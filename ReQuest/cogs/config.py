import logging

import discord.ui
from discord import app_commands
from discord.ext.commands import Cog

from ..ui.views import ConfigBaseView
from ..utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class Config(Cog):
    def __init__(self, bot):
        super().__init__()
        self.bot = bot
        self.gdb = bot.gdb

    @app_commands.checks.has_permissions(manage_guild=True)
    @app_commands.default_permissions(manage_guild=True)
    @app_commands.command(name='config')
    @app_commands.guild_only()
    async def config(self, interaction: discord.Interaction):
        """
        Server Configuration Wizard (Server Admins only)
        """
        try:
            guild_id = interaction.guild.id
            view = ConfigBaseView(guild_id, self.gdb)
            await interaction.response.send_message(embed=view.embed, view=view, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


async def setup(bot):
    await bot.add_cog(Config(bot))
