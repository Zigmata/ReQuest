import logging
import math

import discord
from discord import ButtonStyle
from discord.ui import View, LayoutView, Container, Section, Separator, ActionRow, Button, TextDisplay, Thumbnail

from ReQuest.ui.common.buttons import MenuViewButton, MenuDoneButton, BackButton
from ReQuest.ui.common import modals as common_modals, views as common_views
from ReQuest.ui.config import buttons, selects, enums
from ReQuest.utilities.supportFunctions import log_exception, query_config

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class ConfigBaseView(common_views.MenuBaseView):
    def __init__(self):
        super().__init__(
            title='Server Configuration - Main Menu',
            menu_items=[
                {
                    'name': 'Roles',
                    'description': 'Configuration options for pingable or privileged roles.',
                    'view_class': ConfigRolesView
                },
                {
                    'name': 'Channels',
                    'description': 'Set designated channels for ReQuest posts.',
                    'view_class': ConfigChannelsView
                },
                {
                    'name': 'Quests',
                    'description': 'Global quest settings, such as wait lists.',
                    'view_class': ConfigQuestsView
                },
                {
                    'name': 'Players',
                    'description': 'Global player settings, such as experience point tracking.',
                    'view_class': ConfigPlayersView
                },
                {
                    'name': 'Currency',
                    'description': 'Global currency settings.',
                    'view_class': ConfigCurrencyView
                },
                {
                    'name': 'Shops',
                    'description': 'Configure custom shops.',
                    'view_class': ConfigShopsView
                }
            ],
            menu_level=0
        )


# ------ ROLES ------


class ConfigRolesView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)

        self.announcement_role_status = TextDisplay(
            '**Announcement Role:** Not Configured\n'
            'This role is mentioned when a quest is posted.'
        )
        self.gm_roles_status = TextDisplay(
            '**GM Role(s):** Not Configured\n'
            'These roles will grant access to Game Master commands and features.'
        )

        self.quest_announce_role_select = selects.QuestAnnounceRoleSelect(self)
        self.quest_announce_role_remove_button = buttons.QuestAnnounceRoleRemoveButton(self)
        self.add_gm_role_select = selects.AddGMRoleSelect(self)
        self.gm_role_remove_view_button = buttons.GMRoleRemoveViewButton(ConfigGMRoleRemoveView)
        self.forbidden_roles_button = buttons.ForbiddenRolesButton(self)

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay('**Server Configuration - Roles**'))

        container.add_item(header_section)
        container.add_item(Separator())

        announcement_role_section = Section(accessory=self.quest_announce_role_remove_button)
        announcement_role_section.add_item(self.announcement_role_status)
        container.add_item(announcement_role_section)
        announce_role_select_row = ActionRow(self.quest_announce_role_select)
        container.add_item(announce_role_select_row)
        container.add_item(Separator())

        gm_role_section = Section(accessory=self.gm_role_remove_view_button)
        gm_role_section.add_item(self.gm_roles_status)
        container.add_item(gm_role_section)
        gm_role_select_row = ActionRow(self.add_gm_role_select)
        container.add_item(gm_role_select_row)
        container.add_item(Separator())

        container.add_item(TextDisplay(
            '__**Forbidden Roles**__\n'
            'Configures a list of role names that cannot be used by Game Masters for their party roles. '
            'By default, `everyone`, `administrator`, `gm`, and `game master` cannot be used. This configuration '
            'extends that list.\n'
        ))
        role_row_5 = ActionRow(self.forbidden_roles_button)
        container.add_item(role_row_5)

        self.add_item(container)

    @staticmethod
    async def query_role(role_type, bot, guild):
        try:
            collection = bot.gdb[role_type]

            query = await collection.find_one({'_id': guild.id})
            if not query:
                return None
            else:
                return query[role_type]
        except Exception as e:
            await log_exception(e)

    async def setup(self, bot, guild):
        try:
            announcement_role = await self.query_role('announceRole', bot, guild)
            gm_roles = await self.query_role('gmRoles', bot, guild)

            if not announcement_role:
                announcement_role_string = (
                    '**Announcement Role:** Not Configured\n'
                    'This role is mentioned when a quest is posted.'
                )
                self.quest_announce_role_remove_button.disabled = True
            else:
                announcement_role_string = (
                    f'**Announcement Role:** {announcement_role}\n'
                    'This role is mentioned when a quest is posted.'
                )
                self.quest_announce_role_remove_button.disabled = False

            if not gm_roles:
                gm_roles_string = ('**GM Role(s):** Not Configured\n'
                                   'These roles will grant access to Game Master commands and features.')
                self.gm_role_remove_view_button.disabled = True
            else:
                role_mentions = []
                for role in gm_roles:
                    role_mentions.append(role['mention'])

                gm_roles_string = (f'**GM Role(s):** {','.join(role_mentions)}\n'
                                   f'These roles will grant access to Game Master commands and features.')
                self.gm_role_remove_view_button.disabled = False

            self.announcement_role_status.content = announcement_role_string
            self.gm_roles_status.content = gm_roles_string

        except Exception as e:
            await log_exception(e)


class ConfigGMRoleRemoveView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.gm_role_remove_select = selects.GMRoleRemoveSelect(self)

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(ConfigRolesView))
        header_section.add_item(TextDisplay('**Server Configuration - Remove GM Role(s)**'))

        container.add_item(header_section)
        container.add_item(Separator())

        container.add_item(TextDisplay('Choose roles from the dropdown below to remove from GM status.'))
        gm_role_remove_select_row = ActionRow(self.gm_role_remove_select)
        container.add_item(gm_role_remove_select_row)

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            # Clear any embed fields or select options
            self.gm_role_remove_select.options.clear()

            # Query the db for configured GM roles
            collection = bot.gdb['gmRoles']
            query = await collection.find_one({'_id': guild.id})
            options = []
            role_mentions = []

            # If roles are configured, populate the select options and build a string to display in the embed
            if query and query['gmRoles']:
                roles = query['gmRoles']
                for role in roles:
                    name = role['name']
                    role_mentions.append(role['mention'])
                    options.append(discord.SelectOption(label=name, value=name))
                self.gm_role_remove_select.disabled = False
            else:
                options.append(discord.SelectOption(label='None', value='None'))
                self.gm_role_remove_select.disabled = True
            self.gm_role_remove_select.options = options
        except Exception as e:
            await log_exception(e)


# ------ CHANNELS ------

class ConfigChannelsView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.quest_board_info = TextDisplay(
            '**Quest Board:** Not Configured\n'
            'The channel where new/active quests will be posted.'
        )
        self.player_board_info = TextDisplay(
            '**Player Board:** Not Configured\n'
            'An optional announcement/message board for use by players.'
        )
        self.quest_archive_info = TextDisplay(
            '**Quest Archive:** Not Configured\n'
            'An optional channel where completed quests will move to, with summary information.'
        )
        self.quest_channel_select = selects.SingleChannelConfigSelect(
            calling_view=self,
            config_type='questChannel',
            config_name='Quest Board'
        )
        self.player_board_channel_select = selects.SingleChannelConfigSelect(
            calling_view=self,
            config_type='playerBoardChannel',
            config_name='Player Board'
        )
        self.archive_channel_select = selects.SingleChannelConfigSelect(
            calling_view=self,
            config_type='archiveChannel',
            config_name='Quest Archive'
        )

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay('**Server Configuration - Channels**'))

        container.add_item(header_section)
        container.add_item(Separator())

        quest_board_section = Section(accessory=buttons.ClearChannelButton(self, enums.ChannelType.QUEST_BOARD))
        quest_board_section.add_item(self.quest_board_info)
        container.add_item(quest_board_section)
        quest_board_select_row = ActionRow(self.quest_channel_select)
        container.add_item(quest_board_select_row)
        container.add_item(Separator())

        player_board_section = Section(accessory=buttons.ClearChannelButton(self, enums.ChannelType.PLAYER_BOARD))
        player_board_section.add_item(self.player_board_info)
        container.add_item(player_board_section)
        player_board_select_row = ActionRow(self.player_board_channel_select)
        container.add_item(player_board_select_row)
        container.add_item(Separator())

        quest_archive_section = Section(accessory=buttons.ClearChannelButton(self, enums.ChannelType.QUEST_ARCHIVE))
        quest_archive_section.add_item(self.quest_archive_info)
        container.add_item(quest_archive_section)
        quest_archive_select_row = ActionRow(self.archive_channel_select)
        container.add_item(quest_archive_select_row)
        container.add_item(Separator())

        self.add_item(container)

    @staticmethod
    async def query_channel(channel_type, database, guild_id):
        try:
            collection = database[channel_type]

            query = await collection.find_one({'_id': guild_id})
            if not query:
                return 'Not Configured'
            else:
                return query[channel_type]
        except Exception as e:
            await log_exception(e)

    async def setup(self, bot, guild):
        try:
            database = bot.gdb
            guild_id = guild.id
            player_board = await self.query_channel('playerBoardChannel', database, guild_id)
            quest_board = await self.query_channel('questChannel', database, guild_id)
            quest_archive = await self.query_channel('archiveChannel', database, guild_id)

            self.quest_board_info.content = (f'**Quest Board:** {quest_board}\n'
                                             f'The channel where new/active quests will be posted.')
            self.player_board_info.content = (f'**Player Board:** {player_board}\n'
                                              f'An optional announcement/message board for use by players.')
            self.quest_archive_info.content = (f'**Quest Archive:** {quest_archive}\n'
                                               f'An optional channel where completed quests will move to, with summary '
                                               f'information.')
        except Exception as e:
            await log_exception(e)


# ------ QUESTS ------


class ConfigQuestsView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.wait_list_info = TextDisplay(
            '**Quest Wait List Size:** Disabled\n'
            'A wait list allows the specified number of players to queue for a quest that is full, '
            'in case a player drops.'
        )
        self.quest_summary_info = TextDisplay(
            '**Quest Summary:** Disabled\n'
            'This option enables GMs to provide a short summary when closing out quests.'
        )
        self.wait_list_select = selects.ConfigWaitListSelect(self)
        self.quest_summary_toggle_button = buttons.QuestSummaryToggleButton(self)

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay('**Server Configuration - Quests**'))

        container.add_item(header_section)
        container.add_item(Separator())

        container.add_item(self.wait_list_info)
        wait_list_select_row = ActionRow(self.wait_list_select)
        container.add_item(wait_list_select_row)
        container.add_item(Separator())

        quest_summary_section = Section(accessory=self.quest_summary_toggle_button)
        quest_summary_section.add_item(self.quest_summary_info)
        container.add_item(quest_summary_section)
        container.add_item(Separator())

        gm_rewards_section = Section(accessory=MenuViewButton(GMRewardsView, 'GM Rewards'))
        gm_rewards_section.add_item(TextDisplay(
            '**GM Rewards**\n'
            'Configure rewards for GMs to receive upon completing quests.'
        ))
        container.add_item(gm_rewards_section)

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            quest_summary = await query_config('questSummary', bot, guild)
            wait_list = await query_config('questWaitList', bot, guild)

            self.wait_list_info.content = (
                f'**Quest Wait List Size:** {wait_list if wait_list > 0 else 'Disabled'}\n'
                f'A wait list allows the specified number of players to queue for a quest that is full, in case a '
                f'player drops.'
            )
            self.quest_summary_info.content = (
                f'**Quest Summary:** {"Enabled" if quest_summary else "Disabled"}\n'
                f'This option enables GMs to provide a short summary when closing out quests.'
            )
        except Exception as e:
            await log_exception(e)


class GMRewardsView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.gm_rewards_info = TextDisplay(
            'No rewards configured.'
        )
        self.current_rewards = None

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(ConfigQuestsView))
        header_section.add_item(TextDisplay('**Server Configuration - GM Rewards**'))

        container.add_item(header_section)
        container.add_item(Separator())

        gm_rewards_section = Section(accessory=buttons.GMRewardsButton(self))
        gm_rewards_section.add_item(TextDisplay(
            '**Add/Modify Rewards**\n'
            'Opens an input modal to add, modify, or remove GM rewards.\n\n'
            '> Rewards configured are on a per-quest basis. Every time a Game Master completes a quest, they will '
            'receive the rewards configured below on their active character.'
        ))
        container.add_item(gm_rewards_section)
        container.add_item(Separator())

        container.add_item(self.gm_rewards_info)

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            gm_rewards_collection = bot.gdb['gmRewards']
            gm_rewards_query = await gm_rewards_collection.find_one({'_id': guild.id})
            experience = None
            items = None
            if gm_rewards_query:
                self.current_rewards = gm_rewards_query
                experience = gm_rewards_query['experience']
                items = gm_rewards_query['items']

            xp_info = ''
            item_info = ''
            if experience:
                xp_info = f'**Experience:** {experience}'

            if items:
                rewards_list = []
                for item, quantity in items.items():
                    rewards_list.append(f'{item.capitalize()}: {quantity}')
                rewards_string = '\n'.join(rewards_list)
                item_info = f'**Items:**\n{rewards_string}'

            if xp_info or item_info:
                self.gm_rewards_info.content = f'{xp_info}\n\n{item_info}'
        except Exception as e:
            await log_exception(e)


# ------ PLAYERS ------


class ConfigPlayersView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.player_experience_info = TextDisplay(
            '**Player Experience:** Disabled\n'
            'Enables/Disables the use of experience points (or similar value-based character progression.'
        )
        self.player_experience = True

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay('**Server Configuration - Players**'))

        container.add_item(header_section)
        container.add_item(Separator())

        experience_section = Section(accessory=buttons.PlayerExperienceToggleButton(self))
        experience_section.add_item(self.player_experience_info)
        container.add_item(experience_section)
        container.add_item(Separator())

        player_board_section = Section(accessory=buttons.PlayerBoardPurgeButton(self))
        player_board_section.add_item(TextDisplay(
            '**Player Board Purge**\n'
            'Purges posts from the player board (if enabled).\n\n'
        ))
        container.add_item(player_board_section)

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            self.player_experience = await query_config('playerExperience', bot, guild)
            self.player_experience_info.content = (
                f'**Player Experience:** {'Enabled' if self.player_experience else 'Disabled'}\n'
                f'Enables/Disables the use of experience points (or similar value-based character progression.'
            )
        except Exception as e:
            await log_exception(e)


class ConfigRemoveDenominationView(View):
    def __init__(self, calling_view):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title=f'Server Configuration - Remove Denomination',
            description='Select a denomination to remove.',
            type='rich'
        )
        self.calling_view = calling_view
        self.selected_denomination_name = None
        self.remove_denomination_select = selects.RemoveDenominationSelect(self)
        self.remove_denomination_confirm_button = buttons.RemoveDenominationConfirmButton(self)
        self.add_item(self.remove_denomination_select)
        self.add_item(self.remove_denomination_confirm_button)
        self.add_item(BackButton(ConfigEditCurrencyView))

    async def setup(self, bot, guild):
        try:
            self.embed.clear_fields()
            self.remove_denomination_select.options.clear()

            currency_name = self.calling_view.selected_currency_name
            collection = bot.gdb['currency']
            query = await collection.find_one({'_id': guild.id, 'currencies.name': currency_name})
            currency = next((item for item in query['currencies'] if item['name'] == currency_name), None)
            denominations = currency['denominations']
            if len(denominations) > 0:
                for denomination in denominations:
                    denomination_name = denomination['name']
                    self.remove_denomination_select.options.append(discord.SelectOption(label=denomination_name,
                                                                                        value=denomination_name))
            else:
                self.remove_denomination_select.options.append(discord.SelectOption(label='None available',
                                                                                    value='None'))
                self.remove_denomination_select.placeholder = (f'There are no remaining denominations for '
                                                               f'{currency_name}.')
                self.remove_denomination_select.disabled = True

            if self.selected_denomination_name:
                self.embed.add_field(name=f'Deleting {self.selected_denomination_name}', value='Confirm?')
        except Exception as e:
            await log_exception(e)

    async def remove_currency_denomination(self, denomination_name, bot, guild):
        try:
            collection = bot.gdb['currency']
            currency_name = self.calling_view.selected_currency_name
            await collection.update_one({'_id': guild.id, 'currencies.name': currency_name},
                                        {'$pull': {'currencies.$.denominations': {'name': denomination_name}}})
        except Exception as e:
            await log_exception(e)


class ConfigEditCurrencyView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Server Configuration - Edit Currency',
            description=(
                '__**Toggle View**__\n'
                'Toggles between integer (10) and double (10.00) display views.\n\n'
                '__**Add Denomination**__\n'
                'Add one or more denomination(s) to the selected currency.\n\n'
                '__**Edit Denomination**__\n'
                'Edit the value of an existing denomination.\n\n'
                '__**Remove Denomination**__\n'
                'Remove one or more denomination(s) from the selected currency.\n\n'
                '-----'
            ),
            type='rich'
        )
        self.selected_currency_name = None
        self.edit_currency_select = selects.EditCurrencySelect(self)
        self.toggle_double_button = buttons.ToggleDoubleButton(self)
        self.add_denomination_button = buttons.AddDenominationButton(self)
        self.remove_denomination_button = buttons.RemoveDenominationButton(ConfigRemoveDenominationView, self)
        self.add_item(self.edit_currency_select)
        self.add_item(self.toggle_double_button)
        self.add_item(self.add_denomination_button)
        self.add_item(self.remove_denomination_button)
        self.add_item(BackButton(ConfigCurrencyView))

    async def setup(self, bot, guild):
        try:
            self.embed.clear_fields()
            self.edit_currency_select.options.clear()

            collection = bot.gdb['currency']
            query = await collection.find_one({'_id': guild.id})

            if self.selected_currency_name:
                currency_name = self.selected_currency_name
                self.toggle_double_button.disabled = False
                self.toggle_double_button.label = f'Toggle Display for {currency_name}'
                self.add_denomination_button.disabled = False
                self.add_denomination_button.label = f'Add Denomination to {currency_name}'
                self.remove_denomination_button.label = f'Remove Denomination from {currency_name}'

                currency = next((item for item in query['currencies'] if item['name'] == currency_name),
                                None)
                if currency['isDouble']:
                    display = 'Double (10.00)'
                else:
                    display = 'Integer (10)'

                denominations = currency['denominations']
                if len(denominations) > 0:
                    values = []
                    for denomination in denominations:
                        denomination_name = denomination['name']
                        value = denomination['value']
                        values.append(f'{denomination_name}: {value}')
                    denominations_string = '\n- '.join(values)
                    self.remove_denomination_button.disabled = False
                else:
                    self.remove_denomination_button.disabled = True
                    denominations_string = 'None'

                self.embed.add_field(name=f'{self.selected_currency_name}',
                                     value=f'__Display:__ {display}\n'
                                           f'__Denominations__:\n- {denominations_string}',
                                     inline=True)
            else:
                self.toggle_double_button.disabled = True
                self.add_denomination_button.disabled = True

            for currency in query['currencies']:
                name = currency['name']
                self.edit_currency_select.options.append(discord.SelectOption(label=name, value=name))
        except Exception as e:
            await log_exception(e)


class ConfigCurrencyView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Server Configuration - Currency',
            description=(
                '__**Add New Currency**__\n'
                'Creates a new currency.\n\n'
                '__**Edit Currency**__\n'
                'Update options for an existing currency, such as the double representation and optional denominations.'
                '\n\n'
                '__**Remove Currency**__\n'
                'Remove a currency entirely.\n\n'
                '__** Key Definitions **__\n'
                '- **Name:** The name of the currency. Always has a base value of 1. Example: Gold\n'
                ' ```Note: ReQuest does not care about letter case from a functional standpoint, but any presentations '
                'of your currency in menus will use the case you input when the currency is created, I.E. "Gold" vs. '
                '"gold".```\n'
                '- **Double:** This optional value specifies whether or not currency is displayed as whole integers '
                '(10) or as a double (10.00). Default is `False`\n'
                '- **Denominations:** This optional configuration adds denominations under the base currency. '
                'Following the gold example, this would be Silver (at a value of 0.1), and Platinum (at a value of '
                '10).\n'
                '-----'
            ),
            type='rich'
        )
        self.edit_currency_button = buttons.EditCurrencyButton(ConfigEditCurrencyView)
        self.remove_currency_button = buttons.RemoveCurrencyButton(RemoveCurrencyView)
        self.add_item(buttons.AddCurrencyButton(self))
        self.add_item(self.edit_currency_button)
        self.add_item(self.remove_currency_button)
        self.add_item(BackButton(ConfigBaseView))

    async def setup(self, bot, guild):
        try:
            self.embed.clear_fields()
            collection = bot.gdb['currency']
            query = await collection.find_one({'_id': guild.id})
            self.edit_currency_button.disabled = True
            self.remove_currency_button.disabled = True

            if query and len(query['currencies']) > 0:
                self.edit_currency_button.disabled = False
                self.remove_currency_button.disabled = False

                currency_names = []
                for currency in query['currencies']:
                    currency_names.append(currency['name'])

                self.embed.add_field(name='Active Currencies', value=', '.join(currency_names))
        except Exception as e:
            await log_exception(e)


class RemoveCurrencyView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Server Configuration - Remove Currency',
            description='Select a currency to remove',
            type='rich'
        )
        self.selected_currency_name = None
        self.remove_currency_select = selects.RemoveCurrencySelect(self)
        self.remove_currency_confirm_button = buttons.RemoveCurrencyConfirmButton(self)
        self.add_item(self.remove_currency_select)
        self.add_item(self.remove_currency_confirm_button)
        self.add_item(BackButton(ConfigCurrencyView))

    async def setup(self, bot, guild):
        try:
            self.embed.clear_fields()
            self.remove_currency_select.options.clear()

            if self.selected_currency_name:
                self.embed.add_field(name=f'Deleting {self.selected_currency_name}',
                                     value='Confirm?')

            collection = bot.gdb['currency']
            query = await collection.find_one({'_id': guild.id})
            currencies = query['currencies']
            options = []
            if len(currencies) > 0:
                for currency in currencies:
                    name = currency['name']
                    option = discord.SelectOption(label=name, value=name)
                    options.append(option)
                    self.remove_currency_select.disabled = False
            else:
                options.append(discord.SelectOption(label='None', value='None'))
                self.remove_currency_select.placeholder = 'There are no remaining currencies on this server!'
                self.remove_currency_select.disabled = True

            self.remove_currency_select.options = options
        except Exception as e:
            await log_exception(e)

    async def remove_currency(self, bot, guild):
        try:
            currency_name = self.selected_currency_name
            collection = bot.gdb['currency']
            await collection.update_one({'_id': guild.id, 'currencies.name': currency_name},
                                        {'$pull': {'currencies': {'name': currency_name}}}, upsert=True)
        except Exception as e:
            await log_exception(e)


# ------ SHOPS ------
class ConfigShopsView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Server Configuration - Shops',
            description=(
                '__**Add Shop (Wizard)**__\n'
                'Create a new, empty shop from a form.\n\n'
                '__**Add Shop (JSON)**__\n'
                'Create a new shop by providing a full JSON definition. (Advanced)\n\n'
                '__**Edit Shop (Wizard)**__\n'
                'Edit the selected shop using a UI wizard.\n\n'
                '__**Edit Shop (JSON)**__\n'
                'Upload a new JSON file to replace the selected shop\'s definition.\n\n'
                '__**Download JSON**__\n'
                'Download the selected shop\'s current JSON definition.\n\n'
                '__**Remove Shop**__\n'
                'Removes the selected shop.\n\n'
                '-----'
            ),
            type='rich'
        )
        self.selected_channel_id = None

        self.shop_select = selects.ConfigShopSelect(self)
        self.add_shop_wizard_button = buttons.AddShopWizardButton(self)
        self.add_shop_json_button = buttons.AddShopJSONButton(self)
        self.edit_shop_button = buttons.EditShopButton(EditShopView, self)
        self.download_shop_json_button = buttons.DownloadShopJSONButton(self)
        self.update_shop_json_button = buttons.UpdateShopJSONButton(self)
        self.remove_shop_button = buttons.RemoveShopButton(self)

        self.add_item(self.shop_select)
        self.add_item(self.add_shop_wizard_button)
        self.add_item(self.add_shop_json_button)
        self.add_item(self.edit_shop_button)
        self.add_item(self.update_shop_json_button)
        self.add_item(self.download_shop_json_button)
        self.add_item(self.remove_shop_button)
        self.add_item(BackButton(target_view_class=ConfigBaseView))

    async def setup(self, bot, guild):
        try:
            self.embed.clear_fields()
            self.shop_select.options.clear()

            collection = bot.gdb['shops']
            query = await collection.find_one({'_id': guild.id})

            shop_options = []
            if query and query.get('shopChannels'):
                for channel_id, shop_data in query['shopChannels'].items():
                    shop_name = shop_data.get('shopName')
                    channel_name = guild.get_channel(int(channel_id)).name
                    shop_options.append(discord.SelectOption(label=f'{shop_name} (#{channel_name})', value=channel_id))

            if shop_options:
                self.shop_select.options = shop_options
                self.shop_select.disabled = False
                self.shop_select.placeholder = 'Select a shop to manage'
            else:
                self.shop_select.options = [discord.SelectOption(label='No shops configured', value='None')]
                self.shop_select.disabled = True
                self.shop_select.placeholder = 'No shops configured'

            if self.selected_channel_id:
                shop_name = next((opt.label for opt in shop_options if opt.value == self.selected_channel_id),
                                 "Unknown").split('(')[0].strip()
                shop_id = next((opt.value for opt in shop_options if opt.value == self.selected_channel_id),
                               None)
                self.embed.add_field(name='Selected Shop', value=f'{shop_name}: <#{shop_id}>')
                self.edit_shop_button.disabled = False
                self.download_shop_json_button.disabled = False
                self.update_shop_json_button.disabled = False
                self.remove_shop_button.disabled = False

            if not self.selected_channel_id:
                self.edit_shop_button.disabled = True
                self.download_shop_json_button.disabled = True
                self.update_shop_json_button.disabled = True
                self.remove_shop_button.disabled = True

        except Exception as e:
            await log_exception(e)


class EditShopView(LayoutView):
    def __init__(self, channel_id: str, shop_data: dict):
        super().__init__(timeout=None)
        self.channel_id = channel_id
        self.shop_data = shop_data
        self.all_stock = self.shop_data.get('shopStock', [])

        self.items_per_page = 6
        self.current_page = 0
        self.total_pages = math.ceil(len(self.all_stock) / self.items_per_page)

    def build_view(self):
        self.clear_items()
        container = Container()
        header_items = [TextDisplay(f'**Editing Shop: {self.shop_data.get("shopName")}**')]

        if shop_keeper := self.shop_data.get('shopKeeper'):
            header_items.append(TextDisplay(f'Shopkeeper: **{shop_keeper}**'))
        if shop_description := self.shop_data.get('shopDescription'):
            header_items.append(TextDisplay(f'*{shop_description}*'))

        if shop_image := self.shop_data.get('shopImage'):
            shop_image = Thumbnail(media=f'{shop_image}')
            shop_header = Section(accessory=shop_image)

            for item in header_items:
                shop_header.add_item(item)

            container.add_item(shop_header)
        else:
            for item in header_items:
                container.add_item(item)
        header_buttons = ActionRow()
        header_buttons.add_item(buttons.AddItemButton(self))
        header_buttons.add_item(buttons.EditShopDetailsButton(self))
        container.add_item(header_buttons)
        container.add_item(Separator())

        start_index = self.current_page * self.items_per_page
        end_index = start_index + self.items_per_page
        current_stock = self.all_stock[start_index:end_index]

        for item in current_stock:
            item_name = item.get('name')
            item_desc = item.get('description', None)
            item_price = item.get('price')
            item_currency = item.get('currency')
            item_quantity = item.get('quantity', 1)
            if item_desc:
                item_text = TextDisplay(
                    f'**{item_name} x{item_quantity}**: {item_price} {item_currency}\n'
                    f'*{item_desc}*'
                )
            else:
                item_text = TextDisplay(
                    f'**{item_name} x{item_quantity}**: {item_price} {item_currency}'
                )

            container.add_item(item_text)

            item_buttons = ActionRow()
            item_buttons.add_item(buttons.EditShopItemButton(item, self))
            item_buttons.add_item(buttons.DeleteShopItemButton(item, self))

            container.add_item(item_buttons)

        self.add_item(container)

        if self.total_pages > 1:
            pagination_row = ActionRow()

            prev_button = Button(
                label='Previous',
                style=ButtonStyle.secondary,
                custom_id='shop_edit_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page

            page_display = Button(
                label=f'Page {self.current_page + 1}/{self.total_pages}',
                style=ButtonStyle.secondary,
                custom_id='shop_edit_page'
            )
            page_display.callback = self.show_page_jump_modal

            next_button = Button(
                label='Next',
                style=ButtonStyle.primary,
                custom_id='shop_edit_next',
                disabled=(self.current_page >= self.total_pages - 1)
            )
            next_button.callback = self.next_page

            pagination_row.add_item(prev_button)
            pagination_row.add_item(page_display)
            pagination_row.add_item(next_button)
            pagination_row.add_item(MenuDoneButton())

            self.add_item(pagination_row)
        else:
            button_row = ActionRow()
            button_row.add_item(MenuDoneButton())
            self.add_item(button_row)

    async def prev_page(self, interaction: discord.Interaction):
        if self.current_page > 0:
            self.current_page -= 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def next_page(self, interaction: discord.Interaction):
        if self.current_page < self.total_pages - 1:
            self.current_page += 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def show_page_jump_modal(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(common_modals.PageJumpModal(self))
        except Exception as e:
            logging.error(f'Failed to send PageJumpModal: {e}')
            await interaction.response.send_message('Could not open page selector', ephemeral=True)

    def update_stock(self, new_stock: list):
        self.all_stock = new_stock
        self.shop_data['shopStock'] = new_stock

        self.total_pages = math.ceil(len(self.all_stock) / self.items_per_page)
        if self.current_page >= self.total_pages:
            self.current_page = max(0, self.total_pages - 1)

    def update_details(self, new_shop_data: dict):
        new_shop_data['shopStock'] = self.all_stock
        self.shop_data = new_shop_data
