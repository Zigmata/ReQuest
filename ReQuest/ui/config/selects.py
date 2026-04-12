import logging

import discord
from discord.ui import Select, RoleSelect, ChannelSelect

from ReQuest.ui.common.enums import InventoryType, QuestRoleMode, RoleplayMode, ScheduleType, DayOfWeek
from ReQuest.ui.info.selects import (LOCALE_LABELS, LOCALE_DESCRIPTIONS, LOCALE_EMOJI,
                                     LOCALES_PER_PAGE, get_config_locale_total_pages)
from ReQuest.utilities.constants import (ConfigFields, CommonFields, RoleplayFields,
                                         DatabaseCollections, DiscordLimits,
                                         MAX_QUEST_ROLES_PER_GM)
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE, SUPPORTED_LOCALES
from ReQuest.utilities.db_cache import get_cached_data, update_cached_data, delete_cached_data
from ReQuest.utilities.exceptions import log_exception
from ReQuest.utilities.discord_utils import setup_view

logger = logging.getLogger(__name__)


class SingleChannelConfigSelect(ChannelSelect):
    def __init__(self, calling_view, config_type, config_name):
        channel_types = [discord.ChannelType.text]
        if config_type == ConfigFields.APPROVAL_QUEUE_CHANNEL:
            channel_types = [discord.ChannelType.forum]

        super().__init__(
            channel_types=channel_types,
            placeholder=t(
                DEFAULT_LOCALE, 'config-select-placeholder-channel',
                configName=config_name
            )[:DiscordLimits.SELECT_PLACEHOLDER],
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
            placeholder=t(
                DEFAULT_LOCALE, 'config-select-placeholder-announce-role'
            )[:DiscordLimits.SELECT_PLACEHOLDER],
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
            placeholder=t(
                DEFAULT_LOCALE, 'config-select-placeholder-gm-roles'
            )[:DiscordLimits.SELECT_PLACEHOLDER],
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
                    update_data = {
                        '$push': {ConfigFields.GM_ROLES: {
                            CommonFields.MENTION: value.mention,
                            CommonFields.NAME: value.name}}}
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
                        update_data = {
                            '$push': {ConfigFields.GM_ROLES: {
                                CommonFields.MENTION: value.mention,
                                CommonFields.NAME: value.name}}}
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
        label_disabled = t(
            DEFAULT_LOCALE, 'config-select-option-disabled'
        )[:DiscordLimits.STRING_SELECT_OPTION_LABEL]
        super().__init__(
            options=[
                discord.SelectOption(label=label_disabled, value='0'),
                discord.SelectOption(label='1', value='1'),
                discord.SelectOption(label='2', value='2'),
                discord.SelectOption(label='3', value='3'),
                discord.SelectOption(label='4', value='4'),
                discord.SelectOption(label='5', value='5')
            ],
            placeholder=t(
                DEFAULT_LOCALE, 'config-select-placeholder-wait-list'
            )[:DiscordLimits.SELECT_PLACEHOLDER],
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
        _label = DiscordLimits.STRING_SELECT_OPTION_LABEL
        _desc = DiscordLimits.STRING_SELECT_OPTION_DESCRIPTION
        super().__init__(
            placeholder=t(
                DEFAULT_LOCALE, 'config-select-placeholder-inventory-mode'
            )[:DiscordLimits.SELECT_PLACEHOLDER],
            options=[
                discord.SelectOption(
                    label=t(DEFAULT_LOCALE, 'config-select-option-disabled-label')[:_label],
                    value=InventoryType.DISABLED.value,
                    description=t(DEFAULT_LOCALE, 'config-select-desc-disabled')[:_desc]
                ),
                discord.SelectOption(
                    label=t(DEFAULT_LOCALE, 'config-select-option-selection')[:_label],
                    value=InventoryType.SELECTION.value,
                    description=t(DEFAULT_LOCALE, 'config-select-desc-selection')[:_desc]
                ),
                discord.SelectOption(
                    label=t(DEFAULT_LOCALE, 'config-select-option-purchase')[:_label],
                    value=InventoryType.PURCHASE.value,
                    description=t(DEFAULT_LOCALE, 'config-select-desc-purchase')[:_desc]
                ),
                discord.SelectOption(
                    label=t(DEFAULT_LOCALE, 'config-select-option-open')[:_label],
                    value=InventoryType.OPEN.value,
                    description=t(DEFAULT_LOCALE, 'config-select-desc-open')[:_desc]
                ),
                discord.SelectOption(
                    label=t(DEFAULT_LOCALE, 'config-select-option-static')[:_label],
                    value=InventoryType.STATIC.value,
                    description=t(DEFAULT_LOCALE, 'config-select-desc-static')[:_desc]
                ),
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
            channel_types=[
                discord.ChannelType.text,
                discord.ChannelType.forum,
                discord.ChannelType.category
            ],
            placeholder=t(
                DEFAULT_LOCALE, 'config-select-placeholder-rp-channels'
            )[:DiscordLimits.SELECT_PLACEHOLDER],
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
                update_data={
                    '$addToSet': {RoleplayFields.CHANNELS: {'$each': channel_ids}}
                }
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayModeSelect(Select):
    def __init__(self, calling_view):
        _label = DiscordLimits.STRING_SELECT_OPTION_LABEL
        _desc = DiscordLimits.STRING_SELECT_OPTION_DESCRIPTION
        super().__init__(
            placeholder=t(
                DEFAULT_LOCALE, 'config-select-placeholder-rp-mode'
            )[:DiscordLimits.SELECT_PLACEHOLDER],
            options=[
                discord.SelectOption(
                    label=t(
                        DEFAULT_LOCALE, 'config-select-option-scheduled'
                    )[:_label],
                    value=RoleplayMode.SCHEDULED.value,
                    description=t(
                        DEFAULT_LOCALE, 'config-select-desc-scheduled'
                    )[:_desc]
                ),
                discord.SelectOption(
                    label=t(
                        DEFAULT_LOCALE, 'config-select-option-accrued'
                    )[:_label],
                    value=RoleplayMode.ACCRUED.value,
                    description=t(
                        DEFAULT_LOCALE, 'config-select-desc-accrued'
                    )[:_desc]
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
        _label = DiscordLimits.STRING_SELECT_OPTION_LABEL
        _desc = DiscordLimits.STRING_SELECT_OPTION_DESCRIPTION
        super().__init__(
            placeholder=t(
                DEFAULT_LOCALE, 'config-select-placeholder-reset-period'
            )[:DiscordLimits.SELECT_PLACEHOLDER],
            options=[
                discord.SelectOption(
                    label=t(DEFAULT_LOCALE, 'config-select-option-hourly')[:_label],
                    value=ScheduleType.HOURLY.value,
                    description=t(DEFAULT_LOCALE, 'config-select-desc-hourly')[:_desc]
                ),
                discord.SelectOption(
                    label=t(DEFAULT_LOCALE, 'config-select-option-daily')[:_label],
                    value=ScheduleType.DAILY.value,
                    description=t(DEFAULT_LOCALE, 'config-select-desc-daily')[:_desc]
                ),
                discord.SelectOption(
                    label=t(DEFAULT_LOCALE, 'config-select-option-weekly')[:_label],
                    value=ScheduleType.WEEKLY.value,
                    description=t(DEFAULT_LOCALE, 'config-select-desc-weekly')[:_desc]
                )
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
                update_data={
                    '$set': {
                        f'{RoleplayFields.CONFIG}.{RoleplayFields.RESET_PERIOD}':
                            self.values[0]
                    }
                }
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayResetDaySelect(Select):
    def __init__(self, calling_view):
        _label = DiscordLimits.STRING_SELECT_OPTION_LABEL
        super().__init__(
            placeholder=t(
                DEFAULT_LOCALE, 'config-select-placeholder-reset-day'
            )[:DiscordLimits.SELECT_PLACEHOLDER],
            options=[
                discord.SelectOption(
                    label=t(DEFAULT_LOCALE, 'common-day-monday')[:_label],
                    value=DayOfWeek.MONDAY.value
                ),
                discord.SelectOption(
                    label=t(DEFAULT_LOCALE, 'common-day-tuesday')[:_label],
                    value=DayOfWeek.TUESDAY.value
                ),
                discord.SelectOption(
                    label=t(DEFAULT_LOCALE, 'common-day-wednesday')[:_label],
                    value=DayOfWeek.WEDNESDAY.value
                ),
                discord.SelectOption(
                    label=t(DEFAULT_LOCALE, 'common-day-thursday')[:_label],
                    value=DayOfWeek.THURSDAY.value
                ),
                discord.SelectOption(
                    label=t(DEFAULT_LOCALE, 'common-day-friday')[:_label],
                    value=DayOfWeek.FRIDAY.value
                ),
                discord.SelectOption(
                    label=t(DEFAULT_LOCALE, 'common-day-saturday')[:_label],
                    value=DayOfWeek.SATURDAY.value
                ),
                discord.SelectOption(
                    label=t(DEFAULT_LOCALE, 'common-day-sunday')[:_label],
                    value=DayOfWeek.SUNDAY.value
                )
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
                update_data={
                    '$set': {
                        f'{RoleplayFields.CONFIG}.{RoleplayFields.RESET_DAY}':
                            self.values[0]
                    }
                }
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayResetTimeSelect(Select):
    def __init__(self, calling_view):
        _label = DiscordLimits.STRING_SELECT_OPTION_LABEL
        options = []
        for hour in range(0, 24):
            options.append(discord.SelectOption(
                label=t(
                    DEFAULT_LOCALE, 'config-select-option-utc-time',
                    hour=f'{hour:02}'
                )[:_label],
                value=f'{hour}'
            ))

        super().__init__(
            placeholder=t(
                DEFAULT_LOCALE, 'config-select-placeholder-reset-time'
            )[:DiscordLimits.SELECT_PLACEHOLDER],
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
                update_data={
                    '$set': {
                        f'{RoleplayFields.CONFIG}.{RoleplayFields.RESET_TIME}':
                            int(self.values[0])
                    }
                }
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
            placeholder=t(
                DEFAULT_LOCALE, 'config-select-placeholder-forum-channel'
            )[:DiscordLimits.SELECT_PLACEHOLDER],
            custom_id='forum_channel_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            self.calling_view.selected_forum = self.values[0]
            self.calling_view.selected_thread = None  # Reset thread selection

            forum = interaction.guild.get_channel(self.values[0].id)
            self.calling_view.forum_threads = [
                th for th in forum.threads
                if not th.archived and not th.locked
            ][:25]

            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ForumThreadSelect(Select):
    """Select for choosing an existing thread within a forum channel."""
    def __init__(self, calling_view):
        _label = DiscordLimits.STRING_SELECT_OPTION_LABEL
        _desc = DiscordLimits.STRING_SELECT_OPTION_DESCRIPTION
        options = []

        if calling_view.selected_forum:
            threads = calling_view.forum_threads or []

            if threads:
                for thread in threads:
                    options.append(discord.SelectOption(
                        label=thread.name[:_label],
                        value=str(thread.id),
                        description=t(
                            DEFAULT_LOCALE,
                            'config-select-desc-thread-id',
                            threadId=str(thread.id)
                        )[:_desc]
                    ))
            else:
                # Provide a placeholder option if no threads found
                options.append(discord.SelectOption(
                    label=t(
                        DEFAULT_LOCALE, 'config-select-option-no-threads'
                    )[:_label],
                    value='none',
                    description=t(
                        DEFAULT_LOCALE, 'config-select-desc-no-threads'
                    )[:_desc]
                ))

        if not options:
            options.append(discord.SelectOption(
                label=t(
                    DEFAULT_LOCALE, 'config-select-option-select-forum-first'
                )[:_label],
                value='none',
                description=t(
                    DEFAULT_LOCALE,
                    'config-select-desc-select-forum-first'
                )[:_desc]
            ))

        super().__init__(
            placeholder=t(
                DEFAULT_LOCALE, 'config-select-placeholder-thread'
            )[:DiscordLimits.SELECT_PLACEHOLDER],
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


class ConfigLanguageSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder=t(
                DEFAULT_LOCALE, 'config-select-placeholder-server-language'
            )[:DiscordLimits.SELECT_PLACEHOLDER],
            options=[],
            custom_id='config_language_select'
        )
        self.calling_view = calling_view

    def populate(self, locale, current_guild_locale=None, page=0):
        _label = DiscordLimits.STRING_SELECT_OPTION_LABEL
        _desc = DiscordLimits.STRING_SELECT_OPTION_DESCRIPTION
        self.options.clear()
        # Page 0 reserves one slot for the "Default" option
        per_page_0 = LOCALES_PER_PAGE - 1
        if page == 0:
            self.options.append(discord.SelectOption(
                label=t(
                    locale, 'config-select-option-default'
                )[:_label],
                description=t(
                    locale, 'config-select-desc-default'
                )[:_desc],
                value='default',
                default=(current_guild_locale is None)
            ))
            page_locales = SUPPORTED_LOCALES[:per_page_0]
        else:
            start = per_page_0 + (page - 1) * LOCALES_PER_PAGE
            end = start + LOCALES_PER_PAGE
            page_locales = SUPPORTED_LOCALES[start:end]

        total_pages = get_config_locale_total_pages()
        if total_pages > 1:
            self.placeholder = t(
                locale, 'info-language-select-placeholder-paged',
                current=page + 1, total=total_pages
            )[:DiscordLimits.SELECT_PLACEHOLDER]
        else:
            self.placeholder = t(
                locale, 'config-select-placeholder-server-language'
            )[:DiscordLimits.SELECT_PLACEHOLDER]

        for supported_locale in page_locales:
            self.options.append(discord.SelectOption(
                label=t(
                    locale, LOCALE_LABELS[supported_locale]
                )[:_label],
                description=t(
                    locale, LOCALE_DESCRIPTIONS[supported_locale]
                )[:_desc],
                emoji=LOCALE_EMOJI.get(supported_locale),
                value=supported_locale,
                default=(supported_locale == current_guild_locale)
            ))

    async def callback(self, interaction: discord.Interaction):
        try:
            selected = self.values[0]
            bot = interaction.client

            if selected == 'default':
                await delete_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name=DatabaseCollections.GUILD_LOCALE,
                    search_filter={CommonFields.ID: interaction.guild_id}
                )
            else:
                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name=DatabaseCollections.GUILD_LOCALE,
                    query={CommonFields.ID: interaction.guild_id},
                    update_data={'$set': {'locale': selected}}
                )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class QuestRoleModeSelect(Select):
    def __init__(self, calling_view):
        _label = DiscordLimits.STRING_SELECT_OPTION_LABEL
        _desc = DiscordLimits.STRING_SELECT_OPTION_DESCRIPTION
        super().__init__(
            placeholder=t(
                DEFAULT_LOCALE, 'config-select-placeholder-quest-role-mode'
            )[:DiscordLimits.SELECT_PLACEHOLDER],
            options=[
                discord.SelectOption(
                    label=t(
                        DEFAULT_LOCALE,
                        'config-select-option-quest-role-disabled'
                    )[:_label],
                    value=QuestRoleMode.DISABLED.value,
                    description=t(
                        DEFAULT_LOCALE,
                        'config-select-desc-quest-role-disabled'
                    )[:_desc]
                ),
                discord.SelectOption(
                    label=t(
                        DEFAULT_LOCALE,
                        'config-select-option-quest-role-temporary'
                    )[:_label],
                    value=QuestRoleMode.TEMPORARY.value,
                    description=t(
                        DEFAULT_LOCALE,
                        'config-select-desc-quest-role-temporary'
                    )[:_desc]
                ),
                discord.SelectOption(
                    label=t(
                        DEFAULT_LOCALE,
                        'config-select-option-quest-role-static'
                    )[:_label],
                    value=QuestRoleMode.STATIC.value,
                    description=t(
                        DEFAULT_LOCALE,
                        'config-select-desc-quest-role-static'
                    )[:_desc]
                ),
            ],
            custom_id='quest_role_mode_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUEST_ROLE_MODE,
                query={'_id': interaction.guild_id},
                update_data={
                    '$set': {ConfigFields.QUEST_ROLE_MODE: self.values[0]}
                }
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class AddGMQuestRoleSelect(RoleSelect):
    def __init__(self, calling_view, member_id):
        import uuid
        super().__init__(
            placeholder=t(
                DEFAULT_LOCALE, 'config-select-placeholder-add-quest-role'
            )[:DiscordLimits.SELECT_PLACEHOLDER],
            custom_id=f'add_gm_quest_role_select:{uuid.uuid4().hex[:8]}',
            max_values=MAX_QUEST_ROLES_PER_GM
        )
        self.calling_view = calling_view
        self.member_id = member_id

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id

            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUEST_ROLE_ASSIGNMENTS,
                query={'_id': guild_id}
            )
            existing = []
            if query:
                existing = query.get(ConfigFields.QUEST_ROLE_ASSIGNMENTS, [])

            max_roles_per_gm = MAX_QUEST_ROLES_PER_GM
            member_id_str = str(self.member_id)
            member_existing = [
                a for a in existing if a['userId'] == member_id_str
            ]

            bot_top_role = interaction.guild.me.top_role
            new_assignments = []
            rejected_roles = []
            for role in self.values:
                # Reject roles the bot cannot manage
                if role.managed or role.is_default() or role >= bot_top_role:
                    rejected_roles.append(role)
                    continue

                already_assigned = any(
                    a['userId'] == member_id_str and a['roleId'] == role.id
                    for a in existing
                )
                if not already_assigned:
                    if len(member_existing) + len(new_assignments) >= max_roles_per_gm:
                        break
                    new_assignments.append({
                        'userId': member_id_str,
                        'roleId': role.id,
                        'roleName': role.name
                    })

            if new_assignments:
                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name=DatabaseCollections.QUEST_ROLE_ASSIGNMENTS,
                    query={'_id': guild_id},
                    update_data={
                        '$push': {
                            ConfigFields.QUEST_ROLE_ASSIGNMENTS: {
                                '$each': new_assignments
                            }
                        }
                    }
                )

            locale = getattr(self.calling_view, 'locale', DEFAULT_LOCALE)
            at_limit = (
                len(member_existing) + len(new_assignments) >= max_roles_per_gm
            )
            if rejected_roles or at_limit:
                messages = []
                if rejected_roles:
                    rejected_list = ', '.join(
                        r.mention for r in rejected_roles
                    )
                    messages.append(t(
                        locale, 'config-error-unmanageable-roles',
                        roles=rejected_list
                    ))
                if at_limit:
                    messages.append(t(
                        locale, 'config-error-quest-role-limit',
                        limit=str(max_roles_per_gm)
                    ))
                self.calling_view.error_message = '\n'.join(messages)
            else:
                self.calling_view.error_message = None

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)
