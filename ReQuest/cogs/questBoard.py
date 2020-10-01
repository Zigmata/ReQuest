import asyncio
import shortuuid
import itertools
import bson
import re

import pymongo
from pymongo import MongoClient

import discord
from discord.ext import commands
from discord.ext.commands import Cog, command
from discord.utils import get, find

from ..utilities.supportFunctions import delete_command, has_gm_role, parse_list, strip_id

listener = Cog.listener

# TODO: Exception reporting in channel
class QuestBoard(Cog):
    """Quest posts and associated reaction signups/options"""
    def __init__(self, bot):
        self.bot = bot
        global gdb
        global mdb
        gdb = bot.gdb
        mdb = bot.mdb

# ---- Listeners and support functions ----

    def update_quest_embed(self, quest, is_archival = False) -> discord.Embed:

        (guild_id, quest_id, message_id, title, description, max_party_size, levels, gm, party,
            wait_list, xp, max_wait_list_size, lock_state) = (quest['guildId'], quest['questId'],
            quest['messageId'], quest['title'], quest['desc'], quest['maxPartySize'],
            quest['levels'], quest['gm'], quest['party'], quest['waitList'], quest['xp'],
            quest['maxWaitListSize'], quest['lockState'])

        current_party_size = len(party)
        current_wait_list_size = 0
        if wait_list:
            current_wait_list_size = len(wait_list)

        formatted_party : str = None
        # Map int list to string for formatting, then format the list of users as user mentions
        if party:
            mapped_party = list(map(str, party))
            formatted_party = '- <@!'+'>\n- <@!'.join(mapped_party)+'>'

        formatted_wait_list : str = None
        # Only format the waitlist if there is one.
        if wait_list:
            mapped_wait_list = list(map(str, wait_list))
            formatted_wait_list = '- <@!'+'>\n- <@!'.join(mapped_wait_list)+'>'

        # Shows the quest is locked if applicable, unless it is being archived.
        if lock_state == True and is_archival == False:
            title = title+' (LOCKED)'

        # Construct the embed object and edit the post with the new embed
        post_embed = discord.Embed(title=title, type='rich',
            description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n\n{description}')
        post_embed.add_field(name=f'__Party ({current_party_size}/{max_party_size})__', value=formatted_party)
        # Add a waitlist field if one is present, unless the quest is being archived.
        if max_wait_list_size > 0 and is_archival == False:
            post_embed.add_field(name=f'__Wait List ({current_wait_list_size}/{max_wait_list_size})__', value=formatted_wait_list)
        post_embed.set_footer(text='Quest ID: '+quest_id)

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
        query = gdb['questChannel'].find_one({'guildId': guild_id})
        if not query:
            return # TODO: Error handling/logging
        quest_channel = query['questChannel']
        # Ensure that only posts in the configured Quest Channel are modified.
        if quest_channel != payload.channel_id:
            return

        channel = self.bot.get_channel(payload.channel_id)
        message_id = payload.message_id
        message = await channel.fetch_message(message_id)

            
        collection = gdb['quests']
        quest = collection.find_one({'messageId': message_id}) # Get the quest that matches the message ID
        if not quest:
            emoji = payload.emoji
            await message.remove_reaction(emoji, user)
            return # TODO: Missing quest error handling

        current_party = quest['party']
        current_wait_list = quest['waitList']
        current_party_size = len(current_party)
        max_wait_list_size = quest['maxWaitListSize']
        max_party_size = quest['maxPartySize']
        current_wait_list_size = len(current_wait_list)

        # If a reaction is added, add the reacting user to the party/waitlist if there is room
        if payload.event_type == 'REACTION_ADD':
            if quest['lockState'] == True:
                emoji = payload.emoji
                await message.remove_reaction(emoji, user)
                await user.send('Quest **{}** is locked and not accepting players.'.format(quest['title']))
                return
            else:
                # If the waitlist is enabled, this section formats the embed to include the waitlist
                if max_wait_list_size > 0:
                    # --- Database operations ---

                    # If there is room in the party, add the user.
                    if len(current_party) < max_party_size:
                        collection.update_one({'messageId': message_id}, {'$push': {'party': user_id}})
                    # If the party is full but the waitlist is not, add the user to waitlist.
                    elif len(current_party) >= max_party_size and len(current_wait_list) < max_wait_list_size:
                        collection.update_one({'messageId': message_id}, {'$push': {'waitList': user_id}})
                    # Otherwise, DM the user that the party/waitlist is full
                    else:
                        await self.cancel_reaction(user)
                        return # TODO: Implement user DM that there is no more room

                    # --- Post edit generation ---

                    # The document is queried again to build the updated post
                    quest = collection.find_one({'messageId': message_id})

                    post_embed = self.update_quest_embed(quest)

                    await message.edit(embed=post_embed)

                # If there is no waitlist, this section formats the embed without it
                else:
                    # --- Database operations ---

                    # If there is room in the party, add the user.
                    if len(current_party) < max_party_size:
                        collection.update_one({'messageId': message_id}, {'$push': {'party': user_id}})
                    else:
                        await self.cancel_reaction(user)
                        return # TODO: Implement user DM that there is no more room

                    # --- Post edit generation ---

                    # The document is queried again to build the updated post
                    quest = collection.find_one({'messageId': message_id})
                    post_embed = self.update_quest_embed(quest)
                    await message.edit(embed=post_embed)
        # This path is chosen if a reaction is removed.
        else:
            # If the waitlist is enabled, this section formats the embed to include the waitlist

            guild = self.bot.get_guild(guild_id)
            role_query = gdb['partyRole'].find_one({'guildId': guild_id, 'gm': quest['gm']})

            # If the quest list is locked and a party role exists, fetch the role.
            role = None
            if quest['lockState'] and role_query:
                role = guild.get_role(role_query['role'])

                # Get the member object and remove the role
                member = guild.get_member(user_id)
                await member.remove_roles(role)

            if max_wait_list_size > 0:
                # Find which list the user is in, and remove them from the database
                if user_id in current_party:
                    collection.update_one({'messageId': message_id}, {'$pull': {'party': user_id}})
                    # If there is a waitlist, move the first entry into the party automatically
                    if current_wait_list:
                        new_player = current_wait_list[0]
                        new_member = guild.get_member(new_player)

                        collection.update_one({'messageId': message_id}, {'$push': {'party': new_player}})
                        collection.update_one({'messageId': message_id}, {'$pull': {'waitList': new_player}})

                        # Notify the member they have been moved into the main party
                        await new_member.send('You have been added to the party for the quest, **{}**, due to a player dropping!'.format(quest['title']))

                        # If a role is set, assign it to the player
                        if role:
                            await new_member.add_roles(role)

                elif user_id in current_wait_list:
                    collection.update_one({'messageId': message_id}, {'$pull': {'waitList': user_id}})
                else:
                    return # TODO: Error handling

                # Refresh the query with the new document and edit the post
                quest = collection.find_one({'messageId': message_id})
                post_embed = self.update_quest_embed(quest)
                await message.edit(embed=post_embed)
            # If there is no waitlist, this section formats the embed without it
            else:
                # Remove the user from the quest in the database
                collection.update_one({'messageId': message_id}, {'$pull': {'party': user_id}})

                quest = collection.find_one({'messageId': message_id})
                post_embed = self.update_quest_embed(quest)
                await message.edit(embed=post_embed)

    @listener()
    async def on_raw_reaction_add(self, payload):
        """Reaction_add event handling"""
        if str(payload.emoji) == '<:acceptquest:601559094293430282>':
            await QuestBoard.reaction_operation(self, payload)
        else:
            return

    @listener()
    async def on_raw_reaction_remove(self, payload):
        """Reaction_remove event handling"""
        if str(payload.emoji) == '<:acceptquest:601559094293430282>':
            await QuestBoard.reaction_operation(self, payload)
        else:
            return

# ---- GM Commands ----

    # --- Quests ---

    # TODO: Figure out what is conflicting with normal decorator function to
    # handle GM checks in a support function instead.

    @commands.group(case_insensitive = True, pass_context = True)
    @has_gm_role()
    async def quest(self, ctx):
        """
        Commands for quest management.
        """
        if ctx.invoked_subcommand is None:
            return # TODO: Error message feedback

    @quest.command(pass_context = True)
    async def post(self, ctx, title, levels, max_party_size: int, *, description):
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

        guild_id = ctx.message.guild.id
        quest_id = str(shortuuid.uuid()[:8])
        max_wait_list_size = 0

        # Get the server's waitlist configuration
        query = gdb['questWaitlist'].find_one({'guildId': guild_id})
        if query:
            max_wait_list_size = query['waitlistValue']

        # Query the collection to see if a channel is set
        query = gdb['questChannel'].find_one({'guildId': guild_id})

        # Inform user if quest channel is not set. Otherwise, get the channel string
        quest_channel : int = None
        if not query:
            await ctx.send('Quest channel not set! Configure with `{}config channel quest <channel mention>`'.format(self.bot.command_prefix))
            return
        else:
            quest_channel = query['questChannel']

        # Query the collection to see if a role is set
        query = gdb['announceRole'].find_one({'guildId': guild_id})

        # Inform user if announcement role is not set. Otherwise, get the channel string
        # TODO: Make announcement role optional
        announce_role : int = None
        if query:
            announce_role = query['announceRole']
    
        collection = gdb['quests']
        # Slice the string so we just have the ID, and use that to get the channel object.
        channel = self.bot.get_channel(quest_channel)

        # Set post format and log the author, then post the new quest with an emoji reaction.
        message_id = 0
        gm = ctx.author.id
        party : [int] = []
        wait_list : [int] = []
        xp : int = None
        lock_state = False

        post_embed = discord.Embed(title=title, type='rich', description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n\n{description}')
        post_embed.add_field(name=f'__Party (0/{max_party_size})__', value=None)
        if max_wait_list_size > 0:
            post_embed.add_field(name=f'__Wait List (0/{max_wait_list_size})__', value=None)
        post_embed.set_footer(text='Quest ID: '+quest_id)

        if announce_role:
            ping_msg = await channel.send(f'<@&{announce_role}> **NEW QUEST!**')
            await ping_msg.delete()
        msg = await channel.send(embed=post_embed)
        emoji = '<:acceptquest:601559094293430282>'
        await msg.add_reaction(emoji)
        message_id = msg.id
        await ctx.send(f'Quest `{quest_id}`: **{title}** posted!')

        try:
            collection.insert_one({'guildId': guild_id, 'questId': quest_id, 'messageId': message_id,
                'title': title, 'desc': description, 'maxPartySize': max_party_size, 'levels': levels,
                'gm': gm, 'party': party, 'waitList': wait_list, 'xp': xp, 'maxWaitListSize': max_wait_list_size,
                'lockState': lock_state})
        except Exception as e:
            await ctx.send('{}: {}'.format(type(e).__name__, e))

        await delete_command(ctx.message)

    @quest.command(pass_context = True)
    async def ready(self, ctx, quest_id):
        """
        Locks the quest roster and alerts party members that the quest is ready.

        Arguments:
        [quest_id]: The ID of the quest.
        """
        guild_id = ctx.message.guild.id
        user_id = ctx.author.id
        
        # Fetch the quest
        qcollection = gdb['quests']
        quest = qcollection.find_one({'questId': quest_id})
        if not quest:
            # TODO: Error reporting/logging on no quest match
            await delete_command(ctx.message)
            return

        # Confirm the user calling the command is the GM that created the quest
        if not quest['gm'] == user_id:
            await ctx.send('GMs can only manage their own quests!')
            await delete_command(ctx.message)
            return

        # Check to see if the GM has a party role configured
        role_id : int = None
        rcollection = gdb['partyRole']
        query = rcollection.find_one({'guildId': guild_id, 'gm': user_id})
        if query and query['role']:
            role_id = query['role']

        # Lock the quest
        qcollection.update_one({'questId': quest_id}, {'$set': {'lockState': True}})

        # Fetch the updated quest
        updated_quest = qcollection.find_one({'questId': quest_id})
        party = updated_quest['party']
        title = updated_quest['title']
        
        # Notify each party member that the quest is ready
        guild = self.bot.get_guild(guild_id)
        for player in party:
            member = guild.get_member(player)
            # If the GM has a party role configured, assign it to each party member
            if role_id:
                role = guild.get_role(role_id)
                await member.add_roles(role)
            await member.send(f'Game Master <@{user_id}> has marked your quest, **"{title}"**, ready to start!')

        # Fetch the quest channel to retrieve the message object
        channel_id = gdb['questChannel'].find_one({'guildId': guild_id})
        if not channel_id:
            return # TODO: Error handling/logging

        # Retrieve the message object
        message_id = updated_quest['messageId']
        channel = self.bot.get_channel(channel_id['questChannel'])
        message = await channel.fetch_message(message_id)

        # Create the updated embed, and edit the message
        post_embed = self.update_quest_embed(updated_quest)
        await message.edit(embed = post_embed)
        
        await delete_command(ctx.message)

    @quest.command(aliases = ['ur'], pass_context = True)
    async def unready(self, ctx, quest_id, *, players = None):
        # TODO: Implement player removal notification
        """
        Unlocks a quest if members are not ready.

        Arguments:
        [quest_id]: The ID of the quest.
        [players](Optional): Can be chained. Removes player(s) from party.
        """
        guild_id = ctx.message.guild.id
        user_id = ctx.author.id
        qcollection = gdb['quests']

        # Fetch the quest
        quest = qcollection.find_one({'questId': quest_id})
        if not quest:
            # TODO: Error reporting/logging on no quest match
            await delete_command(ctx.message)
            return

        # Confirm the user calling the command is the GM that created the quest
        if not quest['gm'] == user_id:
            await ctx.send('GMs can only manage their own quests!')
            await delete_command(ctx.message)
            return

        # Check to see if the GM has a party role configured
        guild = self.bot.get_guild(guild_id)
        party = quest['party']
        rcollection = gdb['partyRole']
        query = rcollection.find_one({'guildId': guild_id, 'gm': user_id})
        if query and query['role']:
            # Remove the role from the players
            role_id = query['role']
            role = guild.get_role(role_id)
            for player in party:
                member = guild.get_member(player)
                await member.remove_roles(role)

        # Unlock the quest
        qcollection.update_one({'questId': quest_id}, {'$set': {'lockState': False}})

        # Fetch the quest channel to retrieve the message object        
        channel_id = gdb['questChannel'].find_one({'guildId': guild_id})
        if not channel_id:
            return # TODO: Error handling/logging for missing questChannel document

        # Retrieve the message object
        message_id = quest['messageId']
        channel = self.bot.get_channel(channel_id['questChannel'])
        message = await channel.fetch_message(message_id)

        # This path executes if user mentions are provided
        if players:
            # Split user mentions into an array and parse out the user IDs
            removed_players = players.split()
            player_ids = parse_list(removed_players)

            for player in player_ids:
                # Remove the player from the party
                qcollection.update_one({'questId': quest_id}, {'$pull': {'party': player}})
                member = guild.get_member(player)

                # Remove the player's reactions from the post.
                [await reaction.remove(member) for reaction in message.reactions]

                # Notify the player they have been removed.
                await member.send('You have been removed from the party for the quest, **{}**.'.format(quest['title']))
                
                replacement = None
                replacement_member = None
                # If there is a wait list, move the first player into the party and remove them from the wait list
                if quest['waitList']:
                    replacement = quest['waitList'][0]
                    replacement_member = guild.get_member(replacement)
                    qcollection.update_one({'questId': quest_id}, {'$push': {'party': replacement}})
                    qcollection.update_one({'questId': quest_id}, {'$pull': {'waitList': replacement}})

                    # Notify player they are now in the party
                    await replacement_member.send('You have been added to the party for the quest, **{}**, due to a player dropping!'.format(quest['title']))

        # Fetch the updated quest
        updated_quest = qcollection.find_one({'questId': quest_id})

        # Create the updated embed, and edit the message
        post_embed = self.update_quest_embed(updated_quest)
        await message.edit(embed = post_embed)
        
        await delete_command(ctx.message)

    @quest.command(pass_context = True)
    async def complete(self, ctx, quest_id, *, summary = None):
        """
        Closes a quest and issues rewards.

        Arguments:
        [quest_id]: The ID of the quest.
        [summary](Optional): A summary of the quest. Requires admin enable of quest summaries (see help config quest summary).
        """
        # TODO: Implement quest removal/archival, optional summary, player and GM reward distribution
        guild_id = ctx.message.guild.id
        user_id = ctx.author.id
        guild = self.bot.get_guild(guild_id)

        # Fetch the quest
        quest = gdb['quests'].find_one({'questId': quest_id})

        # Confirm the user calling the command is the GM that created the quest
        if not quest['gm'] == user_id:
            await ctx.send('GMs can only manage their own quests!')
            await delete_command(ctx.message)
            return

        # Check if there is a configured quest archive channel
        archive_channel = None
        archive_query = gdb['archiveChannel'].find_one({'guildId': guild_id})
        if archive_query:
            archive_channel = archive_query['archiveChannel']

        # Check if a GM role was configured
        gm_role = None
        gm = quest['gm']
        role_query = gdb['partyRole'].find_one({'guildId': guild_id, 'gm': gm})
        if role_query:
            gm_role = role_query['role']

        # Get party members and message them with results
        party = quest['party']
        title = quest['title']
        for player in party:
            member = guild.get_member(player)
            # Remove the party role, if applicable
            if gm_role:
                role = guild.get_role(gm_role)
                await member.remove_roles(role)
            # TODO: Implement loot and XP after those functions are added
            await member.send(f'Quest Complete: **{title}**')

        # Archive the quest, if applicable
        if archive_channel:
            # Fetch the channel object
            channel = guild.get_channel(archive_channel)

            # Build the embed
            post_embed = self.update_quest_embed(quest, True)
            # If quest summary is configured, add it
            summary_enabled = gdb['questSummary'].find_one({'guildId': guild_id})
            if summary_enabled and summary_enabled['questSummary']:
                post_embed.add_field(name = 'Summary', value = summary, inline = False)
                
            await channel.send(embed = post_embed)

        # Delete the quest from the database
        result = gdb['quests'].delete_one({'questId': quest_id})

        # Delete the quest from the quest channel
        channel_id = gdb['questChannel'].find_one({'guildId': guild_id})['questChannel']
        quest_channel = guild.get_channel(channel_id)
        message_id = quest['messageId']
        message = await quest_channel.fetch_message(message_id)
        await message.delete()

        await delete_command(ctx.message)

    @quest.command(aliases = ['cancel'], pass_context = True)
    async def delete(self, ctx, quest_id):
        """
        Deletes a quest.

        Arguments:
        [quest_id]: The ID of the quest.
        """
        guild_id = ctx.message.guild.id
        user_id = ctx.author.id
        guild = self.bot.get_guild(guild_id)

        # Fetch the quest
        quest = gdb['quests'].find_one({'questId': quest_id})
        if not quest:
            await ctx.send('Quest ID not found!')
            await delete_command(ctx.message)
            return

        # Confirm the user calling the command is the GM that created the quest, or
        # has administrative rights.
        member = guild.get_member(user_id)
        if not quest['gm'] == user_id or not member.guild_permissions.manage_guild:
            await ctx.send('GMs can only manage their own quests!')
            await delete_command(ctx.message)
            return

        # If a party exists
        party = quest['party']
        title = quest['title']
        if party:        
            # Check if a GM role was configured
            gm_role = None
            gm = quest['gm']
            role_query = gdb['partyRole'].find_one({'guildId': guild_id, 'gm': gm})
            if role_query:
                gm_role = role_query['role']

            # Get party members and message them with results

            for player in party:
                member = guild.get_member(player)
                # Remove the party role, if applicable
                if gm_role:
                    role = guild.get_role(gm_role)
                    await member.remove_roles(role)
                # TODO: Implement loot and XP after those functions are added
                await member.send(f'Quest **{title}** was cancelled by the GM.')

        # Delete the quest from the database
        result = gdb['quests'].delete_one({'questId': quest_id})

        # Delete the quest from the quest channel
        channel_id = gdb['questChannel'].find_one({'guildId': guild_id})['questChannel']
        quest_channel = guild.get_channel(channel_id)
        message_id = quest['messageId']
        message = await quest_channel.fetch_message(message_id)
        await message.delete()

        await ctx.send(f'Quest `{quest_id}`: **{title}** deleted!')

        await delete_command(ctx.message)

    @quest.group(case_insensitive = True, pass_context = True)
    async def edit(self, ctx):
        """Commands for editing of quest posts."""
        #TODO Implement quest title/levels/partysize/description updating
        if ctx.invoked_subcommand is None:
            return # TODO: Error message feedback

    @edit.command(pass_context = True)
    async def title(self, ctx, quest_id, *, new_title):
        """
        Edits the quest's title.

        Arguments:
        [quest_id]: The ID of the quest.
        [new_title]: The updated title.
        """
        guild_id = ctx.message.guild.id
        guild = self.bot.get_guild(guild_id)
        user_id = ctx.author.id
        # Get the quest board channel
        quest_channel_id = gdb['questChannel'].find_one({'guildId': guild_id})['questChannel']
        quest_channel = guild.get_channel(quest_channel_id)

        # Find the quest to edit
        collection = gdb['quests']
        quest = collection.find_one({'questId': quest_id})
        if not quest:
            # TODO: Error handling
            await delete_command(ctx.message)
            return

        # Confirm the user calling the command is the GM that created the quest
        if not quest['gm'] == user_id:
            await ctx.send('GMs can only manage their own quests!')
            await delete_command(ctx.message)
            return

        # Push the edit to db, then grab an updated quest
        collection.update_one({'questId': quest_id}, {'$set': {'title': new_title}})
        updated_quest = collection.find_one({'questId': quest_id})

        # Fetch the updated quest and build the embed, then edit the original post
        message = await quest_channel.fetch_message(updated_quest['messageId'])
        post_embed = self.update_quest_embed(updated_quest)
        await message.edit(embed = post_embed)

        await ctx.send('Quest Updated!')

        await delete_command(ctx.message)

    @edit.command(aliases = ['desc'], pass_context = True)
    async def description(self, ctx, quest_id, *, new_description):
        """
        Edits the description of the provided quest ID.

        Arguments:
        [quest_id]: The ID of the quest.
        [new_description]: The updated description.
        """
        guild_id = ctx.message.guild.id
        guild = self.bot.get_guild(guild_id)
        user_id = ctx.author.id
        # Get the quest board channel
        quest_channel_id = gdb['questChannel'].find_one({'guildId': guild_id})['questChannel']
        quest_channel = guild.get_channel(quest_channel_id)

        # Find the quest to edit
        collection = gdb['quests']
        quest = collection.find_one({'questId': quest_id})
        if not quest:
            # TODO: Error handling
            await delete_command(ctx.message)
            return

        # Confirm the user calling the command is the GM that created the quest
        if not quest['gm'] == user_id:
            await ctx.send('GMs can only manage their own quests!')
            await delete_command(ctx.message)
            return

        # Push the edit to db, then grab an updated quest
        collection.update_one({'questId': quest_id}, {'$set': {'desc': new_description}})
        updated_quest = collection.find_one({'questId': quest_id})

        # Fetch the updated quest and build the embed, then edit the original post
        message = await quest_channel.fetch_message(updated_quest['messageId'])
        post_embed = self.update_quest_embed(updated_quest)
        await message.edit(embed = post_embed)

        await ctx.send('Quest Updated!')

        await delete_command(ctx.message)

    @edit.command(name = 'partysize', aliases = ['party'], pass_context = True)
    async def party_size(self, ctx, quest_id, *, new_party_size : int):
        """
        Edits the max party size of the provided quest ID.

        Arguments:
        [quest_id]: The ID of the quest.
        [new_party_size]: The updated party size.
        """
        guild_id = ctx.message.guild.id
        guild = self.bot.get_guild(guild_id)
        user_id = ctx.author.id
        # Get the quest board channel
        quest_channel_id = gdb['questChannel'].find_one({'guildId': guild_id})['questChannel']
        quest_channel = guild.get_channel(quest_channel_id)

        # Find the quest to edit
        collection = gdb['quests']
        quest = collection.find_one({'questId': quest_id})
        if not quest:
            # TODO: Error handling
            await delete_command(ctx.message)
            return

        # Confirm the user calling the command is the GM that created the quest
        if not quest['gm'] == user_id:
            await ctx.send('GMs can only manage their own quests!')
            await delete_command(ctx.message)
            return

        # Push the edit to db, then grab an updated quest
        collection.update_one({'questId': quest_id}, {'$set': {'maxPartySize': new_party_size}})
        updated_quest = collection.find_one({'questId': quest_id})

        # Fetch the updated quest and build the embed, then edit the original post
        message = await quest_channel.fetch_message(updated_quest['messageId'])
        post_embed = self.update_quest_embed(updated_quest)
        await message.edit(embed = post_embed)

        await ctx.send('Quest Updated!')

        await delete_command(ctx.message)

    @edit.command(pass_context = True)
    async def levels(self, ctx, quest_id, *, new_levels):
        """
        Edits the advertised level range of the provided quest ID.

        Arguments:
        [quest_id]: The ID of the quest.
        [new_levels]: The updated level range.
        """
        guild_id = ctx.message.guild.id
        guild = self.bot.get_guild(guild_id)
        user_id = ctx.author.id
        # Get the quest board channel
        quest_channel_id = gdb['questChannel'].find_one({'guildId': guild_id})['questChannel']
        quest_channel = guild.get_channel(quest_channel_id)

        # Find the quest to edit
        collection = gdb['quests']
        quest = collection.find_one({'questId': quest_id})
        if not quest:
            # TODO: Error handling
            await delete_command(ctx.message)
            return

        # Confirm the user calling the command is the GM that created the quest
        if not quest['gm'] == user_id:
            await ctx.send('GMs can only manage their own quests!')
            await delete_command(ctx.message)
            return

        # Push the edit to db, then grab an updated quest
        collection.update_one({'questId': quest_id}, {'$set': {'levels': new_levels}})
        updated_quest = collection.find_one({'questId': quest_id})

        # Fetch the updated quest and build the embed, then edit the original post
        message = await quest_channel.fetch_message(updated_quest['messageId'])
        post_embed = self.update_quest_embed(updated_quest)
        await message.edit(embed = post_embed)

        await ctx.send('Quest Updated!')

        await delete_command(ctx.message)

    # --- GM Options ---

    @quest.command(pass_context = True)
    async def role(self, ctx, party_role = None):
        # TODO: Input sanitization
        """
        Configures a role to be issued to a GM's party.

        Arguments:
        [party_role]: The role to set as the calling GM's party role.
        --(no argument): Displays the current setting.
        --(role name): Sets the role for questing parties.
        --(delete|remove): Clears the role.
        """
        guild_id = ctx.message.guild.id
        guild = self.bot.get_guild(guild_id)
        user_id = ctx.author.id

        collection = gdb['partyRole']
        query = collection.find_one({'guildId': guild_id, 'gm': user_id})

        if not party_role:
            if not query or not query['role']:
                await ctx.send('No GM role set! Configure with `{}quest role <role mention>`'.format(self.bot.command_prefix))
            else:
                # Get the current role and display
                role_id = query['role']
                role_name = guild.get_role(role_id).name
                await ctx.send(f'Current GM role is `{role_name}`')
        elif party_role == 'delete' or party_role == 'remove':
            collection.delete_one({'guildId': guild_id, 'gm': user_id})
            await ctx.send('GM role deleted!')
        else:
            search = find(lambda r: r.name.lower() == party_role.lower(), guild.roles)
            if not search:
                await ctx.send('Role not found! Check your spelling and/or quotes!')
                await delete_command(ctx.message)
                return

            role_id = search.id
            collection.update_one({'guildId': guild_id, 'gm': user_id}, {'$set': {'role': role_id}}, upsert = True)

            await ctx.send(f'Your GM role for this server has been set to `{search.name}`!')

        await delete_command(ctx.message)

def setup(bot):
    bot.add_cog(QuestBoard(bot))
