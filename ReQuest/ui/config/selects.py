import logging

import discord
from discord.ui import Select, RoleSelect, ChannelSelect

from ReQuest.ui.common.enums import InventoryType, RoleplayMode, ScheduleType, DayOfWeek
from ReQuest.utilities.constants import ConfigFields, CommonFields, RoleplayFields, DatabaseCollections
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
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
        if config_type == ConfigFields.APPROVAL_QUEUE_CHANNEL:
            channel_types = [discord.ChannelType.forum]

        super().__init__(
            channel_types=channel_types,
            placeholder=t(DEFAULT_LOCALE, 'config-select-placeholder-channel', {'configName': config_name}),
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
            placeholder=t(DEFAULT_LOCALE, 'config-select-placeholder-announce-role'),
            custom_id='quest_announce_role_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            update_data = {'$set': {ConfigFields.ANNOUNCE_ROLE: self.values[0].mention}}
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.ANNOUNCE_ROLE,
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
            placeholder=t(DEFAULT_LOCALE, 'config-select-placeholder-gm-roles'),
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
                collection_name=DatabaseCollections.GM_ROLES,
                query={'_id': interaction.guild_id}
            )
            if not query:
                for value in self.values:
                    update_data = {'$push': {ConfigFields.GM_ROLES: {CommonFields.MENTION: value.mention, CommonFields.NAME: value.name}}}
                    await update_cached_data(
                        bot=bot,
                        mongo_database=bot.gdb,
                        collection_name=DatabaseCollections.GM_ROLES,
                        query={'_id': interaction.guild_id},
                        update_data=update_data
                    )
            else:
                for value in self.values:
                    matches = 0
                    for role in query[ConfigFields.GM_ROLES]:
                        if value.mention in role[CommonFields.MENTION]:
                            matches += 1

                    if matches == 0:
                        update_data = {'$push': {ConfigFields.GM_ROLES: {CommonFields.MENTION: value.mention, CommonFields.NAME: value.name}}}
                        await update_cached_data(
                            bot=bot,
                            mongo_database=bot.gdb,
                            collection_name=DatabaseCollections.GM_ROLES,
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
                discord.SelectOption(label=t(DEFAULT_LOCALE, 'config-select-option-disabled'), value='0'),
                discord.SelectOption(label='1', value='1'),
                discord.SelectOption(label='2', value='2'),
                discord.SelectOption(label='3', value='3'),
                discord.SelectOption(label='4', value='4'),
                discord.SelectOption(label='5', value='5')
            ],
            placeholder=t(DEFAULT_LOCALE, 'config-select-placeholder-wait-list'),
            custom_id='config_wait_list_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            update_data = {'$set': {ConfigFields.QUEST_WAIT_LIST: int(self.values[0])}}
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUEST_WAIT_LIST,
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
            placeholder=t(DEFAULT_LOCALE, 'config-select-placeholder-inventory-mode'),
            options=[
                discord.SelectOption(label=t(DEFAULT_LOCALE, 'config-select-option-disabled-label'),
                                     value=InventoryType.DISABLED.value,
                                     description=t(DEFAULT_LOCALE, 'config-select-desc-disabled')),
                discord.SelectOption(label=t(DEFAULT_LOCALE, 'config-select-option-selection'),
                                     value=InventoryType.SELECTION.value,
                                     description=t(DEFAULT_LOCALE, 'config-select-desc-selection')),
                discord.SelectOption(label=t(DEFAULT_LOCALE, 'config-select-option-purchase'),
                                     value=InventoryType.PURCHASE.value,
                                     description=t(DEFAULT_LOCALE, 'config-select-desc-purchase')),
                discord.SelectOption(label=t(DEFAULT_LOCALE, 'config-select-option-open'),
                                     value=InventoryType.OPEN.value,
                                     description=t(DEFAULT_LOCALE, 'config-select-desc-open')),
                discord.SelectOption(label=t(DEFAULT_LOCALE, 'config-select-option-static'),
                                     value=InventoryType.STATIC.value,
                                     description=t(DEFAULT_LOCALE, 'config-select-desc-static')),
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
                collection_name=DatabaseCollections.INVENTORY_CONFIG,
                query={'_id': interaction.guild_id},
                update_data={'$set': {ConfigFields.INVENTORY_TYPE: self.values[0]}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayChannelSelect(ChannelSelect):
    def __init__(self, calling_view):
        super().__init__(
            channel_types=[discord.ChannelType.text, discord.ChannelType.forum, discord.ChannelType.category],
            placeholder=t(DEFAULT_LOCALE, 'config-select-placeholder-rp-channels'),
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
                    # Add both text and forum channels from category
                    for channel in category_channel.text_channels:
                        channel_ids.append(str(channel.id))
                    for channel in category_channel.forums:
                        channel_ids.append(str(channel.id))
                else:
                    channel_ids.append(str(selection.id))

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.ROLEPLAY_CONFIG,
                query={'_id': interaction.guild_id},
                update_data={'$addToSet': {RoleplayFields.CHANNELS: {'$each': channel_ids}}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayModeSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder=t(DEFAULT_LOCALE, 'config-select-placeholder-rp-mode'),
            options=[
                discord.SelectOption(
                    label=t(DEFAULT_LOCALE, 'config-select-option-scheduled'),
                    value=RoleplayMode.SCHEDULED.value,
                    description=t(DEFAULT_LOCALE, 'config-select-desc-scheduled')
                ),
                discord.SelectOption(
                    label=t(DEFAULT_LOCALE, 'config-select-option-accrued'),
                    value=RoleplayMode.ACCRUED.value,
                    description=t(DEFAULT_LOCALE, 'config-select-desc-accrued')
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
                collection_name=DatabaseCollections.ROLEPLAY_CONFIG,
                query={'_id': interaction.guild_id},
                update_data={'$set': {RoleplayFields.MODE: self.values[0]}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayResetSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder=t(DEFAULT_LOCALE, 'config-select-placeholder-reset-period'),
            options=[
                discord.SelectOption(label=t(DEFAULT_LOCALE, 'config-select-option-hourly'),
                                     value=ScheduleType.HOURLY.value,
                                     description=t(DEFAULT_LOCALE, 'config-select-desc-hourly')),
                discord.SelectOption(label=t(DEFAULT_LOCALE, 'config-select-option-daily'),
                                     value=ScheduleType.DAILY.value,
                                     description=t(DEFAULT_LOCALE, 'config-select-desc-daily')),
                discord.SelectOption(label=t(DEFAULT_LOCALE, 'config-select-option-weekly'),
                                     value=ScheduleType.WEEKLY.value,
                                     description=t(DEFAULT_LOCALE, 'config-select-desc-weekly'))
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
                collection_name=DatabaseCollections.ROLEPLAY_CONFIG,
                query={'_id': interaction.guild_id},
                update_data={'$set': {f'{RoleplayFields.CONFIG}.{RoleplayFields.RESET_PERIOD}': self.values[0]}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayResetDaySelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder=t(DEFAULT_LOCALE, 'config-select-placeholder-reset-day'),
            options=[
                discord.SelectOption(label=t(DEFAULT_LOCALE, 'common-day-monday'), value=DayOfWeek.MONDAY.value),
                discord.SelectOption(label=t(DEFAULT_LOCALE, 'common-day-tuesday'), value=DayOfWeek.TUESDAY.value),
                discord.SelectOption(label=t(DEFAULT_LOCALE, 'common-day-wednesday'), value=DayOfWeek.WEDNESDAY.value),
                discord.SelectOption(label=t(DEFAULT_LOCALE, 'common-day-thursday'), value=DayOfWeek.THURSDAY.value),
                discord.SelectOption(label=t(DEFAULT_LOCALE, 'common-day-friday'), value=DayOfWeek.FRIDAY.value),
                discord.SelectOption(label=t(DEFAULT_LOCALE, 'common-day-saturday'), value=DayOfWeek.SATURDAY.value),
                discord.SelectOption(label=t(DEFAULT_LOCALE, 'common-day-sunday'), value=DayOfWeek.SUNDAY.value)
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
                collection_name=DatabaseCollections.ROLEPLAY_CONFIG,
                query={'_id': interaction.guild_id},
                update_data={'$set': {f'{RoleplayFields.CONFIG}.{RoleplayFields.RESET_DAY}': self.values[0]}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayResetTimeSelect(Select):
    def __init__(self, calling_view):
        options = []
        for hour in range(0, 24):
            options.append(discord.SelectOption(
                label=t(DEFAULT_LOCALE, 'config-select-option-utc-time', {'hour': f'{hour:02}'}),
                value=f'{hour}'
            ))

        super().__init__(
            placeholder=t(DEFAULT_LOCALE, 'config-select-placeholder-reset-time'),
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
                collection_name=DatabaseCollections.ROLEPLAY_CONFIG,
                query={'_id': interaction.guild_id},
                update_data={'$set': {f'{RoleplayFields.CONFIG}.{RoleplayFields.RESET_TIME}': int(self.values[0])}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ForumChannelSelect(ChannelSelect):
    """Select for choosing a forum channel for shop setup."""
    def __init__(self, calling_view):
        super().__init__(
            channel_types=[discord.ChannelType.forum],
            placeholder=t(DEFAULT_LOCALE, 'config-select-placeholder-forum-channel'),
            custom_id='forum_channel_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            self.calling_view.selected_forum = self.values[0]
            self.calling_view.selected_thread = None  # Reset thread selection

            forum = interaction.guild.get_channel(self.values[0].id)
            self.calling_view.forum_threads = [t for t in forum.threads if not t.archived and not t.locked][:25]

            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ForumThreadSelect(Select):
    """Select for choosing an existing thread within a forum channel."""
    def __init__(self, calling_view):
        options = []

        if calling_view.selected_forum:
            threads = calling_view.forum_threads or []

            if threads:
                for thread in threads:
                    options.append(discord.SelectOption(
                        label=thread.name[:100],  # Discord label limit
                        value=str(thread.id),
                        description=t(DEFAULT_LOCALE, 'config-select-desc-thread-id', {'threadId': str(thread.id)})
                    ))
            else:
                # Provide a placeholder option if no threads found
                options.append(discord.SelectOption(
                    label=t(DEFAULT_LOCALE, 'config-select-option-no-threads'),
                    value='none',
                    description=t(DEFAULT_LOCALE, 'config-select-desc-no-threads')
                ))

        if not options:
            options.append(discord.SelectOption(
                label=t(DEFAULT_LOCALE, 'config-select-option-select-forum-first'),
                value='none',
                description=t(DEFAULT_LOCALE, 'config-select-desc-select-forum-first')
            ))

        super().__init__(
            placeholder=t(DEFAULT_LOCALE, 'config-select-placeholder-thread'),
            options=options,
            custom_id='forum_thread_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            selected_value = self.values[0]
            if selected_value == 'none':
                await interaction.response.send_message(
                    t(DEFAULT_LOCALE, 'config-error-select-valid-thread'),
                    ephemeral=True
                )
                return

            # Get the thread object
            thread_id = int(selected_value)
            guild = interaction.guild
            thread = guild.get_thread(thread_id)

            if not thread:
                # Try to fetch from the forum
                forum = self.calling_view.selected_forum
                if forum:
                    thread = forum.get_thread(thread_id)

            if thread:
                self.calling_view.selected_thread = thread
                self.calling_view.build_view()
                await interaction.response.edit_message(view=self.calling_view)
            else:
                await interaction.response.send_message(
                    t(DEFAULT_LOCALE, 'config-error-thread-not-found'),
                    ephemeral=True
                )
        except Exception as e:
            await log_exception(e, interaction)
