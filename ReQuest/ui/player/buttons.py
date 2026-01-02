import logging

import discord
from discord import ButtonStyle
from discord.ui import Button

from ReQuest.ui.common import modals as common_modals
from ReQuest.ui.player import modals
from ReQuest.utilities.supportFunctions import (
    log_exception,
    setup_view,
    attempt_delete,
    build_cache_key,
    get_cached_data,
    update_cached_data,
    delete_cached_data
)

logger = logging.getLogger(__name__)


# ----- CHARACTER MANAGEMENT -----

class RegisterCharacterButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Register New Character',
            style=ButtonStyle.success,
            custom_id='register_character_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.CharacterRegisterModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveCharacterButton(Button):
    def __init__(self, calling_view, character_id, character_name):
        super().__init__(
            label='Remove',
            style=ButtonStyle.danger,
            custom_id=f'remove_character_{character_id}'
        )
        self.calling_view = calling_view
        self.character_id = character_id
        self.character_name = character_name

    async def callback(self, interaction: discord.Interaction):
        try:
            confirm_modal = common_modals.ConfirmModal(
                title='Confirm Character Removal',
                prompt_label=f'Delete {self.character_name}?',
                prompt_placeholder='Type CONFIRM to proceed.',
                confirm_callback=self._confirm_delete
            )
            await interaction.response.send_modal(confirm_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def _confirm_delete(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            member_id = interaction.user.id

            # Remove character from db
            await update_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': member_id},
                update_data={'$unset': {f'characters.{self.character_id}': ''}}
            )

            # Unset active character if it was the one removed
            character_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': member_id}
            )
            if character_query and 'activeCharacters' in character_query:
                updates = {}
                for guild_id, active_character_id in character_query['activeCharacters'].items():
                    if active_character_id == self.character_id:
                        updates[f'activeCharacters.{guild_id}'] = ''

                if updates:
                    await update_cached_data(
                        bot=bot,
                        mongo_database=bot.mdb,
                        collection_name='characters',
                        query={'_id': member_id},
                        update_data={'$unset': updates}
                    )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ActivateCharacterButton(Button):
    def __init__(self, calling_view, character_id, disabled=False):
        super().__init__(
            label='Activate',
            style=ButtonStyle.primary,
            custom_id=f'activate_character_{character_id}',
            disabled=disabled
        )
        self.character_id = character_id
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client

            await update_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': interaction.user.id},
                update_data={'$set': {f'activeCharacters.{interaction.guild_id}': self.character_id}}
            )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


# ----- PLAYER BOARD -----


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
    def __init__(self, calling_view, post):
        super().__init__(
            label='Remove',
            style=ButtonStyle.danger,
            custom_id=f'remove_player_post_button_{post.get("postId")}')
        self.calling_view = calling_view
        self.post = post

    async def callback(self, interaction: discord.Interaction):
        try:
            confirm_modal = common_modals.ConfirmModal(
                title='Confirm Post Removal',
                prompt_label=f'WARNING: This action is irreversible!',
                prompt_placeholder='Type CONFIRM to proceed.',
                confirm_callback=self._confirm_delete
            )
            await interaction.response.send_modal(confirm_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def _confirm_delete(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            post_id = self.post.get('postId')
            message_id = self.post.get('messageId')
            guild_id = interaction.guild_id

            # Delete from db
            await delete_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='playerBoard',
                search_filter={'guildId': guild_id, 'postId': post_id},
                cache_id=f'{guild_id}:{post_id}'
            )

            # Delete the post message
            channel_id = self.calling_view.player_board_channel_id
            if channel_id:
                channel = interaction.client.get_channel(channel_id)
                if channel:
                    try:
                        message = channel.get_partial_message(message_id)
                        await attempt_delete(message)
                    except discord.NotFound:
                        logger.warning(f"Message {message_id} not found for deletion.")
                    except Exception as e:
                        logger.error(f"Error deleting message {message_id}: {e}")

            # Invalidate the cached list
            cache_id = f'{guild_id}:{interaction.user.id}'
            redis_key = build_cache_key(interaction.client.gdb.name, cache_id, 'playerBoard')

            await interaction.client.rdb.delete(redis_key)

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class EditPlayerPostButton(Button):
    def __init__(self, calling_view, post):
        super().__init__(
            label='Edit',
            custom_id=f'edit_player_post_button_{post.get("postId")}'
        )
        self.calling_view = calling_view
        self.post = post

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.EditPlayerPostModal(self.calling_view, self.post)
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
    def __init__(self, item, inventory_type, cost_string='Free'):
        label = f'Add to Cart'
        costs = item.get('costs', [])

        if inventory_type == 'purchase':
            if len(costs) > 1:
                label = 'View Purchase Options'
            else:
                label = f'Add to Cart ({cost_string})'

        super().__init__(
            label=label,
            style=ButtonStyle.success,
            custom_id=f'wiz_item_{item["name"]}'
        )
        self.item = item

    async def callback(self, interaction: discord.Interaction):
        try:
            costs = self.item.get('costs', [])
            if len(costs) > 1 and self.view.inventory_type == 'purchase':
                from ReQuest.ui.player.views import NewCharacterComplexItemPurchaseView
                view = NewCharacterComplexItemPurchaseView(self.view, self.item)
                await interaction.response.edit_message(view=view)
            else:
                await self.view.add_to_cart_with_option(interaction, self.item, 0)
        except Exception as e:
            await log_exception(e, interaction)


class WizardSelectCostOptionButton(Button):
    def __init__(self, shop_view, item, index):
        super().__init__(
            label="Select",
            style=ButtonStyle.primary,
            custom_id=f'wiz_sel_opt_{item["name"]}_{index}'
        )
        self.shop_view = shop_view
        self.item = item
        self.index = index

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.shop_view.add_to_cart_with_option(interaction, self.item, self.index)
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


# ----- INVENTORY MANAGEMENT -----


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


class SelectKitOptionButton(Button):
    def __init__(self, kit_id, kit_data):
        super().__init__(
            label='Select',
            style=ButtonStyle.primary,
            custom_id=f'sel_kit_{kit_id}'
        )
        self.kit_id = kit_id
        self.kit_data = kit_data

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.player.views import StaticKitConfirmView

            view = StaticKitConfirmView(
                self.view.character_id,
                self.view.character_name,
                self.kit_id,
                self.kit_data,
                self.view.currency_config
            )
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class KitConfirmButton(Button):
    def __init__(self):
        super().__init__(
            label='Confirm Selection',
            style=ButtonStyle.success,
            custom_id='confirm_kit_btn'
        )

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.view.submit(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class KitBackButton(Button):
    def __init__(self):
        super().__init__(
            label='Back to Kits',
            style=ButtonStyle.secondary,
            custom_id='kit_back_btn'
        )

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.player.views import StaticKitSelectView

            view = StaticKitSelectView(
                self.view.character_id,
                self.view.character_name
            )
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class PrintInventoryButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Print Inventory',
            style=ButtonStyle.secondary,
            custom_id='print_inventory_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            character_name = self.calling_view.active_character['name']
            items = self.calling_view.items
            currencies = self.calling_view.currencies
            inventory_embed = discord.Embed(
                title=f"{character_name}'s Inventory",
                color=discord.Color.blue()
            )
            inventory_embed.add_field(name='Items', value='\n'.join(items) or 'None', inline=False)
            inventory_embed.add_field(name='Currencies', value='\n'.join(currencies) or 'None', inline=False)
            await interaction.response.send_message(embed=inventory_embed)
        except Exception as e:
            await log_exception(e, interaction)
