import yaml
from pathlib import Path

import discord
from discord.ext import commands

# Set up config file and load
CONFIG_FILE = Path('config.yaml')

with open(CONFIG_FILE, 'r') as yaml_file:
    config = yaml.safe_load(yaml_file)

# Define bot class
class ReQuest(commands.AutoShardedBot):
    def __init__(self, prefix, **options):
        super(ReQuest, self).__init__(prefix, **options)

# Define bot and prefix
# TODO: Implement prefix changes
pre = config['prefix']
bot = ReQuest(prefix=pre, activity=discord.Game(name=f'by Post'))
#bot.remove_command('help')
bot.config = config


def main():
    """Tries to load every cog and start up the bot"""
    for extension in bot.config['load_extensions']:
        try:
            bot.load_extension(extension)
        except:
            print(f'Failed to load extension: {extension}')

    print("bot is up and running")
    bot.run(bot.config['token'], bot=True)

if __name__ == '__main__':
    main()