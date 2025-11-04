import logging

import discord
from discord.ui import Select

from ReQuest.utilities.supportFunctions import log_exception
from ReQuest.ui.common import modals

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class ActiveCharacterSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='You have no registered characters',
            options=[],
            custom_id='active_character_select',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            selected_character_id = self.values[0]
            collection = interaction.client.mdb['characters']
            await collection.update_one({'_id': interaction.user.id},
                                        {'$set': {f'activeCharacters.{interaction.guild_id}': selected_character_id}},
                                        upsert=True)
            await self.calling_view.setup(bot=interaction.client, user=interaction.user, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveCharacterSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select a character to remove',
            options=[],
            custom_id='remove_character_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            selected_character_id = self.values[0]
            self.calling_view.selected_character_id = selected_character_id
            confirm_modal = modals.ConfirmModal(
                title='Confirm Character Removal',
                prompt_label='WARNING: This action is irreversible!',
                prompt_placeholder='Type CONFIRM to proceed',
                calling_view=self.calling_view
            )
            await interaction.response.send_modal(confirm_modal)
        except Exception as e:
            await log_exception(e, interaction)


class ManageablePostSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select a post',
            options=[],
            custom_id='manageable_post_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.calling_view.select_callback(interaction)
        except Exception as e:
            await log_exception(e, interaction)
