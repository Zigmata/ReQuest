import logging

import discord
from discord import ButtonStyle
from discord.ui import Button

from ReQuest.ui.gm import modals
from ReQuest.ui.common.enums import RewardType
from ReQuest.utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class CreateQuestButton(Button):
    def __init__(self, quest_view_class):
        super().__init__(
            label='Create',
            style=ButtonStyle.success,
            custom_id='create_quest_button'
        )
        self.quest_view_class = quest_view_class

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.CreateQuestModal(self.quest_view_class)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestButton(Button):
    def __init__(self, calling_view, quest_post_view_class):
        super().__init__(
            label='Edit',
            style=ButtonStyle.secondary,
            custom_id='edit_quest_button',
            disabled=True
        )
        self.calling_view = calling_view
        self.quest_post_view_class = quest_post_view_class

    async def callback(self, interaction: discord.Interaction):
        try:
            quest = self.calling_view.selected_quest
            modal = modals.EditQuestModal(self.calling_view, quest, self.quest_post_view_class)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class ToggleReadyButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Toggle Ready',
            style=ButtonStyle.secondary,
            custom_id='toggle_ready_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.calling_view.quest_ready_toggle(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class RewardsMenuButton(Button):
    def __init__(self, calling_view, rewards_view_class):
        super().__init__(
            label='Rewards',
            style=ButtonStyle.secondary,
            custom_id='rewards_menu_button',
            disabled=True
        )
        self.calling_view = calling_view
        self.rewards_view_class = rewards_view_class

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.rewards_view_class(self.calling_view)
            await new_view.setup()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class RemovePlayerButton(Button):
    def __init__(self, calling_view, target_view_class):
        super().__init__(
            label='Remove Player',
            style=ButtonStyle.danger,
            custom_id='remove_player_button',
            disabled=True
        )
        self.calling_view = calling_view
        self.target_view_class = target_view_class

    async def callback(self, interaction: discord.Interaction):
        try:
            quest = self.calling_view.selected_quest
            new_view = self.target_view_class(quest)
            await new_view.setup()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class CancelQuestButton(Button):
    def __init__(self, calling_view, target_view_class):
        super().__init__(
            label='Cancel Quest',
            style=ButtonStyle.danger,
            custom_id='cancel_quest_button',
            disabled=True
        )
        self.calling_view = calling_view
        self.target_view_class = target_view_class

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.target_view_class(self.calling_view.selected_quest)
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class PartyRewardsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Party Rewards',
            style=ButtonStyle.secondary,
            custom_id='party_rewards_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            rewards_modal = modals.RewardsModal(self, self.calling_view, RewardType.PARTY)
            await interaction.response.send_modal(rewards_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def modal_callback(self, interaction: discord.Interaction, xp, items):
        try:
            view = self.calling_view
            quest = view.quest

            rewards = quest.setdefault('rewards', {})
            party_rewards = rewards.setdefault('party', {})

            xp_val = int(xp) if xp is not None and int(xp) >= 0 else None
            items_val = items if isinstance(items, dict) else {}

            updates = {
                'rewards.party.xp': xp_val,
                'rewards.party.items': items_val
            }

            quest_collection = interaction.client.gdb['quests']
            await quest_collection.update_one(
                {'guildId': quest['guildId'], 'questId': quest['questId']},
                {'$set': updates}
            )

            party_rewards['xp'] = xp_val
            party_rewards['items'] = items_val

            await view.setup()
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class IndividualRewardsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Individual Rewards',
            style=ButtonStyle.secondary,
            custom_id='individual_rewards_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            rewards_modal = modals.RewardsModal(self, self.calling_view, RewardType.INDIVIDUAL)
            await interaction.response.send_modal(rewards_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def modal_callback(self, interaction: discord.Interaction, xp, items):
        try:
            view = self.calling_view
            quest = view.quest
            character_id = view.selected_character_id

            rewards = quest.setdefault('rewards', {})
            char_rewards = rewards.setdefault(character_id, {})

            xp_val = None
            if xp is not None:
                try:
                    xp_int = int(xp)
                    xp_val = xp_int if xp_int >= 0 else None
                except (ValueError, TypeError):
                    xp_val = None

            if items and isinstance(items, dict):
                invalid = [n for n, q in items.items() if not isinstance(q, (int, float)) or q <= 0]
                if invalid:
                    raise ValueError(f"Invalid item quantities: {', '.join(invalid)}")
                items_val = items
            else:
                items_val = {}
            updates = {
                f'rewards.{character_id}.xp': xp_val,
                f'rewards.{character_id}.items': items_val
            }

            quest_collection = interaction.client.gdb['quests']
            await quest_collection.update_one(
                {'guildId': quest['guildId'], 'questId': quest['questId']},
                {'$set': updates}
            )

            char_rewards['xp'] = xp_val
            char_rewards['items'] = items_val

            await view.setup()
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class JoinQuestButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Join',
            style=ButtonStyle.success,
            custom_id='join_quest_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.calling_view.join_callback(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class LeaveQuestButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Leave',
            style=ButtonStyle.danger,
            custom_id='leave_quest_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.calling_view.leave_callback(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class CompleteQuestButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Confirm?',
            style=ButtonStyle.danger,
            custom_id='complete_quest_button',
            disabled=True
        )
        self.calling_view = calling_view
        self.quest_summary_modal = modals.QuestSummaryModal(self)

    async def callback(self, interaction: discord.Interaction):
        try:
            quest_summary_collection = interaction.client.gdb['questSummary']
            quest_summary_config_query = await quest_summary_collection.find_one({'_id': interaction.guild_id})
            if quest_summary_config_query and quest_summary_config_query['questSummary']:
                await interaction.response.send_modal(self.quest_summary_modal)
            else:
                await self.calling_view.complete_quest(interaction)
        except Exception as e:
            await log_exception(e, interaction)

    async def modal_callback(self, interaction):
        try:
            summary = self.quest_summary_modal.summary_input.value
            await self.calling_view.complete_quest(interaction, summary=summary)
        except Exception as e:
            await log_exception(e, interaction)
