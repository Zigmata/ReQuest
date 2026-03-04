from discord import app_commands
from discord.ext import commands
from discord.ext.commands import Cog

from ReQuest.ui.shop import views
from ReQuest.utilities.constants import CommonFields, ShopFields, DatabaseCollections
from ReQuest.utilities.localizer import resolve_locale, t
from ReQuest.utilities.supportFunctions import log_exception, get_cached_data, UserFeedbackError, setup_view


class Shop(Cog):
    def __init__(self, bot: commands.Bot):
        super().__init__()
        self.bot = bot

    @app_commands.command(name='shop')
    @app_commands.guild_only()
    async def shop(self, interaction):
        """
        Opens a shop in the current channel if one is configured.
        """
        try:
            locale = await resolve_locale(interaction)
            bot = interaction.client
            shop_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={CommonFields.ID: interaction.guild_id}
            )
            if not shop_query:
                raise UserFeedbackError(t(locale, 'shop-error-no-shops'), message_id='shop-error-no-shops')

            channel_id = str(interaction.channel.id)
            if channel_id not in shop_query[ShopFields.SHOP_CHANNELS]:
                raise UserFeedbackError(
                    t(locale, 'shop-error-not-shop-channel'), message_id='shop-error-not-shop-channel'
                )

            shop_data = shop_query[ShopFields.SHOP_CHANNELS][channel_id]

            view = views.ShopBaseView(shop_data, channel_id=channel_id)
            await setup_view(view, interaction)
            await interaction.response.send_message(view=view, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


async def setup(bot):
    await bot.add_cog(Shop(bot))
