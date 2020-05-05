import discord
from discord.utils import get
from discord.ext.commands import Cog, command
listener = Cog.listener

class QuestBoard(Cog):
    def __init__(self, bot):
        self.bot = bot

    @listener()
    async def on_reaction_add(self, reaction, user):
        if user.bot:
            return
        else:
            await message.edit(content = original+f'\n- <@!{user.id}>')

    @command()
    async def post(self, ctx):
        msg = await ctx.send('Successful Test!')
        #msg = await ctx.send(f'{announceRole}\n**NEW QUEST:** {title}\n**Level Range:** {levels}\n**GM:** {gm}\n**Description:** {description}\n**Players:**')
        emoji = '<:acceptquest:601559094293430282>'
        await msg.add_reaction(emoji)
        await msg.channel.send('Quest posted!')

def setup(bot):
    bot.add_cog(QuestBoard(bot))