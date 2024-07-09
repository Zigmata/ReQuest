import discord
from discord.ext.commands import Cog
from discord import app_commands
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
