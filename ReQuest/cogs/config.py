# import asyncio
# import json

import discord
from discord import app_commands
from discord.ext.commands import Cog

from ..utilities.supportFunctions import strip_id
from ..utilities.ui import SingleChoiceDropdown, DropdownView


class Config(Cog, app_commands.Group, name='config'):
    """Commands for server configuration of bot options and features."""

    def __init__(self, bot):
        self.bot = bot
        self.gdb = bot.gdb
        self.cdb = bot.cdb
        super().__init__()

    # --- Roles ---

    role_group = app_commands.Group(name='role', description='Commands for configuring roles for extended functions.')
    channel_group = app_commands.Group(name='channel', description='Commands for configuring channels.')

    @app_commands.checks.has_permissions(manage_guild=True)
    @role_group.command(name='announce')
    async def role_announce(self, interaction: discord.Interaction, role_name: str = None) -> None:
        """
        Gets or sets the role used for quest announcements.

        Arguments:
        [role_name]: The name of the role to be mentioned when new quests are posted.
        """
        guild_id = interaction.guild_id
        guild = self.bot.get_guild(guild_id)
        collection = self.gdb['announceRole']
        query = await collection.find_one({'guildId': guild_id})

        if role_name:
            if role_name.lower() == 'delete' or role_name.lower() == 'remove':
                if query:
                    await collection.delete_one({'guildId': guild_id})
                await interaction.response.send_message('Announcement role cleared!')
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
                    await interaction.response.send_message(f'Role `{role_name}` not found! '
                                                            f'Check your spelling and use of quotes!')
                    return

                if len(matches) == 1:
                    new_role = matches[0]['id']
                elif len(matches) > 1:
                    options = []
                    for match in matches:
                        options.append(discord.SelectOption(label=match['name'], value=str(match['id'])))
                    select = SingleChoiceDropdown(placeholder='Choose One', options=options)
                    view = DropdownView(select)
                    await interaction.response.send_message('Multiple matches found!', view=view, ephemeral=True)
                    await view.wait()
                    new_role = int(select.values[0])

                if len(matches) == 1:
                    # Add the new role's ID to the database
                    await collection.update_one({'guildId': guild_id}, {'$set': {'announceRole': new_role}},
                                                upsert=True)

                    # Report the changes made
                    role_embed = discord.Embed(title='Announcement Role Set!', type='rich',
                                               description=f'<@&{new_role}>')
                    await interaction.response.send_message(content=None, embed=role_embed, ephemeral=True)
                else:
                    # Add the new role's ID to the database
                    await collection.update_one({'guildId': guild_id}, {'$set': {'announceRole': new_role}},
                                                upsert=True)

                    # Report the changes made
                    role_embed = discord.Embed(title='Announcement Role Set!', type='rich',
                                               description=f'<@&{new_role}>')
                    await interaction.edit_original_message(content=None, embed=role_embed, view=None)
        # If no argument is provided, query the db for the current setting
        else:
            if not query:
                await interaction.response.send_message(f'Announcement role not set!', ephemeral=True)
            else:
                current_role = query['announceRole']
                post_embed = discord.Embed(title='Config - Role - Announcement', type='rich',
                                           description=f'<@&{current_role}>')
                await interaction.response.send_message(content=None, embed=post_embed, ephemeral=True)

    @app_commands.checks.has_permissions(manage_guild=True)
    @role_group.command(name='gm')
    async def role_gm(self, interaction: discord.Interaction, operation: str = None, role_name: str = None):
        """
        Sets the GM role(s) used for GM commands.
        """
        guild_id = interaction.guild_id
        guild = self.bot.get_guild(guild_id)
        collection = self.gdb['gmRoles']
        query = await collection.find_one({'guildId': guild_id})
        valid_operations = ['add', 'remove', 'clear']
        current_gm_role_ids = []
        error_message = None
        error_title = None

        # If there's an existing setting, load it
        if query and 'gmRoles' in query and query['gmRoles']:
            current_gm_role_ids = query['gmRoles']

        if not operation:  # When no operation is specified, the current setting is queried.
            if not current_gm_role_ids:  # If nothing is returned from the db
                error_title = 'Missing Configuration!'
                error_message = 'No GM roles have been set! Configure with /config role gm add `<role name>`.'
            else:  # Constructs an embed with the configured role mentions
                current_roles = map(str, current_gm_role_ids)

                post_embed = discord.Embed(title='Config - Role - GM', type='rich')
                post_embed.add_field(name='GM Role(s)', value='<@&' + '>\n<@&'.join(current_roles) + '>')
                await interaction.response.send_message(embed=post_embed, ephemeral=True)
        else:  # Performs the specified operation on a list of role names
            if operation.lower() not in valid_operations:  # Return an error if the operation isn't valid
                error_title = 'Invalid Operation'
                error_message = f'\"{operation}\" is not a valid operation type. Please use add, remove, or clear.'
            elif operation.lower() == 'clear':  # Clears all roles from this setting
                if not current_gm_role_ids:
                    error_title = 'Missing Configuration!'
                    error_message = f'No GM roles have been set. There is nothing to remove.'
                else:
                    await collection.delete_one({'guildId': guild_id})
                    await interaction.response.send_message('All GM roles have been cleared!', ephemeral=True)
            else:
                if not role_name:  # Return an error if no roles are provided to operate on
                    error_title = 'Incorrect syntax'
                    error_message = f'You have not provided a role to {operation.lower()}!'
                else:
                    if operation.lower() == 'add':
                        new_role = 0

                        # Get the list of guild names and search for the role name string in any of them
                        search = filter(lambda r: role_name.lower() in r.name.lower(), guild.roles)
                        matches = []
                        if search:
                            for match in search:
                                if match.id == guild_id:
                                    continue  # Prevent the @everyone role from being added to the list
                                matches.append({'name': match.name, 'id': int(match.id)})

                        if not matches:
                            error_title = 'No roles were added to the GM list.'
                            error_message = f'\"{role_name}\" not found. Check your spelling and use of quotes!'
                        # If there is only one match, add that role's ID to the list of changes.
                        elif len(matches) == 1:
                            # Skip if the role is already configured.
                            if current_gm_role_ids and matches[0]['id'] in current_gm_role_ids:
                                error_title = 'No roles were added to the GM list.'
                                error_message = f'<@&{matches[0]["id"]}> is already configured as a GM role.'
                            else:
                                new_role = matches[0]['id']
                        # If there is more than one match, prompt the user with a Select to choose one
                        else:
                            options = []
                            for match in matches:
                                if current_gm_role_ids and match['id'] in current_gm_role_ids:
                                    continue
                                else:
                                    options.append(discord.SelectOption(label=match['name'], value=str(match['id'])))

                            if not options:
                                error_title = 'No roles were added to the GM list.'
                                error_message = f'All roles matching \"{role_name}\" are already configured as GM' \
                                                'roles!'
                            elif len(options) == 1:
                                new_role = int(options[0].value)
                            else:
                                select = SingleChoiceDropdown(placeholder='Choose One', options=options)
                                view = DropdownView(select)
                                if not interaction.response.is_done():  # Make sure this is the first response
                                    await interaction.response.send_message(f'Multiple matches found for '
                                                                            f'\"{role_name}\"!', view=view,
                                                                            ephemeral=True)
                                else:  # If the interaction has been responded to, update the original message instead
                                    await interaction.edit_original_message(content=f'Multiple matches found for'
                                                                                    f' \"{role_name}\"!', view=view)
                                await view.wait()
                                new_role = int(select.values[0])

                        # If no new roles were added, inform the user
                        if new_role != 0:
                            # Add the role's ID to the database
                            await collection.update_one({'guildId': guild_id}, {'$push': {'gmRoles': new_role}},
                                                        upsert=True)
                            # Report the changes made
                            roles_embed = discord.Embed(title='GM Role Added!', type='rich',
                                                        description=f'<@&{new_role}>')
                            if not interaction.response.is_done():
                                await interaction.response.send_message(embed=roles_embed, ephemeral=True)
                            else:
                                await interaction.edit_original_message(content=None, embed=roles_embed, view=None)
                    if operation.lower() == 'remove':
                        removed_role = 0

                        if not current_gm_role_ids:
                            error_title = 'Missing Configuration!'
                            error_message = f'No GM roles have been set. There is nothing to remove.'
                        else:
                            # Compare each provided role name to the list of guild roles
                            search = filter(lambda r: role_name.lower() in r.name.lower(), guild.roles)
                            matches = []
                            if search:
                                for match in search:
                                    if match.id == guild_id:
                                        continue  # Prevent the @everyone role from being added to the list
                                    if match.id in current_gm_role_ids:
                                        matches.append({'name': match.name, 'id': int(match.id)})

                            if not matches:
                                error_title = 'No roles were removed from the GM list.'
                                error_message = f'\"{role_name}\" not found. Check your spelling and use of quotes!'
                            elif len(matches) == 1:
                                if matches[0]['id'] not in current_gm_role_ids:
                                    error_title = 'No roles were removed from the GM list.'
                                    error_message = f'\"{matches[0]["name"]}\" is not configured as a GM role.'
                                else:
                                    removed_role = matches[0]['id']
                            else:
                                options = []
                                for match in matches:
                                    options.append(discord.SelectOption(label=match['name'], value=str(match['id'])))
                                select = SingleChoiceDropdown(placeholder='Choose One', options=options)
                                view = DropdownView(select)
                                if not interaction.response.is_done():  # Make sure this is the first response
                                    await interaction.response.send_message(f'Multiple matches found for {role_name}!',
                                                                            view=view, ephemeral=True)
                                else:  # If the interaction has been responded to, update the original message
                                    await interaction.edit_original_message(
                                        content=f'Multiple matches found for {role_name}!', view=view)
                                await view.wait()
                                removed_role = int(select.values[0])

                        if removed_role != 0:
                            # Remove the role's ID from the database
                            await collection.update_one({'guildId': guild_id}, {'$pull': {'gmRoles': removed_role}})

                            # Report the changes made
                            roles_embed = discord.Embed(title='GM Role Removed!', type='rich',
                                                        description=f'<@&{removed_role}>')
                            if not interaction.response.is_done():
                                await interaction.response.send_message(embed=roles_embed, ephemeral=True)
                            else:
                                await interaction.edit_original_message(content=None, embed=roles_embed, view=None)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            if not interaction.response.is_done():
                await interaction.response.send_message(embed=error_embed, ephemeral=True)
            else:
                await interaction.edit_original_message(content=None, embed=error_embed, view=None)

    # --- Channel ---

    @app_commands.checks.has_permissions(manage_guild=True)
    @channel_group.command(name='playerboard')
    async def player_board_channel(self, interaction: discord.Interaction, channel: str = None):
        """
        Sets or disables (clears) the channel used for the Player Board. No argument displays the current setting.
        """
        guild_id = interaction.guild.id
        collection = self.gdb['playerBoardChannel']
        error_title = None
        error_message = None
        query = await collection.find_one({'guildId': guild_id})

        if not channel:
            if not query:
                error_title = 'Player board channel not set!'
                error_message = 'Configure with /config channel playerboard <channel mention>'
            else:
                await interaction.response.send_message(f'Player board channel currently set to '
                                                        f'<#{query["playerBoardChannel"]}>', ephemeral=True)
        elif channel.lower() == 'disable':
            if query:  # Delete the record if one exists
                await collection.delete_one({'guildId': guild_id})
                await interaction.response.send_message('Player board channel disabled!', ephemeral=True)
            else:
                error_title = 'No operation was performed.'
                error_message = 'The player board channel is already disabled.'
        else:  # Strip the channel ID and update the db
            channel_id = strip_id(channel)
            await collection.update_one({'guildId': guild_id},
                                        {'$set': {'playerBoardChannel': channel_id}}, upsert=True)
            await interaction.response.send_message(f'Successfully set player board channel to {channel}!',
                                                    ephemeral=True)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    @app_commands.checks.has_permissions(manage_guild=True)
    @channel_group.command(name='questboard')
    async def quest_board(self, interaction: discord.Interaction, channel: str = None):
        """
        Configures the channel in which quests are to be posted.
        """
        guild_id = interaction.guild.id
        guild = self.bot.get_guild(guild_id)
        collection = self.gdb['questChannel']
        error_title = None
        error_message = None

        if not channel:
            query = await collection.find_one({'guildId': guild_id})
            if not query:
                error_title = 'Missing configuration!'
                error_message = 'Quest board channel not set! Configure with /config channel questboard <channel link>'
            else:
                await interaction.response.send_message(f'Quest board channel currently set to '
                                                        f'<#{query["questChannel"]}>', ephemeral=True)
        else:
            channel_id = strip_id(channel)  # Strip channel ID and cast to int
            matches = filter(lambda guild_channel: channel_id == guild_channel.id, guild.channels)
            if not matches:
                error_title = 'Incorrect channel reference'
                error_message = 'The channel referenced does not match any channels in this server.'
            else:
                await collection.update_one({'guildId': guild_id}, {'$set': {'questChannel': channel_id}}, upsert=True)
                await interaction.response.send_message(f'Successfully set quest board channel to {channel}!',
                                                        ephemeral=True)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    @app_commands.checks.has_permissions(manage_guild=True)
    @channel_group.command(name='questarchive')
    async def quest_archive(self, interaction: discord.Interaction, channel: str = None):
        """
        Configures the channel in which quests are to be archived.
        """
        guild_id = interaction.guild.id
        guild = self.bot.get_guild(guild_id)
        collection = self.gdb['archiveChannel']
        query = await collection.find_one({'guildId': guild_id})
        error_title = None
        error_message = None

        if not channel:
            if not query:
                error_title = 'Missing configuration!'
                error_message = 'Quest archive channel not set! Configure with /config channel questarchive' \
                                ' <channel link>`'
            else:
                await interaction.response.send_message(f'Quest archive channel currently set to '
                                                        f'<#{query["archiveChannel"]}>', ephemeral=True)
        elif channel.lower() == 'disable':
            if query:  # Delete the record if one exists
                await collection.delete_one({'guildId': guild_id})
                await interaction.response.send_message('Quest archive channel disabled!', ephemeral=True)
            else:
                error_title = 'No operation was performed.'
                error_message = 'The quest archive channel is already disabled.'
        else:
            channel_id = strip_id(channel)  # Strip channel ID and cast to int
            matches = filter(lambda guild_channel: channel_id == guild_channel.id, guild.channels)
            if not matches:
                error_title = 'Incorrect channel reference'
                error_message = 'The channel referenced does not match any channels in this server.'
            else:
                await collection.update_one({'guildId': guild_id}, {'$set': {'archiveChannel': channel_id}},
                                            upsert=True)
                await interaction.response.send_message(f'Successfully set quest archive channel to {channel}!',
                                                        ephemeral=True)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    # # --- Quest ---
    #
    # @config.group(aliases=['q'], case_insensitive=True, pass_context=True)
    # async def quest(self, ctx):
    #     """
    #     Commands for configuring quest post behavior.
    #     """
    #     if ctx.invoked_subcommand is None:
    #         return  # TODO: Error message feedback
    #
    # @quest.command(name='waitlist', aliases=['wait'], pass_context=True)
    # async def wait_list(self, ctx, wait_list_value=None):
    #     """
    #     This command gets or sets the server-wide wait list.
    #
    #     Arguments:
    #     [no argument]: Displays the current setting.
    #     [wait_list_value]: The size of the quest wait list. Accepts a range of 0 to 5.
    #     """
    #     guild_id = ctx.message.guild.id
    #     collection = self.gdb['questWaitlist']
    #
    #     # Print the current setting if no argument is given. Otherwise, store the new value.
    #     if not wait_list_value:
    #         query = await collection.find_one({'guildId': guild_id})
    #         if not query or query['waitlistValue'] == 0:
    #             await ctx.send('Quest wait list is currently disabled.')
    #         else:
    #             await ctx.send(f'Quest wait list currently set to {str(query["waitlistValue"])} players.')
    #     else:
    #         try:
    #             value = int(wait_list_value)  # Convert to int for input validation and db storage
    #             if value < 0 or value > 5:
    #                 raise ValueError('Value must be an integer between 0 and 5!')
    #             else:
    #                 await collection.update_one({'guildId': guild_id}, {'$set': {'waitlistValue': value}}, upsert=True)
    #
    #                 if value == 0:
    #                     await ctx.send('Quest wait list disabled.')
    #                 else:
    #                     await ctx.send(f'Quest wait list set to {value} players.')
    #         except Exception as e:
    #             await ctx.send('{}: {}'.format(type(e).__name__, e))
    #             return
    #
    # @quest.command(name='summary', aliases=['sum'], pass_context=True)
    # async def summary(self, ctx):
    #     """
    #     Toggles quest summary on/off.
    #
    #     When enabled, GMs can input a brief summary of the quest during completion.
    #     """
    #     guild_id = ctx.message.guild.id
    #
    #     # Check to see if the quest archive is configured.
    #     quest_archive = await self.gdb['archiveChannel'].find_one({'guildId': guild_id})
    #     if not quest_archive:
    #         await ctx.send(f'Quest archive channel not configured! Use '
    #                        f'`{await get_prefix(self.bot, ctx.message)}config channel questarchive <channel mention>`'
    #                        f' to set up!')
    #         return
    #
    #     # Query the current setting and toggle
    #     collection = self.gdb['questSummary']
    #     summary_enabled = await collection.find_one({'guildId': guild_id})
    #     if not summary_enabled or not summary_enabled['questSummary']:
    #         await collection.update_one({'guildId': guild_id}, {'$set': {'questSummary': True}}, upsert=True)
    #         await ctx.send('Quest summary enabled.')
    #     else:
    #         await collection.update_one({'guildId': guild_id}, {'$set': {'questSummary': False}})
    #         await ctx.send('Quest summary disabled.')
    #
    # # --- Characters ---
    #
    # @config.group(name='characters', aliases=['chars'], case_insensitive=True)
    # async def config_characters(self, ctx):
    #     """
    #     This group of commands configures the character attributes on the server.
    #     """
    #     if ctx.invoked_subcommand is None:
    #         return  # TODO: Error message feedback
    #
    # @config_characters.command(name='experience', aliases=['xp', 'exp'])
    # async def config_experience(self, ctx, enabled: str = None):
    #     """
    #     This command manages the use of experience points (or similar value-based character progression).
    #
    #     Arguments:
    #     [no argument]: Displays the current configuration.
    #     [True|False]: Configures the server to enable/disable experience points.
    #     """
    #     guild_id = ctx.message.guild.id
    #     query = await self.gdb['characterSettings'].find_one({'guildId': guild_id})
    #
    #     # Display setting if no arg is passed
    #     if enabled is None:
    #         if query and query['xp']:
    #             await ctx.send('Character Experience Points are enabled.')
    #         else:
    #             await ctx.send('Character Experience Points are disabled.')
    #     elif enabled.lower() == 'true':
    #         await self.gdb['characterSettings'].update_one({'guildId': guild_id}, {'$set': {'xp': True}}, upsert=True)
    #         await ctx.send('Character Experience Points enabled!')
    #     elif enabled.lower() == 'false':
    #         await self.gdb['characterSettings'].update_one({'guildId': guild_id}, {'$set': {'xp': False}}, upsert=True)
    #         await ctx.send('Character Experience Points disabled!')
    #
    # @config_characters.group(name='progression', aliases=['prog'], case_insensitive=True,
    #                          invoke_without_subcommand=True)
    # async def config_progression(self, ctx):
    #     if ctx.invoked_subcommand is None:
    #         # display custom progression options
    #         return
    #
    # # --- Currency ---
    #
    # @config.group(name='currency', aliases=['c'], case_insensitive=True, invoke_without_subcommand=True)
    # async def config_currency(self, ctx):
    #     """
    #     Commands for configuring currency used in the server.
    #
    #     If invoked without a subcommand, lists the currencies configured on the server.
    #     """
    #     if ctx.invoked_subcommand is None:
    #         guild_id = ctx.message.guild.id
    #         collection = self.gdb['currency']
    #         query = await collection.find_one({'_id': guild_id})
    #
    #         post_embed = discord.Embed(title='Config - Currencies', type='rich')
    #         for currency in query['currencies']:
    #             cname = currency['name']
    #             double = False
    #             denoms = None
    #             if 'double' in currency:
    #                 double = currency['double']
    #             if 'denoms' in currency:
    #                 values = []
    #                 for denom in currency['denoms']:
    #                     dname = denom['name']
    #                     value = denom['value']
    #                     values.append(f'{dname}: {value} {cname}')
    #                 denoms = '\n'.join(values)
    #             post_embed.add_field(name=cname,
    #                                  value=f'Double: ```\n{double}``` Denominations: ```\n{denoms}```', inline=True)
    #
    #         await ctx.send(embed=post_embed)
    #
    # @config_currency.command(name='add', aliases=['a'])
    # async def currency_add(self, ctx, *, definition):
    #     """
    #     Accepts a JSON definition and adds a new currency type to the server.
    #
    #     Arguments:
    #     <definition>: JSON-formatted string definition. See additional information below.
    #
    #     Definition format:
    #     -----------------------------------
    #     {
    #     "name": string,
    #     "double": bool,
    #     "denoms": [
    #         {"name": string, "value": double}
    #         ]
    #     }
    #
    #     Keys and their functions
    #     -----------------------------------
    #     "name": Name of the currency. Case-insensitive. Acts as the base denomination with a value of 1. Example: gold
    #     "double": Specifies whether currency is displayed as whole integers (10) or as a double (10.00)
    #     "denoms": An array of objects for additional denominations. Example: {"name": "silver", "value": 0.1}
    #
    #     "name" is the only required key to add a new currency.
    #     Denomination names may be referenced in-place of the currency name for transactions.
    #
    #     Examples for common RPG currencies:
    #     Gold: {"name":"Gold", "double":true, "denoms":[{"name":"Platinum", "value":10}, {"name":"Silver","value":0.1}, {"name":"Copper","value":0.01}]}
    #     Credits: {"name":"Credits", "double":true}
    #     Downtime: {"name":"Downtime"}
    #     """
    #     # TODO: Redundant-name prevention
    #     guild_id = ctx.message.guild.id
    #     collection = self.gdb['currency']
    #     try:
    #         loaded = json.loads(definition)
    #         await collection.update_one({'_id': guild_id}, {'$push': {'currencies': loaded}}, upsert=True)
    #         await ctx.send(f'`{loaded["name"]}` added to server currencies!')
    #     except json.JSONDecodeError:
    #         await ctx.send('Invalid JSON format, check syntax and try again!')
    #
    # @config_currency.command(name='remove', aliases=['r', 'delete', 'd'])
    # async def currency_remove(self, ctx, name):
    #     """
    #     Removes a named currency from the server.
    #
    #     Arguments:
    #     <name>: The name of the currency to remove.
    #     """
    #     # TODO: Multiple-match logic
    #     guild_id = ctx.message.guild.id
    #     collection = self.gdb['currency']
    #     query = await collection.find_one({'_id': guild_id})
    #
    #     for i in range(len(query['currencies'])):
    #         currency = query['currencies'][i]
    #         cname = currency['name']
    #         if name.lower() in cname.lower():
    #             await ctx.send(f'Removing `{cname}` from server transactions. Confirm: **Y**es/**N**o?')
    #             confirm = await self.bot.wait_for('message', check=lambda message: message.author == ctx.author)
    #             await attempt_delete(confirm)
    #             if confirm.content.lower() == 'y' or confirm.content.lower() == 'yes':
    #                 await collection.update_one({'_id': guild_id},
    #                                             {'$pull': {'currencies': {'name': cname}}}, upsert=True)
    #                 await ctx.send(f'`{cname}` removed!')
    #             else:
    #                 await ctx.send('Operation aborted!')


async def setup(bot):
    await bot.add_cog(Config(bot))
