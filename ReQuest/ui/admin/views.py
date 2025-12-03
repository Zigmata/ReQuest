import logging
import math

import discord
from discord.ui import LayoutView, ActionRow, Container, Section, Separator, TextDisplay, Button

from ReQuest.ui.admin import buttons
from ReQuest.ui.common import buttons as common_buttons
from ReQuest.ui.common import modals as common_modals
from ReQuest.ui.common.buttons import MenuDoneButton, MenuViewButton
from ReQuest.utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class AdminBaseView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)

        container = Container()

        header_section = Section(accessory=MenuDoneButton())
        header_section.add_item(TextDisplay('**Administration - Main Menu**'))
        container.add_item(header_section)
        container.add_item(Separator())

        allow_list_section = Section(accessory=MenuViewButton(AdminAllowlistView, 'Allowlist'))
        allow_list_section.add_item(TextDisplay('Configure the server allowlist for invite restrictions.'))
        container.add_item(allow_list_section)

        cog_section = Section(accessory=MenuViewButton(AdminCogView, 'Cogs'))
        cog_section.add_item(TextDisplay('Load or reload cogs.'))
        container.add_item(cog_section)

        print_guilds_section = Section(accessory=buttons.PrintGuildsButton())
        print_guilds_section.add_item(TextDisplay('Returns a list of all guilds the bot is a member of.'))
        container.add_item(print_guilds_section)

        shutdown_section = Section(accessory=buttons.AdminShutdownButton(self))
        shutdown_section.add_item(TextDisplay('Shuts down the bot'))
        container.add_item(shutdown_section)

        self.add_item(container)


class AdminAllowlistView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.servers = []

        self.items_per_page = 9
        self.current_page = 0
        self.total_pages = 1

    async def setup(self, bot):
        try:
            collection = bot.cdb['serverAllowlist']
            query = await collection.find_one({'servers': {'$exists': True}})

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
        container = Container()

        header_section = Section(accessory=common_buttons.BackButton(AdminBaseView))
        header_section.add_item(TextDisplay('**Administration - Server Allowlist**'))
        container.add_item(header_section)
        container.add_item(Separator())

        add_server_section = Section(accessory=buttons.AllowlistAddServerButton(self))
        add_server_section.add_item(TextDisplay(
            'Add a new Discord Server ID to the allowlist.\n'
            '**WARNING: There is no way to verify the server ID provided is valid without the bot being a '
            'server member. Double-check your inputs!**'
        ))
        container.add_item(add_server_section)
        container.add_item(Separator())

        if not self.servers:
            container.add_item(TextDisplay("No servers in allowlist."))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = self.servers[start:end]

            for server in page_items:
                name = server.get('name', 'Unknown')
                server_id = server.get('id', 0)

                info = f"**{name}** (ID: `{server_id}`)"

                section = Section(accessory=buttons.RemoveServerButton(self, server_id, name))
                section.add_item(TextDisplay(info))
                container.add_item(section)

        self.add_item(container)

        if self.total_pages > 1:
            nav_row = ActionRow()

            prev_button = Button(
                label='Previous',
                style=discord.ButtonStyle.secondary,
                custom_id='allow_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_display = Button(
                label=f'Page {self.current_page + 1}/{self.total_pages}',
                style=discord.ButtonStyle.secondary,
                custom_id='allow_page_disp'
            )
            page_display.callback = self.show_page_jump_modal
            nav_row.add_item(page_display)

            next_button = Button(
                label='Next',
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


class AdminCogView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=common_buttons.BackButton(AdminBaseView))
        header_section.add_item(TextDisplay('**Administration - Cogs**'))
        container.add_item(header_section)
        container.add_item(Separator())

        load_cog_section = Section(accessory=buttons.AdminLoadCogButton())
        load_cog_section.add_item(TextDisplay(
            'Load a bot cog by name. File must be named `<name>.py` and stored in ReQuest\\cogs\\.'
        ))
        container.add_item(load_cog_section)

        reload_cog_section = Section(accessory=buttons.AdminReloadCogButton())
        reload_cog_section.add_item(TextDisplay(
            'Reload a loaded cog by name. Same naming and file path restrictions apply.'
        ))
        container.add_item(reload_cog_section)

        self.add_item(container)
