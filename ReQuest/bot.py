import asyncio
from pathlib import Path

import aiohttp
import yaml
import discord
from discord.ext import commands
from motor.motor_asyncio import AsyncIOMotorClient as MotorClient
from utilities.supportFunctions import get_prefix


class ReQuest(commands.AutoShardedBot):
    def __init__(self):
        self.motor_client = None
        self.cdb = None
        self.mdb = None
        self.gdb = None
        self.session = None
        intents = discord.Intents.default()
        intents.members = True
        intents.presences = True
        intents.message_content = True
        allowed_mentions = discord.AllowedMentions(roles=True, everyone=False, users=True)
        super(ReQuest, self).__init__(activity=discord.Game(name=f'by Post'), allowed_mentions=allowed_mentions,
                                      case_insensitive=True, chunk_guild_at_startup=False, command_prefix=get_prefix,
                                      intents=intents)

        # Open the config file and load it to the bot
        config_file = Path('config.yaml')
        with open(config_file, 'r') as yaml_file:
            config = yaml.safe_load(yaml_file)
        self.config = config
        self.white_list = []

    async def setup_hook(self):
        # Grab the event loop from asyncio, so we can pass it around
        loop = asyncio.get_running_loop()

        # Instantiate the motor client with the current event loop, and prep the databases
        self.motor_client = MotorClient(self.config['dbServer'], self.config['port'], io_loop=loop)
        self.mdb = self.motor_client[self.config['memberDb']]
        self.cdb = self.motor_client[self.config['configDb']]
        self.gdb = self.motor_client[self.config['guildDb']]

        # Grab the list of extensions and load them asynchronously
        initial_extensions = self.config['load_extensions']
        for ext in initial_extensions:
            asyncio.create_task(self.load_extension(ext))

        # If the white list is enabled, load it async in the background
        if self.config['whiteList']:
            asyncio.create_task(self.load_white_list())

    async def close(self):
        await super().close()
        await self.session.close()

    async def load_white_list(self):
        white_list = await self.cdb['botWhiteList'].find_one({'servers': {'$exists': True}})
        self.white_list = white_list['servers']

    async def on_message(self, message):
        if message.author.bot:
            return
        elif len(message.mentions) > 0 and self.user in message.mentions:
            await message.channel.send(f'My prefix for this server is `{await get_prefix(self, message)}`')
        else:
            await self.process_commands(message)

    @staticmethod
    async def on_ready():
        print("ReQuest is online.")


bot = ReQuest()


async def main():
    async with aiohttp.ClientSession() as session:
        async with bot:
            bot.session = session
            await bot.start(bot.config['token'], reconnect=True)

asyncio.run(main())
