from pathlib import Path
import re
import yaml
from motor.motor_asyncio import AsyncIOMotorClient
import discord

# Set up config file and load
CONFIG_FILE = Path('config.yaml')

with open(CONFIG_FILE, 'r') as yaml_file:
    config = yaml.safe_load(yaml_file)

mongo_client = AsyncIOMotorClient(config['dbServer'], config['port'])
cdb = mongo_client[config['configDb']]
mdb = mongo_client[config['memberDb']]
gdb = mongo_client[config['guildDb']]


# TODO: Implement input sanitization helper functions

# Deletes command invocations
async def delete_command(message):
    try:
        await message.delete()
    except discord.HTTPException:
        pass


async def get_prefix(self, message):
    prefix = await cdb['prefixes'].find_one({'guildId': message.guild.id})
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
