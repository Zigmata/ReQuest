import re
import discord


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
