import asyncio

from discord.ext import commands
from discord.ext.commands import Cog, command
from discord.utils import find

from ..utilities.supportFunctions import delete_command, strip_id, get_prefix

global gdb
global mdb
global cdb
global white_list


class Admin(Cog):
    """Administrative commands such as server configuration and bot options."""

    def __init__(self, bot):
        self.bot = bot
        global gdb
        global mdb
        global cdb
        global white_list
        gdb = bot.gdb
        mdb = bot.mdb
        cdb = bot.cdb
        white_list = bot.white_list

    # -----------------Listeners----------------

    @commands.Cog.listener()
    async def on_guild_join(self, server):
        # TODO: Message guild owner about whitelisting
        # TODO: Expand function to check guild db on valid join and initialize if new
        if not white_list:
            return

        if server.id in white_list:
            return
        else:
            return await server.leave()

    # -------------Private Commands-------------

    # Reload a cog by name
    @commands.is_owner()
    @command(hidden=True)
    async def reload(self, ctx, module: str):
        self.bot.reload_extension('ReQuest.cogs.' + module)
        await delete_command(ctx.message)

        msg = await ctx.send('Extension successfully reloaded: `{}`'.format(module))
        await asyncio.sleep(3)
        await msg.delete()

    # Echoes the first argument provided
    @commands.is_owner()
    @command(hidden=True)
    async def echo(self, ctx, *, text):
        if not text:
            await ctx.send('Give me something to echo!')
        else:
            await ctx.send(text)

        await delete_command(ctx.message)

    # Loads a cog that hasn't yet been loaded
    @commands.is_owner()
    @command(hidden=True)
    async def load(self, ctx, module: str):
        self.bot.load_extension('ReQuest.cogs.' + module)

        msg = await ctx.send('Extension successfully loaded: `{}`'.format(module))
        await asyncio.sleep(3)
        await msg.delete()

        await delete_command(ctx.message)

    # Shut down the bot
    @commands.is_owner()
    @command(hidden=True)
    async def shutdown(self, ctx):
        try:
            await ctx.send('Shutting down!')
            await delete_command(ctx.message)
            await ctx.bot.logout()
        except Exception as e:
            await ctx.send('{}: {}'.format(type(e).__name__, e))

    @commands.is_owner()
    @commands.group(name='whitelist', hidden=True, case_insensitive=True, pass_context=True)
    async def white_list(self, ctx):
        if ctx.invoked_subcommand is None:
            await delete_command(ctx.message)
            return  # TODO: Error message feedback

    @white_list.command(name='add', pass_context=True)
    async def wadd(self, ctx, guild):
        collection = cdb['botWhiteList']
        guild_id = int(guild)
        self.bot.white_list.append(guild_id)

        collection.update_one({'servers': {'$exists': True}}, {'$push': {'servers': guild_id}}, upsert=True)

        msg = await ctx.send('Guild `{}` added to whitelist!'.format(guild_id))

        await delete_command(ctx.message)

        await asyncio.sleep(3)

        await msg.delete()

    @white_list.command(name='remove', pass_context=True)
    async def wremove(self, ctx, guild):
        collection = cdb['botWhiteList']
        guild_id = int(guild)
        self.bot.white_list.remove(guild_id)

        if collection.count_documents({'servers': {'$exists': True}}, limit=1) != 0:
            collection.update_one({'servers': {'$exists': True}}, {'$pull': {'servers': guild_id}})
        else:
            return

        msg = await ctx.send('Guild `{}` removed from whitelist!'.format(guild_id))

        await delete_command(ctx.message)

        await asyncio.sleep(3)

        await msg.delete()

    # -------------Config Commands--------------

    @commands.has_guild_permissions(manage_guild=True)
    @commands.group(aliases=['conf'], case_insensitive=True, pass_context=True)
    async def config(self, ctx):
        """Commands for server configuration of bot options and features."""
        if ctx.invoked_subcommand is None:
            return  # TODO: Error message feedback

    @config.command(aliases=['pre'])
    async def prefix(self, ctx, prefix: str):
        """
        Sets a custom command prefix for this server.

        Arguments:
        [prefix]: The new command prefix to use.
        """
        guild_id = ctx.message.guild.id
        collection = cdb['prefixes']

        collection.update_one({'guildId': guild_id}, {'$set': {'prefix': prefix}}, upsert=True)
        await ctx.send(f'Command prefix changed to `{prefix}`')

        await delete_command(ctx.message)

    # --- Role ---

    @config.group(case_insensitive=True, pass_context=True)
    async def role(self, ctx):
        """Commands for configuring roles for various features."""
        if ctx.invoked_subcommand is None:
            return  # TODO: Error message feedback

    @role.command()
    async def announce(self, ctx, role: str = None):
        """
        Gets or sets the role used for quest announcements.

        Arguments:
        [role name]: The name of the role to be mentioned when new quests are posted.
        """
        guild_id = ctx.message.guild.id
        guild = self.bot.get_guild(guild_id)
        collection = gdb['announceRole']

        # If a role is provided, write it to the db
        # TODO: This looks and flows like shit. Fix it.
        if role:
            query = collection.find_one({'guildId': guild_id})
            search = find(lambda r: r.name.lower() == role.lower(), guild.roles)
            role_id = None
            if search:
                role_id = search.id

            if role.lower() == 'delete' or role.lower() == 'remove':
                if query:
                    collection.delete_one({'guildId': guild_id})

                await ctx.send('Announcement role cleared!')
            else:
                collection.update_one({'guildId': guild_id}, {'$set': {'announceRole': role_id}}, upsert=True)
                await ctx.send(f'Successfully set announcement role to `{search.name}`!')

        # Otherwise, query the db for the current setting
        else:
            query = collection.find_one({'guildId': guild_id})
            if not query:
                await ctx.send(f'Announcement role not set! Configure with `{get_prefix(self, ctx.message)}config '
                               f'role announce <role name>`')
            else:
                role_name = guild.get_role(query['announceRole']).name
                await ctx.send(f'Announcement role currently set to `{role_name}`')

        await delete_command(ctx.message)

    @role.group(case_insensitive=True, pass_context=True, invoke_without_command=True)
    async def gm(self, ctx):
        """
        Sets the GM role(s), used for GM commands.

        When this base command is executed, it displays the current setting.
        """
        guild_id = ctx.message.guild.id
        guild = self.bot.get_guild(guild_id)
        collection = gdb['gmRoles']

        query = collection.find_one({'guildId': guild_id})
        if not query or not query['gmRoles']:
            await ctx.send(f'GM role(s) not set! Configure with `{get_prefix(self, ctx.message)}config role gm add '
                           '<role name>`. Roles can be chained (separate with a space).')
        else:
            current_roles = query['gmRoles']
            role_names = []
            for role_id in current_roles:
                role_names.append(guild.get_role(role_id).name)

            await ctx.send('GM Role(s): {}'.format('`' + '`, `'.join(role_names) + '`'))

        await delete_command(ctx.message)

    @gm.command(aliases=['a'], pass_context=True)
    async def add(self, ctx, *roles):
        """
        Adds a role to the GM list.

        Arguments:
        [role name]: Adds the role to the GM list. Roles with spaces must be encapsulated in quotes.
        """

        guild_id = ctx.message.guild.id
        collection = gdb['gmRoles']

        if roles:
            guild = self.bot.get_guild(guild_id)
            query = collection.find_one({'guildId': guild_id})
            new_roles = []

            # Compare each provided role name to the list of guild roles
            for role in roles:
                search = find(lambda r: r.name.lower() == role.lower(), guild.roles)
                if search:
                    new_roles.append(search.id)

            if not new_roles:
                await ctx.send('Role not found! Check your spelling and use of quotes!')
                await delete_command(ctx.message)
                return

            if query:
                # If a document exists, check to see if the id of the provided role is already set
                gm_roles = query['gmRoles']
                for new_id in new_roles:
                    if new_id in gm_roles:
                        continue  # TODO: Raise error that role is already configured
                    else:
                        # If there is no match, add the id to the database
                        collection.update_one({'guildId': guild_id}, {'$push': {'gmRoles': new_id}})

                # Get the updated document
                update_query = collection.find_one({'guildId': guild_id})['gmRoles']

                # Get the name of the role matching each ID in the database, and output them.
                role_names = []
                for role_id in update_query:
                    role_names.append(guild.get_role(role_id).name)
                await ctx.send('GM role(s) set to {}'.format('`' + '`, `'.join(role_names) + '`'))
            else:
                # If there is no document, create one with the list of role IDs
                collection.insert_one({'guildId': guild_id, 'gmRoles': new_roles})
                role_names = []
                for role_id in new_roles:
                    role_names.append(guild.get_role(role_id).name)
                await ctx.send('Role(s) {} added as GMs'.format('`' + '`, `'.join(role_names) + '`'))
        else:
            await ctx.send('Role not provided!')

        await delete_command(ctx.message)

    @gm.command(aliases=['r'], pass_context=True)
    async def remove(self, ctx, *roles):
        """
        Removes existing GM roles.

        Arguments:
        [role name]: Removes the role from the GM list. Roles with spaces must be encapsulated in quotes.
        --<all>: Removes all roles from the GM list.
        """

        guild_id = ctx.message.guild.id
        guild = self.bot.get_guild(guild_id)
        collection = gdb['gmRoles']

        if roles:
            if roles[0] == 'all':  # If 'all' is provided, delete the whole document
                query = collection.find_one({'guildId': guild_id})
                if query:
                    collection.delete_one({'guildId': guild_id})

                await ctx.send('GM roles cleared!')
            else:
                # Get the current list of roles (if any)
                query = collection.find_one({'guildId': guild_id})

                # If there are none, inform the caller.
                if not query or not query['gmRoles']:
                    await ctx.send('No GM roles are configured!')
                # Otherwise, build a list of the role IDs to delete from the database
                else:
                    role_ids = []
                    for role in roles:
                        # find() will end at the first match in the iterable
                        search = find(lambda r: r.name.lower() == role.lower(), guild.roles)
                        if search:  # If a match is found, add the id to the list
                            role_ids.append(search.id)

                    # If the list is empty, notify the user there were no matches.
                    if not role_ids:
                        await ctx.send('Role not found! Check your spelling and use of quotes!')
                        await delete_command(ctx.message)
                        return

                    current_roles = query['gmRoles']
                    # Build the set where provided roles exist in the db
                    deleted_roles = set(role_ids).intersection(current_roles)
                    for role in deleted_roles:
                        collection.update_one({'guildId': guild_id}, {'$pull': {'gmRoles': role}})

                    # Fetch the updated document
                    update_query = collection.find_one({'guildId': guild_id})['gmRoles']
                    if update_query:
                        updated_roles = []
                        for role_id in update_query:
                            for role in guild.roles:
                                if role_id == role.id:
                                    updated_roles.append(role.name)
                        await ctx.send('GM role(s) set to {}'.format('`' + '`, `'.join(updated_roles) + '`'))
                    else:
                        await ctx.send('GM role(s) cleared!')
        else:
            await ctx.send('Role not provided!')

        await delete_command(ctx.message)

    # --- Channel ---

    @config.group(case_insensitive=True, aliases=['chan', 'ch'], pass_context=True)
    async def channel(self, ctx):
        """
        Commands for configuration of feature channels.
        """
        if ctx.invoked_subcommand is None:
            return  # TODO: Error message feedback

    # Configures the channel in which player messages are to be posted. Same logic as questChannel()
    @channel.command(name='playerboard', aliases=['player', 'pboard', 'pb'], pass_context=True)
    async def player_board_channel(self, ctx, channel: str = None):
        """
        Get or sets the channel used for the Player Board.

        Arguments:
        [no argument]: Displays the current setting.
        [channel link]: Sets the player board channel.
        """
        guild_id = ctx.message.guild.id
        collection = gdb['playerBoardChannel']

        if channel and channel == 'disable':
            if collection.count_documents({'guildId': guild_id}, limit=1) != 0:  # Delete the record if one exists
                collection.delete_one({'guildId': guild_id})
            await ctx.send('Player board channel disabled!')
        elif channel:  # Strip the channel ID and update the db
            channel_id = strip_id(channel)
            collection.update_one({'guildId': guild_id}, {'$set': {'playerBoardChannel': channel_id}}, upsert=True)
            await ctx.send('Successfully set player board channel to {}!'.format(channel))
        else:  # If the channel is not provided, output the current setting.
            query = collection.find_one({'guildId': guild_id})
            if not query:
                await ctx.send(f'Player board channel not set! Configure with `{get_prefix(self, ctx.message)}config '
                               f'channel playerboard <channel mention>`')
            else:
                await ctx.send('Player board channel currently set to <#{}>'.format(query['playerBoardChannel']))

        await delete_command(ctx.message)

    @channel.command(name='questboard', aliases=['quest', 'qboard', 'qb'], pass_context=True)
    async def quest_board(self, ctx, channel: str = None):
        """
        Configures the channel in which quests are to be posted.

        Arguments:
        [no argument]: Displays the current setting.
        [channel link]: Sets the quest board channel.
        """
        guild_id = ctx.message.guild.id
        collection = gdb['questChannel']

        # When provided with a channel name, deletes the old entry and adds the new one.
        if channel:
            channel_id = strip_id(channel)  # Strip channel ID and cast to int
            collection.update_one({'guildId': guild_id}, {'$set': {'questChannel': channel_id}}, upsert=True)
            await ctx.send(f'Successfully set quest board channel to {channel}!')
        else:  # If no channel is provided, inform the user of the current setting
            query = collection.find_one({'guildId': guild_id})
            if not query:
                await ctx.send(f'Quest board channel not set! Configure with `{get_prefix(self, ctx.message)}config '
                               f'channel questboard <channel link>`')
            else:
                await ctx.send(f'Quest board channel currently set to <#{query["questChannel"]}>')

        await delete_command(ctx.message)

    @channel.command(name='questarchive', aliases=['archive', 'qarch', 'qa'], pass_context=True)
    async def quest_archive(self, ctx, channel: str = None):
        """
        Configures the channel in which quests are to be archived.

        Arguments:
        [no argument]: Displays the current setting.
        [channel link]: Sets the quest archive channel.
        --<clear>: Clears the current setting.
        """
        guild_id = ctx.message.guild.id
        collection = gdb['archiveChannel']

        if channel:
            if channel.lower() == 'clear':
                collection.delete_one({'guildId': guild_id})
                await ctx.send('Quest archive setting cleared!')
            else:
                channel_id = strip_id(channel)
                collection.update_one({'guildId': guild_id}, {'$set': {'archiveChannel': channel_id}}, upsert=True)
                await ctx.send(f'Successfully set quest archive channel to {channel}!')
        else:
            query = collection.find_one({'guildId': guild_id})
            if not query:
                await ctx.send(f'Quest archive channel not set! Configure with `{get_prefix(self, ctx.message)}config '
                               f'channel questarchive <channel link>`')
            else:
                await ctx.send(f'Quest archive channel currently set to <#{query["archiveChannel"]}>')

        await delete_command(ctx.message)

    # --- Quest ---

    @config.group(case_insensitive=True, pass_context=True)
    async def quest(self, ctx):
        """
        Commands for configuring quest post behavior.
        """
        if ctx.invoked_subcommand is None:
            await delete_command(ctx.message)
            return  # TODO: Error message feedback

    @quest.command(name='waitlist', aliases=['wait'], pass_context=True)
    async def wait_list(self, ctx, wait_list_value=None):
        """
        This command gets or sets the server-wide wait list.

        Arguments:
        [no argument]: Displays the current setting.
        [wait_list_value]: The size of the quest wait list. Accepts a range of 0 to 5.
        """
        guild_id = ctx.message.guild.id
        collection = gdb['questWaitlist']

        # Print the current setting if no argument is given. Otherwise, store the new value.
        if not wait_list_value:
            query = collection.find_one({'guildId': guild_id})
            if not query or query['waitListValue'] == 0:
                await ctx.send('Quest wait list is currently disabled.')
            else:
                await ctx.send(f'Quest wait list currently set to {str(query["waitListValue"])} players.')
        else:
            try:
                value = int(wait_list_value)  # Convert to int for input validation and db storage
                if value < 0 or value > 5:
                    raise ValueError('Value must be an integer between 0 and 5!')
                else:
                    collection.update_one({'guildId': guild_id}, {'$set': {'waitlistValue': value}}, upsert=True)

                    if value == 0:
                        await ctx.send('Quest wait list disabled.')
                    else:
                        await ctx.send(f'Quest wait list set to {value} players.')
            except Exception as e:
                await ctx.send('{}: {}'.format(type(e).__name__, e))
                return

        await delete_command(ctx.message)

    @quest.command(name='summary', aliases=['sum'], pass_context=True)
    async def summary(self, ctx):
        """
        Toggles quest summary on/off.

        When enabled, GMs can input a brief summary of the quest during completion.
        """
        guild_id = ctx.message.guild.id

        # Check to see if the quest archive is configured.
        quest_archive = gdb['archiveChannel'].find_one({'guildId': guild_id})
        if not quest_archive:
            await ctx.send(f'Quest archive channel not configured! Use `{get_prefix(self, ctx.message)}config channel '
                           f'questarchive <channel mention>` to set up!')
            await delete_command(ctx.message)
            return

        # Query the current setting and toggle
        collection = gdb['questSummary']
        summary_enabled = collection.find_one({'guildId': guild_id})
        if not summary_enabled or not summary_enabled['questSummary']:
            collection.update_one({'guildId': guild_id}, {'$set': {'questSummary': True}}, upsert=True)
            await ctx.send('Quest summary enabled.')
        else:
            collection.update_one({'guildId': guild_id}, {'$set': {'questSummary': False}})
            await ctx.send('Quest summary disabled.')

        await delete_command(ctx.message)

    # --- Characters ---

    @config.group(name='characters', aliases=['chars'], case_insensitive=True)
    async def config_characters(self, ctx):
        """
        This group of commands configures the character attributes on the server.
        """
        if ctx.invoked_subcommand is None:
            await delete_command(ctx.message)
            return  # TODO: Error message feedback

    @config_characters.command(aliases=['xp', 'exp'])
    async def experience(self, ctx, enabled: str = None):
        """
        This command manages the use of experience points (or similar value-based character progression).

        Arguments:
        [no argument]: Displays the current configuration.
        [True|False]: Configures the server to enable/disable experience points.
        """
        # TODO: Default to true
        guild_id = ctx.message.guild.id
        query = gdb['characterSettings'].find_one({'guildId': guild_id})

        if enabled is None:
            if query and query['xp']:
                await ctx.send('Character Experience Points are enabled.')
            else:
                await ctx.send('Character Experience Points are disabled.')
        elif enabled.lower() == 'true':
            gdb['characterSettings'].update_one({'guildId': guild_id}, {'$set': {'xp': True}}, upsert=True)
            await ctx.send('Character Experience Points enabled!')
        elif enabled.lower() == 'false':
            gdb['characterSettings'].update_one({'guildId': guild_id}, {'$set': {'xp': False}}, upsert=True)
            await ctx.send('Character Experience Points disabled!')

        await delete_command(ctx.message)


def setup(bot):
    bot.add_cog(Admin(bot))
