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
        db = connection[config['guildsCollection']] # remove after db redesign
        gdb = connection[config['guildCollection']]

#-------------Private Commands-------------

    # Reload a cog by name
    @commands.is_owner()
    @command(hidden=True)
    async def reload(self, ctx, module : str):
        try:
            self.bot.reload_extension('cogs.'+module)
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
            self.bot.load_extension('cogs.'+module)
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

    #@commands.has_permissions(administrator=True, manage_guild=True)
    #@command(aliases = ['qchannel','qch'])
    #async def questChannel(self, ctx, channel : str = None):
    #    """Configures the channel in which quests are to be posted"""
    #    # Get server ID to locate proper collection
    #    server = ctx.message.guild.id
    #    collection = db[str(server)]
    #    channelName : str = None

    #    # When provided with a channel name, deletes the old entry and adds the new one.
    #    if (channel):
    #        if collection.find_one({'questChannel': {'$exists': 'true'}}):
    #            # If a match is found, attempt to delete it before proceeding.
    #            try:
    #                collection.delete_one({'questChannel': {'$exists': 'true'}})
    #            except Exception as e:
    #                await ctx.send('{}: {}'.format(type(e).__name__, e))
    #                return

    #        # Regardless of whether or not a match is found, insert the new record.
    #        try:
    #            collection.insert_one({'questChannel': channel})
    #        except Exception as e:
    #            await ctx.send('{}: {}'.format(type(e).__name__, e))
    #        else:
    #            await ctx.send('Successfully set quest channel to {0}!'.format(channel))

    #    # If no channel is provided, inform the user of the current setting
    #    if (channel == None):
    #        query = collection.find_one({'questChannel': {'$exists': 'true'}})
    #        if not query:
    #            await ctx.send('Quest channel not set! Configure with `{}questChannel <channel link>`'.format(self.bot.command_prefix))
    #        else:
    #            for key, value in query.items():
    #                if key == 'questChannel':
    #                    channelName = value
    #                    await ctx.send('Quest channel currently set to {}'.format(channelName))

    @commands.has_permissions(administrator=True, manage_guild=True)
    @command(aliases = ['qchannel','qch'])
    async def questChannel(self, ctx, channel : str = None):
        """Configures the channel in which quests are to be posted"""
        # Get server ID to locate proper collection
        guildId = ctx.message.guild.id
        collection = gdb['questChannel']
        channelName : str = None

        # When provided with a channel name, deletes the old entry and adds the new one.
        if (channel):
            if collection.find_one({'guildId': guildId}):
                # If a match is found, attempt to delete it before proceeding.
                try:
                    collection.delete_one({'guildId': guildId})
                except Exception as e:
                    await ctx.send('{}: {}'.format(type(e).__name__, e))
                    return

            # Regardless of whether or not a match is found, insert the new record.
            try:
                collection.insert_one({'guildId': guildId, 'questChannel': channel})
            except Exception as e:
                await ctx.send('{}: {}'.format(type(e).__name__, e))
            else:
                await ctx.send('Successfully set quest channel to {0}!'.format(channel))

        # If no channel is provided, inform the user of the current setting
        if (channel == None):
            query = collection.find_one({'guildId': guildId})
            if not query:
                await ctx.send('Quest channel not set! Configure with `{}questChannel <channel link>`'.format(self.bot.command_prefix))
            else:
                for key, value in query.items():
                    if key == 'questChannel':
                        channelName = value
                        await ctx.send('Quest channel currently set to {}'.format(channelName))

    # Configures the channel in which player messages are to be posted. Same logic as questChannel()
    @commands.has_permissions(administrator=True, manage_guild=True)
    @command(aliases = ['pbchannel','pbch'], hidden=True)
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
                await ctx.send('Successfully set player board channel to {}!'.format(channel))

        if (channel == None):
            query = collection.find_one({'playerBoardChannel': {'$exists': 'true'}})
            if not query:
                await ctx.send('Player board channel not set! Configure with `{}playerBoardChannel <channel mention>`'.format(self.bot.command_prefix))
            else:
                channelName = None
                for key, value in query.items():
                    if key == 'playerBoardChannel':
                        channelName = value

                await ctx.send('Player board channel currently set to {}'.format(channelName))

    #@commands.has_permissions(administrator=True, manage_guild=True)
    #@command(aliases = ['arole','ar'])
    #async def announceRole(self, ctx, role: str = None):
    #    """Gets or sets the role used for post announcements."""
    #    server = ctx.message.guild.id
    #    collection = db[str(server)]

    #    if (role):
    #        if collection.find_one({'announceRole': {'$exists': 'true'}}):
    #            try:
    #                collection.delete_one({'announceRole': {'exists': 'true'}})
    #            except Exception as e:
    #                await ctx.send('{}: {}'.format(type(e).__name__, e))
    #                return

    #        try:
    #            collection.insert_one({'announceRole': role})
    #        except Exception as e:
    #            await ctx.send('{}: {}'.format(type(e).__name__, e))
    #        else:
    #            await ctx.send('Successfully set announcement role to {}!'.format(role))

    #    if (role == None):
    #        query = collection.find_one({'announceRole': {'$exists': 'true'}})
    #        if not query:
    #            await ctx.send('Announcement role not set! Configure with `{}announceRole <role mention>`'.format(self.bot.command_prefix))
    #        else:
    #            announceRole = None
    #            for key, value in query.items():
    #                if key == 'announceRole':
    #                    announceRole = value

    #            await ctx.send('Announcement role currently set to {}'.format(announceRole))

    @commands.has_permissions(administrator=True, manage_guild=True)
    @command(aliases = ['arole','ar'])
    async def announceRole(self, ctx, role: str = None):
        """Gets or sets the role used for post announcements."""
        guildId = ctx.message.guild.id
        collection = gdb['announceRole']

        if (role):
            if collection.find_one({'guildId': guildId}):
                try:
                    collection.delete_one({'guildId': guildId})
                except Exception as e:
                    await ctx.send('{}: {}'.format(type(e).__name__, e))
                    return

            try:
                collection.insert_one({'guildId': guildId, 'announceRole': role})
            except Exception as e:
                await ctx.send('{}: {}'.format(type(e).__name__, e))
            else:
                await ctx.send('Successfully set announcement role to {}!'.format(role))

        if (role == None):
            query = collection.find_one({'guildId': guildId})
            if not query:
                await ctx.send('Announcement role not set! Configure with `{}announceRole <role mention>`'.format(self.bot.command_prefix))
            else:
                announceRole = None
                for key, value in query.items():
                    if key == 'announceRole':
                        announceRole = value

                await ctx.send('Announcement role currently set to {}'.format(announceRole))

    @commands.has_permissions(administrator=True, manage_guild=True)
    @command(aliases = ['gmrole','gmr'], hidden=True)
    async def gmRole(self, ctx, *roles):
        """Gets or sets the GM role(s), used for GM commands."""
        server = ctx.message.guild.id
        collection = db[str(server)]
        gmRoles = []
        newRoles = []

        if (roles):
            await ctx.send(roles)
            if collection.find_one({'gmRoles': {'$exists': 'true'}}):
                query = collection.find_one({'gmRoles': {'$exists': 'true'}})
                for key, value in query.items():
                    if key == 'gmRoles':
                        gmRoles = value
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