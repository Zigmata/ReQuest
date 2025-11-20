import io
import logging

import discord
from discord import ButtonStyle
from discord.ui import Button

from ReQuest.ui.admin import modals
from ReQuest.utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class AdminShutdownButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Shutdown',
            style=ButtonStyle.danger,
            custom_id='shutdown_bot_button'
        )
        self.confirm = False
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            if self.confirm:
                await interaction.response.send_message('Shutting down!', ephemeral=True)
                await interaction.client.close()
            else:
                self.confirm = True
                self.label = 'CONFIRM SHUTDOWN?'
                await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e)


class AllowlistAddServerButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Add New Server',
            style=ButtonStyle.success,
            custom_id='allowlist_add_server_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            new_modal = modals.AllowServerModal(self.calling_view)
            await interaction.response.send_modal(new_modal)
        except Exception as e:
            await log_exception(e, interaction)


class AdminLoadCogButton(Button):
    def __init__(self):
        super().__init__(
            label='Load Cog',
            custom_id='admin_load_cog_button'
        )

    async def callback(self, interaction: discord.Interaction):
        try:
            async def modal_callback(modal_interaction, input_value):
                module = input_value.lower()
                await interaction.client.load_extension(f'ReQuest.cogs.{module}')
                await modal_interaction.response.send_message(f'Extension successfully loaded: `{module}`',
                                                              ephemeral=True)

            modal = modals.AdminCogTextModal('load', modal_callback)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class AdminReloadCogButton(Button):
    def __init__(self):
        super().__init__(
            label='Reload Cog',
            custom_id='admin_reload_cog_button'
        )

    async def callback(self, interaction: discord.Interaction):
        try:
            async def modal_callback(modal_interaction, input_value):
                module = input_value.lower()
                await interaction.client.reload_extension(f'ReQuest.cogs.{module}')
                await modal_interaction.response.send_message(f'Extension successfully reloaded: `{module}`',
                                                              ephemeral=True)

            modal = modals.AdminCogTextModal('reload', modal_callback)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class PrintGuildsButton(Button):
    def __init__(self):
        super().__init__(
            label='Output Guild List',
            style=ButtonStyle.primary,
            custom_id='print_guilds_button'
        )

    async def callback(self, interaction: discord.Interaction):
        try:
            guilds = interaction.client.guilds
            guild_list = [f'{guild.name} (ID: {guild.id})' for guild in guilds]
            guilds_message = 'Connected Guilds:\n' + '\n'.join(guild_list)
            file_name = f'guilds_list.txt'
            guilds_file = discord.File(fp=io.BytesIO(guilds_message.encode()), filename=file_name)
            await interaction.response.send_message(
                f'Connected Guilds:',
                file=guilds_file,
                ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)
