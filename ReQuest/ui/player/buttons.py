import logging

import discord
from discord import ButtonStyle
from discord.ui import Button

from ReQuest.ui.common import modals as common_modals
from ReQuest.ui.common.enums import InventoryType
from ReQuest.ui.player import modals
from ReQuest.utilities.constants import CharacterFields, CommonFields, ContainerFields, ShopFields, DatabaseCollections
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
from ReQuest.utilities.supportFunctions import (
    log_exception,
    setup_view,
    attempt_delete,
    build_cache_key,
    get_cached_data,
    update_cached_data,
    delete_cached_data,
    move_item_between_containers,
    format_inventory_by_container,
    UserFeedbackError,
    get_container_items,
    delete_container,
    reorder_container
)

logger = logging.getLogger(__name__)


# ----- CHARACTER MANAGEMENT -----

class RegisterCharacterButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'player-btn-register-character'),
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
            label=t(DEFAULT_LOCALE, 'common-btn-remove'),
            style=ButtonStyle.danger,
            custom_id=f'remove_character_{character_id}'
        )
        self.calling_view = calling_view
        self.character_id = character_id
        self.character_name = character_name

    async def callback(self, interaction: discord.Interaction):
        try:
            locale = getattr(self.calling_view, 'locale', DEFAULT_LOCALE)
            confirm_modal = common_modals.ConfirmModal(
                title=t(locale, 'player-modal-title-confirm-char-removal'),
                prompt_label=t(locale, 'player-modal-label-confirm-char-delete', characterName=self.character_name),
                prompt_placeholder=t(locale, 'common-confirm-placeholder'),
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
                collection_name=DatabaseCollections.CHARACTERS,
                query={CommonFields.ID: member_id},
                update_data={'$unset': {f'{CharacterFields.CHARACTERS}.{self.character_id}': ''}}
            )

            # Unset active character if it was the one removed
            character_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name=DatabaseCollections.CHARACTERS,
                query={CommonFields.ID: member_id}
            )
            if character_query and CharacterFields.ACTIVE_CHARACTERS in character_query:
                updates = {}
                for guild_id, active_character_id in character_query[CharacterFields.ACTIVE_CHARACTERS].items():
                    if active_character_id == self.character_id:
                        updates[f'{CharacterFields.ACTIVE_CHARACTERS}.{guild_id}'] = ''

                if updates:
                    await update_cached_data(
                        bot=bot,
                        mongo_database=bot.mdb,
                        collection_name=DatabaseCollections.CHARACTERS,
                        query={CommonFields.ID: member_id},
                        update_data={'$unset': updates}
                    )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ActivateCharacterButton(Button):
    def __init__(self, calling_view, character_id, disabled=False):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'player-btn-activate'),
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
                collection_name=DatabaseCollections.CHARACTERS,
                query={CommonFields.ID: interaction.user.id},
                update_data={'$set': {f'{CharacterFields.ACTIVE_CHARACTERS}.{interaction.guild_id}': self.character_id}}
            )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


# ----- PLAYER BOARD -----


class CreatePlayerPostButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'player-btn-create-post'),
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
            label=t(DEFAULT_LOCALE, 'common-btn-remove'),
            style=ButtonStyle.danger,
            custom_id=f'remove_player_post_button_{post.get("postId")}')
        self.calling_view = calling_view
        self.post = post

    async def callback(self, interaction: discord.Interaction):
        try:
            locale = getattr(self.calling_view, 'locale', DEFAULT_LOCALE)
            confirm_modal = common_modals.ConfirmModal(
                title=t(locale, 'player-modal-title-confirm-post-removal'),
                prompt_label=t(locale, 'player-modal-label-post-removal-warning'),
                prompt_placeholder=t(locale, 'common-confirm-placeholder'),
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
                collection_name=DatabaseCollections.PLAYER_BOARD,
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
            redis_key = build_cache_key(interaction.client.gdb.name, cache_id, DatabaseCollections.PLAYER_BOARD)

            await interaction.client.rdb.delete(redis_key)

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class EditPlayerPostButton(Button):
    def __init__(self, calling_view, post):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-edit'),
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
            label=t(DEFAULT_LOCALE, 'player-btn-open-starting-shop'),
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
            label=t(DEFAULT_LOCALE, 'player-btn-select-kit'),
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
            label=t(DEFAULT_LOCALE, 'player-btn-input-inventory'),
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
        label = t(DEFAULT_LOCALE, 'player-btn-add-to-cart')
        costs = item.get(ShopFields.COSTS, [])

        if inventory_type == InventoryType.PURCHASE.value:
            if len(costs) > 1:
                label = t(DEFAULT_LOCALE, 'player-btn-view-purchase-options')
            else:
                label = t(DEFAULT_LOCALE, 'player-btn-add-to-cart-cost', costString=cost_string)

        super().__init__(
            label=label,
            style=ButtonStyle.success,
            custom_id=f'wiz_item_{item[CommonFields.NAME]}'
        )
        self.item = item

    async def callback(self, interaction: discord.Interaction):
        try:
            costs = self.item.get(ShopFields.COSTS, [])
            if len(costs) > 1 and self.view.inventory_type == InventoryType.PURCHASE.value:
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
            label=t(DEFAULT_LOCALE, 'common-btn-select'),
            style=ButtonStyle.primary,
            custom_id=f'wiz_sel_opt_{item[CommonFields.NAME]}_{index}'
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
            label=t(DEFAULT_LOCALE, 'player-btn-review-submit', count=count),
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
            label=t(DEFAULT_LOCALE, 'player-btn-submit-character'),
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
            label=t(DEFAULT_LOCALE, 'player-btn-keep-shopping'),
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
            label=t(DEFAULT_LOCALE, 'player-btn-edit-quantity'),
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
            label=t(DEFAULT_LOCALE, 'player-btn-clear-cart'),
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


class SpendCurrencyButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'player-btn-spend-currency'),
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
            label=t(DEFAULT_LOCALE, 'common-btn-select'),
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
            label=t(DEFAULT_LOCALE, 'player-btn-confirm-selection'),
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
            label=t(DEFAULT_LOCALE, 'player-btn-back-to-kits'),
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
            label=t(DEFAULT_LOCALE, 'player-btn-print-inventory'),
            style=ButtonStyle.secondary,
            custom_id='print_inventory_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            locale = getattr(self.calling_view, 'locale', DEFAULT_LOCALE)
            character_name = self.calling_view.active_character[CommonFields.NAME]
            formatted = format_inventory_by_container(
                self.calling_view.active_character,
                self.calling_view.currency_config
            )

            inventory_embed = discord.Embed(
                title=t(locale, 'player-embed-title-inventory', characterName=character_name),
                description=formatted,
                color=discord.Color.blue()
            )
            await interaction.response.send_message(embed=inventory_embed)
        except Exception as e:
            await log_exception(e, interaction)


# ----- CONTAINER MANAGEMENT -----


class ManageContainersButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'player-btn-manage-containers'),
            style=ButtonStyle.secondary,
            custom_id='manage_containers_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.player.views import ContainerManagementView
            view = ContainerManagementView(
                self.calling_view.active_character_id,
                self.calling_view.active_character
            )
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class CreateContainerButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'player-btn-create-new'),
            style=ButtonStyle.success,
            custom_id='create_container_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.CreateContainerModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class RenameContainerButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-rename'),
            style=ButtonStyle.secondary,
            custom_id='rename_container_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            container_id = self.calling_view.selected_container_id
            if container_id is None:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'player-error-cannot-rename-loose'),
                    message_id='player-error-cannot-rename-loose'
                )

            # Get current name
            containers = self.calling_view.character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CONTAINERS, {})
            current_name = containers.get(container_id, {}).get(ContainerFields.NAME, '')

            modal = modals.RenameContainerModal(self.calling_view, container_id, current_name)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class DeleteContainerButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-delete'),
            style=ButtonStyle.danger,
            custom_id='delete_container_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            locale = getattr(self.calling_view, 'locale', DEFAULT_LOCALE)
            container_id = self.calling_view.selected_container_id
            if container_id is None:
                raise UserFeedbackError(
                    t(locale, 'player-error-cannot-delete-loose'),
                    message_id='player-error-cannot-delete-loose'
                )

            items = get_container_items(self.calling_view.character_data, container_id)
            item_count = len(items)

            containers = self.calling_view.character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CONTAINERS, {})
            container_name = containers.get(container_id, {}).get(ContainerFields.NAME, t(locale, 'common-label-unknown'))

            if item_count > 0:
                prompt_label = t(locale, 'player-modal-label-container-has-items', itemCount=item_count)
            else:
                prompt_label = t(locale, 'player-modal-label-confirm-container-delete', containerName=container_name)

            confirm_modal = common_modals.ConfirmModal(
                title=t(locale, 'player-modal-title-confirm-container-delete'),
                prompt_label=prompt_label,
                prompt_placeholder=t(locale, 'common-confirm-placeholder'),
                confirm_callback=self._confirm_delete
            )
            await interaction.response.send_modal(confirm_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def _confirm_delete(self, interaction: discord.Interaction):
        try:
            await delete_container(
                interaction.client,
                interaction.user.id,
                self.calling_view.character_id,
                self.calling_view.selected_container_id
            )

            self.calling_view.selected_container_id = None
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class MoveContainerUpButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'player-btn-up'),
            style=ButtonStyle.secondary,
            custom_id='move_container_up_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await reorder_container(
                interaction.client,
                interaction.user.id,
                self.calling_view.character_id,
                self.calling_view.selected_container_id,
                -1  # Move up
            )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class MoveContainerDownButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'player-btn-down'),
            style=ButtonStyle.secondary,
            custom_id='move_container_down_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await reorder_container(
                interaction.client,
                interaction.user.id,
                self.calling_view.character_id,
                self.calling_view.selected_container_id,
                1  # Move down
            )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ConsumeFromContainerButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'player-btn-consume-destroy'),
            style=ButtonStyle.danger,
            custom_id='consume_from_container_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            item_name = self.calling_view.selected_item
            items = get_container_items(
                self.calling_view.character_data,
                self.calling_view.container_id
            )

            # Find quantity (case-insensitive)
            max_qty = 0
            for name, qty in items.items():
                if name.lower() == item_name.lower():
                    max_qty = qty
                    break

            modal = modals.ConsumeFromContainerModal(self.calling_view, item_name, max_qty)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class MoveItemButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'player-btn-move'),
            style=ButtonStyle.primary,
            custom_id='move_item_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.player.views import MoveDestinationView

            item_name = self.calling_view.selected_item
            items = get_container_items(
                self.calling_view.character_data,
                self.calling_view.container_id
            )

            # Find quantity (case-insensitive)
            max_qty = 0
            for name, qty in items.items():
                if name.lower() == item_name.lower():
                    max_qty = qty
                    break

            view = MoveDestinationView(
                self.calling_view,
                item_name,
                max_qty
            )
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class MoveAllButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'player-btn-move-all'),
            style=ButtonStyle.success,
            custom_id='move_all_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.player.views import ContainerItemsView

            await move_item_between_containers(
                interaction.client,
                interaction.user.id,
                self.calling_view.source_view.character_id,
                self.calling_view.item_name,
                self.calling_view.available_quantity,
                self.calling_view.source_container_id,
                self.calling_view.selected_destination
            )

            # Return to source container view
            view = ContainerItemsView(
                self.calling_view.source_view.character_id,
                self.calling_view.source_view.character_data,
                self.calling_view.source_container_id
            )
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class MoveSomeButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'player-btn-move-some'),
            style=ButtonStyle.secondary,
            custom_id='move_some_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.MoveItemQuantityModal(
                self.calling_view,
                self.calling_view.item_name,
                self.calling_view.available_quantity
            )
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class BackToInventoryOverviewButton(Button):
    def __init__(self):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'player-btn-back-to-overview'),
            style=ButtonStyle.secondary,
            custom_id='back_to_inv_overview_button'
        )

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.player.views import InventoryOverviewView
            view = InventoryOverviewView()
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class CancelMoveButton(Button):
    def __init__(self, source_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'player-btn-cancel-move'),
            style=ButtonStyle.secondary,
            custom_id='cancel_move_button'
        )
        self.source_view = source_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await setup_view(self.source_view, interaction)
            await interaction.response.edit_message(view=self.source_view)
        except Exception as e:
            await log_exception(e, interaction)
