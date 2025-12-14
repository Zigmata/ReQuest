import logging

import discord
from discord.ui import Select

from ReQuest.utilities.supportFunctions import log_exception, setup_view, update_cached_data
from ReQuest.ui.common import modals

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
            bot = interaction.client
            selected_character_id = self.values[0]

            await update_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': interaction.user.id},
                update_data={'$set': {f'activeCharacters.{interaction.guild_id}': selected_character_id}}
            )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
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
                confirm_callback=self.calling_view.confirm_callback
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
