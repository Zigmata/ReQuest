import datetime
import logging
from datetime import timezone

import discord
from discord.ext import commands
from discord.ext.commands import Cog
from pymongo import ReturnDocument

from ReQuest.ui.common.enums import ScheduleType, RoleplayMode, DayOfWeek
from ReQuest.utilities.constants import CharacterFields, RoleplayFields, CommonFields
from ReQuest.utilities.supportFunctions import (
    log_exception,
    get_cached_data,
    update_character_inventory,
    update_character_experience,
    get_xp_config
)

logger = logging.getLogger(__name__)


class Roleplay(Cog):
    def __init__(self, bot: commands.Bot):
        super().__init__()
        self.bot = bot

    class MockInteraction:
        def __init__(self, client, user, guild, channel):
            self.client = client
            self.user = user
            self.guild = guild
            self.channel = channel
            self.guild_id = guild.id
            self.response = None

    @staticmethod
    def _get_cycle_key(config, now: datetime.datetime):
        """
        Calculates the current cycle key for Scheduled mode based on the reset time.
        """
        reset_time = config.get(RoleplayFields.RESET_TIME, 0)

        reset_time_today = now.replace(hour=reset_time, minute=0, second=0, microsecond=0)

        if now < reset_time_today:
            target_date = now - datetime.timedelta(days=1)
        else:
            target_date = now

        reset_period = config.get(RoleplayFields.RESET_PERIOD, ScheduleType.HOURLY.value)

        if reset_period == ScheduleType.HOURLY.value:
            return now.strftime('%Y-%m-%d-%H')
        elif reset_period == ScheduleType.WEEKLY.value:
            reset_day_str = config.get(RoleplayFields.RESET_DAY, DayOfWeek.MONDAY.value).lower()
            days = [d.value for d in DayOfWeek]
            target_weekday = days.index(reset_day_str) if reset_day_str in days else 0

            current_weekday = target_date.weekday()

            diff = (current_weekday - target_weekday) % 7
            cycle_start = target_date - datetime.timedelta(days=diff)
            return f"weekly-{cycle_start.strftime('%Y-%m-%d')}"
        else:
            return target_date.strftime('%Y-%m-%d')

    @commands.Cog.listener()
    async def on_message(self, message: discord.Message):
        if message.author.bot or not message.guild:
            return

        try:
            bot = self.bot
            guild_id = message.guild.id
            user_id = message.author.id

            rp_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='roleplayConfig',
                query={'_id': guild_id}
            )
            if not rp_config:
                logger.debug(f'No roleplay configuration found for guild {guild_id}.')
                return
            rp_settings = rp_config.get(RoleplayFields.CONFIG, {})

            if not rp_config or not rp_config.get('enabled'):
                logger.debug(f'Roleplay not enabled in guild {guild_id}.')
                return

            allowed_channels = rp_config.get(RoleplayFields.CHANNELS, [])

            # Check if message is in an allowed channel
            # For threads, check if the parent channel is allowed
            channel_to_check = message.channel
            if isinstance(message.channel, discord.Thread):
                channel_to_check = message.channel.parent

            if not channel_to_check or str(channel_to_check.id) not in allowed_channels:
                logger.debug(f'Message in channel {message.channel.id} not in allowed RP channels.')
                return

            min_length = rp_settings.get(RoleplayFields.MIN_LENGTH, 0)
            if len(message.content) < min_length:
                logger.debug(f'Message length {len(message.content)} is below minimum {min_length}.')
                return

            character_data = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': user_id}
            )

            if not character_data or str(guild_id) not in character_data.get(CharacterFields.ACTIVE_CHARACTERS, {}):
                logger.debug(f'User {user_id} has no active character in guild {guild_id}.')
                return

            active_char_id = character_data[CharacterFields.ACTIVE_CHARACTERS][str(guild_id)]

            mode = rp_config.get(RoleplayFields.MODE, RoleplayMode.SCHEDULED.value)
            config_data = rp_config.get(RoleplayFields.CONFIG, {})

            cooldown_time = int(config_data.get(RoleplayFields.COOLDOWN, 20))

            cooldown_state_key = f"rp:{guild_id}:{user_id}:cooldown"
            if await bot.rdb.exists(cooldown_state_key):
                logger.debug(f'User {user_id} is on cooldown in guild {guild_id}.')
                return

            if cooldown_time > 0:
                await bot.rdb.set(cooldown_state_key, "1", ex=cooldown_time)

            collection = bot.gdb['roleplayData']
            db_key = f"{guild_id}:{user_id}"

            trigger_reward = False
            reset_count = False

            if mode == RoleplayMode.SCHEDULED.value:
                now = datetime.datetime.now(timezone.utc)
                current_cycle = self._get_cycle_key(config_data, now)

                result = await collection.find_one_and_update(
                    {'_id': db_key, 'last_reset': {'$ne': current_cycle}},
                    {
                        '$set': {
                            'message_count': 1,
                            'last_reset': current_cycle,
                            'claimed': False
                        }
                    },
                    upsert=False,
                    return_document=ReturnDocument.AFTER
                )

                if result:
                    current_count = 1
                    claimed = False
                else:
                    result = await collection.find_one_and_update(
                        {'_id': db_key},
                        {
                            '$inc': {'message_count': 1},
                            '$setOnInsert': {'last_reset': current_cycle, 'claimed': False}
                        },
                        upsert=True,
                        return_document=ReturnDocument.AFTER
                    )
                    current_count = result.get('message_count', 1)
                    claimed = result.get('claimed', False)

                threshold = int(config_data.get(RoleplayFields.THRESHOLD, 20))
                if current_count >= threshold and not claimed:
                    trigger_reward = True

                    await collection.update_one(
                        {'_id': db_key},
                        {'$set': {'claimed': True}}
                    )

            else:
                frequency = int(config_data.get(RoleplayFields.FREQUENCY, 5))

                result = await collection.find_one_and_update(
                    {'_id': db_key},
                    {'$inc': {'message_count': 1}},
                    upsert=True,
                    return_document=ReturnDocument.AFTER
                )
                current_count = result.get('message_count', 1)

                if current_count >= frequency:
                    trigger_reward = True
                    reset_count = True

            if trigger_reward:
                if reset_count:
                    await collection.update_one(
                        {'_id': db_key},
                        {'$set': {'message_count': 0}}
                    )

                rewards = rp_config.get(RoleplayFields.REWARDS, {})
                xp_amount = rewards.get(RoleplayFields.XP)
                items = rewards.get(CharacterFields.ITEMS, {})
                currency = rewards.get(CharacterFields.CURRENCY, {})

                xp_enabled = await get_xp_config(bot, guild_id)

                mock_interaction = self.MockInteraction(bot, message.author, message.guild, message.channel)

                if xp_enabled and xp_amount:
                    await update_character_experience(mock_interaction, user_id, active_char_id, xp_amount)

                for item_name, qty in items.items():
                    await update_character_inventory(mock_interaction, user_id, active_char_id, item_name, qty)

                for curr_name, amount in currency.items():
                    await update_character_inventory(mock_interaction, user_id, active_char_id, curr_name, amount)

        except Exception as e:
            await log_exception(e)


async def setup(bot):
    await bot.add_cog(Roleplay(bot))
