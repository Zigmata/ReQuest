import logging

import discord
import shortuuid
from discord.ui import Container, Section, TextDisplay, Separator, LayoutView, ActionRow

from ReQuest.ui.common import modals as common_modals
from ReQuest.ui.common.buttons import MenuViewButton, MenuDoneButton, BackButton
from ReQuest.ui.player import buttons, selects
from ReQuest.utilities.supportFunctions import log_exception, strip_id, attempt_delete, format_currency_display, \
    setup_view

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class PlayerBaseView(LayoutView):
    def __init__(self):
        super().__init__()
        self.player_board_button = MenuViewButton(PlayerBoardView, 'Player Board')

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=MenuDoneButton())
        header_section.add_item(TextDisplay('**Player Commands - Main Menu**'))
        container.add_item(header_section)
        container.add_item(Separator())

        character_section = Section(accessory=MenuViewButton(CharacterBaseView, 'Characters'))
        character_section.add_item(TextDisplay(
            'Register, view, and activate player characters.'
        ))
        container.add_item(character_section)

        inventory_section = Section(accessory=MenuViewButton(InventoryBaseView, 'Inventory'))
        inventory_section.add_item(TextDisplay(
            'View your active character\'s inventory and spend currency.'
        ))
        container.add_item(inventory_section)

        player_board_section = Section(accessory=self.player_board_button)
        player_board_section.add_item(TextDisplay(
            'Create a post for the Player Board'
        ))
        container.add_item(player_board_section)

        self.add_item(container)

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


class CharacterBaseView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(PlayerBaseView))
        header_section.add_item(TextDisplay('**Player Commands - Characters**'))
        container.add_item(header_section)
        container.add_item(Separator())

        register_section = Section(accessory=buttons.RegisterCharacterButton())
        register_section.add_item(TextDisplay(
            'Registers a new character, and activates that character on the current server.'
        ))
        container.add_item(register_section)

        list_activate_section = Section(accessory=MenuViewButton(ListCharactersView, 'List/Activate'))
        list_activate_section.add_item(TextDisplay(
            'Show all registered characters, and change the active character for this server.'
        ))
        container.add_item(list_activate_section)

        remove_section = Section(accessory=MenuViewButton(RemoveCharacterView, 'Remove'))
        remove_section.add_item(TextDisplay(
            'Removes a character permanently.'
        ))
        container.add_item(remove_section)

        self.add_item(container)


class ListCharactersView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.active_character_select = selects.ActiveCharacterSelect(self)
        self.character_list_info = TextDisplay(
            'No Characters Registered.'
        )

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(CharacterBaseView))
        header_section.add_item(TextDisplay('**Player Commands - List Characters**'))
        container.add_item(header_section)
        container.add_item(Separator())

        container.add_item(TextDisplay(
            'Registered Characters are listed below. Select a character from the dropdown to activate that character '
            'for this server.'
        ))
        container.add_item(Separator())

        container.add_item(self.character_list_info)
        container.add_item(Separator())

        character_select_row = ActionRow(self.active_character_select)
        container.add_item(character_select_row)

        self.add_item(container)

    async def setup(self, bot, user, guild):
        try:
            collection = bot.mdb['characters']
            query = await collection.find_one({'_id': user.id})
            if not query or not query['characters']:
                self.character_list_info = 'You have no registered characters!'
            else:
                ids = []
                for character_id in query['characters']:
                    ids.append(character_id)

                character_info = []
                for character_id in ids:
                    character = query['characters'][character_id]
                    if (str(guild.id) in query['activeCharacters']
                            and character_id == query['activeCharacters'][str(guild.id)]):
                        character_info.append(
                            f'**{character['name']}: {character['attributes']['experience']} XP (Active Character)**\n'
                            f'{character['note']}'
                        )
                    else:
                        character_info.append(
                            f'**{character['name']}: {character['attributes']['experience']} XP**\n'
                            f'{character['note']}'
                        )
                    self.character_list_info.content = ('\n\n'.join(character_info))

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


class RemoveCharacterView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.selected_character_id = None
        self.all_characters = {}
        self.active_characters = {}
        self.remove_character_select = selects.RemoveCharacterSelect(self)

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(CharacterBaseView))
        header_section.add_item(TextDisplay('**Player Commands - Remove Character**'))
        container.add_item(header_section)
        container.add_item(Separator())

        container.add_item(TextDisplay(
            'Choose a character from the dropdown below. Confirm to permanently remove that character.'
        ))
        container.add_item(Separator())

        character_select_row = ActionRow(self.remove_character_select)
        container.add_item(character_select_row)

        self.add_item(container)

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
            await interaction.response.edit_message(view=self)
        except Exception as e:
            await log_exception(e, interaction)


class InventoryBaseView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.active_character = None
        self.spend_currency_button = buttons.SpendCurrencyButton(self)
        self.current_inventory_info = TextDisplay(
            'No Inventory Available.'
        )
        self.header_info = TextDisplay(
            '**Player Commands - Inventory**'
        )

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(PlayerBaseView))
        header_section.add_item(self.header_info)
        container.add_item(header_section)
        container.add_item(Separator())

        container.add_item(self.current_inventory_info)
        container.add_item(Separator())

        spend_currency_section = Section(accessory=self.spend_currency_button)
        spend_currency_section.add_item(TextDisplay(
            'Spend some currency.'
        ))
        container.add_item(spend_currency_section)

        self.add_item(container)

    async def setup(self, bot, user, guild):
        collection = bot.mdb['characters']
        query = await collection.find_one({'_id': user.id})

        currency_config = await bot.gdb['currency'].find_one({'_id': guild.id})
        if not query:
            self.spend_currency_button.disabled = True
            self.current_inventory_info.content = 'No Characters: Register a character to use these menus.'
        elif str(guild.id) not in query['activeCharacters']:
            self.spend_currency_button.disabled = True
            self.current_inventory_info.content = (
                'No Active Character: Activate a character for this server to use these menus.'
            )
        else:
            active_character_id = query['activeCharacters'][str(guild.id)]
            self.active_character = query['characters'][active_character_id]
            self.header_info.content = f'**Player Commands - {self.active_character['name']}\'s Inventory**'
            inventory = self.active_character['attributes']['inventory']
            player_currencies = self.active_character['attributes']['currency']
            items = []
            currencies = format_currency_display(player_currencies, currency_config)

            for item in inventory:
                pair = (str(item), f'**{inventory[item]}**')
                value = ': '.join(pair)
                items.append(value)

            self.current_inventory_info.content = (
                f'**Possessions**\n'
                f'{('\n'.join(items) or 'None')}\n\n'
                f'**Currency**\n'
                f'{('\n'.join(currencies) or 'None')}'
            )


class PlayerBoardView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.player_board_channel_id = None
        self.selected_post_id = None
        self.posts = []
        self.selected_post = None

        self.manageable_post_select = selects.ManageablePostSelect(self)

        self.edit_player_post_button = buttons.EditPlayerPostButton(self)
        self.edit_player_post_info = TextDisplay(
            'Edit the selected post.'
        )

        self.remove_player_post_button = buttons.RemovePlayerPostButton(self)
        self.remove_player_post_info = TextDisplay(
            'Remove the selected post.'
        )

        self.build_view()

    def build_view(self):
        container = Container()

        header_section = Section(accessory=BackButton(PlayerBaseView))
        header_section.add_item(TextDisplay('**Player Commands - Player Board**'))
        container.add_item(header_section)
        container.add_item(Separator())

        create_post_section = Section(accessory=buttons.CreatePlayerPostButton(self))
        create_post_section.add_item(TextDisplay(
            'Create a new post for the Player Board.'
        ))
        container.add_item(create_post_section)
        container.add_item(Separator())

        post_select_row = ActionRow(self.manageable_post_select)
        container.add_item(post_select_row)

        edit_post_section = Section(accessory=self.edit_player_post_button)
        edit_post_section.add_item(self.edit_player_post_info)
        container.add_item(edit_post_section)

        remove_post_section = Section(accessory=self.remove_player_post_button)
        remove_post_section.add_item(self.remove_player_post_info)
        container.add_item(remove_post_section)

        self.add_item(container)

    async def setup(self, bot, user, guild):
        try:
            channel_collection = bot.gdb['playerBoardChannel']
            channel_query = await channel_collection.find_one({'_id': guild.id})
            self.player_board_channel_id = strip_id(channel_query['playerBoardChannel'])

            self.posts.clear()
            post_collection = bot.gdb['playerBoard']
            post_cursor = post_collection.find({'guildId': guild.id, 'playerId': user.id})
            async for post in post_cursor:
                self.posts.append(dict(post))

            if self.selected_post_id:
                self.selected_post = next((post for post in self.posts if post['postId'] == self.selected_post_id),
                                          None)

                self.edit_player_post_button.disabled = False
                self.edit_player_post_info.content = (
                    f'Edit `{self.selected_post['postId']}`: {self.selected_post['title']}'
                )

                self.remove_player_post_button.disabled = False
                self.remove_player_post_info.content = (
                    f'Remove `{self.selected_post['postId']}`: {self.selected_post['title']}'
                )
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
            self.manageable_post_select.options.clear()
            self.manageable_post_select.options = options
        except Exception as e:
            await log_exception(e)

    async def select_callback(self, interaction: discord.Interaction):
        try:
            self.selected_post_id = self.manageable_post_select.values[0]
            await setup_view(self, interaction)
            await interaction.response.edit_message(view=self)
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

            # Remove placeholder if present before adding the first real post
            if self.manageable_post_select.disabled:
                self.manageable_post_select.options.clear()
            self.manageable_post_select.options.append(discord.SelectOption(
                label=title,
                value=post_id
            ))
            self.manageable_post_select.disabled = False

            await interaction.response.edit_message(view=self)
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
            confirm_modal = common_modals.ConfirmModal(
                title='Confirm Post Removal',
                prompt_label='WARNING: This action is irreversible!',
                prompt_placeholder='Type CONFIRM to proceed',
                confirm_callback=self.confirm_post_removal
            )
            await interaction.response.send_modal(confirm_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def confirm_post_removal(self, interaction):
        try:
            post = self.selected_post
            post_collection = interaction.client.gdb['playerBoard']
            await post_collection.delete_one({'guildId': interaction.guild.id, 'postId': self.selected_post_id})

            message_id = post['messageId']
            channel = interaction.client.get_channel(self.player_board_channel_id)
            message = channel.get_partial_message(message_id)
            await attempt_delete(message)
            self.selected_post = None
            self.selected_post_id = None

            await setup_view(self, interaction)
            await interaction.response.edit_message(view=self)
        except Exception as e:
            await log_exception(e, interaction)
