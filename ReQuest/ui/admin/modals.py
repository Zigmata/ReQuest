import logging
from datetime import datetime, timezone

import discord
import discord.ui
import shortuuid
from discord.ui import Modal

from ReQuest.ui.inputs import AddCurrencyDenominationTextInput
from ReQuest.utilities.supportFunctions import find_currency_or_denomination, log_exception, trade_currency, trade_item, \
    normalize_currency_keys, consolidate_currency, strip_id, update_character_inventory, update_character_experience, \
    purge_player_board

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
            style=discord.TextStyle.short,
            custom_id='allow_server_name_input',
            placeholder='Type a short name for the Discord Server',
            required=True
        )
        self.allow_server_id_input = discord.ui.TextInput(
            label='Server ID',
            style=discord.TextStyle.short,
            custom_id='allow_server_text_input',
            placeholder='Type the ID of the Discord Server',
            required=True
        )
        self.add_item(self.allow_server_name_input)
        self.add_item(self.allow_server_id_input)

    async def on_submit(self, interaction):
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
        self.text_input = discord.ui.TextInput(label='Name', style=discord.TextStyle.short,
                                               placeholder=f'Enter the name of the Cog to {function}',
                                               custom_id='cog_name_text_input', required=True)
        self.add_item(self.text_input)
        self._on_submit = on_submit

    async def on_submit(self, interaction):
        try:
            await self._on_submit(interaction, self.text_input.value)
        except Exception as e:
            await log_exception(e, interaction)