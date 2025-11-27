import logging

import discord
import discord.ui
import shortuuid
from discord.ui import Modal

from ReQuest.ui.common.enums import RewardType
from ReQuest.utilities.supportFunctions import (
    log_exception,
    strip_id,
    update_character_inventory,
    update_character_experience, find_currency_or_denomination, get_denomination_map, setup_view, titlecase
)

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class CreateQuestModal(Modal):
    def __init__(self, quest_view_class):
        super().__init__(
            title='Create New Quest',
            timeout=None
        )
        self.quest_view_class = quest_view_class
        self.quest_title_text_input = discord.ui.TextInput(label='Quest Title',
                                                           custom_id='quest_title_text_input',
                                                           placeholder='Title of your quest')
        self.quest_restrictions_text_input = discord.ui.TextInput(label='Restrictions',
                                                                  custom_id='quest_restrictions_text_input',
                                                                  placeholder='Restrictions, if any, such as player '
                                                                              'levels',
                                                                  required=False)
        self.quest_party_size_text_input = discord.ui.TextInput(label='Maximum Party Size',
                                                                custom_id='quest_party_size_text_input',
                                                                placeholder='Max size of the party for this quest',
                                                                max_length=2)
        self.quest_party_role_text_input = discord.ui.TextInput(label='Party Role',
                                                                custom_id='quest_party_role',
                                                                placeholder='Create a role for this quest (Optional)',
                                                                required=False)
        self.quest_description_text_input = discord.ui.TextInput(label='Description',
                                                                 style=discord.TextStyle.paragraph,
                                                                 custom_id='quest_description_text_input',
                                                                 placeholder='Write the details of your quest here')

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
            guild_id = guild.id
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
                config_collection = interaction.client.gdb['forbiddenRoles']
                config_query = await config_collection.find_one({'_id': interaction.guild_id})
                if config_query and config_query['forbiddenRoles']:
                    for name in config_query['forbiddenRoles']:
                        custom_forbidden_names.append(name)

                if (party_role_name.lower() in default_forbidden_names or
                        party_role_name.lower() in custom_forbidden_names):
                    raise Exception('The name provided for the party role is forbidden.')

                for role in guild.roles:
                    if role.name.lower() == party_role_name.lower():
                        raise Exception('The name provided for the party role already exists on this server!')

                party_role = await guild.create_role(
                    name=party_role_name,
                    reason=f'Automated party role creation from ReQuest for quest ID {quest_id}. Requested by '
                           f'game master: {interaction.user.mention}.'
                )
                party_role_id = party_role.id

            # Get the server's wait list configuration
            wait_list_query = await bot.gdb['questWaitList'].find_one({'_id': guild_id})
            if wait_list_query:
                max_wait_list_size = wait_list_query['questWaitList']

            # Query the collection to see if a channel is set
            quest_channel_query = await bot.gdb['questChannel'].find_one({'_id': guild_id})

            # Inform user if quest channel is not set. Otherwise, get the channel string
            if not quest_channel_query:
                raise Exception('A channel has not yet been designated for quest posts. Contact a server admin to '
                                'configure the Quest Channel.')
            else:
                quest_channel_mention = quest_channel_query['questChannel']

            # Query the collection to see if a role is set
            announce_role_query = await bot.gdb['announceRole'].find_one({'_id': guild_id})

            # Grab the announcement role, if configured.
            announce_role = None
            if announce_role_query:
                announce_role = announce_role_query['announceRole']

            quest_collection = bot.gdb['quests']
            # Get the channel object.
            quest_channel = bot.get_channel(strip_id(quest_channel_mention))

            # Log the author, then post the new quest with an emoji reaction.
            author_id = interaction.user.id
            party: [int] = []
            wait_list: [int] = []
            lock_state = False

            # If an announcement role is set, ping it and then delete the message.
            if announce_role != 0:
                ping_msg = await quest_channel.send(f'{announce_role} **NEW QUEST!**')
                await ping_msg.delete()

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

            view = self.quest_view_class(quest)
            await view.setup()
            msg = await quest_channel.send(embed=view.embed, view=view)
            quest['messageId'] = msg.id

            await quest_collection.insert_one(quest)
            await interaction.response.send_message(f'Quest `{quest_id}`: **{title}** posted!',
                                                    ephemeral=True,
                                                    delete_after=10)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestModal(Modal):
    def __init__(self, calling_view, quest, quest_post_view_class):
        super().__init__(
            title=f'Editing {quest['title']}',
            timeout=600
        )

        # Get the current quest's values
        self.calling_view = calling_view
        self.quest = quest
        self.quest_post_view_class = quest_post_view_class
        title = quest['title']
        restrictions = quest['restrictions']
        max_party_size = quest['maxPartySize']
        description = quest['description']

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
            gdb = interaction.client.gdb
            guild_id = interaction.guild_id
            quest_collection = gdb['quests']
            updates = {
                'title': self.title_text_input.value,
                'restrictions': self.restrictions_text_input.value,
                'maxPartySize': int(self.max_party_size_text_input.value),
                'description': self.description_text_input.value
            }
            await quest_collection.update_one({'guildId': interaction.guild_id, 'questId': self.quest['questId']},
                                              {'$set': updates})

            # Get the updated quest
            self.quest.update(updates)

            # Get the quest board channel
            quest_channel_collection = gdb['questChannel']
            quest_channel_query = await quest_channel_collection.find_one({'_id': guild_id})
            quest_channel_id = strip_id(quest_channel_query['questChannel'])
            guild = interaction.client.get_guild(guild_id)
            quest_channel = guild.get_channel(quest_channel_id)

            # Get the original quest post message object and create a new embed
            message = quest_channel.get_partial_message(self.quest['messageId'])

            # Create a fresh quest view, and update the original post message
            quest_view = self.quest_post_view_class(self.quest)
            await quest_view.setup()
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

        if self.reward_type == RewardType.PARTY:
            rewards = calling_view.current_party_rewards
        else:
            rewards = calling_view.current_individual_rewards

        xp_default = ''
        if rewards.get('xp') is not None:
            xp_default = str(rewards['xp'])

        items_default = ''
        if rewards.get('items'):
            lines = [f'{name}: {quantity}' for name, quantity in rewards['items'].items()]
            items_default = '\n'.join(lines)

        self.xp_input = discord.ui.TextInput(
            label='Experience Points',
            style=discord.TextStyle.short,
            custom_id='experience_text_input',
            placeholder='Enter a number',
            default=xp_default,
            required=False
        )
        self.item_input = discord.ui.TextInput(
            label='Items',
            style=discord.TextStyle.paragraph,
            custom_id='items_text_input',
            placeholder='{item}: {quantity}\n'
                        '{item2}: {quantity}\n'
                        'etc.',
            default=items_default,
            required=False
        )
        self.add_item(self.xp_input)
        self.add_item(self.item_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            xp = None
            items = None
            if self.xp_input.value:
                xp = int(self.xp_input.value)
            if self.item_input.value:
                if self.item_input.value.lower() == 'none':
                    items = 'none'
                else:
                    items = {}
                    for item in self.item_input.value.strip().split('\n'):
                        item_name, quantity = item.split(':', 1)
                        items[titlecase(item_name.strip())] = int(quantity.strip())

            await self.caller.modal_callback(interaction, xp, items)
        except Exception as e:
            await log_exception(e, interaction)

    @staticmethod
    def parse_items_to_string(items) -> str:
        item_list = []
        for item_name, quantity in items.items():
            item_list.append(f'{titlecase(item_name)}: {quantity}')
        item_string = '\n'.join(item_list)
        return item_string


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
    def __init__(self, member: discord.Member, character_id, character_data):
        super().__init__(
            title=f'Modifying {member.name}',
            timeout=600
        )
        self.member = member
        self.character_id = character_id
        self.character_data = character_data
        self.experience_text_input = discord.ui.TextInput(
            label='Experience Points',
            placeholder='Enter a positive or negative number.',
            custom_id='experience_text_input',
            required=False
        )
        self.inventory_text_input = discord.ui.TextInput(
            label='Inventory',
            style=discord.TextStyle.paragraph,
            placeholder='{item}: {quantity}\n'
                        '{item2}: {quantity}\n'
                        'etc.',
            custom_id='inventory_text_input',
            required=False
        )
        self.add_item(self.experience_text_input)
        self.add_item(self.inventory_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            xp = None
            gdb = interaction.client.gdb
            guild_id = interaction.guild_id
            currency_config = await gdb['currency'].find_one({'_id': guild_id})
            log_channel_config = await gdb['gmTransactionLogChannel'].find_one({'_id': guild_id})
            log_channel = None
            if log_channel_config:
                log_channel_id = strip_id(log_channel_config['gmTransactionLogChannel'])
                log_channel = interaction.client.get_channel(log_channel_id)

            item_changes = {}
            currency_changes = {}

            if self.experience_text_input.value:
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
                    f'Recipient: {self.member.mention} as `{self.character_data['name']}`'
                ),
                type='rich'
            )

            if xp:
                await update_character_experience(interaction, self.member.id, self.character_id, xp)
                mod_summary_embed.add_field(name='Experience', value=xp)

            for base_currency_name, total_value in currency_changes.items():
                if total_value == 0:
                    continue
                await update_character_inventory(interaction, self.member.id, self.character_id,
                                                 base_currency_name, total_value)

                display_value = f"{total_value:.2f}" if isinstance(total_value,
                                                                   float) and total_value % 1 != 0 else str(total_value)
                mod_summary_embed.add_field(name=titlecase(base_currency_name), value=display_value)

            for item_name, quantity in item_changes.items():
                if quantity == 0:
                    continue
                await update_character_inventory(interaction, self.member.id, self.character_id,
                                                 item_name.lower(), int(quantity))
                mod_summary_embed.add_field(name=titlecase(item_name), value=int(quantity))

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
