import logging
import discord
from discord.ui import Modal
from ReQuest.utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class PageJumpModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Go to Page',
            timeout=180
        )
        self.calling_view = calling_view
        self.page_number_input = discord.ui.TextInput(
            label='Page Number',
            custom_id='page_number_input',
            placeholder=f'Enter a number from 1 to {self.calling_view.total_pages}',
            required=True,
            max_length=len(str(self.calling_view.total_pages))
        )
        self.add_item(self.page_number_input)

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
