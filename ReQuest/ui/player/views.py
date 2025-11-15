import logging

import discord
import shortuuid
from discord.ui import View

from ReQuest.ui.player import buttons, selects
from ReQuest.ui.common.buttons import MenuViewButton, MenuDoneButton, BackButton, ConfirmButton
from ReQuest.utilities.supportFunctions import log_exception, strip_id, attempt_delete

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class PlayerBaseView(View):
    def __init__(self):
        super().__init__()
        self.embed = discord.Embed(
            title='Player Commands - Main Menu',
            description=(
                '__**Characters**__\n'
                'Register, view, and activate player characters.\n\n'
                '__**Inventory**__\n'
                'View your active character\'s inventory and spend currency.\n\n'
                '__**Player Board**__\n'
                'Create a post for the Player Board, if configured on your server.\n\n'
            ),
            type='rich'
        )
        self.player_board_button = MenuViewButton(PlayerBoardView, 'Player Board')
        self.add_item(MenuViewButton(CharacterBaseView, 'Characters'))
        self.add_item(MenuViewButton(InventoryBaseView, 'Inventory'))
        self.add_item(self.player_board_button)
        self.add_item(MenuDoneButton())

    async def setup(self, bot, guild):
        try:
            channel_collection = bot.gdb['playerBoardChannel']
            channel_query = await channel_collection.find_one({'_id': guild.id})
            if channel_query:
                self.player_board_button.disabled = False
            else:
                self.player_board_button.disabled = True
                self.player_board_button.label = 'Player Board (Not Configured)'
        except Exception as e:
            await log_exception(e)


class CharacterBaseView(View):
    def __init__(self):
        super().__init__(timeout=None)
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
        self.add_item(buttons.RegisterCharacterButton())
        self.add_item(MenuViewButton(ListCharactersView, 'List/Activate'))
        self.add_item(MenuViewButton(RemoveCharacterView, 'Remove'))
        self.add_item(BackButton(PlayerBaseView))


class ListCharactersView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Player Commands - List Characters',
            description='Registered Characters are listed below. Select a character from the dropdown to activate '
                        'that character for this server.',
            type='rich'
        )
        self.active_character_select = selects.ActiveCharacterSelect(self)
        self.add_item(self.active_character_select)
        self.add_item(BackButton(CharacterBaseView))

    async def setup(self, bot, user, guild):
        try:
            self.embed.clear_fields()
            collection = bot.mdb['characters']
            query = await collection.find_one({'_id': user.id})
            if not query or not query['characters']:
                self.embed.description = 'You have no registered characters!'
            else:
                ids = []
                for character_id in query['characters']:
                    ids.append(character_id)
                for character_id in ids:
                    character = query['characters'][character_id]
                    if (str(guild.id) in query['activeCharacters']
                            and character_id == query['activeCharacters'][str(guild.id)]):
                        character_info = (f'{character['name']}: {character['attributes']['experience']} XP '
                                          f'(Active Character)')
                    else:
                        character_info = f'{character['name']}: {character['attributes']['experience']} XP'
                    self.embed.add_field(name=character_info, value=character['note'], inline=False)

            self.active_character_select.options.clear()
            options = []
            collection = bot.mdb['characters']
            query = await collection.find_one({'_id': user.id})
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


class RemoveCharacterView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Player Commands - Remove Character',
            description='Select a character from the dropdown. Confirm to permanently remove that character.',
            type='rich'
        )
        self.selected_character_id = None
        self.all_characters = {}
        self.active_characters = {}
        self.remove_character_select = selects.RemoveCharacterSelect(self)
        self.add_item(self.remove_character_select)
        self.add_item(BackButton(CharacterBaseView))

    async def setup(self, bot, user):
        try:
            collection = bot.mdb['characters']
            query = await collection.find_one({'_id': user.id})
            if not query or not query.get('characters'):
                self.all_characters = {}
                self.active_characters = {}
            else:
                self.all_characters = query.get('characters', {})
                self.active_characters = query.get('activeCharacters', {})

            self._build_ui()

        except Exception as e:
            await log_exception(e)

    def _build_ui(self):
        self.embed.clear_fields()
        self.remove_character_select.options.clear()
        options = []

        if not self.all_characters:
            self.remove_character_select.placeholder = "You have no registered characters!"
            options.append(discord.SelectOption(label='No characters to remove', value='None'))
            self.remove_character_select.disabled = True
        else:
            for character_id, character in self.all_characters.items():
                character_name = character['name']
                if character_id in self.active_characters.values():
                    option_label = f'{character_name} (Active)'
                else:
                    option_label = character_name
                option = discord.SelectOption(label=option_label, value=character_id)
                options.append(option)
            self.remove_character_select.disabled = False
            self.remove_character_select.placeholder = 'Select a character to remove'

        self.remove_character_select.options = options

    async def confirm_callback(self, interaction: discord.Interaction):
        try:
            selected_character_id = self.selected_character_id
            collection = interaction.client.mdb['characters']
            member_id = interaction.user.id

            character_name = self.all_characters[selected_character_id]['name']
            await collection.update_one({'_id': member_id},
                                        {'$unset': {f'characters.{selected_character_id}': ''}})

            active_guild_id = None
            for guild_id, character_id in self.active_characters.items():
                if character_id == selected_character_id:
                    active_guild_id = guild_id
                    break

            if active_guild_id:
                await collection.update_one({'_id': member_id},
                                            {'$unset': {f'activeCharacters.{active_guild_id}': ''}})

            if selected_character_id in self.all_characters:
                del self.all_characters[selected_character_id]
            if active_guild_id and active_guild_id in self.active_characters:
                del self.active_characters[active_guild_id]

            self.selected_character_id = None

            self._build_ui()

            self.embed.add_field(name='Success!', value=f'Character {character_name} has been removed.')
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)


class InventoryBaseView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Player Commands - Inventory',
            description=(
                '__**Spend Currency**__\n'
                'Spend some currency.\n\n'
                '__**Trade**__\n'
                'Trading is now handled as a User Context command.\n'
                'Right-click or long-press another user and select Apps -> Trade\n\n'
                '------\n\n'
            ),
            type='rich'
        )
        self.active_character = None
        self.spend_currency_button = buttons.SpendCurrencyButton(self)
        self.add_item(self.spend_currency_button)
        self.add_item(BackButton(PlayerBaseView))

    async def setup(self, bot, user, guild):
        self.embed.clear_fields()
        collection = bot.mdb['characters']
        query = await collection.find_one({'_id': user.id})
        if not query:
            self.spend_currency_button.disabled = True
            self.embed.add_field(name='No Characters', value='Register a character to use these menus.')
        elif str(guild.id) not in query['activeCharacters']:
            self.spend_currency_button.disabled = True
            self.embed.add_field(name='No Active Character', value='Activate a character for this server to use these'
                                                                   'menus.')
        else:
            active_character_id = query['activeCharacters'][str(guild.id)]
            self.active_character = query['characters'][active_character_id]
            self.embed.title = f'Player Commands - {self.active_character['name']}\'s Inventory'
            inventory = self.active_character['attributes']['inventory']
            player_currencies = self.active_character['attributes']['currency']
            items = []
            currencies = []

            for item in inventory:
                pair = (str(item), f'**{inventory[item]}**')
                value = ': '.join(pair)
                items.append(value)

            for currency in player_currencies:
                pair = (str(currency), f'**{player_currencies[currency]}**')
                value = ': '.join(pair)
                currencies.append(value)

            self.embed.add_field(name='Possessions',
                                 value='\n'.join(items))
            self.embed.add_field(name='Currency',
                                 value='\n'.join(currencies))


class PlayerBoardView(View):
    def __init__(self):
        super().__init__(timeout=None)
        self.embed = discord.Embed(
            title='Player Commands - Player Board',
            description=(
                '__**Create Post**__\n'
                'Creates a new post for the Player Board.\n\n'
                '__**Edit Post**__\n'
                'Edits the selected post.\n\n'
                '__**Remove Post**__\n'
                'Removes the selected post from the Player Board.\n\n'
                '------'
            ),
            type='rich'
        )
        self.player_board_channel_id = None
        self.selected_post_id = None
        self.posts = []
        self.selected_post = None
        self.manageable_post_select = selects.ManageablePostSelect(self)
        self.create_player_post_button = buttons.CreatePlayerPostButton(self)
        self.edit_player_post_button = buttons.EditPlayerPostButton(self)
        self.remove_player_post_button = buttons.RemovePlayerPostButton(self)
        self.add_item(self.manageable_post_select)
        self.add_item(self.create_player_post_button)
        self.add_item(self.edit_player_post_button)
        self.add_item(self.remove_player_post_button)
        self.add_item(BackButton(PlayerBaseView))

    async def setup(self, bot, user, guild):
        try:
            channel_collection = bot.gdb['playerBoardChannel']
            channel_query = await channel_collection.find_one({'_id': guild.id})
            self.player_board_channel_id = strip_id(channel_query['playerBoardChannel'])

            self.posts.clear()
            self.embed.clear_fields()
            post_collection = bot.gdb['playerBoard']
            post_cursor = post_collection.find({'guildId': guild.id, 'playerId': user.id})
            async for post in post_cursor:
                self.posts.append(dict(post))

            if self.selected_post_id:
                self.edit_player_post_button.disabled = False
                self.remove_player_post_button.disabled = False
                self.selected_post = next((post for post in self.posts if post['postId'] == self.selected_post_id),
                                          None)
                self.embed.add_field(name='Selected Post',
                                     value=f'`{self.selected_post['postId']}`: {self.selected_post['title']}')
            else:
                self.edit_player_post_button.disabled = True
                self.remove_player_post_button.disabled = True

            options = []
            if self.posts:
                for post in self.posts:
                    options.append(discord.SelectOption(
                        label=post['title'],
                        value=post['postId']
                    ))
                self.manageable_post_select.disabled = False
            else:
                options.append(discord.SelectOption(
                    label='You don\'t have any current posts',
                    value='None'
                ))
                self.manageable_post_select.disabled = True
            self.manageable_post_select.options = options
        except Exception as e:
            await log_exception(e)

    async def select_callback(self, interaction: discord.Interaction):
        try:
            self.selected_post_id = self.manageable_post_select.values[0]
            await self.setup(bot=interaction.client, user=interaction.user, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)

    async def create_post(self, title, content, interaction):
        try:
            post_collection = interaction.client.gdb['playerBoard']
            post_id = str(shortuuid.uuid()[:8])
            post_embed = discord.Embed(
                title=title,
                description=content,
                type='rich'
            )
            post_embed.add_field(name='Author', value=interaction.user.mention)
            post_embed.set_footer(text=f'Post ID: {post_id}')
            channel = interaction.client.get_channel(self.player_board_channel_id)
            message = await channel.send(embed=post_embed)

            post = {
                'guildId': interaction.guild_id,
                'playerId': interaction.user.id,
                'postId': post_id,
                'messageId': message.id,
                'timestamp': message.created_at,
                'title': title,
                'content': content
            }

            await post_collection.insert_one(post)

            self.posts.append(post)

            self.manageable_post_select.options.append(discord.SelectOption(
                label=title,
                value=post_id
            ))
            self.manageable_post_select.disabled = False

            self.embed.add_field(name='Post Created!', value=f'`{post_id}`: **{title}**')

            await interaction.response.edit_message(embed=self.embed, view=self)
        except Exception as e:
            await log_exception(e, interaction)

    async def edit_post(self, title, content, interaction):
        try:
            self.selected_post['title'] = title
            self.selected_post['content'] = content
            post_embed = discord.Embed(
                title=title,
                description=content,
                type='rich'
            )
            post_embed.add_field(name='Author', value=interaction.user.mention)
            post_embed.set_footer(text=f'Post ID: {self.selected_post_id}')

            message_id = self.selected_post['messageId']
            channel = interaction.client.get_channel(self.player_board_channel_id)
            message = channel.get_partial_message(message_id)
            await message.edit(embed=post_embed)

            post_collection = interaction.client.gdb['playerBoard']
            await post_collection.replace_one({'guildId': interaction.guild_id, 'postId': self.selected_post_id},
                                              self.selected_post)

            await interaction.response.send_message(f'Post `{self.selected_post_id}`: **{title}** updated!',
                                                    ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)

    async def remove_post(self, interaction: discord.Interaction):
        try:
            post = self.selected_post
            post_collection = interaction.client.gdb['playerBoard']
            await post_collection.delete_one({'guildId': interaction.guild.id, 'postId': self.selected_post_id})

            message_id = post['messageId']
            channel = interaction.client.get_channel(self.player_board_channel_id)
            message = channel.get_partial_message(message_id)
            await attempt_delete(message)
            self.selected_post = None
            await interaction.response.send_message(f'Post `{post['postId']}`: **{post['title']}** deleted!',
                                                    ephemeral=True)
            await self.setup(bot=interaction.client, user=interaction.user, guild=interaction.guild)
        except Exception as e:
            await log_exception(e, interaction)
