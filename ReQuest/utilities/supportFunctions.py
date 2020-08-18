import discord

async def command_remove(message):
    try:
        await message.delete()
    except discord.HTTPException:
        pass
