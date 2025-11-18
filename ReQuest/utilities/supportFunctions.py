import datetime
import inspect
import logging
import re
import traceback
from typing import Tuple

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


async def log_exception(exception, interaction=None):
    logger.error(f'{type(exception).__name__}: {exception}')
    logger.error(traceback.format_exc())
    if interaction:
        try:
            if not interaction.response.is_done():
                await interaction.response.defer(ephemeral=True)
                await interaction.followup.send(exception, ephemeral=True)
            else:
                await interaction.followup.send(exception, ephemeral=True)
        except discord.errors.InteractionResponded:
            try:
                await interaction.followup.send(exception, ephemeral=True)
            except Exception as e:
                logger.error(f'Failed to send followup error message: {e}')
        except Exception as e:
            logger.error(f'Failed to handle exception in log_exception: {e}')


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


def format_currency_display(player_currency: dict, currency_config: dict) -> list[str]:
    """
    Formats currency into a list of strings based on the server's currency configuration
    (double vs integer).
    """
    if not player_currency or not currency_config or 'currencies' not in currency_config:
        return []

    output_lines = []
    processed_denominations = set()
    norm_player_wallet = normalize_currency_keys(player_currency)

    for currency in currency_config['currencies']:
        base_name = currency['name']
        denomination_map, _ = get_denomination_map(currency_config, base_name)

        if not denomination_map:
            continue

        denominations_in_wallet = {k for k in norm_player_wallet if k in denomination_map}
        if not denominations_in_wallet:
            continue

        # Display as double
        if currency.get('isDouble', False):
            total_value = 0.0
            for denom_name_lower in denominations_in_wallet:
                quantity = norm_player_wallet.get(denom_name_lower, 0)
                denom_value_in_base = denomination_map[denom_name_lower]
                total_value += quantity * denom_value_in_base
                processed_denominations.add(denom_name_lower)

            if total_value > 0:
                output_lines.append(f"{base_name.capitalize()}: **{total_value:.2f}**")

        # Display as separate integers
        else:
            # Sort by value descending
            sorted_denoms = sorted(denominations_in_wallet, key=lambda d: denomination_map[d], reverse=True)
            for denom_name_lower in sorted_denoms:
                quantity = norm_player_wallet.get(denom_name_lower, 0)
                if quantity > 0:
                    denom_display_name, _ = find_currency_or_denomination(currency_config, denom_name_lower)
                    if denom_display_name:
                        output_lines.append(f"{denom_display_name.capitalize()}: **{quantity}**")
                    processed_denominations.add(denom_name_lower)

    return output_lines


async def trade_currency(mdb, gdb, currency_name, amount, sending_member_id, receiving_member_id, guild_id):
    collection = mdb['characters']
    sender_data = await collection.find_one({'_id': sending_member_id})
    sender_character_id = sender_data['activeCharacters'][str(guild_id)]
    sender_currency = sender_data['characters'][sender_character_id]['attributes'].get('currency', {})

    currency_collection = gdb['currency']
    currency_config = await currency_collection.find_one({'_id': guild_id})
    if not currency_config:
        raise Exception('Currency definition not found')

    can_afford, message = check_sufficient_funds(sender_currency, currency_config, currency_name, amount)
    if not can_afford:
        raise Exception(f"Sender has insufficient funds: {message}")

    await update_character_inventory(None, sending_member_id, sender_character_id, currency_name, -amount)
    receiver_data = await collection.find_one({'_id': receiving_member_id})
    receiver_character_id = receiver_data['activeCharacters'][str(guild_id)]
    await update_character_inventory(None, receiving_member_id, receiver_character_id, currency_name, amount)

    sender_data = await collection.find_one({'_id': sending_member_id})
    sender_currency_db = sender_data['characters'][sender_character_id]['attributes'].get('currency', {})

    receiver_data = await collection.find_one({'_id': receiving_member_id})
    receiver_currency_db = receiver_data['characters'][receiver_character_id]['attributes'].get('currency', {})

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

    # Check if sender has enough items
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

    # Normalize the inventories for db update
    sender_character['attributes']['inventory'] = {k.capitalize(): v for k, v in sender_inventory.items()}
    receiver_character['attributes']['inventory'] = {k.capitalize(): v for k, v in receiver_inventory.items()}

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

        currency_collection = interaction.client.gdb['currency']
        currency_query = await currency_collection.find_one({'_id': interaction.guild_id})

        is_currency, currency_parent_name = None, None
        if currency_query:
            is_currency, currency_parent_name = find_currency_or_denomination(currency_query, item_name)

        if is_currency:
            denomination_map, _ = get_denomination_map(currency_query, item_name)
            if not denomination_map:
                raise Exception(f"Currency {item_name} could not be processed.")

            min_value = min(denomination_map.values())
            if min_value <= 0:
                raise Exception(f"Currency {currency_parent_name} has a non-positive denomination value.")

            character_currency = normalize_currency_keys(character_data['attributes'].get('currency', {}))

            total_in_lowest_denom = 0.0
            for denom, value in denomination_map.items():
                total_in_lowest_denom += character_currency.get(denom, 0) * (value / min_value)

            change_value_in_lowest = quantity * (denomination_map[item_name.lower()] / min_value)

            total_in_lowest_denom += change_value_in_lowest

            tolerance = 1e-9
            if total_in_lowest_denom < -tolerance:
                raise Exception(f"Insufficient funds to cover this transaction.")

            if total_in_lowest_denom < 0:
                total_in_lowest_denom = 0

            new_character_currency = {}
            for denom, value in sorted(denomination_map.items(), key=lambda x: -x[1]):
                denom_value_in_lowest = value / min_value
                if total_in_lowest_denom + tolerance >= denom_value_in_lowest:
                    qty = int(total_in_lowest_denom // denom_value_in_lowest)
                    new_character_currency[denom] = qty
                    total_in_lowest_denom %= denom_value_in_lowest

            final_wallet = normalize_currency_keys(character_data['attributes'].get('currency', {}))

            for denom_name in denomination_map.keys():
                if denom_name in new_character_currency:
                    final_wallet[denom_name] = new_character_currency[denom_name]
                elif denom_name in final_wallet:
                    del final_wallet[denom_name]

            character_currency_db = {k.capitalize(): v for k, v in final_wallet.items() if v > 0}

            await character_collection.update_one(
                {'_id': player_id},
                {'$set': {f'characters.{character_id}.attributes.currency': character_currency_db}}
            )

        else:
            character_inventory = character_data['attributes'].get('inventory', {})
            item_name_lower = item_name.lower()

            found_key = None
            for key in character_inventory.keys():
                if key.lower() == item_name_lower:
                    found_key = key
                    break

            if found_key:
                character_inventory[found_key] += int(quantity)
                if character_inventory[found_key] <= 0:
                    del character_inventory[found_key]
            elif quantity > 0:
                character_inventory[item_name.capitalize()] = int(quantity)
            elif quantity < 0:
                raise Exception(f"Insufficient item: {item_name.capitalize()}")

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
        await player_board_collection.delete_many({'guildId': interaction.guild_id,
                                                  'timestamp': {'$lt': cutoff_date}})

        # Get the channel object and purge all messages older than the cutoff
        config_collection = interaction.client.gdb['playerBoardChannel']
        config_query = await config_collection.find_one({'_id': interaction.guild_id})
        channel_id = strip_id(config_query['playerBoardChannel'])
        channel = interaction.guild.get_channel(channel_id)
        await channel.purge(before=cutoff_date)

        await interaction.response.send_message(f'Posts older than {age} days have been purged!',
                                                ephemeral=True,
                                                delete_after=10)
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
    if 'interaction' in params:
        kwargs['interaction'] = interaction

    await setup_function(**kwargs)


def get_denomination_map(currency_config: dict, currency_name: str) -> Tuple[dict | None, str | None]:
    if not currency_config or 'currencies' not in currency_config:
        return None, None

    _denom_name, parent_name = find_currency_or_denomination(currency_config, currency_name)

    if not parent_name:
        return None, None  # Not a valid configured currency

    parent_currency_config = next(
        (c for c in currency_config['currencies'] if c['name'].lower() == parent_name.lower()), None)

    if not parent_currency_config:
        return None, None  # Config is inconsistent

    denomination_map = {parent_name.lower(): 1.0}
    for denom in parent_currency_config.get('denominations', []):
        denomination_map[denom['name'].lower()] = float(denom['value'])

    return denomination_map, parent_name


def check_sufficient_funds(player_currency: dict, currency_config: dict, cost_currency_name: str,
                           cost_amount: float) -> Tuple[bool, str]:
    try:
        if cost_amount <= 0:
            return True, "OK"

        denomination_map, _ = get_denomination_map(currency_config, cost_currency_name)

        if not denomination_map:
            return False, f"Currency '{cost_currency_name}' is not configured on this server."

        cost_name_lower = cost_currency_name.lower()
        if cost_name_lower not in denomination_map:
            return False, f"Cost currency '{cost_currency_name}' is not part of its own currency system."

        min_value = min(denomination_map.values())
        if min_value <= 0:
            return False, "Currency configuration error: 0 or negative denomination value."

        norm_player_currency = normalize_currency_keys(player_currency)
        player_total_value = 0.0

        for denom_name_lower, denom_value in denomination_map.items():
            player_qty = norm_player_currency.get(denom_name_lower, 0)
            player_total_value += player_qty * (denom_value / min_value)

        cost_denom_value = denomination_map[cost_name_lower]
        cost_total_value = cost_amount * (cost_denom_value / min_value)

        tolerance = 1e-9
        if player_total_value + tolerance < cost_total_value:
            return False, "Insufficient funds."

        return True, "OK"

    except Exception as e:
        logger.error(f"Error in check_sufficient_funds: {e}")
        logger.error(traceback.format_exc())
        return False, f"An error occurred during currency validation: {e}"


def apply_item_change_local(character_data: dict, item_name: str, quantity: int) -> dict:
    inventory = character_data['attributes'].get('inventory', {})
    item_name_lower = item_name.lower()

    found_key = None
    for key in inventory.keys():
        if key.lower() == item_name_lower:
            found_key = key
            break

    if found_key:
        inventory[found_key] += int(quantity)
        if inventory[found_key] <= 0:
            del inventory[found_key]
    elif quantity > 0:
        inventory[item_name.capitalize()] = int(quantity)
    elif quantity < 0:
        raise Exception(f"Insufficient item: {item_name.capitalize()}")

    character_data['attributes']['inventory'] = inventory
    return character_data


def apply_currency_change_local(character_data: dict, currency_config: dict, item_name: str, quantity: float) -> dict:
    is_currency, currency_parent_name = find_currency_or_denomination(currency_config, item_name)

    if not is_currency:
        raise Exception(f"{item_name} is not a valid currency.")

    denomination_map, _ = get_denomination_map(currency_config, item_name)
    if not denomination_map:
        raise Exception(f"Currency {item_name} could not be processed.")

    min_value = min(denomination_map.values())
    if min_value <= 0:
        raise Exception(f"Currency {currency_parent_name} has a non-positive denomination value.")

    character_currency = normalize_currency_keys(character_data['attributes'].get('currency', {}))

    total_in_lowest_denom = 0.0
    for denom, value in denomination_map.items():
        total_in_lowest_denom += character_currency.get(denom, 0) * (value / min_value)

    change_value_in_lowest = quantity * (denomination_map[item_name.lower()] / min_value)

    total_in_lowest_denom += change_value_in_lowest

    tolerance = 1e-9
    if total_in_lowest_denom < -tolerance:
        raise Exception("Insufficient funds for this transaction.")
    if total_in_lowest_denom < 0:
        total_in_lowest_denom = 0.0

    new_character_currency = {}
    for denom, value in sorted(denomination_map.items(), key=lambda x: -x[1]):
        denom_value_in_lowest = value / min_value
        if total_in_lowest_denom + tolerance >= denom_value_in_lowest:
            qty = int(total_in_lowest_denom // denom_value_in_lowest)
            new_character_currency[denom] = qty
            total_in_lowest_denom %= denom_value_in_lowest

    final_wallet = normalize_currency_keys(character_data['attributes'].get('currency', {}))
    for denom_name in denomination_map.keys():
        if denom_name in new_character_currency:
            final_wallet[denom_name] = new_character_currency[denom_name]
        elif denom_name in final_wallet:
            del final_wallet[denom_name]

    character_data['attributes']['currency'] = {k.capitalize(): v for k, v in final_wallet.items() if v > 0}
    return character_data
