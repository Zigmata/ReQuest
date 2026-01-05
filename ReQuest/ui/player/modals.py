import logging
from datetime import datetime, timezone
from titlecase import titlecase

import discord
import discord.ui
import shortuuid
from discord.ui import Modal

from ReQuest.utilities.supportFunctions import (
    find_currency_or_denomination,
    log_exception,
    trade_currency,
    trade_item,
    check_sufficient_funds,
    update_character_inventory,
    format_currency_display,
    format_price_string,
    setup_view,
    strip_id,
    UserFeedbackError,
    get_cached_data,
    update_cached_data,
    create_container,
    rename_container,
    get_container_name,
    consume_item_from_container,
    move_item_between_containers
)

logger = logging.getLogger(__name__)


class TradeModal(Modal):
    def __init__(self, target: discord.Member):
        super().__init__(
            title=f'Trading with {target.name}',
            timeout=180
        )
        self.target = target
        self.item_name_text_input = discord.ui.TextInput(label='Name',
                                                         placeholder='Enter the name of the item you are trading',
                                                         custom_id='item_name_text_input')
        self.item_quantity_text_input = discord.ui.TextInput(label='Quantity',
                                                             placeholder='Enter the amount you are trading',
                                                             custom_id='item_quantity_text_input')
        self.add_item(self.item_name_text_input)
        self.add_item(self.item_quantity_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            transaction_id = shortuuid.uuid()[:12]
            member_id = interaction.user.id
            target_id = self.target.id
            guild_id = interaction.guild_id
            quantity = float(self.item_quantity_text_input.value)
            item_name = self.item_name_text_input.value

            member_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': member_id}
            )

            member_active_character_id = member_query['activeCharacters'][str(guild_id)]
            member_active_character = member_query['characters'][member_active_character_id]

            log_channel = None
            log_channel_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='playerTransactionLogChannel',
                query={'_id': guild_id}
            )
            if log_channel_query:
                log_channel_id = strip_id(log_channel_query['playerTransactionLogChannel'])
                log_channel = interaction.guild.get_channel(log_channel_id)

            target_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': target_id}
            )
            if not target_query:
                raise UserFeedbackError('The player you are attempting to trade with has no characters!')
            elif str(guild_id) not in target_query['activeCharacters']:
                raise UserFeedbackError(
                    'The player you are attempting to trade with does not have an active character on this server!'
                )
            target_active_character_id = target_query['activeCharacters'][str(guild_id)]
            target_active_character = target_query['characters'][target_active_character_id]

            currency_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='currency',
                query={'_id': guild_id}
            )

            is_currency, _ = find_currency_or_denomination(currency_query, item_name)

            trade_embed = discord.Embed(
                title=f'Trade Report',
                description=(
                    f'Sender: {interaction.user.mention} as `{member_active_character['name']}`\n'
                    f'Recipient: {self.target.mention} as `{target_active_character['name']}`\n'
                ),
                type='rich'
            )

            if is_currency:
                sender_currency, receiver_currency = await trade_currency(interaction, item_name, quantity,
                                                                          member_id, target_id, guild_id)
                sender_balance_str = '\n'.join(format_currency_display(sender_currency, currency_query)) or "None"
                receiver_currency_str = '\n'.join(format_currency_display(receiver_currency, currency_query)) or "None"
                trade_embed.add_field(name='Currency', value=titlecase(item_name))
                trade_embed.add_field(name='Amount', value=quantity)
                trade_embed.add_field(name=f'{member_active_character['name']}\'s Balance', value=sender_balance_str,
                                      inline=False)
                trade_embed.add_field(name=f'{target_active_character['name']}\'s Balance', value=receiver_currency_str,
                                      inline=False)
            else:
                quantity = int(quantity)
                await trade_item(interaction.client, item_name, quantity, member_id, target_id, guild_id)
                trade_embed.add_field(name='Item', value=titlecase(item_name))
                trade_embed.add_field(name='Quantity', value=quantity)

            trade_embed.set_footer(text=f'Transaction ID: {transaction_id}')

            await interaction.response.send_message(embed=trade_embed, ephemeral=True)
            try:
                await self.target.send(embed=trade_embed)
            except discord.errors.Forbidden as e:
                logger.warning(f'Could not send trade DM to {self.target}. They might have DMs disabled. {e}')
            if log_channel:
                await log_channel.send(embed=trade_embed)

        except Exception as e:
            await log_exception(e, interaction)


class CharacterRegisterModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Register New Character',
            timeout=180
        )
        self.name_text_input = discord.ui.TextInput(
            label='Name',
            custom_id='character_name_text_input',
            placeholder='Enter your character\'s name.',
            max_length=40
        )
        self.note_text_input = discord.ui.TextInput(
            label='Note',
            custom_id='character_note_text_input',
            placeholder='Enter a note to identify your character',
            max_length=80
        )
        self.add_item(self.name_text_input)
        self.add_item(self.note_text_input)
        self.calling_view = calling_view

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            character_id = str(shortuuid.uuid())
            member_id = interaction.user.id
            guild_id = interaction.guild_id
            date = datetime.now(timezone.utc)
            character_name = self.name_text_input.value
            character_note = self.note_text_input.value

            await update_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': member_id},
                update_data={'$set': {f'activeCharacters.{guild_id}': character_id,
                                      f'characters.{character_id}': {
                                          'name': character_name,
                                          'note': character_note,
                                          'registeredDate': date,
                                          'attributes': {
                                              'level': None,
                                              'experience': None,
                                              'inventory': {},
                                              'currency': {}
                                          }}}}
            )

            inventory_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='inventoryConfig',
                query={'_id': guild_id}
            )
            inventory_type = inventory_config.get('inventoryType', 'disabled') if inventory_config else 'disabled'

            if inventory_type == 'disabled':
                await setup_view(self.calling_view, interaction)
                await interaction.response.edit_message(view=self.calling_view)
            else:
                from ReQuest.ui.player.views import NewCharacterWizardView

                view = NewCharacterWizardView(character_id, character_name, inventory_type)
                await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class OpenInventoryInputModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Starting Inventory Input',
            timeout=600
        )
        self.calling_view = calling_view
        self.items_input = discord.ui.TextInput(
            label='Inventory',
            placeholder='One per line in <name>: <quantity> format, e.g.:\nSword: 1\ngold: 30',
            style=discord.TextStyle.paragraph,
            required=False
        )
        self.add_item(self.items_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            items = {}
            errors = []

            if self.items_input.value:
                for line in self.items_input.value.split('\n'):
                    line = line.strip()
                    if not line:
                        continue

                    if ':' not in line:
                        errors.append(f'Invalid format: "{line}". Use <name>: <quantity>.')
                        continue

                    name, quantity = line.rsplit(':', 1)
                    name = name.strip()
                    quantity = quantity.strip()

                    if not name:
                        errors.append(f'Item name cannot be empty in line: "{line}".')
                        continue

                    if not quantity.isdigit() or int(quantity) < 1:
                        errors.append(f'Invalid quantity for "{name}": "{quantity}". Must be a positive integer.')
                        continue

                    items[name] = int(quantity)

            if errors:
                error_message = 'Errors in inventory input:\n- ' + '\n- '.join(errors)
                await interaction.response.send_message(error_message, ephemeral=True)
                return

            if not items:
                await interaction.response.send_message('No valid items provided. Initializing with empty inventory.',
                                                        ephemeral=True)
                return

            await self.calling_view.submit_open_inventory(interaction, items)

        except Exception as e:
            await log_exception(e, interaction)


class SpendCurrencyModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title=f'Spend Currency',
            timeout=180
        )
        self.calling_view = calling_view
        self.currency_name_text_input = discord.ui.TextInput(
            label='Currency Name',
            placeholder=f'Enter the name of the currency you are spending',
            custom_id='currency_name_text_input',
            required=True
        )
        self.currency_amount_text_input = discord.ui.TextInput(
            label='Amount',
            placeholder='Enter the amount to spend',
            custom_id='currency_amount_text_input',
            required=True
        )
        self.add_item(self.currency_name_text_input)
        self.add_item(self.currency_amount_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            currency_name = self.currency_name_text_input.value.strip()
            try:
                amount = float(self.currency_amount_text_input.value.strip())
            except ValueError:
                raise UserFeedbackError('Amount must be a number.')

            if amount <= 0:
                raise UserFeedbackError('You must spend a positive amount.')

            bot = interaction.client
            member_id = interaction.user.id
            guild_id = interaction.guild_id

            character_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': member_id}
            )
            if not character_query or str(guild_id) not in character_query['activeCharacters']:
                raise UserFeedbackError("You do not have an active character on this server.")

            active_character_id = character_query['activeCharacters'][str(guild_id)]
            character_data = character_query['characters'][active_character_id]
            current_wallet = character_data['attributes'].get('currency', {})

            currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='currency',
                query={'_id': guild_id}
            )
            if not currency_config:
                raise UserFeedbackError("A currency configuration was not found for this server.")

            can_afford, message = check_sufficient_funds(current_wallet, currency_config, currency_name, amount)
            if not can_afford:
                raise UserFeedbackError(message)

            await update_character_inventory(interaction, member_id, active_character_id, currency_name, -amount)

            updated_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': member_id}
            )

            new_wallet = updated_query['characters'][active_character_id]['attributes'].get('currency', {})

            formatted_amount = format_price_string(amount, currency_name, currency_config)
            balance_lines = format_currency_display(new_wallet, currency_config)
            balance_str = '\n'.join(balance_lines) or "None"

            character_name = character_data['name']
            trade_embed = discord.Embed(
                title=f'Player Transaction Report',
                description=(
                    f'Player: {interaction.user.mention} as `{character_name}`\n'
                    f'Transaction: **{character_name}** spent **{formatted_amount}**.'
                ),
                color=discord.Color.gold(),
                type='rich'
            )
            trade_embed.set_author(
                name=interaction.user.display_name,
                icon_url=interaction.user.display_avatar.url if interaction.user.display_avatar else None
            )
            trade_embed.add_field(name=f'{character_name}\'s Balance', value=balance_str, inline=False)
            trade_embed.set_footer(text=f'Transaction ID: {shortuuid.uuid()[:12]}')

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
            receipt = await interaction.followup.send(embed=trade_embed, wait=True)

            log_channel_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='playerTransactionLogChannel',
                query={'_id': guild_id}
            )
            if log_channel_query:
                log_channel_id = strip_id(log_channel_query['playerTransactionLogChannel'])
                log_channel = interaction.guild.get_channel(log_channel_id)
                if log_channel:
                    channel_mention = interaction.channel.mention
                    trade_embed.add_field(name='Channel', value=channel_mention)
                    trade_embed.add_field(name='Receipt', value=receipt.jump_url)
                    await log_channel.send(embed=trade_embed)
        except Exception as e:
            await log_exception(e, interaction)


class CreatePlayerPostModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Create Player Board Post',
            timeout=600
        )
        self.title_text_input = discord.ui.TextInput(
            label='Title',
            custom_id='title_text_input',
            placeholder='Enter a title for your post',
            max_length=80
        )
        self.content_text_input = discord.ui.TextInput(
            label='Post Content',
            style=discord.TextStyle.paragraph,
            custom_id='content_text_input',
            placeholder='Enter the body of your post'
        )
        self.calling_view = calling_view
        self.add_item(self.title_text_input)
        self.add_item(self.content_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            title = self.title_text_input.value
            content = self.content_text_input.value
            await self.calling_view.create_post(title, content, interaction)
        except Exception as e:
            await log_exception(e, interaction)


class EditPlayerPostModal(Modal):
    def __init__(self, calling_view, post):
        super().__init__(
            title='Edit Player Board Post',
            timeout=600
        )
        self.calling_view = calling_view
        self.post = post
        self.title_text_input = discord.ui.TextInput(
            label='Title',
            custom_id='title_text_input',
            placeholder='Enter a title for your post',
            default=post['title'],
            max_length=80,
            required=False
        )
        self.content_text_input = discord.ui.TextInput(
            label='Post Content',
            style=discord.TextStyle.paragraph,
            custom_id='content_text_input',
            placeholder='Enter the body of your post',
            default=post['content'],
            required=False
        )
        self.add_item(self.title_text_input)
        self.add_item(self.content_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            title = self.title_text_input.value
            content = self.content_text_input.value
            await self.calling_view.edit_post(self.post, title, content, interaction)
        except Exception as e:
            await log_exception(e, interaction)


class WizardEditCartItemModal(Modal):
    def __init__(self, cart_view, item_key, current_quantity):
        super().__init__(
            title='Edit Cart Quantity',
            timeout=600
        )
        self.cart_view = cart_view
        self.item_key = item_key

        self.quantity_text_input = discord.ui.TextInput(
            label='Quantity',
            default=str(current_quantity),
            min_length=1,
            max_length=5,
            placeholder='Enter new quantity (0 to remove)',
            custom_id='wiz_cart_qty_input'
        )
        self.add_item(self.quantity_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            if not self.quantity_text_input.value.isdigit():
                await interaction.response.send_message('Please enter a valid positive number.',
                                                        ephemeral=True, delete_after=10)
                return

            new_quantity = int(self.quantity_text_input.value)
            cart = self.cart_view.shop_view.cart

            if new_quantity <= 0:
                if self.item_key in cart:
                    del cart[self.item_key]
            else:
                if self.item_key in cart:
                    cart[self.item_key]['quantity'] = new_quantity

            self.cart_view.build_view()
            await interaction.response.edit_message(view=self.cart_view)
        except Exception as e:
            await log_exception(e, interaction)


class CreateContainerModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Create New Container',
            timeout=180
        )
        self.calling_view = calling_view
        self.name_input = discord.ui.TextInput(
            label='Container Name',
            placeholder='Enter a name for your container (e.g., Backpack)',
            custom_id='container_name_input',
            max_length=50,
            required=True
        )
        self.add_item(self.name_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            name = self.name_input.value.strip()
            await create_container(
                interaction.client,
                interaction.user.id,
                self.calling_view.character_id,
                name
            )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RenameContainerModal(Modal):
    def __init__(self, calling_view, container_id: str, current_name: str):
        super().__init__(
            title='Rename Container',
            timeout=180
        )
        self.calling_view = calling_view
        self.container_id = container_id
        self.name_input = discord.ui.TextInput(
            label='New Container Name',
            placeholder='Enter the new name',
            custom_id='container_rename_input',
            default=current_name,
            max_length=50,
            required=True
        )
        self.add_item(self.name_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            new_name = self.name_input.value.strip()
            await rename_container(
                interaction.client,
                interaction.user.id,
                self.calling_view.character_id,
                self.container_id,
                new_name
            )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ConsumeFromContainerModal(Modal):
    def __init__(self, calling_view, item_name: str, max_quantity: int):
        super().__init__(
            title='Consume/Destroy Item',
            timeout=180
        )
        self.calling_view = calling_view
        self.item_name = item_name
        self.max_quantity = max_quantity

        self.quantity_input = discord.ui.TextInput(
            label=f'Quantity (max: {max_quantity})',
            placeholder='Enter amount to consume/destroy',
            custom_id='consume_quantity_input',
            default='1',
            required=True
        )
        self.add_item(self.quantity_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            if not self.quantity_input.value.isdigit():
                raise UserFeedbackError('Quantity must be a positive integer.')

            quantity = int(self.quantity_input.value)
            if quantity < 1:
                raise UserFeedbackError('Quantity must be at least 1.')
            if quantity > self.max_quantity:
                raise UserFeedbackError(f'You only have {self.max_quantity} of this item.')

            container_name = get_container_name(
                self.calling_view.character_data,
                self.calling_view.container_id
            )

            await consume_item_from_container(
                interaction.client,
                interaction.user.id,
                self.calling_view.character_id,
                self.item_name,
                quantity,
                self.calling_view.container_id
            )

            # Clear selection and refresh
            self.calling_view.selected_item = None
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)

            # Send receipt
            receipt_embed = discord.Embed(
                title='Item Consumption Report',
                description=f'Player: {interaction.user.mention } as `{self.calling_view.character_data["name"]}`\n'
                            f'Removed: **{quantity}x {titlecase(self.item_name)}** from **{container_name}**',
                color=discord.Color.gold(),
                type='rich'
            )
            receipt_embed.set_author(
                name=interaction.user.display_name,
                icon_url=interaction.user.display_avatar.url if interaction.user.display_avatar else None
            )
            receipt_embed.set_footer(text=f'Transaction ID: {shortuuid.uuid()[:12]}')

            receipt_message = await interaction.followup.send(embed=receipt_embed, wait=True)

            # Log to transaction channel if set
            bot = interaction.client
            guild_id = interaction.guild_id

            log_channel_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='playerTransactionLogChannel',
                query={'_id': guild_id}
            )
            if log_channel_query:
                log_channel_id = strip_id(log_channel_query['playerTransactionLogChannel'])
                log_channel = interaction.guild.get_channel(log_channel_id)
                if log_channel:
                    receipt_embed.add_field(name='Channel', value=interaction.channel.mention)
                    receipt_embed.add_field(name='Receipt', value=receipt_message.jump_url)
                    await log_channel.send(embed=receipt_embed)
        except Exception as e:
            await log_exception(e, interaction)


class MoveItemQuantityModal(Modal):
    def __init__(self, calling_view, item_name: str, max_quantity: int):
        super().__init__(
            title='Move Item',
            timeout=180
        )
        self.calling_view = calling_view
        self.item_name = item_name
        self.max_quantity = max_quantity

        self.quantity_input = discord.ui.TextInput(
            label=f'Quantity to move (max: {max_quantity})',
            placeholder='Enter amount to move',
            custom_id='move_quantity_input',
            default=str(max_quantity),
            required=True
        )
        self.add_item(self.quantity_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            if not self.quantity_input.value.isdigit():
                raise UserFeedbackError('Quantity must be a positive integer.')

            quantity = int(self.quantity_input.value)
            if quantity < 1:
                raise UserFeedbackError('Quantity must be at least 1.')
            if quantity > self.max_quantity:
                raise UserFeedbackError(f'You only have {self.max_quantity} of this item.')

            await move_item_between_containers(
                interaction.client,
                interaction.user.id,
                self.calling_view.source_view.character_id,
                self.item_name,
                quantity,
                self.calling_view.source_container_id,
                self.calling_view.selected_destination
            )

            # Return to the source container view
            from ReQuest.ui.player.views import ContainerItemsView
            view = ContainerItemsView(
                self.calling_view.source_view.character_id,
                self.calling_view.source_view.character_data,
                self.calling_view.source_container_id
            )
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)

        except Exception as e:
            await log_exception(e, interaction)
