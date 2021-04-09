from pathlib import Path
import yaml
from pymongo import MongoClient

from discord.ext import commands
from .supportFunctions import delete_command

# Set up config file and load
CONFIG_FILE = Path('config.yaml')

with open(CONFIG_FILE, 'r') as yaml_file:
    config = yaml.safe_load(yaml_file)

connection = MongoClient(config['dbServer'], config['port'])
cdb = connection[config['configDb']]
mdb = connection[config['memberDb']]
gdb = connection[config['guildDb']]


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


def has_gm_or_mod():
    async def predicate(ctx):
        if ctx.author.guild_permissions.manage_guild:
            return True
        else:
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


def has_active_character():
    async def predicate(ctx):
        member_id = ctx.author.id
        guild_id = ctx.message.guild.id
        collection = mdb['characters']
        query = collection.find_one({'memberId': member_id})

        if query:
            if str(guild_id) in query['activeChars']:
                return True
            else:
                await delete_command(ctx.message)
                raise commands.CheckFailure("You do not have an active character on this server!")
        else:
            await delete_command(ctx.message)
            raise commands.CheckFailure("You do not have any registered characters!")

    return commands.check(predicate)
