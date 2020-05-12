import discord
from discord.ext.commands import Cog, command

class Admin(Cog):
    def __init__(self, bot):
        self.bot = bot

    @command(hidden=True)
    # TODO add utility for owner check/admin check
    async def reload(self, ctx, module : str):
        try:
            self.bot.reload_extension('cogs.'+module)
        except Exception as e:
            await ctx.send('{}: {}'.format(type(e).__name__, e))
        else:
            await ctx.send('Extension successfully reloaded: `{}`'.format(module))

def setup(bot):
    bot.add_cog(Admin(bot))