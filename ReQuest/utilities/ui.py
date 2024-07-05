import logging
from typing import Any

import discord
from discord import Interaction
from discord._types import ClientT

from .supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


# -------- BUTTONS --------
class BackButton(discord.ui.Button):
    def __init__(self, returning_view_class, guild_id, gdb, setup_embed=True, setup_select=True):
        super().__init__(
            label='Back',
            style=discord.ButtonStyle.primary,
            custom_id='back_button')
        self.guild_id = guild_id
        self.gdb = gdb
        self.returning_view_class = returning_view_class
        self.setup_embed = setup_embed
        self.setup_select = setup_select

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.returning_view_class(self.guild_id, self.gdb)
            if hasattr(new_view, 'setup_select') and self.setup_select:
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed') and self.setup_embed:
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class ConfigMenuButton(discord.ui.Button):
    def __init__(self, submenu_view_class, label, guild_id, gdb):
        super().__init__(
            label=label,
            style=discord.ButtonStyle.primary,
            custom_id=f'config_{label.lower()}_button'
        )
        self.guild_id = guild_id
        self.gdb = gdb
        self.submenu_view_class = submenu_view_class

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.submenu_view_class(self.guild_id, self.gdb)
            await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class MenuDoneButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Done',
            style=discord.ButtonStyle.gray,
            custom_id='done_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            for child in self.calling_view.children.copy():
                self.calling_view.remove_item(child)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


# -------- SELECTS --------


class SingleChannelConfigSelect(discord.ui.ChannelSelect):
    def __init__(self, calling_view, config_type, config_name, guild_id, gdb):
        super().__init__(
            channel_types=[discord.ChannelType.text],
            placeholder=f'Search for your {config_name} Channel',
            custom_id=f'config_{config_type}_channel_select'
        )
        self.calling_view = calling_view
        self.config_type = config_type
        self.guild_id = guild_id
        self.gdb = gdb

    async def callback(self, interaction: discord.Interaction):
        try:
            collection = self.gdb[self.config_type]
            await collection.update_one({'_id': self.guild_id}, {'$set': {self.config_type: self.values[0].mention}},
                                        upsert=True)
            await self.calling_view.setup_embed()
            return await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)

# -------- MODALS --------
