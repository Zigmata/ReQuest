import logging
import re
import traceback

import discord

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


# Deletes command invocations
async def attempt_delete(message):
    try:
        await message.delete()
    except discord.HTTPException:
        pass


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
        await interaction.followup.send(exception, ephemeral=True)


def find_currency_or_denomination(currency_def_query, search_name):
    search_name = search_name.lower()
    for currency in currency_def_query['currencies']:
        if currency['name'].lower() == search_name:
            return currency['name'], currency['name']
        if 'denominations' in currency:
            for denomination in currency['denominations']:
                if denomination['name'].lower() == search_name:
                    return denomination['name'], currency['name']
    return None, None
