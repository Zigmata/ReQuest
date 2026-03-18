import logging
from datetime import datetime, timedelta, timezone

import discord
from discord.ext import commands, tasks
from discord.ext.commands import Cog

from ReQuest.ui.common.enums import ScheduleType, RestockMode
from ReQuest.utilities.constants import CommonFields, ShopFields, RestockFields, DatabaseCollections
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE, resolve_guild_locale
from ReQuest.utilities.supportFunctions import (
    cleanup_expired_carts,
    get_last_restock,
    get_item_stock,
    get_shop_channel,
    set_available_stock,
    increment_available_stock,
    update_last_restock,
    log_exception,
    escape_markdown
)

logger = logging.getLogger(__name__)


class Tasks(Cog):
    """Background tasks for shop stock management."""
    def __init__(self, bot: commands.Bot):
        super().__init__()
        self.bot = bot

    async def cog_load(self):
        """Start background tasks when the cog is loaded."""
        self.cart_cleanup_task.start()
        self.restock_check_task.start()

    async def cog_unload(self):
        """Stop background tasks when the cog is unloaded."""
        self.cart_cleanup_task.cancel()
        self.restock_check_task.cancel()

    @tasks.loop(minutes=1)
    async def cart_cleanup_task(self):
        """Clean up expired carts and release reserved stock."""
        try:
            await cleanup_expired_carts(self.bot)
        except Exception as e:
            logger.error(f"Error in cart cleanup task: {e}")
            await log_exception(e)

    @cart_cleanup_task.before_loop
    async def before_cart_cleanup(self):
        """Wait for the bot to be ready and run initial cleanup."""
        await self.bot.wait_until_ready()
        # Run immediate cleanup on startup for any orphaned carts
        try:
            await cleanup_expired_carts(self.bot)
            logger.info("Completed startup cart cleanup.")
        except Exception as e:
            logger.error(f"Error in startup cart cleanup: {e}")

    @tasks.loop(minutes=1)
    async def restock_check_task(self):
        """Check all shops for pending restocks."""
        try:
            await self._process_restocks()
        except Exception as e:
            logger.error(f"Error in restock check task: {e}")
            await log_exception(e)

    @restock_check_task.before_loop
    async def before_restock_check(self):
        """Wait for the bot to be ready."""
        await self.bot.wait_until_ready()

    async def _process_restocks(self):
        """Process restocks for all shops with enabled restock schedules."""
        now = datetime.now(timezone.utc)

        # Query all guilds with shops
        collection = self.bot.gdb[DatabaseCollections.SHOPS]
        cursor = collection.find({})
        all_shops = await cursor.to_list(length=None)

        for guild_doc in all_shops:
            guild_id = guild_doc[CommonFields.ID]
            shop_channels = guild_doc.get(ShopFields.SHOP_CHANNELS, {})

            for channel_id, shop_data in shop_channels.items():
                restock_config = shop_data.get(ShopFields.RESTOCK_CONFIG)
                if not restock_config or not restock_config.get(RestockFields.ENABLED):
                    continue

                # Check if restock is due
                last_restock_str = await get_last_restock(self.bot, guild_id, channel_id)
                last_restock = None
                if last_restock_str:
                    try:
                        last_restock = datetime.fromisoformat(last_restock_str.replace('Z', '+00:00'))
                    except (ValueError, TypeError):
                        logger.error(f'Malformed data for last restock in guild {guild_id}, channel {channel_id}')

                if self._is_restock_due(restock_config, last_restock, now):
                    await self._restock_shop(guild_id, channel_id, shop_data, restock_config)
                    await update_last_restock(self.bot, guild_id, channel_id, now.isoformat())
                    logger.debug(f"Restocked shop in guild {guild_id}, channel {channel_id}")

    @staticmethod
    def _is_restock_due(restock_config: dict, last_restock: datetime | None, now: datetime) -> bool:
        """
        Determine if restocking should occur based on schedule.

        Uses a "has the target time passed since the last restock?" approach
        rather than exact minute matching, so the check is resilient to loop
        drift and doesn't require the tick to land on the exact target minute.

        :param restock_config: The shop's restock configuration
        :param last_restock: The last restock datetime or None
        :param now: The current datetime (UTC)

        :return: True if restock is due
        """
        schedule = restock_config.get(RestockFields.SCHEDULE)
        target_minute = restock_config.get(RestockFields.MINUTE, 0)
        target_hour = restock_config.get(RestockFields.HOUR, 0)
        target_day = restock_config.get(RestockFields.DAY_OF_WEEK, 0)  # 0 = Monday

        if schedule == ScheduleType.HOURLY.value:
            # The target time this hour
            target_time = now.replace(minute=target_minute, second=0, microsecond=0)

            # Haven't reached target minute yet this hour
            if now < target_time:
                return False

            # Check if we're within a small window (2 minutes) of the target minute.
            # This prevents a catch-up restock from firing if the bot restarts
            # well past the target minute (e.g. target :10, restart at :45).
            minute_diff = now.minute - target_minute
            if minute_diff > 2:
                return False

            if last_restock is None:
                return True

            # Only restock if the last restock was before this hour's target
            return last_restock < target_time

        elif schedule == ScheduleType.DAILY.value:
            # Build today's target time
            target_time = now.replace(hour=target_hour, minute=target_minute, second=0, microsecond=0)

            # Haven't reached target time yet today
            if now < target_time:
                return False

            if last_restock is None:
                return True

            return last_restock < target_time

        elif schedule == ScheduleType.WEEKLY.value:
            # Calculate this week's target day (Mon=0 anchor)
            this_monday = now.date() - timedelta(days=now.weekday())
            target_date = this_monday + timedelta(days=target_day)
            target_time = datetime(
                target_date.year, target_date.month, target_date.day,
                target_hour, target_minute, 0, 0, timezone.utc
            )

            # Haven't reached target time yet this week
            if now < target_time:
                return False

            if last_restock is None:
                return True

            return last_restock < target_time

        return False

    async def _restock_shop(self, guild_id: int, channel_id: str, shop_data: dict, restock_config: dict):
        """
        Restock all limited items in a shop and post a notification embed.

        :param guild_id: The guild ID
        :param channel_id: The shop channel ID
        :param shop_data: The shop configuration data
        :param restock_config: The restocking configuration
        """
        mode = restock_config.get(RestockFields.MODE, RestockMode.FULL.value)
        increment_amount = restock_config.get(RestockFields.INCREMENT_AMOUNT, 1)

        shop_stock = shop_data.get(ShopFields.SHOP_STOCK, [])
        restocked_items = []  # List of (item_name, amount_added)

        for item in shop_stock:
            max_stock = item.get(ShopFields.MAX_STOCK)
            if max_stock is None:
                continue  # Unlimited item

            item_name = item.get(CommonFields.NAME)

            # Get current stock to calculate how much was added
            current_stock = await get_item_stock(self.bot, guild_id, channel_id, item_name)
            current_available = current_stock[ShopFields.AVAILABLE] if current_stock else 0

            if mode == RestockMode.FULL.value:
                # Set available to maxStock
                await set_available_stock(self.bot, guild_id, channel_id, item_name, max_stock)
                amount_added = max_stock - current_available
            else:
                # Increment available up to maxStock
                await increment_available_stock(self.bot, guild_id, channel_id, item_name,
                                                increment_amount, max_stock)
                amount_added = min(increment_amount, max_stock - current_available)

            if amount_added > 0:
                restocked_items.append((item_name, amount_added))

        # Post restock notification to the shop channel
        if restocked_items:
            await self._post_restock_notification(guild_id, channel_id, restocked_items)

    async def _post_restock_notification(self, guild_id: int, channel_id: str, restocked_items: list):
        """
        Posts a restock notification embed to the shop channel or forum thread.

        :param guild_id: The guild ID
        :param channel_id: The shop channel ID (or thread ID for forum shops)
        :param restocked_items: List of (item_name, amount_added) tuples
        """
        try:
            # Use helper to find channel (handles both text channels and forum threads)
            channel = await get_shop_channel(self.bot, guild_id, channel_id)
            if not channel:
                return

            locale = await resolve_guild_locale(self.bot, guild_id)

            # Build the item list (cap at 20 items)
            max_display = 20
            item_lines = []
            for item_name, amount in restocked_items[:max_display]:
                item_lines.append(f"- **{escape_markdown(item_name)}**: +{amount}")

            if len(restocked_items) > max_display:
                remaining = len(restocked_items) - max_display
                item_lines.append(t(locale, 'shop-restock-more-items', remaining=remaining))

            description = "\n".join(item_lines)

            embed = discord.Embed(
                title=t(locale, 'shop-embed-title-restocked'),
                description=description,
                color=discord.Color.green(),
                timestamp=datetime.now(timezone.utc)
            )
            embed.set_footer(text=t(locale, 'shop-embed-footer-restocked', count=len(restocked_items)))

            await channel.send(embed=embed)
        except Exception as e:
            logger.error(f"Failed to post restock notification: {e}")


async def setup(bot):
    await bot.add_cog(Tasks(bot))
