import logging

import discord
from discord import ButtonStyle
from discord.ui import Button

from ReQuest.utilities.supportFunctions import log_exception, setup_view

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class BaseViewButton(Button):
    def __init__(self, target_view_class, label, style, custom_id, row=None):
        super().__init__(
            label=label,
            style=style,
            custom_id=custom_id,
            row=row
        )
        self.target_view_class = target_view_class

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.target_view_class()
            if hasattr(view, 'setup'):
                await setup_view(view, interaction)
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
    def __init__(self, target_view_class):
        super().__init__(
            target_view_class=target_view_class,
            label='Back',
            style=ButtonStyle.secondary,
            custom_id='menu_back_button',
            row=4
        )


class MenuDoneButton(Button):
    def __init__(self, row=4):
        super().__init__(
            label='Done',
            style=ButtonStyle.secondary,
            custom_id='done_button',
            row=row
        )

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.defer()
            await interaction.followup.delete_message(interaction.message.id)
        except Exception as e:
            await log_exception(e, interaction)


class ConfirmButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Confirm',
            style=ButtonStyle.danger,
            custom_id='confirm_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.calling_view.confirm_callback(interaction)
        except Exception as e:
            await log_exception(e, interaction)
