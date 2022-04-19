import discord
from discord import app_commands
from discord.ext.commands import Cog, command


class Info(Cog):
    """Help and informational commands."""

    def __init__(self, bot):
        self.bot = bot

    # Simple ping test
    @app_commands.command(name='ping')
    async def ping(self, interaction: discord.Interaction) -> None:
        """
        Get a quick reply from the bot to see if it is online.
        """
        await interaction.response.send_message('**Pong!**\n{0}ms'.format(round(self.bot.latency * 1000), 1),
                                                ephemeral=True)

    @app_commands.command(name='invite')
    async def invite(self, interaction: discord.Interaction) -> None:
        """
        Prints an invitation to add ReQuest to your server.
        """
        embed = discord.Embed(title='Invite me to your server!',
                              description='[Get ReQuest!](https://discord.com/api/oauth2/authorize?client_id=6014922017'
                                          '04521765&permissions=1497132133440&scope=applications.commands%20bot)',
                              type='rich')
        await interaction.response.send_message(embed=embed)

    @app_commands.command(name='support')
    async def support(self, interaction: discord.Interaction) -> None:
        """
        Prints the bot version and a link to the development server.
        """
        await interaction.response.send_message(
            f'**ReQuest v0.5.3-a.1**\n\nBugs? Feature Requests? Join the development server at '
            f'https://discord.gg/Zq37gj4')


async def setup(bot):
    await bot.add_cog(Info(bot))
