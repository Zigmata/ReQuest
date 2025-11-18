from discord import app_commands
from discord.ext import commands
from discord.ext.commands import Cog

from ReQuest.ui.shop import views
from ReQuest.utilities.supportFunctions import log_exception


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
            collection = interaction.client.gdb['shops']
            shop_query = await collection.find_one({'_id': interaction.guild_id})

            channel_id = str(interaction.channel.id)
            if channel_id not in shop_query['shopChannels']:
                raise Exception('This channel is not registered as a shop channel.\n'
                                'If you think there is supposed to be a shop here, let your server admin know.')

            shop_data = shop_query['shopChannels'][channel_id]

            view = views.ShopBaseView(shop_data)
            await interaction.response.send_message(view=view, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


async def setup(bot):
    await bot.add_cog(Shop(bot))
