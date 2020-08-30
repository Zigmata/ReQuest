import re
import functools

import discord
from discord.ext import commands

import pymongo

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
        gdb = ctx.bot.gdb
        collection = gdb['gmRoles']
        guildId = ctx.guild.id

        query = collection.find_one({'guildId': guildId})
        if query:
            gmRoles = query['gmRoles']
            for role in ctx.author.roles:
                if role.id in gmRoles:
                    return True

        await delete_command(ctx.message)
        raise commands.CheckFailure("You do not have permissions to run this command!")

    return commands.check(predicate)

def strip_id(mention) -> int:
    stripped_mention = re.sub(r'[<>#!@&]', '', mention)
    parsed_id = int(stripped_mention)
    return parsed_id

def parse_list(mentions) -> [int]:
    stripped_list = [re.sub(r'[<>#!@&]', '', item) for item in mentions]
    mapped_list = list(map(int, stripped_list))
    return mapped_list