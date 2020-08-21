import itertools
import bson
import re

import pymongo
from pymongo import MongoClient

import discord
from discord.ext import commands
from discord.ext.commands import Cog, command

from ..utilities.supportFunctions import delete_command

class Admin(Cog):
    """Administrative commands such as server configuration and bot options."""
    def __init__(self, bot):
        self.bot = bot
        global gdb
        global mdb
        gdb = bot.gdb
        mdb = bot.mdb

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

#-------------Config Commands--------------

    @commands.has_guild_permissions(administrator = True, manage_guild = True)
    @commands.group(aliases = ['conf'], pass_context = True)
    async def config(self, ctx):
        if ctx.invoked_subcommand is None:
            return # TODO: Error message feedback

    # --- Role ---

    @config.group(pass_context = True)
    async def role(self, ctx):
        if ctx.invoked_subcommand is None:
            return # TODO: Error message feedback
    
    @role.command()
    async def announce(self, ctx, role: str = None):
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

        await delete_command(ctx.message)

    @role.group(pass_context = True, invoke_without_command = True)
    async def gm(self, ctx):
        """
        Gets or sets the GM role(s), used for GM commands.
        """
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

    @gm.command(aliases = ['a'], pass_context = True)
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

    @gm.command(aliases = ['r'], pass_context = True)
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

    # --- Channel ---

    @config.group(aliases = ['chan', 'ch'], pass_context = True)
    async def channel(self, ctx):
        if ctx.invoked_subcommand is None:
            return # TODO: Error message feedback

    # Configures the channel in which player messages are to be posted. Same logic as questChannel()
    @channel.command(aliases = ['pboard', 'pb'], pass_context = True)
    async def playerBoard(self, ctx, channel : str = None):
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

    @channel.command(aliases = ['qboard', 'qb'], pass_context = True)
    async def questBoard(self, ctx, channel : str = None):
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

        await delete_command(ctx.message)

    @channel.command(aliases = ['qarch', 'qa'], pass_context = True)
    async def questArchive(self, ctx, channel : str = None):
        return # TODO: Implement quest archive

    # --- Quest ---

    @config.group(pass_context = True)
    async def quest(self, ctx):
        if ctx.invoked_subcommand is None:
            return # TODO: Error message feedback

    @quest.command(aliases = ['wait'], pass_context = True)
    async def waitlist(self, ctx, waitlistValue = None):
        """This command gets or sets the waitlist cap. Accepts a range of 0 to 5."""
        guildId = ctx.message.guild.id
        collection = gdb['questWaitlist']

        # Print the current setting if no argument is given. Otherwise, store the new value.
        if (waitlistValue == None):
            query = collection.find_one({'guildId': guildId})
            if query:
                value = query['waitlistValue']
                if value == 0:
                    await ctx.send('Quest wait list is currently disabled.')
                else:
                    await ctx.send('Quest wait list currently set to {} players.'.format(str(value)))
            else:
                await ctx.send('Quest wait list is currently disabled.')
        else:
            try:
                value = int(waitlistValue) # Convert to int for input validation and db storage
                if value < 0 or value > 5:
                    raise ValueError('Value must be an integer between 0 and 5!')
                else:
                    # If a document is found, update it. Otherwise create a new one.
                    if collection.count_documents({'guildId': guildId}, limit = 1) != 0:
                        collection.update_one({'guildId': guildId}, {'$set': {'waitlistValue': value}})
                    else:
                        collection.insert_one({'guildId': guildId, 'waitlistValue': value})

                    if value == 0:
                        await ctx.send('Quest wait list disabled.')
                    else:
                        await ctx.send(f'Quest wait list set to {value} players.')
            except Exception as e:
                await ctx.send('{}: {}'.format(type(e).__name__, e))

        await delete_command(ctx.message)

def setup(bot):
    bot.add_cog(Admin(bot))
