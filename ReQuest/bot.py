import asyncio
from pathlib import Path

import aiohttp
import discord
import yaml
from motor.motor_asyncio import AsyncIOMotorClient
from discord.ext import commands, tasks
from utilities.supportFunctions import get_prefix

# Set up config file and load
CONFIG_FILE = Path('config.yaml')

with open(CONFIG_FILE, 'r') as yaml_file:
    config = yaml.safe_load(yaml_file)

mongo_client = AsyncIOMotorClient(config['dbServer'], config['port'])
cdb = mongo_client[config['configDb']]
mdb = mongo_client[config['memberDb']]
gdb = mongo_client[config['guildDb']]


# Define bot class
class ReQuest(commands.AutoShardedBot):
    def __init__(self):
        self.session = None
        allowed_mentions = discord.AllowedMentions(roles=True, everyone=False, users=True)
        intents = discord.Intents.default()
        intents.members = True  # Subscribe to the privileged members intent.
        intents.presences = True  # Subscribe to the privileged presences intent.
        super(ReQuest, self).__init__(command_prefix=get_prefix, fetch_offline_members=False,
                                      allowed_mentions=allowed_mentions, intents=intents, case_insensitive=True,
                                      activity=discord.Game(name=f'by Post'))

        self.gdb = gdb
        self.mdb = mdb
        self.cdb = cdb
        self.config = config
        self.white_list = []
        self.initial_extensions = config['load_extensions']
        if config['whiteList']:
            self.white_list = self.get_white_list()

    async def setup_hook(self):
        # self.background_task.start()
        self.session = aiohttp.ClientSession()
        # if config['whiteList']:
        #     self.white_list = await self.get_white_list()
        for ext in self.initial_extensions:
            try:
                await self.load_extension(ext)
            except Exception as e:
                print(f'Failed to load extension: {ext}')
                print(f'{type(e).__name__}: {e}')

    async def close(self):
        await super().close()
        await self.session.close()

    # @tasks.loop(minutes=10)
    # async def background_task(self):
    #     print('Running background task...')

    @staticmethod
    async def on_ready():
        print('Ready!')

    @staticmethod
    async def get_white_list():
        return await cdb['botWhiteList'].find_one({'servers': {'$exists': True}})['servers']

    async def on_message(self, message):
        if message.author.bot:
            return
        elif len(message.mentions) > 0 and self.user in message.mentions:
            await message.channel.send(f'My prefix for this server is `{await get_prefix(self, message)}`')
        else:
            await self.process_commands(message)


bot = ReQuest()


async def main():
    # """Tries to load every cog and start up the bot"""
    # for extension in bot.config['load_extensions']:
    #     try:
    #         await bot.load_extension(extension)
    #     except Exception as e:
    #         print(f'Failed to load extension: {extension}')
    #         print('{}: {}'.format(type(e).__name__, e))
    async with aiohttp.ClientSession() as session:
        async with bot:
            bot.session = session
            # bot.loop.create_task(bot.background_task())
            await bot.start(bot.config['token'], reconnect=True)
            print("ReQuest is online.")


# if __name__ == '__main__':
asyncio.run(main())
