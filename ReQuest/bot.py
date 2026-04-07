import asyncio
import os
import signal
import logging
from urllib.parse import quote_plus

import aiohttp
import discord
from discord.ext import commands
from discord.ext.commands import errors
from pymongo import AsyncMongoClient as MongoClient
import redis.asyncio as redis

from ReQuest.ui.gm.views import QuestPostView
from ReQuest.utilities.constants import (
    ApprovalFields, QuestFields, QuestStatus, ConfigFields, CommonFields, DatabaseCollections
)
from ReQuest.utilities.db_cache import get_cached_data, build_cache_key
from ReQuest.utilities.discord_utils import attempt_delete, strip_id
from ReQuest.utilities.exceptions import log_exception

log_level = os.getenv('LOG_LEVEL', 'INFO').upper()
logging.basicConfig(
    level=log_level,
    format='%(asctime)s %(name)s %(levelname)s %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S'
)
logger = logging.getLogger(__name__)


class ReQuest(commands.Bot):
    def __init__(self):
        self.mongo_client = None
        self.cdb = None
        self.mdb = None
        self.gdb = None
        self.rdb = None
        self.session = None
        self.allow_list_enabled = False
        intents = discord.Intents.default()
        # Privileged members intent is required for role management and some retrieval of guild members from cache.
        intents.members = True
        # Privileged message_content intent is required for role-play rewards to function, due to the dependency on
        # the on_message events.
        intents.message_content = True
        allowed_mentions = discord.AllowedMentions(roles=True, everyone=False, users=True)
        activity = discord.CustomActivity(
            name=os.getenv('BOT_ACTIVITY', 'Playing by Post')
        )
        super(ReQuest, self).__init__(
            activity=activity,
            allowed_mentions=allowed_mentions,
            case_insensitive=True,
            command_prefix='rq!',
            intents=intents,
            chunk_guilds_at_startup=False
        )
        self.allow_list = []
        self.version = os.getenv('VERSION')

    async def setup_hook(self):
        # The following two sections are two different ways to connect to MongoDB.
        #
        # The first is a default local installation without authentication (not recommended for production).
        #
        # The second is a method of loading environment variables to craft a connection string with
        # authentication (recommended). See the README for details on setting up your environment variables.

        # ----- DEFAULT LOCAL MONGODB INSTALLATION (UNSECURE)-----
        # self.mongo_client = MongoClient('localhost', 27017)
        # --------------------------------------------------------

        # ----- MONGODB WITH AUTHENTICATION (RECOMMENDED) -----
        mongo_user = os.getenv('MONGO_USER')
        mongo_password = os.getenv('MONGO_PASSWORD')
        mongo_host = os.getenv('MONGO_HOST')
        mongo_port = os.getenv('MONGO_PORT')
        auth_db = os.getenv('AUTH_DB')

        # Properly escape any special characters in the username/password
        username = quote_plus(mongo_user)
        password = quote_plus(mongo_password)

        db_uri = f'mongodb://{username}:{password}@{mongo_host}:{mongo_port}/?authSource={auth_db}'
        self.mongo_client = MongoClient(db_uri)
        # ------------------------------------------------------

        # Instantiate the database environment variables as Discord client attributes
        self.mdb = self.mongo_client[os.getenv('MEMBER_DB')]
        self.cdb = self.mongo_client[os.getenv('CONFIG_DB')]
        self.gdb = self.mongo_client[os.getenv('GUILD_DB')]

        # Connect to Redis
        redis_host = os.getenv('REDIS_HOST', 'localhost')
        redis_port = int(os.getenv('REDIS_PORT', 6379))
        redis_password = os.getenv('REDIS_PASSWORD')

        self.rdb = redis.Redis(
            host=redis_host,
            port=redis_port,
            password=redis_password,
            decode_responses=True,
            socket_keepalive=True,
            health_check_interval=30
        )

        # Register the Fluent translator for slash command localization
        from ReQuest.utilities.localizer import FluentTranslator, validate_locale_setup
        validate_locale_setup()
        await self.tree.set_translator(FluentTranslator())

        # Grab the list of extensions and load them asynchronously
        initial_extensions = os.getenv('LOAD_EXTENSIONS').split(',')
        for ext in initial_extensions:
            try:
                await self.load_extension(f'ReQuest.cogs.{ext.strip()}')
            except Exception as e:
                print(f'Failed to load extension: {ext}')
                print('{}: {}'.format(type(e).__name__, e))

        # If the allow list is enabled, load it async in the background
        if os.getenv('ALLOWLIST', 'false').lower() == 'true':
            self.allow_list_enabled = True
            await self.load_allow_list()

        await self._migrate_legacy_quests()
        await self._load_quest_views()
        await self._load_approval_views()

    async def _migrate_legacy_quests(self):
        """One-time migration: convert old embed-based quests to V2 components."""
        quest_collection = self.gdb[DatabaseCollections.QUESTS]
        async for quest in quest_collection.find({QuestFields.STATUS: {'$exists': False}}):
            try:
                quest_id = quest.get(QuestFields.QUEST_ID, 'unknown')
                guild_id = quest.get(QuestFields.GUILD_ID)
                message_id = quest.get(QuestFields.MESSAGE_ID)
                logger.info(f'[Migration] Found legacy quest {quest_id} in guild {guild_id}, '
                            f'messageId={message_id}')

                # Set status to published and invalidate any stale Redis cache
                await quest_collection.update_one(
                    {QuestFields.QUEST_ID: quest_id, QuestFields.GUILD_ID: guild_id},
                    {'$set': {QuestFields.STATUS: QuestStatus.PUBLISHED}}
                )
                quest[QuestFields.STATUS] = QuestStatus.PUBLISHED
                cache_key = build_cache_key(
                    self.gdb.name, f'{guild_id}:{quest_id}', DatabaseCollections.QUESTS
                )
                try:
                    await self.rdb.delete(cache_key)
                except Exception as e:
                    logger.warning(f'[Migration] Quest {quest_id}: Redis cache invalidation failed: {e}')
                logger.info(f'[Migration] Quest {quest_id}: status set to published')

                # Re-post as V2 if message exists
                if not message_id:
                    logger.info(f'[Migration] Quest {quest_id}: no messageId, skipping re-post')
                    continue

                channel_query = await get_cached_data(
                    bot=self,
                    mongo_database=self.gdb,
                    collection_name=DatabaseCollections.QUEST_CHANNEL,
                    query={CommonFields.ID: guild_id}
                )
                if not channel_query:
                    logger.info(
                        f'[Migration] Quest {quest_id}: no quest channel configured for guild {guild_id}'
                    )
                    continue

                channel_id_str = channel_query.get(ConfigFields.QUEST_CHANNEL)
                logger.info(f'[Migration] Quest {quest_id}: quest channel config = {channel_id_str}')
                channel = self.get_channel(strip_id(channel_id_str))
                if not channel:
                    logger.info(f'[Migration] Quest {quest_id}: channel not found in cache, '
                                f'trying fetch for {channel_id_str}')
                    try:
                        channel = await self.fetch_channel(strip_id(channel_id_str))
                    except Exception as e:
                        logger.error(f'[Migration] Quest {quest_id}: failed to fetch channel: {e}')
                        continue

                old_msg = channel.get_partial_message(message_id)
                view = QuestPostView(quest)
                await view.setup(bot=self)
                logger.info(f'[Migration] Quest {quest_id}: sending new V2 post to channel {channel.id}')
                new_msg = await channel.send(view=view)
                await quest_collection.update_one(
                    {QuestFields.QUEST_ID: quest_id, QuestFields.GUILD_ID: guild_id},
                    {'$set': {QuestFields.MESSAGE_ID: new_msg.id}}
                )
                quest[QuestFields.MESSAGE_ID] = new_msg.id
                # Invalidate all related caches after messageId update
                try:
                    await self.rdb.delete(cache_key)
                    admin_key = build_cache_key(
                        self.gdb.name, f'guild_quests:{guild_id}', 'quests'
                    )
                    await self.rdb.delete(admin_key)
                except Exception as e:
                    logger.warning(f'[Migration] Quest {quest_id}: Redis cache invalidation failed: {e}')
                await attempt_delete(old_msg)
                logger.info(
                    f'[Migration] Quest {quest_id}: migrated successfully, new messageId={new_msg.id}'
                )

                # Rate limit protection — pause between migrations
                await asyncio.sleep(2)

            except Exception as e:
                logger.error(f'[Migration] Failed to migrate quest '
                             f'{quest.get(QuestFields.QUEST_ID, "unknown")}: {e}')

    async def _load_quest_views(self):
        """Reload persistent views for published/locked quests."""
        quest_collection = self.gdb[DatabaseCollections.QUESTS]
        async for quest in quest_collection.find():
            try:
                status = quest.get(QuestFields.STATUS, QuestStatus.PUBLISHED)
                message_id = quest.get(QuestFields.MESSAGE_ID)
                if status == QuestStatus.DRAFT or not message_id:
                    continue
                view = QuestPostView(quest)
                await view.setup(bot=self)
                self.add_view(view=view, message_id=message_id)
            except (KeyError, TypeError) as e:
                quest_id = quest.get(QuestFields.QUEST_ID, 'unknown')
                logger.error(f'Failed to load view for quest {quest_id}: {e}')
            except Exception as e:
                quest_id = quest.get(QuestFields.QUEST_ID, 'unknown')
                logger.error(f'Unexpected error loading view for quest {quest_id}: {e}')

    async def _load_approval_views(self):
        """Reload persistent views for pending approval submissions."""
        from ReQuest.ui.player.views import ApprovalPostView
        from ReQuest.utilities.localizer import resolve_guild_locale
        approval_collection = self.gdb[DatabaseCollections.APPROVALS]

        # Revert any submissions stuck in 'processing' from a prior interrupted shutdown
        await approval_collection.update_many(
            {ApprovalFields.STATUS: ApprovalFields.STATUS_PROCESSING},
            {'$set': {ApprovalFields.STATUS: ApprovalFields.STATUS_PENDING}}
        )

        approval_cursor = approval_collection.find(
            {ApprovalFields.STATUS: ApprovalFields.STATUS_PENDING,
             ApprovalFields.MESSAGE_ID: {'$exists': True}}
        )
        async for doc in approval_cursor:
            try:
                submission_id = doc[ApprovalFields.SUBMISSION_ID]
                message_id = doc[ApprovalFields.MESSAGE_ID]
                view = ApprovalPostView(submission_id)
                view.locale = await resolve_guild_locale(self, doc[ApprovalFields.GUILD_ID])
                await view.setup(self)
                self.add_view(view=view, message_id=message_id)
            except (KeyError, TypeError) as e:
                logger.error(f'Failed to load approval view '
                             f'{doc.get(ApprovalFields.SUBMISSION_ID, "unknown")}: {e}')
            except Exception as e:
                logger.error(f'Unexpected error loading approval view '
                             f'{doc.get(ApprovalFields.SUBMISSION_ID, "unknown")}: {e}')

    async def close(self):
        await super().close()
        if self.session:
            await self.session.close()
        if self.mongo_client:
            await self.mongo_client.close()
        if self.rdb:
            await self.rdb.aclose()

    async def load_allow_list(self):
        collection_list = await self.cdb.list_collection_names()
        if 'serverAllowlist' not in collection_list:
            await self.cdb.create_collection('serverAllowlist')

        allow_list_collection = self.cdb['serverAllowlist']
        allow_list_query = await allow_list_collection.find_one({'servers': {'$exists': True}})
        if allow_list_query:
            for server in allow_list_query['servers']:
                self.allow_list.append(server['id'])

    # Overridden from base to delete command invocation messages
    async def invoke(self, ctx):
        if ctx.command is not None:
            self.dispatch('command', ctx)
            try:
                if await self.can_run(ctx, call_once=True):
                    await attempt_delete(ctx.message)
                    await ctx.command.invoke(ctx)
                else:
                    raise errors.CheckFailure('The global check once functions failed.')
            except errors.CommandError as exc:
                await ctx.command.dispatch_error(ctx, exc)
            else:
                self.dispatch('command_completion', ctx)
        elif ctx.invoked_with:
            exc = errors.CommandNotFound('Command "{}" is not found'.format(ctx.invoked_with))
            self.dispatch('command_error', ctx, exc)

    @staticmethod
    async def on_ready():
        logger.info("ReQuest is online.")


bot = ReQuest()


@bot.tree.error
async def on_app_command_error(interaction: discord.Interaction, error: discord.app_commands.AppCommandError):
    await log_exception(error, interaction)


async def main():
    async with aiohttp.ClientSession() as session:
        async with bot:
            bot.session = session
            bot_token = os.getenv('BOT_TOKEN')
            if not bot_token:
                raise ValueError("BOT_TOKEN environment variable is not set.")
            await bot.start(bot_token, reconnect=True)


# Handlers for graceful bot shutdown on container stop/restart
async def shutdown_bot():
    print("Shutting down ReQuest gracefully...")
    await bot.close()


def handle_shutdown_signal(signal_number, frame):
    print(f'Received signal {signal_number}, shutting down...')
    print(f'Shutdown requested by function: {frame.f_code.co_name}')
    loop = asyncio.get_running_loop()
    loop.create_task(shutdown_bot())


signal.signal(signal.SIGINT, handle_shutdown_signal)
signal.signal(signal.SIGTERM, handle_shutdown_signal)

asyncio.run(main())
