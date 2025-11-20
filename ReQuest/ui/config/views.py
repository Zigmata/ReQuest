import logging
import math
from collections import namedtuple
from typing import List

import discord
from discord import ButtonStyle
from discord.ui import LayoutView, Container, Section, Separator, ActionRow, Button, TextDisplay, Thumbnail

from ReQuest.ui.common import modals as common_modals, views as common_views
from ReQuest.ui.common.buttons import MenuViewButton, BackButton
from ReQuest.ui.config import buttons, selects, enums
from ReQuest.utilities.supportFunctions import log_exception, query_config, setup_view, strip_id, smart_title_case

logging.basicConfig(level=logging.INFO)
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
                report_lines.append(f'  - {smart_title_case(item_name)}: {quantity}')

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
            guild = interaction.guild
            gdb = interaction.client.gdb

            # Bot permissions
            bot_perm_text, bot_perm_warnings = self.validate_bot_permission(guild)

            # Role configs
            announcement_role_query = await gdb['announceRole'].find_one({'_id': guild.id})
            gm_roles_query = await gdb['gmRoles'].find_one({'_id': guild.id})

            # Channel configs
            channels = []
            quest_channel_query = await gdb['questChannel'].find_one({'_id': guild.id})
            channels.append(
                {
                    'name': 'Quest Board',
                    'mention': quest_channel_query['questChannel'] if quest_channel_query else None,
                    'required': True}
            )
            player_channel_query = await gdb['playerBoardChannel'].find_one({'_id': guild.id})
            channels.append(
                {
                    'name': 'Player Board',
                    'mention': player_channel_query['playerBoardChannel'] if player_channel_query else None,
                    'required': False}
            )

            archive_channel_query = await gdb['archiveChannel'].find_one({'_id': guild.id})
            channels.append(
                {
                    'name': 'Quest Archive',
                    'mention': archive_channel_query['archiveChannel'] if archive_channel_query else None,
                    'required': False
                }
            )

            gm_log_query = await gdb['gmTransactionLogChannel'].find_one({'_id': guild.id})
            channels.append(
                {
                    'name': 'GM Transaction Log',
                    'mention': gm_log_query['gmTransactionLogChannel'] if gm_log_query else None,
                    'required': False
                }
            )

            player_trade_log_query = await gdb['playerTradingLogChannel'].find_one({'_id': guild.id})
            channels.append(
                {
                    'name': 'Player Trading Log',
                    'mention': player_trade_log_query['playerTradingLogChannel'] if player_trade_log_query else None,
                    'required': False
                }
            )

            shop_log_query = await gdb['shopLogChannel'].find_one({'_id': guild.id})
            channels.append(
                {
                    'name': 'Shop Log',
                    'mention': shop_log_query['shopLogChannel'] if shop_log_query else None,
                    'required': False
                }
            )

            # Dashboard configs
            wait_list_query = await gdb['questWaitList'].find_one({'_id': guild.id})
            quest_summary_query = await gdb['questSummary'].find_one({'_id': guild.id})
            gm_rewards_query = await gdb['gmRewards'].find_one({'_id': guild.id})
            player_xp_query = await gdb['playerExperience'].find_one({'_id': guild.id})
            currency_config_query = await gdb['currency'].find_one({'_id': guild.id})

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
                    'content': bot_perm_text,
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

        self.build_view()

    def build_view(self):
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

    @staticmethod
    async def query_role(role_type, bot, guild):
        try:
            collection = bot.gdb[role_type]

            query = await collection.find_one({'_id': guild.id})
            if not query:
                return None
            else:
                return query[role_type]
        except Exception as e:
            await log_exception(e)

    async def setup(self, bot, guild):
        try:
            announcement_role = await self.query_role('announceRole', bot, guild)
            gm_roles = await self.query_role('gmRoles', bot, guild)

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

        except Exception as e:
            await log_exception(e)


class ConfigGMRoleRemoveView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.gm_role_remove_select = selects.GMRoleRemoveSelect(self)

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(ConfigRolesView))
        header_section.add_item(TextDisplay('**Server Configuration - Remove GM Role(s)**'))

        container.add_item(header_section)
        container.add_item(Separator())

        container.add_item(TextDisplay('Choose roles from the dropdown below to remove from GM status.'))
        gm_role_remove_select_row = ActionRow(self.gm_role_remove_select)
        container.add_item(gm_role_remove_select_row)

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            # Clear any embed fields or select options
            self.gm_role_remove_select.options.clear()

            # Query the db for configured GM roles
            collection = bot.gdb['gmRoles']
            query = await collection.find_one({'_id': guild.id})
            options = []
            role_mentions = []

            # If roles are configured, populate the select options and build a string to display in the embed
            if query and query['gmRoles']:
                roles = query['gmRoles']
                for role in roles:
                    name = role['name']
                    role_mentions.append(role['mention'])
                    options.append(discord.SelectOption(label=name, value=name))
                self.gm_role_remove_select.disabled = False
            else:
                options.append(discord.SelectOption(label='None', value='None'))
                self.gm_role_remove_select.disabled = True
            self.gm_role_remove_select.options = options
        except Exception as e:
            await log_exception(e)


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
            'An optional channel where GM transactions (I.E. Modify Player commands) are logged.'
        )
        self.player_trading_log_info = TextDisplay(
            '**Player Trading Log:** Not Configured\n'
            'An optional channel where player-to-player trade transactions are logged.'
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
        self.player_trading_log_channel_select = selects.SingleChannelConfigSelect(
            calling_view=self,
            config_type='playerTradingLogChannel',
            config_name='Player Trading Log'
        )
        self.shop_log_channel_select = selects.SingleChannelConfigSelect(
            calling_view=self,
            config_type='shopLogChannel',
            config_name='Shop Log'
        )

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay('**Server Configuration - Channels**'))

        container.add_item(header_section)
        container.add_item(Separator())

        quest_board_section = Section(accessory=buttons.ClearChannelButton(self, enums.ChannelType.QUEST_BOARD))
        quest_board_section.add_item(self.quest_board_info)
        container.add_item(quest_board_section)
        quest_board_select_row = ActionRow(self.quest_channel_select)
        container.add_item(quest_board_select_row)
        container.add_item(Separator())

        player_board_section = Section(accessory=buttons.ClearChannelButton(self, enums.ChannelType.PLAYER_BOARD))
        player_board_section.add_item(self.player_board_info)
        container.add_item(player_board_section)
        player_board_select_row = ActionRow(self.player_board_channel_select)
        container.add_item(player_board_select_row)
        container.add_item(Separator())

        quest_archive_section = Section(accessory=buttons.ClearChannelButton(self, enums.ChannelType.QUEST_ARCHIVE))
        quest_archive_section.add_item(self.quest_archive_info)
        container.add_item(quest_archive_section)
        quest_archive_select_row = ActionRow(self.archive_channel_select)
        container.add_item(quest_archive_select_row)
        container.add_item(Separator())

        gm_transaction_log_section = Section(accessory=buttons.ClearChannelButton(self,
                                                                                  enums.ChannelType.GM_TRANSACTION_LOG))
        gm_transaction_log_section.add_item(self.gm_transaction_log_info)
        container.add_item(gm_transaction_log_section)
        gm_transaction_log_select_row = ActionRow(self.gm_transaction_log_channel_select)
        container.add_item(gm_transaction_log_select_row)
        container.add_item(Separator())

        player_trading_log_section = Section(accessory=buttons.ClearChannelButton(self,
                                                                                  enums.ChannelType.PLAYER_TRADING_LOG))
        player_trading_log_section.add_item(self.player_trading_log_info)
        container.add_item(player_trading_log_section)
        player_trading_log_select_row = ActionRow(self.player_trading_log_channel_select)
        container.add_item(player_trading_log_select_row)
        container.add_item(Separator())

        shop_log_section = Section(accessory=buttons.ClearChannelButton(self, enums.ChannelType.SHOP_LOG))
        shop_log_section.add_item(self.shop_log_info)
        container.add_item(shop_log_section)
        shop_log_select_row = ActionRow(self.shop_log_channel_select)
        container.add_item(shop_log_select_row)

        self.add_item(container)

    @staticmethod
    async def query_channel(channel_type, database, guild_id):
        try:
            collection = database[channel_type]

            query = await collection.find_one({'_id': guild_id})
            if not query:
                return 'Not Configured'
            else:
                return query[channel_type]
        except Exception as e:
            await log_exception(e)

    async def setup(self, bot, guild):
        try:
            database = bot.gdb
            guild_id = guild.id
            player_board = await self.query_channel('playerBoardChannel', database, guild_id)
            quest_board = await self.query_channel('questChannel', database, guild_id)
            quest_archive = await self.query_channel('archiveChannel', database, guild_id)
            gm_transaction_log = await self.query_channel('gmTransactionLogChannel', database, guild_id)
            player_trading_log = await self.query_channel('playerTradingLogChannel', database, guild_id)
            shop_log = await self.query_channel('shopLogChannel', database, guild_id)

            self.quest_board_info.content = (f'**Quest Board:** {quest_board}\n'
                                             f'The channel where new/active quests will be posted.')
            self.player_board_info.content = (f'**Player Board:** {player_board}\n'
                                              f'An optional announcement/message board for use by players.')
            self.quest_archive_info.content = (f'**Quest Archive:** {quest_archive}\n'
                                               f'An optional channel where completed quests will move to, with summary '
                                               f'information.')
            self.gm_transaction_log_info.content = (f'**GM Transaction Log:** {gm_transaction_log}\n'
                                                    f'An optional channel where GM transactions (I.E. Modify Player '
                                                    f'commands) are logged.')
            self.player_trading_log_info.content = (f'**Player Trading Log:** {player_trading_log}\n'
                                                    f'An optional channel where player-to-player trade transactions '
                                                    f'are logged.')
            self.shop_log_info.content = (f'**Shop Log:** {shop_log}\n'
                                          f'An optional channel where shop transactions are logged.')

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

        self.build_view()

    def build_view(self):
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
            quest_summary = await query_config('questSummary', bot, guild)
            wait_list = await query_config('questWaitList', bot, guild)

            self.wait_list_info.content = (
                f'**Quest Wait List Size:** {wait_list if wait_list > 0 else "Disabled"}\n'
                f'A wait list allows the specified number of players to queue for a quest that is full, in case a '
                f'player drops.'
            )
            self.quest_summary_info.content = (
                f'**Quest Summary:** {"Enabled" if quest_summary else "Disabled"}\n'
                f'This option enables GMs to provide a short summary when closing out quests.'
            )
        except Exception as e:
            await log_exception(e)


class GMRewardsView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.gm_rewards_info = TextDisplay(
            'No rewards configured.'
        )
        self.current_rewards = None

        self.build_view()

    def build_view(self):
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
            gm_rewards_collection = bot.gdb['gmRewards']
            gm_rewards_query = await gm_rewards_collection.find_one({'_id': guild.id})
            experience = None
            items = None
            if gm_rewards_query:
                self.current_rewards = gm_rewards_query
                experience = gm_rewards_query['experience']
                items = gm_rewards_query['items']

            xp_info = ''
            item_info = ''
            if experience:
                xp_info = f'**Experience:** {experience}'

            if items:
                rewards_list = []
                for item, quantity in items.items():
                    rewards_list.append(f'{item.capitalize()}: {quantity}')
                rewards_string = '\n'.join(rewards_list)
                item_info = f'**Items:**\n{rewards_string}'

            if xp_info or item_info:
                self.gm_rewards_info.content = f'{xp_info}\n\n{item_info}'
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
        self.player_experience = True

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay('**Server Configuration - Players**'))

        container.add_item(header_section)
        container.add_item(Separator())

        experience_section = Section(accessory=buttons.PlayerExperienceToggleButton(self))
        experience_section.add_item(self.player_experience_info)
        container.add_item(experience_section)
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
            self.player_experience = await query_config('playerExperience', bot, guild)
            self.player_experience_info.content = (
                f'**Player Experience:** {"Enabled" if self.player_experience else "Disabled"}\n'
                f'Enables/Disables the use of experience points (or similar value-based character progression.'
            )
        except Exception as e:
            await log_exception(e)


# ------ CURRENCY ------


class ConfigCurrencyView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)

        self.selected_currency_name = None
        self.edit_currency_info = TextDisplay(
            '**Edit Currency**\n'
            'Manage the selected currency\'s denominations and display options.'
        )
        self.remove_currency_info = TextDisplay(
            '**Remove Currency**\n'
            'Remove the selected currency from the server.'
        )
        self.edit_currency_button = buttons.EditCurrencyButton(ConfigEditCurrencyView, self)
        self.edit_currency_select = selects.EditCurrencySelect(self)
        self.remove_currency_button = buttons.RemoveCurrencyButton(self)

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay('**Server Configuration - Currency**'))
        container.add_item(header_section)
        container.add_item(Separator())

        add_currency_section = Section(accessory=buttons.AddCurrencyButton(self))
        add_currency_section.add_item(TextDisplay(
            'Create a new currency.'
        ))
        container.add_item(add_currency_section)
        container.add_item(Separator())

        currency_select_row = ActionRow(self.edit_currency_select)
        container.add_item(currency_select_row)

        edit_currency_section = Section(accessory=self.edit_currency_button)
        edit_currency_section.add_item(self.edit_currency_info)
        container.add_item(edit_currency_section)
        container.add_item(Separator())

        remove_currency_section = Section(accessory=self.remove_currency_button)
        remove_currency_section.add_item(self.remove_currency_info)
        container.add_item(remove_currency_section)
        container.add_item(Separator())

        self.add_item(container)

    async def setup(self, bot, guild):
        """
        Populate the currency select if any currencies are configured
        """
        try:
            collection = bot.gdb['currency']
            query = await collection.find_one({'_id': guild.id})

            # Disable everything by default
            self.edit_currency_button.disabled = True
            self.remove_currency_button.disabled = True
            self.edit_currency_select.disabled = True
            self.edit_currency_select.options.clear()
            self.edit_currency_select.options = [discord.SelectOption(label='No currencies configured', value='None')]

            self.edit_currency_select.placeholder = 'No currencies configured.'

            # Populate the select with options if currencies exist
            if query and len(query['currencies']) > 0:
                self.edit_currency_select.disabled = False
                self.edit_currency_select.placeholder = 'Select a currency to edit.'

                options = []
                for currency in query['currencies']:
                    options.append(
                        discord.SelectOption(label=currency['name'], value=currency['name'])
                    )
                self.edit_currency_select.options = options

            # If a currency is selected, enable the edit and remove buttons and update their sections
            if self.selected_currency_name:
                self.edit_currency_button.disabled = False
                self.edit_currency_button.label = f'Edit {self.selected_currency_name}'
                self.edit_currency_info.content = (
                    f'**Edit Currency:** {self.selected_currency_name}\n'
                    f'Manage denominations and display options for {self.selected_currency_name}.'
                )

                self.remove_currency_button.disabled = False
                self.remove_currency_button.label = f'Remove {self.selected_currency_name}'
                self.remove_currency_info.content = (
                    f'**Remove Currency:** {self.selected_currency_name}\n'
                    f'Remove {self.selected_currency_name} from the server.'
                )
        except Exception as e:
            await log_exception(e)

    async def remove_currency_confirm_callback(self, interaction):
        try:
            currency_name = self.selected_currency_name
            collection = interaction.client.gdb['currency']
            await collection.update_one({'_id': interaction.guild_id, 'currencies.name': currency_name},
                                        {'$pull': {'currencies': {'name': currency_name}}}, upsert=True)
            await setup_view(self, interaction)
            await interaction.response.edit_message(view=self)
        except Exception as e:
            await log_exception(e, interaction)


class ConfigEditCurrencyView(LayoutView):
    def __init__(self, calling_view):
        super().__init__(timeout=None)
        self.calling_view = calling_view
        self.selected_currency_name = calling_view.selected_currency_name
        self.selected_denomination_name = None

        self.denomination_select = selects.DenominationSelect(self)
        self.toggle_double_button = buttons.ToggleDoubleButton(self)
        self.add_denomination_button = buttons.AddDenominationButton(self)
        self.remove_denomination_button = buttons.RemoveDenominationButton(self)

        self.double_display_info = TextDisplay(
            '**Display Type:** Integer\n'
            'Toggles between integer (e.g. 10) and double (e.g. 10.00) display views.'
        )

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(ConfigCurrencyView))
        header_section.add_item(TextDisplay(f'**Server Configuration - Editing {self.selected_currency_name}**'))
        container.add_item(header_section)
        container.add_item(Separator())

        container.add_item(TextDisplay(
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
        ))
        container.add_item(Separator())

        toggle_double_section = Section(accessory=self.toggle_double_button)
        toggle_double_section.add_item(self.double_display_info)
        container.add_item(toggle_double_section)
        container.add_item(Separator())

        add_denomination_section = Section(accessory=self.add_denomination_button)
        add_denomination_section.add_item(TextDisplay(
            '**Add Denomination**\n'
            'Add one or more denomination(s) to the selected currency.'
        ))
        container.add_item(add_denomination_section)
        container.add_item(Separator())

        container.add_item(ActionRow(self.denomination_select))
        container.add_item(Separator())

        remove_denomination_section = Section(accessory=self.remove_denomination_button)
        remove_denomination_section.add_item(TextDisplay(
            '**Remove Denomination**\n'
            'Remove one or more denomination(s) from the selected currency.'
        ))
        container.add_item(remove_denomination_section)
        container.add_item(Separator())

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            self.denomination_select.options.clear()
            collection = bot.gdb['currency']
            query = await collection.find_one({'_id': guild.id})

            currency_name = self.selected_currency_name
            self.toggle_double_button.label = f'Toggle Display for {currency_name}'
            self.add_denomination_button.label = f'Add Denomination to {currency_name}'

            if self.selected_denomination_name:
                self.remove_denomination_button.disabled = False
                self.remove_denomination_button.label = f'Remove {self.selected_denomination_name} from {currency_name}'

            currency = next((item for item in query['currencies'] if item['name'] == currency_name),
                            None)
            if currency['isDouble']:
                display = 'Double'
            else:
                display = 'Integer'

            if currency['denominations']:
                self.denomination_select.disabled = False
                for denomination in currency['denominations']:
                    denomination_name = denomination['name']
                    self.denomination_select.options.append(
                        discord.SelectOption(label=denomination_name, value=denomination_name)
                    )
            else:
                self.denomination_select.disabled = True
                self.denomination_select.options.append(
                    discord.SelectOption(label='No denominations configured', value='None')
                )

            self.double_display_info.content = (
                f'**Display Type:** {display}\n'
                f'Toggles between integer (e.g. 10) and double (e.g. 10.00) display views.'
            )
        except Exception as e:
            await log_exception(e)

    async def remove_denomination_confirm_callback(self, interaction):
        try:
            denomination_name = self.selected_denomination_name
            collection = interaction.client.gdb['currency']
            guild_id = interaction.guild_id
            currency_name = self.selected_currency_name
            await collection.update_one({'_id': guild_id, 'currencies.name': currency_name},
                                        {'$pull': {'currencies.$.denominations': {'name': denomination_name}}})

            self.selected_denomination_name = None
            self.remove_denomination_button.label = 'Remove Denomination'
            self.remove_denomination_button.disabled = True

            await setup_view(self, interaction)
            await interaction.response.edit_message(view=self)
        except Exception as e:
            await log_exception(e)


# ------ SHOPS ------


class ConfigShopsView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.selected_channel_id = None

        self.edit_shop_wizard_info = TextDisplay(
            '**Edit Shop**\n'
            'Edit the selected shop using a UI wizard.'
        )
        self.edit_shop_json_info = TextDisplay(
            '**Edit Shop (JSON)**\n'
            'Upload a new JSON file to replace the selected shop\'s definition.'
        )
        self.download_shop_json_info = TextDisplay(
            '**Download JSON**\n'
            'Download the selected shop\'s current JSON definition.'
        )
        self.remove_shop_info = TextDisplay(
            '**Remove Shop**\n'
            'Removes the selected shop.'
        )

        self.shop_select = selects.ConfigShopSelect(self)
        self.add_shop_wizard_button = buttons.AddShopWizardButton(self)
        self.add_shop_json_button = buttons.AddShopJSONButton(self)
        self.edit_shop_wizard_button = buttons.EditShopButton(EditShopView, self)
        self.download_shop_json_button = buttons.DownloadShopJSONButton(self)
        self.edit_shop_json_button = buttons.UpdateShopJSONButton(self)
        self.remove_shop_button = buttons.RemoveShopButton(self)

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay('**Server Configuration - Shops**'))
        container.add_item(header_section)
        container.add_item(Separator())

        add_shop_wizard_section = Section(accessory=self.add_shop_wizard_button)
        add_shop_wizard_section.add_item(TextDisplay(
            '**Add Shop (Wizard)**\n'
            'Create a new, empty shop from a form.'
        ))
        container.add_item(add_shop_wizard_section)

        add_shop_json_section = Section(accessory=self.add_shop_json_button)
        add_shop_json_section.add_item(TextDisplay(
            '**Add Shop (JSON)**\n'
            'Create a new shop by providing a full JSON definition. (Advanced)'
        ))
        container.add_item(add_shop_json_section)
        container.add_item(Separator())

        container.add_item(ActionRow(self.shop_select))

        edit_shop_wizard_section = Section(accessory=self.edit_shop_wizard_button)
        edit_shop_wizard_section.add_item(self.edit_shop_wizard_info)
        container.add_item(edit_shop_wizard_section)

        edit_shop_json_section = Section(accessory=self.edit_shop_json_button)
        edit_shop_json_section.add_item(self.edit_shop_json_info)
        container.add_item(edit_shop_json_section)

        download_shop_json_section = Section(accessory=self.download_shop_json_button)
        download_shop_json_section.add_item(self.download_shop_json_info)
        container.add_item(download_shop_json_section)

        remove_shop_section = Section(accessory=self.remove_shop_button)
        remove_shop_section.add_item(self.remove_shop_info)
        container.add_item(remove_shop_section)

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            self.shop_select.options.clear()

            collection = bot.gdb['shops']
            query = await collection.find_one({'_id': guild.id})

            shop_options = []
            if query and query.get('shopChannels'):
                for channel_id, shop_data in query['shopChannels'].items():
                    shop_name = shop_data.get('shopName')
                    channel_name = guild.get_channel(int(channel_id)).name
                    shop_options.append(discord.SelectOption(label=f'{shop_name} (#{channel_name})', value=channel_id))

            if shop_options:
                self.shop_select.options = shop_options
                self.shop_select.disabled = False
                self.shop_select.placeholder = 'Select a shop to manage'
            else:
                self.shop_select.options = [discord.SelectOption(label='No shops configured', value='None')]
                self.shop_select.disabled = True
                self.shop_select.placeholder = 'No shops configured'

            if self.selected_channel_id:
                shop_name = next(
                    (opt.label for opt in shop_options if opt.value == self.selected_channel_id),
                    "Unknown").split('(')[0].strip()

                self.edit_shop_wizard_button.disabled = False
                self.edit_shop_wizard_button.label = f'Edit {shop_name} (Wizard)'
                self.edit_shop_wizard_info.content = (
                    f'**Edit Shop (Wizard):** {shop_name}\n'
                    f'Edit **{shop_name}** using a UI wizard.'
                )

                self.download_shop_json_button.disabled = False
                self.download_shop_json_button.label = f'Download {shop_name} JSON'
                self.download_shop_json_info.content = (
                    f'**Download JSON:** {shop_name}\n'
                    f'Download the current JSON definition for **{shop_name}**.'
                )

                self.edit_shop_json_button.disabled = False
                self.edit_shop_json_button.label = f'Edit {shop_name} (JSON)'
                self.edit_shop_json_info.content = (
                    f'**Edit Shop (JSON):** {shop_name}\n'
                    f'Upload a new JSON file to replace the current definition for **{shop_name}**.'
                )

                self.remove_shop_button.disabled = False
                self.remove_shop_button.label = f'Remove {shop_name}'
                self.remove_shop_info.content = (
                    f'**Remove Shop:** {shop_name}\n'
                    f'Removes **{shop_name}** from the server.'
                )

            if not self.selected_channel_id:
                self.edit_shop_wizard_button.disabled = True
                self.download_shop_json_button.disabled = True
                self.edit_shop_json_button.disabled = True
                self.remove_shop_button.disabled = True
        except Exception as e:
            await log_exception(e)


class EditShopView(LayoutView):
    def __init__(self, channel_id: str, shop_data: dict):
        super().__init__(timeout=None)
        self.channel_id = channel_id
        self.shop_data = shop_data
        self.all_stock = self.shop_data.get('shopStock', [])

        self.items_per_page = 6
        self.current_page = 0
        self.total_pages = math.ceil(len(self.all_stock) / self.items_per_page)
        self.done_editing_button = BackButton(ConfigShopsView)
        self.done_editing_button.label = 'Done Editing'  # Override the label for this button to avoid confusion

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
