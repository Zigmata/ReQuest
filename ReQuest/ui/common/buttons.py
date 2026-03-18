import logging

import discord
from discord import ButtonStyle
from discord.ui import Button

from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
from ReQuest.utilities.supportFunctions import log_exception, setup_view

logger = logging.getLogger(__name__)


class BaseViewButton(Button):
    def __init__(self, target_view_class, label, style, custom_id):
        super().__init__(
            label=label,
            style=style,
            custom_id=custom_id
        )
        self.target_view_class = target_view_class

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.target_view_class()
            locale = getattr(self.view, 'locale', DEFAULT_LOCALE)
            view.locale = locale
            if hasattr(view, 'setup'):
                await setup_view(view, interaction)
            elif hasattr(view, 'build_view'):
                view.build_view()
            await interaction.response.edit_message(view=view)
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
            label=t(self._locale, 'common-btn-back'),
            style=ButtonStyle.secondary,
            custom_id='menu_back_button'
        )


class MenuDoneButton(Button):
    def __init__(self, locale=None):
        self._locale = locale or DEFAULT_LOCALE
        super().__init__(
            label=t(self._locale, 'common-btn-done'),
            style=ButtonStyle.secondary,
            custom_id='done_button'
        )

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.defer()
            await interaction.followup.delete_message(interaction.message.id)
        except Exception as e:
            await log_exception(e, interaction)
