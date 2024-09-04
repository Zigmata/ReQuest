import asyncio
import logging

import discord
import shortuuid

import ReQuest.ui.buttons as buttons
import ReQuest.ui.selects as selects
from ReQuest.utilities.supportFunctions import (
    log_exception,
    strip_id,
    update_character_inventory,
    update_character_experience,
    attempt_delete,
    update_quest_embed,
    find_character_in_lists
)

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class PlayerBaseView(discord.ui.View):
    def __init__(self):
        super().__init__()
        self.embed = discord.Embed(
            title='Player Commands - Main Menu',
            description=(
                '__**Characters**__\n'
                'Register, view, and activate player characters.\n\n'
                '__**Inventory**__\n'
                'View your active character\'s inventory, spend currency, and trade with other players.\n\n'
                '__**Player Board**__\n'
                'Create a post for the Player Board, if configured on your server.\n\n'
            ),
            type='rich'
        )

    async def setup(self, bot, guild):
        try:
            self.add_item(buttons.MenuViewButton(
                target_view_class=CharacterBaseView,
                label='Characters',
            ))
            self.add_item(buttons.MenuViewButton(
                target_view_class=InventoryBaseView,
                label='Inventory',
            ))
            channel_collection = bot.gdb['playerBoardChannel']
            channel_query = await channel_collection.find_one({'_id': guild.id})
            if channel_query:
                player_board_button = buttons.MenuViewButton(
                    target_view_class=PlayerBoardView,
                    label='Player Board'
                )
                self.add_item(player_board_button)

            self.add_item(buttons.MenuDoneButton())
        except Exception as e:
            await log_exception(e)


class CharacterBaseView(discord.ui.View):
    def __init__(self):
        super().__init__(timeout=None)
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
        self.add_item(buttons.RegisterCharacterButton())
        self.add_item(buttons.MenuViewButton(ListCharactersView, 'List/Activate'))
        self.add_item(buttons.MenuViewButton(RemoveCharacterView, 'Remove'))
        self.add_item(buttons.BackButton(PlayerBaseView()))


class ListCharactersView(discord.ui.View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Player Commands - List Characters',
            description='Registered Characters are listed below. Select a character from the dropdown to activate '
                        'that character for this server.',
            type='rich'
        )
        self.active_character_select = selects.ActiveCharacterSelect(self)
        self.add_item(self.active_character_select)
        self.add_item(buttons.BackButton(CharacterBaseView()))

    async def setup(self, bot, user, guild):
        try:
            self.embed.clear_fields()
            collection = bot.mdb['characters']
            query = await collection.find_one({'_id': user.id})
            if not query or not query['characters']:
                self.embed.description = 'You have no registered characters!'
            else:
                ids = []
                for character_id in query['characters']:
                    ids.append(character_id)
                for character_id in ids:
                    character = query['characters'][character_id]
                    if (str(guild.id) in query['activeCharacters']
                            and character_id == query['activeCharacters'][str(guild.id)]):
                        character_info = (f'{character['name']}: {character['attributes']['experience']} XP '
                                          f'(Active Character)')
                    else:
                        character_info = f'{character['name']}: {character['attributes']['experience']} XP'
                    self.embed.add_field(name=character_info, value=character['note'], inline=False)

            self.active_character_select.options.clear()
            options = []
            collection = bot.mdb['characters']
            query = await collection.find_one({'_id': user.id})
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
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Player Commands - Remove Character',
            description='Select a character from the dropdown. Confirm to permanently remove that character.',
            type='rich'
        )
        self.selected_character_id = None
        self.confirm_button = buttons.ConfirmButton(self)
        self.remove_character_select = selects.RemoveCharacterSelect(self, self.confirm_button)
        self.add_item(self.remove_character_select)
        self.add_item(self.confirm_button)
        self.add_item(buttons.BackButton(CharacterBaseView()))

    async def setup(self, bot, user):
        try:
            self.remove_character_select.options.clear()
            options = []
            collection = bot.mdb['characters']
            query = await collection.find_one({'_id': user.id})
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

    async def confirm_callback(self, interaction):
        try:
            selected_character_id = self.selected_character_id
            collection = interaction.client.mdb['characters']
            member_id = interaction.user.id
            query = await collection.find_one({'_id': member_id})
            await collection.update_one({'_id': member_id},
                                        {'$unset': {f'characters.{selected_character_id}': ''}}, upsert=True)
            for guild in query['activeCharacters']:
                if query['activeCharacters'][guild] == selected_character_id:
                    await collection.update_one({'_id': member_id},
                                                {'$unset': {f'activeCharacters.{interaction.guild_id}': ''}},
                                                upsert=True)
            self.selected_character_id = None
            await self.setup(bot=interaction.client, user=interaction.user)
            self.embed.clear_fields()
            self.confirm_button.disabled = True
            self.confirm_button.label = 'Confirm'
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)


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
        self.add_item(buttons.ConfigMenuButton(ConfigRolesView, 'Roles', guild_id, gdb))
        self.add_item(buttons.ConfigMenuButton(ConfigChannelsView, 'Channels', guild_id, gdb))
        self.add_item(buttons.ConfigMenuButton(ConfigQuestsView, 'Quests', guild_id, gdb))
        self.add_item(buttons.ConfigMenuButton(ConfigPlayersView, 'Players', guild_id, gdb))
        self.add_item(buttons.ConfigMenuButton(ConfigCurrencyView, 'Currency', guild_id, gdb))
        self.add_item(buttons.MenuDoneButton())


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
                '__**Forbidden Roles**__\n'
                'Configures a list of role names that cannot be used by Game Masters for their party roles. By '
                'default, `everyone`, `administrator`, `gm`, and `game master` cannot be used. This configuration '
                'extends that list.\n\n'
                '-----'
            ),
            type='rich'
        )
        self.guild_id = guild_id
        self.gdb = gdb
        self.quest_announce_role_remove_button = buttons.QuestAnnounceRoleRemoveButton(self)
        self.gm_role_remove_button = buttons.GMRoleRemoveButton(ConfigGMRoleRemoveView(self.guild_id, self.gdb))
        self.forbidden_roles_button = buttons.ForbiddenRolesButton(self)
        self.add_item(selects.QuestAnnounceRoleSelect(self))
        self.add_item(selects.AddGMRoleSelect(self))
        self.add_item(self.quest_announce_role_remove_button)
        self.add_item(self.gm_role_remove_button)
        self.add_item(self.forbidden_roles_button)
        self.add_item(buttons.ConfigBackButton(ConfigBaseView, guild_id, gdb))

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
        self.gm_role_remove_select = selects.GMRoleRemoveSelect(self)
        self.add_item(self.gm_role_remove_select)
        self.add_item(buttons.ConfigBackButton(ConfigRolesView, guild_id, gdb))

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

            logger.debug(f'Options: {options}')
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
        self.clear_channels_button = buttons.ClearChannelsButton(self)
        self.quest_channel_select = selects.SingleChannelConfigSelect(
            self,
            config_type='questChannel',
            config_name='Quest Board',
            guild_id=guild_id,
            gdb=gdb
        )
        self.player_board_channel_select = selects.SingleChannelConfigSelect(
            self,
            config_type='playerBoardChannel',
            config_name='Player Board',
            guild_id=guild_id,
            gdb=gdb
        )
        self.archive_channel_select = selects.SingleChannelConfigSelect(
            self,
            config_type='archiveChannel',
            config_name='Quest Archive',
            guild_id=guild_id,
            gdb=gdb
        )
        self.add_item(self.quest_channel_select)
        self.add_item(self.player_board_channel_select)
        self.add_item(self.archive_channel_select)
        self.add_item(self.clear_channels_button)
        self.add_item(buttons.ConfigBackButton(ConfigBaseView, guild_id, gdb))

    async def query_channel(self, channel_type):
        try:
            collection = self.gdb[channel_type]

            query = await collection.find_one({'_id': self.guild_id})
            logger.debug(f'{channel_type} query: {query}')
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
        self.add_item(selects.ConfigWaitListSelect(self))
        self.add_item(buttons.QuestSummaryToggleButton(self))
        self.add_item(buttons.ConfigBackButton(ConfigBaseView, guild_id, gdb))

    async def query_quest_config(self, config_type):
        try:
            collection = self.gdb[config_type]

            query = await collection.find_one({'_id': self.guild_id})
            logger.debug(f'{config_type} query: {query}')
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
                '__**Player Board Purge**__\n'
                'Purges posts from the player board (if enabled).\n\n'
                '-----'
            ),
            type='rich'
        )
        self.guild_id = guild_id
        self.gdb = gdb
        self.player_board_purge_button = buttons.PlayerBoardPurgeButton(self)
        self.add_item(buttons.PlayerExperienceToggleButton(self))
        self.add_item(self.player_board_purge_button)
        self.add_item(buttons.ConfigBackButton(ConfigBaseView, guild_id, gdb))

    async def query_player_config(self, config_type):
        try:
            collection = self.gdb[config_type]

            query = await collection.find_one({'_id': self.guild_id})
            logger.debug(f'{config_type} query: {query}')
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
        self.remove_denomination_select = selects.RemoveDenominationSelect(self)
        self.remove_denomination_confirm_button = buttons.RemoveDenominationConfirmButton(self)
        self.add_item(self.remove_denomination_select)
        self.add_item(self.remove_denomination_confirm_button)
        self.add_item(buttons.ConfigBackButton(ConfigEditCurrencyView, guild_id, gdb, setup_embed=False))

    async def setup_select(self):
        try:
            currency_name = self.calling_view.selected_currency_name
            self.remove_denomination_select.options.clear()
            collection = self.gdb['currency']
            query = await collection.find_one({'_id': self.guild_id, 'currencies.name': currency_name})
            currency = next((item for item in query['currencies'] if item['name'] == currency_name), None)
            logger.debug(f'Found Currency: {currency}')
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
        self.selected_currency_name = None
        self.remove_denomination_view = ConfigRemoveDenominationView(self.guild_id, self.gdb, self)
        self.edit_currency_select = selects.EditCurrencySelect(self)
        self.toggle_double_button = buttons.ToggleDoubleButton(self)
        self.add_denomination_button = buttons.AddDenominationButton(self)
        self.remove_denomination_button = buttons.RemoveDenominationButton(self.remove_denomination_view)
        self.add_item(self.edit_currency_select)
        self.add_item(self.toggle_double_button)
        self.add_item(self.add_denomination_button)
        self.add_item(self.remove_denomination_button)
        self.add_item(buttons.ConfigBackButton(ConfigCurrencyView, guild_id, gdb))

    async def setup_embed(self, currency_name):
        try:
            collection = self.gdb['currency']
            query = await collection.find_one({'_id': self.guild_id, 'currencies.name': currency_name})
            currency = next((item for item in query['currencies'] if item['name'] == currency_name), None)
            logger.debug(f'Found currency: {currency}')
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
        self.edit_currency_button = buttons.EditCurrencyButton(ConfigEditCurrencyView(guild_id=self.guild_id,
                                                                                      gdb=self.gdb))
        self.remove_currency_button = buttons.RemoveCurrencyButton(RemoveCurrencyView(guild_id=self.guild_id,
                                                                                      gdb=self.gdb))
        self.add_item(buttons.AddCurrencyButton(self))
        self.add_item(self.edit_currency_button)
        self.add_item(self.remove_currency_button)
        self.add_item(buttons.ConfigBackButton(ConfigBaseView, guild_id, gdb))

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
        self.remove_currency_select = selects.RemoveCurrencySelect(self)
        self.remove_currency_confirm_button = buttons.RemoveCurrencyConfirmButton(self)
        self.add_item(self.remove_currency_select)
        self.add_item(self.remove_currency_confirm_button)
        self.add_item(buttons.ConfigBackButton(ConfigCurrencyView, guild_id, gdb))
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
        self.add_item(buttons.AdminMenuButton(AdminAllowlistView, 'Allowlist', self.cdb, self.bot, setup_embed=False))
        self.add_item(buttons.AdminMenuButton(AdminCogView, 'Cogs', self.cdb, self.bot,
                                              setup_select=False, setup_embed=False))
        self.add_item(buttons.AdminShutdownButton(bot, self))
        self.add_item(buttons.MenuDoneButton())


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
        self.remove_guild_allowlist_select = selects.RemoveGuildAllowlistSelect(self)
        self.confirm_allowlist_remove_button = buttons.ConfirmAllowlistRemoveButton(self)
        self.add_item(self.remove_guild_allowlist_select)
        self.add_item(buttons.AllowlistAddServerButton(self))
        self.add_item(self.confirm_allowlist_remove_button)
        self.add_item(buttons.AdminBackButton(AdminBaseView, cdb, bot))

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
        self.add_item(buttons.AdminLoadCogButton())
        self.add_item(buttons.AdminReloadCogButton())
        self.add_item(buttons.AdminBackButton(AdminBaseView, cdb, bot))


class InventoryBaseView(discord.ui.View):
    def __init__(self):
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
        self.active_character = None
        self.view_inventory_button = buttons.ViewInventoryButton(self)
        self.spend_currency_button = buttons.SpendCurrencyButton(self)
        self.add_item(self.view_inventory_button)
        self.add_item(self.spend_currency_button)
        self.add_item(buttons.BackButton(PlayerBaseView()))

    async def setup(self, bot, user, guild):
        self.embed.clear_fields()
        collection = bot.mdb['characters']
        query = await collection.find_one({'_id': user.id})
        if not query:
            self.view_inventory_button.disabled = True
            self.spend_currency_button.disabled = True
            self.embed.add_field(name='No Characters', value='Register a character to use these menus.')
        elif str(guild.id) not in query['activeCharacters']:
            self.view_inventory_button.disabled = True
            self.spend_currency_button.disabled = True
            self.embed.add_field(name='No Active Character', value='Activate a character for this server to use these'
                                                                   'menus.')
        else:
            active_character_id = query['activeCharacters'][str(guild.id)]
            self.active_character = query['characters'][active_character_id]
            self.embed.title = f'Player Commands - {self.active_character['name']}\'s Inventory'


# ---------- GM Views -----------------


class GMBaseView(discord.ui.View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Game Master - Main Menu',
            description=(
                '__**Quests**__\n'
                'Functions for creating, posting, and managing quests.\n\n'
                '__**Players**__\n'
                'Player management functions such as inventory, experience, and currency modifications.\n\n'
                '__**Configs**__\n'
                'Additional GM customizations for this server, such as player/questing roles.\n\n'
            ),
            type='rich'
        )
        self.gm_quest_menu_button = buttons.MenuViewButton(target_view_class=GMQuestMenuView, label='Quests')
        self.gm_config_menu_button = buttons.MenuViewButton(target_view_class=GMConfigMenuView, label='Configs',
                                                            setup_embed=True)
        self.gm_player_menu_button = buttons.MenuViewButton(target_view_class=GMPlayerMenuView, label='Players')
        self.add_item(self.gm_quest_menu_button)
        self.add_item(self.gm_config_menu_button)
        self.add_item(self.gm_player_menu_button)
        self.add_item(buttons.MenuDoneButton())


class GMQuestMenuView(discord.ui.View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Game Master - Quests',
            description=(
                '__**Create**__\n'
                'Create and post a new quest.\n\n'
                '__**Manage**__\n'
                'Manage an active quest: Rewards, edits, etc.\n\n'
                '__**Complete**__\n'
                'Complete an active quest. Issues rewards, if any, to party members.\n\n'
            ),
            type='rich'
        )
        self.create_quest_button = buttons.CreateQuestButton(QuestPostView)
        self.manage_quests_view_button = buttons.MenuViewButton(target_view_class=ManageQuestsView, label='Manage',
                                                                setup_select=True)
        self.complete_quests_button = buttons.MenuViewButton(target_view_class=CompleteQuestsView, label='Complete',
                                                             setup_select=True)
        self.add_item(self.create_quest_button)
        self.add_item(self.manage_quests_view_button)
        self.add_item(self.complete_quests_button)
        self.add_item(buttons.BackButton(GMBaseView()))


class ManageQuestsView(discord.ui.View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Game Master - Quest Management',
            description=(
                '__**Edit**__\n'
                'Edits quest fields such as title, party restrictions, party size, and description.\n\n'
                '__**Toggle Ready**__\n'
                'Toggles the ready state of the quest. A quest that is \"ready\" locks the signup roster, and assigns '
                'party roles to members (if configured).\n\n'
                '__**Rewards**__\n'
                'Configure rewards for quest completion, such as individual loot, or group experience.\n\n'
                '__**Remove Player**__\n'
                'Removes a player from the active roster. If there is a waitlist, the highest in the queue will '
                'autofill the open spot.\n\n'
                '__**Cancel**__\n'
                'Cancels a quest, deleting it from the database and the quest channel.\n\n'
                '------\n\n'
            ),
            type='rich'
        )
        self.selected_quest = None
        self.quests = None
        self.manage_quest_select = selects.ManageQuestSelect(self)
        self.edit_quest_button = buttons.EditQuestButton(self, QuestPostView)
        self.toggle_ready_button = buttons.ToggleReadyButton(self)
        self.rewards_menu_button = buttons.RewardsMenuButton(self, RewardsMenuView)
        self.remove_player_button = buttons.RemovePlayerButton(self, RemovePlayerView)
        self.cancel_quest_button = buttons.CancelQuestButton(self, CancelQuestView)
        self.add_item(self.manage_quest_select)
        self.add_item(self.edit_quest_button)
        self.add_item(self.toggle_ready_button)
        self.add_item(self.rewards_menu_button)
        self.add_item(self.remove_player_button)
        self.add_item(self.cancel_quest_button)
        self.add_item(buttons.BackButton(GMQuestMenuView()))

    async def setup(self, bot, user, guild):
        try:
            self.embed.clear_fields()

            quest_collection = bot.gdb['quests']
            options = []
            quests = []

            # Check to see if the user has guild admin privileges. This lets them edit any quest in the guild.
            if user.guild_permissions.manage_guild:
                quest_query = quest_collection.find({'guildId': guild.id})
            else:
                quest_query = quest_collection.find({'guildId': guild.id, 'gm': user.id})

            async for document in quest_query:
                quests.append(dict(document))

            if len(quests) > 0:
                for quest in quests:
                    options.append(discord.SelectOption(label=f'{quest['questId']}: {quest['title']}',
                                                        value=quest['questId']))
                self.quests = quests
                logger.debug(f'Found {len(quests)} quests.')
                self.manage_quest_select.disabled = False
            else:
                options.append(discord.SelectOption(label='No quests were found, or you do not have permissions to edit'
                                                          ' them.', value='None'))
                self.manage_quest_select.disabled = True
                self.embed.add_field(name='No Quests Available', value='No quests were found, or you do not have '
                                                                       'permissions to edit them.')
            self.manage_quest_select.options = options
        except Exception as e:
            await log_exception(e)

    async def quest_ready_toggle(self, interaction):
        try:
            quest = self.selected_quest
            guild_id = interaction.guild_id
            user_id = interaction.user.id
            guild = interaction.client.get_guild(guild_id)

            # Fetch the quest channel to retrieve the message object
            channel_collection = interaction.client.gdb['questChannel']
            channel_id_query = await channel_collection.find_one({'_id': guild_id})
            if not channel_id_query:
                raise Exception('Quest channel has not been set!')
            channel_id = strip_id(channel_id_query['questChannel'])
            channel = interaction.client.get_channel(channel_id)

            # Retrieve the message object
            message_id = quest['messageId']
            message = channel.get_partial_message(message_id)

            # Check to see if the GM has a party role configured
            role_collection = interaction.client.gdb['partyRole']
            role_query = await role_collection.find_one({'guildId': guild_id, 'gm': user_id})
            role = None
            if role_query and role_query['roleId']:
                role_id = role_query['roleId']
                role = guild.get_role(role_id)

            party = quest['party']
            title = quest['title']
            quest_id = quest['questId']
            tasks = []

            # Locks the quest roster and alerts party members that the quest is ready.
            quest_collection = interaction.client.gdb['quests']
            if not quest['lockState']:
                await quest_collection.update_one({'questId': quest_id}, {'$set': {'lockState': True}})

                # Fetch the updated quest
                updated_quest = await quest_collection.find_one({'questId': quest_id})

                # Notify each party member that the quest is ready
                for player in party:
                    for key in player:
                        member = guild.get_member(int(key))
                        # If the GM has a party role configured, assign it to each party member
                        if role:
                            tasks.append(member.add_roles(role))
                        tasks.append(member.send(f'Game Master <@{user_id}> has marked your quest, **"{title}"**, '
                                                 f'ready to start!'))

                await interaction.user.send('Quest roster locked and party notified!')
            # Unlocks a quest if members are not ready.
            else:
                # Remove the role from the players
                if role:
                    for player in party:
                        for key in player:
                            member = guild.get_member(int(key))
                            tasks.append(member.remove_roles(role))

                # Unlock the quest
                await quest_collection.update_one({'questId': quest_id}, {'$set': {'lockState': False}})

                # Fetch the updated quest
                updated_quest = await quest_collection.find_one({'questId': quest_id})

                await interaction.user.send('Quest roster has been unlocked.')

            if len(tasks) > 0:
                await asyncio.gather(*tasks)

            self.selected_quest = updated_quest

            # Create a fresh quest view, and update the original post message
            quest_view = QuestPostView(updated_quest)
            await quest_view.setup_embed()
            await message.edit(embed=quest_view.embed, view=quest_view)

            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)


class RewardsMenuView(discord.ui.View):
    def __init__(self, calling_view, bot, guild_id):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='',
            description=(
                '__**Party Rewards**__\n'
                'Assigns experience and/or currency rewards to be split evenly across all party members.\n\n'
                '__**Individual Rewards**__\n'
                'Assigns additional bonus rewards for the selected party member.\n\n'
                '**How To Input Rewards**\n\n'
                '> Experience Points\n'
                '- Input the total amount of experience to award. New values will override the old.\n\n'
                '> Items/Currency\n'
                '- New item names will be added to the existing list.\n'
                '- Items with the same name will overwrite the previous quantity with the new one.\n'
                '- Note the {name}: {quantity} format in the placeholder text.\n'
                '- A value of \"None\" will reset the item list.\n'
                '- Item/Currency names are case-insensitive, so \"gOLd\" == \"Gold\"\n\n'
                '------'
            ),
            type='rich'
        )
        self.bot = bot
        self.calling_view = calling_view
        self.quest = calling_view.selected_quest
        self.guild_id = guild_id
        self.selected_character = None
        self.selected_character_id = None
        self.individual_rewards_button = buttons.IndividualRewardsButton(self)
        self.party_rewards_button = buttons.PartyRewardsButton(self)
        self.party_member_select = selects.PartyMemberSelect(calling_view=self,
                                                             disabled_components=[self.individual_rewards_button])
        back_button = buttons.MenuViewButton(target_view_class=ManageQuestsView, label='Back', setup_select=True,
                                             setup_embed=True)
        self.add_item(self.party_member_select)
        self.add_item(self.party_rewards_button)
        self.add_item(self.individual_rewards_button)
        self.add_item(back_button)

    async def setup_select(self):
        try:
            quest = self.quest
            party = quest['party']
            options = []

            if len(party) > 0:
                for player in party:
                    for member_id in player:
                        for character_id in player[str(member_id)]:
                            character = player[str(member_id)][str(character_id)]
                            options.append(discord.SelectOption(label=character['name'], value=character_id))
                self.party_member_select.placeholder = 'Select a party member'
                self.party_member_select.disabled = False
            else:
                options.append(discord.SelectOption(label='None', value='None'))
                self.party_member_select.placeholder = 'No party members'
                self.party_member_select.disabled = True

            self.party_member_select.options = options
        except Exception as e:
            await log_exception(e)

    async def setup_embed(self):
        try:
            self.embed.clear_fields()
            quest = self.calling_view.selected_quest
            self.embed.title = f'Quest Rewards - {quest['title']}'
            if 'party' in quest['rewards']:
                party_rewards = quest['rewards']['party']
                party_rewards_list = []
                if 'xp' in party_rewards and party_rewards['xp']:
                    party_rewards_list.append(f'Experience: {party_rewards['xp']}')
                if 'items' in party_rewards:
                    for item, quantity in party_rewards['items'].items():
                        party_rewards_list.append(f'{item.capitalize()}: {quantity}')
                party_rewards_string = '\n'.join(party_rewards_list)
                self.embed.add_field(name='Party Rewards',
                                     value=party_rewards_string if party_rewards_string else 'None')

            if self.selected_character:
                character_id = self.selected_character_id
                individual_rewards_list = []
                for key in quest['rewards']:
                    if key == character_id:
                        individual_rewards = quest['rewards'][character_id]
                        if 'xp' in individual_rewards and individual_rewards['xp']:
                            individual_rewards_list.append(f'Experience: {quest['rewards'][character_id]['xp']}')
                        for item, quantity in individual_rewards['items'].items():
                            individual_rewards_list.append(f'{item.capitalize()}: {quantity}')
                rewards_string = '\n'.join(individual_rewards_list)
                self.embed.add_field(name=f'Additional rewards for {self.selected_character['name']}',
                                     value=rewards_string if rewards_string else 'None',
                                     inline=False)
        except Exception as e:
            await log_exception(e)


class GMPlayerMenuView(discord.ui.View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Game Master - Player Management',
            description=(
                '__**Modifying Player Inventory/Experience**__\n'
                'This command is accessed through context menus. Right-click (desktop) or long-press (mobile) a player '
                'and choose Apps -> Modify Player to bring up the input modal.\n\n'
                '- Values entered will be added/subtracted from the player\'s current total.\n'
                '- To reduce a value, make sure you precede the amount/quantity with a `\'-\'`.\n'
                '- For items, put each item on a separate line and follow the `item: quantity` format in the '
                'placeholder text. Currency is treated as an item.\n\n'
            ),
            type='rich'
        )
        self.add_item(buttons.BackButton(GMBaseView()))


class GMConfigMenuView(discord.ui.View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Game Master - Configs',
            description=(
                '__**Party Role**__\n'
                'Use the buttons to create/delete a role that will be assigned to your players on active quests.\n\n'
                '------\n\n'
            ),
            type='rich'
        )
        self.create_party_role_button = buttons.CreatePartyRoleButton(self)
        self.remove_party_role_button = buttons.RemovePartyRoleButton(self)
        self.add_item(self.create_party_role_button)
        self.add_item(self.remove_party_role_button)
        self.add_item(buttons.BackButton(GMBaseView()))

    async def setup(self, bot, user, guild):
        self.embed.clear_fields()
        party_role_collection = bot.gdb['partyRole']
        party_role_query = await party_role_collection.find_one({'guildId': guild.id, 'gm': user.id})
        if party_role_query:
            role_id = party_role_query['roleId']
            self.embed.add_field(name='Configured Party Role', value=f'<@&{role_id}>')
            self.create_party_role_button.disabled = True
            self.remove_party_role_button.disabled = False
        else:
            self.create_party_role_button.disabled = False
            self.remove_party_role_button.disabled = True


class RemovePlayerView(discord.ui.View):
    def __init__(self, quest):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='',
            description=(
                'This action will remove the selected player, and fill the vacancy from a wait list, if '
                'applicable.\n\n'
                'Any individual rewards configured for the removed player will be removed from this quest. If you still'
                'want to reward the player for any contributions prior to removal, use the `GM --> Player` menus to '
                'directly issue rewards.'
            ),
            type='rich'
        )
        self.quest = quest
        self.selected_member_id = None
        self.selected_character_id = None
        self.remove_player_select = selects.RemovePlayerSelect(self)
        self.confirm_button = buttons.ConfirmButton(self)
        self.back_button = buttons.MenuViewButton(target_view_class=ManageQuestsView, label='Back', setup_select=True)
        self.add_item(self.remove_player_select)
        self.add_item(self.confirm_button)
        self.add_item(self.back_button)

    async def setup_select(self):
        try:
            options = []
            party = self.quest['party']
            wait_list = self.quest['waitList']
            for player in party:
                for member_id in player:
                    for character_id in player[str(member_id)]:
                        character = player[str(member_id)][str(character_id)]
                        options.append(discord.SelectOption(label=f'{character['name']}', value=member_id))
            for player in wait_list:
                for member_id in player:
                    for character_id in player[str(member_id)]:
                        character = player[str(member_id)][str(character_id)]
                        options.append(discord.SelectOption(label=f'{character['name']}', value=member_id))
            self.remove_player_select.options = options
        except Exception as e:
            await log_exception(e)

    async def setup_embed(self):
        try:
            self.embed.clear_fields()
            if self.selected_character_id:
                character = find_character_in_lists([self.quest['party'], self.quest['waitList']],
                                                    self.selected_member_id,
                                                    self.selected_character_id)

                self.embed.add_field(name='Selected Character', value=character['name'])
            else:
                self.embed.title = f'Select a player to remove from \"{self.quest['title']}\"'
        except Exception as e:
            await log_exception(e)

    async def confirm_callback(self, interaction):
        try:
            quest = self.quest
            (quest_id, message_id, title, gm, party,
             wait_list, max_wait_list_size, lock_state, rewards) = (quest['questId'], quest['messageId'],
                                                                    quest['title'], quest['gm'], quest['party'],
                                                                    quest['waitList'], quest['maxWaitListSize'],
                                                                    quest['lockState'], quest['rewards'])

            removed_member_id = self.selected_member_id
            guild_id = interaction.guild_id
            guild = interaction.guild
            member = guild.get_member(int(removed_member_id))

            # Fetch the quest channel to retrieve the message object
            channel_collection = interaction.client.gdb['questChannel']
            channel_id_query = await channel_collection.find_one({'_id': guild_id})
            channel_id = strip_id(channel_id_query['questChannel'])
            channel = interaction.client.get_channel(channel_id)
            message = channel.get_partial_message(message_id)

            quest_collection = interaction.client.gdb['quests']

            party_role_collection = interaction.client.gdb['partyRole']
            party_role_query = await party_role_collection.find_one({'guildId': guild_id, 'gm': gm})

            # If the quest list is locked and a party role exists, fetch the role.
            role = None
            if lock_state and party_role_query:
                role = guild.get_role(party_role_query['roleId'])

                # Remove the role from the member
                await member.remove_roles(role)

            removal_message = ''
            player_found = False
            # Check the wait list and remove the player if present
            for waiting_player in wait_list:
                if removed_member_id in waiting_player:
                    wait_list.remove(waiting_player)
                    player_found = True
                    removal_message = f'The Game Master for **{quest["title"]}** has removed you from the wait list.'
                    break

            # If they're not in the wait list, they must be in the party
            if not player_found:
                for player in party:
                    if removed_member_id in player:
                        removal_message = f'The Game Master for **{quest["title"]}** has removed you from the party.'
                        party.remove(player)

                        # If there is a wait list, promote the first entry into the party
                        if max_wait_list_size > 0 and len(wait_list) > 0:
                            new_player = wait_list.pop(0)
                            party.append(new_player)

                            for key in new_player:
                                new_member = guild.get_member(int(key))
                                await new_member.send(f'You have been added to the party for **{quest["title"]}**, '
                                                      f'due to a player dropping!')

                                # If a role is set, assign it to the player
                                if role and lock_state:
                                    await new_member.add_roles(role)

                        if rewards:
                            if self.selected_character_id in rewards:
                                del rewards[self.selected_character_id]
                        break

            await quest_collection.replace_one({'guildId': guild_id, 'questId': quest_id}, self.quest)

            # Give the GM some feedback that the changes applied
            gm_member = guild.get_member(interaction.user.id)
            await gm_member.send(f'Player removed and quest roster updated!')

            # Refresh the views with the updated local quest object
            refreshed_view = RemovePlayerView(self.quest)
            await refreshed_view.setup_embed()
            await refreshed_view.setup_select()
            quest_view = QuestPostView(self.quest)
            await quest_view.setup_embed()

            # Update the menu view and the quest post
            await message.edit(embed=quest_view.embed, view=quest_view)
            await interaction.response.edit_message(embed=refreshed_view.embed, view=refreshed_view)

            # Notify the player they have been removed.
            await member.send(removal_message)
        except Exception as e:
            await log_exception(e, interaction)


class QuestPostView(discord.ui.View):
    def __init__(self, quest):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='',
            description='',
            type='rich'
        )
        self.quest = quest
        self.join_button = buttons.JoinQuestButton(self)
        self.leave_button = buttons.LeaveQuestButton(self)
        self.add_item(self.join_button)
        self.add_item(self.leave_button)

    async def setup_embed(self):
        try:
            self.embed = await update_quest_embed(self.quest)
        except Exception as e:
            await log_exception(e)

    async def join_callback(self, interaction):
        try:
            guild_id = interaction.guild_id
            user_id = interaction.user.id

            quest_collection = interaction.client.gdb['quests']
            quest_id = self.quest['questId']
            quest = await quest_collection.find_one({'guildId': guild_id, 'questId': quest_id})

            current_party = quest['party']
            current_wait_list = quest['waitList']
            for player in current_party:
                if str(user_id) in player:
                    for character_id, character_data in player[str(user_id)].items():
                        raise Exception(f'You are already on this quest as {character_data['name']}')
            max_wait_list_size = quest['maxWaitListSize']
            max_party_size = quest['maxPartySize']
            member_collection = interaction.client.mdb['characters']
            player_characters = await member_collection.find_one({'_id': user_id})
            if (not player_characters or
                    'activeCharacters' not in player_characters or
                    str(guild_id) not in player_characters['activeCharacters']):
                raise Exception('You do not have an active character on this server. Use the `/player` menus to create'
                                'a new character, or activate an existing one on this server.')
            active_character_id = player_characters['activeCharacters'][str(guild_id)]
            active_character = player_characters['characters'][active_character_id]

            if quest['lockState']:
                raise Exception(f'Error joining quest **{quest["title"]}**: The quest is locked and not accepting new '
                                f'players.')
            else:
                # If the wait list is enabled, this section formats the embed to include the wait list
                if max_wait_list_size > 0:
                    # If there is room in the party, add the user.
                    if len(current_party) < max_party_size:
                        await quest_collection.update_one(
                            {'guildId': guild_id, 'questId': quest_id},
                            {'$push': {'party': {f'{user_id}': {f'{active_character_id}': active_character}}}}
                        )
                    # If the party is full but the wait list is not, add the user to wait list.
                    elif len(current_party) >= max_party_size and len(current_wait_list) < max_wait_list_size:
                        await quest_collection.update_one(
                            {'guildId': guild_id, 'questId': quest_id},
                            {'$push': {'waitList': {f'{user_id}': {f'{active_character_id}': active_character}}}}
                        )

                    # Otherwise, inform the user that the party/wait list is full
                    else:
                        raise Exception(f'Error joining quest **{quest["title"]}**: The quest roster is full!')
                # If there is no wait list, this section formats the embed without it
                else:
                    # If there is room in the party, add the user.
                    if len(current_party) < max_party_size:
                        await quest_collection.update_one(
                            {'guildId': guild_id, 'questId': quest_id},
                            {'$push': {'party': {f'{user_id}': {f'{active_character_id}': active_character}}}}
                        )
                    else:
                        raise Exception(f'Error joining quest **{quest["title"]}**: The quest roster is full!')

                # The document is queried again to build the updated post
                self.quest = await quest_collection.find_one({'guildId': guild_id, 'questId': quest_id})
                await self.setup_embed()
                await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)

    async def leave_callback(self, interaction):
        try:
            guild_id = interaction.guild_id
            user_id = interaction.user.id
            guild = interaction.client.get_guild(guild_id)

            quest_collection = interaction.client.gdb['quests']
            quest = self.quest
            quest_id, party, wait_list, max_wait_list_size, lock_state = (quest['questId'], quest['party'],
                                                                          quest['waitList'], quest['maxWaitListSize'],
                                                                          quest['lockState'])

            in_party = False
            for player in party:
                if str(user_id) in player:
                    in_party = True
            in_wait_list = False
            if len(wait_list) > 0:
                for player in wait_list:
                    if str(user_id) in player:
                        in_wait_list = True
            if not in_party and not in_wait_list:
                raise Exception(f'You are not signed up for this quest.')

            if in_wait_list:
                for player in wait_list:
                    if str(user_id) in player:
                        wait_list.remove(player)
                        break
            else:
                for player in party:
                    if str(user_id) in player:
                        party.remove(player)

                new_member = None
                # If there is a wait list, move the first entry into the party automatically
                if max_wait_list_size > 0 and len(wait_list) > 0:
                    new_player = wait_list.pop(0)
                    party.append(new_player)

                    for key in new_player:
                        new_member = guild.get_member(int(key))

                    # Notify the member they have been moved into the main party
                    await new_member.send(f'You have been added to the party for '
                                          f'**{quest["title"]}**, due to a player dropping!')

                # If the quest list is locked and a party role exists, fetch the role.
                if lock_state:
                    party_role_collection = interaction.client.gdb['partyRole']
                    party_role_query = await party_role_collection.find_one({'guildId': guild_id, 'gm': quest['gm']})
                    role = None
                    if party_role_query:
                        role = guild.get_role(party_role_query['roleId'])

                    if role:
                        # Get the member object and remove the role
                        member = guild.get_member(user_id)
                        await member.remove_roles(role)
                        if new_member:
                            await new_member.add_roles(role)

            # Update the database
            await quest_collection.replace_one({'guildId': guild_id, 'questId': quest_id}, self.quest)

            # Refresh the query with the new document and edit the post
            await self.setup_embed()
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)


class CompleteQuestsView(discord.ui.View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Game Master - Quest Completion',
            description=(
                'Select a quest to complete. **This action is irreversible!**\n\n'
                'Completing a quest does the following:\n'
                '- Removes the quest post from the Quest Board channel.\n'
                '- Issues rewards (if any) to party members.\n'
                '- Removes GM roles (if any) from party members.\n'
                '- Messages party members with a summary of their individual rewards.\n'
                '- If configured in the server, prompts the GM to summarize the results of the quest/story, and posts '
                'the quest results to a designated Archive Channel.'
            ),
            type='rich'
        )
        self.quests = None
        self.selected_quest = None
        self.quest_select = selects.ManageableQuestSelect(self)
        self.complete_quest_button = buttons.CompleteQuestButton(self)
        self.add_item(self.quest_select)
        self.add_item(self.complete_quest_button)
        self.add_item(buttons.BackButton(GMQuestMenuView()))

    async def setup(self, bot, user, guild):
        try:
            self.embed.clear_fields()

            quest_collection = bot.gdb['quests']
            options = []
            quests = []

            # Check to see if the user has guild admin privileges. This lets them edit any quest in the guild.
            if user.guild_permissions.manage_guild:
                quest_query = quest_collection.find({'guildId': guild.id})
            else:
                quest_query = quest_collection.find({'guildId': guild.id, 'gm': user.id})

            async for document in quest_query:
                quests.append(dict(document))

            if len(quests) > 0:
                for quest in quests:
                    options.append(discord.SelectOption(label=f'{quest['questId']}: {quest['title']}',
                                                        value=quest['questId']))
                self.quests = quests
                logger.debug(f'Found {len(quests)} quests.')
                self.quest_select.disabled = False
            else:
                options.append(discord.SelectOption(label='No quests were found, or you do not have permissions to edit'
                                                          ' them.', value='None'))
                self.quest_select.disabled = True
                self.embed.add_field(name='No Quests Available', value='No quests were found, or you do not have '
                                                                       'permissions to edit them.')
            self.quest_select.options = options

            quest = self.selected_quest
            if quest:
                self.embed.add_field(name='Selected Quest', value=f'`{quest['questId']}`: {quest['title']}')
        except Exception as e:
            await log_exception(e)

    async def select_callback(self, interaction):
        try:
            quests = self.quests
            for quest in quests:
                if self.quest_select.values[0] == quest['questId']:
                    self.selected_quest = quest

            await self.setup(bot=interaction.client, user=interaction.user, guild=interaction.guild)
            self.complete_quest_button.label = f'Confirm completion of {self.selected_quest['title']}?'
            self.complete_quest_button.disabled = False
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)

    async def complete_quest(self, interaction, summary=None):
        try:
            guild_id = interaction.guild_id
            guild = interaction.client.get_guild(guild_id)

            # Fetch the quest
            quest = self.selected_quest

            # Setup quest variables
            quest_id, message_id, title, description, gm, party, rewards = (quest['questId'], quest['messageId'],
                                                                            quest['title'], quest['description'],
                                                                            quest['gm'], quest['party'],
                                                                            quest['rewards'])

            # Check if there is a configured quest archive channel
            archive_channel = None
            archive_query = await interaction.client.gdb['archiveChannel'].find_one({'_id': guild_id})
            if archive_query:
                archive_channel = guild.get_channel(strip_id(archive_query['archiveChannel']))

            # Check if a party role was configured
            party_role_id = None
            party_role_collection = interaction.client.gdb['partyRole']
            party_role_query = await party_role_collection.find_one({'guildId': guild_id, 'gm': gm})
            if party_role_query:
                party_role_id = party_role_query['roleId']

            # Get party members and message them with results
            reward_summary = []
            party_xp = rewards.get('party', {}).get('xp', 0) // len(party)
            party_items = rewards.get('party', {}).get('items', {})
            for entry in party:
                for player_id, character_info in entry.items():
                    member = guild.get_member(int(player_id))

                    # Remove the party role, if applicable
                    if party_role_id:
                        role = guild.get_role(party_role_id)
                        await member.remove_roles(role)

                    # Get character data
                    character_id = next(iter(character_info))
                    character = character_info[character_id]
                    reward_summary.append(f'<@!{player_id}> as {character['name']}:')

                    # Prep reward data
                    total_xp = party_xp
                    combined_items = party_items.copy()

                    # Check if character has individual rewards
                    if character_id in rewards:
                        individual_rewards = rewards[character_id]
                        total_xp += individual_rewards.get('xp', 0)

                        # Merge individual items with party items
                        for item, quantity in individual_rewards.get('items', {}).items():
                            combined_items[item] = combined_items.get(item, 0) + quantity

                    # Update the character's XP and inventory
                    reward_summary.append(f'Experience: {total_xp}')
                    await update_character_experience(interaction, int(player_id), character_id, total_xp)
                    for item_name, quantity in combined_items.items():
                        reward_summary.append(f'{item_name}: {quantity}')
                        await update_character_inventory(interaction, int(player_id), character_id, item_name, quantity)

                    # Send reward summary to player
                    reward_strings = self.build_reward_summary(total_xp, combined_items)
                    dm_embed = discord.Embed(
                        title=f'Quest Complete: {title}',
                        type='rich'
                    )
                    if reward_strings:
                        dm_embed.add_field(name='Rewards', value='\n'.join(reward_strings))
                    await member.send(embed=dm_embed)

            # If an archive channel is configured, build an embed and post it
            if archive_channel:
                archive_embed = discord.Embed(
                    title=title,
                    description='',
                    type='rich'
                )
                # Format the main embed body
                post_description = (
                    f'**GM:** <@!{gm}>\n\n'
                    f'{description}\n\n'
                    f'------'
                )
                formatted_party = []
                for player in party:
                    for member_id in player:
                        for character_id in player[str(member_id)]:
                            character = player[str(member_id)][str(character_id)]
                            formatted_party.append(f'- <@!{member_id}> as {character['name']}')

                # Set the embed fields and footer
                archive_embed.title = title
                archive_embed.description = post_description
                archive_embed.add_field(name=f'__Party__',
                                        value='\n'.join(formatted_party))
                archive_embed.set_footer(text='Quest ID: ' + quest_id)

                # Add the summary if provided
                if summary:
                    archive_embed.add_field(name='Summary', value=summary, inline=False)

                if reward_summary:
                    archive_embed.add_field(name='Rewards', value='\n'.join(reward_summary), inline=True)

                # Post the archived quest
                await archive_channel.send(embed=archive_embed)

            # Delete the original quest post
            quest_channel_query = await interaction.client.gdb['questChannel'].find_one({'_id': guild_id})
            quest_channel_id = quest_channel_query['questChannel']
            quest_channel = interaction.client.get_channel(strip_id(quest_channel_id))
            quest_message = quest_channel.get_partial_message(message_id)
            await attempt_delete(quest_message)

            # Remove the quest from the database
            quest_collection = interaction.client.gdb['quests']
            await quest_collection.delete_one({'guildId': guild_id, 'questId': quest_id})

            # Reset the view and handle the interaction response
            self.selected_quest = None
            self.complete_quest_button.label = 'Confirm?'
            self.complete_quest_button.disabled = True
            await self.setup(bot=interaction.client, user=interaction.user, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e)

    @staticmethod
    def build_reward_summary(xp, items) -> list[str]:
        reward_strings = []
        if xp and xp > 0:
            reward_strings.append(f'- Experience Points: {xp}')
        if items:
            for item, quantity in items.items():
                reward_strings.append(f'- {item}: {quantity}')
        return reward_strings


class CancelQuestView(discord.ui.View):
    def __init__(self, selected_quest):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title=f'Cancel Quest: {selected_quest['title']}',
            description=(
                'This action cannot be undone!'
            ),
            type='rich'
        )
        self.selected_quest = selected_quest
        self.confirm_button = buttons.ConfirmButton(self)
        self.confirm_button.disabled = False
        self.back_button = buttons.MenuViewButton(target_view_class=ManageQuestsView, label='Back', setup_select=True)
        self.add_item(self.confirm_button)
        self.add_item(self.back_button)

    async def confirm_callback(self, interaction):
        try:
            quest = self.selected_quest
            guild_id = interaction.guild_id
            guild = interaction.client.get_guild(guild_id)

            # If a party exists
            party = quest['party']
            title = quest['title']
            if party:
                # Check if a GM role was configured
                party_role = None
                gm = quest['gm']
                party_role_collection = interaction.client.gdb['partyRole']
                party_role_query = await party_role_collection.find_one({'guildId': guild_id, 'gm': gm})
                if party_role_query:
                    party_role_id = party_role_query['roleId']
                    party_role = guild.get_role(party_role_id)

                # Get party members and message them with results
                for player in party:
                    for member_id in player:
                        member = await guild.fetch_member(int(member_id))
                        # Remove the party role, if applicable
                        if party_role:
                            await member.remove_roles(party_role)
                        # Message the player that the quest was cancelled.
                        await member.send(f'Quest **{title}** was cancelled by the GM.')

            # Delete the quest from the database
            await interaction.client.gdb['quests'].delete_one({'guildId': guild_id, 'questId': quest['questId']})

            # Delete the quest from the quest channel
            channel_query = await interaction.client.gdb['questChannel'].find_one({'_id': guild_id})
            channel_id = strip_id(channel_query['questChannel'])
            quest_channel = guild.get_channel(channel_id)
            message_id = quest['messageId']
            message = quest_channel.get_partial_message(message_id)
            await attempt_delete(message)

            await interaction.response.send_message(f'Quest `{quest['questId']}`: **{title}** cancelled!',
                                                    ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


class PlayerBoardView(discord.ui.View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Player Commands - Player Board',
            description=(
                '__**Create Post**__\n'
                'Creates a new post for the Player Board.\n\n'
                '__**Edit Post**__\n'
                'Edits the selected post.\n\n'
                '__**Remove Post**__\n'
                'Removes the selected post from the Player Board.\n\n'
                '------'
            ),
            type='rich'
        )
        self.player_board_channel_id = None
        self.selected_post_id = None
        self.posts = []
        self.selected_post = None
        self.manageable_post_select = selects.ManageablePostSelect(self)
        self.create_player_post_button = buttons.CreatePlayerPostButton(self)
        self.edit_player_post_button = buttons.EditPlayerPostButton(self)
        self.remove_player_post_button = buttons.RemovePlayerPostButton(self)
        self.add_item(self.manageable_post_select)
        self.add_item(self.create_player_post_button)
        self.add_item(self.edit_player_post_button)
        self.add_item(self.remove_player_post_button)
        self.add_item(buttons.BackButton(PlayerBaseView()))

    async def setup(self, bot, user, guild):
        try:
            channel_collection = bot.gdb['playerBoardChannel']
            channel_query = await channel_collection.find_one({'_id': guild.id})
            self.player_board_channel_id = strip_id(channel_query['playerBoardChannel'])

            self.posts.clear()
            self.embed.clear_fields()
            post_collection = bot.gdb['playerBoard']
            post_cursor = post_collection.find({'guildId': guild.id, 'playerId': user.id})
            async for post in post_cursor:
                self.posts.append(dict(post))

            if self.selected_post_id:
                self.edit_player_post_button.disabled = False
                self.remove_player_post_button.disabled = False
                self.selected_post = next((post for post in self.posts if post['postId'] == self.selected_post_id),
                                          None)
                self.embed.add_field(name='Selected Post',
                                     value=f'`{self.selected_post['postId']}`: {self.selected_post['title']}')
            else:
                self.edit_player_post_button.disabled = True
                self.remove_player_post_button.disabled = True

            options = []
            if self.posts:
                for post in self.posts:
                    options.append(discord.SelectOption(
                        label=post['title'],
                        value=post['postId']
                    ))
                self.manageable_post_select.disabled = False
            else:
                options.append(discord.SelectOption(
                    label='You don\'t have any current posts',
                    value='None'
                ))
                self.manageable_post_select.disabled = True
            self.manageable_post_select.options = options
        except Exception as e:
            await log_exception(e)

    async def select_callback(self, interaction):
        try:
            self.selected_post_id = self.manageable_post_select.values[0]
            await self.setup(bot=interaction.client, user=interaction.user, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)

    async def create_post(self, title, content, interaction):
        try:
            post_collection = interaction.client.gdb['playerBoard']
            post_id = str(shortuuid.uuid()[:8])
            post_embed = discord.Embed(
                title=title,
                description=content,
                type='rich'
            )
            post_embed.add_field(name='Author', value=interaction.user.mention)
            post_embed.set_footer(text=f'Post ID: {post_id}')
            channel = interaction.client.get_channel(self.player_board_channel_id)
            message = await channel.send(embed=post_embed)

            post = {
                'guildId': interaction.guild_id,
                'playerId': interaction.user.id,
                'postId': post_id,
                'messageId': message.id,
                'timestamp': message.created_at,
                'title': title,
                'content': content
            }

            await post_collection.insert_one(post)

            await interaction.response.send_message(f'Post `{post_id}`: **{title}** posted!', ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)

    async def edit_post(self, title, content, interaction):
        try:
            self.selected_post['title'] = title
            self.selected_post['content'] = content
            post_embed = discord.Embed(
                title=title,
                description=content,
                type='rich'
            )
            post_embed.add_field(name='Author', value=interaction.user.mention)
            post_embed.set_footer(text=f'Post ID: {self.selected_post_id}')

            message_id = self.selected_post['messageId']
            channel = interaction.client.get_channel(self.player_board_channel_id)
            message = channel.get_partial_message(message_id)
            await message.edit(embed=post_embed)

            post_collection = interaction.client.gdb['playerBoard']
            await post_collection.replace_one({'guildId': interaction.guild_id, 'postId': self.selected_post_id},
                                              self.selected_post)

            await interaction.response.send_message(f'Post `{self.selected_post_id}`: **{title}** updated!',
                                                    ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)

    async def remove_post(self, interaction):
        try:
            post = self.selected_post
            post_collection = interaction.client.gdb['playerBoard']
            await post_collection.delete_one({'guildId': interaction.guild.id, 'postId': self.selected_post_id})

            message_id = post['messageId']
            channel = interaction.client.get_channel(self.player_board_channel_id)
            message = channel.get_partial_message(message_id)
            await attempt_delete(message)

            await interaction.response.send_message(f'Post `{post['postId']}`: **{post['title']}** deleted!',
                                                    ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)
