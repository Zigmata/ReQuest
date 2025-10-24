import asyncio
import os
import signal
from urllib.parse import quote_plus

import aiohttp
import discord
from discord.ext import commands
from discord.ext.commands import errors
from motor.motor_asyncio import AsyncIOMotorClient as MotorClient

from ReQuest.ui.views import QuestPostView
from utilities.supportFunctions import attempt_delete, log_exception


class ReQuest(commands.Bot):
    def __init__(self):
        self.motor_client = None
        self.cdb = None
        self.mdb = None
        self.gdb = None
        self.session = None
        intents = discord.Intents.default()
        intents.members = True  # Subscribe to the privileged members intent.
        intents.presences = True  # Subscribe to the privileged presences intent.
        intents.message_content = True  # Subscribe to the privileged message content intent.
        allowed_mentions = discord.AllowedMentions(roles=True, everyone=False, users=True)
        super(ReQuest, self).__init__(
            activity=discord.Game(name=f'by Post'),
            allowed_mentions=allowed_mentions,
            case_insensitive=True,
            command_prefix='!',
            intents=intents)

        # Open the config file and load it to the bot
        self.allow_list = []
        self.version = os.getenv('VERSION')

    async def setup_hook(self):
        # Grab the event loop from asyncio, so we can pass it around
        loop = asyncio.get_running_loop()

        # Instantiate the motor client with the current event loop, and prep the databases. This instantiation uses
        # a local mongoDB deployment on the default port.
        # self.motor_client = MotorClient('localhost', 27017, io_loop=loop)

        # If you are using a connection URI, uncomment the next few blocks of code and use them instead of the client
        # instantiation above. In this example, we are using environment variables from the host system to hold the
        # necessary values.
        mongo_user = os.getenv('MONGO_USER')
        mongo_password = os.getenv('MONGO_PASSWORD')
        mongo_host = os.getenv('MONGO_HOST')
        mongo_port = os.getenv('MONGO_PORT')
        auth_db = os.getenv('AUTH_DB')

        # Properly escape any special characters in the username/password
        username = quote_plus(mongo_user)
        password = quote_plus(mongo_password)

        db_uri = f'mongodb://{username}:{password}@{mongo_host}:{mongo_port}/?authSource={auth_db}'
        self.motor_client = MotorClient(db_uri, io_loop=loop)

        # Instantiate the database objects as Discord client attributes
        self.mdb = self.motor_client[os.getenv('MEMBER_DB')]
        self.cdb = self.motor_client[os.getenv('CONFIG_DB')]
        self.gdb = self.motor_client[os.getenv('GUILD_DB')]

        # Grab the list of extensions and load them asynchronously
        initial_extensions = os.getenv('LOAD_EXTENSIONS').split(', ')
        for ext in initial_extensions:
            try:
                await asyncio.create_task(self.load_extension(ext))
            except Exception as e:
                print(f'Failed to load extension: {ext}')
                print('{}: {}'.format(type(e).__name__, e))

        # If the white list is enabled, load it async in the background
        if os.getenv('ALLOWLIST'):
            await asyncio.create_task(self.load_allow_list())

        # If the bot is restarted with any existing quests, this reloads their views so they can be interacted with.
        quests = []
        quest_collection = self.gdb['quests']
        cursor = quest_collection.find()
        for document in await cursor.to_list(length=None):
            quests.append(document)
        for quest in quests:
            self.add_view(view=QuestPostView(quest), message_id=quest['messageId'])

    async def close(self):
        await super().close()
        if self.session:
            await self.session.close()

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

    async def on_message(self, message):
        if message.author.bot:
            return
        else:
            try:
                await self.process_commands(message)
            except discord.ext.commands.CommandError as command_error:
                await message.channel.send(f'{command_error}')

    @staticmethod
    async def on_ready():
        print("ReQuest is online.")


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
    loop = asyncio.get_event_loop()
    loop.create_task(shutdown_bot())


signal.signal(signal.SIGINT, handle_shutdown_signal)
signal.signal(signal.SIGTERM, handle_shutdown_signal)

asyncio.run(main())
