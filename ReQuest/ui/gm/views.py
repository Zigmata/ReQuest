import asyncio
import logging
from typing import Any, Dict, Iterator, Tuple

import discord
from discord.ui import View, LayoutView, Container, TextDisplay, Separator, ActionRow, Section
from titlecase import titlecase

from ReQuest.ui.common.buttons import MenuViewButton, MenuDoneButton, BackButton
from ReQuest.ui.common.views import MenuBaseView
from ReQuest.ui.gm import buttons, selects, modals
from ReQuest.utilities.supportFunctions import (
    log_exception,
    strip_id,
    update_character_inventory,
    update_character_experience,
    attempt_delete,
    update_quest_embed,
    format_currency_display, setup_view, format_consolidated_totals
)

logging.basicConfig(level=logging.INFO)
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
        self.create_quest_button = buttons.CreateQuestButton(QuestPostView)
        self.manage_quests_view_button = MenuViewButton(ManageQuestsView, 'Manage')
        self.complete_quests_button = MenuViewButton(CompleteQuestsView, 'Complete')

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(GMBaseView))
        header_section.add_item(TextDisplay('**Game Master - Quests**'))
        container.add_item(header_section)
        container.add_item(Separator())

        create_quest_section = Section(accessory=self.create_quest_button)
        create_quest_section.add_item(TextDisplay('Create and post a new quest.'))
        container.add_item(create_quest_section)

        manage_quest_section = Section(accessory=self.manage_quests_view_button)
        manage_quest_section.add_item(TextDisplay('Manage an active quest: Rewards, edits, etc.'))
        container.add_item(manage_quest_section)

        complete_quest_section = Section(accessory=self.complete_quests_button)
        complete_quest_section.add_item(TextDisplay(
            'Complete an active quest. Issues rewards, if any, to party members.'
        ))
        container.add_item(complete_quest_section)

        self.add_item(container)


class ManageQuestsView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.selected_quest = None
        self.quests = None

        self.quest_select = selects.ManageQuestSelect(self)

        self.edit_quest_button = buttons.EditQuestButton(self, QuestPostView)
        self.edit_quest_info = TextDisplay(
            'Edit details for the selected quest.'
        )

        self.toggle_ready_button = buttons.ToggleReadyButton(self)
        self.toggle_ready_info = TextDisplay(
            'Toggle the ready state of the selected quest.'
        )

        self.rewards_menu_button = buttons.RewardsMenuButton(self, RewardsMenuView)
        self.rewards_menu_info = TextDisplay(
            'Configure rewards for the selected quest.'
        )

        self.remove_player_button = buttons.RemovePlayerButton(self, RemovePlayerView)
        self.remove_player_info = TextDisplay(
            'Remove a player from the selected quest.'
        )

        self.cancel_quest_button = buttons.CancelQuestButton(self)
        self.cancel_quest_info = TextDisplay(
            'Cancel the selected quest and delete it from the quest board.'
        )

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(GMQuestMenuView))
        header_section.add_item(TextDisplay('**Game Master - Quest Management**'))
        container.add_item(header_section)
        container.add_item(Separator())

        quest_select_row = ActionRow(self.quest_select)
        container.add_item(quest_select_row)

        edit_quest_section = Section(accessory=self.edit_quest_button)
        edit_quest_section.add_item(self.edit_quest_info)
        container.add_item(edit_quest_section)

        toggle_ready_section = Section(accessory=self.toggle_ready_button)
        toggle_ready_section.add_item(self.toggle_ready_info)
        container.add_item(toggle_ready_section)

        rewards_menu_section = Section(accessory=self.rewards_menu_button)
        rewards_menu_section.add_item(self.rewards_menu_info)
        container.add_item(rewards_menu_section)

        remove_player_section = Section(accessory=self.remove_player_button)
        remove_player_section.add_item(self.remove_player_info)
        container.add_item(remove_player_section)

        cancel_quest_section = Section(accessory=self.cancel_quest_button)
        cancel_quest_section.add_item(self.cancel_quest_info)
        container.add_item(cancel_quest_section)

        self.add_item(container)

    async def setup(self, bot, user, guild):
        try:
            quest_collection = bot.gdb['quests']
            options = []
            quests = []

            # Check to see if the user has guild admin privileges. This lets them edit any quest in the guild.
            if user.guild_permissions.manage_guild:
                quest_query = quest_collection.find({'guildId': guild.id})
            else:
                quest_query = quest_collection.find({'guildId': guild.id, 'gm': user.id})

            async for document in quest_query:
                quests.append(dict(document))

            if len(quests) > 0:
                for quest in quests:
                    options.append(discord.SelectOption(label=f'{quest['questId']}: {quest['title']}',
                                                        value=quest['questId']))
                self.quests = quests
                self.quest_select.disabled = False
            else:
                options.append(discord.SelectOption(label='No quests were found, or you do not have permissions to edit'
                                                          ' them.', value='None'))
                self.quest_select.disabled = True

            self.quest_select.options = options

            if self.selected_quest:
                quest_title = self.selected_quest.get('title')
                quest_id = self.selected_quest.get('questId')

                self.edit_quest_info.content = f'Edit details for `{quest_id}`: **{quest_title}**.'
                self.edit_quest_button.disabled = False

                self.toggle_ready_info.content = f'Toggle the ready state for `{quest_id}`: **{quest_title}**.'
                self.toggle_ready_button.disabled = False

                self.rewards_menu_info.content = f'Configure rewards for `{quest_id}`: **{quest_title}**.'
                self.rewards_menu_button.disabled = False

                self.remove_player_info.content = f'Remove a player from `{quest_id}`: **{quest_title}**.'
                self.remove_player_button.disabled = False

                self.cancel_quest_info.content = f'Cancel `{quest_id}`: **{quest_title}**.'
                self.cancel_quest_button.disabled = False

        except Exception as e:
            await log_exception(e)

    async def quest_ready_toggle(self, interaction: discord.Interaction):
        try:
            quest = self.selected_quest
            guild_id = interaction.guild_id
            user_id = interaction.user.id
            guild = interaction.client.get_guild(guild_id)

            # Fetch the quest channel to retrieve the message object
            channel_collection = interaction.client.gdb['questChannel']
            channel_id_query = await channel_collection.find_one({'_id': guild_id})
            if not channel_id_query:
                raise Exception('Quest channel has not been set!')
            channel_id = strip_id(channel_id_query['questChannel'])
            channel = interaction.client.get_channel(channel_id)

            # Retrieve the message object
            message_id = quest['messageId']
            message = channel.get_partial_message(message_id)

            # Check to see if the GM has a party role configured
            role = None
            if quest['partyRoleId']:
                role_id = quest['partyRoleId']
                role = guild.get_role(role_id)

            party = quest['party']
            title = quest['title']
            quest_id = quest['questId']
            tasks = []

            # Locks the quest roster and alerts party members that the quest is ready.
            quest_collection = interaction.client.gdb['quests']
            if not quest['lockState']:
                await quest_collection.update_one({'questId': quest_id}, {'$set': {'lockState': True}})

                # Fetch the updated quest
                quest['lockState'] = True

                # Notify each party member that the quest is ready
                for player in party:
                    for key in player:
                        member = guild.get_member(int(key))
                        # If the GM has a party role configured, assign it to each party member
                        if role:
                            tasks.append(member.add_roles(role))
                        tasks.append(member.send(f'Game Master <@{user_id}> has marked your quest, **"{title}"**, '
                                                 f'ready to start!'))

                await interaction.user.send('Quest roster locked and party notified!')
            # Unlocks a quest if members are not ready.
            else:
                # Remove the role from the players
                if role:
                    for player in party:
                        for key in player:
                            member = guild.get_member(int(key))
                            tasks.append(member.remove_roles(role))

                # Unlock the quest
                await quest_collection.update_one({'questId': quest_id}, {'$set': {'lockState': False}})

                # Fetch the updated quest
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


class RewardsMenuView(LayoutView):
    def __init__(self, calling_view):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='',
            description=(
                '__**Party Rewards**__\n'
                'Assigns rewards shared across all party members. XP and currency will be split evenly.\n\n'
                '__**Individual Rewards**__\n'
                'Assigns additional bonus rewards for the selected party member.\n\n'
                '**How To Input Rewards**\n\n'
                '> Experience Points\n'
                '- Input the total amount of experience to award.\n\n'
                '> Items/Currency\n'
                '- Note the {name}: {quantity} format in the placeholder text.\n'
                '- Item/Currency names are case-insensitive, so \"gOLd\" == \"Gold\"\n\n'
                '------'
            ),
            type='rich'
        )
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

        header_section = Section(accessory=BackButton(ManageQuestsView))
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
            self.embed.clear_fields()

            self.embed.title = f"Quest Rewards - {self.quest.get('title', 'Unknown Quest')}"

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
            self.current_party_rewards_info.content = (
                '**Party Rewards**\n'
                f'{self._format_rewards_field(party_rewards)}'
            )

            if self.selected_character and self.selected_character_id:
                individual_rewards = self._extract_individual_rewards(self.quest, self.selected_character_id)
                self.current_individual_rewards = individual_rewards

                char_name = self.selected_character.get('name', 'Selected Character')
                self.current_individual_rewards_info.content = (
                    f'**Additional rewards for {char_name}**\n'
                    f'{self._format_rewards_field(individual_rewards)}'
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
    def _format_rewards_field(rewards: Dict[str, Any]) -> str:
        lines: list[str] = []

        xp = rewards.get('xp')
        if isinstance(xp, int) and xp > 0:
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
        self.embed = discord.Embed(
            title='Game Master - Player Management',
            description=(
                '__**Modifying Player Inventory/Experience**__\n'
                'This command is accessed through context menus. Right-click (desktop) or long-press (mobile) a player '
                'and choose Apps -> Modify Player to bring up the input modal.\n\n'
                '- Values entered will be added/subtracted from the player\'s current total.\n'
                '- To reduce a value, make sure you precede the amount/quantity with a `\'-\'`.\n'
                '- For items, put each item on a separate line and follow the `item: quantity` format in the '
                'placeholder text. Currency is treated as an item.\n\n'
            ),
            type='rich'
        )
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

        header_section = Section(accessory=BackButton(ManageQuestsView))
        header_section.add_item(TextDisplay(f'**Remove Player from Quest - {self.quest['title']}**'))
        container.add_item(header_section)
        container.add_item(Separator())

        container.add_item(TextDisplay(
            '__**Player Removal Notes**__\n\n'
            '- Choose a player from the dropdown above to remove them from the quest roster.\n'
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
            channel_collection = interaction.client.gdb['questChannel']
            channel_id_query = await channel_collection.find_one({'_id': guild_id})
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
            guild_id = interaction.guild_id
            user_id = interaction.user.id

            quest_collection = interaction.client.gdb['quests']
            quest_id = self.quest['questId']
            quest = await quest_collection.find_one({'guildId': guild_id, 'questId': quest_id})

            current_party = quest['party']
            current_wait_list = quest['waitList']
            for player in current_party:
                if str(user_id) in player:
                    for character_id, character_data in player[str(user_id)].items():
                        raise Exception(f'You are already on this quest as {character_data['name']}')
            max_wait_list_size = quest['maxWaitListSize']
            max_party_size = quest['maxPartySize']
            member_collection = interaction.client.mdb['characters']
            player_characters = await member_collection.find_one({'_id': user_id})
            if (not player_characters or
                    'activeCharacters' not in player_characters or
                    str(guild_id) not in player_characters['activeCharacters']):
                raise Exception('You do not have an active character on this server. Use the `/player` menus to create'
                                'a new character, or activate an existing one on this server.')
            active_character_id = player_characters['activeCharacters'][str(guild_id)]
            active_character = player_characters['characters'][active_character_id]

            if quest['lockState']:
                raise Exception(f'Error joining quest **{quest["title"]}**: The quest is locked and not accepting new '
                                f'players.')
            else:
                new_player_entry = {f'{user_id}': {f'{active_character_id}': active_character}}
                # If the wait list is enabled, this section formats the embed to include the wait list
                if max_wait_list_size > 0:
                    # If there is room in the party, add the user.
                    if len(current_party) < max_party_size:
                        await quest_collection.update_one(
                            {'guildId': guild_id, 'questId': quest_id},
                            {'$push': {'party': new_player_entry}}
                        )
                        self.quest['party'].append(new_player_entry)
                    # If the party is full but the wait list is not, add the user to wait list.
                    elif len(current_party) >= max_party_size and len(current_wait_list) < max_wait_list_size:
                        await quest_collection.update_one(
                            {'guildId': guild_id, 'questId': quest_id},
                            {'$push': {'waitList': new_player_entry}}
                        )
                        self.quest['waitList'].append(new_player_entry)

                    # Otherwise, inform the user that the party/wait list is full
                    else:
                        raise Exception(f'Error joining quest **{quest["title"]}**: The quest roster is full!')
                # If there is no wait list, this section formats the embed without it
                else:
                    # If there is room in the party, add the user.
                    if len(current_party) < max_party_size:
                        await quest_collection.update_one(
                            {'guildId': guild_id, 'questId': quest_id},
                            {'$push': {'party': new_player_entry}}
                        )
                        self.quest['party'].append(new_player_entry)
                    else:
                        raise Exception(f'Error joining quest **{quest["title"]}**: The quest roster is full!')

                await self.setup()
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
                raise Exception(f'You are not signed up for this quest.')

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


class CompleteQuestsView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Game Master - Quest Completion',
            description=(
                'Choose a quest to complete. **This action is irreversible!**\n\n'
                'Completing a quest does the following:\n'
                '- Removes the quest post from the Quest Board channel.\n'
                '- Issues rewards (if any) to party members.\n'
                '- Removes GM roles (if any) from party members.\n'
                '- Messages party members with a summary of their individual rewards.\n'
                '- If configured in the server, prompts the GM to summarize the results of the quest/story, and posts '
                'the quest results to a designated Archive Channel.'
            ),
            type='rich'
        )
        self.quests = None
        self.selected_quest = None
        self.quest_select = selects.ManageableQuestSelect(self)

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(GMQuestMenuView))
        header_section.add_item(TextDisplay('**Game Master - Quest Completion**'))
        container.add_item(header_section)
        container.add_item(Separator())

        container.add_item(TextDisplay(
                'Choose a quest to complete. **This action is irreversible!**\n\n'
                'Completing a quest does the following:\n'
                '- Removes the quest post from the Quest Board channel.\n'
                '- Issues rewards (if any) to party members.\n'
                '- Removes GM roles (if any) from party members.\n'
                '- Messages party members with a summary of their individual rewards.\n'
                '- If configured in the server, prompts the GM to summarize the results of the quest/story, and posts '
                'the quest results to a designated Archive Channel.'
            ))
        container.add_item(Separator())

        quest_select_row = ActionRow(self.quest_select)
        container.add_item(quest_select_row)

        self.add_item(container)

    async def setup(self, bot, user, guild):
        try:
            quest_collection = bot.gdb['quests']
            options = []
            quests = []

            # Check to see if the user has guild admin privileges. This lets them edit any quest in the guild.
            if user.guild_permissions.manage_guild:
                quest_query = quest_collection.find({'guildId': guild.id})
            else:
                quest_query = quest_collection.find({'guildId': guild.id, 'gm': user.id})

            async for document in quest_query:
                quests.append(dict(document))

            if len(quests) > 0:
                for quest in quests:
                    options.append(discord.SelectOption(label=f'{quest['questId']}: {quest['title']}',
                                                        value=quest['questId']))
                self.quests = quests
                self.quest_select.disabled = False
            else:
                options.append(discord.SelectOption(label='No quests were found, or you do not have permissions to edit'
                                                          ' them.', value='None'))
                self.quest_select.disabled = True

            self.quest_select.options = options
        except Exception as e:
            await log_exception(e)

    async def select_callback(self, interaction: discord.Interaction, quest_id):
        try:
            collection = interaction.client.gdb['quests']
            self.selected_quest = await collection.find_one({'guildId': interaction.guild_id, 'questId': quest_id})

            quest_summary_modal = modals.QuestSummaryModal(self)

            quest_summary_collection = interaction.client.gdb['questSummary']
            quest_summary_config_query = await quest_summary_collection.find_one({'_id': interaction.guild_id})
            if quest_summary_config_query and quest_summary_config_query['questSummary']:
                await interaction.response.send_modal(quest_summary_modal)
            else:
                await self.complete_quest(interaction)
        except Exception as e:
            await log_exception(e, interaction)

    async def complete_quest(self, interaction: discord.Interaction, summary=None):
        try:
            guild_id = interaction.guild_id
            guild = interaction.client.get_guild(guild_id)

            # Fetch the quest
            quest = self.selected_quest

            # Setup quest variables
            quest_id, message_id, title, description, gm, party, rewards = (quest['questId'], quest['messageId'],
                                                                            quest['title'], quest['description'],
                                                                            quest['gm'], quest['party'],
                                                                            quest['rewards'])

            if not party:
                raise Exception('You cannot complete a quest with an empty roster. Try cancelling instead.')

            # Check if there is a configured quest archive channel
            archive_channel = None
            archive_query = await interaction.client.gdb['archiveChannel'].find_one({'_id': guild_id})
            if archive_query:
                archive_channel = guild.get_channel(strip_id(archive_query['archiveChannel']))

            # Check if a party role was configured, and delete it
            party_role_id = quest['partyRoleId']
            if party_role_id:
                role = guild.get_role(party_role_id)
                await role.delete(reason=f'Quest ID {quest['questId']} was completed by {interaction.user.mention}.')

            # Get party members and message them with results
            reward_summary = []
            party_xp = rewards.get('party', {}).get('xp', 0) // len(party)
            party_items = rewards.get('party', {}).get('items', {})
            for entry in party:
                for player_id, character_info in entry.items():
                    member = guild.get_member(int(player_id))

                    # Get character data
                    character_id = next(iter(character_info))
                    character = character_info[character_id]
                    reward_summary.append(f'<@!{player_id}> as {character['name']}:')

                    # Prep reward data
                    total_xp = party_xp
                    combined_items = party_items.copy()

                    # Check if character has individual rewards
                    if character_id in rewards:
                        individual_rewards = rewards[character_id]
                        total_xp += individual_rewards.get('xp', 0)

                        # Merge individual items with party items
                        for item, quantity in individual_rewards.get('items', {}).items():
                            combined_items[item] = combined_items.get(item, 0) + quantity

                    # Update the character's XP and inventory
                    reward_summary.append(f'Experience: {total_xp}')
                    await update_character_experience(interaction, int(player_id), character_id, total_xp)
                    for item_name, quantity in combined_items.items():
                        reward_summary.append(f'{item_name}: {quantity}')
                        await update_character_inventory(interaction, int(player_id), character_id, item_name, quantity)

                    # Send reward summary to player
                    reward_strings = self.build_reward_summary(total_xp, combined_items)
                    dm_embed = discord.Embed(
                        title=f'Quest Complete: {title}',
                        type='rich'
                    )
                    if reward_strings:
                        dm_embed.add_field(name='Rewards', value='\n'.join(reward_strings))
                    try:
                        await member.send(embed=dm_embed)
                    except discord.errors.Forbidden as e:
                        logger.warning(f'Could not DM {member.id} about quest completion rewards: {e}')

            # Build an embed for feedback
            quest_embed = discord.Embed(
                title=title,
                description='',
                type='rich'
            )
            # Format the main embed body
            post_description = (
                f'**GM:** <@!{gm}>\n\n'
                f'{description}\n\n'
                f'------'
            )
            formatted_party = []
            for player in party:
                for member_id in player:
                    for character_id in player[str(member_id)]:
                        character = player[str(member_id)][str(character_id)]
                        formatted_party.append(f'- <@!{member_id}> as {character['name']}')

            # Set the embed fields and footer
            quest_embed.title = f'QUEST COMPLETED: {title}'
            quest_embed.description = post_description
            quest_embed.add_field(name=f'__Party__',
                                  value='\n'.join(formatted_party))
            quest_embed.set_footer(text='Quest ID: ' + quest_id)

            # Add the summary if provided
            if summary:
                quest_embed.add_field(name='Summary', value=summary, inline=False)

            if reward_summary:
                quest_embed.add_field(name='Rewards', value='\n'.join(reward_summary), inline=True)

            # If an archive channel is configured, post the archived quest
            if archive_channel:
                await archive_channel.send(embed=quest_embed)

            # Delete the original quest post
            quest_channel_query = await interaction.client.gdb['questChannel'].find_one({'_id': guild_id})
            quest_channel_id = quest_channel_query['questChannel']
            quest_channel = interaction.client.get_channel(strip_id(quest_channel_id))
            quest_message = quest_channel.get_partial_message(message_id)
            await attempt_delete(quest_message)

            # Remove the quest from the database
            quest_collection = interaction.client.gdb['quests']
            await quest_collection.delete_one({'guildId': guild_id, 'questId': quest_id})

            # Message feedback to the Game Master
            await interaction.user.send(embed=quest_embed)

            # Check if GM rewards are enabled, and reward the GM accordingly
            gm_rewards_collection = interaction.client.gdb['gmRewards']
            gm_rewards_query = await gm_rewards_collection.find_one({'_id': interaction.guild_id})
            if gm_rewards_query:
                experience = gm_rewards_query['experience'] if gm_rewards_query['experience'] else None
                items = gm_rewards_query['items'] if gm_rewards_query['items'] else None

                character_collection = interaction.client.mdb['characters']
                character_query = await character_collection.find_one({'_id': interaction.user.id})
                if not character_query:
                    character_string = ('Your server admin has configured rewards for Game Masters when they complete '
                                        'quests. However, since you have no registered characters, your rewards could '
                                        'not be automatically issued at this time.')
                else:
                    if str(interaction.guild_id) not in character_query['activeCharacters']:
                        character_string = ('Your server admin has configured rewards for Game Masters when they '
                                            'complete quests. However, since you have no active characters on this '
                                            'server, your rewards could not be automatically issued at this time.')
                    else:
                        active_character_id = character_query['activeCharacters'][str(interaction.guild_id)]
                        character_string = (f'The following has been awarded to your active character, '
                                            f'{character_query['characters'][active_character_id]['name']}')
                        if experience:
                            await update_character_experience(interaction, interaction.user.id, active_character_id,
                                                              experience)
                        if items:
                            for item_name, quantity in items.items():
                                await update_character_inventory(interaction, interaction.user.id, active_character_id,
                                                                 item_name, quantity)

                gm_rewards_embed = discord.Embed(
                    title='GM Rewards Issued',
                    description=character_string,
                    type='rich'
                )

                if experience:
                    gm_rewards_embed.add_field(name='Experience', value=experience)

                if items:
                    item_strings = []
                    for item_name, quantity in items.items():
                        item_strings.append(f'{item_name.capitalize()}: {quantity}')
                    gm_rewards_embed.add_field(name='Items', value='\n'.join(item_strings))

                try:
                    await interaction.user.send(embed=gm_rewards_embed)
                except discord.errors.Forbidden as e:
                    logger.warning(f'Could not DM {interaction.user.id} about GM rewards: {e}')

            # Reset the view and handle the interaction response
            self.selected_quest = None
            await setup_view(self, interaction)
            await interaction.response.edit_message(view=self)
        except Exception as e:
            await log_exception(e, interaction)

    @staticmethod
    def build_reward_summary(xp, items) -> list[str]:
        reward_strings = []
        if xp and xp > 0:
            reward_strings.append(f'- Experience Points: {xp}')
        if items:
            for item, quantity in items.items():
                reward_strings.append(f'- {item}: {quantity}')
        return reward_strings


class ViewCharacterView(LayoutView):
    def __init__(self, member_id, character_data, currency_config):
        super().__init__(timeout=None)
        container = Container()

        name = character_data.get('name', 'Unknown')
        xp = character_data['attributes'].get('experience', None)
        inventory = character_data['attributes'].get('inventory', {})
        currency = character_data['attributes'].get('currency', {})

        container.add_item(TextDisplay(content=f'**Character Sheet for {name} (<@{member_id}>)**'))
        container.add_item(Separator())
        if xp:
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
            character_id = self.data['character_id']
            user_id = self.data['user_id']

            for name, quantity in self.data.get('items', {}).items():
                await update_character_inventory(interaction, user_id, character_id, name, quantity)
            for name, quantity in self.data.get('currency', {}).items():
                await update_character_inventory(interaction, user_id, character_id, name, quantity)

            await interaction.client.gdb['approvals'].delete_one({'submission_id': self.data['submission_id']})

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
            await interaction.client.gdb['approvals'].delete_one({'submission_id': self.data['submission_id']})

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
