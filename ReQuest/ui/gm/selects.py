import logging

import discord
from discord.ui import Select

from ReQuest.utilities.supportFunctions import log_exception, find_member_and_character_id_in_lists, setup_view
from ReQuest.ui.common import modals as common_modals

logger = logging.getLogger(__name__)


class PartyMemberSelect(Select):
    def __init__(self, calling_view, disabled_components=None):
        super().__init__(
            placeholder='Select a party member',
            options=[],
            custom_id='party_member_select',
            disabled=True
        )
        self.calling_view = calling_view
        self.disabled_components = disabled_components

    async def callback(self, interaction: discord.Interaction):
        try:
            character_id = self.values[0]
            view = self.calling_view
            quest = view.quest
            for player in quest['party']:
                for member_id in player:
                    for character_id_key in player[str(member_id)]:
                        if character_id_key == character_id:
                            character = player[str(member_id)][character_id]
                            view.selected_character = character
                            view.selected_character_id = character_id
            await setup_view(view, interaction)
            if self.disabled_components:
                for component in self.disabled_components:
                    component.disabled = False
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class RemovePlayerSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select a party member',
            options=[],
            custom_id='remove_player_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.calling_view
            party = view.quest['party']
            wait_list = view.quest['waitList']
            member_id, character_id = find_member_and_character_id_in_lists([party, wait_list], self.values[0])
            view.selected_character_id = character_id
            view.selected_member_id = member_id
            confirm_modal = common_modals.ConfirmModal(
                title=f'Remove character from quest',
                prompt_label=f'Confirm character removal?',
                prompt_placeholder='Type "CONFIRM" to proceed.',
                confirm_callback=view.confirm_callback
            )
            await interaction.response.send_modal(confirm_modal)
        except Exception as e:
            await log_exception(e, interaction)
