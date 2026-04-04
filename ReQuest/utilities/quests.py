import logging

import discord

from ReQuest.utilities.constants import QuestFields, CharacterFields, CommonFields, DatabaseCollections
from ReQuest.utilities.exceptions import log_exception
from ReQuest.utilities.db_cache import get_cached_data

logger = logging.getLogger(__name__)

__all__ = [
    'update_quest_embed',
]


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
