import logging

import discord
from discord.ui import Select, RoleSelect, ChannelSelect

from ReQuest.utilities.supportFunctions import (
    log_exception,
    setup_view,
    get_cached_data,
    update_cached_data
)

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
            bot = interaction.client
            update_data = {'$set': {self.config_type: self.values[0].mention}}
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=self.config_type,
                query={'_id': interaction.guild_id},
                update_data=update_data
            )
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
            bot = interaction.client
            update_data = {'$set': {'announceRole': self.values[0].mention}}
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='announceRole',
                query={'_id': interaction.guild_id},
                update_data=update_data
            )
            await setup_view(self.calling_view, interaction)
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
            bot = interaction.client
            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='gmRoles',
                query={'_id': interaction.guild_id}
            )
            if not query:
                for value in self.values:
                    update_data = {'$push': {'gmRoles': {'mention': value.mention, 'name': value.name}}}
                    await update_cached_data(
                        bot=bot,
                        mongo_database=bot.gdb,
                        collection_name='gmRoles',
                        query={'_id': interaction.guild_id},
                        update_data=update_data
                    )
            else:
                for value in self.values:
                    matches = 0
                    for role in query['gmRoles']:
                        if value.mention in role['mention']:
                            matches += 1

                    if matches == 0:
                        update_data = {'$push': {'gmRoles': {'mention': value.mention, 'name': value.name}}}
                        await update_cached_data(
                            bot=bot,
                            mongo_database=bot.gdb,
                            collection_name='gmRoles',
                            query={'_id': interaction.guild_id},
                            update_data=update_data
                        )

            await setup_view(self.calling_view, interaction)
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
            bot = interaction.client
            update_data = {'$set': {'questWaitList': int(self.values[0])}}
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='questWaitList',
                query={'_id': interaction.guild_id},
                update_data=update_data
            )
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
            bot = interaction.client
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='inventoryConfig',
                query={'_id': interaction.guild_id},
                update_data={'$set': {'inventoryType': self.values[0]}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayChannelSelect(ChannelSelect):
    def __init__(self, calling_view):
        super().__init__(
            channel_types=[discord.ChannelType.text, discord.ChannelType.category],
            placeholder='Select Eligible Channels',
            min_values=0,
            max_values=25,
            custom_id='rp_channel_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            channel_ids = []
            for selection in self.values:
                if selection.type is discord.ChannelType.category:
                    category_channel = await selection.fetch()
                    for channel in category_channel.text_channels:  # Only add text channels
                        channel_ids.append(str(channel.id))
                else:
                    channel_ids.append(str(selection.id))

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='roleplayConfig',
                query={'_id': interaction.guild_id},
                update_data={'$addToSet': {'channels': {'$each': channel_ids}}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayModeSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select Mode',
            options=[
                discord.SelectOption(
                    label='Scheduled',
                    value='scheduled',
                    description='Rewards are granted once within a specified reset period.'
                ),
                discord.SelectOption(
                    label='Accrued',
                    value='accrued',
                    description='Rewards are repeatedly granted based on specified activity levels.'
                )
            ],
            custom_id='rp_mode_select'
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
                update_data={'$set': {'mode': self.values[0]}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayResetSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select Reset Period',
            options=[
                discord.SelectOption(label='Hourly', value='hourly', description='Resets every hour.'),
                discord.SelectOption(label='Daily', value='daily', description='Resets every 24 hours.'),
                discord.SelectOption(label='Weekly', value='weekly', description='Resets every 7 days.')
            ],
            custom_id='rp_reset_select'
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
                update_data={'$set': {'config.resetPeriod': self.values[0]}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayResetDaySelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select Reset Day',
            options=[
                discord.SelectOption(label='Monday', value='monday'),
                discord.SelectOption(label='Tuesday', value='tuesday'),
                discord.SelectOption(label='Wednesday', value='wednesday'),
                discord.SelectOption(label='Thursday', value='thursday'),
                discord.SelectOption(label='Friday', value='friday'),
                discord.SelectOption(label='Saturday', value='saturday'),
                discord.SelectOption(label='Sunday', value='sunday')
            ],
            custom_id='rp_reset_day_select'
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
                update_data={'$set': {'config.resetDay': self.values[0]}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayResetTimeSelect(Select):
    def __init__(self, calling_view):
        options = []
        for hour in range(0, 24):
            options.append(discord.SelectOption(label=f'{hour:02}:00 UTC', value=f'{hour}'))

        super().__init__(
            placeholder='Select Reset Time (UTC)',
            options=options,
            custom_id='rp_reset_time_select'
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
                update_data={'$set': {'config.resetTime': int(self.values[0])}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)
