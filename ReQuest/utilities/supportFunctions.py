import datetime
import inspect
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


def parse_list(mentions) -> list[int]:
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

    logger.debug(f"Denominations: {denominations}")

    sender_currency = normalize_currency_keys(sender_character['attributes'].get('currency', {}))
    receiver_currency = normalize_currency_keys(receiver_character['attributes'].get('currency', {}))

    # Convert the total currency of the sender to the lowest denomination
    sender_total_in_lowest_denom = sum(
        sender_currency.get(denom, 0) * (value / min(denominations.values())) for denom, value in denominations.items())
    amount_in_lowest_denom = amount * (denominations[currency_name.lower()] / min(denominations.values()))

    logger.debug(f"Sender's total in lowest denomination: {sender_total_in_lowest_denom}")
    logger.debug(f"Amount in lowest denomination: {amount_in_lowest_denom}")

    if sender_total_in_lowest_denom < amount_in_lowest_denom:
        logger.debug(f"Insufficient funds: {sender_total_in_lowest_denom} < {amount_in_lowest_denom}")
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
    logger.debug(f"Sender's currency after deduction: {sender_currency}")

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
    logger.debug(f"Receiver's currency after addition: {receiver_currency}")

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


async def update_character_inventory(interaction: discord.Interaction, player_id: int, character_id: str,
                                     item_name: str, quantity: float):
    try:
        character_collection = interaction.client.mdb['characters']
        player_data = await character_collection.find_one({'_id': player_id})
        character_data = player_data['characters'].get(character_id)

        # Fetch server currency definitions
        currency_collection = interaction.client.gdb['currency']
        currency_query = await currency_collection.find_one({'_id': interaction.guild_id})

        # If the server has a currency defined, check if the provided item name is a currency or denomination
        is_currency, currency_parent_name = None, None
        if currency_query:
            is_currency, currency_parent_name = find_currency_or_denomination(currency_query, item_name)

        if is_currency:
            # Update currency
            denominations = {d['name'].lower(): d['value'] for currency in currency_query['currencies'] if
                             currency['name'].lower() == currency_parent_name.lower() for d in
                             currency['denominations']}
            denominations[currency_parent_name.lower()] = 1  # Base currency

            character_currency = normalize_currency_keys(character_data['attributes'].get('currency', {}))

            # Convert the character's total currency to the lowest denomination
            total_in_lowest_denom = sum(
                character_currency.get(denom, 0) * (value / min(denominations.values()))
                for denom, value in denominations.items()
            )
            amount_in_lowest_denom = quantity * (denominations[item_name.lower()] / min(denominations.values()))

            # Update the total in the lowest denomination
            total_in_lowest_denom += amount_in_lowest_denom

            # Convert the total back to the original denominations
            remaining_currency = {}
            for denom, value in sorted(denominations.items(), key=lambda x: -x[1]):
                denom_value_in_lowest_denom = value / min(denominations.values())
                if total_in_lowest_denom >= denom_value_in_lowest_denom:
                    remaining_currency[denom] = int(total_in_lowest_denom // denom_value_in_lowest_denom)
                    total_in_lowest_denom %= denom_value_in_lowest_denom

            # Consolidate the currency
            consolidated_currency = consolidate_currency(remaining_currency, denominations)
            character_currency_db = {k.capitalize(): v for k, v in consolidated_currency.items()}

            await character_collection.update_one(
                {'_id': player_id},
                {'$set': {f'characters.{character_id}.attributes.currency': character_currency_db}}
            )
        else:
            # Handle inventory update
            character_inventory = character_data['attributes'].get('inventory', {})
            item_name_lower = item_name.lower()

            # Find the item in the inventory (case-insensitive)
            for key in character_inventory.keys():
                if key.lower() == item_name_lower:
                    character_inventory[key.capitalize()] += quantity
                    break
            else:
                # If item not found, add new item
                character_inventory[item_name.capitalize()] = quantity

            await character_collection.update_one(
                {'_id': player_id},
                {'$set': {f'characters.{character_id}.attributes.inventory': character_inventory}}
            )
    except Exception as e:
        await log_exception(e, interaction)


async def update_character_experience(interaction: discord.Interaction, player_id: int, character_id: str,
                                      amount: int):
    try:
        character_collection = interaction.client.mdb['characters']
        player_data = await character_collection.find_one({'_id': player_id})
        character_data = player_data['characters'].get(character_id)
        if character_data['attributes']['experience']:
            character_data['attributes']['experience'] += amount
        else:
            character_data['attributes']['experience'] = amount
        await character_collection.update_one(
            {'_id': player_id},
            {'$set': {f'characters.{character_id}': character_data}}
        )
    except Exception as e:
        await log_exception(e, interaction)


async def update_quest_embed(quest) -> discord.Embed | None:
    try:
        embed = discord.Embed()
        # Initialize all the current quest values
        (guild_id, quest_id, title, description, max_party_size, restrictions, gm, party, wait_list,
         max_wait_list_size, lock_state, rewards) = (quest['guildId'], quest['questId'], quest['title'],
                                                     quest['description'], quest['maxPartySize'],
                                                     quest['restrictions'], quest['gm'], quest['party'],
                                                     quest['waitList'], quest['maxWaitListSize'],
                                                     quest['lockState'], quest['rewards'])

        # Format the main embed body
        if restrictions:
            post_description = (
                f'**GM:** <@!{gm}>\n'
                f'**Party Restrictions:** {restrictions}\n\n'
                f'{description}\n\n'
                f'------'
            )
        else:
            post_description = (
                f'**GM:** <@!{gm}>\n\n'
                f'{description}\n\n'
                f'------'
            )

        if lock_state:
            title = title + ' (LOCKED)'

        current_party_size = len(party)
        current_wait_list_size = 0
        if wait_list:
            current_wait_list_size = len(wait_list)

        formatted_party = []
        # Map int list to string for formatting, then format the list of users as user mentions
        if len(party) > 0:
            for player in party:
                for member_id in player:
                    for character_id in player[str(member_id)]:
                        character = player[str(member_id)][str(character_id)]
                        formatted_party.append(f'- <@!{member_id}> as {character['name']}')

        formatted_wait_list = []
        # Only format the wait list if there is one.
        if len(wait_list) > 0:
            for player in wait_list:
                for member_id in player:
                    for character_id in player[str(member_id)]:
                        character = player[str(member_id)][str(character_id)]
                        formatted_wait_list.append(f'- <@!{member_id}> as {character['name']}')

        # Set the embed fields and footer
        embed.title = title
        embed.description = post_description
        if len(formatted_party) == 0:
            embed.add_field(name=f'__Party ({current_party_size}/{max_party_size})__',
                            value='None')
        else:
            embed.add_field(name=f'__Party ({current_party_size}/{max_party_size})__',
                            value='\n'.join(formatted_party))

        # Add a wait list field if one is present, unless the quest is being archived.
        if max_wait_list_size > 0:
            if len(formatted_wait_list) == 0:
                embed.add_field(name=f'__Wait List ({current_wait_list_size}/{max_wait_list_size})__',
                                value='None')
            else:
                embed.add_field(name=f'__Wait List ({current_wait_list_size}/{max_wait_list_size})__',
                                value='\n'.join(formatted_wait_list))

        embed.set_footer(text='Quest ID: ' + quest_id)

        return embed
    except Exception as e:
        await log_exception(e)


def find_character_in_lists(lists, selected_member_id, selected_character_id):
    for list_name in lists:
        for player in list_name:
            for member_id, character_data in player.items():
                if selected_member_id == member_id and selected_character_id in character_data:
                    return character_data[selected_character_id]
    return None


def find_member_and_character_id_in_lists(lists, selected_member_id):
    for list_name in lists:
        for player in list_name:
            for member_id, character_data in player.items():
                if str(member_id) == selected_member_id:
                    for character_id in character_data:
                        return member_id, character_id
    return None, None


async def purge_player_board(age, interaction):
    try:
        # Get the current datetime and calculate the cutoff date
        current_datetime = datetime.datetime.now(datetime.UTC)
        cutoff_date = current_datetime - datetime.timedelta(days=age)

        # Delete all records in the db matching this guild that are older than the cutoff
        player_board_collection = interaction.client.gdb['playerBoard']
        player_board_collection.delete_many({'guildId': interaction.guild_id,
                                             'timestamp': {'$lt': cutoff_date}})

        # Get the channel object and purge all messages older than the cutoff
        config_collection = interaction.client.gdb['playerBoardChannel']
        config_query = await config_collection.find_one({'_id': interaction.guild_id})
        channel_id = strip_id(config_query['playerBoardChannel'])
        channel = interaction.guild.get_channel(channel_id)
        await channel.purge(before=cutoff_date)

        await interaction.response.send_message(f'Posts older than {age} days have been purged!', ephemeral=True)
    except Exception as e:
        await log_exception(e, interaction)


async def query_config(config_type, bot, guild):
    try:
        collection = bot.gdb[config_type]

        query = await collection.find_one({'_id': guild.id})
        logger.debug(f'{config_type} query: {query}')
        if not query:
            return 'Not Configured'
        else:
            return query[config_type]
    except Exception as e:
        await log_exception(e)


async def setup_view(view, interaction):
    setup_function = view.setup
    sig = inspect.signature(setup_function)
    params = sig.parameters

    kwargs = {}
    if 'bot' in params:
        kwargs['bot'] = interaction.client
    if 'user' in params:
        kwargs['user'] = interaction.user
    if 'guild' in params:
        kwargs['guild'] = interaction.guild

    await setup_function(**kwargs)
