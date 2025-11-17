import discord.ui
from discord import app_commands
from discord.ext.commands import Cog

from ReQuest.ui.config import views
from ReQuest.utilities.supportFunctions import log_exception


class Config(Cog):
    def __init__(self, bot):
        super().__init__()
        self.bot = bot

    @app_commands.checks.has_permissions(manage_guild=True)
    @app_commands.default_permissions(manage_guild=True)
    @app_commands.command(name='config')
    @app_commands.guild_only()
    async def config(self, interaction: discord.Interaction):
        """
        Server Configuration Menus (Server Admins only)
        """
        try:
            view = views.ConfigBaseView()
            await interaction.response.send_message(view=view, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


async def setup(bot):
    await bot.add_cog(Config(bot))
