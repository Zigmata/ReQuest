import logging
import re

import discord

logger = logging.getLogger(__name__)

__all__ = [
    'attempt_delete',
    'strip_id',
    'truncate_text',
    'escape_markdown',
    'get_guild_member',
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
