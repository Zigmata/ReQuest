import io
import logging

import discord
from discord import ButtonStyle
from discord.ui import Button

from ReQuest.ui.admin import modals
from ReQuest.ui.common import modals as common_modals
from ReQuest.utilities.constants import DatabaseCollections
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
from ReQuest.utilities.supportFunctions import log_exception, setup_view, update_cached_data

logger = logging.getLogger(__name__)


class AdminShutdownButton(Button):
    def __init__(self, calling_view, locale=None):
        self._locale = locale or DEFAULT_LOCALE
        super().__init__(
            label=t(self._locale, 'admin-btn-shutdown'),
            style=ButtonStyle.danger,
            custom_id='shutdown_bot_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            locale = getattr(self.view, 'locale', DEFAULT_LOCALE)
            confirm_modal = common_modals.ConfirmModal(
                title=t(locale, 'admin-modal-title-confirm-shutdown'),
                prompt_label=t(locale, 'admin-modal-label-shutdown-warning'),
                prompt_placeholder=t(locale, 'common-confirm-placeholder'),
                confirm_callback=self._confirm_shutdown,
                locale=locale
            )
            await interaction.response.send_modal(confirm_modal)
        except Exception as e:
            await log_exception(e, interaction)

    @staticmethod
    async def _confirm_shutdown(interaction: discord.Interaction):
        try:
            await interaction.response.send_message(t(DEFAULT_LOCALE, 'admin-msg-shutting-down'), ephemeral=True)
            await interaction.client.close()
        except Exception as e:
            await log_exception(e)


class AllowlistAddServerButton(Button):
    def __init__(self, calling_view, locale=None):
        self._locale = locale or DEFAULT_LOCALE
        super().__init__(
            label=t(self._locale, 'admin-btn-add-server'),
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
    def __init__(self, locale=None):
        self._locale = locale or DEFAULT_LOCALE
        super().__init__(
            label=t(self._locale, 'admin-btn-load-cog'),
            custom_id='admin_load_cog_button'
        )

    async def callback(self, interaction: discord.Interaction):
        try:
            locale = getattr(self.view, 'locale', DEFAULT_LOCALE)

            async def modal_callback(modal_interaction, input_value):
                module = input_value.lower()
                await interaction.client.load_extension(f'ReQuest.cogs.{module}')
                await modal_interaction.response.send_message(
                    t(locale, 'admin-msg-extension-loaded', module=module),
                    ephemeral=True)

            modal = modals.AdminCogTextModal('load', modal_callback)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class AdminReloadCogButton(Button):
    def __init__(self, locale=None):
        self._locale = locale or DEFAULT_LOCALE
        super().__init__(
            label=t(self._locale, 'admin-btn-reload-cog'),
            custom_id='admin_reload_cog_button'
        )

    async def callback(self, interaction: discord.Interaction):
        try:
            locale = getattr(self.view, 'locale', DEFAULT_LOCALE)

            async def modal_callback(modal_interaction, input_value):
                module = input_value.lower()
                await interaction.client.reload_extension(f'ReQuest.cogs.{module}')
                await modal_interaction.response.send_message(
                    t(locale, 'admin-msg-extension-reloaded', module=module),
                    ephemeral=True)

            modal = modals.AdminCogTextModal('reload', modal_callback)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class PrintGuildsButton(Button):
    def __init__(self, locale=None):
        self._locale = locale or DEFAULT_LOCALE
        super().__init__(
            label=t(self._locale, 'admin-btn-output-guilds'),
            style=ButtonStyle.primary,
            custom_id='print_guilds_button'
        )

    async def callback(self, interaction: discord.Interaction):
        try:
            locale = getattr(self.view, 'locale', DEFAULT_LOCALE)
            guilds = interaction.client.guilds
            guild_list = [f'{guild.name} (ID: {guild.id})' for guild in guilds]
            guilds_message = t(locale, 'admin-msg-connected-guilds', count=len(guilds)) + '\n' + '\n'.join(guild_list)
            file_name = f'guilds_list.txt'
            guilds_file = discord.File(fp=io.BytesIO(guilds_message.encode()), filename=file_name)
            await interaction.response.send_message(
                t(locale, 'admin-msg-connected-guilds', count=len(guilds)),
                file=guilds_file,
                ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveServerButton(Button):
    def __init__(self, calling_view, guild_id, server_name, locale=None):
        self._locale = locale or DEFAULT_LOCALE
        super().__init__(
            label=t(self._locale, 'common-btn-remove'),
            style=ButtonStyle.danger,
            custom_id=f'remove_server_{guild_id}'
        )
        self.calling_view = calling_view
        self.guild_id = guild_id
        self.server_name = server_name

    async def callback(self, interaction: discord.Interaction):
        try:
            locale = getattr(self.view, 'locale', DEFAULT_LOCALE)
            confirm_modal = common_modals.ConfirmModal(
                title=t(locale, 'admin-modal-title-confirm-server-removal'),
                prompt_label=t(locale, 'admin-modal-label-server-removal'),
                prompt_placeholder=t(locale, 'common-confirm-placeholder'),
                confirm_callback=self._confirm_delete,
                locale=locale
            )
            await interaction.response.send_modal(confirm_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def _confirm_delete(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            await update_cached_data(
                bot=bot,
                mongo_database=bot.cdb,
                collection_name=DatabaseCollections.SERVER_ALLOWLIST,
                query={'servers': {'$exists': True}},
                update_data={'$pull': {'servers': {'id': self.guild_id}}},
                cache_id=self.guild_id
            )

            if self.guild_id in interaction.client.allow_list:
                interaction.client.allow_list.remove(self.guild_id)

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)
