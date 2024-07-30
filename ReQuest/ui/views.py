import logging

import discord

from ReQuest.ui.buttons import PlayerMenuButton, MenuDoneButton, PlayerBackButton, ConfigMenuButton, ConfigBackButton, \
    AdminMenuButton, AdminBackButton, AdminShutdownButton, RegisterCharacterButton, ListCharactersButton, \
    RemoveCharacterButton, ConfirmButton, QuestAnnounceRoleRemoveButton, GMRoleRemoveButton, QuestSummaryToggleButton, \
    PlayerExperienceToggleButton, RemoveDenominationConfirmButton, ToggleDoubleButton, AddDenominationButton, \
    RemoveDenominationButton, AddCurrencyButton, EditCurrencyButton, RemoveCurrencyButton, RemoveCurrencyConfirmButton, \
    AllowlistAddServerButton, ConfirmAllowlistRemoveButton, AdminLoadCogButton, AdminReloadCogButton, \
    ViewInventoryButton, SpendCurrencyButton
from ReQuest.ui.selects import GMRoleRemoveSelect, SingleChannelConfigSelect, ActiveCharacterSelect, \
    RemoveCharacterSelect, AddGMRoleSelect, QuestAnnounceRoleSelect, ConfigWaitListSelect, RemoveDenominationSelect, \
    EditCurrencySelect, RemoveCurrencySelect, RemoveGuildAllowlistSelect
from ReQuest.utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class PlayerBaseView(discord.ui.View):
    def __init__(self, mdb, bot, member_id, guild_id):
        super().__init__()
        self.mdb = mdb
        self.bot = bot
        self.member_id = member_id
        self.guild_id = guild_id
        self.embed = discord.Embed(
            title='Player Commands - Main Menu',
            description=(
                '__**Characters**__\n'
                'Commands to register, view, and activate player characters.\n\n'
                '__**Inventory**__\n'
                'Commands to view your active character\'s inventory, spend currency, and trade with other players.'
            ),
            type='rich'
        )
        self.add_item(PlayerMenuButton(CharacterBaseView, 'Characters', mdb, bot, member_id, guild_id))
        self.add_item(PlayerMenuButton(InventoryBaseView, 'Inventory', mdb, bot, member_id, guild_id))
        self.add_item(MenuDoneButton())


class CharacterBaseView(discord.ui.View):
    def __init__(self, mdb, bot, member_id, guild_id):
        super().__init__(timeout=None)
        self.mdb = mdb
        self.bot = bot
        self.member_id = member_id
        self.guild_id = guild_id
        self.embed = discord.Embed(
            title='Player Commands - Characters',
            description=(
                '__**Register**__\n'
                'Registers a new character, and activates that character on the current server.\n\n'
                '__**List/Activate**__\n'
                'Show all registered characters, and change the active character for this server.\n\n'
                '__**Remove**__\n'
                'Removes a character permanently.\n\n'
            ),
            type='rich'
        )
        self.add_item(RegisterCharacterButton())
        self.add_item(ListCharactersButton(ListCharactersView(mdb, bot, member_id, guild_id)))
        self.add_item(RemoveCharacterButton(RemoveCharacterView(mdb, bot, member_id, guild_id)))
        self.add_item(PlayerBackButton(PlayerBaseView, mdb, bot, member_id, guild_id))


class ListCharactersView(discord.ui.View):
    def __init__(self, mdb, bot, member_id, guild_id):
        super().__init__(timeout=None)
        self.mdb = mdb
        self.bot = bot
        self.member_id = member_id
        self.guild_id = guild_id
        self.embed = discord.Embed(
            title='Player Commands - List Characters',
            description='Registered Characters are listed below. Select a character from the dropdown to activate '
                        'that character for this server.',
            type='rich'
        )
        self.active_character_select = ActiveCharacterSelect(self)
        self.add_item(self.active_character_select)
        self.add_item(PlayerBackButton(CharacterBaseView, mdb, bot, member_id, guild_id))

    async def setup_embed(self):
        try:
            self.embed.clear_fields()
            collection = self.mdb['characters']
            query = await collection.find_one({'_id': self.member_id})
            if not query or not query['characters']:
                self.embed.description = 'You have no registered characters!'
            else:
                ids = []
                for character_id in query['characters']:
                    ids.append(character_id)
                for character_id in ids:
                    character = query['characters'][character_id]
                    if (str(self.guild_id) in query['activeCharacters']
                            and character_id == query['activeCharacters'][str(self.guild_id)]):
                        character_info = (f'{character['name']}: {character['attributes']['experience']} XP '
                                          f'(Active Character)')
                    else:
                        character_info = f'{character['name']}: {character['attributes']['experience']} XP'
                    self.embed.add_field(name=character_info, value=character['note'], inline=False)
        except Exception as e:
            await log_exception(e)

    async def setup_select(self):
        try:
            self.active_character_select.options.clear()
            options = []
            collection = self.mdb['characters']
            query = await collection.find_one({'_id': self.member_id})
            if not query or not query['characters'] or len(query['characters']) == 0:
                options.append(discord.SelectOption(label='No characters', value='None'))
            else:
                for character_id in query['characters']:
                    character = query['characters'][character_id]
                    character_name = character['name']
                    option = discord.SelectOption(label=character_name, value=character_id)
                    options.append(option)
                self.active_character_select.disabled = False
                self.active_character_select.placeholder = 'Select a character to activate on this server'

            self.active_character_select.options = options
        except Exception as e:
            await log_exception(e)


class RemoveCharacterView(discord.ui.View):
    def __init__(self, mdb, bot, member_id, guild_id):
        super().__init__(timeout=None)
        self.mdb = mdb
        self.bot = bot
        self.member_id = member_id
        self.guild_id = guild_id
        self.embed = discord.Embed(
            title='Player Commands - Remove Character',
            description='Select a character from the dropdown. Confirm to permanently remove that character.',
            type='rich'
        )
        self.selected_character_id = None
        confirm_button = ConfirmButton(self)
        self.remove_character_select = RemoveCharacterSelect(self, confirm_button)
        self.add_item(self.remove_character_select)
        self.add_item(confirm_button)
        self.add_item(PlayerBackButton(CharacterBaseView, mdb, bot, member_id, guild_id))

    async def setup_select(self):
        try:
            self.remove_character_select.options.clear()
            options = []
            collection = self.mdb['characters']
            query = await collection.find_one({'_id': self.member_id})
            if not query or not query['characters'] or len(query['characters']) == 0:
                options.append(discord.SelectOption(label='No characters', value='None'))
                self.remove_character_select.disabled = True
            else:
                for character_id in query['characters']:
                    character = query['characters'][character_id]
                    character_name = character['name']
                    option = discord.SelectOption(label=character_name, value=character_id)
                    options.append(option)
                self.remove_character_select.disabled = False

            self.remove_character_select.options = options
        except Exception as e:
            await log_exception(e)


class ConfigBaseView(discord.ui.View):
    def __init__(self, guild_id, gdb):
        super().__init__(timeout=None)
        self.guild_id = guild_id
        self.gdb = gdb
        self.embed = discord.Embed(
            title='Server Configuration - Main Menu',
            description=('__**Roles**__\n'
                         'Configuration options for pingable or privileged roles.\n\n'
                         '__**Channels**__\n'
                         'Set designated channels for ReQuest posts.\n\n'
                         '__**Quests**__\n'
                         'Global quest settings, such as wait lists.\n\n'
                         '__**Players**__\n'
                         'Global player settings, such as experience point tracking.\n\n'
                         '__**Currency**__\n'
                         'Server-wide currency settings.'),
            type='rich'
        )
        self.add_item(ConfigMenuButton(ConfigRolesView, 'Roles', guild_id, gdb))
        self.add_item(ConfigMenuButton(ConfigChannelsView, 'Channels', guild_id, gdb))
        self.add_item(ConfigMenuButton(ConfigQuestsView, 'Quests', guild_id, gdb))
        self.add_item(ConfigMenuButton(ConfigPlayersView, 'Players', guild_id, gdb))
        self.add_item(ConfigMenuButton(ConfigCurrencyView, 'Currency', guild_id, gdb))
        self.add_item(MenuDoneButton())


class ConfigRolesView(discord.ui.View):
    def __init__(self, guild_id, gdb):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Server Configuration - Roles',
            description=(
                '__**Announcement Role**__\n'
                'This role is mentioned when a quest is posted.\n\n'
                '__**GM Role**__\n'
                'A role designated as GM will gain access to extended Game Master commands and functionality.\n\n'
                '-----'
            ),
            type='rich'
        )
        self.guild_id = guild_id
        self.gdb = gdb
        self.quest_announce_role_remove_button = QuestAnnounceRoleRemoveButton(self)
        self.gm_role_remove_button = GMRoleRemoveButton(ConfigGMRoleRemoveView(self.guild_id, self.gdb))
        self.add_item(QuestAnnounceRoleSelect(self))
        self.add_item(AddGMRoleSelect(self))
        self.add_item(self.quest_announce_role_remove_button)
        self.add_item(self.gm_role_remove_button)
        self.add_item(ConfigBackButton(ConfigBaseView, guild_id, gdb))

    async def query_role(self, role_type):
        try:
            collection = self.gdb[role_type]

            query = await collection.find_one({'_id': self.guild_id})
            if not query:
                return None
            else:
                return query[role_type]
        except Exception as e:
            await log_exception(e)

    async def setup_embed(self):
        try:
            announcement_role = await self.query_role('announceRole')
            gm_roles = await self.query_role('gmRoles')

            if not announcement_role:
                announcement_role_string = 'Not Configured'
                self.quest_announce_role_remove_button.disabled = True
            else:
                announcement_role_string = f'{announcement_role}'
                self.quest_announce_role_remove_button.disabled = False
            if not gm_roles:
                gm_roles_string = 'Not Configured'
                self.gm_role_remove_button.disabled = True
            else:
                role_mentions = []
                for role in gm_roles:
                    role_mentions.append(role['mention'])

                gm_roles_string = f'- {'\n- '.join(role_mentions)}'
                self.gm_role_remove_button.disabled = False

            self.embed.clear_fields()
            self.embed.add_field(name='Announcement Role', value=announcement_role_string)
            self.embed.add_field(name='GM Roles', value=gm_roles_string)
        except Exception as e:
            await log_exception(e)


class ConfigGMRoleRemoveView(discord.ui.View):
    def __init__(self, guild_id, gdb):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Server Configuration - Remove GM Role(s)',
            description='Select roles from the dropdown below to remove from GM status.\n\n'
                        '-----',
            type='rich'
        )
        self.guild_id = guild_id
        self.gdb = gdb
        self.gm_role_remove_select = GMRoleRemoveSelect(self)
        self.add_item(self.gm_role_remove_select)
        self.add_item(ConfigBackButton(ConfigRolesView, guild_id, gdb))

    async def setup_embed(self):
        try:
            collection = self.gdb['gmRoles']
            query = await collection.find_one({'_id': self.guild_id})
            gm_roles = query['gmRoles']
            role_mentions = []
            for role in gm_roles:
                role_mentions.append(role['mention'])

            self.embed.clear_fields()
            self.embed.add_field(name='Current GM Roles', value=f'- {'\n- '.join(role_mentions)}')
        except Exception as e:
            await log_exception(e)

    async def setup_select(self):
        try:
            self.gm_role_remove_select.options.clear()
            collection = self.gdb['gmRoles']
            query = await collection.find_one({'_id': self.guild_id})
            options = []
            for result in query['gmRoles']:
                name = result['name']
                options.append(discord.SelectOption(label=name, value=name))

            logger.info(f'Options: {options}')
            self.gm_role_remove_select.options = options
        except Exception as e:
            await log_exception(e)


class ConfigChannelsView(discord.ui.View):
    def __init__(self, guild_id, gdb):
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
        self.guild_id = guild_id
        self.gdb = gdb
        self.add_item(SingleChannelConfigSelect(self,
                                                config_type='questChannel',
                                                config_name='Quest Board',
                                                guild_id=guild_id,
                                                gdb=gdb))
        self.add_item(SingleChannelConfigSelect(self,
                                                config_type='playerBoardChannel',
                                                config_name='Player Board',
                                                guild_id=guild_id,
                                                gdb=gdb))
        self.add_item(SingleChannelConfigSelect(self,
                                                config_type='archiveChannel',
                                                config_name='Quest Archive',
                                                guild_id=guild_id,
                                                gdb=gdb))
        self.add_item(ConfigBackButton(ConfigBaseView, guild_id, gdb))

    async def query_channel(self, channel_type):
        try:
            collection = self.gdb[channel_type]

            query = await collection.find_one({'_id': self.guild_id})
            logger.info(f'{channel_type} query: {query}')
            if not query:
                return 'Not Configured'
            else:
                return query[channel_type]
        except Exception as e:
            await log_exception(e)

    async def setup_embed(self):
        try:
            player_board = await self.query_channel('playerBoardChannel')
            quest_board = await self.query_channel('questChannel')
            quest_archive = await self.query_channel('archiveChannel')

            self.embed.clear_fields()
            self.embed.add_field(name='Quest Board', value=quest_board, inline=False)
            self.embed.add_field(name='Player Board', value=player_board, inline=False)
            self.embed.add_field(name='Quest Archive', value=quest_archive, inline=False)
        except Exception as e:
            await log_exception(e)


class ConfigQuestsView(discord.ui.View):
    def __init__(self, guild_id, gdb):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Server Configuration - Quests',
            description=(
                '__**Quest Summary**__\n'
                'This option enables GMs to provide a short summary block when closing out quests.\n\n'
                '__**Quest Wait List**__\n'
                'This option enables the specified number of players to queue for a quest, in case a player drops.\n\n'
                '-----'
            ),
            type='rich'
        )
        self.guild_id = guild_id
        self.gdb = gdb
        self.add_item(ConfigWaitListSelect(self))
        self.add_item(QuestSummaryToggleButton(self))
        self.add_item(ConfigBackButton(ConfigBaseView, guild_id, gdb))

    async def query_quest_config(self, config_type):
        try:
            collection = self.gdb[config_type]

            query = await collection.find_one({'_id': self.guild_id})
            logger.info(f'{config_type} query: {query}')
            if not query:
                return 'Not Configured'
            else:
                return query[config_type]
        except Exception as e:
            await log_exception(e)

    async def setup_embed(self):
        try:
            quest_summary = await self.query_quest_config('questSummary')
            wait_list = await self.query_quest_config('questWaitList')

            self.embed.clear_fields()
            self.embed.add_field(name='Quest Summary Enabled', value=quest_summary, inline=False)
            self.embed.add_field(name='Quest Wait List', value=wait_list, inline=False)
        except Exception as e:
            await log_exception(e)


class ConfigPlayersView(discord.ui.View):
    def __init__(self, guild_id, gdb):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Server Configuration - Players',
            description=(
                '__**Experience**__\n'
                'Enables/Disables the use of experience points (or similar value-based character progression).\n\n'
                '-----'
            ),
            type='rich'
        )
        self.guild_id = guild_id
        self.gdb = gdb
        self.add_item(PlayerExperienceToggleButton(self))
        self.add_item(ConfigBackButton(ConfigBaseView, guild_id, gdb))

    async def query_player_config(self, config_type):
        try:
            collection = self.gdb[config_type]

            query = await collection.find_one({'_id': self.guild_id})
            logger.info(f'{config_type} query: {query}')
            if not query:
                return 'Not Configured'
            else:
                return query[config_type]
        except Exception as e:
            await log_exception(e)

    async def setup_embed(self):
        try:
            player_experience = await self.query_player_config('playerExperience')

            self.embed.clear_fields()
            self.embed.add_field(name='Player Experience Enabled', value=player_experience, inline=False)
        except Exception as e:
            await log_exception(e)


class ConfigRemoveDenominationView(discord.ui.View):
    def __init__(self, guild_id, gdb, calling_view):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title=f'Server Configuration - Remove Denomination',
            description='Select a denomination to remove.',
            type='rich'
        )
        self.guild_id = guild_id
        self.gdb = gdb
        self.calling_view = calling_view
        self.selected_denomination_name = None
        self.remove_denomination_select = RemoveDenominationSelect(self)
        self.remove_denomination_confirm_button = RemoveDenominationConfirmButton(self)
        self.add_item(self.remove_denomination_select)
        self.add_item(self.remove_denomination_confirm_button)
        self.add_item(ConfigBackButton(ConfigEditCurrencyView, guild_id, gdb, setup_embed=False))

    async def setup_select(self):
        try:
            currency_name = self.calling_view.selected_currency_name
            self.remove_denomination_select.options.clear()
            collection = self.gdb['currency']
            query = await collection.find_one({'_id': self.guild_id, 'currencies.name': currency_name})
            currency = next((item for item in query['currencies'] if item['name'] == currency_name), None)
            logger.info(f'Found Currency: {currency}')
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
        except Exception as e:
            await log_exception(e)

    async def setup_embed(self):
        try:
            self.embed.clear_fields()
            self.embed.add_field(name=f'Deleting {self.selected_denomination_name}',
                                 value='Confirm?')
        except Exception as e:
            await log_exception(e)

    async def remove_currency_denomination(self, denomination_name):
        try:
            collection = self.gdb['currency']
            currency_name = self.calling_view.selected_currency_name
            await collection.update_one({'_id': self.guild_id, 'currencies.name': currency_name},
                                        {'$pull': {'currencies.$.denominations': {'name': denomination_name}}})
        except Exception as e:
            await log_exception(e)


class ConfigEditCurrencyView(discord.ui.View):
    def __init__(self, guild_id, gdb):
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
        self.guild_id = guild_id
        self.gdb = gdb
        # TODO: Implement (self.collection = self.gdb['currency']) in classes instead of every function
        self.selected_currency_name = None
        self.remove_denomination_view = ConfigRemoveDenominationView(self.guild_id, self.gdb, self)
        self.edit_currency_select = EditCurrencySelect(self)
        self.toggle_double_button = ToggleDoubleButton(self)
        self.add_denomination_button = AddDenominationButton(self)
        self.remove_denomination_button = RemoveDenominationButton(self.remove_denomination_view)
        self.add_item(self.edit_currency_select)
        self.add_item(self.toggle_double_button)
        self.add_item(self.add_denomination_button)
        self.add_item(self.remove_denomination_button)
        self.add_item(ConfigBackButton(ConfigCurrencyView, guild_id, gdb))

    async def setup_embed(self, currency_name):
        try:
            collection = self.gdb['currency']
            query = await collection.find_one({'_id': self.guild_id, 'currencies.name': currency_name})
            currency = next((item for item in query['currencies'] if item['name'] == currency_name), None)
            logger.info(f'Found currency: {currency}')
            self.embed.clear_fields()
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

            self.embed.add_field(name=f'{currency_name}',
                                 value=f'__Display:__ {display}\n'
                                       f'__Denominations__:\n- {denominations_string}',
                                 inline=True)
        except Exception as e:
            await log_exception(e)

    async def setup_select(self):
        try:
            self.edit_currency_select.options.clear()

            collection = self.gdb['currency']
            query = await collection.find_one({'_id': self.guild_id})
            for currency in query['currencies']:
                name = currency['name']
                self.edit_currency_select.options.append(discord.SelectOption(label=name, value=name))
        except Exception as e:
            await log_exception(e)


class ConfigCurrencyView(discord.ui.View):
    def __init__(self, guild_id, gdb):
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
        self.guild_id = guild_id
        self.gdb = gdb
        self.edit_currency_button = EditCurrencyButton(ConfigEditCurrencyView(guild_id=self.guild_id, gdb=self.gdb))
        self.remove_currency_button = RemoveCurrencyButton(RemoveCurrencyView(guild_id=self.guild_id, gdb=self.gdb))
        self.add_item(AddCurrencyButton(self))
        self.add_item(self.edit_currency_button)
        self.add_item(self.remove_currency_button)
        self.add_item(ConfigBackButton(ConfigBaseView, guild_id, gdb))

    async def setup_embed(self):
        try:
            self.embed.clear_fields()
            collection = self.gdb['currency']
            query = await collection.find_one({'_id': self.guild_id})
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


class RemoveCurrencyView(discord.ui.View):
    def __init__(self, guild_id, gdb):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Server Configuration - Remove Currency',
            description='Select a currency to remove',
            type='rich'
        )
        self.guild_id = guild_id
        self.gdb = gdb
        self.remove_currency_select = RemoveCurrencySelect(self)
        self.remove_currency_confirm_button = RemoveCurrencyConfirmButton(self)
        self.add_item(self.remove_currency_select)
        self.add_item(self.remove_currency_confirm_button)
        self.add_item(ConfigBackButton(ConfigCurrencyView, guild_id, gdb))
        self.selected_currency = None

    async def setup_embed(self):
        try:
            self.embed.clear_fields()
            self.embed.add_field(name=f'Deleting {self.selected_currency}',
                                 value='Confirm?')
        except Exception as e:
            await log_exception(e)

    async def setup_select(self):
        try:
            self.remove_currency_select.options.clear()
            collection = self.gdb['currency']
            query = await collection.find_one({'_id': self.guild_id})
            currencies = query['currencies']
            if len(currencies) > 0:
                for currency in currencies:
                    name = currency['name']
                    option = discord.SelectOption(label=name, value=name)
                    self.remove_currency_select.options.append(option)
            else:
                self.remove_currency_select.options.append(discord.SelectOption(label='None', value='None'))
                self.remove_currency_select.placeholder = 'There are no remaining currencies on this server!'
                self.remove_currency_select.disabled = True
        except Exception as e:
            await log_exception(e)

    async def remove_currency(self, currency_name):
        try:
            collection = self.gdb['currency']
            await collection.update_one({'_id': self.guild_id, 'currencies.name': currency_name},
                                        {'$pull': {'currencies': {'name': currency_name}}}, upsert=True)
        except Exception as e:
            await log_exception(e)


class AdminBaseView(discord.ui.View):
    def __init__(self, cdb, bot):
        super().__init__(timeout=None)
        self.cdb = cdb
        self.bot = bot
        self.embed = discord.Embed(
            title='Administrative - Main Menu',
            description=(
                '__**Allowlist**__\n'
                'Configures the server allowlist for invite restrictions.'
            ),
            type='rich'
        )
        self.add_item(AdminMenuButton(AdminAllowlistView, 'Allowlist', self.cdb, self.bot, setup_embed=False))
        self.add_item(AdminMenuButton(AdminCogView, 'Cogs', self.cdb, self.bot,
                                      setup_select=False, setup_embed=False))
        self.add_item(AdminShutdownButton(bot, self))
        self.add_item(MenuDoneButton())


class AdminAllowlistView(discord.ui.View):
    def __init__(self, cdb, bot):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Administration - Server Allowlist',
            description=('__**Add New Server**__\n'
                         'Adds a new Discord Server ID to the allowlist.\n'
                         '**WARNING: There is no way to verify the server ID provided is valid without the bot being a'
                         'server member. Double-check your inputs!**\n\n'
                         '__**Remove**__\n'
                         'Removes the selected Discord Server from the allowlist.\n\n'),
            type='rich'
        )
        self.bot = bot
        self.cdb = cdb
        self.selected_guild = None
        self.remove_guild_allowlist_select = RemoveGuildAllowlistSelect(self)
        self.confirm_allowlist_remove_button = ConfirmAllowlistRemoveButton(self)
        self.add_item(self.remove_guild_allowlist_select)
        self.add_item(AllowlistAddServerButton(self))
        self.add_item(self.confirm_allowlist_remove_button)
        self.add_item(AdminBackButton(AdminBaseView, cdb, bot))

    async def setup_select(self):
        try:
            self.remove_guild_allowlist_select.options.clear()
            collection = self.cdb['serverAllowlist']
            query = await collection.find_one()
            if len(query['servers']) > 0:
                for server in query['servers']:
                    option = discord.SelectOption(label=server['name'], value=server['id'])
                    self.remove_guild_allowlist_select.options.append(option)
            else:
                option = discord.SelectOption(label='There are no servers in the allowlist', value='None')
                self.remove_guild_allowlist_select.options.append(option)
                self.remove_guild_allowlist_select.placeholder = 'There are no servers in the allowlist'
                self.remove_guild_allowlist_select.disabled = True
        except Exception as e:
            await log_exception(e)


class AdminCogView(discord.ui.View):
    def __init__(self, cdb, bot):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Administration - Cogs',
            description=(
                '__**Load**__\n'
                'Loads a cog by name. File must be named `<name>.py` and stored in ReQuest\\cogs\\\n\n'
                '__**Reload**__\n'
                'Reloads a loaded cog by name. Same naming and file path restrictions apply.'
            ),
            type='rich'
        )
        self.bot = bot
        self.add_item(AdminLoadCogButton())
        self.add_item(AdminReloadCogButton())
        self.add_item(AdminBackButton(AdminBaseView, cdb, bot))


class InventoryBaseView(discord.ui.View):
    def __init__(self, mdb, bot, member_id, guild_id):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Player Commands - Inventory',
            description=(
                '__**View**__\n'
                'Displays your inventory.\n\n'
                '__**Spend Currency**__\n'
                'Spend some currency.\n\n'
                '__**Trade**__\n'
                'Sends an item or currency to another character. Trading is now handled as a User Context command. '
                'Right-click or long-press another user and select Apps -> Trade\n\n'
                '------\n\n'
            ),
            type='rich'
        )
        self.mdb = mdb
        self.bot = bot
        self.member_id = member_id
        self.guild_id = guild_id
        self.active_character = None
        self.view_inventory_button = ViewInventoryButton(self)
        self.spend_currency_button = SpendCurrencyButton(self)
        self.add_item(self.view_inventory_button)
        self.add_item(self.spend_currency_button)
        self.add_item(PlayerBackButton(PlayerBaseView, mdb, bot, member_id, guild_id))

    async def setup_embed(self):
        self.embed.clear_fields()
        collection = self.mdb['characters']
        query = await collection.find_one({'_id': self.member_id})
        if not query:
            self.view_inventory_button.disabled = True
            self.spend_currency_button.disabled = True
            self.embed.add_field(name='No Characters', value='Register a character to use these menus.')
        elif str(self.guild_id) not in query['activeCharacters']:
            self.view_inventory_button.disabled = True
            self.spend_currency_button.disabled = True
            self.embed.add_field(name='No Active Character', value='Activate a character for this server to use these'
                                                                   'menus.')
        else:
            active_character_id = query['activeCharacters'][str(self.guild_id)]
            self.active_character = query['characters'][active_character_id]
            self.embed.title = f'Player Commands - {self.active_character['name']}\'s Inventory'
