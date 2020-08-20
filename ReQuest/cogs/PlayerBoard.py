import itertools
import bson
import re

import pymongo
from pymongo import MongoClient

import discord
from discord.utils import get
from discord.ext import commands
from discord.ext.commands import Cog, command

from ..utilities.supportFunctions import delete_command

listener = Cog.listener

class PlayerBoard(Cog):
    def __init__(self, bot):
        global config
        global gdb
        self.bot = bot
        config = bot.config
        connection = MongoClient(config['dbServer'],config['port'])
        gdb = connection[config['guildCollection']]

    # Configures the channel in which player messages are to be posted. Same logic as questChannel()
    @commands.has_permissions(administrator=True, manage_guild=True)
    @command(aliases = ['pbchannel','pbch'])
    async def playerBoardChannel(self, ctx, channel : str = None):
        """Get or sets the channel used for the Player Board."""
        guildId = ctx.message.guild.id
        collection = gdb['playerBoardChannel']
        channelName : str = None

        if (channel):
            if collection.find_one({'guildId': guildId}):
                try:
                    collection.update_one({'guildId': guildId}, {'$set': {'playerBoardChannel': channel}})
                except Exception as e:
                    await ctx.send('{}: {}'.format(type(e).__name__, e))
                    return
            else:
                try:
                    collection.insert_one({'guildId': guildId, 'playerBoardChannel': channel})
                except Exception as e:
                    await ctx.send('{}: {}'.format(type(e).__name__, e))
                    return

            await ctx.send('Successfully set player board channel to {}!'.format(channel))

        if (channel == None):
            query = collection.find_one({'guildId': guildId})
            if not query:
                await ctx.send('Player board channel not set! Configure with `{}playerBoardChannel <channel mention>`'.format(self.bot.command_prefix))
            else:
                channelName = None
                for key, value in query.items():
                    if key == 'playerBoardChannel':
                        channelName = value

                await ctx.send('Player board channel currently set to {}'.format(channelName))

        await delete_command(ctx.message)

def setup(bot):
    bot.add_cog(PlayerBoard(bot))
