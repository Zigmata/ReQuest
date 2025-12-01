import logging

import discord
from discord import ButtonStyle
from discord.ui import Button
from titlecase import titlecase

from ReQuest.ui.player import modals
from ReQuest.utilities.supportFunctions import log_exception, setup_view

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class RegisterCharacterButton(Button):
    def __init__(self):
        super().__init__(
            label='Register',
            style=ButtonStyle.success,
            custom_id='register_character_button'
        )

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.CharacterRegisterModal()
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class SpendCurrencyButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Spend Currency',
            style=ButtonStyle.primary,
            custom_id='spend_currency_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.SpendCurrencyModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class CreatePlayerPostButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Create Post',
            style=ButtonStyle.success,
            custom_id='create_player_post_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.CreatePlayerPostModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class RemovePlayerPostButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Remove Post',
            style=ButtonStyle.danger,
            custom_id='remove_player_post_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.calling_view.remove_post(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class EditPlayerPostButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Edit Post',
            custom_id='edit_player_post_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.EditPlayerPostModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class OpenStartingShopButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Open Starting Shop',
            style=ButtonStyle.primary,
            custom_id='open_starting_shop_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.player.views import NewCharacterShopView
            view = NewCharacterShopView(
                self.calling_view.character_id,
                self.calling_view.character_name,
                self.calling_view.inventory_type
            )
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class SelectStaticKitButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Select Kit',
            style=ButtonStyle.primary,
            custom_id='select_static_kit_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.player.views import StaticKitSelectView
            view = StaticKitSelectView(
                self.calling_view.character_id,
                self.calling_view.character_name
            )
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class OpenInventoryInputButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Input Inventory',
            style=ButtonStyle.primary,
            custom_id='open_inv_input_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(modals.OpenInventoryInputModal(self.calling_view))
        except Exception as e:
            await log_exception(e, interaction)


class WizardItemButton(Button):
    def __init__(self, item, inventory_type):
        label = f'Add to cart'
        if inventory_type == 'purchase':
            if item.get('price') and item.get('currency'):
                label += f' ({item["price"]} {titlecase(item["currency"])})'

        super().__init__(
            label=label,
            style=ButtonStyle.success,
            custom_id=f'wiz_item_{item["name"]}'
        )
        self.item = item

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.view.add_to_cart(interaction, self.item)
        except Exception as e:
            await log_exception(e, interaction)


class WizardViewCartButton(Button):
    def __init__(self, calling_view, count=0):
        super().__init__(
            label=f'Review & Submit ({count})',
            style=ButtonStyle.success,
            custom_id='wiz_view_cart_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.player.views import NewCharacterCartView
            view = NewCharacterCartView(self.calling_view)
            view.build_view()
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class WizardSubmitButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Submit Character',
            style=ButtonStyle.success,
            custom_id='wiz_submit_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.calling_view.submit(interaction)
        except Exception as e:
            await log_exception(e, interaction)

class RemoveCharacterButton(Button):
    def __init__(self):
        super().__init__(
            label='Remove Character',
            style=ButtonStyle.danger,
            custom_id='remove_character_button'
        )

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.player.views import RemoveCharacterView
            view = RemoveCharacterView()
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class WizardKeepShoppingButton(Button):
    def __init__(self, shop_view):
        super().__init__(
            label='Keep Shopping',
            style=ButtonStyle.secondary,
            custom_id='wiz_keep_shopping_button'
        )
        self.shop_view = shop_view

    async def callback(self, interaction: discord.Interaction):
        try:
            self.shop_view.build_view()
            await interaction.response.edit_message(view=self.shop_view)
        except Exception as e:
            await log_exception(e, interaction)


class WizardEditCartItemButton(Button):
    def __init__(self, item_key, quantity):
        super().__init__(
            label='Edit Quantity',
            style=ButtonStyle.secondary,
            custom_id=f'wiz_edit_cart_{item_key}'
        )
        self.item_key = item_key
        self.quantity = quantity

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.WizardEditCartItemModal(self.view, self.item_key, self.quantity)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class WizardClearCartButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Clear Cart',
            style=ButtonStyle.danger,
            custom_id='wiz_clear_cart_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            self.calling_view.shop_view.cart.clear()
            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ConsumeItemButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Consume/Destroy Item',
            style=ButtonStyle.danger,
            custom_id='consume_item_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.ConsumeItemModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)
