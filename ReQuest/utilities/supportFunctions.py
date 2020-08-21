import discord
from discord.ext import commands

import pymongo

async def delete_command(message):
    try:
        await message.delete()
    except discord.HTTPException:
        pass

def has_gm_role():
    def predicate(ctx):
        gdb=ctx.bot.gdb
        collection = gdb['gmRoles']
        guildId = ctx.guild.id

        query = collection.find_one({'guildId': guildId})
        if query:
            gmRoles = query['gmRoles']
            for role in ctx.author.roles:
                if role.id in gmRoles:
                    return True
        raise commands.CheckFailure("You do not have permissions to run this command!")

    return commands.check(predicate)
