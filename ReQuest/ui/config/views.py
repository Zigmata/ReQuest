import logging

import discord
from discord.ui import View

from ReQuest.ui.config import buttons, selects
from ReQuest.ui.common.buttons import MenuViewButton, MenuDoneButton, BackButton
from ReQuest.utilities.supportFunctions import log_exception, query_config

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class ConfigBaseView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Server Configuration - Main Menu',
            description=(
                '__**Roles**__\n'
                'Configuration options for pingable or privileged roles.\n\n'
                '__**Channels**__\n'
                'Set designated channels for ReQuest posts.\n\n'
                '__**Quests**__\n'
                'Global quest settings, such as wait lists.\n\n'
                '__**Players**__\n'
                'Global player settings, such as experience point tracking.\n\n'
                '__**Currency**__\n'
                'Server-wide currency settings.\n\n'
            ),
            type='rich'
        )
        self.add_item(MenuViewButton(ConfigRolesView, 'Roles'))
        self.add_item(MenuViewButton(ConfigChannelsView, 'Channels'))
        self.add_item(MenuViewButton(ConfigQuestsView, 'Quests'))
        self.add_item(MenuViewButton(ConfigPlayersView, 'Players'))
        self.add_item(MenuViewButton(ConfigCurrencyView, 'Currency'))
        self.add_item(MenuDoneButton())


class ConfigRolesView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Server Configuration - Roles',
            description=(
                '__**Announcement Role**__\n'
                'This role is mentioned when a quest is posted.\n\n'
                '__**GM Role**__\n'
                'A role designated as GM will gain access to extended Game Master commands and functionality.\n\n'
                '__**Forbidden Roles**__\n'
                'Configures a list of role names that cannot be used by Game Masters for their party roles. By '
                'default, `everyone`, `administrator`, `gm`, and `game master` cannot be used. This configuration '
                'extends that list.\n\n'
                '-----'
            ),
            type='rich'
        )
        self.quest_announce_role_remove_button = buttons.QuestAnnounceRoleRemoveButton(self)
        self.gm_role_remove_view_button = buttons.GMRoleRemoveViewButton(ConfigGMRoleRemoveView)
        self.forbidden_roles_button = buttons.ForbiddenRolesButton(self)
        self.add_item(selects.QuestAnnounceRoleSelect(self))
        self.add_item(selects.AddGMRoleSelect(self))
        self.add_item(self.quest_announce_role_remove_button)
        self.add_item(self.gm_role_remove_view_button)
        self.add_item(self.forbidden_roles_button)
        self.add_item(BackButton(ConfigBaseView))

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
            self.embed.clear_fields()
            announcement_role = await self.query_role('announceRole', bot, guild)
            gm_roles = await self.query_role('gmRoles', bot, guild)

            if not announcement_role:
                announcement_role_string = 'Not Configured'
                self.quest_announce_role_remove_button.disabled = True
            else:
                announcement_role_string = f'{announcement_role}'
                self.quest_announce_role_remove_button.disabled = False

            if not gm_roles:
                gm_roles_string = 'Not Configured'
                self.gm_role_remove_view_button.disabled = True
            else:
                role_mentions = []
                for role in gm_roles:
                    role_mentions.append(role['mention'])

                gm_roles_string = f'- {'\n- '.join(role_mentions)}'
                self.gm_role_remove_view_button.disabled = False

            self.embed.add_field(name='Announcement Role', value=announcement_role_string)
            self.embed.add_field(name='GM Roles', value=gm_roles_string)
        except Exception as e:
            await log_exception(e)


class ConfigGMRoleRemoveView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Server Configuration - Remove GM Role(s)',
            description='Select roles from the dropdown below to remove from GM status.\n\n'
                        '-----',
            type='rich'
        )
        self.gm_role_remove_select = selects.GMRoleRemoveSelect(self)
        self.add_item(self.gm_role_remove_select)
        self.add_item(BackButton(ConfigRolesView))

    async def setup(self, bot, guild):
        try:
            # Clear any embed fields or select options
            self.embed.clear_fields()
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
                self.embed.add_field(name='Current GM Roles', value=f'- {'\n- '.join(role_mentions)}')
                self.gm_role_remove_select.disabled = False
            else:
                options.append(discord.SelectOption(label='None', value='None'))
                self.gm_role_remove_select.disabled = True
            self.gm_role_remove_select.options = options
        except Exception as e:
            await log_exception(e)


class ConfigChannelsView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Server Configuration - Channels',
            description=(
                '__**Quest Board**__\n'
                'The channel where new/active quests will be posted.\n\n'
                '__**Player Board**__\n'
                'An optional announcement/message board for use by players.\n\n'
                '__**Quest Archive**__\n'
                'An optional channel where completed quests will move to, with summary information.\n\n'
                '-----'
            ),
            type='rich'
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
        self.clear_channels_button = buttons.ClearChannelsButton(self)
        self.add_item(self.quest_channel_select)
        self.add_item(self.player_board_channel_select)
        self.add_item(self.archive_channel_select)
        self.add_item(self.clear_channels_button)
        self.add_item(BackButton(ConfigBaseView))

    @staticmethod
    async def query_channel(channel_type, database, guild_id):
        try:
            collection = database[channel_type]

            query = await collection.find_one({'_id': guild_id})
            logger.debug(f'{channel_type} query: {query}')
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

            self.embed.clear_fields()
            self.embed.add_field(name='Quest Board', value=quest_board, inline=False)
            self.embed.add_field(name='Player Board', value=player_board, inline=False)
            self.embed.add_field(name='Quest Archive', value=quest_archive, inline=False)
        except Exception as e:
            await log_exception(e)


class GMRewardsView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Server Configuration - GM Rewards',
            description=(
                '__**Add/Modify Rewards**__\n'
                'Opens an input modal to add, modify, or remove GM rewards.\n\n'
                '> Rewards configured are on a per-quest basis. Every time a Game Master completes a quest, they will '
                'receive the rewards configured here on their active character.\n\n'
                '------'
            )
        )
        self.current_rewards = None
        self.add_item(buttons.GMRewardsButton(self))
        self.add_item(BackButton(ConfigQuestsView))

    async def setup(self, bot, guild):
        try:
            self.embed.clear_fields()
            gm_rewards_collection = bot.gdb['gmRewards']
            gm_rewards_query = await gm_rewards_collection.find_one({'_id': guild.id})
            experience = None
            items = None
            if gm_rewards_query:
                self.current_rewards = gm_rewards_query
                experience = gm_rewards_query['experience']
                items = gm_rewards_query['items']

            if experience:
                self.embed.add_field(name='Experience', value=experience)

            if items:
                rewards_list = []
                for item, quantity in items.items():
                    rewards_list.append(f'{item.capitalize()}: {quantity}')
                rewards_string = '\n'.join(rewards_list)
                self.embed.add_field(name='Items', value=rewards_string, inline=False)
        except Exception as e:
            await log_exception(e)


class ConfigQuestsView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Server Configuration - Quests',
            description=(
                '__**Quest Summary**__\n'
                'This option enables GMs to provide a short summary block when closing out quests.\n\n'
                '__**Quest Wait List**__\n'
                'This option enables the specified number of players to queue for a quest, in case a player drops.\n\n'
                '__**GM Rewards**__\n'
                'Configure rewards for GMs to receive upon completing quests.\n\n'
                '-----'
            ),
            type='rich'
        )
        self.add_item(selects.ConfigWaitListSelect(self))
        self.add_item(buttons.QuestSummaryToggleButton(self))
        self.add_item(MenuViewButton(GMRewardsView, 'GM Rewards'))
        self.add_item(BackButton(ConfigBaseView))

    async def setup(self, bot, guild):
        try:
            self.embed.clear_fields()
            quest_summary = await query_config('questSummary', bot, guild)
            wait_list = await query_config('questWaitList', bot, guild)

            self.embed.add_field(name='Quest Summary Enabled', value=quest_summary, inline=False)
            self.embed.add_field(name='Quest Wait List', value=wait_list, inline=False)
        except Exception as e:
            await log_exception(e)


class ConfigPlayersView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Server Configuration - Players',
            description=(
                '__**Experience**__\n'
                'Enables/Disables the use of experience points (or similar value-based character progression).\n\n'
                '__**Player Board Purge**__\n'
                'Purges posts from the player board (if enabled).\n\n'
                '-----'
            ),
            type='rich'
        )
        self.player_board_purge_button = buttons.PlayerBoardPurgeButton(self)
        self.add_item(buttons.PlayerExperienceToggleButton(self))
        self.add_item(self.player_board_purge_button)
        self.add_item(BackButton(ConfigBaseView))

    async def setup(self, bot, guild):
        try:
            self.embed.clear_fields()

            player_experience = await query_config('playerExperience', bot, guild)
            self.embed.add_field(name='Player Experience Enabled', value=player_experience, inline=False)
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
