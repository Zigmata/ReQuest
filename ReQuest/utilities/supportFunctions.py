from pathlib import Path
import re
import yaml
from pymongo import MongoClient

import discord

# Set up config file and load
CONFIG_FILE = Path('config.yaml')

with open(CONFIG_FILE, 'r') as yaml_file:
    config = yaml.safe_load(yaml_file)

connection = MongoClient(config['dbServer'], config['port'])
cdb = connection[config['configDb']]
mdb = connection[config['memberDb']]
gdb = connection[config['guildDb']]


# TODO: Implement input sanitization helper functions

# Deletes command invocations
async def delete_command(message):
    try:
        await message.delete()
    except discord.HTTPException:
        pass


def get_prefix(self, message):
    prefix = cdb['prefixes'].find_one({'guildId': message.guild.id})
    if not prefix:
        return f'{config["prefix"]}'
    else:
        return str(prefix['prefix'])


def strip_id(mention) -> int:
    stripped_mention = re.sub(r'[<>#!@&]', '', mention)
    parsed_id = int(stripped_mention)
    return parsed_id


def parse_list(mentions) -> [int]:
    stripped_list = [re.sub(r'[<>#!@&]', '', item) for item in mentions]
    mapped_list = list(map(int, stripped_list))
    return mapped_list
