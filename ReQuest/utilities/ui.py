import traceback

import discord
from discord.ui import Button, View, Select


class SingleChoiceDropdown(Select):
    def __init__(self, placeholder=None, options=None):
        super().__init__(placeholder=placeholder, min_values=1, max_values=1, options=options)

    async def callback(self, interaction: discord.Interaction):
        self.view.stop()


class DropdownView(View):
    def __init__(self, dropdown: Select):
        super().__init__()

        self.add_item(dropdown)


class ConfirmationButtonView(View):
    def __init__(self):
        super().__init__(timeout=30)
        self.value = None

    @discord.ui.button(label='Confirm', style=discord.ButtonStyle.green, custom_id='confirm_button')
    async def confirm(self, interaction: discord.Interaction, button: Button):
        self.value = True
        self.stop()

    @discord.ui.button(label='Cancel', style=discord.ButtonStyle.red, custom_id='cancel_button')
    async def cancel(self, interaction: discord.Interaction, button: Button):
        self.value = False
        self.stop()


class TextInputModal(discord.ui.Modal):
    input_field = discord.ui.TextInput(label='A', style=discord.TextStyle.paragraph)
    definition = None

    async def on_submit(self, interaction: discord.Interaction):
        await interaction.response.send_message(f'Submitted!', ephemeral=True)
        self.definition = self.input_field.value

    async def on_error(self, interaction: discord.Interaction, error: Exception) -> None:
        await interaction.response.send_message('Oops! Something went wrong.', ephemeral=True)

        traceback.print_tb(error.__traceback__)
