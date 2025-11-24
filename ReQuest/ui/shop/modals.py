import discord
from discord.ui import Modal

from ReQuest.utilities.supportFunctions import log_exception


class EditCartItemModal(Modal):
    def __init__(self, cart_view, item_key, current_quantity):
        super().__init__(
            title='Edit Cart Quantity',
        )
        self.cart_view = cart_view
        self.item_key = item_key

        self.quantity_input = discord.ui.TextInput(
            label='Quantity',
            default=str(current_quantity),
            min_length=1,
            max_length=5,
            placeholder='Enter the new quantity for this item',
            custom_id='cart_quantity_input'
        )
        self.add_item(self.quantity_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            if not self.quantity_input.value.isdigit():
                await interaction.response.send_message('Please enter a valid number.', ephemeral=True)
                return

            new_quantity = int(self.quantity_input.value)
            cart = self.cart_view.prev_view.cart

            if new_quantity <= 0:
                if self.item_key in cart:
                    del cart[self.item_key]
            else:
                cart[self.item_key]['quantity'] = new_quantity

            self.cart_view.build_view()
            await interaction.response.edit_message(view=self.cart_view)
        except Exception as e:
            await log_exception(e, interaction)