import logging
import math

import discord
import shortuuid
from discord.ui import (
    Container,
    LayoutView,
    Section,
    TextDisplay,
    Separator,
    ActionRow,
    Button
)
from titlecase import titlecase

from ReQuest.ui.common import modals as common_modals
from ReQuest.ui.common.views import LocaleLayoutView
from ReQuest.ui.common.buttons import MenuViewButton, MenuDoneButton, BackButton
from ReQuest.ui.common.enums import InventoryType
from ReQuest.ui.player import buttons, selects
from ReQuest.utilities.constants import (
    ApprovalFields, CharacterFields, ConfigFields, CommonFields, ShopFields, DatabaseCollections,
    DiscordLimits, DisplayLimits
)
from ReQuest.utilities.checks import is_gm_or_mod
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE, resolve_locale
from ReQuest.utilities.character import update_character_inventory
from ReQuest.utilities.containers import get_containers_sorted, get_container_name, get_container_items
from ReQuest.utilities.currency import (
    find_currency_or_denomination, format_currency_display, format_price_string, consolidate_currency_totals,
    check_sufficient_funds, get_denomination_map, format_consolidated_totals, format_complex_cost
)
from ReQuest.utilities.db_cache import (
    get_cached_data, update_cached_data, build_cache_key, delete_cached_data, decode_mongo_key, get_xp_config,
    run_in_transaction
)
from ReQuest.utilities.discord_utils import setup_view, strip_id, escape_markdown, truncate_text
from ReQuest.utilities.exceptions import UserFeedbackError, log_exception

logger = logging.getLogger(__name__)


class PlayerBaseView(LocaleLayoutView):
    def __init__(self):
        super().__init__()
        locale = getattr(self, 'locale', DEFAULT_LOCALE)
        self.player_board_button = MenuViewButton(
            PlayerBoardView, t(locale, 'player-menu-btn-player-board')[:DiscordLimits.BUTTON_LABEL]
        )

        self.build_view()

    def build_view(self):
        self.clear_items()
        locale = getattr(self, 'locale', DEFAULT_LOCALE)
        container = Container()

        header_section = Section(accessory=MenuDoneButton(locale=locale))
        header_section.add_item(TextDisplay(t(locale, 'player-title-main-menu')))
        container.add_item(header_section)
        container.add_item(Separator())

        character_section = Section(
            accessory=MenuViewButton(
                CharacterBaseView,
                t(locale, 'player-menu-btn-characters')[:DiscordLimits.BUTTON_LABEL])
        )
        character_section.add_item(TextDisplay(t(locale, 'player-menu-desc-characters')))
        container.add_item(character_section)

        inventory_section = Section(
            accessory=MenuViewButton(
                InventoryOverviewView,
                t(locale, 'player-menu-btn-inventory')[:DiscordLimits.BUTTON_LABEL])
        )
        inventory_section.add_item(TextDisplay(t(locale, 'player-menu-desc-inventory')))
        container.add_item(inventory_section)

        player_board_section = Section(accessory=self.player_board_button)
        player_board_section.add_item(TextDisplay(t(locale, 'player-menu-desc-player-board')))
        container.add_item(player_board_section)

        self.add_item(container)

    async def setup(self, bot, guild):
        try:
            locale = getattr(self, 'locale', DEFAULT_LOCALE)
            channel_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.PLAYER_BOARD_CHANNEL,
                query={CommonFields.ID: guild.id}
            )
            if channel_query:
                self.player_board_button.disabled = False
                self.player_board_button.label = t(
                    locale, 'player-menu-btn-player-board'
                )[:DiscordLimits.BUTTON_LABEL]
            else:
                self.player_board_button.disabled = True
                self.player_board_button.label = t(
                    locale, 'player-menu-btn-player-board-disabled'
                )[:DiscordLimits.BUTTON_LABEL]
            self.build_view()
        except Exception as e:
            await log_exception(e)


class CharacterBaseView(LocaleLayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.characters = {}
        self.active_character_id = None
        self.sorted_characters = []
        self.xp_enabled = True
        self.pending_character = None

        self.items_per_page = 6
        self.current_page = 0
        self.total_pages = 1

    async def setup(self, interaction):
        try:
            bot = interaction.client
            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name=DatabaseCollections.CHARACTERS,
                query={CommonFields.ID: interaction.user.id}
            )

            self.characters = query.get(CharacterFields.CHARACTERS, {}) if query else {}
            self.active_character_id = (
                query.get(CharacterFields.ACTIVE_CHARACTERS, {}).get(str(interaction.guild_id))
                if query else None
            )

            self.sorted_characters = sorted(
                self.characters.items(),
                key=lambda x: x[1].get(CharacterFields.NAME, '').lower()
            )

            self.total_pages = math.ceil(len(self.sorted_characters) / self.items_per_page)
            if self.total_pages == 0:
                self.total_pages = 1

            if self.current_page >= self.total_pages:
                self.current_page = max(0, self.total_pages - 1)

            self.xp_enabled = await get_xp_config(interaction.client, interaction.guild_id)

            # Check for a pending character registration on this guild
            pending_id = f'{interaction.user.id}_{interaction.guild_id}'
            self.pending_character = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.PENDING_CHARACTERS,
                query={CommonFields.ID: pending_id}
            )

            self.build_view()
        except Exception as e:
            await log_exception(e, interaction)

    def build_view(self):
        self.clear_items()
        locale = getattr(self, 'locale', DEFAULT_LOCALE)
        container = Container()

        header_section = Section(accessory=BackButton(PlayerBaseView))
        header_section.add_item(TextDisplay(t(locale, 'player-title-characters')))
        container.add_item(header_section)
        container.add_item(Separator())

        # Show pending character section if one exists for this guild
        if self.pending_character:
            pending_name = self.pending_character.get('name', '')
            container.add_item(TextDisplay(
                t(locale, 'player-title-character-in-progress', characterName=pending_name)
            ))
            pending_actions = ActionRow()
            pending_actions.add_item(buttons.ResumeWizardButton(self))
            pending_actions.add_item(buttons.DiscardPendingCharacterButton(self))
            container.add_item(pending_actions)
            container.add_item(Separator())

        # Disable registration if a pending character exists
        register_button = buttons.RegisterCharacterButton(self)
        if self.pending_character:
            register_button.disabled = True
        register_section = Section(accessory=register_button)
        register_section.add_item(TextDisplay(t(locale, 'player-desc-register-character')))
        container.add_item(register_section)
        container.add_item(Separator())

        if not self.sorted_characters:
            container.add_item(TextDisplay(t(locale, 'player-msg-no-characters')))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = self.sorted_characters[start:end]

            for character_id, character_data in page_items:
                is_active = (character_id == self.active_character_id)

                name = character_data.get(CharacterFields.NAME)
                note = character_data.get('note', '')
                xp = character_data.get(CharacterFields.ATTRIBUTES, {}).get(CharacterFields.EXPERIENCE, 0)

                display_name = f"**{name}**"
                if is_active:
                    display_name += f" {t(locale, 'player-label-active')}"

                info_text = f"{display_name}"
                if self.xp_enabled and xp and xp > 0:
                    info_text += f" - {t(locale, 'player-label-xp', xp=xp)}"
                if note:
                    info_text += f"\n*{note}*"

                actions = ActionRow()

                activate_button = buttons.ActivateCharacterButton(self, character_id, disabled=is_active)
                if is_active:
                    activate_button.label = t(locale, 'player-btn-active')[:DiscordLimits.BUTTON_LABEL]
                    activate_button.style = discord.ButtonStyle.success

                actions.add_item(activate_button)
                actions.add_item(buttons.RemoveCharacterButton(self, character_id, name))

                container.add_item(TextDisplay(info_text))
                container.add_item(actions)

        self.add_item(container)

        if self.total_pages > 1:
            nav_row = ActionRow()

            prev_button = Button(
                label=t(locale, 'common-btn-previous')[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='char_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_display = Button(
                label=t(locale, 'common-page-label', current=self.current_page + 1,
                       total=self.total_pages)[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='char_page_disp'
            )
            page_display.callback = self.show_page_jump_modal
            nav_row.add_item(page_display)

            next_button = Button(
                label=t(locale, 'common-btn-next')[:DiscordLimits.BUTTON_LABEL],
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


class InventoryOverviewView(LocaleLayoutView):
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
            collection_name=DatabaseCollections.CHARACTERS,
            query={CommonFields.ID: interaction.user.id}
        )

        self.currency_config = await get_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name=DatabaseCollections.CURRENCY,
            query={CommonFields.ID: guild_id}
        )

        if not query:
            self.active_character = None
            self.active_character_id = None
        elif str(guild_id) not in query.get(CharacterFields.ACTIVE_CHARACTERS, {}):
            self.active_character = None
            self.active_character_id = None
        else:
            self.active_character_id = query[CharacterFields.ACTIVE_CHARACTERS][str(guild_id)]
            self.active_character = query[CharacterFields.CHARACTERS][self.active_character_id]

            # Validate currencies in inventory and convert based on server config
            inventory_keys_to_check = list(
                self.active_character[CharacterFields.ATTRIBUTES].get(
                    CharacterFields.INVENTORY, {}
                ).keys()
            )

            if inventory_keys_to_check and self.currency_config:
                conversion_occurred = False

                for item_name_key in inventory_keys_to_check:
                    quantity = self.active_character[CharacterFields.ATTRIBUTES][
                        CharacterFields.INVENTORY
                    ].get(item_name_key)
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
                        inventory = self.active_character[CharacterFields.ATTRIBUTES].get(
                            CharacterFields.INVENTORY, {}
                        )
                        if item_name_key in inventory:
                            del inventory[item_name_key]  # Update local copy
                            inv_path = (
                                f'{CharacterFields.CHARACTERS}.{self.active_character_id}'
                                f'.{CharacterFields.ATTRIBUTES}.{CharacterFields.INVENTORY}'
                            )
                            collection = bot.mdb[DatabaseCollections.CHARACTERS]
                            await collection.update_one(
                                {CommonFields.ID: interaction.user.id},
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
                            cache_key = build_cache_key(
                                bot.mdb.name, interaction.user.id, DatabaseCollections.CHARACTERS
                            )
                            try:
                                await bot.rdb.delete(cache_key)
                            except Exception as e:
                                logger.error(f"Redis delete failed: {e}")
                        conversion_occurred = True

                if conversion_occurred:
                    query = await get_cached_data(
                        bot=bot,
                        mongo_database=bot.mdb,
                        collection_name=DatabaseCollections.CHARACTERS,
                        query={CommonFields.ID: interaction.user.id}
                    )
                    self.active_character = query[CharacterFields.CHARACTERS][self.active_character_id]

            # Get containers
            self.containers = get_containers_sorted(
                self.active_character, locale=getattr(self, 'locale', DEFAULT_LOCALE)
            )

            # Calculate pagination
            self.total_pages = math.ceil(len(self.containers) / self.items_per_page)
            if self.total_pages == 0:
                self.total_pages = 1
            if self.current_page >= self.total_pages:
                self.current_page = max(0, self.total_pages - 1)

            # Get currencies
            player_currencies = self.active_character[CharacterFields.ATTRIBUTES].get(CharacterFields.CURRENCY, {})
            self.currencies = format_currency_display(player_currencies, self.currency_config)

        self.build_view()

    def build_view(self):
        self.clear_items()
        locale = getattr(self, 'locale', DEFAULT_LOCALE)
        container = Container()

        header_section = Section(accessory=BackButton(PlayerBaseView))

        if not self.active_character:
            header_section.add_item(TextDisplay(t(locale, 'player-title-inventory')))
            container.add_item(header_section)
            container.add_item(Separator())

            if self.active_character_id is None:
                container.add_item(TextDisplay(t(locale, 'player-msg-no-active-character')))
            else:
                container.add_item(TextDisplay(t(locale, 'player-msg-no-characters-registered')))

            self.add_item(container)
            return

        header_section.add_item(TextDisplay(
            t(locale, 'player-title-char-inventory',
              characterName=self.active_character[CharacterFields.NAME])
        ))
        container.add_item(header_section)
        container.add_item(Separator())

        # Build container summary
        summary_lines = []
        total_items = 0
        for c in self.containers:
            summary_lines.append(
                t(locale, 'player-label-container-summary',
                  containerName=c['name'], count=c['count'])
            )
            total_items += c['count']

        if self.currencies:
            summary_lines.append('')
            summary_lines.append(t(locale, 'player-label-currency'))
            summary_lines.extend(self.currencies)

        container.add_item(TextDisplay(
            '\n'.join(summary_lines) if summary_lines else t(locale, 'player-msg-inventory-empty')
        ))
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
                label=t(locale, 'common-btn-previous')[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='inv_overview_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_button = Button(
                label=t(locale, 'common-page-label', current=self.current_page + 1,
                       total=self.total_pages)[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='inv_overview_page'
            )
            page_button.callback = self.show_page_jump_modal
            nav_row.add_item(page_button)

            next_button = Button(
                label=t(locale, 'common-btn-next')[:DiscordLimits.BUTTON_LABEL],
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


class ContainerItemsView(LocaleLayoutView):
    def __init__(self, character_id: str, character_data: dict, container_id: str | None):
        super().__init__(timeout=None)
        self.character_id = character_id
        self.character_data = character_data
        self.container_id = container_id
        self.container_name = t(DEFAULT_LOCALE, 'common-label-loose-items')

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
            collection_name=DatabaseCollections.CHARACTERS,
            query={CommonFields.ID: interaction.user.id}
        )

        self.character_data = player_data[CharacterFields.CHARACTERS][self.character_id]

        self.container_name = get_container_name(
            self.character_data, self.container_id, locale=getattr(self, 'locale', DEFAULT_LOCALE)
        )
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
        locale = getattr(self, 'locale', DEFAULT_LOCALE)
        container = Container()

        header_section = Section(accessory=buttons.BackToInventoryOverviewButton(locale=locale))
        header_section.add_item(TextDisplay(f'**{self.container_name}**'))
        container.add_item(header_section)
        container.add_item(Separator())

        if not self.items:
            container.add_item(TextDisplay(t(locale, 'player-msg-container-empty')))
        else:
            # Display items on current page
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = self.items[start:end]

            items_display = []
            for item_name, quantity in page_items:
                item_text = escape_markdown(truncate_text(item_name, DisplayLimits.ITEM_NAME))
                items_display.append(f'• {item_text}: **{quantity}**')

            container.add_item(TextDisplay('\n'.join(items_display)))
            container.add_item(Separator())

            # Item select
            item_select_row = ActionRow()
            item_select = selects.ContainerItemSelect(self, page_items, self.current_page)
            item_select_row.add_item(item_select)
            container.add_item(item_select_row)

            if self.selected_item:
                container.add_item(TextDisplay(
                    t(locale, 'player-label-selected-item', itemName=self.selected_item)
                ))

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
                label=t(locale, 'common-btn-previous')[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='container_items_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_button = Button(
                label=t(locale, 'common-page-label', current=self.current_page + 1,
                       total=self.total_pages)[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='container_items_page'
            )
            page_button.callback = self.show_page_jump_modal
            nav_row.add_item(page_button)

            next_button = Button(
                label=t(locale, 'common-btn-next')[:DiscordLimits.BUTTON_LABEL],
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


class MoveDestinationView(LocaleLayoutView):
    def __init__(self, source_view: ContainerItemsView, item_name: str, available_quantity: int):
        super().__init__(timeout=None)
        self.source_view = source_view
        self.source_container_id = source_view.container_id
        self.item_name = item_name
        self.available_quantity = available_quantity

        self.selected_destination = None
        self.loose_items_selected = False
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
            collection_name=DatabaseCollections.CHARACTERS,
            query={CommonFields.ID: interaction.user.id}
        )

        self.source_view.character_data = player_data[CharacterFields.CHARACTERS][self.source_view.character_id]

        all_containers = get_containers_sorted(
            self.source_view.character_data, locale=getattr(self, 'locale', DEFAULT_LOCALE)
        )

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
        locale = getattr(self, 'locale', DEFAULT_LOCALE)
        container = Container()

        header_section = Section(accessory=buttons.CancelMoveButton(self.source_view))
        header_section.add_item(TextDisplay(
            t(locale, 'player-title-move-item',
              itemName=self.item_name, available=self.available_quantity)
        ))
        container.add_item(header_section)
        container.add_item(Separator())

        if not self.containers:
            container.add_item(TextDisplay(t(locale, 'player-msg-no-other-containers')))
        else:
            container.add_item(TextDisplay(t(locale, 'player-msg-select-destination')))

            # Destination select (paginated)
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_containers = self.containers[start:end]

            destination_select_row = ActionRow()
            destination_select = selects.DestinationContainerSelect(self, page_containers, self.current_page)
            destination_select_row.add_item(destination_select)
            container.add_item(destination_select_row)

            if self.selected_destination is not None or self.loose_items_selected:
                destination_name = None
                # Find destination name
                if self.selected_destination is None:
                    destination_name = t(locale, 'common-label-loose-items')
                else:
                    for dest_container in self.containers:
                        if dest_container['id'] == self.selected_destination:
                            destination_name = dest_container['name']
                            break

                if destination_name is not None:
                    container.add_item(TextDisplay(
                        t(locale, 'player-label-destination', destinationName=destination_name)
                    ))

        self.add_item(container)

        # Move action buttons
        action_row = ActionRow()

        # Check if we have a valid destination
        has_destination = self.loose_items_selected or self.selected_destination is not None

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
                label=t(locale, 'common-btn-previous')[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='move_dest_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_button = Button(
                label=t(locale, 'common-page-label', current=self.current_page + 1,
                       total=self.total_pages)[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='move_dest_page'
            )
            page_button.callback = self.show_page_jump_modal
            nav_row.add_item(page_button)

            next_button = Button(
                label=t(locale, 'common-btn-next')[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='move_dest_next',
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


class ContainerManagementView(LocaleLayoutView):
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
            collection_name=DatabaseCollections.CHARACTERS,
            query={CommonFields.ID: interaction.user.id}
        )
        self.character_data = player_data[CharacterFields.CHARACTERS][self.character_id]

        self.containers = get_containers_sorted(
            self.character_data, locale=getattr(self, 'locale', DEFAULT_LOCALE)
        )

        self.total_pages = math.ceil(len(self.containers) / self.items_per_page)
        if self.total_pages == 0:
            self.total_pages = 1
        if self.current_page >= self.total_pages:
            self.current_page = max(0, self.total_pages - 1)

        self.build_view()

    def build_view(self):
        self.clear_items()
        locale = getattr(self, 'locale', DEFAULT_LOCALE)
        container = Container()

        header_section = Section(accessory=buttons.BackToInventoryOverviewButton(locale=locale))
        header_section.add_item(TextDisplay(t(locale, 'player-title-manage-containers')))
        container.add_item(header_section)
        container.add_item(Separator())

        # Container list
        container_lines = []
        for index, container_data in enumerate(self.containers):
            prefix = f'{index + 1}. '
            suffix = t(locale, 'player-label-default-suffix') if container_data['id'] is None else ''
            container_lines.append(
                t(locale, 'player-label-container-line',
                  prefix=prefix, containerName=container_data['name'],
                  count=container_data['count'], suffix=suffix)
            )

        container.add_item(TextDisplay(
            '\n'.join(container_lines) if container_lines else t(locale, 'player-msg-no-containers')
        ))
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
            selected_name = t(locale, 'common-label-loose-items')
            if self.selected_container_id is not None:
                for container_data in self.containers:
                    if container_data['id'] == self.selected_container_id:
                        selected_name = container_data['name']
                        break
            container.add_item(TextDisplay(
                t(locale, 'player-label-selected-container', containerName=selected_name)
            ))

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
                label=t(locale, 'common-btn-previous')[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='manage_containers_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_button = Button(
                label=t(locale, 'common-page-label', current=self.current_page + 1,
                       total=self.total_pages)[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='manage_containers_page'
            )
            page_button.callback = self.show_page_jump_modal
            nav_row.add_item(page_button)

            next_button = Button(
                label=t(locale, 'common-btn-next')[:DiscordLimits.BUTTON_LABEL],
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


class PlayerBoardView(LocaleLayoutView):
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
                collection_name=DatabaseCollections.PLAYER_BOARD_CHANNEL,
                query={CommonFields.ID: guild.id}
            )
            self.player_board_channel_id = (
                strip_id(channel_query[ConfigFields.PLAYER_BOARD_CHANNEL])
                if channel_query else None
            )

            cache_id = f'{guild.id}:{user.id}'

            self.posts = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.PLAYER_BOARD,
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
        locale = getattr(self, 'locale', DEFAULT_LOCALE)
        container = Container()

        header_section = Section(accessory=BackButton(PlayerBaseView))
        header_section.add_item(TextDisplay(t(locale, 'player-title-player-board')))
        container.add_item(header_section)
        container.add_item(Separator())

        create_post_section = Section(accessory=buttons.CreatePlayerPostButton(self))
        create_post_section.add_item(TextDisplay(t(locale, 'player-desc-create-post')))
        container.add_item(create_post_section)
        container.add_item(Separator())

        if not self.posts:
            container.add_item(TextDisplay(t(locale, 'player-msg-no-posts')))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_posts = self.posts[start:end]

            for post in page_posts:
                title = post.get('title', t(locale, 'player-label-untitled'))
                post_id = post.get('postId', t(locale, 'common-label-unknown'))

                info_text = t(locale, 'player-label-post-info', title=title, postId=post_id)

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
                label=t(locale, 'common-btn-previous')[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='pb_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page
            nav_row.add_item(prev_button)

            page_display = Button(
                label=t(locale, 'common-page-label', current=self.current_page + 1,
                       total=self.total_pages)[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='pb_page_disp'
            )
            page_display.callback = self.show_page_jump_modal
            nav_row.add_item(page_display)

            next_button = Button(
                label=t(locale, 'common-btn-next')[:DiscordLimits.BUTTON_LABEL],
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
            bot = interaction.client
            guild_locale = await resolve_locale(bot=bot, guild_id=interaction.guild_id)
            user_locale = await resolve_locale(interaction)
            post_collection = bot.gdb[DatabaseCollections.PLAYER_BOARD]
            post_id = str(shortuuid.uuid()[:8])

            post_embed = discord.Embed(
                title=title,
                description=content,
                type='rich'
            )
            post_embed.add_field(
                name=t(guild_locale, 'player-embed-field-author'),
                value=interaction.user.mention
            )
            post_embed.set_footer(text=t(guild_locale, 'player-embed-footer-post-id', postId=post_id))

            channel = interaction.client.get_channel(self.player_board_channel_id)
            if not channel:
                raise UserFeedbackError(
                    t(user_locale, 'player-error-board-channel-not-found'),
                    message_id='player-error-board-channel-not-found'
                )

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
            redis_key = build_cache_key(interaction.client.gdb.name, cache_id, DatabaseCollections.PLAYER_BOARD)

            await interaction.client.rdb.delete(redis_key)

            await setup_view(self, interaction)
            await interaction.response.edit_message(view=self)
        except Exception as e:
            await log_exception(e, interaction)

    async def edit_post(self, post, new_title, new_content, interaction):
        try:
            bot = interaction.client
            guild_locale = await resolve_locale(bot=bot, guild_id=interaction.guild_id)
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.PLAYER_BOARD,
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
                        embed.add_field(
                            name=t(guild_locale, 'player-embed-field-author'),
                            value=interaction.user.mention
                        )
                        embed.set_footer(text=t(guild_locale, 'player-embed-footer-post-id', postId=post['postId']))

                        await message.edit(embed=embed)
                    except discord.NotFound:
                        logger.error("Player Board message not found for editing.")
                    except Exception as e:
                        logger.error(f"Failed to edit Player Board message: {e}")

            cache_id = f'{interaction.guild_id}:{interaction.user.id}'
            redis_key = build_cache_key(interaction.client.gdb.name, cache_id, DatabaseCollections.PLAYER_BOARD)

            await interaction.client.rdb.delete(redis_key)

            await setup_view(self, interaction)
            await interaction.response.edit_message(view=self)
        except Exception as e:
            await log_exception(e, interaction)


class ValidationErrorView(LocaleLayoutView):
    """Paginated view for displaying input validation errors."""

    def __init__(self, errors, calling_view):
        super().__init__(timeout=None)
        self.errors = errors
        self.calling_view = calling_view
        self.locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self.items_per_page = 15
        self.current_page = 0
        self.total_pages = max(1, math.ceil(len(errors) / self.items_per_page))
        self.build_view()

    def build_view(self):
        self.clear_items()
        locale = getattr(self, 'locale', DEFAULT_LOCALE)
        container = Container()

        container.add_item(TextDisplay(f'**{t(locale, "player-validation-error-title")}**'))
        container.add_item(Separator())

        start = self.current_page * self.items_per_page
        end = start + self.items_per_page
        page_errors = self.errors[start:end]
        container.add_item(TextDisplay('\n'.join(f'- {e}' for e in page_errors)))
        container.add_item(Separator())

        actions = ActionRow()
        actions.add_item(buttons.ValidationRetryButton(self))
        container.add_item(actions)

        self.add_item(container)

        if self.total_pages > 1:
            nav_row = ActionRow()
            prev_button = Button(
                label=t(locale, 'common-btn-prev')[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='val_err_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page

            page_display = Button(
                label=t(locale, 'common-page-label',
                        current=self.current_page + 1, total=self.total_pages)[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='val_err_page'
            )
            page_display.callback = self.show_page_jump_modal

            next_button = Button(
                label=t(locale, 'common-btn-next')[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='val_err_next',
                disabled=(self.current_page >= self.total_pages - 1)
            )
            next_button.callback = self.next_page

            nav_row.add_item(prev_button)
            nav_row.add_item(page_display)
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
            locale = getattr(self, 'locale', DEFAULT_LOCALE)
            logger.error(f'Failed to send PageJumpModal: {e}')
            await interaction.response.send_message(
                t(locale, 'common-error-page-selector'), ephemeral=True
            )


class NewCharacterWizardView(LocaleLayoutView):
    def __init__(self, pending_character, inventory_type, locale=None):
        super().__init__(timeout=None)
        self.pending_character = pending_character
        self.character_id = pending_character['character_id']
        self.character_name = pending_character['name']
        self.inventory_type = inventory_type
        if locale:
            self.locale = locale

        self.build_view()

    def build_view(self):
        self.clear_items()
        locale = getattr(self, 'locale', DEFAULT_LOCALE)
        container = Container()
        container.add_item(TextDisplay(
            t(locale, 'player-title-setup-inventory', characterName=self.character_name)
        ))
        container.add_item(Separator())

        description = ""
        action_row = ActionRow()

        if self.inventory_type in [InventoryType.SELECTION.value, InventoryType.PURCHASE.value]:
            description = t(locale, 'player-desc-browse-shop')
            action_row.add_item(buttons.OpenStartingShopButton(self))
        elif self.inventory_type == InventoryType.STATIC.value:
            description = t(locale, 'player-desc-select-kit')
            action_row.add_item(buttons.SelectStaticKitButton(self))
        elif self.inventory_type == InventoryType.OPEN.value:
            description = t(locale, 'player-desc-input-inventory')
            action_row.add_item(buttons.OpenInventoryInputButton(self))

        container.add_item(TextDisplay(description))
        container.add_item(action_row)

        self.add_item(container)

    async def submit_open_inventory(self, interaction, items):
        await _handle_submission(interaction, self.pending_character, items, {})


class StaticKitSelectView(LocaleLayoutView):
    def __init__(self, pending_character):
        super().__init__(timeout=None)
        self.pending_character = pending_character
        self.character_id = pending_character['character_id']
        self.character_name = pending_character['name']
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
            collection_name=DatabaseCollections.STATIC_KITS,
            query={CommonFields.ID: interaction.guild_id}
        )
        self.kits = query.get('kits', {}) if query else {}

        # Sort kits by name
        self.sorted_kits = sorted(self.kits.items(), key=lambda x: x[1].get(CommonFields.NAME, '').lower())
        self.total_pages = math.ceil(len(self.sorted_kits) / self.items_per_page)

        self.currency_config = await get_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name=DatabaseCollections.CURRENCY,
            query={CommonFields.ID: interaction.guild_id}
        )

        self.build_view()

    def build_view(self):
        self.clear_items()
        locale = getattr(self, 'locale', DEFAULT_LOCALE)
        container = Container()

        container.add_item(TextDisplay(
            t(locale, 'player-title-select-kit', characterName=self.character_name)
        ))
        container.add_item(Separator())

        if not self.sorted_kits:
            container.add_item(TextDisplay(t(locale, 'player-msg-no-kits')))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = self.sorted_kits[start:end]

            for kit_id, kit_data in page_items:
                select_button = buttons.SelectKitOptionButton(kit_id, kit_data, locale=locale)
                section = Section(accessory=select_button)

                kit_name = kit_data.get(CommonFields.NAME, 'Unknown Kit')
                description = kit_data.get('description', '')

                content_lines = [f'**{escape_markdown(titlecase(kit_name))}**']
                if description:
                    content_lines.append(f'*{escape_markdown(description)}*')

                # Preview Contents
                items = kit_data.get(CommonFields.ITEMS, [])
                # Decode currency keys for display
                currency = {decode_mongo_key(k): v for k, v in kit_data.get(CharacterFields.CURRENCY, {}).items()}

                preview_list = []
                for item in items[:3]:  # Show first 3 items
                    preview_list.append(
                        f'{item.get(CommonFields.QUANTITY, 1)}x '
                        f'{escape_markdown(titlecase(item.get(CommonFields.NAME, "")))}'
                    )
                if len(items) > 3:
                    preview_list.append(
                        t(locale, 'player-label-and-more-items', count=len(items) - 3)
                    )

                if currency:
                    currency_strings = format_consolidated_totals(currency, self.currency_config)
                    preview_list.extend(currency_strings)

                if preview_list:
                    content_lines.append(f'> {", ".join(preview_list)}')
                else:
                    content_lines.append(f'> {t(locale, "player-label-empty-kit")}')

                section.add_item(TextDisplay('\n'.join(content_lines)))
                container.add_item(section)

        self.add_item(container)

        # Pagination
        if self.total_pages > 1:
            nav_row = ActionRow()
            prev_button = Button(
                label=t(locale, 'common-btn-prev')[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='kit_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page

            page_display = Button(
                label=t(locale, 'common-page-label', current=self.current_page + 1,
                       total=self.total_pages)[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='kit_page_display'
            )
            page_display.callback = self.show_page_jump_modal

            next_button = Button(
                label=t(locale, 'common-btn-next')[:DiscordLimits.BUTTON_LABEL],
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


class StaticKitConfirmView(LocaleLayoutView):
    def __init__(self, pending_character, kit_id, kit_data, currency_config, locale=None):
        super().__init__(timeout=None)
        self.locale = locale or DEFAULT_LOCALE
        self.pending_character = pending_character
        self.character_id = pending_character['character_id']
        self.character_name = pending_character['name']
        self.kit_id = kit_id
        self.kit_data = kit_data
        self.currency_config = currency_config

        self.items_per_page = 9
        self.current_page = 0
        self.total_pages = 1

        self.build_view()

    def build_view(self):
        self.clear_items()
        locale = getattr(self, 'locale', DEFAULT_LOCALE)
        container = Container()

        container.add_item(TextDisplay(
            t(locale, 'player-title-confirm-kit',
              kitName=escape_markdown(titlecase(self.kit_data.get(CommonFields.NAME))))
        ))
        container.add_item(Separator())

        description = self.kit_data.get('description')
        if description:
            container.add_item(TextDisplay(
                escape_markdown(truncate_text(description, DisplayLimits.ITEM_DESCRIPTION))))
            container.add_item(Separator())

        items = self.kit_data.get(CommonFields.ITEMS, [])
        currency = {decode_mongo_key(k): v for k, v in self.kit_data.get(CharacterFields.CURRENCY, {}).items()}

        # Build combined list of detail lines
        detail_lines = []
        if currency:
            curr_strs = format_consolidated_totals(currency, self.currency_config)
            for s in curr_strs:
                detail_lines.append(f'- {s}')
        if items:
            for item in items:
                detail_lines.append(
                    f'- {item.get(CommonFields.QUANTITY, 1)}x '
                    f'{escape_markdown(truncate_text(
                        titlecase(item.get(CommonFields.NAME)), DisplayLimits.ITEM_NAME))}'
                )

        if not detail_lines:
            container.add_item(TextDisplay(t(locale, 'player-msg-kit-empty')))
        else:
            self.total_pages = math.ceil(len(detail_lines) / self.items_per_page)
            if self.current_page >= self.total_pages:
                self.current_page = max(0, self.total_pages - 1)

            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_lines = detail_lines[start:end]

            container.add_item(TextDisplay('\n'.join(page_lines)))

        container.add_item(Separator())

        actions = ActionRow()
        actions.add_item(buttons.KitConfirmButton(locale=locale))
        actions.add_item(buttons.KitBackButton(locale=locale))
        container.add_item(actions)

        self.add_item(container)

        if self.total_pages > 1:
            nav_row = ActionRow()
            prev_button = Button(
                label=t(locale, 'common-btn-prev')[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='kit_confirm_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page

            page_display = Button(
                label=t(locale, 'common-page-label', current=self.current_page + 1,
                       total=self.total_pages)[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='kit_confirm_page'
            )
            page_display.callback = self.show_page_jump_modal

            next_button = Button(
                label=t(locale, 'common-btn-next')[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='kit_confirm_next',
                disabled=(self.current_page >= self.total_pages - 1)
            )
            next_button.callback = self.next_page

            nav_row.add_item(prev_button)
            nav_row.add_item(page_display)
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

    async def submit(self, interaction):
        items = {
            item[CommonFields.NAME]: item[CommonFields.QUANTITY]
            for item in self.kit_data.get(CommonFields.ITEMS, [])
        }
        # Decode currency keys for display
        currency = {decode_mongo_key(k): v for k, v in self.kit_data.get(CharacterFields.CURRENCY, {}).items()}
        await _handle_submission(interaction, self.pending_character, items, currency)


class NewCharacterComplexItemPurchaseView(LocaleLayoutView):
    def __init__(self, parent_view, item):
        super().__init__(timeout=None)
        self.locale = getattr(parent_view, 'locale', DEFAULT_LOCALE)
        self.parent_view = parent_view
        self.item = item
        self.build_view()

    def build_view(self):
        self.clear_items()
        locale = getattr(self, 'locale', DEFAULT_LOCALE)
        container = Container()

        header = Section(accessory=buttons.WizardKeepShoppingButton(self.parent_view))
        header.add_item(TextDisplay(
            t(locale, 'player-title-purchase-options', itemName=self.item[CommonFields.NAME])
        ))
        container.add_item(header)
        container.add_item(Separator())

        costs = self.item.get(ShopFields.COSTS, [])
        currency_config = getattr(self.parent_view, 'currency_config', {})

        if not costs:
            container.add_item(TextDisplay(t(locale, 'player-msg-no-cost-options')))
        else:
            for index, cost_option in enumerate(costs):
                cost_str = format_complex_cost([cost_option], currency_config, locale=locale)

                select_button = buttons.WizardSelectCostOptionButton(self.parent_view, self.item, index)
                section = Section(accessory=select_button)
                section.add_item(TextDisplay(
                    t(locale, 'player-label-cost-option', index=index + 1, costString=cost_str)
                ))
                container.add_item(section)

        self.add_item(container)


class NewCharacterShopView(LocaleLayoutView):
    def __init__(self, pending_character, inventory_type):
        super().__init__(timeout=None)
        self.pending_character = pending_character
        self.character_id = pending_character['character_id']
        self.character_name = pending_character['name']
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
            collection_name=DatabaseCollections.NEW_CHARACTER_SHOP,
            query={CommonFields.ID: guild_id}
        )
        self.shop_stock = shop_query.get(ShopFields.SHOP_STOCK, []) if shop_query else []
        self.total_pages = math.ceil(len(self.shop_stock) / self.items_per_page)

        self.currency_config = await get_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name=DatabaseCollections.CURRENCY,
            query={CommonFields.ID: guild_id}
        )

        if self.inventory_type == InventoryType.PURCHASE.value:
            inventory_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.INVENTORY_CONFIG,
                query={CommonFields.ID: guild_id}
            )
            self.starting_wealth = (
                inventory_config.get(ConfigFields.NEW_CHARACTER_WEALTH)
                if inventory_config else None
            )

        self.build_view()

    def build_view(self):
        self.clear_items()
        locale = getattr(self, 'locale', DEFAULT_LOCALE)
        container = Container()

        title = t(locale, 'player-title-starting-shop', inventoryType=self.inventory_type.capitalize())
        if self.starting_wealth:
            amount = self.starting_wealth.get(CommonFields.AMOUNT, 0)
            currency = self.starting_wealth.get(CharacterFields.CURRENCY, '')
            formatted_currency = format_price_string(amount, currency, self.currency_config)
            title += '\n' + t(locale, 'player-label-starting-wealth', formattedCurrency=formatted_currency)

        container.add_item(TextDisplay(title))
        container.add_item(Separator())

        start = self.current_page * self.items_per_page
        end = start + self.items_per_page
        stock_slice = self.shop_stock[start:end]

        for item in stock_slice:
            cost_string = t(locale, 'common-label-free')
            if self.inventory_type == InventoryType.PURCHASE.value:
                costs = item.get(ShopFields.COSTS, [])
                cost_string = format_complex_cost(costs, self.currency_config, locale=locale)

            section = Section(accessory=buttons.WizardItemButton(
                item, self.inventory_type, cost_string, locale=locale
            ))

            display = f'**{item[CommonFields.NAME]}**'
            if item.get(CommonFields.QUANTITY, 1) > 1:
                display += f'(x{item.get(CommonFields.QUANTITY, 1)})'

            if item_name := item.get(CommonFields.NAME):
                item_quantity_in_cart = 0
                for value in self.cart.values():
                    if value['item'][CommonFields.NAME] == item_name:
                        item_quantity_in_cart += value[CommonFields.QUANTITY]

                if item_quantity_in_cart > 0:
                    display += f" {t(locale, 'player-label-in-cart', quantity=item_quantity_in_cart)}"

            if description := item.get('description'):
                display += f"\n*{escape_markdown(truncate_text(description, DisplayLimits.ITEM_DESCRIPTION))}*"

            section.add_item(TextDisplay(display))
            container.add_item(section)

        self.add_item(container)

        nav_row = ActionRow()
        if self.total_pages > 1:
            prev_button = Button(
                label=t(locale, 'common-btn-prev')[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='wiz_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page

            next_button = Button(
                label=t(locale, 'common-btn-next')[:DiscordLimits.BUTTON_LABEL],
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
        name = item[CommonFields.NAME]
        if name in self.cart:
            self.cart[name]['quantity'] += 1
        else:
            self.cart[name] = {'item': item, 'quantity': 1}
        self.build_view()
        await interaction.response.edit_message(view=self)

    async def add_to_cart_with_option(self, interaction, item, option_index=0):
        name = item[CommonFields.NAME]
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


class NewCharacterCartView(LocaleLayoutView):
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
        locale = getattr(self, 'locale', DEFAULT_LOCALE)
        container = Container()

        header_section = Section(accessory=buttons.WizardKeepShoppingButton(self.shop_view))
        header_section.add_item(TextDisplay(t(locale, 'player-title-review-cart')))
        container.add_item(header_section)
        container.add_item(Separator())

        total_cost_raw = {}
        self.cart_items = {}

        for key, data in self.shop_view.cart.items():
            item = data['item']
            quantity = data['quantity']
            option_index = data.get('optionIndex', 0)
            quantity_per_purchase = item.get(CommonFields.QUANTITY, 1)
            total_quantity = quantity * quantity_per_purchase

            name = item[CommonFields.NAME]
            self.cart_items[name] = self.cart_items.get(name, 0) + total_quantity

            if self.shop_view.inventory_type == InventoryType.PURCHASE.value:
                costs = item.get(ShopFields.COSTS, [])
                if 0 <= option_index < len(costs):
                    selected_cost = costs[option_index]
                    for currency, amount in selected_cost.items():
                        total_cost_raw[currency] = total_cost_raw.get(currency, 0) + (amount * quantity)

        self.can_afford = True
        warnings = []
        consolidated_costs = {}

        if self.shop_view.inventory_type == InventoryType.PURCHASE.value:
            consolidated_costs = consolidate_currency_totals(total_cost_raw, self.shop_view.currency_config)

            starting_wealth = self.shop_view.starting_wealth or {}
            wallet = {}
            if starting_wealth:
                wallet[starting_wealth.get(CharacterFields.CURRENCY)] = starting_wealth.get(CommonFields.AMOUNT, 0)

            for base_currency, amount in consolidated_costs.items():
                is_ok, _ = check_sufficient_funds(
                    wallet, self.shop_view.currency_config, base_currency, amount, locale=locale
                )
                if not is_ok:
                    self.can_afford = False
                    warnings.append(
                        t(locale, 'player-label-insufficient-currency', currencyName=titlecase(base_currency))
                    )

            final_currency = {}

            if starting_wealth:
                starting_currency = starting_wealth.get(CharacterFields.CURRENCY)
                starting_amount = starting_wealth.get(CommonFields.AMOUNT, 0)

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
            container.add_item(TextDisplay(t(locale, 'player-msg-cart-empty')))
        else:
            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            page_items = cart_items[start:end]

            for key, data in page_items:
                item = data['item']
                name = item.get(CommonFields.NAME)
                quantity = data['quantity']
                option_index = data.get('optionIndex', 0)
                quantity_per_purchase = item.get(CommonFields.QUANTITY, 1)
                total_quantity = quantity * quantity_per_purchase

                display = t(locale, 'player-label-cart-item', name=name, quantity=quantity)
                if quantity_per_purchase > 1:
                    display += f' {t(locale, "player-label-cart-item-total", totalQuantity=total_quantity)}'

                if self.shop_view.inventory_type == InventoryType.PURCHASE.value:
                    costs = item.get(ShopFields.COSTS, [])
                    if 0 <= option_index < len(costs):
                        selected_cost = costs[option_index]
                        if selected_cost:
                            total_line_cost = {k: v * quantity for k, v in selected_cost.items()}
                            price_label = format_complex_cost(
                                [total_line_cost], self.shop_view.currency_config, locale=locale
                            )
                            display += f' - {price_label}'

                edit_button = buttons.WizardEditCartItemButton(key, quantity, locale=locale)
                section = Section(accessory=edit_button)
                section.add_item(TextDisplay(display))
                container.add_item(section)

        container.add_item(Separator())

        if warnings:
            container.add_item(TextDisplay("\n".join(warnings)))
            container.add_item(Separator())

        if self.shop_view.inventory_type == InventoryType.PURCHASE.value:
            totals = format_consolidated_totals(consolidated_costs, self.shop_view.currency_config)
            if totals:
                container.add_item(TextDisplay(
                    t(locale, 'player-label-total-cost') + f'\n{", ".join(totals)}'
                ))
            else:
                container.add_item(TextDisplay(t(locale, 'player-label-total-cost-free')))

        self.add_item(container)

        nav_row = ActionRow()
        if self.total_pages > 1:
            prev_button = Button(
                label=t(locale, 'common-btn-prev')[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='wiz_cart_prev',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page

            page_display = Button(
                label=t(locale, 'player-label-cart-page', current=self.current_page + 1,
                       total=self.total_pages)[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id='wiz_cart_page_display'
            )
            page_display.callback = self.show_page_jump_modal

            next_button = Button(
                label=t(locale, 'common-btn-next')[:DiscordLimits.BUTTON_LABEL],
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
        currency_to_give = (
            self.remaining_wealth
            if self.shop_view.inventory_type == InventoryType.PURCHASE.value else {}
        )

        await _handle_submission(interaction, self.shop_view.pending_character, self.cart_items, currency_to_give)


class ApprovalPostView(LocaleLayoutView):
    """Persistent view posted in forum threads for GM approval of character submissions."""

    def __init__(self, submission_id):
        super().__init__(timeout=None)
        self.submission_id = submission_id
        self.locale = DEFAULT_LOCALE
        self.submission_data = None
        self.currency_config = None
        self.resolved = False
        self.resolved_by = None
        self.resolved_action = None  # 'approved' or 'denied'
        self.deny_reason = None

        self.items_per_page = 9
        self.current_page = 0
        self.total_pages = 1

    async def setup(self, bot):
        self.submission_data = await bot.gdb[DatabaseCollections.APPROVALS].find_one(
            {ApprovalFields.SUBMISSION_ID: self.submission_id}
        )
        if not self.submission_data:
            self.resolved = True
        else:
            guild_id = self.submission_data.get(ApprovalFields.GUILD_ID)
            if not self.locale or self.locale == DEFAULT_LOCALE:
                self.locale = await resolve_locale(bot=bot, guild_id=guild_id)
            self.currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: guild_id}
            )
        self.build_view()

    def build_view(self):
        self.clear_items()
        locale = getattr(self, 'locale', None) or DEFAULT_LOCALE
        container = Container()

        if not self.submission_data:
            container.add_item(TextDisplay(t(locale, 'player-approval-resolved')))
            self.add_item(container)
            return

        character_name = self.submission_data.get(ApprovalFields.CHARACTER_NAME, '')
        user_id = self.submission_data.get(ApprovalFields.USER_ID)
        items = self.submission_data.get(ApprovalFields.ITEMS, {})
        currency = self.submission_data.get(ApprovalFields.CURRENCY, {})

        # Header
        container.add_item(TextDisplay(
            t(locale, 'player-approval-post-header',
              characterName=character_name, userMention=f'<@{user_id}>')
        ))
        container.add_item(Separator())

        # Build combined detail lines (currency first, then items)
        detail_lines = []
        if currency:
            detail_lines.append(f'**{t(locale, "player-approval-post-currency")}**')
            currency_labels = format_consolidated_totals(currency, self.currency_config)
            for label in currency_labels:
                detail_lines.append(f'- {label}')

        if items:
            detail_lines.append(f'**{t(locale, "player-approval-post-items")}**')
            for name, quantity in sorted(items.items()):
                quantity_label = f'{quantity}x ' if quantity > 1 else ''
                detail_lines.append(
                    f'- {quantity_label}{escape_markdown(truncate_text(name, DisplayLimits.ITEM_NAME))}'
                )

        if not detail_lines:
            self.total_pages = 1
            self.current_page = 0
            container.add_item(TextDisplay(t(locale, 'common-label-none')))
        else:
            self.total_pages = math.ceil(len(detail_lines) / self.items_per_page)
            if self.current_page >= self.total_pages:
                self.current_page = max(0, self.total_pages - 1)

            start = self.current_page * self.items_per_page
            end = start + self.items_per_page
            container.add_item(TextDisplay('\n'.join(detail_lines[start:end])))

        container.add_item(Separator())

        if self.resolved:
            # Show resolution info instead of buttons
            if self.resolved_action == ApprovalFields.STATUS_APPROVED:
                container.add_item(TextDisplay(
                    t(locale, 'player-approval-approved-by', approver=self.resolved_by)
                ))
            elif self.resolved_action == ApprovalFields.STATUS_DENIED:
                deny_text = t(locale, 'player-approval-denied-by', denier=self.resolved_by)
                if self.deny_reason:
                    deny_text += f'\n{t(locale, "player-approval-deny-reason", reason=self.deny_reason)}'
                container.add_item(TextDisplay(deny_text))
            else:
                container.add_item(TextDisplay(t(locale, 'player-approval-resolved')))
        else:
            # Action buttons
            actions = ActionRow()
            actions.add_item(buttons.ApprovalApproveButton(self.submission_id, locale=locale))
            actions.add_item(buttons.ApprovalDenyButton(self.submission_id, locale=locale))
            actions.add_item(buttons.ApprovalEditButton(self.submission_id, locale=locale))
            container.add_item(actions)

        self.add_item(container)

        # Pagination (only when not resolved)
        if not self.resolved and self.total_pages > 1:
            nav_row = ActionRow()
            prev_button = Button(
                label=t(locale, 'common-btn-prev')[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id=f'approval_prev_{self.submission_id}',
                disabled=(self.current_page == 0)
            )
            prev_button.callback = self.prev_page

            page_display = Button(
                label=t(locale, 'common-page-label',
                        current=self.current_page + 1, total=self.total_pages)[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id=f'approval_page_{self.submission_id}'
            )
            page_display.callback = self.show_page_jump_modal

            next_button = Button(
                label=t(locale, 'common-btn-next')[:DiscordLimits.BUTTON_LABEL],
                style=discord.ButtonStyle.secondary,
                custom_id=f'approval_next_{self.submission_id}',
                disabled=(self.current_page >= self.total_pages - 1)
            )
            next_button.callback = self.next_page

            nav_row.add_item(prev_button)
            nav_row.add_item(page_display)
            nav_row.add_item(next_button)
            self.add_item(nav_row)

    async def interaction_check(self, interaction: discord.Interaction) -> bool:
        await super().interaction_check(interaction)
        if self.resolved:
            self.build_view()
            await interaction.response.edit_message(view=self)
            return False

        custom_id = interaction.data.get('custom_id', '')

        # Approve/Deny: require GM or mod
        if custom_id.startswith(('approve_sub_', 'deny_sub_')):
            if not await is_gm_or_mod(interaction.client, interaction.guild, interaction.user):
                caller_locale = await resolve_locale(interaction)
                await interaction.response.send_message(
                    t(caller_locale, 'player-approval-error-no-permission'), ephemeral=True
                )
                return False
            return True

        # Edit: require original submitter
        if custom_id.startswith('edit_sub_'):
            submitter_id = self.submission_data.get(ApprovalFields.USER_ID)
            if interaction.user.id != submitter_id:
                caller_locale = await resolve_locale(interaction)
                await interaction.response.send_message(
                    t(caller_locale, 'player-approval-error-not-submitter'), ephemeral=True
                )
                return False
            return True

        # Pagination: allow anyone who can see the thread
        return True

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
            caller_locale = await resolve_locale(interaction)
            logger.error(f'Failed to send PageJumpModal: {e}')
            await interaction.response.send_message(
                t(caller_locale, 'common-error-page-selector'), ephemeral=True
            )

    async def approve(self, interaction):
        bot = interaction.client
        try:
            await interaction.response.defer()

            async def _do_approve(session):
                # Atomically claim the submission to prevent concurrent approve/deny
                claimed = await bot.gdb[DatabaseCollections.APPROVALS].find_one_and_update(
                    {ApprovalFields.SUBMISSION_ID: self.submission_id,
                     ApprovalFields.STATUS: ApprovalFields.STATUS_PENDING},
                    {'$set': {ApprovalFields.STATUS: ApprovalFields.STATUS_PROCESSING}},
                    session=session
                )
                if not claimed:
                    return None

                # Use the claimed doc as the authoritative data source
                pending_character = claimed.get(ApprovalFields.PENDING_CHARACTER, {})
                character_id = pending_character.get(
                    ApprovalFields.CHARACTER_ID, claimed.get(ApprovalFields.CHARACTER_ID)
                )
                character_name = pending_character.get(
                    CommonFields.NAME, claimed.get(ApprovalFields.CHARACTER_NAME)
                )

                # Build the full character document with inventory and currency pre-populated
                inventory = {titlecase(k): int(v) for k, v in claimed.get(ApprovalFields.ITEMS, {}).items()}
                currency = {titlecase(k): int(v) for k, v in claimed.get(ApprovalFields.CURRENCY, {}).items()}

                # Create the character in the CHARACTERS collection
                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.mdb,
                    collection_name=DatabaseCollections.CHARACTERS,
                    query={CommonFields.ID: claimed[ApprovalFields.USER_ID]},
                    update_data={'$set': {
                        f'{CharacterFields.ACTIVE_CHARACTERS}.{claimed[ApprovalFields.GUILD_ID]}': character_id,
                        f'{CharacterFields.CHARACTERS}.{character_id}': {
                            CharacterFields.NAME: character_name,
                            'note': pending_character.get('note', ''),
                            'registeredDate': (
                                pending_character.get('registered_date')
                                or claimed.get(ApprovalFields.TIMESTAMP)
                            ),
                            CharacterFields.ATTRIBUTES: {
                                'level': None,
                                CharacterFields.EXPERIENCE: None,
                                CharacterFields.INVENTORY: inventory,
                                CharacterFields.CURRENCY: currency
                            }
                        }
                    }},
                    session=session
                )

                # Delete the approval record
                await delete_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name=DatabaseCollections.APPROVALS,
                    search_filter={ApprovalFields.SUBMISSION_ID: self.submission_id},
                    cache_id=f'approval_submission:{self.submission_id}',
                    session=session
                )

                return claimed

            result = await run_in_transaction(bot, _do_approve)

            if result is None:
                self.resolved = True
                self.build_view()
                await interaction.edit_original_response(view=self)
                return

            # Transaction committed — handle Discord side effects
            self.submission_data = result
            guild_id = result[ApprovalFields.GUILD_ID]
            user_id = result[ApprovalFields.USER_ID]
            character_name = result.get(ApprovalFields.PENDING_CHARACTER, {}).get(
                CommonFields.NAME, result.get(ApprovalFields.CHARACTER_NAME)
            )
            granted_permissions = result.get(ApprovalFields.GRANTED_PERMISSIONS, [])

            # Revoke granted forum permissions
            thread = interaction.channel
            if isinstance(thread, discord.Thread):
                await self._revoke_submitter_permissions(
                    thread, bot, guild_id, user_id, granted_permissions
                )

            # Update view to resolved state
            self.resolved = True
            self.resolved_by = interaction.user.mention
            self.resolved_action = ApprovalFields.STATUS_APPROVED
            self.build_view()
            await interaction.edit_original_response(view=self)

            # DM the player
            try:
                user = await bot.fetch_user(user_id)
                user_locale = await resolve_locale(bot=bot, user_id=user_id, guild_id=guild_id)
                guild = bot.get_guild(guild_id)
                guild_name = guild.name if guild else 'Unknown'
                dm_embed = discord.Embed(
                    title=t(user_locale, 'player-dm-title-approved'),
                    description=t(user_locale, 'player-dm-desc-approved',
                                  characterName=character_name,
                                  approver=interaction.user.display_name,
                                  guildName=guild_name),
                    color=discord.Color.green()
                )
                await user.send(embed=dm_embed)
            except discord.errors.Forbidden:
                logger.warning(f'Could not DM user {user_id} about approval — DMs may be disabled.')

            # Lock and archive the thread
            if isinstance(thread, discord.Thread):
                await thread.edit(locked=True, archived=True)

        except Exception as e:
            await log_exception(e, interaction)

    async def deny(self, interaction):
        try:
            # Present the GM with a reason modal
            from ReQuest.ui.player import modals as player_modals
            modal = player_modals.DenyReasonModal(self)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def process_denial(self, interaction, reason=''):
        bot = interaction.client
        try:
            await interaction.response.defer()

            async def _do_denial(session):
                # Atomically claim the submission to prevent concurrent approve/deny
                claimed = await bot.gdb[DatabaseCollections.APPROVALS].find_one_and_update(
                    {ApprovalFields.SUBMISSION_ID: self.submission_id,
                     ApprovalFields.STATUS: ApprovalFields.STATUS_PENDING},
                    {'$set': {ApprovalFields.STATUS: ApprovalFields.STATUS_PROCESSING}},
                    session=session
                )
                if not claimed:
                    return None

                # Delete the approval record (character was never created)
                await delete_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name=DatabaseCollections.APPROVALS,
                    search_filter={ApprovalFields.SUBMISSION_ID: self.submission_id},
                    cache_id=f'approval_submission:{self.submission_id}',
                    session=session
                )

                return claimed

            result = await run_in_transaction(bot, _do_denial)

            if result is None:
                self.resolved = True
                self.build_view()
                await interaction.edit_original_response(view=self)
                return

            # Transaction committed — handle Discord side effects
            self.submission_data = result
            user_id = result[ApprovalFields.USER_ID]
            guild_id = result[ApprovalFields.GUILD_ID]
            character_name = result.get(ApprovalFields.CHARACTER_NAME, '')
            granted_permissions = result.get(ApprovalFields.GRANTED_PERMISSIONS, [])

            # Revoke granted forum permissions
            thread = interaction.channel
            if isinstance(thread, discord.Thread):
                await self._revoke_submitter_permissions(
                    thread, bot, guild_id, user_id, granted_permissions
                )

            # Update view to resolved state
            self.resolved = True
            self.resolved_by = interaction.user.mention
            self.resolved_action = ApprovalFields.STATUS_DENIED
            self.deny_reason = reason or None
            self.build_view()
            await interaction.edit_original_response(view=self)

            # DM the player
            try:
                user = await bot.fetch_user(user_id)
                user_locale = await resolve_locale(bot=bot, user_id=user_id, guild_id=guild_id)
                guild = bot.get_guild(guild_id)
                guild_name = guild.name if guild else 'Unknown'
                description = t(user_locale, 'player-dm-desc-denied',
                                characterName=character_name,
                                denier=interaction.user.display_name,
                                guildName=guild_name)
                if reason:
                    description += f'\n\n{t(user_locale, "player-approval-deny-reason", reason=reason)}'
                dm_embed = discord.Embed(
                    title=t(user_locale, 'player-dm-title-denied'),
                    description=description,
                    color=discord.Color.red()
                )
                await user.send(embed=dm_embed)
            except discord.errors.Forbidden:
                logger.warning(f'Could not DM user {user_id} about denial — DMs may be disabled.')

            # Lock and archive the thread
            if isinstance(thread, discord.Thread):
                await thread.edit(locked=True, archived=True)

        except Exception as e:
            await log_exception(e, interaction)

    @staticmethod
    async def _revoke_submitter_permissions(thread, bot, guild_id, user_id, granted_permissions):
        """Revoke only the forum channel permissions that were granted by the bot."""
        try:
            if not granted_permissions:
                return
            guild = bot.get_guild(guild_id)
            if not guild:
                return
            member = guild.get_member(user_id) or await guild.fetch_member(user_id)
            forum_channel = thread.parent
            if not forum_channel:
                return
            overwrite = forum_channel.overwrites_for(member)
            for perm in granted_permissions:
                setattr(overwrite, perm, None)
            if overwrite.is_empty():
                await forum_channel.set_permissions(member, overwrite=None)
            else:
                await forum_channel.set_permissions(member, overwrite=overwrite)
        except Exception as e:
            logger.warning(f'Could not revoke forum access for user {user_id}: {e}')

    async def edit(self, interaction):
        try:
            # Re-open the inventory wizard for the submitting player
            pending_character = self.submission_data.get(ApprovalFields.PENDING_CHARACTER)
            if pending_character:
                pending_character = dict(pending_character)
            else:
                # Backwards compat: build from flat fields
                pending_character = {
                    'character_id': self.submission_data.get(ApprovalFields.CHARACTER_ID),
                    'name': self.submission_data.get(ApprovalFields.CHARACTER_NAME),
                    'note': '',
                    'registered_date': self.submission_data.get(ApprovalFields.TIMESTAMP),
                    'inventory_type': 'open'
                }

            inventory_type = pending_character.get('inventory_type', 'open')

            # Store the submission_id so _handle_submission can update instead of insert
            pending_character['submission_id'] = self.submission_id

            caller_locale = await resolve_locale(interaction)
            view = NewCharacterWizardView(pending_character, inventory_type, locale=caller_locale)
            await interaction.response.send_message(view=view, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


async def _handle_submission(interaction, pending_character, items, currency):
    try:
        locale = await resolve_locale(interaction)
        guild_id = interaction.guild_id
        bot = interaction.client
        member_id = interaction.user.id
        character_id = pending_character['character_id']
        character_name = pending_character['name']

        currency_config = await get_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name=DatabaseCollections.CURRENCY,
            query={CommonFields.ID: guild_id}
        )

        approval_query = await get_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name=DatabaseCollections.APPROVAL_QUEUE_CHANNEL,
            query={CommonFields.ID: guild_id}
        )

        channel_id = strip_id(approval_query[ConfigFields.APPROVAL_QUEUE_CHANNEL]) if approval_query else None
        forum_channel = bot.get_channel(channel_id) if channel_id else None

        # Check if this is a re-submission (edit flow from ApprovalPostView)
        existing_submission_id = pending_character.get('submission_id')

        if forum_channel and isinstance(forum_channel, discord.ForumChannel):
            guild_locale = await resolve_locale(bot=bot, guild_id=guild_id)

            if existing_submission_id:
                # Edit re-submission: update the existing APPROVALS doc and refresh the forum post
                submission_id = existing_submission_id
                await interaction.response.defer()

                result = await bot.gdb[DatabaseCollections.APPROVALS].update_one(
                    {ApprovalFields.SUBMISSION_ID: submission_id,
                     ApprovalFields.STATUS: ApprovalFields.STATUS_PENDING,
                     ApprovalFields.USER_ID: member_id},
                    {'$set': {
                        ApprovalFields.PENDING_CHARACTER: pending_character,
                        ApprovalFields.ITEMS: items,
                        ApprovalFields.CURRENCY: currency,
                        ApprovalFields.TIMESTAMP: discord.utils.utcnow()
                    }}
                )

                if result.matched_count == 0:
                    resolved_view = LayoutView()
                    container = Container(accent_colour=discord.Colour.red())
                    container.add_item(TextDisplay(t(locale, 'player-approval-resolved')))
                    resolved_view.add_item(container)
                    await interaction.edit_original_response(view=resolved_view)
                    return

                confirmation_view = LayoutView()
                container = Container(accent_colour=discord.Colour.green())
                container.add_item(TextDisplay(t(locale, 'player-msg-submission-updated')))
                confirmation_view.add_item(container)
                await interaction.edit_original_response(view=confirmation_view)

                # Refresh the forum post view
                approval_doc = await bot.gdb[DatabaseCollections.APPROVALS].find_one(
                    {ApprovalFields.SUBMISSION_ID: submission_id}
                )
                if approval_doc and approval_doc.get(ApprovalFields.MESSAGE_ID):
                    thread_id = approval_doc.get(ApprovalFields.THREAD_ID)
                    thread = bot.get_channel(thread_id)
                    if thread:
                        message = thread.get_partial_message(approval_doc[ApprovalFields.MESSAGE_ID])
                        approval_view = ApprovalPostView(submission_id)
                        approval_view.locale = guild_locale
                        await approval_view.setup(bot)
                        await message.edit(view=approval_view)
            else:
                # New submission: create thread with ApprovalPostView
                await interaction.response.defer()

                submission_id = shortuuid.uuid()[:8]
                submission_data = {
                    ApprovalFields.GUILD_ID: guild_id,
                    ApprovalFields.USER_ID: member_id,
                    ApprovalFields.PENDING_CHARACTER: pending_character,
                    ApprovalFields.CHARACTER_ID: character_id,
                    ApprovalFields.CHARACTER_NAME: character_name,
                    ApprovalFields.ITEMS: items,
                    ApprovalFields.CURRENCY: currency,
                    ApprovalFields.STATUS: ApprovalFields.STATUS_PENDING,
                    ApprovalFields.TIMESTAMP: discord.utils.utcnow(),
                    ApprovalFields.SUBMISSION_ID: submission_id
                }

                # Create ApprovalPostView for the forum thread
                approval_view = ApprovalPostView(submission_id)
                approval_view.submission_data = submission_data
                approval_view.currency_config = currency_config
                approval_view.locale = guild_locale
                approval_view.build_view()

                thread_name = t(guild_locale, 'player-label-approval-thread', characterName=character_name)
                thread_message = await forum_channel.create_thread(name=thread_name, view=approval_view)

                thread = thread_message.thread
                submission_data[ApprovalFields.THREAD_ID] = thread.id
                submission_data[ApprovalFields.MESSAGE_ID] = thread_message.message.id

                await bot.gdb[DatabaseCollections.APPROVALS].insert_one(submission_data)

                # Clean up the pending character record now that the submission is persisted
                pending_id = f'{member_id}_{guild_id}'
                await delete_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name=DatabaseCollections.PENDING_CHARACTERS,
                    search_filter={CommonFields.ID: pending_id},
                    cache_id=pending_id
                )

                # Grant forum channel access to submitter for any missing permissions
                try:
                    forum_perms = forum_channel.permissions_for(interaction.user)
                    needed_perms = {
                        'view_channel': not forum_perms.view_channel,
                        'send_messages_in_threads': not forum_perms.send_messages_in_threads,
                        'read_message_history': not forum_perms.read_message_history,
                    }
                    if any(needed_perms.values()):
                        overwrite = forum_channel.overwrites_for(interaction.user)
                        granted = []
                        for perm, needed in needed_perms.items():
                            if needed and getattr(overwrite, perm) is None:
                                setattr(overwrite, perm, True)
                                granted.append(perm)
                        if granted:
                            await forum_channel.set_permissions(interaction.user, overwrite=overwrite)
                            await bot.gdb[DatabaseCollections.APPROVALS].update_one(
                                {ApprovalFields.SUBMISSION_ID: submission_id},
                                {'$set': {ApprovalFields.GRANTED_PERMISSIONS: granted}}
                            )
                except Exception as e:
                    logger.warning(f'Could not grant forum access for user {member_id}: {e}')

                # Send canned instructions in the thread
                await thread.send(t(
                    guild_locale, 'player-approval-thread-instructions',
                    characterName=character_name,
                    playerMention=interaction.user.mention
                ))

                # Return player to character list
                new_view = CharacterBaseView()
                await setup_view(new_view, interaction)
                await interaction.edit_original_response(view=new_view)

                confirmation_embed = discord.Embed(
                    title=t(locale, 'player-embed-title-submission-sent'),
                    description=t(locale, 'player-embed-desc-submission-sent',
                                  characterName=character_name,
                                  threadUrl=thread.jump_url),
                    color=discord.Color.green()
                )
                await interaction.followup.send(embed=confirmation_embed, ephemeral=True)

        else:
            # Direct-apply path: create character and apply inventory immediately
            await interaction.response.defer()

            # Build the full character document with inventory and currency pre-populated
            starting_inventory = {titlecase(k): int(v) for k, v in items.items()}
            starting_currency = {titlecase(k): int(v) for k, v in currency.items()}

            await update_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name=DatabaseCollections.CHARACTERS,
                query={CommonFields.ID: member_id},
                update_data={'$set': {
                    f'{CharacterFields.ACTIVE_CHARACTERS}.{guild_id}': character_id,
                    f'{CharacterFields.CHARACTERS}.{character_id}': {
                        CharacterFields.NAME: character_name,
                        'note': pending_character.get('note', ''),
                        'registeredDate': pending_character.get('registered_date'),
                        CharacterFields.ATTRIBUTES: {
                            'level': None,
                            CharacterFields.EXPERIENCE: None,
                            CharacterFields.INVENTORY: starting_inventory,
                            CharacterFields.CURRENCY: starting_currency
                        }
                    }
                }}
            )

            # Clean up the pending character record now that the character is created
            pending_id = f'{member_id}_{guild_id}'
            await delete_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.PENDING_CHARACTERS,
                search_filter={CommonFields.ID: pending_id},
                cache_id=pending_id
            )

            report_embed = discord.Embed(
                title=t(locale, 'player-embed-title-starting-inventory'),
                color=discord.Color.green()
            )
            report_embed.description = (
                t(locale, 'player-embed-desc-starting-inventory',
                  playerMention=interaction.user.mention,
                  characterName=character_name) + '\n'
            )

            added_items_summary = []
            for name, quantity in items.items():
                quantity_label = f'{quantity}x ' if quantity > 1 else ''
                added_items_summary.append(f'{quantity_label}{escape_markdown(titlecase(name))}')

            report_embed.add_field(
                name=t(locale, 'player-embed-field-items-received'),
                value='\n'.join(added_items_summary) or t(locale, 'common-label-none'), inline=False
            )

            currency_labels = format_consolidated_totals(currency, currency_config)
            report_embed.add_field(
                name=t(locale, 'player-embed-field-currency-received-label'),
                value='\n'.join(currency_labels) or t(locale, 'common-label-none'), inline=False
            )

            report_embed.set_footer(text=t(
                locale, 'player-embed-footer-transaction-id',
                transactionId=shortuuid.uuid()[:12]
            ))

            view = CharacterBaseView()
            await setup_view(view, interaction)
            await interaction.edit_original_response(view=view)
            await interaction.followup.send(embed=report_embed, ephemeral=True)

    except Exception as e:
        await log_exception(e, interaction)
