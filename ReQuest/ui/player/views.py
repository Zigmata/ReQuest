import logging
import math

import discord
import shortuuid
from discord.ui import Container, Section, TextDisplay, Separator, LayoutView, ActionRow, Button
from titlecase import titlecase

from ReQuest.ui.common import modals as common_modals
from ReQuest.ui.common.buttons import MenuViewButton, MenuDoneButton, BackButton
from ReQuest.ui.player import buttons, selects
from ReQuest.utilities.supportFunctions import log_exception, strip_id, format_currency_display, \
    setup_view, find_currency_or_denomination, update_character_inventory, format_price_string, \
    consolidate_currency_totals, check_sufficient_funds, get_denomination_map, format_consolidated_totals

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
        self.characters = {}
        self.active_character_id = None
        self.sorted_characters = []

        self.items_per_page = 6
        self.current_page = 0
        self.total_pages = 1

    async def setup(self, interaction):
        try:
            collection = interaction.client.mdb['characters']
            query = await collection.find_one({'_id': interaction.user.id})

            self.characters = query.get('characters', {}) if query else {}
            self.active_character_id = query.get('activeCharacters', {}).get(str(interaction.guild_id)) if query else None

            self.sorted_characters = sorted(self.characters.items(), key=lambda x: x[1].get('name', '').lower())

            self.total_pages = math.ceil(len(self.sorted_characters) / self.items_per_page)
            if self.total_pages == 0:
                self.total_pages = 1

            if self.current_page >= self.total_pages:
                self.current_page = max(0, self.total_pages - 1)

            self.build_view()
        except Exception as e:
            await log_exception(e, interaction)

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(PlayerBaseView))
        header_section.add_item(TextDisplay('**Player Commands - Characters**'))
        container.add_item(header_section)
        container.add_item(Separator())

        register_section = Section(accessory=buttons.RegisterCharacterButton(self))
        register_section.add_item(TextDisplay("Register a new character."))
        container.add_item(register_section)
        container.add_item(Separator())

        if not self.sorted_characters:
            container.add_item(TextDisplay("You have no characters registered."))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = self.sorted_characters[start:end]

            for character_id, character_data in page_items:
                is_active = (character_id == self.active_character_id)

                name = character_data.get('name')
                note = character_data.get('note', '')
                xp = character_data.get('attributes', {}).get('experience', 0)

                display_name = f"**{name}**"
                if is_active:
                    display_name += " (Active)"

                info_text = f"{display_name}"
                if xp and xp > 0:
                    info_text += f" - {xp} XP"
                if note:
                    info_text += f"\n*{note}*"

                actions = ActionRow()

                activate_button = buttons.ActivateCharacterButton(self, character_id, disabled=is_active)
                if is_active:
                    activate_button.label = "Active"
                    activate_button.style = discord.ButtonStyle.success

                actions.add_item(activate_button)
                actions.add_item(buttons.RemoveCharacterButton(self, character_id, name))

                container.add_item(TextDisplay(info_text))
                container.add_item(actions)

        self.add_item(container)

        if self.total_pages > 1:
            nav_row = ActionRow()

            prev_button = Button(
                label='Previous',
                style=discord.ButtonStyle.secondary,
                custom_id='char_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_display = Button(
                label=f'Page {self.current_page + 1}/{self.total_pages}',
                style=discord.ButtonStyle.secondary,
                custom_id='char_page_disp'
            )
            page_display.callback = self.show_page_jump_modal
            nav_row.add_item(page_display)

            next_button = Button(
                label='Next',
                style=discord.ButtonStyle.secondary,
                custom_id='char_next',
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
        self.active_character_id = None
        self.spend_currency_button = buttons.SpendCurrencyButton(self)
        self.consume_item_button = buttons.ConsumeItemButton(self)
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

        consume_item_section = Section(accessory=self.consume_item_button)
        consume_item_section.add_item(TextDisplay(
            'Consume or destroy an item from your inventory.'
        ))
        container.add_item(consume_item_section)

        self.add_item(container)

    async def setup(self, interaction: discord.Interaction):
        collection = interaction.client.mdb['characters']
        guild_id = interaction.guild_id
        query = await collection.find_one({'_id': interaction.user.id})

        currency_config = await interaction.client.gdb['currency'].find_one({'_id': guild_id})
        if not query:
            self.spend_currency_button.disabled = True
            self.consume_item_button.disabled = True
            self.current_inventory_info.content = 'No Characters: Register a character to use these menus.'
        elif str(guild_id) not in query['activeCharacters']:
            self.spend_currency_button.disabled = True
            self.consume_item_button.disabled = True
            self.current_inventory_info.content = (
                'No Active Character: Activate a character for this server to use these menus.'
            )
        else:
            self.active_character_id = query['activeCharacters'][str(guild_id)]
            self.active_character = query['characters'][self.active_character_id]
            self.header_info.content = f'**Player Commands - {self.active_character['name']}\'s Inventory**'

            # Validate currencies in inventory and convert based on server config
            inventory_keys_to_check = list(self.active_character['attributes']['inventory'].keys())

            if inventory_keys_to_check and currency_config:
                conversion_occurred = False

                for item_name_key in inventory_keys_to_check:
                    quantity = self.active_character['attributes']['inventory'].get(item_name_key)

                    is_currency, _ = find_currency_or_denomination(currency_config, item_name_key)

                    if is_currency:
                        await update_character_inventory(
                            interaction,
                            interaction.user.id,
                            self.active_character_id,
                            item_name_key,
                            float(quantity)
                        )

                        await collection.update_one(
                            {'_id': interaction.user.id},
                            {'$unset': {
                                f'characters.{self.active_character_id}.attributes.inventory.{item_name_key}': ''
                            }}
                        )

                        conversion_occurred = True

                if conversion_occurred:
                    query = await collection.find_one({'_id': interaction.user.id})
                    self.active_character = query['characters'][self.active_character_id]

            inventory = self.active_character['attributes']['inventory']
            player_currencies = self.active_character['attributes']['currency']
            items = []
            currencies = format_currency_display(player_currencies, currency_config)

            for item in inventory:
                pair = (str(item), f'**{inventory[item]}**')
                value = ': '.join(pair)
                items.append(value)

            if items:
                self.consume_item_button.disabled = False
            else:
                self.consume_item_button.disabled = True

            if currencies:
                self.spend_currency_button.disabled = False
            else:
                self.spend_currency_button.disabled = True

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
        self.posts = []

        self.items_per_page = 6
        self.current_page = 0
        self.total_pages = 1

    async def setup(self, bot, user, guild):
        try:
            channel_collection = bot.gdb['playerBoardChannel']
            channel_query = await channel_collection.find_one({'_id': guild.id})
            self.player_board_channel_id = strip_id(channel_query['playerBoardChannel']) if channel_query else None

            self.posts = []
            post_collection = bot.gdb['playerBoard']
            post_cursor = post_collection.find({'guildId': guild.id, 'playerId': user.id})
            async for post in post_cursor:
                self.posts.append(dict(post))

            # Sort by newest first
            self.posts.sort(key=lambda x: x.get('timestamp', 0), reverse=True)

            self.total_pages = math.ceil(len(self.posts) / self.items_per_page)
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

        if not self.posts:
            container.add_item(TextDisplay("You don't have any current posts."))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_posts = self.posts[start:end]

            for post in page_posts:
                title = post.get('title', 'Untitled')
                post_id = post.get('postId', 'Unknown')

                info_text = f"**{title}** (ID: `{post_id}`)"

                actions = ActionRow()
                actions.add_item(buttons.EditPlayerPostButton(self, post))
                actions.add_item(buttons.RemovePlayerPostButton(self, post))

                container.add_item(TextDisplay(info_text))
                container.add_item(actions)

        self.add_item(container)

        # Pagination
        if self.total_pages > 1:
            nav_row = ActionRow()

            prev_button = Button(
                label='Previous',
                style=discord.ButtonStyle.secondary,
                custom_id='pb_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_display = Button(
                label=f'Page {self.current_page + 1}/{self.total_pages}',
                style=discord.ButtonStyle.secondary,
                custom_id='pb_page_disp'
            )
            page_display.callback = self.show_page_jump_modal
            nav_row.add_item(page_display)

            next_button = Button(
                label='Next',
                style=discord.ButtonStyle.secondary,
                custom_id='pb_next',
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
            if not channel:
                raise Exception("Player Board channel not found.")

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

            await setup_view(self, interaction)
            await interaction.response.edit_message(view=self)
        except Exception as e:
            await log_exception(e, interaction)

    async def edit_post(self, post, new_title, new_content, interaction):
        try:
            post_collection = interaction.client.gdb['playerBoard']
            await post_collection.update_one(
                {'guildId': interaction.guild_id, 'postId': post['postId']},
                {'$set': {'title': new_title, 'content': new_content}}
            )

            channel_id = self.player_board_channel_id
            message_id = post['messageId']
            if channel_id:
                channel = interaction.client.get_channel(channel_id)
                if channel:
                    try:
                        message = channel.get_partial_message(message_id)

                        embed = discord.Embed(
                            title=new_title,
                            description=new_content,
                            type='rich'
                        )
                        embed.add_field(name='Author', value=interaction.user.mention)
                        embed.set_footer(text=f'Post ID: {post["postId"]}')

                        await message.edit(embed=embed)
                    except discord.NotFound:
                        logger.error("Player Board message not found for editing.")
                    except Exception as e:
                        logger.error(f"Failed to edit Player Board message: {e}")

            await setup_view(self, interaction)
            await interaction.response.edit_message(view=self)
        except Exception as e:
            await log_exception(e, interaction)


class NewCharacterWizardView(LayoutView):
    def __init__(self, character_id, character_name, inventory_type):
        super().__init__(timeout=None)
        self.character_id = character_id
        self.character_name = character_name
        self.inventory_type = inventory_type

        self.build_view()

    def build_view(self):
        container = Container()
        container.add_item(TextDisplay(f"**Setup Inventory for {self.character_name}**"))
        container.add_item(Separator())

        description = ""
        action_row = ActionRow()

        if self.inventory_type in ['selection', 'purchase']:
            description = "Browse the Starting Shop to equip your character."
            action_row.add_item(buttons.OpenStartingShopButton(self))
        elif self.inventory_type == 'static':
            description = "Select a Starting Kit."
            action_row.add_item(buttons.SelectStaticKitButton(self))
        elif self.inventory_type == 'open':
            description = "Manually input your starting inventory."
            action_row.add_item(buttons.OpenInventoryInputButton(self))

        container.add_item(TextDisplay(description))
        container.add_item(action_row)

        self.add_item(container)

    async def submit_open_inventory(self, interaction, items):
        await _handle_submission(interaction, self.character_id, self.character_name, items, {})


class StaticKitSelectView(LayoutView):
    def __init__(self, character_id, character_name):
        super().__init__(timeout=None)
        self.character_id = character_id
        self.character_name = character_name
        self.kits = {}
        self.currency_config = None
        self.sorted_kits = []

        self.items_per_page = 11
        self.current_page = 0
        self.total_pages = 1

    async def setup(self, interaction):
        bot = interaction.client
        collection = bot.gdb['staticKits']
        query = await collection.find_one({'_id': interaction.guild_id})
        self.kits = query.get('kits', {}) if query else {}

        # Sort kits by name
        self.sorted_kits = sorted(self.kits.items(), key=lambda x: x[1].get('name', '').lower())
        self.total_pages = math.ceil(len(self.sorted_kits) / self.items_per_page)

        self.currency_config = await bot.gdb['currency'].find_one({'_id': interaction.guild_id})

        self.build_view()

    def build_view(self):
        self.clear_items()
        container = Container()

        container.add_item(TextDisplay(f'**Select a Kit for {self.character_name}**'))
        container.add_item(Separator())

        if not self.sorted_kits:
            container.add_item(TextDisplay('No starting kits are available.'))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = self.sorted_kits[start:end]

            for kit_id, kit_data in page_items:
                select_button = buttons.SelectKitOptionButton(kit_id, kit_data)
                section = Section(accessory=select_button)

                kit_name = kit_data.get('name', 'Unknown Kit')
                description = kit_data.get('description', '')

                content_lines = [f'**{titlecase(kit_name)}**']
                if description:
                    content_lines.append(f'*{description}*')

                # Preview Contents
                items = kit_data.get('items', [])
                currency = kit_data.get('currency', {})

                preview_list = []
                for item in items[:3]:  # Show first 3 items
                    preview_list.append(f'{item.get("quantity", 1)}x {titlecase(item.get("name", ""))}')
                if len(items) > 3:
                    preview_list.append(f'...and {len(items) - 3} more items')

                if currency:
                    currency_strings = format_consolidated_totals(currency, self.currency_config)
                    preview_list.extend(currency_strings)

                if preview_list:
                    content_lines.append(f'> {", ".join(preview_list)}')
                else:
                    content_lines.append('> *Empty Kit*')

                section.add_item(TextDisplay('\n'.join(content_lines)))
                container.add_item(section)

        self.add_item(container)

        # Pagination
        if self.total_pages > 1:
            nav_row = ActionRow()
            prev_button = Button(
                label='Prev',
                style=discord.ButtonStyle.secondary,
                custom_id='kit_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page

            page_display = Button(
                label=f'Page {self.current_page + 1}/{self.total_pages}',
                style=discord.ButtonStyle.secondary,
                custom_id='kit_page_display'
            )
            page_display.callback = self.show_page_jump_modal

            next_button = Button(
                label='Next',
                style=discord.ButtonStyle.secondary,
                custom_id='kit_next',
                disabled=(self.current_page >= self.total_pages - 1)
            )
            next_button.callback = self.next_page

            nav_row.add_item(prev_button)
            nav_row.add_item(page_display)
            nav_row.add_item(next_button)

            self.add_item(nav_row)

    async def prev_page(self, interaction):
        self.current_page -= 1
        self.build_view()
        await interaction.response.edit_message(view=self)

    async def next_page(self, interaction):
        self.current_page += 1
        self.build_view()
        await interaction.response.edit_message(view=self)

    async def show_page_jump_modal(self, interaction):
        try:
            await interaction.response.send_modal(common_modals.PageJumpModal(self))
        except Exception as e:
            await log_exception(e, interaction)


class StaticKitConfirmView(LayoutView):
    def __init__(self, character_id, character_name, kit_id, kit_data, currency_config):
        super().__init__(timeout=None)
        self.character_id = character_id
        self.character_name = character_name
        self.kit_id = kit_id
        self.kit_data = kit_data
        self.currency_config = currency_config

        self.build_view()

    def build_view(self):
        self.clear_items()
        container = Container()

        container.add_item(TextDisplay(f'**Confirm Selection: {titlecase(self.kit_data.get("name"))}**'))
        container.add_item(Separator())

        description = self.kit_data.get('description')
        if description:
            container.add_item(TextDisplay(description))
            container.add_item(Separator())

        items = self.kit_data.get('items', [])
        currency = self.kit_data.get('currency', {})

        details = []
        if items:
            details.append('**Items:**')
            for item in items:
                details.append(f'- {item.get("quantity", 1)}x {titlecase(item.get("name"))}')

        if currency:
            details.append('\n**Currency:**')
            curr_strs = format_consolidated_totals(currency, self.currency_config)
            for s in curr_strs:
                details.append(f'- {s}')

        if not details:
            details.append('This kit is empty.')

        container.add_item(TextDisplay('\n'.join(details)))
        container.add_item(Separator())

        actions = ActionRow()
        actions.add_item(buttons.KitConfirmButton())
        actions.add_item(buttons.KitBackButton())
        container.add_item(actions)

        self.add_item(container)

    async def submit(self, interaction):
        items = {item['name']: item['quantity'] for item in self.kit_data.get('items', [])}
        currency = self.kit_data.get('currency', {})
        await _handle_submission(interaction, self.character_id, self.character_name, items, currency)


class NewCharacterShopView(LayoutView):
    def __init__(self, character_id, character_name, inventory_type):
        super().__init__(timeout=None)
        self.character_id = character_id
        self.character_name = character_name
        self.inventory_type = inventory_type
        self.shop_stock = []
        self.cart = {}

        self.items_per_page = 11
        self.current_page = 0
        self.total_pages = 1

        self.currency_config = None
        self.starting_wealth = None

    async def setup(self, interaction):
        guild_id = interaction.guild_id
        bot = interaction.client

        shop_query = await bot.gdb['newCharacterShop'].find_one({'_id': guild_id})
        self.shop_stock = shop_query.get('shopStock', []) if shop_query else []
        self.total_pages = math.ceil(len(self.shop_stock) / self.items_per_page)

        self.currency_config = await bot.gdb['currency'].find_one({'_id': guild_id})

        if self.inventory_type == 'purchase':
            inventory_config = await bot.gdb['inventoryConfig'].find_one({'_id': guild_id})
            self.starting_wealth = inventory_config.get('newCharacterWealth') if inventory_config else None

        self.build_view()

    def build_view(self):
        self.clear_items()
        container = Container()

        title = f'**Starting Shop ({self.inventory_type.capitalize()})**'
        if self.starting_wealth:
            amount = self.starting_wealth.get('amount', 0)
            currency = self.starting_wealth.get('currency', '')
            formatted_currency = format_price_string(amount, currency, self.currency_config)
            title += f'\nStarting Wealth: {formatted_currency}'

        container.add_item(TextDisplay(title))
        container.add_item(Separator())

        start = self.current_page * self.items_per_page
        end = start + self.items_per_page
        stock_slice = self.shop_stock[start:end]

        for item in stock_slice:
            section = Section(accessory=buttons.WizardItemButton(item, self.inventory_type))

            display = f'**{item["name"]}**'
            if item.get('quantity', 1) > 1:
                display += f'(x{item.get("quantity", 1)})'

            if item_name := item.get('name'):
                if item_name in self.cart:
                    display += f" **(In Cart: {self.cart[item_name]['quantity']})**"

            if description := item.get('description'):
                display += f"\n*{description}*"

            section.add_item(TextDisplay(display))
            container.add_item(section)

        self.add_item(container)

        nav_row = ActionRow()
        if self.total_pages > 1:
            prev_button = Button(
                label='Prev',
                style=discord.ButtonStyle.secondary,
                custom_id='wiz_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page

            next_button = Button(
                label='Next',
                style=discord.ButtonStyle.secondary,
                custom_id='wiz_next',
                disabled=(self.current_page >= self.total_pages - 1)
            )
            next_button.callback = self.next_page

            nav_row.add_item(prev_button)
            nav_row.add_item(next_button)

        cart_count = sum(x['quantity'] for x in self.cart.values())
        nav_row.add_item(buttons.WizardViewCartButton(self, cart_count))
        self.add_item(nav_row)

    async def add_to_cart(self, interaction, item):
        name = item['name']
        if name in self.cart:
            self.cart[name]['quantity'] += 1
        else:
            self.cart[name] = {'item': item, 'quantity': 1}
        self.build_view()
        await interaction.response.edit_message(view=self)

    async def prev_page(self, interaction):
        self.current_page -= 1
        self.build_view()
        await interaction.response.edit_message(view=self)

    async def next_page(self, interaction):
        self.current_page += 1
        self.build_view()
        await interaction.response.edit_message(view=self)


class NewCharacterCartView(LayoutView):
    def __init__(self, shop_view: NewCharacterShopView):
        super().__init__(timeout=None)
        self.shop_view = shop_view
        self.can_afford = True
        self.cart_items = {}
        self.remaining_wealth = {}

        self.items_per_page = 8
        self.current_page = 0
        self.total_pages = 1

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=buttons.WizardKeepShoppingButton(self.shop_view))
        header_section.add_item(TextDisplay('**Review Cart**'))
        container.add_item(header_section)
        container.add_item(Separator())

        total_cost_raw = {}
        self.cart_items = {}

        for name, data in self.shop_view.cart.items():
            item = data['item']
            quantity = data['quantity']
            quantity_per_purchase = item.get('quantity', 1)
            total_quantity = quantity * quantity_per_purchase

            self.cart_items[name] = total_quantity

            if self.shop_view.inventory_type == 'purchase':
                cost = quantity * item.get('price', 0)
                if cost > 0:
                    currency = item.get('currency')
                    total_cost_raw[currency] = total_cost_raw.get(currency, 0) + cost

        self.can_afford = True
        warnings = []
        consolidated_costs = {}

        if self.shop_view.inventory_type == 'purchase':
            consolidated_costs = consolidate_currency_totals(total_cost_raw, self.shop_view.currency_config)

            starting_wealth = self.shop_view.starting_wealth or {}
            wallet = {}
            if starting_wealth:
                wallet[starting_wealth.get('currency')] = starting_wealth.get('amount', 0)

            for base_currency, amount in consolidated_costs.items():
                is_ok, _ = check_sufficient_funds(wallet, self.shop_view.currency_config, base_currency, amount)
                if not is_ok:
                    self.can_afford = False
                    warnings.append(f'Insufficient {titlecase(base_currency)}')

            final_currency = {}

            if starting_wealth:
                starting_currency = starting_wealth.get('currency')
                starting_amount = starting_wealth.get('amount', 0)

                denomination_map, base = get_denomination_map(self.shop_view.currency_config, starting_currency)
                value_in_base = starting_amount * denomination_map.get(starting_currency.lower(), 1)

                total_cost_in_base = consolidated_costs.get(base.lower(), 0)

                remaining_in_base = value_in_base - total_cost_in_base

                final_currency[base] = remaining_in_base

                self.remaining_wealth = final_currency

        cart_items = list(self.shop_view.cart.items())
        self.total_pages = math.ceil(len(cart_items) / self.items_per_page)

        if self.current_page >= self.total_pages and self.current_page > 0:
            self.current_page = max(0, self.total_pages - 1)

        if not cart_items:
            container.add_item(TextDisplay('Your cart is empty.'))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = cart_items[start:end]

            for name, data in page_items:
                item = data['item']
                quantity = data['quantity']
                quantity_per_purchase = item.get('quantity', 1)
                total_quantity = quantity * quantity_per_purchase

                display = f'**{name}** x{quantity}'
                if quantity_per_purchase > 1:
                    display += f' (Total: {total_quantity})'

                if self.shop_view.inventory_type == 'purchase':
                    cost = quantity * float(item.get('price', 0))
                    if cost > 0:
                        currency = item.get('currency')
                        price_label = format_price_string(cost, currency, self.shop_view.currency_config)
                        display += f' - {price_label}'

                edit_button = buttons.WizardEditCartItemButton(name, quantity)
                section = Section(accessory=edit_button)
                section.add_item(TextDisplay(display))
                container.add_item(section)

        container.add_item(Separator())

        if warnings:
            container.add_item(TextDisplay("\n".join(warnings)))
            container.add_item(Separator())

        if self.shop_view.inventory_type == 'purchase':
            totals = format_consolidated_totals(consolidated_costs, self.shop_view.currency_config)
            if totals:
                container.add_item(TextDisplay(f'**Total Cost:**\n{", ".join(totals)}'))
            else:
                container.add_item(TextDisplay('**Total Cost:** Free'))

        self.add_item(container)

        nav_row = ActionRow()
        if self.total_pages > 1:
            prev_button = Button(
                label='Prev',
                style=discord.ButtonStyle.secondary,
                custom_id='wiz_cart_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page

            page_display = Button(
                label=f'Page {self.current_page + 1} of {self.total_pages}',
                style=discord.ButtonStyle.secondary,
                custom_id='wiz_cart_page_display'
            )
            page_display.callback = self.show_page_jump_modal

            next_button = Button(
                label='Next',
                style=discord.ButtonStyle.secondary,
                custom_id='wiz_cart_next',
                disabled=(self.current_page >= self.total_pages - 1)
            )
            next_button.callback = self.next_page


            nav_row.add_item(prev_button)
            nav_row.add_item(page_display)
            nav_row.add_item(next_button)

        submit_button = buttons.WizardSubmitButton(self)
        submit_button.disabled = not self.can_afford or not self.cart_items
        nav_row.add_item(submit_button)
        clear_cart_button = buttons.WizardClearCartButton(self)
        clear_cart_button.disabled = not self.cart_items
        nav_row.add_item(clear_cart_button)

        self.add_item(nav_row)

    async def prev_page(self, interaction):
        self.current_page -= 1
        self.build_view()
        await interaction.response.edit_message(view=self)

    async def next_page(self, interaction):
        self.current_page += 1
        self.build_view()
        await interaction.response.edit_message(view=self)

    async def show_page_jump_modal(self, interaction):
        try:
            await interaction.response.send_modal(common_modals.PageJumpModal(self))
        except Exception as e:
            await log_exception(e, interaction)

    async def submit(self, interaction):
        currency_to_give = self.remaining_wealth if self.shop_view.inventory_type == 'purchase' else {}

        await _handle_submission(interaction, self.shop_view.character_id, self.shop_view.character_name,
                                 self.cart_items, currency_to_give)


async def _handle_submission(interaction, character_id, character_name, items, currency):
    try:
        guild_id = interaction.guild_id
        bot = interaction.client
        currency_config = await bot.gdb['currency'].find_one({'_id': guild_id})

        approval_query = await bot.gdb['approvalQueueChannel'].find_one({'_id': guild_id})
        channel_id = strip_id(approval_query['approvalQueueChannel']) if approval_query else None
        forum_channel = bot.get_channel(channel_id) if channel_id else None

        submission_data = {
            'guild_id': guild_id,
            'user_id': interaction.user.id,
            'character_id': character_id,
            'character_name': character_name,
            'items': items,
            'currency': currency,
            'status': 'pending',
            'timestamp': discord.utils.utcnow()
        }

        if forum_channel and isinstance(forum_channel, discord.ForumChannel):
            # Create Embed for Forum Post
            embed = discord.Embed(
                title=f'Inventory Approval: {character_name}',
                description=f'Submitted by {interaction.user.mention}',
                color=discord.Color.blue()
            )
            embed.set_author(name=interaction.user.display_name,
                             icon_url=interaction.user.avatar.url if interaction.user.avatar else None)

            item_labels = [f'{k}: {v}' for k, v in items.items()]
            embed.add_field(name='Items', value='\n'.join(item_labels) or 'None', inline=False)

            currency_labels = format_consolidated_totals(currency, currency_config)
            embed.add_field(name='Currency', value='\n'.join(currency_labels) or 'None', inline=False)

            submission_id = shortuuid.uuid()[:8]
            embed.set_footer(text=f'Submission ID: {submission_id}')

            # Create Thread
            thread_name = f'Approval: {character_name}'
            thread_message = await forum_channel.create_thread(name=thread_name, embed=embed)

            # Store submission in DB (Needed for GM to approve later)
            submission_data['thread_id'] = thread_message.thread.id
            submission_data['submission_id'] = submission_id

            await bot.gdb['approvals'].insert_one(submission_data)

            await interaction.response.edit_message(view=CharacterBaseView())

            confirmation_embed = discord.Embed(
                title='Inventory Submission Sent',
                description=(
                    f'Your submission for **{character_name}** has been sent to the GM team for approval! '
                    f'You will be notified once it has been reviewed.\n'
                    f'[View Submission Thread]({thread_message.thread.jump_url})'
                ),
                color=discord.Color.green()
            )
            await interaction.followup.send(embed=confirmation_embed, ephemeral=True)

        else:
            for name, quantity in items.items():
                await update_character_inventory(interaction, interaction.user.id, character_id, name, quantity)

            for name, quantity in currency.items():
                await update_character_inventory(interaction, interaction.user.id, character_id, name, quantity)


            report_embed = discord.Embed(title='Starting Inventory Applied', color=discord.Color.green())
            report_embed.description = (
                f'Player: {interaction.user.mention} as `{character_name}`\n'
            )

            added_items_summary = []
            for name, quantity in items.items():
                quantity_label = f'{quantity}x ' if quantity > 1 else ''
                added_items_summary.append(f'{quantity_label}{titlecase(name)}')

            report_embed.add_field(name='Items Received', value='\n'.join(added_items_summary) or 'None', inline=False)

            currency_labels = format_consolidated_totals(currency, currency_config)
            report_embed.add_field(name='Currency Received', value='\n'.join(currency_labels) or 'None', inline=False)

            report_embed.set_footer(text=f'Transaction ID: {shortuuid.uuid()[:12]}')

            await interaction.response.edit_message(view=CharacterBaseView())
            await interaction.followup.send(embed=report_embed, ephemeral=True)

    except Exception as e:
        await log_exception(e, interaction)
