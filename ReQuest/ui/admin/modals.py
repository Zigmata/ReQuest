import logging

import discord
import discord.ui
from ReQuest.ui.common.modals import LocaleModal

from ReQuest.utilities.constants import DatabaseCollections, DiscordCharacterLimits
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
from ReQuest.utilities.db_cache import update_cached_data
from ReQuest.utilities.exceptions import log_exception
from ReQuest.utilities.discord_utils import setup_view

logger = logging.getLogger(__name__)


class AllowServerModal(LocaleModal):
    def __init__(self, calling_view, locale=None):
        self._locale = locale or DEFAULT_LOCALE
        super().__init__(
            title=t(self._locale, 'admin-modal-title-add-server')[:DiscordCharacterLimits.MODAL_TITLE],
            timeout=180
        )
        self.calling_view = calling_view
        self.allow_server_name_input = discord.ui.TextInput(
            custom_id='allow_server_name_input',
            placeholder=t(
                self._locale, 'admin-modal-placeholder-server-name'
            )[:DiscordCharacterLimits.TEXT_INPUT_PLACEHOLDER]
        )
        self.allow_server_name_label = discord.ui.Label(
            text=t(self._locale, 'admin-modal-label-server-name')[:DiscordCharacterLimits.LABEL_LABEL],
            component=self.allow_server_name_input
        )
        self.allow_server_id_input = discord.ui.TextInput(
            custom_id='allow_server_text_input',
            placeholder=t(
                self._locale, 'admin-modal-placeholder-server-id'
            )[:DiscordCharacterLimits.TEXT_INPUT_PLACEHOLDER]
        )
        self.allow_server_id_label = discord.ui.Label(
            text=t(self._locale, 'admin-modal-label-server-id')[:DiscordCharacterLimits.LABEL_LABEL],
            component=self.allow_server_id_input
        )
        self.add_item(self.allow_server_name_label)
        self.add_item(self.allow_server_id_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            input_name = self.allow_server_name_input.value
            guild_id = int(self.allow_server_id_input.value)
            bot = interaction.client

            await update_cached_data(
                bot=bot,
                mongo_database=bot.cdb,
                collection_name=DatabaseCollections.SERVER_ALLOWLIST,
                query={'servers': {'$exists': True}},
                update_data={'$push': {'servers': {'name': input_name, 'id': guild_id}}},
                cache_id=f'{guild_id}'
            )

            interaction.client.allow_list.append(guild_id)

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class AdminCogTextModal(LocaleModal):
    def __init__(self, function, on_submit, locale=None):
        self._locale = locale or DEFAULT_LOCALE
        super().__init__(
            title=t(
                self._locale, 'admin-modal-title-cog-action', action=function.capitalize()
            )[:DiscordCharacterLimits.MODAL_TITLE],
            timeout=180
        )
        self.text_input = discord.ui.TextInput(
            placeholder=t(
                self._locale, 'admin-modal-placeholder-cog-name', action=function
            )[:DiscordCharacterLimits.TEXT_INPUT_PLACEHOLDER],
            custom_id='cog_name_text_input'
        )
        self.text_label = discord.ui.Label(
            text=t(self._locale, 'admin-modal-label-cog-name')[:DiscordCharacterLimits.LABEL_LABEL],
            component=self.text_input
        )
        self.add_item(self.text_label)
        self._on_submit = on_submit

    async def on_submit(self, interaction: discord.Interaction):
        try:
            await self._on_submit(interaction, self.text_input.value)
        except Exception as e:
            await log_exception(e, interaction)
