import shortuuid
import itertools
import bson
import re

import pymongo
from pymongo import MongoClient

import discord
from discord.ext import commands
from discord.ext.commands import Cog, command

from ..utilities.supportFunctions import delete_command, has_gm_role

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

    async def reaction_operation(self, payload):
        """Handles addition/removal of user mentions when reacting to quest posts"""
        guild_id = payload.guild_id
        channel = self.bot.get_channel(payload.channel_id)
        message_id = payload.message_id
        message = await channel.fetch_message(message_id)
        user_id = payload.user_id
        user = self.bot.get_user(user_id)

        # Find the configured Quest Channel and get the name (string in <#channelID> format)
        query = gdb['questChannel'].find_one({'guildId': guild_id})
        if not query:
            return # TODO: Error handling/logging
        quest_channel = query['questChannel']

        # Ensure that only posts in the configured Quest Channel are modified.
        if quest_channel != payload.channel.id:
            return
            
        collection = gdb['quests']
        query = collection.find_one({'messageId': message_id}) # Get the quest that matches the message ID
        if not query:
            return # TODO: Missing quest error handling

        current_party = query['party']
        current_wait_list = query['waitList']
        current_party_size = len(current_party)
        max_wait_list_size = query['maxwait_list_size']
        max_party_size = query['maxparty_size']
        current_wait_list_size = len(current_wait_list)

        # If a reaction is added, add the reacting user to the party/waitlist if there is room
        if payload.event_type == 'REACTION_ADD':
            if payload.member.bot: # Ignore the event if a bot added the reaction
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
                        emoji = self.bot.get_emoji(':acceptquest:601559094293430282')
                        if not user.bot:
                            await message.remove_reaction(emoji, user)
                        return # TODO: Implement user DM that there is no more room

                    # --- Post edit generation ---

                    # The document is queried again to build the updated post
                    query = collection.find_one({'messageId': message_id})

                    quest_id, title, description, levels, gm, party, wait_list = (query['questId'], query['title'],
                            query['desc'], query['levels'], query['gm'], query['party'], query['waitList'])

                    # Get the size of the party and wait lists
                    party_size = len(party)
                    wait_list_size = len(wait_list)

                    # Map int list to string for formatting, then format the list of users as user mentions
                    mapped_party = list(map(str, party))
                    formatted_party = '- <@!'+'>\n- <@!'.join(mapped_party)+'>'

                    formatted_wait_list : str = None
                    # Only format the waitlist if there is one.
                    if wait_list:
                        mapped_wait_list = list(map(str, wait_list))
                        formatted_wait_list = '- <@!'+'>\n- <@!'.join(mapped_wait_list)+'>'

                    # Construct the embed object and edit the post with the new embed
                    post_embed = discord.Embed(title=title, type='rich',
                        description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n**Description:**\n{description}')
                    post_embed.add_field(name=f'__Party ({party_size}/{max_party_size})__', value=formatted_party)
                    post_embed.add_field(name=f'__Wait List ({wait_list_size}/{max_wait_list_size})__', value=formatted_wait_list)
                    post_embed.set_footer(text='Quest ID: '+quest_id)

                    await message.edit(embed=post_embed)

                # If there is no waitlist, this section formats the embed without it
                else:
                    # --- Database operations ---

                    # If there is room in the party, add the user.
                    if len(current_party) < max_party_size:
                        collection.update_one({'messageId': message_id}, {'$push': {'party': user_id}})
                    else:
                        emoji = self.bot.get_emoji(601559094293430282)
                        if not user.bot:
                            await message.remove_reaction(emoji, user)
                        return # TODO: Implement user DM that there is no more room

                    # --- Post edit generation ---

                    # The document is queried again to build the updated post
                    query = collection.find_one({'messageId': message_id})

                    quest_id, title, description, levels, gm, party = (query['questId'], query['title'],
                        query['desc'], query['levels'], query['gm'], query['party'])

                    # Get the size of the party list
                    party_size = len(party)

                    # Map int list to string for formatting
                    mapped_party = list(map(str, party))

                    # Format the list of users as user mentions
                    formatted_party = '- <@!'+'>\n- <@!'.join(mapped_party)+'>'

                    # Construct the embed object and edit the post with the new embed
                    post_embed = discord.Embed(title=title, type='rich',
                        description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n**Description:**\n{description}')
                    post_embed.add_field(name=f'__Party ({party_size}/{max_party_size})__', value=formatted_party)
                    post_embed.set_footer(text='Quest ID: '+quest_id)

                    await message.edit(embed=post_embed)
        # This path is chosen if a reaction is removed.
        else:
            # If the waitlist is enabled, this section formats the embed to include the waitlist
            if max_wait_list_size > 0:
                # --- Database operations ---

                # Find which list the user is in, and remove them from the database
                if user_id in current_party:
                    collection.update_one({'messageId': message_id}, {'$pull': {'party': user_id}})
                    # If there is a waitlist, move the first entry into the party automatically
                    if current_wait_list:
                        player = current_wait_list[0]
                        collection.update_one({'messageId': message_id}, {'$push': {'party': player}})
                        collection.update_one({'messageId': message_id}, {'$pull': {'waitList': player}})
                elif user_id in current_wait_list:
                    collection.update_one({'messageId': message_id}, {'$pull': {'waitList': user_id}})
                else:
                    return # TODO: Error handling

                # --- Post edit generation ---

                # Refresh the query with the new document
                query = collection.find_one({'messageId': message_id})

                quest_id, title, description, levels, gm, party, wait_list = (query['questId'], query['title'],
                    query['desc'], query['levels'], query['gm'], query['party'], query['waitList'])

                # Get the size of the party and wait lists
                party_size = len(party)
                wait_list_size = len(wait_list)

                # Format the party and waitlists.
                formatted_party : str = None
                if party:
                    mapped_party = list(map(str, party))
                    formatted_party = '- <@!'+'>\n- <@!'.join(mapped_party)+'>'
                formatted_wait_list : str = None
                if wait_list:
                    mapped_wait_list = list(map(str, wait_list))
                    formatted_wait_list = '- <@!'+'>\n- <@!'.join(mapped_wait_list)+'>'

                # Build the embed object and update the post with the new embed
                post_embed = discord.Embed(title=title, type='rich',
                    description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n**Description:**\n{description}')
                post_embed.add_field(name=f'__Party ({party_size}/{max_party_size})__', value=formatted_party)
                post_embed.add_field(name=f'__Wait List ({wait_list_size}/{max_wait_list_size})__', value=formatted_wait_list)
                post_embed.set_footer(text='Quest ID: '+quest_id)

                await message.edit(embed=post_embed)
            # If there is no waitlist, this section formats the embed without it
            else:
                # --- Database operations ---

                # Remove the user from the quest in the database
                collection.update_one({'messageId': message_id}, {'$pull': {'party': user_id}})

                # --- Post edit generation ---
                query = collection.find_one({'messageId': message_id})

                quest_id, title, description, levels, gm, party = \
                    query['questId'], query['title'], query['desc'], query['levels'], query['gm'], query['party']

                # Get the size of the party list
                party_size = len(party)

                # Format the party list
                formatted_party : str = None
                if party:
                    mapped_party = list(map(str, party))
                    formatted_party = '- <@!'+'>\n- <@!'.join(mapped_party)+'>'

                # Build the embed object and update the post with the new embed
                post_embed = discord.Embed(title=title, type='rich',
                    description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n**Description:**\n{description}')
                post_embed.add_field(name=f'__Party ({party_size}/{max_party_size})__', value=formatted_party)
                post_embed.set_footer(text='Quest ID: '+quest_id)

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

    @commands.group(pass_context = True)
    @has_gm_role()
    async def quest(self, ctx):
        if ctx.invoked_subcommand is None:
            return # TODO: Error message feedback

    @quest.command(pass_context = True)
    async def post(self, ctx, title: str, levels: str, description: str, max_party_size: int):
        """Posts a new quest."""

        # TODO: Research exception catching on function argument TypeError

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
            await ctx.send('Quest channel not set! Configure with `{}questChannel <channel mention>`'.format(self.bot.command_prefix))
            return
        else:
            quest_channel = query['questChannel']

        # Query the collection to see if a role is set
        query = gdb['announceRole'].find_one({'guildId': guild_id})

        # Inform user if announcement role is not set. Otherwise, get the channel string
        # TODO: Make announcement role optional
        announce_role : int = None
        if not query:
            await ctx.send('Announcement role not set! Configure with `{}announceRole <role mention>`'.format(self.bot.command_prefix))
            return
        else:
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

        post_embed = discord.Embed(title=title, type='rich', description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n**Description:**\n{description}')
        post_embed.add_field(name=f'__Party (0/{max_party_size})__', value=None)
        if max_wait_list_size > 0:
            post_embed.add_field(name=f'__Wait List (0/{max_wait_list_size})__', value=None)
        post_embed.set_footer(text='Quest ID: '+quest_id)

        await channel.send(f'{announceRole} **NEW QUEST!**')
        msg = await channel.send(embed=post_embed)
        emoji = '<:acceptquest:601559094293430282>'
        await msg.add_reaction(emoji)
        message_id = msg.id
        await ctx.send('Quest posted!')

        try:
            collection.insert_one({'guildId': guild_id, 'questId': quest_id, 'messageId': message_id,
                'title': title, 'desc': description, 'maxparty_size': max_party_size, 'levels': levels,
                'gm': gm, 'party': party, 'waitList': wait_list, 'xp': xp, 'maxwait_list_size': max_wait_list_size})
        except Exception as e:
            await ctx.send('{}: {}'.format(type(e).__name__, e))

        await delete_command(ctx.message)

    @quest.command(pass_context = True)
    async def ready(self, ctx, id):
        """Locks the quest roster and alerts party members that the quest is ready."""
        guild_id = ctx.message.guild.id
        collection = gdb['quests']

        
        await delete_command(ctx.message)

    @quest.command(aliases = ['ur'], pass_context = True)
    async def unready(self, ctx, id):
        # TODO: Implement player removal, waitlist backfill and notification, and quest unlocking
        await delete_command(ctx.message)

    @quest.command(pass_context = True)
    async def complete(self, ctx, id):
        # TODO: Implement quest removal/archival, optional summary, player and GM reward distribution
        await delete_command(ctx.message)

def setup(bot):
    bot.add_cog(QuestBoard(bot))
