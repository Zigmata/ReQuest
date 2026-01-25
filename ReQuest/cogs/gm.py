import discord
from discord import app_commands
from discord.ext import commands
from discord.ext.commands import Cog

from ReQuest.ui.gm import views, modals
from ReQuest.utilities.checks import has_gm_or_mod
from ReQuest.utilities.constants import CharacterFields
from ReQuest.utilities.supportFunctions import (
    log_exception,
    get_cached_data,
    get_xp_config,
    UserFeedbackError
)


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
            await interaction.response.send_message(view=view, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)

    @has_gm_or_mod()
    @app_commands.guild_only()
    async def mod_player_menu(self, interaction: discord.Interaction, member: discord.Member):
        """
        Add or remove items or experience from a player.
        """
        try:
            bot = interaction.client
            guild_id = str(interaction.guild_id)
            player_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': member.id}
            )
            if not player_query:
                raise UserFeedbackError('The target player does not have any registered characters.')

            if guild_id not in player_query[CharacterFields.ACTIVE_CHARACTERS]:
                raise UserFeedbackError('The target player does not have a character activated on this server.')

            active_character_id = player_query[CharacterFields.ACTIVE_CHARACTERS][guild_id]
            character_data = player_query[CharacterFields.CHARACTERS][active_character_id]
            xp_enabled = await get_xp_config(interaction.client, interaction.guild_id)
            modal = modals.ModPlayerModal(member, active_character_id, character_data, xp_enabled)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)

    @has_gm_or_mod()
    @app_commands.guild_only()
    async def view_player(self, interaction: discord.Interaction, member: discord.Member):
        """
        View a player's active character.
        """
        try:
            bot = interaction.client
            guild_id = str(interaction.guild_id)
            player_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': member.id}
            )
            if not player_query:
                raise UserFeedbackError('The target player does not have any registered characters.')

            if guild_id not in player_query[CharacterFields.ACTIVE_CHARACTERS]:
                raise UserFeedbackError('The target player does not have a character activated on this server.')

            active_character_id = player_query[CharacterFields.ACTIVE_CHARACTERS][guild_id]
            character_data = player_query[CharacterFields.CHARACTERS][active_character_id]

            currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='currency',
                query={'_id': interaction.guild_id}
            )
            xp_enabled = await get_xp_config(interaction.client, interaction.guild_id)
            view = views.ViewCharacterView(member.id, character_data, currency_config, xp_enabled)
            await interaction.response.send_message(view=view, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


async def setup(bot):
    await bot.add_cog(GameMaster(bot))
