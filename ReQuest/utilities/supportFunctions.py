from pathlib import Path
import re
import yaml
from pymongo import MongoClient

import discord
from discord.ext import commands

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


# Verifies the user that invokes a command has a
# server-defined GM role
def has_gm_role():
    async def predicate(ctx):
        collection = gdb['gmRoles']
        guild_id = ctx.guild.id

        query = collection.find_one({'guildId': guild_id})
        if query:
            gm_roles = query['gmRoles']
            for role in ctx.author.roles:
                if role.id in gm_roles:
                    return True

        await delete_command(ctx.message)
        raise commands.CheckFailure("You do not have permissions to run this command!")

    return commands.check(predicate)


def get_prefix(self, message):
    # load prefixes
    prefix = cdb['prefixes'].find_one({'guildId': message.guild.id})
    if not prefix:
        return '{0}'.format(config['prefix'])
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
