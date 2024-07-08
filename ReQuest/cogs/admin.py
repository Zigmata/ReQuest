import discord
import discord.ui
from discord import app_commands
from discord.ext import commands
from discord.ext.commands import Cog
import aiohttp
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

from ..utilities.supportFunctions import log_exception
from ..utilities.ui import MenuDoneButton, AdminMenuButton, AdminBackButton


class Admin(Cog):
    def __init__(self, bot):
        self.bot = bot
        self.cdb = bot.cdb
        super().__init__()

    # -----------------Listeners----------------

    @commands.Cog.listener()
    async def on_guild_join(self, guild):
        try:
            if not self.bot.config['allowList'] or guild.id in self.bot.allow_list:
                return
            else:
                await guild.owner.send(
                    'Thank you for your interest in ReQuest! Your server is not in ReQuest\'s list of '
                    'authorized testing servers. Please join the support server and contact the '
                    'development team to request test access.')
                return await guild.leave()
        except Exception as e:
            await log_exception(e)

    # -------------Private Commands-------------

    @commands.is_owner()
    @commands.command(name='commandsync', case_insensitive=True, hidden=True, pass_context=True)
    async def command_sync(self, ctx, guild_id=None):
        """
        Syncs the application commands to Discord.

        NOTE: Provide a guild_id argument when testing to sync to a specific guild. ONLY sync globally (no argument)
        when you are creating a new command and are finished testing it locally.
        """

        try:
            guild = self.bot.get_guild(int(guild_id))
            self.bot.tree.copy_global_to(guild=guild)
            status = await self.bot.tree.sync(guild=guild)
            synced_commands = []
            if guild_id:
                embed_title = f"The following commands were synchronized to guild ID {guild_id}"
            else:
                embed_title = "The following commands were synchronized globally"

            for synced_command in status:
                synced_commands.append(synced_command.name)

            message_embed = discord.Embed(title=embed_title, description='\n'.join(synced_commands))
            await ctx.author.send(embed=message_embed)
        except discord.Forbidden:
            await ctx.send(f'ReQuest does not have the correct scope in the target guild. Add `applications.commands`'
                           f' permission and try again.')
        except Exception as e:
            await ctx.send(f'There was an error syncing commands: {e}')

    @app_commands.checks.has_permissions(manage_guild=True)
    @app_commands.default_permissions(manage_guild=True)
    @app_commands.command(name='admin')
    @app_commands.guild_only()
    async def admin(self, interaction: discord.Interaction):
        """
        Administration wizard. Bot owner only
        """
        try:
            view = AdminBaseView(cdb=self.cdb, bot=self.bot)
            await interaction.response.send_message(embed=view.embed, view=view, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


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
        self.add_item(MenuDoneButton(self))


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

    @discord.ui.select(cls=discord.ui.Select, placeholder='Select a server to remove',
                       options=[], custom_id='remove_guild_allowlist_select', row=0)
    async def remove_guild_allowlist_select(self, interaction: discord.Interaction, select: discord.ui.Select):
        try:
            guild_id = int(select.values[0])
            collection = self.cdb['serverAllowlist']
            query = await collection.find_one({'servers': {'$exists': True}, 'servers.id': guild_id})
            server = next((server for server in query['servers'] if server['id'] == guild_id))
            logger.info(f'Found server: {server}')
            self.selected_guild = server['id']
            self.confirm_allowlist_remove_button.disabled = False
            self.confirm_allowlist_remove_button.label = f'Confirm removal of {guild_id}'
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)

    @discord.ui.button(label='Add New Server', style=discord.ButtonStyle.success,
                       custom_id='allowlist_add_server_button')
    async def allowlist_add_server_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            new_modal = AllowServerModal(self.cdb, self, self.bot)
            await interaction.response.send_modal(new_modal)
        except Exception as e:
            await log_exception(e, interaction)

    @discord.ui.button(label='Confirm', style=discord.ButtonStyle.danger, custom_id='confirm_allowlist_remove_button',
                       disabled=True)
    async def confirm_allowlist_remove_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            collection = self.cdb['serverAllowlist']
            await collection.update_one({'servers': {'$exists': True}},
                                        {'$pull': {'servers': {'id': self.selected_guild}}})
            await self.setup_select()
            self.confirm_allowlist_remove_button.disabled = True
            self.confirm_allowlist_remove_button.label = 'Confirm'
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)


class AllowServerModal(discord.ui.Modal):
    def __init__(self, cdb, calling_view, bot):
        super().__init__(
            title='Add Server ID to Allowlist',
            timeout=180
        )
        self.cdb = cdb
        self.calling_view = calling_view
        self.allow_server_name_input = discord.ui.TextInput(
            label='Server Name',
            style=discord.TextStyle.short,
            custom_id='allow_server_name_input',
            placeholder='Type a short name for the Discord Server',
            required=True
        )
        self.allow_server_id_input = discord.ui.TextInput(
            label='Server ID',
            style=discord.TextStyle.short,
            custom_id='allow_server_text_input',
            placeholder='Type the ID of the Discord Server',
            required=True
        )
        self.add_item(self.allow_server_name_input)
        self.add_item(self.allow_server_id_input)
        self.bot = bot

    async def on_submit(self, interaction: discord.Interaction):
        try:
            input_name = self.allow_server_name_input.value
            guild_id = int(self.allow_server_id_input.value)
            collection = self.cdb['serverAllowlist']
            self.bot.allow_list.append(guild_id)
            await collection.update_one({'servers': {'$exists': True}},
                                        {'$push': {'servers': {'name': input_name, 'id': guild_id}}},
                                        upsert=True)
            await self.calling_view.setup_select()
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


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
        self.add_item(AdminBackButton(AdminBaseView, cdb, bot))

    @discord.ui.button(label='Load Cog', style=discord.ButtonStyle.secondary, custom_id='admin_load_cog_button')
    async def admin_load_cog_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            async def modal_callback(modal_interaction: discord.Interaction, input_value):
                module = input_value.lower()
                await self.bot.load_extension(f'ReQuest.cogs.{module}')
                await modal_interaction.response.send_message(f'Extension successfully loaded: `{module}`',
                                                              ephemeral=True)

            modal = AdminCogTextModal('load', modal_callback)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)

    @discord.ui.button(label='Reload Cog', style=discord.ButtonStyle.secondary, custom_id='admin_reload_cog_button')
    async def admin_reload_cog_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            async def modal_callback(modal_interaction: discord.Interaction, input_value):
                module = input_value.lower()
                await self.bot.reload_extension(f'ReQuest.cogs.{module}')
                await modal_interaction.response.send_message(f'Extension successfully reloaded: `{module}`',
                                                              ephemeral=True)

            modal = AdminCogTextModal('reload', modal_callback)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class AdminCogTextModal(discord.ui.Modal):
    def __init__(self, function, on_submit):
        super().__init__(
            title=f'{function.capitalize()} Cog',
            timeout=180
        )
        self.text_input = discord.ui.TextInput(label='Name', style=discord.TextStyle.short,
                                               placeholder=f'Enter the name of the Cog to {function}',
                                               custom_id='cog_name_text_input', required=True)
        self.add_item(self.text_input)
        self._on_submit = on_submit

    async def on_submit(self, interaction: discord.Interaction):
        try:
            await self._on_submit(interaction, self.text_input.value)
        except Exception as e:
            await log_exception(e, interaction)

    # # Echoes the first argument provided
    # @is_owner()
    # @app_commands.command(name='echo')
    # async def echo(self, interaction: discord.Interaction, text: str):
    #     await interaction.response.send_message(text, ephemeral=True)
    #
    # # Shut down the bot
    # @is_owner()
    # @app_commands.command(name='shutdown')
    # async def shutdown(self, interaction: discord.Interaction):
    #     try:
    #         await interaction.response.send_message('Shutting down!', ephemeral=True)
    #         await self.bot.close()
    #     except Exception as e:
    #         await interaction.response.send_message(f'{type(e).__name__}: {e}', ephemeral=True)
    #
    # @is_owner()
    # @allowlist_group.command(name='add')
    # async def allowlist_add(self, interaction: discord.Interaction, guild: str):
    #     collection = self.cdb['serverAllowlist']
    #     guild_id = int(guild)
    #     self.bot.allow_list.append(guild_id)
    #
    #     await collection.update_one({'servers': {'$exists': True}}, {'$push': {'servers': guild_id}}, upsert=True)
    #
    #     await interaction.response.send_message(f'Guild ID `{guild_id}` added to allowlist!', ephemeral=True)
    #
    # @is_owner()
    # @allowlist_group.command(name='remove')
    # async def allowlist_remove(self, interaction: discord.Interaction, guild: str):
    #     collection = self.cdb['serverAllowlist']
    #     guild_id = int(guild)
    #     self.bot.allow_list.remove(guild_id)
    #
    #     if await collection.count_documents({'servers': {'$exists': True}}, limit=1) != 0:
    #         await collection.update_one({'servers': {'$exists': True}}, {'$pull': {'servers': guild_id}})
    #     else:
    #         return
    #
    #     await interaction.response.send_message(f'Guild ID `{guild_id}` removed from allowlist!', ephemeral=True)
    #


async def setup(bot):
    await bot.add_cog(Admin(bot))
