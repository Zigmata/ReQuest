import logging

import discord
from discord.ui import View

from ReQuest.ui.admin import buttons, selects
from ReQuest.ui.common import buttons as common_buttons
from ReQuest.utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class AdminBaseView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Administrative - Main Menu',
            description=(
                '__**Allowlist**__\n'
                'Configures the server allowlist for invite restrictions.'
            ),
            type='rich'
        )
        self.add_item(common_buttons.MenuViewButton(AdminAllowlistView, 'Allowlist'))
        self.add_item(common_buttons.MenuViewButton(AdminCogView, 'Cogs'))
        self.add_item(buttons.AdminShutdownButton(self))
        self.add_item(common_buttons.MenuDoneButton())


class AdminAllowlistView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Administration - Server Allowlist',
            description=('__**Add New Server**__\n'
                         'Adds a new Discord Server ID to the allowlist.\n'
                         '**WARNING: There is no way to verify the server ID provided is valid without the bot being a'
                         'server member. Double-check your inputs!**\n\n'
                         '__**Remove**__\n'
                         'Removes the selected Discord Server from the allowlist.\n\n'),
            type='rich'
        )
        self.selected_guild = None
        self.remove_guild_allowlist_select = selects.RemoveGuildAllowlistSelect(self)
        self.confirm_allowlist_remove_button = buttons.ConfirmAllowlistRemoveButton(self)
        self.add_item(self.remove_guild_allowlist_select)
        self.add_item(buttons.AllowlistAddServerButton(self))
        self.add_item(self.confirm_allowlist_remove_button)
        self.add_item(common_buttons.BackButton(AdminBaseView))

    async def setup(self, bot):
        try:
            self.embed.clear_fields()
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


class AdminCogView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Administration - Cogs',
            description=(
                '__**Load**__\n'
                'Loads a cog by name. File must be named `<name>.py` and stored in ReQuest\\cogs\\\n\n'
                '__**Reload**__\n'
                'Reloads a loaded cog by name. Same naming and file path restrictions apply.'
            ),
            type='rich'
        )
        self.add_item(buttons.AdminLoadCogButton())
        self.add_item(buttons.AdminReloadCogButton())
        self.add_item(common_buttons.BackButton(AdminBaseView))
