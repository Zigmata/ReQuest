import shortuuid
import discord
import discord.ui
import logging
from ..utilities.checks import has_gm_or_mod
from datetime import datetime, timezone
from discord import app_commands
from discord.ext.commands import Cog
from ..utilities.supportFunctions import log_exception
from ..utilities.ui import MenuDoneButton, PlayerMenuButton, PlayerBackButton

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
            view = PlayerBaseView(self.mdb, self.bot)
            await interaction.response.send_message(embed=view.embed, view=view, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


class PlayerBaseView(discord.ui.View):
    def __init__(self, mdb, bot):
        super().__init__(timeout=None)
        self.mdb = mdb
        self.bot = bot
        self.embed = discord.Embed(
            title='Player Commands - Main Menu',
            description=(
                '__**Characters**__\n'
                'Commands to register, view, and activate player characters.\n\n'
            ),
            type='rich'
        )
        self.add_item(PlayerMenuButton(CharacterBaseView, 'Characters', mdb, bot))
        self.add_item(MenuDoneButton(PlayerBaseView))


class CharacterBaseView(discord.ui.View):
    def __init__(self, mdb, bot):
        super().__init__(timeout=None)
        self.mdb = mdb
        self.bot = bot
        self.embed = discord.Embed(
            title='Player Commands - Characters',
            description=(
                '__**Register**__\n'
                'Registers a new character, and activates that character on the current server.\n\n'
                '__**List**__\n'
                'List all registered characters.'
                '__**Activate**__\n'
                '__**Remove**__\n'
                ''
            ),
            type='rich'
        )

    async def setup_embed(self):
        return

    async def setup_select(self):
        return

    # TODO: Implement max_length of 40 for names and notes
    @discord.ui.button(label='Register New Character', style=discord.ButtonStyle.success,
                       custom_id='register_character_button')
    async def register_character_button(self, interaction: discord.Interaction, button: discord.ui.Button):
        try:
            modal = CharacterRegisterModal(self, self.mdb)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class CharacterRegisterModal(discord.ui.Modal):
    def __init__(self, calling_view, mdb):
        super().__init__(
            title='Register New Character',
            timeout=180
        )
        self.name_text_input = discord.ui.TextInput(
            label='Name',
            style=discord.TextStyle.short,
            custom_id='character_name_text_input',
            placeholder='Enter your character\'s name'
        )
        self.note_text_input = discord.ui.TextInput(
            label='Note',
            style=discord.TextStyle.short,
            custom_id='character_note_text_input',
            placeholder='Enter a note to identify your character'
        )
        self.calling_view = calling_view
        self.mdb = mdb
        self.add_item(self.name_text_input)
        self.add_item(self.note_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            member_id = interaction.user.id
            guild_id = interaction.guild_id
            character_id = str(shortuuid.uuid())
            collection = self.mdb['characters']
            date = datetime.now(timezone.utc)
            character_name = self.name_text_input.value
            character_note = self.note_text_input.value

            await collection.update_one({'_id': member_id},
                                        {'$set': {f'activeCharacters.{guild_id}': character_id,
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

            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)

    # @app_commands.command(name='character')
    # async def character(self, interaction: discord.Interaction, character_name: str = None):
    #     """
    #     Commands for registration and management of player characters.
    #
    #     Arguments:
    #     <none>: Displays current active character for this server.
    #     <character_name>: Name of the character to set as active for this server.
    #     """
    #     member_id = interaction.user.id
    #     guild_id = interaction.guild_id
    #     collection = self.mdb['characters']
    #     query = await collection.find_one({'_id': member_id})
    #     error_title = None
    #     error_message = None
    #
    #     if character_name:
    #         ids = []
    #         if not query:
    #             error_title = 'Error'
    #             error_message = 'You have no registered characters!'
    #         else:
    #             for character_id in query['characters']:
    #                 ids.append(character_id)
    #
    #         name = character_name.lower()
    #         matches = []
    #         for character_id in ids:
    #             char = query['characters'][character_id]
    #             if name in char['name'].lower():
    #                 matches.append(character_id)
    #
    #         if not matches:
    #             error_title = 'Search failed.'
    #             error_message = 'No characters found with that name!'
    #         elif len(matches) == 1:
    #             char = query['characters'][matches[0]]
    #             await collection.update_one({'_id': member_id}, {'$set': {f'activeCharacters.{guild_id}': matches[0]}})
    #             await interaction.response.send_message(f'Active character changed to {char["name"]} ({char["note"]})',
    #                                                     ephemeral=True)
    #         elif len(matches) > 1:
    #             options = []
    #             for match in matches:
    #                 char = query['characters'][match]
    #                 options.append(discord.SelectOption(label=f'{char["name"][:40]} ({char["note"][:40]})',
    #                                                     value=match))
    #             select = SingleChoiceDropdown(placeholder='Choose One', options=options)
    #             view = DropdownView(select)
    #             await interaction.response.send_message('Multiple matches found!', view=view, ephemeral=True)
    #             await view.wait()
    #             selection_id = select.values[0]
    #             selection = query['characters'][selection_id]
    #             await interaction.edit_original_response(content=f'Active character changed to {selection["name"]} '
    #                                                      f'({selection["note"]})', embed=None, view=None)
    #             await collection.update_one({'_id': member_id}, {'$set': {f'activeCharacters.{guild_id}': selection_id}})
    #     else:
    #         if not query:
    #             error_title = 'Error'
    #             error_message = 'You have no registered characters!'
    #         elif not str(guild_id) in query['activeCharacters']:
    #             error_title = 'Error'
    #             error_message = 'You have no active characters on this server!'
    #         else:
    #             active_character = query['activeCharacters'][str(guild_id)]
    #             await interaction.response.send_message(f'Active character: '
    #                                                     f'{query["characters"][active_character]["name"]} '
    #                                                     f'({query["characters"][active_character]["note"]})',
    #                                                     ephemeral=True)
    #
    #     if error_message:
    #         error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
    #         interaction.response.send_message(embed=error_embed, ephemeral=True)
    #
    # @app_commands.command(name='list')
    # async def character_list(self, interaction: discord.Interaction):
    #     """
    #     Lists the player's registered characters.
    #     """
    #     member_id = interaction.user.id
    #     guild_id = interaction.guild_id
    #     collection = self.mdb['characters']
    #     query = await collection.find_one({'_id': member_id})
    #
    #     if not query or not query['characters']:
    #         error_embed = discord.Embed(title='Error', description='You have no registered characters!', type='rich')
    #         await interaction.response.send_message(embed=error_embed, ephemeral=True)
    #     else:
    #         ids = []
    #         for character_id in query['characters']:
    #             ids.append(character_id)
    #
    #         post_embed = discord.Embed(title='Registered Characters', type='rich')
    #         for character_id in ids:
    #             char = query['characters'][character_id]
    #             if str(guild_id) in query['activeCharacters']:
    #                 if character_id == query['activeCharacters'][str(guild_id)]:
    #                     post_embed.add_field(name=char['name'] + ' (Active)', value=char['note'], inline=False)
    #                     continue
    #
    #             post_embed.add_field(name=char['name'], value=char['note'], inline=False)
    #
    #         await interaction.response.send_message(embed=post_embed, ephemeral=True)
    #

    #
    # @app_commands.command(name='delete')
    # async def character_delete(self, interaction: discord.Interaction, character_name: str):
    #     """
    #     Deletes a player character.
    #
    #     Arguments:
    #     <character_name>: The name of the character.
    #     """
    #     member_id = interaction.user.id
    #     guild_id = interaction.guild_id
    #     collection = self.mdb['characters']
    #     query = await collection.find_one({'_id': member_id})
    #     error_title = None
    #     error_message = None
    #
    #     ids = []
    #     if not query:
    #         error_title = 'Error!'
    #         error_message = 'You have no registered characters!'
    #     else:
    #         for character_id in query['characters']:
    #             ids.append(character_id)
    #
    #         name = character_name.lower()
    #         matches = []
    #         for character_id in ids:
    #             char = query['characters'][character_id]
    #             if name in char['name'].lower():
    #                 matches.append(character_id)
    #
    #         if not matches:
    #             error_title = 'Error!'
    #             error_message = 'No characters found with that name!'
    #         elif len(matches) == 1:
    #             name = query['characters'][matches[0]]['name']
    #
    #             # TODO: Create confirmation modal
    #             await collection.update_one({'_id': member_id}, {'$unset': {f'characters.{matches[0]}': ''}},
    #                                         upsert=True)
    #             for guild in query['activeCharacters']:
    #                 if query[f'activeCharacters'][guild] == matches[0]:
    #                     await collection.update_one({'_id': member_id}, {'$unset': {f'activeCharacters.{guild_id}': ''}},
    #                                                 upsert=True)
    #             await interaction.response.send_message(f'`{name}` deleted!', ephemeral=True)
    #         else:
    #             options = []
    #             for match in matches:
    #                 char = query['characters'][match]
    #                 options.append(discord.SelectOption(label=f'{char["name"][:40]} ({char["note"][:40]})',
    #                                                     value=match))
    #             select = SingleChoiceDropdown(placeholder='Choose One', options=options)
    #             view = DropdownView(select)
    #             await interaction.response.send_message('Multiple matches found!', view=view, ephemeral=True)
    #             await view.wait()
    #             selection_id = select.values[0]
    #             await collection.update_one({'_id': member_id}, {'$unset': {f'characters.{selection_id}': ''}},
    #                                         upsert=True)
    #             for guild in query['activeCharacters']:
    #                 if query[f'activeCharacters'][guild] == selection_id:
    #                     await collection.update_one({'_id': member_id}, {'$unset': {f'activeCharacters.{guild_id}': ''}},
    #                                                 upsert=True)
    #             await interaction.edit_original_response(content=f'`{query["characters"][selection_id]["name"]}` '
    #                                                              f'deleted!', embed=None, view=None)
    #
    #     if error_message:
    #         error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
    #         await interaction.response.send_message(embed=error_embed, ephemeral=True)
    #
    # @experience_group.command(name='view')
    # async def view_experience(self, interaction: discord.Interaction):
    #     """
    #     Commands for modifying experience points. Displays the current value if no subcommand is used.
    #     """
    #     member_id = interaction.user.id
    #     guild_id = interaction.guild_id
    #     collection = self.mdb['characters']
    #     error_title = None
    #     error_message = None
    #
    #     # Load the player's characters
    #     query = await collection.find_one({'_id': member_id})
    #     if not query:  # If none exist, output the error
    #         error_title = 'Error!'
    #         error_message = 'You have no registered characters!'
    #     elif not str(guild_id) in query['activeCharacters']:
    #         error_title = 'Error!'
    #         error_message = 'You have no active characters on this server!'
    #     else:  # Otherwise, proceed to query the active character and retrieve its xp
    #         active_character = query['activeCharacters'][str(guild_id)]
    #         char = query['characters'][active_character]
    #         name = char['name']
    #         xp = char['attributes']['experience']
    #
    #         xp_embed = discord.Embed(title=f'{name}', type='rich', description=f'Total Experience: **{xp}**')
    #         await interaction.response.send_message(embed=xp_embed, ephemeral=True)
    #
    #     if error_message:
    #         error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
    #         await interaction.response.send_message(embed=error_embed, ephemeral=True)
    #



async def setup(bot):
    await bot.add_cog(Player(bot))
