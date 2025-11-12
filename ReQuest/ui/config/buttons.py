import logging

import discord
from discord import ButtonStyle
from discord.ui import Button

from ReQuest.ui.config import modals
from ReQuest.ui.common.buttons import BaseViewButton
from ReQuest.utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class QuestAnnounceRoleRemoveButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Remove Quest Announcement Role',
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

            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
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

            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed)
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
            guild_id = interaction.guild_id
            collection = interaction.client.gdb['playerExperience']
            query = await collection.find_one({'_id': guild_id})
            if query and query['playerExperience']:
                await collection.update_one({'_id': guild_id}, {'$set': {'playerExperience': False}},
                                            upsert=True)
            else:
                await collection.update_one({'_id': guild_id}, {'$set': {'playerExperience': True}},
                                            upsert=True)

            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveDenominationConfirmButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Confirm',
            style=ButtonStyle.danger,
            custom_id='remove_denomination_confirm_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.calling_view.remove_currency_denomination(self.calling_view.selected_denomination_name,
                                                                 interaction.client, interaction.guild)
            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            self.disabled = True
            self.label = 'Confirm'
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e)


class ToggleDoubleButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Select a currency',
            custom_id='toggle_double_button',
            disabled=True
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
            await view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e)


class AddDenominationButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Select a currency',
            style=ButtonStyle.success,
            custom_id='add_denomination_button',
            disabled=True
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
    def __init__(self, target_view_class, calling_view):
        super().__init__(
            label='Select a currency',
            style=ButtonStyle.danger,
            custom_id='remove_denomination_button'
        )
        self.target_view_class = target_view_class
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.target_view_class(self.calling_view)
            await view.setup(interaction.client, interaction.guild)
            await interaction.response.edit_message(embed=view.embed, view=view)
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


class EditCurrencyButton(BaseViewButton):
    def __init__(self, target_view_class):
        super().__init__(
            target_view_class=target_view_class,
            label='Edit Currency',
            style=ButtonStyle.secondary,
            custom_id='edit_currency_button'
        )


class RemoveCurrencyButton(BaseViewButton):
    def __init__(self, target_view_class):
        super().__init__(
            target_view_class=target_view_class,
            label='Remove Currency',
            style=ButtonStyle.danger,
            custom_id='remove_currency_button'
        )


class RemoveCurrencyConfirmButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Confirm',
            style=ButtonStyle.danger,
            custom_id='remove_currency_confirm_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.calling_view
            await view.remove_currency(bot=interaction.client, guild=interaction.guild)
            await view.setup(bot=interaction.client, guild=interaction.guild)
            view.remove_currency_confirm_button.disabled = True
            view.remove_currency_confirm_button.label = 'Confirm'
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e)


class ClearChannelsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Clear Channels',
            style=ButtonStyle.danger,
            custom_id='clear_channels_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.calling_view
            await interaction.client.gdb['questChannel'].delete_one({'_id': interaction.guild_id})
            await interaction.client.gdb['playerBoardChannel'].delete_one({'_id': interaction.guild_id})
            await interaction.client.gdb['archiveChannel'].delete_one({'_id': interaction.guild_id})
            await view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=view.embed, view=view)
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
            label='Add Shop (from JSON)',
            style=ButtonStyle.secondary,
            custom_id='add_shop_json_button'
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
            label='Edit Shop',
            style=ButtonStyle.primary,
            custom_id='edit_shop_button',
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

            await interaction.response.send_message(view=view, ephemeral=True)

        except Exception as e:
            await log_exception(e, interaction)


class RemoveShopButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Remove Shop',
            style=ButtonStyle.danger,
            custom_id='remove_shop_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            guild_id = interaction.guild_id
            collection = interaction.client.gdb['shops']
            channel_id = self.calling_view.selected_channel_id

            await collection.update_one(
                {'_id': guild_id},
                {'$unset': {f'shopChannels.{channel_id}': ''}}
            )

            self.calling_view.selected_channel_id = None
            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)

        except Exception as e:
            await log_exception(e, interaction)


class EditItemButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Edit Item',
            style=ButtonStyle.primary,
            custom_id='edit_shop_item_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            selected_item = next(
                (item for item in self.calling_view.shop_stock if item['name'] == self.calling_view.selected_item_name),
                None
            )
            if not selected_item:
                raise Exception("Selected item not found.")

            await interaction.response.send_modal(modals.ShopItemModal(self.calling_view, existing_item=selected_item))
        except Exception as e:
            await log_exception(e, interaction)


class RemoveItemButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Remove Item',
            style=ButtonStyle.danger,
            custom_id='remove_shop_item_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            guild_id = interaction.guild_id
            collection = interaction.client.gdb['shops']
            channel_id = self.calling_view.channel_id
            item_name = self.calling_view.selected_item_name

            await collection.update_one(
                {'_id': guild_id},
                {'$pull': {f'shopChannels.{channel_id}.shopStock': {'name': item_name}}}
            )

            self.calling_view.selected_item_name = None
            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
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

            await self.calling_view.refresh(interaction)

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
