import discord
from discord import app_commands
from discord.ext.commands import Cog

from ReQuest.ui.info.views import LanguageView
from ReQuest.utilities.localizer import resolve_locale, set_locale_context, t
from ReQuest.utilities.supportFunctions import setup_view


class Info(Cog):
    """Help and informational commands."""
    def __init__(self, bot):
        self.bot = bot
        super().__init__()

    # Simple ping test
    @app_commands.command(
        name='ping',
        description=app_commands.locale_str('Get a quick reply from the bot to see if it is online.')
    )
    async def ping(self, interaction: discord.Interaction):
        locale = await resolve_locale(interaction)
        latency = str(round(self.bot.latency * 1000))
        await interaction.response.send_message(t(locale, 'info-pong', latency=latency), ephemeral=True)

    @app_commands.command(
        name='invite',
        description=app_commands.locale_str('Prints an invitation to add ReQuest to your server.')
    )
    async def invite(self, interaction: discord.Interaction):
        locale = await resolve_locale(interaction)
        embed = discord.Embed(title=t(locale, 'info-invite-title'),
                              description='[Get ReQuest!](https://discord.com/api/oauth2/authorize?client_id=6014922017'
                                          '04521765&permissions=1497132133440&scope=applications.commands%20bot)',
                              type='rich')
        await interaction.response.send_message(embed=embed)

    @app_commands.command(
        name='support',
        description=app_commands.locale_str('Prints the bot version and a link to the development server.')
    )
    async def support(self, interaction: discord.Interaction):
        locale = await resolve_locale(interaction)
        await interaction.response.send_message(t(locale, 'info-support', version=interaction.client.version))

    @app_commands.command(
        name='language',
        description=app_commands.locale_str('Set your preferred language for bot responses.')
    )
    async def language(self, interaction: discord.Interaction):
        view = LanguageView()
        await setup_view(view, interaction)
        await interaction.response.send_message(view=view, ephemeral=True)

    @app_commands.command(
        name='help',
        description=app_commands.locale_str('Displays a list of commands and their functions.')
    )
    async def help(self, interaction: discord.Interaction):
        locale = await resolve_locale(interaction)
        embed = discord.Embed(
            title=t(locale, 'info-help-title'),
            description=t(locale, 'info-help-description'),
            type='rich'
        )
        await interaction.response.send_message(embed=embed, ephemeral=True)


async def setup(bot):
    await bot.add_cog(Info(bot))
