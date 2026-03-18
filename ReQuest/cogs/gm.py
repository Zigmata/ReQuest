import discord
from discord import app_commands
from discord.ext import commands
from discord.ext.commands import Cog

from ReQuest.ui.gm import views, modals
from ReQuest.utilities.checks import has_gm_or_mod
from ReQuest.utilities.constants import CharacterFields, CommonFields, DatabaseCollections
from ReQuest.utilities.localizer import resolve_locale, set_locale_context, t
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
            name=app_commands.locale_str('Modify Player'),
            callback=self.mod_player_menu
        )
        self.view_player_menu = app_commands.ContextMenu(
            name=app_commands.locale_str('View Player'),
            callback=self.view_player
        )
        self.bot.tree.add_command(self.mod_player_menu)
        self.bot.tree.add_command(self.view_player_menu)

    async def cog_unload(self) -> None:
        self.bot.tree.remove_command(self.mod_player_menu.name, type=self.mod_player_menu.type)
        self.bot.tree.remove_command(self.view_player_menu.name, type=self.view_player_menu.type)

    @has_gm_or_mod()
    @app_commands.command(
        name='gm',
        description=app_commands.locale_str('Game Master Menus')
    )
    @app_commands.guild_only()
    async def gm(self, interaction):
        try:
            locale = await resolve_locale(interaction)
            set_locale_context(locale)
            view = views.GMBaseView()
            view.locale = locale
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
            locale = await resolve_locale(interaction)
            set_locale_context(locale)
            bot = interaction.client
            guild_id = str(interaction.guild_id)
            player_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name=DatabaseCollections.CHARACTERS,
                query={CommonFields.ID: member.id}
            )
            if not player_query:
                raise UserFeedbackError(t(locale, 'error-no-characters'), message_id='error-no-characters')

            if guild_id not in player_query[CharacterFields.ACTIVE_CHARACTERS]:
                raise UserFeedbackError(t(locale, 'error-no-active-character-target'), message_id='error-no-active-character-target')

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
            locale = await resolve_locale(interaction)
            set_locale_context(locale)
            bot = interaction.client
            guild_id = str(interaction.guild_id)
            player_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name=DatabaseCollections.CHARACTERS,
                query={CommonFields.ID: member.id}
            )
            if not player_query:
                raise UserFeedbackError(t(locale, 'error-no-characters'), message_id='error-no-characters')

            if guild_id not in player_query[CharacterFields.ACTIVE_CHARACTERS]:
                raise UserFeedbackError(t(locale, 'error-no-active-character-target'), message_id='error-no-active-character-target')

            active_character_id = player_query[CharacterFields.ACTIVE_CHARACTERS][guild_id]
            character_data = player_query[CharacterFields.CHARACTERS][active_character_id]

            currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: interaction.guild_id}
            )
            xp_enabled = await get_xp_config(interaction.client, interaction.guild_id)
            view = views.ViewCharacterView(member.id, character_data, currency_config, xp_enabled)
            await interaction.response.send_message(view=view, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


async def setup(bot):
    await bot.add_cog(GameMaster(bot))
