import logging
import math

import discord
from discord import ButtonStyle
from discord.ui import View, LayoutView, Container, Section, Separator, ActionRow, Button, TextDisplay, Thumbnail

from ReQuest.ui.common.buttons import MenuViewButton, MenuDoneButton, BackButton
from ReQuest.ui.common import modals as common_modals
from ReQuest.ui.config import buttons, selects
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
                'Global currency settings.\n\n'
                '__**Shops**__\n'
                'Configure custom shops.\n\n'
            ),
            type='rich'
        )
        self.add_item(MenuViewButton(ConfigRolesView, 'Roles'))
        self.add_item(MenuViewButton(ConfigChannelsView, 'Channels'))
        self.add_item(MenuViewButton(ConfigQuestsView, 'Quests'))
        self.add_item(MenuViewButton(ConfigPlayersView, 'Players'))
        self.add_item(MenuViewButton(ConfigCurrencyView, 'Currency'))
        self.add_item(MenuViewButton(ConfigShopsView, 'Shops'))
        self.add_item(MenuDoneButton(row=None))


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
