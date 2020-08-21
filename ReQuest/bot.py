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

# Define bot and prefix
# TODO: Implement prefix changes
pre = config['prefix']
bot = ReQuest(prefix=pre, activity=discord.Game(name=f'by Post | r!help'))
#bot.remove_command('help') # Un-comment when custom help commands are implemented.
bot.config = config
bot.gdb = connection[config['guildCollection']]
bot.mdb = connection[config['memberCollection']]

def main():
    """Tries to load every cog and start up the bot"""
    for extension in bot.config['load_extensions']:
        try:
            bot.load_extension(extension)
        except:
            print(f'Failed to load extension: {extension}')

    print("ReQuest is online.")
    bot.run(bot.config['token'], bot=True)

if __name__ == '__main__':
    main()