import logging

import discord
import discord.ui
from discord import ButtonStyle, Interaction
from discord.ui import Button

from .modals import CharacterRegisterModal
from ..utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class RegisterCharacterButton(Button):
    def __init__(self):
        super().__init__(
            label='Register',
            style=ButtonStyle.success,
            custom_id='register_character_button'
        )

    async def callback(self, interaction: Interaction):
        try:
            modal = CharacterRegisterModal(self, interaction.client.mdb, interaction.user.id, interaction.guild_id)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class ListCharactersButton(Button):
    def __init__(self, target_view):
        super().__init__(
            label='List/Activate',
            style=ButtonStyle.secondary,
            custom_id='list_characters_button'
        )
        self.target_view = target_view

    async def callback(self, interaction: Interaction):
        try:
            await self.target_view.setup_select()
            await self.target_view.setup_embed()
            await interaction.response.edit_message(embed=self.target_view.embed, view=self.target_view)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveCharacterButton(Button):
    def __init__(self, target_view):
        super().__init__(
            label='Remove',
            style=ButtonStyle.danger,
            custom_id='remove_character_button'
        )
        self.target_view = target_view

    async def callback(self, interaction: Interaction):
        try:
            await self.target_view.setup_select()
            await interaction.response.edit_message(embed=self.target_view.embed, view=self.target_view)
        except Exception as e:
            await log_exception(e, interaction)


class BackButton(discord.ui.Button):
    def __init__(self, new_view):
        super().__init__(
            label='Back',
            style=discord.ButtonStyle.secondary,
            custom_id='menu_back_button'
        )
        self.new_view = new_view

    async def callback(self, interaction: discord.Interaction):
        try:
            if hasattr(self.new_view, 'setup_select'):
                await self.new_view.setup_select()
            if hasattr(self.new_view, 'setup_embed'):
                await self.new_view.setup_embed()
            await interaction.response.edit_message(embed=self.new_view.embed, view=self.new_view)
        except Exception as e:
            await log_exception(e, interaction)


class AdminShutdownButton(discord.ui.Button):
    def __init__(self, bot, calling_view):
        super().__init__(
            label='Shutdown',
            style=discord.ButtonStyle.danger,
            custom_id='shutdown_bot_button'
        )
        self.confirm = False
        self.bot = bot
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            if self.confirm:
                await interaction.response.send_message('Shutting down!', ephemeral=True)
                await self.bot.close()
            else:
                self.confirm = True
                self.label = 'CONFIRM SHUTDOWN?'
                await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e)


class ConfigBackButton(discord.ui.Button):
    def __init__(self, returning_view_class, guild_id, db, setup_embed=True, setup_select=True):
        super().__init__(
            label='Back',
            style=discord.ButtonStyle.primary,
            custom_id='back_button')
        self.guild_id = guild_id
        self.db = db
        self.returning_view_class = returning_view_class
        self.setup_embed = setup_embed
        self.setup_select = setup_select

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.returning_view_class(self.guild_id, self.db)
            if hasattr(new_view, 'setup_select') and self.setup_select:
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed') and self.setup_embed:
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class AdminBackButton(discord.ui.Button):
    def __init__(self, returning_view_class, cdb, bot, setup_embed=True, setup_select=True):
        super().__init__(
            label='Back',
            style=discord.ButtonStyle.primary,
            custom_id='back_button')
        self.cdb = cdb
        self.bot = bot
        self.returning_view_class = returning_view_class
        self.setup_embed = setup_embed
        self.setup_select = setup_select

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.returning_view_class(self.cdb, self.bot)
            if hasattr(new_view, 'setup_select') and self.setup_select:
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed') and self.setup_embed:
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class PlayerBackButton(discord.ui.Button):
    def __init__(self, returning_view_class, mdb, bot, member_id, guild_id, setup_embed=True, setup_select=True):
        super().__init__(
            label='Back',
            style=discord.ButtonStyle.primary,
            custom_id='back_button')
        self.mdb = mdb
        self.bot = bot
        self.member_id = member_id
        self.guild_id = guild_id
        self.returning_view_class = returning_view_class
        self.setup_embed = setup_embed
        self.setup_select = setup_select

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.returning_view_class(self.mdb, self.bot, self.member_id, self.guild_id)
            if hasattr(new_view, 'setup_select') and self.setup_select:
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed') and self.setup_embed:
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class ConfigMenuButton(discord.ui.Button):
    def __init__(self, submenu_view_class, label, guild_id, gdb):
        super().__init__(
            label=label,
            style=discord.ButtonStyle.primary,
            custom_id=f'config_{label.lower()}_button'
        )
        self.guild_id = guild_id
        self.gdb = gdb
        self.submenu_view_class = submenu_view_class

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.submenu_view_class(self.guild_id, self.gdb)
            await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class AdminMenuButton(discord.ui.Button):
    def __init__(self, submenu_view_class, label, cdb, bot, setup_select=True, setup_embed=True):
        super().__init__(
            label=label,
            style=discord.ButtonStyle.primary,
            custom_id=f'admin_{label.lower()}_button'
        )
        self.cdb = cdb
        self.submenu_view_class = submenu_view_class
        self.bot = bot
        self.setup_select = setup_select
        self.setup_embed = setup_embed

    async def callback(self, interaction: discord.Interaction, ):
        try:
            new_view = self.submenu_view_class(self.cdb, self.bot)
            if hasattr(new_view, 'setup_select') and self.setup_select:
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed') and self.setup_embed:
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class PlayerMenuButton(discord.ui.Button):
    def __init__(self, submenu_view_class, label, mdb, bot, member_id, guild_id, setup_select=True, setup_embed=True):
        super().__init__(
            label=label,
            style=discord.ButtonStyle.primary,
            custom_id=f'player_{label.lower()}_button'
        )
        self.submenu_view_class = submenu_view_class
        self.mdb = mdb
        self.bot = bot
        self.member_id = member_id
        self.guild_id = guild_id
        self.setup_select = setup_select
        self.setup_embed = setup_embed

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.submenu_view_class(self.mdb, self.bot, self.member_id, self.guild_id)
            if hasattr(new_view, 'setup_select') and self.setup_select:
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed') and self.setup_embed:
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class MenuForwardButton(discord.ui.Button):
    def __init__(self, menu_view, label, bot, member_id, guild_id):
        super().__init__(
            label=label,
            style=discord.ButtonStyle.primary,
            custom_id=f'{label.lower()}_menu_button'
        )
        self.menu_view = menu_view
        self.bot = bot
        self.member_id = member_id
        self.guild_id = guild_id

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.menu_view
            if hasattr(new_view, 'setup_select'):
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed'):
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class MenuDoneButton(discord.ui.Button):
    def __init__(self):
        super().__init__(
            label='Done',
            style=discord.ButtonStyle.gray,
            custom_id='done_button'
        )

    async def callback(self, interaction: discord.Interaction):
        try:
            for child in self.view.children.copy():
                self.view.remove_item(child)
            await interaction.response.edit_message(view=self.view)
        except Exception as e:
            await log_exception(e, interaction)


class ConfirmButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Confirm',
            style=discord.ButtonStyle.danger,
            custom_id='confirm_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            selected_character_id = self.calling_view.selected_character_id
            collection = interaction.client.mdb['characters']
            member_id = interaction.user.id
            query = await collection.find_one({'_id': member_id})
            await collection.update_one({'_id': member_id},
                                        {'$unset': {f'characters.{selected_character_id}': ''}}, upsert=True)
            for guild in query['activeCharacters']:
                if query['activeCharacters'][guild] == selected_character_id:
                    await collection.update_one({'_id': member_id},
                                                {'$unset': {f'activeCharacters.{interaction.guild_id}': ''}},
                                                upsert=True)
            self.calling_view.selected_character_id = None
            await self.calling_view.setup_select()
            self.calling_view.embed.clear_fields()
            self.disabled = True
            self.label = 'Confirm'
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class QuestAnnounceRoleRemoveButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Remove Quest Announcement Role',
            style=discord.ButtonStyle.red,
            custom_id='quest_announce_role_remove_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            collection = interaction.client.gdb['announceRole']
            query = await collection.find_one({'_id': interaction.guild_id})
            if query:
                await collection.delete_one({'_id': interaction.guild_id})

            await self.calling_view.setup_embed()
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class GMRoleRemoveButton(discord.ui.Button):
    def __init__(self, new_view):
        super().__init__(
            label='Remove GM Roles',
            style=discord.ButtonStyle.red,
            custom_id='gm_role_remove_button'
        )
        self.new_view = new_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.new_view.setup_select()
            await self.new_view.setup_embed()
            await interaction.response.edit_message(embed=self.new_view.embed, view=self.new_view)
        except Exception as e:
            await log_exception(e, interaction)
