from datetime import datetime

import discord
import shortuuid
from discord import app_commands
from discord.ext.commands import Cog

from ..utilities.checks import has_gm_or_mod, has_active_character
from ..utilities.supportFunctions import strip_id

listener = Cog.listener


class Inventory(Cog):
    def __init__(self, bot):
        self.bot = bot
        self.gdb = bot.gdb
        self.mdb = bot.mdb
        super().__init__()

    @has_active_character()
    @app_commands.command(name='view')
    async def inventory_view(self, interaction: discord.Interaction, private: bool = False):
        """
        Displays the currently-loaded character's inventory.
        """
        # if not has_active_character():
        #     await interaction.response.send_message('You do not have an active character!', ephemeral=True)
        #     return
        member_id = interaction.user.id
        guild_id = interaction.guild_id
        collection = self.mdb['characters']
        query = await collection.find_one({'_id': member_id})
        active_character = query['activeChars'][str(guild_id)]
        name = query['characters'][active_character]['name']
        inventory = query['characters'][active_character]['attributes']['inventory']
        items = []

        # Get currency to split them out from the rest of the inventory
        currency_collection = self.gdb['currency']
        currency_query = await currency_collection.find_one({'_id': guild_id})
        currency_names = []
        if currency_query:
            for currency_type in currency_query['currencies']:
                currency_names.append(currency_type['name'].lower())
                if 'denoms' in currency_type:
                    for denom in currency_type['denoms']:
                        currency_names.append(denom['name'].lower())

        for item in inventory:
            if str(item).lower() in currency_names:
                continue
            pair = (str(item), f'**{inventory[item]}**')
            value = ': '.join(pair)
            items.append(value)

        post_embed = discord.Embed(title=f'{name}\'s Possessions', type='rich', description='\n'.join(items))

        await interaction.response.send_message(embed=post_embed, ephemeral=private)

    @has_active_character()
    @app_commands.command(name='give')
    async def inventory_give(self, interaction: discord.Interaction, user_mention: str, item_name: str,
                             quantity: int = 1):
        """
        Gives an item from your active character's inventory to another player's active character.

        Arguments:
        <user_mention>: The recipient of the item.
        <item_name>: The name of the item. Case-sensitive!
        [quantity]: The amount of the item to give. Defaults to 1 if not specified.
        """
        donor_id = interaction.user.id
        recipient_id = strip_id(user_mention)
        guild_id = interaction.guild_id
        collection = self.mdb['characters']
        error_title = None
        error_message = None
        recipient_query = await collection.find_one({'_id': recipient_id})

        if not recipient_query:
            error_title = 'Item not given'
            error_message = f'{user_mention} does not have any registered characters!'
        elif str(guild_id) not in recipient_query['activeChars']:
            error_title = 'Item not given'
            error_message = f'{user_mention} does not have an active character on this server!'
        else:
            transaction_id = str(shortuuid.uuid()[:12])
            donor_query = await collection.find_one({'_id': donor_id})
            donor_active = donor_query['activeChars'][str(guild_id)]
            source_inventory = donor_query['characters'][donor_active]['attributes']['inventory']

            if item_name not in source_inventory:  # First make sure the player has the item
                error_title = 'Item not given'
                error_message = f'{item_name} was not found in your inventory. This command is case-sensitive; ' \
                                f'check your spelling.'
            else:
                source_current_quantity = int(source_inventory[item_name])

                if source_current_quantity < quantity:  # Then make sure the player has enough to give
                    error_title = 'Item not given'
                    error_message = 'You are attempting to give more than you have. Check your inventory!'
                else:
                    new_quantity = source_current_quantity - quantity
                    if new_quantity == 0:  # If the transaction results in a 0 quantity, pull the item.
                        await collection.update_one({'_id': donor_id}, {
                            '$unset': {f'characters.{donor_active}.attributes.inventory.{item_name}': ''}}, upsert=True)
                    else:  # Otherwise, just update the donor's quantity
                        await collection.update_one({'_id': donor_id}, {
                            '$set': {f'characters.{donor_active}.attributes.inventory.{item_name}': new_quantity}},
                                                    upsert=True)

                    recipient_active = recipient_query['activeChars'][str(guild_id)]
                    recipient_inventory = recipient_query['characters'][recipient_active]['attributes']['inventory']
                    if item_name in recipient_inventory:  # Check to see if the recipient has the item already
                        recipient_current_quantity = recipient_inventory[item_name]
                        new_quantity = recipient_current_quantity + quantity  # Add to the quantity if they do
                    else:  # If not, simply set the quantity given.
                        new_quantity = quantity

                    await collection.update_one({'_id': recipient_id}, {
                        '$set': {f'characters.{recipient_active}.attributes.inventory.{item_name}': new_quantity}},
                                                upsert=True)

                    trade_embed = discord.Embed(
                        title='Trade Completed!', type='rich',
                        description=f'<@!{donor_id}> as **{donor_query["characters"][donor_active]["name"]}**\n\ngives '
                                    f'**{quantity}x {item_name}** to\n\n<@!{recipient_id}> as '
                                    f'**{recipient_query["characters"][recipient_active]["name"]}**')
                    trade_embed.set_footer(text=f'{datetime.utcnow().strftime("%Y-%m-%d")} '
                                                f'Transaction ID: {transaction_id}')
                    await interaction.response.send_message(embed=trade_embed)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    @has_active_character()
    @app_commands.command(name='buy')
    async def inventory_buy(self, interaction: discord.Interaction, item_name: str, quantity: int = 1):
        """
        Buys an item from the auto-market.
        Arguments:
        <item_name>: The name of the item to purchase.
        <quantity>: The quantity of the item being purchased.
        """
        await interaction.response.send_message('Future feature. Stay tuned!', ephemeral=True)

    @has_active_character()
    @app_commands.command(name='sell')
    async def inventory_sell(self, interaction: discord.Interaction, item_name: str, quantity: int = 1):
        """
        Sells an item on the auto-market.
        Arguments:
        <item_name>: The name of the item to sell.
        <quantity>: The quantity of the item being sold.
        """
        await interaction.response.send_message('Future feature. Stay tuned!', ephemeral=True)


async def setup(bot):
    await bot.add_cog(Inventory(bot))
