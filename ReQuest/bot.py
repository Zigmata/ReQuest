from pathlib import Path

import discord
import yaml
from discord.ext import commands
from pymongo import MongoClient
from utilities.supportFunctions import get_prefix

# Set up config file and load
CONFIG_FILE = Path('config.yaml')

with open(CONFIG_FILE, 'r') as yaml_file:
    config = yaml.safe_load(yaml_file)

connection = MongoClient(config['dbServer'], config['port'])
cdb = connection[config['configDb']]
mdb = connection[config['memberDb']]
gdb = connection[config['guildDb']]


# Define bot class
class ReQuest(commands.AutoShardedBot):
    def __init__(self):
        allowed_mentions = discord.AllowedMentions(roles=True, everyone=True, users=True)
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
        if config['whiteList']:
            self.white_list = cdb['botWhiteList'].find_one({'servers': {'$exists': True}})['servers']

    async def on_message(self, message):
        if message.author.bot:
            return
        elif len(message.mentions) > 0 and self.user in message.mentions:
            await message.channel.send(f'My prefix for this server is `{get_prefix(self, message)}`')
        else:
            await self.process_commands(message)


bot = ReQuest()


def main():
    """Tries to load every cog and start up the bot"""
    for extension in bot.config['load_extensions']:
        try:
            bot.load_extension(extension)
        except Exception as e:
            print(f'Failed to load extension: {extension}')
            print('{}: {}'.format(type(e).__name__, e))

    print("ReQuest is online.")
    bot.run(bot.config['token'], bot=True, reconnect=True)


if __name__ == '__main__':
    main()
