from datetime import datetime
import itertools
import bson
import re

import pymongo
from pymongo import MongoClient

import discord
from discord.utils import get
from discord.ext.commands import Cog, command

listener = Cog.listener

# TODO: Exception reporting in channel
class QuestBoard(Cog):
    """Cog for driving quest posts and associated reaction signups/options"""
    def __init__(self, bot):
        global config
        global connection
        global db
        self.bot = bot
        config = bot.config
        connection = MongoClient(config['dbServer'],config['port'])
        db = connection[config['guildCollection']]

    async def reaction_operation(self, payload):
        """Handles addition/removal of user mentions when reacting to quest posts"""
        channel = self.bot.get_channel(payload.channel_id)
        message = await channel.fetch_message(payload.message_id)
        collection = db[str(payload.guild_id)]
        channelName : str = None

        # Find the configured Quest Channel and get the name (string in <#channelID> format)
        query = collection.find_one({'questChannel': {'$exists': 'true'}})
        if not query:
            # TODO: Error handling/logging
            return
        else:
            for key, value in query.items():
                if key == 'questChannel':
                    channelName = value

        if int(channelName[2:len(channelName)-1]) == int(channel.id): # Ensure that only posts in the configured Quest Channel are modified.
            if payload.event_type == 'REACTION_ADD': # Checks which kind of event is raised
                if payload.member.bot:
                        return # Exits the function if the reaction add is triggered by the bot
                else:
                    original = message.content # Grab the original message
                    await message.edit(content = original+f'\n- <@!{payload.user_id}>') # Append the reacting user's mention to the message
            else:
                original = message.content
                id = str(payload.user_id)
                edited = re.sub('- <@!'+id+'>', '', original)
                # TODO: index a regex of user mention, then remove that substring somehow
                await message.edit(content = edited)
        else:
            return # TODO: Needs error reporting/logging

    @listener()
    async def on_raw_reaction_add(self, payload):
        """Reaction_add event handling"""
        await QuestBoard.reaction_operation(self, payload)

    @listener()
    async def on_raw_reaction_remove(self, payload):
        """Reaction_remove event handling"""
        await QuestBoard.reaction_operation(self, payload)

    @command(aliases = ['qpost','qp'])
    async def questPost(self, ctx, title: str, levels: str, description: str, maxPartySize: int):
        """Posts a new quest."""

        # TODO: Research exception catching on function argument TypeError
        # TODO: Refactor post into BSON entry for manipulation/future functionality

        # Get server ID, set up db collection to connect
        server = ctx.message.guild.id
        collection = db[str(server)]
        channelName : str = None
        announceRole : str = None

        # Query the collection to see if a channel is set
        query = collection.find_one({'questChannel': {'$exists': 'true'}})

        # Inform user if quest channel is not set. Otherwise, get the channel string
        if not query:
            await ctx.send('Quest channel not set! Configure with `{}questChannel <channel mention>`'.format(self.bot.command_prefix))
            return
        else:
            for key, value in query.items():
                if key == 'questChannel':
                    channelName = value

        # Query the collection to see if a role is set
        query = collection.find_one({'announceRole': {'$exists': 'true'}})

        # Inform user if quest channel is not set. Otherwise, get the channel string
        if not query:
            await ctx.send('Announcement role not set! Configure with `{}announceRole <role mention>`'.format(self.bot.command_prefix))
            return
        else:
            for key, value in query.items():
                if key == 'announceRole':
                    announceRole = value
    
        # Slice the string so we just have the ID, and use that to get the channel object.
        channel = self.bot.get_channel(int(channelName[2:len(channelName)-1]))

        # Set post format and log the author, then post the new quest with an emoji reaction.
        gm = f'<@!{ctx.author.id}>'
        msg = await channel.send(f'{announceRole}\n**NEW QUEST:** {title}\n**Level Range:** {levels}\n**GM:** {gm}\n**Description:** {description}\n**Players (Max of {maxPartySize}):**')
        emoji = '<:acceptquest:601559094293430282>'
        await msg.add_reaction(emoji)
            
        # Provide feedback to the channel from which the command was sent.
        await ctx.send('Quest posted!')

def setup(bot):
    bot.add_cog(QuestBoard(bot))