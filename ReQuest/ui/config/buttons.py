import inspect
import logging

from discord import ButtonStyle
from discord.ui import Button

import ReQuest.ui.modals as modals
from ..utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class QuestAnnounceRoleRemoveButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Remove Quest Announcement Role',
            style=ButtonStyle.red,
            custom_id='quest_announce_role_remove_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
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

    async def callback(self, interaction):
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

    async def callback(self, interaction):
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

    async def callback(self, interaction):
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
            style=ButtonStyle.secondary,
            custom_id='toggle_double_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            view = self.calling_view
            currency_name = view.selected_currency_name
            collection = interaction.client.gdb['currency']
            query = await collection.find_one({'_id': interaction.guild_id, 'currencies.name': currency_name})
            currency = next((item for item in query['currencies'] if item['name'] == currency_name), None)
            if currency['isDouble']:
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

    async def callback(self, interaction):
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

    async def callback(self, interaction):
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

    async def callback(self, interaction):
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

    async def callback(self, interaction):
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

    async def callback(self, interaction):
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
            style=ButtonStyle.secondary,
            custom_id='forbidden_roles_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
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

    async def callback(self, interaction):
        try:
            modal = modals.PlayerBoardPurgeModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class GMRewardsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Add/Modify Rewards',
            style=ButtonStyle.secondary,
            custom_id='gm_rewards_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            modal = modals.GMRewardsModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)