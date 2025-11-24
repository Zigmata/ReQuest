import logging
import json
import io

import discord
from discord import ButtonStyle
from discord.ui import Button

from ReQuest.ui.config import modals, enums
from ReQuest.ui.common import modals as common_modals
from ReQuest.ui.common.buttons import BaseViewButton
from ReQuest.utilities.supportFunctions import log_exception, setup_view

logging.basicConfig(level=logging.INFO)
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
            collection = interaction.client.gdb['announceRole']
            query = await collection.find_one({'_id': interaction.guild_id})
            if query:
                await collection.delete_one({'_id': interaction.guild_id})

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
            guild_id = interaction.guild_id
            collection = interaction.client.gdb['questSummary']
            query = await collection.find_one({'_id': guild_id})
            if not query:
                await collection.insert_one({'_id': guild_id, 'questSummary': True})
            else:
                if query['questSummary']:
                    await collection.update_one({'_id': guild_id}, {'$set': {'questSummary': False}})
                else:
                    await collection.update_one({'_id': guild_id}, {'$set': {'questSummary': True}})

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
            xp_state = self.calling_view.player_experience
            guild_id = interaction.guild_id
            collection = interaction.client.gdb['playerExperience']
            if xp_state:
                await collection.update_one({'_id': guild_id}, {'$set': {'playerExperience': False}},
                                            upsert=True)
            else:
                await collection.update_one({'_id': guild_id}, {'$set': {'playerExperience': True}},
                                            upsert=True)

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ToggleDoubleButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Select a currency',
            custom_id='toggle_double_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.calling_view
            currency_name = view.selected_currency_name
            collection = interaction.client.gdb['currency']
            query = await collection.find_one({'_id': interaction.guild_id, 'currencies.name': currency_name})
            currency = next((item for item in query['currencies'] if item['name'] == currency_name), None)
            if currency and currency['isDouble']:
                value = False
            else:
                value = True
            await collection.update_one({'_id': interaction.guild_id, 'currencies.name': currency_name},
                                        {'$set': {'currencies.$.isDouble': value}})
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e)


class AddDenominationButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Select a currency',
            style=ButtonStyle.success,
            custom_id='add_denomination_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            new_modal = modals.AddCurrencyDenominationTextModal(
                calling_view=self.calling_view,
                base_currency_name=self.calling_view.selected_currency_name
            )
            await interaction.response.send_modal(new_modal)
        except Exception as e:
            await log_exception(e)


class RemoveDenominationButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Remove Denomination',
            style=ButtonStyle.danger,
            custom_id='remove_denomination_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            confirm_modal = common_modals.ConfirmModal(
                title='Confirm Denomination Removal',
                prompt_label='WARNING: This action is irreversible!',
                prompt_placeholder='Type CONFIRM to proceed',
                confirm_callback=self.calling_view.remove_denomination_confirm_callback
            )
            await interaction.response.send_modal(confirm_modal)
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


class EditCurrencyButton(Button):
    def __init__(self, target_view_class, calling_view):
        super().__init__(
            label='Edit Currency',
            style=ButtonStyle.secondary,
            custom_id='edit_currency_button'
        )
        self.target_view_class = target_view_class
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.target_view_class(self.calling_view)
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveCurrencyButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Remove Currency',
            style=ButtonStyle.danger,
            custom_id='remove_currency_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = common_modals.ConfirmModal(
                title='Confirm Currency Removal',
                prompt_label='WARNING: This action is irreversible!',
                prompt_placeholder='Type CONFIRM to proceed',
                confirm_callback=self.calling_view.remove_currency_confirm_callback
            )
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class ClearChannelButton(Button):
    def __init__(self, calling_view, channel_type: enums.ChannelType):
        super().__init__(
            label='Clear',
            style=ButtonStyle.danger,
            custom_id=f'clear_{channel_type.value}_channel_button'
        )
        self.calling_view = calling_view
        self.channel_type = channel_type

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.calling_view
            if self.channel_type == enums.ChannelType.QUEST_BOARD:
                await interaction.client.gdb['questChannel'].delete_one({'_id': interaction.guild_id})
            elif self.channel_type == enums.ChannelType.PLAYER_BOARD:
                await interaction.client.gdb['playerBoardChannel'].delete_one({'_id': interaction.guild_id})
            elif self.channel_type == enums.ChannelType.QUEST_ARCHIVE:
                await interaction.client.gdb['archiveChannel'].delete_one({'_id': interaction.guild_id})
            elif self.channel_type == enums.ChannelType.GM_TRANSACTION_LOG:
                await interaction.client.gdb['gmTransactionLogChannel'].delete_one({'_id': interaction.guild_id})
            elif self.channel_type == enums.ChannelType.PLAYER_TRADING_LOG:
                await interaction.client.gdb['playerTradingLogChannel'].delete_one({'_id': interaction.guild_id})
            elif self.channel_type == enums.ChannelType.SHOP_LOG:
                await interaction.client.gdb['shopLogChannel'].delete_one({'_id': interaction.guild_id})
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
            current_roles = []
            config_collection = interaction.client.gdb['forbiddenRoles']
            config_query = await config_collection.find_one({'_id': interaction.guild_id})
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


class EditShopButton(Button):
    def __init__(self, target_view_class, calling_view):
        super().__init__(
            label='Edit Shop (Wizard)',
            style=ButtonStyle.primary,
            custom_id='edit_shop_wizard_button',
            disabled=True
        )
        self.target_view_class = target_view_class
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            collection = interaction.client.gdb['shops']
            query = await collection.find_one({'_id': interaction.guild_id})
            shop_data = query.get('shopChannels', {}).get(self.calling_view.selected_channel_id)

            if not shop_data:
                await interaction.response.send_message("Error: Could not find that shop's data.", ephemeral=True)
                return

            view = self.target_view_class(
                channel_id=self.calling_view.selected_channel_id,
                shop_data=shop_data
            )
            view.build_view()

            await interaction.response.edit_message(view=view)

        except Exception as e:
            await log_exception(e, interaction)


class RemoveShopButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Remove Shop',
            style=ButtonStyle.danger,
            custom_id='remove_shop_button',
            row=4,
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            if not self.calling_view.selected_channel_id:
                raise Exception('No shop selected')

            confirm_modal = common_modals.ConfirmModal(
                title='Confirm Shop Removal',
                prompt_label='WARNING: This action is irreversible!',
                prompt_placeholder='Type CONFIRM to proceed',
                confirm_callback=self._confirm_delete_callback
            )
            await interaction.response.send_modal(confirm_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def _confirm_delete_callback(self, interaction: discord.Interaction):
        try:
            view = self.calling_view
            if not view.selected_channel_id:
                raise Exception('No shop was selected for removal')

            guild_id = interaction.guild_id
            collection = interaction.client.gdb['shops']
            channel_id = view.selected_channel_id

            await collection.update_one(
                {'_id': guild_id},
                {'$unset': {f'shopChannels.{channel_id}': ''}}
            )

            view.selected_channel_id = None

            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
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
            guild_id = interaction.guild_id
            collection = interaction.client.gdb['shops']
            channel_id = self.calling_view.channel_id
            item_name = self.item['name']

            await collection.update_one(
                {'_id': guild_id},
                {'$pull': {f'shopChannels.{channel_id}.shopStock': {'name': item_name}}}
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
            custom_id='download_shop_json_button',
            row=2,
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            guild_id = interaction.guild_id
            channel_id = self.calling_view.selected_channel_id
            if not channel_id:
                raise Exception("No shop selected.")

            collection = interaction.client.gdb['shops']
            query = await collection.find_one({'_id': guild_id})
            shop_data = query.get('shopChannels', {}).get(channel_id)

            if not shop_data:
                raise Exception("Could not find shop data.")

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
            custom_id='edit_shop_json_button',
            row=2,
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            if not self.calling_view.selected_channel_id:
                raise Exception("No shop selected.")

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


class AddStartingShopItemButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Add Item',
            style=ButtonStyle.success,
            custom_id='add_starting_shop_item_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(modals.StartingShopItemModal(self.calling_view))
        except Exception as e:
            await log_exception(e, interaction)


class EditStartingShopItemButton(Button):
    def __init__(self, item: dict, calling_view):
        super().__init__(
            label='Edit',
            style=ButtonStyle.primary,
            custom_id=f"edit_starting_shop_item_{item['name']}"
        )
        self.item = item
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(modals.StartingShopItemModal(self.calling_view, self.item))
        except Exception as e:
            await log_exception(e, interaction)


class DeleteStartingShopItemButton(Button):
    def __init__(self, item: dict, calling_view):
        super().__init__(
            label='Delete',
            style=ButtonStyle.danger,
            custom_id=f"delete_starting_shop_item_{item['name']}"
        )
        self.item = item
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            guild_id = interaction.guild_id
            collection = interaction.client.gdb['startingShop']
            item_name = self.item['name']

            await collection.update_one(
                {'_id': guild_id},
                {'$pull': {'shopStock': {'name': item_name}}}
            )

            new_stock = [item for item in self.calling_view.all_stock if item['name'] != item_name]
            self.calling_view.update_stock(new_stock)
            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class StartingShopJSONButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Upload JSON',
            style=ButtonStyle.success,
            custom_id='upload_starting_shop_json_button',
            row=1
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(modals.StartingShopJSONModal(self.calling_view))
        except Exception as e:
            await log_exception(e, interaction)


class DownloadStartingShopJSONButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Download JSON',
            style=ButtonStyle.secondary,
            custom_id='download_starting_shop_json_button',
            row=1
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            guild_id = interaction.guild_id
            collection = interaction.client.gdb['startingShop']
            query = await collection.find_one({'_id': guild_id})

            shop_data = {'shopStock': query.get('shopStock', []) if query else []}

            file_name = f"starting_shop_{guild_id}.json"
            json_string = json.dumps(shop_data, indent=4)
            json_bytes = io.BytesIO(json_string.encode('utf-8'))

            shop_file = discord.File(json_bytes, filename=file_name)

            await interaction.response.send_message(
                "Here is the JSON definition for the Starting Shop.",
                file=shop_file,
                ephemeral=True
            )
        except Exception as e:
            await log_exception(e, interaction)