import discord
from discord import app_commands
from discord.ext.commands import Cog

from ..utilities.checks import has_gm_role


class GameMaster(Cog):
    def __init__(self, bot):
        super().__init__()
        self.bot = bot
        self.mdb = bot.mdb
        self.gdb = bot.gdb

    @has_gm_role()
    @app_commands.command(name='gm')
    async def gm(self, interaction: discord.Interaction):
        await interaction.response.send_message('Here\'s where I would keep all my GM commands, if I had any.',
                                                ephemeral=True)


async def setup(bot):
    await bot.add_cog(GameMaster(bot))

    # @has_gm_or_mod()
    # @app_commands.command(name='mod')
    # async def inventory_mod(self, interaction: discord.Interaction, user_mention: str, item_name: str,
    #                         quantity: int = 1):
    #     """
    #     Modifies a player's currently active character's inventory. GM Command.
    #     Requires an assigned GM role or Server Moderator privileges.
    #
    #     Arguments:
    #     <item_name>: The name of the item. Case-sensitive!
    #     <quantity>: Quantity to give or take.
    #     <user_mention>: User mention of the receiving player.
    #     """
    #     if quantity == 0:
    #         await interaction.response.send_message('Stop being a tease and enter an actual quantity!', ephemeral=True)
    #         return
    #
    #     gm_member_id = interaction.user.id
    #     guild_id = interaction.guild_id
    #     collection = self.mdb['characters']
    #     transaction_id = str(shortuuid.uuid()[:12])
    #
    #     member_id = strip_id(user_mention)
    #
    #     query = await collection.find_one({'_id': member_id})
    #     active_character = query['activeChars'][str(guild_id)]
    #     inventory = query['characters'][active_character]['attributes']['inventory']
    #     if item_name in inventory:
    #         current_quantity = inventory[item_name]
    #         new_quantity = current_quantity + quantity
    #         if new_quantity == 0:
    #             await collection.update_one({'_id': member_id}, {
    #                 '$unset': {f'characters.{active_character}.attributes.inventory.{item_name}': ''}}, upsert=True)
    #         else:
    #             await collection.update_one({'_id': member_id}, {
    #                 '$set': {f'characters.{active_character}.attributes.inventory.{item_name}': new_quantity}},
    #                                         upsert=True)
    #     else:
    #         await collection.update_one({'_id': member_id}, {
    #             '$set': {f'characters.{active_character}.attributes.inventory.{item_name}': quantity}}, upsert=True)
    #     recipient_string = f'<@!{member_id}> as {query["characters"][active_character]["name"]}'
    #
    #     inventory_embed = discord.Embed(description=f'Item: **{item_name}**\nQuantity: **{abs(quantity)}**',
    #                                     type='rich').set_footer(text=f'{datetime.utcnow().strftime("%Y-%m-%d")}'
    #                                                                  f' Transaction ID: {transaction_id}')
    #     if quantity > 0:
    #         inventory_embed.title = 'Item Awarded!'
    #     elif quantity < 0:
    #         inventory_embed.title = 'Item Removed!'
    #     inventory_embed.add_field(name="Recipient", value=recipient_string)
    #     inventory_embed.add_field(name='Game Master', value=f'<@!{gm_member_id}>', inline=False)
    #     await interaction.response.send_message(embed=inventory_embed)


# @experience_group.command(name='mod')
# @has_gm_or_mod()
# async def mod_experience(self, interaction: discord.Interaction, value: int, user_mention: str):
#     """
#     GM Command: Modifies the experience points of a player's currently active character.
#     Requires an assigned GM role or Server Moderator privileges.
#
#     Arguments:
#     <value>: The amount of experience given.
#     <user_mentions>: User mention(s) of the receiving player(s). Can be chained.
#     """
#     gm_member_id = interaction.user.id
#     guild_id = interaction.guild_id
#     collection = self.mdb['characters']
#     transaction_id = str(shortuuid.uuid()[:12])
#     error_title = None
#     error_message = None
#
#     if value == 0:
#         error_title = 'Invalid value'
#         error_message = 'Stop being a tease and enter an actual quantity!'
#     else:
#         member_id = (strip_id(user_mention))
#         user = await self.bot.fetch_user(member_id)
#         query = await collection.find_one({'_id': member_id})
#
#         if not query:  # If none exist, output the error
#             error_title = 'Error!'
#             error_message = f'{user.name} has no registered characters!'
#         elif not str(guild_id) in query['activeChars']:
#             error_title = 'Error!'
#             error_message = f'{user.name} has no active characters on this server!'
#         else:
#             # Otherwise, proceed to query the active character and retrieve its xp
#             active_character = query['activeChars'][str(guild_id)]
#             char = query['characters'][active_character]
#             name = char['name']
#             xp = char['attributes']['experience']
#
#             if xp:
#                 xp += value
#             else:
#                 xp = value
#
#             # Update the db
#             await collection.update_one({'_id': member_id},
#                                         {'$set': {f'characters.{active_character}.attributes.experience': xp}},
#                                         upsert=True)
#
#             # Dynamic feedback based on the operation performed
#             function = 'gained'
#             if value < 0:
#                 function = 'lost'
#             absolute = abs(value)
#             xp_embed = discord.Embed(title=f'{absolute} experience points {function}!', type='rich',
#                                      description=f'<@!{member_id}> as {name}\nTotal XP: **{xp}**')
#             xp_embed.add_field(name='Game Master', value=f'<@!{gm_member_id}>')
#             xp_embed.set_footer(text=f'{datetime.utcnow().strftime("%Y-%m-%d")} Transaction ID: {transaction_id}')
#             await interaction.response.send_message(embed=xp_embed, ephemeral=True)
#
#     if error_message:
#         error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
#         await interaction.response.send_message(embed=error_embed, ephemeral=True)


# @has_gm_or_mod()
# @currency_group.command(name='mod')
# async def currency_mod(self, interaction: discord.Interaction, user_mention: str, currency_name: str,
#                        quantity: int = 1):
#     """
#     Modifies a player's currently active character's inventory. GM Command.
#     Requires an assigned GM role or Server Moderator privileges.
#
#     Arguments:
#     <name>: The name of the inventory.
#     <quantity>: Quantity to give or take.
#     <user_mentions>: User mention(s) of the receiving player(s). Can be chained.
#     """
#     gm_user_id = interaction.user.id
#     guild_id = interaction.guild_id
#     character_collection = self.mdb['characters']
#     guild_collection = self.gdb['currency']
#     transaction_id = str(shortuuid.uuid()[:12])
#     error_title = None
#     error_message = None
#
#     # Make sure the referenced currency is a valid name used in the server
#     currency_query = await guild_collection.find_one({'_id': guild_id})
#     # TODO: Extract to validation function
#     matches = []
#     for currency in currency_query['currencies']:
#         if currency_name.lower() in currency['name'].lower():
#             matches.append(currency['name'])
#         if 'denoms' in currency:
#             denominations = currency['denoms']
#             for i in range(len(denominations)):
#                 if currency_name.lower() in denominations[i]['name'].lower():
#                     matches.append(denominations[i]['name'])
#     if quantity == 0:
#         error_title = 'Invalid Quantity!'
#         error_message = 'Stop being a tease and enter an actual quantity!'
#     elif not matches:
#         error_title = 'Incorrect Currency Name!'
#         error_message = 'No currency with that name is used on this server!'
#     else:
#         member_id = strip_id(user_mention)
#         query = await character_collection.find_one({'_id': member_id})
#         active_character = query['activeChars'][str(guild_id)]
#         inventory = query['characters'][active_character]['attributes']['inventory']
#
#         if len(matches) == 1:
#             cname = matches[0]
#         else:
#             options = []
#             for match in matches:
#                 options.append(discord.SelectOption(label=match))
#             select = SingleChoiceDropdown(placeholder='Choose One', options=options)
#             view = DropdownView(select)
#             if not interaction.response.is_done():  # Make sure this is the first response
#                 await interaction.response.send_message(f'Multiple matches found for {currency_name}!',
#                                                         view=view, ephemeral=True)
#             else:  # If the interaction has been responded to, update the original message
#                 await interaction.edit_original_response(
#                     content=f'Multiple matches found for {currency_name}!', view=view)
#             await view.wait()
#             cname = select.values[0]
#
#         if cname in inventory:
#             current_quantity = inventory[cname]
#             new_quantity = current_quantity + quantity
#             if new_quantity == 0:
#                 await character_collection.update_one({'_id': member_id}, {
#                     '$unset': {f'characters.{active_character}.attributes.inventory.{cname}': ''}}, upsert=True)
#             else:
#                 await character_collection.update_one({'_id': member_id}, {
#                     '$set': {f'characters.{active_character}.attributes.inventory.{cname}': new_quantity}},
#                                                       upsert=True)
#         else:
#             await character_collection.update_one({'_id': member_id}, {
#                 '$set': {f'characters.{active_character}.attributes.inventory.{cname}': quantity}}, upsert=True)
#
#         recipient_string = f'<@!{member_id}> as {query["characters"][active_character]["name"]}'
#
#         currency_embed = discord.Embed(type='rich')
#         if quantity > 0:
#             currency_embed.title = 'Currency Awarded!'
#         elif quantity < 0:
#             currency_embed.title = 'Currency Removed!'
#         currency_embed.description = f'Currency: **{cname}**\nQuantity: **{abs(quantity)}**'
#         currency_embed.add_field(name="Recipient", value=recipient_string)
#         currency_embed.add_field(name='Game Master', value=f'<@!{gm_user_id}>', inline=False)
#         currency_embed.set_footer(text=f'{datetime.utcnow().strftime("%Y-%m-%d")} Transaction ID: {transaction_id}')
#         if interaction.response.is_done():
#             await interaction.edit_original_response(content=None, embed=currency_embed, view=None)
#         else:
#             await interaction.response.send_message(embed=currency_embed)
#
#     if error_message:
#         error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
#         await interaction.response.send_message(embed=error_embed, ephemeral=True)


# @has_gm_or_mod()
# @app_commands.command(name='role')
# async def role(self, interaction: discord.Interaction, role_name: str = None):
#     """
#     Configures a role to be issued to a GM's party.
#
#     WARNING: Avoid placing ReQuest's role higher than any roles you don't want players to have access to.
#     Placing ReQuest's role above privileged roles could enable GMs to circumvent your server's hierarchy!
#
#     Arguments:
#     [party_role]: The role to set as the calling GM's party role.
#     --(no argument): Displays the current setting.
#     --(role name): Sets the role for questing parties.
#     --(delete|remove): Clears the role.
#     """
#     guild_id = interaction.guild_id
#     guild = self.bot.get_guild(guild_id)
#     user_id = interaction.user.id
#     collection = self.gdb['partyRole']
#     query = await collection.find_one({'guildId': guild_id, 'gm': user_id})
#     error_title = None
#     error_message = None
#
#     if role_name:
#         if role_name.lower() == 'delete' or role_name.lower() == 'remove':
#             if query:
#                 await collection.delete_one({'guildId': guild_id, 'gm': user_id})
#             await interaction.response.send_message('Party role cleared!', ephemeral=True)
#         else:
#             # Search the list of guild roles for all name matches
#             search = filter(lambda r: role_name.lower() in r.name.lower(), guild.roles)
#             matches = []
#             if search:
#                 for match in search:
#                     if match.id == guild_id:
#                         continue  # Prevent the @everyone role from being added to the list
#                     bot_member = guild.get_member(self.bot.user.id)
#                     bot_roles = bot_member.roles
#                     if match.position >= bot_roles[len(bot_roles) - 1].position:
#                         continue  # Prevent roles at or above the bot from being assigned.
#                     matches.append({'name': match.name, 'id': int(match.id)})
#
#             if not matches:
#                 error_title = f'No valid roles matching `{role_name}` were found!'
#                 error_message = 'Check your spelling and use of quotes. ReQuest cannot assign roles above itself ' \
#                                 'in your server hierarchy.'
#             elif len(matches) == 1:
#                 new_role = matches[0]
#                 # Add the new role's ID to the database
#                 await collection.update_one({'guildId': guild_id, 'gm': user_id},
#                                             {'$set': {'role': new_role['id']}}, upsert=True)
#                 # Report the changes made
#                 role_embed = discord.Embed(title='Party Role Set!', type='rich',
#                                            description=f'<@&{new_role["id"]}>')
#                 await interaction.response.send_message(embed=role_embed, ephemeral=True)
#             elif len(matches) > 1:
#                 options = []
#                 for match in matches:
#                     options.append(discord.SelectOption(label=match['name'], value=str(match['id'])))
#                 select = SingleChoiceDropdown(placeholder='Choose One', options=options)
#                 view = DropdownView(select)
#                 await interaction.response.send_message('Multiple matches found!', view=view, ephemeral=True)
#                 await view.wait()
#                 new_role = int(select.values[0])
#
#                 # Add the new role's ID to the database
#                 await collection.update_one({'guildId': guild_id, 'gm': user_id}, {'$set': {'role': new_role}},
#                                             upsert=True)
#                 # Report the changes made
#                 role_embed = discord.Embed(title='Party Role Set!', type='rich', description=f'<@&{new_role}>')
#                 await interaction.edit_original_response(content=None, embed=role_embed, view=None)
#
#     # If no argument is provided, query the db for the current setting
#     else:
#         if not query:
#             error_title = 'Missing Configuration!'
#             error_message = f'Party role not set! Configure with `/quest role <role name>`'
#         else:
#             current_role = query['role']
#             post_embed = discord.Embed(title='Quest - Role (This Server)', type='rich',
#                                        description=f'<@&{current_role}>')
#             await interaction.response.send_message(embed=post_embed, ephemeral=True)
#
#     if error_message:
#         error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
#         await interaction.response.send_message(embed=error_embed, ephemeral=True)
