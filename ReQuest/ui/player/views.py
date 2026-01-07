import logging
import math

import discord
import shortuuid
from discord.ui import (
    Container,
    Section,
    TextDisplay,
    Separator,
    LayoutView,
    ActionRow,
    Button
)
from titlecase import titlecase

from ReQuest.ui.common import modals as common_modals
from ReQuest.ui.common.buttons import MenuViewButton, MenuDoneButton, BackButton
from ReQuest.ui.player import buttons, selects
from ReQuest.utilities.supportFunctions import (
    log_exception,
    strip_id,
    format_currency_display,
    setup_view,
    find_currency_or_denomination,
    update_character_inventory,
    format_price_string,
    consolidate_currency_totals,
    check_sufficient_funds,
    get_denomination_map,
    format_consolidated_totals,
    get_xp_config,
    UserFeedbackError,
    get_cached_data,
    update_cached_data,
    build_cache_key,
    format_complex_cost,
    get_containers_sorted,
    get_container_name,
    get_container_items,
    escape_markdown,
    decode_mongo_key
)

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

        inventory_section = Section(accessory=MenuViewButton(InventoryOverviewView, 'Inventory'))
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
            channel_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='playerBoardChannel',
                query={'_id': guild.id}
            )
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
        self.xp_enabled = True

        self.items_per_page = 6
        self.current_page = 0
        self.total_pages = 1

    async def setup(self, interaction):
        try:
            bot = interaction.client
            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': interaction.user.id}
            )

            self.characters = query.get('characters', {}) if query else {}
            self.active_character_id = query.get('activeCharacters', {}).get(str(interaction.guild_id)) \
                if query else None

            self.sorted_characters = sorted(self.characters.items(), key=lambda x: x[1].get('name', '').lower())

            self.total_pages = math.ceil(len(self.sorted_characters) / self.items_per_page)
            if self.total_pages == 0:
                self.total_pages = 1

            if self.current_page >= self.total_pages:
                self.current_page = max(0, self.total_pages - 1)

            self.xp_enabled = await get_xp_config(interaction.client, interaction.guild_id)

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
                if self.xp_enabled and xp and xp > 0:
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


class InventoryOverviewView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.active_character = None
        self.active_character_id = None
        self.containers = []
        self.currencies = []
        self.currency_config = None

        # Pagination for containers
        self.items_per_page = 25
        self.current_page = 0
        self.total_pages = 1

    async def setup(self, interaction: discord.Interaction):
        bot = interaction.client
        guild_id = interaction.guild_id
        query = await get_cached_data(
            bot=bot,
            mongo_database=bot.mdb,
            collection_name='characters',
            query={'_id': interaction.user.id}
        )

        self.currency_config = await get_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name='currency',
            query={'_id': guild_id}
        )

        if not query:
            self.active_character = None
            self.active_character_id = None
        elif str(guild_id) not in query.get('activeCharacters', {}):
            self.active_character = None
            self.active_character_id = None
        else:
            self.active_character_id = query['activeCharacters'][str(guild_id)]
            self.active_character = query['characters'][self.active_character_id]

            # Validate currencies in inventory and convert based on server config
            inventory_keys_to_check = list(self.active_character['attributes'].get('inventory', {}).keys())

            if inventory_keys_to_check and self.currency_config:
                conversion_occurred = False

                for item_name_key in inventory_keys_to_check:
                    quantity = self.active_character['attributes']['inventory'].get(item_name_key)
                    is_currency, _ = find_currency_or_denomination(self.currency_config, item_name_key)

                    if is_currency:
                        await update_character_inventory(
                            interaction,
                            interaction.user.id,
                            self.active_character_id,
                            item_name_key,
                            float(quantity)
                        )

                        # In the event a currency was given prior to being defined (and therefore stored as an item),
                        # this second update removes the old entry from inventory and updates the currency dict
                        inventory = self.active_character['attributes'].get('inventory', {})
                        if item_name_key in inventory:
                            del inventory[item_name_key]  # Update local copy
                            inv_path = f'characters.{self.active_character_id}.attributes.inventory'
                            collection = bot.mdb['characters']
                            await collection.update_one(
                                {'_id': interaction.user.id},
                                [
                                    {
                                        '$set': {
                                            inv_path: {
                                                '$arrayToObject': {
                                                    '$filter': {
                                                        'input': {'$objectToArray': f'${inv_path}'},
                                                        'cond': {'$ne': ['$$this.k', item_name_key]}
                                                    }
                                                }
                                            }
                                        }
                                    }
                                ]
                            )

                            # Invalidate cache after direct collection update
                            cache_key = build_cache_key(bot.mdb.name, interaction.user.id, 'characters')
                            try:
                                await bot.rdb.delete(cache_key)
                            except Exception as e:
                                logger.error(f"Redis delete failed: {e}")
                        conversion_occurred = True

                if conversion_occurred:
                    query = await get_cached_data(
                        bot=bot,
                        mongo_database=bot.mdb,
                        collection_name='characters',
                        query={'_id': interaction.user.id}
                    )
                    self.active_character = query['characters'][self.active_character_id]

            # Get containers
            self.containers = get_containers_sorted(self.active_character)

            # Calculate pagination
            self.total_pages = math.ceil(len(self.containers) / self.items_per_page)
            if self.total_pages == 0:
                self.total_pages = 1
            if self.current_page >= self.total_pages:
                self.current_page = max(0, self.total_pages - 1)

            # Get currencies
            player_currencies = self.active_character['attributes'].get('currency', {})
            self.currencies = format_currency_display(player_currencies, self.currency_config)

        self.build_view()

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=BackButton(PlayerBaseView))

        if not self.active_character:
            header_section.add_item(TextDisplay('**Player Commands - Inventory**'))
            container.add_item(header_section)
            container.add_item(Separator())

            if self.active_character_id is None:
                container.add_item(TextDisplay(
                    'No Active Character: Activate a character for this server to use these menus.'
                ))
            else:
                container.add_item(TextDisplay(
                    'No Characters: Register a character to use these menus.'
                ))

            self.add_item(container)
            return

        header_section.add_item(TextDisplay(
            f"**{self.active_character['name']}'s Inventory**"
        ))
        container.add_item(header_section)
        container.add_item(Separator())

        # Build container summary
        summary_lines = []
        total_items = 0
        for c in self.containers:
            summary_lines.append(f"**{c['name']}** — {c['count']} items")
            total_items += c['count']

        if self.currencies:
            summary_lines.append('')
            summary_lines.append('**Currency**')
            summary_lines.extend(self.currencies)

        container.add_item(TextDisplay('\n'.join(summary_lines) if summary_lines else 'Inventory is empty.'))
        container.add_item(Separator())

        # Container select (paginated)
        start = self.current_page * self.items_per_page
        end = start + self.items_per_page
        page_containers = self.containers[start:end]

        container_select_row = ActionRow()
        container_select = selects.ContainerOverviewSelect(self, page_containers, self.current_page)
        container_select_row.add_item(container_select)
        container.add_item(container_select_row)

        self.add_item(container)

        # Action buttons row
        action_row = ActionRow()
        action_row.add_item(buttons.ManageContainersButton(self))

        spend_button = buttons.SpendCurrencyButton(self)
        spend_button.disabled = not self.currencies
        action_row.add_item(spend_button)

        print_button = buttons.PrintInventoryButton(self)
        print_button.disabled = (total_items == 0 and not self.currencies) or not self.active_character
        action_row.add_item(print_button)

        self.add_item(action_row)

        # Pagination row (if needed)
        if self.total_pages > 1:
            nav_row = ActionRow()

            prev_button = Button(
                label='Previous',
                style=discord.ButtonStyle.secondary,
                custom_id='inv_overview_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_button = Button(
                label=f'Page {self.current_page + 1}/{self.total_pages}',
                style=discord.ButtonStyle.secondary,
                custom_id='inv_overview_page'
            )
            page_button.callback = self.show_page_jump_modal
            nav_row.add_item(page_button)

            next_button = Button(
                label='Next',
                style=discord.ButtonStyle.secondary,
                custom_id='inv_overview_next',
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


class ContainerItemsView(LayoutView):
    def __init__(self, character_id: str, character_data: dict, container_id: str | None):
        super().__init__(timeout=None)
        self.character_id = character_id
        self.character_data = character_data
        self.container_id = container_id
        self.container_name = 'Loose Items'

        self.selected_item = None
        self.items = []

        self.items_per_page = 25
        self.current_page = 0
        self.total_pages = 1

    async def setup(self, interaction: discord.Interaction):
        # Refresh character data
        bot = interaction.client
        player_data = await get_cached_data(
            bot=bot,
            mongo_database=bot.mdb,
            collection_name='characters',
            query={'_id': interaction.user.id}
        )

        self.character_data = player_data['characters'][self.character_id]

        self.container_name = get_container_name(self.character_data, self.container_id)
        items_dict = get_container_items(self.character_data, self.container_id)

        # Convert to sorted list of tuples
        self.items = sorted(items_dict.items(), key=lambda x: x[0].lower())

        self.total_pages = math.ceil(len(self.items) / self.items_per_page)
        if self.total_pages == 0:
            self.total_pages = 1
        if self.current_page >= self.total_pages:
            self.current_page = max(0, self.total_pages - 1)

        # Clear selection if item no longer exists
        if self.selected_item:
            item_names_lower = [name.lower() for name, _ in self.items]
            if self.selected_item.lower() not in item_names_lower:
                self.selected_item = None

        self.build_view()

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=buttons.BackToInventoryOverviewButton())
        header_section.add_item(TextDisplay(f'**{self.container_name}**'))
        container.add_item(header_section)
        container.add_item(Separator())

        if not self.items:
            container.add_item(TextDisplay('This container is empty.'))
        else:
            # Display items on current page
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = self.items[start:end]

            items_display = []
            for item_name, quantity in page_items:
                items_display.append(f'• {item_name}: **{quantity}**')

            container.add_item(TextDisplay('\n'.join(items_display)))
            container.add_item(Separator())

            # Item select
            item_select_row = ActionRow()
            item_select = selects.ContainerItemSelect(self, page_items, self.current_page)
            item_select_row.add_item(item_select)
            container.add_item(item_select_row)

            if self.selected_item:
                container.add_item(TextDisplay(f'Selected: **{self.selected_item}**'))

        self.add_item(container)

        # Action buttons
        action_row = ActionRow()

        consume_button = buttons.ConsumeFromContainerButton(self)
        consume_button.disabled = self.selected_item is None
        action_row.add_item(consume_button)

        move_button = buttons.MoveItemButton(self)
        move_button.disabled = self.selected_item is None
        action_row.add_item(move_button)

        self.add_item(action_row)

        # Pagination
        if self.total_pages > 1:
            nav_row = ActionRow()

            prev_button = Button(
                label='Previous',
                style=discord.ButtonStyle.secondary,
                custom_id='container_items_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_button = Button(
                label=f'Page {self.current_page + 1}/{self.total_pages}',
                style=discord.ButtonStyle.secondary,
                custom_id='container_items_page'
            )
            page_button.callback = self.show_page_jump_modal
            nav_row.add_item(page_button)

            next_button = Button(
                label='Next',
                style=discord.ButtonStyle.secondary,
                custom_id='container_items_next',
                disabled=(self.current_page >= self.total_pages - 1)
            )
            next_button.callback = self.next_page
            nav_row.add_item(next_button)

            self.add_item(nav_row)

    async def prev_page(self, interaction):
        if self.current_page > 0:
            self.current_page -= 1
            self.selected_item = None
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def next_page(self, interaction):
        if self.current_page < self.total_pages - 1:
            self.current_page += 1
            self.selected_item = None
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def show_page_jump_modal(self, interaction):
        try:
            await interaction.response.send_modal(common_modals.PageJumpModal(self))
        except Exception as e:
            await log_exception(e, interaction)


class MoveDestinationView(LayoutView):
    def __init__(self, source_view: ContainerItemsView, item_name: str, available_quantity: int):
        super().__init__(timeout=None)
        self.source_view = source_view
        self.source_container_id = source_view.container_id
        self.item_name = item_name
        self.available_quantity = available_quantity

        self.selected_destination = None
        self._loose_items_selected = False
        self.containers = []

        self.items_per_page = 25
        self.current_page = 0
        self.total_pages = 1

    async def setup(self, interaction: discord.Interaction):
        # Refresh character data
        bot = interaction.client
        player_data = await get_cached_data(
            bot=bot,
            mongo_database=bot.mdb,
            collection_name='characters',
            query={'_id': interaction.user.id}
        )

        self.source_view.character_data = player_data['characters'][self.source_view.character_id]

        all_containers = get_containers_sorted(self.source_view.character_data)

        # Exclude source container
        self.containers = [c for c in all_containers if c['id'] != self.source_container_id]

        self.total_pages = math.ceil(len(self.containers) / self.items_per_page)
        if self.total_pages == 0:
            self.total_pages = 1
        if self.current_page >= self.total_pages:
            self.current_page = max(0, self.total_pages - 1)

        self.build_view()

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=buttons.CancelMoveButton(self.source_view))
        header_section.add_item(TextDisplay(
            f'**Move "{self.item_name}"** ({self.available_quantity} available)'
        ))
        container.add_item(header_section)
        container.add_item(Separator())

        if not self.containers:
            container.add_item(TextDisplay('No other containers available.'))
        else:
            container.add_item(TextDisplay('Select destination container:'))

            # Destination select (paginated)
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_containers = self.containers[start:end]

            destination_select_row = ActionRow()
            destination_select = selects.DestinationContainerSelect(self, page_containers, self.current_page)
            destination_select_row.add_item(destination_select)
            container.add_item(destination_select_row)

            if self.selected_destination is not None or self._loose_selected():
                destination_name = None
                # Find destination name
                if self.selected_destination is None:
                    destination_name = 'Loose Items'
                else:
                    for dest_container in self.containers:
                        if dest_container['id'] == self.selected_destination:
                            destination_name = dest_container['name']
                            break

                if destination_name is not None:
                    container.add_item(TextDisplay(f'Destination: **{destination_name}**'))

        self.add_item(container)

        # Move action buttons
        action_row = ActionRow()

        # Check if we have a valid destination
        loose_selected = self._loose_selected()
        has_destination = loose_selected or self.selected_destination is not None

        move_all_button = buttons.MoveAllButton(self)
        move_all_button.disabled = not has_destination
        action_row.add_item(move_all_button)

        move_some_button = buttons.MoveSomeButton(self)
        move_some_button.disabled = not has_destination
        action_row.add_item(move_some_button)

        self.add_item(action_row)

        # Pagination
        if self.total_pages > 1:
            nav_row = ActionRow()

            prev_button = Button(
                label='Previous',
                style=discord.ButtonStyle.secondary,
                custom_id='move_dest_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_button = Button(
                label=f'Page {self.current_page + 1}/{self.total_pages}',
                style=discord.ButtonStyle.secondary,
                custom_id='move_dest_page'
            )
            page_button.callback = self.show_page_jump_modal
            nav_row.add_item(page_button)

            next_button = Button(
                label='Next',
                style=discord.ButtonStyle.secondary,
                custom_id='move_dest_next',
                disabled=(self.current_page >= self.total_pages - 1)
            )
            next_button.callback = self.next_page
            nav_row.add_item(next_button)

            self.add_item(nav_row)

    def _loose_selected(self) -> bool:
        return self._loose_items_selected

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


class ContainerManagementView(LayoutView):
    def __init__(self, character_id: str, character_data: dict):
        super().__init__(timeout=None)
        self.character_id = character_id
        self.character_data = character_data

        self.selected_container_id = None  # None can mean Loose Items OR nothing selected
        self.has_selection = False
        self.containers = []

        self.items_per_page = 25
        self.current_page = 0
        self.total_pages = 1

    async def setup(self, interaction: discord.Interaction):
        # Refresh character data
        bot = interaction.client
        player_data = await get_cached_data(
            bot=bot,
            mongo_database=bot.mdb,
            collection_name='characters',
            query={'_id': interaction.user.id}
        )
        self.character_data = player_data['characters'][self.character_id]

        self.containers = get_containers_sorted(self.character_data)

        self.total_pages = math.ceil(len(self.containers) / self.items_per_page)
        if self.total_pages == 0:
            self.total_pages = 1
        if self.current_page >= self.total_pages:
            self.current_page = max(0, self.total_pages - 1)

        self.build_view()

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=buttons.BackToInventoryOverviewButton())
        header_section.add_item(TextDisplay('**Manage Containers**'))
        container.add_item(header_section)
        container.add_item(Separator())

        # Container list
        container_lines = []
        for index, container_data in enumerate(self.containers):
            prefix = f'{index + 1}. '
            suffix = ' (default)' if container_data['id'] is None else ''
            container_lines.append(f"{prefix}**{container_data['name']}** ({container_data['count']} items){suffix}")

        container.add_item(TextDisplay('\n'.join(container_lines) if container_lines else 'No containers.'))
        container.add_item(Separator())

        # Container select (paginated)
        start = self.current_page * self.items_per_page
        end = start + self.items_per_page
        page_containers = self.containers[start:end]

        manage_select_row = ActionRow()
        manage_select = selects.ManageContainerSelect(self, page_containers, self.current_page)
        manage_select_row.add_item(manage_select)
        container.add_item(manage_select_row)

        if self.has_selection:
            selected_name = 'Loose Items'
            if self.selected_container_id is not None:
                for container_data in self.containers:
                    if container_data['id'] == self.selected_container_id:
                        selected_name = container_data['name']
                        break
            container.add_item(TextDisplay(f'Selected: **{selected_name}**'))

        self.add_item(container)

        # Action buttons row 1: Create
        create_row = ActionRow()
        create_row.add_item(buttons.CreateContainerButton(self))
        self.add_item(create_row)

        # Action buttons row 2: Rename, Delete, Reorder
        manage_row = ActionRow()

        # These are disabled for Loose Items (selected_container_id is None)
        has_valid_selection = self.has_selection and self.selected_container_id is not None

        rename_button = buttons.RenameContainerButton(self)
        rename_button.disabled = not has_valid_selection
        manage_row.add_item(rename_button)

        delete_button = buttons.DeleteContainerButton(self)
        delete_button.disabled = not has_valid_selection
        manage_row.add_item(delete_button)

        # Reorder buttons - check boundaries
        can_move_up = False
        can_move_down = False
        if has_valid_selection:
            for index, container_data in enumerate(self.containers):
                if container_data['id'] == self.selected_container_id:
                    # Index 0 is Loose Items, so real containers start at 1
                    can_move_up = index > 1  # Can't move above Loose Items
                    can_move_down = index < len(self.containers) - 1
                    break

        up_button = buttons.MoveContainerUpButton(self)
        up_button.disabled = not can_move_up
        manage_row.add_item(up_button)

        down_button = buttons.MoveContainerDownButton(self)
        down_button.disabled = not can_move_down
        manage_row.add_item(down_button)

        self.add_item(manage_row)

        # Pagination
        if self.total_pages > 1:
            nav_row = ActionRow()

            prev_button = Button(
                label='Previous',
                style=discord.ButtonStyle.secondary,
                custom_id='manage_containers_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_button = Button(
                label=f'Page {self.current_page + 1}/{self.total_pages}',
                style=discord.ButtonStyle.secondary,
                custom_id='manage_containers_page'
            )
            page_button.callback = self.show_page_jump_modal
            nav_row.add_item(page_button)

            next_button = Button(
                label='Next',
                style=discord.ButtonStyle.secondary,
                custom_id='manage_containers_next',
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
            channel_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='playerBoardChannel',
                query={'_id': guild.id}
            )
            self.player_board_channel_id = strip_id(channel_query['playerBoardChannel']) if channel_query else None

            cache_id = f'{guild.id}:{user.id}'

            self.posts = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='playerBoard',
                query={'guildId': guild.id, 'playerId': user.id},
                is_single=False,
                cache_id=cache_id
            )

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
                raise UserFeedbackError("Player Board channel not found.")

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

            cache_id = f'{interaction.guild_id}:{interaction.user.id}'
            redis_key = build_cache_key(interaction.client.gdb.name, cache_id, 'playerBoard')

            await interaction.client.rdb.delete(redis_key)

            await setup_view(self, interaction)
            await interaction.response.edit_message(view=self)
        except Exception as e:
            await log_exception(e, interaction)

    async def edit_post(self, post, new_title, new_content, interaction):
        try:
            bot = interaction.client
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='playerBoard',
                query={'guildId': interaction.guild_id, 'postId': post['postId']},
                update_data={'$set': {'title': new_title, 'content': new_content}},
                cache_id=f'{interaction.guild_id}:{post["postId"]}'
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

            cache_id = f'{interaction.guild_id}:{interaction.user.id}'
            redis_key = build_cache_key(interaction.client.gdb.name, cache_id, 'playerBoard')

            await interaction.client.rdb.delete(redis_key)

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
        query = await get_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name='staticKits',
            query={'_id': interaction.guild_id}
        )
        self.kits = query.get('kits', {}) if query else {}

        # Sort kits by name
        self.sorted_kits = sorted(self.kits.items(), key=lambda x: x[1].get('name', '').lower())
        self.total_pages = math.ceil(len(self.sorted_kits) / self.items_per_page)

        self.currency_config = await get_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name='currency',
            query={'_id': interaction.guild_id}
        )

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

                content_lines = [f'**{escape_markdown(titlecase(kit_name))}**']
                if description:
                    content_lines.append(f'*{escape_markdown(description)}*')

                # Preview Contents
                items = kit_data.get('items', [])
                # Decode currency keys for display
                currency = {decode_mongo_key(k): v for k, v in kit_data.get('currency', {}).items()}

                preview_list = []
                for item in items[:3]:  # Show first 3 items
                    preview_list.append(f'{item.get("quantity", 1)}x {escape_markdown(titlecase(item.get("name", "")))}')
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

        container.add_item(TextDisplay(f'**Confirm Selection: {escape_markdown(titlecase(self.kit_data.get("name")))}**'))
        container.add_item(Separator())

        description = self.kit_data.get('description')
        if description:
            container.add_item(TextDisplay(escape_markdown(description)))
            container.add_item(Separator())

        items = self.kit_data.get('items', [])
        # Decode currency keys for display
        currency = {decode_mongo_key(k): v for k, v in self.kit_data.get('currency', {}).items()}

        details = []
        if items:
            details.append('**Items:**')
            for item in items:
                details.append(f'- {item.get("quantity", 1)}x {escape_markdown(titlecase(item.get("name")))}')

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
        # Decode currency keys for display
        currency = {decode_mongo_key(k): v for k, v in self.kit_data.get('currency', {}).items()}
        await _handle_submission(interaction, self.character_id, self.character_name, items, currency)


class NewCharacterComplexItemPurchaseView(LayoutView):
    def __init__(self, parent_view, item):
        super().__init__(timeout=None)
        self.parent_view = parent_view
        self.item = item
        self.build_view()

    def build_view(self):
        self.clear_items()
        container = Container()

        header = Section(accessory=buttons.WizardKeepShoppingButton(self.parent_view))
        header.add_item(TextDisplay(f"**Purchase Options: {self.item['name']}**"))
        container.add_item(header)
        container.add_item(Separator())

        costs = self.item.get('costs', [])
        currency_config = getattr(self.parent_view, 'currency_config', {})

        if not costs:
            container.add_item(TextDisplay("This item has no cost options available."))
        else:
            for index, cost_option in enumerate(costs):
                cost_str = format_complex_cost([cost_option], currency_config)

                select_button = buttons.WizardSelectCostOptionButton(self.parent_view, self.item, index)
                section = Section(accessory=select_button)
                section.add_item(TextDisplay(f"**Option {index + 1}:** {cost_str}"))
                container.add_item(section)

        self.add_item(container)


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

        self.currency_config = {}
        self.starting_wealth = None

    async def setup(self, interaction):
        guild_id = interaction.guild_id
        bot = interaction.client

        shop_query = await get_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name='newCharacterShop',
            query={'_id': guild_id}
        )
        self.shop_stock = shop_query.get('shopStock', []) if shop_query else []
        self.total_pages = math.ceil(len(self.shop_stock) / self.items_per_page)

        self.currency_config = await get_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name='currency',
            query={'_id': guild_id}
        )

        if self.inventory_type == 'purchase':
            inventory_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='inventoryConfig',
                query={'_id': guild_id}
            )
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
            cost_string = 'Free'
            if self.inventory_type == 'purchase':
                costs = item.get('costs', [])
                cost_string = format_complex_cost(costs, self.currency_config)

            section = Section(accessory=buttons.WizardItemButton(item, self.inventory_type, cost_string))

            display = f'**{item["name"]}**'
            if item.get('quantity', 1) > 1:
                display += f'(x{item.get("quantity", 1)})'

            if item_name := item.get('name'):
                item_quantity_in_cart = 0
                for value in self.cart.values():
                    if value['item']['name'] == item_name:
                        item_quantity_in_cart += value['quantity']

                if item_quantity_in_cart > 0:
                    display += f" **(In Cart: {item_quantity_in_cart})**"

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

    async def add_to_cart_with_option(self, interaction, item, option_index=0):
        name = item['name']
        key = f"{name}::{option_index}"

        if key in self.cart:
            self.cart[key]['quantity'] += 1
        else:
            self.cart[key] = {'item': item, 'quantity': 1, 'option_index': option_index}
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

        for key, data in self.shop_view.cart.items():
            item = data['item']
            quantity = data['quantity']
            option_index = data.get('optionIndex', 0)
            quantity_per_purchase = item.get('quantity', 1)
            total_quantity = quantity * quantity_per_purchase

            name = item['name']
            self.cart_items[name] = self.cart_items.get(name, 0) + total_quantity

            if self.shop_view.inventory_type == 'purchase':
                costs = item.get('costs', [])
                if 0 <= option_index < len(costs):
                    selected_cost = costs[option_index]
                    for currency, amount in selected_cost.items():
                        total_cost_raw[currency] = total_cost_raw.get(currency, 0) + (amount * quantity)

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

            for key, data in page_items:
                item = data['item']
                name = item.get('name')
                quantity = data['quantity']
                option_index = data.get('optionIndex', 0)
                quantity_per_purchase = item.get('quantity', 1)
                total_quantity = quantity * quantity_per_purchase

                display = f'**{name}** x{quantity}'
                if quantity_per_purchase > 1:
                    display += f' (Total: {total_quantity})'

                if self.shop_view.inventory_type == 'purchase':
                    costs = item.get('costs', [])
                    if 0 <= option_index < len(costs):
                        selected_cost = costs[option_index]
                        if selected_cost:
                            total_line_cost = {k: v * quantity for k, v in selected_cost.items()}
                            price_label = format_complex_cost([total_line_cost], self.shop_view.currency_config)
                            display += f' - {price_label}'

                edit_button = buttons.WizardEditCartItemButton(key, quantity)
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
        currency_config = await get_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name='currency',
            query={'_id': guild_id}
        )

        approval_query = await get_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name='approvalQueueChannel',
            query={'_id': guild_id}
        )

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

            # Reset the view to Character Base View
            new_view = CharacterBaseView()
            await setup_view(new_view, interaction)
            await interaction.response.edit_message(view=new_view)

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
                added_items_summary.append(f'{quantity_label}{escape_markdown(titlecase(name))}')

            report_embed.add_field(name='Items Received', value='\n'.join(added_items_summary) or 'None', inline=False)

            currency_labels = format_consolidated_totals(currency, currency_config)
            report_embed.add_field(name='Currency Received', value='\n'.join(currency_labels) or 'None', inline=False)

            report_embed.set_footer(text=f'Transaction ID: {shortuuid.uuid()[:12]}')

            view = CharacterBaseView()
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
            await interaction.followup.send(embed=report_embed, ephemeral=True)

    except Exception as e:
        await log_exception(e, interaction)
