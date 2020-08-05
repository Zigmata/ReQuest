from datetime import datetime
import pymongo
from pymongo import MongoClient

import discord
from discord.utils import get
from discord.ext.commands import Cog, command

#commandList = ['help', 'ping', 'post']

class Help(Cog):
    def __init__(self, bot):
        global config
        global connection
        global db
        self.bot = bot
        config = bot.config
        connection = MongoClient(config['dbServer'],config['port'])
        db = connection[config['guildCollection']]

    # Simple ping test
    @command()
    async def ping(self, ctx):
        await ctx.send('**Pong!**\n{0}ms'.format(round(self.bot.latency * 1000), 1))

    @command()
    async def invite(self,ctx):
        await ctx.send(f'Invite me to your server! https://discord.com/api/oauth2/authorize?client_id=601492201704521765&permissions=519232&scope=bot')

    #@command()
    #async def help(self, ctx):
    #    global commandList
    #    await ctx.send('```Now why the hell isn\'t there a help file yet? Who would do that? Here\'s a list of commands for now:```')
    #    commandString = ', '.join(commandList)
    #    await ctx.send(commandString)

def setup(bot):
    bot.add_cog(Help(bot))