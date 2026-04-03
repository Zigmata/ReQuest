import logging

from titlecase import titlecase

from ReQuest.utilities.constants import CharacterFields, CommonFields, DatabaseCollections, CurrencyFields
from ReQuest.utilities.exceptions import UserFeedbackError, log_exception
from ReQuest.utilities.db_cache import get_cached_data, update_cached_data
from ReQuest.utilities.currency import find_currency_or_denomination, get_denomination_map, normalize_currency_keys, \
    check_sufficient_funds
from ReQuest.utilities.containers import get_total_item_quantity, get_item_locations

logger = logging.getLogger(__name__)

__all__ = [
    'trade_currency',
    'trade_item',
    'update_character_inventory',
    'update_character_experience',
    'apply_item_change_local',
    'apply_currency_change_local',
]


async def trade_currency(interaction, currency_name, amount, sending_member_id, receiving_member_id,
                         guild_id):
    bot = interaction.client
    currency_name = currency_name.lower()
    sender_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name=DatabaseCollections.CHARACTERS,
        query={CommonFields.ID: sending_member_id}
    )
    receiver_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name=DatabaseCollections.CHARACTERS,
        query={CommonFields.ID: receiving_member_id}
    )
    sender_character_id = sender_data[CharacterFields.ACTIVE_CHARACTERS][str(guild_id)]
    sender_currency = (
        sender_data[CharacterFields.CHARACTERS][sender_character_id][CharacterFields.ATTRIBUTES]
        .get(CharacterFields.CURRENCY, {})
    )
    receiver_character_id = receiver_data[CharacterFields.ACTIVE_CHARACTERS][str(guild_id)]

    currency_config = await get_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name=DatabaseCollections.CURRENCY,
        query={CommonFields.ID: guild_id}
    )

    if not currency_config:
        raise Exception('Currency definition not found')

    can_afford, message = check_sufficient_funds(sender_currency, currency_config, currency_name, amount)
    if not can_afford:
        raise UserFeedbackError(f'The transaction cannot be completed:\n{message}',
                                message_id='error-transaction-cannot-complete', reason=message)

    await update_character_inventory(interaction, sending_member_id, sender_character_id, currency_name, -amount)
    await update_character_inventory(interaction, receiving_member_id, receiver_character_id, currency_name, amount)

    updated_sender_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name=DatabaseCollections.CHARACTERS,
        query={CommonFields.ID: sending_member_id}
    )
    updated_receiver_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name=DatabaseCollections.CHARACTERS,
        query={CommonFields.ID: receiving_member_id}
    )
    updated_sender_currency = (
        updated_sender_data[CharacterFields.CHARACTERS][sender_character_id][CharacterFields.ATTRIBUTES]
        .get(CharacterFields.CURRENCY)
    )
    updated_receiver_currency = (
        updated_receiver_data[CharacterFields.CHARACTERS][receiver_character_id][CharacterFields.ATTRIBUTES]
        .get(CharacterFields.CURRENCY)
    )

    return updated_sender_currency, updated_receiver_currency


async def trade_item(bot, item_name, quantity, sending_member_id, receiving_member_id, guild_id):
    # Normalize the item name for consistent storage and comparison
    normalized_item_name = item_name.lower()

    # Fetch sending character
    sender_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name=DatabaseCollections.CHARACTERS,
        query={CommonFields.ID: sending_member_id}
    )
    sender_character_id = sender_data[CharacterFields.ACTIVE_CHARACTERS][str(guild_id)]
    sender_character = sender_data[CharacterFields.CHARACTERS][sender_character_id]

    # Fetch receiving character
    receiver_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name=DatabaseCollections.CHARACTERS,
        query={CommonFields.ID: receiving_member_id}
    )
    receiver_character_id = receiver_data[CharacterFields.ACTIVE_CHARACTERS][str(guild_id)]
    receiver_character = receiver_data[CharacterFields.CHARACTERS][receiver_character_id]

    # Check if sender has enough items across all containers + loose items
    quantity_owned = get_total_item_quantity(sender_character, item_name)
    if quantity_owned < quantity:
        raise UserFeedbackError(f'You have {quantity_owned}x {titlecase(normalized_item_name)} but are trying to give '
                                f'{quantity}.',
                                message_id='error-insufficient-item-trade',
                                itemName=titlecase(normalized_item_name), owned=str(quantity_owned),
                                quantity=str(quantity))

    # Get item locations and remove items (loose items first, then containers)
    locations = get_item_locations(sender_character, item_name)
    # Sort so loose items (id=None) come first
    locations.sort(key=lambda x: (x['id'] is not None, x['name']))

    remaining_to_remove = quantity
    for loc in locations:
        if remaining_to_remove <= 0:
            break

        container_id = loc[CommonFields.ID]
        loc_qty = loc[CommonFields.QUANTITY]
        remove_from_here = min(loc_qty, remaining_to_remove)

        if container_id is None:
            # Remove from loose items
            inventory = sender_character[CharacterFields.ATTRIBUTES].get(CharacterFields.INVENTORY, {})
            for key in list(inventory.keys()):
                if key.lower() == normalized_item_name:
                    inventory[key] -= remove_from_here
                    if inventory[key] <= 0:
                        del inventory[key]
                    break
        else:
            # Remove from container
            container_items = (
                sender_character[CharacterFields.ATTRIBUTES][CharacterFields.CONTAINERS][container_id]
                .get(CharacterFields.ITEMS, {})
            )
            for key in list(container_items.keys()):
                if key.lower() == normalized_item_name:
                    container_items[key] -= remove_from_here
                    if container_items[key] <= 0:
                        del container_items[key]
                    break

        remaining_to_remove -= remove_from_here

    # Add items to receiver's loose inventory
    receiver_inventory = receiver_character[CharacterFields.ATTRIBUTES].get(CharacterFields.INVENTORY, {})
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
        f'{CharacterFields.CHARACTERS}.{sender_character_id}.{CharacterFields.ATTRIBUTES}'
        f'.{CharacterFields.INVENTORY}': sender_character[CharacterFields.ATTRIBUTES]
        .get(CharacterFields.INVENTORY, {})
    }
    # Include container updates if containers exist
    if sender_character[CharacterFields.ATTRIBUTES].get(CharacterFields.CONTAINERS):
        sender_update[
            f'{CharacterFields.CHARACTERS}.{sender_character_id}'
            f'.{CharacterFields.ATTRIBUTES}.{CharacterFields.CONTAINERS}'
        ] = sender_character[CharacterFields.ATTRIBUTES][CharacterFields.CONTAINERS]

    await update_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name=DatabaseCollections.CHARACTERS,
        query={CommonFields.ID: sending_member_id},
        update_data={'$set': sender_update}
    )

    # Update receiver's inventory
    await update_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name=DatabaseCollections.CHARACTERS,
        query={CommonFields.ID: receiving_member_id},
        update_data={'$set': {
            f'{CharacterFields.CHARACTERS}.{receiver_character_id}'
            f'.{CharacterFields.ATTRIBUTES}.{CharacterFields.INVENTORY}': receiver_inventory
        }}
    )


async def update_character_inventory(interaction, player_id: int, character_id: str,
                                     item_name: str, quantity: float, raise_on_error: bool = False):
    try:
        bot = interaction.client
        normalized_item_name = item_name.lower()

        player_data = await get_cached_data(
            bot=bot,
            mongo_database=bot.mdb,
            collection_name=DatabaseCollections.CHARACTERS,
            query={CommonFields.ID: player_id}
        )
        if not player_data:
            raise UserFeedbackError('Player data not found.', message_id='error-player-not-found')

        character_data = player_data[CharacterFields.CHARACTERS].get(character_id)
        if not character_data:
            raise UserFeedbackError('Character data not found.', message_id='error-character-not-found')

        currency_query = await get_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name=DatabaseCollections.CURRENCY,
            query={CommonFields.ID: interaction.guild_id}
        )

        is_currency, currency_parent_name = None, None
        if currency_query:
            is_currency, currency_parent_name = find_currency_or_denomination(currency_query, normalized_item_name)

        if is_currency:
            denomination_map, _ = get_denomination_map(currency_query, normalized_item_name)
            if not denomination_map:
                raise UserFeedbackError(f"Currency {item_name} could not be processed.",
                                        message_id='error-currency-process-failed', currencyName=item_name)

            min_value = min(denomination_map.values())
            if min_value <= 0:
                raise Exception(f"Currency {currency_parent_name} has a non-positive denomination value.")

            character_currency = normalize_currency_keys(
                character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CURRENCY, {})
            )

            total_in_lowest_denom = 0.0
            for denom, value in denomination_map.items():
                total_in_lowest_denom += character_currency.get(denom, 0) * (value / min_value)

            change_value_in_lowest = quantity * (denomination_map[item_name.lower()] / min_value)

            total_in_lowest_denom += change_value_in_lowest

            tolerance = 1e-9
            if total_in_lowest_denom < -tolerance:
                raise UserFeedbackError("Insufficient funds to cover this transaction.",
                                        message_id='error-insufficient-funds-transaction')

            if total_in_lowest_denom < 0:
                total_in_lowest_denom = 0

            new_character_currency = {}
            for denom, value in sorted(denomination_map.items(), key=lambda x: -x[1]):
                denom_value_in_lowest = value / min_value
                if total_in_lowest_denom + tolerance >= denom_value_in_lowest:
                    qty = int(total_in_lowest_denom // denom_value_in_lowest)
                    new_character_currency[denom] = qty
                    total_in_lowest_denom %= denom_value_in_lowest

            final_wallet = normalize_currency_keys(
                character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CURRENCY, {})
            )

            for denom_name in denomination_map.keys():
                if denom_name in new_character_currency:
                    final_wallet[denom_name] = new_character_currency[denom_name]
                elif denom_name in final_wallet:
                    del final_wallet[denom_name]

            character_currency_db = {titlecase(k): v for k, v in final_wallet.items() if v > 0}

            await update_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name=DatabaseCollections.CHARACTERS,
                query={CommonFields.ID: player_id},
                update_data={'$set': {
                    f'{CharacterFields.CHARACTERS}.{character_id}'
                    f'.{CharacterFields.ATTRIBUTES}.{CharacterFields.CURRENCY}': character_currency_db
                }}
            )
        else:
            character_inventory = normalize_currency_keys(
                character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.INVENTORY, {})
            )
            found_key = normalized_item_name

            if found_key in character_inventory:
                character_inventory[found_key] += int(quantity)
                if character_inventory[found_key] <= 0:
                    del character_inventory[found_key]
            elif quantity > 0:
                character_inventory[normalized_item_name] = int(quantity)
            elif quantity < 0:
                raise UserFeedbackError(f"Insufficient item(s): {titlecase(item_name)}",
                                        message_id='error-insufficient-items', itemName=titlecase(item_name))

            inventory_for_db = {titlecase(k): v for k, v in character_inventory.items()}

            await update_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name=DatabaseCollections.CHARACTERS,
                query={CommonFields.ID: player_id},
                update_data={'$set': {
                    f'{CharacterFields.CHARACTERS}.{character_id}'
                    f'.{CharacterFields.ATTRIBUTES}.{CharacterFields.INVENTORY}': inventory_for_db
                }}
            )
    except Exception as e:
        if raise_on_error:
            raise
        await log_exception(e, interaction)


async def update_character_experience(interaction, player_id: int, character_id: str,
                                      amount: int):
    bot = interaction.client
    try:
        player_data = await get_cached_data(
            bot=bot,
            mongo_database=bot.mdb,
            collection_name=DatabaseCollections.CHARACTERS,
            query={CommonFields.ID: player_id}
        )
        if not player_data:
            raise UserFeedbackError('Player data not found.', message_id='error-player-not-found')

        character_data = player_data[CharacterFields.CHARACTERS].get(character_id)
        if not character_data:
            raise UserFeedbackError('Character data not found.', message_id='error-character-not-found')

        if character_data[CharacterFields.ATTRIBUTES][CharacterFields.EXPERIENCE]:
            character_data[CharacterFields.ATTRIBUTES][CharacterFields.EXPERIENCE] += amount
        else:
            character_data[CharacterFields.ATTRIBUTES][CharacterFields.EXPERIENCE] = amount

        await update_cached_data(
            bot=bot,
            mongo_database=bot.mdb,
            collection_name=DatabaseCollections.CHARACTERS,
            query={CommonFields.ID: player_id},
            update_data={'$set': {f'{CharacterFields.CHARACTERS}.{character_id}': character_data}}
        )
    except Exception as e:
        await log_exception(e, interaction)


def apply_item_change_local(character_data: dict, item_name: str, quantity: int) -> dict:
    """
    Applies an item change to a character's inventory dict.

    :param character_data: The character's data dictionary
    :param item_name: The name of the item to add or remove
    :param quantity: The quantity to add (positive) or remove (negative)

    :return: The updated character data dictionary
    """
    inventory = normalize_currency_keys(character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.INVENTORY, {}))
    item_name_lower = item_name.lower()

    found_key = item_name_lower

    if found_key in inventory:
        inventory[found_key] += int(quantity)
        if inventory[found_key] <= 0:
            del inventory[found_key]
    elif quantity > 0:
        inventory[item_name.lower()] = int(quantity)
    elif quantity < 0:
        raise UserFeedbackError(f"Insufficient item(s): {titlecase(item_name)}",
                                message_id='error-insufficient-items', itemName=titlecase(item_name))

    character_data[CharacterFields.ATTRIBUTES][CharacterFields.INVENTORY] = {
        titlecase(k): v for k, v in inventory.items()
    }
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
        raise UserFeedbackError(f'{item_name} is not a valid currency.',
                                message_id='error-invalid-currency', itemName=item_name)

    denomination_map, _ = get_denomination_map(currency_config, normalized_item_name)
    if not denomination_map:
        raise UserFeedbackError(f'Currency {item_name} could not be processed.',
                                message_id='error-currency-process-failed', currencyName=item_name)

    min_value = min(denomination_map.values())
    if min_value <= 0:
        raise Exception(f'Currency {currency_parent_name} has a non-positive denomination value.')

    character_currency = normalize_currency_keys(
        character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CURRENCY, {})
    )

    total_in_lowest_denom = 0.0
    for denom, value in denomination_map.items():
        total_in_lowest_denom += character_currency.get(denom, 0) * (value / min_value)

    change_value_in_lowest = quantity * (denomination_map[item_name.lower()] / min_value)

    total_in_lowest_denom += change_value_in_lowest

    tolerance = 1e-9
    if total_in_lowest_denom < -tolerance:
        raise UserFeedbackError('Insufficient funds for this transaction.',
                                message_id='error-insufficient-funds-for-transaction')
    if total_in_lowest_denom < 0:
        total_in_lowest_denom = 0.0

    new_character_currency = {}
    for denom, value in sorted(denomination_map.items(), key=lambda x: -x[1]):
        denom_value_in_lowest = value / min_value
        if total_in_lowest_denom + tolerance >= denom_value_in_lowest:
            qty = int(total_in_lowest_denom // denom_value_in_lowest)
            new_character_currency[denom] = qty
            total_in_lowest_denom %= denom_value_in_lowest

    final_wallet = normalize_currency_keys(
        character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CURRENCY, {})
    )
    for denom_name in denomination_map.keys():
        if denom_name in new_character_currency:
            final_wallet[denom_name] = new_character_currency[denom_name]
        elif denom_name in final_wallet:
            del final_wallet[denom_name]

    character_data[CharacterFields.ATTRIBUTES][CharacterFields.CURRENCY] = {
        titlecase(k): v for k, v in final_wallet.items() if v > 0
    }
    return character_data
