import discord
from discord import app_commands, Interaction
from discord.app_commands.commands import check

from .enums import EditTarget


def is_owner():
    async def predicate(interaction: Interaction) -> bool:
        if await interaction.client.is_owner(interaction.user):
            return True

        raise app_commands.AppCommandError("Only the bot owner can use this command!")

    return app_commands.check(predicate)


def has_gm_role():
    async def predicate(interaction: Interaction) -> bool:
        collection = interaction.client.gdb['gmRoles']
        guild_id = interaction.guild.id
        query = await collection.find_one({'guildId': guild_id})
        if query:
            gm_role_mentions = []
            gm_roles = query['gmRoles']
            for item in gm_roles:
                gm_role_mentions.append(item['mention'])
            for role in interaction.user.roles:
                if role.mention in gm_role_mentions:
                    return True

        raise app_commands.AppCommandError("You must be a Game Master to use this command!")

    return check(predicate)


def has_gm_or_mod():
    async def predicate(interaction: Interaction) -> bool:
        if interaction.user.guild_permissions.manage_guild:
            return True
        else:
            collection = interaction.client.gdb['gmRoles']
            guild_id = interaction.guild.id
            query = await collection.find_one({'_id': guild_id})
            if query:
                gm_role_mentions = []
                gm_roles = query['gmRoles']
                for item in gm_roles:
                    gm_role_mentions.append(item['mention'])
                for role in interaction.user.roles:
                    if role.mention in gm_role_mentions:
                        return True

        raise app_commands.AppCommandError("You do not have permissions to run this command!")

    return check(predicate)


def has_active_character():
    async def predicate(interaction: Interaction) -> bool:
        member_id = interaction.user.id
        guild_id = interaction.guild_id
        collection = interaction.client.mdb['characters']
        query = await collection.find_one({'_id': member_id})

        if query:
            if str(guild_id) in query['activeCharacters']:
                return True
            else:
                raise app_commands.AppCommandError("You do not have an active character on this server!")
        else:
            raise app_commands.AppCommandError("You do not have any registered characters!")

    return check(predicate)


async def is_author_or_mod(db, member: discord.Member, edit_target: EditTarget, target_id: str):
    if member.guild_permissions.manage_guild:
        return True
    else:
        caller_id = member.id

        if edit_target is EditTarget.QUEST:
            collection = db['quests']
            quest = await collection.find_one({'questId': target_id})
            if quest['gm'] == caller_id:
                return True
        elif edit_target is EditTarget.POST:
            collection = db['playerBoard']
            post = await collection.find_one({'postId': target_id})
            if post['player'] == caller_id:
                return True

    return False
