import logging

import discord
import shortuuid
from discord import TextDisplay
from discord.ui import (
    LayoutView,
    ActionRow,
    Container,
    TextDisplay,
    Section,
    Separator,
    Thumbnail
)
from ReQuest.ui.shop import buttons


class ShopBaseView(LayoutView):
    def __init__(self, shop_data):
        super().__init__(timeout=None)

        container = Container()

        header_items = []

        if shop_name := shop_data.get('shopName'):
            header_items.append(TextDisplay(f'**{shop_name}**'))
        if shop_keeper := shop_data.get('shopKeeper'):
            header_items.append(TextDisplay(f'Shopkeeper: **{shop_keeper}**'))
        if shop_description := shop_data.get('shopDescription'):
            header_items.append(TextDisplay(f'*{shop_description}*'))

        if shop_image := shop_data.get('shopImage'):
            shop_image = Thumbnail(media=f'{shop_image}')
            shop_header = Section(accessory=shop_image)

            for item in header_items:
                shop_header.add_item(item)

            container.add_item(shop_header)
        else:
            for item in header_items:
                container.add_item(item)

        if header_items:
            container.add_item(Separator())

        for item in shop_data.get('shopStock', []):
            buy_button = buttons.ShopItemButton(item)
            section = Section(accessory=buy_button)

            item_name = item.get('name', 'Unknown Item')
            item_description = item.get('description', 'No description available.')
            section.add_item(TextDisplay(f'**{item_name}**\n{item_description}'))
            container.add_item(section)

        self.add_item(container)
