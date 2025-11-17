import discord
from discord import app_commands
from discord.ext import commands
from discord.ext.commands import Cog

from ReQuest.ui.gm import views, modals
from ReQuest.utilities.checks import has_gm_or_mod
from ReQuest.utilities.supportFunctions import log_exception


class GameMaster(Cog):
    def __init__(self, bot: commands.Bot):
        super().__init__()
        self.bot = bot
        self.mod_player_menu = app_commands.ContextMenu(
            name='Modify Player',
            callback=self.mod_player_menu
        )
        self.view_player_menu = app_commands.ContextMenu(
            name='View Player',
            callback=self.view_player
        )
        self.bot.tree.add_command(self.mod_player_menu)
        self.bot.tree.add_command(self.view_player_menu)

    async def cog_unload(self) -> None:
        self.bot.tree.remove_command(self.mod_player_menu.name, type=self.mod_player_menu.type)
        self.bot.tree.remove_command(self.view_player_menu.name, type=self.view_player_menu.type)

    @has_gm_or_mod()
    @app_commands.command(name='gm')
    @app_commands.guild_only()
    async def gm(self, interaction):
        """
        Game Master Menus
        """
        try:
            view = views.GMBaseView()
            await interaction.response.send_message(embed=view.embed, view=view, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)

    @has_gm_or_mod()
    @app_commands.guild_only()
    async def mod_player_menu(self, interaction, member: discord.Member):
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

            active_character_id = player_query['activeCharacters'][guild_id]
            character_data = player_query['characters'][active_character_id]
            modal = modals.ModPlayerModal(member, active_character_id, character_data)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)

    @has_gm_or_mod()
    @app_commands.guild_only()
    async def view_player(self, interaction, member: discord.Member):
        """
        View a player's active character.
        """
        try:
            guild_id = str(interaction.guild_id)
            character_collection = interaction.client.mdb['characters']
            player_query = await character_collection.find_one({'_id': member.id})
            if not player_query:
                raise Exception('The target player does not have any registered characters.')

            if guild_id not in player_query['activeCharacters']:
                raise Exception('The target player does not have a character activated on this server.')

            active_character_id = player_query['activeCharacters'][guild_id]
            character_data = player_query['characters'][active_character_id]

            currency_config = await interaction.client.gdb['currency'].find_one({'_id': interaction.guild_id})
            view = views.ViewCharacterView(member.id, character_data, currency_config)
            await interaction.response.send_message(view=view, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


async def setup(bot):
    await bot.add_cog(GameMaster(bot))
