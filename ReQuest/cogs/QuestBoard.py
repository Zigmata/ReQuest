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

    def update_embed(self, quest):

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

        if lock_state == True:
            title = title+' (LOCKED)'

        # Construct the embed object and edit the post with the new embed
        post_embed = discord.Embed(title=title, type='rich',
            description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n**Description:**\n{description}')
        post_embed.add_field(name=f'__Party ({current_party_size}/{max_party_size})__', value=formatted_party)
        if max_wait_list_size > 0:
            post_embed.add_field(name=f'__Wait List ({current_wait_list_size}/{max_wait_list_size})__', value=formatted_wait_list)
        post_embed.set_footer(text='Quest ID: '+quest_id)

        return post_embed

    async def reaction_operation(self, payload):
        """Handles addition/removal of user mentions when reacting to quest posts"""
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
        query = collection.find_one({'messageId': message_id}) # Get the quest that matches the message ID
        if not query:
            emoji = payload.emoji
            await message.remove_reaction(emoji, user)
            return # TODO: Missing quest error handling

        current_party = query['party']
        current_wait_list = query['waitList']
        current_party_size = len(current_party)
        max_wait_list_size = query['maxWaitListSize']
        max_party_size = query['maxPartySize']
        current_wait_list_size = len(current_wait_list)

        # If a reaction is added, add the reacting user to the party/waitlist if there is room
        if payload.event_type == 'REACTION_ADD':
            if query['lockState'] == True:
                emoji = payload.emoji
                await message.remove_reaction(emoji, user)
                return # TODO: Report locked status
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

                    post_embed = self.update_embed(quest)

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

                    post_embed = self.update_embed(quest)

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
                quest = collection.find_one({'messageId': message_id})

                post_embed = self.update_embed(quest)

                await message.edit(embed=post_embed)
            # If there is no waitlist, this section formats the embed without it
            else:
                # --- Database operations ---

                # Remove the user from the quest in the database
                collection.update_one({'messageId': message_id}, {'$pull': {'party': user_id}})

                # --- Post edit generation ---
                quest = collection.find_one({'messageId': message_id})

                post_embed = self.update_embed(quest)

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
            await ctx.send('Quest channel not set! Configure with `{}config channel quest <channel mention>`'.format(self.bot.command_prefix))
            return
        else:
            quest_channel = query['questChannel']

        # Query the collection to see if a role is set
        query = gdb['announceRole'].find_one({'guildId': guild_id})

        # Inform user if announcement role is not set. Otherwise, get the channel string
        # TODO: Make announcement role optional
        announce_role : int = None
        if not query:
            await ctx.send('Announcement role not set! Configure with `{}config role announce <role mention>`'.format(self.bot.command_prefix))
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
        lock_state = False

        post_embed = discord.Embed(title=title, type='rich', description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n**Description:**\n{description}')
        post_embed.add_field(name=f'__Party (0/{max_party_size})__', value=None)
        if max_wait_list_size > 0:
            post_embed.add_field(name=f'__Wait List (0/{max_wait_list_size})__', value=None)
        post_embed.set_footer(text='Quest ID: '+quest_id)

        await channel.send(f'<@&{announce_role}> **NEW QUEST!**')
        msg = await channel.send(embed=post_embed)
        emoji = '<:acceptquest:601559094293430282>'
        await msg.add_reaction(emoji)
        message_id = msg.id
        await ctx.send('Quest posted!')

        try:
            collection.insert_one({'guildId': guild_id, 'questId': quest_id, 'messageId': message_id,
                'title': title, 'desc': description, 'maxPartySize': max_party_size, 'levels': levels,
                'gm': gm, 'party': party, 'waitList': wait_list, 'xp': xp, 'maxWaitListSize': max_wait_list_size,
                'lockState': lock_state})
        except Exception as e:
            await ctx.send('{}: {}'.format(type(e).__name__, e))

        await delete_command(ctx.message)

    @quest.command(pass_context = True)
    async def ready(self, ctx, id):
        """Locks the quest roster and alerts party members that the quest is ready."""
        guild_id = ctx.message.guild.id
        collection = gdb['quests']

        query = collection.find_one({'questId': id})
        if not query:
            # TODO: Error reporting/logging on no quest match
            return

        collection.update_one({'questId': id}, {'$set': {'lockState': True}})

        quest = collection.find_one({'questId': id})

        channel_id = gdb['questChannel'].find_one({'guildId': guild_id})
        if not channel_id:
            return # TODO: Error handling/logging
        message_id = quest['messageId']
        channel = self.bot.get_channel(channel_id['questChannel'])
        message = await channel.fetch_message(message_id)
        post_embed = self.update_embed(quest)

        await message.edit(embed = post_embed)
        
        await delete_command(ctx.message)

    @quest.command(aliases = ['ur'], pass_context = True)
    async def unready(self, ctx, id, *players):
        # TODO: Implement player removal, waitlist backfill and notification, and quest unlocking
        await delete_command(ctx.message)

    @quest.command(pass_context = True)
    async def complete(self, ctx, id):
        # TODO: Implement quest removal/archival, optional summary, player and GM reward distribution
        await delete_command(ctx.message)

def setup(bot):
    bot.add_cog(QuestBoard(bot))
