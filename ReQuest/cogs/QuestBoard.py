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

    @listener()
    async def on_raw_reaction_add(self, payload):
        # When a reaction is added, update the post content with their user mention
        guild = self.bot.get_guild(payload.guild_id)
        channel = guild.get_channel(payload.channel_id)
        message = await channel.fetch_message(payload.message_id)
        collection = db[str(payload.guild_id)]
        channelName : str = None

        original = message.content
        if payload.member.bot:
            return
        else:
            await message.edit(content = original+f'\n- <@!{payload.user_id}>')

    @listener()
    async def on_raw_reaction_remove(self, payload):
        # When a reaction is removed, update the post content without their user mention
        guild = self.bot.get_guild(payload.guild_id)
        channel = guild.get_channel(payload.channel_id)
        message = await channel.fetch_message(payload.message_id)

        original = message.content
        id = str(payload.user_id)
        edited = re.sub('- <@!'+id+'>', '', original)
        
        # TODO: index a regex of user mention, then remove that substring somehow
        await message.edit(content = edited)

    # TODO: Incorporate GM options, max party size, custom post formatter
    @command(aliases = ['qpost','qp'])
    async def questPost(self, ctx, title, levels, description):
        # Get server ID, set up db collection to connect
        server = ctx.message.guild.id
        collection = db[str(server)]
        channelName : str = None

        # Query the collection to see if a channel is set
        query = collection.find_one({'questChannel': {'$exists': 'true'}})

        # Inform user if quest channel is not set. Otherwise, get the channel string
        if not query:
            await ctx.send('Quest channel not set! Configure with `{}questChannel <channel link>`'.format(self.bot.command_prefix))
        else:
            for key, value in query.items():
                if key == 'questChannel':
                    channelName = value
    
            # Slice the string so we just have the ID, and use that to get the channel object.
            channel = self.bot.get_channel(int(channelName[2:len(channelName)-1]))

            # Set post format and log the author, then post the new quest with an emoji reaction.
            gm = f'<@!{ctx.author.id}>'
            msg = await channel.send(f'**NEW QUEST:** {title}\n**Level Range:** {levels}\n**GM:** {gm}\n**Description:** {description}\n**Players:**')
            emoji = '<:acceptquest:601559094293430282>'
            await msg.add_reaction(emoji)
            
            # Provide feedback to the channel from which the command was sent.
            await ctx.send('Quest posted!')

def setup(bot):
    bot.add_cog(QuestBoard(bot))