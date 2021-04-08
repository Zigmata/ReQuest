from datetime import datetime
import discord
import shortuuid
from discord.ext import commands
from discord.ext.commands import Cog

from ..utilities.supportFunctions import delete_command, has_gm_role, strip_id

listener = Cog.listener

global gdb
global mdb


class Inventory(Cog):
    def __init__(self, bot):
        self.bot = bot
        global gdb
        global mdb
        gdb = bot.gdb
        mdb = bot.mdb

    @commands.group(case_insensitive=True)
    @has_gm_role()
    async def gm(self, ctx):
        """
        GM commands to directly award items/experience/currency to players.
        """
        if ctx.invoked_subcommand is None:
            await delete_command(ctx.message)
            return  # TODO: Error message feedback

    @gm.command(name='item', aliases=['i'])
    async def gm_item(self, ctx, item_name, quantity: int = 1, *user_mentions):
        """
        Awards a specified quantity of an item to a player's currently active character.

        Arguments:
        <user_mention>: User mention of the receiving player.
        <item_name>: The name of the item. Case-sensitive!
        [quantity]: Quantity to give. Defaults to 1 if this argument is not present.
        """
        gm_member_id = ctx.author.id
        guild_id = ctx.message.guild.id
        members = []
        for user in user_mentions:
            members.append(strip_id(user))
        collection = mdb['characters']
        transaction_id = str(shortuuid.uuid()[:12])

        recipient_strings = []
        for member_id in members:
            query = collection.find_one({'memberId': member_id})
            active_character = query['activeChars'][str(guild_id)]

            inventory = query['characters'][active_character]['attributes']['inventory']
            if item_name in inventory:
                current_quantity = inventory[item_name]
                new_quantity = current_quantity + quantity
                collection.update_one({'memberId': member_id},
                                      {'$set': {f'characters.{active_character}.attributes.'
                                                f'inventory.{item_name}': new_quantity}}, upsert=True)
            else:
                collection.update_one({'memberId': member_id}, {
                    '$set': {f'characters.{active_character}.attributes.inventory.{item_name}': quantity}}, upsert=True)

            recipient_strings.append(f'<@!{member_id}> as {query["characters"][active_character]["name"]}')

        inventory_embed = discord.Embed(type='rich')
        if len(user_mentions) > 1:
            inventory_embed.title = 'Items Awarded!'
            inventory_embed.description = f'Item: **{item_name}**\nQuantity: **{quantity}** each'
            inventory_embed.add_field(name="Recipients", value='\n'.join(recipient_strings))
        else:
            inventory_embed.title = 'Item Awarded!'
            inventory_embed.description = f'Item: **{item_name}**\nQuantity: **{quantity}**'
            inventory_embed.add_field(name="Recipient", value='\n'.join(recipient_strings))
        inventory_embed.add_field(name='Game Master', value=f'<@!{gm_member_id}>', inline=False)
        inventory_embed.set_footer(text=f'{datetime.utcnow().strftime("%Y-%m-%d")} Transaction ID: {transaction_id}')

        await ctx.send(embed=inventory_embed)

        await delete_command(ctx.message)

    @gm.command(name='experience', aliases=['xp', 'exp'])
    async def gm_experience(self, ctx, user_mention, value: int = None):
        """
        Gives experience points to a player's currently active character.

        Arguments:
        <user_mention>: User mention of the receiving player.
        <value>: The amount of experience given.
        """
        # TODO: error handling for non integer values given
        gm_member_id = ctx.author.id
        member_id = strip_id(user_mention)
        guild_id = ctx.message.guild.id
        collection = mdb['characters']
        transaction_id = str(shortuuid.uuid()[:12])

        # Load the player's characters
        query = collection.find_one({'memberId': member_id})
        if not query:  # If none exist, output the error
            await ctx.send(f'Player has no registered characters!')
            await delete_command(ctx.message)
            return

        # Otherwise, proceed to query the active character and retrieve its xp
        active_character = query['activeChars'][str(guild_id)]
        char = query['characters'][active_character]
        name = char['name']
        xp = char['attributes']['experience']

        if xp:
            xp += value
        else:
            xp = value

        # Update the db
        collection.update_one({'memberId': member_id},
                              {'$set': {f'characters.{active_character}.attributes.experience': xp}}, upsert=True)

        # Dynamic feedback based on the operation performed
        function = 'gains'
        if value < 0:
            function = 'loses'
        absolute = abs(value)
        xp_embed = discord.Embed(title=f'{name} {function} {absolute} experience points!', type='rich',
                                 description=f'Total Experience: **{xp}**')
        xp_embed.add_field(name='Game Master', value=f'<@!{gm_member_id}>')
        xp_embed.set_footer(text=f'{datetime.utcnow().strftime("%Y-%m-%d")} Transaction ID: {transaction_id}')
        await ctx.send(embed=xp_embed)

        await delete_command(ctx.message)


def setup(bot):
    bot.add_cog(Inventory(bot))
