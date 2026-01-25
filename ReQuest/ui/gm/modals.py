import logging
from titlecase import titlecase

import discord
import discord.ui
import shortuuid
from discord.ui import Modal

from ReQuest.ui.common.enums import RewardType
from ReQuest.utilities.constants import QuestFields, ConfigFields, CommonFields
from ReQuest.utilities.supportFunctions import (
    log_exception,
    strip_id,
    update_character_inventory,
    update_character_experience,
    find_currency_or_denomination,
    get_denomination_map,
    setup_view,
    UserFeedbackError,
    update_cached_data,
    get_cached_data,
    build_cache_key,
    escape_markdown
)

logger = logging.getLogger(__name__)


class CreateQuestModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Create New Quest',
            timeout=None
        )
        self.calling_view = calling_view
        self.quest_title_text_input = discord.ui.TextInput(
            label='Quest Title',
            custom_id='quest_title_text_input',
            placeholder='Title of your quest'
        )
        self.quest_restrictions_text_input = discord.ui.TextInput(
            label='Restrictions',
            custom_id='quest_restrictions_text_input',
            placeholder='Restrictions, if any, such as player levels',
            required=False
        )
        self.quest_party_size_text_input = discord.ui.TextInput(
            label='Maximum Party Size',
            custom_id='quest_party_size_text_input',
            placeholder='Max size of the party for this quest',
            max_length=2
        )
        self.quest_party_role_text_input = discord.ui.TextInput(
            label='Party Role',
            custom_id='quest_party_role',
            placeholder='Create a role for this quest (Optional)',
            required=False
        )
        self.quest_description_text_input = discord.ui.TextInput(
            label='Description',
            style=discord.TextStyle.paragraph,
            custom_id='quest_description_text_input',
            placeholder='Write the details of your quest here'
        )

        self.add_item(self.quest_title_text_input)
        self.add_item(self.quest_restrictions_text_input)
        self.add_item(self.quest_party_size_text_input)
        self.add_item(self.quest_party_role_text_input)
        self.add_item(self.quest_description_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            title = self.quest_title_text_input.value
            restrictions = self.quest_restrictions_text_input.value
            max_party_size = int(self.quest_party_size_text_input.value)
            party_role_name = self.quest_party_role_text_input.value
            description = self.quest_description_text_input.value

            guild = interaction.guild
            guild_id = interaction.guild_id
            quest_id = str(shortuuid.uuid()[:8])
            bot = interaction.client
            max_wait_list_size = 0

            # Validate the party role name, if provided
            party_role_id = None
            if party_role_name:
                default_forbidden_names = [
                    'everyone',
                    'administrator',
                    'game master',
                    'gm',
                ]
                custom_forbidden_names = []
                config_query = await get_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name='forbiddenRoles',
                    query={'_id': guild_id}
                )
                if config_query and config_query[ConfigFields.FORBIDDEN_ROLES]:
                    for name in config_query[ConfigFields.FORBIDDEN_ROLES]:
                        custom_forbidden_names.append(name)

                if (party_role_name.lower() in default_forbidden_names or
                        party_role_name.lower() in custom_forbidden_names):
                    raise UserFeedbackError('The name provided for the party role is forbidden.')

                for role in guild.roles:
                    if role.name.lower() == party_role_name.lower():
                        raise UserFeedbackError('A role with that name already exists in this server.')

                party_role = await guild.create_role(
                    name=party_role_name,
                    reason=f'Automated party role creation from ReQuest for quest ID {quest_id}. Requested by '
                           f'game master: {interaction.user.mention}.'
                )
                party_role_id = party_role.id

            # Get the server's wait list configuration
            wait_list_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='questWaitList',
                query={'_id': guild_id}
            )
            if wait_list_query:
                max_wait_list_size = wait_list_query[ConfigFields.QUEST_WAIT_LIST]

            # Query the collection to see if a channel is set
            quest_channel_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='questChannel',
                query={'_id': guild_id}
            )

            # Inform user if quest channel is not set. Otherwise, get the channel string
            if not quest_channel_query:
                raise UserFeedbackError(
                    'A channel has not yet been designated for quest posts. Contact a server admin to configure the '
                    'Quest Channel.'
                )
            else:
                quest_channel_mention = quest_channel_query[ConfigFields.QUEST_CHANNEL]

            # Query the collection to see if a role is set
            announce_role_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='announceRole',
                query={'_id': guild_id}
            )

            # Grab the announcement role, if configured.
            announce_role = None
            if announce_role_query:
                announce_role = announce_role_query[ConfigFields.ANNOUNCE_ROLE]

            # Get the channel object.
            quest_channel = bot.get_channel(strip_id(quest_channel_mention))

            # Log the author, then post the new quest with an emoji reaction.
            author_id = interaction.user.id
            party = []
            wait_list = []
            lock_state = False

            # If an announcement role is set, ping it and then delete the message.
            if announce_role != 0:
                try:
                    ping_msg = await quest_channel.send(f'{announce_role} **NEW QUEST!**')
                    await ping_msg.delete()
                except discord.errors.Forbidden:
                    raise UserFeedbackError(
                        f'Could not ping announce role {announce_role} in channel {quest_channel.mention}. Check '
                        f'channel and ReQuest role permissions with your server admin(s).')

            quest = {
                'guildId': guild_id,
                'questId': quest_id,
                'messageId': 0,
                'title': title,
                'description': description,
                'maxPartySize': max_party_size,
                'restrictions': restrictions,
                'gm': author_id,
                'party': party,
                'partyRoleId': party_role_id,
                'waitList': wait_list,
                'maxWaitListSize': max_wait_list_size,
                'lockState': lock_state,
                'rewards': {}
            }

            from ReQuest.ui.gm.views import QuestPostView
            view = QuestPostView(quest)
            await view.setup()
            msg = await quest_channel.send(embed=view.embed, view=view)
            quest[QuestFields.MESSAGE_ID] = msg.id

            quest_collection = bot.gdb['quests']
            await quest_collection.insert_one(quest)

            # Clear the cached guild quests for the GM
            admin_key = build_cache_key(bot.gdb.name, f'guild_quests:{guild_id}', 'quests')
            await bot.rdb.delete(admin_key)

            gm_key = build_cache_key(bot.gdb.name, f'gm_quests:{guild_id}:{author_id}', 'quests')
            await bot.rdb.delete(gm_key)

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestModal(Modal):
    def __init__(self, calling_view, quest):
        header = f'Editing {quest[QuestFields.TITLE]}'
        if len(header) > 45:
            header = header[:42] + '...'
        super().__init__(
            title=header,
            timeout=600
        )

        # Get the current quest's values
        self.calling_view = calling_view
        self.quest = quest
        title = quest[QuestFields.TITLE]
        restrictions = quest[QuestFields.RESTRICTIONS]
        max_party_size = quest[QuestFields.MAX_PARTY_SIZE]
        description = quest[QuestFields.DESCRIPTION]

        # Build the text inputs w/ the existing values
        self.title_text_input = discord.ui.TextInput(
            label='Title',
            style=discord.TextStyle.short,
            default=title,
            custom_id='title_text_input',
            required=False
        )
        self.restrictions_text_input = discord.ui.TextInput(
            label='Restrictions',
            style=discord.TextStyle.short,
            default=restrictions,
            custom_id='restrictions_text_input',
            required=False
        )
        self.max_party_size_text_input = discord.ui.TextInput(
            label='Max Party Size',
            style=discord.TextStyle.short,
            default=max_party_size,
            custom_id='max_party_size_text_input',
            required=False
        )
        self.description_text_input = discord.ui.TextInput(
            label='Description',
            style=discord.TextStyle.paragraph,
            default=description,
            custom_id='description_text_input',
            required=False
        )
        self.add_item(self.title_text_input)
        self.add_item(self.restrictions_text_input)
        self.add_item(self.max_party_size_text_input)
        self.add_item(self.description_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            # Push the updates
            bot = interaction.client
            guild_id = interaction.guild_id
            updates = {
                'title': self.title_text_input.value,
                'restrictions': self.restrictions_text_input.value,
                'maxPartySize': int(self.max_party_size_text_input.value),
                'description': self.description_text_input.value
            }

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='quests',
                query={QuestFields.GUILD_ID: guild_id, QuestFields.QUEST_ID: self.quest[QuestFields.QUEST_ID]},
                update_data={'$set': updates},
                cache_id=f'{guild_id}:{self.quest[QuestFields.QUEST_ID]}'
            )

            # Get the updated quest
            self.quest.update(updates)

            # Get the quest board channel
            quest_channel_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='questChannel',
                query={'_id': guild_id}
            )
            quest_channel_id = strip_id(quest_channel_query[ConfigFields.QUEST_CHANNEL])
            guild = interaction.client.get_guild(guild_id)
            quest_channel = guild.get_channel(quest_channel_id)

            # Get the original quest post message object and create a new embed
            message = quest_channel.get_partial_message(self.quest[QuestFields.MESSAGE_ID])

            # Create a fresh quest view, and update the original post message
            from ReQuest.ui.gm.views import QuestPostView
            quest_view = QuestPostView(self.quest)
            await setup_view(quest_view, interaction)
            await message.edit(embed=quest_view.embed, view=quest_view)

            # Reload the UI view
            view = self.calling_view
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class RewardsModal(Modal):
    def __init__(self, caller, calling_view, reward_type: RewardType):
        super().__init__(
            title='Add Reward',
            timeout=600
        )
        self.caller = caller
        self.calling_view = calling_view
        self.reward_type = reward_type
        self.xp_enabled = getattr(calling_view, 'xp_enabled', True)

        if self.reward_type == RewardType.PARTY:
            rewards = calling_view.current_party_rewards
        else:
            rewards = calling_view.current_individual_rewards

        if self.xp_enabled:
            xp_value = rewards.get('xp')
            xp_default = str(xp_value) if xp_value is not None else '0'
            self.xp_input = discord.ui.TextInput(
                label='Experience Points',
                style=discord.TextStyle.short,
                custom_id='experience_text_input',
                placeholder='Enter a number',
                default=xp_default,
                required=False
            )
            self.add_item(self.xp_input)

        items_default = ''
        if rewards.get('items'):
            lines = [f'{name}: {quantity}' for name, quantity in rewards['items'].items()]
            items_default = '\n'.join(lines)

        self.item_input = discord.ui.TextInput(
            label='Items',
            style=discord.TextStyle.paragraph,
            custom_id='items_text_input',
            placeholder='item: quantity\n'
                        'item2: quantity\n'
                        'etc.',
            default=items_default,
            required=False
        )
        self.add_item(self.item_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            xp = 0
            items = None
            if self.xp_enabled and hasattr(self, 'xp_input') and self.xp_input.value:
                xp = int(self.xp_input.value)
            if self.item_input.value:
                if self.item_input.value.lower() == 'none':
                    items = 'none'
                else:
                    items = {}
                    for item in self.item_input.value.strip().split('\n'):
                        try:
                            item_name, quantity = item.split(':', 1)
                            items[titlecase(item_name.strip())] = int(quantity.strip())
                        except ValueError:
                            raise UserFeedbackError(
                                f'Invalid item format: "{item}". Each item must be on a new line, and in the format '
                                f'"Name: Quantity".'
                            )

            await self.caller.modal_callback(interaction, xp, items)
        except Exception as e:
            await log_exception(e, interaction)


class QuestSummaryModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Add Quest Summary',
            timeout=None
        )
        self.calling_view = calling_view
        self.summary_input = discord.ui.TextInput(
            label='Summary',
            style=discord.TextStyle.paragraph,
            custom_id='summary_input',
            placeholder='Add a story summary of the quest'
        )
        self.add_item(self.summary_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            await self.calling_view.complete_quest(interaction, self.summary_input.value)
        except Exception as e:
            await log_exception(e, interaction)


class ModPlayerModal(Modal):
    def __init__(self, member: discord.Member, character_id, character_data, xp_enabled=True):
        super().__init__(
            title=f'Modifying {member.name}',
            timeout=600
        )
        self.member = member
        self.character_id = character_id
        self.character_data = character_data
        self.xp_enabled = xp_enabled

        if self.xp_enabled:
            self.experience_text_input = discord.ui.TextInput(
                label='Experience Points',
                placeholder='Enter a positive or negative number.',
                custom_id='experience_text_input',
                required=False
            )
            self.add_item(self.experience_text_input)

        self.inventory_text_input = discord.ui.TextInput(
            label='Inventory',
            style=discord.TextStyle.paragraph,
            placeholder='item: quantity\n'
                        'item2: quantity\n'
                        'etc.',
            custom_id='inventory_text_input',
            required=False
        )
        self.add_item(self.inventory_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            xp = 0
            guild_id = interaction.guild_id
            currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='currency',
                query={'_id': guild_id}
            )
            log_channel_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='gmTransactionLogChannel',
                query={'_id': guild_id}
            )
            log_channel = None
            if log_channel_config:
                log_channel_id = strip_id(log_channel_config[ConfigFields.GM_TRANSACTION_LOG_CHANNEL])
                log_channel = interaction.client.get_channel(log_channel_id)

            item_changes = {}
            currency_changes = {}

            if self.xp_enabled and hasattr(self, 'experience_text_input') and self.experience_text_input.value:
                xp = int(self.experience_text_input.value)

            if self.inventory_text_input.value:
                for item_line in self.inventory_text_input.value.strip().split('\n'):
                    try:
                        item_name_str, quantity_str = item_line.split(':', 1)
                        item_name = item_name_str.strip()
                        quantity = float(quantity_str.strip())
                    except ValueError:
                        continue

                    is_currency, parent_name = None, None
                    if currency_config:
                        is_currency, parent_name = find_currency_or_denomination(currency_config, item_name)

                    if is_currency:
                        denomination_map, _ = get_denomination_map(currency_config, item_name)
                        if not denomination_map:
                            item_changes[item_name.lower()] = (item_changes.get(item_name.lower(), 0) +
                                                               int(quantity))
                            continue

                        item_value_in_base = denomination_map[item_name.lower()]
                        total_value_to_add = quantity * item_value_in_base

                        currency_changes[parent_name] = currency_changes.get(parent_name, 0.0) + total_value_to_add

                    else:
                        item_changes[item_name.lower()] = (item_changes.get(item_name.lower(), 0) +
                                                           int(quantity))

            mod_summary_embed = discord.Embed(
                title=f'GM Player Modification Report',
                description=(
                    f'Game Master: {interaction.user.mention}\n'
                    f'Recipient: {self.member.mention} as `{self.character_data[CommonFields.NAME]}`'
                ),
                type='rich'
            )

            if self.xp_enabled and xp:
                await update_character_experience(interaction, self.member.id, self.character_id, xp)
                mod_summary_embed.add_field(name='Experience', value=xp)

            for base_currency_name, total_value in currency_changes.items():
                if total_value == 0:
                    continue
                await update_character_inventory(interaction, self.member.id, self.character_id,
                                                 base_currency_name, total_value)

                display_value = f"{total_value:.2f}" if isinstance(total_value,
                                                                   float) and total_value % 1 != 0 else str(total_value)
                mod_summary_embed.add_field(name=escape_markdown(titlecase(base_currency_name)), value=display_value)

            for item_name, quantity in item_changes.items():
                if quantity == 0:
                    continue
                await update_character_inventory(interaction, self.member.id, self.character_id,
                                                 item_name.lower(), int(quantity))
                mod_summary_embed.add_field(name=escape_markdown(titlecase(item_name)), value=int(quantity))

            transaction_id = shortuuid.uuid()[:12]
            mod_summary_embed.set_footer(text=f'Transaction ID: {transaction_id}')

            if log_channel:
                await log_channel.send(embed=mod_summary_embed)

            await interaction.response.send_message(embed=mod_summary_embed, ephemeral=True)
            try:
                await self.member.send(embed=mod_summary_embed)
            except discord.errors.Forbidden as e:
                logger.warning(f'Could not send DM to {self.member} regarding GM modification: {e}')
        except Exception as e:
            await log_exception(e, interaction)


class ReviewSubmissionInputModal(Modal):
    def __init__(self, calling_view):
        super().__init__(title="Review Submission", timeout=180)
        self.calling_view = calling_view
        self.submission_id_text_input = discord.ui.TextInput(
            label="Submission ID",
            placeholder="Enter the 8-char ID",
            min_length=8,
            max_length=8
        )
        self.add_item(self.submission_id_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            submission_id = self.submission_id_text_input.value

            data = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='approvals',
                query={'submission_id': submission_id},
                cache_id=f'approval_submission:{submission_id}'
            )

            if not data:
                await interaction.response.send_message("Submission not found.", ephemeral=True)
                return

            currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='currency',
                query={'_id': interaction.guild_id}
            )

            from ReQuest.ui.gm.views import ReviewSubmissionView
            view = ReviewSubmissionView(data, currency_config)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)
