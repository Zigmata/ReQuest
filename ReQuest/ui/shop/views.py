import logging
import math

import discord
import shortuuid
from discord.ui import (
    LayoutView,
    ActionRow,
    Container,
    TextDisplay,
    Section,
    Separator,
    Thumbnail,
    Button
)
from titlecase import titlecase

from ReQuest.ui.common import modals as common_modals
from ReQuest.ui.shop import buttons
from ReQuest.utilities.supportFunctions import (
    check_sufficient_funds,
    apply_currency_change_local,
    apply_item_change_local,
    strip_id,
    format_consolidated_totals,
    consolidate_currency_totals,
    get_cached_data,
    update_cached_data,
    format_complex_cost,
    get_shop_stock,
    get_cart,
    add_item_to_cart,
    clear_cart_and_release_stock,
    finalize_cart_purchase,
    log_exception,
    UserFeedbackError
)

logger = logging.getLogger(__name__)


class ShopBaseView(LayoutView):
    def __init__(self, shop_data, channel_id: str = None):
        super().__init__(timeout=600)
        self.shop_data = shop_data
        self.channel_id = channel_id
        self.all_stock = self.shop_data.get('shopStock', [])
        self.items_per_page = 9
        self.current_page = 0
        self.total_pages = math.ceil(len(self.all_stock) / self.items_per_page) if self.all_stock else 1
        self.currency_config = {}
        self.cart = {}
        self.stock_info = {}
        self.guild_id = None
        self.user_id = None
        self.bot = None

    async def setup(self, bot, guild):
        self.bot = bot
        self.guild_id = guild.id

        self.currency_config = await get_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name='currency',
            query={'_id': guild.id}
        )

        # Load stock info for limited items
        if self.channel_id:
            self.stock_info = await get_shop_stock(bot, guild.id, self.channel_id)

        self.build_view()

    async def setup_for_user(self, interaction: discord.Interaction):
        self.user_id = interaction.user.id
        self.bot = interaction.client

        if not self.channel_id:
            self.channel_id = str(interaction.channel.id)

        # Load existing cart from database
        if self.user_id and self.channel_id:
            db_cart = await get_cart(self.bot, self.guild_id, self.user_id, self.channel_id)
            if db_cart:
                self.cart = db_cart.get('items', {})

        # Refresh stock info
        self.stock_info = await get_shop_stock(self.bot, self.guild_id, self.channel_id)

    def build_view(self):
        try:
            self.clear_items()
            container = Container()
            header_items = []

            if shop_name := self.shop_data.get('shopName'):
                header_items.append(TextDisplay(f'**{shop_name}**'))
            if shop_keeper := self.shop_data.get('shopKeeper'):
                header_items.append(TextDisplay(f'Shopkeeper: **{shop_keeper}**'))
            if shop_description := self.shop_data.get('shopDescription'):
                header_items.append(TextDisplay(f'*{shop_description}*'))

            if shop_image := self.shop_data.get('shopImage'):
                shop_image = Thumbnail(media=f'{shop_image}')
                shop_header = Section(accessory=shop_image)

                for item in header_items:
                    shop_header.add_item(item)

                container.add_item(shop_header)
            else:
                for item in header_items:
                    container.add_item(item)

            container.add_item(Separator())

            start_index = self.current_page * self.items_per_page
            end_index = start_index + self.items_per_page
            current_stock = self.all_stock[start_index:end_index]

            for item in current_stock:
                costs = item.get('costs', [])
                cost_string = format_complex_cost(costs, getattr(self, 'currency_config', {}))

                item_name = item.get('name', 'Unknown Item')

                # Get stock info for this item
                item_stock_info = self.stock_info.get(item_name) if self.stock_info else None

                buy_button = buttons.ShopItemButton(item, cost_string, item_stock_info)
                section = Section(accessory=buy_button)

                item_description = item.get('description', None)
                item_quantity = item.get('quantity', 1)
                item_display_name = f'{item_name} x{item_quantity}' if item_quantity > 1 else item_name

                cart_quantity = 0
                for value in self.cart.values():
                    cart_item = value.get('item', value)  # Handle both DB and local formats
                    if cart_item.get('name') == item_name:
                        cart_quantity += value.get('quantity', 0)

                content = item_display_name
                if cart_quantity > 0:
                    content += f' (In Cart: {cart_quantity})'

                # Show stock info if item has limits
                if item_stock_info is not None:
                    available = item_stock_info.get('available', 0)
                    if available == 0:
                        content += f'\n**OUT OF STOCK**'
                    else:
                        content += f'\n*Stock: {available}*'

                if item_description:
                    content += f'\n*{item_description}*'

                section.add_item(TextDisplay(content))
                container.add_item(section)

            self.add_item(container)

            # Pagination buttons
            nav_row = ActionRow()
            if self.total_pages > 1:
                prev_button = Button(
                    label='Previous',
                    style=discord.ButtonStyle.secondary,
                    custom_id='shop_prev_page',
                    disabled=(self.current_page == 0)
                )
                prev_button.callback = self.prev_page

                page_display = Button(
                    label=f'Page {self.current_page + 1} of {self.total_pages}',
                    style=discord.ButtonStyle.secondary,
                    custom_id='shop_page_display'
                )
                page_display.callback = self.show_page_jump_modal

                next_button = Button(
                    label='Next',
                    style=discord.ButtonStyle.primary,
                    custom_id='shop_next_page',
                    disabled=(self.current_page >= self.total_pages - 1)
                )
                next_button.callback = self.next_page

                nav_row.add_item(prev_button)
                nav_row.add_item(page_display)
                nav_row.add_item(next_button)

            cart_item_count = sum(item.get('quantity', 0) for item in self.cart.values())
            view_cart_button = buttons.ViewCartButton(self)
            view_cart_button.label = f'View Cart ({cart_item_count})' if cart_item_count > 0 else 'View Cart'

            nav_row.add_item(view_cart_button)
            self.add_item(nav_row)

        except Exception as e:
            logging.error(f'Error building shop view: {e}')

    async def add_to_cart_with_option(self, interaction: discord.Interaction, item, option_index=0):
        try:
            # Ensure user context is set up
            if not self.user_id:
                await self.setup_for_user(interaction)

            item_name = item.get('name')

            # Use database-backed cart with reservation
            success = await add_item_to_cart(
                self.bot, self.guild_id, self.user_id, self.channel_id, item, option_index
            )

            if not success:
                raise UserFeedbackError(f'**{item_name}** is out of stock.')

            # Refresh local cart cache and stock info
            db_cart = await get_cart(self.bot, self.guild_id, self.user_id, self.channel_id)
            if db_cart:
                self.cart = db_cart.get('items', {})

            # Refresh stock info after reservation
            self.stock_info = await get_shop_stock(self.bot, self.guild_id, self.channel_id)

            self.build_view()
            await interaction.response.edit_message(view=self)
        except Exception as e:
            await log_exception(e, interaction)

    async def on_timeout(self):
        try:
            if self.user_id and self.channel_id and self.bot:
                await clear_cart_and_release_stock(self.bot, self.guild_id, self.user_id, self.channel_id)
        except Exception as e:
            logging.error(f'Error releasing stock on timeout: {e}')

    async def prev_page(self, interaction: discord.Interaction):
        if self.current_page > 0:
            self.current_page -= 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def next_page(self, interaction: discord.Interaction):
        if self.current_page < self.total_pages - 1:
            self.current_page += 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def show_page_jump_modal(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(common_modals.PageJumpModal(self))
        except Exception as e:
            logging.error(f'Failed to send PageJumpModal: {e}')
            await interaction.response.send_message('Could not open page selector', ephemeral=True)


class ShopCartView(LayoutView):
    def __init__(self, prev_view: ShopBaseView, currency_config: dict, character_data: dict):
        super().__init__(timeout=None)
        self.prev_view = prev_view
        self.currency_config = currency_config
        self.character_data = character_data
        self.base_totals = {}

        self.items_per_page = 9
        self.current_page = 0
        self.total_pages = math.ceil(len(self.prev_view.cart) / self.items_per_page)

        self.build_view()

    def build_view(self):
        try:
            self.clear_items()
            container = Container()

            header_section = Section(accessory=buttons.CartBackButton(self.prev_view))
            header_section.add_item(TextDisplay('🛒 **Shopping Cart**'))
            container.add_item(header_section)
            container.add_item(Separator())

            raw_totals = {}
            warnings = []
            can_afford_all = True

            # Re-calculate pages since carts are dynamic
            cart_length = len(self.prev_view.cart)
            self.total_pages = math.ceil(cart_length / self.items_per_page)
            if self.current_page >= self.total_pages > 0:
                self.current_page = max(0, self.total_pages - 1)

            if not self.prev_view.cart:
                container.add_item(TextDisplay('Your cart is empty.'))
            else:
                for item_key, data in self.prev_view.cart.items():
                    item = data['item']
                    quantity = data['quantity']
                    option_index = data.get('option_index', 0)

                    costs = item.get('costs', [])
                    if 0 <= option_index < len(costs):
                        selected_cost = costs[option_index]
                        for currency_name, amount in selected_cost.items():
                            raw_totals[currency_name] = raw_totals.get(currency_name, 0.0) + (amount * quantity)

                self.base_totals = consolidate_currency_totals(raw_totals, self.currency_config)

                if not self.character_data:
                    warnings.append("⚠️ No active character found. Cannot verify funds.")
                    can_afford_all = False
                else:
                    player_wallet = self.character_data['attributes'].get('currency', {})
                    for base_currency, amount in self.base_totals.items():
                        is_ok, _ = check_sufficient_funds(player_wallet, self.currency_config, base_currency, amount)
                        if not is_ok:
                            can_afford_all = False
                            warnings.append(f"⚠️ Insufficient funds for {titlecase(base_currency)}")

                start_index = self.current_page * self.items_per_page
                end_index = start_index + self.items_per_page

                all_cart_items = list(self.prev_view.cart.items())
                current_cart = all_cart_items[start_index:end_index]

                for item_key, data in current_cart:
                    item = data['item']
                    quantity = data['quantity']
                    quantity_per_item = item.get('quantity', 1)
                    option_index = data.get('option_index', 0)
                    total_item_quantity = quantity * quantity_per_item

                    costs = item.get('costs', [])
                    price_string = 'Invalid Cost'
                    if not costs:
                        price_string = 'Free'
                    elif 0 <= option_index < len(costs):
                        selected_cost = costs[option_index]
                        if not selected_cost:
                            price_string = 'Free'
                        else:
                            total_cost = {k: v * quantity for k, v in selected_cost.items()}
                            price_string = format_complex_cost([total_cost], self.currency_config)

                    edit_button = buttons.EditCartItemButton(item_key, quantity)
                    section = Section(accessory=edit_button)

                    item_line = (f'**{item["name"]}** x{quantity} '
                                 f'(Total: {total_item_quantity}) - {price_string}')
                    section.add_item(TextDisplay(item_line))
                    container.add_item(section)

                container.add_item(Separator())

                total_strings = format_consolidated_totals(self.base_totals, self.currency_config)
                cost_string = f'**Total Cost:**'
                if total_strings:
                    cost_string += f'\n{', '.join(total_strings)}'
                else:
                    cost_string += '\nFree'
                if warnings:
                    cost_string += f'\n**Warning:**\n- ' + '\n- '.join(warnings)

                container.add_item(TextDisplay(cost_string))

            self.add_item(container)

            nav_row = ActionRow()
            if self.total_pages > 1:

                prev_button = Button(
                    label='Previous',
                    style=discord.ButtonStyle.secondary,
                    custom_id='shop_prev_page',
                    disabled=(self.current_page == 0)
                )
                prev_button.callback = self.prev_page

                page_display = Button(
                    label=f'Page {self.current_page + 1} of {self.total_pages}',
                    style=discord.ButtonStyle.secondary,
                    custom_id='shop_page_display'
                )
                page_display.callback = self.show_page_jump_modal

                next_button = Button(
                    label='Next',
                    style=discord.ButtonStyle.primary,
                    custom_id='shop_next_page',
                    disabled=(self.current_page >= self.total_pages - 1)
                )
                next_button.callback = self.next_page

                nav_row.add_item(prev_button)
                nav_row.add_item(page_display)
                nav_row.add_item(next_button)

            checkout_button = buttons.CartCheckoutButton(self)
            checkout_button.disabled = not (can_afford_all and len(self.prev_view.cart) > 0)
            cart_clear_button = buttons.CartClearButton(self)
            cart_clear_button.disabled = not len(self.prev_view.cart) > 0
            nav_row.add_item(checkout_button)
            nav_row.add_item(cart_clear_button)

            self.add_item(nav_row)
        except Exception as e:
            logging.error(f'Error building cart view: {e}')

    async def prev_page(self, interaction: discord.Interaction):
        if self.current_page > 0:
            self.current_page -= 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def next_page(self, interaction: discord.Interaction):
        if self.current_page < self.total_pages - 1:
            self.current_page += 1
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def show_page_jump_modal(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(common_modals.PageJumpModal(self))
        except Exception as e:
            logging.error(f'Failed to send PageJumpModal: {e}')
            await interaction.response.send_message('Could not open page selector', ephemeral=True)

    async def checkout(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            user_id = interaction.user.id

            channel_id = self.prev_view.channel_id

            character_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': user_id}
            )

            if not character_query or str(guild_id) not in character_query['activeCharacters']:
                await interaction.response.send_message("You do not have an active character on this server.",
                                                        ephemeral=True)
                return

            active_char_id = character_query['activeCharacters'][str(guild_id)]
            character_data = character_query['characters'][active_char_id]

            for base_currency, amount in self.base_totals.items():
                is_ok, msg = check_sufficient_funds(character_data['attributes'].get('currency', {}),
                                                    self.currency_config, base_currency, amount)
                if not is_ok:
                    await interaction.response.send_message(
                        f"Checkout failed: Insufficient {titlecase(base_currency)}.", ephemeral=True)
                    return

            for base_currency, amount in self.base_totals.items():
                character_data = apply_currency_change_local(character_data, self.currency_config,
                                                             base_currency, -amount)

            added_items_summary = []
            for item_key, data in self.prev_view.cart.items():
                item = data.get('item', data)  # Handle both DB and local formats
                quantity = data.get('quantity', 0)
                qty_per_item = item.get('quantity', 1)
                total_qty = quantity * qty_per_item

                character_data = apply_item_change_local(character_data, item['name'], total_qty)
                summary_string = (f'{total_qty}x ' if total_qty > 1 else '') + titlecase(item["name"])
                added_items_summary.append(summary_string)

            await update_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': user_id},
                update_data={'$set': {f'characters.{active_char_id}': character_data}}
            )

            # Finalize stock (remove from reserved counts) and clear cart from database
            await finalize_cart_purchase(bot, guild_id, user_id, channel_id)

            log_channel = None
            log_channel_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='shopLogChannel',
                query={'_id': guild_id}
            )
            if log_channel_query:
                log_channel_id = strip_id(log_channel_query['shopLogChannel'])
                log_channel = interaction.guild.get_channel(log_channel_id)

            receipt_embed = discord.Embed(title="Shopping Report", color=discord.Color.gold())
            receipt_embed.description = (
                f'Player: {interaction.user.mention} as `{character_data["name"]}`\n'
                f'Shop: {self.prev_view.shop_data.get("shopName", "Unknown Shop")}'
            )
            receipt_embed.add_field(name="Purchased", value="\n".join(added_items_summary) or 'No Items', inline=False)

            total_strs = format_consolidated_totals(self.base_totals, self.currency_config)
            receipt_embed.add_field(name="Total Paid", value="\n".join(total_strs) or '0', inline=False)

            receipt_embed.set_footer(text=f"Transaction ID: {shortuuid.uuid()[:12]}")

            if log_channel:
                await log_channel.send(embed=receipt_embed)

            # Clear local cart cache and refresh stock info
            self.prev_view.cart.clear()
            self.prev_view.stock_info = await get_shop_stock(bot, guild_id, channel_id)
            self.prev_view.build_view()

            await interaction.response.edit_message(view=self.prev_view)
            await interaction.followup.send(embed=receipt_embed, ephemeral=True)
        except Exception as e:
            logging.error(f'Error during checkout: {e}')


class ComplexItemPurchaseView(LayoutView):
    def __init__(self, parent_view, item):
        super().__init__(timeout=None)
        self.parent_view = parent_view
        self.item = item
        self.build_view()

    def build_view(self):
        self.clear_items()
        container = Container()

        header = Section(accessory=buttons.CartBackButton(self.parent_view))
        header.add_item(TextDisplay(f"**Purchase Options: {self.item['name']}**"))
        container.add_item(header)
        container.add_item(Separator())

        costs = self.item.get('costs', [])
        currency_config = getattr(self.parent_view, 'currency_config', {})

        if not costs:
            container.add_item(TextDisplay("There are no purchase options available for this item."))
        else:
            for index, cost_option in enumerate(costs):
                cost_str = format_complex_cost([cost_option], currency_config)

                select_button = buttons.SelectCostOptionButton(self.parent_view, self.item, index)
                section = Section(accessory=select_button)
                section.add_item(TextDisplay(cost_str))
                container.add_item(section)

        self.add_item(container)
