"""Container management utilities for character inventory organization."""

import shortuuid
from titlecase import titlecase

from ReQuest.utilities.constants import CharacterFields, ContainerFields, CommonFields, DatabaseCollections
from ReQuest.utilities.currency import format_currency_display
from ReQuest.utilities.db_cache import get_cached_data, update_cached_data
from ReQuest.utilities.exceptions import UserFeedbackError

__all__ = [
    'MAX_CONTAINERS_PER_PLAYER',
    'MAX_CONTAINER_NAME_LENGTH',
    'get_containers_sorted',
    'get_container_items',
    'get_container_name',
    'get_total_item_quantity',
    'get_item_locations',
    'get_container_count',
    'get_next_container_order',
    'container_name_exists',
    'create_container',
    'rename_container',
    'delete_container',
    'reorder_container',
    'move_item_between_containers',
    'consume_item_from_container',
    'format_inventory_by_container',
]

MAX_CONTAINERS_PER_PLAYER = 50
MAX_CONTAINER_NAME_LENGTH = 50


def get_containers_sorted(character_data: dict, locale: str | None = None) -> list[dict]:
    """
    Returns list of container dicts sorted by order.
    First entry is always Loose Items.

    Each dict: {'id': str|None, 'name': str, 'items': dict, 'count': int}
    """
    from ReQuest.utilities.localizer import t, DEFAULT_LOCALE

    if locale is None:
        locale = DEFAULT_LOCALE

    result = []

    # Loose items (root inventory) is always first
    loose_items = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.INVENTORY, {})
    result.append({
        'id': None,
        'name': t(locale, 'common-label-loose-items'),
        'items': loose_items,
        'count': len(loose_items)
    })

    # Get containers sorted by order
    containers = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CONTAINERS, {})
    sorted_containers = sorted(
        containers.items(),
        key=lambda x: x[1].get(ContainerFields.ORDER, 0)
    )

    for container_id, container_data in sorted_containers:
        items = container_data.get(ContainerFields.ITEMS, {})
        result.append({
            'id': container_id,
            'name': container_data.get(ContainerFields.NAME, t(locale, 'common-label-unknown')),
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
        return character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.INVENTORY, {})

    containers = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CONTAINERS, {})
    container = containers.get(container_id, {})
    return container.get(ContainerFields.ITEMS, {})


def get_container_name(character_data: dict, container_id: str | None, locale: str | None = None) -> str:
    """Returns the name of a container. None returns 'Loose Items'."""
    from ReQuest.utilities.localizer import t, DEFAULT_LOCALE

    if locale is None:
        locale = DEFAULT_LOCALE

    if container_id is None:
        return t(locale, 'common-label-loose-items')

    containers = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CONTAINERS, {})
    container = containers.get(container_id, {})
    return container.get(ContainerFields.NAME, t(locale, 'common-label-unknown'))


def get_total_item_quantity(character_data: dict, item_name: str) -> int:
    """
    Returns total quantity of item across ALL containers + loose items.
    Useful for validating trades, quest requirements, etc.
    """
    item_name_lower = item_name.lower()
    total = 0

    # Check loose items
    inventory = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.INVENTORY, {})
    for name, qty in inventory.items():
        if name.lower() == item_name_lower:
            total += qty

    # Check all containers
    containers = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CONTAINERS, {})
    for container_data in containers.values():
        items = container_data.get(ContainerFields.ITEMS, {})
        for name, qty in items.items():
            if name.lower() == item_name_lower:
                total += qty

    return total


def get_item_locations(character_data: dict, item_name: str, locale: str | None = None) -> list[dict]:
    """
    Returns list of dicts for everywhere this item exists.
    Each dict: {'id': str|None, 'name': str, 'quantity': int}
    """
    from ReQuest.utilities.localizer import t, DEFAULT_LOCALE

    if locale is None:
        locale = DEFAULT_LOCALE

    item_name_lower = item_name.lower()
    locations = []

    # Check loose items
    inventory = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.INVENTORY, {})
    for name, qty in inventory.items():
        if name.lower() == item_name_lower and qty > 0:
            locations.append({'id': None, 'name': t(locale, 'common-label-loose-items'), 'quantity': qty})

    # Check all containers
    containers = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CONTAINERS, {})
    for container_id, container_data in containers.items():
        items = container_data.get(ContainerFields.ITEMS, {})
        for name, qty in items.items():
            if name.lower() == item_name_lower and qty > 0:
                locations.append({
                    'id': container_id,
                    'name': container_data.get(ContainerFields.NAME, t(locale, 'common-label-unknown')),
                    'quantity': qty
                })

    return locations


def get_container_count(character_data: dict) -> int:
    """Returns the number of containers (excluding Loose Items)."""
    return len(character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CONTAINERS, {}))


def get_next_container_order(character_data: dict) -> int:
    """Returns the next available order value for a new container."""
    containers = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CONTAINERS, {})
    if not containers:
        return 1
    max_order = max(c.get(ContainerFields.ORDER, 0) for c in containers.values())
    return max_order + 1


def container_name_exists(character_data: dict, name: str, exclude_id: str | None = None,
                          locale: str | None = None) -> bool:
    """Check if a container name already exists (case-insensitive)."""
    from ReQuest.utilities.localizer import t, DEFAULT_LOCALE

    if locale is None:
        locale = DEFAULT_LOCALE

    name_lower = name.lower()

    # Check against "Loose Items"
    if name_lower == t(locale, 'common-label-loose-items').lower():
        return True

    containers = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CONTAINERS, {})
    for container_id, container_data in containers.items():
        if exclude_id and container_id == exclude_id:
            continue
        if container_data.get(ContainerFields.NAME, '').lower() == name_lower:
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
        raise UserFeedbackError('Container name cannot be empty.',
                                message_id='error-container-name-empty')

    if len(name) > MAX_CONTAINER_NAME_LENGTH:
        raise UserFeedbackError(f'Container name cannot exceed {MAX_CONTAINER_NAME_LENGTH} characters.',
                                message_id='error-container-name-too-long',
                                maxLength=str(MAX_CONTAINER_NAME_LENGTH))

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
        raise UserFeedbackError('Character not found.', message_id='error-character-not-found')

    if get_container_count(character_data) >= MAX_CONTAINERS_PER_PLAYER:
        raise UserFeedbackError(f'You cannot create more than {MAX_CONTAINERS_PER_PLAYER} containers.',
                                message_id='error-max-containers-reached',
                                maxContainers=str(MAX_CONTAINERS_PER_PLAYER))

    if container_name_exists(character_data, name):
        raise UserFeedbackError(f'A container named "{name}" already exists.',
                                message_id='error-container-name-exists', containerName=name)

    container_id = str(shortuuid.uuid())
    order = get_next_container_order(character_data)

    await update_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name=DatabaseCollections.CHARACTERS,
        query={CommonFields.ID: player_id},
        update_data={'$set': {
            f'{CharacterFields.CHARACTERS}.{character_id}'
            f'.{CharacterFields.ATTRIBUTES}.{CharacterFields.CONTAINERS}'
            f'.{container_id}': {
                ContainerFields.NAME: name,
                ContainerFields.ORDER: order,
                ContainerFields.ITEMS: {}
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
        raise UserFeedbackError('Container name cannot be empty.',
                                message_id='error-container-name-empty')

    if len(new_name) > MAX_CONTAINER_NAME_LENGTH:
        raise UserFeedbackError(f'Container name cannot exceed {MAX_CONTAINER_NAME_LENGTH} characters.',
                                message_id='error-container-name-too-long',
                                maxLength=str(MAX_CONTAINER_NAME_LENGTH))

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
        raise UserFeedbackError('Character not found.', message_id='error-character-not-found')

    containers = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CONTAINERS, {})
    if container_id not in containers:
        raise UserFeedbackError('Container not found.', message_id='error-container-not-found')

    if container_name_exists(character_data, new_name, exclude_id=container_id):
        raise UserFeedbackError(f'A container named "{new_name}" already exists.',
                                message_id='error-container-name-exists', containerName=new_name)

    await update_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name=DatabaseCollections.CHARACTERS,
        query={CommonFields.ID: player_id},
        update_data={'$set': {
            f'{CharacterFields.CHARACTERS}.{character_id}'
            f'.{CharacterFields.ATTRIBUTES}.{CharacterFields.CONTAINERS}'
            f'.{container_id}.{ContainerFields.NAME}': new_name
        }}
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
        collection_name=DatabaseCollections.CHARACTERS,
        query={CommonFields.ID: player_id}
    )

    if not player_data:
        raise UserFeedbackError('Player data not found.', message_id='error-player-not-found')

    character_data = player_data[CharacterFields.CHARACTERS].get(character_id)
    if not character_data:
        raise UserFeedbackError('Character not found.', message_id='error-character-not-found')

    containers = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CONTAINERS, {})
    if container_id not in containers:
        raise UserFeedbackError('Container not found.', message_id='error-container-not-found')

    container = containers[container_id]
    items_to_move = container.get(ContainerFields.ITEMS, {})
    items_count = len(items_to_move)

    # Move items to root inventory
    if items_to_move:
        current_inventory = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.INVENTORY, {})
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
            collection_name=DatabaseCollections.CHARACTERS,
            query={CommonFields.ID: player_id},
            update_data={
                '$set': {
                    f'{CharacterFields.CHARACTERS}.{character_id}'
                    f'.{CharacterFields.ATTRIBUTES}.{CharacterFields.INVENTORY}': new_inventory
                },
                '$unset': {
                    f'{CharacterFields.CHARACTERS}.{character_id}'
                    f'.{CharacterFields.ATTRIBUTES}.{CharacterFields.CONTAINERS}'
                    f'.{container_id}': ''
                }
            }
        )
    else:
        await update_cached_data(
            bot=bot,
            mongo_database=bot.mdb,
            collection_name=DatabaseCollections.CHARACTERS,
            query={CommonFields.ID: player_id},
            update_data={'$unset': {
                f'{CharacterFields.CHARACTERS}.{character_id}'
                f'.{CharacterFields.ATTRIBUTES}.{CharacterFields.CONTAINERS}'
                f'.{container_id}': ''
            }}
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
        collection_name=DatabaseCollections.CHARACTERS,
        query={CommonFields.ID: player_id}
    )

    if not player_data:
        raise UserFeedbackError('Player data not found.', message_id='error-player-not-found')
    character_data = player_data[CharacterFields.CHARACTERS].get(character_id)
    if not character_data:
        raise UserFeedbackError('Character not found.', message_id='error-character-not-found')

    containers = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CONTAINERS, {})
    if container_id not in containers:
        raise UserFeedbackError('Container not found.', message_id='error-container-not-found')

    # Sort containers by order
    sorted_containers = sorted(containers.items(), key=lambda x: x[1].get(ContainerFields.ORDER, 0))

    current_index = None
    for i, (cid, _) in enumerate(sorted_containers):
        if cid == container_id:
            current_index = i
            break

    if current_index is None:
        raise UserFeedbackError('Container not found.', message_id='error-container-not-found')

    target_index = current_index + direction

    if target_index < 0 or target_index >= len(sorted_containers):
        # Already at boundary, nothing to do
        return

    # Swap order values
    current_container_id = sorted_containers[current_index][0]
    target_container_id = sorted_containers[target_index][0]

    current_order = containers[current_container_id].get(ContainerFields.ORDER, current_index)
    target_order = containers[target_container_id].get(ContainerFields.ORDER, target_index)

    await update_cached_data(
        bot=bot,
        mongo_database=bot.mdb,
        collection_name=DatabaseCollections.CHARACTERS,
        query={CommonFields.ID: player_id},
        update_data={'$set': {
            f'{CharacterFields.CHARACTERS}.{character_id}'
            f'.{CharacterFields.ATTRIBUTES}.{CharacterFields.CONTAINERS}'
            f'.{current_container_id}.{ContainerFields.ORDER}': target_order,
            f'{CharacterFields.CHARACTERS}.{character_id}'
            f'.{CharacterFields.ATTRIBUTES}.{CharacterFields.CONTAINERS}'
            f'.{target_container_id}.{ContainerFields.ORDER}': current_order
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
        raise UserFeedbackError('Item is already in this container.',
                                message_id='error-item-already-in-container')

    if quantity < 1:
        raise UserFeedbackError('Quantity must be at least 1.',
                                message_id='error-quantity-minimum')

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
        raise UserFeedbackError('Character not found.', message_id='error-character-not-found')

    item_name_lower = item_name.lower()

    # Get source items
    if source_container_id is None:
        source_items = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.INVENTORY, {})
        source_path = (
            f'{CharacterFields.CHARACTERS}.{character_id}'
            f'.{CharacterFields.ATTRIBUTES}.{CharacterFields.INVENTORY}'
        )
    else:
        containers = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CONTAINERS, {})
        if source_container_id not in containers:
            raise UserFeedbackError('Source container not found.',
                                    message_id='error-source-container-not-found')
        source_items = containers[source_container_id].get(ContainerFields.ITEMS, {})
        source_path = (
            f'{CharacterFields.CHARACTERS}.{character_id}'
            f'.{CharacterFields.ATTRIBUTES}.{CharacterFields.CONTAINERS}'
            f'.{source_container_id}.{ContainerFields.ITEMS}'
        )

    # Find item in source (case-insensitive)
    source_key = None
    source_qty = 0
    for key, qty in source_items.items():
        if key.lower() == item_name_lower:
            source_key = key
            source_qty = qty
            break

    if source_key is None:
        raise UserFeedbackError(f'Item "{item_name}" not found in the source container.',
                                message_id='error-item-not-in-source', itemName=item_name)

    if source_qty < quantity:
        raise UserFeedbackError(f'Insufficient quantity. You have {source_qty} in this container.',
                                message_id='error-insufficient-quantity-in-container',
                                available=str(source_qty))

    # Get destination items
    if dest_container_id is None:
        dest_items = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.INVENTORY, {})
        dest_path = (
            f'{CharacterFields.CHARACTERS}.{character_id}'
            f'.{CharacterFields.ATTRIBUTES}.{CharacterFields.INVENTORY}'
        )
    else:
        containers = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CONTAINERS, {})
        if dest_container_id not in containers:
            raise UserFeedbackError('Destination container not found.',
                                    message_id='error-dest-container-not-found')
        dest_items = containers[dest_container_id].get(ContainerFields.ITEMS, {})
        dest_path = (
            f'{CharacterFields.CHARACTERS}.{character_id}'
            f'.{CharacterFields.ATTRIBUTES}.{CharacterFields.CONTAINERS}'
            f'.{dest_container_id}.{ContainerFields.ITEMS}'
        )

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
        collection_name=DatabaseCollections.CHARACTERS,
        query={CommonFields.ID: player_id},
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
        raise UserFeedbackError('Quantity must be at least 1.',
                                message_id='error-quantity-minimum')

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
        raise UserFeedbackError('Character not found.', message_id='error-character-not-found')

    item_name_lower = item_name.lower()

    # Get container items
    if container_id is None:
        items = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.INVENTORY, {})
        path = (
            f'{CharacterFields.CHARACTERS}.{character_id}'
            f'.{CharacterFields.ATTRIBUTES}.{CharacterFields.INVENTORY}'
        )
    else:
        containers = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CONTAINERS, {})
        if container_id not in containers:
            raise UserFeedbackError('Container not found.', message_id='error-container-not-found')
        items = containers[container_id].get(ContainerFields.ITEMS, {})
        path = (
            f'{CharacterFields.CHARACTERS}.{character_id}'
            f'.{CharacterFields.ATTRIBUTES}.{CharacterFields.CONTAINERS}'
            f'.{container_id}.{ContainerFields.ITEMS}'
        )

    # Find item (case-insensitive)
    item_key = None
    current_qty = 0
    for key, qty in items.items():
        if key.lower() == item_name_lower:
            item_key = key
            current_qty = qty
            break

    if item_key is None:
        raise UserFeedbackError(f'Item "{item_name}" not found in this container.',
                                message_id='error-item-not-in-container', itemName=item_name)

    if current_qty < quantity:
        raise UserFeedbackError(f'You only have {current_qty} of this item in this container.',
                                message_id='error-insufficient-quantity-consume',
                                available=str(current_qty))

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
        collection_name=DatabaseCollections.CHARACTERS,
        query={CommonFields.ID: player_id},
        update_data={'$set': {path: items}}
    )


def format_inventory_by_container(character_data: dict, currency_config: dict | None = None,
                                   locale: str | None = None) -> str:
    """
    Formats the full inventory grouped by container for display/printing.
    Returns a formatted string.
    """
    from ReQuest.utilities.localizer import t, DEFAULT_LOCALE

    if locale is None:
        locale = DEFAULT_LOCALE

    lines = []
    containers = get_containers_sorted(character_data, locale=locale)

    for container in containers:
        items = container['items']
        if not items:
            continue  # Skip empty containers in print output

        lines.append(f'**{container["name"]}**')
        for item_name, quantity in sorted(items.items()):
            lines.append(f'• {item_name}: **{quantity}**')
        lines.append('')  # Blank line between containers

    # Add currency section
    player_currency = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CURRENCY, {})
    if player_currency and currency_config:
        currency_lines = format_currency_display(player_currency, currency_config)
        if currency_lines:
            lines.append(f'**{t(locale, "common-label-currency")}**')
            for currency_line in currency_lines:
                lines.append(currency_line)

    return '\n'.join(lines) if lines else t(locale, 'common-label-inventory-empty')
