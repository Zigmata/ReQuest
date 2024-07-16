import logging
from datetime import datetime, timezone

import discord
import discord.ui
import shortuuid
from discord import app_commands
from discord.ext.commands import Cog

from ..utilities.checks import has_active_character
from ..utilities.supportFunctions import log_exception
from ..utilities.ui import MenuDoneButton, PlayerMenuButton, PlayerBackButton, TradeModal

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class Player(Cog):
    def __init__(self, bot):
        self.bot = bot
        self.mdb = bot.mdb
        super().__init__()

    @app_commands.command(name='player')
    @app_commands.guild_only()
    async def player(self, interaction: discord.Interaction):
        """
        Player Commands
        """
        try:
            member_id = interaction.user.id
            guild_id = interaction.guild_id
            view = PlayerBaseView(self.mdb, self.bot, member_id, guild_id)
            await interaction.response.send_message(embed=view.embed, view=view, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


@has_active_character()
@app_commands.guild_only()
@app_commands.context_menu(name='Trade')
async def trade(interaction: discord.Interaction, target: discord.Member):
    try:
        modal = TradeModal(target=target)
        await interaction.response.send_modal(modal)
    except Exception as e:
        await log_exception(e, interaction)


class PlayerBaseView(discord.ui.View):
    def __init__(self, mdb, bot, member_id, guild_id):
        super().__init__(timeout=None)
        self.mdb = mdb
        self.bot = bot
        self.member_id = member_id
        self.guild_id = guild_id
        self.embed = discord.Embed(
            title='Player Commands - Main Menu',
            description=(
                '__**Characters**__\n'
                'Commands to register, view, and activate player characters.\n\n'
            ),
            type='rich'
        )
        self.add_item(PlayerMenuButton(CharacterBaseView, 'Characters', mdb, bot, member_id, guild_id))
        self.add_item(MenuDoneButton(self))


class CharacterBaseView(discord.ui.View):
    def __init__(self, mdb, bot, member_id, guild_id):
        super().__init__(timeout=None)
        self.mdb = mdb
        self.bot = bot
        self.member_id = member_id
        self.guild_id = guild_id
        self.embed = discord.Embed(
            title='Player Commands - Characters',
            description=(
                '__**Register**__\n'
                'Registers a new character, and activates that character on the current server.\n\n'
                '__**List/Activate**__\n'
                'Show all registered characters, and change the active character for this server.\n\n'
                '__**Remove**__\n'
                'Removes a character permanently.\n\n'
            ),
            type='rich'
        )
        self.add_item(PlayerBackButton(PlayerBaseView, mdb, bot, member_id, guild_id))

    @discord.ui.button(label='Register', style=discord.ButtonStyle.success, custom_id='register_character_button')
    async def register_character_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            modal = CharacterRegisterModal(self, self.mdb, self.member_id, self.guild_id)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)

    @discord.ui.button(label='List/Activate', style=discord.ButtonStyle.secondary, custom_id='list_characters_button')
    async def list_characters_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            new_view = ListCharactersView(self.mdb, self.bot, self.member_id, self.guild_id)
            await new_view.setup_select()
            await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)

    @discord.ui.button(label='Remove', style=discord.ButtonStyle.danger, custom_id='remove_character_button')
    async def remove_character_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            new_view = RemoveCharacterView(self.mdb, self.bot, self.member_id, self.guild_id)
            await new_view.setup_select()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class CharacterRegisterModal(discord.ui.Modal):
    def __init__(self, calling_view, mdb, member_id, guild_id):
        super().__init__(
            title='Register New Character',
            timeout=180
        )
        self.name_text_input = discord.ui.TextInput(
            label='Name',
            style=discord.TextStyle.short,
            custom_id='character_name_text_input',
            placeholder='Enter your character\'s name.',
            max_length=40
        )
        self.note_text_input = discord.ui.TextInput(
            label='Note',
            style=discord.TextStyle.short,
            custom_id='character_note_text_input',
            placeholder='Enter a note to identify your character',
            max_length=80
        )
        self.calling_view = calling_view
        self.mdb = mdb
        self.member_id = member_id
        self.guild_id = guild_id
        self.add_item(self.name_text_input)
        self.add_item(self.note_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            character_id = str(shortuuid.uuid())
            collection = self.mdb['characters']
            date = datetime.now(timezone.utc)
            character_name = self.name_text_input.value
            character_note = self.note_text_input.value

            await collection.update_one({'_id': self.member_id},
                                        {'$set': {f'activeCharacters.{self.guild_id}': character_id,
                                                  f'characters.{character_id}': {
                                                      'name': character_name,
                                                      'note': character_note,
                                                      'registeredDate': date,
                                                      'attributes': {
                                                          'level': None,
                                                          'experience': None,
                                                          'inventory': {},
                                                          'currency': {}
                                                      }}}},
                                        upsert=True)

            await interaction.response.send_message(f'{character_name} was born!', ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


class ListCharactersView(discord.ui.View):
    def __init__(self, mdb, bot, member_id, guild_id):
        super().__init__(timeout=None)
        self.mdb = mdb
        self.bot = bot
        self.member_id = member_id
        self.guild_id = guild_id
        self.embed = discord.Embed(
            title='Player Commands - List Characters',
            description='Registered Characters are listed below. Select a character from the dropdown to activate '
                        'that character for this server.',
            type='rich'
        )
        self.add_item(PlayerBackButton(CharacterBaseView, mdb, bot, member_id, guild_id))

    async def setup_embed(self):
        try:
            self.embed.clear_fields()
            collection = self.mdb['characters']
            query = await collection.find_one({'_id': self.member_id})
            if not query or not query['characters']:
                self.embed.description = 'You have no registered characters!'
            else:
                ids = []
                for character_id in query['characters']:
                    ids.append(character_id)
                for character_id in ids:
                    character = query['characters'][character_id]
                    if (str(self.guild_id) in query['activeCharacters']
                            and character_id == query['activeCharacters'][str(self.guild_id)]):
                        character_info = (f'{character['name']}: {character['attributes']['experience']} XP '
                                          f'(Active Character)')
                    else:
                        character_info = f'{character['name']}: {character['attributes']['experience']} XP'
                    self.embed.add_field(name=character_info, value=character['note'], inline=False)
        except Exception as e:
            await log_exception(e)

    async def setup_select(self):
        try:
            self.active_character_select.options.clear()
            options = []
            collection = self.mdb['characters']
            query = await collection.find_one({'_id': self.member_id})
            if not query or not query['characters'] or len(query['characters']) == 0:
                options.append(discord.SelectOption(label='No characters', value='None'))
            else:
                for character_id in query['characters']:
                    character = query['characters'][character_id]
                    character_name = character['name']
                    option = discord.SelectOption(label=character_name, value=character_id)
                    options.append(option)
                self.active_character_select.disabled = False
                self.active_character_select.placeholder = 'Select a character to activate on this server'

            self.active_character_select.options = options
        except Exception as e:
            await log_exception(e)

    @discord.ui.select(cls=discord.ui.Select, placeholder='You have no registered characters', options=[],
                       custom_id='active_character_select', disabled=True)
    async def active_character_select(self, interaction: discord.Interaction, select: discord.ui.Select):
        try:
            selected_character_id = select.values[0]
            collection = self.mdb['characters']
            await collection.update_one({'_id': self.member_id},
                                        {'$set': {f'activeCharacters.{self.guild_id}': selected_character_id}},
                                        upsert=True)
            await self.setup_embed()
            await self.setup_select()
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveCharacterView(discord.ui.View):
    def __init__(self, mdb, bot, member_id, guild_id):
        super().__init__(timeout=None)
        self.mdb = mdb
        self.bot = bot
        self.member_id = member_id
        self.guild_id = guild_id
        self.embed = discord.Embed(
            title='Player Commands - Remove Character',
            description='Select a character from the dropdown. Confirm to permanently remove that character.',
            type='rich'
        )
        self.add_item(PlayerBackButton(CharacterBaseView, mdb, bot, member_id, guild_id))
        self.selected_character_id = None

    async def setup_select(self):
        try:
            self.remove_character_select.options.clear()
            options = []
            collection = self.mdb['characters']
            query = await collection.find_one({'_id': self.member_id})
            if not query or not query['characters'] or len(query['characters']) == 0:
                options.append(discord.SelectOption(label='No characters', value='None'))
                self.remove_character_select.disabled = True
            else:
                for character_id in query['characters']:
                    character = query['characters'][character_id]
                    character_name = character['name']
                    option = discord.SelectOption(label=character_name, value=character_id)
                    options.append(option)
                self.remove_character_select.disabled = False

            self.remove_character_select.options = options
        except Exception as e:
            await log_exception(e)

    @discord.ui.select(cls=discord.ui.Select, placeholder='Select a character to remove', options=[],
                       custom_id='remove_character_select')
    async def remove_character_select(self, interaction: discord.Interaction, select: discord.ui.Select):
        try:
            self.selected_character_id = select.values[0]
            collection = self.mdb['characters']
            query = await collection.find_one({'_id': self.member_id})
            character_name = query['characters'][self.selected_character_id]['name']
            self.embed.add_field(name=f'Removing {character_name}', value='**This action is permanent!** Confirm?')
            self.confirm_button.disabled = False
            self.confirm_button.label = f'Confirm removal of {character_name}'
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)

    @discord.ui.button(label='Confirm', style=discord.ButtonStyle.danger, custom_id='confirm_button', disabled=True)
    async def confirm_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            collection = self.mdb['characters']
            query = await collection.find_one({'_id': self.member_id})
            await collection.update_one({'_id': self.member_id},
                                        {'$unset': {f'characters.{self.selected_character_id}': ''}}, upsert=True)
            for guild in query['activeCharacters']:
                if query['activeCharacters'][guild] == self.selected_character_id:
                    await collection.update_one({'_id': self.member_id},
                                                {'$unset': {f'activeCharacters.{self.guild_id}': ''}}, upsert=True)
            await self.setup_select()
            self.embed.clear_fields()
            self.confirm_button.disabled = True
            self.confirm_button.label = 'Confirm'
            self.selected_character_id = None
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)


async def setup(bot):
    await bot.add_cog(Player(bot))
    bot.tree.add_command(trade)
