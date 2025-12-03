import logging

import discord
from discord.ui import Select, RoleSelect, ChannelSelect

from ReQuest.utilities.supportFunctions import log_exception, setup_view

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class SingleChannelConfigSelect(ChannelSelect):
    def __init__(self, calling_view, config_type, config_name):
        channel_types = [discord.ChannelType.text]
        if config_type == 'approvalQueueChannel':
            channel_types = [discord.ChannelType.forum]

        super().__init__(
            channel_types=channel_types,
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
            await setup_view(self.calling_view, interaction)
            return await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class QuestAnnounceRoleSelect(RoleSelect):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Choose your Quest Announcement Role',
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
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class AddGMRoleSelect(RoleSelect):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Choose your GM Role(s)',
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
            await interaction.response.edit_message(view=self.calling_view)
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
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class InventoryTypeSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select Inventory Mode',
            options=[
                discord.SelectOption(label='Disabled', value='disabled',
                                     description='Players start with empty inventories.'),
                discord.SelectOption(label='Selection', value='selection',
                                     description='Players choose items freely from the New Character Shop.'),
                discord.SelectOption(label='Purchase', value='purchase',
                                     description='Players purchase items from the New Character Shop with a given '
                                                 'amount of currency.'),
                discord.SelectOption(label='Open', value='open',
                                     description='Players manually input their own inventories.'),
                discord.SelectOption(label='Static', value='static',
                                     description='Players are given a predefined starting inventory.')
            ],
            custom_id='inventory_type_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            collection = interaction.client.gdb['inventoryConfig']
            await collection.update_one({'_id': interaction.guild_id},
                                        {'$set': {'inventoryType': self.values[0]}},
                                        upsert=True)
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)
