from datetime import datetime

import discord
from discord.ext.commands import Cog, command

commandList = ['help', 'ping', 'post']

class Help(Cog):
    def __init__(self, bot):
        self.bot = bot

    # Simple ping test
    @command()
    async def ping(self, ctx):
        await ctx.send('**Pong!**\n{0}ms'.format(round(self.bot.latency * 1000), 1))

    #@command()
    #async def help(self, ctx):
    #    global commandList
    #    await ctx.send('```Now why the hell isn\'t there a help file yet? Who would do that? Here\'s a list of commands for now:```')
    #    commandString = ', '.join(commandList)
    #    await ctx.send(commandString)

def setup(bot):
    bot.add_cog(Help(bot))