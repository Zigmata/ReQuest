import logging
import math

import discord
from discord.ui import (
    LayoutView,
    ActionRow,
    Container,
    TextDisplay,
    Section,
    Separator,
    Thumbnail,
    Button
)

from ReQuest.ui.common import modals as common_modals
from ReQuest.ui.shop import buttons


class ShopBaseView(LayoutView):
    def __init__(self, shop_data):
        super().__init__(timeout=None)
        self.shop_data = shop_data
        self.all_stock = self.shop_data.get('shopStock', [])
        self.items_per_page = 9
        self.current_page = 0
        self.total_pages = math.ceil(len(self.all_stock) / self.items_per_page)

        self.build_view()

    def build_view(self):
        try:
            self.clear_items()
            container = Container()
            header_items = []

            if shop_name := self.shop_data.get('shopName'):
                header_items.append(TextDisplay(f'**{shop_name}**'))
            if shop_keeper := self.shop_data.get('shopKeeper'):
                header_items.append(TextDisplay(f'Shopkeeper: **{shop_keeper}**'))
            if shop_description := self.shop_data.get('shopDescription'):
                header_items.append(TextDisplay(f'*{shop_description}*'))

            if shop_image := self.shop_data.get('shopImage'):
                shop_image = Thumbnail(media=f'{shop_image}')
                shop_header = Section(accessory=shop_image)

                for item in header_items:
                    shop_header.add_item(item)

                container.add_item(shop_header)
            else:
                for item in header_items:
                    container.add_item(item)

            container.add_item(Separator())

            start_index = self.current_page * self.items_per_page
            end_index = start_index + self.items_per_page
            current_stock = self.all_stock[start_index:end_index]

            for item in current_stock:
                buy_button = buttons.ShopItemButton(item)
                section = Section(accessory=buy_button)

                item_name = item.get('name', 'Unknown Item')
                item_description = item.get('description', None)
                item_quantity = item.get('quantity', 1)
                item_display_name = f'{item_name} x{item_quantity}' if item_quantity > 1 else item_name
                if item_description:
                    section.add_item(TextDisplay(f'**{item_display_name}**\n*{item_description}*'))
                else:
                    section.add_item(TextDisplay(f'**{item_display_name}**'))
                container.add_item(section)

            self.add_item(container)

            # Pagination buttons
            if self.total_pages > 1:
                pagination_row = ActionRow()

                prev_button = Button(
                    label='Previous',
                    style=discord.ButtonStyle.secondary,
                    custom_id='shop_prev_page',
                    disabled=(self.current_page == 0)
                )
                prev_button.callback = self.prev_page

                page_display = Button(
                    label=f'Page {self.current_page + 1} of {self.total_pages}',
                    style=discord.ButtonStyle.secondary,
                    custom_id='shop_page_display'
                )
                page_display.callback = self.show_page_jump_modal

                next_button = Button(
                    label='Next',
                    style=discord.ButtonStyle.primary,
                    custom_id='shop_next_page',
                    disabled=(self.current_page >= self.total_pages - 1)
                )
                next_button.callback = self.next_page

                pagination_row.add_item(prev_button)
                pagination_row.add_item(page_display)
                pagination_row.add_item(next_button)

                self.add_item(pagination_row)
        except Exception as e:
            logging.error(f'Error building shop view: {e}')

    async def prev_page(self, interaction: discord.Interaction):
        if self.current_page > 0:
            self.current_page -= 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def next_page(self, interaction: discord.Interaction):
        if self.current_page < self.total_pages - 1:
            self.current_page += 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def show_page_jump_modal(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(common_modals.PageJumpModal(self))
        except Exception as e:
            logging.error(f'Failed to send PageJumpModal: {e}')
            await interaction.response.send_message('Could not open page selector', ephemeral=True)
