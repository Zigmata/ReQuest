import logging

import discord
from discord.ui import Select

from ReQuest.utilities.supportFunctions import log_exception
from ReQuest.ui.common import modals as common_modals

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class RemoveGuildAllowlistSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select a server to remove',
            options=[],
            custom_id='remove_guild_allowlist_select'
        )
        self.calling_view = calling_view
        self.guild_id = None

    async def callback(self, interaction: discord.Interaction):
        try:
            self.guild_id = self.values[0]
            confirm_modal = common_modals.ConfirmModal(
                title='Confirm Remove Server from Allowlist',
                prompt_label='Confirm server removal',
                prompt_placeholder='Type CONFIRM to proceed',
                confirm_callback=self.confirm_removal
            )
            await interaction.response.send_modal(confirm_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def confirm_removal(self, interaction: discord.Interaction):
        try:
            view = self.calling_view
            guild_id = int(self.guild_id)

            collection = interaction.client.cdb['serverAllowlist']
            await collection.update_one({'servers': {'$exists': True}},
                                        {'$pull': {'servers': {'id': guild_id}}})

            if guild_id in interaction.client.allow_list:
                interaction.client.allow_list.remove(guild_id)

            view.remove_guild_allowlist_select.options = [
                option for option in view.remove_guild_allowlist_select.options if int(option.value) != guild_id
            ]

            if not view.remove_guild_allowlist_select.options:
                view.remove_guild_allowlist_select.disabled = True
                view.remove_guild_allowlist_select.placeholder = 'There are no servers in the allowlist'
                view.remove_guild_allowlist_select.options.append(
                    discord.SelectOption(label='There are no servers in the allowlist', value='None')
                )
            await view.setup(interaction.client)
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)
