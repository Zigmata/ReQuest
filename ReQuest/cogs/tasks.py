import logging
from datetime import datetime, timezone

from discord.ext import commands, tasks
from discord.ext.commands import Cog

from ReQuest.utilities.supportFunctions import (
    cleanup_expired_carts,
    get_last_restock,
    set_available_stock,
    increment_available_stock,
    update_last_restock,
    log_exception
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
        collection = self.bot.gdb['shops']
        cursor = collection.find({})
        all_shops = await cursor.to_list(length=None)

        for guild_doc in all_shops:
            guild_id = guild_doc['_id']
            shop_channels = guild_doc.get('shopChannels', {})

            for channel_id, shop_data in shop_channels.items():
                restock_config = shop_data.get('restockConfig')
                if not restock_config or not restock_config.get('enabled'):
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

        :param restock_config: The shop's restock configuration
        :param last_restock: The last restock datetime or None
        :param now: The current datetime (UTC)

        :return: True if restock is due
        """
        schedule = restock_config.get('schedule')
        target_minute = restock_config.get('minute', 0)
        target_hour = restock_config.get('hour', 0)
        target_day = restock_config.get('dayOfWeek', 0)  # 0 = Monday

        if schedule == 'hourly':
            # Check if we're at the target minute
            if now.minute == target_minute:
                if last_restock is None:
                    return True
                # Check if at least 1 hour has passed
                time_diff = now - last_restock
                if time_diff.total_seconds() >= 3600 - 60:  # 1 hour minus 1 minute buffer
                    return True

        elif schedule == 'daily':
            # Check if we're at target hour:minute
            if now.hour == target_hour and now.minute == target_minute:
                if last_restock is None:
                    return True
                # Check if it's a different day
                if now.date() > last_restock.date():
                    return True

        elif schedule == 'weekly':
            # Check if correct day, hour, minute
            if now.weekday() == target_day and now.hour == target_hour and now.minute == target_minute:
                if last_restock is None:
                    return True
                # Check if at least 6 days have passed (to avoid issues at day boundaries)
                time_diff = now - last_restock
                if time_diff.days >= 6:
                    return True

        return False

    async def _restock_shop(self, guild_id: int, channel_id: str, shop_data: dict, restock_config: dict):
        """
        Restock all limited items in a shop.

        :param guild_id: The guild ID
        :param channel_id: The shop channel ID
        :param shop_data: The shop configuration data
        :param restock_config: The restocking configuration
        """
        mode = restock_config.get('mode', 'full')
        increment_amount = restock_config.get('incrementAmount', 1)

        shop_stock = shop_data.get('shopStock', [])

        for item in shop_stock:
            max_stock = item.get('maxStock')
            if max_stock is None:
                continue  # Unlimited item

            item_name = item.get('name')

            if mode == 'full':
                # Set available to maxStock
                await set_available_stock(self.bot, guild_id, channel_id, item_name, max_stock)
            else:
                # Increment available up to maxStock
                await increment_available_stock(self.bot, guild_id, channel_id, item_name,
                                                increment_amount, max_stock)


async def setup(bot):
    await bot.add_cog(Tasks(bot))
