import discord
import shortuuid
from discord import app_commands
from discord.ext.commands import Cog, GroupCog
from ..utilities.supportFunctions import attempt_delete, parse_list, strip_id
from ..utilities.checks import has_gm_role, has_gm_or_mod
from ..utilities.ui import SingleChoiceDropdown, DropdownView

listener = Cog.listener


# TODO: Exception reporting in channel
class QuestBoard(GroupCog, name='quest', description='Commands for posting and updating quests.'):
    """Quest posts and associated reaction signups/options"""

    def __init__(self, bot):
        self.bot = bot
        self.gdb = bot.gdb
        self.mdb = bot.mdb
        super().__init__()

    edit_group = app_commands.Group(name='edit', description='Commands for editing quests.')

    # ---- Listeners and support functions ----

    async def cancel_reaction(self, payload, reason):
        emoji = payload.emoji
        user_id = payload.user_id
        user = self.bot.get_user(user_id)
        channel = self.bot.get_channel(payload.channel_id)
        message_id = payload.message_id
        message = channel.get_partial_message(message_id)

        await message.remove_reaction(emoji, user)
        await user.send(reason)

    async def update_quest_embed(self, quest, is_archival=False) -> discord.Embed:

        (guild_id, quest_id, message_id, title, description, max_party_size, levels, gm, party,
         wait_list, xp, max_wait_list_size, lock_state) = (quest['guildId'], quest['questId'],
                                                           quest['messageId'], quest['title'], quest['desc'],
                                                           quest['maxPartySize'],
                                                           quest['levels'], quest['gm'], quest['party'],
                                                           quest['waitList'], quest['xp'],
                                                           quest['maxWaitListSize'], quest['lockState'])

        current_party_size = len(party)
        current_wait_list_size = 0
        if wait_list:
            current_wait_list_size = len(wait_list)

        formatted_party = []
        # Map int list to string for formatting, then format the list of users as user mentions
        if len(party) > 0:
            for member in party:
                for key in member:
                    character_query = await self.bot.mdb['characters'].find_one({'_id': int(key)})
                    character_name = character_query['characters'][member[key]]['name']
                    formatted_party.append(f'- <@!{key}> as {character_name}')

        formatted_wait_list = []
        # Only format the wait list if there is one.
        if len(wait_list) > 0:
            for member in wait_list:
                for key in member:
                    character_query = await self.bot.mdb['characters'].find_one({'_id': int(key)})
                    character_name = character_query['characters'][member[key]]['name']
                    formatted_wait_list.append(f'- <@!{key}> as {character_name}')

        # Shows the quest is locked if applicable, unless it is being archived.
        if lock_state is True and is_archival is False:
            title = title + ' (LOCKED)'

        # Construct the embed object and edit the post with the new embed
        post_embed = discord.Embed(title=title, type='rich',
                                   description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n\n{description}')
        if len(formatted_party) == 0:
            post_embed.add_field(name=f'__Party ({current_party_size}/{max_party_size})__',
                                 value='None')
        else:
            post_embed.add_field(name=f'__Party ({current_party_size}/{max_party_size})__',
                                 value='\n'.join(formatted_party))
        # Add a wait list field if one is present, unless the quest is being archived.
        if max_wait_list_size > 0 and is_archival is False:
            if len(formatted_wait_list) == 0:
                post_embed.add_field(name=f'__Wait List ({current_wait_list_size}/{max_wait_list_size})__',
                                     value='None')
            else:
                post_embed.add_field(name=f'__Wait List ({current_wait_list_size}/{max_wait_list_size})__',
                                     value='\n'.join(formatted_wait_list))

        post_embed.set_footer(text='Quest ID: ' + quest_id)

        return post_embed

    async def reaction_operation(self, payload):
        """Handles addition/removal of user mentions when reacting to quest posts"""
        # TODO: Level restrictions if enabled
        guild_id = payload.guild_id
        user_id = payload.user_id
        user = self.bot.get_user(user_id)
        if user.bot:
            return

        # Find the configured Quest Channel and get the name (string in <#channelID> format)
        query = await self.gdb['questChannel'].find_one({'guildId': guild_id})
        if not query:
            return  # TODO: Error handling/logging
        quest_channel = query['questChannel']
        # Ensure that only posts in the configured Quest Channel are modified.
        if quest_channel != payload.channel_id:
            return

        channel = self.bot.get_channel(payload.channel_id)
        message_id = payload.message_id
        message = channel.get_partial_message(message_id)

        collection = self.gdb['quests']
        quest = await collection.find_one({'messageId': message_id})  # Get the quest that matches the message ID
        if not quest:
            await self.cancel_reaction(payload, f'Error: Quest not found in database.')
            return

        current_party = quest['party']
        current_wait_list = quest['waitList']
        max_wait_list_size = quest['maxWaitListSize']
        max_party_size = quest['maxPartySize']
        member_collection = self.mdb['characters']
        player_characters = await member_collection.find_one({'_id': user_id})
        if 'activeChars' not in player_characters or str(guild_id) not in player_characters['activeChars']:
            await self.cancel_reaction(payload, f'Error joining quest **{quest["title"]}**: You do not have an active '
                                                f'character on that server. Use the `character` commands to activate '
                                                f'or register!')
            return
        active_character_id = player_characters['activeChars'][f'{guild_id}']

        # If a reaction is added, add the reacting user to the party/wait list if there is room
        if payload.event_type == 'REACTION_ADD':
            if quest['lockState']:
                await self.cancel_reaction(payload, f'Error joining quest **{quest["title"]}**: '
                                                    f'The quest is locked and not accepting players.')
                return
            else:
                if str(guild_id) not in player_characters['activeChars']:
                    await self.cancel_reaction(payload, f'Error joining quest **{quest["title"]}**: '
                                                        f'You have no active characters on that server!')
                    return

                # If the wait list is enabled, this section formats the embed to include the wait list
                if max_wait_list_size > 0:
                    # --- Database operations ---

                    # If there is room in the party, add the user.
                    if len(current_party) < max_party_size:
                        await collection.update_one({'messageId': message_id},
                                                    {'$push': {'party': {f'{user_id}': active_character_id}}})
                    # If the party is full but the wait list is not, add the user to wait list.
                    elif len(current_party) >= max_party_size and len(current_wait_list) < max_wait_list_size:
                        await collection.update_one({'messageId': message_id},
                                                    {'$push': {'waitList': {f'{user_id}': active_character_id}}})

                    # Otherwise, DM the user that the party/wait list is full
                    else:
                        await self.cancel_reaction(payload, f'Error joining quest **{quest["title"]}**: '
                                                            f'The quest roster is full!')
                        return

                    # --- Post edit generation ---

                    # The document is queried again to build the updated post
                    quest = await collection.find_one({'messageId': message_id})

                    post_embed = await self.update_quest_embed(quest)

                    await message.edit(embed=post_embed)

                # If there is no wait list, this section formats the embed without it
                else:
                    # --- Database operations ---

                    # If there is room in the party, add the user.
                    if len(current_party) < max_party_size:
                        await collection.update_one({'messageId': message_id},
                                                    {'$push': {'party': {f'{user_id}': active_character_id}}})
                    else:
                        await self.cancel_reaction(payload, f'Error joining quest **{quest["title"]}**: '
                                                            f'The quest roster is full!')
                        return

                    # --- Post edit generation ---

                    # The document is queried again to build the updated post
                    quest = await collection.find_one({'messageId': message_id})
                    post_embed = await self.update_quest_embed(quest)
                    await message.edit(embed=post_embed)

        # This path is chosen if a reaction is removed.
        else:
            # If the wait list is enabled, this section formats the embed to include the wait list

            guild = self.bot.get_guild(guild_id)
            role_query = await self.gdb['partyRole'].find_one({'guildId': guild_id, 'gm': quest['gm']})

            # If the quest list is locked and a party role exists, fetch the role.
            role = None
            if quest['lockState'] and role_query:
                role = guild.get_role(role_query['role'])

                # Get the member object and remove the role
                member = guild.get_member(user_id)
                await member.remove_roles(role)

            if max_wait_list_size > 0:
                # Find which list the user is in, and remove them from the database
                for entry in current_party:
                    if str(user_id) in entry:
                        await collection.update_one({'messageId': message_id},
                                                    {'$pull': {'party': {f'{user_id}': {'$exists': True}}}})
                        # If there is a wait list, move the first entry into the party automatically
                        if len(current_wait_list) > 0:
                            for new_player in current_wait_list:
                                for key in new_player:
                                    new_member = guild.get_member(int(key))

                                    await collection.update_one({'messageId': message_id},
                                                                {'$push': {'party': new_player}})
                                    await collection.update_one({'messageId': message_id},
                                                                {'$pull': {'waitList': new_player}})

                                    # Notify the member they have been moved into the main party
                                    await new_member.send(f'You have been added to the party for **{quest["title"]}**, '
                                                          f'due to a player dropping!')

                                    # If a role is set, assign it to the player
                                    if role:
                                        await new_member.add_roles(role)

                for entry in current_wait_list:
                    if str(user_id) in entry:
                        await collection.update_one({'messageId': message_id},
                                                    {'$pull': {'waitList': {f'{user_id}': {'$exists': True}}}})

                # Refresh the query with the new document and edit the post
                quest = await collection.find_one({'messageId': message_id})
                post_embed = await self.update_quest_embed(quest)
                await message.edit(embed=post_embed)
            # If there is no wait list, this section formats the embed without it
            else:
                # Remove the user from the quest in the database
                await collection.update_one({'messageId': message_id},
                                            {'$pull': {'party': {f'{user_id}': {'$exists': True}}}})

                quest = await collection.find_one({'messageId': message_id})
                post_embed = await self.update_quest_embed(quest)
                await message.edit(embed=post_embed)

    @listener()
    async def on_raw_reaction_add(self, payload):
        """Reaction_add event handling"""
        if str(payload.emoji) == '<:acceptquest:601559094293430282>':
            await self.reaction_operation(payload)
        else:
            return

    @listener()
    async def on_raw_reaction_remove(self, payload):
        """Reaction_remove event handling"""
        if str(payload.emoji) == '<:acceptquest:601559094293430282>':
            await self.reaction_operation(payload)
        else:
            return

    # ---- GM Commands ----

    # --- Quests ---

    @has_gm_role()
    @app_commands.command(name='post')
    async def post(self, interaction: discord.Interaction, title: str, levels: str, max_party_size: int,
                   description: str):
        """
        Posts a new quest.

        Arguments:
        [title]: The title of the quest.
        [levels]: Can be anything to detail who you want joining. E.G. "1-4" or "All players."
        [max_party_size]: The maximum amount of players that may join the quest.
        [description]: Details of the quest and any other info you'd like to include.
        """

        # TODO: Research exception catching on function argument TypeError
        # TODO: Level min/max for enabled servers

        guild_id = interaction.guild_id
        quest_id = str(shortuuid.uuid()[:8])
        max_wait_list_size = 0

        # Get the server's wait list configuration
        wait_list_query = await self.gdb['questWaitlist'].find_one({'guildId': guild_id})
        if wait_list_query:
            max_wait_list_size = wait_list_query['waitlistValue']

        # Query the collection to see if a channel is set
        quest_channel_query = await self.gdb['questChannel'].find_one({'guildId': guild_id})

        # Inform user if quest channel is not set. Otherwise, get the channel string
        quest_channel = None
        if not quest_channel_query:
            error_embed = discord.Embed(title='Missing Configuration!',
                                        description='Quest channel not set! Configure with /config channel quest'
                                                    ' <channel mention>',
                                        type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)
        else:
            quest_channel = quest_channel_query['questChannel']

        # Query the collection to see if a role is set
        announce_role_query = await self.gdb['announceRole'].find_one({'guildId': guild_id})

        # Grab the announcement role, if configured.
        announce_role: int = 0
        if announce_role_query:
            announce_role = announce_role_query['announceRole']

        collection = self.gdb['quests']
        # Get the channel object.
        channel = self.bot.get_channel(quest_channel)

        # Log the author, then post the new quest with an emoji reaction.
        gm = interaction.user.id
        party: [int] = []
        wait_list: [int] = []
        lock_state = False

        post_embed = discord.Embed(title=title, type='rich',
                                   description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n\n{description}')
        post_embed.add_field(name=f'__Party (0/{max_party_size})__', value=None)
        if max_wait_list_size > 0:
            post_embed.add_field(name=f'__Wait List (0/{max_wait_list_size})__', value=None)
        post_embed.set_footer(text='Quest ID: ' + quest_id)

        # If an announcement role is set, ping it and then delete the message.
        if announce_role != 0:
            ping_msg = await channel.send(f'<@&{announce_role}> **NEW QUEST!**')
            await ping_msg.delete()

        msg = await channel.send(embed=post_embed)
        emoji = '<:acceptquest:601559094293430282>'
        await msg.add_reaction(emoji)
        message_id = msg.id

        try:
            await collection.insert_one({'guildId': guild_id, 'questId': quest_id, 'messageId': message_id,
                                         'title': title, 'desc': description, 'maxPartySize': max_party_size,
                                         'levels': levels, 'gm': gm, 'party': party, 'waitList': wait_list, 'xp': 0,
                                         'maxWaitListSize': max_wait_list_size, 'lockState': lock_state, 'rewards': {}})
            await interaction.response.send_message(f'Quest `{quest_id}`: **{title}** posted!', ephemeral=True)
        except Exception as e:
            await interaction.response.send_message('{}: {}'.format(type(e).__name__, e), ephemeral=True)

    @app_commands.command(name='ready')
    async def ready(self, interaction: discord.Interaction, quest_id: str):
        """
        Locks the quest roster and alerts party members that the quest is ready.

        Arguments:
        [quest_id]: The ID of the quest.
        """
        guild_id = interaction.guild_id
        user_id = interaction.user.id

        # Fetch the quest
        quest_collection = self.gdb['quests']
        quest = await quest_collection.find_one({'questId': quest_id})
        if not quest:
            error_embed = discord.Embed(title='Error!', description='No quest with that ID was found.')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)
            return

        # Confirm the user calling the command is the GM that created the quest
        if not quest['gm'] == user_id:
            error_embed = discord.Embed(title='Error!', description='GMs can only manage their own quests!',
                                        type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)
            return

        # Check to see if the GM has a party role configured
        role_collection = self.gdb['partyRole']
        query = await role_collection.find_one({'guildId': guild_id, 'gm': user_id})
        if query and query['role']:
            role_id = query['role']
        else:
            role_id = None

        # Lock the quest
        await quest_collection.update_one({'questId': quest_id}, {'$set': {'lockState': True}})

        # Fetch the updated quest
        updated_quest = await quest_collection.find_one({'questId': quest_id})
        party = updated_quest['party']
        title = updated_quest['title']

        # Notify each party member that the quest is ready
        guild = self.bot.get_guild(guild_id)
        # TODO: Make this asynchronous
        for player in party:
            for key in player:
                member = guild.get_member(int(key))
                # If the GM has a party role configured, assign it to each party member
                if role_id:
                    role = guild.get_role(role_id)
                    await member.add_roles(role)
                await member.send(f'Game Master <@{user_id}> has marked your quest, **"{title}"**, ready to start!')

        # Fetch the quest channel to retrieve the message object
        channel_id = await self.gdb['questChannel'].find_one({'guildId': guild_id})
        if not channel_id:
            return  # TODO: Error handling/logging

        # Retrieve the message object
        message_id = updated_quest['messageId']
        channel = self.bot.get_channel(channel_id['questChannel'])
        message = channel.get_partial_message(message_id)

        # Create the updated embed, and edit the message
        post_embed = await self.update_quest_embed(updated_quest)
        await message.edit(embed=post_embed)

        await interaction.response.send_message('Quest roster locked and party notified!', ephemeral=True)

    @app_commands.command(name='unready')
    async def unready(self, interaction: discord.Interaction, quest_id: str, players: str = None):
        """
        Unlocks a quest if members are not ready.

        Arguments:
        [quest_id]: The ID of the quest.
        [players](Optional): Can be chained. Removes player(s) from party.
        """
        guild_id = interaction.guild_id
        user_id = interaction.user.id
        quest_collection = self.gdb['quests']
        error_title = None
        error_message = None

        # Fetch the quest channel to retrieve the message object
        channel_id = await self.gdb['questChannel'].find_one({'guildId': guild_id})

        # Fetch the quest
        quest = await quest_collection.find_one({'questId': quest_id})
        if not quest:
            error_title = 'Error!'
            error_message = f'Quest ID {quest_id} was not found in the database.'
        elif not quest['gm'] == user_id:  # Confirm the user calling the command is the GM that created the quest
            error_title = 'Quest Not Edited!'
            error_message = 'GMs can only manage their own quests!'
        elif not channel_id:
            error_title = 'Missing Configuration!'
            error_message = 'Quest channel has not been set!'
        else:
            # Check to see if the GM has a party role configured
            guild = self.bot.get_guild(guild_id)
            party = quest['party']
            role_collection = self.gdb['partyRole']
            query = await role_collection.find_one({'guildId': guild_id, 'gm': user_id})
            if query and query['role']:
                # Remove the role from the players
                role_id = query['role']
                role = guild.get_role(role_id)
                for player in party:
                    for key in player:
                        member = guild.get_member(int(key))
                        await member.remove_roles(role)

            # Unlock the quest
            await quest_collection.update_one({'questId': quest_id}, {'$set': {'lockState': False}})

            # Retrieve the message object
            message_id = quest['messageId']
            channel = self.bot.get_channel(channel_id['questChannel'])
            message = channel.get_partial_message(message_id)

            # This path executes if user mentions are provided
            if players:
                # Split user mentions into an array and parse out the user IDs
                removed_players = players.split()
                player_ids = parse_list(removed_players)

                for player in player_ids:
                    # Remove the player from the party
                    await quest_collection.update_one({'questId': quest_id}, {'$pull': {'party': player}})
                    member = guild.get_member(player)

                    # Remove the player's reactions from the post.
                    [await reaction.gm_remove(member) for reaction in message.reactions]

                    # Notify the player they have been removed.
                    await member.send(f'You have been removed from the party for the quest, **{quest["title"]}**.')

                    # If there is a wait list, move the first player into the party and remove them from the wait list
                    if quest['waitList']:
                        replacement = quest['waitList'][0]
                        replacement_member = guild.get_member(replacement)
                        await quest_collection.update_one({'questId': quest_id}, {'$push': {'party': replacement}})
                        await quest_collection.update_one({'questId': quest_id}, {'$pull': {'waitList': replacement}})

                        # Notify player they are now in the party
                        await replacement_member.send(f'You have been added to the party for the quest, '
                                                      f'**{quest["title"]}**, due to a player dropping!')

            # Fetch the updated quest
            updated_quest = await quest_collection.find_one({'questId': quest_id})

            # Create the updated embed, and edit the message
            post_embed = await self.update_quest_embed(updated_quest)
            await message.edit(embed=post_embed)

            await interaction.response.send_message('Quest roster has been unlocked.', ephemeral=True)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    @app_commands.command(name='complete')
    async def complete(self, interaction: discord.Interaction, quest_id: str, summary: str = None):
        """
        Closes a quest and issues rewards.

        Arguments:
        [quest_id]: The ID of the quest.
        [summary](Optional): A summary of the quest, if enabled (see help config quest summary).
        """
        # TODO: Implement quest removal/archival, optional summary, player and GM reward distribution
        guild_id = interaction.guild_id
        user_id = interaction.user.id
        guild = self.bot.get_guild(guild_id)

        # Fetch the quest
        quest = await self.gdb['quests'].find_one({'questId': quest_id})

        # Confirm the user calling the command is the GM that created the quest
        if not quest['gm'] == user_id:
            error_embed = discord.Embed(title='Quest Not Edited!', description='GMs can only manage their own quests!',
                                        type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)
        else:
            # Check if there is a configured quest archive channel
            archive_channel = None
            archive_query = await self.gdb['archiveChannel'].find_one({'guildId': guild_id})
            if archive_query:
                archive_channel = archive_query['archiveChannel']

            # Check if a GM role was configured
            gm_role = None
            gm = quest['gm']
            role_query = await self.gdb['partyRole'].find_one({'guildId': guild_id, 'gm': gm})
            if role_query:
                gm_role = role_query['role']

            # Get party members and message them with results
            party = quest['party']
            title = quest['title']
            xp_value = quest['xp']
            rewards = quest['rewards']
            reward_summary = []
            member_collection = self.mdb['characters']
            for entry in party:
                for player_id in entry:
                    player = int(player_id)
                    member = guild.get_member(player)
                    # Remove the party role, if applicable
                    if gm_role:
                        role = guild.get_role(gm_role)
                        await member.remove_roles(role)

                    character_query = await member_collection.find_one({'_id': player})
                    character_id = entry[player_id]
                    character = character_query['characters'][character_id]
                    reward_strings = []

                    if str(player) in rewards:
                        if archive_channel:
                            reward_summary.append(f'\n<@!{player}>')
                        inventory = character['attributes']['inventory']
                        for item_name in rewards[f'{player}']:
                            quantity = rewards[f'{player}'][item_name]
                            if item_name in inventory:
                                current_quantity = inventory[item_name]
                                new_quantity = current_quantity + quantity
                                await member_collection.update_one(
                                    {'_id': player},
                                    {'$set': {
                                        f'characters.{character_id}.attributes.inventory.{item_name}': new_quantity}},
                                    upsert=True)
                            else:
                                await member_collection.update_one({'_id': player}, {
                                    '$set': {f'characters.{character_id}.attributes.inventory.{item_name}': quantity}},
                                                             upsert=True)

                            reward_strings.append(f'{quantity}x {item_name}')
                            if archive_channel:
                                reward_summary.append(f'{quantity}x {item_name}')

                    if xp_value:
                        current_xp = character['attributes']['experience']

                        if current_xp:
                            current_xp += xp_value
                        else:
                            current_xp = xp_value

                        # Update the db
                        await member_collection.update_one({'_id': player}, {
                            '$set': {f'characters.{character_id}.attributes.experience': current_xp}}, upsert=True)

                        reward_strings.append(f'{xp_value} experience points')

                    dm_embed = discord.Embed(title=f'Quest Complete: {title}',
                                             type='rich')
                    if reward_strings:
                        dm_embed.add_field(name='Rewards', value='\n'.join(reward_strings))

                    await member.send(embed=dm_embed)

            # Archive the quest, if applicable
            if archive_channel:
                # Fetch the channel object
                channel = guild.get_channel(archive_channel)

                # Build the embed
                post_embed = await self.update_quest_embed(quest, True)
                # If quest summary is configured, add it
                summary_enabled = await self.gdb['questSummary'].find_one({'guildId': guild_id})
                if summary_enabled and summary_enabled['questSummary']:
                    post_embed.add_field(name='Summary', value=summary, inline=False)

                if rewards:
                    post_embed.add_field(name='Rewards', value='\n'.join(reward_summary), inline=True)

                if xp_value:
                    post_embed.add_field(name='Experience Points', value=f'{xp_value} each', inline=True)

                await channel.send(embed=post_embed)

            # Delete the quest from the database
            await self.gdb['quests'].delete_one({'questId': quest_id})

            # Delete the quest from the quest channel
            channel_query = await self.gdb['questChannel'].find_one({'guildId': guild_id})
            channel_id = channel_query['questChannel']
            quest_channel = guild.get_channel(channel_id)
            message_id = quest['messageId']
            message = quest_channel.get_partial_message(message_id)
            await attempt_delete(message)

            await interaction.response.send_message(f'Quest `{quest_id}`: **{title}** completed!', ephemeral=True)

    @app_commands.command(name='delete')
    async def delete(self, interaction: discord.Interaction, quest_id: str):
        """
        Deletes a quest.

        Arguments:
        [quest_id]: The ID of the quest.
        """
        guild_id = interaction.guild_id
        user_id = interaction.user.id
        guild = self.bot.get_guild(guild_id)
        member = guild.get_member(user_id)
        error_title = None
        error_message = None

        # Fetch the quest
        quest = await self.gdb['quests'].find_one({'questId': quest_id})
        if not quest:
            error_title = 'Error!'
            error_message = 'Quest ID not found!'
        # Confirm the user calling the command is the GM that created the quest, or has administrative rights.
        elif not quest['gm'] == user_id and not member.guild_permissions.manage_guild:
            error_title = 'Quest Not Edited!'
            error_message = 'GMs can only manage their own quests!'
        else:
            # If a party exists
            party = quest['party']
            title = quest['title']
            if party:
                # Check if a GM role was configured
                gm_role = None
                gm = quest['gm']
                role_query = await self.gdb['partyRole'].find_one({'guildId': guild_id, 'gm': gm})
                if role_query:
                    gm_role = role_query['role']

                # Get party members and message them with results
                for player in party:
                    for key in player:
                        member = await guild.fetch_member(int(key))
                        # Remove the party role, if applicable
                        if gm_role:
                            role = guild.get_role(gm_role)
                            await member.remove_roles(role)
                        # TODO: Implement loot and XP after those functions are added
                        await member.send(f'Quest **{title}** was cancelled by the GM.')

            # Delete the quest from the database
            await self.gdb['quests'].delete_one({'questId': quest_id})

            # Delete the quest from the quest channel
            channel_query = await self.gdb['questChannel'].find_one({'guildId': guild_id})
            channel_id = channel_query['questChannel']
            quest_channel = guild.get_channel(channel_id)
            message_id = quest['messageId']
            message = quest_channel.get_partial_message(message_id)
            await attempt_delete(message)

            await interaction.response.send_message(f'Quest `{quest_id}`: **{title}** deleted!', ephemeral=True)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    @edit_group.command(name='title')
    async def title(self, interaction: discord.Interaction, quest_id: str, new_title: str):
        """
        Edits the quest's title.

        Arguments:
        [quest_id]: The ID of the quest.
        [new_title]: The updated title.
        """
        guild_id = interaction.guild_id
        guild = self.bot.get_guild(guild_id)
        user_id = interaction.user.id
        # Get the quest board channel
        query = await self.gdb['questChannel'].find_one({'guildId': guild_id})
        quest_channel_id = query['questChannel']
        quest_channel = guild.get_channel(quest_channel_id)
        error_title = None
        error_message = None

        # Find the quest to edit
        collection = self.gdb['quests']
        quest = await collection.find_one({'questId': quest_id})
        if not quest:
            error_title = 'Error!'
            error_message = f'A quest with id {quest_id} was not found in the database!'
        # Confirm the user calling the command is the GM that created the quest
        elif not quest['gm'] == user_id:
            error_title = 'Quest Not Edited!'
            error_message = 'GMs can only manage their own quests!'
        else:
            # Push the edit to db, then grab an updated quest
            await collection.update_one({'questId': quest_id}, {'$set': {'title': new_title}})
            updated_quest = await collection.find_one({'questId': quest_id})

            # Fetch the updated quest and build the embed, then edit the original post
            message = quest_channel.get_partial_message(updated_quest['messageId'])
            post_embed = await self.update_quest_embed(updated_quest)
            await message.edit(embed=post_embed)

            await interaction.response.send_message('Quest Updated!', ephemeral=True)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    @edit_group.command(name='description')
    async def description(self, interaction: discord.Interaction, quest_id: str, new_description: str):
        """
        Edits the description of the provided quest ID.

        Arguments:
        [quest_id]: The ID of the quest.
        [new_description]: The updated description.
        """
        guild_id = interaction.guild_id
        guild = self.bot.get_guild(guild_id)
        user_id = interaction.user.id
        # Get the quest board channel
        query = await self.gdb['questChannel'].find_one({'guildId': guild_id})
        quest_channel_id = query['questChannel']
        quest_channel = guild.get_channel(quest_channel_id)
        error_title = None
        error_message = None

        # Find the quest to edit
        collection = self.gdb['quests']
        quest = await collection.find_one({'questId': quest_id})
        if not quest:
            error_title = 'Error!'
            error_message = f'A quest with id {quest_id} was not found in the database!'
        # Confirm the user calling the command is the GM that created the quest
        elif not quest['gm'] == user_id:
            error_title = 'Quest Not Edited!'
            error_message = 'GMs can only manage their own quests!'
        else:
            # Push the edit to db, then grab an updated quest
            await collection.update_one({'questId': quest_id}, {'$set': {'desc': new_description}})
            updated_quest = await collection.find_one({'questId': quest_id})

            # Fetch the updated quest and build the embed, then edit the original post
            message = quest_channel.get_partial_message(updated_quest['messageId'])
            post_embed = await self.update_quest_embed(updated_quest)
            await message.edit(embed=post_embed)

            await interaction.response.send_message('Quest Updated!', ephemeral=True)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    @edit_group.command(name='partysize')
    async def party_size(self, interaction: discord.Interaction, quest_id: str, new_party_size: int):
        """
        Edits the max party size of the provided quest ID.

        Arguments:
        [quest_id]: The ID of the quest.
        [new_party_size]: The updated party size.
        """
        guild_id = interaction.guild_id
        guild = self.bot.get_guild(guild_id)
        user_id = interaction.user.id
        # Get the quest board channel
        query = await self.gdb['questChannel'].find_one({'guildId': guild_id})
        quest_channel_id = query['questChannel']
        quest_channel = guild.get_channel(quest_channel_id)
        error_title = None
        error_message = None

        # Find the quest to edit
        collection = self.gdb['quests']
        quest = await collection.find_one({'questId': quest_id})
        if not quest:
            error_title = 'Error!'
            error_message = f'A quest with id {quest_id} was not found in the database!'
        # Confirm the user calling the command is the GM that created the quest
        elif not quest['gm'] == user_id:
            error_title = 'Quest Not Edited!'
            error_message = 'GMs can only manage their own quests!'
        else:
            # Push the edit to db, then grab an updated quest
            await collection.update_one({'questId': quest_id}, {'$set': {'maxPartySize': new_party_size}})
            updated_quest = await collection.find_one({'questId': quest_id})

            # Fetch the updated quest and build the embed, then edit the original post
            message = quest_channel.get_partial_message(updated_quest['messageId'])
            post_embed = await self.update_quest_embed(updated_quest)
            await message.edit(embed=post_embed)

            await interaction.response.send_message('Quest Updated!', ephemeral=True)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    @edit_group.command(name='levels')
    async def levels(self, interaction: discord.Interaction, quest_id: str, new_levels: str):
        """
        Edits the advertised level range of the provided quest ID.

        Arguments:
        [quest_id]: The ID of the quest.
        [new_levels]: The updated level range.
        """
        guild_id = interaction.guild_id
        guild = self.bot.get_guild(guild_id)
        user_id = interaction.user.id
        # Get the quest board channel
        query = await self.gdb['questChannel'].find_one({'guildId': guild_id})
        quest_channel_id = query['questChannel']
        quest_channel = guild.get_channel(quest_channel_id)
        error_title = None
        error_message = None

        # Find the quest to edit
        collection = self.gdb['quests']
        quest = await collection.find_one({'questId': quest_id})
        if not quest:
            error_title = 'Error!'
            error_message = f'A quest with id {quest_id} was not found in the database!'
        # Confirm the user calling the command is the GM that created the quest
        elif not quest['gm'] == user_id:
            error_title = 'Quest Not Edited!'
            error_message = 'GMs can only manage their own quests!'
        else:
            # Push the edit to db, then grab an updated quest
            await collection.update_one({'questId': quest_id}, {'$set': {'levels': new_levels}})
            updated_quest = await collection.find_one({'questId': quest_id})

            # Fetch the updated quest and build the embed, then edit the original post
            message = quest_channel.get_partial_message(updated_quest['messageId'])
            post_embed = await self.update_quest_embed(updated_quest)
            await message.edit(embed=post_embed)

            await interaction.response.send_message('Quest Updated!', ephemeral=True)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    @edit_group.command(name='experience')
    async def quest_experience(self, interaction: discord.Interaction, quest_id: str, experience: int):
        """
        Assigns a global experience reward to a quest.

        Experience is awarded equally to each member of a quest party once the quest is completed.

        Arguments:
        <quest_id>: The id of the quest to assign the reward.
        <experience>: The global experience reward for the quest. This value is given to each player.
        """
        guild_id = interaction.guild_id
        guild = self.bot.get_guild(guild_id)
        user_id = interaction.user.id
        member = guild.get_member(user_id)
        collection = self.gdb['quests']
        quest_query = await collection.find_one({'questId': quest_id})
        error_title = None
        error_message = None

        if experience < 1:
            error_title = 'Error!'
            error_message = 'Experience must be a positive integer!'
        elif user_id != quest_query['gm'] and not member.guild_permissions.manage_guild:
            error_title = 'Quest Not Edited!'
            error_message = 'Quests can only be manipulated by their GM or staff!'
        else:
            title = quest_query['title']
            await collection.update_one({'questId': quest_id}, {'$set': {'xp': experience}}, upsert=True)

            await interaction.response.send_message(f'Experience reward for quest `{quest_id}`: **{title}** set to '
                                                    f'{experience} per character!', ephemeral=True)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    @edit_group.command(name='rewards')
    async def quest_rewards(self, interaction: discord.Interaction, quest_id: str, recipients: str, reward_name: str,
                            quantity: int = 1):
        """
        Assigns item rewards to a quest for one, some, or all characters in the party.

        Arguments:
        <quest_id>: The ID of the quest.
        <reward_name>: The name of the item to award.
        <quantity>: The quantity of the item to award each recipient.
        <recipients>: User mentions of recipients. Can be chained.
        """
        guild_id = interaction.guild_id
        guild = self.bot.get_guild(guild_id)
        user_id = interaction.user.id
        member = guild.get_member(user_id)
        collection = self.gdb['quests']
        quest_query = await collection.find_one({'questId': quest_id})
        error_title = None
        error_message = None

        if quantity < 1:
            error_title = 'Quantity Error!'
            error_message = 'Quantity must be a positive integer!'
        elif not quest_query:
            error_title = 'Error!'
            error_message = f'A quest with id {quest_id} was not found in the database!'
        elif user_id != quest_query['gm'] and not member.guild_permissions.manage_guild:
            error_title = 'Quest Not Edited!'
            error_message = 'Quests can only be manipulated by their GM or staff!'
        else:
            title = quest_query['title']
            current_rewards = quest_query['rewards']
            party = quest_query['party']
            valid_players = []
            invalid_players = []

            for player in recipients:
                user_id = strip_id(player)
                user_name = self.bot.get_user(user_id).name
                present = False
                for entry in party:
                    if str(user_id) in entry:
                        present = True

                if not present:
                    invalid_players.append(user_name)
                    continue
                else:
                    valid_players.append(player)

                    if str(user_id) in current_rewards and reward_name in current_rewards[f'{user_id}']:
                        current_quantity = current_rewards[f'{user_id}'][reward_name]
                        new_quantity = current_quantity + quantity
                        await collection.update_one({'questId': quest_id},
                                                    {'$set': {f'rewards.{user_id}.{reward_name}': new_quantity}},
                                                    upsert=True)
                    else:
                        await collection.update_one({'questId': quest_id},
                                                    {'$set': {f'rewards.{user_id}.{reward_name}': quantity}},
                                                    upsert=True)

            if not valid_players:
                error_title = 'Error!'
                error_message = 'No valid players were provided!'
            else:
                update_embed = discord.Embed(title='Rewards updated!', type='rich',
                                             description=f'Quest ID: **{quest_id}**\n'
                                                         f'Title: **{title}**\n'
                                                         f'Reward: **{quantity}x {reward_name} each**')
                update_embed.add_field(name="Recipients", value='\n'.join(valid_players))
                update_embed.add_field(name='The following players were not found in the roster',
                                       value='\n'.join(invalid_players))

                await interaction.response.send_message(embed=update_embed, ephemeral=True)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    # --- GM Options ---

    @has_gm_or_mod()
    @app_commands.command(name='role')
    async def role(self, interaction: discord.Interaction, role_name: str = None):
        """
        Configures a role to be issued to a GM's party.

        WARNING: Avoid placing ReQuest's role higher than any roles you don't want players to have access to.
        Placing ReQuest's role above privileged roles could enable GMs to circumvent your server's hierarchy!

        Arguments:
        [party_role]: The role to set as the calling GM's party role.
        --(no argument): Displays the current setting.
        --(role name): Sets the role for questing parties.
        --(delete|remove): Clears the role.
        """
        guild_id = interaction.guild_id
        guild = self.bot.get_guild(guild_id)
        user_id = interaction.user.id
        collection = self.gdb['partyRole']
        query = await collection.find_one({'guildId': guild_id, 'gm': user_id})
        error_title = None
        error_message = None

        if role_name:
            if role_name.lower() == 'delete' or role_name.lower() == 'remove':
                if query:
                    await collection.delete_one({'guildId': guild_id, 'gm': user_id})
                await interaction.response.send_message('Party role cleared!', ephemeral=True)
            else:
                # Search the list of guild roles for all name matches
                search = filter(lambda r: role_name.lower() in r.name.lower(), guild.roles)
                matches = []
                if search:
                    for match in search:
                        if match.id == guild_id:
                            continue  # Prevent the @everyone role from being added to the list
                        bot_member = guild.get_member(self.bot.user.id)
                        bot_roles = bot_member.roles
                        if match.position >= bot_roles[len(bot_roles) - 1].position:
                            continue  # Prevent roles at or above the bot from being assigned.
                        matches.append({'name': match.name, 'id': int(match.id)})

                if not matches:
                    error_title = f'No valid roles matching `{role_name}` were found!'
                    error_message = 'Check your spelling and use of quotes. ReQuest cannot assign roles above itself ' \
                                    'in your server hierarchy.'
                elif len(matches) == 1:
                    new_role = matches[0]
                    # Add the new role's ID to the database
                    await collection.update_one({'guildId': guild_id, 'gm': user_id},
                                                {'$set': {'role': new_role['id']}}, upsert=True)
                    # Report the changes made
                    role_embed = discord.Embed(title='Party Role Set!', type='rich',
                                               description=f'<@&{new_role["id"]}>')
                    await interaction.response.send_message(embed=role_embed, ephemeral=True)
                elif len(matches) > 1:
                    options = []
                    for match in matches:
                        options.append(discord.SelectOption(label=match['name'], value=str(match['id'])))
                    select = SingleChoiceDropdown(placeholder='Choose One', options=options)
                    view = DropdownView(select)
                    await interaction.response.send_message('Multiple matches found!', view=view, ephemeral=True)
                    await view.wait()
                    new_role = int(select.values[0])

                    # Add the new role's ID to the database
                    await collection.update_one({'guildId': guild_id, 'gm': user_id}, {'$set': {'role': new_role}},
                                                upsert=True)
                    # Report the changes made
                    role_embed = discord.Embed(title='Party Role Set!', type='rich', description=f'<@&{new_role}>')
                    await interaction.edit_original_message(content=None, embed=role_embed, view=None)

        # If no argument is provided, query the db for the current setting
        else:
            if not query:
                error_title = 'Missing Configuration!'
                error_message = f'Party role not set! Configure with `/quest role <role name>`'
            else:
                current_role = query['role']
                post_embed = discord.Embed(title='Quest - Role (This Server)', type='rich',
                                           description=f'<@&{current_role}>')
                await interaction.response.send_message(embed=post_embed, ephemeral=True)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)


async def setup(bot):
    await bot.add_cog(QuestBoard(bot))
