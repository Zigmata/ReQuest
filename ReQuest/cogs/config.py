import asyncio
import json
from typing import Sequence, List

import discord
from discord.ext import commands
from discord import app_commands
from discord.ext.commands import Cog, command

from ..utilities.supportFunctions import attempt_delete, strip_id, get_prefix
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

    @app_commands.checks.has_permissions(manage_guild=True)
    @role_group.command(name='announce')
    async def announce(self, interaction: discord.Interaction, role_name: str = None) -> None:
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

        :param interaction: The discord interaction calling this command
        :type interaction: discord.Interaction
        :param operation: Optional: The operation to perform (add, remove, or clear)
        :type operation: str
        :param role_name: Optional: Name of the role to add or delete.
        :type role_name: str
        """
        guild_id = interaction.guild_id
        guild = self.bot.get_guild(guild_id)
        collection = self.gdb['gmRoles']
        query = await collection.find_one({'guildId': guild_id})
        valid_operations = ['add', 'remove', 'clear']

        if not operation:  # When no operation is specified, the current setting is queried.
            if not query or 'gmRoles' not in query or not query['gmRoles']:  # If nothing is returned from the db
                await interaction.response.send_message(f'No GM roles have been set! Configure with /config role gm '
                                                        f'add `<role name>`.', ephemeral=True)
            else:  # Constructs an embed with the configured role mentions
                current_role_ids = query['gmRoles']
                current_roles = map(str, current_role_ids)

                post_embed = discord.Embed(title='Config - Role - GM', type='rich')
                post_embed.add_field(name='GM Role(s)', value='<@&' + '>\n<@&'.join(current_roles) + '>')
                await interaction.response.send_message(embed=post_embed, ephemeral=True)
        else:  # Performs the specified operation on a list of role names
            if operation.lower() not in valid_operations:  # Return an error if the operation isn't valid
                await interaction.response.send_message(f'The specified operation \"{operation}\" is not valid. '
                                                        f'Please use add, remove, or clear.', ephemeral=True)
            elif operation.lower() == 'clear':  # Clears all roles from this setting
                await collection.delete_one({'guildId': guild_id})
                await interaction.response.send_message('All GM roles have been cleared!', ephemeral=True)
            else:
                if not role_name:  # Return an error if no roles are provided to operate on
                    await interaction.response.send_message(f'You have not provided a role to {operation.lower()}!',
                                                            ephemeral=True)
                else:
                    if operation.lower() == 'add':
                        # Make a list and load the current setting if one exists.
                        gm_roles = []
                        if query and 'gmRoles' in query:
                            gm_roles = query['gmRoles']
                        new_role = 0
                        error_messsage = ''

                        # Get the list of guild names and search for the role name string in any of them
                        search = filter(lambda r: role_name.lower() in r.name.lower(), guild.roles)
                        matches = []
                        if search:
                            for match in search:
                                if match.id == guild_id:
                                    continue  # Prevent the @everyone role from being added to the list
                                matches.append({'name': match.name, 'id': int(match.id)})

                        if not matches:
                            error_messsage = f'{role_name} not found. Check your spelling and use of quotes!'

                        # If there is only one match, add that role's ID to the list of changes.
                        if len(matches) == 1:
                            if gm_roles and matches[0]['id'] in gm_roles:  # Skip if the role is already configured.
                                error_messsage = f'<@&{matches[0]["id"]}> is already configured as a GM role.'
                            else:
                                new_role = matches[0]['id']
                        # If there is more than one match, prompt the user with a Select to choose one
                        elif len(matches) > 1:
                            options = []
                            for match in matches:
                                if gm_roles and match['id'] in gm_roles:
                                    continue
                                else:
                                    options.append(discord.SelectOption(label=match['name'], value=str(match['id'])))

                            if len(options) == 1:
                                new_role = int(options[0].value)
                            elif len(options) == 0:
                                error_messsage = 'All roles matching the provided name are already configured as GM' \
                                                 'roles!'
                            else:
                                select = SingleChoiceDropdown(placeholder='Choose One', options=options)
                                view = DropdownView(select)
                                if not interaction.response.is_done():  # Make sure this is the first response
                                    await interaction.response.send_message(f'Multiple matches found for {role_name}!',
                                                                            view=view, ephemeral=True)
                                else:  # If the interaction has been responded to, update the original message instead
                                    await interaction.edit_original_message(content=f'Multiple matches found for'
                                                                                    f' {role_name}!', view=view)
                                await view.wait()
                                new_role = int(select.values[0])

                        # If no new roles were added, inform the user
                        if new_role == 0:
                            error_embed = discord.Embed(title='No roles were added to the GM list.', type='rich')
                            if error_messsage:
                                error_embed.description = error_messsage
                            if not interaction.response.is_done():
                                await interaction.response.send_message(embed=error_embed, ephemeral=True)
                            else:
                                await interaction.edit_original_message(content=None, embed=error_embed, view=None)
                        else:
                            # Add each role's ID to the database, and add a role mention to the names array for feedback
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
                        if not query or 'gmRoles' not in query or not query['gmRoles']:
                            await interaction.response.send_message(f'GM role(s) not set! Configure with /config role '
                                                                    f'gm add <role name>`. Roles can be chained '
                                                                    f'(separate with a space).',
                                                                    ephemeral=True)
                        else:
                            removed_role = 0
                            guild = self.bot.get_guild(guild_id)
                            gm_roles = query['gmRoles']
                            error_messsage = ''

                            # Compare each provided role name to the list of guild roles
                            search = filter(lambda r: role_name.lower() in r.name.lower(), guild.roles)
                            matches = []
                            if search:
                                for match in search:
                                    if match.id == guild_id:
                                        continue  # Prevent the @everyone role from being added to the list
                                    if match.id in gm_roles:
                                        matches.append({'name': match.name, 'id': int(match.id)})

                            if not matches:
                                error_messsage = f'{role_name} not found. Check your spelling and use of quotes!'

                            if len(matches) == 1:
                                if matches[0]['id'] not in gm_roles:
                                    error_messsage = f'{matches[0]["name"]} not configured as a GM role. Skipped.'
                                else:
                                    removed_role = matches[0]['id']
                            elif len(matches) > 1:
                                options = []
                                for match in matches:
                                    options.append(
                                        discord.SelectOption(label=match['name'], value=str(match['id'])))
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

                            if not removed_role:
                                error_embed = discord.Embed(title='No roles were removed from the GM list.',
                                                            type='rich')
                                if error_messsage:  # List any bad queries
                                    error_embed.description = error_messsage
                                if not interaction.response.is_done():
                                    await interaction.response.send_message(embed=error_embed, ephemeral=True)
                                else:
                                    await interaction.edit_original_message(content=None, embed=error_embed, view=None)
                            else:
                                # Remove each role's ID from the database
                                await collection.update_one({'guildId': guild_id}, {'$pull': {'gmRoles': removed_role}})

                                # Report the changes made
                                roles_embed = discord.Embed(title='GM Role Removed!', type='rich',
                                                            description=f'<@&{removed_role}>')
                                if not interaction.response.is_done():
                                    await interaction.response.send_message(embed=roles_embed, ephemeral=True)
                                else:
                                    await interaction.edit_original_message(content=None, embed=roles_embed, view=None)

    # # --- Channel ---
    #
    # @config.group(case_insensitive=True, aliases=['chan', 'ch'], pass_context=True)
    # async def channel(self, ctx):
    #     """
    #     Commands for configuration of feature channels.
    #     """
    #     if ctx.invoked_subcommand is None:
    #         return  # TODO: Error message feedback
    #
    # # Configures the channel in which player messages are to be posted. Same logic as questChannel()
    # @channel.command(name='playerboard', aliases=['player', 'pboard', 'pb'], pass_context=True)
    # async def player_board_channel(self, ctx, channel: str = None):
    #     """
    #     Get or sets the channel used for the Player Board.
    #
    #     Arguments:
    #     [no argument]: Displays the current setting.
    #     [channel link]: Sets the player board channel.
    #     """
    #     guild_id = ctx.message.guild.id
    #     collection = self.gdb['playerBoardChannel']
    #
    #     if channel and channel == 'disable':
    #         if await collection.count_documents({'guildId': guild_id}, limit=1) != 0:  # Delete the record if one exists
    #             await collection.delete_one({'guildId': guild_id})
    #         await ctx.send('Player board channel disabled!')
    #     elif channel:  # Strip the channel ID and update the db
    #         channel_id = strip_id(channel)
    #         await collection.update_one({'guildId': guild_id},
    #                                     {'$set': {'playerBoardChannel': channel_id}}, upsert=True)
    #         await ctx.send('Successfully set player board channel to {}!'.format(channel))
    #     else:  # If the channel is not provided, output the current setting.
    #         query = await collection.find_one({'guildId': guild_id})
    #         if not query:
    #             await ctx.send(f'Player board channel not set! Configure with '
    #                            f'`{await get_prefix(self.bot, ctx.message)}config channel playerboard'
    #                            f' <channel mention>`')
    #         else:
    #             await ctx.send('Player board channel currently set to <#{}>'.format(query['playerBoardChannel']))
    #
    # @channel.command(name='questboard', aliases=['quest', 'qboard', 'qb'], pass_context=True)
    # async def quest_board(self, ctx, channel: str = None):
    #     """
    #     Configures the channel in which quests are to be posted.
    #
    #     Arguments:
    #     [no argument]: Displays the current setting.
    #     [channel link]: Sets the quest board channel.
    #     """
    #     guild_id = ctx.message.guild.id
    #     collection = self.gdb['questChannel']
    #
    #     # When provided with a channel name, deletes the old entry and adds the new one.
    #     if channel:
    #         channel_id = strip_id(channel)  # Strip channel ID and cast to int
    #         await collection.update_one({'guildId': guild_id}, {'$set': {'questChannel': channel_id}}, upsert=True)
    #         await ctx.send(f'Successfully set quest board channel to {channel}!')
    #     else:  # If no channel is provided, inform the user of the current setting
    #         query = await collection.find_one({'guildId': guild_id})
    #         if not query:
    #             await ctx.send(f'Quest board channel not set! Configure with `{await get_prefix(self.bot, ctx.message)}'
    #                            f'config channel questboard <channel link>`')
    #         else:
    #             await ctx.send(f'Quest board channel currently set to <#{query["questChannel"]}>')
    #
    # @channel.command(name='questarchive', aliases=['archive', 'qarch', 'qa'], pass_context=True)
    # async def quest_archive(self, ctx, channel: str = None):
    #     """
    #     Configures the channel in which quests are to be archived.
    #
    #     Arguments:
    #     [no argument]: Displays the current setting.
    #     [channel link]: Sets the quest archive channel.
    #     --<clear>: Clears the current setting.
    #     """
    #     guild_id = ctx.message.guild.id
    #     collection = self.gdb['archiveChannel']
    #
    #     if channel:
    #         if channel.lower() == 'clear':
    #             await collection.delete_one({'guildId': guild_id})
    #             await ctx.send('Quest archive setting cleared!')
    #         else:
    #             channel_id = strip_id(channel)
    #             await collection.update_one({'guildId': guild_id}, {'$set': {'archiveChannel': channel_id}},
    #                                         upsert=True)
    #             await ctx.send(f'Successfully set quest archive channel to {channel}!')
    #     else:
    #         query = await collection.find_one({'guildId': guild_id})
    #         if not query:
    #             await ctx.send(f'Quest archive channel not set! Configure with '
    #                            f'`{await get_prefix(self.bot, ctx.message)}config channel questarchive <channel link>`')
    #         else:
    #             await ctx.send(f'Quest archive channel currently set to <#{query["archiveChannel"]}>')
    #
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
