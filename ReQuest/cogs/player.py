import logging

import discord.ui
from discord import app_commands
from discord.ext.commands import Cog

from ..ui import modals
from ..ui.views import PlayerBaseView
from ..utilities.checks import has_active_character
from ..utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class Player(Cog):
    def __init__(self):
        super().__init__()

    @app_commands.command(name='player')
    @app_commands.guild_only()
    async def player(self, interaction: discord.Interaction):
        """
        Player Commands
        """
        try:
            member_id = interaction.user.id
            guild_id = interaction.guild_id
            player_base_view = PlayerBaseView(interaction.client.mdb, interaction.client, member_id, guild_id)
            await interaction.response.send_message(embed=player_base_view.embed, view=player_base_view, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


@has_active_character()
@app_commands.guild_only()
@app_commands.context_menu(name='Trade')
async def trade(interaction: discord.Interaction, target: discord.Member):
    try:
        modal = modals.TradeModal(target=target)
        await interaction.response.send_modal(modal)
    except Exception as e:
        await log_exception(e, interaction)


async def setup(bot):
    await bot.add_cog(Player())
    bot.tree.add_command(trade)
