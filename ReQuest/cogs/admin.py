import asyncio
import json

import discord
from discord.ext import commands
from discord.ext.commands import Cog, command

from ..utilities.supportFunctions import delete_command, strip_id, get_prefix


class Admin(Cog):
    """Administrative commands such as server configuration and bot options."""

    def __init__(self, bot):
        self.bot = bot
        self.gdb = bot.gdb
        self.cdb = bot.cdb

    # -----------------Listeners----------------

    @commands.Cog.listener()
    async def on_guild_join(self, server):
        # TODO: Message guild owner about whitelisting
        # TODO: Expand function to check guild db on valid join and initialize if new
        if not self.white_list or server.id in self.white_list:
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

        msg = await ctx.send(f'Extension successfully reloaded: `{module}`')
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

        msg = await ctx.send(f'Extension successfully loaded: `{module}`')
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
            await ctx.bot.close()
        except Exception as e:
            await ctx.send(f'{type(e).__name__}: {e}')

    @commands.is_owner()
    @commands.group(name='whitelist', hidden=True, case_insensitive=True, pass_context=True)
    async def white_list(self, ctx):
        if ctx.invoked_subcommand is None:
            await delete_command(ctx.message)
            return  # TODO: Error message feedback

    @white_list.command(name='add', pass_context=True)
    async def whitelist_add(self, ctx, guild):
        collection = self.cdb['botWhiteList']
        guild_id = int(guild)
        self.bot.white_list.append(guild_id)

        await collection.update_one({'servers': {'$exists': True}}, {'$push': {'servers': guild_id}}, upsert=True)

        msg = await ctx.send(f'Guild `{guild_id}` added to whitelist!')

        await delete_command(ctx.message)

        await asyncio.sleep(3)

        await msg.delete()

    @white_list.command(name='remove', pass_context=True)
    async def whitelist_remove(self, ctx, guild):
        collection = self.cdb['botWhiteList']
        guild_id = int(guild)
        self.bot.white_list.remove(guild_id)

        if await collection.count_documents({'servers': {'$exists': True}}, limit=1) != 0:
            await collection.update_one({'servers': {'$exists': True}}, {'$pull': {'servers': guild_id}})
        else:
            return

        msg = await ctx.send(f'Guild `{guild_id}` removed from whitelist!')

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
        collection = self.cdb['prefixes']

        await collection.update_one({'guildId': guild_id}, {'$set': {'prefix': prefix}}, upsert=True)
        await ctx.send(f'Command prefix changed to `{prefix}`')

        await delete_command(ctx.message)

    # --- Role ---

    @config.group(case_insensitive=True, pass_context=True)
    async def role(self, ctx):
        """Commands for configuring roles for various features."""
        if ctx.invoked_subcommand is None:
            return  # TODO: Error message feedback

    @role.command()
    async def announce(self, ctx, role_name: str = None):
        """
        Gets or sets the role used for quest announcements.

        Arguments:
        [role_name]: The name of the role to be mentioned when new quests are posted.
        """
        guild_id = ctx.message.guild.id
        guild = self.bot.get_guild(guild_id)
        collection = self.gdb['announceRole']
        query = await collection.find_one({'guildId': guild_id})

        if role_name:
            if role_name.lower() == 'delete' or role_name.lower() == 'remove':
                if query:
                    await collection.delete_one({'guildId': guild_id})
                await ctx.send('Announcement role cleared!')
            else:
                # Search the list of guild roles for all name matches
                search = filter(lambda r: role_name.lower() in r.name.lower(), guild.roles)
                matches = []
                new_role = {}
                if search:
                    for match in search:
                        if match.id == guild_id:
                            continue  # Prevent the @everyone role from being added to the list
                        matches.append({'name': match.name, 'id': int(match.id)})

                if not matches:
                    await ctx.send(f'Role `{role_name}` not found! Check your spelling and use of quotes!')
                    return

                if len(matches) == 1:
                    new_role = matches[0]
                elif len(matches) > 1:
                    content = ''
                    for i in range(len(matches)):
                        content += f'{i + 1}: {matches[i]["name"]}\n'

                    match_embed = discord.Embed(title=f'Your query returned more than one result!', type='rich',
                                                description=content)
                    match_msg = await ctx.send(embed=match_embed)
                    reply = await self.bot.wait_for('message', check=lambda message: message.author == ctx.author)
                    selection = int(reply.content)
                    if selection > len(matches):
                        await delete_command(match_msg)
                        await delete_command(reply)
                        await ctx.send(f'Selection is outside the list of options. Operation aborted.')
                        return
                    else:
                        await delete_command(match_msg)
                        await delete_command(reply)
                        new_role = matches[selection - 1]

                # Add the new role's ID to the database
                await collection.update_one({'guildId': guild_id}, {'$set': {'announceRole': new_role['id']}},
                                            upsert=True)

                # Report the changes made
                role_embed = discord.Embed(title='Announcement Role Set!', type='rich',
                                           description=f'<@&{new_role["id"]}>')
                await ctx.send(embed=role_embed)
        # If no argument is provided, query the db for the current setting
        else:
            if not query:
                await ctx.send(f'Announcement role not set! Configure with '
                               f'`{await get_prefix(self.bot, ctx.message)}config role announce <role name>`')
            else:
                current_role = query['announceRole']
                post_embed = discord.Embed(title='Config - Role - Announcement', type='rich',
                                           description=f'<@&{current_role}>')
                await ctx.send(embed=post_embed)

        await delete_command(ctx.message)

    @role.group(name='gm', case_insensitive=True, pass_context=True, invoke_without_command=True)
    async def role_gm(self, ctx):
        """
        Sets the GM role(s), used for GM commands.

        When this base command is executed, it displays the current setting.
        """
        guild_id = ctx.message.guild.id
        collection = self.gdb['gmRoles']

        query = await collection.find_one({'guildId': guild_id})
        if not query or 'gmRoles' not in query or not query['gmRoles']:
            await ctx.send(f'GM role(s) not set! Configure with '
                           f'`{await get_prefix(self.bot, ctx.message)}config role gm add <role name>`.'
                           f' Roles can be chained (separate with a space).')
        else:
            current_role_ids = query['gmRoles']
            current_roles = map(str, current_role_ids)

            post_embed = discord.Embed(title='Config - Role - GM', type='rich')
            post_embed.add_field(name='GM Role(s)', value='<@&' + '>\n<@&'.join(current_roles) + '>')
            await ctx.send(embed=post_embed)

        await delete_command(ctx.message)

    @role_gm.command(name='add', aliases=['a'], pass_context=True)
    async def gm_add(self, ctx, *role_names):
        """
        Configures roles for access to GM commands.

        Arguments:
        [role_names]: Adds the role as a GM. Can be chained. Roles with spaces must be encapsulated in quotes.
        """
        guild_id = ctx.message.guild.id
        collection = self.gdb['gmRoles']

        if role_names:
            guild = self.bot.get_guild(guild_id)
            query = await collection.find_one({'guildId': guild_id})
            gm_roles = []
            if query and 'gmRoles' in query:
                gm_roles = query['gmRoles']
            new_roles = []

            # Compare each provided role name to the list of guild roles
            for role in role_names:
                search = filter(lambda r: role.lower() in r.name.lower(), guild.roles)
                matches = []
                if search:
                    for match in search:
                        if match.id == guild_id:
                            continue  # Prevent the @everyone role from being added to the list
                        matches.append({'name': match.name, 'id': int(match.id)})

                if not matches:
                    await ctx.send(f'Role `{role}` not found! Check your spelling and use of quotes!')
                    continue

                if len(matches) == 1:
                    if gm_roles and matches[0]['id'] in gm_roles:
                        await ctx.send(f'`{matches[0]["name"]}` is already configured as a GM role. Skipping . . .')
                        continue
                    else:
                        new_roles.append(matches[0])
                elif len(matches) > 1:
                    content = ''
                    for i in range(len(matches)):
                        content += f'{i + 1}: {matches[i]["name"]}\n'

                    match_embed = discord.Embed(title=f'Your query \"{role}\" returned more than one result!',
                                                type='rich', description=content)
                    match_msg = await ctx.send(embed=match_embed)
                    reply = await self.bot.wait_for('message', check=lambda message: message.author == ctx.author)
                    selection = int(reply.content)
                    if selection > len(matches):
                        await delete_command(match_msg)
                        await delete_command(reply)
                        await ctx.send(f'Selection is outside the list of options. Selection for "{role}" aborted.')
                        continue
                    else:
                        await delete_command(match_msg)
                        await delete_command(reply)
                        # If a document exists, check to see if the id of the provided role is already set
                        if gm_roles and matches[selection - 1]['id'] in gm_roles:
                            await ctx.send(f'`{matches[selection - 1]["name"]}` is already configured as a GM role. '
                                           f'Skipping . . .')
                            continue
                        else:
                            # If there is no match, add the role to the update list
                            new_roles.append(matches[selection - 1])

            if not new_roles:
                await ctx.send('No valid roles were added to the GM list.')
                await delete_command(ctx.message)
                return
            else:
                added_names = []
                # Add each role's ID to the database, and add a role mention to the names array for feedback
                for addition in new_roles:
                    await collection.update_one({'guildId': guild_id}, {'$push': {'gmRoles': addition['id']}},
                                                upsert=True)
                    added_names.append(f'<@&{addition["id"]}>')

                # Report the changes made
                roles_embed = discord.Embed(title='GM Roles Added!', type='rich', description='\n'.join(added_names))
                await ctx.send(embed=roles_embed)

        else:
            await ctx.send('Role not provided!')

        await delete_command(ctx.message)

    @role_gm.command(name='remove', aliases=['r', 'del', 'rem'], pass_context=True)
    async def gm_remove(self, ctx, *role_names):
        """
        Removes a role's access to GM commands.

        Arguments:
        [role_names]: Removes the role as a GM. Can be chained. Roles with spaces must be encapsulated in quotes.
        --<all>: Removes all roles from the GM list.
        """
        guild_id = ctx.message.guild.id
        collection = self.gdb['gmRoles']

        if role_names:
            query = await collection.find_one({'guildId': guild_id})
            if not query or 'gmRoles' not in query or not query['gmRoles']:
                await ctx.send('No GM roles have been set!')
                await delete_command(ctx.message)
                return

            removed_roles = []
            # If 'all' is provided, delete the whole document
            if len(role_names) == 1 and role_names[0].lower() == 'all':
                await collection.delete_one({'guildId': guild_id})
                await ctx.send('GM roles cleared!')
                await delete_command(ctx.message)
                return
            else:
                guild = self.bot.get_guild(guild_id)
                gm_roles = query['gmRoles']

                # Compare each provided role name to the list of guild roles
                for role in role_names:
                    search = filter(lambda r: role.lower() in r.name.lower(), guild.roles)
                    matches = []
                    if search:
                        for match in search:
                            if match.id == guild_id:
                                continue  # Prevent the @everyone role from being added to the list
                            matches.append({'name': match.name, 'id': int(match.id)})

                    if not matches:
                        await ctx.send(f'Role `{role}` not found! Check your spelling and use of quotes!')
                        continue

                    if len(matches) == 1:
                        if matches[0]['id'] not in gm_roles:
                            await ctx.send(f'`{matches[0]["name"]}` is not configured as a GM role. Skipping . . .')
                            continue
                        else:
                            removed_roles.append(matches[0])
                    elif len(matches) > 1:
                        content = ''
                        for i in range(len(matches)):
                            content += f'{i + 1}: {matches[i]["name"]}\n'

                        match_embed = discord.Embed(title=f'Your query \"{role}\" returned more than one result!',
                                                    type='rich', description=content)
                        match_msg = await ctx.send(embed=match_embed)
                        reply = await self.bot.wait_for('message', check=lambda message: message.author == ctx.author)
                        selection = int(reply.content)
                        if selection > len(matches):
                            await delete_command(match_msg)
                            await delete_command(reply)
                            await ctx.send(f'Selection is outside the list of options. Selection for "{role}" aborted.')
                            continue
                        else:
                            await delete_command(match_msg)
                            await delete_command(reply)
                            # Check to see if the id of the provided role is stored or not
                            if matches[selection - 1]['id'] not in gm_roles:
                                await ctx.send(f'`{matches[selection - 1]["name"]}` is not configured as a GM role. '
                                               f'Skipping . . .')
                                continue
                            else:
                                # If the id is found, add the role to the update list
                                removed_roles.append(matches[selection - 1])

            if not removed_roles:
                await ctx.send('No valid roles were removed from the GM list.')
                await delete_command(ctx.message)
                return
            else:
                removed_names = []
                # Add each role's ID to the database, and add a role mention to the names array for feedback
                for removal in removed_roles:
                    await collection.update_one({'guildId': guild_id}, {'$pull': {'gmRoles': removal['id']}})
                    removed_names.append(f'<@&{removal["id"]}>')

                # Report the changes made
                roles_embed = discord.Embed(title='GM Roles Removed!', type='rich',
                                            description='\n'.join(removed_names))
                await ctx.send(embed=roles_embed)
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
    # noinspection SpellCheckingInspection
    @channel.command(name='playerboard', aliases=['player', 'pboard', 'pb'], pass_context=True)
    async def player_board_channel(self, ctx, channel: str = None):
        """
        Get or sets the channel used for the Player Board.

        Arguments:
        [no argument]: Displays the current setting.
        [channel link]: Sets the player board channel.
        """
        guild_id = ctx.message.guild.id
        collection = self.gdb['playerBoardChannel']

        if channel and channel == 'disable':
            if await collection.count_documents({'guildId': guild_id}, limit=1) != 0:  # Delete the record if one exists
                await collection.delete_one({'guildId': guild_id})
            await ctx.send('Player board channel disabled!')
        elif channel:  # Strip the channel ID and update the db
            channel_id = strip_id(channel)
            await collection.update_one({'guildId': guild_id},
                                        {'$set': {'playerBoardChannel': channel_id}}, upsert=True)
            await ctx.send('Successfully set player board channel to {}!'.format(channel))
        else:  # If the channel is not provided, output the current setting.
            query = await collection.find_one({'guildId': guild_id})
            if not query:
                await ctx.send(f'Player board channel not set! Configure with '
                               f'`{await get_prefix(self.bot, ctx.message)}config channel playerboard'
                               f' <channel mention>`')
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
        collection = self.gdb['questChannel']

        # When provided with a channel name, deletes the old entry and adds the new one.
        if channel:
            channel_id = strip_id(channel)  # Strip channel ID and cast to int
            await collection.update_one({'guildId': guild_id}, {'$set': {'questChannel': channel_id}}, upsert=True)
            await ctx.send(f'Successfully set quest board channel to {channel}!')
        else:  # If no channel is provided, inform the user of the current setting
            query = await collection.find_one({'guildId': guild_id})
            if not query:
                await ctx.send(f'Quest board channel not set! Configure with `{await get_prefix(self.bot, ctx.message)}'
                               f'config channel questboard <channel link>`')
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
        collection = self.gdb['archiveChannel']

        if channel:
            if channel.lower() == 'clear':
                await collection.delete_one({'guildId': guild_id})
                await ctx.send('Quest archive setting cleared!')
            else:
                channel_id = strip_id(channel)
                await collection.update_one({'guildId': guild_id}, {'$set': {'archiveChannel': channel_id}},
                                            upsert=True)
                await ctx.send(f'Successfully set quest archive channel to {channel}!')
        else:
            query = await collection.find_one({'guildId': guild_id})
            if not query:
                await ctx.send(f'Quest archive channel not set! Configure with '
                               f'`{await get_prefix(self.bot, ctx.message)}config channel questarchive <channel link>`')
            else:
                await ctx.send(f'Quest archive channel currently set to <#{query["archiveChannel"]}>')

        await delete_command(ctx.message)

    # --- Quest ---

    @config.group(aliases=['q'], case_insensitive=True, pass_context=True)
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
        collection = self.gdb['questWaitlist']

        # Print the current setting if no argument is given. Otherwise, store the new value.
        if not wait_list_value:
            query = await collection.find_one({'guildId': guild_id})
            if not query or query['waitlistValue'] == 0:
                await ctx.send('Quest wait list is currently disabled.')
            else:
                await ctx.send(f'Quest wait list currently set to {str(query["waitlistValue"])} players.')
        else:
            try:
                value = int(wait_list_value)  # Convert to int for input validation and db storage
                if value < 0 or value > 5:
                    raise ValueError('Value must be an integer between 0 and 5!')
                else:
                    await collection.update_one({'guildId': guild_id}, {'$set': {'waitlistValue': value}}, upsert=True)

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
        quest_archive = await self.gdb['archiveChannel'].find_one({'guildId': guild_id})
        if not quest_archive:
            await ctx.send(f'Quest archive channel not configured! Use '
                           f'`{await get_prefix(self.bot, ctx.message)}config channel questarchive <channel mention>`'
                           f' to set up!')
            await delete_command(ctx.message)
            return

        # Query the current setting and toggle
        collection = self.gdb['questSummary']
        summary_enabled = await collection.find_one({'guildId': guild_id})
        if not summary_enabled or not summary_enabled['questSummary']:
            await collection.update_one({'guildId': guild_id}, {'$set': {'questSummary': True}}, upsert=True)
            await ctx.send('Quest summary enabled.')
        else:
            await collection.update_one({'guildId': guild_id}, {'$set': {'questSummary': False}})
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

    @config_characters.command(name='experience', aliases=['xp', 'exp'])
    async def config_experience(self, ctx, enabled: str = None):
        """
        This command manages the use of experience points (or similar value-based character progression).

        Arguments:
        [no argument]: Displays the current configuration.
        [True|False]: Configures the server to enable/disable experience points.
        """
        guild_id = ctx.message.guild.id
        query = await self.gdb['characterSettings'].find_one({'guildId': guild_id})

        # Display setting if no arg is passed
        if enabled is None:
            if query and query['xp']:
                await ctx.send('Character Experience Points are enabled.')
            else:
                await ctx.send('Character Experience Points are disabled.')
        elif enabled.lower() == 'true':
            await self.gdb['characterSettings'].update_one({'guildId': guild_id}, {'$set': {'xp': True}}, upsert=True)
            await ctx.send('Character Experience Points enabled!')
        elif enabled.lower() == 'false':
            await self.gdb['characterSettings'].update_one({'guildId': guild_id}, {'$set': {'xp': False}}, upsert=True)
            await ctx.send('Character Experience Points disabled!')

        await delete_command(ctx.message)

    # --- Currency ---

    @config.group(name='currency', aliases=['c'], case_insensitive=True, invoke_without_subcommand=True)
    async def config_currency(self, ctx):
        """
        Commands for configuring currency used in the server.

        If invoked without a subcommand, lists the currencies configured on the server.
        """
        if ctx.invoked_subcommand is None:
            guild_id = ctx.message.guild.id
            collection = self.gdb['currency']
            query = await collection.find_one({'_id': guild_id})

            post_embed = discord.Embed(title='Config - Currencies', type='rich')
            for currency in query['currencies']:
                cname = currency['name']
                double = False
                denoms = None
                if 'double' in currency:
                    double = currency['double']
                if 'denoms' in currency:
                    values = []
                    for denom in currency['denoms']:
                        dname = denom['name']
                        value = denom['value']
                        values.append(f'{dname}: {value} {cname}')
                    denoms = '\n'.join(values)
                post_embed.add_field(name=cname,
                                     value=f'Double: ```\n{double}``` Denominations: ```\n{denoms}```', inline=True)

            await ctx.send(embed=post_embed)
            await delete_command(ctx.message)

    @config_currency.command(name='add', aliases=['a'])
    async def currency_add(self, ctx, *, definition):
        """
        Accepts a JSON definition and adds a new currency type to the server.

        Arguments:
        <definition>: JSON-formatted string definition. See additional information below.

        Definition format:
        -----------------------------------
        {
        "name": string,
        "double": bool,
        "denoms": [
            {"name": string, "value": double}
            ]
        }

        Keys and their functions
        -----------------------------------
        "name": Name of the currency. Case-insensitive. Acts as the base denomination with a value of 1. Example: gold
        "double": Specifies whether currency is displayed as whole integers (10) or as a double (10.00)
        "denoms": An array of objects for additional denominations. Example: {"name": "silver", "value": 0.1}

        "name" is the only required key to add a new currency.
        Denomination names may be referenced in-place of the currency name for transactions.

        Examples for common RPG currencies:
        Gold: {"name":"Gold", "double":true, "denoms":[{"name":"Platinum", "value":10}, {"name":"Silver","value":0.1}, {"name":"Copper","value":0.01}]}
        Credits: {"name":"Credits", "double":true}
        Downtime: {"name":"Downtime"}
        """
        # TODO: Redundant-name prevention
        guild_id = ctx.message.guild.id
        collection = self.gdb['currency']
        try:
            loaded = json.loads(definition)
            await collection.update_one({'_id': guild_id}, {'$push': {'currencies': loaded}}, upsert=True)
            await ctx.send(f'`{loaded["name"]}` added to server currencies!')
        except json.JSONDecodeError:
            await ctx.send('Invalid JSON format, check syntax and try again!')

        await delete_command(ctx.message)

    @config_currency.command(name='remove', aliases=['r', 'delete', 'd'])
    async def currency_remove(self, ctx, name):
        """
        Removes a named currency from the server.

        Arguments:
        <name>: The name of the currency to remove.
        """
        # TODO: Multiple-match logic
        guild_id = ctx.message.guild.id
        collection = self.gdb['currency']
        query = await collection.find_one({'_id': guild_id})

        for i in range(len(query['currencies'])):
            currency = query['currencies'][i]
            cname = currency['name']
            if name.lower() in cname.lower():
                await ctx.send(f'Removing `{cname}` from server transactions. Confirm: **Y**es/**N**o?')
                confirm = await self.bot.wait_for('message', check=lambda message: message.author == ctx.author)
                await delete_command(confirm)
                if confirm.content.lower() == 'y' or confirm.content.lower() == 'yes':
                    await collection.update_one({'_id': guild_id},
                                                {'$pull': {'currencies': {'name': cname}}}, upsert=True)
                    await ctx.send(f'`{cname}` removed!')
                else:
                    await ctx.send('Operation aborted!')

        await delete_command(ctx.message)


async def setup(bot):
    await bot.add_cog(Admin(bot))
