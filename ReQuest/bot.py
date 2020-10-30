import asyncio
import yaml
from pathlib import Path

import pymongo
from pymongo import MongoClient

import discord
from discord.ext import commands

# Set up config file and load
CONFIG_FILE = Path('ReQuest\config.yaml')

with open(CONFIG_FILE, 'r') as yaml_file:
    config = yaml.safe_load(yaml_file)

connection = MongoClient(config['dbServer'],config['port'])

# Define bot class
class ReQuest(commands.AutoShardedBot):
    def __init__(self, prefix, **options):
        super(ReQuest, self).__init__(prefix, **options)

# Define privileged gateway intents

intents = discord.Intents.default()
intents.members = True  # Subscribe to the privileged members intent.

# Define bot and prefix
# TODO: Implement prefix changes
pre = config['prefix']
bot = ReQuest(prefix=pre, case_insensitive = True, intents=intents, activity=discord.Game(name=f'by Post | $help'))
#bot.remove_command('help') # TODO: Un-comment when custom help commands are implemented.
bot.config = config
bot.gdb = connection[config['guildDb']]
bot.mdb = connection[config['memberDb']]
bot.cdb = connection[config['configDb']]
bot.white_list = []
if config['whiteList']:
    bot.white_list = bot.cdb['botWhiteList'].find_one({'servers': {'$exists': True}})['servers']

def main():
    """Tries to load every cog and start up the bot"""
    for extension in bot.config['load_extensions']:
        try:
            bot.load_extension(extension)
        except Exception as e:
            print(f'Failed to load extension: {extension}')
            print('{}: {}'.format(type(e).__name__, e))

    print("ReQuest is online.")
    bot.run(bot.config['token'], bot=True)

if __name__ == '__main__':
    main()