import inspect
import json
import logging
import re
import traceback
from typing import Tuple

import discord
from discord import app_commands
from titlecase import titlecase

logger = logging.getLogger(__name__)


class UserFeedbackError(Exception):
    """
    This is used for errors that should be reported to the user directly but do not need to log a stack trace.
    """
    pass


def build_cache_key(database_name, identifier, collection_name):
    return f'{database_name}:{identifier}:{collection_name}'


async def get_cached_data(bot, mongo_database, collection_name, query, is_single=True, cache_id=None):
    """
    Fetches a document from mongodb using redis caching.

    :param bot: the discord bot instance
    :param mongo_database: the mongodb database instance
    :param collection_name: the mongodb collection name
    :param query: mongodb dict query
    :param is_single: whether to fetch a single document or return a list of documents
    :param cache_id: optional identifier for redis caching; if not provided, uses the '_id' from the query

    :return: the fetched document(s) or None if not found
    """
    if cache_id is None:
        if '_id' in query:
            cache_id = query['_id']
        else:
            raise ValueError('cache_id must be provided if "_id" is not in the query.')

    cache_key = build_cache_key(mongo_database.name, cache_id, collection_name)

    try:
        cached = await bot.rdb.get(cache_key)
        if cached:
            return json.loads(cached)
    except Exception as e:
        logger.error(f"Redis read failed: {e}")
        await log_exception(e)

    try:
        if is_single:
            data = await mongo_database[collection_name].find_one(query)

            if data:
                try:
                    await bot.rdb.set(cache_key, json.dumps(data, default=str), ex=3600)
                except Exception as e:
                    logger.error(f"Redis write failed: {e}")
        else:
            cursor = mongo_database[collection_name].find(query)
            data = await cursor.to_list(length=None)

            if len(data) > 0:
                try:
                    await bot.rdb.set(cache_key, json.dumps(data, default=str), ex=3600)
                except Exception as e:
                    logger.error(f"Redis write failed: {e}")

        return data
    except Exception as e:
        await log_exception(e)
        return None


async def update_cached_data(bot, mongo_database, collection_name, query, update_data,
                             is_single: bool = True, cache_id=None):
    """
    Updates mongodb and deletes the corresponding key from redis

    :param bot: the discord bot instance
    :param mongo_database: the mongodb database instance
    :param collection_name: the mongodb collection name
    :param query: mongodb dict query
    :param update_data: the update dict for mongo
    :param is_single: whether to update a single document or multiple
    :param cache_id: identifier for redis; if not provided, uses the '_id' from the query
    """
    if cache_id is None:
        if '_id' in query:
            cache_id = query['_id']
        else:
            raise ValueError('cache_id must be provided if "_id" is not in the query.')

    cache_key = build_cache_key(mongo_database.name, cache_id, collection_name)

    try:
        mongo_collection = mongo_database[collection_name]
        if is_single:
            await mongo_collection.update_one(
                query,
                update_data,
                upsert=True
            )
        else:
            await mongo_collection.update_many(
                query,
                update_data,
                upsert=True
            )
    except Exception as e:
        raise Exception(f'Error updating config in database: {e}') from e

    try:
        await bot.rdb.delete(cache_key)
    except Exception as e:
        logger.error(f"Redis delete failed: {e}")


async def delete_cached_data(bot, mongo_database, collection_name, search_filter,
                             is_single: bool = True, cache_id=None):
    """
    Deletes documents from mongodb and deletes the corresponding keys from redis

    :param bot: the discord bot instance
    :param mongo_database: the mongodb database instance
    :param collection_name: the mongodb collection name
    :param search_filter: dict for the delete filter
    :param is_single: whether to delete a single document or multiple
    :param cache_id: identifier for redis; if not provided, uses the '_id' from the query
    """
    if cache_id is None:
        if '_id' in search_filter:
            cache_id = search_filter['_id']
        else:
            raise ValueError('cache_id must be provided if "_id" is not in the query.')

    cache_key = build_cache_key(mongo_database.name, cache_id, collection_name)

    try:
        mongo_collection = mongo_database[collection_name]
        if is_single:
            await mongo_collection.delete_one(search_filter)
        else:
            await mongo_collection.delete_many(search_filter)
    except Exception as e:
        raise Exception(f'Error deleting config in database: {e}') from e

    try:
        await bot.rdb.delete(cache_key)
    except Exception as e:
        logger.error(f"Redis delete failed: {e}")


async def attempt_delete(message: discord.Message | discord.PartialMessage):
    """
    Attempts to delete a message
    """
    try:
        await message.delete()
    except discord.HTTPException as e:
        logger.error(f'HTTPException while deleting message: {e}')
        logger.info('Failed to delete message.')
    except Exception as e:
        logger.error(f'Unexpected error while deleting message: {e}')
        logger.info('An unexpected error occurred while trying to delete the message.')


def strip_id(mention: str) -> int:
    """
    Strips a mention string to extract the ID as an integer.

    :param mention: The mention string (e.g., '<@!123456789012345678>')

    :return: The extracted ID as an integer
    """
    stripped_mention = re.sub(r'[<>#!@&]', '', mention)
    parsed_id = int(stripped_mention)
    return parsed_id


async def log_exception(exception, interaction=None):
    """
    Logs an exception and sends a user-friendly message if interaction is provided.
    """
    report_string = (
        f'An exception occurred:\n\n'
        f'```{str(exception)}```\n'
        f'If this error is unexpected, or you suspect the bot is not functioning correctly, please submit a bug report '
        f'in the [Official ReQuest Support Discord](https://discord.gg/Zq37gj4).'
    )
    error_embed = discord.Embed(
        title='⚠️ Oops!',
        description=report_string,
        color=discord.Color.red(),
        type='rich'
    )

    if isinstance(exception, app_commands.CommandInvokeError):
        exception = exception.original

    if isinstance(exception, (UserFeedbackError, app_commands.CheckFailure)):
        logger.debug(f'User feedback triggered: {exception}\nUser: {interaction.user.id if interaction else "Unknown"}')

        if interaction:
            try:
                if not interaction.response.is_done():
                    await interaction.response.send_message(embed=error_embed, ephemeral=True)
                else:
                    await interaction.followup.send(embed=error_embed, ephemeral=True)
            except discord.errors.InteractionResponded:
                try:
                    await interaction.followup.send(embed=error_embed, ephemeral=True)
                except Exception as e:
                    logger.error(f'Failed to send followup user feedback message: {e}')
            except Exception as e:
                logger.error(f'Failed to handle user feedback in log_exception: {e}')
        return

    logger.error(f'{type(exception).__name__}: {exception}')
    logger.error(traceback.format_exc())
    if interaction:
        logger.error(f'Logged from guild ID: {interaction.guild_id}, user ID: {interaction.user.id}')
        try:
            if not interaction.response.is_done():
                await interaction.response.defer(ephemeral=True)
                await interaction.followup.send(embed=error_embed, ephemeral=True)
            else:
                await interaction.followup.send(embed=error_embed, ephemeral=True)
        except discord.errors.InteractionResponded:
            try:
                await interaction.followup.send(embed=error_embed, ephemeral=True)
            except Exception as e:
                logger.error(f'Failed to send followup error message: {e}')
        except Exception as e:
            logger.error(f'Failed to handle exception in log_exception: {e}')


def find_currency_or_denomination(currency_def_query, search_name) -> Tuple[str | None, str | None]:
    """
    Finds a currency or denomination by name in the currency definition.

    :param currency_def_query: The server's currency definition dict
    :param search_name: The name of the currency or denomination to search for

    :return: A tuple containing:
                - The found currency or denomination name, or None if not found
                - The parent currency name, or None if not found
    """
    if not currency_def_query:
        return None, None
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

    :param player_currency: The player's currency dict
    :param currency_config: The server's currency config dict

    :return: A list of formatted currency strings
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
                output_lines.append(f"{titlecase(base_name)}: **{total_value:.2f}**")

        # Display as separate integers
        else:
            # Sort by value descending
            sorted_denoms = sorted(denominations_in_wallet, key=lambda d: denomination_map[d], reverse=True)
            for denom_name_lower in sorted_denoms:
                quantity = norm_player_wallet.get(denom_name_lower, 0)
                if quantity > 0:
                    denom_display_name, _ = find_currency_or_denomination(currency_config, denom_name_lower)
                    if denom_display_name:
                        output_lines.append(f"{titlecase(denom_display_name)}: **{quantity}**")
                    processed_denominations.add(denom_name_lower)

    return output_lines


async def trade_currency(interaction, gdb, currency_name, amount, sending_member_id, receiving_member_id,
                         guild_id):
    bot = interaction.client
    currency_name = currency_name.lower()
    sender_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': sending_member_id}
    )
    receiver_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': receiving_member_id}
    )
    sender_character_id = sender_data['activeCharacters'][str(guild_id)]
    sender_currency = sender_data['characters'][sender_character_id]['attributes'].get('currency', {})
    receiver_character_id = receiver_data['activeCharacters'][str(guild_id)]

    currency_collection = gdb['currency']
    currency_config = await currency_collection.find_one({'_id': guild_id})
    if not currency_config:
        raise Exception('Currency definition not found')

    can_afford, message = check_sufficient_funds(sender_currency, currency_config, currency_name, amount)
    if not can_afford:
        raise UserFeedbackError(f'The transaction cannot be completed:\n{message}')

    await update_character_inventory(interaction, sending_member_id, sender_character_id, currency_name, -amount)
    await update_character_inventory(interaction, receiving_member_id, receiver_character_id, currency_name, amount)

    updated_sender_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': sending_member_id}
    )
    updated_receiver_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': receiving_member_id}
    )
    updated_sender_currency = updated_sender_data['characters'][sender_character_id]['attributes'].get('currency')
    updated_receiver_currency = updated_receiver_data['characters'][receiver_character_id]['attributes'].get('currency')

    return updated_sender_currency, updated_receiver_currency


async def trade_item(bot, item_name, quantity, sending_member_id, receiving_member_id, guild_id):
    # Normalize the item name for consistent storage and comparison
    normalized_item_name = item_name.lower()

    # Fetch sending character
    sender_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': sending_member_id}
    )
    sender_character_id = sender_data['activeCharacters'][str(guild_id)]
    sender_character = sender_data['characters'][sender_character_id]

    # Fetch receiving character
    receiver_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': receiving_member_id}
    )
    receiver_character_id = receiver_data['activeCharacters'][str(guild_id)]
    receiver_character = receiver_data['characters'][receiver_character_id]

    # Check if sender has enough items
    sender_inventory = {k.lower(): v for k, v in sender_character['attributes']['inventory'].items()}
    quantity_owned = sender_inventory.get(normalized_item_name, 0)
    if quantity_owned < quantity:
        raise UserFeedbackError(f'You have {quantity_owned}x {titlecase(normalized_item_name)} but are trying to give '
                                f'{quantity}.')

    # Perform the trade operation
    sender_inventory[normalized_item_name] -= quantity
    if sender_inventory[normalized_item_name] == 0:
        del sender_inventory[normalized_item_name]

    receiver_inventory = {k.lower(): v for k, v in receiver_character['attributes']['inventory'].items()}
    receiver_inventory[normalized_item_name] = receiver_inventory.get(normalized_item_name, 0) + quantity

    # Normalize the inventories for db update
    sender_character['attributes']['inventory'] = {titlecase(k): v for k, v in sender_inventory.items()}
    receiver_character['attributes']['inventory'] = {titlecase(k): v for k, v in receiver_inventory.items()}

    await update_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': sending_member_id, f'characters.{sender_character_id}.attributes.inventory': {'$exists': True}},
        update_data={'$set': {f'characters.{sender_character_id}.attributes.inventory':
                              sender_character['attributes']['inventory']}}
    )
    await update_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': receiving_member_id,
               f'characters.{receiver_character_id}.attributes.inventory': {'$exists': True}},
        update_data={'$set': {f'characters.{receiver_character_id}.attributes.inventory':
                              receiver_character['attributes']['inventory']}}
    )


async def update_character_inventory(interaction, player_id: int, character_id: str,
                                     item_name: str, quantity: float):
    try:
        bot = interaction.client
        normalized_item_name = item_name.lower()

        player_data = await get_cached_data(
            bot=bot,
            mongo_database=bot.mdb,
            collection_name='characters',
            query={'_id': player_id}
        )
        character_data = player_data['characters'].get(character_id)

        currency_collection = interaction.client.gdb['currency']
        currency_query = await currency_collection.find_one({'_id': interaction.guild_id})

        is_currency, currency_parent_name = None, None
        if currency_query:
            is_currency, currency_parent_name = find_currency_or_denomination(currency_query, normalized_item_name)

        if is_currency:
            denomination_map, _ = get_denomination_map(currency_query, normalized_item_name)
            if not denomination_map:
                raise UserFeedbackError(f"Currency {item_name} could not be processed.")

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
                raise UserFeedbackError(f"Insufficient funds to cover this transaction.")

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

            character_currency_db = {titlecase(k): v for k, v in final_wallet.items() if v > 0}

            await update_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': player_id},
                update_data={'$set': {f'characters.{character_id}.attributes.currency': character_currency_db}}
            )
        else:
            character_inventory = normalize_currency_keys(character_data['attributes'].get('inventory', {}))
            found_key = normalized_item_name

            if found_key in character_inventory:
                character_inventory[found_key] += int(quantity)
                if character_inventory[found_key] <= 0:
                    del character_inventory[found_key]
            elif quantity > 0:
                character_inventory[normalized_item_name] = int(quantity)
            elif quantity < 0:
                raise UserFeedbackError(f"Insufficient item(s): {titlecase(item_name)}")

            inventory_for_db = {titlecase(k): v for k, v in character_inventory.items()}

            await update_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': player_id},
                update_data={'$set': {f'characters.{character_id}.attributes.inventory': inventory_for_db}}
            )
    except Exception as e:
        await log_exception(e, interaction)


async def update_character_experience(interaction, player_id: int, character_id: str,
                                      amount: int):
    bot = interaction.client
    try:
        player_data = await get_cached_data(
            bot=bot,
            mongo_database=bot.mdb,
            collection_name='characters',
            query={'_id': player_id}
        )
        character_data = player_data['characters'].get(character_id)
        if character_data['attributes']['experience']:
            character_data['attributes']['experience'] += amount
        else:
            character_data['attributes']['experience'] = amount

        await update_cached_data(
            bot=bot,
            mongo_database=bot.mdb,
            collection_name='characters',
            query={'_id': player_id},
            update_data={'$set': {f'characters.{character_id}': character_data}}
        )
    except Exception as e:
        await log_exception(e, interaction)


async def update_quest_embed(quest: dict) -> discord.Embed | None:
    """
    Updates a quest embed based on the current quest data.

    :param quest: The quest data dictionary

    :return: Updated discord.Embed object
    """
    try:
        embed = discord.Embed()

        # Initialize all the current quest values
        quest_id = quest['questId']
        title = quest['title']
        description = quest['description']
        max_party_size = quest['maxPartySize']
        restrictions = quest['restrictions']
        gm = quest['gm']
        party = quest['party']
        wait_list = quest['waitList']
        max_wait_list_size = quest['maxWaitListSize']
        lock_state = quest['lockState']

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


def find_member_and_character_id_in_lists(lists, selected_member_id):
    for list_name in lists:
        for player in list_name:
            for member_id, character_data in player.items():
                if str(member_id) == selected_member_id:
                    for character_id in character_data:
                        return member_id, character_id
    return None, None


async def setup_view(view, interaction: discord.Interaction):
    """
    Dynamically sets up a view by inspecting its setup method for required parameters.
    """
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
    """
    Retrieves a mapping of denomination names to their values for a given currency.

    :param currency_config: The server's currency config dict
    :param currency_name: The name of the currency or denomination to look up

    :return: A tuple containing:
             - A dict mapping denomination names (lowercase) to their float values, or None if not found
             - The parent currency name, or None if not found
    """
    if not currency_config or 'currencies' not in currency_config:
        return None, None

    _denom_name, parent_name = find_currency_or_denomination(currency_config, currency_name)

    if not parent_name:
        return None, None

    parent_currency_config = next(
        (currency for currency in currency_config['currencies'] if currency['name'].lower() == parent_name.lower()),
        None
    )

    if not parent_currency_config:
        return None, None  # Config is inconsistent

    denomination_map = {parent_name.lower(): 1.0}
    for denom in parent_currency_config.get('denominations', []):
        denomination_map[denom['name'].lower()] = float(denom['value'])

    return denomination_map, parent_name


def check_sufficient_funds(player_currency: dict, currency_config: dict, cost_currency_name: str,
                           cost_amount: float) -> Tuple[bool, str]:
    """
    Verifies that a player has funds to cover the attempted transaction.

    :param player_currency: The player's currency dict
    :param currency_config: The server's currency config dict
    :param cost_currency_name: The name of the currency or denomination that is being used
    :param cost_amount: The amount of the currency or denomination that is being used

    :return: A tuple containing:
             - A boolean indicating if the player has sufficient funds
             - A message string indicating success or the reason for failure
    """
    try:
        if cost_amount <= 0:
            return True, "OK"

        denomination_map, _ = get_denomination_map(currency_config, cost_currency_name.lower())

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
    """
    Applies an item change to a character's inventory dict.

    :param character_data: The character's data dictionary
    :param item_name: The name of the item to add or remove
    :param quantity: The quantity to add (positive) or remove (negative)

    :return: The updated character data dictionary
    """
    inventory = normalize_currency_keys(character_data['attributes'].get('inventory', {}))
    item_name_lower = item_name.lower()

    found_key = item_name_lower

    if found_key in inventory:
        inventory[found_key] += int(quantity)
        if inventory[found_key] <= 0:
            del inventory[found_key]
    elif quantity > 0:
        inventory[item_name.lower()] = int(quantity)
    elif quantity < 0:
        raise UserFeedbackError(f"Insufficient item(s): {titlecase(item_name)}")

    character_data['attributes']['inventory'] = {titlecase(k): v for k, v in inventory.items()}
    return character_data


def apply_currency_change_local(character_data: dict, currency_config: dict, item_name: str, quantity: float) -> dict:
    """
    Applies a currency change to a character's currency dict.

    :param character_data: The character's data dictionary
    :param currency_config: The server's currency config dict
    :param item_name: The name of the currency or denomination to add or remove
    :param quantity: The amount to add (positive) or remove (negative)

    :return: The updated character data dictionary
    """
    normalized_item_name = item_name.lower()
    is_currency, currency_parent_name = find_currency_or_denomination(currency_config, normalized_item_name)

    if not is_currency:
        raise UserFeedbackError(f'{item_name} is not a valid currency.')

    denomination_map, _ = get_denomination_map(currency_config, normalized_item_name)
    if not denomination_map:
        raise UserFeedbackError(f'Currency {item_name} could not be processed.')

    min_value = min(denomination_map.values())
    if min_value <= 0:
        raise Exception(f'Currency {currency_parent_name} has a non-positive denomination value.')

    character_currency = normalize_currency_keys(character_data['attributes'].get('currency', {}))

    total_in_lowest_denom = 0.0
    for denom, value in denomination_map.items():
        total_in_lowest_denom += character_currency.get(denom, 0) * (value / min_value)

    change_value_in_lowest = quantity * (denomination_map[item_name.lower()] / min_value)

    total_in_lowest_denom += change_value_in_lowest

    tolerance = 1e-9
    if total_in_lowest_denom < -tolerance:
        raise UserFeedbackError('Insufficient funds for this transaction.')
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

    character_data['attributes']['currency'] = {titlecase(k): v for k, v in final_wallet.items() if v > 0}
    return character_data


def get_base_currency_info(currency_config: dict, currency_name: str):
    """
    Returns base currency info for a given currency name.

    Parameters:
    - currency_config (dict): The currency configuration dictionary.
    - currency_name (str): The name of the currency.

    Returns:
    - Tuple[str | None, float, bool]: A tuple containing the base currency name (or None if not found),
      the multiplier to convert to base currency, and a boolean indicating if it's a double currency.
    """
    normalized_name = currency_name.lower()
    is_currency, parent_name = find_currency_or_denomination(currency_config, normalized_name)

    if not is_currency:
        return None, 0, False

    denomination_map, base_name = get_denomination_map(currency_config, normalized_name)
    multiplier = denomination_map.get(normalized_name, 0)

    is_double = False
    for currency in currency_config.get('currencies'):
        if currency['name'].lower() == base_name.lower():
            is_double = currency.get('isDouble', False)
            break

    return base_name, multiplier, is_double


def consolidate_currency_totals(raw_totals: dict, currency_config: dict) -> dict:
    """
    Consolidates raw currency totals into base currencies, or in other words, makes change so that a given currency
    is represented by the fewest amount of coins/denominations.

    :param raw_totals: A dict mapping currency/denomination names to their total amounts
    :param currency_config: The server's currency config dict

    :return: A dict mapping base currency names to their consolidated total amounts
    """
    if not currency_config:
        return raw_totals

    consolidated = {}

    for currency_name, amount in raw_totals.items():
        base_name, multiplier, _ = get_base_currency_info(currency_config, currency_name)

        if base_name:
            base_key = base_name.lower()
            total_value_in_base = amount * multiplier
            consolidated[base_key] = consolidated.get(base_key, 0.0) + total_value_in_base
        else:
            consolidated[currency_name] = consolidated.get(currency_name, 0.0) + amount

    return consolidated


def format_consolidated_totals(base_totals: dict, currency_config: dict) -> list[str]:
    """
    Formats consolidated currency totals into a list of strings for display.

    :param base_totals: A dict mapping base currency names to their total amounts
    :param currency_config: The server's currency config dict

    :return: A list of formatted currency total strings
    """
    output = []

    for base_name, total_value in base_totals.items():
        curr_conf = None
        if currency_config:
            for c in currency_config.get('currencies', []):
                if c['name'].lower() == base_name.lower():
                    curr_conf = c
                    break

        if not curr_conf:
            output.append(f"{titlecase(base_name)}: {total_value}")
            continue

        base_display_name = curr_conf['name']

        if curr_conf.get('isDouble', False):
            output.append(f"{titlecase(base_display_name)}: {total_value:.2f}")
        else:
            denoms = curr_conf.get('denominations', [])
            all_denoms = [{'name': curr_conf['name'], 'value': 1.0}] + denoms
            all_denoms.sort(key=lambda x: float(x['value']), reverse=True)

            parts = []
            remaining_val = total_value

            tolerance = 1e-9

            for d in all_denoms:
                d_val = float(d['value'])
                if remaining_val + tolerance >= d_val:
                    count = int(remaining_val / d_val + tolerance)
                    if count > 0:
                        parts.append(f'{count} {titlecase(d["name"])}')
                        remaining_val -= count * d_val

            if parts:
                output.append(', '.join(parts))
            elif total_value == 0:
                output.append(f'{titlecase(base_display_name)}: 0')
            elif total_value > 0:
                output.append(f'{titlecase(base_display_name)}: {total_value:.2f}')

    return output


def format_price_string(amount, currency_name, currency_config) -> str:
    """
    Formats a single price/cost string.

    :param amount: The amount of currency
    :param currency_name: The name of the currency
    :param currency_config: The server's currency config dict

    :return: A formatted price string
    """
    base_name, _, is_double = get_base_currency_info(currency_config, currency_name)

    display_name = titlecase(currency_name)

    if is_double:
        return f"{amount:.2f} {display_name}"
    else:
        if amount % 1 == 0:
            return f"{int(amount)} {display_name}"
        else:
            return f"{amount:.2f} {display_name}"


async def get_xp_config(bot, guild_id) -> bool:
    """
    Retrieves the XP configuration for a guild.

    :param bot: The Discord bot instance
    :param guild_id: The Discord guild id

    :return: True if XP is enabled, False if XP is disabled
    """
    try:
        query = await get_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name='playerExperience',
            query={'_id': guild_id}
        )
        if query is None:
            return True  # Default to XP enabled if no config found
        return query.get('playerExperience', True)
    except Exception as e:
        logger.error(f"Error retrieving XP config: {e}")
        await log_exception(e)
        return True  # Default to XP enabled on error
