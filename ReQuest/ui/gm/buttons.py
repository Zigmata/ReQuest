import logging

import discord
from discord import ButtonStyle
from discord.ui import Button

from ReQuest.ui.common.modals import ConfirmModal
from ReQuest.ui.gm import modals
from ReQuest.ui.common.enums import RewardType
from ReQuest.utilities.supportFunctions import (
    log_exception,
    setup_view,
    strip_id,
    attempt_delete,
    get_cached_data,
    update_cached_data,
    delete_cached_data, build_cache_key
)

logger = logging.getLogger(__name__)


class CreateQuestButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Create',
            style=ButtonStyle.success,
            custom_id='create_quest_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.CreateQuestModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Edit Details',
            style=ButtonStyle.primary,
            custom_id='edit_quest_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            quest = self.calling_view.selected_quest
            modal = modals.EditQuestModal(self.calling_view, quest)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class ToggleReadyButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Toggle Ready',
            style=ButtonStyle.primary,
            custom_id='toggle_ready_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.calling_view.quest_ready_toggle(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class RewardsMenuButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Configure Rewards',
            style=ButtonStyle.primary,
            custom_id='rewards_menu_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.gm.views import RewardsMenuView
            new_view = RewardsMenuView(self.calling_view)
            await setup_view(new_view, interaction)
            await interaction.response.edit_message(view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class RemovePlayerButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Remove Player',
            style=ButtonStyle.danger,
            custom_id='remove_player_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            quest = self.calling_view.selected_quest
            from ReQuest.ui.gm.views import RemovePlayerView
            new_view = RemovePlayerView(quest)
            await setup_view(new_view, interaction)
            await interaction.response.edit_message(view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class CancelQuestButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Cancel Quest',
            style=ButtonStyle.danger,
            custom_id='cancel_quest_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            confirm_modal = ConfirmModal(
                title='Cancel Quest',
                prompt_label='Type CONFIRM to cancel the quest.',
                prompt_placeholder='Type "CONFIRM" to proceed.',
                confirm_callback=self.confirm_callback
            )
            await interaction.response.send_modal(confirm_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def confirm_callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            quest = self.calling_view.selected_quest
            guild_id = interaction.guild_id
            guild = interaction.guild

            # If a party exists
            party = quest['party']
            title = quest['title']
            if party:
                # Get party members and message them with results
                for player in party:
                    for member_id in player:
                        # Message the player that the quest was canceled.
                        member = await guild.fetch_member(int(member_id))
                        try:
                            await member.send(f'Quest **{title}** was cancelled by the GM.')
                        except discord.errors.Forbidden as e:
                            logger.warning(f'Could not DM {member.id} about quest cancellation: {e}')

            # Remove the party role, if applicable
            party_role_id = quest['partyRoleId']
            if party_role_id:
                party_role = guild.get_role(party_role_id)
                await party_role.delete(reason=f'Quest {quest['questId']} cancelled by {interaction.user.mention}.')

            # Delete the quest from the database
            await delete_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='quests',
                search_filter={'guildId': guild_id, 'questId': quest['questId']},
                cache_id=f'{guild_id}:{quest["questId"]}'
            )

            # Delete the quest from the redis cache
            admin_list_key = build_cache_key(bot.gdb.name, f'guild_quests:{guild_id}', 'quests')
            await bot.rdb.delete(admin_list_key)

            gm_list_key = build_cache_key(bot.gdb.name, f'gm_quests:{guild_id}:{quest["gm"]}', 'quests')
            await bot.rdb.delete(gm_list_key)

            # Delete the quest from the quest channel
            channel_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='questChannel',
                query={'_id': guild_id}
            )
            channel_id = strip_id(channel_query['questChannel'])
            quest_channel = guild.get_channel(channel_id)
            message_id = quest['messageId']
            message = quest_channel.get_partial_message(message_id)
            await attempt_delete(message)

            from ReQuest.ui.gm.views import GMQuestMenuView
            view = GMQuestMenuView()
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class PartyRewardsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Manage Party Rewards',
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
            bot = interaction.client
            view = self.calling_view
            quest = view.quest

            rewards = quest.setdefault('rewards', {})
            party_rewards = rewards.setdefault('party', {})

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
                    raise ValueError(f"Invalid item quantities: {', '.join(map(str, invalid))}")
                items_val = items
            else:
                items_val = {}
            updates = {
                'rewards.party.xp': xp_val,
                'rewards.party.items': items_val
            }

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='quests',
                query={'guildId': quest['guildId'], 'questId': quest['questId']},
                update_data={'$set': updates},
                cache_id=f'guild_quest:{quest["guildId"]}:{quest["questId"]}'
            )

            party_rewards['xp'] = xp_val
            party_rewards['items'] = items_val

            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class IndividualRewardsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Manage Individual Rewards',
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
            bot = interaction.client
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

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='quests',
                query={'guildId': quest['guildId'], 'questId': quest['questId']},
                update_data={'$set': updates},
                cache_id=f'guild_quest:{quest["guildId"]}:{quest["questId"]}'
            )

            char_rewards['xp'] = xp_val
            char_rewards['items'] = items_val

            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
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
            label='Complete Quest',
            style=ButtonStyle.success,
            custom_id='complete_quest_button'
        )
        self.calling_view = calling_view
        self.quest_summary_modal = modals.QuestSummaryModal(self.calling_view)

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client

            quest_summary_config_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='questSummary',
                query={'_id': interaction.guild_id}
            )

            if quest_summary_config_query and quest_summary_config_query['questSummary']:
                await interaction.response.send_modal(self.quest_summary_modal)
            else:
                await self.calling_view.complete_quest(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class ReviewSubmissionButton(Button):
    def __init__(self, calling_view):
        super().__init__(label="Review Submission", style=ButtonStyle.success)
        self.calling_view = calling_view

    async def callback(self, interaction):
        await interaction.response.send_modal(modals.ReviewSubmissionInputModal(self.calling_view))


class ApproveSubmissionButton(Button):
    def __init__(self, calling_view):
        super().__init__(label="Approve", style=ButtonStyle.success)
        self.calling_view = calling_view

    async def callback(self, interaction):
        await self.calling_view.approve(interaction)


class DenySubmissionButton(Button):
    def __init__(self, calling_view):
        super().__init__(label="Deny", style=ButtonStyle.danger)
        self.calling_view = calling_view

    async def callback(self, interaction):
        await self.calling_view.deny(interaction)


class ManageQuestRowButton(Button):
    def __init__(self, quest):
        super().__init__(
            label='Manage',
            style=ButtonStyle.secondary,
            custom_id=f'manage_quest_{quest["questId"]}'
        )
        self.quest = quest

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.gm.views import ManageQuestsView
            view = ManageQuestsView(self.quest)
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class BackToManageQuestButton(Button):
    def __init__(self, quest):
        super().__init__(
            label='Back',
            style=ButtonStyle.secondary,
            custom_id='back_to_manage_quest'
        )
        self.quest = quest

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.gm.views import ManageQuestsView
            view = ManageQuestsView(self.quest)
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)
