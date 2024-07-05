import logging

import discord
import discord.ui
from discord import app_commands
from discord.ext.commands import Cog

from ..utilities.supportFunctions import log_exception
from ..utilities.ui import BackButton, ConfigMenuButton, MenuDoneButton, SingleChannelConfigSelect

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class Config(Cog):
    def __init__(self, bot):
        super().__init__()
        self.bot = bot
        self.gdb = bot.gdb

    @app_commands.checks.has_permissions(manage_guild=True)
    @app_commands.default_permissions(manage_guild=True)
    @app_commands.command(name='config')
    @app_commands.guild_only()
    async def config(self, interaction: discord.Interaction):
        """
        Server Configuration Wizard (Server Admins only)
        """
        try:
            guild_id = interaction.guild.id
            view = ConfigBaseView(guild_id, self.gdb)
            await interaction.response.send_message(embed=view.embed, view=view, ephemeral=True)
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
        self.add_item(ConfigMenuButton(ConfigRolesView, 'Roles', guild_id, gdb))
        self.add_item(ConfigMenuButton(ConfigChannelsView, 'Channels', guild_id, gdb))
        self.add_item(ConfigMenuButton(ConfigQuestsView, 'Quests', guild_id, gdb))
        self.add_item(ConfigMenuButton(ConfigPlayersView, 'Players', guild_id, gdb))
        self.add_item(ConfigMenuButton(ConfigCurrencyView, 'Currency', guild_id, gdb))
        self.add_item(MenuDoneButton(self))


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
        self.add_item(BackButton(ConfigBaseView, guild_id, gdb))

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
                self.config_quest_announce_role_remove_button.disabled = True
            else:
                announcement_role_string = f'{announcement_role}'
                self.config_quest_announce_role_remove_button.disabled = False
            if not gm_roles:
                gm_roles_string = 'Not Configured'
                self.config_gm_role_remove_button.disabled = True
            else:
                role_mentions = []
                for role in gm_roles:
                    role_mentions.append(role['mention'])

                gm_roles_string = f'- {'\n- '.join(role_mentions)}'
                self.config_gm_role_remove_button.disabled = False

            self.embed.clear_fields()
            self.embed.add_field(name='Announcement Role', value=announcement_role_string)
            self.embed.add_field(name='GM Roles', value=gm_roles_string)
        except Exception as e:
            await log_exception(e)

    @discord.ui.select(cls=discord.ui.RoleSelect, placeholder='Search for your Quest Announcement Role',
                       custom_id='config_quest_announce_role_select')
    async def config_quest_announce_role_select(self, interaction: discord.Interaction, select: discord.ui.RoleSelect):
        try:
            collection = self.gdb['announceRole']
            await collection.update_one({'_id': self.guild_id}, {'$set': {'announceRole': select.values[0].mention}},
                                        upsert=True)
            await self.setup_embed()
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)

    @discord.ui.select(cls=discord.ui.RoleSelect, placeholder='Search for your GM Role(s)',
                       custom_id='config_gm_role_select', max_values=25)
    async def config_gm_role_select(self, interaction: discord.Interaction, select: discord.ui.RoleSelect):
        try:
            collection = self.gdb['gmRoles']
            query = await collection.find_one({'_id': self.guild_id})
            if not query:
                for value in select.values:
                    await collection.update_one({'_id': self.guild_id},
                                                {'$push': {'gmRoles': {'mention': value.mention, 'name': value.name}}},
                                                upsert=True)
            else:
                for value in select.values:
                    matches = 0
                    for role in query['gmRoles']:
                        if value.mention in role['mention']:
                            matches += 1

                    if matches == 0:
                        await collection.update_one({'_id': self.guild_id},
                                                    {'$push': {
                                                        'gmRoles': {'mention': value.mention, 'name': value.name}}},
                                                    upsert=True)

            await self.setup_embed()
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)

    @discord.ui.button(label='Remove Quest Announcement Role', style=discord.ButtonStyle.red,
                       custom_id='config_quest_announce_role_remove_button')
    async def config_quest_announce_role_remove_button(self, interaction: discord.Interaction,
                                                       button: discord.ui.Button):
        try:
            collection = self.gdb['announceRole']
            query = await collection.find_one({'_id': self.guild_id})
            if query:
                await collection.delete_one({'_id': self.guild_id})

            await self.setup_embed()
            return await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)

    @discord.ui.button(label='Remove GM Roles', style=discord.ButtonStyle.red, custom_id='config_gm_role_remove_button')
    async def config_gm_role_remove_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            collection = self.gdb['gmRoles']
            query = await collection.find_one({'_id': self.guild_id})
            options = []
            for result in query['gmRoles']:
                name = result['name']
                options.append(discord.SelectOption(label=name, value=name))

            logger.info(f'Options: {options}')
            new_view = ConfigGMRoleRemoveView(self.guild_id, self.gdb, options)
            await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class GMRoleSelect(discord.ui.Select):
    def __init__(self, guild_id, gdb, options):
        super().__init__(
            placeholder='Select Role(s)',
            max_values=len(options),
            options=options
        )
        self.guild_id = guild_id
        self.gdb = gdb

    async def callback(self, interaction: discord.Interaction):
        try:
            collection = self.gdb['gmRoles']
            for value in self.values:
                await collection.update_one({'_id': self.guild_id}, {'$pull': {'gmRoles': {'name': value}}})

            new_view = ConfigRolesView(self.guild_id, self.gdb)
            await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class ConfigGMRoleRemoveView(discord.ui.View):
    def __init__(self, guild_id, gdb, options):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Server Configuration - Remove GM Role(s)',
            description='Select roles from the dropdown below to remove from GM status.\n\n'
                        '-----',
            type='rich'
        )
        self.guild_id = guild_id
        self.gdb = gdb
        self.add_item(GMRoleSelect(guild_id, gdb, options))
        self.add_item(BackButton(ConfigRolesView, guild_id, gdb))

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
        self.add_item(BackButton(ConfigBaseView, guild_id, gdb))

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
        self.add_item(BackButton(ConfigBaseView, guild_id, gdb))

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

    @discord.ui.button(label='Toggle Quest Summary', style=discord.ButtonStyle.primary,
                       custom_id='config_quest_summary_toggle_button')
    async def config_quest_summary_toggle_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            collection = self.gdb['questSummary']
            query = await collection.find_one({'_id': self.guild_id})
            if not query:
                await collection.insert_one({'_id': self.guild_id, 'questSummary': True})
            else:
                if query['questSummary']:
                    await collection.update_one({'_id': self.guild_id}, {'$set': {'questSummary': False}})
                else:
                    await collection.update_one({'_id': self.guild_id}, {'$set': {'questSummary': True}})

            await self.setup_embed()
            await interaction.response.edit_message(embed=self.embed)
        except Exception as e:
            await log_exception(e, interaction)

    @discord.ui.select(cls=discord.ui.Select,
                       row=0,
                       options=[
                           discord.SelectOption(label='0 (Disabled)', value='0'),
                           discord.SelectOption(label='1', value='1'),
                           discord.SelectOption(label='2', value='2'),
                           discord.SelectOption(label='3', value='3'),
                           discord.SelectOption(label='4', value='4'),
                           discord.SelectOption(label='5', value='5')
                       ],
                       placeholder='Select Wait List size',
                       custom_id='config_wait_list_select')
    async def config_wait_list_select(self, interaction: discord.Interaction, select: discord.ui.Select):
        try:
            collection = self.gdb['questWaitList']
            await collection.update_one({'_id': self.guild_id}, {'$set': {'questWaitList': int(select.values[0])}},
                                        upsert=True)
            await self.setup_embed()
            await interaction.response.edit_message(embed=self.embed)
        except Exception as e:
            await log_exception(e, interaction)


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
        self.add_item(BackButton(ConfigBaseView, guild_id, gdb))

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

    @discord.ui.button(label='Toggle Player Experience', style=discord.ButtonStyle.primary,
                       custom_id='config_player_experience_toggle_button')
    async def config_player_experience_toggle_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            collection = self.gdb['playerExperience']
            query = await collection.find_one({'_id': self.guild_id})
            if query and query['playerExperience']:
                await collection.update_one({'_id': self.guild_id}, {'$set': {'playerExperience': False}},
                                            upsert=True)
            else:
                await collection.update_one({'_id': self.guild_id}, {'$set': {'playerExperience': True}},
                                            upsert=True)

            await self.setup_embed()
            await interaction.response.edit_message(embed=self.embed)
        except Exception as e:
            await log_exception(e, interaction)


class AddCurrencyTextModal(discord.ui.Modal):
    def __init__(self, guild_id, gdb, calling_view):
        super().__init__(
            title='Add New Currency',
            timeout=180
        )
        self.calling_view = calling_view
        self.guild_id = guild_id
        self.gdb = gdb
        self.text_input = discord.ui.TextInput(label='Currency Name', style=discord.TextStyle.short, required=True,
                                               custom_id='new_currency_name_text_input')
        self.add_item(self.text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            collection = self.gdb['currency']
            query = await collection.find_one({'_id': self.guild_id})
            if query:
                matches = 0
                for currency in query['currencies']:
                    if currency['name'].lower() == self.text_input.value.lower():
                        matches += 1
                    if currency['denominations'] and len(currency['denominations']) > 0:
                        for denomination in currency['denominations']:
                            if denomination['name'].lower() == self.text_input.value.lower():
                                matches += 1

                if matches > 0:
                    await interaction.response.defer(ephemeral=True, thinking=True)
                    await interaction.followup.send(f'A currency or denomination named {self.text_input.value} '
                                                    f'already exists!')
                else:
                    await collection.update_one({'_id': self.guild_id},
                                                {'$push': {'currencies': {'name': self.text_input.value,
                                                                          'isDouble': False, 'denominations': []}}},
                                                upsert=True)
                    await self.calling_view.setup_embed()
                    await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
            else:
                await collection.update_one({'_id': self.guild_id},
                                            {'$push': {'currencies': {'name': self.text_input.value,
                                                                      'isDouble': False, 'denominations': []}}},
                                            upsert=True)
                await self.calling_view.setup_embed()
                await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class AddCurrencyDenominationTextInput(discord.ui.TextInput):
    def __init__(self, input_type, placeholder):
        super().__init__(
            label=input_type,
            style=discord.TextStyle.short,
            placeholder=placeholder,
            custom_id=f'denomination_{input_type.lower()}_text_input',
            required=True
        )


class AddCurrencyDenominationTextModal(discord.ui.Modal):
    def __init__(self, guild_id, gdb, calling_view, base_currency_name):
        super().__init__(
            title=f'Add {base_currency_name} Denomination',
            timeout=300
        )
        self.guild_id = guild_id
        self.gdb = gdb
        self.calling_view = calling_view
        self.base_currency_name = base_currency_name
        self.denomination_name_text_input = AddCurrencyDenominationTextInput(input_type='Name',
                                                                             placeholder='e.g., Silver')
        self.denomination_value_text_input = AddCurrencyDenominationTextInput(input_type='Value',
                                                                              placeholder='e.g., 0.1')
        self.add_item(self.denomination_name_text_input)
        self.add_item(self.denomination_value_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            new_name = self.denomination_name_text_input.value
            collection = self.gdb['currency']
            query = await collection.find_one({'_id': self.guild_id})
            for currency in query['currencies']:
                if new_name.lower() == currency['name'].lower():
                    raise Exception(f'New denomination name cannot match an existing currency on this server! Found '
                                    f'existing currency named \"{currency['name']}\".')
                for denomination in currency['denominations']:
                    if new_name.lower() == denomination['name'].lower():
                        raise Exception(f'New denomination name cannot match an existing denomination on this server! '
                                        f'Found existing denomination named \"{denomination['name']}\" under the '
                                        f'currency named \"{currency['name']}\".')
            base_currency = next((item for item in query['currencies'] if item['name'] == self.base_currency_name),
                                 None)
            for denomination in base_currency['denominations']:
                if float(self.denomination_value_text_input.value) == denomination['value']:
                    using_name = denomination['name']
                    raise Exception(f'Denominations under a single currency must have unique values! '
                                    f'{using_name} already has this value assigned.')

            await collection.update_one({'_id': self.guild_id, 'currencies.name': self.base_currency_name},
                                        {'$push': {'currencies.$.denominations': {
                                            'name': new_name,
                                            'value': float(self.denomination_value_text_input.value)}}},
                                        upsert=True)
            await self.calling_view.setup_select()
            await self.calling_view.setup_embed(self.base_currency_name)
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ConfigRemoveDenominationView(discord.ui.View):
    def __init__(self, guild_id, gdb, currency_name):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title=f'Server Configuration - Remove {currency_name} Denomination',
            description='Select a denomination to remove.',
            type='rich'
        )
        self.guild_id = guild_id
        self.gdb = gdb
        self.currency_name = currency_name
        self.selected_denomination_name = None
        self.add_item(BackButton(ConfigEditCurrencyView, guild_id, gdb, setup_embed=False))

    async def setup_select(self):
        try:
            self.remove_denomination_select.options.clear()
            collection = self.gdb['currency']
            query = await collection.find_one({'_id': self.guild_id, 'currencies.name': self.currency_name})
            currency = next((item for item in query['currencies'] if item['name'] == self.currency_name), None)
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
                                                               f'{self.currency_name}.')
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
            await collection.update_one({'_id': self.guild_id, 'currencies.name': self.currency_name},
                                        {'$pull': {'currencies.$.denominations': {'name': denomination_name}}})
        except Exception as e:
            await log_exception(e)

    @discord.ui.select(cls=discord.ui.Select, placeholder='Select a denomination', options=[],
                       custom_id='remove_denomination_select', row=0)
    async def remove_denomination_select(self, interaction: discord.Interaction, select: discord.ui.Select):
        try:
            self.selected_denomination_name = select.values[0]
            self.remove_denomination_confirm_button.label = f'Confirm deletion of {self.selected_denomination_name}'
            self.remove_denomination_confirm_button.disabled = False
            await self.setup_embed()
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e)

    @discord.ui.button(label='Confirm', style=discord.ButtonStyle.danger,
                       custom_id='remove_denomination_confirm_button', disabled=True)
    async def remove_denomination_confirm_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            await self.remove_currency_denomination(self.selected_denomination_name)
            self.embed.clear_fields()
            await self.setup_select()
            self.remove_denomination_confirm_button.disabled = True
            self.remove_denomination_confirm_button.label = 'Confirm'
            await interaction.response.edit_message(embed=self.embed, view=self)
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
        self.add_item(BackButton(ConfigCurrencyView, guild_id, gdb))
        self.selected_currency_name = None

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

    @discord.ui.select(cls=discord.ui.Select, placeholder='Choose a currency to edit', options=[],
                       custom_id='edit_currency_select', row=0)
    async def edit_currency_select(self, interaction: discord.Interaction, select: discord.ui.Select):
        try:
            self.selected_currency_name = select.values[0]
            self.toggle_double_button.disabled = False
            self.toggle_double_button.label = f'Toggle Display for {self.selected_currency_name}'
            self.add_denomination_button.disabled = False
            self.add_denomination_button.label = f'Add Denomination to {self.selected_currency_name}'
            self.remove_denomination_button.label = f'Remove Denomination from {self.selected_currency_name}'
            await self.setup_embed(self.selected_currency_name)
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e)

    @discord.ui.button(label='Select a currency', style=discord.ButtonStyle.secondary, custom_id='toggle_double_button',
                       disabled=True)
    async def toggle_double_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            collection = self.gdb['currency']
            query = await collection.find_one({'_id': self.guild_id, 'currencies.name': self.selected_currency_name})
            currency = next((item for item in query['currencies'] if item['name'] == self.selected_currency_name), None)
            if currency['isDouble']:
                value = False
            else:
                value = True
            await collection.update_one({'_id': self.guild_id, 'currencies.name': self.selected_currency_name},
                                        {'$set': {'currencies.$.isDouble': value}})
            await self.setup_embed(self.selected_currency_name)
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e)

    @discord.ui.button(label='Select a currency', style=discord.ButtonStyle.success,
                       custom_id='add_denomination_button', disabled=True)
    async def add_denomination_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            new_modal = AddCurrencyDenominationTextModal(
                guild_id=self.guild_id,
                gdb=self.gdb,
                calling_view=self,
                base_currency_name=self.selected_currency_name
            )
            await interaction.response.send_modal(new_modal)
        except Exception as e:
            await log_exception(e)

    @discord.ui.button(label='Select a currency', style=discord.ButtonStyle.danger,
                       custom_id='remove_denomination_button', disabled=True)
    async def remove_denomination_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            new_view = ConfigRemoveDenominationView(self.guild_id, self.gdb, self.selected_currency_name)
            await new_view.setup_select()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
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
        self.add_item(BackButton(ConfigBaseView, guild_id, gdb))

    async def setup_embed(self):
        try:
            self.embed.clear_fields()
            collection = self.gdb['currency']
            query = await collection.find_one({'_id': self.guild_id})
            self.config_edit_currency_button.disabled = True
            self.config_remove_currency_button.disabled = True

            if query and len(query['currencies']) > 0:
                self.config_edit_currency_button.disabled = False
                self.config_remove_currency_button.disabled = False

                currency_names = []
                for currency in query['currencies']:
                    currency_names.append(currency['name'])

                self.embed.add_field(name='Active Currencies', value=', '.join(currency_names))
        except Exception as e:
            await log_exception(e)

    @discord.ui.button(label='Add New Currency', style=discord.ButtonStyle.success,
                       custom_id='config_add_currency_button')
    async def config_add_currency_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            await interaction.response.send_modal(AddCurrencyTextModal(guild_id=self.guild_id,
                                                                       gdb=self.gdb,
                                                                       calling_view=self))
        except Exception as e:
            await log_exception(e)

    @discord.ui.button(label='Edit Currency', style=discord.ButtonStyle.secondary,
                       custom_id='config_edit_currency_button')
    async def config_edit_currency_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            new_view = ConfigEditCurrencyView(guild_id=self.guild_id, gdb=self.gdb)
            await new_view.setup_select()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e)

    @discord.ui.button(label='Remove Currency', style=discord.ButtonStyle.danger,
                       custom_id='config_remove_currency_button')
    async def config_remove_currency_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            new_view = RemoveCurrencyView(guild_id=self.guild_id, gdb=self.gdb)
            await new_view.setup_select()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
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
        self.add_item(BackButton(ConfigCurrencyView, guild_id, gdb))
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

    @discord.ui.select(cls=discord.ui.Select, placeholder='Select a currency', options=[],
                       custom_id='remove_currency_select', row=0)
    async def remove_currency_select(self, interaction: discord.Interaction, select: discord.ui.Select):
        try:
            self.selected_currency = select.values[0]
            self.remove_currency_confirm_button.label = f'Confirm deletion of {self.selected_currency}'
            self.remove_currency_confirm_button.disabled = False
            await self.setup_embed()
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e)

    @discord.ui.button(label='Confirm', style=discord.ButtonStyle.danger,
                       custom_id='remove_currency_confirm_button', disabled=True)
    async def remove_currency_confirm_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            await self.remove_currency(self.selected_currency)
            self.embed.clear_fields()
            await self.setup_select()
            self.remove_currency_confirm_button.disabled = True
            self.remove_currency_confirm_button.label = 'Confirm'
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e)


async def setup(bot):
    await bot.add_cog(Config(bot))
