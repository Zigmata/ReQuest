import logging
import re
import traceback

import discord

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


# Deletes command invocations
async def attempt_delete(message):
    try:
        await message.delete()
    except discord.HTTPException:
        pass


def strip_id(mention) -> int:
    stripped_mention = re.sub(r'[<>#!@&]', '', mention)
    parsed_id = int(stripped_mention)
    return parsed_id


def parse_list(mentions) -> [int]:
    stripped_list = [re.sub(r'[<>#!@&]', '', item) for item in mentions]
    mapped_list = list(map(int, stripped_list))
    return mapped_list


async def log_exception(exception, interaction=None):
    logger.error(f'{type(exception).__name__}: {exception}')
    logger.error(traceback.format_exc())
    if interaction:
        await interaction.response.defer()
        await interaction.followup.send(exception, ephemeral=True)


def find_currency_or_denomination(currency_def_query, search_name):
    search_name = search_name.lower()
    for currency in currency_def_query['currencies']:
        if currency['name'].lower() == search_name:
            return currency['name'], currency['name']
        if 'denominations' in currency:
            for denomination in currency['denominations']:
                if denomination['name'].lower() == search_name:
                    return denomination['name'], currency['name']
    return None, None


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


# --------- Quest Posts -------------------

# async def quest_ready_toggle(interaction: discord.Interaction, quest, quest_post_view_class) -> dict:
#     guild_id = interaction.guild_id
#     user_id = interaction.user.id
#     guild = interaction.client.get_guild(guild_id)
#
#     # Fetch the quest channel to retrieve the message object
#     channel_collection = interaction.client.gdb['questChannel']
#     channel_id_query = await channel_collection.find_one({'_id': guild_id})
#     if not channel_id_query:
#         raise Exception('Quest channel has not been set!')
#     channel_id = strip_id(channel_id_query['questChannel'])
#     channel = interaction.client.get_channel(channel_id)
#
#     # Retrieve the message object
#     message_id = quest['messageId']
#     message = channel.get_partial_message(message_id)
#
#     # Check to see if the GM has a party role configured
#     role_collection = interaction.client.gdb['partyRole']
#     role_query = await role_collection.find_one({'_id': guild_id, 'gm': user_id})
#     role = None
#     if role_query and role_query['role']:
#         role_id = role_query['role']
#         role = guild.get_role(role_id)
#
#     party = quest['party']
#     title = quest['title']
#     quest_id = quest['questId']
#     tasks = []
#
#     # Locks the quest roster and alerts party members that the quest is ready.
#     quest_collection = interaction.client.gdb['quests']
#     if not quest['lockState']:
#         await quest_collection.update_one({'questId': quest_id}, {'$set': {'lockState': True}})
#
#         # Fetch the updated quest
#         updated_quest = await quest_collection.find_one({'questId': quest_id})
#
#         # Notify each party member that the quest is ready
#         for player in party:
#             for key in player:
#                 member = guild.get_member(int(key))
#                 # If the GM has a party role configured, assign it to each party member
#                 if role:
#                     tasks.append(member.add_roles(role))
#                 tasks.append(member.send(f'Game Master <@{user_id}> has marked your quest, **"{title}"**, '
#                                          f'ready to start!'))
#
#         await interaction.user.send('Quest roster locked and party notified!')
#     # Unlocks a quest if members are not ready.
#     else:
#         # Remove the role from the players
#         if role:
#             for player in party:
#                 for key in player:
#                     member = guild.get_member(int(key))
#                     tasks.append(member.remove_roles(role))
#
#         # Unlock the quest
#         await quest_collection.update_one({'questId': quest_id}, {'$set': {'lockState': False}})
#
#         # Fetch the updated quest
#         updated_quest = await quest_collection.find_one({'questId': quest_id})
#
#         await interaction.user.send('Quest roster has been unlocked.')
#
#     if len(tasks) > 0:
#         await asyncio.gather(*tasks)
#
#     # Create a fresh quest view, and update the original post message
#     quest_view = quest_post_view_class(updated_quest)
#     await quest_view.setup_embed()
#     await message.edit(embed=quest_view.embed, view=quest_view)
#     return updated_quest
