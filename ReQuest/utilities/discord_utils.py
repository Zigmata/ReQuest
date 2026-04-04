import inspect
import logging
import re

import discord

from ReQuest.utilities.exceptions import UserFeedbackError

logger = logging.getLogger(__name__)

__all__ = [
    'attempt_delete',
    'check_role_hierarchy',
    'strip_id',
    'truncate_text',
    'escape_markdown',
    'get_guild_member',
    'setup_view',
]


async def attempt_delete(message: discord.Message | discord.PartialMessage):
    """
    Attempts to delete a message
    """
    try:
        await message.delete()
    except discord.HTTPException as e:
        logger.error(f'HTTPException while deleting message: {e}')
    except Exception as e:
        logger.error(f'Unexpected error while deleting message: {e}')


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


def strip_id(mention: str) -> int:
    """
    Strips a mention string to extract the ID as an integer.

    :param mention: The mention string (e.g., '<@!123456789012345678>')

    :return: The extracted ID as an integer
    """
    stripped_mention = re.sub(r'[<>#!@&]', '', mention)
    parsed_id = int(stripped_mention)
    return parsed_id


def truncate_text(text: str, max_length: int) -> str:
    """Truncates text to max_length, appending '...' if truncated."""
    if not text:
        return ''
    if max_length < 4:
        return text[:max(max_length, 0)]
    if len(text) <= max_length:
        return text
    return text[:max_length - 3] + '...'


def escape_markdown(text: str) -> str:
    """
    Escapes Discord markdown special characters in text.

    :param text: The text to escape

    :return: Text with markdown characters escaped
    """
    if not text:
        return text
    # Escape backslash first to avoid double-escaping
    text = text.replace('\\', '\\\\')
    # Escape other markdown characters
    for char in ('*', '_', '~', '`', '|', '>', '[', ']', '(', ')'):
        text = text.replace(char, f'\\{char}')
    return text


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


async def get_guild_member(guild: discord.Guild, user_id: int) -> discord.Member | None:
    """
    Retrieves a guild member object, chunking the guild if it is not cached already.

    :param guild: The Discord guild object
    :param user_id: The user ID

    :return: discord.Member object or None if not found
    """
    if not guild.chunked:
        await guild.chunk()

    member = guild.get_member(user_id)
    return member
