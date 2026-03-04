import discord
from discord.ui import Modal

from ReQuest.utilities.constants import CartFields
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
from ReQuest.utilities.supportFunctions import (
    log_exception,
    update_cart_item_quantity,
    get_cart,
    get_shop_stock,
    UserFeedbackError
)


class EditCartItemModal(Modal):
    def __init__(self, cart_view, item_key, current_quantity):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'shop-modal-title-edit-cart-qty'),
        )
        self.cart_view = cart_view
        self.item_key = item_key
        self.current_quantity = current_quantity

        self.quantity_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'shop-modal-label-quantity'),
            default=str(current_quantity),
            min_length=1,
            max_length=5,
            placeholder=t(DEFAULT_LOCALE, 'shop-modal-placeholder-quantity'),
            custom_id='cart_quantity_text_input'
        )
        self.add_item(self.quantity_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            if not self.quantity_text_input.value.isdigit():
                locale = getattr(self, 'locale', DEFAULT_LOCALE)
                await interaction.response.send_message(
                    t(locale, 'shop-error-invalid-number'), ephemeral=True
                )
                return

            new_quantity = int(self.quantity_text_input.value)
            prev_view = self.cart_view.prev_view
            bot = interaction.client
            guild_id = interaction.guild_id
            user_id = interaction.user.id
            channel_id = prev_view.channel_id

            # Use database-backed cart update with stock handling
            success, message = await update_cart_item_quantity(
                bot, guild_id, user_id, channel_id, self.item_key, new_quantity
            )

            if not success:
                raise UserFeedbackError(message)

            # Refresh local cart cache from database
            db_cart = await get_cart(bot, guild_id, user_id, channel_id)
            if db_cart:
                prev_view.cart = db_cart.get(CartFields.ITEMS, {})
            else:
                prev_view.cart = {}

            # Refresh stock info
            prev_view.stock_info = await get_shop_stock(bot, guild_id, channel_id)

            self.cart_view.build_view()
            await interaction.response.edit_message(view=self.cart_view)
        except Exception as e:
            await log_exception(e, interaction)
