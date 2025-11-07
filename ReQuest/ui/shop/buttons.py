import discord
from discord import ButtonStyle
from discord.ui import Button

from ReQuest.utilities.supportFunctions import log_exception


class ShopItemButton(Button):
    def __init__(self, item):
        super().__init__(
            label=f'Buy for {item["price"]} {item["currency"]}',
            style=ButtonStyle.primary,
            custom_id=f'shop_item_button_{item['name']}'
        )
        self.item = item

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_message(f'You have purchased **{self.item['name']}** for '
                                                    f'**{self.item['price']}** {self.item['currency']}!')
        except Exception as e:
            await log_exception(e, interaction)
