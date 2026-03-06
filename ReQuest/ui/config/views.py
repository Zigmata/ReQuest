import logging
import math
from collections import namedtuple
from datetime import datetime, timezone, time
from typing import List

import discord
from discord import ButtonStyle
from discord.ui import (
    Container,
    Section,
    Separator,
    ActionRow,
    Button,
    TextDisplay,
    Thumbnail
)
from titlecase import titlecase

from ReQuest.ui.common import modals as common_modals, views as common_views
from ReQuest.ui.common.views import LocaleLayoutView
from ReQuest.ui.common.buttons import MenuViewButton, BackButton
from ReQuest.ui.common.enums import ShopChannelType, RestockMode, ScheduleType, RoleplayMode
from ReQuest.ui.config import buttons, selects
from ReQuest.ui.config.buttons import AddShopJSONButton
from ReQuest.utilities.constants import (
    ConfigFields, CurrencyFields, ShopFields, RestockFields, RoleplayFields, CommonFields,
    DatabaseCollections
)
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
from ReQuest.utilities.supportFunctions import (
    log_exception,
    strip_id,
    format_complex_cost,
    format_price_string,
    format_consolidated_totals,
    get_xp_config,
    get_cached_data,
    consolidate_currency_totals,
    get_shop_stock,
    escape_markdown,
    encode_mongo_key,
    decode_mongo_key
)

logger = logging.getLogger(__name__)


class ConfigBaseView(common_views.MenuBaseView):
    def __init__(self):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-title-main-menu'),
            menu_items=[
                {
                    'name': t(DEFAULT_LOCALE, 'config-menu-config-wizard'),
                    'description': t(DEFAULT_LOCALE, 'config-menu-desc-config-wizard'),
                    'view_class': ConfigWizardView
                },
                {
                    'name': t(DEFAULT_LOCALE, 'config-menu-channels'),
                    'description': t(DEFAULT_LOCALE, 'config-menu-desc-channels'),
                    'view_class': ConfigChannelsView
                },
                {
                    'name': t(DEFAULT_LOCALE, 'config-menu-currency'),
                    'description': t(DEFAULT_LOCALE, 'config-menu-desc-currency'),
                    'view_class': ConfigCurrencyView
                },
                {
                    'name': t(DEFAULT_LOCALE, 'config-menu-players'),
                    'description': t(DEFAULT_LOCALE, 'config-menu-desc-players'),
                    'view_class': ConfigPlayersView
                },
                {
                    'name': t(DEFAULT_LOCALE, 'config-menu-quests'),
                    'description': t(DEFAULT_LOCALE, 'config-menu-desc-quests'),
                    'view_class': ConfigQuestsView
                },
                {
                    'name': t(DEFAULT_LOCALE, 'config-menu-rp-rewards'),
                    'description': t(DEFAULT_LOCALE, 'config-menu-desc-rp-rewards'),
                    'view_class': ConfigRoleplayView
                },
                {
                    'name': t(DEFAULT_LOCALE, 'config-menu-roles'),
                    'description': t(DEFAULT_LOCALE, 'config-menu-desc-roles'),
                    'view_class': ConfigRolesView
                },
                {
                    'name': t(DEFAULT_LOCALE, 'config-menu-shops'),
                    'description': t(DEFAULT_LOCALE, 'config-menu-desc-shops'),
                    'view_class': ConfigShopsView
                },
                {
                    'name': t(DEFAULT_LOCALE, 'config-menu-language'),
                    'description': t(DEFAULT_LOCALE, 'config-menu-desc-language'),
                    'view_class': ConfigLanguageView
                }
            ],
            menu_level=0
        )


# ------ WIZARD ------


class ConfigWizardView(LocaleLayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.pages = []
        self.current_page = 0
        self.total_pages = 4
        self.intro_text = t(DEFAULT_LOCALE, 'config-wizard-intro')

        self.build_view()

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.accessory.label = t(DEFAULT_LOCALE, 'config-btn-quit')
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-wizard')))
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
                label=t(DEFAULT_LOCALE, 'common-btn-previous'),
                style=ButtonStyle.secondary,
                custom_id='wizard_prev_page',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page_callback
            nav_row.add_item(prev_button)

            page_button = Button(
                label=t(DEFAULT_LOCALE, 'common-page-display', **{'current': str(self.current_page + 1), 'total': str(len(self.pages))}),
                style=ButtonStyle.secondary,
                custom_id='wizard_page_indicator'
            )
            page_button.callback = self.show_page_jump_modal
            nav_row.add_item(page_button)

            next_button = Button(
                label=t(DEFAULT_LOCALE, 'common-btn-next'),
                style=ButtonStyle.secondary,
                custom_id='wizard_next_page',
                disabled=(self.current_page == len(self.pages) - 1)
            )
            next_button.callback = self.next_page_callback
            nav_row.add_item(next_button)

            scan_button = buttons.ScanServerButton(self)
            scan_button.label = t(DEFAULT_LOCALE, 'config-btn-re-scan')
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
            await interaction.response.send_message(t(DEFAULT_LOCALE, 'common-error-page-selector'), ephemeral=True)

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
                'view_channel': t(DEFAULT_LOCALE, 'config-wizard-perm-view-channels'),
                'manage_roles': t(DEFAULT_LOCALE, 'config-wizard-perm-manage-roles'),
                'send_messages': t(DEFAULT_LOCALE, 'config-wizard-perm-send-messages'),
                'attach_files': t(DEFAULT_LOCALE, 'config-wizard-perm-attach-files'),
                'add_reactions': t(DEFAULT_LOCALE, 'config-wizard-perm-add-reactions'),
                'use_external_emojis': t(DEFAULT_LOCALE, 'config-wizard-perm-use-external-emoji'),
                'manage_messages': t(DEFAULT_LOCALE, 'config-wizard-perm-manage-messages'),
                'read_message_history': t(DEFAULT_LOCALE, 'config-wizard-perm-read-message-history')
            }

            missing_perms = []

            for attr, name in required_permissions.items():
                if not getattr(bot_perms, attr):
                    missing_perms.append(t(DEFAULT_LOCALE, 'config-wizard-missing-perm', **{'permissionName': name}))

            report_lines = [
                t(DEFAULT_LOCALE, 'config-wizard-bot-permissions-header'),
                t(DEFAULT_LOCALE, 'config-wizard-bot-permissions-desc') + '\n',
                t(DEFAULT_LOCALE, 'config-wizard-bot-role', **{'roleMention': bot_member.top_role.mention})
            ]

            if missing_perms:
                report_lines.append(t(DEFAULT_LOCALE, 'config-wizard-status-warnings'))
                report_lines.extend(missing_perms)
                report_lines.append('')
                report_lines.append(t(DEFAULT_LOCALE, 'config-wizard-ensure-permissions'))
                return '\n'.join(report_lines), True
            else:
                report_lines.append(t(DEFAULT_LOCALE, 'config-wizard-status-ok'))
                report_lines.append(t(DEFAULT_LOCALE, 'config-wizard-bot-permissions-ok'))
                return '\n'.join(report_lines), False

        except Exception as e:
            required_perms_list = [
                t(DEFAULT_LOCALE, 'config-wizard-perm-view-channels'),
                t(DEFAULT_LOCALE, 'config-wizard-perm-manage-roles'),
                t(DEFAULT_LOCALE, 'config-wizard-perm-send-messages'),
                t(DEFAULT_LOCALE, 'config-wizard-perm-attach-files'),
                t(DEFAULT_LOCALE, 'config-wizard-perm-add-reactions'),
                t(DEFAULT_LOCALE, 'config-wizard-perm-use-external-emoji'),
                t(DEFAULT_LOCALE, 'config-wizard-perm-manage-messages'),
                t(DEFAULT_LOCALE, 'config-wizard-perm-read-message-history')
            ]

            report_lines = [
                t(DEFAULT_LOCALE, 'config-wizard-bot-permissions-header'),
                t(DEFAULT_LOCALE, 'config-wizard-status-scan-failed'),
                t(DEFAULT_LOCALE, 'config-wizard-scan-error'),
                t(DEFAULT_LOCALE, 'config-wizard-error-type', **{'errorType': type(e).__name__}),
                '',
                t(DEFAULT_LOCALE, 'config-wizard-required-permissions'),
                '\n'.join([f'- {p}' for p in required_perms_list])
            ]

            return '\n'.join(report_lines), True

    def validate_roles(self, guild, gm_roles_config, announcement_role_config):
        """
        Validate the permissions for default and GM roles.
        """
        has_warnings = False
        report_lines = [
            t(DEFAULT_LOCALE, 'config-wizard-role-header'),
            t(DEFAULT_LOCALE, 'config-wizard-role-desc')
        ]

        # Validate default (@everyone) role
        default_role = guild.default_role
        default_issues = []

        # These are needed for users to access the bot's features
        required_default_permissions = {
            'view_channel': t(DEFAULT_LOCALE, 'config-wizard-perm-view-channels'),
            'read_message_history': t(DEFAULT_LOCALE, 'config-wizard-perm-read-message-history'),
            'send_messages': t(DEFAULT_LOCALE, 'config-wizard-perm-send-messages'),
            'send_messages_in_threads': t(DEFAULT_LOCALE, 'config-wizard-perm-send-messages-in-threads'),
            'use_application_commands': t(DEFAULT_LOCALE, 'config-wizard-perm-use-application-commands')
        }

        for permission, name in required_default_permissions.items():
            if not getattr(default_role.permissions, permission):
                default_issues.append(t(DEFAULT_LOCALE, 'config-wizard-missing-permission', **{'permissionName': name}))

        # These are generally a bad idea, or may enable users to circumvent bot features
        dangerous_permissions = {
            'manage_channels': t(DEFAULT_LOCALE, 'config-wizard-perm-manage-channels'),
            'manage_roles': t(DEFAULT_LOCALE, 'config-wizard-perm-manage-roles'),
            'manage_webhooks': t(DEFAULT_LOCALE, 'config-wizard-perm-manage-webhooks'),
            'manage_guild': t(DEFAULT_LOCALE, 'config-wizard-perm-manage-server'),
            'manage_nicknames': t(DEFAULT_LOCALE, 'config-wizard-perm-manage-nicknames'),
            'kick_members': t(DEFAULT_LOCALE, 'config-wizard-perm-kick-members'),
            'ban_members': t(DEFAULT_LOCALE, 'config-wizard-perm-ban-members'),
            'moderate_members': t(DEFAULT_LOCALE, 'config-wizard-perm-timeout-members'),
            'mention_everyone': t(DEFAULT_LOCALE, 'config-wizard-perm-mention-everyone'),
            'manage_messages': t(DEFAULT_LOCALE, 'config-wizard-perm-manage-messages'),
            'manage_threads': t(DEFAULT_LOCALE, 'config-wizard-perm-manage-threads'),
            'administrator': t(DEFAULT_LOCALE, 'config-wizard-perm-administrator')
        }

        for permission, name in dangerous_permissions.items():
            if getattr(default_role.permissions, permission):
                default_issues.append(f'- `{name}`')

        if default_issues:
            has_warnings = True
            report_lines.append(t(DEFAULT_LOCALE, 'config-wizard-default-role-label') + '\n' + t(DEFAULT_LOCALE, 'config-wizard-default-role-dangerous'))
            report_lines.extend(default_issues)
        else:
            report_lines.append(t(DEFAULT_LOCALE, 'config-wizard-default-role-label') + '\n' + t(DEFAULT_LOCALE, 'config-wizard-default-role-ok'))

        # Validate at least one GM role is configured, and does not extend permissions of the default role
        if not gm_roles_config or not gm_roles_config.get(ConfigFields.GM_ROLES):
            has_warnings = True
            report_lines.append('\n' + t(DEFAULT_LOCALE, 'config-wizard-gm-roles-label') + '\n' + t(DEFAULT_LOCALE, 'config-wizard-no-gm-roles'))
        else:
            report_lines.append('\n' + t(DEFAULT_LOCALE, 'config-wizard-gm-roles-label'))
            for role_data in gm_roles_config[ConfigFields.GM_ROLES]:
                try:
                    role_id = strip_id(role_data[CommonFields.MENTION])
                    role = guild.get_role(role_id)

                    if not role:
                        has_warnings = True
                        report_lines.append(t(DEFAULT_LOCALE, 'config-wizard-role-not-found', **{'roleName': role_data[CommonFields.NAME]}))
                        continue

                    escalation_report = self._has_escalations(role, default_role)

                    if escalation_report.has_escalations:
                        has_warnings = True
                        report_lines.extend(escalation_report.report_lines)
                    else:
                        report_lines.append(t(DEFAULT_LOCALE, 'config-wizard-role-ok', **{'roleMention': role.mention}))
                except Exception as e:
                    logger.error(f'Error validating role {role_data}: {e}')
                    report_lines.append(f'- Error validating {role_data[CommonFields.NAME]}')

        # Validate announcement role
        if not announcement_role_config or not announcement_role_config.get(ConfigFields.ANNOUNCE_ROLE):
            has_warnings = True
            report_lines.append('\n' + t(DEFAULT_LOCALE, 'config-wizard-announcement-role-label') + '\n' + t(DEFAULT_LOCALE, 'config-wizard-no-announcement-role'))
        else:
            try:
                role_id = strip_id(announcement_role_config[ConfigFields.ANNOUNCE_ROLE])
                role = guild.get_role(role_id)

                if not role:
                    has_warnings = True
                    report_lines.append(
                        '\n' + t(DEFAULT_LOCALE, 'config-wizard-announcement-role-label') + '\n' + t(DEFAULT_LOCALE, 'config-wizard-announcement-role-not-found')
                    )
                else:
                    escalation_report = self._has_escalations(role, default_role)

                    if escalation_report.has_escalations:
                        has_warnings = True
                        report_lines.append('\n' + t(DEFAULT_LOCALE, 'config-wizard-announcement-role-label'))
                        report_lines.extend(escalation_report.report_lines)
                    else:
                        report_lines.append('\n' + t(DEFAULT_LOCALE, 'config-wizard-announcement-role-label') + '\n' + t(DEFAULT_LOCALE, 'config-wizard-role-ok', **{'roleMention': role.mention}))
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
            t(DEFAULT_LOCALE, 'config-wizard-channel-header'),
            t(DEFAULT_LOCALE, 'config-wizard-channel-desc')
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
                    report_lines.append(f'\n**{name}:**\n' + t(DEFAULT_LOCALE, 'config-wizard-channel-no-config-required'))
                else:
                    report_lines.append(f'\n**{name}:**\n' + t(DEFAULT_LOCALE, 'config-wizard-channel-not-configured'))
                continue

            try:
                channel_id = strip_id(mention)
                channel = guild.get_channel(channel_id)

                if not channel:
                    has_warnings = True
                    report_lines.append(f'\n**{name}:**\n' + t(DEFAULT_LOCALE, 'config-wizard-channel-not-found'))
                    continue

                # Check bot permissions
                bot_permissions = channel.permissions_for(bot_member)
                channel_issues = []

                bot_mention = bot_member.mention

                if not bot_permissions.view_channel:
                    channel_issues.append(t(DEFAULT_LOCALE, 'config-wizard-bot-cannot-view', **{'botMention': bot_mention}))
                if not bot_permissions.send_messages:
                    channel_issues.append(t(DEFAULT_LOCALE, 'config-wizard-bot-cannot-send', **{'botMention': bot_mention}))

                # Check default role permissions
                default_role = guild.default_role
                default_permissions = channel.permissions_for(default_role)
                if default_permissions.send_messages:
                    channel_issues.append(t(DEFAULT_LOCALE, 'config-wizard-everyone-can-send'))

                if channel_issues:
                    has_warnings = True
                    report_lines.append(f'\n**{name} ({channel.mention}):**')
                    report_lines.extend(channel_issues)
                else:
                    report_lines.append(f'\n**{name} ({channel.mention}):**\n' + t(DEFAULT_LOCALE, 'config-wizard-channel-ok'))
            except Exception as e:
                logger.error(f'Error validating channel {name}: {e}')
                report_lines.append(f'- Error validating {name} channel')
                has_warnings = True

        button = MenuViewButton(ConfigChannelsView, t(DEFAULT_LOCALE, 'config-btn-configure-channels'))
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
                    escalations_str += t(DEFAULT_LOCALE, 'config-wizard-escalation-more', **{'count': str(len(escalations) - 3)})

            report_lines.append(
                t(DEFAULT_LOCALE, 'config-wizard-escalation-detected', **{'roleMention': role.mention, 'escalations': escalations_str})
            )
            return result(True, report_lines)
        else:
            return result(False, report_lines)

    @staticmethod
    def _format_currency_report(currency_config):
        report_lines = []
        if not currency_config or not currency_config.get(CurrencyFields.CURRENCIES):
            report_lines.append(t(DEFAULT_LOCALE, 'config-wizard-no-currencies'))
            return '\n'.join(report_lines)

        report_lines.append(t(DEFAULT_LOCALE, 'config-wizard-configured-currencies'))
        for currency in currency_config[CurrencyFields.CURRENCIES]:
            name = currency[CommonFields.NAME]
            denominations = currency.get(CurrencyFields.DENOMINATIONS, {})

            lines = [f'- **{name}**']

            if denominations:
                denomination_list = []
                for denomination in denominations:
                    denom_name = denomination[CommonFields.NAME]
                    denom_value = denomination[CurrencyFields.VALUE]
                    denomination_list.append(f'  - {denom_name}: {denom_value}')
                lines.extend(denomination_list)
            else:
                lines.append('  - ' + t(DEFAULT_LOCALE, 'config-wizard-no-denominations'))

            report_lines.extend(lines)

        return '\n'.join(report_lines)

    @staticmethod
    def _format_gm_rewards_report(gm_rewards_query):
        report_lines = []
        if not gm_rewards_query or (not gm_rewards_query.get('experience') and not gm_rewards_query.get(CommonFields.ITEMS)):
            report_lines.append(t(DEFAULT_LOCALE, 'config-wizard-gm-rewards-disabled'))
            return '\n'.join(report_lines)

        report_lines.append(t(DEFAULT_LOCALE, 'config-wizard-gm-rewards-enabled'))
        experience = gm_rewards_query.get('experience')
        items = gm_rewards_query.get(CommonFields.ITEMS)

        if experience and experience > 0:
            report_lines.append(t(DEFAULT_LOCALE, 'config-wizard-gm-rewards-experience', **{'xp': str(experience)}))

        if items:
            report_lines.append(t(DEFAULT_LOCALE, 'config-wizard-gm-rewards-items'))
            for item_name, quantity in items.items():
                report_lines.append(f'  - {escape_markdown(titlecase(item_name))}: {quantity}')

        return '\n'.join(report_lines)

    def validate_dashboard_settings(self, wait_list_query, quest_summary_query, gm_rewards_query,
                                    player_xp_query, currency_config, roleplay_config,
                                    shops_config, inventory_config, new_char_shop, static_kits):

        # Fetch data
        wait_list_size = wait_list_query.get(ConfigFields.QUEST_WAIT_LIST, 0) if wait_list_query else 0
        summary_enabled = quest_summary_query.get('questSummary', False) if quest_summary_query else False
        xp_enabled = player_xp_query.get(ConfigFields.PLAYER_EXPERIENCE, False) if player_xp_query else False

        # Define different sections/components
        components = []

        # Quest Settings
        wait_list_display = str(wait_list_size) if wait_list_size > 0 else t(DEFAULT_LOCALE, 'config-label-rp-disabled')
        summary_display = t(DEFAULT_LOCALE, 'config-label-rp-enabled') if summary_enabled else t(DEFAULT_LOCALE, 'config-label-rp-disabled')
        quest_section_content = [
            t(DEFAULT_LOCALE, 'config-wizard-quest-settings'),
            t(DEFAULT_LOCALE, 'config-wizard-quest-wait-list', **{'size': wait_list_display}),
            t(DEFAULT_LOCALE, 'config-wizard-quest-summary', **{'status': summary_display}),
            '\n' + t(DEFAULT_LOCALE, 'config-wizard-gm-rewards-per-quest'),
            self._format_gm_rewards_report(gm_rewards_query)
        ]
        components.append({
            'content': '\n'.join(quest_section_content),
            'shortcut_button': MenuViewButton(ConfigQuestsView, t(DEFAULT_LOCALE, 'config-btn-configure-quests'))
        })

        # Player Settings
        xp_display = t(DEFAULT_LOCALE, 'config-label-rp-enabled') if xp_enabled else t(DEFAULT_LOCALE, 'config-label-rp-disabled')
        player_section_content = [
            t(DEFAULT_LOCALE, 'config-wizard-player-settings'),
            t(DEFAULT_LOCALE, 'config-wizard-player-experience', **{'status': xp_display})
        ]
        components.append({
            'content': '\n'.join(player_section_content),
            'shortcut_button': MenuViewButton(ConfigPlayersView, t(DEFAULT_LOCALE, 'config-btn-configure-players'))
        })

        # Currency Settings
        currency_section_content = [
            t(DEFAULT_LOCALE, 'config-wizard-currency-settings'),
            self._format_currency_report(currency_config)
        ]
        components.append({
            'content': '\n'.join(currency_section_content),
            'shortcut_button': MenuViewButton(ConfigCurrencyView, t(DEFAULT_LOCALE, 'config-btn-configure-currency'))
        })

        # Roleplay Rewards Settings
        rp_enabled = roleplay_config.get(RoleplayFields.ENABLED, False) if roleplay_config else False
        rp_mode = roleplay_config.get(RoleplayFields.MODE, 'scheduled') if roleplay_config else 'scheduled'
        rp_channels = roleplay_config.get(RoleplayFields.CHANNELS, []) if roleplay_config else []
        rp_status_display = t(DEFAULT_LOCALE, 'config-label-rp-enabled') if rp_enabled else t(DEFAULT_LOCALE, 'config-label-rp-disabled')
        roleplay_section_content = [
            t(DEFAULT_LOCALE, 'config-wizard-rp-rewards'),
            t(DEFAULT_LOCALE, 'config-wizard-rp-status', **{'status': rp_status_display}),
            t(DEFAULT_LOCALE, 'config-wizard-rp-mode', **{'mode': rp_mode.capitalize()}),
            t(DEFAULT_LOCALE, 'config-wizard-rp-channels', **{'count': str(len(rp_channels))})
        ]
        components.append({
            'content': '\n'.join(roleplay_section_content),
            'shortcut_button': MenuViewButton(ConfigRoleplayView, t(DEFAULT_LOCALE, 'config-btn-configure-rp-rewards'))
        })

        # Shops Settings
        shop_channels = shops_config.get(ShopFields.SHOP_CHANNELS, {}) if shops_config else {}
        shops_section_content = [
            t(DEFAULT_LOCALE, 'config-wizard-shops'),
            t(DEFAULT_LOCALE, 'config-wizard-shops-count', **{'count': str(len(shop_channels))})
        ]
        if shop_channels:
            shop_names = [data.get(ShopFields.SHOP_NAME, t(DEFAULT_LOCALE, 'config-wizard-unnamed-shop')) for data in shop_channels.values()]
            shop_names.sort(key=str.lower)
            for shop_name in shop_names[:3]:
                shops_section_content.append(f'  - {shop_name}')
            if len(shop_names) > 3:
                shops_section_content.append('  - ' + t(DEFAULT_LOCALE, 'config-wizard-shops-more', **{'count': str(len(shop_names) - 3)}))
        components.append({
            'content': '\n'.join(shops_section_content),
            'shortcut_button': MenuViewButton(ConfigShopsView, t(DEFAULT_LOCALE, 'config-btn-configure-shops'))
        })

        # New Character Setup
        inv_type = inventory_config.get(ConfigFields.INVENTORY_TYPE, 'none') if inventory_config else 'none'
        shop_items = new_char_shop.get(ShopFields.SHOP_STOCK, []) if new_char_shop else []
        kits = static_kits.get('kits', []) if static_kits else []
        new_char_section_content = [
            t(DEFAULT_LOCALE, 'config-wizard-new-char-setup'),
            t(DEFAULT_LOCALE, 'config-wizard-inventory-type', **{'type': inv_type.capitalize()}),
            t(DEFAULT_LOCALE, 'config-wizard-new-char-shop-items', **{'count': str(len(shop_items))}),
            t(DEFAULT_LOCALE, 'config-wizard-static-kits', **{'count': str(len(kits))})
        ]
        components.append({
            'content': '\n'.join(new_char_section_content),
            'shortcut_button': MenuViewButton(ConfigPlayersView, t(DEFAULT_LOCALE, 'config-btn-new-char-setup'))
        })

        # Header
        intro_content = [
            t(DEFAULT_LOCALE, 'config-wizard-dashboard-header'),
            t(DEFAULT_LOCALE, 'config-wizard-dashboard-desc') + '\n'
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
                collection_name=DatabaseCollections.ANNOUNCE_ROLE,
                query={CommonFields.ID: guild.id}
            )
            gm_roles_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name=DatabaseCollections.GM_ROLES,
                query={CommonFields.ID: guild.id}
            )

            # Channel configs
            channels = []
            quest_channel_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name=DatabaseCollections.QUEST_CHANNEL,
                query={CommonFields.ID: guild.id}
            )
            channels.append(
                {
                    'name': t(DEFAULT_LOCALE, 'config-wizard-channel-quest-board'),
                    'mention': quest_channel_query[ConfigFields.QUEST_CHANNEL] if quest_channel_query else None,
                    'required': True}
            )

            player_channel_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name=DatabaseCollections.PLAYER_BOARD_CHANNEL,
                query={CommonFields.ID: guild.id}
            )
            channels.append(
                {
                    'name': t(DEFAULT_LOCALE, 'config-wizard-channel-player-board'),
                    'mention': player_channel_query[ConfigFields.PLAYER_BOARD_CHANNEL] if player_channel_query else None,
                    'required': False}
            )

            archive_channel_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name=DatabaseCollections.ARCHIVE_CHANNEL,
                query={CommonFields.ID: guild.id}
            )
            channels.append(
                {
                    'name': t(DEFAULT_LOCALE, 'config-wizard-channel-quest-archive'),
                    'mention': archive_channel_query[ConfigFields.ARCHIVE_CHANNEL] if archive_channel_query else None,
                    'required': False
                }
            )

            gm_log_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name=DatabaseCollections.GM_TRANSACTION_LOG_CHANNEL,
                query={CommonFields.ID: guild.id}
            )
            channels.append(
                {
                    'name': t(DEFAULT_LOCALE, 'config-wizard-channel-gm-transaction-log'),
                    'mention': gm_log_query[ConfigFields.GM_TRANSACTION_LOG_CHANNEL] if gm_log_query else None,
                    'required': False
                }
            )

            player_transaction_log_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name=DatabaseCollections.PLAYER_TRANSACTION_LOG_CHANNEL,
                query={CommonFields.ID: guild.id}
            )
            channels.append(
                {
                    'name': t(DEFAULT_LOCALE, 'config-wizard-channel-player-transaction-log'),
                    'mention': player_transaction_log_query[ConfigFields.PLAYER_TRANSACTION_LOG_CHANNEL]
                    if player_transaction_log_query else None,
                    'required': False
                }
            )

            shop_log_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name=DatabaseCollections.SHOP_LOG_CHANNEL,
                query={CommonFields.ID: guild.id}
            )
            channels.append(
                {
                    'name': t(DEFAULT_LOCALE, 'config-wizard-channel-shop-log'),
                    'mention': shop_log_query[ConfigFields.SHOP_LOG_CHANNEL] if shop_log_query else None,
                    'required': False
                }
            )

            approval_queue_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name=DatabaseCollections.APPROVAL_QUEUE_CHANNEL,
                query={CommonFields.ID: guild.id}
            )
            channels.append(
                {
                    'name': t(DEFAULT_LOCALE, 'config-wizard-channel-approval-queue'),
                    'mention': approval_queue_query[ConfigFields.APPROVAL_QUEUE_CHANNEL] if approval_queue_query else None,
                    'required': False
                }
            )

            # Dashboard configs
            wait_list_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name=DatabaseCollections.QUEST_WAIT_LIST,
                query={CommonFields.ID: guild.id}
            )
            quest_summary_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name=DatabaseCollections.QUEST_SUMMARY,
                query={CommonFields.ID: guild.id}
            )
            gm_rewards_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name=DatabaseCollections.GM_REWARDS,
                query={CommonFields.ID: guild.id}
            )
            player_xp_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name=DatabaseCollections.PLAYER_EXPERIENCE,
                query={CommonFields.ID: guild.id}
            )
            currency_config_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: guild.id}
            )

            # Roleplay config
            roleplay_config_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name=DatabaseCollections.ROLEPLAY_CONFIG,
                query={CommonFields.ID: guild.id}
            )

            # Shops config
            shops_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={CommonFields.ID: guild.id}
            )

            # New character setup configs
            inventory_config_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name=DatabaseCollections.INVENTORY_CONFIG,
                query={CommonFields.ID: guild.id}
            )
            new_char_shop_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name=DatabaseCollections.NEW_CHARACTER_SHOP,
                query={CommonFields.ID: guild.id}
            )
            static_kits_query = await get_cached_data(
                bot=bot,
                mongo_database=gdb,
                collection_name=DatabaseCollections.STATIC_KITS,
                query={CommonFields.ID: guild.id}
            )

            # Role validation report
            role_text, role_has_warnings = self.validate_roles(guild, gm_roles_query, announcement_role_query)
            role_button = MenuViewButton(ConfigRolesView, t(DEFAULT_LOCALE, 'config-btn-configure-roles'))
            role_button.disabled = not role_has_warnings

            # Channel validation report
            channel_text, channel_button = self.validate_channels(guild, channels)

            # Dashboard settings report
            dashboard_data = self.validate_dashboard_settings(
                wait_list_query, quest_summary_query, gm_rewards_query, player_xp_query, currency_config_query,
                roleplay_config_query, shops_query, inventory_config_query, new_char_shop_query, static_kits_query
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


class ConfigRolesView(LocaleLayoutView):
    def __init__(self):
        super().__init__(timeout=None)

        self.announcement_role_status = TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-announcement-role-default') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-announcement-role')
        )
        self.gm_roles_status = TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-gm-roles-default') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-gm-roles')
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
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-roles')))

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
            t(DEFAULT_LOCALE, 'config-title-forbidden-roles') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-forbidden-roles')
        ))
        forbidden_role_row = ActionRow(self.forbidden_roles_button)
        container.add_item(forbidden_role_row)

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            announcement_role_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.ANNOUNCE_ROLE,
                query={CommonFields.ID: guild.id}
            )
            announcement_role = announcement_role_query.get(ConfigFields.ANNOUNCE_ROLE) if announcement_role_query else None
            gm_role_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.GM_ROLES,
                query={CommonFields.ID: guild.id}
            )
            gm_roles = gm_role_query.get(ConfigFields.GM_ROLES, []) if gm_role_query else []

            if not announcement_role:
                announcement_role_string = (
                    t(DEFAULT_LOCALE, 'config-label-announcement-role-default') + '\n' +
                    t(DEFAULT_LOCALE, 'config-desc-announcement-role')
                )
                self.quest_announce_role_remove_button.disabled = True
            else:
                announcement_role_string = (
                    t(DEFAULT_LOCALE, 'config-label-announcement-role', **{'status': announcement_role}) + '\n' +
                    t(DEFAULT_LOCALE, 'config-desc-announcement-role')
                )
                self.quest_announce_role_remove_button.disabled = False

            if not gm_roles:
                gm_roles_string = (
                    t(DEFAULT_LOCALE, 'config-label-gm-roles-default') + '\n' +
                    t(DEFAULT_LOCALE, 'config-desc-gm-roles')
                )
                self.gm_role_remove_view_button.disabled = True
            else:
                role_mentions = []
                for role in gm_roles:
                    role_mentions.append(role[CommonFields.MENTION])

                gm_roles_string = (
                    t(DEFAULT_LOCALE, 'config-label-gm-roles', **{'roles': ', '.join(role_mentions)}) + '\n' +
                    t(DEFAULT_LOCALE, 'config-desc-gm-roles')
                )
                self.gm_role_remove_view_button.disabled = False

            self.announcement_role_status.content = announcement_role_string
            self.gm_roles_status.content = gm_roles_string

            self.build_view()
        except Exception as e:
            await log_exception(e)


class ConfigGMRoleRemoveView(LocaleLayoutView):
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
                collection_name=DatabaseCollections.GM_ROLES,
                query={CommonFields.ID: guild.id}
            )

            self.roles = query.get(ConfigFields.GM_ROLES, []) if query else []
            self.roles.sort(key=lambda x: x.get(CommonFields.NAME, '').lower())

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
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-remove-gm-roles')))
        container.add_item(header_section)
        container.add_item(Separator())

        if not self.roles:
            container.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-msg-no-gm-roles')))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_roles = self.roles[start:end]

            for role in page_roles:
                name = role.get(CommonFields.NAME, 'Unknown')
                mention = role.get(CommonFields.MENTION, '')

                info = f"{mention}"

                section = Section(accessory=buttons.RemoveGMRoleButton(self, name))
                section.add_item(TextDisplay(info))
                container.add_item(section)

        self.add_item(container)

        if self.total_pages > 1:
            nav_row = ActionRow()

            prev_button = Button(
                label=t(DEFAULT_LOCALE, 'common-btn-previous'),
                style=discord.ButtonStyle.secondary,
                custom_id='gm_role_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_display = Button(
                label=t(DEFAULT_LOCALE, 'common-page-label', **{'current': str(self.current_page + 1), 'total': str(self.total_pages)}),
                style=discord.ButtonStyle.secondary,
                custom_id='gm_role_page'
            )
            page_display.callback = self.show_page_jump_modal
            nav_row.add_item(page_display)

            next_button = Button(
                label=t(DEFAULT_LOCALE, 'common-btn-next'),
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


class ConfigChannelsView(LocaleLayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.quest_board_info = TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-quest-board-default') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-quest-board')
        )
        self.player_board_info = TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-player-board-default') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-player-board')
        )
        self.quest_archive_info = TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-quest-archive-default') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-quest-archive')
        )
        self.gm_transaction_log_info = TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-gm-transaction-log-default') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-gm-transaction-log')
        )
        self.player_transaction_log_info = TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-player-transaction-log-default') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-player-transaction-log')
        )
        self.shop_log_info = TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-shop-log-default') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-shop-log')
        )
        self.quest_channel_select = selects.SingleChannelConfigSelect(
            calling_view=self,
            config_type=ConfigFields.QUEST_CHANNEL,
            config_name='Quest Board'
        )
        self.player_board_channel_select = selects.SingleChannelConfigSelect(
            calling_view=self,
            config_type=ConfigFields.PLAYER_BOARD_CHANNEL,
            config_name='Player Board'
        )
        self.archive_channel_select = selects.SingleChannelConfigSelect(
            calling_view=self,
            config_type=ConfigFields.ARCHIVE_CHANNEL,
            config_name='Quest Archive'
        )
        self.gm_transaction_log_channel_select = selects.SingleChannelConfigSelect(
            calling_view=self,
            config_type=ConfigFields.GM_TRANSACTION_LOG_CHANNEL,
            config_name='GM Transaction Log'
        )
        self.player_transaction_log_channel_select = selects.SingleChannelConfigSelect(
            calling_view=self,
            config_type=ConfigFields.PLAYER_TRANSACTION_LOG_CHANNEL,
            config_name='Player Transaction Log'
        )
        self.shop_log_channel_select = selects.SingleChannelConfigSelect(
            calling_view=self,
            config_type=ConfigFields.SHOP_LOG_CHANNEL,
            config_name='Shop Log'
        )

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-channels')))

        container.add_item(header_section)
        container.add_item(Separator())

        quest_board_section = Section(accessory=buttons.ClearChannelButton(self, ConfigFields.QUEST_CHANNEL))
        quest_board_section.add_item(self.quest_board_info)
        container.add_item(quest_board_section)
        quest_board_select_row = ActionRow(self.quest_channel_select)
        container.add_item(quest_board_select_row)
        container.add_item(Separator())

        player_board_section = Section(accessory=buttons.ClearChannelButton(self, ConfigFields.PLAYER_BOARD_CHANNEL))
        player_board_section.add_item(self.player_board_info)
        container.add_item(player_board_section)
        player_board_select_row = ActionRow(self.player_board_channel_select)
        container.add_item(player_board_select_row)
        container.add_item(Separator())

        quest_archive_section = Section(accessory=buttons.ClearChannelButton(self, ConfigFields.ARCHIVE_CHANNEL))
        quest_archive_section.add_item(self.quest_archive_info)
        container.add_item(quest_archive_section)
        quest_archive_select_row = ActionRow(self.archive_channel_select)
        container.add_item(quest_archive_select_row)
        container.add_item(Separator())

        gm_transaction_log_section = Section(accessory=buttons.ClearChannelButton(self,
                                                                                  ConfigFields.GM_TRANSACTION_LOG_CHANNEL))
        gm_transaction_log_section.add_item(self.gm_transaction_log_info)
        container.add_item(gm_transaction_log_section)
        gm_transaction_log_select_row = ActionRow(self.gm_transaction_log_channel_select)
        container.add_item(gm_transaction_log_select_row)
        container.add_item(Separator())

        player_transaction_log_section = Section(accessory=buttons.ClearChannelButton(self,
                                                                                      ConfigFields.PLAYER_TRANSACTION_LOG_CHANNEL))
        player_transaction_log_section.add_item(self.player_transaction_log_info)
        container.add_item(player_transaction_log_section)
        player_transaction_log_select_row = ActionRow(self.player_transaction_log_channel_select)
        container.add_item(player_transaction_log_select_row)
        container.add_item(Separator())

        shop_log_section = Section(accessory=buttons.ClearChannelButton(self, ConfigFields.SHOP_LOG_CHANNEL))
        shop_log_section.add_item(self.shop_log_info)
        container.add_item(shop_log_section)
        shop_log_select_row = ActionRow(self.shop_log_channel_select)
        container.add_item(shop_log_select_row)

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            player_board_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.PLAYER_BOARD_CHANNEL,
                query={CommonFields.ID: guild.id}
            )
            player_board = player_board_query.get(ConfigFields.PLAYER_BOARD_CHANNEL) if player_board_query else None

            quest_board_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUEST_CHANNEL,
                query={CommonFields.ID: guild.id}
            )
            quest_board = quest_board_query.get(ConfigFields.QUEST_CHANNEL) if quest_board_query else None

            quest_archive_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.ARCHIVE_CHANNEL,
                query={CommonFields.ID: guild.id}
            )
            quest_archive = quest_archive_query.get(ConfigFields.ARCHIVE_CHANNEL) if quest_archive_query else None

            gm_log_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.GM_TRANSACTION_LOG_CHANNEL,
                query={CommonFields.ID: guild.id}
            )
            gm_transaction_log = gm_log_query.get(ConfigFields.GM_TRANSACTION_LOG_CHANNEL) if gm_log_query else None

            player_log_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.PLAYER_TRANSACTION_LOG_CHANNEL,
                query={CommonFields.ID: guild.id}
            )
            player_transaction_log = player_log_query.get(ConfigFields.PLAYER_TRANSACTION_LOG_CHANNEL) if player_log_query else None

            shop_log_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOP_LOG_CHANNEL,
                query={CommonFields.ID: guild.id}
            )
            shop_log = shop_log_query.get(ConfigFields.SHOP_LOG_CHANNEL) if shop_log_query else None

            self.quest_board_info.content = (
                t(DEFAULT_LOCALE, 'config-label-quest-board', **{'channel': str(quest_board)}) + '\n' +
                t(DEFAULT_LOCALE, 'config-desc-quest-board')
            )
            self.player_board_info.content = (
                t(DEFAULT_LOCALE, 'config-label-player-board', **{'channel': str(player_board)}) + '\n' +
                t(DEFAULT_LOCALE, 'config-desc-player-board')
            )
            self.quest_archive_info.content = (
                t(DEFAULT_LOCALE, 'config-label-quest-archive', **{'channel': str(quest_archive)}) + '\n' +
                t(DEFAULT_LOCALE, 'config-desc-quest-archive')
            )
            self.gm_transaction_log_info.content = (
                t(DEFAULT_LOCALE, 'config-label-gm-transaction-log', **{'channel': str(gm_transaction_log)}) + '\n' +
                t(DEFAULT_LOCALE, 'config-desc-gm-transaction-log')
            )
            self.player_transaction_log_info.content = (
                t(DEFAULT_LOCALE, 'config-label-player-transaction-log', **{'channel': str(player_transaction_log)}) + '\n' +
                t(DEFAULT_LOCALE, 'config-desc-player-transaction-log')
            )
            self.shop_log_info.content = (
                t(DEFAULT_LOCALE, 'config-label-shop-log', **{'channel': str(shop_log)}) + '\n' +
                t(DEFAULT_LOCALE, 'config-desc-shop-log')
            )

            self.build_view()
        except Exception as e:
            await log_exception(e)


# ------ QUESTS ------


class ConfigQuestsView(LocaleLayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.wait_list_info = TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-wait-list-disabled') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-wait-list')
        )
        self.quest_summary_info = TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-quest-summary-disabled') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-quest-summary')
        )
        self.wait_list_select = selects.ConfigWaitListSelect(self)
        self.quest_summary_toggle_button = buttons.QuestSummaryToggleButton(self)

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-quests')))

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

        gm_rewards_section = Section(accessory=MenuViewButton(GMRewardsView, t(DEFAULT_LOCALE, 'config-label-gm-rewards')))
        gm_rewards_section.add_item(TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-gm-rewards') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-gm-rewards')
        ))
        container.add_item(gm_rewards_section)

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            quest_summary_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUEST_SUMMARY,
                query={CommonFields.ID: guild.id}
            )
            quest_summary = quest_summary_query.get('questSummary') if quest_summary_query else False

            wait_list_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUEST_WAIT_LIST,
                query={CommonFields.ID: guild.id}
            )
            wait_list = wait_list_query.get(ConfigFields.QUEST_WAIT_LIST, 0) if wait_list_query else 0

            if isinstance(wait_list, int) and wait_list > 0:
                self.wait_list_info.content = (
                    t(DEFAULT_LOCALE, 'config-label-wait-list', **{'size': str(wait_list)}) + '\n' +
                    t(DEFAULT_LOCALE, 'config-desc-wait-list')
                )
            else:
                self.wait_list_info.content = (
                    t(DEFAULT_LOCALE, 'config-label-wait-list-disabled') + '\n' +
                    t(DEFAULT_LOCALE, 'config-desc-wait-list')
                )

            if quest_summary is True:
                quest_summary_display = t(DEFAULT_LOCALE, 'config-label-rp-enabled')
                self.quest_summary_info.content = (
                    t(DEFAULT_LOCALE, 'config-label-quest-summary', **{'status': quest_summary_display}) + '\n' +
                    t(DEFAULT_LOCALE, 'config-desc-quest-summary')
                )
            else:
                self.quest_summary_info.content = (
                    t(DEFAULT_LOCALE, 'config-label-quest-summary-disabled') + '\n' +
                    t(DEFAULT_LOCALE, 'config-desc-quest-summary')
                )

            self.build_view()
        except Exception as e:
            await log_exception(e)


class GMRewardsView(LocaleLayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.gm_rewards_info = TextDisplay(t(DEFAULT_LOCALE, 'config-msg-no-rewards'))
        self.current_rewards = None
        self.xp_enabled = True

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigQuestsView))
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-gm-rewards')))

        container.add_item(header_section)
        container.add_item(Separator())

        gm_rewards_section = Section(accessory=buttons.GMRewardsButton(self))
        gm_rewards_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-desc-gm-rewards-detail')))
        container.add_item(gm_rewards_section)
        container.add_item(Separator())

        container.add_item(self.gm_rewards_info)

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            self.xp_enabled = await get_xp_config(bot, guild.id)
            gm_rewards_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.GM_REWARDS,
                query={CommonFields.ID: guild.id}
            )
            experience = None
            items = None
            if gm_rewards_query:
                self.current_rewards = gm_rewards_query
                experience = gm_rewards_query['experience']
                items = gm_rewards_query[CommonFields.ITEMS]

            xp_info = ''
            item_info = ''
            if self.xp_enabled and experience:
                xp_info = t(DEFAULT_LOCALE, 'config-label-gm-experience', **{'xp': str(experience)})

            if items:
                rewards_list = []
                for item, quantity in items.items():
                    rewards_list.append(f'{item.capitalize()}: {quantity}')
                rewards_string = '\n'.join(rewards_list)
                item_info = t(DEFAULT_LOCALE, 'config-label-gm-items') + '\n' + rewards_string

            if xp_info or item_info:
                self.gm_rewards_info.content = f'{xp_info}\n\n{item_info}'.strip()
            else:
                self.gm_rewards_info.content = t(DEFAULT_LOCALE, 'config-msg-no-rewards')

            self.build_view()
        except Exception as e:
            await log_exception(e)


# ------ PLAYERS ------


class ConfigPlayersView(LocaleLayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.player_experience_info = TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-player-experience-disabled') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-player-experience')
        )

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-players')))
        container.add_item(header_section)
        container.add_item(Separator())

        experience_section = Section(accessory=buttons.PlayerExperienceToggleButton(self))
        experience_section.add_item(self.player_experience_info)
        container.add_item(experience_section)
        container.add_item(Separator())

        new_character_section = Section(accessory=MenuViewButton(ConfigNewCharacterView, t(DEFAULT_LOCALE, 'config-btn-new-character-settings')))
        new_character_section.add_item(TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-new-char-settings') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-new-char-settings')
        ))
        container.add_item(new_character_section)
        container.add_item(Separator())

        player_board_section = Section(accessory=buttons.PlayerBoardPurgeButton(self))
        player_board_section.add_item(TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-player-board-purge') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-player-board-purge') + '\n\n'
        ))
        container.add_item(player_board_section)

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            # XP section
            player_experience = await get_xp_config(bot, guild.id)
            if player_experience:
                self.player_experience_info.content = (
                    t(DEFAULT_LOCALE, 'config-label-player-experience', **{'status': t(DEFAULT_LOCALE, 'config-label-rp-enabled')}) + '\n' +
                    t(DEFAULT_LOCALE, 'config-desc-player-experience')
                )
            else:
                self.player_experience_info.content = (
                    t(DEFAULT_LOCALE, 'config-label-player-experience-disabled') + '\n' +
                    t(DEFAULT_LOCALE, 'config-desc-player-experience')
                )

            self.build_view()
        except Exception as e:
            await log_exception(e)


class ConfigNewCharacterView(LocaleLayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.inventory_type_info = TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-inventory-type-disabled') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-inventory-type')
        )
        self.new_character_wealth_info = TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-new-char-wealth-disabled') + '\n'
        )
        self.approval_queue_info = TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-approval-queue-disabled') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-approval-queue')
        )
        self.inventory_type_select = selects.InventoryTypeSelect(self)
        self.approval_queue_select = selects.SingleChannelConfigSelect(
            self, ConfigFields.APPROVAL_QUEUE_CHANNEL, 'Approval Queue'
        )
        self.approval_queue_clear_button = buttons.ClearChannelButton(self, ConfigFields.APPROVAL_QUEUE_CHANNEL)

        self.new_character_wealth = None
        self.currency_config = {}
        self.new_character_shop_button = MenuViewButton(ConfigNewCharacterShopView, t(DEFAULT_LOCALE, 'config-btn-configure-new-character-shop'))
        self.new_character_wealth_button = buttons.ConfigNewCharacterWealthButton(self)
        self.static_kits_button = MenuViewButton(ConfigStaticKitsView, t(DEFAULT_LOCALE, 'config-btn-configure-static-kits'))

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigPlayersView))
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-new-character')))
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
                collection_name=DatabaseCollections.INVENTORY_CONFIG,
                query={CommonFields.ID: guild.id}
            )
            inventory_type = inventory_config.get(ConfigFields.INVENTORY_TYPE, 'disabled') if inventory_config else 'disabled'
            new_character_wealth = inventory_config.get(ConfigFields.NEW_CHARACTER_WEALTH, None) if inventory_config else None
            self.new_character_wealth = new_character_wealth

            type_description = {
                'disabled': t(DEFAULT_LOCALE, 'config-desc-inv-type-disabled'),
                'selection': t(DEFAULT_LOCALE, 'config-desc-inv-type-selection'),
                'purchase': t(DEFAULT_LOCALE, 'config-desc-inv-type-purchase'),
                'open': t(DEFAULT_LOCALE, 'config-desc-inv-type-open'),
                'static': t(DEFAULT_LOCALE, 'config-desc-inv-type-static')
            }

            self.inventory_type_info.content = (
                t(DEFAULT_LOCALE, 'config-label-inventory-type', **{'type': inventory_type.capitalize()}) + '\n' +
                type_description.get(inventory_type, '')
            )

            # New character Shop section
            currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: guild.id}
            )
            self.currency_config = currency_config

            self.new_character_shop_button.disabled = True
            self.new_character_shop_button.label = t(DEFAULT_LOCALE, 'config-btn-configure-new-character-shop')
            self.new_character_wealth_button.disabled = True
            self.new_character_wealth_button.label = t(DEFAULT_LOCALE, 'config-btn-configure-new-character-wealth')
            self.static_kits_button.disabled = True

            if inventory_type == 'selection':
                self.new_character_shop_button.disabled = False
                if currency_config:
                    self.new_character_wealth_button.disabled = False
                else:
                    self.new_character_wealth_button.label = t(DEFAULT_LOCALE, 'config-btn-disabled-no-currency')

            if inventory_type == 'purchase':
                if not currency_config:
                    self.new_character_shop_button.label = t(DEFAULT_LOCALE, 'config-btn-disabled-no-currency')
                    self.new_character_wealth_button.label = t(DEFAULT_LOCALE, 'config-btn-disabled-no-currency')
                else:
                    self.new_character_wealth_button.disabled = False
                    if not new_character_wealth:
                        self.new_character_shop_button.label = t(DEFAULT_LOCALE, 'config-btn-disabled-no-wealth')
                    else:
                        self.new_character_shop_button.disabled = False

            if inventory_type == 'static':
                self.static_kits_button.disabled = False

            if new_character_wealth:
                amount = new_character_wealth.get(CommonFields.AMOUNT, 0)
                currency_name = new_character_wealth.get('currency', '')

                formatted_wealth = format_price_string(amount, currency_name, currency_config)

                self.new_character_wealth_info.content = (
                    t(DEFAULT_LOCALE, 'config-label-new-char-wealth', **{'wealth': formatted_wealth})
                )
            else:
                self.new_character_wealth_info.content = (
                    t(DEFAULT_LOCALE, 'config-label-new-char-wealth-disabled')
                )

            # Approval Queue section
            approval_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.APPROVAL_QUEUE_CHANNEL,
                query={CommonFields.ID: guild.id}
            )
            if approval_query and approval_query.get(ConfigFields.APPROVAL_QUEUE_CHANNEL):
                approval_channel = approval_query[ConfigFields.APPROVAL_QUEUE_CHANNEL]
                self.approval_queue_info.content = (
                    t(DEFAULT_LOCALE, 'config-label-approval-queue', **{'channel': approval_channel}) + '\n' +
                    t(DEFAULT_LOCALE, 'config-desc-approval-queue')
                )
            else:
                self.approval_queue_info.content = (
                    t(DEFAULT_LOCALE, 'config-label-approval-queue-not-configured') + '\n' +
                    t(DEFAULT_LOCALE, 'config-desc-approval-queue')
                )

            self.build_view()
        except Exception as e:
            await log_exception(e)


class ConfigNewCharacterShopView(LocaleLayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.all_stock = []
        self.items_per_page = 6
        self.current_page = 0
        self.total_pages = 1
        self.mode_description = ''
        self.currency_config = {}
        self.inventory_type = ''

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigNewCharacterView))
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-new-char-shop')))
        container.add_item(header_section)
        container.add_item(Separator())

        container.add_item(TextDisplay(self.mode_description or t(DEFAULT_LOCALE, 'config-msg-define-shop-items')))

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
            container.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-msg-no-items')))
        else:
            for item in current_stock:
                item_name = escape_markdown(item.get(CommonFields.NAME))
                item_description = item.get('description')
                item_quantity = item.get(CommonFields.QUANTITY, 1)

                costs = item.get(ShopFields.COSTS, [])
                cost_string = format_complex_cost(costs, getattr(self, 'currency_config', {}))

                display_string = f'**{item_name}** (x{item_quantity})'
                if cost_string:
                    display_string += f' - {cost_string}'

                if item_description:
                    display_string += f"\n*{escape_markdown(item_description)}*"

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
                label=t(DEFAULT_LOCALE, 'common-btn-previous'),
                style=ButtonStyle.secondary,
                custom_id='ss_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_button = Button(
                label=t(DEFAULT_LOCALE, 'common-page-label', **{'current': str(self.current_page + 1), 'total': str(self.total_pages)}),
                style=ButtonStyle.secondary,
                disabled=True
            )
            nav_row.add_item(page_button)

            next_button = Button(
                label=t(DEFAULT_LOCALE, 'common-btn-next'),
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
                collection_name=DatabaseCollections.INVENTORY_CONFIG,
                query={CommonFields.ID: guild.id}
            )
            self.inventory_type = inventory_config.get(ConfigFields.INVENTORY_TYPE, 'disabled') if inventory_config else 'disabled'

            if self.inventory_type == 'selection':
                self.mode_description = (
                    t(DEFAULT_LOCALE, 'config-label-inv-type-selection') + '\n' +
                    t(DEFAULT_LOCALE, 'config-desc-inv-type-selection-shop')
                )
            elif self.inventory_type == 'purchase':
                self.mode_description = (
                    t(DEFAULT_LOCALE, 'config-label-inv-type-purchase') + '\n' +
                    t(DEFAULT_LOCALE, 'config-desc-inv-type-purchase-shop')
                )
            else:
                self.mode_description = (
                    t(DEFAULT_LOCALE, 'config-label-inv-type-other', **{'type': titlecase(self.inventory_type)}) + '\n' +
                    t(DEFAULT_LOCALE, 'config-desc-inv-type-not-in-use')
                )

            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.NEW_CHARACTER_SHOP,
                query={CommonFields.ID: guild.id}
            )
            if query and ShopFields.SHOP_STOCK in query:
                self.update_stock(query[ShopFields.SHOP_STOCK])
            else:
                self.update_stock([])

            self.currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: guild.id}
            )

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


class ConfigStaticKitsView(LocaleLayoutView):
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
                collection_name=DatabaseCollections.STATIC_KITS,
                query={CommonFields.ID: guild.id}
            )
            self.kits = query.get('kits', {}) if query else {}

            self.sorted_kits = sorted(self.kits.items(), key=lambda x: x[1].get(CommonFields.NAME, '').lower())

            self.total_pages = math.ceil(len(self.sorted_kits) / self.items_per_page)
            if self.total_pages == 0:
                self.total_pages = 1

            if self.current_page >= self.total_pages:
                self.current_page = max(0, self.total_pages - 1)

            self.currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: guild.id}
            )

            self.build_view()
        except Exception as e:
            await log_exception(e)

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigNewCharacterView))
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-static-kits')))
        container.add_item(header_section)
        container.add_item(Separator())

        add_section = Section(accessory=buttons.AddStaticKitButton(self))
        add_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-desc-create-kit')))
        container.add_item(add_section)
        container.add_item(Separator())

        if not self.sorted_kits:
            container.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-msg-no-kits')))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = self.sorted_kits[start:end]

            for kit_id, kit_data in page_items:
                kit_name = kit_data.get(CommonFields.NAME, 'Unknown')
                description = kit_data.get('description', '')

                info_text = f"**{titlecase(kit_name)}**"
                if description:
                    info_text += f"\n*{description}*"

                items = kit_data.get(CommonFields.ITEMS, [])
                currency = kit_data.get('currency', {})
                contents = []

                for item in items[:3]:
                    contents.append(f"{item.get(CommonFields.QUANTITY, 1)}x {escape_markdown(titlecase(item.get(CommonFields.NAME, '')))}")
                if len(items) > 3:
                    contents.append(t(DEFAULT_LOCALE, 'config-label-kit-more-items', **{'count': str(len(items) - 3)}))

                if currency:
                    contents.extend(format_consolidated_totals(currency, self.currency_config))

                if contents:
                    info_text += f"\n> {', '.join(contents)}"
                else:
                    info_text += '\n> ' + t(DEFAULT_LOCALE, 'config-label-empty-kit')

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
                label=t(DEFAULT_LOCALE, 'common-btn-previous'),
                style=ButtonStyle.secondary,
                custom_id='kit_conf_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_display = Button(
                label=t(DEFAULT_LOCALE, 'common-page-label', **{'current': str(self.current_page + 1), 'total': str(self.total_pages)}),
                style=ButtonStyle.secondary,
                custom_id='kit_conf_page_disp'
            )
            page_display.callback = self.show_page_jump_modal
            nav_row.add_item(page_display)

            next_button = Button(
                label=t(DEFAULT_LOCALE, 'common-btn-next'),
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


class EditStaticKitView(LocaleLayoutView):
    def __init__(self, kit_id, kit_data, currency_config):
        super().__init__(timeout=None)
        self.kit_id = kit_id
        self.kit_data = kit_data
        self.currency_config = currency_config
        self.items_per_page = 6
        self.current_page = 0
        self.total_pages = 0

        self.items = self.kit_data.get(CommonFields.ITEMS, [])

        self.build_view()

    def build_view(self):
        self.clear_items()

        self.items = self.kit_data.get(CommonFields.ITEMS, [])
        currencies = self.kit_data.get('currency', {})

        combined_list = []

        for encoded_currency_key, amount in currencies.items():
            # Decode the key for display; original name is needed for lookups and formatting
            decoded_name = decode_mongo_key(encoded_currency_key)
            combined_list.append({'type': 'currency', 'name': decoded_name, 'amount': amount})

        for index, item in enumerate(self.items):
            combined_list.append({'type': 'item', 'index': index, 'data': item})

        self.total_pages = math.ceil(len(combined_list) / self.items_per_page)
        if self.total_pages == 0:
            self.total_pages = 1

        if self.current_page >= self.total_pages and self.current_page > 0:
            self.current_page = max(0, self.total_pages - 1)

        container = Container()

        header_section = Section(accessory=BackButton(ConfigStaticKitsView))
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-editing-kit', **{'kitName': titlecase(self.kit_data[CommonFields.NAME])})))
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
            container.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-msg-kit-empty')))
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
                    currency_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-label-kit-currency', **{'display': display})))
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

                    display = t(DEFAULT_LOCALE, 'config-label-kit-item', **{'name': escape_markdown(titlecase(item_data[CommonFields.NAME]))})
                    if item_data[CommonFields.QUANTITY] > 1:
                        display += f' (x{item_data[CommonFields.QUANTITY]})'
                    if item_data.get('description'):
                        display += f'\n*{escape_markdown(item_data["description"])}*'

                    container.add_item(TextDisplay(display))
                    container.add_item(item_actions)

            # Pagination Controls
            if self.total_pages > 1:
                nav_row = ActionRow()
                prev_button = Button(
                    label=t(DEFAULT_LOCALE, 'common-btn-previous'),
                    style=ButtonStyle.secondary,
                    custom_id='kit_prev',
                    disabled=(self.current_page == 0)
                )
                prev_button.callback = self.prev_page
                nav_row.add_item(prev_button)

                page_button = Button(
                    label=t(DEFAULT_LOCALE, 'common-page-label', **{'current': str(self.current_page + 1), 'total': str(self.total_pages)}),
                    style=ButtonStyle.secondary
                )
                page_button.callback = self.show_page_jump_modal
                nav_row.add_item(page_button)

                next_button = Button(
                    label=t(DEFAULT_LOCALE, 'common-btn-next'),
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
            await interaction.response.send_message(t(DEFAULT_LOCALE, 'common-error-page-selector'), ephemeral=True)


# ------ CURRENCY ------


class ConfigCurrencyView(LocaleLayoutView):
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
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: guild.id}
            )

            self.currencies = query.get(CurrencyFields.CURRENCIES, []) if query else []
            self.currencies.sort(key=lambda x: x.get(CommonFields.NAME, '').lower())

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
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-currency')))
        container.add_item(header_section)
        container.add_item(Separator())

        add_currency_section = Section(accessory=buttons.AddCurrencyButton(self))
        add_currency_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-desc-create-currency')))
        container.add_item(add_currency_section)
        container.add_item(Separator())

        if not self.currencies:
            container.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-msg-no-currencies')))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = self.currencies[start:end]

            for currency in page_items:
                currency_name = currency.get(CommonFields.NAME, 'Unknown')
                is_double = currency.get(CurrencyFields.IS_DOUBLE, False)
                denominations = currency.get(CurrencyFields.DENOMINATIONS, [])

                currency_type = t(DEFAULT_LOCALE, 'config-label-currency-type-double') if is_double else t(DEFAULT_LOCALE, 'config-label-currency-type-integer')
                denomination_count = len(denominations)

                info = (f'**{titlecase(currency_name)}**\n' +
                        t(DEFAULT_LOCALE, 'config-label-currency-display-type', **{'type': currency_type, 'count': str(denomination_count)}))

                section = Section(accessory=buttons.ManageCurrencyButton(currency_name))
                section.add_item(TextDisplay(info))
                container.add_item(section)

        self.add_item(container)

        # Pagination
        if self.total_pages > 1:
            nav_row = ActionRow()
            prev_button = Button(
                label=t(DEFAULT_LOCALE, 'common-btn-previous'),
                style=discord.ButtonStyle.secondary,
                custom_id='curr_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_display = Button(
                label=t(DEFAULT_LOCALE, 'common-page-label', **{'current': str(self.current_page + 1), 'total': str(self.total_pages)}),
                style=discord.ButtonStyle.secondary,
                custom_id='curr_page_disp'
            )
            page_display.callback = self.show_page_jump_modal
            nav_row.add_item(page_display)

            next_button = Button(
                label=t(DEFAULT_LOCALE, 'common-btn-next'),
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


class ConfigEditCurrencyView(LocaleLayoutView):
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
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: guild.id}
            )

            if query:
                self.currency_data = next((c for c in query.get(CurrencyFields.CURRENCIES, [])
                                           if c[CommonFields.NAME] == self.currency_name), {})

            self.denominations = self.currency_data.get(CurrencyFields.DENOMINATIONS, [])
            # Sort denominations by value descending
            self.denominations.sort(key=lambda x: x.get(CurrencyFields.VALUE, 0), reverse=True)

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
        display_type = t(DEFAULT_LOCALE, 'config-label-currency-type-double') if self.currency_data.get(CurrencyFields.IS_DOUBLE) else t(DEFAULT_LOCALE, 'config-label-currency-type-integer')

        header_section = Section(accessory=BackButton(ConfigCurrencyView))
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-manage-currency', **{'currencyName': titlecase(self.currency_name)})))
        container.add_item(header_section)
        container.add_item(Separator())

        info_text = t(DEFAULT_LOCALE, 'config-desc-currency-info')
        container.add_item(TextDisplay(info_text))
        container.add_item(Separator())

        actions = ActionRow()
        toggle_double_button = buttons.ToggleDoubleButton(self)
        toggle_double_button.label = t(DEFAULT_LOCALE, 'config-btn-toggle-display-current', **{'type': display_type})
        actions.add_item(toggle_double_button)
        actions.add_item(buttons.AddDenominationButton(self))
        actions.add_item(buttons.RenameCurrencyButton(self, self.currency_name))
        actions.add_item(buttons.RemoveCurrencyButton(self, self.currency_name))
        container.add_item(actions)
        container.add_item(Separator())

        if not self.denominations:
            container.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-msg-no-denominations')))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = self.denominations[start:end]

            for denomination in page_items:
                denomination_name = denomination.get(CommonFields.NAME, 'Unknown')
                denomination_value = denomination.get(CurrencyFields.VALUE, 0)

                info = f"**{titlecase(denomination_name)}** (Value: {denomination_value})"
                container.add_item(TextDisplay(info))

                denom_actions = ActionRow()
                denom_actions.add_item(buttons.RenameDenominationButton(self, denomination_name))
                denom_actions.add_item(buttons.RemoveDenominationButton(self, denomination_name))
                container.add_item(denom_actions)

        self.add_item(container)

        if self.total_pages > 1:
            nav_row = ActionRow()
            prev_button = Button(
                label=t(DEFAULT_LOCALE, 'common-btn-previous'),
                style=discord.ButtonStyle.secondary,
                custom_id='denom_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_display = Button(
                label=t(DEFAULT_LOCALE, 'common-page-label', **{'current': str(self.current_page + 1), 'total': str(self.total_pages)}),
                style=discord.ButtonStyle.secondary,
                custom_id='denom_page_disp'
            )
            page_display.callback = self.show_page_jump_modal
            nav_row.add_item(page_display)

            next_button = Button(
                label=t(DEFAULT_LOCALE, 'common-btn-next'),
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


class ConfigShopsView(LocaleLayoutView):
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
                collection_name=DatabaseCollections.SHOPS,
                query={CommonFields.ID: guild.id}
            )

            unsorted_shops = []
            if query and query.get(ShopFields.SHOP_CHANNELS):
                for channel_id, shop_data in query[ShopFields.SHOP_CHANNELS].items():
                    unsorted_shops.append({
                        'id': channel_id,
                        'data': shop_data
                    })

            self.shops = sorted(unsorted_shops, key=lambda x: x['data'].get(ShopFields.SHOP_NAME, '').lower())

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
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-shops')))
        container.add_item(header_section)
        container.add_item(Separator())

        add_shop_wizard_section = Section(accessory=buttons.AddShopWizardButton(self))
        add_shop_wizard_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-desc-add-shop-wizard')))
        container.add_item(add_shop_wizard_section)

        add_shop_json_section = Section(accessory=AddShopJSONButton(self))
        add_shop_json_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-desc-add-shop-json')))
        container.add_item(add_shop_json_section)
        container.add_item(Separator())

        if not self.shops:
            container.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-msg-no-shops')))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = self.shops[start:end]

            for shop in page_items:
                shop_name = shop['data'].get(ShopFields.SHOP_NAME, 'Unknown Shop')
                channel_id = shop['id']
                channel_type = shop['data'].get(ShopFields.CHANNEL_TYPE, 'text')
                type_indicator = ' ' + t(DEFAULT_LOCALE, 'config-label-shop-type-forum') if channel_type == ShopChannelType.FORUM_THREAD.value else ''

                info = f"**{shop_name}**{type_indicator}\n" + t(DEFAULT_LOCALE, 'config-label-shop-channel', **{'channelId': channel_id})

                section = Section(accessory=buttons.ManageShopNavButton(channel_id, shop['data'], t(DEFAULT_LOCALE, 'common-btn-manage')))
                section.add_item(TextDisplay(info))
                container.add_item(section)

        self.add_item(container)

        if self.total_pages > 1:
            nav_row = ActionRow()
            prev_button = Button(
                label=t(DEFAULT_LOCALE, 'common-btn-previous'),
                style=ButtonStyle.secondary,
                custom_id='conf_shop_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_display = Button(
                label=t(DEFAULT_LOCALE, 'common-page-label', **{'current': str(self.current_page + 1), 'total': str(self.total_pages)}),
                style=discord.ButtonStyle.secondary,
                custom_id='conf_shop_page'
            )
            page_display.callback = self.show_page_jump_modal
            nav_row.add_item(page_display)

            next_button = Button(
                label=t(DEFAULT_LOCALE, 'common-btn-next'),
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


class ShopChannelTypeSelectionView(LocaleLayoutView):
    """Allows user to choose between text channel or forum thread for a new shop."""
    def __init__(self):
        super().__init__(timeout=None)

    async def setup(self):
        self.build_view()

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigShopsView))
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-choose-location')))
        container.add_item(header_section)
        container.add_item(Separator())

        text_section = Section(accessory=buttons.TextChannelShopButton(self))
        text_section.add_item(TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-text-channel') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-text-channel')
        ))
        container.add_item(text_section)

        forum_section = Section(accessory=buttons.ForumThreadShopButton(self))
        forum_section.add_item(TextDisplay(
            t(DEFAULT_LOCALE, 'config-label-forum-thread') + '\n' +
            t(DEFAULT_LOCALE, 'config-desc-forum-thread')
        ))
        container.add_item(forum_section)

        self.add_item(container)


class ForumShopSetupView(LocaleLayoutView):
    """Allows user to configure a forum thread shop - new or existing thread."""
    def __init__(self):
        super().__init__(timeout=None)
        self.selected_forum = None
        self.create_new_thread = True  # Default to creating new thread
        self.selected_thread = None
        self.forum_threads = []

    async def setup(self):
        """Populate available forums."""
        self.build_view()

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ShopChannelTypeSelectionView))
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-forum-setup')))
        container.add_item(header_section)
        container.add_item(Separator())

        # Forum selection
        container.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-label-step1')))
        forum_select_row = ActionRow()
        forum_select_row.add_item(selects.ForumChannelSelect(self))
        container.add_item(forum_select_row)
        container.add_item(Separator())

        if self.selected_forum:
            # Thread creation mode selection
            container.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-label-step2')))

            new_thread_row = ActionRow()
            new_thread_btn = Button(
                label=t(DEFAULT_LOCALE, 'config-btn-create-new-thread'),
                style=ButtonStyle.primary if self.create_new_thread else ButtonStyle.secondary,
                custom_id='forum_new_thread_toggle'
            )
            new_thread_btn.callback = self._toggle_new_thread
            new_thread_row.add_item(new_thread_btn)

            existing_thread_btn = Button(
                label=t(DEFAULT_LOCALE, 'config-btn-use-existing-thread'),
                style=ButtonStyle.primary if not self.create_new_thread else ButtonStyle.secondary,
                custom_id='forum_existing_thread_toggle'
            )
            existing_thread_btn.callback = self._toggle_existing_thread
            new_thread_row.add_item(existing_thread_btn)
            container.add_item(new_thread_row)
            container.add_item(Separator())

            if self.create_new_thread:
                # Show button to proceed with new thread creation
                proceed_section = Section(accessory=buttons.CreateNewForumThreadButton(self))
                proceed_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-desc-create-new-thread')))
                container.add_item(proceed_section)
            else:
                # Show thread select for existing threads
                container.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-label-step3')))
                thread_select_row = ActionRow()
                thread_select_row.add_item(selects.ForumThreadSelect(self))
                container.add_item(thread_select_row)

                if self.selected_thread:
                    proceed_section = Section(accessory=buttons.UseExistingThreadButton(self))
                    proceed_section.add_item(TextDisplay(
                        t(DEFAULT_LOCALE, 'config-label-selected-thread', **{'threadName': self.selected_thread.name}) + '\n' +
                        t(DEFAULT_LOCALE, 'config-desc-click-to-configure')
                    ))
                    container.add_item(proceed_section)

        self.add_item(container)

    async def _toggle_new_thread(self, interaction: discord.Interaction):
        self.create_new_thread = True
        self.selected_thread = None
        self.build_view()
        await interaction.response.edit_message(view=self)

    async def _toggle_existing_thread(self, interaction: discord.Interaction):
        self.create_new_thread = False
        self.build_view()
        await interaction.response.edit_message(view=self)


class ManageShopView(LocaleLayoutView):
    def __init__(self, channel_id, shop_data):
        super().__init__(timeout=None)
        self.selected_channel_id = channel_id
        self.shop_data = shop_data

        self.build_view()

    def build_view(self):
        self.clear_items()
        container = Container()

        shop_name = self.shop_data.get(ShopFields.SHOP_NAME, 'Unknown')

        header_section = Section(accessory=BackButton(ConfigShopsView))
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-manage-shop', **{'shopName': shop_name})))
        container.add_item(header_section)
        container.add_item(Separator())

        shop_keeper = self.shop_data.get(ShopFields.SHOP_KEEPER, t(DEFAULT_LOCALE, 'common-label-none'))
        shop_description = self.shop_data.get(ShopFields.SHOP_DESCRIPTION, t(DEFAULT_LOCALE, 'common-label-none'))
        channel_type = self.shop_data.get(ShopFields.CHANNEL_TYPE, 'text')
        channel_type_display = t(DEFAULT_LOCALE, 'config-label-shop-type-forum-thread') if channel_type == ShopChannelType.FORUM_THREAD.value else t(DEFAULT_LOCALE, 'config-label-shop-type-text')

        info_text = (
            t(DEFAULT_LOCALE, 'config-label-shop-channel-info', **{'channelId': self.selected_channel_id}) + '\n' +
            t(DEFAULT_LOCALE, 'config-label-shop-type', **{'type': channel_type_display}) + '\n' +
            t(DEFAULT_LOCALE, 'config-label-shopkeeper', **{'name': shop_keeper}) + '\n' +
            t(DEFAULT_LOCALE, 'config-label-shop-description', **{'description': shop_description})
        )
        container.add_item(TextDisplay(info_text))
        container.add_item(Separator())

        wizard_section = Section(accessory=buttons.EditShopButton(self))
        wizard_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-desc-edit-wizard')))
        container.add_item(wizard_section)

        json_section = Section(accessory=buttons.UpdateShopJSONButton(self))
        json_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-desc-upload-json')))
        container.add_item(json_section)

        download_section = Section(accessory=buttons.DownloadShopJSONButton(self))
        download_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-desc-download-json')))
        container.add_item(download_section)
        container.add_item(Separator())

        remove_section = Section(accessory=buttons.RemoveShopButton(self))
        remove_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-desc-remove-shop')))
        container.add_item(remove_section)

        self.add_item(container)

    def update_details(self, new_data):
        self.shop_data = new_data


class EditShopView(LocaleLayoutView):
    def __init__(self, channel_id: str, shop_data: dict):
        super().__init__(timeout=None)
        self.channel_id = channel_id
        self.shop_data = shop_data
        self.all_stock = self.shop_data.get(ShopFields.SHOP_STOCK, [])

        self.items_per_page = 6
        self.current_page = 0
        self.total_pages = math.ceil(len(self.all_stock) / self.items_per_page)
        self.done_editing_button = buttons.ManageShopNavButton(
            self.channel_id,
            self.shop_data,
            t(DEFAULT_LOCALE, 'config-btn-done-editing'),
            ButtonStyle.secondary
        )
        self.currency_config = {}

    async def setup(self, bot, guild):
        try:
            self.currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: guild.id}
            )

            self.build_view()
        except Exception as e:
            await log_exception(e)

    def build_view(self):
        self.clear_items()
        container = Container()
        header_items = [TextDisplay(t(DEFAULT_LOCALE, 'config-title-editing-shop', **{'shopName': self.shop_data.get(ShopFields.SHOP_NAME)}))]

        if shop_keeper := self.shop_data.get(ShopFields.SHOP_KEEPER):
            header_items.append(TextDisplay(t(DEFAULT_LOCALE, 'config-label-shop-shopkeeper', **{'name': shop_keeper})))
        if shop_description := self.shop_data.get(ShopFields.SHOP_DESCRIPTION):
            header_items.append(TextDisplay(f'*{shop_description}*'))

        if shop_image := self.shop_data.get(ShopFields.SHOP_IMAGE):
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
        header_buttons.add_item(buttons.ConfigStockLimitsButton(self))
        container.add_item(header_buttons)
        container.add_item(Separator())

        start_index = self.current_page * self.items_per_page
        end_index = start_index + self.items_per_page
        current_stock = self.all_stock[start_index:end_index]

        for item in current_stock:
            item_name = escape_markdown(item.get(CommonFields.NAME))
            item_description = item.get('description', None)
            item_quantity = item.get(CommonFields.QUANTITY, 1)

            costs = item.get(ShopFields.COSTS, [])
            cost_string = format_complex_cost(costs, getattr(self, 'currency_config', {}))

            if item_quantity > 1:
                item_text = f'{item_name} x{item_quantity}'
            else:
                item_text = item_name

            display_string = f'**{item_text}** - {cost_string}'

            if item_description:
                display_string += f'\n*{escape_markdown(item_description)}*'

            container.add_item(TextDisplay(display_string))

            item_buttons = ActionRow()
            item_buttons.add_item(buttons.EditShopItemButton(item, self))
            item_buttons.add_item(buttons.DeleteShopItemButton(item, self))

            container.add_item(item_buttons)

        self.add_item(container)

        if self.total_pages > 1:
            pagination_row = ActionRow()

            prev_button = Button(
                label=t(DEFAULT_LOCALE, 'common-btn-previous'),
                style=ButtonStyle.secondary,
                custom_id='shop_edit_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page

            page_display = Button(
                label=t(DEFAULT_LOCALE, 'common-page-display', **{'current': str(self.current_page + 1), 'total': str(self.total_pages)}),
                style=ButtonStyle.secondary,
                custom_id='shop_edit_page'
            )
            page_display.callback = self.show_page_jump_modal

            next_button = Button(
                label=t(DEFAULT_LOCALE, 'common-btn-next'),
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
            await interaction.response.send_message(t(DEFAULT_LOCALE, 'common-error-page-selector'), ephemeral=True)

    def update_stock(self, new_stock: list):
        self.all_stock = new_stock
        self.shop_data[ShopFields.SHOP_STOCK] = new_stock

        self.total_pages = math.ceil(len(self.all_stock) / self.items_per_page)
        if self.current_page >= self.total_pages:
            self.current_page = max(0, self.total_pages - 1)

    def update_details(self, new_shop_data: dict):
        new_shop_data[ShopFields.SHOP_STOCK] = self.all_stock
        self.shop_data = new_shop_data


class ConfigStockLimitsView(LocaleLayoutView):
    def __init__(self, channel_id: str, shop_data: dict):
        super().__init__(timeout=None)
        self.channel_id = channel_id
        self.shop_data = shop_data
        self.all_stock = self.shop_data.get(ShopFields.SHOP_STOCK, [])
        self.stock_info = {}

        self.items_per_page = 6
        self.current_page = 0
        self.total_pages = max(1, math.ceil(len(self.all_stock) / self.items_per_page))

    async def setup(self, bot, guild):
        try:
            # Refresh shop data from database
            shop_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={CommonFields.ID: guild.id}
            )
            if shop_query:
                self.shop_data = shop_query.get(ShopFields.SHOP_CHANNELS, {}).get(self.channel_id, self.shop_data)
                self.all_stock = self.shop_data.get(ShopFields.SHOP_STOCK, [])

            # Get runtime stock info
            self.stock_info = await get_shop_stock(bot, guild.id, self.channel_id)

            self.total_pages = max(1, math.ceil(len(self.all_stock) / self.items_per_page))
            if self.current_page >= self.total_pages:
                self.current_page = max(0, self.total_pages - 1)

            self.build_view()
        except Exception as e:
            await log_exception(e)

    def build_view(self):
        self.clear_items()
        container = Container()

        # Header
        shop_name = self.shop_data.get(ShopFields.SHOP_NAME, 'Unknown Shop')
        header_section = Section(accessory=buttons.BackToEditShopButton(self.channel_id, self.shop_data))
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-stock-config', **{'shopName': shop_name})))
        container.add_item(header_section)
        container.add_item(Separator())

        # Current UTC time display
        now = datetime.now(timezone.utc)
        utc_time_str = now.strftime('%Y-%m-%d %H:%M UTC')
        container.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-label-current-utc', **{'time': utc_time_str})))
        container.add_item(Separator())

        # Restock schedule section
        restock_config = self.shop_data.get(ShopFields.RESTOCK_CONFIG, {})
        if restock_config.get(RestockFields.ENABLED):
            schedule = restock_config.get(RestockFields.SCHEDULE, 'none')
            hour = restock_config.get(RestockFields.HOUR, 0)
            minute = restock_config.get(RestockFields.MINUTE, 0)
            day_of_week = restock_config.get(RestockFields.DAY_OF_WEEK, 0)
            mode = restock_config.get(RestockFields.MODE, RestockMode.FULL.value)
            increment = restock_config.get(RestockFields.INCREMENT_AMOUNT, 1)

            day_name_keys = ['common-day-monday', 'common-day-tuesday', 'common-day-wednesday', 'common-day-thursday', 'common-day-friday', 'common-day-saturday', 'common-day-sunday']
            day_name = t(DEFAULT_LOCALE, day_name_keys[day_of_week]) if 0 <= day_of_week <= 6 else t(DEFAULT_LOCALE, 'common-label-unknown')

            schedule_text = t(DEFAULT_LOCALE, 'config-label-restock-schedule', **{'schedule': schedule.capitalize()})
            if schedule == ScheduleType.HOURLY.value:
                schedule_text += ' ' + t(DEFAULT_LOCALE, 'config-label-restock-hourly', **{'minute': f'{minute:02d}'})
            elif schedule == ScheduleType.DAILY.value:
                schedule_text += ' ' + t(DEFAULT_LOCALE, 'config-label-restock-daily', **{'time': f'{hour:02d}:{minute:02d}'})
            elif schedule == ScheduleType.WEEKLY.value:
                schedule_text += ' ' + t(DEFAULT_LOCALE, 'config-label-restock-weekly', **{'day': day_name, 'time': f'{hour:02d}:{minute:02d}'})

            mode_text = t(DEFAULT_LOCALE, 'config-label-restock-full') if mode == RestockMode.FULL.value else t(DEFAULT_LOCALE, 'config-label-restock-incremental', **{'amount': str(increment)})
            schedule_text += '\n' + t(DEFAULT_LOCALE, 'config-label-restock-mode', **{'mode': mode_text})
        else:
            schedule_text = t(DEFAULT_LOCALE, 'config-label-restock-disabled')

        schedule_section = Section(accessory=buttons.RestockScheduleButton(self))
        schedule_section.add_item(TextDisplay(schedule_text))
        container.add_item(schedule_section)
        container.add_item(Separator())

        # Item stock limits section
        container.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-label-item-stock-limits')))

        if not self.all_stock:
            container.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-msg-no-items-in-shop')))
        else:
            start_index = self.current_page * self.items_per_page
            end_index = start_index + self.items_per_page
            page_items = self.all_stock[start_index:end_index]

            for item in page_items:
                item_name = item.get(CommonFields.NAME, 'Unknown')
                item_name_display = escape_markdown(item_name)
                max_stock = item.get(ShopFields.MAX_STOCK)

                # Get runtime stock info (only if data is valid with 'available' key)
                runtime_stock = self.stock_info.get(encode_mongo_key(item_name))
                current_available = None
                reserved = 0
                if runtime_stock and ShopFields.AVAILABLE in runtime_stock:
                    current_available = runtime_stock.get(ShopFields.AVAILABLE, 0)
                    reserved = runtime_stock.get(ShopFields.RESERVED, 0)

                if max_stock is not None:
                    if current_available is not None:
                        stock_text = f'**{item_name_display}**\n' + t(DEFAULT_LOCALE, 'config-label-stock-with-available', **{'max': str(max_stock), 'available': str(current_available)})
                        if reserved > 0:
                            stock_text += t(DEFAULT_LOCALE, 'config-label-stock-reserved', **{'reserved': str(reserved)})
                    else:
                        stock_text = f'**{item_name_display}**\n' + t(DEFAULT_LOCALE, 'config-label-stock-not-initialized', **{'max': str(max_stock)})

                    # Create button row with edit and remove buttons
                    item_row = ActionRow()
                    item_row.add_item(buttons.SetItemStockButton(item, self, current_available))
                    item_row.add_item(buttons.RemoveItemStockLimitButton(item, self))

                    container.add_item(TextDisplay(stock_text))
                    container.add_item(item_row)
                else:
                    stock_text = f'**{item_name_display}**\n' + t(DEFAULT_LOCALE, 'config-label-stock-unlimited')
                    item_section = Section(accessory=buttons.SetItemStockButton(item, self))
                    item_section.add_item(TextDisplay(stock_text))
                    container.add_item(item_section)

        self.add_item(container)

        # Pagination
        if self.total_pages > 1:
            nav_row = ActionRow()

            prev_button = Button(
                label=t(DEFAULT_LOCALE, 'common-btn-previous'),
                style=ButtonStyle.secondary,
                custom_id='stock_limits_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page

            page_display = Button(
                label=t(DEFAULT_LOCALE, 'common-page-display', **{'current': str(self.current_page + 1), 'total': str(self.total_pages)}),
                style=ButtonStyle.secondary,
                custom_id='stock_limits_page'
            )
            page_display.callback = self.show_page_jump_modal

            next_button = Button(
                label=t(DEFAULT_LOCALE, 'common-btn-next'),
                style=ButtonStyle.primary,
                custom_id='stock_limits_next',
                disabled=(self.current_page >= self.total_pages - 1)
            )
            next_button.callback = self.next_page

            nav_row.add_item(prev_button)
            nav_row.add_item(page_display)
            nav_row.add_item(next_button)
            self.add_item(nav_row)

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
            await log_exception(e, interaction)


class ConfigRoleplayView(LocaleLayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.config = {}
        self.currency_config = {}
        self.roleplay_toggle_button = buttons.RoleplayToggleEnableButton(self)
        self.channel_select = selects.RoleplayChannelSelect(self)
        self.rewards_button = buttons.RoleplayRewardsButton(self)

    async def setup(self, bot, guild):
        try:
            self.config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.ROLEPLAY_CONFIG,
                query={CommonFields.ID: guild.id}
            )
            if not self.config:
                self.config = {RoleplayFields.ENABLED: False, RoleplayFields.MODE: RoleplayMode.SCHEDULED.value}

            self.currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: guild.id}
            )

            self.build_view()
        except Exception as e:
            await log_exception(e)

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-roleplay')))
        container.add_item(header_section)
        container.add_item(Separator())

        # Status & Time
        enabled = self.config.get(RoleplayFields.ENABLED, False)
        mode = self.config.get(RoleplayFields.MODE, 'scheduled')

        now = datetime.now(timezone.utc)
        time_str = now.strftime('%H:%M UTC')

        status_display = t(DEFAULT_LOCALE, 'config-label-rp-enabled') if enabled else t(DEFAULT_LOCALE, 'config-label-rp-disabled')
        status_text = (
            t(DEFAULT_LOCALE, 'config-label-rp-status', **{'status': status_display}) + '\n' +
            t(DEFAULT_LOCALE, 'config-label-rp-server-time', **{'time': time_str})
        )

        status_section = Section(accessory=self.roleplay_toggle_button)
        self.roleplay_toggle_button.label = t(DEFAULT_LOCALE, 'common-btn-disable') if enabled else t(DEFAULT_LOCALE, 'common-btn-enable')
        self.roleplay_toggle_button.style = ButtonStyle.danger if enabled else ButtonStyle.success
        status_section.add_item(TextDisplay(status_text))
        container.add_item(status_section)
        container.add_item(Separator())

        # Mode Description
        if mode == 'scheduled':
            mode_description = t(DEFAULT_LOCALE, 'config-desc-rp-mode-scheduled')
        else:
            mode_description = t(DEFAULT_LOCALE, 'config-desc-rp-mode-accrued')

        # Settings
        settings_config = self.config.get(RoleplayFields.CONFIG, {})
        min_length = settings_config.get(RoleplayFields.MIN_LENGTH, 20)
        cooldown = settings_config.get(RoleplayFields.COOLDOWN, 30)
        setting_details = (
            t(DEFAULT_LOCALE, 'config-label-rp-config-details') + '\n\n' +
            t(DEFAULT_LOCALE, 'config-label-rp-mode', **{'mode': mode.capitalize()}) + '\n' +
            mode_description +
            t(DEFAULT_LOCALE, 'config-label-rp-min-length', **{'length': str(min_length)}) + '\n' +
            t(DEFAULT_LOCALE, 'config-label-rp-cooldown', **{'seconds': str(cooldown)}) + '\n'
        )

        if mode == 'scheduled':
            frequency = 'hour'
            frequency_config = settings_config.get(RoleplayFields.RESET_PERIOD, 'hourly')
            if frequency_config == 'daily':
                frequency = 'day'
            elif frequency_config == 'weekly':
                frequency = 'week'
            setting_details += t(DEFAULT_LOCALE, 'config-label-rp-frequency-once', **{'period': frequency}) + '\n'

            if frequency_config in ['daily', 'weekly']:
                reset_time = settings_config.get(RoleplayFields.RESET_TIME, 0)
                formatted_time = time(hour=reset_time, minute=0, tzinfo=timezone.utc).strftime('%H:%M')

                formatted_day = ''
                if frequency_config == 'weekly':
                    reset_day = settings_config.get(RoleplayFields.RESET_DAY, 'monday')
                    formatted_day = f'{reset_day.capitalize()}s at '

                setting_details += t(DEFAULT_LOCALE, 'config-label-rp-reset-time', **{'dayAndTime': f'{formatted_day}{formatted_time}'}) + '\n'

            message_threshold = settings_config.get(RoleplayFields.THRESHOLD, 20)

            setting_details += t(DEFAULT_LOCALE, 'config-label-rp-threshold', **{'count': str(message_threshold)})
        else:
            frequency = settings_config.get(RoleplayFields.FREQUENCY, 20)
            setting_details += t(DEFAULT_LOCALE, 'config-label-rp-frequency-every', **{'count': str(frequency)})

        settings_section = Section(accessory=buttons.RoleplaySettingsButton(self))
        settings_section.add_item(setting_details)
        container.add_item(settings_section)

        mode_select_row = ActionRow()
        mode_select_row.add_item(selects.RoleplayModeSelect(self))
        container.add_item(mode_select_row)

        if mode == 'scheduled':
            frequency_select_row = ActionRow()
            frequency_select_row.add_item(selects.RoleplayResetSelect(self))
            container.add_item(frequency_select_row)

        if mode == 'scheduled' and settings_config.get(RoleplayFields.RESET_PERIOD) in ['daily', 'weekly']:
            reset_time_action_row = ActionRow()
            reset_time_action_row.add_item(selects.RoleplayResetTimeSelect(self))
            container.add_item(reset_time_action_row)

        if mode == 'scheduled' and settings_config.get(RoleplayFields.RESET_PERIOD) == 'weekly':
            reset_day_action_row = ActionRow()
            reset_day_action_row.add_item(selects.RoleplayResetDaySelect(self))
            container.add_item(reset_day_action_row)

        container.add_item(Separator())

        # Channels
        channels = self.config.get(RoleplayFields.CHANNELS, [])
        if not channels:
            channel_lines = t(DEFAULT_LOCALE, 'config-msg-rp-no-channels')
        else:
            shown_channels = channels[:6]
            formatted_lines = [f'- <#{chan_id}>' for chan_id in shown_channels]
            remaining = len(channels) - len(shown_channels)
            if remaining > 0:
                formatted_lines.append(t(DEFAULT_LOCALE, 'config-label-rp-channels-more', **{'count': str(remaining)}))
            channel_lines = '\n'.join(formatted_lines)

        channel_text = t(DEFAULT_LOCALE, 'config-label-rp-channels') + '\n' + channel_lines

        channel_section = Section(accessory=buttons.RoleplayClearChannelsButton(self))
        channel_section.add_item(TextDisplay(channel_text))
        channel_select_row = ActionRow()
        channel_select_row.add_item(self.channel_select)
        container.add_item(channel_section)
        container.add_item(channel_select_row)
        container.add_item(Separator())

        # Rewards
        rewards_text = t(DEFAULT_LOCALE, 'config-label-rp-rewards') + '\n'
        rewards_data = self.config.get(RoleplayFields.REWARDS, {})
        if not rewards_data:
            rewards_text += t(DEFAULT_LOCALE, 'config-msg-rp-no-rewards')
        else:
            if xp := rewards_data.get(RoleplayFields.XP):
                rewards_text += t(DEFAULT_LOCALE, 'config-label-rp-experience', **{'xp': str(xp)}) + '\n'
            if items := rewards_data.get(RoleplayFields.ITEMS):
                item_lines = [f'- {escape_markdown(titlecase(name))}: {quantity}' for name, quantity in items.items()]
                rewards_text += t(DEFAULT_LOCALE, 'config-label-rp-items') + '\n' + '\n'.join(item_lines) + '\n'
            if currency := rewards_data.get(RoleplayFields.CURRENCY):
                consolidated = consolidate_currency_totals(currency, self.currency_config)
                currency_lines = format_consolidated_totals(consolidated, self.currency_config)
                formatted_lines = [f'- {line}' for line in currency_lines]
                rewards_text += t(DEFAULT_LOCALE, 'config-label-rp-currency') + '\n' + '\n'.join(formatted_lines) + '\n'

        reward_section = Section(accessory=self.rewards_button)
        reward_section.add_item(TextDisplay(rewards_text))
        container.add_item(reward_section)

        self.add_item(container)


# ------ LANGUAGE ------


class ConfigLanguageView(LocaleLayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.language_info = TextDisplay(t(DEFAULT_LOCALE, 'config-label-server-language-default'))
        self.language_select = selects.ConfigLanguageSelect(self)

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(ConfigBaseView))
        header_section.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-title-language')))

        container.add_item(header_section)
        container.add_item(Separator())
        container.add_item(self.language_info)

        language_select_row = ActionRow(self.language_select)
        container.add_item(language_select_row)

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            guild_locale_data = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.GUILD_LOCALE,
                query={CommonFields.ID: guild.id}
            )
            current_guild_locale = None
            if guild_locale_data and 'locale' in guild_locale_data:
                current_guild_locale = guild_locale_data['locale']

            if current_guild_locale:
                from ReQuest.ui.info.selects import LOCALE_LABELS
                language_name = t(DEFAULT_LOCALE, LOCALE_LABELS.get(current_guild_locale, current_guild_locale))
                self.language_info.content = t(DEFAULT_LOCALE, 'config-label-server-language',
                                               language=language_name)
            else:
                self.language_info.content = t(DEFAULT_LOCALE, 'config-label-server-language-default')

            self.language_select.populate(DEFAULT_LOCALE, current_guild_locale)
            self.build_view()
        except Exception as e:
            await log_exception(e)
