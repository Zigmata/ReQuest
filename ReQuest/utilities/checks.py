from discord.ext import commands
from .enums import EditTarget


def has_gm_role():
    async def predicate(ctx):
        collection = ctx.bot.gdb['gmRoles']
        guild_id = ctx.guild.id

        query = await collection.find_one({'guildId': guild_id})
        if query:
            gm_roles = query['gmRoles']
            for role in ctx.author.roles:
                if role.id in gm_roles:
                    return True

        raise commands.CheckFailure("You do not have permissions to run this command!")

    return commands.check(predicate)


def has_gm_or_mod():
    async def predicate(ctx):
        if ctx.author.guild_permissions.manage_guild:
            return True
        else:
            collection = ctx.bot.gdb['gmRoles']
            guild_id = ctx.guild.id
            query = await collection.find_one({'guildId': guild_id})
            if query:
                gm_roles = query['gmRoles']
                for role in ctx.author.roles:
                    if role.id in gm_roles:
                        return True

        raise commands.CheckFailure("You do not have permissions to run this command!")

    return commands.check(predicate)


def has_active_character():
    async def predicate(ctx):
        member_id = ctx.author.id
        guild_id = ctx.message.guild.id
        collection = ctx.bot.mdb['characters']
        query = await collection.find_one({'_id': member_id})

        if query:
            if str(guild_id) in query['activeChars']:
                return True
            else:
                raise commands.CheckFailure("You do not have an active character on this server!")
        else:
            raise commands.CheckFailure("You do not have any registered characters!")

    return commands.check(predicate)


async def is_author_or_mod(ctx, edit_target: EditTarget, target_id: str):
    if ctx.author.guild_permissions.manage_guild:
        return True
    else:
        caller_id = ctx.author.id

        if edit_target is EditTarget.QUEST:
            collection = ctx.bot.gdb['quests']
            quest = await collection.find_one({'questId': target_id})
            if quest['gm'] == caller_id:
                return True
        elif edit_target is EditTarget.POST:
            collection = ctx.bot.gdb['playerBoard']
            post = await collection.find_one({'postId': target_id})
            if post['player'] == caller_id:
                return True

    return False
