import inspect
import logging

from discord import ButtonStyle
from discord.ui import Button

import ReQuest.ui.modals as modals
from ..utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class BaseViewButton(Button):
    def __init__(self, target_view_class, label, style, custom_id):
        super().__init__(
            label=label,
            style=style,
            custom_id=custom_id
        )
        self.target_view_class = target_view_class

    async def callback(self, interaction):
        try:
            view = self.target_view_class()
            if hasattr(view, 'setup'):
                setup_function = view.setup
                sig = inspect.signature(setup_function)
                params = sig.parameters

                kwargs = {}
                if 'bot' in params:
                    kwargs['bot'] = interaction.client
                if 'user' in params:
                    kwargs['user'] = interaction.user
                if 'guild' in params:
                    kwargs['guild'] = interaction.guild

                await setup_function(**kwargs)
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)

class MenuViewButton(BaseViewButton):
    def __init__(self, target_view_class, label):
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
            custom_id='menu_back_button'
        )

class MenuDoneButton(Button):
    def __init__(self):
        super().__init__(
            label='Done',
            style=ButtonStyle.gray,
            custom_id='done_button'
        )

    async def callback(self, interaction):
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

    async def callback(self, interaction):
        try:
            await self.calling_view.confirm_callback(interaction)
        except Exception as e:
            await log_exception(e, interaction)