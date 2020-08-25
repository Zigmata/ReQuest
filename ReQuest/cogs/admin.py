import itertools
import bson
import re

import pymongo
from pymongo import MongoClient

import discord
from discord.ext import commands
from discord.ext.commands import Cog, command

from ..utilities.supportFunctions import delete_command, strip_id

class Admin(Cog):
    """Administrative commands such as server configuration and bot options."""
    def __init__(self, bot):
        self.bot = bot
        global gdb
        global mdb
        gdb = bot.gdb
        mdb = bot.mdb

#-------------Support Functions------------



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

    @commands.has_guild_permissions(manage_guild = True)
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
        guild_id = ctx.message.guild.id
        collection = gdb['announceRole']

        # If a role is provided, write it to the db
        if role:
            role_id = strip_id(role) # Get numeric role ID
            if collection.find_one({'guildId': guild_id}):
                try:
                    collection.update_one({'guildId': guild_id}, {'$set': {'announceRole': role_id}})
                except Exception as e:
                    await ctx.send('{}: {}'.format(type(e).__name__, e))
                    return # TODO: Feedback and logging
            else:
                try:
                    collection.insert_one({'guildId': guild_id, 'announceRole': role_id})
                except Exception as e:
                    await ctx.send('{}: {}'.format(type(e).__name__, e))
                    return # TODO: Feedback and logging

            await ctx.send('Successfully set announcement role to {}!'.format(role))
        # Otherwise, query the db for the current setting
        else:
            query = collection.find_one({'guildId': guild_id})
            if not query:
                await ctx.send('Announcement role not set! '
                    'Configure with `{}config role announce <role mention>`'.format(self.bot.command_prefix))
            else:
                await ctx.send('Announcement role currently set to <@&{}>'.format(str(query['announceRole'])))
        await delete_command(ctx.message)

    @role.group(pass_context = True, invoke_without_command = True)
    async def gm(self, ctx):
        """
        Gets or sets the GM role(s), used for GM commands.
        """
        guild_id = ctx.message.guild.id
        collection = gdb['gmRoles']
            
        query = collection.find_one({'guildId': guild_id})
        if not query or not query['gmRoles']:
            await ctx.send('GM role(s) not set! Configure with '
                '`{}gmRole <role mention>`. Roles can be chained (separate with a space).'.format(self.bot.command_prefix))
        else:
            current_roles = query['gmRoles']
            mapped_roles = list(map(str, current_roles))

            await ctx.send('GM Role(s): {}'.format('<@&'+'>, <@&'.join(mapped_roles)+'>'))

        await delete_command(ctx.message)

    @gm.command(aliases = ['a'], pass_context = True)
    async def add(self, ctx, *, roles):
        """
        Multiple roles can be chained by separating them with a space.
        """
        
        guild_id = ctx.message.guild.id
        collection = gdb['gmRoles']

        if roles:
            new_roles = roles.split()
            formatted_roles = [re.sub(r'[<>@&]', '', role) for role in new_roles]
            parsed_roles = list(map(int, formatted_roles))
            query = collection.find_one({'guildId': guild_id})
            if query:
                gm_roles = query['gmRoles']
                for role in parsed_roles:
                    if role in gm_roles:
                        continue # TODO: Raise error that role is already configured
                    else:
                        try:
                            collection.update_one({'guildId': guild_id}, {'$push': {'gmRoles': role}})
                        except Exception as e:
                            await ctx.send('{}: {}'.format(type(e).__name__, e))
                            return # TODO: Logging

                update_query = collection.find_one({'guildId': guild_id})['gmRoles']
                mapped_query = list(map(str, update_query))
                await ctx.send('GM role(s) set to {}'.format('<@&'+'>, <@&'.join(mapped_query)+'>'))
            else:
                try:
                    collection.insert_one({'guildId': guild_id, 'gmRoles': parsed_roles})
                    await ctx.send('Role(s) {} added as GMs'.format('<@&'+'>, <@&'.join(formatted_roles)+'>'))
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

        guild_id = ctx.message.guild.id
        collection = gdb['gmRoles']

        if roles:
            if roles == 'all':
                query = collection.find_one({'guildId': guild_id})
                if query:
                    try:
                        collection.update({'guildId': guild_id}, {'$set': {'gmRoles': []}})
                    except Exception as e:
                        await ctx.send('{}: {}'.format(type(e).__name__, e))
                        return # TODO: Logging

                await ctx.send('GM roles cleared!')
            else:
                split_roles = roles.split()
                parsed_roles = self.parse_list(split_roles)
                query = collection.find_one({'guildId': guild_id})
                if query:
                    gm_roles = query['gmRoles']
                    for role in parsed_roles:
                        if role in gm_roles:
                            try:
                                collection.update_one({'guildId': guild_id}, {'$pull': {'gmRoles': role}})
                            except Exception as e:
                                await ctx.send('{}: {}'.format(type(e).__name__, e))
                                return # TODO: Logging
                        else:
                            continue

                    update_query = collection.find_one({'guildId': guild_id})['gmRoles']
                    if update_query:
                        mapped_query = list(map(str, update_query))
                        await ctx.send('GM role(s) set to {}'.format('<@&'+'>, <@&'.join(mapped_query)+'>'))
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
    @channel.command(name = 'playerboard', aliases = ['pboard', 'pb'], pass_context = True)
    async def player_board(self, ctx, channel : str = None):
        """Get or sets the channel used for the Player Board."""
        guild_id = ctx.message.guild.id
        collection = gdb['playerBoardChannel']
        channelName : str = None

        if channel:
            try:
                channel_id = strip_id(channel)
                if collection.count_documents({'guildId': guild_id}, limit = 1) != 0:
                    collection.update_one({'guildId': guild_id}, {'$set': {'playerBoardChannel': channel_id}})
                else:
                    collection.insert_one({'guildId': guild_id, 'playerBoardChannel': channel_id})
                await ctx.send('Successfully set player board channel to {}!'.format(channel))
            except Exception as e:
                await ctx.send('{}: {}'.format(type(e).__name__, e))
                return
        else:
            query = collection.find_one({'guildId': guild_id})
            if not query:
                await ctx.send('Player board channel not set! Configure with `{}config channel playerboard <channel mention>`'.format(self.bot.command_prefix))
            else:
                await ctx.send('Player board channel currently set to <#{}>'.format(query['playerBoardChannel']))

        await delete_command(ctx.message)

    @channel.command(name = 'questboard', aliases = ['qboard', 'qb'], pass_context = True)
    async def quest_board(self, ctx, channel : str = None):
        """Configures the channel in which quests are to be posted"""
        guild_id = ctx.message.guild.id
        collection = gdb['questChannel']

        # When provided with a channel name, deletes the old entry and adds the new one.
        if channel:
            try:
                channel_id = strip_id(channel) # Strip channel ID and cast to int
                if collection.count_documents({'guildId': guild_id}, limit = 1) != 0:
                    # If a match is found, attempt to update it before proceeding.
                    collection.update_one({'guildId': guild_id}, {'$set': {'questChannel': channel_id}})
                else:
                    # Otherwise, insert the new record.
                    collection.insert_one({'guildId': guild_id, 'questChannel': channel_id})
                await ctx.send('Successfully set quest channel to {}!'.format(channel))
            except Exception as e:
                await ctx.send('{}: {}'.format(type(e).__name__, e))
                return
        else: # If no channel is provided, inform the user of the current setting
            query = collection.find_one({'guildId': guild_id})
            if not query:
                await ctx.send('Quest board channel not set! Configure with `{}config channel questboard <channel link>`'.format(self.bot.command_prefix))
            else:
                await ctx.send('Quest board channel currently set to <#{}>'.format(query['questChannel']))

        await delete_command(ctx.message)

    @channel.command(name = 'questarchive', aliases = ['qarch', 'qa'], pass_context = True)
    async def quest_archive(self, ctx, channel : str = None):
        """Configures the channel in which quests are to be archived."""
        guild_id = ctx.message.guild.id
        collection = gdb['archiveChannel']

        if channel:
            try:
                channel_id = strip_id(channel)
                if collection.count_documents({'guildId': guild_id}, limit = 1) != 0:
                    collection.update_one({'guildId': guild_id}, {'$set': {'archiveChannel': channel_id}})
                else:
                    collection.insert_one({'guildId': guild_id, 'archiveChannel': channel_id})
                await ctx.send('Successfully set quest channel to {}!'.format(channel))
            except Exception as e:
                await ctx.send('{}: {}'.format(type(e).__name__, e))
                return
        else:
            query = collection.find_one({'guildId': guild_id})
            if not query:
                await ctx.send('Quest archive channel not set! Configure with `{}config channel questarchive <channel link>`'.format(self.bot.command_prefix))
            else:
                await ctx.send('Quest archive channel currently set to <#{}>'.format(query['archiveChannel']))

        await delete_command(ctx.message)

    # --- Quest ---

    @config.group(pass_context = True)
    async def quest(self, ctx):
        if ctx.invoked_subcommand is None:
            return # TODO: Error message feedback

    @quest.command(name = 'waitlist', aliases = ['wait'], pass_context = True)
    async def wait_list(self, ctx, waitlistValue = None):
        """This command gets or sets the waitlist cap. Accepts a range of 0 to 5."""
        guild_id = ctx.message.guild.id
        collection = gdb['questWaitlist']

        # Print the current setting if no argument is given. Otherwise, store the new value.
        if not waitlistValue:
            query = collection.find_one({'guildId': guild_id})
            if not query:
                await ctx.send('Quest wait list is currently disabled.')
            elif query and query['waitlistValue'] == 0:
                await ctx.send('Quest wait list is currently disabled.')
            else:
                await ctx.send('Quest wait list currently set to {} players.'.format(str(query['waitlistValue'])))
        else:
            try:
                value = int(waitlistValue) # Convert to int for input validation and db storage
                if value < 0 or value > 5:
                    raise ValueError('Value must be an integer between 0 and 5!')
                else:
                    # If a document is found, update it. Otherwise create a new one.
                    if collection.count_documents({'guildId': guild_id}, limit = 1) != 0:
                        collection.update_one({'guildId': guild_id}, {'$set': {'waitlistValue': value}})
                    else:
                        collection.insert_one({'guildId': guild_id, 'waitlistValue': value})

                    if value == 0:
                        await ctx.send('Quest wait list disabled.')
                    else:
                        await ctx.send(f'Quest wait list set to {value} players.')
            except Exception as e:
                await ctx.send('{}: {}'.format(type(e).__name__, e))
                return

        await delete_command(ctx.message)

def setup(bot):
    bot.add_cog(Admin(bot))
