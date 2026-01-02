import logging
import json
import io

import discord
from discord import ButtonStyle
from discord.ui import Button

from ReQuest.ui.config import modals
from ReQuest.ui.common import modals as common_modals
from ReQuest.ui.common.buttons import BaseViewButton
from ReQuest.utilities.supportFunctions import (
    log_exception,
    setup_view,
    get_cached_data,
    delete_cached_data,
    update_cached_data,
    get_xp_config, remove_item_stock_limit
)

logger = logging.getLogger(__name__)


class QuestAnnounceRoleRemoveButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Clear',
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
                collection_name='announceRole',
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
            label='Remove GM Roles',
            style=ButtonStyle.danger,
            custom_id='gm_role_remove_view_button'
        )


class RemoveGMRoleButton(Button):
    def __init__(self, calling_view, role_name):
        super().__init__(
            label='Remove',
            style=ButtonStyle.danger,
            custom_id=f'remove_gm_role_{role_name}'
        )
        self.calling_view = calling_view
        self.role_name = role_name

    async def callback(self, interaction: discord.Interaction):
        try:
            confirm_modal = common_modals.ConfirmModal(
                title='Confirm Role Removal',
                prompt_label=f'Remove {self.role_name}?',
                prompt_placeholder='Type CONFIRM to proceed',
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
                collection_name='gmRoles',
                query={'_id': interaction.guild_id},
                update_data={'$pull': {'gmRoles': {'name': self.role_name}}}
            )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class QuestSummaryToggleButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Toggle Quest Summary',
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
                collection_name='questSummary',
                query={'_id': guild_id}
            )

            if not query:
                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name='questSummary',
                    query={'_id': guild_id},
                    update_data={'$set': {'questSummary': True}}
                )
            else:
                if query['questSummary']:
                    await update_cached_data(
                        bot=bot,
                        mongo_database=bot.gdb,
                        collection_name='questSummary',
                        query={'_id': guild_id},
                        update_data={'$set': {'questSummary': False}}
                    )
                else:
                    await update_cached_data(
                        bot=bot,
                        mongo_database=bot.gdb,
                        collection_name='questSummary',
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
            label='Toggle Player Experience',
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
                collection_name='playerExperience',
                query={'_id': guild_id}
            )
            xp_state = query['playerExperience'] if query else True
            if xp_state:
                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name='playerExperience',
                    query={'_id': guild_id},
                    update_data={'$set': {'playerExperience': False}}
                )
            else:
                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name='playerExperience',
                    query={'_id': guild_id},
                    update_data={'$set': {'playerExperience': True}}
                )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ToggleDoubleButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Toggle Display',
            style=ButtonStyle.primary,
            custom_id='toggle_double_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            view = self.calling_view
            currency_name = view.currency_name

            new_value = not view.currency_data.get('isDouble', False)

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='currency',
                query={'_id': interaction.guild_id, 'currencies.name': currency_name},
                update_data={'$set': {'currencies.$.isDouble': new_value}}
            )

            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e)


class AddDenominationButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Add Denomination',
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
            label='Remove',
            style=ButtonStyle.danger,
            custom_id=f'remove_denomination_button_{denomination_name}'
        )
        self.calling_view = calling_view
        self.denomination_name = denomination_name

    async def callback(self, interaction: discord.Interaction):
        try:
            confirm_modal = common_modals.ConfirmModal(
                title='Confirm Removal',
                prompt_label=f'Remove {self.denomination_name}?',
                prompt_placeholder='Type CONFIRM to proceed',
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
                collection_name='currency',
                query={'_id': interaction.guild_id, 'currencies.name': currency_name},
                update_data={'$pull': {f'currencies.$.denominations': {'name': denomination_name}}}
            )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class AddCurrencyButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Add New Currency',
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
            label='Manage',
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
            label='Remove Currency',
            style=ButtonStyle.danger,
            custom_id='remove_currency_button'
        )
        self.calling_view = calling_view
        self.currency_name = currency_name

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = common_modals.ConfirmModal(
                title='Confirm Currency Removal',
                prompt_label=f'Remove {self.currency_name}?',
                prompt_placeholder='Type CONFIRM to proceed',
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
                collection_name='currency',
                query={'_id': interaction.guild_id},
                update_data={'$pull': {'currencies': {'name': currency_name}}}
            )

            from ReQuest.ui.config.views import ConfigCurrencyView
            view = ConfigCurrencyView()
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class ClearChannelButton(Button):
    def __init__(self, calling_view, collection_name):
        super().__init__(
            label='Clear',
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
            label='Forbidden Roles',
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
                collection_name='forbiddenRoles',
                query={'_id': interaction.guild_id}
            )
            if config_query and config_query['forbiddenRoles']:
                current_roles = config_query['forbiddenRoles']
            modal = modals.ForbiddenRolesModal(current_roles)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class PlayerBoardPurgeButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Purge Player Board',
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
            label='Add/Modify Rewards',
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
            label='Add Shop (Wizard)',
            style=ButtonStyle.success,
            custom_id='add_shop_wizard_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(modals.ConfigShopDetailsModal(self.calling_view))
        except Exception as e:
            await log_exception(e, interaction)


class AddShopJSONButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Add Shop (JSON)',
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
            label='Edit Shop (Wizard)',
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
                collection_name='shops',
                query={'_id': interaction.guild_id}
            )
            shop_data = query.get('shopChannels', {}).get(self.calling_view.selected_channel_id)

            if not shop_data:
                await interaction.response.send_message('Error: Could not find that shop\'s data.', ephemeral=True)
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
            label='Remove Shop',
            style=ButtonStyle.danger,
            custom_id='remove_shop_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            confirm_modal = common_modals.ConfirmModal(
                title='Confirm Shop Removal',
                prompt_label='WARNING: This action is irreversible!',
                prompt_placeholder='Type CONFIRM to proceed',
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

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='shops',
                query={'_id': guild_id},
                update_data={'$unset': {f'shopChannels.{channel_id}': ''}}
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
            label='Edit',
            style=ButtonStyle.primary,
            custom_id=f"edit_shop_item_{item['name']}"
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
            label='Delete',
            style=ButtonStyle.danger,
            custom_id=f"delete_shop_item_{item['name']}"
        )
        self.item = item
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            channel_id = self.calling_view.channel_id
            item_name = self.item['name']

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='shops',
                query={'_id': guild_id},
                update_data={'$pull': {f'shopChannels.{channel_id}.shopStock': {'name': item_name}}}
            )

            new_stock = [item for item in self.calling_view.all_stock if item['name'] != item_name]
            self.calling_view.update_stock(new_stock)

            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class AddItemButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Add Item',
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
            label='Edit Shop Details',
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
            label='Download JSON',
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
                collection_name='shops',
                query={'_id': guild_id}
            )
            shop_data = query.get('shopChannels', {}).get(channel_id)

            if not shop_data:
                raise Exception('Shop data not found.')

            shop_name = shop_data.get("shopName", "shop")
            file_name = f"{shop_name.replace(' ', '_')}_{channel_id}.json"

            json_string = json.dumps(shop_data, indent=4)
            json_bytes = io.BytesIO(json_string.encode('utf-8'))

            shop_file = discord.File(json_bytes, filename=file_name)

            await interaction.response.send_message(
                f"Here is the JSON definition for **{shop_name}**.",
                file=shop_file,
                ephemeral=True
            )

        except Exception as e:
            await log_exception(e, interaction)


class UpdateShopJSONButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Edit Shop (JSON)',
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
            label='Scan Server Configs',
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
            label='Add Item',
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
            label='Edit',
            style=ButtonStyle.primary,
            custom_id=f"edit_new_character_shop_item_{item['name']}"
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
            label='Delete',
            style=ButtonStyle.danger,
            custom_id=f"delete_new_character_shop_item_{item['name']}"
        )
        self.item = item
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            item_name = self.item['name']

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='newCharacterShop',
                query={'_id': guild_id},
                update_data={'$pull': {'shopStock': {'name': item_name}}}
            )

            new_stock = [item for item in self.calling_view.all_stock if item['name'] != item_name]
            self.calling_view.update_stock(new_stock)
            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class NewCharacterShopJSONButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Upload JSON',
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
            label='Download JSON',
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
                collection_name='newCharacterShop',
                query={'_id': guild_id}
            )

            shop_data = {'shopStock': query.get('shopStock', []) if query else []}

            file_name = f"new_character_shop_{guild_id}.json"
            json_string = json.dumps(shop_data, indent=4)
            json_bytes = io.BytesIO(json_string.encode('utf-8'))

            shop_file = discord.File(json_bytes, filename=file_name)

            await interaction.response.send_message(
                "Here is the JSON definition for the New Character Shop.",
                file=shop_file,
                ephemeral=True
            )
        except Exception as e:
            await log_exception(e, interaction)


class ConfigNewCharacterWealthButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Configure New Character Wealth',
            style=ButtonStyle.primary,
            custom_id='config_new_character_wealth_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.ConfigNewCharacterWealthModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


# ----- Static Kits -----


class AddStaticKitButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Create New Kit',
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
            label='Edit',
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
                    collection_name='currency',
                    query={'_id': interaction.guild_id}
                )

            edit_view = EditStaticKitView(self.kit_id, self.kit_data, currency_config)
            await interaction.response.edit_message(view=edit_view)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveStaticKitButton(Button):
    def __init__(self, kit_id, kit_name):
        super().__init__(
            label='Delete Kit',
            style=ButtonStyle.danger,
            custom_id=f'remove_static_kit_button_{kit_id}'
        )
        self.kit_id = kit_id
        self.kit_name = kit_name

    async def callback(self, interaction: discord.Interaction):
        try:
            confirm_modal = common_modals.ConfirmModal(
                title='Confirm Kit Deletion',
                prompt_label='WARNING: Irreversible!',
                prompt_placeholder='Type CONFIRM',
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
                collection_name='staticKits',
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
            label='Add Item',
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
            label='Edit',
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
            label='Delete',
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
                collection_name='staticKits',
                query={'_id': interaction.guild_id}
            )
            items = query['kits'][kit_id].get('items', [])

            if 0 <= self.index < len(items):
                del items[self.index]

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='staticKits',
                query={'_id': interaction.guild_id},
                update_data={'$set': {f'kits.{kit_id}.items': items}}
            )

            self.calling_view.kit_data['items'] = items
            self.calling_view.items = items
            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class AddKitCurrencyButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Add Currency',
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
            label='Delete',
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
                collection_name='staticKits',
                query={'_id': interaction.guild_id},
                update_data={'$unset': {f'kits.{kit_id}.currency.{self.currency_name}': ''}}
            )

            if self.currency_name in self.calling_view.kit_data.get('currency', {}):
                del self.calling_view.kit_data['currency'][self.currency_name]

            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayToggleEnableButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Toggle RP Rewards',
            custom_id='rp_toggle_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            current_state = self.calling_view.config.get('enabled', False)
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='roleplayConfig',
                query={'_id': interaction.guild_id},
                update_data={'$set': {'enabled': not current_state}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayClearChannelsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Clear Channels',
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
                collection_name='roleplayConfig',
                query={'_id': interaction.guild_id},
                update_data={'$set': {'channels': []}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplaySettingsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Edit Settings',
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
            label='Configure Rewards',
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
            label='Stock Limits',
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
        has_limit = item.get('maxStock') is not None
        label = 'Edit Limit' if has_limit else 'Set Limit'

        super().__init__(
            label=label,
            style=ButtonStyle.primary,
            custom_id=f"set_stock_{item['name']}"
        )
        self.item = item
        self.calling_view = calling_view
        self.current_stock = current_stock

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.SetItemStockModal(
                calling_view=self.calling_view,
                item_name=self.item['name'],
                current_max=self.item.get('maxStock'),
                current_stock=self.current_stock
            )
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveItemStockLimitButton(Button):
    def __init__(self, item: dict, calling_view):
        super().__init__(
            label='Remove Limit',
            style=ButtonStyle.danger,
            custom_id=f"remove_stock_limit_{item['name']}"
        )
        self.item = item
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            confirm_modal = common_modals.ConfirmModal(
                title='Confirm Remove Stock Limit',
                prompt_label='Type CONFIRM to remove the stock limit',
                prompt_placeholder='Type CONFIRM',
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
            item_name = self.item['name']

            # Update shop config to remove maxStock from item
            shop_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='shops',
                query={'_id': guild_id}
            )
            shop_data = shop_query.get('shopChannels', {}).get(channel_id, {})
            shop_stock = shop_data.get('shopStock', [])

            # Find and update the item
            for item in shop_stock:
                if item.get('name') == item_name:
                    if 'maxStock' in item:
                        del item['maxStock']
                    break

            # Save shop config
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='shops',
                query={'_id': guild_id},
                update_data={'$set': {f'shopChannels.{channel_id}': shop_data}}
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
            label='Configure Restock Schedule',
            style=ButtonStyle.primary,
            custom_id='restock_schedule_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            current_config = self.calling_view.shop_data.get('restockConfig')
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
            label='Back to Shop Editor',
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
