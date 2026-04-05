import logging
from datetime import datetime, timezone, timedelta
from typing import Tuple

import discord

from ReQuest.utilities.constants import ShopFields, CartFields, CommonFields, DatabaseCollections, RestockFields
from ReQuest.utilities.db_cache import (
    get_cached_data, update_cached_data, delete_cached_data, build_cache_key, encode_mongo_key
)

logger = logging.getLogger(__name__)

__all__ = [
    'get_shop_channel',
    'get_item_stock',
    'get_shop_stock',
    'initialize_item_stock',
    'remove_item_stock_limit',
    'reserve_stock',
    'release_stock',
    'finalize_stock',
    'set_available_stock',
    'increment_available_stock',
    'update_last_restock',
    'get_last_restock',
    'build_cart_id',
    'get_cart',
    'get_or_create_cart',
    'add_item_to_cart',
    'remove_item_from_cart',
    'update_cart_item_quantity',
    'clear_cart_and_release_stock',
    'finalize_cart_purchase',
    'cleanup_expired_carts',
]

# ----- Shop Cart Management -----

CART_TTL_MINUTES = 10


async def get_shop_channel(bot, guild_id: int, channel_id: str) -> discord.abc.Messageable | None:
    """
    Retrieves a shop channel, handling both text channels and forum threads.

    Discord threads require different lookup methods than regular channels.
    This helper provides unified access for both channel types.

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param channel_id: The channel or thread ID (as string)
    :return: The channel/thread object or None if not found
    """
    guild = bot.get_guild(guild_id)
    if not guild:
        return None

    # Try direct channel lookup first (works for text channels and cached threads)
    channel = guild.get_channel(int(channel_id))
    if channel:
        return channel

    # Try to find as thread in text channels
    for text_channel in guild.text_channels:
        thread = text_channel.get_thread(int(channel_id))
        if thread:
            return thread

    # Try to find as thread in forum channels
    for forum in guild.forums:
        thread = forum.get_thread(int(channel_id))
        if thread:
            return thread

    # Fall back to fetch if not found in cache
    try:
        channel = await bot.fetch_channel(int(channel_id))
        return channel
    except discord.NotFound:
        return None
    except discord.Forbidden:
        logger.warning(f"No permission to access channel {channel_id}")
        return None
    except Exception as e:
        logger.warning(f"Failed to fetch channel {channel_id}: {e}")
        return None


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
        collection_name=DatabaseCollections.SHOP_STOCK,
        query={CommonFields.ID: guild_id}
    )

    if not stock_data:
        return None

    shops = stock_data.get(ShopFields.SHOPS, {})
    shop_stock = shops.get(str(channel_id), {})
    item_stock = shop_stock.get(encode_mongo_key(item_name))

    if item_stock is None:
        return None

    return {
        ShopFields.AVAILABLE: item_stock.get(ShopFields.AVAILABLE, 0),
        ShopFields.RESERVED: item_stock.get(ShopFields.RESERVED, 0)
    }


async def get_shop_stock(bot, guild_id: int, channel_id: str) -> dict:
    """
    Retrieves all stock information for a shop.

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param channel_id: The shop channel ID

    :return: Dict mapping encoded item names (via encode_mongo_key) to their stock info, empty dict if no stock limits
    """
    stock_data = await get_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name=DatabaseCollections.SHOP_STOCK,
        query={CommonFields.ID: guild_id}
    )

    if not stock_data:
        return {}

    shops = stock_data.get(ShopFields.SHOPS, {})
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
        collection_name=DatabaseCollections.SHOP_STOCK,
        query={CommonFields.ID: guild_id},
        update_data={
            '$set': {
                f'{ShopFields.SHOPS}.{channel_id}.{encode_mongo_key(item_name)}': {
                    ShopFields.AVAILABLE: current_stock,
                    ShopFields.RESERVED: 0
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
        collection_name=DatabaseCollections.SHOP_STOCK,
        query={CommonFields.ID: guild_id},
        update_data={
            '$unset': {
                f'{ShopFields.SHOPS}.{channel_id}.{encode_mongo_key(item_name)}': ''
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
    collection = bot.gdb[DatabaseCollections.SHOP_STOCK]

    encoded_name = encode_mongo_key(item_name)
    result = await collection.find_one_and_update(
        {
            CommonFields.ID: guild_id,
            f'{ShopFields.SHOPS}.{channel_id}.{encoded_name}.{ShopFields.AVAILABLE}': {'$gte': quantity}
        },
        {
            '$inc': {
                f'{ShopFields.SHOPS}.{channel_id}.{encoded_name}.{ShopFields.AVAILABLE}': -quantity,
                f'{ShopFields.SHOPS}.{channel_id}.{encoded_name}.{ShopFields.RESERVED}': quantity
            }
        }
    )

    # Invalidate cache after update
    if result:
        cache_key = build_cache_key(bot.gdb.name, guild_id, DatabaseCollections.SHOP_STOCK)
        try:
            await bot.rdb.delete(cache_key)
        except Exception as e:
            logger.error(f"Redis delete failed: {e}")
        return True

    return False


async def release_stock(bot, guild_id: int, channel_id: str, item_name: str,
                        quantity: int = 1, max_stock: int | None = None):
    """
    Releases reserved stock back to available, capped at max_stock.

    :param bot: The Discord bot instance
    :param guild_id: The guild ID
    :param channel_id: The shop channel ID
    :param item_name: The name of the item
    :param quantity: The quantity to release
    :param max_stock: The maximum stock for this item (caps available to prevent overflow)
    """
    collection = bot.gdb[DatabaseCollections.SHOP_STOCK]
    encoded_name = encode_mongo_key(item_name)
    path = f'{ShopFields.SHOPS}.{channel_id}.{encoded_name}'

    new_available = {'$add': [f'${path}.{ShopFields.AVAILABLE}', quantity]}
    if max_stock is not None:
        new_available = {'$min': [max_stock, new_available]}

    result = await collection.update_one(
        {CommonFields.ID: guild_id, f'{path}.{ShopFields.RESERVED}': {'$exists': True}},
        [
            {
                '$set': {
                    f'{path}.{ShopFields.AVAILABLE}': new_available,
                    f'{path}.{ShopFields.RESERVED}': {
                        '$max': [0, {'$subtract': [f'${path}.{ShopFields.RESERVED}', quantity]}]
                    }
                }
            }
        ]
    )

    # Invalidate cache after update
    if result.modified_count > 0:
        cache_key = build_cache_key(bot.gdb.name, guild_id, DatabaseCollections.SHOP_STOCK)
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
    collection = bot.gdb[DatabaseCollections.SHOP_STOCK]
    encoded_name = encode_mongo_key(item_name)
    path = f'{ShopFields.SHOPS}.{channel_id}.{encoded_name}'

    result = await collection.update_one(
        {CommonFields.ID: guild_id, f'{path}.{ShopFields.RESERVED}': {'$exists': True}},
        [
            {
                '$set': {
                    f'{path}.{ShopFields.RESERVED}': {
                        '$max': [0, {'$subtract': [f'${path}.{ShopFields.RESERVED}', quantity]}]
                    }
                }
            }
        ]
    )

    # Invalidate cache after update
    if result.modified_count > 0:
        cache_key = build_cache_key(bot.gdb.name, guild_id, DatabaseCollections.SHOP_STOCK)
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
        collection_name=DatabaseCollections.SHOP_STOCK,
        query={CommonFields.ID: guild_id},
        update_data={
            '$set': {
                f'{ShopFields.SHOPS}.{channel_id}.{encode_mongo_key(item_name)}.{ShopFields.AVAILABLE}': amount
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
    collection = bot.gdb[DatabaseCollections.SHOP_STOCK]
    encoded_name = encode_mongo_key(item_name)
    path = f'{ShopFields.SHOPS}.{channel_id}.{encoded_name}'

    result = await collection.update_one(
        {CommonFields.ID: guild_id, f'{path}.{ShopFields.AVAILABLE}': {'$exists': True}},
        [
            {
                '$set': {
                    f'{path}.{ShopFields.AVAILABLE}': {
                        '$min': [max_stock, {'$add': [f'${path}.{ShopFields.AVAILABLE}', increment]}]
                    }
                }
            }
        ]
    )

    # Invalidate cache after update
    if result.modified_count > 0:
        cache_key = build_cache_key(bot.gdb.name, guild_id, DatabaseCollections.SHOP_STOCK)
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
        collection_name=DatabaseCollections.SHOP_STOCK,
        query={CommonFields.ID: guild_id},
        update_data={
            '$set': {
                f'{RestockFields.LAST_RESTOCK}.{channel_id}': timestamp
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
        collection_name=DatabaseCollections.SHOP_STOCK,
        query={CommonFields.ID: guild_id}
    )

    if not stock_data:
        return None

    return stock_data.get(RestockFields.LAST_RESTOCK, {}).get(str(channel_id))


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
        collection_name=DatabaseCollections.SHOP_CARTS,
        query={CommonFields.ID: cart_id},
        cache_id=cart_id
    )

    if not cart:
        return None

    # Check if cart has expired
    expires_at = cart.get(CartFields.EXPIRES_AT)
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
        CommonFields.ID: cart_id,
        CartFields.GUILD_ID: guild_id,
        CartFields.USER_ID: user_id,
        CartFields.CHANNEL_ID: channel_id,
        CartFields.ITEMS: {},
        CartFields.CREATED_AT: now.isoformat(),
        CartFields.UPDATED_AT: now.isoformat(),
        CartFields.EXPIRES_AT: expires_at.isoformat()
    }

    await update_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name=DatabaseCollections.SHOP_CARTS,
        query={CommonFields.ID: cart_id},
        update_data={'$set': new_cart},
        cache_id=cart_id
    )

    return new_cart


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
    item_name = item.get(CommonFields.NAME)
    cart_key = f"{encode_mongo_key(item_name)}::{option_index}"

    # Check if item has stock limit and reserve if needed
    has_stock_limit = item.get(ShopFields.MAX_STOCK) is not None
    reserved_quantity = 0
    if has_stock_limit:
        item_quantity = item.get(CommonFields.QUANTITY, 1)
        success = await reserve_stock(bot, guild_id, channel_id, item_name, item_quantity)
        if not success:
            return False
        reserved_quantity = item_quantity

    # Persist the cart entry; release stock if the write fails
    try:
        cart = await get_or_create_cart(bot, guild_id, user_id, channel_id)
        cart_id = cart[CommonFields.ID]

        now = datetime.now(timezone.utc)
        expires_at = now + timedelta(minutes=CART_TTL_MINUTES)

        # Check if item already in cart
        existing_items = cart.get(CartFields.ITEMS, {})
        if cart_key in existing_items:
            # Increment quantity
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOP_CARTS,
                query={CommonFields.ID: cart_id},
                update_data={
                    '$inc': {f'{CartFields.ITEMS}.{cart_key}.{CartFields.QUANTITY}': 1},
                    '$set': {
                        CartFields.UPDATED_AT: now.isoformat(),
                        CartFields.EXPIRES_AT: expires_at.isoformat()
                    }
                },
                cache_id=cart_id
            )
        else:
            # Add new item
            cart_item = {
                CartFields.ITEM: item,
                CartFields.QUANTITY: 1,
                CartFields.OPTION_INDEX: option_index,
                CartFields.RESERVED_AT: now.isoformat()
            }
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOP_CARTS,
                query={CommonFields.ID: cart_id},
                update_data={
                    '$set': {
                        f'{CartFields.ITEMS}.{cart_key}': cart_item,
                        CartFields.UPDATED_AT: now.isoformat(),
                        CartFields.EXPIRES_AT: expires_at.isoformat()
                    }
                },
                cache_id=cart_id
            )
    except Exception:
        if reserved_quantity > 0:
            await release_stock(bot, guild_id, channel_id, item_name, reserved_quantity)
        raise

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

    cart_id = cart[CommonFields.ID]
    items = cart.get(CartFields.ITEMS, {})

    if cart_key not in items:
        return

    cart_item = items[cart_key]
    item = cart_item[CartFields.ITEM]
    current_quantity = cart_item[CartFields.QUANTITY]
    item_name = item.get(CommonFields.NAME)

    now = datetime.now(timezone.utc)
    expires_at = now + timedelta(minutes=CART_TTL_MINUTES)

    # Update the cart first to prevent stock release without cart consistency
    if quantity >= current_quantity:
        # Remove item entirely
        await update_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name=DatabaseCollections.SHOP_CARTS,
            query={CommonFields.ID: cart_id},
            update_data={
                '$unset': {f'{CartFields.ITEMS}.{cart_key}': ''},
                '$set': {
                    CartFields.UPDATED_AT: now.isoformat(),
                    CartFields.EXPIRES_AT: expires_at.isoformat()
                }
            },
            cache_id=cart_id
        )
    else:
        # Decrement quantity
        await update_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name=DatabaseCollections.SHOP_CARTS,
            query={CommonFields.ID: cart_id},
            update_data={
                '$inc': {f'{CartFields.ITEMS}.{cart_key}.{CartFields.QUANTITY}': -quantity},
                '$set': {
                    CartFields.UPDATED_AT: now.isoformat(),
                    CartFields.EXPIRES_AT: expires_at.isoformat()
                }
            },
            cache_id=cart_id
        )

    # Release stock after successful cart update
    max_stock = item.get(ShopFields.MAX_STOCK)
    if max_stock is not None:
        item_quantity = item.get(CommonFields.QUANTITY, 1)
        release_qty = min(quantity, current_quantity) * item_quantity
        await release_stock(bot, guild_id, channel_id, item_name, release_qty, max_stock)


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
    from ReQuest.utilities.localizer import t, DEFAULT_LOCALE

    cart = await get_cart(bot, guild_id, user_id, channel_id)
    if not cart:
        return False, t(DEFAULT_LOCALE, 'error-cart-not-found')

    items = cart.get(CartFields.ITEMS, {})
    if cart_key not in items:
        return False, t(DEFAULT_LOCALE, 'error-item-not-in-cart')

    cart_item = items[cart_key]
    item = cart_item[CartFields.ITEM]
    current_quantity = cart_item[CartFields.QUANTITY]
    item_name = item.get(CommonFields.NAME)

    if new_quantity <= 0:
        # Remove item entirely
        await remove_item_from_cart(bot, guild_id, user_id, channel_id, cart_key, current_quantity)
        return True, t(DEFAULT_LOCALE, 'shop-msg-item-removed')

    quantity_diff = new_quantity - current_quantity
    has_stock_limit = item.get(ShopFields.MAX_STOCK) is not None

    if quantity_diff > 0:
        # Trying to add more
        reserved_quantity = 0
        if has_stock_limit:
            # Need to reserve additional stock
            item_quantity = item.get(CommonFields.QUANTITY, 1)
            reserved_quantity = quantity_diff * item_quantity
            success = await reserve_stock(bot, guild_id, channel_id, item_name, reserved_quantity)
            if not success:
                return False, t(DEFAULT_LOCALE, 'error-not-enough-stock')

        # Update quantity; release stock if the write fails
        try:
            now = datetime.now(timezone.utc)
            expires_at = now + timedelta(minutes=CART_TTL_MINUTES)

            cart_id = cart[CommonFields.ID]
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOP_CARTS,
                query={CommonFields.ID: cart_id},
                update_data={
                    '$set': {
                        f'{CartFields.ITEMS}.{cart_key}.{CartFields.QUANTITY}': new_quantity,
                        CartFields.UPDATED_AT: now.isoformat(),
                        CartFields.EXPIRES_AT: expires_at.isoformat()
                    }
                },
                cache_id=cart_id
            )
        except Exception:
            if reserved_quantity > 0:
                await release_stock(bot, guild_id, channel_id, item_name, reserved_quantity)
            raise
    elif quantity_diff < 0:
        # Reducing quantity, release stock
        await remove_item_from_cart(bot, guild_id, user_id, channel_id, cart_key, abs(quantity_diff))

    return True, t(DEFAULT_LOCALE, 'shop-msg-cart-updated')


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
        collection_name=DatabaseCollections.SHOP_CARTS,
        query={CommonFields.ID: cart_id},
        cache_id=cart_id
    )
    if not cart:
        return
    items = cart.get(CartFields.ITEMS, {})

    # Delete the cart first to prevent inconsistency if stock release fails
    await delete_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name=DatabaseCollections.SHOP_CARTS,
        search_filter={CommonFields.ID: cart_id},
        cache_id=cart_id
    )

    # Release all reserved stock (cart already deleted — log failures so leaked reservations are visible)
    for cart_key, cart_item in items.items():
        item = cart_item[CartFields.ITEM]
        quantity = cart_item[CartFields.QUANTITY]
        item_name = item.get(CommonFields.NAME)

        max_stock = item.get(ShopFields.MAX_STOCK)
        if max_stock is not None:
            item_quantity = item.get(CommonFields.QUANTITY, 1)
            try:
                await release_stock(bot, guild_id, channel_id, item_name, quantity * item_quantity, max_stock)
            except Exception as e:
                logger.error(
                    f'Failed to release stock for {item_name} (qty={quantity * item_quantity}) '
                    f'in guild {guild_id}, channel {channel_id} after cart deletion: {e}'
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

    cart_id = cart[CommonFields.ID]
    items = cart.get(CartFields.ITEMS, {})

    # Delete the cart first to prevent double-finalization on retry
    await delete_cached_data(
        bot=bot,
        mongo_database=bot.gdb,
        collection_name=DatabaseCollections.SHOP_CARTS,
        search_filter={CommonFields.ID: cart_id},
        cache_id=cart_id
    )

    # Finalize stock (cart already deleted — log failures so leaked reservations are visible)
    for cart_key, cart_item in items.items():
        item = cart_item[CartFields.ITEM]
        quantity = cart_item[CartFields.QUANTITY]
        item_name = item.get(CommonFields.NAME)

        has_stock_limit = item.get(ShopFields.MAX_STOCK) is not None
        if has_stock_limit:
            item_quantity = item.get(CommonFields.QUANTITY, 1)
            try:
                await finalize_stock(bot, guild_id, channel_id, item_name, quantity * item_quantity)
            except Exception as e:
                logger.error(
                    f'Failed to finalize stock for {item_name} (qty={quantity * item_quantity}) '
                    f'in guild {guild_id}, channel {channel_id} after cart deletion: {e}'
                )


async def cleanup_expired_carts(bot):
    """
    Finds and cleans up all expired carts, releasing reserved stock.

    :param bot: The Discord bot instance
    """
    now = datetime.now(timezone.utc)

    # Query all expired carts directly from MongoDB (bypass cache for cleanup)
    collection = bot.gdb[DatabaseCollections.SHOP_CARTS]
    cursor = collection.find({
        CartFields.EXPIRES_AT: {'$lt': now.isoformat()}
    })

    expired_carts = await cursor.to_list(length=None)

    for cart in expired_carts:
        guild_id = cart[CartFields.GUILD_ID]
        channel_id = cart[CartFields.CHANNEL_ID]
        items = cart.get(CartFields.ITEMS, {})

        # Release all reserved stock
        for cart_key, cart_item in items.items():
            item = cart_item[CartFields.ITEM]
            quantity = cart_item[CartFields.QUANTITY]
            item_name = item.get(CommonFields.NAME)

            max_stock = item.get(ShopFields.MAX_STOCK)
            if max_stock is not None:
                item_quantity = item.get(CommonFields.QUANTITY, 1)
                await release_stock(bot, guild_id, channel_id, item_name, quantity * item_quantity, max_stock)

        # Delete the cart
        cart_id = cart[CommonFields.ID]
        await delete_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name=DatabaseCollections.SHOP_CARTS,
            search_filter={CommonFields.ID: cart_id},
            cache_id=cart_id
        )

    if expired_carts:
        logger.info(f"Cleaned up {len(expired_carts)} expired shop carts.")
