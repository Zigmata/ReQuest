from discord.ext.commands import Cog

listener = Cog.listener

global gdb
global mdb


class Inventory(Cog):
    def __init__(self, bot):
        self.bot = bot
        global gdb
        global mdb
        gdb = bot.gdb
        mdb = bot.mdb


def setup(bot):
    bot.add_cog(Inventory(bot))
