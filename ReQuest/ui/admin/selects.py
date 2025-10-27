import logging

import discord
from discord.ui import Select

from ReQuest.utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class RemoveGuildAllowlistSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select a server to remove',
            options=[],
            custom_id='remove_guild_allowlist_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.calling_view
            guild_id = int(self.values[0])
            collection = interaction.client.cdb['serverAllowlist']
            query = await collection.find_one({'servers': {'$exists': True}, 'servers.id': guild_id})
            server = next((server for server in query['servers'] if server['id'] == guild_id))
            logger.debug(f'Found server: {server}')
            view.selected_guild = server['id']
            view.confirm_allowlist_remove_button.disabled = False
            view.confirm_allowlist_remove_button.label = f'Confirm removal of {server['name']}'
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)
