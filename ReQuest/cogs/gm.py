import discord
from discord import app_commands
from discord.ext import commands
from discord.ext.commands import Cog

import ReQuest.ui.modals as modals
from ..ui.views import GMBaseView
from ..utilities.checks import has_gm_or_mod
from ..utilities.supportFunctions import log_exception


class GameMaster(Cog):
    def __init__(self, bot: commands.Bot):
        super().__init__()
        self.bot = bot
        self.mod_player_menu = app_commands.ContextMenu(
            name='Modify Player',
            callback=self.mod_player_menu
        )
        self.bot.tree.add_command(self.mod_player_menu)

    async def cog_unload(self) -> None:
        self.bot.tree.remove_command(self.mod_player_menu.name, type=self.mod_player_menu.type)

    @has_gm_or_mod()
    @app_commands.command(name='gm')
    @app_commands.guild_only()
    async def gm(self, interaction: discord.Interaction):
        """
        Game Master Menus
        """
        try:
            view = GMBaseView(interaction.client, interaction.user, interaction.guild_id)
            await interaction.response.send_message(embed=view.embed, view=view, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)

    @has_gm_or_mod()
    @app_commands.guild_only()
    async def mod_player_menu(self, interaction: discord.Interaction, member: discord.Member):
        """
        Add or remove items or experience from a player.
        """
        try:
            guild_id = str(interaction.guild_id)
            character_collection = interaction.client.mdb['characters']
            player_query = await character_collection.find_one({'_id': member.id})
            if not player_query:
                raise Exception('The target player does not have any registered characters.')

            if guild_id not in player_query['activeCharacters']:
                raise Exception('The target player does not have a character activated on this server.')

            character_id = player_query['activeCharacters'][guild_id]
            character_data = player_query['characters'][character_id]
            modal = modals.ModPlayerModal(member, character_id, character_data)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)

async def setup(bot):
    await bot.add_cog(GameMaster(bot))
