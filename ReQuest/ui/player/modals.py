import logging
from datetime import datetime, timezone
from titlecase import titlecase

import discord
import discord.ui
import shortuuid
from ReQuest.ui.common.modals import LocaleModal

from ReQuest.ui.common.enums import InventoryType
from ReQuest.utilities.constants import CharacterFields, ConfigFields, CommonFields, DatabaseCollections
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
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
    move_item_between_containers,
    escape_markdown
)

logger = logging.getLogger(__name__)


class TradeModal(LocaleModal):
    def __init__(self, target: discord.Member, locale: str = DEFAULT_LOCALE):
        super().__init__(
            title=t(locale, 'player-modal-title-trade', targetName=target.name),
            timeout=180
        )
        self.target = target
        self.locale = locale
        self.item_name_text_input = discord.ui.TextInput(
            label=t(locale, 'player-modal-label-trade-name'),
            placeholder=t(locale, 'player-modal-placeholder-trade-name'),
            custom_id='item_name_text_input'
        )
        self.item_quantity_text_input = discord.ui.TextInput(
            label=t(locale, 'player-modal-label-trade-quantity'),
            placeholder=t(locale, 'player-modal-placeholder-trade-quantity'),
            custom_id='item_quantity_text_input'
        )
        self.add_item(self.item_name_text_input)
        self.add_item(self.item_quantity_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            locale = self.locale
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
                collection_name=DatabaseCollections.CHARACTERS,
                query={CommonFields.ID: member_id}
            )

            member_active_character_id = member_query[CharacterFields.ACTIVE_CHARACTERS][str(guild_id)]
            member_active_character = member_query[CharacterFields.CHARACTERS][member_active_character_id]

            log_channel = None
            log_channel_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.PLAYER_TRANSACTION_LOG_CHANNEL,
                query={CommonFields.ID: guild_id}
            )
            if log_channel_query:
                log_channel_id = strip_id(log_channel_query[ConfigFields.PLAYER_TRANSACTION_LOG_CHANNEL])
                log_channel = interaction.guild.get_channel(log_channel_id)

            target_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name=DatabaseCollections.CHARACTERS,
                query={CommonFields.ID: target_id}
            )
            if not target_query:
                raise UserFeedbackError(
                    t(locale, 'player-error-trade-no-characters'),
                    message_id='player-error-trade-no-characters'
                )
            elif str(guild_id) not in target_query[CharacterFields.ACTIVE_CHARACTERS]:
                raise UserFeedbackError(
                    t(locale, 'player-error-trade-no-active'),
                    message_id='player-error-trade-no-active'
                )
            target_active_character_id = target_query[CharacterFields.ACTIVE_CHARACTERS][str(guild_id)]
            target_active_character = target_query[CharacterFields.CHARACTERS][target_active_character_id]

            currency_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: guild_id}
            )

            is_currency, _ = find_currency_or_denomination(currency_query, item_name)

            trade_embed = discord.Embed(
                title=t(locale, 'player-embed-title-trade'),
                description=(
                    t(locale, 'player-embed-desc-trade-sender',
                      senderMention=interaction.user.mention,
                      senderCharacter=member_active_character[CharacterFields.NAME]) + '\n' +
                    t(locale, 'player-embed-desc-trade-recipient',
                      recipientMention=self.target.mention,
                      recipientCharacter=target_active_character[CharacterFields.NAME]) + '\n'
                ),
                type='rich'
            )

            if is_currency:
                sender_currency, receiver_currency = await trade_currency(interaction, item_name, quantity,
                                                                          member_id, target_id, guild_id)
                sender_balance_str = '\n'.join(format_currency_display(sender_currency, currency_query)) or "None"
                receiver_currency_str = '\n'.join(format_currency_display(receiver_currency, currency_query)) or "None"
                trade_embed.add_field(
                    name=t(locale, 'player-embed-field-currency'),
                    value=escape_markdown(titlecase(item_name))
                )
                trade_embed.add_field(
                    name=t(locale, 'player-embed-field-amount'),
                    value=quantity
                )
                trade_embed.add_field(
                    name=t(locale, 'player-embed-field-balance',
                           characterName=member_active_character[CharacterFields.NAME]),
                    value=sender_balance_str,
                    inline=False
                )
                trade_embed.add_field(
                    name=t(locale, 'player-embed-field-balance',
                           characterName=target_active_character[CharacterFields.NAME]),
                    value=receiver_currency_str,
                    inline=False
                )
            else:
                quantity = int(quantity)
                await trade_item(interaction.client, item_name, quantity, member_id, target_id, guild_id)
                trade_embed.add_field(
                    name=t(locale, 'player-embed-field-item'),
                    value=escape_markdown(titlecase(item_name))
                )
                trade_embed.add_field(
                    name=t(locale, 'player-embed-field-quantity'),
                    value=quantity
                )

            trade_embed.set_footer(text=t(locale, 'player-embed-footer-transaction-id', transactionId=transaction_id))

            await interaction.response.send_message(embed=trade_embed, ephemeral=True)
            try:
                await self.target.send(embed=trade_embed)
            except discord.errors.Forbidden as e:
                logger.warning(f'Could not send trade DM to {self.target}. They might have DMs disabled. {e}')
            if log_channel:
                await log_channel.send(embed=trade_embed)

        except Exception as e:
            await log_exception(e, interaction)


class CharacterRegisterModal(LocaleModal):
    def __init__(self, calling_view):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'player-modal-title-register'),
            timeout=180
        )
        self.name_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'player-modal-label-char-name'),
            custom_id='character_name_text_input',
            placeholder=t(DEFAULT_LOCALE, 'player-modal-placeholder-char-name'),
            max_length=40
        )
        self.note_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'player-modal-label-char-note'),
            custom_id='character_note_text_input',
            placeholder=t(DEFAULT_LOCALE, 'player-modal-placeholder-char-note'),
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
                collection_name=DatabaseCollections.CHARACTERS,
                query={CommonFields.ID: member_id},
                update_data={'$set': {f'{CharacterFields.ACTIVE_CHARACTERS}.{guild_id}': character_id,
                                      f'{CharacterFields.CHARACTERS}.{character_id}': {
                                          CharacterFields.NAME: character_name,
                                          'note': character_note,
                                          'registeredDate': date,
                                          CharacterFields.ATTRIBUTES: {
                                              'level': None,
                                              CharacterFields.EXPERIENCE: None,
                                              CharacterFields.INVENTORY: {},
                                              CharacterFields.CURRENCY: {}
                                          }}}}
            )

            inventory_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.INVENTORY_CONFIG,
                query={CommonFields.ID: guild_id}
            )
            inventory_type = inventory_config.get(ConfigFields.INVENTORY_TYPE, InventoryType.DISABLED.value) if inventory_config else InventoryType.DISABLED.value

            if inventory_type == InventoryType.DISABLED.value:
                await setup_view(self.calling_view, interaction)
                await interaction.response.edit_message(view=self.calling_view)
            else:
                from ReQuest.ui.player.views import NewCharacterWizardView

                view = NewCharacterWizardView(character_id, character_name, inventory_type)
                await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class OpenInventoryInputModal(LocaleModal):
    def __init__(self, calling_view):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'player-modal-title-starting-inventory'),
            timeout=600
        )
        self.calling_view = calling_view
        self.items_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'player-modal-label-inventory'),
            placeholder=t(DEFAULT_LOCALE, 'player-modal-placeholder-inventory-input'),
            style=discord.TextStyle.paragraph,
            required=False
        )
        self.add_item(self.items_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            locale = getattr(self.calling_view, 'locale', DEFAULT_LOCALE)
            items = {}
            errors = []

            if self.items_input.value:
                for line in self.items_input.value.split('\n'):
                    line = line.strip()
                    if not line:
                        continue

                    if ':' not in line:
                        errors.append(t(locale, 'player-error-invalid-format', line=line))
                        continue

                    name, quantity = line.rsplit(':', 1)
                    name = name.strip()
                    quantity = quantity.strip()

                    if not name:
                        errors.append(t(locale, 'player-error-empty-name', line=line))
                        continue

                    if not quantity.isdigit() or int(quantity) < 1:
                        errors.append(t(locale, 'player-error-invalid-quantity', name=name, quantity=quantity))
                        continue

                    items[name] = int(quantity)

            if errors:
                error_message = t(locale, 'player-error-input-errors-header') + '\n- ' + '\n- '.join(errors)
                await interaction.response.send_message(error_message, ephemeral=True)
                return

            if not items:
                await interaction.response.send_message(
                    t(locale, 'player-msg-no-valid-items'),
                    ephemeral=True
                )
                return

            await self.calling_view.submit_open_inventory(interaction, items)

        except Exception as e:
            await log_exception(e, interaction)


class SpendCurrencyModal(LocaleModal):
    def __init__(self, calling_view):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'player-modal-title-spend-currency'),
            timeout=180
        )
        self.calling_view = calling_view
        self.currency_name_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'player-modal-label-currency-name'),
            placeholder=t(DEFAULT_LOCALE, 'player-modal-placeholder-currency-name'),
            custom_id='currency_name_text_input',
            required=True
        )
        self.currency_amount_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'player-modal-label-currency-amount'),
            placeholder=t(DEFAULT_LOCALE, 'player-modal-placeholder-currency-amount'),
            custom_id='currency_amount_text_input',
            required=True
        )
        self.add_item(self.currency_name_text_input)
        self.add_item(self.currency_amount_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            locale = getattr(self.calling_view, 'locale', DEFAULT_LOCALE)
            currency_name = self.currency_name_text_input.value.strip()
            try:
                amount = float(self.currency_amount_text_input.value.strip())
            except ValueError:
                raise UserFeedbackError(
                    t(locale, 'player-error-amount-not-number'),
                    message_id='player-error-amount-not-number'
                )

            if amount <= 0:
                raise UserFeedbackError(
                    t(locale, 'player-error-amount-positive'),
                    message_id='player-error-amount-positive'
                )

            bot = interaction.client
            member_id = interaction.user.id
            guild_id = interaction.guild_id

            character_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name=DatabaseCollections.CHARACTERS,
                query={CommonFields.ID: member_id}
            )
            if not character_query or str(guild_id) not in character_query[CharacterFields.ACTIVE_CHARACTERS]:
                raise UserFeedbackError(
                    t(locale, 'player-error-no-active-character-server'),
                    message_id='player-error-no-active-character-server'
                )

            active_character_id = character_query[CharacterFields.ACTIVE_CHARACTERS][str(guild_id)]
            character_data = character_query[CharacterFields.CHARACTERS][active_character_id]
            current_wallet = character_data[CharacterFields.ATTRIBUTES].get(CharacterFields.CURRENCY, {})

            currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: guild_id}
            )
            if not currency_config:
                raise UserFeedbackError(
                    t(locale, 'player-error-no-currency-config'),
                    message_id='player-error-no-currency-config'
                )

            can_afford, message = check_sufficient_funds(current_wallet, currency_config, currency_name, amount)
            if not can_afford:
                raise UserFeedbackError(message)

            await update_character_inventory(interaction, member_id, active_character_id, currency_name, -amount)

            updated_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name=DatabaseCollections.CHARACTERS,
                query={CommonFields.ID: member_id}
            )

            new_wallet = updated_query[CharacterFields.CHARACTERS][active_character_id][CharacterFields.ATTRIBUTES].get(CharacterFields.CURRENCY, {})

            formatted_amount = format_price_string(amount, currency_name, currency_config)
            balance_lines = format_currency_display(new_wallet, currency_config)
            balance_str = '\n'.join(balance_lines) or "None"

            character_name = character_data[CharacterFields.NAME]
            trade_embed = discord.Embed(
                title=t(locale, 'player-embed-title-spend'),
                description=(
                    t(locale, 'player-embed-desc-spend-player',
                      playerMention=interaction.user.mention,
                      characterName=character_name) + '\n' +
                    t(locale, 'player-embed-desc-spend-transaction',
                      characterName=character_name,
                      formattedAmount=formatted_amount)
                ),
                color=discord.Color.gold(),
                type='rich'
            )
            trade_embed.set_author(
                name=interaction.user.display_name,
                icon_url=interaction.user.display_avatar.url if interaction.user.display_avatar else None
            )
            trade_embed.add_field(
                name=t(locale, 'player-embed-field-balance', characterName=character_name),
                value=balance_str, inline=False
            )
            trade_embed.set_footer(text=t(locale, 'player-embed-footer-transaction-id', transactionId=shortuuid.uuid()[:12]))

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
            receipt = await interaction.followup.send(embed=trade_embed, wait=True)

            log_channel_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.PLAYER_TRANSACTION_LOG_CHANNEL,
                query={CommonFields.ID: guild_id}
            )
            if log_channel_query:
                log_channel_id = strip_id(log_channel_query[ConfigFields.PLAYER_TRANSACTION_LOG_CHANNEL])
                log_channel = interaction.guild.get_channel(log_channel_id)
                if log_channel:
                    channel_mention = interaction.channel.mention
                    trade_embed.add_field(name=t(locale, 'player-embed-field-channel'), value=channel_mention)
                    trade_embed.add_field(name=t(locale, 'player-embed-field-receipt'), value=receipt.jump_url)
                    await log_channel.send(embed=trade_embed)
        except Exception as e:
            await log_exception(e, interaction)


class CreatePlayerPostModal(LocaleModal):
    def __init__(self, calling_view):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'player-modal-title-create-post'),
            timeout=600
        )
        self.title_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'player-modal-label-post-title'),
            custom_id='title_text_input',
            placeholder=t(DEFAULT_LOCALE, 'player-modal-placeholder-post-title'),
            max_length=80
        )
        self.content_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'player-modal-label-post-content'),
            style=discord.TextStyle.paragraph,
            custom_id='content_text_input',
            placeholder=t(DEFAULT_LOCALE, 'player-modal-placeholder-post-content')
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


class EditPlayerPostModal(LocaleModal):
    def __init__(self, calling_view, post):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'player-modal-title-edit-post'),
            timeout=600
        )
        self.calling_view = calling_view
        self.post = post
        self.title_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'player-modal-label-post-title'),
            custom_id='title_text_input',
            placeholder=t(DEFAULT_LOCALE, 'player-modal-placeholder-post-title'),
            default=post['title'],
            max_length=80,
            required=False
        )
        self.content_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'player-modal-label-post-content'),
            style=discord.TextStyle.paragraph,
            custom_id='content_text_input',
            placeholder=t(DEFAULT_LOCALE, 'player-modal-placeholder-post-content'),
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


class WizardEditCartItemModal(LocaleModal):
    def __init__(self, cart_view, item_key, current_quantity):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'player-modal-title-edit-cart-qty'),
            timeout=600
        )
        self.cart_view = cart_view
        self.item_key = item_key

        self.quantity_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'player-modal-label-cart-qty'),
            default=str(current_quantity),
            min_length=1,
            max_length=5,
            placeholder=t(DEFAULT_LOCALE, 'player-modal-placeholder-cart-qty'),
            custom_id='wiz_cart_qty_input'
        )
        self.add_item(self.quantity_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            locale = getattr(self.cart_view, 'locale', DEFAULT_LOCALE)
            if not self.quantity_text_input.value.isdigit():
                await interaction.response.send_message(
                    t(locale, 'player-error-enter-valid-number'),
                    ephemeral=True, delete_after=10
                )
                return

            new_quantity = int(self.quantity_text_input.value)
            cart = self.cart_view.shop_view.cart

            if new_quantity <= 0:
                if self.item_key in cart:
                    del cart[self.item_key]
            else:
                if self.item_key in cart:
                    cart[self.item_key][CommonFields.QUANTITY] = new_quantity

            self.cart_view.build_view()
            await interaction.response.edit_message(view=self.cart_view)
        except Exception as e:
            await log_exception(e, interaction)


class CreateContainerModal(LocaleModal):
    def __init__(self, calling_view):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'player-modal-title-create-container'),
            timeout=180
        )
        self.calling_view = calling_view
        self.name_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'player-modal-label-container-name'),
            placeholder=t(DEFAULT_LOCALE, 'player-modal-placeholder-container-name'),
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


class RenameContainerModal(LocaleModal):
    def __init__(self, calling_view, container_id: str, current_name: str):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'player-modal-title-rename-container'),
            timeout=180
        )
        self.calling_view = calling_view
        self.container_id = container_id
        self.name_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'player-modal-label-new-container-name'),
            placeholder=t(DEFAULT_LOCALE, 'player-modal-placeholder-new-container-name'),
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


class ConsumeFromContainerModal(LocaleModal):
    def __init__(self, calling_view, item_name: str, max_quantity: int):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'player-modal-title-consume'),
            timeout=180
        )
        self.calling_view = calling_view
        self.item_name = item_name
        self.max_quantity = max_quantity

        self.quantity_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'player-modal-label-consume-qty', maxQuantity=max_quantity),
            placeholder=t(DEFAULT_LOCALE, 'player-modal-placeholder-consume-qty'),
            custom_id='consume_quantity_input',
            default='1',
            required=True
        )
        self.add_item(self.quantity_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            locale = getattr(self.calling_view, 'locale', DEFAULT_LOCALE)
            if not self.quantity_input.value.isdigit():
                raise UserFeedbackError(
                    t(locale, 'player-error-qty-positive-integer'),
                    message_id='player-error-qty-positive-integer'
                )

            quantity = int(self.quantity_input.value)
            if quantity < 1:
                raise UserFeedbackError(
                    t(locale, 'player-error-qty-at-least-one'),
                    message_id='player-error-qty-at-least-one'
                )
            if quantity > self.max_quantity:
                raise UserFeedbackError(
                    t(locale, 'player-error-qty-only-have', maxQuantity=self.max_quantity),
                    message_id='player-error-qty-only-have'
                )

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
                title=t(locale, 'player-embed-title-consume'),
                description=(
                    t(locale, 'player-embed-desc-consume',
                      playerMention=interaction.user.mention,
                      characterName=self.calling_view.character_data[CharacterFields.NAME]) + '\n' +
                    t(locale, 'player-embed-desc-consume-removed',
                      quantity=quantity,
                      itemName=escape_markdown(titlecase(self.item_name)),
                      containerName=container_name)
                ),
                color=discord.Color.gold(),
                type='rich'
            )
            receipt_embed.set_author(
                name=interaction.user.display_name,
                icon_url=interaction.user.display_avatar.url if interaction.user.display_avatar else None
            )
            receipt_embed.set_footer(text=t(locale, 'player-embed-footer-transaction-id', transactionId=shortuuid.uuid()[:12]))

            receipt_message = await interaction.followup.send(embed=receipt_embed, wait=True)

            # Log to transaction channel if set
            bot = interaction.client
            guild_id = interaction.guild_id

            log_channel_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.PLAYER_TRANSACTION_LOG_CHANNEL,
                query={CommonFields.ID: guild_id}
            )
            if log_channel_query:
                log_channel_id = strip_id(log_channel_query[ConfigFields.PLAYER_TRANSACTION_LOG_CHANNEL])
                log_channel = interaction.guild.get_channel(log_channel_id)
                if log_channel:
                    receipt_embed.add_field(name=t(locale, 'player-embed-field-channel'), value=interaction.channel.mention)
                    receipt_embed.add_field(name=t(locale, 'player-embed-field-receipt'), value=receipt_message.jump_url)
                    await log_channel.send(embed=receipt_embed)
        except Exception as e:
            await log_exception(e, interaction)


class MoveItemQuantityModal(LocaleModal):
    def __init__(self, calling_view, item_name: str, max_quantity: int):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'player-modal-title-move-item'),
            timeout=180
        )
        self.calling_view = calling_view
        self.item_name = item_name
        self.max_quantity = max_quantity

        self.quantity_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'player-modal-label-move-qty', maxQuantity=max_quantity),
            placeholder=t(DEFAULT_LOCALE, 'player-modal-placeholder-move-qty'),
            custom_id='move_quantity_input',
            default=str(max_quantity),
            required=True
        )
        self.add_item(self.quantity_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            locale = getattr(self.calling_view, 'locale', DEFAULT_LOCALE)
            if not self.quantity_input.value.isdigit():
                raise UserFeedbackError(
                    t(locale, 'player-error-qty-positive-integer'),
                    message_id='player-error-qty-positive-integer'
                )

            quantity = int(self.quantity_input.value)
            if quantity < 1:
                raise UserFeedbackError(
                    t(locale, 'player-error-qty-at-least-one'),
                    message_id='player-error-qty-at-least-one'
                )
            if quantity > self.max_quantity:
                raise UserFeedbackError(
                    t(locale, 'player-error-qty-only-have', maxQuantity=self.max_quantity),
                    message_id='player-error-qty-only-have'
                )

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
