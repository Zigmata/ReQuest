import logging

import discord
import discord.ui
from discord.ui import Modal

from ReQuest.utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class AllowServerModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Add Server ID to Allowlist',
            timeout=180
        )
        self.calling_view = calling_view
        self.allow_server_name_input = discord.ui.TextInput(
            label='Server Name',
            custom_id='allow_server_name_input',
            placeholder='Type a short name for the Discord Server'
        )
        self.allow_server_id_input = discord.ui.TextInput(
            label='Server ID',
            custom_id='allow_server_text_input',
            placeholder='Type the ID of the Discord Server'
        )
        self.add_item(self.allow_server_name_input)
        self.add_item(self.allow_server_id_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            input_name = self.allow_server_name_input.value
            guild_id = int(self.allow_server_id_input.value)
            collection = interaction.client.cdb['serverAllowlist']
            interaction.client.allow_list.append(guild_id)
            await collection.update_one({'servers': {'$exists': True}},
                                        {'$push': {'servers': {'name': input_name, 'id': guild_id}}},
                                        upsert=True)
            await self.calling_view.setup(bot=interaction.client)
            await self.calling_view.embed.add_field(name=f'{input_name} added to allowlist', value=f'ID: `{guild_id}`')
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class AdminCogTextModal(Modal):
    def __init__(self, function, on_submit):
        super().__init__(
            title=f'{function.capitalize()} Cog',
            timeout=180
        )
        self.text_input = discord.ui.TextInput(
            label='Name',
            placeholder=f'Enter the name of the Cog to {function}',
            custom_id='cog_name_text_input'
        )
        self.add_item(self.text_input)
        self._on_submit = on_submit

    async def on_submit(self, interaction: discord.Interaction):
        try:
            await self._on_submit(interaction, self.text_input.value)
        except Exception as e:
            await log_exception(e, interaction)
