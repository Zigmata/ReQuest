from datetime import datetime
import discord
import shortuuid
from discord.ext import commands
from discord.ext.commands import Cog

from ..utilities.supportFunctions import delete_command, strip_id
from ..utilities.checks import has_gm_or_mod, has_active_character

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

    @commands.group(aliases=['i'], case_insensitive=True)
    async def item(self, ctx):
        """
        Commands for transfer, purchase, and sale of items.
        """
        if ctx.invoked_subcommand is None:
            await delete_command(ctx.message)
            return  # TODO: Error message feedback

    @item.command(name='mod')
    @has_gm_or_mod()
    async def item_mod(self, ctx, item_name, quantity: int, *user_mentions):
        """
        Modifies a player's currently active character's inventory. GM Command.
        Requires an assigned GM role or Server Moderator privileges.

        Arguments:
        <item_name>: The name of the item. Case-sensitive!
        <quantity>: Quantity to give or take.
        <user_mentions>: User mention(s) of the receiving player(s). Can be chained.
        """
        gm_member_id = ctx.author.id
        guild_id = ctx.message.guild.id
        members = []
        for user in user_mentions:
            members.append(strip_id(user))
        collection = mdb['characters']
        if quantity == 0:
            await ctx.send('Stop being a tease and enter an actual quantity!')
            await delete_command(ctx.message)
            return

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
            if quantity > 0:
                inventory_embed.title = 'Items Awarded!'
            elif quantity < 0:
                inventory_embed.title = 'Items Removed!'
            inventory_embed.description = f'Item: **{item_name}**\nQuantity: **{abs(quantity)}** each'
            inventory_embed.add_field(name="Recipients", value='\n'.join(recipient_strings))
        else:
            if quantity > 0:
                inventory_embed.title = 'Item Awarded!'
            elif quantity < 0:
                inventory_embed.title = 'Item Removed!'
            inventory_embed.description = f'Item: **{item_name}**\nQuantity: **{quantity}**'
            inventory_embed.add_field(name="Recipient", value='\n'.join(recipient_strings))
        inventory_embed.add_field(name='Game Master', value=f'<@!{gm_member_id}>', inline=False)
        inventory_embed.set_footer(text=f'{datetime.utcnow().strftime("%Y-%m-%d")} Transaction ID: {transaction_id}')

        await ctx.send(embed=inventory_embed)

        await delete_command(ctx.message)

    @item.command(name='give')
    @has_active_character()
    async def item_give(self, ctx, item_name, quantity: int, user_mention):
        """
        Gives an item from your active character's inventory to another player's active character.

        Arguments:
        <item_name>: The name of the item. Case sensitive!
        <quantity>: The amount of the item to give.
        <user_mention>: The recipient of the item.
        """
        donor_id = ctx.author.id
        recipient_id = strip_id(user_mention)
        guild_id = ctx.message.guild.id
        collection = mdb['characters']

        recipient_query = collection.find_one({'memberId': recipient_id})
        if not recipient_query:
            await ctx.send('That player does not have any registered characters!')
            await delete_command(ctx.message)
            return
        if str(guild_id) not in recipient_query['activeChars']:
            await ctx.send('That player does not have an active character on this server!')
            await delete_command(ctx.message)
            return

        transaction_id = str(shortuuid.uuid()[:12])
        donor_query = collection.find_one({'memberId': donor_id})
        donor_active = donor_query['activeChars'][str(guild_id)]
        source_inventory = donor_query['characters'][donor_active]['attributes']['inventory']
        if item_name in source_inventory:  # First make sure the player has the item
            source_current_quantity = int(source_inventory[item_name])
            if source_current_quantity >= quantity:  # Then make sure the player has enough to give
                new_quantity = source_current_quantity - quantity
                # if new_quantity == 0:  # If the transaction would result in a 0 quantity, pull the item.
                #     collection.update_one({'memberId': donor_id},
                #                           {'$pull': {'characters': {f'{donor_active}':
                #                                                     {'attributes': {'inventory': item_name}}}}})
                if new_quantity == 0:  # If the transaction would result in a 0 quantity, pull the item.
                    collection.update_one({'memberId': donor_id},
                                          {'$pull': {'characters': {f'{donor_active}': {'attributes': {'inventory': {item_name: {'$exists': 'true'}}}}}}})
                else:  # Otherwise, just update the donor's quantity
                    collection.update_one({'memberId': donor_id},
                                          {'$set': {f'characters.{donor_active}.attributes.'
                                                    f'inventory.{item_name}': new_quantity}}, upsert=True)
                recipient_active = recipient_query['activeChars'][str(guild_id)]
                recipient_inventory = recipient_query['characters'][recipient_active]['attributes']['inventory']
                if item_name in recipient_inventory:  # Check to see if the recipient has the item already
                    recipient_current_quantity = recipient_inventory[item_name]
                    new_quantity = recipient_current_quantity + quantity  # Add to the quantity if they do
                else:  # If not, simply set the quantity given.
                    new_quantity = quantity
                collection.update_one({'memberId': recipient_id},
                                      {'$set': {f'characters.{recipient_active}.attributes.'
                                                f'inventory.{item_name}': new_quantity}}, upsert=True)
            else:
                await ctx.send('You are attempting to give more than you have. Check your inventory!')
                await delete_command(ctx.message)
                return
        else:
            await ctx.send(f'{item_name} was not found in your inventory. This command is case-sensitive; '
                           f'check your spelling.')
            await delete_command(ctx.message)
            return

        trade_embed = discord.Embed(title='Trade Completed!', type='rich',
                                    description=f'<@!{donor_id}> as '
                                                f'**{donor_query["characters"][donor_active]["name"]}**\n\n'
                                                f'gives **{quantity} {item_name}** to\n\n<@!{recipient_id}> as '
                                                f'**{recipient_query["characters"][recipient_active]["name"]}**')
        trade_embed.set_footer(text=f'{datetime.utcnow().strftime("%Y-%m-%d")} Transaction ID: {transaction_id}')

        await ctx.send(embed=trade_embed)

        await delete_command(ctx.message)

    @item.command(name='buy')
    async def item_buy(self, ctx, item_name, quantity: int):
        """
        Buys an item from the auto-market.

        Arguments:
        <item_name>: The name of the item to purchase.
        <quantity>: The quantity of the item being purchased.
        """
        await ctx.send('Future feature. Stay tuned!')
        await delete_command(ctx.message)

    @item.command(name='sell')
    async def item_sell(self, ctx, item_name, quantity: int):
        """
        Sells an item on the auto-market.

        Arguments:
        <item_name>: The name of the item to sell.
        <quantity>: The quantity of the item being sold.
        """
        await ctx.send('Future feature. Stay tuned!')
        await delete_command(ctx.message)


def setup(bot):
    bot.add_cog(Inventory(bot))
