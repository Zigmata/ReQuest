import logging

import discord
from discord.ui import Select

from ReQuest.utilities.constants import QuestFields, CommonFields, DatabaseCollections
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
from ReQuest.utilities.character import find_member_and_character_id_in_lists
from ReQuest.utilities.db_cache import update_cached_data
from ReQuest.utilities.exceptions import log_exception
from ReQuest.utilities.discord_utils import setup_view
from ReQuest.ui.common import modals as common_modals

logger = logging.getLogger(__name__)


class PartyMemberSelect(Select):
    def __init__(self, calling_view, disabled_components=None):
        super().__init__(
            placeholder=t(DEFAULT_LOCALE, 'gm-select-placeholder-party-member'),
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
            for player in quest[QuestFields.PARTY]:
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
            placeholder=t(DEFAULT_LOCALE, 'gm-select-placeholder-party-member'),
            options=[],
            custom_id='remove_player_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.calling_view
            party = view.quest[QuestFields.PARTY]
            wait_list = view.quest[QuestFields.WAIT_LIST]
            member_id, character_id = find_member_and_character_id_in_lists([party, wait_list], self.values[0])
            view.selected_character_id = character_id
            view.selected_member_id = member_id
            locale = getattr(self.calling_view, 'locale', DEFAULT_LOCALE)
            confirm_modal = common_modals.ConfirmModal(
                title=t(locale, 'gm-modal-title-remove-from-quest'),
                prompt_label=t(locale, 'gm-modal-label-remove-from-quest'),
                confirm_callback=view.confirm_callback,
                locale=locale
            )
            await interaction.response.send_modal(confirm_modal)
        except Exception as e:
            await log_exception(e, interaction)


class PartyRoleSelect(Select):
    """Select menu for choosing a party role from the GM's assigned roles."""

    def __init__(self, calling_view, assigned_roles):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        options = [discord.SelectOption(
            label=t(locale, 'gm-select-option-no-role'),
            value='none'
        )]
        for role_assignment in assigned_roles:
            options.append(discord.SelectOption(
                label=role_assignment['roleName'],
                value=str(role_assignment['roleId'])
            ))
        super().__init__(
            placeholder=t(locale, 'gm-select-placeholder-party-role'),
            options=options,
            custom_id='edit_quest_party_role_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            quest = self.calling_view.quest
            guild_id = quest[QuestFields.GUILD_ID]
            quest_id = quest[QuestFields.QUEST_ID]
            bot = interaction.client

            selected_value = self.values[0]
            party_role_id = int(selected_value) if selected_value != 'none' else None

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUESTS,
                query={QuestFields.GUILD_ID: guild_id, QuestFields.QUEST_ID: quest_id},
                update_data={'$set': {QuestFields.PARTY_ROLE_ID: party_role_id}},
                cache_id=f'{guild_id}:{quest_id}'
            )
            quest[QuestFields.PARTY_ROLE_ID] = party_role_id

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)
