import logging
import math

import discord
from discord.ui import (
    ActionRow,
    Container,
    Section,
    Separator,
    TextDisplay,
    Button
)

from ReQuest.ui.common.views import LocaleLayoutView

from ReQuest.ui.admin import buttons
from ReQuest.ui.common import buttons as common_buttons
from ReQuest.ui.common import modals as common_modals
from ReQuest.ui.common.buttons import MenuDoneButton, MenuViewButton
from ReQuest.utilities.constants import DatabaseCollections
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
from ReQuest.utilities.supportFunctions import log_exception, get_cached_data

logger = logging.getLogger(__name__)


class AdminBaseView(LocaleLayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        locale = getattr(self, 'locale', DEFAULT_LOCALE)

        container = Container()

        header_section = Section(accessory=MenuDoneButton(locale=locale))
        header_section.add_item(TextDisplay(f'**{t(locale, "admin-title-main-menu")}**'))
        container.add_item(header_section)
        container.add_item(Separator())

        allow_list_section = Section(accessory=MenuViewButton(AdminAllowlistView, 'Allowlist'))
        allow_list_section.add_item(TextDisplay(t(locale, 'admin-desc-allowlist')))
        container.add_item(allow_list_section)

        cog_section = Section(accessory=MenuViewButton(AdminCogView, 'Cogs'))
        cog_section.add_item(TextDisplay(t(locale, 'admin-desc-cogs')))
        container.add_item(cog_section)

        print_guilds_section = Section(accessory=buttons.PrintGuildsButton(locale=locale))
        print_guilds_section.add_item(TextDisplay(t(locale, 'admin-desc-guild-list')))
        container.add_item(print_guilds_section)

        shutdown_section = Section(accessory=buttons.AdminShutdownButton(self, locale=locale))
        shutdown_section.add_item(TextDisplay(t(locale, 'admin-desc-shutdown')))
        container.add_item(shutdown_section)

        self.add_item(container)


class AdminAllowlistView(LocaleLayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.servers = []

        self.items_per_page = 9
        self.current_page = 0
        self.total_pages = 1

    async def setup(self, bot):
        try:
            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.cdb,
                collection_name=DatabaseCollections.SERVER_ALLOWLIST,
                query={'servers': {'$exists': True}},
                cache_id='admin_allowlist_servers'
            )

            self.servers = query.get('servers', []) if query else []
            self.servers.sort(key=lambda x: x.get('name', '').lower())

            self.total_pages = math.ceil(len(self.servers) / self.items_per_page)
            if self.total_pages == 0:
                self.total_pages = 1

            if self.current_page >= self.total_pages:
                self.current_page = max(0, self.total_pages - 1)

            self.build_view()
        except Exception as e:
            await log_exception(e)

    def build_view(self):
        self.clear_items()
        locale = getattr(self, 'locale', DEFAULT_LOCALE)
        container = Container()

        header_section = Section(accessory=common_buttons.BackButton(AdminBaseView, locale=locale))
        header_section.add_item(TextDisplay(f'**{t(locale, "admin-title-allowlist")}**'))
        container.add_item(header_section)
        container.add_item(Separator())

        add_server_section = Section(accessory=buttons.AllowlistAddServerButton(self, locale=locale))
        add_server_section.add_item(TextDisplay(t(locale, 'admin-desc-allowlist-warning')))
        container.add_item(add_server_section)
        container.add_item(Separator())

        if not self.servers:
            container.add_item(TextDisplay(t(locale, 'admin-msg-no-servers')))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = self.servers[start:end]

            for server in page_items:
                name = server.get('name', 'Unknown')
                server_id = server.get('id', 0)

                info = f"**{name}** (ID: `{server_id}`)"

                section = Section(accessory=buttons.RemoveServerButton(self, server_id, name, locale=locale))
                section.add_item(TextDisplay(info))
                container.add_item(section)

        self.add_item(container)

        if self.total_pages > 1:
            nav_row = ActionRow()

            prev_button = Button(
                label=t(locale, 'common-btn-previous'),
                style=discord.ButtonStyle.secondary,
                custom_id='allow_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_display = Button(
                label=t(locale, 'common-page-label', current=self.current_page + 1, total=self.total_pages),
                style=discord.ButtonStyle.secondary,
                custom_id='allow_page_disp'
            )
            page_display.callback = self.show_page_jump_modal
            nav_row.add_item(page_display)

            next_button = Button(
                label=t(locale, 'common-btn-next'),
                style=discord.ButtonStyle.secondary,
                custom_id='allow_next',
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


class AdminCogView(LocaleLayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.build_view()

    def build_view(self):
        locale = getattr(self, 'locale', DEFAULT_LOCALE)
        container = Container()

        header_section = Section(accessory=common_buttons.BackButton(AdminBaseView, locale=locale))
        header_section.add_item(TextDisplay(f'**{t(locale, "admin-title-cogs")}**'))
        container.add_item(header_section)
        container.add_item(Separator())

        load_cog_section = Section(accessory=buttons.AdminLoadCogButton(locale=locale))
        load_cog_section.add_item(TextDisplay(t(locale, 'admin-desc-load-cog')))
        container.add_item(load_cog_section)

        reload_cog_section = Section(accessory=buttons.AdminReloadCogButton(locale=locale))
        reload_cog_section.add_item(TextDisplay(t(locale, 'admin-desc-reload-cog')))
        container.add_item(reload_cog_section)

        self.add_item(container)
