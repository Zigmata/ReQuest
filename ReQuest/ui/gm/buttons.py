import asyncio
import logging

import discord
from discord import ButtonStyle
from discord.ui import Button

from ReQuest.ui.common.modals import ConfirmModal
from ReQuest.ui.gm import modals
from ReQuest.ui.common.enums import RewardType
from ReQuest.utilities.constants import QuestFields, ConfigFields, CommonFields, DatabaseCollections
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE, resolve_user_locale
from ReQuest.utilities.db_cache import get_cached_data, update_cached_data, delete_cached_data, build_cache_key
from ReQuest.utilities.discord_utils import setup_view, strip_id, attempt_delete, get_guild_member, check_role_hierarchy
from ReQuest.utilities.exceptions import log_exception

logger = logging.getLogger(__name__)


class CreateQuestButton(Button):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        super().__init__(
            label=t(locale, 'gm-btn-create'),
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
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        super().__init__(
            label=t(locale, 'gm-btn-edit-details'),
            style=ButtonStyle.primary,
            custom_id='edit_quest_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.gm.views import EditQuestView
            view = EditQuestView(self.calling_view.selected_quest)
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestTitleButton(Button):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        super().__init__(
            label=t(locale, 'gm-btn-edit-field'),
            style=ButtonStyle.primary,
            custom_id='edit_quest_title_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.EditQuestTitleModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestDescriptionButton(Button):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        super().__init__(
            label=t(locale, 'gm-btn-edit-field'),
            style=ButtonStyle.primary,
            custom_id='edit_quest_description_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.EditQuestDescriptionModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestRestrictionsButton(Button):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        super().__init__(
            label=t(locale, 'gm-btn-edit-field'),
            style=ButtonStyle.primary,
            custom_id='edit_quest_restrictions_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.EditQuestRestrictionsModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestPartySizeButton(Button):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        super().__init__(
            label=t(locale, 'gm-btn-edit-field'),
            style=ButtonStyle.primary,
            custom_id='edit_quest_party_size_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.EditQuestMaxPartySizeModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestPartyRoleButton(Button):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        super().__init__(
            label=t(locale, 'gm-btn-edit-field'),
            style=ButtonStyle.primary,
            custom_id='edit_quest_party_role_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.EditQuestPartyRoleModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class ClearPartyRoleButton(Button):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        has_role = calling_view.quest.get(QuestFields.PARTY_ROLE_ID) is not None
        super().__init__(
            label=t(locale, 'gm-btn-clear'),
            style=ButtonStyle.danger,
            custom_id='clear_party_role_button',
            disabled=not has_role
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            quest = self.calling_view.quest
            guild_id = quest[QuestFields.GUILD_ID]
            quest_id = quest[QuestFields.QUEST_ID]
            bot = interaction.client

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUESTS,
                query={QuestFields.GUILD_ID: guild_id, QuestFields.QUEST_ID: quest_id},
                update_data={'$set': {QuestFields.PARTY_ROLE_ID: None}},
                cache_id=f'{guild_id}:{quest_id}'
            )
            quest[QuestFields.PARTY_ROLE_ID] = None

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestImageButton(Button):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        super().__init__(
            label=t(locale, 'gm-btn-edit-field'),
            style=ButtonStyle.primary,
            custom_id='edit_quest_image_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.EditQuestImageUrlModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestLargeImageButton(Button):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        super().__init__(
            label=t(locale, 'gm-btn-edit-field'),
            style=ButtonStyle.primary,
            custom_id='edit_quest_large_image_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.EditQuestLargeImageUrlModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class ToggleReadyButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'gm-btn-toggle-ready'),
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
            label=t(DEFAULT_LOCALE, 'gm-btn-configure-rewards'),
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
            label=t(DEFAULT_LOCALE, 'gm-btn-remove-player'),
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
            label=t(DEFAULT_LOCALE, 'gm-btn-cancel-quest'),
            style=ButtonStyle.danger,
            custom_id='cancel_quest_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            locale = getattr(self.calling_view, 'locale', DEFAULT_LOCALE)
            confirm_modal = ConfirmModal(
                title=t(locale, 'gm-modal-title-cancel-quest'),
                prompt_label=t(locale, 'gm-modal-label-cancel-quest'),
                confirm_callback=self.confirm_callback,
                locale=locale
            )
            await interaction.response.send_modal(confirm_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def confirm_callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.defer()
            bot = interaction.client
            quest = self.calling_view.selected_quest
            guild_id = interaction.guild_id
            guild = interaction.guild

            # If a party exists
            party = quest[QuestFields.PARTY]
            title = quest[QuestFields.TITLE]
            if party:
                # Get party members and message them with results
                for player in party:
                    for member_id in player:
                        # Message the player that the quest was canceled.
                        member = await get_guild_member(guild, int(member_id))
                        if member:
                            try:
                                member_locale = await resolve_user_locale(bot, int(member_id), guild_id)
                                await member.send(t(member_locale, 'gm-dm-quest-cancelled', questTitle=title))
                            except discord.errors.Forbidden as e:
                                logger.warning(f'Could not DM {member_id} about quest cancellation: {e}')
                            except Exception as e:
                                logger.warning(f'Unexpected error while attempting to DM {member_id}: {e}')
                        else:
                            logger.warning(f'Could not find member {member_id} in guild {guild_id}.')

            # Remove the party role, if applicable
            party_role_id = quest[QuestFields.PARTY_ROLE_ID]
            if party_role_id:
                party_role = guild.get_role(party_role_id)
                if party_role:
                    check_role_hierarchy(guild, party_role)
                    role_mode = quest.get(QuestFields.QUEST_ROLE_MODE, 'temporary')
                    if role_mode == 'static':
                        if not guild.chunked:
                            await guild.chunk()
                        remove_tasks = []
                        remove_members = []
                        for player in party:
                            for member_id in player:
                                member = guild.get_member(int(member_id))
                                if member:
                                    remove_tasks.append(member.remove_roles(party_role))
                                    remove_members.append(member)
                        if remove_tasks:
                            results = await asyncio.gather(*remove_tasks, return_exceptions=True)
                            failed_members = []
                            for member, result in zip(remove_members, results):
                                if isinstance(result, Exception):
                                    logger.warning(
                                        f'Failed to remove role {party_role.name} '
                                        f'from {member} (ID: {member.id}): {result}'
                                    )
                                    failed_members.append(member)
                            if failed_members:
                                gm_locale = await resolve_user_locale(bot, interaction.user.id, guild_id)
                                failed_list = ', '.join(m.mention for m in failed_members)
                                await interaction.user.send(
                                    t(
                                        gm_locale, 'gm-dm-role-removal-failed',
                                        roleName=party_role.name, members=failed_list
                                    )
                                )
                    else:
                        await party_role.delete(
                            reason=(
                                f'Quest {quest[QuestFields.QUEST_ID]} cancelled '
                                f'by {interaction.user.mention}.'
                            )
                        )
                else:
                    logger.warning(f'Quest role {party_role_id} no longer exists in guild {guild_id}. '
                                   f'Skipping role cleanup for cancelled quest {quest[QuestFields.QUEST_ID]}.')
                    try:
                        gm_locale = await resolve_user_locale(bot, interaction.user.id, guild_id)
                        await interaction.user.send(
                            t(gm_locale, 'gm-dm-role-not-found', roleId=str(party_role_id), questTitle=title)
                        )
                    except discord.errors.Forbidden:
                        logger.warning(f'Could not DM {interaction.user.id} about missing quest role.')

            # Delete the quest from the database
            await delete_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUESTS,
                search_filter={QuestFields.GUILD_ID: guild_id, QuestFields.QUEST_ID: quest[QuestFields.QUEST_ID]},
                cache_id=f'{guild_id}:{quest[QuestFields.QUEST_ID]}'
            )

            # Delete the quest from the redis cache
            admin_list_key = build_cache_key(bot.gdb.name, f'guild_quests:{guild_id}', 'quests')
            await bot.rdb.delete(admin_list_key)

            gm_list_key = build_cache_key(bot.gdb.name, f'gm_quests:{guild_id}:{quest[QuestFields.GM]}', 'quests')
            await bot.rdb.delete(gm_list_key)

            # Delete the quest from the quest channel
            channel_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUEST_CHANNEL,
                query={CommonFields.ID: guild_id}
            )
            channel_id = strip_id(channel_query[ConfigFields.QUEST_CHANNEL])
            quest_channel = guild.get_channel(channel_id)
            message_id = quest[QuestFields.MESSAGE_ID]
            message = quest_channel.get_partial_message(message_id)
            await attempt_delete(message)

            from ReQuest.ui.gm.views import GMQuestMenuView
            view = GMQuestMenuView()
            await setup_view(view, interaction)
            await interaction.edit_original_response(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class PartyRewardsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'gm-btn-manage-party-rewards'),
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

            rewards = quest.setdefault(QuestFields.REWARDS, {})
            party_rewards = rewards.setdefault(QuestFields.PARTY, {})

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
                f'{QuestFields.REWARDS}.{QuestFields.PARTY}.{QuestFields.XP}': xp_val,
                f'{QuestFields.REWARDS}.{QuestFields.PARTY}.{CommonFields.ITEMS}': items_val
            }

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUESTS,
                query={
                    QuestFields.GUILD_ID: quest[QuestFields.GUILD_ID],
                    QuestFields.QUEST_ID: quest[QuestFields.QUEST_ID]
                },
                update_data={'$set': updates},
                cache_id=f'{quest[QuestFields.GUILD_ID]}:{quest[QuestFields.QUEST_ID]}'
            )

            party_rewards[QuestFields.XP] = xp_val
            party_rewards[CommonFields.ITEMS] = items_val

            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class IndividualRewardsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'gm-btn-manage-individual-rewards'),
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

            rewards = quest.setdefault(QuestFields.REWARDS, {})
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
                f'{QuestFields.REWARDS}.{character_id}.{QuestFields.XP}': xp_val,
                f'{QuestFields.REWARDS}.{character_id}.{CommonFields.ITEMS}': items_val
            }

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUESTS,
                query={
                    QuestFields.GUILD_ID: quest[QuestFields.GUILD_ID],
                    QuestFields.QUEST_ID: quest[QuestFields.QUEST_ID]
                },
                update_data={'$set': updates},
                cache_id=f'{quest[QuestFields.GUILD_ID]}:{quest[QuestFields.QUEST_ID]}'
            )

            char_rewards[QuestFields.XP] = xp_val
            char_rewards[CommonFields.ITEMS] = items_val

            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class JoinQuestButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'gm-btn-join'),
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
            label=t(DEFAULT_LOCALE, 'gm-btn-leave'),
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
            label=t(DEFAULT_LOCALE, 'gm-btn-complete-quest'),
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
                collection_name=DatabaseCollections.QUEST_SUMMARY,
                query={CommonFields.ID: interaction.guild_id}
            )

            if quest_summary_config_query and quest_summary_config_query['questSummary']:
                await interaction.response.send_modal(self.quest_summary_modal)
            else:
                await self.calling_view.complete_quest(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class ManageQuestRowButton(Button):
    def __init__(self, quest):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-manage'),
            style=ButtonStyle.secondary,
            custom_id=f'manage_quest_{quest[QuestFields.QUEST_ID]}'
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
            label=t(DEFAULT_LOCALE, 'common-btn-back'),
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
