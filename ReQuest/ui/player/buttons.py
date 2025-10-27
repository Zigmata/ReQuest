import inspect
import logging

from discord import ButtonStyle
from discord.ui import Button

import ReQuest.ui.modals as modals
from ..utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class RegisterCharacterButton(Button):
    def __init__(self):
        super().__init__(
            label='Register',
            style=ButtonStyle.primary,
            custom_id='register_character_button'
        )

    async def callback(self, interaction):
        try:
            modal = modals.CharacterRegisterModal(self, interaction.client.mdb, interaction.user.id,
                                                  interaction.guild_id)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)

class ViewInventoryButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='View',
            style=ButtonStyle.secondary,
            custom_id='view_inventory_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            view = self.calling_view
            character = view.active_character
            inventory = character['attributes']['inventory']
            player_currencies = character['attributes']['currency']
            items = []
            currencies = []

            for item in inventory:
                pair = (str(item), f'**{inventory[item]}**')
                value = ': '.join(pair)
                items.append(value)

            for currency in player_currencies:
                pair = (str(currency), f'**{player_currencies[currency]}**')
                value = ': '.join(pair)
                currencies.append(value)

            await view.setup(bot=interaction.client, user=interaction.user, guild=interaction.guild)
            view.embed.add_field(name='Possessions',
                                 value='\n'.join(items))
            view.embed.add_field(name='Currency',
                                 value='\n'.join(currencies))

            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class SpendCurrencyButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Spend Currency',
            style=ButtonStyle.secondary,
            custom_id='spend_currency_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
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

    async def callback(self, interaction):
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

    async def callback(self, interaction):
        try:
            await self.calling_view.remove_post(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class EditPlayerPostButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Edit Post',
            style=ButtonStyle.secondary,
            custom_id='edit_player_post_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            modal = modals.EditPlayerPostModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)