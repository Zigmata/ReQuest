from discord import app_commands, Interaction

from ReQuest.utilities.constants import ConfigFields, CharacterFields, CommonFields
from ReQuest.utilities.supportFunctions import get_cached_data


def is_owner():
    async def predicate(interaction: Interaction) -> bool:
        if await interaction.client.is_owner(interaction.user):
            return True

        raise app_commands.CheckFailure("Only the bot owner can use this command!")

    return app_commands.check(predicate)


def has_gm_or_mod():
    async def predicate(interaction: Interaction) -> bool:
        if interaction.user.guild_permissions.manage_guild:
            return True
        else:
            bot = interaction.client
            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='gmRoles',
                query={'_id': interaction.guild.id}
            )
            if query:
                gm_role_mentions = []
                gm_roles = query[ConfigFields.GM_ROLES]
                for item in gm_roles:
                    gm_role_mentions.append(item[CommonFields.MENTION])
                for role in interaction.user.roles:
                    if role.mention in gm_role_mentions:
                        return True

        raise app_commands.CheckFailure("You do not have permissions to run this command!")

    return app_commands.check(predicate)


def has_active_character():
    async def predicate(interaction: Interaction) -> bool:
        member_id = interaction.user.id
        guild_id = interaction.guild_id
        query = await get_cached_data(
            bot=interaction.client,
            mongo_database=interaction.client.mdb,
            collection_name='characters',
            query={'_id': member_id}
        )

        if query:
            if str(guild_id) in query[CharacterFields.ACTIVE_CHARACTERS]:
                return True
            else:
                raise app_commands.CheckFailure("You do not have an active character on this server!")
        else:
            raise app_commands.CheckFailure("You do not have any registered characters!")

    return app_commands.check(predicate)
