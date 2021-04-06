from discord.ext.commands import Cog, command

from ..utilities.supportFunctions import delete_command

global gdb
global mdb


class Help(Cog):
    """Help and informational commands."""

    def __init__(self, bot):
        self.bot = bot
        global gdb
        global mdb
        gdb = bot.gdb
        mdb = bot.mdb

    # Simple ping test
    @command()
    async def ping(self, ctx):
        """
        Get a quick reply from the bot to see if it is online.
        """
        await ctx.send('**Pong!**\n{0}ms'.format(round(self.bot.latency * 1000), 1))

        await delete_command(ctx.message)

    @command()
    async def invite(self, ctx):
        """
        Prints an invite to add ReQuest to your server.
        """
        await ctx.send(f'Invite me to your server! <https://discord.com/api/oauth2/authorize?client_id'
                       f'=601492201704521765&permissions=268954688&scope=bot>')

        await delete_command(ctx.message)

    @command()
    async def info(self, ctx):
        """
        Prints useful bot information.
        """
        await ctx.send(
            f'**ReQuest v0.2.1-a.1**\n\nBugs? Feature Requests? Join the development server at '
            f'https://discord.gg/Zq37gj4')

        await delete_command(ctx.message)


def setup(bot):
    bot.add_cog(Help(bot))
