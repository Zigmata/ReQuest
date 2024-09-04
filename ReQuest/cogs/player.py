import logging

import discord.ui
from discord import app_commands
from discord.ext import commands
from discord.ext.commands import Cog

from ..ui import modals
from ..ui.views import PlayerBaseView
from ..utilities.checks import has_active_character
from ..utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class Player(Cog):
    def __init__(self, bot: commands.Bot):
        super().__init__()
        self.trade_menu = app_commands.ContextMenu(
            name='Trade',
            callback=self.trade_menu
        )
        self.bot = bot
        self.bot.tree.add_command(self.trade_menu)

    async def cog_unload(self) -> None:
        self.bot.tree.remove_command(self.trade_menu.name, type=self.trade_menu.type)

    @app_commands.command(name='player')
    @app_commands.guild_only()
    async def player(self, interaction):
        """
        Player Menus
        """
        try:
            new_view = PlayerBaseView()
            await new_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.send_message(embed=new_view.embed, view=new_view, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)

    @has_active_character()
    @app_commands.guild_only()
    async def trade_menu(self, interaction, target: discord.Member):
        try:
            modal = modals.TradeModal(target=target)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


async def setup(bot):
    await bot.add_cog(Player(bot))
