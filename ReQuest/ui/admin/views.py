import logging

import discord
from discord.ui import LayoutView, ActionRow, Container, Section, Separator, TextDisplay

from ReQuest.ui.admin import buttons, selects
from ReQuest.ui.common import buttons as common_buttons
from ReQuest.ui.common.views import MenuBaseView
from ReQuest.utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class AdminBaseView(MenuBaseView):
    def __init__(self):
        super().__init__(
            title='**Administrative - Main Menu**',
            menu_items=[
                {
                    'name': 'Allowlist',
                    'description': 'Configures the server allowlist for invite restrictions.',
                    'view_class': AdminAllowlistView
                },
                {
                    'name': 'Cogs',
                    'description': 'Load or reload bot cogs.',
                    'view_class': AdminCogView
                }
            ],
            menu_level=0
        )
        self.children[0].add_item(ActionRow(buttons.AdminShutdownButton(self)))


class AdminAllowlistView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.remove_guild_allowlist_select = selects.RemoveGuildAllowlistSelect(self)

        self.build_view()

    def build_view(self):
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

        container.add_item(TextDisplay('Choose a server to remove from the allowlist'))
        server_select_row = ActionRow(self.remove_guild_allowlist_select)
        container.add_item(server_select_row)

        self.add_item(container)

    async def setup(self, bot):
        try:
            self.remove_guild_allowlist_select.options.clear()
            collection = bot.cdb['serverAllowlist']
            query = await collection.find_one()
            options = []
            if query and len(query['servers']) > 0:
                for server in query['servers']:
                    options.append(discord.SelectOption(label=server['name'], value=server['id']))
            else:
                options.append(discord.SelectOption(label='There are no servers in the allowlist', value='None'))
                self.remove_guild_allowlist_select.placeholder = 'There are no servers in the allowlist'
                self.remove_guild_allowlist_select.disabled = True

            self.remove_guild_allowlist_select.options = options
        except Exception as e:
            await log_exception(e)


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
