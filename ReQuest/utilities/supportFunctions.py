import logging
import re
import discord
import traceback

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


# Deletes command invocations
async def attempt_delete(message):
    try:
        await message.delete()
    except discord.HTTPException:
        pass


async def get_prefix(bot, message):
    prefix = await bot.cdb['prefixes'].find_one({'guildId': message.guild.id})
    if not prefix:
        return f'{bot.config["prefix"]}'
    else:
        return f'{prefix["prefix"]}'


def strip_id(mention) -> int:
    stripped_mention = re.sub(r'[<>#!@&]', '', mention)
    parsed_id = int(stripped_mention)
    return parsed_id


def parse_list(mentions) -> [int]:
    stripped_list = [re.sub(r'[<>#!@&]', '', item) for item in mentions]
    mapped_list = list(map(int, stripped_list))
    return mapped_list


async def log_exception(exception, interaction=None):
    logger.error(f'{type(exception).__name__}: {exception}')
    logger.error(traceback.format_exc())
    if interaction:
        await interaction.response.defer()
        await interaction.followup.send(f'An error occurred: {type(exception).__name__}: {exception}', ephemeral=True)
