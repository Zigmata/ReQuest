import inspect
import json
import logging
import re
import traceback
from typing import Tuple

import discord
import shortuuid
from discord import app_commands
from titlecase import titlecase
from datetime import datetime, timezone, timedelta

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

            if data:
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


async def replace_cached_data(bot, mongo_database, collection_name, query, new_data, cache_id=None):
    """
    Replaces a document in mongodb and deletes the corresponding key from redis

    :param bot: the discord bot instance
    :param mongo_database: the mongodb database instance
    :param collection_name: the mongodb collection name
    :param query: mongodb dict query
    :param new_data: the new document data to replace with
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
        await mongo_collection.replace_one(
            query,
            new_data,
            upsert=True
        )
    except Exception as e:
        raise Exception(f'Error replacing config in database: {e}') from e

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
    except Exception as e:
        logger.error(f'Unexpected error while deleting message: {e}')


def strip_id(mention: str) -> int:
    """
    Strips a mention string to extract the ID as an integer.

    :param mention: The mention string (e.g., '<@!123456789012345678>')

    :return: The extracted ID as an integer
    """
    stripped_mention = re.sub(r'[<>#!@&]', '', mention)
    parsed_id = int(stripped_mention)
    return parsed_id


def escape_markdown(text: str) -> str:
    """
    Escapes Discord markdown special characters in text.

    :param text: The text to escape

    :return: Text with markdown characters escaped
    """
    if not text:
        return text
    # Escape backslash first to avoid double-escaping
    text = text.replace('\\', '\\\\')
    # Escape other markdown characters
    for char in ('*', '_', '~', '`', '|', '>', '[', ']', '(', ')'):
        text = text.replace(char, f'\\{char}')
    return text


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


async def trade_currency(interaction, currency_name, amount, sending_member_id, receiving_member_id,
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

    currency_config = await get_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name='currency',
        query={'_id': guild_id}
    )

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

    # Check if sender has enough items across all containers + loose items
    quantity_owned = get_total_item_quantity(sender_character, item_name)
    if quantity_owned < quantity:
        raise UserFeedbackError(f'You have {quantity_owned}x {titlecase(normalized_item_name)} but are trying to give '
                                f'{quantity}.')

    # Get item locations and remove items (loose items first, then containers)
    locations = get_item_locations(sender_character, item_name)
    # Sort so loose items (id=None) come first
    locations.sort(key=lambda x: (x['id'] is not None, x['name']))

    remaining_to_remove = quantity
    for loc in locations:
        if remaining_to_remove <= 0:
            break

        container_id = loc['id']
        loc_qty = loc['quantity']
        remove_from_here = min(loc_qty, remaining_to_remove)

        if container_id is None:
            # Remove from loose items
            inventory = sender_character['attributes'].get('inventory', {})
            for key in list(inventory.keys()):
                if key.lower() == normalized_item_name:
                    inventory[key] -= remove_from_here
                    if inventory[key] <= 0:
                        del inventory[key]
                    break
        else:
            # Remove from container
            container_items = sender_character['attributes']['containers'][container_id].get('items', {})
            for key in list(container_items.keys()):
                if key.lower() == normalized_item_name:
                    container_items[key] -= remove_from_here
                    if container_items[key] <= 0:
                        del container_items[key]
                    break

        remaining_to_remove -= remove_from_here

    # Add items to receiver's loose inventory
    receiver_inventory = receiver_character['attributes'].get('inventory', {})
    # Find existing key (case-insensitive) or use titlecase
    existing_key = None
    for key in receiver_inventory:
        if key.lower() == normalized_item_name:
            existing_key = key
            break

    if existing_key:
        receiver_inventory[existing_key] += quantity
    else:
        receiver_inventory[titlecase(item_name)] = quantity

    # Update sender's character data
    sender_update = {
        f'characters.{sender_character_id}.attributes.inventory': sender_character['attributes'].get('inventory', {})
    }
    # Include container updates if containers exist
    if sender_character['attributes'].get('containers'):
        sender_update[f'characters.{sender_character_id}.attributes.containers'] = sender_character['attributes']['containers']

    await update_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': sending_member_id},
        update_data={'$set': sender_update}
    )

    # Update receiver's inventory
    await update_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': receiving_member_id},
        update_data={'$set': {f'characters.{receiver_character_id}.attributes.inventory': receiver_inventory}}
    )


async def update_character_inventory(interaction: discord.Interaction, player_id: int, character_id: str,
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
        if not player_data:
            raise UserFeedbackError('Player data not found.')

        character_data = player_data['characters'].get(character_id)
        if not character_data:
            raise UserFeedbackError('Character data not found.')

        currency_query = await get_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name='currency',
            query={'_id': interaction.guild_id}
        )

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
        if not player_data:
            raise UserFeedbackError('Player data not found.')

        character_data = player_data['characters'].get(character_id)
        if not character_data:
            raise UserFeedbackError('Character data not found.')

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
        if party:
            for player in party:
                for member_id in player:
                    for character_id in player[str(member_id)]:
                        character = player[str(member_id)][str(character_id)]
                        formatted_party.append(f'- <@!{member_id}> as {character['name']}')

        formatted_wait_list = []
        # Only format the wait list if there is one.
        if wait_list:
            for player in wait_list:
                for member_id in player:
                    for character_id in player[str(member_id)]:
                        character = player[str(member_id)][str(character_id)]
                        formatted_wait_list.append(f'- <@!{member_id}> as {character['name']}')

        # Set the embed fields and footer
        embed.title = title
        embed.description = post_description
        if formatted_party:
            party_string = '\n'.join(formatted_party)
        else:
            party_string = 'None'
        embed.add_field(name=f'__Party ({current_party_size}/{max_party_size})__',
                        value=party_string)

        # Add a wait list field if one is present, unless the quest is being archived.
        if max_wait_list_size > 0:
            if formatted_wait_list:
                wait_list_string = '\n'.join(formatted_wait_list)
            else:
                wait_list_string = 'None'

            embed.add_field(name=f'__Wait List ({current_wait_list_size}/{max_wait_list_size})__',
                            value=wait_list_string)

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
        return f'{amount:.2f} {display_name}'
    else:
        if amount % 1 == 0:
            return f'{int(amount)} {display_name}'
        else:
            return f'{amount:.2f} {display_name}'


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


def format_complex_cost(costs: list, currency_config: dict) -> str:
    """
    Formats a list of complex costs into a readable string.

    :param costs: A list of cost dictionaries, e.g. [{'gold': 10}, {'reputation': 50}]
    :param currency_config: The server's currency config dict

    :return: A formatted cost string
    """

    if not costs:
        return 'Free'

    option_strings = []
    for option in costs:
        component_strings = []
        for currency_name, amount in option.items():
            component_strings.append(format_price_string(amount, currency_name, currency_config))
        if component_strings:
            option_strings.append(' + '.join(component_strings))

    if not option_strings:
        return 'Free'

    return ' OR\n'.join(option_strings)


# ----- Shop Stock Management -----


async def get_item_stock(bot, guild_id: int, channel_id: str, item_name: str) -> dict | None:
    """
    Retrieves stock information for a specific item in a shop.

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param channel_id: The shop channel ID
    :param item_name: The name of the item

    :return: Dict with 'available' and 'reserved' counts, or None if unlimited
    """
    stock_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name='shopStock',
        query={'_id': guild_id}
    )

    if not stock_data:
        return None

    shops = stock_data.get('shops', {})
    shop_stock = shops.get(str(channel_id), {})
    item_stock = shop_stock.get(encode_mongo_key(item_name))

    if item_stock is None:
        return None

    return {
        'available': item_stock.get('available', 0),
        'reserved': item_stock.get('reserved', 0)
    }


async def get_shop_stock(bot, guild_id: int, channel_id: str) -> dict:
    """
    Retrieves all stock information for a shop.

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param channel_id: The shop channel ID

    :return: Dict mapping item names to their stock info, empty dict if no stock limits
    """
    stock_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name='shopStock',
        query={'_id': guild_id}
    )

    if not stock_data:
        return {}

    shops = stock_data.get('shops', {})
    return shops.get(str(channel_id), {})


async def initialize_item_stock(bot, guild_id: int, channel_id: str, item_name: str,
                                max_stock: int, current_stock: int | None = None):
    """
    Initializes stock tracking for a limited item.

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param channel_id: The shop channel ID
    :param item_name: The name of the item
    :param max_stock: The maximum stock for this item
    :param current_stock: The current stock (defaults to max_stock if not provided)
    """
    if current_stock is None:
        current_stock = max_stock

    await update_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name='shopStock',
        query={'_id': guild_id},
        update_data={
            '$set': {
                f'shops.{channel_id}.{encode_mongo_key(item_name)}': {
                    'available': current_stock,
                    'reserved': 0
                }
            }
        }
    )


async def remove_item_stock_limit(bot, guild_id: int, channel_id: str, item_name: str):
    """
    Removes stock tracking for an item (makes it unlimited).

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param channel_id: The shop channel ID
    :param item_name: The name of the item
    """
    await update_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name='shopStock',
        query={'_id': guild_id},
        update_data={
            '$unset': {
                f'shops.{channel_id}.{encode_mongo_key(item_name)}': ''
            }
        }
    )


async def reserve_stock(bot, guild_id: int, channel_id: str, item_name: str, quantity: int = 1) -> bool:
    """
    Atomically reserves stock by moving from available to reserved.

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param channel_id: The shop channel ID
    :param item_name: The name of the item
    :param quantity: The quantity to reserve

    :return: True if reservation succeeded, False if insufficient stock
    """
    collection = bot.gdb['shopStock']

    encoded_name = encode_mongo_key(item_name)
    result = await collection.find_one_and_update(
        {
            '_id': guild_id,
            f'shops.{channel_id}.{encoded_name}.available': {'$gte': quantity}
        },
        {
            '$inc': {
                f'shops.{channel_id}.{encoded_name}.available': -quantity,
                f'shops.{channel_id}.{encoded_name}.reserved': quantity
            }
        },
        return_document=True
    )

    # Invalidate cache after update
    if result:
        cache_key = build_cache_key(bot.gdb.name, guild_id, 'shopStock')
        try:
            await bot.rdb.delete(cache_key)
        except Exception as e:
            logger.error(f"Redis delete failed: {e}")
        return True

    return False


async def release_stock(bot, guild_id: int, channel_id: str, item_name: str, quantity: int = 1):
    """
    Releases reserved stock back to available.

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param channel_id: The shop channel ID
    :param item_name: The name of the item
    :param quantity: The quantity to release
    """
    collection = bot.gdb['shopStock']
    encoded_name = encode_mongo_key(item_name)
    path = f'shops.{channel_id}.{encoded_name}'

    result = await collection.update_one(
        {'_id': guild_id, f'{path}.reserved': {'$exists': True}},
        [
            {
                '$set': {
                    f'{path}.available': {'$add': [f'${path}.available', quantity]},
                    f'{path}.reserved': {'$max': [0, {'$subtract': [f'${path}.reserved', quantity]}]}
                }
            }
        ]
    )

    # Invalidate cache after update
    if result.modified_count > 0:
        cache_key = build_cache_key(bot.gdb.name, guild_id, 'shopStock')
        try:
            await bot.rdb.delete(cache_key)
        except Exception as e:
            logger.error(f"Redis delete failed: {e}")


async def finalize_stock(bot, guild_id: int, channel_id: str, item_name: str, quantity: int = 1):
    """
    Finalizes a purchase by removing from reserved (stock already decremented from available).

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param channel_id: The shop channel ID
    :param item_name: The name of the item
    :param quantity: The quantity to finalize
    """
    collection = bot.gdb['shopStock']
    encoded_name = encode_mongo_key(item_name)
    path = f'shops.{channel_id}.{encoded_name}'

    result = await collection.update_one(
        {'_id': guild_id, f'{path}.reserved': {'$exists': True}},
        [
            {
                '$set': {
                    f'{path}.reserved': {'$max': [0, {'$subtract': [f'${path}.reserved', quantity]}]}
                }
            }
        ]
    )

    # Invalidate cache after update
    if result.modified_count > 0:
        cache_key = build_cache_key(bot.gdb.name, guild_id, 'shopStock')
        try:
            await bot.rdb.delete(cache_key)
        except Exception as e:
            logger.error(f"Redis delete failed: {e}")


async def set_available_stock(bot, guild_id: int, channel_id: str, item_name: str, amount: int):
    """
    Sets the available stock to a specific amount (used for full restock).

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param channel_id: The shop channel ID
    :param item_name: The name of the item
    :param amount: The amount to set available stock to
    """
    await update_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name='shopStock',
        query={'_id': guild_id},
        update_data={
            '$set': {
                f'shops.{channel_id}.{encode_mongo_key(item_name)}.available': amount
            }
        }
    )


async def increment_available_stock(bot, guild_id: int, channel_id: str, item_name: str,
                                    increment: int, max_stock: int):
    """
    Increments available stock up to the maximum (used for incremental restock).

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param channel_id: The shop channel ID
    :param item_name: The name of the item
    :param increment: The amount to add
    :param max_stock: The maximum stock allowed
    """
    collection = bot.gdb['shopStock']
    encoded_name = encode_mongo_key(item_name)
    path = f'shops.{channel_id}.{encoded_name}'

    result = await collection.update_one(
        {'_id': guild_id, f'{path}.available': {'$exists': True}},
        [
            {
                '$set': {
                    f'{path}.available': {'$min': [max_stock, {'$add': [f'${path}.available', increment]}]}
                }
            }
        ]
    )

    # Invalidate cache after update
    if result.modified_count > 0:
        cache_key = build_cache_key(bot.gdb.name, guild_id, 'shopStock')
        try:
            await bot.rdb.delete(cache_key)
        except Exception as e:
            logger.error(f"Redis delete failed: {e}")


async def update_last_restock(bot, guild_id: int, channel_id: str, timestamp: str):
    """
    Updates the last restock timestamp for a shop.

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param channel_id: The shop channel ID
    :param timestamp: ISO format timestamp string
    """
    await update_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name='shopStock',
        query={'_id': guild_id},
        update_data={
            '$set': {
                f'lastRestock.{channel_id}': timestamp
            }
        }
    )


async def get_last_restock(bot, guild_id: int, channel_id: str) -> str | None:
    """
    Gets the last restock timestamp for a shop.

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param channel_id: The shop channel ID

    :return: ISO format timestamp string or None
    """
    stock_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name='shopStock',
        query={'_id': guild_id}
    )

    if not stock_data:
        return None

    return stock_data.get('lastRestock', {}).get(str(channel_id))


# ----- Shop Cart Management -----


CART_TTL_MINUTES = 10


def encode_mongo_key(key: str) -> str:
    """
    Encodes a string for safe use as a MongoDB field name.

    MongoDB field names cannot contain:
    - '.' (dot) - interpreted as nested document path
    - '$' (dollar) - reserved for operators
    - null characters - not allowed in field names

    Uses URL-encoding style. The '%' character is encoded first to ensure reversibility.
    """
    if not key:
        return key
    # Order matters: encode '%' first to avoid double-encoding
    result = key.replace('%', '%25')
    result = result.replace('.', '%2E')
    result = result.replace('$', '%24')
    # Strip null characters (invalid in MongoDB field names and have no display value)
    result = result.replace('\x00', '')
    return result


def decode_mongo_key(key: str) -> str:
    """
    Decodes a MongoDB field name back to its original form.

    Reverses the encoding applied by encode_mongo_key().
    """
    if not key:
        return key
    # Order matters: decode '%' last to avoid incorrect decoding
    result = key.replace('%2E', '.')
    result = result.replace('%24', '$')
    result = result.replace('%25', '%')
    return result


def build_cart_id(guild_id: int, user_id: int, channel_id: str) -> str:
    """Builds the cart document ID."""
    return f"{guild_id}:{user_id}:{channel_id}"


async def get_cart(bot, guild_id: int, user_id: int, channel_id: str) -> dict | None:
    """
    Retrieves an existing cart for a user in a specific shop.

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param user_id: The user ID
    :param channel_id: The shop channel ID

    :return: Cart document or None if not found
    """
    cart_id = build_cart_id(guild_id, user_id, channel_id)

    cart = await get_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name='shopCarts',
        query={'_id': cart_id},
        cache_id=cart_id
    )

    if not cart:
        return None

    # Check if cart has expired
    expires_at = cart.get('expiresAt')
    if expires_at:
        if isinstance(expires_at, str):
            expires_at = datetime.fromisoformat(expires_at.replace('Z', '+00:00'))
        if datetime.now(timezone.utc) > expires_at:
            # Cart expired, clean it up
            await clear_cart_and_release_stock(bot, guild_id, user_id, channel_id)
            return None

    return cart


async def get_or_create_cart(bot, guild_id: int, user_id: int, channel_id: str) -> dict:
    """
    Gets an existing cart or creates a new one.

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param user_id: The user ID
    :param channel_id: The shop channel ID

    :return: Cart document
    """
    cart = await get_cart(bot, guild_id, user_id, channel_id)

    if cart:
        return cart

    # Create new cart
    cart_id = build_cart_id(guild_id, user_id, channel_id)
    now = datetime.now(timezone.utc)
    expires_at = now + timedelta(minutes=CART_TTL_MINUTES)

    new_cart = {
        '_id': cart_id,
        'guildId': guild_id,
        'userId': user_id,
        'channelId': channel_id,
        'items': {},
        'createdAt': now.isoformat(),
        'updatedAt': now.isoformat(),
        'expiresAt': expires_at.isoformat()
    }

    await update_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name='shopCarts',
        query={'_id': cart_id},
        update_data={'$set': new_cart},
        cache_id=cart_id
    )

    return new_cart


async def update_cart_expiry(bot, guild_id: int, user_id: int, channel_id: str):
    """
    Extends the cart expiry to now + TTL.

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param user_id: The user ID
    :param channel_id: The shop channel ID
    """
    cart_id = build_cart_id(guild_id, user_id, channel_id)
    now = datetime.now(timezone.utc)
    expires_at = now + timedelta(minutes=CART_TTL_MINUTES)

    await update_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name='shopCarts',
        query={'_id': cart_id},
        update_data={
            '$set': {
                'updatedAt': now.isoformat(),
                'expiresAt': expires_at.isoformat()
            }
        },
        cache_id=cart_id
    )


async def add_item_to_cart(bot, guild_id: int, user_id: int, channel_id: str,
                           item: dict, option_index: int = 0) -> bool:
    """
    Adds an item to the cart and reserves stock if applicable.

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param user_id: The user ID
    :param channel_id: The shop channel ID
    :param item: The item data dictionary
    :param option_index: The cost option index

    :return: True if successful, False if out of stock
    """
    item_name = item.get('name')
    cart_key = f"{encode_mongo_key(item_name)}::{option_index}"

    # Check if item has stock limit and reserve if needed
    has_stock_limit = item.get('maxStock') is not None
    if has_stock_limit:
        success = await reserve_stock(bot, guild_id, channel_id, item_name, 1)
        if not success:
            return False

    # Get or create cart
    cart = await get_or_create_cart(bot, guild_id, user_id, channel_id)
    cart_id = cart['_id']

    now = datetime.now(timezone.utc)
    expires_at = now + timedelta(minutes=CART_TTL_MINUTES)

    # Check if item already in cart
    existing_items = cart.get('items', {})
    if cart_key in existing_items:
        # Increment quantity
        await update_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name='shopCarts',
            query={'_id': cart_id},
            update_data={
                '$inc': {f'items.{cart_key}.quantity': 1},
                '$set': {
                    'updatedAt': now.isoformat(),
                    'expiresAt': expires_at.isoformat()
                }
            },
            cache_id=cart_id
        )
    else:
        # Add new item
        cart_item = {
            'item': item,
            'quantity': 1,
            'optionIndex': option_index,
            'reservedAt': now.isoformat()
        }
        await update_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name='shopCarts',
            query={'_id': cart_id},
            update_data={
                '$set': {
                    f'items.{cart_key}': cart_item,
                    'updatedAt': now.isoformat(),
                    'expiresAt': expires_at.isoformat()
                }
            },
            cache_id=cart_id
        )

    return True


async def remove_item_from_cart(bot, guild_id: int, user_id: int, channel_id: str,
                                cart_key: str, quantity: int = 1):
    """
    Removes an item from the cart and releases reserved stock.

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param user_id: The user ID
    :param channel_id: The shop channel ID
    :param cart_key: The cart item key (item_name::option_index)
    :param quantity: The quantity to remove
    """
    cart = await get_cart(bot, guild_id, user_id, channel_id)
    if not cart:
        return

    cart_id = cart['_id']
    items = cart.get('items', {})

    if cart_key not in items:
        return

    cart_item = items[cart_key]
    item = cart_item['item']
    current_quantity = cart_item['quantity']
    item_name = item.get('name')

    # Release stock if item has stock limit
    has_stock_limit = item.get('maxStock') is not None
    if has_stock_limit:
        release_qty = min(quantity, current_quantity)
        await release_stock(bot, guild_id, channel_id, item_name, release_qty)

    now = datetime.now(timezone.utc)
    expires_at = now + timedelta(minutes=CART_TTL_MINUTES)

    if quantity >= current_quantity:
        # Remove item entirely
        await update_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name='shopCarts',
            query={'_id': cart_id},
            update_data={
                '$unset': {f'items.{cart_key}': ''},
                '$set': {
                    'updatedAt': now.isoformat(),
                    'expiresAt': expires_at.isoformat()
                }
            },
            cache_id=cart_id
        )
    else:
        # Decrement quantity
        await update_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name='shopCarts',
            query={'_id': cart_id},
            update_data={
                '$inc': {f'items.{cart_key}.quantity': -quantity},
                '$set': {
                    'updatedAt': now.isoformat(),
                    'expiresAt': expires_at.isoformat()
                }
            },
            cache_id=cart_id
        )


async def update_cart_item_quantity(bot, guild_id: int, user_id: int, channel_id: str,
                                    cart_key: str, new_quantity: int) -> Tuple[bool, str]:
    """
    Updates the quantity of an item in the cart, handling stock reservations.

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param user_id: The user ID
    :param channel_id: The shop channel ID
    :param cart_key: The cart item key (item_name::option_index)
    :param new_quantity: The new quantity

    :return: Tuple of (success, message)
    """
    cart = await get_cart(bot, guild_id, user_id, channel_id)
    if not cart:
        return False, "Cart not found."

    items = cart.get('items', {})
    if cart_key not in items:
        return False, "Item not in cart."

    cart_item = items[cart_key]
    item = cart_item['item']
    current_quantity = cart_item['quantity']
    item_name = item.get('name')

    if new_quantity <= 0:
        # Remove item entirely
        await remove_item_from_cart(bot, guild_id, user_id, channel_id, cart_key, current_quantity)
        return True, "Item removed from cart."

    quantity_diff = new_quantity - current_quantity
    has_stock_limit = item.get('maxStock') is not None

    if quantity_diff > 0:
        # Trying to add more
        if has_stock_limit:
            # Need to reserve additional stock
            success = await reserve_stock(bot, guild_id, channel_id, item_name, quantity_diff)
            if not success:
                return False, "Not enough stock available."

        # Update quantity
        now = datetime.now(timezone.utc)
        expires_at = now + timedelta(minutes=CART_TTL_MINUTES)

        cart_id = cart['_id']
        await update_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name='shopCarts',
            query={'_id': cart_id},
            update_data={
                '$set': {
                    f'items.{cart_key}.quantity': new_quantity,
                    'updatedAt': now.isoformat(),
                    'expiresAt': expires_at.isoformat()
                }
            },
            cache_id=cart_id
        )
    elif quantity_diff < 0:
        # Reducing quantity, release stock
        await remove_item_from_cart(bot, guild_id, user_id, channel_id, cart_key, abs(quantity_diff))

    return True, "Cart updated."


async def clear_cart_and_release_stock(bot, guild_id: int, user_id: int, channel_id: str):
    """
    Clears a cart and releases all reserved stock.

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param user_id: The user ID
    :param channel_id: The shop channel ID
    """
    # Fetch cart directly to avoid recursion with get_cart's expiry check
    cart_id = build_cart_id(guild_id, user_id, channel_id)
    cart = await get_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name='shopCarts',
        query={'_id': cart_id},
        cache_id=cart_id
    )
    if not cart:
        return
    items = cart.get('items', {})

    # Release all reserved stock
    for cart_key, cart_item in items.items():
        item = cart_item['item']
        quantity = cart_item['quantity']
        item_name = item.get('name')

        has_stock_limit = item.get('maxStock') is not None
        if has_stock_limit:
            await release_stock(bot, guild_id, channel_id, item_name, quantity)

    # Delete the cart
    await delete_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name='shopCarts',
        search_filter={'_id': cart_id},
        cache_id=cart_id
    )


async def finalize_cart_purchase(bot, guild_id: int, user_id: int, channel_id: str):
    """
    Finalizes a cart purchase by removing reserved stock counts and deleting the cart.

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param user_id: The user ID
    :param channel_id: The shop channel ID
    """
    cart = await get_cart(bot, guild_id, user_id, channel_id)
    if not cart:
        return

    cart_id = cart['_id']
    items = cart.get('items', {})

    # Finalize stock (remove from reserved counts)
    for cart_key, cart_item in items.items():
        item = cart_item['item']
        quantity = cart_item['quantity']
        item_name = item.get('name')

        has_stock_limit = item.get('maxStock') is not None
        if has_stock_limit:
            await finalize_stock(bot, guild_id, channel_id, item_name, quantity)

    # Delete the cart
    await delete_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name='shopCarts',
        search_filter={'_id': cart_id},
        cache_id=cart_id
    )


async def cleanup_expired_carts(bot):
    """
    Finds and cleans up all expired carts, releasing reserved stock.

    :param bot: The Discord bot instance
    """
    now = datetime.now(timezone.utc)

    # Query all expired carts directly from MongoDB (bypass cache for cleanup)
    collection = bot.gdb['shopCarts']
    cursor = collection.find({
        'expiresAt': {'$lt': now.isoformat()}
    })

    expired_carts = await cursor.to_list(length=None)

    for cart in expired_carts:
        guild_id = cart['guildId']
        channel_id = cart['channelId']
        items = cart.get('items', {})

        # Release all reserved stock
        for cart_key, cart_item in items.items():
            item = cart_item['item']
            quantity = cart_item['quantity']
            item_name = item.get('name')

            has_stock_limit = item.get('maxStock') is not None
            if has_stock_limit:
                await release_stock(bot, guild_id, channel_id, item_name, quantity)

        # Delete the cart
        cart_id = cart['_id']
        await delete_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name='shopCarts',
            search_filter={'_id': cart_id},
            cache_id=cart_id
        )

    if expired_carts:
        logger.info(f"Cleaned up {len(expired_carts)} expired shop carts.")


# ----- Container Management -----


MAX_CONTAINERS_PER_PLAYER = 50
MAX_CONTAINER_NAME_LENGTH = 50


def get_containers_sorted(character_data: dict) -> list[dict]:
    """
    Returns list of container dicts sorted by order.
    First entry is always Loose Items.

    Each dict: {'id': str|None, 'name': str, 'items': dict, 'count': int}
    """
    result = []

    # Loose items (root inventory) is always first
    loose_items = character_data['attributes'].get('inventory', {})
    result.append({
        'id': None,
        'name': 'Loose Items',
        'items': loose_items,
        'count': len(loose_items)
    })

    # Get containers sorted by order
    containers = character_data['attributes'].get('containers', {})
    sorted_containers = sorted(
        containers.items(),
        key=lambda x: x[1].get('order', 0)
    )

    for container_id, container_data in sorted_containers:
        items = container_data.get('items', {})
        result.append({
            'id': container_id,
            'name': container_data.get('name', 'Unknown'),
            'items': items,
            'count': len(items)
        })

    return result


def get_container_items(character_data: dict, container_id: str | None) -> dict:
    """
    Returns items dict for the specified container.
    container_id=None returns root inventory (Loose Items).
    """
    if container_id is None:
        return character_data['attributes'].get('inventory', {})

    containers = character_data['attributes'].get('containers', {})
    container = containers.get(container_id, {})
    return container.get('items', {})


def get_container_name(character_data: dict, container_id: str | None) -> str:
    """Returns the name of a container. None returns 'Loose Items'."""
    if container_id is None:
        return 'Loose Items'

    containers = character_data['attributes'].get('containers', {})
    container = containers.get(container_id, {})
    return container.get('name', 'Unknown')


def get_total_item_quantity(character_data: dict, item_name: str) -> int:
    """
    Returns total quantity of item across ALL containers + loose items.
    Useful for validating trades, quest requirements, etc.
    """
    item_name_lower = item_name.lower()
    total = 0

    # Check loose items
    inventory = character_data['attributes'].get('inventory', {})
    for name, qty in inventory.items():
        if name.lower() == item_name_lower:
            total += qty

    # Check all containers
    containers = character_data['attributes'].get('containers', {})
    for container_data in containers.values():
        items = container_data.get('items', {})
        for name, qty in items.items():
            if name.lower() == item_name_lower:
                total += qty

    return total


def get_item_locations(character_data: dict, item_name: str) -> list[dict]:
    """
    Returns list of dicts for everywhere this item exists.
    Each dict: {'id': str|None, 'name': str, 'quantity': int}
    """
    item_name_lower = item_name.lower()
    locations = []

    # Check loose items
    inventory = character_data['attributes'].get('inventory', {})
    for name, qty in inventory.items():
        if name.lower() == item_name_lower and qty > 0:
            locations.append({'id': None, 'name': 'Loose Items', 'quantity': qty})

    # Check all containers
    containers = character_data['attributes'].get('containers', {})
    for container_id, container_data in containers.items():
        items = container_data.get('items', {})
        for name, qty in items.items():
            if name.lower() == item_name_lower and qty > 0:
                locations.append({
                    'id': container_id,
                    'name': container_data.get('name', 'Unknown'),
                    'quantity': qty
                })

    return locations


def get_container_count(character_data: dict) -> int:
    """Returns the number of containers (excluding Loose Items)."""
    return len(character_data['attributes'].get('containers', {}))


def get_next_container_order(character_data: dict) -> int:
    """Returns the next available order value for a new container."""
    containers = character_data['attributes'].get('containers', {})
    if not containers:
        return 1
    max_order = max(c.get('order', 0) for c in containers.values())
    return max_order + 1


def container_name_exists(character_data: dict, name: str, exclude_id: str | None = None) -> bool:
    """Check if a container name already exists (case-insensitive)."""
    name_lower = name.lower()

    # Check against "Loose Items"
    if name_lower == 'loose items':
        return True

    containers = character_data['attributes'].get('containers', {})
    for container_id, container_data in containers.items():
        if exclude_id and container_id == exclude_id:
            continue
        if container_data.get('name', '').lower() == name_lower:
            return True

    return False


async def create_container(bot, player_id: int, character_id: str, name: str) -> str:
    """
    Creates a new container with the given name.
    Returns the new container's UUID.
    Raises UserFeedbackError if name already exists or max containers reached.
    """
    name = name.strip()

    if not name:
        raise UserFeedbackError('Container name cannot be empty.')

    if len(name) > MAX_CONTAINER_NAME_LENGTH:
        raise UserFeedbackError(f'Container name cannot exceed {MAX_CONTAINER_NAME_LENGTH} characters.')

    player_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': player_id}
    )
    if not player_data:
        raise UserFeedbackError('Player data not found.')

    character_data = player_data['characters'].get(character_id)
    if not character_data:
        raise UserFeedbackError('Character not found.')

    if get_container_count(character_data) >= MAX_CONTAINERS_PER_PLAYER:
        raise UserFeedbackError(f'You cannot create more than {MAX_CONTAINERS_PER_PLAYER} containers.')

    if container_name_exists(character_data, name):
        raise UserFeedbackError(f'A container named "{name}" already exists.')

    container_id = str(shortuuid.uuid())
    order = get_next_container_order(character_data)

    await update_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': player_id},
        update_data={'$set': {
            f'characters.{character_id}.attributes.containers.{container_id}': {
                'name': name,
                'order': order,
                'items': {}
            }
        }}
    )

    return container_id


async def rename_container(bot, player_id: int, character_id: str,
                           container_id: str, new_name: str) -> None:
    """
    Renames an existing container.
    Raises UserFeedbackError if new_name already exists or container not found.
    """
    new_name = new_name.strip()

    if not new_name:
        raise UserFeedbackError('Container name cannot be empty.')

    if len(new_name) > MAX_CONTAINER_NAME_LENGTH:
        raise UserFeedbackError(f'Container name cannot exceed {MAX_CONTAINER_NAME_LENGTH} characters.')

    player_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': player_id}
    )
    if not player_data:
        raise UserFeedbackError('Player data not found.')

    character_data = player_data['characters'].get(character_id)
    if not character_data:
        raise UserFeedbackError('Character not found.')

    containers = character_data['attributes'].get('containers', {})
    if container_id not in containers:
        raise UserFeedbackError('Container not found.')

    if container_name_exists(character_data, new_name, exclude_id=container_id):
        raise UserFeedbackError(f'A container named "{new_name}" already exists.')

    await update_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': player_id},
        update_data={'$set': {f'characters.{character_id}.attributes.containers.{container_id}.name': new_name}}
    )


async def delete_container(bot, player_id: int, character_id: str,
                           container_id: str) -> int:
    """
    Deletes a container. Moves any items to root inventory.
    Returns the number of unique items moved.

    :param bot: The Discord bot instance
    :param player_id: The player's Discord ID
    :param character_id: The character's ID
    :param container_id: The container's ID to delete

    :return: Number of unique items moved to the root inventory
    """
    player_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': player_id}
    )

    if not player_data:
        raise UserFeedbackError('Player data not found.')

    character_data = player_data['characters'].get(character_id)
    if not character_data:
        raise UserFeedbackError('Character not found.')

    containers = character_data['attributes'].get('containers', {})
    if container_id not in containers:
        raise UserFeedbackError('Container not found.')

    container = containers[container_id]
    items_to_move = container.get('items', {})
    items_count = len(items_to_move)

    # Move items to root inventory
    if items_to_move:
        current_inventory = character_data['attributes'].get('inventory', {})
        # Normalize to lowercase for merging
        inventory_lower = {k.lower(): (k, v) for k, v in current_inventory.items()}

        for item_name, quantity in items_to_move.items():
            item_lower = item_name.lower()
            if item_lower in inventory_lower:
                original_name, current_qty = inventory_lower[item_lower]
                inventory_lower[item_lower] = (original_name, current_qty + quantity)
            else:
                inventory_lower[item_lower] = (titlecase(item_name), quantity)

        # Rebuild inventory with titlecase keys
        new_inventory = {name: qty for name, qty in inventory_lower.values()}

        await update_cached_data(
            bot=bot,
            mongo_database=bot.mdb,
            collection_name='characters',
            query={'_id': player_id},
            update_data={
                '$set': {f'characters.{character_id}.attributes.inventory': new_inventory},
                '$unset': {f'characters.{character_id}.attributes.containers.{container_id}': ''}
            }
        )
    else:
        await update_cached_data(
            bot=bot,
            mongo_database=bot.mdb,
            collection_name='characters',
            query={'_id': player_id},
            update_data={'$unset': {f'characters.{character_id}.attributes.containers.{container_id}': ''}}
        )

    return items_count


async def reorder_container(bot, player_id: int, character_id: str,
                            container_id: str, direction: int) -> None:
    """
    Moves container up (direction=-1) or down (direction=1) in order.
    Swaps order values with adjacent container.
    """
    player_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': player_id}
    )

    if not player_data:
        raise UserFeedbackError('Player data not found.')
    character_data = player_data['characters'].get(character_id)
    if not character_data:
        raise UserFeedbackError('Character not found.')

    containers = character_data['attributes'].get('containers', {})
    if container_id not in containers:
        raise UserFeedbackError('Container not found.')

    # Sort containers by order
    sorted_containers = sorted(containers.items(), key=lambda x: x[1].get('order', 0))

    current_index = None
    for i, (cid, _) in enumerate(sorted_containers):
        if cid == container_id:
            current_index = i
            break

    if current_index is None:
        raise UserFeedbackError('Container not found.')

    target_index = current_index + direction

    if target_index < 0 or target_index >= len(sorted_containers):
        # Already at boundary, nothing to do
        return

    # Swap order values
    current_container_id = sorted_containers[current_index][0]
    target_container_id = sorted_containers[target_index][0]

    current_order = containers[current_container_id].get('order', current_index)
    target_order = containers[target_container_id].get('order', target_index)

    await update_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': player_id},
        update_data={'$set': {
            f'characters.{character_id}.attributes.containers.{current_container_id}.order': target_order,
            f'characters.{character_id}.attributes.containers.{target_container_id}.order': current_order
        }}
    )


async def move_item_between_containers(
        bot, player_id: int, character_id: str,
        item_name: str, quantity: int,
        source_container_id: str | None,
        dest_container_id: str | None
) -> None:
    """
    Moves quantity of item from source to destination container.
    None = Loose Items (root inventory).
    Raises UserFeedbackError if insufficient quantity in source.
    """
    if source_container_id == dest_container_id:
        raise UserFeedbackError('Item is already in this container.')

    if quantity < 1:
        raise UserFeedbackError('Quantity must be at least 1.')

    player_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': player_id}
    )
    if not player_data:
        raise UserFeedbackError('Player data not found.')

    character_data = player_data['characters'].get(character_id)
    if not character_data:
        raise UserFeedbackError('Character not found.')

    item_name_lower = item_name.lower()

    # Get source items
    if source_container_id is None:
        source_items = character_data['attributes'].get('inventory', {})
        source_path = f'characters.{character_id}.attributes.inventory'
    else:
        containers = character_data['attributes'].get('containers', {})
        if source_container_id not in containers:
            raise UserFeedbackError('Source container not found.')
        source_items = containers[source_container_id].get('items', {})
        source_path = f'characters.{character_id}.attributes.containers.{source_container_id}.items'

    # Find item in source (case-insensitive)
    source_key = None
    source_qty = 0
    for key, qty in source_items.items():
        if key.lower() == item_name_lower:
            source_key = key
            source_qty = qty
            break

    if source_key is None:
        raise UserFeedbackError(f'Item "{item_name}" not found in the source container.')

    if source_qty < quantity:
        raise UserFeedbackError(f'Insufficient quantity. You have {source_qty} in this container.')

    # Get destination items
    if dest_container_id is None:
        dest_items = character_data['attributes'].get('inventory', {})
        dest_path = f'characters.{character_id}.attributes.inventory'
    else:
        containers = character_data['attributes'].get('containers', {})
        if dest_container_id not in containers:
            raise UserFeedbackError('Destination container not found.')
        dest_items = containers[dest_container_id].get('items', {})
        dest_path = f'characters.{character_id}.attributes.containers.{dest_container_id}.items'

    # Find existing item in destination (case-insensitive)
    dest_key = None
    dest_qty = 0
    for key, qty in dest_items.items():
        if key.lower() == item_name_lower:
            dest_key = key
            dest_qty = qty
            break

    # Use titlecase for the item name
    display_name = titlecase(item_name)

    # Modify source items dict (remove item)
    new_source_qty = source_qty - quantity
    if new_source_qty <= 0:
        del source_items[source_key]
    else:
        source_items[source_key] = new_source_qty

    # Modify destination items dict (add item)
    if dest_key:
        dest_items[dest_key] = dest_qty + quantity
    else:
        dest_items[display_name] = quantity

    # Update both containers at once using full path to items dict
    # This avoids dot-notation issues with item names containing dots
    await update_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': player_id},
        update_data={
            '$set': {
                source_path: source_items,
                dest_path: dest_items
            }
        }
    )


async def consume_item_from_container(
        bot, player_id: int, character_id: str,
        item_name: str, quantity: int,
        container_id: str | None
) -> None:
    """
    Removes quantity of item from specific container.
    container_id=None targets Loose Items.
    Raises UserFeedbackError if insufficient quantity.
    """
    if quantity < 1:
        raise UserFeedbackError('Quantity must be at least 1.')

    player_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': player_id}
    )
    if not player_data:
        raise UserFeedbackError('Player data not found.')

    character_data = player_data['characters'].get(character_id)
    if not character_data:
        raise UserFeedbackError('Character not found.')

    item_name_lower = item_name.lower()

    # Get container items
    if container_id is None:
        items = character_data['attributes'].get('inventory', {})
        path = f'characters.{character_id}.attributes.inventory'
    else:
        containers = character_data['attributes'].get('containers', {})
        if container_id not in containers:
            raise UserFeedbackError('Container not found.')
        items = containers[container_id].get('items', {})
        path = f'characters.{character_id}.attributes.containers.{container_id}.items'

    # Find item (case-insensitive)
    item_key = None
    current_qty = 0
    for key, qty in items.items():
        if key.lower() == item_name_lower:
            item_key = key
            current_qty = qty
            break

    if item_key is None:
        raise UserFeedbackError(f'Item "{item_name}" not found in this container.')

    if current_qty < quantity:
        raise UserFeedbackError(f'You only have {current_qty} of this item in this container.')

    new_qty = current_qty - quantity

    # Modify items dict in Python and set the entire container
    # This avoids dot-notation issues with item names containing dots
    if new_qty <= 0:
        del items[item_key]
    else:
        items[item_key] = new_qty

    await update_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name='characters',
        query={'_id': player_id},
        update_data={'$set': {path: items}}
    )


def format_inventory_by_container(character_data: dict, currency_config: dict | None = None) -> str:
    """
    Formats the full inventory grouped by container for display/printing.
    Returns a formatted string.
    """
    lines = []
    containers = get_containers_sorted(character_data)

    for container in containers:
        items = container['items']
        if not items:
            continue  # Skip empty containers in print output

        lines.append(f'**{container["name"]}**')
        for item_name, quantity in sorted(items.items()):
            lines.append(f'• {item_name}: **{quantity}**')
        lines.append('')  # Blank line between containers

    # Add currency section
    player_currency = character_data['attributes'].get('currency', {})
    if player_currency and currency_config:
        currency_lines = format_currency_display(player_currency, currency_config)
        if currency_lines:
            lines.append('**Currency**')
            for currency_line in currency_lines:
                lines.append(currency_line)

    return '\n'.join(lines) if lines else 'Inventory is empty.'
