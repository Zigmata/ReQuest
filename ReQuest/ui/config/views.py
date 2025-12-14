import logging
import math
from collections import namedtuple
from typing import List
from titlecase import titlecase

import discord
from discord import ButtonStyle
from discord.ui import (
    LayoutView,
    Container,
    Section,
    Separator,
    ActionRow,
    Button,
    TextDisplay,
    Thumbnail
)

from ReQuest.ui.common import modals as common_modals, views as common_views
from ReQuest.ui.common.buttons import MenuViewButton, BackButton
from ReQuest.ui.config import buttons, selects, enums
from ReQuest.ui.config.buttons import AddShopJSONButton
from ReQuest.utilities.supportFunctions import (
    log_exception,
    strip_id,
    format_price_string,
    format_consolidated_totals,
    get_xp_config,
    get_cached_data
)

logger = logging.getLogger(__name__)


class ConfigBaseView(common_views.MenuBaseView):
    def __init__(self):
        super().__init__(
            title='Server Configuration - Main Menu',
            menu_items=[
                {
                    'name': 'Config Wizard',
                    'description': 'Validate your server is ready to use ReQuest with a quick scan.',
                    'view_class': ConfigWizardView
                },
                {
                    'name': 'Roles',
                    'description': 'Configuration options for pingable or privileged roles.',
                    'view_class': ConfigRolesView
                },
                {
                    'name': 'Channels',
                    'description': 'Set designated channels for ReQuest posts.',
                    'view_class': ConfigChannelsView
                },
                {
                    'name': 'Quests',
                    'description': 'Global quest settings, such as wait lists.',
                    'view_class': ConfigQuestsView
                },
                {
                    'name': 'Players',
                    'description': 'Global player settings, such as experience point tracking.',
                    'view_class': ConfigPlayersView
                },
                {
                    'name': 'Currency',
                    'description': 'Global currency settings.',
                    'view_class': ConfigCurrencyView
                },
                {
                    'name': 'Shops',
                    'description': 'Configure custom shops.',
                    'view_class': ConfigShopsView
                }
            ],
            menu_level=0
        )


# ------ WIZARD ------


class ConfigWizardView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.pages = []
        self.current_page = 0
        self.total_pages = 4
        self.intro_text = (
            '**Welcome to the ReQuest Configuration Wizard!**\n\n'
            'This wizard will help you ensure that your server is properly configured to use ReQuest\'s features. '
            'It will scan your current settings and provide recommendations for any adjustments needed.\n\n'
            'Use the "Launch Scan" button below to begin the validation process. Once the scan is complete, '
            'you will receive a detailed report of your server\'s configuration along with any recommended changes.'
        )

        self.build_view()

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.accessory.label = 'Quit'  # Overriding button label to avoid confusion w/ pagination
        header_section.add_item(TextDisplay('**Server Configuration - Wizard**'))
        container.add_item(header_section)
        container.add_item(Separator())

        if not self.pages:
            container.add_item(TextDisplay(self.intro_text))
            container.add_item(Separator())

            container.add_item(ActionRow(buttons.ScanServerButton(self)))
        else:
            page_data = self.pages[self.current_page]

            if 'custom_sections' in page_data:
                if page_data.get('content'):
                    container.add_item(TextDisplay(page_data['content']))
                    container.add_item(Separator())

                # Build custom sections
                for section_data in page_data['custom_sections']:
                    content = section_data.get('content')
                    button = section_data.get('shortcut_button')

                    if content and button:
                        section = Section(accessory=button)
                        section.add_item(TextDisplay(content))
                        container.add_item(section)
                        container.add_item(Separator())
                    elif content:
                        container.add_item(TextDisplay(content))
                        container.add_item(Separator())
            else:
                content_text = page_data['content']
                shortcut_button = page_data.get('shortcut_button')

                if shortcut_button:
                    section = Section(accessory=shortcut_button)
                    section.add_item(TextDisplay(content_text))
                    container.add_item(section)
                    container.add_item(Separator())
                else:
                    container.add_item(TextDisplay(content_text))
                    container.add_item(Separator())

            # Navigation
            nav_row = ActionRow()

            prev_button = Button(
                label='Previous',
                style=ButtonStyle.secondary,
                custom_id='wizard_prev_page',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page_callback
            nav_row.add_item(prev_button)

            page_button = Button(
                label=f'Page {self.current_page + 1} of {len(self.pages)}',
                style=ButtonStyle.secondary,
                custom_id='wizard_page_indicator'
            )
            page_button.callback = self.show_page_jump_modal
            nav_row.add_item(page_button)

            next_button = Button(
                label='Next',
                style=ButtonStyle.secondary,
                custom_id='wizard_next_page',
                disabled=(self.current_page == len(self.pages) - 1)
            )
            next_button.callback = self.next_page_callback
            nav_row.add_item(next_button)

            scan_button = buttons.ScanServerButton(self)
            scan_button.label = 'Re-Scan'
            nav_row.add_item(scan_button)

            container.add_item(nav_row)

        self.add_item(container)

    async def prev_page_callback(self, interaction: discord.Interaction):
        if self.current_page > 0:
            self.current_page -= 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def show_page_jump_modal(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(common_modals.PageJumpModal(self))
        except Exception as e:
            logging.error(f'Failed to send PageJumpModal: {e}')
            await interaction.response.send_message('Could not open page selector', ephemeral=True)

    async def next_page_callback(self, interaction: discord.Interaction):
        if self.current_page < len(self.pages) - 1:
            self.current_page += 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    @staticmethod
    def validate_bot_permission(guild):
        """
        Validate the bot's global permissions.
        Returns (report_string, has_warnings_boolean)
        """
        try:
            bot_member = guild.me
            bot_perms = bot_member.guild_permissions

            # Use a dictionary to map permission attribute names to readable names
            required_permissions = {
                'view_channel': 'View Channels',
                'manage_roles': 'Manage Roles',
                'send_messages': 'Send Messages',
                'attach_files': 'Attach Files',
                'add_reactions': 'Add Reactions',
                'use_external_emojis': 'Use External Emoji',
                'manage_messages': 'Manage Messages',
                'read_message_history': 'Read Message History'
            }

            missing_perms = []

            for attr, name in required_permissions.items():
                if not getattr(bot_perms, attr):
                    missing_perms.append(f'- ⚠️ Missing: `{name}`')

            report_lines = [
                '__**Bot Global Permissions**__',
                'This section verifies that ReQuest has the correct permissions to function correctly.\n',
                f'Bot Role: {bot_member.top_role.mention}'
            ]

            if missing_perms:
                report_lines.append('**Status: ⚠️ WARNINGS FOUND**')
                report_lines.extend(missing_perms)
                report_lines.append('')
                report_lines.append('Please ensure the bot\'s highest role has these permissions granted globally.')
                return '\n'.join(report_lines), True
            else:
                report_lines.append('**Status: ✅ OK**')
                report_lines.append('The bot has all required global permissions.')
                return '\n'.join(report_lines), False

        except Exception as e:
            required_perms_list = [
                'View Channels',
                'Manage Roles',
                'Send Messages',
                'Attach Files',
                'Add Reactions',
                'Use External Emoji',
                'Manage Messages',
                'Read Message History'
            ]

            report_lines = [
                '__**Bot Global Permissions**__',
                '**Status: ❌ SCAN FAILED**',
                'An unexpected error occurred while checking bot permissions.',
                f'Error: {type(e).__name__}',
                '',
                '**Required Permissions for the Bot\'s Role:**',
                '\n'.join([f'- {p}' for p in required_perms_list])
            ]

            return '\n'.join(report_lines), True

    def validate_roles(self, guild, gm_roles_config, announcement_role_config):
        """
        Validate the permissions for default and GM roles.
        """
        has_warnings = False
        report_lines = [
            '__**Role Configurations**__',
            'This section verifies the following:\n'
            '- GM roles (required) and Announcement role (optional) are configured.\n'
            '- The default (@everyone) role has required permissions for users to access bot features.\n'
            '- The default (@everyone) role does not have dangerous permissions.\n'
            '- GM and Announcement roles are checked to see if they have any permission escalations '
            'beyond the default role.\n',
            'Any warnings here are solely recommendations based on a default setup. Depending on your server\'s '
            'needs, you may have reason to disregard some of these recommendations.\n'
        ]

        # Validate default (@everyone) role
        default_role = guild.default_role
        default_issues = []

        # These are needed for users to access the bot's features
        required_default_permissions = {
            'view_channel': 'View Channels',
            'read_message_history': 'Read Message History',
            'send_messages': 'Send Messages',
            'send_messages_in_threads': 'Send Messages in Threads',
            'use_application_commands': 'Use Application Commands'
        }

        for permission, name in required_default_permissions.items():
            if not getattr(default_role.permissions, permission):
                default_issues.append(f'- Missing Permission: `{name}`')

        # These are generally a bad idea, or may enable users to circumvent bot features
        dangerous_permissions = {
            'manage_channels': 'Manage Channels',
            'manage_roles': 'Manage Roles',
            'manage_webhooks': 'Manage Webhooks',
            'manage_guild': 'Manage Server',
            'manage_nicknames': 'Manage Nicknames',
            'kick_members': 'Kick Members',
            'ban_members': 'Ban Members',
            'moderate_members': 'Timeout Members',
            'mention_everyone': 'Mention @everyone',
            'manage_messages': 'Manage Messages',
            'manage_threads': 'Manage Threads',
            'administrator': 'Administrator'
        }

        for permission, name in dangerous_permissions.items():
            if getattr(default_role.permissions, permission):
                default_issues.append(f'- `{name}`')

        if default_issues:
            has_warnings = True
            report_lines.append('**Default Role:**\n⚠️ @everyone: Dangerous Permissions Found:')
            report_lines.extend(default_issues)
        else:
            report_lines.append('**Default Role:**\n- ✅ @everyone: OK')

        # Validate at least one GM role is configured, and does not extend permissions of the default role
        if not gm_roles_config or not gm_roles_config.get('gmRoles'):
            has_warnings = True
            report_lines.append('\n**GM Roles:**\n- ⚠️ No GM Roles Configured')
        else:
            report_lines.append('\n**GM Roles:**')
            for role_data in gm_roles_config['gmRoles']:
                try:
                    role_id = strip_id(role_data['mention'])
                    role = guild.get_role(role_id)

                    if not role:
                        has_warnings = True
                        report_lines.append(f'- ⚠️ **{role_data["name"]}:** Configured Role Not Found/Deleted '
                                            f'from Server')
                        continue

                    escalation_report = self._has_escalations(role, default_role)

                    if escalation_report.has_escalations:
                        has_warnings = True
                        report_lines.extend(escalation_report.report_lines)
                    else:
                        report_lines.append(f'- ✅ {role.mention}: OK')
                except Exception as e:
                    logger.error(f'Error validating role {role_data}: {e}')
                    report_lines.append(f'- Error validating {role_data["name"]}')

        # Validate announcement role
        if not announcement_role_config or not announcement_role_config.get('announceRole'):
            has_warnings = True
            report_lines.append('\n**Announcement Role:**\n- ℹ️ No Announcement Role Configured')
        else:
            try:
                role_id = strip_id(announcement_role_config['announceRole'])
                role = guild.get_role(role_id)

                if not role:
                    has_warnings = True
                    report_lines.append(
                        '\n**Announcement Role:**\n- ⚠️ Configured Role Not Found/Deleted from Server'
                    )
                else:
                    escalation_report = self._has_escalations(role, default_role)

                    if escalation_report.has_escalations:
                        has_warnings = True
                        report_lines.append('\n**Announcement Role:**')
                        report_lines.extend(escalation_report.report_lines)
                    else:
                        report_lines.append(f'\n**Announcement Role:**\n- ✅ {role.mention}: OK')
            except Exception as e:
                logger.error(f'Error validating announcement role: {e}')
                report_lines.append('- Error validating Announcement Role')

        if has_warnings:
            return '\n'.join(report_lines), True
        else:
            return '\n'.join(report_lines), False

    @staticmethod
    def validate_channels(guild, channels: List[dict]):
        """
        Validate configured channels and their permissions.
        """
        report_lines = [
            '__**Channel Configurations**__',
            'This section verifies the following:\n'
            '- Configured channels exist.\n'
            '- The bot has permission to view and send messages in the configured channels.\n'
            '- The default (@everyone) role does not have `Send Messages` permissions.\n'
        ]

        has_warnings = False

        bot_member = guild.me

        for channel in channels:
            name = channel['name']
            mention = channel['mention']
            required = channel['required']

            if not mention:
                if required:
                    has_warnings = True
                    report_lines.append(f'\n**{name}:**\n- ⚠️ No Channel Configured')
                else:
                    report_lines.append(f'\n**{name}:**\n- ℹ️ Not Configured (Optional)')
                continue

            try:
                channel_id = strip_id(mention)
                channel = guild.get_channel(channel_id)

                if not channel:
                    has_warnings = True
                    report_lines.append(f'\n**{name}:**\n'
                                        f'- ⚠️ Configured Channel Not Found/Deleted from Server')
                    continue

                # Check bot permissions
                bot_permissions = channel.permissions_for(bot_member)
                channel_issues = []

                bot_mention = bot_member.mention

                if not bot_permissions.view_channel:
                    channel_issues.append(f'- ⚠️ {bot_mention} cannot view this channel.')
                if not bot_permissions.send_messages:
                    channel_issues.append(f'- ⚠️ {bot_mention} cannot send messages in this channel.')

                # Check default role permissions
                default_role = guild.default_role
                default_permissions = channel.permissions_for(default_role)
                if default_permissions.send_messages:
                    channel_issues.append('- ⚠️ @everyone can send messages in this channel.')

                if channel_issues:
                    has_warnings = True
                    report_lines.append(f'\n**{name} ({channel.mention}):**')
                    report_lines.extend(channel_issues)
                else:
                    report_lines.append(f'\n**{name} ({channel.mention}):**\n- ✅ OK')
            except Exception as e:
                logger.error(f'Error validating channel {name}: {e}')
                report_lines.append(f'- Error validating {name} channel')
                has_warnings = True

        button = MenuViewButton(ConfigChannelsView, 'Configure Channels')
        button.disabled = not has_warnings

        return '\n'.join(report_lines), button

    @staticmethod
    def _has_escalations(role, default_role):
        report_lines = []
        escalations = []
        for permission_name, value in role.permissions:
            if value and not getattr(default_role.permissions, permission_name):
                # Format names to be readable
                formatted_name = permission_name.replace('_', ' ').title()
                escalations.append(formatted_name)

        result = namedtuple('EscalationResult', ['has_escalations', 'report_lines'])
        if escalations:
            if 'Administrator' in escalations:
                escalations_str = 'Administrator'
            else:
                escalations_str = ', '.join(escalations[:3])
                if len(escalations) > 3:
                    escalations_str += f', and {len(escalations) - 3} more...'

            report_lines.append(
                f'- ⚠️ {role.mention}: Permission Escalations Detected - {escalations_str}'
            )
            return result(True, report_lines)
        else:
            return result(False, report_lines)

    @staticmethod
    def _format_currency_report(currency_config):
        report_lines = []
        if not currency_config or not currency_config.get('currencies'):
            report_lines.append('- ℹ️ No Currencies Configured')
            return '\n'.join(report_lines)

        report_lines.append('**Configured Currencies:**')
        for currency in currency_config['currencies']:
            name = currency['name']
            denominations = currency.get('denominations', {})

            lines = [f'- **{name}**']

            if denominations:
                denomination_list = []
                for denomination in denominations:
                    denom_name = denomination['name']
                    denom_value = denomination['value']
                    denomination_list.append(f'  - {denom_name}: {denom_value}')
                lines.extend(denomination_list)
            else:
                lines.append('  - No Denominations Configured')

            report_lines.extend(lines)

        return '\n'.join(report_lines)

    @staticmethod
    def _format_gm_rewards_report(gm_rewards_query):
        report_lines = []
        if not gm_rewards_query or (not gm_rewards_query.get('experience') and not gm_rewards_query.get('items')):
            report_lines.append('**Status:** Disabled')
            return '\n'.join(report_lines)

        report_lines.append('**Status:** Enabled')
        experience = gm_rewards_query.get('experience')
        items = gm_rewards_query.get('items')

        if experience and experience > 0:
            report_lines.append(f'- Experience: {experience}')

        if items:
            report_lines.append('- Items:')
            for item_name, quantity in items.items():
                report_lines.append(f'  - {titlecase(item_name)}: {quantity}')

        return '\n'.join(report_lines)

    def validate_dashboard_settings(self, wait_list_query, quest_summary_query, gm_rewards_query,
                                    player_xp_query, currency_config):

        # Fetch data
        wait_list_size = wait_list_query.get('questWaitList', 0) if wait_list_query else 0
        summary_enabled = quest_summary_query.get('questSummary', False) if quest_summary_query else False
        xp_enabled = player_xp_query.get('playerExperience', False) if player_xp_query else False

        # Define different sections/components
        components = []

        # Quest Settings
        quest_section_content = [
            '**Quest Settings**',
            f'- Quest Wait List Size: {wait_list_size if wait_list_size > 0 else "Disabled"}',
            f'- Quest Summary: {"Enabled" if summary_enabled else "Disabled"}',
            f'\n**GM Rewards (Per Quest)**',
            self._format_gm_rewards_report(gm_rewards_query)
        ]
        components.append({
            'content': '\n'.join(quest_section_content),
            'shortcut_button': MenuViewButton(ConfigQuestsView, 'Configure Quests')
        })

        # Player Settings
        player_section_content = [
            '**Player Settings**',
            f'- Player Experience: {"Enabled" if xp_enabled else "Disabled"}'
        ]
        components.append({
            'content': '\n'.join(player_section_content),
            'shortcut_button': MenuViewButton(ConfigPlayersView, 'Configure Players')
        })

        # Currency Settings
        currency_section_content = [
            '**Currency Settings**',
            self._format_currency_report(currency_config)
        ]
        components.append({
            'content': '\n'.join(currency_section_content),
            'shortcut_button': MenuViewButton(ConfigCurrencyView, 'Configure Currency')
        })

        # Header
        intro_content = [
            '__**Settings Dashboard**__',
            'This section provides an overview of non-essential configurations for quick reference.\n'
        ]

        return {
            'intro': '\n'.join(intro_content),
            'sections': components
        }

    async def run_scan(self, interaction):
        try:
            bot = interaction.client
            guild = interaction.guild
            gdb = interaction.client.gdb

            # Bot permissions
            bot_permission_text, bot_permission_warnings = self.validate_bot_permission(guild)

            # Role configs
            announcement_role_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name='announceRole',
                query={'_id': guild.id}
            )
            gm_roles_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name='gmRoles',
                query={'_id': guild.id}
            )

            # Channel configs
            channels = []
            quest_channel_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name='questChannel',
                query={'_id': guild.id}
            )
            channels.append(
                {
                    'name': 'Quest Board',
                    'mention': quest_channel_query['questChannel'] if quest_channel_query else None,
                    'required': True}
            )

            player_channel_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name='playerBoardChannel',
                query={'_id': guild.id}
            )
            channels.append(
                {
                    'name': 'Player Board',
                    'mention': player_channel_query['playerBoardChannel'] if player_channel_query else None,
                    'required': False}
            )

            archive_channel_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name='archiveChannel',
                query={'_id': guild.id}
            )
            channels.append(
                {
                    'name': 'Quest Archive',
                    'mention': archive_channel_query['archiveChannel'] if archive_channel_query else None,
                    'required': False
                }
            )

            gm_log_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name='gmTransactionLogChannel',
                query={'_id': guild.id}
            )
            channels.append(
                {
                    'name': 'GM Transaction Log',
                    'mention': gm_log_query['gmTransactionLogChannel'] if gm_log_query else None,
                    'required': False
                }
            )

            player_transaction_log_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name='playerTransactionLogChannel',
                query={'_id': guild.id}
            )
            channels.append(
                {
                    'name': 'Player Transaction Log',
                    'mention': player_transaction_log_query['playerTransactionLogChannel'] if player_transaction_log_query else None,
                    'required': False
                }
            )

            shop_log_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name='shopLogChannel',
                query={'_id': guild.id}
            )
            channels.append(
                {
                    'name': 'Shop Log',
                    'mention': shop_log_query['shopLogChannel'] if shop_log_query else None,
                    'required': False
                }
            )

            # Dashboard configs
            wait_list_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name='questWaitList',
                query={'_id': guild.id}
            )
            quest_summary_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name='questSummary',
                query={'_id': guild.id}
            )
            gm_rewards_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name='gmRewards',
                query={'_id': guild.id}
            )
            player_xp_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name='playerExperience',
                query={'_id': guild.id}
            )
            currency_config_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name='currency',
                query={'_id': guild.id}
            )

            # Role validation report
            role_text, role_has_warnings = self.validate_roles(guild, gm_roles_query, announcement_role_query)
            role_button = MenuViewButton(ConfigRolesView, 'Configure Roles')
            role_button.disabled = not role_has_warnings

            # Channel validation report
            channel_text, channel_button = self.validate_channels(guild, channels)

            # Dashboard settings report
            dashboard_data = self.validate_dashboard_settings(
                wait_list_query, quest_summary_query, gm_rewards_query, player_xp_query, currency_config_query
            )

            # Compile pages
            self.pages = [
                {
                    'content': bot_permission_text,
                    'shortcut_button': None
                },
                {
                    'content': role_text,
                    'shortcut_button': role_button
                },
                {
                    'content': channel_text,
                    'shortcut_button': channel_button
                },
                {
                    'content': dashboard_data.get('intro'),
                    'custom_sections': dashboard_data.get('sections', [])
                }
            ]

            self.current_page = 0
            self.build_view()

            await interaction.edit_original_response(view=self)
        except Exception as e:
            await log_exception(e, interaction)


# ------ ROLES ------


class ConfigRolesView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)

        self.announcement_role_status = TextDisplay(
            '**Announcement Role:** Not Configured\n'
            'This role is mentioned when a quest is posted.'
        )
        self.gm_roles_status = TextDisplay(
            '**GM Role(s):** Not Configured\n'
            'These roles will grant access to Game Master commands and features.'
        )

        self.quest_announce_role_select = selects.QuestAnnounceRoleSelect(self)
        self.quest_announce_role_remove_button = buttons.QuestAnnounceRoleRemoveButton(self)
        self.add_gm_role_select = selects.AddGMRoleSelect(self)
        self.gm_role_remove_view_button = buttons.GMRoleRemoveViewButton(ConfigGMRoleRemoveView)
        self.forbidden_roles_button = buttons.ForbiddenRolesButton(self)

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay('**Server Configuration - Roles**'))

        container.add_item(header_section)
        container.add_item(Separator())

        announcement_role_section = Section(accessory=self.quest_announce_role_remove_button)
        announcement_role_section.add_item(self.announcement_role_status)
        container.add_item(announcement_role_section)
        announce_role_select_row = ActionRow(self.quest_announce_role_select)
        container.add_item(announce_role_select_row)
        container.add_item(Separator())

        gm_role_section = Section(accessory=self.gm_role_remove_view_button)
        gm_role_section.add_item(self.gm_roles_status)
        container.add_item(gm_role_section)
        gm_role_select_row = ActionRow(self.add_gm_role_select)
        container.add_item(gm_role_select_row)
        container.add_item(Separator())

        container.add_item(TextDisplay(
            '__**Forbidden Roles**__\n'
            'Configures a list of role names that cannot be used by Game Masters for their party roles. '
            'By default, `everyone`, `administrator`, `gm`, and `game master` cannot be used. This configuration '
            'extends that list.\n'
        ))
        role_row_5 = ActionRow(self.forbidden_roles_button)
        container.add_item(role_row_5)

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            announcement_role = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='announceRole',
                query={'_id': guild.id}
            )
            gm_roles = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='gmRoles',
                query={'_id': guild.id}
            )

            if not announcement_role:
                announcement_role_string = (
                    '**Announcement Role:** Not Configured\n'
                    'This role is mentioned when a quest is posted.'
                )
                self.quest_announce_role_remove_button.disabled = True
            else:
                announcement_role_string = (
                    f'**Announcement Role:** {announcement_role}\n'
                    'This role is mentioned when a quest is posted.'
                )
                self.quest_announce_role_remove_button.disabled = False

            if not gm_roles:
                gm_roles_string = ('**GM Role(s):** Not Configured\n'
                                   'These roles will grant access to Game Master commands and features.')
                self.gm_role_remove_view_button.disabled = True
            else:
                role_mentions = []
                for role in gm_roles:
                    role_mentions.append(role['mention'])

                gm_roles_string = (f'**GM Role(s):** {', '.join(role_mentions)}\n'
                                   f'These roles will grant access to Game Master commands and features.')
                self.gm_role_remove_view_button.disabled = False

            self.announcement_role_status.content = announcement_role_string
            self.gm_roles_status.content = gm_roles_string

            self.build_view()
        except Exception as e:
            await log_exception(e)


class ConfigGMRoleRemoveView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.roles = []

        self.items_per_page = 10
        self.current_page = 0
        self.total_pages = 1

    async def setup(self, bot, guild):
        try:
            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='gmRoles',
                query={'_id': guild.id}
            )

            self.roles = query.get('gmRoles', []) if query else []
            self.roles.sort(key=lambda x: x.get('name', '').lower())

            self.total_pages = math.ceil(len(self.roles) / self.items_per_page)
            if self.total_pages == 0:
                self.total_pages = 1

            if self.current_page >= self.total_pages:
                self.current_page = max(0, self.total_pages - 1)

            self.build_view()
        except Exception as e:
            await log_exception(e)

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigRolesView))
        header_section.add_item(TextDisplay('**Server Configuration - Remove GM Role(s)**'))
        container.add_item(header_section)
        container.add_item(Separator())

        if not self.roles:
            container.add_item(TextDisplay("No GM roles configured."))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_roles = self.roles[start:end]

            for role in page_roles:
                name = role.get('name', 'Unknown')
                mention = role.get('mention', '')

                info = f"{mention}"

                section = Section(accessory=buttons.RemoveGMRoleButton(self, name))
                section.add_item(TextDisplay(info))
                container.add_item(section)

        self.add_item(container)

        if self.total_pages > 1:
            nav_row = ActionRow()

            prev_button = Button(
                label='Previous',
                style=discord.ButtonStyle.secondary,
                custom_id='gm_role_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_display = Button(
                label=f'Page {self.current_page + 1}/{self.total_pages}',
                style=discord.ButtonStyle.secondary,
                custom_id='gm_role_page'
            )
            page_display.callback = self.show_page_jump_modal
            nav_row.add_item(page_display)

            next_button = Button(
                label='Next',
                style=discord.ButtonStyle.secondary,
                custom_id='gm_role_next',
                disabled=(self.current_page >= self.total_pages - 1)
            )
            next_button.callback = self.next_page
            nav_row.add_item(next_button)

            self.add_item(nav_row)

    async def prev_page(self, interaction):
        if self.current_page > 0:
            self.current_page -= 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def next_page(self, interaction):
        if self.current_page < self.total_pages - 1:
            self.current_page += 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def show_page_jump_modal(self, interaction):
        try:
            await interaction.response.send_modal(common_modals.PageJumpModal(self))
        except Exception as e:
            await log_exception(e, interaction)


# ------ CHANNELS ------


class ConfigChannelsView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.quest_board_info = TextDisplay(
            '**Quest Board:** Not Configured\n'
            'The channel where new/active quests will be posted.'
        )
        self.player_board_info = TextDisplay(
            '**Player Board:** Not Configured\n'
            'An optional announcement/message board for use by players.'
        )
        self.quest_archive_info = TextDisplay(
            '**Quest Archive:** Not Configured\n'
            'An optional channel where completed quests will move to, with summary information.'
        )
        self.gm_transaction_log_info = TextDisplay(
            '**GM Transaction Log:** Not Configured\n'
            'An optional channel where GM transactions (i.e. Modify Player commands) are logged.'
        )
        self.player_transaction_log_info = TextDisplay(
            '**Player Transaction Log:** Not Configured\n'
            'An optional channel where player transactions such as trading and consuming items are logged.'
        )
        self.shop_log_info = TextDisplay(
            '**Shop Log:** Not Configured\n'
            'An optional channel where shop transactions are logged.'
        )
        self.quest_channel_select = selects.SingleChannelConfigSelect(
            calling_view=self,
            config_type='questChannel',
            config_name='Quest Board'
        )
        self.player_board_channel_select = selects.SingleChannelConfigSelect(
            calling_view=self,
            config_type='playerBoardChannel',
            config_name='Player Board'
        )
        self.archive_channel_select = selects.SingleChannelConfigSelect(
            calling_view=self,
            config_type='archiveChannel',
            config_name='Quest Archive'
        )
        self.gm_transaction_log_channel_select = selects.SingleChannelConfigSelect(
            calling_view=self,
            config_type='gmTransactionLogChannel',
            config_name='GM Transaction Log'
        )
        self.player_transaction_log_channel_select = selects.SingleChannelConfigSelect(
            calling_view=self,
            config_type='playerTransactionLogChannel',
            config_name='Player Transaction Log'
        )
        self.shop_log_channel_select = selects.SingleChannelConfigSelect(
            calling_view=self,
            config_type='shopLogChannel',
            config_name='Shop Log'
        )

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay('**Server Configuration - Channels**'))

        container.add_item(header_section)
        container.add_item(Separator())

        quest_board_section = Section(accessory=buttons.ClearChannelButton(self, 'questChannel'))
        quest_board_section.add_item(self.quest_board_info)
        container.add_item(quest_board_section)
        quest_board_select_row = ActionRow(self.quest_channel_select)
        container.add_item(quest_board_select_row)
        container.add_item(Separator())

        player_board_section = Section(accessory=buttons.ClearChannelButton(self, 'playerBoardChannel'))
        player_board_section.add_item(self.player_board_info)
        container.add_item(player_board_section)
        player_board_select_row = ActionRow(self.player_board_channel_select)
        container.add_item(player_board_select_row)
        container.add_item(Separator())

        quest_archive_section = Section(accessory=buttons.ClearChannelButton(self, 'archiveChannel'))
        quest_archive_section.add_item(self.quest_archive_info)
        container.add_item(quest_archive_section)
        quest_archive_select_row = ActionRow(self.archive_channel_select)
        container.add_item(quest_archive_select_row)
        container.add_item(Separator())

        gm_transaction_log_section = Section(accessory=buttons.ClearChannelButton(self,
                                                                                  'gmTransactionLogChannel'))
        gm_transaction_log_section.add_item(self.gm_transaction_log_info)
        container.add_item(gm_transaction_log_section)
        gm_transaction_log_select_row = ActionRow(self.gm_transaction_log_channel_select)
        container.add_item(gm_transaction_log_select_row)
        container.add_item(Separator())

        player_transaction_log_section = Section(accessory=buttons.ClearChannelButton(self,
                                                                                      'playerTransactionLogChannel'))
        player_transaction_log_section.add_item(self.player_transaction_log_info)
        container.add_item(player_transaction_log_section)
        player_transaction_log_select_row = ActionRow(self.player_transaction_log_channel_select)
        container.add_item(player_transaction_log_select_row)
        container.add_item(Separator())

        shop_log_section = Section(accessory=buttons.ClearChannelButton(self, 'shopLogChannel'))
        shop_log_section.add_item(self.shop_log_info)
        container.add_item(shop_log_section)
        shop_log_select_row = ActionRow(self.shop_log_channel_select)
        container.add_item(shop_log_select_row)

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            player_board = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='playerBoardChannel',
                query={'_id': guild.id}
            )
            quest_board = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='questChannel',
                query={'_id': guild.id}
            )
            quest_archive = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='archiveChannel',
                query={'_id': guild.id}
            )
            gm_transaction_log = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='gmTransactionLogChannel',
                query={'_id': guild.id}
            )
            player_transaction_log = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='playerTransactionLogChannel',
                query={'_id': guild.id}
            )
            shop_log = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='shopLogChannel',
                query={'_id': guild.id}
            )

            self.quest_board_info.content = (
                f'**Quest Board:** {quest_board}\n'
                f'The channel where new/active quests will be posted.'
            )
            self.player_board_info.content = (
                f'**Player Board:** {player_board}\n'
                f'An optional announcement/message board for use by players.'
            )
            self.quest_archive_info.content = (
                f'**Quest Archive:** {quest_archive}\n'
                f'An optional channel where completed quests will move to, with summary information.'
            )
            self.gm_transaction_log_info.content = (
                f'**GM Transaction Log:** {gm_transaction_log}\n'
                f'An optional channel where GM transactions (i.e. Modify Player commands) are logged.'
            )
            self.player_transaction_log_info.content = (
                f'**Player Transaction Log:** {player_transaction_log}\n'
                f'An optional channel where player transactions such as trading and consuming items are logged.'
            )
            self.shop_log_info.content = (
                f'**Shop Log:** {shop_log}\n'
                f'An optional channel where shop transactions are logged.'
            )

            self.build_view()
        except Exception as e:
            await log_exception(e)


# ------ QUESTS ------


class ConfigQuestsView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.wait_list_info = TextDisplay(
            '**Quest Wait List Size:** Disabled\n'
            'A wait list allows the specified number of players to queue for a quest that is full, '
            'in case a player drops.'
        )
        self.quest_summary_info = TextDisplay(
            '**Quest Summary:** Disabled\n'
            'This option enables GMs to provide a short summary when closing out quests.'
        )
        self.wait_list_select = selects.ConfigWaitListSelect(self)
        self.quest_summary_toggle_button = buttons.QuestSummaryToggleButton(self)

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay('**Server Configuration - Quests**'))

        container.add_item(header_section)
        container.add_item(Separator())

        container.add_item(self.wait_list_info)
        wait_list_select_row = ActionRow(self.wait_list_select)
        container.add_item(wait_list_select_row)
        container.add_item(Separator())

        quest_summary_section = Section(accessory=self.quest_summary_toggle_button)
        quest_summary_section.add_item(self.quest_summary_info)
        container.add_item(quest_summary_section)
        container.add_item(Separator())

        gm_rewards_section = Section(accessory=MenuViewButton(GMRewardsView, 'GM Rewards'))
        gm_rewards_section.add_item(TextDisplay(
            '**GM Rewards**\n'
            'Configure rewards for GMs to receive upon completing quests.'
        ))
        container.add_item(gm_rewards_section)

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            quest_summary = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='questSummary',
                query={'_id': guild.id}
            )
            wait_list = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='questWaitList',
                query={'_id': guild.id}
            )

            wait_list_display = wait_list if isinstance(wait_list, int) and wait_list > 0 else 'Disabled'
            quest_summary_display = "Enabled" if quest_summary is True else "Disabled"

            self.wait_list_info.content = (
                f'**Quest Wait List Size:** {wait_list_display}\n'
                f'A wait list allows the specified number of players to queue for a quest that is full, in case a '
                f'player drops.'
            )
            self.quest_summary_info.content = (
                f'**Quest Summary:** {quest_summary_display}\n'
                f'This option enables GMs to provide a short summary when closing out quests.'
            )

            self.build_view()
        except Exception as e:
            await log_exception(e)


class GMRewardsView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.gm_rewards_info = TextDisplay('No rewards configured.')
        self.current_rewards = None
        self.xp_enabled = True

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigQuestsView))
        header_section.add_item(TextDisplay('**Server Configuration - GM Rewards**'))

        container.add_item(header_section)
        container.add_item(Separator())

        gm_rewards_section = Section(accessory=buttons.GMRewardsButton(self))
        gm_rewards_section.add_item(TextDisplay(
            '**Add/Modify Rewards**\n'
            'Opens an input modal to add, modify, or remove GM rewards.\n\n'
            '> Rewards configured are on a per-quest basis. Every time a Game Master completes a quest, they will '
            'receive the rewards configured below on their active character.'
        ))
        container.add_item(gm_rewards_section)
        container.add_item(Separator())

        container.add_item(self.gm_rewards_info)

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            self.xp_enabled = await get_xp_config(bot, guild)
            gm_rewards_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='gmRewards',
                query={'_id': guild.id}
            )
            experience = None
            items = None
            if gm_rewards_query:
                self.current_rewards = gm_rewards_query
                experience = gm_rewards_query['experience']
                items = gm_rewards_query['items']

            xp_info = ''
            item_info = ''
            if self.xp_enabled and experience:
                xp_info = f'**Experience:** {experience}'

            if items:
                rewards_list = []
                for item, quantity in items.items():
                    rewards_list.append(f'{item.capitalize()}: {quantity}')
                rewards_string = '\n'.join(rewards_list)
                item_info = f'**Items:**\n{rewards_string}'

            if xp_info or item_info:
                self.gm_rewards_info.content = f'{xp_info}\n\n{item_info}'.strip()
            else:
                self.gm_rewards_info.content = 'No rewards configured.'

            self.build_view()
        except Exception as e:
            await log_exception(e)


# ------ PLAYERS ------


class ConfigPlayersView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.player_experience_info = TextDisplay(
            '**Player Experience:** Disabled\n'
            'Enables/Disables the use of experience points (or similar value-based character progression.'
        )

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay('**Server Configuration - Players**'))
        container.add_item(header_section)
        container.add_item(Separator())

        experience_section = Section(accessory=buttons.PlayerExperienceToggleButton(self))
        experience_section.add_item(self.player_experience_info)
        container.add_item(experience_section)
        container.add_item(Separator())

        new_character_section = Section(accessory=MenuViewButton(ConfigNewCharacterView, 'New Character Settings'))
        new_character_section.add_item(TextDisplay(
            '**New Character Settings**\n'
            'Configure settings related to new player characters and how their initial inventories are set up.'
        ))
        container.add_item(new_character_section)
        container.add_item(Separator())

        player_board_section = Section(accessory=buttons.PlayerBoardPurgeButton(self))
        player_board_section.add_item(TextDisplay(
            '**Player Board Purge**\n'
            'Purges posts from the player board (if enabled).\n\n'
        ))
        container.add_item(player_board_section)

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            # XP section
            player_experience = await get_xp_config(bot, guild)
            self.player_experience_info.content = (
                f'**Player Experience:** {"Enabled" if player_experience else "Disabled"}\n'
                f'Enables/Disables the use of experience points (or similar value-based character progression.'
            )

            self.build_view()
        except Exception as e:
            await log_exception(e)


class ConfigNewCharacterView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.inventory_type_info = TextDisplay(
            '**New Character Inventory Type:** Disabled\n'
            'Determines how newly-registered characters initialize their inventories.'
        )
        self.new_character_wealth_info = TextDisplay(
            '**New Character Wealth:** Disabled\n'
        )
        self.approval_queue_info = TextDisplay(
            '**Approval Queue:** Disabled\n'
            'If set, new characters must be approved by a GM in this Forum Channel before they are active.'
        )
        self.inventory_type_select = selects.InventoryTypeSelect(self)
        self.approval_queue_select = selects.SingleChannelConfigSelect(
            self, 'approvalQueueChannel', 'Approval Queue'
        )
        self.approval_queue_clear_button = buttons.ClearChannelButton(self, 'approvalQueueChannel')

        self.new_character_shop_button = MenuViewButton(ConfigNewCharacterShopView, 'Configure New Character Shop')
        self.new_character_wealth_button = buttons.ConfigNewCharacterWealthButton(self)
        self.static_kits_button = MenuViewButton(ConfigStaticKitsView, 'Configure Static Kits')

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigPlayersView))
        header_section.add_item(TextDisplay('**Server Configuration - New Character Settings**'))
        container.add_item(header_section)
        container.add_item(Separator())

        # Inventory type section
        container.add_item(self.inventory_type_info)
        container.add_item(ActionRow(self.inventory_type_select))
        container.add_item(Separator())

        # New Character wealth section
        new_character_wealth_row = ActionRow()
        new_character_wealth_row.add_item(self.new_character_shop_button)
        new_character_wealth_row.add_item(self.new_character_wealth_button)
        new_character_wealth_row.add_item(self.static_kits_button)
        container.add_item(new_character_wealth_row)
        container.add_item(self.new_character_wealth_info)
        container.add_item(Separator())

        # Approval queue section
        approval_section = Section(accessory=self.approval_queue_clear_button)
        approval_section.add_item(self.approval_queue_info)
        container.add_item(approval_section)
        container.add_item(ActionRow(self.approval_queue_select))
        container.add_item(Separator())

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            # Inventory section
            inventory_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='inventoryConfig',
                query={'_id': guild.id}
            )
            inventory_type = inventory_config.get('inventoryType', 'disabled') if inventory_config else 'disabled'
            new_character_wealth = inventory_config.get('newCharacterWealth', None) if inventory_config else None

            type_description = {
                'disabled': 'Players start with empty inventories.',
                'selection': 'Players choose items freely from the New Character Shop.',
                'purchase': 'Players purchase items from the New Character Shop with a given amount of currency.',
                'open': 'Players manually input their inventory items.',
                'static': 'Players are given a predefined starting inventory.'
            }

            self.inventory_type_info.content = (
                f'**New Character Inventory Type:** {inventory_type.capitalize()}\n'
                f'{type_description.get(inventory_type, "")}'
            )


            # New character Shop section
            currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='currency',
                query={'_id': guild.id}
            )

            self.new_character_shop_button.disabled = True
            self.new_character_shop_button.label = 'Configure New Character Shop'
            self.new_character_wealth_button.disabled = True
            self.new_character_wealth_button.label = 'Configure New Character Wealth'
            self.static_kits_button.disabled = True

            if inventory_type == 'selection':
                self.new_character_shop_button.disabled = False
                if currency_config:
                    self.new_character_wealth_button.disabled = False
                else:
                    self.new_character_wealth_button.label = 'Disabled (No Currency Configured)'

            if inventory_type == 'purchase':
                if not currency_config:
                    self.new_character_shop_button.label = 'Disabled (No Currency Configured)'
                    self.new_character_wealth_button.label = 'Disabled (No Currency Configured)'
                else:
                    self.new_character_wealth_button.disabled = False
                    if not new_character_wealth:
                        self.new_character_shop_button.label = 'Disabled (No Starting Wealth Configured)'
                    else:
                        self.new_character_shop_button.disabled = False

            if inventory_type == 'static':
                self.static_kits_button.disabled = False

            if new_character_wealth:
                amount = new_character_wealth.get('amount', 0)
                currency_name = new_character_wealth.get('currency', '')

                formatted_wealth = format_price_string(amount, currency_name, currency_config)

                self.new_character_wealth_info.content = (
                    f'**New Character Wealth:** {formatted_wealth}'
                )
            else:
                self.new_character_wealth_info.content = (
                    f'**New Character Wealth:** Disabled'
                )

            # Approval Queue section
            approval_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='approvalQueueChannel',
                query={'_id': guild.id}
            )
            approval_channel = approval_query['approvalQueueChannel'] if approval_query else 'Not Configured'

            self.approval_queue_info.content = (
                f'**Approval Queue:** {approval_channel}\n'
                f'If set, new characters must be approved by a GM in this Forum Channel before they are active.'
            )

            self.build_view()
        except Exception as e:
            await log_exception(e)


class ConfigNewCharacterShopView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.all_stock = []
        self.items_per_page = 6
        self.current_page = 0
        self.total_pages = 1
        self.mode_description = ''

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigNewCharacterView))
        header_section.add_item(TextDisplay('**Server Configuration - New Character Shop**'))
        container.add_item(header_section)
        container.add_item(Separator())

        container.add_item(TextDisplay(self.mode_description or 'Define the shop items.'))

        action_row = ActionRow()
        action_row.add_item(buttons.AddNewCharacterShopItemButton(self))
        action_row.add_item(buttons.NewCharacterShopJSONButton(self))
        action_row.add_item(buttons.DownloadNewCharacterShopJSONButton(self))
        container.add_item(action_row)
        container.add_item(Separator())

        start_index = self.current_page * self.items_per_page
        end_index = start_index + self.items_per_page
        current_stock = self.all_stock[start_index:end_index]

        if not current_stock:
            container.add_item(TextDisplay("No items configured."))
        else:
            for item in current_stock:
                item_name = item.get('name')
                item_description = item.get('description')
                item_price = item.get('price', 0)
                item_currency = item.get('currency', '')
                item_quantity = item.get('quantity', 1)

                display_string = f"**{item_name}** (x{item_quantity})"
                if item_price > 0:
                    display_string += f" - {item_price} {item_currency}"
                else:
                    display_string += " - Free"

                if item_description:
                    display_string += f"\n*{item_description}*"

                container.add_item(TextDisplay(display_string))

                item_actions = ActionRow()
                item_actions.add_item(buttons.EditNewCharacterShopItemButton(item, self))
                item_actions.add_item(buttons.DeleteNewCharacterShopItemButton(item, self))
                container.add_item(item_actions)

        self.add_item(container)

        # Pagination
        if self.total_pages > 1:
            nav_row = ActionRow()

            prev_button = Button(
                label='Previous',
                style=ButtonStyle.secondary,
                custom_id='ss_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_button = Button(
                label=f'Page {self.current_page + 1}/{self.total_pages}',
                style=ButtonStyle.secondary,
                disabled=True
            )
            nav_row.add_item(page_button)

            next_button = Button(
                label='Next',
                style=ButtonStyle.primary,
                custom_id='ss_next',
                disabled=(self.current_page >= self.total_pages - 1)
            )
            next_button.callback = self.next_page
            nav_row.add_item(next_button)

            self.add_item(nav_row)

    async def setup(self, bot, guild):
        try:
            inventory_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='inventoryConfig',
                query={'_id': guild.id}
            )
            inventory_type = inventory_config.get('inventoryType', 'disabled') if inventory_config else 'disabled'

            if inventory_type == 'selection':
                self.mode_description = (
                    '**Inventory Type:** Selection\n'
                    'Players choose items freely from the New Character Shop.'
                )
            elif inventory_type == 'purchase':
                self.mode_description = (
                    '**Inventory Type:** Purchase\n'
                    'Players purchase items from the New Character Shop with a given amount of currency.'
                )
            else:
                self.mode_description = (
                    f'**Inventory Type:** {titlecase(inventory_type)}\n'
                    f'New Character Shop is not in use.'
                )

            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='newCharacterShop',
                query={'_id': guild.id}
            )
            if query and 'shopStock' in query:
                self.update_stock(query['shopStock'])
            else:
                self.update_stock([])

            self.build_view()
        except Exception as e:
            await log_exception(e)

    def update_stock(self, new_stock):
        self.all_stock = new_stock
        self.total_pages = math.ceil(len(self.all_stock) / self.items_per_page)
        if self.current_page >= self.total_pages and self.current_page > 0:
            self.current_page = max(0, self.total_pages - 1)

    async def prev_page(self, interaction):
        if self.current_page > 0:
            self.current_page -= 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def next_page(self, interaction):
        if self.current_page < self.total_pages - 1:
            self.current_page += 1
            self.build_view()
            await interaction.response.edit_message(view=self)


class ConfigStaticKitsView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.kits = {}
        self.sorted_kits = []
        self.currency_config = None

        self.items_per_page = 6
        self.current_page = 0
        self.total_pages = 1

    async def setup(self, bot, guild):
        try:
            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='staticKits',
                query={'_id': guild.id}
            )
            self.kits = query.get('kits', {}) if query else {}

            self.sorted_kits = sorted(self.kits.items(), key=lambda x: x[1].get('name', '').lower())

            self.total_pages = math.ceil(len(self.sorted_kits) / self.items_per_page)
            if self.total_pages == 0:
                self.total_pages = 1

            if self.current_page >= self.total_pages:
                self.current_page = max(0, self.total_pages - 1)

            self.currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='currency',
                query={'_id': guild.id}
            )

            self.build_view()
        except Exception as e:
            await log_exception(e)

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigNewCharacterView))
        header_section.add_item(TextDisplay('**Server Configuration - Static Kits**'))
        container.add_item(header_section)
        container.add_item(Separator())

        add_section = Section(accessory=buttons.AddStaticKitButton(self))
        add_section.add_item(TextDisplay("Create a new kit definition."))
        container.add_item(add_section)
        container.add_item(Separator())

        if not self.sorted_kits:
            container.add_item(TextDisplay("No kits configured."))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = self.sorted_kits[start:end]

            for kit_id, kit_data in page_items:
                kit_name = kit_data.get('name', 'Unknown')
                description = kit_data.get('description', '')

                info_text = f"**{titlecase(kit_name)}**"
                if description:
                    info_text += f"\n*{description}*"

                items = kit_data.get('items', [])
                currency = kit_data.get('currency', {})
                contents = []

                for item in items[:3]:
                    contents.append(f"{item.get('quantity', 1)}x {titlecase(item.get('name', ''))}")
                if len(items) > 3:
                    contents.append(f"...and {len(items) - 3} more items")

                if currency:
                    contents.extend(format_consolidated_totals(currency, self.currency_config))

                if contents:
                    info_text += f"\n> {', '.join(contents)}"
                else:
                    info_text += "\n> *Empty Kit*"

                container.add_item(TextDisplay(info_text))

                actions = ActionRow()
                actions.add_item(buttons.EditStaticKitButton(kit_id, kit_data))
                actions.add_item(buttons.RemoveStaticKitButton(kit_id, kit_name))
                container.add_item(actions)

        self.add_item(container)

        # Pagination Controls
        if self.total_pages > 1:
            nav_row = ActionRow()

            prev_button = Button(
                label='Previous',
                style=ButtonStyle.secondary,
                custom_id='kit_conf_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_display = Button(
                label=f'Page {self.current_page + 1}/{self.total_pages}',
                style=ButtonStyle.secondary,
                custom_id='kit_conf_page_disp'
            )
            page_display.callback = self.show_page_jump_modal
            nav_row.add_item(page_display)

            next_button = Button(
                label='Next',
                style=ButtonStyle.secondary,
                custom_id='kit_conf_next',
                disabled=(self.current_page >= self.total_pages - 1)
            )
            next_button.callback = self.next_page
            nav_row.add_item(next_button)

            self.add_item(nav_row)

    async def prev_page(self, interaction):
        if self.current_page > 0:
            self.current_page -= 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def next_page(self, interaction):
        if self.current_page < self.total_pages - 1:
            self.current_page += 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def show_page_jump_modal(self, interaction):
        try:
            await interaction.response.send_modal(common_modals.PageJumpModal(self))
        except Exception as e:
            await log_exception(e, interaction)


class EditStaticKitView(LayoutView):
    def __init__(self, kit_id, kit_data, currency_config):
        super().__init__(timeout=None)
        self.kit_id = kit_id
        self.kit_data = kit_data
        self.currency_config = currency_config
        self.items_per_page = 6
        self.current_page = 0
        self.total_pages = 0

        self.items = self.kit_data.get('items', [])

        self.build_view()

    def build_view(self):
        self.clear_items()

        self.items = self.kit_data.get('items', [])
        currencies = self.kit_data.get('currency', {})

        combined_list = []

        for currency_name, amount in currencies.items():
            combined_list.append({'type': 'currency', 'name': currency_name, 'amount': amount})

        for index, item in enumerate(self.items):
            combined_list.append({'type': 'item', 'index': index, 'data': item})

        self.total_pages = math.ceil(len(combined_list) / self.items_per_page)
        if self.total_pages == 0:
            self.total_pages = 1

        if self.current_page >= self.total_pages and self.current_page > 0:
            self.current_page = max(0, self.total_pages - 1)

        container = Container()

        header_section = Section(accessory=BackButton(ConfigStaticKitsView))
        header_section.add_item(TextDisplay(f'**Editing Kit: {titlecase(self.kit_data["name"])}**'))
        container.add_item(header_section)

        if description := self.kit_data.get('description'):
            container.add_item(TextDisplay(f"*{description}*"))
        container.add_item(Separator())

        kit_actions = ActionRow()
        kit_actions.add_item(buttons.AddKitCurrencyButton(self))
        kit_actions.add_item(buttons.AddKitItemButton(self))
        container.add_item(kit_actions)
        container.add_item(Separator())

        if not combined_list:
            container.add_item(TextDisplay("This kit is empty. Use the buttons above to add currency or items."))
        else:
            start_index = self.current_page * self.items_per_page
            end_index = start_index + self.items_per_page
            page_entries = combined_list[start_index:end_index]

            entry_type = ''
            for entry in page_entries:
                if entry['type'] == 'currency':
                    entry_type = 'currency'
                    currency_name = entry['name']
                    amount = entry['amount']

                    currency_section = Section(accessory=buttons.DeleteKitCurrencyButton(self, currency_name))
                    display = format_price_string(amount, currency_name, self.currency_config)
                    currency_section.add_item(TextDisplay(f'**Currency:** {display}'))
                    container.add_item(currency_section)
                elif entry['type'] == 'item':
                    if entry_type == 'currency':
                        container.add_item(Separator())
                    entry_type = 'item'
                    item_data = entry['data']
                    index = entry['index']

                    item_actions = ActionRow()
                    item_actions.add_item(buttons.EditKitItemButton(self, item_data, index))
                    item_actions.add_item(buttons.DeleteKitItemButton(self, index))

                    display = f'**Item:** {titlecase(item_data["name"])}'
                    if item_data['quantity'] > 1:
                        display += f' (x{item_data["quantity"]})'
                    if item_data.get('description'):
                        display += f'\n*{item_data["description"]}*'

                    container.add_item(TextDisplay(display))
                    container.add_item(item_actions)

            # Pagination Controls
            if self.total_pages > 1:
                nav_row = ActionRow()
                prev_button = Button(
                    label='Previous',
                    style=ButtonStyle.secondary,
                    custom_id='kit_prev',
                    disabled=(self.current_page == 0)
                )
                prev_button.callback = self.prev_page
                nav_row.add_item(prev_button)

                page_button = Button(
                    label=f'Page {self.current_page + 1}/{self.total_pages}',
                    style=ButtonStyle.secondary
                )
                page_button.callback = self.show_page_jump_modal
                nav_row.add_item(page_button)

                next_button = Button(
                    label='Next',
                    style=ButtonStyle.primary,
                    custom_id='kit_next',
                    disabled=(self.current_page >= self.total_pages - 1)
                )
                next_button.callback = self.next_page
                nav_row.add_item(next_button)
                container.add_item(nav_row)

        self.add_item(container)

    async def prev_page(self, interaction):
        if self.current_page > 0:
            self.current_page -= 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def next_page(self, interaction):
        if self.current_page < self.total_pages - 1:
            self.current_page += 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def show_page_jump_modal(self, interaction):
        try:
            await interaction.response.send_modal(common_modals.PageJumpModal(self))
        except Exception as e:
            logging.error(f'Failed to send PageJumpModal: {e}')
            await interaction.response.send_message('Could not open page selector', ephemeral=True)


# ------ CURRENCY ------


class ConfigCurrencyView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.currencies = []

        self.items_per_page = 9
        self.current_page = 0
        self.total_pages = 1

    async def setup(self, bot, guild):
        try:
            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='currency',
                query={'_id': guild.id}
            )

            self.currencies = query.get('currencies', []) if query else []
            self.currencies.sort(key=lambda x: x.get('name', '').lower())

            self.total_pages = math.ceil(len(self.currencies) / self.items_per_page)
            if self.total_pages == 0:
                self.total_pages = 1
            if self.current_page >= self.total_pages:
                self.current_page = max(0, self.total_pages - 1)

            self.build_view()
        except Exception as e:
            await log_exception(e)

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay('**Server Configuration - Currency**'))
        container.add_item(header_section)
        container.add_item(Separator())

        add_currency_section = Section(accessory=buttons.AddCurrencyButton(self))
        add_currency_section.add_item(TextDisplay('Create a new currency.'))
        container.add_item(add_currency_section)
        container.add_item(Separator())

        if not self.currencies:
            container.add_item(TextDisplay('No currencies configured.'))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = self.currencies[start:end]

            for currency in page_items:
                currency_name = currency.get('name', 'Unknown')
                is_double = currency.get('isDouble', False)
                denominations = currency.get('denominations', [])

                currency_type = 'Double' if is_double else 'Integer'
                denomination_count = len(denominations)

                info = (f'**{titlecase(currency_name)}**\n'
                        f'Display Type: {currency_type} | Denominations: {denomination_count}')

                section = Section(accessory=buttons.ManageCurrencyButton(currency_name))
                section.add_item(TextDisplay(info))
                container.add_item(section)

        self.add_item(container)

        # Pagination
        if self.total_pages > 1:
            nav_row = ActionRow()
            prev_button = Button(
                label='Previous',
                style=discord.ButtonStyle.secondary,
                custom_id='curr_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_display = Button(
                label=f'Page {self.current_page + 1}/{self.total_pages}',
                style=discord.ButtonStyle.secondary,
                custom_id='curr_page_disp'
            )
            page_display.callback = self.show_page_jump_modal
            nav_row.add_item(page_display)

            next_button = Button(
                label='Next',
                style=discord.ButtonStyle.secondary,
                custom_id='curr_next',
                disabled=(self.current_page >= self.total_pages - 1)
            )
            next_button.callback = self.next_page
            nav_row.add_item(next_button)

            self.add_item(nav_row)

    async def prev_page(self, interaction):
        if self.current_page > 0:
            self.current_page -= 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def next_page(self, interaction):
        if self.current_page < self.total_pages - 1:
            self.current_page += 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def show_page_jump_modal(self, interaction):
        try:
            await interaction.response.send_modal(common_modals.PageJumpModal(self))
        except Exception as e:
            await log_exception(e, interaction)


class ConfigEditCurrencyView(LayoutView):
    def __init__(self, currency_name):
        super().__init__(timeout=None)
        self.currency_name = currency_name
        self.currency_data = {}
        self.denominations = []

        self.items_per_page = 8
        self.current_page = 0
        self.total_pages = 1

    async def setup(self, bot, guild):
        try:
            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='currency',
                query={'_id': guild.id}
            )

            if query:
                self.currency_data = next((c for c in query.get('currencies', [])
                                           if c['name'] == self.currency_name), {})

            self.denominations = self.currency_data.get('denominations', [])
            # Sort denominations by value descending
            self.denominations.sort(key=lambda x: x.get('value', 0), reverse=True)

            self.total_pages = math.ceil(len(self.denominations) / self.items_per_page)
            if self.total_pages == 0:
                self.total_pages = 1
            if self.current_page >= self.total_pages:
                self.current_page = max(0, self.total_pages - 1)

            self.build_view()
        except Exception as e:
            await log_exception(e)

    def build_view(self):
        self.clear_items()
        container = Container()
        display_type = 'Double' if self.currency_data.get('isDouble') else 'Integer'

        header_section = Section(accessory=BackButton(ConfigCurrencyView))
        header_section.add_item(TextDisplay(f'**Manage Currency: {titlecase(self.currency_name)}**'))
        container.add_item(header_section)
        container.add_item(Separator())

        info_text = (
            '__**Currency and Denominations**__\n'
            '- The given name of your currency is considered the base currency and has a value of 1.'
            '```Example: "gold" is configured as a currency.```\n'
            '- Adding a denomination requires specifying a name and a value relative to the base currency.'
            '```Example: Gold is given two denominations: silver (value of 0.1), and copper (value of 0.01).```\n'
            '- Any transactions involving a base currency or its denominations will automatically convert them.'
            '```Example: A player has 10 gold and spends 3 copper. Their new balance will automatically display '
            '9 gold, 9 silver, and 7 copper.```\n'
            '- Currencies displayed as an integer will show each denomination, while currencies displayed as a double '
            'will show only as the base currency.'
            '```Example: The player above with double display enabled will show as 9.97 gold.```\n'
        )
        container.add_item(TextDisplay(info_text))
        container.add_item(Separator())

        actions = ActionRow()
        toggle_double_button = buttons.ToggleDoubleButton(self)
        toggle_double_button.label = f'Toggle Display (Current: {display_type})'
        actions.add_item(toggle_double_button)
        actions.add_item(buttons.AddDenominationButton(self))
        actions.add_item(buttons.RemoveCurrencyButton(self, self.currency_name))
        container.add_item(actions)
        container.add_item(Separator())

        if not self.denominations:
            container.add_item(TextDisplay("No denominations configured."))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = self.denominations[start:end]

            for denomination in page_items:
                denomination_name = denomination.get('name', 'Unknown')
                denomination_value = denomination.get('value', 0)

                info = f"**{titlecase(denomination_name)}** (Value: {denomination_value})"

                section = Section(accessory=buttons.RemoveDenominationButton(self, denomination_name))
                section.add_item(TextDisplay(info))
                container.add_item(section)

        self.add_item(container)

        if self.total_pages > 1:
            nav_row = ActionRow()
            prev_button = Button(
                label='Previous',
                style=discord.ButtonStyle.secondary,
                custom_id='denom_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_display = Button(
                label=f'Page {self.current_page + 1}/{self.total_pages}',
                style=discord.ButtonStyle.secondary,
                custom_id='denom_page_disp'
            )
            page_display.callback = self.show_page_jump_modal
            nav_row.add_item(page_display)

            next_button = Button(
                label='Next',
                style=discord.ButtonStyle.secondary,
                custom_id='denom_next',
                disabled=(self.current_page >= self.total_pages - 1)
            )
            next_button.callback = self.next_page
            nav_row.add_item(next_button)

            self.add_item(nav_row)

    async def prev_page(self, interaction):
        if self.current_page > 0:
            self.current_page -= 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def next_page(self, interaction):
        if self.current_page < self.total_pages - 1:
            self.current_page += 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def show_page_jump_modal(self, interaction):
        try:
            await interaction.response.send_modal(common_modals.PageJumpModal(self))
        except Exception as e:
            await log_exception(e, interaction)


# ------ SHOPS ------


class ConfigShopsView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.shops = []

        self.items_per_page = 8
        self.current_page = 0
        self.total_pages = 1

    async def setup(self, bot, guild):
        try:
            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='shops',
                query={'_id': guild.id}
            )

            unsorted_shops = []
            if query and query.get('shopChannels'):
                for channel_id, shop_data in query['shopChannels'].items():
                    unsorted_shops.append({
                        'id': channel_id,
                        'data': shop_data
                    })

            self.shops = sorted(unsorted_shops, key=lambda x: x['data'].get('shopName', '').lower())

            self.total_pages = math.ceil(len(self.shops) / self.items_per_page)
            if self.total_pages == 0:
                self.total_pages = 1
            if self.current_page >= self.total_pages:
                self.current_page = max(0, self.total_pages - 1)

            self.build_view()

        except Exception as e:
            await log_exception(e)

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay('**Server Configuration - Shops**'))
        container.add_item(header_section)
        container.add_item(Separator())

        add_shop_wizard_section = Section(accessory=buttons.AddShopWizardButton(self))
        add_shop_wizard_section.add_item(TextDisplay(
            '**Add Shop (Wizard)**\n'
            'Create a new, empty shop from a form.'
        ))
        container.add_item(add_shop_wizard_section)

        add_shop_json_section = Section(accessory=AddShopJSONButton(self))
        add_shop_json_section.add_item(TextDisplay(
            '**Add Shop (JSON)**\n'
            'Create a new shop by providing a full JSON definition. (Advanced)'
        ))
        container.add_item(add_shop_json_section)
        container.add_item(Separator())

        if not self.shops:
            container.add_item(TextDisplay("No shops configured."))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = self.shops[start:end]

            for shop in page_items:
                shop_name = shop['data'].get('shopName', 'Unknown Shop')
                channel_id = shop['id']

                info = f"**{shop_name}**\nChannel: <#{channel_id}>"

                section = Section(accessory=buttons.ManageShopNavButton(channel_id, shop['data'], 'Manage'))
                section.add_item(TextDisplay(info))
                container.add_item(section)

        self.add_item(container)

        if self.total_pages > 1:
            nav_row = ActionRow()
            prev_button = Button(
                label='Previous',
                style=ButtonStyle.secondary,
                custom_id='conf_shop_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_display = Button(
                label=f'Page {self.current_page + 1}/{self.total_pages}',
                style=discord.ButtonStyle.secondary,
                custom_id='conf_shop_page'
            )
            page_display.callback = self.show_page_jump_modal
            nav_row.add_item(page_display)

            next_button = Button(
                label='Next',
                style=ButtonStyle.secondary,
                custom_id='conf_shop_next',
                disabled=(self.current_page >= self.total_pages - 1)
            )
            next_button.callback = self.next_page
            nav_row.add_item(next_button)

            self.add_item(nav_row)

    async def prev_page(self, interaction):
        if self.current_page > 0:
            self.current_page -= 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def next_page(self, interaction):
        if self.current_page < self.total_pages - 1:
            self.current_page += 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def show_page_jump_modal(self, interaction):
        try:
            await interaction.response.send_modal(common_modals.PageJumpModal(self))
        except Exception as e:
            await log_exception(e, interaction)


class ManageShopView(LayoutView):
    def __init__(self, channel_id, shop_data):
        super().__init__(timeout=None)
        self.selected_channel_id = channel_id
        self.shop_data = shop_data

        self.build_view()

    def build_view(self):
        self.clear_items()
        container = Container()

        shop_name = self.shop_data.get('shopName', 'Unknown')

        header_section = Section(accessory=BackButton(ConfigShopsView))
        header_section.add_item(TextDisplay(f'**Manage Shop: {shop_name}**'))
        container.add_item(header_section)
        container.add_item(Separator())

        shop_keeper = self.shop_data.get('shopKeeper', 'None')
        shop_description = self.shop_data.get('shopDescription', 'None')
        info_text = f"**Shopkeeper:** {shop_keeper}\n**Description:** {shop_description}"
        container.add_item(TextDisplay(info_text))
        container.add_item(Separator())

        wizard_section = Section(accessory=buttons.EditShopButton(self))
        wizard_section.add_item(TextDisplay("Edit Shop details and items via Wizard."))
        container.add_item(wizard_section)

        json_section = Section(accessory=buttons.UpdateShopJSONButton(self))
        json_section.add_item(TextDisplay("Upload a new JSON definition for this shop."))
        container.add_item(json_section)

        download_section = Section(accessory=buttons.DownloadShopJSONButton(self))
        download_section.add_item(TextDisplay("Download the current JSON definition."))
        container.add_item(download_section)
        container.add_item(Separator())

        remove_section = Section(accessory=buttons.RemoveShopButton(self))
        remove_section.add_item(TextDisplay("Permanently remove this shop."))
        container.add_item(remove_section)

        self.add_item(container)

    def update_details(self, new_data):
        self.shop_data = new_data


class EditShopView(LayoutView):
    def __init__(self, channel_id: str, shop_data: dict):
        super().__init__(timeout=None)
        self.channel_id = channel_id
        self.shop_data = shop_data
        self.all_stock = self.shop_data.get('shopStock', [])

        self.items_per_page = 6
        self.current_page = 0
        self.total_pages = math.ceil(len(self.all_stock) / self.items_per_page)
        self.done_editing_button = buttons.ManageShopNavButton(self.channel_id, self.shop_data,
                                                               'Done Editing', ButtonStyle.secondary)

    def build_view(self):
        self.clear_items()
        container = Container()
        header_items = [TextDisplay(f'**Editing Shop: {self.shop_data.get("shopName")}**')]

        if shop_keeper := self.shop_data.get('shopKeeper'):
            header_items.append(TextDisplay(f'Shopkeeper: **{shop_keeper}**'))
        if shop_description := self.shop_data.get('shopDescription'):
            header_items.append(TextDisplay(f'*{shop_description}*'))

        if shop_image := self.shop_data.get('shopImage'):
            shop_image = Thumbnail(media=f'{shop_image}')
            shop_header = Section(accessory=shop_image)

            for item in header_items:
                shop_header.add_item(item)

            container.add_item(shop_header)
        else:
            for item in header_items:
                container.add_item(item)
        header_buttons = ActionRow()
        header_buttons.add_item(buttons.AddItemButton(self))
        header_buttons.add_item(buttons.EditShopDetailsButton(self))
        container.add_item(header_buttons)
        container.add_item(Separator())

        start_index = self.current_page * self.items_per_page
        end_index = start_index + self.items_per_page
        current_stock = self.all_stock[start_index:end_index]

        for item in current_stock:
            item_name = item.get('name')
            item_desc = item.get('description', None)
            item_price = item.get('price')
            item_currency = item.get('currency')
            item_quantity = item.get('quantity', 1)

            item_text = f'{f'{item_name} x{item_quantity}' if item_quantity > 1 else item_name}'

            if item_desc:
                item_display = TextDisplay(
                    f'**{item_text}**: {item_price} {item_currency}\n'
                    f'*{item_desc}*'
                )
            else:
                item_display = TextDisplay(
                    f'**{item_text}**: {item_price} {item_currency}'
                )

            container.add_item(item_display)

            item_buttons = ActionRow()
            item_buttons.add_item(buttons.EditShopItemButton(item, self))
            item_buttons.add_item(buttons.DeleteShopItemButton(item, self))

            container.add_item(item_buttons)

        self.add_item(container)

        if self.total_pages > 1:
            pagination_row = ActionRow()

            prev_button = Button(
                label='Previous',
                style=ButtonStyle.secondary,
                custom_id='shop_edit_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page

            page_display = Button(
                label=f'Page {self.current_page + 1} of {self.total_pages}',
                style=ButtonStyle.secondary,
                custom_id='shop_edit_page'
            )
            page_display.callback = self.show_page_jump_modal

            next_button = Button(
                label='Next',
                style=ButtonStyle.primary,
                custom_id='shop_edit_next',
                disabled=(self.current_page >= self.total_pages - 1)
            )
            next_button.callback = self.next_page

            pagination_row.add_item(prev_button)
            pagination_row.add_item(page_display)
            pagination_row.add_item(next_button)
            pagination_row.add_item(self.done_editing_button)

            self.add_item(pagination_row)
        else:
            button_row = ActionRow()
            button_row.add_item(self.done_editing_button)
            self.add_item(button_row)

    async def prev_page(self, interaction: discord.Interaction):
        if self.current_page > 0:
            self.current_page -= 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def next_page(self, interaction: discord.Interaction):
        if self.current_page < self.total_pages - 1:
            self.current_page += 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def show_page_jump_modal(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(common_modals.PageJumpModal(self))
        except Exception as e:
            logging.error(f'Failed to send PageJumpModal: {e}')
            await interaction.response.send_message('Could not open page selector', ephemeral=True)

    def update_stock(self, new_stock: list):
        self.all_stock = new_stock
        self.shop_data['shopStock'] = new_stock

        self.total_pages = math.ceil(len(self.all_stock) / self.items_per_page)
        if self.current_page >= self.total_pages:
            self.current_page = max(0, self.total_pages - 1)

    def update_details(self, new_shop_data: dict):
        new_shop_data['shopStock'] = self.all_stock
        self.shop_data = new_shop_data
