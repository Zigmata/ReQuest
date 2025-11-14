import asyncio
import logging
from typing import Any, Dict, Iterator, Optional, Tuple

import discord
from discord.ui import View

from ReQuest.ui.common.buttons import MenuViewButton, MenuDoneButton, BackButton, ConfirmButton
from ReQuest.ui.gm import buttons, selects
from ReQuest.utilities.supportFunctions import (
    log_exception,
    strip_id,
    update_character_inventory,
    update_character_experience,
    attempt_delete,
    update_quest_embed,
    find_character_in_lists
)

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class GMBaseView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Game Master - Main Menu',
            description=(
                '__**Quests**__\n'
                'Functions for creating, posting, and managing quests.\n\n'
                '__**Players**__\n'
                'Player management functions such as inventory, experience, and currency modifications.\n\n'
            ),
            type='rich'
        )
        self.gm_quest_menu_button = MenuViewButton(GMQuestMenuView, 'Quests')
        self.gm_player_menu_button = MenuViewButton(GMPlayerMenuView, 'Players')
        self.add_item(self.gm_quest_menu_button)
        self.add_item(self.gm_player_menu_button)
        self.add_item(MenuDoneButton())


class GMQuestMenuView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Game Master - Quests',
            description=(
                '__**Create**__\n'
                'Create and post a new quest.\n\n'
                '__**Manage**__\n'
                'Manage an active quest: Rewards, edits, etc.\n\n'
                '__**Complete**__\n'
                'Complete an active quest. Issues rewards, if any, to party members.\n\n'
            ),
            type='rich'
        )
        self.create_quest_button = buttons.CreateQuestButton(QuestPostView)
        self.manage_quests_view_button = MenuViewButton(ManageQuestsView, 'Manage')
        self.complete_quests_button = MenuViewButton(CompleteQuestsView, 'Complete')
        self.add_item(self.create_quest_button)
        self.add_item(self.manage_quests_view_button)
        self.add_item(self.complete_quests_button)
        self.add_item(BackButton(GMBaseView))


class ManageQuestsView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Game Master - Quest Management',
            description=(
                '__**Edit**__\n'
                'Edits quest fields such as title, party restrictions, party size, and description.\n\n'
                '__**Toggle Ready**__\n'
                'Toggles the ready state of the quest. A quest that is \"ready\" locks the signup roster, and assigns '
                'party roles to members (if configured).\n\n'
                '__**Rewards**__\n'
                'Configure rewards for quest completion, such as individual loot, or group experience.\n\n'
                '__**Remove Player**__\n'
                'Removes a player from the active roster. If there is a waitlist, the highest in the queue will '
                'autofill the open spot.\n\n'
                '__**Cancel**__\n'
                'Cancels a quest, deleting it from the database and the quest channel.\n\n'
                '------\n\n'
            ),
            type='rich'
        )
        self.selected_quest = None
        self.quests = None
        self.manage_quest_select = selects.ManageQuestSelect(self)
        self.edit_quest_button = buttons.EditQuestButton(self, QuestPostView)
        self.toggle_ready_button = buttons.ToggleReadyButton(self)
        self.rewards_menu_button = buttons.RewardsMenuButton(self, RewardsMenuView)
        self.remove_player_button = buttons.RemovePlayerButton(self, RemovePlayerView)
        self.cancel_quest_button = buttons.CancelQuestButton(self, CancelQuestView)
        self.add_item(self.manage_quest_select)
        self.add_item(self.edit_quest_button)
        self.add_item(self.toggle_ready_button)
        self.add_item(self.rewards_menu_button)
        self.add_item(self.remove_player_button)
        self.add_item(self.cancel_quest_button)
        self.add_item(BackButton(GMQuestMenuView))

    async def setup(self, bot, user, guild):
        try:
            self.embed.clear_fields()

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
                logger.debug(f'Found {len(quests)} quests.')
                self.manage_quest_select.disabled = False
            else:
                options.append(discord.SelectOption(label='No quests were found, or you do not have permissions to edit'
                                                          ' them.', value='None'))
                self.manage_quest_select.disabled = True
                self.embed.add_field(name='No Quests Available', value='No quests were found, or you do not have '
                                                                       'permissions to edit them.')
            self.manage_quest_select.options = options
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
                updated_quest = await quest_collection.find_one({'questId': quest_id})

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
                updated_quest = await quest_collection.find_one({'questId': quest_id})

                await interaction.user.send('Quest roster has been unlocked.')

            if len(tasks) > 0:
                results = await asyncio.gather(*tasks, return_exceptions=True)
                for result in results:
                    if isinstance(result, discord.errors.Forbidden):
                        logger.warning(f'Permission error when updating roles or sending DMs: {result}')
                    elif isinstance(result, Exception):
                        await log_exception(result)

            self.selected_quest = updated_quest

            # Create a fresh quest view, and update the original post message
            quest_view = QuestPostView(updated_quest)
            await quest_view.setup()
            await message.edit(embed=quest_view.embed, view=quest_view)

            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)


class RewardsMenuView(View):
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

        self.current_party_rewards = self._extract_party_rewards(self.quest)
        self.current_individual_rewards = {'xp': None, 'items': {}}

        self.individual_rewards_button = buttons.IndividualRewardsButton(self)
        self.party_rewards_button = buttons.PartyRewardsButton(self)
        self.party_member_select = selects.PartyMemberSelect(calling_view=self,
                                                             disabled_components=[self.individual_rewards_button])
        self.add_item(self.party_member_select)
        self.add_item(self.party_rewards_button)
        self.add_item(self.individual_rewards_button)
        self.add_item(BackButton(ManageQuestsView))

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
            self.embed.add_field(
                name='Party Rewards',
                value=self._format_rewards_field(party_rewards),
                inline=False
            )

            if self.selected_character and self.selected_character_id:
                individual_rewards = self._extract_individual_rewards(self.quest, self.selected_character_id)
                self.current_individual_rewards = individual_rewards

                char_name = self.selected_character.get('name', 'Selected Character')
                self.embed.add_field(
                    name=f'Additional rewards for {char_name}',
                    value=self._format_rewards_field(individual_rewards),
                    inline=False
                )
            else:
                self.current_individual_rewards = {"xp": None, "items": {}}

        except Exception as e:
            await log_exception(e)

    def _build_party_member_options(self, quest: Dict[str, Any]) -> list[discord.SelectOption]:
        """
        Your party shape looks like a list of player dicts keyed by member_id -> character_id -> character.
        We’ll iterate safely and produce SelectOptions.
        """
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
        """
        Turn {"xp": 10, "items": {"gold": 3, "potion": 1}} into a neat string.
        """
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


class GMPlayerMenuView(View):
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
        self.add_item(BackButton(GMBaseView))


class RemovePlayerView(View):
    def __init__(self, quest):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='',
            description=(
                'This action will remove the selected player, and fill the vacancy from a wait list, if '
                'applicable.\n\n'
                'Any individual rewards configured for the removed player will be removed from this quest. If you '
                'still want to reward the player for any contributions prior to removal, use the `Modify Player` '
                'context menus to directly issue rewards.'
            ),
            type='rich'
        )
        self.quest = quest
        self.selected_member_id = None
        self.selected_character_id = None
        self.remove_player_select = selects.RemovePlayerSelect(self)
        self.add_item(self.remove_player_select)
        self.add_item(BackButton(ManageQuestsView))

    async def setup(self):
        try:
            self.embed.clear_fields()
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

            if self.selected_character_id:
                character = find_character_in_lists([self.quest['party'], self.quest['waitList']],
                                                    self.selected_member_id,
                                                    self.selected_character_id)

                self.embed.add_field(name='Selected Character', value=character['name'])
            else:
                self.embed.title = f'Select a player to remove from \"{self.quest['title']}\"'
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
            refreshed_view = RemovePlayerView(self.quest)
            await refreshed_view.setup()
            quest_view = QuestPostView(self.quest)
            await quest_view.setup()

            # Update the menu view and the quest post
            await message.edit(embed=quest_view.embed, view=quest_view)
            await interaction.response.edit_message(embed=refreshed_view.embed, view=refreshed_view)

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
                # If the wait list is enabled, this section formats the embed to include the wait list
                if max_wait_list_size > 0:
                    # If there is room in the party, add the user.
                    if len(current_party) < max_party_size:
                        await quest_collection.update_one(
                            {'guildId': guild_id, 'questId': quest_id},
                            {'$push': {'party': {f'{user_id}': {f'{active_character_id}': active_character}}}}
                        )
                    # If the party is full but the wait list is not, add the user to wait list.
                    elif len(current_party) >= max_party_size and len(current_wait_list) < max_wait_list_size:
                        await quest_collection.update_one(
                            {'guildId': guild_id, 'questId': quest_id},
                            {'$push': {'waitList': {f'{user_id}': {f'{active_character_id}': active_character}}}}
                        )

                    # Otherwise, inform the user that the party/wait list is full
                    else:
                        raise Exception(f'Error joining quest **{quest["title"]}**: The quest roster is full!')
                # If there is no wait list, this section formats the embed without it
                else:
                    # If there is room in the party, add the user.
                    if len(current_party) < max_party_size:
                        await quest_collection.update_one(
                            {'guildId': guild_id, 'questId': quest_id},
                            {'$push': {'party': {f'{user_id}': {f'{active_character_id}': active_character}}}}
                        )
                    else:
                        raise Exception(f'Error joining quest **{quest["title"]}**: The quest roster is full!')

                # The document is queried again to build the updated post
                self.quest = await quest_collection.find_one({'guildId': guild_id, 'questId': quest_id})
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


class CompleteQuestsView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Game Master - Quest Completion',
            description=(
                'Select a quest to complete. **This action is irreversible!**\n\n'
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
        self.complete_quest_button = buttons.CompleteQuestButton(self)
        self.add_item(self.quest_select)
        self.add_item(self.complete_quest_button)
        self.add_item(BackButton(GMQuestMenuView))

    async def setup(self, bot, user, guild):
        try:
            self.embed.clear_fields()

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
                logger.debug(f'Found {len(quests)} quests.')
                self.quest_select.disabled = False
            else:
                options.append(discord.SelectOption(label='No quests were found, or you do not have permissions to edit'
                                                          ' them.', value='None'))
                self.quest_select.disabled = True
                self.embed.add_field(name='No Quests Available', value='No quests were found, or you do not have '
                                                                       'permissions to edit them.')
            self.quest_select.options = options

            quest = self.selected_quest
            if quest:
                self.embed.add_field(name='Selected Quest', value=f'`{quest['questId']}`: {quest['title']}')
        except Exception as e:
            await log_exception(e)

    async def select_callback(self, interaction: discord.Interaction):
        try:
            quests = self.quests
            for quest in quests:
                if self.quest_select.values[0] == quest['questId']:
                    self.selected_quest = quest

            await self.setup(bot=interaction.client, user=interaction.user, guild=interaction.guild)
            self.complete_quest_button.label = f'Confirm completion of {self.selected_quest['title']}?'
            self.complete_quest_button.disabled = False
            await interaction.response.edit_message(embed=self.embed, view=self)
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
            self.complete_quest_button.label = 'Confirm?'
            self.complete_quest_button.disabled = True
            await self.setup(bot=interaction.client, user=interaction.user, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.embed, view=self)
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


class CancelQuestView(View):
    def __init__(self, selected_quest):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title=f'Cancel Quest: {selected_quest['title']}',
            description=(
                'This action cannot be undone!'
            ),
            type='rich'
        )
        self.selected_quest = selected_quest
        self.confirm_button = ConfirmButton(self)
        self.confirm_button.disabled = False
        self.add_item(self.confirm_button)
        self.add_item(BackButton(ManageQuestsView))

    async def confirm_callback(self, interaction: discord.Interaction):
        try:
            quest = self.selected_quest
            guild_id = interaction.guild_id
            guild = interaction.client.get_guild(guild_id)

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
            await interaction.client.gdb['quests'].delete_one({'guildId': guild_id, 'questId': quest['questId']})

            # Delete the quest from the quest channel
            channel_query = await interaction.client.gdb['questChannel'].find_one({'_id': guild_id})
            channel_id = strip_id(channel_query['questChannel'])
            quest_channel = guild.get_channel(channel_id)
            message_id = quest['messageId']
            message = quest_channel.get_partial_message(message_id)
            await attempt_delete(message)

            await interaction.response.send_message(f'Quest `{quest['questId']}`: **{title}** cancelled!',
                                                    ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)
