import logging
import json
import io

import discord
from discord import ButtonStyle
from discord.ui import Button

from ReQuest.ui.config import modals
from ReQuest.ui.common import modals as common_modals
from ReQuest.ui.common.buttons import BaseViewButton
from ReQuest.ui.common.enums import ShopChannelType
from ReQuest.utilities.constants import (
    ConfigFields, ShopFields, CommonFields, RoleplayFields, CurrencyFields, DatabaseCollections
)
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
from ReQuest.utilities.supportFunctions import (
    log_exception,
    setup_view,
    get_cached_data,
    delete_cached_data,
    update_cached_data,
    get_xp_config,
    remove_item_stock_limit,
    encode_mongo_key,
    format_currency_amount
)

logger = logging.getLogger(__name__)


class QuestAnnounceRoleRemoveButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-clear'),
            style=ButtonStyle.danger,
            custom_id='quest_announce_role_remove_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            await delete_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.ANNOUNCE_ROLE,
                search_filter={'_id': interaction.guild_id}
            )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class GMRoleRemoveViewButton(BaseViewButton):
    def __init__(self, target_view_class):
        super().__init__(
            target_view_class=target_view_class,
            label=t(DEFAULT_LOCALE, 'config-btn-remove-gm-roles'),
            style=ButtonStyle.danger,
            custom_id='gm_role_remove_view_button'
        )


class RemoveGMRoleButton(Button):
    def __init__(self, calling_view, role_name):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-remove'),
            style=ButtonStyle.danger,
            custom_id=f'remove_gm_role_{role_name}'
        )
        self.calling_view = calling_view
        self.role_name = role_name

    async def callback(self, interaction: discord.Interaction):
        try:
            confirm_modal = common_modals.ConfirmModal(
                title=t(DEFAULT_LOCALE, 'config-modal-title-confirm-role-removal'),
                prompt_label=t(DEFAULT_LOCALE, 'config-modal-label-remove-role', **{'roleName': self.role_name}),
                prompt_placeholder=t(DEFAULT_LOCALE, 'common-confirm-placeholder'),
                confirm_callback=self._confirm_delete
            )
            await interaction.response.send_modal(confirm_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def _confirm_delete(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.GM_ROLES,
                query={'_id': interaction.guild_id},
                update_data={'$pull': {ConfigFields.GM_ROLES: {CommonFields.NAME: self.role_name}}}
            )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class QuestSummaryToggleButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-toggle-quest-summary'),
            style=ButtonStyle.primary,
            custom_id='quest_summary_toggle_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id

            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUEST_SUMMARY,
                query={'_id': guild_id}
            )

            if not query:
                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name=DatabaseCollections.QUEST_SUMMARY,
                    query={'_id': guild_id},
                    update_data={'$set': {'questSummary': True}}
                )
            else:
                if query.get('questSummary'):
                    await update_cached_data(
                        bot=bot,
                        mongo_database=bot.gdb,
                        collection_name=DatabaseCollections.QUEST_SUMMARY,
                        query={'_id': guild_id},
                        update_data={'$set': {'questSummary': False}}
                    )
                else:
                    await update_cached_data(
                        bot=bot,
                        mongo_database=bot.gdb,
                        collection_name=DatabaseCollections.QUEST_SUMMARY,
                        query={'_id': guild_id},
                        update_data={'$set': {'questSummary': True}}
                    )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class PlayerExperienceToggleButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-toggle-player-experience'),
            style=ButtonStyle.primary,
            custom_id='config_player_experience_toggle_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.PLAYER_EXPERIENCE,
                query={'_id': guild_id}
            )
            xp_state = query.get(ConfigFields.PLAYER_EXPERIENCE, True) if query else True
            if xp_state:
                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name=DatabaseCollections.PLAYER_EXPERIENCE,
                    query={'_id': guild_id},
                    update_data={'$set': {ConfigFields.PLAYER_EXPERIENCE: False}}
                )
            else:
                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name=DatabaseCollections.PLAYER_EXPERIENCE,
                    query={'_id': guild_id},
                    update_data={'$set': {ConfigFields.PLAYER_EXPERIENCE: True}}
                )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ToggleDoubleButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-toggle-display'),
            style=ButtonStyle.primary,
            custom_id='toggle_double_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            view = self.calling_view
            currency_name = view.currency_name

            new_value = not view.currency_data.get(CurrencyFields.IS_DOUBLE, False)

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={'_id': interaction.guild_id, f'{CurrencyFields.CURRENCIES}.{CommonFields.NAME}': currency_name},
                update_data={'$set': {f'{CurrencyFields.CURRENCIES}.$.{CurrencyFields.IS_DOUBLE}': new_value}}
            )

            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e)


class AddDenominationButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-add-denomination'),
            style=ButtonStyle.success,
            custom_id='add_denomination_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            new_modal = modals.AddCurrencyDenominationModal(
                calling_view=self.calling_view,
                base_currency_name=self.calling_view.currency_name
            )
            await interaction.response.send_modal(new_modal)
        except Exception as e:
            await log_exception(e)


class RemoveDenominationButton(Button):
    def __init__(self, calling_view, denomination_name):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-remove'),
            style=ButtonStyle.danger,
            custom_id=f'remove_denomination_button_{denomination_name}'
        )
        self.calling_view = calling_view
        self.denomination_name = denomination_name

    async def callback(self, interaction: discord.Interaction):
        try:
            confirm_modal = common_modals.ConfirmModal(
                title=t(DEFAULT_LOCALE, 'config-modal-title-confirm-removal'),
                prompt_label=t(DEFAULT_LOCALE, 'config-modal-label-remove-denomination', **{'denominationName': self.denomination_name}),
                prompt_placeholder=t(DEFAULT_LOCALE, 'common-confirm-placeholder'),
                confirm_callback=self._confirm_delete
            )
            await interaction.response.send_modal(confirm_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def _confirm_delete(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            currency_name = self.calling_view.currency_name
            denomination_name = self.denomination_name

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={'_id': interaction.guild_id, f'{CurrencyFields.CURRENCIES}.{CommonFields.NAME}': currency_name},
                update_data={'$pull': {f'{CurrencyFields.CURRENCIES}.$.{CurrencyFields.DENOMINATIONS}': {CommonFields.NAME: denomination_name}}}
            )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RenameDenominationButton(Button):
    def __init__(self, calling_view, denomination_name):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-rename'),
            style=ButtonStyle.secondary,
            custom_id=f'rename_denomination_button_{denomination_name}'
        )
        self.calling_view = calling_view
        self.denomination_name = denomination_name

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(
                modals.RenameDenominationModal(
                    self.calling_view,
                    self.calling_view.currency_name,
                    self.denomination_name
                )
            )
        except Exception as e:
            await log_exception(e, interaction)


class AddCurrencyButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-add-new-currency'),
            style=ButtonStyle.success,
            custom_id='add_currency_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(modals.AddCurrencyTextModal(self.calling_view))
        except Exception as e:
            await log_exception(e)


class ManageCurrencyButton(Button):
    def __init__(self, currency_name):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-manage'),
            style=ButtonStyle.primary,
            custom_id=f'manage_currency_button_{currency_name}'
        )
        self.currency_name = currency_name

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.config.views import ConfigEditCurrencyView
            view = ConfigEditCurrencyView(self.currency_name)
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveCurrencyButton(Button):
    def __init__(self, calling_view, currency_name):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-remove-currency'),
            style=ButtonStyle.danger,
            custom_id='remove_currency_button'
        )
        self.calling_view = calling_view
        self.currency_name = currency_name

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = common_modals.ConfirmModal(
                title=t(DEFAULT_LOCALE, 'config-modal-title-confirm-currency-removal'),
                prompt_label=t(DEFAULT_LOCALE, 'config-modal-label-remove-currency', **{'currencyName': self.currency_name}),
                prompt_placeholder=t(DEFAULT_LOCALE, 'common-confirm-placeholder'),
                confirm_callback=self._confirm_delete
            )
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def _confirm_delete(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            currency_name = self.currency_name

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={'_id': interaction.guild_id},
                update_data={'$pull': {CurrencyFields.CURRENCIES: {CommonFields.NAME: currency_name}}}
            )

            from ReQuest.ui.config.views import ConfigCurrencyView
            view = ConfigCurrencyView()
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class RenameCurrencyButton(Button):
    def __init__(self, calling_view, currency_name):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-rename'),
            style=ButtonStyle.secondary,
            custom_id='rename_currency_button'
        )
        self.calling_view = calling_view
        self.currency_name = currency_name

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(
                modals.RenameCurrencyModal(self.calling_view, self.currency_name)
            )
        except Exception as e:
            await log_exception(e, interaction)


class ClearChannelButton(Button):
    def __init__(self, calling_view, collection_name):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-clear'),
            style=ButtonStyle.danger,
            custom_id=f'clear_{collection_name}_channel_button'
        )
        self.calling_view = calling_view
        self.collection_name = collection_name

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            view = self.calling_view
            await delete_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=self.collection_name,
                search_filter={'_id': interaction.guild_id}
            )
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class ForbiddenRolesButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-forbidden-roles'),
            custom_id='forbidden_roles_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            current_roles = []
            config_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.FORBIDDEN_ROLES,
                query={'_id': interaction.guild_id}
            )
            if config_query and config_query[ConfigFields.FORBIDDEN_ROLES]:
                current_roles = config_query[ConfigFields.FORBIDDEN_ROLES]
            modal = modals.ForbiddenRolesModal(current_roles)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class PlayerBoardPurgeButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-purge-player-board'),
            style=ButtonStyle.danger,
            custom_id='player_board_purge_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.PlayerBoardPurgeModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class GMRewardsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-add-modify-rewards'),
            custom_id='gm_rewards_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.GMRewardsModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class AddShopWizardButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-add-shop-wizard'),
            style=ButtonStyle.success,
            custom_id='add_shop_wizard_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.config.views import ShopChannelTypeSelectionView
            view = ShopChannelTypeSelectionView()
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class TextChannelShopButton(Button):
    """Opens the existing text channel shop modal."""
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-select'),
            style=ButtonStyle.primary,
            custom_id='text_channel_shop_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(
                modals.ConfigShopDetailsModal(self.calling_view, channel_type='text')
            )
        except Exception as e:
            await log_exception(e, interaction)


class ForumThreadShopButton(Button):
    """Opens the forum thread shop setup view."""
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-select'),
            style=ButtonStyle.primary,
            custom_id='forum_thread_shop_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.config.views import ForumShopSetupView
            view = ForumShopSetupView()
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class CreateNewForumThreadButton(Button):
    """Opens modal to create a new forum thread for the shop."""
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-continue'),
            style=ButtonStyle.success,
            custom_id='create_new_forum_thread_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            if not self.calling_view.selected_forum:
                await interaction.response.send_message(
                    t(DEFAULT_LOCALE, 'config-error-select-forum-first'),
                    ephemeral=True
                )
                return

            await interaction.response.send_modal(
                modals.ForumThreadShopModal(self.calling_view, self.calling_view.selected_forum)
            )
        except Exception as e:
            await log_exception(e, interaction)


class UseExistingThreadButton(Button):
    """Opens modal to configure shop in an existing forum thread."""
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-continue'),
            style=ButtonStyle.success,
            custom_id='use_existing_thread_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            if not self.calling_view.selected_thread:
                await interaction.response.send_message(
                    t(DEFAULT_LOCALE, 'config-error-select-thread-first'),
                    ephemeral=True
                )
                return

            await interaction.response.send_modal(
                modals.ConfigShopDetailsModal(
                    self.calling_view,
                    channel_type=ShopChannelType.FORUM_THREAD.value,
                    parent_forum_id=str(self.calling_view.selected_forum.id),
                    preselected_channel=self.calling_view.selected_thread
                )
            )
        except Exception as e:
            await log_exception(e, interaction)


class AddShopJSONButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-add-shop-json'),
            style=ButtonStyle.success,
            custom_id='add_shop_json_button',
            row=2
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(modals.ConfigShopJSONModal(self.calling_view))
        except Exception as e:
            await log_exception(e, interaction)


class ManageShopNavButton(Button):
    def __init__(self, channel_id, shop_data, label, style=ButtonStyle.primary):
        super().__init__(
            label=label,
            style=style,
            custom_id=f'{label}_shop_{channel_id}'
        )
        self.channel_id = channel_id
        self.shop_data = shop_data

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.config.views import ManageShopView
            view = ManageShopView(self.channel_id, self.shop_data)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class EditShopButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-edit-shop-wizard'),
            style=ButtonStyle.primary,
            custom_id='edit_shop_wizard_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={'_id': interaction.guild_id}
            )
            shop_data = query.get(ShopFields.SHOP_CHANNELS, {}).get(self.calling_view.selected_channel_id)

            if not shop_data:
                await interaction.response.send_message(t(DEFAULT_LOCALE, 'config-error-shop-data-not-found'), ephemeral=True)
                return

            from ReQuest.ui.config.views import EditShopView

            view = EditShopView(self.calling_view.selected_channel_id, shop_data)
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveShopButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-remove-shop'),
            style=ButtonStyle.danger,
            custom_id='remove_shop_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            confirm_modal = common_modals.ConfirmModal(
                title=t(DEFAULT_LOCALE, 'config-modal-title-confirm-shop-removal'),
                prompt_label=t(DEFAULT_LOCALE, 'config-modal-label-shop-removal-warning'),
                prompt_placeholder=t(DEFAULT_LOCALE, 'common-confirm-placeholder'),
                confirm_callback=self._confirm_delete
            )
            await interaction.response.send_modal(confirm_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def _confirm_delete(self, interaction: discord.Interaction):
        try:
            view = self.calling_view

            bot = interaction.client
            guild_id = interaction.guild_id
            channel_id = view.selected_channel_id

            # Get shop data to check if it's a forum thread
            shop_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={'_id': guild_id}
            )

            shop_data = {}
            if shop_query:
                shop_data = shop_query.get(ShopFields.SHOP_CHANNELS, {}).get(channel_id, {})
            channel_type = shop_data.get(ShopFields.CHANNEL_TYPE, 'text')

            # Archive and lock if forum thread
            if channel_type == ShopChannelType.FORUM_THREAD.value:
                try:
                    thread = bot.get_channel(int(channel_id))
                    if not thread:
                        thread = await bot.fetch_channel(int(channel_id))
                    if thread and isinstance(thread, discord.Thread):
                        await thread.edit(archived=True, locked=True)
                except discord.NotFound:
                    logger.warning(f"Thread {channel_id} not found - may have been deleted already")
                except Exception as e:
                    logger.warning(f"Could not archive thread {channel_id}: {e}")

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={'_id': guild_id},
                update_data={'$unset': {f'{ShopFields.SHOP_CHANNELS}.{channel_id}': ''}}
            )

            from ReQuest.ui.config.views import ConfigShopsView
            new_view = ConfigShopsView()
            await setup_view(new_view, interaction)
            await interaction.response.edit_message(view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class EditShopItemButton(Button):
    def __init__(self, item: dict, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-edit'),
            style=ButtonStyle.primary,
            custom_id=f"edit_shop_item_{item[CommonFields.NAME]}"
        )
        self.item = item
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.ShopItemModal(
                calling_view=self.calling_view,
                existing_item=self.item
            )
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class DeleteShopItemButton(Button):
    def __init__(self, item: dict, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-delete'),
            style=ButtonStyle.danger,
            custom_id=f"delete_shop_item_{item[CommonFields.NAME]}"
        )
        self.item = item
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            channel_id = self.calling_view.channel_id
            item_name = self.item[CommonFields.NAME]

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={'_id': guild_id},
                update_data={'$pull': {f'{ShopFields.SHOP_CHANNELS}.{channel_id}.{ShopFields.SHOP_STOCK}': {CommonFields.NAME: item_name}}}
            )

            new_stock = [item for item in self.calling_view.all_stock if item[CommonFields.NAME] != item_name]
            self.calling_view.update_stock(new_stock)

            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class AddItemButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-add-item'),
            style=ButtonStyle.success,
            custom_id='add_shop_item_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(modals.ShopItemModal(self.calling_view))
        except Exception as e:
            await log_exception(e, interaction)


class EditShopDetailsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-edit-shop-details'),
            style=ButtonStyle.secondary,
            custom_id='edit_shop_details_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.ConfigShopDetailsModal(
                calling_view=self.calling_view,
                existing_shop_data=self.calling_view.shop_data,
                existing_channel_id=self.calling_view.channel_id
            )
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class DownloadShopJSONButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-download-json'),
            style=ButtonStyle.secondary,
            custom_id='download_shop_json_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            channel_id = self.calling_view.selected_channel_id

            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={'_id': guild_id}
            )
            shop_data = query.get(ShopFields.SHOP_CHANNELS, {}).get(channel_id)

            if not shop_data:
                raise Exception('Shop data not found.')

            shop_name = shop_data.get(ShopFields.SHOP_NAME, "shop")
            file_name = f"{shop_name.replace(' ', '_')}_{channel_id}.json"

            json_string = json.dumps(shop_data, indent=4)
            json_bytes = io.BytesIO(json_string.encode('utf-8'))

            shop_file = discord.File(json_bytes, filename=file_name)

            await interaction.response.send_message(
                t(DEFAULT_LOCALE, 'config-msg-shop-json-download', **{'shopName': shop_name}),
                file=shop_file,
                ephemeral=True
            )

        except Exception as e:
            await log_exception(e, interaction)


class UpdateShopJSONButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-edit-shop-json'),
            style=ButtonStyle.primary,
            custom_id='edit_shop_json_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(
                modals.ConfigUpdateShopJSONModal(self.calling_view)
            )
        except Exception as e:
            await log_exception(e, interaction)


class ScanServerButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-scan-server-configs'),
            style=ButtonStyle.success,
            custom_id='scan_server_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.defer()
            await self.calling_view.run_scan(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class AddNewCharacterShopItemButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-add-item'),
            style=ButtonStyle.success,
            custom_id='add_new_character_shop_item_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            item_modal = modals.NewCharacterShopItemModal(self.calling_view, self.calling_view.inventory_type)
            await interaction.response.send_modal(item_modal)
        except Exception as e:
            await log_exception(e, interaction)


class EditNewCharacterShopItemButton(Button):
    def __init__(self, item: dict, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-edit'),
            style=ButtonStyle.primary,
            custom_id=f"edit_new_character_shop_item_{item[CommonFields.NAME]}"
        )
        self.item = item
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.calling_view
            item_modal = modals.NewCharacterShopItemModal(view, view.inventory_type, self.item)
            await interaction.response.send_modal(item_modal)
        except Exception as e:
            await log_exception(e, interaction)


class DeleteNewCharacterShopItemButton(Button):
    def __init__(self, item: dict, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-delete'),
            style=ButtonStyle.danger,
            custom_id=f"delete_new_character_shop_item_{item[CommonFields.NAME]}"
        )
        self.item = item
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            item_name = self.item[CommonFields.NAME]

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.NEW_CHARACTER_SHOP,
                query={'_id': guild_id},
                update_data={'$pull': {ShopFields.SHOP_STOCK: {CommonFields.NAME: item_name}}}
            )

            new_stock = [item for item in self.calling_view.all_stock if item[CommonFields.NAME] != item_name]
            self.calling_view.update_stock(new_stock)
            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class NewCharacterShopJSONButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-upload-json'),
            style=ButtonStyle.success,
            custom_id='upload_new_character_shop_json_button',
            row=1
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(modals.NewCharacterShopJSONModal(self.calling_view))
        except Exception as e:
            await log_exception(e, interaction)


class DownloadNewCharacterShopJSONButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-download-json'),
            style=ButtonStyle.secondary,
            custom_id='download_new_character_shop_json_button',
            row=1
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id

            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.NEW_CHARACTER_SHOP,
                query={'_id': guild_id}
            )

            shop_data = {ShopFields.SHOP_STOCK: query.get(ShopFields.SHOP_STOCK, []) if query else []}

            file_name = f"new_character_shop_{guild_id}.json"
            json_string = json.dumps(shop_data, indent=4)
            json_bytes = io.BytesIO(json_string.encode('utf-8'))

            shop_file = discord.File(json_bytes, filename=file_name)

            await interaction.response.send_message(
                t(DEFAULT_LOCALE, 'config-msg-new-char-shop-json-download'),
                file=shop_file,
                ephemeral=True
            )
        except Exception as e:
            await log_exception(e, interaction)


class ConfigNewCharacterWealthButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-configure-new-character-wealth'),
            style=ButtonStyle.primary,
            custom_id='config_new_character_wealth_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            current_wealth = self.calling_view.new_character_wealth
            current_currency = current_wealth.get('currency') if current_wealth else None
            formatted_amount = None
            if current_wealth and current_currency:
                raw_amount = current_wealth.get('amount')
                if raw_amount is not None:
                    formatted_amount = format_currency_amount(
                        raw_amount, current_currency, self.calling_view.currency_config
                    )
            modal = modals.ConfigNewCharacterWealthModal(
                self.calling_view,
                current_amount=formatted_amount,
                current_currency=current_currency
            )
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


# ----- Static Kits -----


class AddStaticKitButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-create-new-kit'),
            style=ButtonStyle.success,
            custom_id='add_static_kit_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(modals.CreateStaticKitModal(self.calling_view))
        except Exception as e:
            await log_exception(e, interaction)


class EditStaticKitButton(Button):
    def __init__(self, kit_id, kit_data):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-edit'),
            style=ButtonStyle.secondary,
            custom_id=f'edit_static_kit_button_{kit_id}'
        )
        self.kit_id = kit_id
        self.kit_data = kit_data

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.config.views import EditStaticKitView

            currency_config = getattr(self.view, 'currency_config', None)
            if not currency_config:
                bot = interaction.client
                currency_config = await get_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name=DatabaseCollections.CURRENCY,
                    query={'_id': interaction.guild_id}
                )

            edit_view = EditStaticKitView(self.kit_id, self.kit_data, currency_config)
            await interaction.response.edit_message(view=edit_view)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveStaticKitButton(Button):
    def __init__(self, kit_id, kit_name):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-delete-kit'),
            style=ButtonStyle.danger,
            custom_id=f'remove_static_kit_button_{kit_id}'
        )
        self.kit_id = kit_id
        self.kit_name = kit_name

    async def callback(self, interaction: discord.Interaction):
        try:
            confirm_modal = common_modals.ConfirmModal(
                title=t(DEFAULT_LOCALE, 'config-modal-title-confirm-kit-deletion'),
                prompt_label=t(DEFAULT_LOCALE, 'config-modal-label-kit-deletion-warning'),
                prompt_placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-type-confirm'),
                confirm_callback=self._confirm_delete
            )
            await interaction.response.send_modal(confirm_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def _confirm_delete(self, interaction: discord.Interaction):
        try:
            bot = interaction.client

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.STATIC_KITS,
                query={'_id': interaction.guild_id},
                update_data={'$unset': {f'kits.{self.kit_id}': ''}}
            )

            from ReQuest.ui.config.views import ConfigStaticKitsView
            new_view = ConfigStaticKitsView()
            await setup_view(new_view, interaction)
            await interaction.response.edit_message(view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class AddKitItemButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-add-item'),
            style=ButtonStyle.success,
            custom_id='add_kit_item_btn'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(modals.StaticKitItemModal(self.calling_view))
        except Exception as e:
            await log_exception(e, interaction)


class EditKitItemButton(Button):
    def __init__(self, calling_view, item, index):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-edit'),
            style=ButtonStyle.secondary,
            custom_id=f'edit_kit_item_{index}'
        )
        self.calling_view = calling_view
        self.item = item
        self.index = index

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(
                modals.StaticKitItemModal(self.calling_view, self.item, self.index)
            )
        except Exception as e:
            await log_exception(e, interaction)


class DeleteKitItemButton(Button):
    def __init__(self, calling_view, index):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-delete'),
            style=ButtonStyle.danger,
            custom_id=f'del_kit_item_{index}'
        )
        self.calling_view = calling_view
        self.index = index

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            kit_id = self.calling_view.kit_id

            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.STATIC_KITS,
                query={'_id': interaction.guild_id}
            )
            items = query['kits'][kit_id].get(CommonFields.ITEMS, [])

            if 0 <= self.index < len(items):
                del items[self.index]

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.STATIC_KITS,
                query={'_id': interaction.guild_id},
                update_data={'$set': {f'kits.{kit_id}.{CommonFields.ITEMS}': items}}
            )

            self.calling_view.kit_data[CommonFields.ITEMS] = items
            self.calling_view.items = items
            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class AddKitCurrencyButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-add-currency'),
            style=ButtonStyle.success,
            custom_id='add_kit_curr_btn'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(modals.StaticKitCurrencyModal(self.calling_view))
        except Exception as e:
            await log_exception(e, interaction)


class DeleteKitCurrencyButton(Button):
    def __init__(self, calling_view, currency_name):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'common-btn-delete'),
            style=ButtonStyle.danger,
            custom_id=f'del_kit_curr_{currency_name}'
        )
        self.calling_view = calling_view
        self.currency_name = currency_name

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            kit_id = self.calling_view.kit_id

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.STATIC_KITS,
                query={'_id': interaction.guild_id},
                update_data={'$unset': {f'kits.{kit_id}.currency.{encode_mongo_key(self.currency_name)}': ''}}
            )

            encoded_currency = encode_mongo_key(self.currency_name)
            if encoded_currency in self.calling_view.kit_data.get('currency', {}):
                del self.calling_view.kit_data['currency'][encoded_currency]

            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayToggleEnableButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-toggle-rp-rewards'),
            custom_id='rp_toggle_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            current_state = self.calling_view.config.get(RoleplayFields.ENABLED, False)
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.ROLEPLAY_CONFIG,
                query={'_id': interaction.guild_id},
                update_data={'$set': {RoleplayFields.ENABLED: not current_state}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayClearChannelsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-clear-channels'),
            style=ButtonStyle.danger,
            custom_id='rp_clear_channels_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.ROLEPLAY_CONFIG,
                query={'_id': interaction.guild_id},
                update_data={'$set': {RoleplayFields.CHANNELS: []}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplaySettingsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-edit-settings'),
            style=ButtonStyle.primary,
            custom_id='rp_settings_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(modals.RoleplaySettingsModal(self.calling_view))
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayRewardsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-configure-rewards'),
            style=ButtonStyle.primary,
            custom_id='rp_rewards_button')
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            xp_enabled = await get_xp_config(interaction.client, interaction.guild_id)
            rp_modal = modals.RoleplayRewardsModal(self.calling_view, xp_enabled)
            await interaction.response.send_modal(rp_modal)
        except Exception as e:
            await log_exception(e, interaction)


class ConfigStockLimitsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-stock-limits'),
            style=ButtonStyle.secondary,
            custom_id='config_stock_limits_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.config.views import ConfigStockLimitsView

            view = ConfigStockLimitsView(
                self.calling_view.channel_id,
                self.calling_view.shop_data
            )
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class SetItemStockButton(Button):
    def __init__(self, item: dict, calling_view, current_stock: int | None = None):
        # Determine label based on whether limit exists
        has_limit = item.get(ShopFields.MAX_STOCK) is not None
        label = t(DEFAULT_LOCALE, 'config-btn-edit-limit') if has_limit else t(DEFAULT_LOCALE, 'config-btn-set-limit')

        super().__init__(
            label=label,
            style=ButtonStyle.primary,
            custom_id=f"set_stock_{item[CommonFields.NAME]}"
        )
        self.item = item
        self.calling_view = calling_view
        self.current_stock = current_stock

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.SetItemStockModal(
                calling_view=self.calling_view,
                item_name=self.item[CommonFields.NAME],
                current_max=self.item.get(ShopFields.MAX_STOCK),
                current_stock=self.current_stock
            )
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveItemStockLimitButton(Button):
    def __init__(self, item: dict, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-remove-limit'),
            style=ButtonStyle.danger,
            custom_id=f"remove_stock_limit_{item[CommonFields.NAME]}"
        )
        self.item = item
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            confirm_modal = common_modals.ConfirmModal(
                title=t(DEFAULT_LOCALE, 'config-modal-title-confirm-remove-stock-limit'),
                prompt_label=t(DEFAULT_LOCALE, 'config-modal-label-remove-stock-limit'),
                prompt_placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-type-confirm'),
                confirm_callback=self._confirm_callback
            )
            await interaction.response.send_modal(confirm_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def _confirm_callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            channel_id = self.calling_view.channel_id
            item_name = self.item[CommonFields.NAME]

            # Update shop config to remove maxStock from item
            shop_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={'_id': guild_id}
            )
            shop_data = shop_query.get(ShopFields.SHOP_CHANNELS, {}).get(channel_id, {})
            shop_stock = shop_data.get(ShopFields.SHOP_STOCK, [])

            # Find and update the item
            for item in shop_stock:
                if item.get(CommonFields.NAME) == item_name:
                    if ShopFields.MAX_STOCK in item:
                        del item[ShopFields.MAX_STOCK]
                    break

            # Save shop config
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={'_id': guild_id},
                update_data={'$set': {f'{ShopFields.SHOP_CHANNELS}.{channel_id}': shop_data}}
            )

            # Remove from runtime stock tracking
            await remove_item_stock_limit(bot, guild_id, channel_id, item_name)

            # Refresh the view
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RestockScheduleButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-configure-restock-schedule'),
            style=ButtonStyle.primary,
            custom_id='restock_schedule_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            current_config = self.calling_view.shop_data.get(ShopFields.RESTOCK_CONFIG)
            modal = modals.RestockScheduleModal(
                calling_view=self.calling_view,
                current_config=current_config
            )
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class BackToEditShopButton(Button):
    def __init__(self, channel_id: str, shop_data: dict):
        super().__init__(
            label=t(DEFAULT_LOCALE, 'config-btn-back-to-shop-editor'),
            style=ButtonStyle.secondary,
            custom_id='back_to_edit_shop_button'
        )
        self.channel_id = channel_id
        self.shop_data = shop_data

    async def callback(self, interaction: discord.Interaction):
        try:
            from ReQuest.ui.config.views import EditShopView

            view = EditShopView(self.channel_id, self.shop_data)
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)
