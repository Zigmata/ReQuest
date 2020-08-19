import itertools
import bson
import re

import pymongo
from pymongo import MongoClient

import discord
from discord.utils import get
from discord.ext import commands
from discord.ext.commands import Cog, command

class Admin(Cog):
    """Administrative commands such as server configuration and bot options."""
    def __init__(self, bot):
        global config
        global db # remove after redesign
        global gdb
        self.bot = bot
        config = bot.config
        connection = MongoClient(config['dbServer'],config['port'])
        #db = connection[config['guildsCollection']] # remove after db redesign
        gdb = connection[config['guildCollection']]

#-------------Private Commands-------------

    # Reload a cog by name
    @commands.is_owner()
    @command(hidden=True)
    async def reload(self, ctx, module : str):
        try:
            self.bot.reload_extension('ReQuest.cogs.'+module)
        except Exception as e:
            await ctx.send('{}: {}'.format(type(e).__name__, e))
        else:
            await ctx.send('Extension successfully reloaded: `{}`'.format(module))

    # Echoes the first argument provided
    @commands.is_owner()
    @command(hidden=True)
    async def echo(self, ctx, *, text):
        if not (text):
            await ctx.send('Give me something to echo!')
        else:
            await ctx.send(text)

    # Loads a cog that hasn't yet been loaded
    @commands.is_owner()
    @command(hidden=True)
    async def load(self, ctx, module : str):
        try:
            self.bot.load_extension('ReQuest.cogs.'+module)
        except Exception as e:
            await ctx.send('{}: {}'.format(type(e).__name__, e))
        else:
            await ctx.send('Extension successfully loaded: `{}`'.format(module))

    # Shut down the bot
    @commands.is_owner()
    @command(hidden=True)
    async def shutdown(self,ctx):
        try:
            await ctx.send('Shutting down!')
            await ctx.bot.logout()
        except Exception as e:
            await ctx.send('{}: {}'.format(type(e).__name__, e))

#-------------Public Commands-------------

    @commands.has_permissions(administrator=True, manage_guild=True)
    @command(aliases = ['gmrole','gmr'])
    async def gmRole(self, ctx, *roles):
        """Gets or sets the GM role(s), used for GM commands."""
        guildId = ctx.message.guild.id
        collection = gdb['gmRoles']
        gmRoles = []
        newRoles = []

        if (roles):
            await ctx.send(roles)
            if collection.count_documents({'guildId': guildId}, limit = 1) != 0:
                query = collection.find_one({'guildId': guildId})
                gmRoles = query['gmRoles']
                for role in roles:
                    if role in gmRoles:
                        continue # Raise error that role is already configured
                    else:
                        newRoles.append(role)
                try:
                    collection.update_one('gmRoles', {'$addToSet': { 'gmRoles':', '.join(newRoles)}}, True)
                    await ctx.send('Successfully set {} as GM!'.format(', '.join(newRoles)))
                except Exception as e:
                    await ctx.send('{}: {}'.format(type(e).__name__, e))
            else:
                try:
                    collection.insert_one('gmRoles', ', '.join(roles))
                    await ctx.send('Successfully set {} as GM!'.format(', '.join(roles)))
                except Exception as e:
                    await ctx.send('{}: {}'.format(type(e).__name__, e))
        else:
            query = collection.find_one({'gmRoles': {'$exists': 'true'}})
            if not query:
                await ctx.send('GM role(s) not set! Configure with `{}gmRole <role mention>`. Roles can be chained (separate with a space).'.format(self.bot.command_prefix))
            else:
                for key, value in query.items():
                    if key == 'gmRoles':
                        gmRoles = value

                await ctx.send('GM role(s) currently set to {}'.format(', '.join(gmRoles)))

def setup(bot):
    bot.add_cog(Admin(bot))