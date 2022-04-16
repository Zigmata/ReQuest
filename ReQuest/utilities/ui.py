import discord


class SingleChoiceDropdown(discord.ui.Select):
    def __init__(self, placeholder=None, options=None):
        super().__init__(placeholder=placeholder, min_values=1, max_values=1, options=options)

    async def callback(self, interaction: discord.Interaction):
        # await interaction.response.send_message(f'{self.values[0]} selected.', ephemeral=True)
        self.view.stop()


class DropdownView(discord.ui.View):
    def __init__(self, dropdown: discord.ui.Select):
        super().__init__()

        self.add_item(dropdown)
