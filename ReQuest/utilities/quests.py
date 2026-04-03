import inspect
import logging

import discord

from ReQuest.utilities.constants import QuestFields, CharacterFields, CommonFields, DatabaseCollections, ConfigFields
from ReQuest.utilities.exceptions import UserFeedbackError, log_exception
from ReQuest.utilities.db_cache import get_cached_data

logger = logging.getLogger(__name__)

__all__ = [
    'check_role_hierarchy',
    'update_quest_embed',
    'find_member_and_character_id_in_lists',
    'setup_view',
    'get_xp_config',
]


def check_role_hierarchy(guild: discord.Guild, role: discord.Role):
    """Raises UserFeedbackError if the bot cannot manage the given role due to hierarchy."""
    from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
    bot_top_role = guild.me.top_role
    if role >= bot_top_role:
        raise UserFeedbackError(
            t(DEFAULT_LOCALE, 'gm-error-role-hierarchy', roleName=role.name, roleId=str(role.id)),
            message_id='gm-error-role-hierarchy',
            roleName=role.name,
            roleId=str(role.id)
        )


async def update_quest_embed(quest: dict, locale: str | None = None) -> discord.Embed | None:
    """
    Updates a quest embed based on the current quest data.

    :param quest: The quest data dictionary
    :param locale: Locale to use for static labels (defaults to DEFAULT_LOCALE)

    :return: Updated discord.Embed object
    """
    from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
    if locale is None:
        locale = DEFAULT_LOCALE

    try:
        embed = discord.Embed()

        # Initialize all the current quest values
        quest_id = quest[QuestFields.QUEST_ID]
        title = quest[QuestFields.TITLE]
        description = quest[QuestFields.DESCRIPTION]
        max_party_size = quest[QuestFields.MAX_PARTY_SIZE]
        restrictions = quest[QuestFields.RESTRICTIONS]
        gm = quest[QuestFields.GM]
        party = quest[QuestFields.PARTY]
        wait_list = quest[QuestFields.WAIT_LIST]
        max_wait_list_size = quest[QuestFields.MAX_WAIT_LIST_SIZE]
        lock_state = quest[QuestFields.LOCK_STATE]

        # Format the main embed body
        gm_label = t(locale, 'common-embed-label-gm')
        if restrictions:
            restrictions_label = t(locale, 'common-embed-label-party-restrictions')
            post_description = (
                f'{gm_label} <@!{gm}>\n'
                f'{restrictions_label} {restrictions}\n\n'
                f'{description}\n\n'
                f'------'
            )
        else:
            post_description = (
                f'{gm_label} <@!{gm}>\n\n'
                f'{description}\n\n'
                f'------'
            )

        if lock_state:
            title = title + ' ' + t(locale, 'common-label-locked')

        current_party_size = len(party)
        current_wait_list_size = 0
        if wait_list:
            current_wait_list_size = len(wait_list)

        formatted_party = []
        # Map int list to string for formatting, then format the list of users as user mentions
        if party:
            for player in party:
                for member_id in player:
                    for character_id in player[str(member_id)]:
                        character = player[str(member_id)][str(character_id)]
                        formatted_party.append(f'- <@!{member_id}> as {character[CharacterFields.NAME]}')

        formatted_wait_list = []
        # Only format the wait list if there is one.
        if wait_list:
            for player in wait_list:
                for member_id in player:
                    for character_id in player[str(member_id)]:
                        character = player[str(member_id)][str(character_id)]
                        formatted_wait_list.append(f'- <@!{member_id}> as {character[CharacterFields.NAME]}')

        # Set the embed fields and footer
        embed.title = title
        embed.description = post_description
        if formatted_party:
            party_string = '\n'.join(formatted_party)
        else:
            party_string = t(locale, 'common-label-none')
        embed.add_field(name=f'{t(locale, "common-embed-field-party")} ({current_party_size}/{max_party_size})',
                        value=party_string)

        # Add a wait list field if one is present, unless the quest is being archived.
        if max_wait_list_size > 0:
            if formatted_wait_list:
                wait_list_string = '\n'.join(formatted_wait_list)
            else:
                wait_list_string = t(locale, 'common-label-none')

            embed.add_field(
                name=(
                    f'{t(locale, "common-embed-field-wait-list")}'
                    f' ({current_wait_list_size}/{max_wait_list_size})'
                ),
                value=wait_list_string
            )

        embed.set_footer(text=t(locale, 'common-embed-footer-quest-id', questId=quest_id))

        return embed
    except Exception as e:
        await log_exception(e)


def find_member_and_character_id_in_lists(lists, selected_member_id):
    for list_name in lists:
        for player in list_name:
            for member_id, character_data in player.items():
                if str(member_id) == selected_member_id:
                    for character_id in character_data:
                        return member_id, character_id
    return None, None


async def setup_view(view, interaction: discord.Interaction):
    """
    Dynamically sets up a view by inspecting its setup method for required parameters.
    Resolves and propagates the user's locale to the view before calling setup().
    """
    from ReQuest.utilities.localizer import resolve_locale, set_locale_context

    locale = await resolve_locale(interaction)
    set_locale_context(locale)
    view.locale = locale

    setup_function = view.setup
    sig = inspect.signature(setup_function)
    params = sig.parameters

    kwargs = {}
    if 'bot' in params:
        kwargs['bot'] = interaction.client
    if 'user' in params:
        kwargs['user'] = interaction.user
    if 'guild' in params:
        kwargs['guild'] = interaction.guild
    if 'interaction' in params:
        kwargs['interaction'] = interaction

    await setup_function(**kwargs)


async def get_xp_config(bot, guild_id) -> bool:
    """
    Retrieves the XP configuration for a guild.

    :param bot: The Discord bot instance
    :param guild_id: The Discord guild id

    :return: True if XP is enabled, False if XP is disabled
    """
    try:
        query = await get_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name=DatabaseCollections.PLAYER_EXPERIENCE,
            query={CommonFields.ID: guild_id}
        )
        if query is None:
            return True  # Default to XP enabled if no config found
        return query.get(ConfigFields.PLAYER_EXPERIENCE, True)
    except Exception as e:
        logger.error(f"Error retrieving XP config: {e}")
        await log_exception(e)
        return True  # Default to XP enabled on error
