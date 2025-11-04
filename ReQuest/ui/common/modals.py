import logging

import discord
import discord.ui
from discord.ui import Modal

from ReQuest.utilities.supportFunctions import log_exception, setup_view

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class ConfirmModal(Modal):
    def __init__(self, title: str, prompt_label: str, prompt_placeholder: str, calling_view):
        super().__init__(title=title)
        self.calling_view = calling_view
        self.prompt = discord.ui.TextInput(
            label=prompt_label,
            placeholder=prompt_placeholder,
            required=True,
            max_length=7
        )
        self.add_item(self.prompt)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            if self.prompt.value.strip() == 'CONFIRM':
                await self.calling_view.confirm_callback(interaction)
            else:
                view = self.calling_view
                if hasattr(view, 'setup'):
                    await setup_view(view, interaction)
                self.calling_view.embed.add_field(name='Confirmation Failed', value=f'Operation was cancelled.')
                await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)
