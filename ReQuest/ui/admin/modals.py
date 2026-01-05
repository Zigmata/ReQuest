import logging

import discord
import discord.ui
from discord.ui import Modal

from ReQuest.utilities.supportFunctions import log_exception, update_cached_data

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
            bot = interaction.client

            await update_cached_data(
                bot=bot,
                mongo_database=bot.cdb,
                collection_name='serverAllowlist',
                query={'servers': {'$exists': True}},
                update_data={'$push': {'servers': {'name': input_name, 'id': guild_id}}},
                cache_id=f'{guild_id}'
            )

            interaction.client.allow_list.append(guild_id)

            view = self.calling_view

            if view.remove_guild_allowlist_select.disabled:
                view.remove_guild_allowlist_select.disabled = False
                view.remove_guild_allowlist_select.placeholder = 'Select a server to remove'
                view.remove_guild_allowlist_select.options.clear()

            view.remove_guild_allowlist_select.options.append(
                discord.SelectOption(label=input_name, value=str(guild_id))
            )

            await interaction.response.edit_message(view=self.calling_view)
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
