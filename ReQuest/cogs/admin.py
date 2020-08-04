from datetime import datetime
import itertools
import bson
import re

import pymongo
from pymongo import MongoClient

import discord
from discord.utils import get
from discord.ext.commands import Cog, command

class Admin(Cog):
    def __init__(self, bot):
        global config
        global connection
        global db
        self.bot = bot
        config = bot.config
        connection = MongoClient(config['dbServer'],config['port'])
        db = connection[config['guildCollection']]

    # Reload a cog by name
    @command(hidden=True)
    # TODO add utility for owner check/admin check
    async def reload(self, ctx, module : str):
        try:
            self.bot.reload_extension('cogs.'+module)
        except Exception as e:
            await ctx.send('{}: {}'.format(type(e).__name__, e))
        else:
            await ctx.send('Extension successfully reloaded: `{}`'.format(module))

    # Echoes the first argument provided
    @command(hidden=True)
    async def echo(self, ctx, text : str = None):
        if (text == None):
            await ctx.send('Give me something to echo!')
        else:
            await ctx.send(text)

    # Loads a cog that hasn't yet been loaded
    @command(hidden=True)
    async def load(self, ctx, module : str):
        try:
            self.bot.load_extension('cogs.'+module)
        except Exception as e:
            await ctx.send('{}: {}'.format(type(e).__name__, e))
        else:
            await ctx.send('Extension successfully loaded: `{}`'.format(module))

    # Shut down the bot
    @command(hidden=True)
    async def shutdown(self,ctx):
        try:
            await ctx.bot.logout()
        except Exception as e:
            await ctx.send('{}: {}'.format(type(e).__name__, e))

    # Configures the channel in which quests are to be posted
    @command(aliases = ['qchannel','qch'])
    async def questChannel(self, ctx, channel : str = None):
        # Get server ID to locate proper collection
        server = ctx.message.guild.id
        collection = db[str(server)]
        channelName : str = None

        # When provided with a channel name, deletes the old entry and adds the new one.
        if (channel):
            if collection.find_one({'questChannel': {'$exists': 'true'}}):
                # If a match is found, attempt to delete it before proceeding.
                try:
                    collection.delete_one({'questChannel': {'$exists': 'true'}})
                except Exception as e:
                    await ctx.send('{}: {}'.format(type(e).__name__, e))
                    return

            # Regardless of whether or not a match is found, insert the new record.
            try:
                collection.insert_one({'questChannel': channel})
            except Exception as e:
                await ctx.send('{}: {}'.format(type(e).__name__, e))
            else:
                await ctx.send('Successfully set quest channel to {0}!'.format(channel))

        # If no channel is provided, inform the user of the current setting
        if (channel == None):
            query = collection.find_one({'questChannel': {'$exists': 'true'}})
            if not query:
                await ctx.send('Quest channel not set! Configure with `{}questChannel <channel link>`'.format(self.bot.command_prefix))
            else:
                for key, value in query.items():
                    if key == 'questChannel':
                        channelName = value
                        await ctx.send('Quest channel currently set to {}'.format(channelName))

    # Configures the channel in which player messages are to be posted. Same logic as questChannel()
    @command(aliases = ['pbchannel','pbch'])
    async def playerBoardChannel(self, ctx, channel : str = None):
        server = ctx.message.guild.id
        collection = db[str(server)]
        channelName : str = None

        if (channel):
            if collection.find_one({'playerBoardChannel': {'$exists': 'true'}}):
                try:
                    collection.delete_one({'playerBoardChannel': {'$exists': 'true'}})
                except Exception as e:
                    await ctx.send('{}: {}'.format(type(e).__name__, e))
                    return

            try:
                collection.insert_one({'playerBoardChannel': channel})
            except Exception as e:
                await ctx.send('{}: {}'.format(type(e).__name__, e))
            else:
                await ctx.send('Successfully set player board channel to {0}!'.format(channel))

        if (channel == None):
            query = collection.find_one({'playerBoardChannel': {'$exists': 'true'}})
            if not query:
                await ctx.send('Player board channel not set! Configure with `{}playerBoardChannel <channel link>`'.format(self.bot.command_prefix))
            else:
                for key, value in query.items():
                    if key == 'playerBoardChannel':
                        channelName = value
                        await ctx.send('Player board channel currently set to {}'.format(channelName))

def setup(bot):
    bot.add_cog(Admin(bot))