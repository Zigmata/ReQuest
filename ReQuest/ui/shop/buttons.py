import discord
from discord import ButtonStyle
from discord.ui import Button

from ReQuest.ui.shop import modals
from ReQuest.utilities.supportFunctions import (
    log_exception,
    get_cached_data,
    UserFeedbackError,
    clear_cart_and_release_stock,
    get_shop_stock,
    get_cart,
    get_item_stock
)


class ShopItemButton(Button):
    def __init__(self, item, cost_string='Free', stock_info=None):
        """
        Button to add item to cart or view purchase options.

        :param item: The item dictionary
        :param cost_string: Formatted cost string for display
        :param stock_info: Dict with 'available' and 'reserved' counts, or None if unlimited
        """
        costs = item.get('costs', [])

        # Check if out of stock
        is_out_of_stock = False
        if stock_info is not None:
            available = stock_info.get('available', 0)
            if available <= 0:
                is_out_of_stock = True

        if is_out_of_stock:
            label = 'Out of Stock'
            style = ButtonStyle.secondary
            disabled = True
        elif len(costs) > 1:
            label = 'View Purchase Options'
            style = ButtonStyle.success
            disabled = False
        else:
            label = f'Add to Cart ({cost_string})'
            style = ButtonStyle.success
            disabled = False

        super().__init__(
            label=label,
            style=style,
            custom_id=f'shop_item_button_{item["name"]}',
            disabled=disabled
        )
        self.item = item
        self.stock_info = stock_info

    async def callback(self, interaction: discord.Interaction):
        try:
            # Double-check stock availability (in case UI is stale)
            item_name = self.item['name']
            channel_id = str(interaction.channel_id)
            self.stock_info = await get_item_stock(interaction.client, interaction.guild_id, channel_id, item_name)
            if self.stock_info is not None and self.stock_info.get('available', 0) <= 0:
                raise UserFeedbackError(f'**{self.item["name"]}** is out of stock.')

            costs = self.item.get('costs', [])
            if len(costs) > 1:
                from ReQuest.ui.shop.views import ComplexItemPurchaseView
                view = ComplexItemPurchaseView(self.view, self.item)
                await interaction.response.edit_message(view=view)
            else:
                await self.view.add_to_cart_with_option(interaction, self.item, 0)
        except Exception as e:
            await log_exception(e, interaction)


class SelectCostOptionButton(Button):
    def __init__(self, shop_view, item, index):
        super().__init__(
            label="Select",
            style=ButtonStyle.primary,
            custom_id=f'sel_opt_{item["name"]}_{index}'
        )
        self.shop_view = shop_view
        self.item = item
        self.index = index

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.shop_view.add_to_cart_with_option(interaction, self.item, self.index)
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

            # Ensure user context is set up on calling view
            if not self.calling_view.user_id:
                await self.calling_view.setup_for_user(interaction)

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

            # Load cart from database
            channel_id = self.calling_view.channel_id
            db_cart = await get_cart(bot, guild_id, user_id, channel_id)
            if db_cart:
                self.calling_view.cart = db_cart.get('items', {})

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
            bot = interaction.client
            guild_id = interaction.guild_id
            user_id = interaction.user.id
            prev_view = self.calling_view.prev_view
            channel_id = prev_view.channel_id

            # Clear cart from database and release reserved stock
            await clear_cart_and_release_stock(bot, guild_id, user_id, channel_id)

            # Clear local cart cache
            prev_view.cart.clear()

            # Refresh stock info
            prev_view.stock_info = await get_shop_stock(bot, guild_id, channel_id)

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
