import logging

import discord
from discord.ui import Select, RoleSelect, ChannelSelect

from ReQuest.utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class GMRoleRemoveSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select Role(s)',
            options=[]
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            collection = interaction.client.gdb['gmRoles']
            for value in self.values:
                await collection.update_one({'_id': interaction.guild_id}, {'$pull': {'gmRoles': {'name': value}}})
            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class SingleChannelConfigSelect(ChannelSelect):
    def __init__(self, calling_view, config_type, config_name):
        super().__init__(
            channel_types=[discord.ChannelType['text']],
            placeholder=f'Search for your {config_name} Channel',
            custom_id=f'config_{config_type}_channel_select'
        )
        self.calling_view = calling_view
        self.config_type = config_type

    async def callback(self, interaction: discord.Interaction):
        try:
            collection = interaction.client.gdb[self.config_type]
            await collection.update_one({'_id': interaction.guild_id},
                                        {'$set': {self.config_type: self.values[0].mention}},
                                        upsert=True)
            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            return await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class QuestAnnounceRoleSelect(RoleSelect):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Search for your Quest Announcement Role',
            custom_id='quest_announce_role_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            collection = interaction.client.gdb['announceRole']
            await collection.update_one({'_id': interaction.guild_id},
                                        {'$set': {'announceRole': self.values[0].mention}},
                                        upsert=True)
            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class AddGMRoleSelect(RoleSelect):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Search for your GM Role(s)',
            custom_id='add_gm_role_select',
            max_values=25
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            collection = interaction.client.gdb['gmRoles']
            query = await collection.find_one({'_id': interaction.guild_id})
            if not query:
                for value in self.values:
                    await collection.update_one({'_id': interaction.guild_id},
                                                {'$push': {'gmRoles': {'mention': value.mention, 'name': value.name}}},
                                                upsert=True)
            else:
                for value in self.values:
                    matches = 0
                    for role in query['gmRoles']:
                        if value.mention in role['mention']:
                            matches += 1

                    if matches == 0:
                        await collection.update_one({'_id': interaction.guild_id},
                                                    {'$push': {
                                                        'gmRoles': {'mention': value.mention, 'name': value.name}}},
                                                    upsert=True)

            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ConfigWaitListSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            options=[
                discord.SelectOption(label='0 (Disabled)', value='0'),
                discord.SelectOption(label='1', value='1'),
                discord.SelectOption(label='2', value='2'),
                discord.SelectOption(label='3', value='3'),
                discord.SelectOption(label='4', value='4'),
                discord.SelectOption(label='5', value='5')
            ],
            placeholder='Select Wait List size',
            custom_id='config_wait_list_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            collection = interaction.client.gdb['questWaitList']
            await collection.update_one({'_id': interaction.guild_id},
                                        {'$set': {'questWaitList': int(self.values[0])}},
                                        upsert=True)
            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveDenominationSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select a denomination',
            options=[],
            custom_id='remove_denomination_select',
            row=0
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            denomination_name = self.values[0]
            self.calling_view.selected_denomination_name = denomination_name
            self.calling_view.remove_denomination_confirm_button.label = f'Confirm deletion of {denomination_name}'
            self.calling_view.remove_denomination_confirm_button.disabled = False
            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e)


class EditCurrencySelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Choose a currency to edit',
            options=[],
            custom_id='edit_currency_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.calling_view
            view.selected_currency_name = self.values[0]

            await view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e)


class RemoveCurrencySelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select a currency',
            options=[],
            custom_id='remove_currency_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.calling_view
            view.selected_currency_name = self.values[0]
            view.remove_currency_confirm_button.label = f'Confirm deletion of {self.values[0]}'
            view.remove_currency_confirm_button.disabled = False
            await view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e)


class ConfigShopSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select a shop to manage',
            options=[discord.SelectOption(label='No shops configured', value='None')],
            custom_id='config_shop_select',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.calling_view
            view.selected_channel_id = self.values[0]

            view.edit_shop_button.disabled = False
            view.remove_shop_button.disabled = False

            await view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)
