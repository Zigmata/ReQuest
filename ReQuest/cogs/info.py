import discord
from discord import app_commands
from discord.ext.commands import Cog

from ReQuest.utilities.localizer import resolve_locale, t


class Info(Cog):
    """Help and informational commands."""
    def __init__(self, bot):
        self.bot = bot
        super().__init__()

    # Simple ping test
    @app_commands.command(name='ping')
    async def ping(self, interaction: discord.Interaction):
        """
        Get a quick reply from the bot to see if it is online.
        """
        locale = await resolve_locale(interaction)
        latency = str(round(self.bot.latency * 1000))
        await interaction.response.send_message(t(locale, 'info-pong', latency=latency), ephemeral=True)

    @app_commands.command(name='invite')
    async def invite(self, interaction: discord.Interaction):
        """
        Prints an invitation to add ReQuest to your server.
        """
        locale = await resolve_locale(interaction)
        embed = discord.Embed(title=t(locale, 'info-invite-title'),
                              description='[Get ReQuest!](https://discord.com/api/oauth2/authorize?client_id=6014922017'
                                          '04521765&permissions=1497132133440&scope=applications.commands%20bot)',
                              type='rich')
        await interaction.response.send_message(embed=embed)

    @app_commands.command(name='support')
    async def support(self, interaction: discord.Interaction):
        """
        Prints the bot version and a link to the development server.
        """
        locale = await resolve_locale(interaction)
        await interaction.response.send_message(t(locale, 'info-support', version=interaction.client.version))

    @app_commands.command(name='help')
    async def help(self, interaction: discord.Interaction):
        """
        Displays a list of commands and their functions.
        """
        locale = await resolve_locale(interaction)
        embed = discord.Embed(
            title=t(locale, 'info-help-title'),
            description=t(locale, 'info-help-description'),
            type='rich'
        )
        await interaction.response.send_message(embed=embed, ephemeral=True)


async def setup(bot):
    await bot.add_cog(Info(bot))
