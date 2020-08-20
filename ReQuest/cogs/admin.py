import itertools
import bson
import re

import pymongo
from pymongo import MongoClient

import discord
from discord.utils import get
from discord.ext import commands
from discord.ext.commands import Cog, command, group

from ..utilities.supportFunctions import delete_command

class Admin(Cog):
    """Administrative commands such as server configuration and bot options."""
    def __init__(self, bot):
        global config
        global gdb
        self.bot = bot
        config = bot.config
        connection = MongoClient(config['dbServer'],config['port'])
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

        await delete_command(ctx.message)

    # Echoes the first argument provided
    @commands.is_owner()
    @command(hidden=True)
    async def echo(self, ctx, *, text):
        if not (text):
            await ctx.send('Give me something to echo!')
        else:
            await ctx.send(text)

        await delete_command(ctx.message)

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

        await delete_command(ctx.message)

    # Shut down the bot
    @commands.is_owner()
    @command(hidden=True)
    async def shutdown(self,ctx):
        try:
            await ctx.send('Shutting down!')
            await delete_command(ctx.message)
            await ctx.bot.logout()
        except Exception as e:
            await ctx.send('{}: {}'.format(type(e).__name__, e))

#-------------Public Commands-------------

    @commands.has_permissions(administrator=True, manage_guild=True)
    @group(aliases = ['gmrole', 'gmr'])
    async def gmRole(self, ctx):
        """
        Gets or sets the GM role(s), used for GM commands.
        """
        if ctx.invoked_subcommand is None:
            guildId = ctx.message.guild.id
            collection = gdb['gmRoles']
            
            query = collection.find_one({'guildId': guildId})
            if not query:
                await ctx.send('GM role(s) not set! Configure with `{}gmRole <role mention>`. Roles can be chained (separate with a space).'.format(self.bot.command_prefix))
            else:
                currentRoles = query['gmRoles']
                mappedRoles = list(map(str, currentRoles))

                await ctx.send('GM Role(s): {}'.format('<@&'+'>, <@&'.join(mappedRoles)+'>'))

        await delete_command(ctx.message)

    @gmRole.command(aliases = ['a'])
    async def add(self, ctx, *, roles):
        """
        Multiple roles can be chained by separating them with a space.
        """
        
        guildId = ctx.message.guild.id
        collection = gdb['gmRoles']

        if roles:
            newRoles = roles.split()
            formattedRoles = [re.sub(r'[<>@&]', '', role) for role in newRoles]
            parsedRoles = list(map(int, formattedRoles))
            query = collection.find_one({'guildId': guildId})
            if query:
                gmRoles = query['gmRoles']
                for role in parsedRoles:
                    if role in gmRoles:
                        continue # TODO: Raise error that role is already configured
                    else:
                        try:
                            collection.update_one({'guildId': guildId}, {'$push': {'gmRoles': role}})
                        except Exception as e:
                            await ctx.send('{}: {}'.format(type(e).__name__, e))
                            return # TODO: Logging

                updatedQuery = collection.find_one({'guildId': guildId})['gmRoles']
                mappedQuery = list(map(str, updatedQuery))
                await ctx.send('GM role(s) set to {}'.format('<@&'+'>, <@&'.join(mappedQuery)+'>'))
            else:
                try:
                    collection.insert_one({'guildId': guildId, 'gmRoles': parsedRoles})
                    await ctx.send('Role(s) {} added as GMs'.format('<@&'+'>, <@&'.join(formattedRoles)+'>'))
                except Exception as e:
                    await ctx.send('{}: {}'.format(type(e).__name__, e))
        else:
            await ctx.send('Role not provided!')

        await delete_command(ctx.message)

    @gmRole.command(aliases = ['r'])
    async def remove(self, ctx, *, roles):
        """
        Multiple roles can be chained by separating them with a space, or type 'all' to remove all roles.
        """

        guildId = ctx.message.guild.id
        collection = gdb['gmRoles']

        if roles:
            if roles == 'all':
                query = collection.find_one({'guildId': guildId})
                if query:
                    try:
                        collection.update({'guildId':guildId}, {'$set': {'guildId': []}})
                    except Exception as e:
                        await ctx.send('{}: {}'.format(type(e).__name__, e))
                        return # TODO: Logging

                await ctx.send('GM roles cleared!')
            else:
                delRoles = roles.split()
                formattedRoles = [re.sub(r'[<>@&]', '', role) for role in delRoles]
                parsedRoles = list(map(int, formattedRoles))
                query = collection.find_one({'guildId': guildId})
                if query:
                    gmRoles = query['gmRoles']
                    remRoles = []
                    for role in parsedRoles:
                        if role in gmRoles:
                            try:
                                collection.update_one({'guildId': guildId}, {'$pull': {'gmRoles': role}})
                            except Exception as e:
                                await ctx.send('{}: {}'.format(type(e).__name__, e))
                                return # TODO: Logging
                        else:
                            continue

                    updatedQuery = collection.find_one({'guildId': guildId})['gmRoles']
                    if updatedQuery:
                        mappedQuery = list(map(str, updatedQuery))
                        await ctx.send('GM role(s) set to {}'.format('<@&'+'>, <@&'.join(mappedQuery)+'>'))
                    else:
                        await ctx.send('GM role(s) cleared!')
                else:
                    await ctx.send('No GM roles are configured!')
        else:
            await ctx.send('Role not provided!')

        await delete_command(ctx.message)

def setup(bot):
    bot.add_cog(Admin(bot))
