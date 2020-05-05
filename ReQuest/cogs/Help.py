import discord

from discord.ext import commands

class Help(commands.Cog):
    def __init__(self, bot):
        self.bot = bot

def setup(bot):
    bot.add_cog(Help(bot))