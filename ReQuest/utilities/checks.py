from discord import app_commands, Interaction

from ReQuest.utilities.constants import ConfigFields, CharacterFields, CommonFields, DatabaseCollections
from ReQuest.utilities.localizer import resolve_locale, t
from ReQuest.utilities.supportFunctions import get_cached_data


def is_owner():
    async def predicate(interaction: Interaction) -> bool:
        if await interaction.client.is_owner(interaction.user):
            return True

        locale = await resolve_locale(interaction)
        raise app_commands.CheckFailure(t(locale, 'error-owner-only'))

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
                collection_name=DatabaseCollections.GM_ROLES,
                query={CommonFields.ID: interaction.guild.id}
            )
            if query:
                gm_role_mentions = []
                gm_roles = query[ConfigFields.GM_ROLES]
                for item in gm_roles:
                    gm_role_mentions.append(item[CommonFields.MENTION])
                for role in interaction.user.roles:
                    if role.mention in gm_role_mentions:
                        return True

        locale = await resolve_locale(interaction)
        raise app_commands.CheckFailure(t(locale, 'error-no-permission'))

    return app_commands.check(predicate)


def has_active_character():
    async def predicate(interaction: Interaction) -> bool:
        member_id = interaction.user.id
        guild_id = interaction.guild_id
        query = await get_cached_data(
            bot=interaction.client,
            mongo_database=interaction.client.mdb,
            collection_name=DatabaseCollections.CHARACTERS,
            query={CommonFields.ID: member_id}
        )

        if query:
            if str(guild_id) in query[CharacterFields.ACTIVE_CHARACTERS]:
                return True
            else:
                locale = await resolve_locale(interaction)
                raise app_commands.CheckFailure(t(locale, 'error-no-active-character'))
        else:
            locale = await resolve_locale(interaction)
            raise app_commands.CheckFailure(t(locale, 'error-no-registered-characters'))

    return app_commands.check(predicate)
