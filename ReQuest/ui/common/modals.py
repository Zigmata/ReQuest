import logging

import discord
import discord.ui
from discord.ui import Modal

from ReQuest.utilities.constants import DiscordLimits
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
from ReQuest.utilities.exceptions import log_exception, UserFeedbackError

logger = logging.getLogger(__name__)


class LocaleModal(Modal):
    """Modal subclass with locale support."""
    pass


class ConfirmModal(LocaleModal):
    def __init__(self, title: str, prompt_label: str, confirm_callback, locale=None):
        self._locale = locale or DEFAULT_LOCALE
        self.confirm_word = t(self._locale, 'common-confirm-word')
        prompt_placeholder = t(self._locale, 'common-confirm-placeholder', confirmWord=self.confirm_word)
        super().__init__(title=title[:DiscordLimits.MODAL_TITLE])
        self.confirm_callback = confirm_callback
        self.prompt = discord.ui.TextInput(
            placeholder=prompt_placeholder[:DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            required=True,
            max_length=len(self.confirm_word)
        )
        self.prompt_label = discord.ui.Label(
            text=prompt_label[:DiscordLimits.LABEL_LABEL],
            component=self.prompt
        )
        self.add_item(self.prompt_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            if self.prompt.value.strip() == self.confirm_word:
                await self.confirm_callback(interaction)
            else:
                raise UserFeedbackError(
                    t(self._locale, 'common-confirm-failed'),
                    message_id='common-confirm-failed'
                )
        except Exception as e:
            await log_exception(e, interaction)


class PageJumpModal(LocaleModal):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(self._locale, 'common-page-jump-title')[:DiscordLimits.MODAL_TITLE],
            timeout=180
        )
        self.calling_view = calling_view
        self.page_number_input = discord.ui.TextInput(
            custom_id='page_number_input',
            placeholder=t(self._locale, 'common-page-jump-placeholder',
                         totalPages=str(self.calling_view.total_pages))[:DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            required=True,
            max_length=len(str(self.calling_view.total_pages))
        )
        self.page_number_label = discord.ui.Label(
            text=t(self._locale, 'common-page-jump-label')[:DiscordLimits.LABEL_LABEL],
            component=self.page_number_input
        )
        self.add_item(self.page_number_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            input_value = self.page_number_input.value
            if not input_value.isdigit():
                await interaction.response.send_message(f"Input must be a number.", ephemeral=True)
                return

            page_num = int(input_value)

            if not 1 <= page_num <= self.calling_view.total_pages:
                await interaction.response.send_message(
                    f"Page number must be between 1 and {self.calling_view.total_pages}.",
                    ephemeral=True
                )
                return

            self.calling_view.current_page = page_num - 1

            self.calling_view.build_view()

            await interaction.response.edit_message(view=self.calling_view)

        except Exception as e:
            await log_exception(e, interaction)
