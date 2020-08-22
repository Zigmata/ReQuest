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
        guildId = payload.guild_id
        channel = self.bot.get_channel(payload.channel_id)
        messageId = payload.message_id
        message = await channel.fetch_message(messageId)
        userId = payload.user_id
        user = self.bot.get_user(userId)

        # Find the configured Quest Channel and get the name (string in <#channelID> format)
        channelName : str = None
        query = gdb['questChannel'].find_one({'guildId': guildId})
        if not query:
            return # TODO: Error handling/logging
        channelName = query['questChannel']

        # Ensure that only posts in the configured Quest Channel are modified.
        if int(channelName[2:len(channelName)-1]) != int(channel.id):
            return
            
        collection = gdb['quests']
        query = collection.find_one({'messageId': messageId}) # Get the quest that matches the message ID
        if not query:
            return # TODO: Missing quest error handling

        currentParty = query['party']
        currentWaitlist = query['waitlist']
        currentPartySize = len(currentParty)
        maxWaitlistSize = query['maxWaitlistSize']
        maxPartySize = query['maxPartySize']
        currentWaitlistSize = len(currentWaitlist)

        # If a reaction is added, add the reacting user to the party/waitlist if there is room
        if payload.event_type == 'REACTION_ADD':
            if payload.member.bot: # Ignore the event if a bot added the reaction
                return
            else:
                # If the waitlist is enabled, this section formats the embed to include the waitlist
                if maxWaitlistSize > 0:
                    # --- Database operations ---

                    # If there is room in the party, add the user.
                    if len(currentParty) < maxPartySize:
                        collection.update_one({'messageId': messageId}, {'$push': {'party': userId}})
                    # If the party is full but the waitlist is not, add the user to waitlist.
                    elif len(currentParty) >= maxPartySize and len(currentWaitlist) < maxWaitlistSize:
                        collection.update_one({'messageId': messageId}, {'$push': {'waitlist': userId}})
                    # Otherwise, DM the user that the party/waitlist is full
                    else:
                        emoji = self.bot.get_emoji(':acceptquest:601559094293430282')
                        if not user.bot:
                            await message.remove_reaction(emoji, user)
                        return # TODO: Implement user DM that there is no more room

                    # --- Post edit generation ---

                    # The document is queried again to build the updated post
                    query = collection.find_one({'messageId': messageId})

                    questId, title, description, levels, gm, party, waitlist = (query['questId'], query['title'],
                            query['desc'], query['levels'], query['gm'], query['party'], query['waitlist'])

                    # Get the size of the party and wait lists
                    partySize = len(party)
                    waitlistSize = len(waitlist)

                    # Map int list to string for formatting, then format the list of users as user mentions
                    mappedParty = list(map(str, party))
                    formattedParty = '- <@!'+'>\n- <@!'.join(mappedParty)+'>'

                    formattedWaitlist : str = None
                    # Only format the waitlist if there is one.
                    if waitlist:
                        mappedWaitlist = list(map(str, waitlist))
                        formattedWaitlist = '- <@!'+'>\n- <@!'.join(mappedWaitlist)+'>'

                    # Construct the embed object and edit the post with the new embed
                    postEmbed = discord.Embed(title=title, type='rich',
                        description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n**Description:**\n{description}')
                    postEmbed.add_field(name=f'__Party ({partySize}/{maxPartySize})__', value=formattedParty)
                    postEmbed.add_field(name=f'__Wait List ({waitlistSize}/{maxWaitlistSize})__', value=formattedWaitlist)
                    postEmbed.set_footer(text='Quest ID: '+questId)

                    await message.edit(embed=postEmbed)

                # If there is no waitlist, this section formats the embed without it
                else:
                    # --- Database operations ---

                    # If there is room in the party, add the user.
                    if len(currentParty) < maxPartySize:
                        collection.update_one({'messageId': messageId}, {'$push': {'party': userId}})
                    else:
                        emoji = self.bot.get_emoji(601559094293430282)
                        if not user.bot:
                            await message.remove_reaction(emoji, user)
                        return # TODO: Implement user DM that there is no more room

                    # --- Post edit generation ---

                    # The document is queried again to build the updated post
                    query = collection.find_one({'messageId': messageId})

                    questId, title, description, levels, gm, party = (query['questId'], query['title'],
                        query['desc'], query['levels'], query['gm'], query['party'])

                    # Get the size of the party list
                    partySize = len(party)

                    # Map int list to string for formatting
                    mappedParty = list(map(str, party))

                    # Format the list of users as user mentions
                    formattedParty = '- <@!'+'>\n- <@!'.join(mappedParty)+'>'

                    # Construct the embed object and edit the post with the new embed
                    postEmbed = discord.Embed(title=title, type='rich',
                        description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n**Description:**\n{description}')
                    postEmbed.add_field(name=f'__Party ({partySize}/{maxPartySize})__', value=formattedParty)
                    postEmbed.set_footer(text='Quest ID: '+questId)

                    await message.edit(embed=postEmbed)
        # This path is chosen if a reaction is removed.
        else:
            # If the waitlist is enabled, this section formats the embed to include the waitlist
            if maxWaitlistSize > 0:
                # --- Database operations ---

                # Find which list the user is in, and remove them from the database
                if userId in currentParty:
                    collection.update_one({'messageId': messageId}, {'$pull': {'party': userId}})
                    # If there is a waitlist, move the first entry into the party automatically
                    if currentWaitlist:
                        player = currentWaitlist[0]
                        collection.update_one({'messageId': messageId}, {'$push': {'party': player}})
                        collection.update_one({'messageId': messageId}, {'$pull': {'waitlist': player}})
                elif userId in currentWaitlist:
                    collection.update_one({'messageId': messageId}, {'$pull': {'waitlist': userId}})
                else:
                    return # TODO: Error handling

                # --- Post edit generation ---

                # Refresh the query with the new document
                query = collection.find_one({'messageId': messageId})

                questId, title, description, levels, gm, party, waitlist = (query['questId'], query['title'],
                    query['desc'], query['levels'], query['gm'], query['party'], query['waitlist'])

                # Get the size of the party and wait lists
                partySize = len(party)
                waitlistSize = len(waitlist)

                # Format the party and waitlists.
                formattedParty : str = None
                if party:
                    mappedParty = list(map(str, party))
                    formattedParty = '- <@!'+'>\n- <@!'.join(mappedParty)+'>'
                formattedWaitlist : str = None
                if waitlist:
                    mappedWaitlist = list(map(str, waitlist))
                    formattedWaitlist = '- <@!'+'>\n- <@!'.join(mappedWaitlist)+'>'

                # Build the embed object and update the post with the new embed
                postEmbed = discord.Embed(title=title, type='rich',
                    description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n**Description:**\n{description}')
                postEmbed.add_field(name=f'__Party ({partySize}/{maxPartySize})__', value=formattedParty)
                postEmbed.add_field(name=f'__Wait List ({waitlistSize}/{maxWaitlistSize})__', value=formattedWaitlist)
                postEmbed.set_footer(text='Quest ID: '+questId)

                await message.edit(embed=postEmbed)
            # If there is no waitlist, this section formats the embed without it
            else:
                # --- Database operations ---

                # Remove the user from the quest in the database
                collection.update_one({'messageId': messageId}, {'$pull': {'party': userId}})

                # --- Post edit generation ---
                query = collection.find_one({'messageId': messageId})

                questId, title, description, levels, gm, party = \
                    query['questId'], query['title'], query['desc'], query['levels'], query['gm'], query['party']

                # Get the size of the party list
                partySize = len(party)

                # Format the party list
                formattedParty : str = None
                if party:
                    mappedParty = list(map(str, party))
                    formattedParty = '- <@!'+'>\n- <@!'.join(mappedParty)+'>'

                # Build the embed object and update the post with the new embed
                postEmbed = discord.Embed(title=title, type='rich',
                    description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n**Description:**\n{description}')
                postEmbed.add_field(name=f'__Party ({partySize}/{maxPartySize})__', value=formattedParty)
                postEmbed.set_footer(text='Quest ID: '+questId)

                await message.edit(embed=postEmbed)

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
    async def post(self, ctx, title: str, levels: str, description: str, maxPartySize: int):
        """Posts a new quest."""

        # TODO: Research exception catching on function argument TypeError

        guildId = ctx.message.guild.id
        questId = str(shortuuid.uuid()[:8])
        maxWaitlistSize = 0

        # Get the server's waitlist configuration
        query = gdb['questWaitlist'].find_one({'guildId': guildId})
        if query:
            maxWaitlistSize = query['waitlistValue']

        # Query the collection to see if a channel is set
        query = gdb['questChannel'].find_one({'guildId': guildId})

        # Inform user if quest channel is not set. Otherwise, get the channel string
        channelName : str = None
        if not query:
            await ctx.send('Quest channel not set! Configure with `{}questChannel <channel mention>`'.format(self.bot.command_prefix))
            return
        else:
            for key, value in query.items():
                if key == 'questChannel':
                    channelName = value

        # Query the collection to see if a role is set
        query = gdb['announceRole'].find_one({'guildId': guildId})

        # Inform user if announcement role is not set. Otherwise, get the channel string
        # TODO: Make announcement role optional
        announceRole : str = None
        if not query:
            await ctx.send('Announcement role not set! Configure with `{}announceRole <role mention>`'.format(self.bot.command_prefix))
            return
        else:
            for key, value in query.items():
                if key == 'announceRole':
                    announceRole = value
    
        collection = gdb['quests']
        # Slice the string so we just have the ID, and use that to get the channel object.
        channel = self.bot.get_channel(int(channelName[2:len(channelName)-1]))

        # Set post format and log the author, then post the new quest with an emoji reaction.
        embedQuery = gdb['questEmbed'].find_one({'guildId': guildId})
        messageId = 0
        gm = ctx.author.id
        party : [int] = []
        waitlist : [int] = []
        xp : int = None

        if embedQuery['embed'] == True:
            postEmbed = discord.Embed(title=title, type='rich', description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n**Description:**\n{description}')
            postEmbed.add_field(name=f'__Party (0/{maxPartySize})__', value=None)
            if maxWaitlistSize > 0:
                postEmbed.add_field(name=f'__Wait List (0/{maxWaitlistSize})__', value=None)
            postEmbed.set_footer(text='Quest ID: '+questId)

            await channel.send(f'{announceRole} **NEW QUEST!**')
            msg = await channel.send(embed=postEmbed)
            emoji = '<:acceptquest:601559094293430282>'
            await msg.add_reaction(emoji)
            messageId = msg.id
            await ctx.send('Quest posted!')

        try:
            collection.insert_one({'guildId': guildId, 'questId': questId, 'messageId': messageId,
                'title': title, 'desc': description, 'maxPartySize': maxPartySize, 'levels': levels,
                'gm': gm, 'party': party, 'waitlist': waitlist, 'xp': xp, 'maxWaitlistSize': maxWaitlistSize})
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
