import discord
from discord import ButtonStyle
from discord.ui import Button

from ReQuest.ui.shop import modals
from ReQuest.utilities.constants import (
    CharacterFields, ShopFields, CommonFields, CartFields, DatabaseCollections, DiscordLimits
)
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
from ReQuest.utilities.db_cache import get_cached_data
from ReQuest.utilities.exceptions import UserFeedbackError, log_exception
from ReQuest.utilities.shop import clear_cart_and_release_stock, get_shop_stock, get_cart, get_item_stock


class ShopItemButton(Button):
    def __init__(self, item, cost_string='Free', stock_info=None, locale=None):
        """
        Button to add item to cart or view purchase options.

        :param item: The item dictionary
        :param cost_string: Formatted cost string for display
        :param stock_info: Dict with ShopFields.AVAILABLE and ShopFields.RESERVED counts, or None if unlimited
        :param locale: Locale for translation
        """
        locale = locale or DEFAULT_LOCALE
        costs = item.get(ShopFields.COSTS, [])

        is_out_of_stock = False
        if stock_info is not None and ShopFields.AVAILABLE in stock_info:
            available = stock_info.get(ShopFields.AVAILABLE, 0)
            if available <= 0:
                is_out_of_stock = True

        if is_out_of_stock:
            label = t(locale, 'shop-btn-out-of-stock')[:DiscordLimits.BUTTON_LABEL]
            style = ButtonStyle.secondary
            disabled = True
        elif len(costs) > 1:
            label = t(locale, 'shop-btn-view-options')[:DiscordLimits.BUTTON_LABEL]
            style = ButtonStyle.success
            disabled = False
        else:
            label = t(locale, 'shop-btn-add-to-cart', cost=cost_string)[:DiscordLimits.BUTTON_LABEL]
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
            item_name = self.item[CommonFields.NAME]
            channel_id = self.view.channel_id or str(interaction.channel_id)
            self.stock_info = await get_item_stock(interaction.client, interaction.guild_id, channel_id, item_name)
            if (self.stock_info is not None
                    and ShopFields.AVAILABLE in self.stock_info
                    and self.stock_info.get(ShopFields.AVAILABLE, 0) <= 0):
                locale = getattr(self.view, 'locale', DEFAULT_LOCALE)
                raise UserFeedbackError(
                    t(locale, 'shop-error-item-out-of-stock', itemName=self.item[CommonFields.NAME]),
                    message_id='shop-error-item-out-of-stock'
                )

            costs = self.item.get(ShopFields.COSTS, [])
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
        locale = getattr(shop_view, 'locale', DEFAULT_LOCALE)
        super().__init__(
            label=t(locale, 'common-btn-select')[:DiscordLimits.BUTTON_LABEL],
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
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        super().__init__(
            label=t(locale, 'shop-btn-view-cart')[:DiscordLimits.BUTTON_LABEL],
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

            if not self.calling_view.user_id:
                await self.calling_view.setup_for_user(interaction)

            currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={'_id': guild_id}
            )

            character_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name=DatabaseCollections.CHARACTERS,
                query={'_id': user_id}
            )
            active_character = None
            if character_query and str(guild_id) in character_query.get(CharacterFields.ACTIVE_CHARACTERS, {}):
                character_id = character_query[CharacterFields.ACTIVE_CHARACTERS][str(guild_id)]
                active_character = character_query[CharacterFields.CHARACTERS].get(character_id)

            channel_id = self.calling_view.channel_id
            db_cart = await get_cart(bot, guild_id, user_id, channel_id)
            if db_cart:
                self.calling_view.cart = db_cart.get(CartFields.ITEMS, {})

            view = ShopCartView(self.calling_view, currency_config, active_character)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class CartBackButton(Button):
    def __init__(self, target_view):
        locale = getattr(target_view, 'locale', DEFAULT_LOCALE)
        super().__init__(
            label=t(locale, 'shop-btn-back-to-shop')[:DiscordLimits.BUTTON_LABEL],
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
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        super().__init__(
            label=t(locale, 'shop-btn-clear-cart')[:DiscordLimits.BUTTON_LABEL],
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

            await clear_cart_and_release_stock(bot, guild_id, user_id, channel_id)

            prev_view.cart.clear()

            prev_view.stock_info = await get_shop_stock(bot, guild_id, channel_id)

            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class CartCheckoutButton(Button):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        super().__init__(
            label=t(locale, 'shop-btn-checkout')[:DiscordLimits.BUTTON_LABEL],
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
    def __init__(self, item_key, quantity, locale=None):
        locale = locale or DEFAULT_LOCALE
        super().__init__(
            label=t(locale, 'shop-btn-edit-quantity')[:DiscordLimits.BUTTON_LABEL],
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
