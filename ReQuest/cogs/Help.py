import pymongo
from pymongo import MongoClient

import discord
from discord.utils import get
from discord.ext import commands
from discord.ext.commands import Cog, command

#commandList = ['help', 'ping', 'post']

class Help(Cog):
    """Help and informational commands."""
    def __init__(self, bot):
        global config
        global db
        self.bot = bot
        config = bot.config
        connection = MongoClient(config['dbServer'],config['port'])
        db = connection[config['guildCollection']]

    # Simple ping test
    @command()
    async def ping(self, ctx):
        """Get a quick reply from the bot to see if it is online."""
        await ctx.send('**Pong!**\n{0}ms'.format(round(self.bot.latency * 1000), 1))

    @commands.is_owner()
    @command(hidden=True) # Adjust descriptors after public release
    async def invite(self,ctx):
        """Prints an invite to add ReQuest to your server."""
        await ctx.send(f'Invite me to your server! https://discord.com/api/oauth2/authorize?client_id=601492201704521765&permissions=519232&scope=bot')

def setup(bot):
    bot.add_cog(Help(bot))