import asyncio
import logging
import math
from typing import Any, Dict, Iterator, Tuple

import discord
from discord.ui import (
    View,
    LayoutView,
    Container,
    TextDisplay,
    Separator,
    ActionRow,
    Section,
    Button
)
from titlecase import titlecase

from ReQuest.ui.common.buttons import MenuDoneButton, BackButton
from ReQuest.ui.common.modals import PageJumpModal
from ReQuest.ui.common.views import MenuBaseView
from ReQuest.ui.gm import buttons, selects
from ReQuest.utilities.supportFunctions import (
    log_exception,
    strip_id,
    update_character_inventory,
    update_character_experience,
    attempt_delete,
    update_quest_embed,
    format_currency_display,
    setup_view,
    format_consolidated_totals,
    get_xp_config,
    UserFeedbackError,
    get_cached_data,
    delete_cached_data,
    update_cached_data,
    build_cache_key
)

logger = logging.getLogger(__name__)


class GMBaseView(MenuBaseView):
    def __init__(self):
        super().__init__(
            title='Game Master - Main Menu',
            menu_items=[
                {
                    'name': 'Quests',
                    'description': 'Functions for creating, posting, and managing quests.',
                    'view_class': GMQuestMenuView
                },
                {
                    'name': 'Players',
                    'description': 'Player management information.',
                    'view_class': GMPlayerMenuView
                },
                {
                    'name': 'Character Approvals',
                    'description': 'Review pending inventory submissions.',
                    'view_class': GMApprovalsView
                }
            ],
            menu_level=0
        )


class GMQuestMenuView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.quests = []

        self.items_per_page = 9
        self.current_page = 0
        self.total_pages = 1

    async def setup(self, bot, user, guild):
        try:
            # Check to see if the user has guild admin privileges. This lets them view any quest in the guild.
            if user.guild_permissions.manage_guild:
                query = {'guildId': guild.id}
                cache_id = f'guild_quests:{guild.id}'
            else:
                query = {'guildId': guild.id, 'gm': user.id}
                cache_id = f'gm_quests:{guild.id}:{user.id}'

            self.quests = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='quests',
                query=query,
                is_single=False,
                cache_id=cache_id
            )

            if self.quests is None:
                self.quests = []

            self.quests.sort(key=lambda x: x.get('title', '').lower())

            self.total_pages = math.ceil(len(self.quests) / self.items_per_page)
            if self.total_pages == 0:
                self.total_pages = 1
            if self.current_page >= self.total_pages:
                self.current_page = max(0, self.total_pages - 1)

            self.build_view()
        except Exception as e:
            await log_exception(e)

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(GMBaseView))
        header_section.add_item(TextDisplay('**Game Master - Quests**'))
        container.add_item(header_section)
        container.add_item(Separator())

        create_quest_section = Section(accessory=buttons.CreateQuestButton(self))
        create_quest_section.add_item(TextDisplay('Create and post a new quest.'))
        container.add_item(create_quest_section)
        container.add_item(Separator())

        if not self.quests:
            container.add_item(TextDisplay("No quests found."))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = self.quests[start:end]

            for quest in page_items:
                title = quest.get('title', 'Untitled')
                quest_id = quest.get('questId', 'Unknown')
                lock_state = " (Locked)" if quest.get('lockState') else ""

                info_text = f"**{title}**{lock_state}\nID: `{quest_id}`"

                section = Section(accessory=buttons.ManageQuestRowButton(quest))
                section.add_item(TextDisplay(info_text))
                container.add_item(section)

        self.add_item(container)

        if self.total_pages > 1:
            nav_row = ActionRow()
            prev_button = Button(
                label='Previous',
                style=discord.ButtonStyle.secondary,
                custom_id='gm_q_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_display = Button(
                label=f'Page {self.current_page + 1}/{self.total_pages}',
                style=discord.ButtonStyle.secondary,
                custom_id='gm_q_page'
            )
            page_display.callback = self.show_page_jump_modal
            nav_row.add_item(page_display)

            next_button = Button(
                label='Next',
                style=discord.ButtonStyle.secondary,
                custom_id='gm_q_next',
                disabled=(self.current_page >= self.total_pages - 1)
            )
            next_button.callback = self.next_page
            nav_row.add_item(next_button)

            self.add_item(nav_row)

    async def prev_page(self, interaction):
        if self.current_page > 0:
            self.current_page -= 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def next_page(self, interaction):
        if self.current_page < self.total_pages - 1:
            self.current_page += 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def show_page_jump_modal(self, interaction):
        try:
            await interaction.response.send_modal(PageJumpModal(self))
        except Exception as e:
            await log_exception(e, interaction)


class ManageQuestsView(LayoutView):
    def __init__(self, quest):
        super().__init__(timeout=None)
        self.selected_quest = quest
        self.xp_enabled = True

        self.build_view()

    async def setup(self, bot):
        try:
            # Refresh the selected quest data
            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='quests',
                query={'guildId': self.selected_quest['guildId'], 'questId': self.selected_quest['questId']},
                cache_id=f"{self.selected_quest['guildId']}:{self.selected_quest['questId']}"
            )
            if query:
                self.selected_quest = query

            self.xp_enabled = await get_xp_config(bot.gdb, self.selected_quest['guildId'])

            self.build_view()
        except Exception as e:
            await log_exception(e)

    def build_view(self):
        self.clear_items()
        container = Container()

        quest = self.selected_quest
        title = quest.get('title', 'Unknown')
        quest_id = quest.get('questId', 'Unknown')

        header_section = Section(accessory=BackButton(GMQuestMenuView))
        header_section.add_item(TextDisplay(f'**Manage Quest - {title}** `{quest_id}`'))
        container.add_item(header_section)
        container.add_item(Separator())

        edit_section = Section(accessory=buttons.EditQuestButton(self))
        edit_section.add_item(TextDisplay('Edit quest details such as title, description, and party size.'))
        container.add_item(edit_section)

        ready_status = "Locked/Ready" if quest.get('lockState') else "Open"
        toggle_section = Section(accessory=buttons.ToggleReadyButton(self))
        toggle_section.add_item(TextDisplay(
            f'Toggle ready state (Current: **{ready_status}**)\n'
            f'-Locks the quest roster and notifies party members that the quest will begin soon. If a role is '
            f'configured, it will be assigned to party members when locked.\n'
            f'- Unlocks the roster when set to Open.'
        ))
        container.add_item(toggle_section)

        rewards_section = Section(accessory=buttons.RewardsMenuButton(self))
        rewards_section.add_item(TextDisplay('Configure rewards for the selected quest.'))
        container.add_item(rewards_section)

        complete_quest_button = buttons.CompleteQuestButton(self)
        complete_quest_button.disabled = not (quest.get('party') is not None and len(quest.get('party')) > 0)
        complete_section = Section(accessory=complete_quest_button)
        complete_section.add_item(TextDisplay('Complete a quest. Issues rewards, if any, to party members.'))
        container.add_item(complete_section)

        remove_player_button = buttons.RemovePlayerButton(self)
        remove_player_button.disabled = not (quest.get('party') is not None and len(quest.get('party')) > 0)
        remove_player_section = Section(accessory=remove_player_button)
        remove_player_section.add_item(TextDisplay('Remove a player from the quest roster and notify them.'))
        container.add_item(remove_player_section)
        container.add_item(Separator())

        cancel_section = Section(accessory=buttons.CancelQuestButton(self))
        cancel_section.add_item(TextDisplay('Cancel the quest and delete it from the quest board.'))
        container.add_item(cancel_section)

        self.add_item(container)

    async def quest_ready_toggle(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            quest = self.selected_quest
            guild_id = interaction.guild_id
            user_id = interaction.user.id
            guild = interaction.guild

            # Fetch the quest channel
            channel_id_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='questChannel',
                query={'_id': guild_id}
            )
            if not channel_id_query:
                raise UserFeedbackError('Quest channel has not been set!')
            channel_id = strip_id(channel_id_query['questChannel'])
            channel = interaction.client.get_channel(channel_id)

            # Retrieve the message object
            message_id = quest['messageId']
            message = channel.get_partial_message(message_id)

            # Check to see if the quest has a party role configured
            role = None
            if quest['partyRoleId']:
                role_id = quest['partyRoleId']
                role = guild.get_role(role_id)

            party = quest['party']
            title = quest['title']
            quest_id = quest['questId']
            tasks = []

            # Locks the quest roster and alerts party members that the quest is ready.
            if not quest['lockState']:
                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name='quests',
                    query={'questId': quest_id},
                    update_data={'$set': {'lockState': True}},
                    cache_id=f'{guild_id}:{quest_id}'
                )
                quest['lockState'] = True

                # Notify each party member that the quest is ready
                for player in party:
                    for key in player:
                        member = guild.get_member(int(key))
                        # If the quest has a party role configured, assign it to each party member
                        if role:
                            tasks.append(member.add_roles(role))
                        tasks.append(member.send(f'Game Master <@{user_id}> has marked your quest, **"{title}"**, '
                                                 f'ready to start!'))
                await interaction.user.send('Quest roster locked and party notified!')
            # Unlocks a quest if members are not ready
            else:
                # Remove the role from the players
                if role:
                    for player in party:
                        for key in player:
                            member = guild.get_member(int(key))
                            tasks.append(member.remove_roles(role))

                # Unlock the quest
                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name='quests',
                    query={'questId': quest_id},
                    update_data={'$set': {'lockState': False}},
                    cache_id=f'{guild_id}:{quest_id}'
                )
                quest['lockState'] = False

                await interaction.user.send('Quest roster has been unlocked.')

            if len(tasks) > 0:
                results = await asyncio.gather(*tasks, return_exceptions=True)
                for result in results:
                    if isinstance(result, discord.errors.Forbidden):
                        logger.warning(f'Permission error when updating roles or sending DMs: {result}')
                    elif isinstance(result, Exception):
                        await log_exception(result)

            self.selected_quest = quest

            # Create a fresh quest view, and update the original post message
            quest_view = QuestPostView(quest)
            await quest_view.setup()
            await message.edit(embed=quest_view.embed, view=quest_view)

            await setup_view(self, interaction)
            await interaction.response.edit_message(view=self)
        except Exception as e:
            await log_exception(e, interaction)

    async def complete_quest(self, interaction: discord.Interaction, summary=None):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            guild = interaction.guild

            # Refresh the quest state before attempting to complete it
            refreshed_quest = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='quests',
                query={'guildId': guild_id, 'questId': self.selected_quest['questId']},
                cache_id=f'{guild_id}:{self.selected_quest["questId"]}'
            )

            if not refreshed_quest:
                raise Exception('Could not find the specified quest in the database.')

            self.selected_quest = refreshed_quest
            quest = self.selected_quest
            xp_enabled = await get_xp_config(interaction.client.gdb, guild_id)

            # Setup quest variables
            quest_id = quest['questId']
            message_id = quest['messageId']
            title = quest['title']
            description = quest['description']
            gm = quest['gm']
            party = quest['party']
            rewards = quest['rewards']

            if not party:
                raise UserFeedbackError('You cannot complete a quest with an empty roster. Try cancelling instead.')

            archive_channel = None
            archive_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='archiveChannel',
                query={'_id': guild_id}
            )
            if archive_query:
                archive_channel = guild.get_channel(strip_id(archive_query['archiveChannel']))

            # Check if a party role was configured, and delete it
            party_role_id = quest['partyRoleId']
            if party_role_id:
                role = guild.get_role(party_role_id)
                if role:
                    await role.delete(
                        reason=f'Quest ID {quest['questId']} was completed by {interaction.user.mention}.')

            # Get party members and message them with results
            reward_summary = []
            party_xp = rewards.get('party', {}).get('xp', 0)
            xp_per_member = party_xp // len(party) if party else 0
            party_items = rewards.get('party', {}).get('items', {})

            for entry in party:
                for player_id, character_info in entry.items():
                    # If the player left the server, this will return None
                    member = guild.get_member(int(player_id))
                    if not member:
                        continue  # Skip the player if they left.

                    # Get character data
                    character_id = next(iter(character_info))
                    character = character_info[character_id]
                    reward_summary.append(f'<@!{player_id}> as {character["name"]}:')

                    # Prep reward data
                    total_xp = xp_per_member
                    if not xp_enabled:
                        total_xp = 0
                    combined_items = party_items.copy()

                    # Check if character has individual rewards
                    if character_id in rewards:
                        individual_rewards = rewards[character_id]
                        if xp_enabled:
                            total_xp += individual_rewards.get('xp', 0)

                        # Merge individual items with party items
                        for item, quantity in (individual_rewards.get('items') or {}).items():
                            combined_items[item] = combined_items.get(item, 0) + quantity

                    # Update the character's XP and inventory
                    if xp_enabled and total_xp > 0:
                        reward_summary.append(f'Experience: {total_xp}')
                        await update_character_experience(interaction, int(player_id), character_id, total_xp)
                    for item_name, quantity in combined_items.items():
                        reward_summary.append(f'{item_name}: {quantity}')
                        await update_character_inventory(interaction, int(player_id), character_id, item_name, quantity)

                    # Send reward summary to player
                    reward_strings = self.build_reward_summary(total_xp, combined_items, xp_enabled)
                    dm_embed = discord.Embed(title=f'Quest Complete: {title}', type='rich')
                    if reward_strings:
                        dm_embed.add_field(name='Rewards', value='\n'.join(reward_strings))
                    try:
                        await member.send(embed=dm_embed)
                    except discord.errors.Forbidden as e:
                        logger.warning(f'Could not DM {member.id} about quest completion rewards: {e}')

            # Build an embed for feedback
            quest_embed = discord.Embed(
                title=f'QUEST COMPLETED: {title}',
                description=(
                    f'**GM:** <@!{gm}>\n\n'
                    f'{description}\n\n'
                    f'------'
                ),
                type='rich'
            )

            formatted_party = []
            for player in party:
                for member_id in player:
                    for character_id in player[str(member_id)]:
                        character = player[str(member_id)][str(character_id)]
                        formatted_party.append(f'- <@!{member_id}> as {character["name"]}')

            quest_embed.add_field(name=f'__Party__', value='\n'.join(formatted_party))
            quest_embed.set_footer(text='Quest ID: ' + quest_id)

            if summary:
                quest_embed.add_field(name='Summary', value=summary, inline=False)
            if reward_summary:
                quest_embed.add_field(name='Rewards', value='\n'.join(reward_summary), inline=True)

            # If an archive channel is configured, post the archived post
            if archive_channel:
                await archive_channel.send(embed=quest_embed)

            # Delete the original quest post
            quest_channel_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='questChannel',
                query={'_id': guild_id}
            )

            quest_channel_id = quest_channel_query['questChannel']
            quest_channel = interaction.client.get_channel(strip_id(quest_channel_id))
            if quest_channel:
                quest_message = quest_channel.get_partial_message(message_id)
                await attempt_delete(quest_message)

            # Remove the quest from the db
            await delete_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='quests',
                search_filter={'guildId': guild_id, 'questId': quest_id},
                cache_id=f'{guild_id}:{quest_id}'
            )

            admin_list_key = build_cache_key(bot.gdb.name, f'guild_quests:{guild_id}', 'quests')
            await bot.rdb.delete(admin_list_key)

            gm_list_key = build_cache_key(bot.gdb.name, f'gm_quests:{guild_id}:{gm}', 'quests')
            await bot.rdb.delete(gm_list_key)

            # Message feedback to the GM
            await interaction.user.send(embed=quest_embed)

            # Check if GM rewards are enabled, and reward the GM accordingly
            gm_rewards_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='gmRewards',
                query={'_id': guild_id}
            )
            if gm_rewards_query:
                experience = gm_rewards_query.get('experience')
                items = gm_rewards_query.get('items')

                character_query = await get_cached_data(
                    bot=bot,
                    mongo_database=bot.mdb,
                    collection_name='characters',
                    query={'_id': interaction.user.id}
                )

                if not character_query:
                    character_string = ('Your server admin has configured rewards for Game Masters when they complete '
                                        'quests. However, since you have no registered characters, your rewards could '
                                        'not be automatically issued at this time.')
                else:
                    if str(guild_id) not in character_query.get('activeCharacters', {}):
                        character_string = ('Your server admin has configured rewards for Game Masters when they '
                                            'complete quests. However, since you have no active character on this '
                                            'server, your rewards could not be automatically issued at this time.')
                    else:
                        active_character_id = character_query['activeCharacters'][str(guild_id)]
                        character_string = (f'The following has been awarded to your active character, '
                                            f'{character_query["characters"][active_character_id]["name"]}')
                        if experience and xp_enabled:
                            await update_character_experience(interaction, interaction.user.id, active_character_id,
                                                              experience)
                        if items:
                            for item_name, quantity in items.items():
                                await update_character_inventory(interaction, interaction.user.id, active_character_id,
                                                                 item_name, quantity)

                gm_rewards_embed = discord.Embed(
                    title='GM Rewards Issued',
                    description=character_string,
                    color=discord.Color.gold(),
                    type='rich'
                )
                if experience and xp_enabled:
                    gm_rewards_embed.add_field(name='Experience', value=experience)
                if items:
                    item_strings = []
                    for item_name, quantity in items.items():
                        item_strings.append(f'{titlecase(item_name)}: {quantity}')
                    gm_rewards_embed.add_field(name='Items', value='\n'.join(item_strings))

                try:
                    await interaction.user.send(embed=gm_rewards_embed)
                except discord.errors.Forbidden as e:
                    logger.warning(f'Could not DM {interaction.user.id} about GM rewards: {e}')

            # Reset the view and handle the interaction response
            view = GMQuestMenuView()
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)

    @staticmethod
    def build_reward_summary(xp, items, xp_enabled=True) -> list[str]:
        reward_strings = []
        if xp_enabled and xp and xp > 0:
            reward_strings.append(f'- Experience Points: {xp}')
        if items:
            for item, quantity in items.items():
                reward_strings.append(f'- {item}: {quantity}')
        return reward_strings


class RewardsMenuView(LayoutView):
    def __init__(self, calling_view):
        super().__init__(timeout=None)
        self.calling_view = calling_view
        self.quest = calling_view.selected_quest
        self.selected_character = None
        self.selected_character_id = None

        self.party_rewards_button = buttons.PartyRewardsButton(self)
        self.current_party_rewards = self._extract_party_rewards(self.quest)
        self.current_party_rewards_info = TextDisplay(
            '**Party Rewards**\n'
            'None'
        )

        self.individual_rewards_button = buttons.IndividualRewardsButton(self)
        self.current_individual_rewards = {'xp': None, 'items': {}}
        self.current_individual_rewards_info = TextDisplay(
            '**Individual Rewards**'
        )

        self.party_member_select = selects.PartyMemberSelect(calling_view=self,
                                                             disabled_components=[self.individual_rewards_button])

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=buttons.BackToManageQuestButton(self.quest))
        header_section.add_item(TextDisplay(f'**Quest Rewards - {self.quest['title']}**'))
        container.add_item(header_section)
        container.add_item(Separator())

        party_rewards_section = Section(accessory=self.party_rewards_button)
        party_rewards_section.add_item(self.current_party_rewards_info)
        container.add_item(party_rewards_section)
        container.add_item(Separator())

        party_member_select_row = ActionRow(self.party_member_select)
        container.add_item(party_member_select_row)

        individual_rewards_section = Section(accessory=self.individual_rewards_button)
        individual_rewards_section.add_item(self.current_individual_rewards_info)
        container.add_item(individual_rewards_section)
        container.add_item(Separator())

        self.add_item(container)

    async def setup(self):
        try:
            self.party_member_select.options.clear()

            options = self._build_party_member_options(self.quest)
            if options:
                self.party_member_select.placeholder = 'Select a party member'
                self.party_member_select.disabled = False
                self.party_member_select.options = options
            else:
                self.party_member_select.placeholder = 'No party members'
                self.party_member_select.disabled = True
                self.party_member_select.options = [
                    discord.SelectOption(label='None', value='None')
                ]

            party_rewards = self._extract_party_rewards(self.quest)
            self.current_party_rewards = party_rewards
            xp_enabled = getattr(self.calling_view, 'xp_enabled', True)
            self.current_party_rewards_info.content = (
                '**Party Rewards**\n'
                f'{self._format_rewards_field(party_rewards, xp_enabled)}'
            )

            if self.selected_character and self.selected_character_id:
                individual_rewards = self._extract_individual_rewards(self.quest, self.selected_character_id)
                self.current_individual_rewards = individual_rewards

                char_name = self.selected_character.get('name', 'Selected Character')
                self.current_individual_rewards_info.content = (
                    f'**Additional rewards for {char_name}**\n'
                    f'{self._format_rewards_field(individual_rewards, xp_enabled)}'
                )
            else:
                self.current_individual_rewards = {"xp": None, "items": {}}
                self.current_individual_rewards_info.content = (
                    '**Individual Rewards**'
                )
        except Exception as e:
            await log_exception(e)

    def _build_party_member_options(self, quest: Dict[str, Any]) -> list[discord.SelectOption]:
        options: list[discord.SelectOption] = []
        party = quest.get('party') or []

        for member_id, character_id, character in self._iter_party_members(party):
            name = character.get('name', f'Character {character_id}')
            options.append(discord.SelectOption(label=name, value=str(character_id)))

        return options

    @staticmethod
    def _iter_party_members(party: Any) -> Iterator[Tuple[str, str, Dict[str, Any]]]:
        for player in party if isinstance(party, list) else []:
            if not isinstance(player, dict):
                continue
            for member_id, chars in player.items():
                if not isinstance(chars, dict):
                    continue
                for character_id, character in chars.items():
                    if isinstance(character, dict):
                        yield str(member_id), str(character_id), character

    @staticmethod
    def _extract_party_rewards(quest: Dict[str, Any]) -> Dict[str, Any]:
        rewards = (quest.get('rewards') or {}).get('party') or {}
        xp = rewards.get('xp')
        items = rewards.get('items') or {}

        xp_val = int(xp) if isinstance(xp, (int, float, str)) and str(xp).isdigit() else (
            xp if isinstance(xp, int) else None)
        items_val = dict(items) if isinstance(items, dict) else {}

        return {"xp": xp_val, "items": items_val}

    @staticmethod
    def _extract_individual_rewards(quest: Dict[str, Any], character_id: str) -> Dict[str, Any]:
        rewards = (quest.get('rewards') or {}).get(character_id) or {}
        xp = rewards.get('xp')
        items = rewards.get('items') or {}

        xp_val = int(xp) if isinstance(xp, (int, float, str)) and str(xp).isdigit() else (
            xp if isinstance(xp, int) else None)
        items_val = dict(items) if isinstance(items, dict) else {}

        return {"xp": xp_val, "items": items_val}

    @staticmethod
    def _format_rewards_field(rewards: Dict[str, Any], xp_enabled=True) -> str:
        lines: list[str] = []

        xp = rewards.get('xp')
        if xp_enabled and isinstance(xp, int) and xp > 0:
            lines.append(f'Experience: {xp}')

        items = rewards.get('items') or {}
        if isinstance(items, dict) and items:
            for item_name, qty in items.items():
                pretty = str(item_name).capitalize()
                lines.append(f'{pretty}: {qty}')

        return '\n'.join(lines) if lines else 'None'


class GMPlayerMenuView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(GMBaseView))
        header_section.add_item(TextDisplay('**Game Master - Player Management**'))
        container.add_item(header_section)
        container.add_item(Separator())

        container.add_item(TextDisplay(
            'These commands have migrated to context menus. Right-click (desktop) or long-press (mobile) a player\'s '
            'profile for the following menu options:\n\n'
            '- **Modify Player**: Add or remove items and experience from a player.\n'
            '- **View Player**: View a player\'s active character details.'
        ))

        self.add_item(container)


class RemovePlayerView(LayoutView):
    def __init__(self, quest):
        super().__init__(timeout=None)
        self.quest = quest
        self.selected_member_id = None
        self.selected_character_id = None
        self.remove_player_select = selects.RemovePlayerSelect(self)

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=buttons.BackToManageQuestButton(self.quest))
        header_section.add_item(TextDisplay(f'**Remove Player from Quest - {self.quest['title']}**'))
        container.add_item(header_section)
        container.add_item(Separator())

        container.add_item(TextDisplay(
            '__**Player Removal Notes**__\n\n'
            '- Choose a player from the dropdown below to remove them from the quest roster.\n'
            '- If any players are on a wait list, the first player on the list will be promoted to the party.\n'
            '- Individual rewards for the removed player will be deleted from the quest.\n'
            '- If you wish to reward the player for prior contributions, use the `Modify Player` context menu to issue '
            'them rewards directly.'
        ))

        remove_player_select_row = ActionRow(self.remove_player_select)
        container.add_item(remove_player_select_row)

        self.add_item(container)

    async def setup(self):
        try:
            self.remove_player_select.options.clear()

            options = []
            party = self.quest['party']
            wait_list = self.quest['waitList']
            if party:
                for player in party:
                    for member_id in player:
                        for character_id in player[str(member_id)]:
                            character = player[str(member_id)][str(character_id)]
                            options.append(discord.SelectOption(label=f'{character['name']}', value=member_id))
            if wait_list:
                for player in wait_list:
                    for member_id in player:
                        for character_id in player[str(member_id)]:
                            character = player[str(member_id)][str(character_id)]
                            options.append(discord.SelectOption(label=f'{character['name']}', value=member_id))
            if not party and not wait_list:
                options.append(discord.SelectOption(label='No players in quest roster', value='None'))
                self.remove_player_select.placeholder = 'No players in quest roster'
                self.remove_player_select.disabled = True

            self.remove_player_select.options = options
        except Exception as e:
            await log_exception(e)

    async def confirm_callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            quest = self.quest
            (quest_id, message_id, title, gm, party,
             wait_list, max_wait_list_size, lock_state, rewards) = (quest['questId'], quest['messageId'],
                                                                    quest['title'], quest['gm'], quest['party'],
                                                                    quest['waitList'], quest['maxWaitListSize'],
                                                                    quest['lockState'], quest['rewards'])

            removed_member_id = self.selected_member_id
            guild_id = interaction.guild_id
            guild = interaction.guild
            member = guild.get_member(int(removed_member_id))

            # Fetch the quest channel to retrieve the message object
            channel_id_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='questChannel',
                query={'_id': guild_id}
            )
            channel_id = strip_id(channel_id_query['questChannel'])
            channel = interaction.client.get_channel(channel_id)
            message = channel.get_partial_message(message_id)

            quest_collection = interaction.client.gdb['quests']

            party_role_id = quest['partyRoleId']

            # If the quest list is locked and a party role exists, fetch the role.
            role = None
            if lock_state and party_role_id:
                role = guild.get_role(party_role_id)

                # Remove the role from the member
                await member.remove_roles(role)

            removal_message = ''
            player_found = False
            # Check the wait list and remove the player if present
            for waiting_player in wait_list:
                if removed_member_id in waiting_player:
                    wait_list.remove(waiting_player)
                    player_found = True
                    removal_message = f'The Game Master for **{quest["title"]}** has removed you from the wait list.'
                    break

            # If they're not in the wait list, they must be in the party
            if not player_found:
                for player in party:
                    if removed_member_id in player:
                        removal_message = f'The Game Master for **{quest["title"]}** has removed you from the party.'
                        party.remove(player)

                        # If there is a wait list, promote the first entry into the party
                        if max_wait_list_size > 0 and len(wait_list) > 0:
                            new_player = wait_list.pop(0)
                            party.append(new_player)

                            for key in new_player:
                                new_member = guild.get_member(int(key))
                                try:
                                    await new_member.send(f'You have been added to the party for **{quest["title"]}**, '
                                                          f'due to a player dropping!')
                                except discord.errors.Forbidden as e:
                                    logger.warning(f'Could not DM {new_member.id} about party promotion: {e}')

                                # If a role is set, assign it to the player
                                if role and lock_state:
                                    await new_member.add_roles(role)

                        if rewards:
                            if self.selected_character_id in rewards:
                                del rewards[self.selected_character_id]
                        break

            await quest_collection.replace_one({'guildId': guild_id, 'questId': quest_id}, self.quest)

            # Give the GM some feedback that the changes applied
            gm_member = guild.get_member(interaction.user.id)
            await gm_member.send(f'Player removed and quest roster updated!')

            # Refresh the views with the updated local quest object
            quest_view = QuestPostView(self.quest)
            await setup_view(quest_view, interaction)

            # Update the menu view and the quest post
            await message.edit(embed=quest_view.embed, view=quest_view)
            await setup_view(self, interaction)
            await interaction.response.edit_message(view=self)

            # Notify the player they have been removed.
            try:
                await member.send(removal_message)
            except discord.errors.Forbidden as e:
                logger.warning(f'Could not DM {member.id} about removal from quest: {e}')
        except Exception as e:
            await log_exception(e, interaction)


class QuestPostView(View):
    def __init__(self, quest):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='',
            description='',
            type='rich'
        )
        self.quest = quest
        self.join_button = buttons.JoinQuestButton(self)
        self.leave_button = buttons.LeaveQuestButton(self)
        self.add_item(self.join_button)
        self.add_item(self.leave_button)

    async def setup(self):
        try:
            self.embed = await update_quest_embed(self.quest)
        except Exception as e:
            await log_exception(e)

    async def join_callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            user_id = interaction.user.id
            quest_id = self.quest['questId']

            quest = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='quests',
                query={'guildId': guild_id, 'questId': quest_id},
                cache_id=f'{guild_id}:{quest_id}'
            )

            current_party = quest['party']
            current_wait_list = quest['waitList']
            for player in current_party:
                if str(user_id) in player:
                    for character_id, character_data in player[str(user_id)].items():
                        raise UserFeedbackError(f'You are already on this quest as {character_data['name']}')
            max_wait_list_size = quest['maxWaitListSize']
            max_party_size = quest['maxPartySize']

            player_characters = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': user_id}
            )
            if (not player_characters or
                    'activeCharacters' not in player_characters or
                    str(guild_id) not in player_characters['activeCharacters']):
                raise UserFeedbackError(
                    'You do not have an active character on this server. Use the `/player` menus to create a new '
                    'character, or activate an existing one on this server.'
                )
            active_character_id = player_characters['activeCharacters'][str(guild_id)]
            active_character = player_characters['characters'][active_character_id]

            if quest['lockState']:
                raise UserFeedbackError(
                    f'Error joining quest **{quest["title"]}**: The quest is locked and not accepting new players.'
                )
            else:
                new_player_entry = {f'{user_id}': {f'{active_character_id}': active_character}}
                # If the wait list is enabled, this section formats the embed to include the wait list
                if max_wait_list_size > 0:
                    # If there is room in the party, add the user.
                    if len(current_party) < max_party_size:
                        await update_cached_data(
                            bot=bot,
                            mongo_database=bot.gdb,
                            collection_name='quests',
                            query={'guildId': guild_id, 'questId': quest_id},
                            update_data={'$push': {'party': new_player_entry}},
                            cache_id=f'{guild_id}:{quest_id}'
                        )
                        self.quest['party'].append(new_player_entry)
                    # If the party is full but the wait list is not, add the user to wait list.
                    elif len(current_party) >= max_party_size and len(current_wait_list) < max_wait_list_size:
                        await update_cached_data(
                            bot=bot,
                            mongo_database=bot.gdb,
                            collection_name='quests',
                            query={'guildId': guild_id, 'questId': quest_id},
                            update_data={'$push': {'waitList': new_player_entry}},
                            cache_id=f'{guild_id}:{quest_id}'
                        )
                        self.quest['waitList'].append(new_player_entry)

                    # Otherwise, inform the user that the party/wait list is full
                    else:
                        raise UserFeedbackError(f'Error joining quest **{quest["title"]}**: The quest roster is full!')
                # If there is no wait list, this section formats the embed without it
                else:
                    # If there is room in the party, add the user.
                    if len(current_party) < max_party_size:
                        await update_cached_data(
                            bot=bot,
                            mongo_database=bot.gdb,
                            collection_name='quests',
                            query={'guildId': guild_id, 'questId': quest_id},
                            update_data={'$push': {'party': new_player_entry}},
                            cache_id=f'{guild_id}:{quest_id}'
                        )
                        self.quest['party'].append(new_player_entry)
                    else:
                        raise UserFeedbackError(f'Error joining quest **{quest["title"]}**: The quest roster is full!')

                await setup_view(self, interaction)
                await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)

    async def leave_callback(self, interaction: discord.Interaction):
        try:
            guild_id = interaction.guild_id
            user_id = interaction.user.id
            guild = interaction.client.get_guild(guild_id)

            quest_collection = interaction.client.gdb['quests']
            quest = self.quest
            quest_id, party, wait_list, max_wait_list_size, lock_state = (quest['questId'], quest['party'],
                                                                          quest['waitList'], quest['maxWaitListSize'],
                                                                          quest['lockState'])

            in_party = False
            for player in party:
                if str(user_id) in player:
                    in_party = True
            in_wait_list = False
            if len(wait_list) > 0:
                for player in wait_list:
                    if str(user_id) in player:
                        in_wait_list = True
            if not in_party and not in_wait_list:
                raise UserFeedbackError(f'You are not signed up for this quest.')

            if in_wait_list:
                for player in wait_list:
                    if str(user_id) in player:
                        wait_list.remove(player)
                        break
            else:
                for player in party:
                    if str(user_id) in player:
                        party.remove(player)

                new_member = None
                # If there is a wait list, move the first entry into the party automatically
                if max_wait_list_size > 0 and len(wait_list) > 0:
                    new_player = wait_list.pop(0)
                    party.append(new_player)

                    for key in new_player:
                        new_member = guild.get_member(int(key))

                    # Notify the member they have been moved into the main party
                    try:
                        await new_member.send(f'You have been added to the party for '
                                              f'**{quest["title"]}**, due to a player dropping!')
                    except discord.errors.Forbidden as e:
                        logger.warning(f'Could not DM {new_member.id} about party promotion: {e}')

                # If the quest list is locked and a party role exists, fetch the role.
                party_role_id = quest['partyRoleId']
                if lock_state and party_role_id:
                    role = guild.get_role(party_role_id)

                    # Get the member object and remove the role
                    member = guild.get_member(user_id)
                    await member.remove_roles(role)
                    if new_member:
                        await new_member.add_roles(role)

            # Update the database
            await quest_collection.replace_one({'guildId': guild_id, 'questId': quest_id}, self.quest)

            # Refresh the query with the new document and edit the post
            await self.setup()
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)


class ViewCharacterView(LayoutView):
    def __init__(self, member_id, character_data, currency_config, xp_enabled=True):
        super().__init__(timeout=None)
        container = Container()

        name = character_data.get('name', 'Unknown')
        xp = character_data['attributes'].get('experience', None)
        inventory = character_data['attributes'].get('inventory', {})
        currency = character_data['attributes'].get('currency', {})

        container.add_item(TextDisplay(content=f'**Character Sheet for {name} (<@{member_id}>)**'))
        container.add_item(Separator())
        if xp_enabled and xp is not None:
            container.add_item(TextDisplay(f'__**Experience Points:**__\n{xp}'))
        inventory_display = TextDisplay(
            '__**Possessions**__\n\n' + ('\n'.join([f'{item}: **{quantity}**' for item, quantity in inventory.items()])
                                         if inventory else 'No items in inventory.')
        )
        currency_lines = format_currency_display(currency, currency_config)
        currency_display = TextDisplay(
            '__**Currency**__\n\n' + ('\n'.join(currency_lines)
                                      if currency_lines else 'No currency.'))

        container.add_item(inventory_display)
        container.add_item(currency_display)

        self.add_item(container)

        nav_row = ActionRow()
        nav_row.add_item(MenuDoneButton())
        self.add_item(nav_row)


# ----- Approval Queue -----

class GMApprovalsView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.review_button = buttons.ReviewSubmissionButton(self)
        self.build_view()

    def build_view(self):
        container = Container()
        header = Section(accessory=BackButton(GMBaseView))
        header.add_item(TextDisplay("**Game Master - Inventory Approvals**"))
        container.add_item(header)
        container.add_item(Separator())

        section = Section(accessory=self.review_button)
        section.add_item(TextDisplay("Enter a Submission ID to review and approve/deny it."))
        container.add_item(section)

        self.add_item(container)


class ReviewSubmissionView(LayoutView):
    def __init__(self, submission_data, currency_config):
        super().__init__(timeout=None)
        self.currency_config = currency_config
        self.data = submission_data
        self.build_view()

    def build_view(self):
        container = Container()
        header = Section(accessory=BackButton(GMApprovalsView))
        header.add_item(TextDisplay(f'**Reviewing: {self.data["character_name"]}**'))
        container.add_item(header)
        container.add_item(Separator())

        items = self.data.get('items', {})
        currency = self.data.get('currency', {})

        description = '**Items:**\n' + ('\n'.join([f'{k}: {v}' for k, v in items.items()]) or 'None')
        currency_labels = format_consolidated_totals(currency, self.currency_config)
        description += '\n\n**Currency:**\n' + ('\n'.join(currency_labels) or 'None')

        container.add_item(TextDisplay(description))

        actions = ActionRow()
        actions.add_item(buttons.ApproveSubmissionButton(self))
        actions.add_item(buttons.DenySubmissionButton(self))
        container.add_item(actions)

        self.add_item(container)

    async def approve(self, interaction):
        try:
            bot = interaction.client
            character_id = self.data['character_id']
            user_id = self.data['user_id']
            submission_id = self.data['submission_id']

            for name, quantity in self.data.get('items', {}).items():
                await update_character_inventory(interaction, user_id, character_id, name, quantity)
            for name, quantity in self.data.get('currency', {}).items():
                await update_character_inventory(interaction, user_id, character_id, name, quantity)

            await delete_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='approvals',
                search_filter={'submission_id': submission_id},
                cache_id=f'approval_submission:{submission_id}'
            )

            approval_embed = discord.Embed(
                title='Inventory Update Approved',
                description=(
                    f'The inventory for **{self.data["character_name"]}** has been approved by '
                    f'{interaction.user.mention}.'
                ),
                color=discord.Color.green(),
                type='rich'
            )

            # Post the approval message
            thread_id = self.data.get('thread_id')
            thread = interaction.guild.get_thread(thread_id)
            await thread.send(embed=approval_embed)

            # Either refresh GM view, or delete original response if in thread since it will be archived.
            if interaction.channel_id == thread_id:
                await interaction.response.defer()
                await interaction.followup.delete_message(interaction.message.id)
            else:
                view = GMApprovalsView()
                await interaction.response.edit_message(view=view)

            # Lock/Archive thread
            await thread.edit(locked=True, archived=True)
        except Exception as e:
            await log_exception(e, interaction)

    async def deny(self, interaction):
        try:
            # Same logic as above but for denials
            bot = interaction.client
            submission_id = self.data['submission_id']

            await delete_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='approvals',
                search_filter={'submission_id': submission_id},
                cache_id=f'approval_submission:{submission_id}'
            )

            denial_embed = discord.Embed(
                title='Inventory Update Denied',
                description=(
                    f'The inventory for **{self.data["character_name"]}** has been denied by '
                    f'{interaction.user.mention}.'
                ),
                color=discord.Color.red(),
                type='rich'
            )

            thread_id = self.data.get('thread_id')
            thread = interaction.guild.get_thread(thread_id)
            await thread.send(embed=denial_embed)

            if interaction.channel_id == thread_id:
                await interaction.response.defer()
                await interaction.followup.delete_message(interaction.message.id)
            else:
                view = GMApprovalsView()
                await interaction.response.edit_message(view=view)

            await thread.edit(locked=True, archived=True)
        except Exception as e:
            await log_exception(e, interaction)
