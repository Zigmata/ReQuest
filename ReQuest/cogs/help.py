from discord.ext.commands import Cog, command


class Help(Cog):
    """Help and informational commands."""

    def __init__(self, bot):
        self.bot = bot

    # Simple ping test
    @command()
    async def ping(self, ctx):
        """
        Get a quick reply from the bot to see if it is online.
        """
        await ctx.send('**Pong!**\n{0}ms'.format(round(self.bot.latency * 1000), 1))

    @command()
    async def invite(self, ctx):
        """
        Prints an invite to add ReQuest to your server.
        """
        await ctx.send(f'Invite me to your server! <https://discord.com/api/oauth2/authorize?client_id'
                       f'=601492201704521765&permissions=268954688&scope=bot>')

    @command()
    async def info(self, ctx):
        """
        Prints useful bot information.
        """
        await ctx.send(
            f'**ReQuest v0.5.3-a.1**\n\nBugs? Feature Requests? Join the development server at '
            f'https://discord.gg/Zq37gj4')


async def setup(bot):
    await bot.add_cog(Help(bot))
