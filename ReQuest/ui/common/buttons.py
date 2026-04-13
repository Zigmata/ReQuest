import inspect
import logging

import discord
from discord import ButtonStyle
from discord.ui import Button

from ReQuest.utilities.constants import DiscordLimits
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
from ReQuest.utilities.exceptions import log_exception
from ReQuest.utilities.discord_utils import setup_view

logger = logging.getLogger(__name__)


class BaseViewButton(Button):
    def __init__(self, target_view_class, label, style, custom_id):
        super().__init__(
            label=label[:DiscordLimits.BUTTON_LABEL],
            style=style,
            custom_id=custom_id
        )
        self.target_view_class = target_view_class

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.defer()
            locale = getattr(self.view, 'locale', DEFAULT_LOCALE)
            init_params = inspect.signature(self.target_view_class.__init__).parameters
            if 'locale' in init_params:
                view = self.target_view_class(locale=locale)
            else:
                view = self.target_view_class()
            view.locale = locale
            if hasattr(view, 'setup'):
                await setup_view(view, interaction)
            elif hasattr(view, 'build_view'):
                view.build_view()
            await interaction.edit_original_response(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class MenuViewButton(BaseViewButton):
    def __init__(self, target_view_class, label: str):
        super().__init__(
            target_view_class=target_view_class,
            label=label,
            style=ButtonStyle.primary,
            custom_id=f'{label.lower()}_view_button'
        )


class BackButton(BaseViewButton):
    def __init__(self, target_view_class, locale=None):
        self._locale = locale or DEFAULT_LOCALE
        super().__init__(
            target_view_class=target_view_class,
            label=t(self._locale, 'common-btn-back')[:DiscordLimits.BUTTON_LABEL],
            style=ButtonStyle.secondary,
            custom_id='menu_back_button'
        )


class MenuDoneButton(Button):
    def __init__(self, locale=None):
        self._locale = locale or DEFAULT_LOCALE
        super().__init__(
            label=t(self._locale, 'common-btn-done')[:DiscordLimits.BUTTON_LABEL],
            style=ButtonStyle.secondary,
            custom_id='done_button'
        )

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.defer()
            await interaction.followup.delete_message(interaction.message.id)
        except Exception as e:
            await log_exception(e, interaction)
