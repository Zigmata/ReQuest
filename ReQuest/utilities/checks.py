from discord import app_commands, Interaction
from discord.app_commands.commands import check


def is_owner():
    async def predicate(interaction: Interaction) -> bool:
        if await interaction.client.is_owner(interaction.user):
            return True

        raise app_commands.AppCommandError("Only the bot owner can use this command!")

    return app_commands.check(predicate)


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
