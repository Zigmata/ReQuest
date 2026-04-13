import discord
from ReQuest.ui.common.modals import LocaleModal

from ReQuest.utilities.constants import CartFields, DiscordLimits
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
from ReQuest.utilities.exceptions import UserFeedbackError, log_exception
from ReQuest.utilities.db_cache import run_in_transaction
from ReQuest.utilities.shop import update_cart_item_quantity, get_cart, get_shop_stock


class EditCartItemModal(LocaleModal):
    def __init__(self, cart_view, item_key, current_quantity):
        locale = getattr(cart_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'shop-modal-title-edit-cart-qty')[:DiscordLimits.MODAL_TITLE],
        )
        self.cart_view = cart_view
        self.item_key = item_key
        self.current_quantity = current_quantity

        self.quantity_text_input = discord.ui.TextInput(
            default=str(current_quantity),
            min_length=1,
            max_length=5,
            placeholder=t(locale, 'shop-modal-placeholder-quantity')[:DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            custom_id='cart_quantity_text_input'
        )
        self.quantity_label = discord.ui.Label(
            text=t(locale, 'shop-modal-label-quantity')[:DiscordLimits.LABEL_LABEL],
            component=self.quantity_text_input
        )
        self.add_item(self.quantity_label)

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

            success, message = await run_in_transaction(
                bot, lambda s: update_cart_item_quantity(
                    bot, guild_id, user_id, channel_id, self.item_key, new_quantity,
                    session=s, locale=self._locale
                )
            )

            if not success:
                raise UserFeedbackError(message)

            db_cart = await get_cart(bot, guild_id, user_id, channel_id)
            if db_cart:
                prev_view.cart = db_cart.get(CartFields.ITEMS, {})
            else:
                prev_view.cart = {}

            prev_view.stock_info = await get_shop_stock(bot, guild_id, channel_id)

            self.cart_view.build_view()
            await interaction.response.edit_message(view=self.cart_view)
        except Exception as e:
            await log_exception(e, interaction)
