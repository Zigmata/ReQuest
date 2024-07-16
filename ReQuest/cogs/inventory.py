import logging

import discord
from discord import app_commands
from discord.ext.commands import Cog

from ..utilities.checks import has_active_character
from ..utilities.supportFunctions import find_currency_or_denomination

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def normalize_currency_keys(currency_dict):
    return {k.lower(): v for k, v in currency_dict.items()}


def consolidate_currency(currency_dict, denominations):
    consolidated = {}
    sorted_denoms = sorted(denominations.items(), key=lambda x: -x[1])
    remaining_amount = sum(currency_dict.get(denom.lower(), 0) * value for denom, value in denominations.items())
    for denom, value in sorted_denoms:
        if remaining_amount >= value:
            consolidated[denom] = int(remaining_amount // value)
            remaining_amount %= value
    return consolidated


def make_change(sender_currency, remaining_amount, denom_value, denominations):
    higher_denoms = sorted([(denom, value) for denom, value in denominations.items() if value > denom_value],
                           key=lambda x: -x[1])

    for higher_denom, higher_value in higher_denoms:
        qty = sender_currency.get(higher_denom.lower(), 0)

        if qty > 0:
            total_value = qty * higher_value

            if total_value >= remaining_amount:
                needed_qty = (remaining_amount + higher_value - 1) // higher_value
                sender_currency[higher_denom.lower()] -= needed_qty
                change_amount = needed_qty * higher_value - remaining_amount
                lower_denom_qty = change_amount / denom_value
                if denom_value not in sender_currency:
                    sender_currency[denom_value] = 0
                sender_currency[denom_value] += lower_denom_qty
                remaining_amount = 0
                break
            else:
                sender_currency[higher_denom.lower()] = 0
                remaining_amount -= total_value
                lower_denom_qty = total_value / denom_value
                if denom_value not in sender_currency:
                    sender_currency[denom_value] = 0
                sender_currency[denom_value] += lower_denom_qty

    return remaining_amount


async def trade_currency(mdb, gdb, currency_name, amount, sending_member_id, receiving_member_id, guild_id):
    collection = mdb['characters']

    sender_data = await collection.find_one({'_id': sending_member_id})
    sender_character_id = sender_data['activeCharacters'][str(guild_id)]
    sender_character = sender_data['characters'][sender_character_id]

    receiver_data = await collection.find_one({'_id': receiving_member_id})
    receiver_character_id = receiver_data['activeCharacters'][str(guild_id)]
    receiver_character = receiver_data['characters'][receiver_character_id]

    currency_collection = gdb['currency']
    currency_query = await currency_collection.find_one({'_id': guild_id})
    if not currency_query:
        raise Exception('Currency definition not found')

    currencies = currency_query['currencies']

    base_currency_name, currency_parent_name = find_currency_or_denomination(currency_query, currency_name)
    if not base_currency_name:
        raise Exception('Currency or denomination not found')

    base_currency_name = currency_parent_name

    denominations = {d['name'].lower(): d['value'] for currency in currencies if
                     currency['name'].lower() == base_currency_name.lower() for d in currency['denominations']}
    denominations[base_currency_name.lower()] = 1

    logger.info(f"Denominations: {denominations}")

    sender_currency = normalize_currency_keys(sender_character['attributes'].get('currency', {}))
    receiver_currency = normalize_currency_keys(receiver_character['attributes'].get('currency', {}))

    # Convert the total currency of the sender to the lowest denomination
    sender_total_in_lowest_denom = sum(
        sender_currency.get(denom, 0) * (value / min(denominations.values())) for denom, value in denominations.items())
    amount_in_lowest_denom = amount * (denominations[currency_name.lower()] / min(denominations.values()))

    logger.info(f"Sender's total in lowest denomination: {sender_total_in_lowest_denom}")
    logger.info(f"Amount in lowest denomination: {amount_in_lowest_denom}")

    if sender_total_in_lowest_denom < amount_in_lowest_denom:
        logger.info(f"Insufficient funds: {sender_total_in_lowest_denom} < {amount_in_lowest_denom}")
        raise Exception('Insufficient funds')

    # Deduct the amount from the sender's total in the lowest denomination
    sender_total_in_lowest_denom -= amount_in_lowest_denom

    # Convert the sender's remaining total back to the original denominations
    remaining_sender_currency = {}
    for denom, value in sorted(denominations.items(), key=lambda x: -x[1]):
        denom_value_in_lowest_denom = value / min(denominations.values())
        if sender_total_in_lowest_denom >= denom_value_in_lowest_denom:
            remaining_sender_currency[denom] = int(sender_total_in_lowest_denom // denom_value_in_lowest_denom)
            sender_total_in_lowest_denom %= denom_value_in_lowest_denom

    # Consolidate the sender's currency
    sender_currency = consolidate_currency(remaining_sender_currency, denominations)
    logger.info(f"Sender's currency after deduction: {sender_currency}")

    # Add the amount to the receiver's total in the lowest denomination
    receiver_total_in_lowest_denom = sum(
        receiver_currency.get(denom, 0) * (value / min(denominations.values())) for denom, value in
        denominations.items())
    receiver_total_in_lowest_denom += amount_in_lowest_denom

    # Convert the receiver's total back to the original denominations
    remaining_receiver_currency = {}
    for denom, value in sorted(denominations.items(), key=lambda x: -x[1]):
        denom_value_in_lowest_denom = value / min(denominations.values())
        if receiver_total_in_lowest_denom >= denom_value_in_lowest_denom:
            remaining_receiver_currency[denom] = int(receiver_total_in_lowest_denom // denom_value_in_lowest_denom)
            receiver_total_in_lowest_denom %= denom_value_in_lowest_denom

    # Consolidate the receiver's currency
    receiver_currency = consolidate_currency(remaining_receiver_currency, denominations)
    logger.info(f"Receiver's currency after addition: {receiver_currency}")

    sender_currency_db = {k.capitalize(): v for k, v in sender_currency.items()}
    receiver_currency_db = {k.capitalize(): v for k, v in receiver_currency.items()}

    await collection.update_one(
        {'_id': sending_member_id, f'characters.{sender_character_id}.attributes.currency': {'$exists': True}},
        {'$set': {f'characters.{sender_character_id}.attributes.currency': sender_currency_db}}
    )
    await collection.update_one(
        {'_id': receiving_member_id, f'characters.{receiver_character_id}.attributes.currency': {'$exists': True}},
        {'$set': {f'characters.{receiver_character_id}.attributes.currency': receiver_currency_db}}
    )

    return sender_currency_db, receiver_currency_db


async def trade_item(mdb, item_name, quantity, sending_member_id, receiving_member_id, guild_id):
    collection = mdb['characters']

    # Normalize the item name for consistent storage and comparison
    normalized_item_name = ' '.join(word.capitalize() for word in item_name.split())

    # Fetch sending character
    sender_data = await collection.find_one({'_id': sending_member_id})
    sender_character_id = sender_data['activeCharacters'][str(guild_id)]
    sender_character = sender_data['characters'][sender_character_id]

    # Fetch receiving character
    receiver_data = await collection.find_one({'_id': receiving_member_id})
    receiver_character_id = receiver_data['activeCharacters'][str(guild_id)]
    receiver_character = receiver_data['characters'][receiver_character_id]

    # Check if sender has enough items (case-insensitive comparison)
    sender_inventory = {k.lower(): v for k, v in sender_character['attributes']['inventory'].items()}
    if sender_inventory.get(normalized_item_name.lower(), 0) < quantity:
        raise Exception('Insufficient items')

    # Perform the trade operation
    sender_inventory[normalized_item_name.lower()] -= quantity
    if sender_inventory[normalized_item_name.lower()] == 0:
        del sender_inventory[normalized_item_name.lower()]
    receiver_inventory = {k.lower(): v for k, v in receiver_character['attributes']['inventory'].items()}
    receiver_inventory[normalized_item_name.lower()] = receiver_inventory.get(normalized_item_name.lower(),
                                                                              0) + quantity

    # Normalize the inventories for MongoDB update
    sender_character['attributes']['inventory'] = {k.capitalize(): v for k, v in sender_inventory.items()}
    receiver_character['attributes']['inventory'] = {k.capitalize(): v for k, v in receiver_inventory.items()}

    # Update MongoDB
    await collection.update_one(
        {'_id': sending_member_id, f'characters.{sender_character_id}.attributes.inventory': {'$exists': True}},
        {'$set': {
            f'characters.{sender_character_id}.attributes.inventory': sender_character['attributes']['inventory']}}
    )
    await collection.update_one(
        {'_id': receiving_member_id, f'characters.{receiver_character_id}.attributes.inventory': {'$exists': True}},
        {'$set': {
            f'characters.{receiver_character_id}.attributes.inventory': receiver_character['attributes']['inventory']}}
    )


class Inventory(Cog):
    def __init__(self, bot):
        self.bot = bot
        self.gdb = bot.gdb
        self.mdb = bot.mdb
        super().__init__()

    @has_active_character()
    @app_commands.command(name='view')
    async def view_inventory(self, interaction: discord.Interaction, private: bool = False):
        """
        Displays the currently-loaded character's inventory.
        """
        member_id = interaction.user.id
        guild_id = interaction.guild_id
        collection = self.mdb['characters']
        query = await collection.find_one({'_id': member_id})
        active_character = query['activeCharacters'][str(guild_id)]
        name = query['characters'][active_character]['name']
        inventory = query['characters'][active_character]['attributes']['inventory']
        player_currencies = query['characters'][active_character]['attributes']['currency']
        items = []
        currencies = []

        # Get currency to split them out from the rest of the inventory
        currency_collection = self.gdb['currency']
        currency_query = await currency_collection.find_one({'_id': guild_id})
        currency_names = []
        if currency_query:
            for currency_type in currency_query['currencies']:
                currency_names.append(currency_type['name'].lower())
                if 'denominations' in currency_type:
                    for denomination in currency_type['denominations']:
                        currency_names.append(denomination['name'].lower())

        for item in inventory:
            if str(item).lower() in currency_names:
                continue
            pair = (str(item), f'**{inventory[item]}**')
            value = ': '.join(pair)
            items.append(value)

        for item in player_currencies:
            if str(item).lower() in currency_names:
                pair = (str(item), f'**{player_currencies[item]}**')
                value = ': '.join(pair)
                currencies.append(value)

        post_embed = discord.Embed(title=f'{name}\'s Possessions', type='rich', description='\n'.join(items))
        post_embed.add_field(name='Currency', value='\n'.join(currencies))

        await interaction.response.send_message(embed=post_embed, ephemeral=private)

    # @has_active_character()
    # @app_commands.command(name='give')
    # async def inventory_give(self, interaction: discord.Interaction, user_mention: str, item_name: str,
    #                          quantity: int = 1):
    #     """
    #     Gives an item from your active character's inventory to another player's active character.
    #
    #     Arguments:
    #     <user_mention>: The recipient of the item.
    #     <item_name>: The name of the item. Case-sensitive!
    #     [quantity]: The amount of the item to give. Defaults to 1 if not specified.
    #     """
    #     donor_id = interaction.user.id
    #     recipient_id = strip_id(user_mention)
    #     guild_id = interaction.guild_id
    #     collection = self.mdb['characters']
    #     error_title = None
    #     error_message = None
    #     recipient_query = await collection.find_one({'_id': recipient_id})
    #
    #     if not recipient_query:
    #         error_title = 'Item not given'
    #         error_message = f'{user_mention} does not have any registered characters!'
    #     elif str(guild_id) not in recipient_query['activeCharacters']:
    #         error_title = 'Item not given'
    #         error_message = f'{user_mention} does not have an active character on this server!'
    #     else:
    #         transaction_id = str(shortuuid.uuid()[:12])
    #         donor_query = await collection.find_one({'_id': donor_id})
    #         donor_active = donor_query['activeCharacters'][str(guild_id)]
    #         source_inventory = donor_query['characters'][donor_active]['attributes']['inventory']
    #
    #         if item_name not in source_inventory:  # First make sure the player has the item
    #             error_title = 'Item not given'
    #             error_message = f'{item_name} was not found in your inventory. This command is case-sensitive; ' \
    #                             f'check your spelling.'
    #         else:
    #             source_current_quantity = int(source_inventory[item_name])
    #
    #             if source_current_quantity < quantity:  # Then make sure the player has enough to give
    #                 error_title = 'Item not given'
    #                 error_message = 'You are attempting to give more than you have. Check your inventory!'
    #             else:
    #                 new_quantity = source_current_quantity - quantity
    #                 if new_quantity == 0:  # If the transaction results in a 0 quantity, pull the item.
    #                     await collection.update_one({'_id': donor_id}, {
    #                         '$unset': {f'characters.{donor_active}.attributes.inventory.{item_name}': ''}}, upsert=True)
    #                 else:  # Otherwise, just update the donor's quantity
    #                     await collection.update_one({'_id': donor_id}, {
    #                         '$set': {f'characters.{donor_active}.attributes.inventory.{item_name}': new_quantity}},
    #                                                 upsert=True)
    #
    #                 recipient_active = recipient_query['activeCharacters'][str(guild_id)]
    #                 recipient_inventory = recipient_query['characters'][recipient_active]['attributes']['inventory']
    #                 if item_name in recipient_inventory:  # Check to see if the recipient has the item already
    #                     recipient_current_quantity = recipient_inventory[item_name]
    #                     new_quantity = recipient_current_quantity + quantity  # Add to the quantity if they do
    #                 else:  # If not, simply set the quantity given.
    #                     new_quantity = quantity
    #
    #                 await collection.update_one({'_id': recipient_id}, {
    #                     '$set': {f'characters.{recipient_active}.attributes.inventory.{item_name}': new_quantity}},
    #                                             upsert=True)
    #
    #                 trade_embed = discord.Embed(
    #                     title='Trade Completed!', type='rich',
    #                     description=f'<@!{donor_id}> as **{donor_query["characters"][donor_active]["name"]}**\n\ngives '
    #                                 f'**{quantity}x {item_name}** to\n\n<@!{recipient_id}> as '
    #                                 f'**{recipient_query["characters"][recipient_active]["name"]}**')
    #                 trade_embed.set_footer(text=f'{datetime.utcnow().strftime("%Y-%m-%d")} '
    #                                             f'Transaction ID: {transaction_id}')
    #                 await interaction.response.send_message(embed=trade_embed)
    #
    #     if error_message:
    #         error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
    #         await interaction.response.send_message(embed=error_embed, ephemeral=True)
    #
    # @has_active_character()
    # @app_commands.command(name='buy')
    # async def inventory_buy(self, interaction: discord.Interaction, item_name: str, quantity: int = 1):
    #     """
    #     Buys an item from the auto-market.
    #     Arguments:
    #     <item_name>: The name of the item to purchase.
    #     <quantity>: The quantity of the item being purchased.
    #     """
    #     await interaction.response.send_message('Future feature. Stay tuned!', ephemeral=True)
    #
    # @has_active_character()
    # @app_commands.command(name='sell')
    # async def inventory_sell(self, interaction: discord.Interaction, item_name: str, quantity: int = 1):
    #     """
    #     Sells an item on the auto-market.
    #     Arguments:
    #     <item_name>: The name of the item to sell.
    #     <quantity>: The quantity of the item being sold.
    #     """
    #     await interaction.response.send_message('Future feature. Stay tuned!', ephemeral=True)


async def setup(bot):
    await bot.add_cog(Inventory(bot))
