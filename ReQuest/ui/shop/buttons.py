import discord
from discord import ButtonStyle
from discord.ui import Button
from titlecase import titlecase

from ReQuest.utilities.supportFunctions import log_exception, get_cached_data

from ReQuest.ui.shop import modals


class ShopItemButton(Button):
    def __init__(self, item):
        super().__init__(
            label=f'Add to Cart ({item["price"]} {titlecase(item["currency"])})',
            style=ButtonStyle.success,
            custom_id=f'shop_item_button_{item["name"]}'
        )
        self.item = item

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.view.add_to_cart(interaction, self.item)
        except Exception as e:
            await log_exception(e, interaction)


class ViewCartButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='View Cart',
            style=ButtonStyle.success,
            custom_id='view_cart_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.shop.views import ShopCartView

            bot = interaction.client
            guild_id = interaction.guild_id
            user_id = interaction.user.id

            currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='currency',
                query={'_id': guild_id}
            )

            character_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': user_id}
            )
            active_character = None
            if character_query and str(guild_id) in character_query.get('activeCharacters', {}):
                character_id = character_query['activeCharacters'][str(guild_id)]
                active_character = character_query['characters'].get(character_id)

            view = ShopCartView(self.calling_view, currency_config, active_character)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class CartBackButton(Button):
    def __init__(self, target_view):
        super().__init__(
            label='Back to Shop',
            style=ButtonStyle.secondary,
            custom_id='cart_back_button'
        )
        self.target_view = target_view

    async def callback(self, interaction: discord.Interaction):
        try:
            self.target_view.build_view()
            await interaction.response.edit_message(view=self.target_view)
        except Exception as e:
            await log_exception(e, interaction)


class CartClearButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Clear Cart',
            style=ButtonStyle.danger,
            custom_id='cart_clear_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            self.calling_view.prev_view.cart.clear()
            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class CartCheckoutButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Checkout',
            style=ButtonStyle.success,
            custom_id='cart_checkout_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.calling_view.checkout(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class EditCartItemButton(Button):
    def __init__(self, item_key, quantity):
        super().__init__(
            label='Edit Quantity',
            style=ButtonStyle.secondary,
            custom_id=f'edit_cart_item_button_{item_key}'
        )
        self.item_key = item_key
        self.quantity = quantity

    async def callback(self, interaction: discord.Interaction):
        try:
            edit_modal = modals.EditCartItemModal(self.view, self.item_key, self.quantity)
            await interaction.response.send_modal(edit_modal)
        except Exception as e:
            await log_exception(e, interaction)
