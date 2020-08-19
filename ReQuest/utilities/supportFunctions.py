import discord

async def delete_command(message):
    try:
        await message.delete()
    except discord.HTTPException:
        pass
