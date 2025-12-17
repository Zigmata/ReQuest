import datetime
import logging
from datetime import timezone

import discord
from discord.ext import commands
from discord.ext.commands import Cog
from pymongo import ReturnDocument

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

    @staticmethod
    def _get_cycle_key(config, now: datetime.datetime):
        """
        Calculates the current cycle key for Scheduled mode based on the reset time.
        """
        reset_time_str = config.get('resetTime', '00:00')
        try:
            h, m = map(int, reset_time_str.split(':'))
        except ValueError:
            h, m = 0, 0

        reset_time_today = now.replace(hour=h, minute=m, second=0, microsecond=0)

        if now < reset_time_today:
            target_date = now - datetime.timedelta(days=1)
        else:
            target_date = now

        frequency = config.get('frequency', 'daily')

        if frequency == 'hourly':
            return now.strftime('%Y-%m-%d-%H')
        elif frequency == 'weekly':
            reset_day_str = config.get('resetDay', 'monday').lower()
            days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']
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
                query={'_id': guild_id},
                cache_id=guild_id
            )

            if not rp_config or not rp_config.get('enabled'):
                return

            allowed_channels = rp_config.get('channels', [])
            if str(message.channel.id) not in allowed_channels:
                return

            min_length = rp_config.get('minLength', 0)
            if len(message.content) < min_length:
                return

            character_data = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': user_id}
            )

            if not character_data or str(guild_id) not in character_data.get('activeCharacters', {}):
                return

            active_char_id = character_data['activeCharacters'][str(guild_id)]

            mode = rp_config.get('mode', 'scheduled')
            config_data = rp_config.get('config', {})

            cooldown_time = 60
            if mode == 'accrued':
                cooldown_time = int(config_data.get('cooldown', 20))

            redis_key = f"rp:{guild_id}:{user_id}:cooldown"
            if await bot.rdb.exists(redis_key):
                return

            await bot.rdb.set(redis_key, "1", ex=cooldown_time)

            collection = bot.gdb['roleplayData']
            db_key = f"{guild_id}:{user_id}"

            trigger_reward = False
            reset_count = False

            if mode == 'scheduled':
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

                threshold = int(config_data.get('threshold', 20))
                if current_count >= threshold and not claimed:
                    trigger_reward = True

                    await collection.update_one(
                        {'_id': db_key},
                        {'$set': {'claimed': True}}
                    )

            else:
                frequency = int(config_data.get('frequency', 5))

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

                rewards = rp_config.get('rewards', {})
                xp_amount = rewards.get('xp')
                items = rewards.get('items', {})
                currency = rewards.get('currency', {})

                xp_enabled = await get_xp_config(bot, guild_id)
                if xp_enabled and xp_amount:

                    char_data_fresh = await bot.mdb['characters'].find_one({'_id': user_id})
                    active_char = char_data_fresh['characters'][active_char_id]

                    if active_char['attributes'].get('experience') is None:
                        active_char['attributes']['experience'] = 0

                    active_char['attributes']['experience'] += xp_amount

                    pass

                class MockInteraction:
                    def __init__(self, client, user, guild, channel):
                        self.client = client
                        self.user = user
                        self.guild = guild
                        self.channel = channel
                        self.response = None

                mock_interaction = MockInteraction(bot, message.author, message.guild, message.channel)

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
