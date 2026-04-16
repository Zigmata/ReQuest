import logging
import math
from datetime import datetime, timezone
from titlecase import titlecase

import discord
import discord.ui
import shortuuid
from ReQuest.ui.common.modals import LocaleModal

from ReQuest.ui.common.enums import InventoryType
from ReQuest.utilities.constants import (
    CharacterFields, ConfigFields, CommonFields, DatabaseCollections, DiscordLimits, DisplayLimits
)
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE, resolve_locale
from ReQuest.utilities.character import trade_currency, trade_item, update_character_inventory
from ReQuest.utilities.db_cache import run_in_transaction
from ReQuest.utilities.containers import (
    create_container, rename_container, get_container_name, consume_item_from_container,
    move_item_between_containers
)
from ReQuest.utilities.currency import (
    find_currency_or_denomination, check_sufficient_funds, format_currency_display, format_price_string
)
from ReQuest.utilities.db_cache import get_cached_data, update_cached_data
from ReQuest.utilities.discord_utils import setup_view, strip_id, escape_markdown
from ReQuest.utilities.exceptions import UserFeedbackError, log_exception

logger = logging.getLogger(__name__)


class TradeModal(LocaleModal):
    def __init__(self, target: discord.Member, locale: str = DEFAULT_LOCALE):
        super().__init__(
            title=t(locale, 'player-modal-title-trade', targetName=target.name)[:DiscordLimits.MODAL_TITLE],
            timeout=180
        )
        self.target = target
        self.locale = locale
        self.item_name_text_input = discord.ui.TextInput(
            placeholder=t(locale, 'player-modal-placeholder-trade-name')[
                :DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            custom_id='item_name_text_input'
        )
        self.item_name_label = discord.ui.Label(
            text=t(locale, 'player-modal-label-trade-name')[:DiscordLimits.LABEL_LABEL],
            component=self.item_name_text_input
        )
        self.item_quantity_text_input = discord.ui.TextInput(
            placeholder=t(locale, 'player-modal-placeholder-trade-quantity')[
                :DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            custom_id='item_quantity_text_input'
        )
        self.item_quantity_label = discord.ui.Label(
            text=t(locale, 'player-modal-label-trade-quantity')[:DiscordLimits.LABEL_LABEL],
            component=self.item_quantity_text_input
        )
        self.add_item(self.item_name_label)
        self.add_item(self.item_quantity_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            await interaction.response.defer(ephemeral=True)
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

            is_currency, _ = find_currency_or_denomination(
                currency_query, item_name
            )

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
                sender_currency, receiver_currency = await run_in_transaction(
                    bot, lambda s: trade_currency(
                        interaction, item_name, quantity, member_id, target_id, guild_id, session=s
                    )
                )
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
                await run_in_transaction(
                    bot, lambda s: trade_item(bot, item_name, quantity, member_id, target_id, guild_id, session=s)
                )
                trade_embed.add_field(
                    name=t(locale, 'player-embed-field-item'),
                    value=escape_markdown(titlecase(item_name))
                )
                trade_embed.add_field(
                    name=t(locale, 'player-embed-field-quantity'),
                    value=quantity
                )

            trade_embed.set_footer(text=t(locale, 'player-embed-footer-transaction-id', transactionId=transaction_id))

            await interaction.followup.send(embed=trade_embed, ephemeral=True)
            try:
                target_locale = await resolve_locale(bot=bot, user_id=target_id, guild_id=guild_id)
                if target_locale != locale:
                    dm_embed = discord.Embed(
                        title=t(target_locale, 'player-embed-title-trade'),
                        description=(
                            t(target_locale, 'player-embed-desc-trade-sender',
                              senderMention=interaction.user.mention,
                              senderCharacter=member_active_character[CharacterFields.NAME]) + '\n' +
                            t(target_locale, 'player-embed-desc-trade-recipient',
                              recipientMention=self.target.mention,
                              recipientCharacter=target_active_character[CharacterFields.NAME]) + '\n'
                        ),
                        type='rich'
                    )
                    if is_currency:
                        sender_balance_str_dm = '\n'.join(
                            format_currency_display(sender_currency, currency_query)
                        ) or "None"
                        receiver_currency_str_dm = '\n'.join(
                            format_currency_display(receiver_currency, currency_query)
                        ) or "None"
                        dm_embed.add_field(
                            name=t(target_locale, 'player-embed-field-currency'),
                            value=escape_markdown(titlecase(item_name))
                        )
                        dm_embed.add_field(
                            name=t(target_locale, 'player-embed-field-amount'),
                            value=quantity
                        )
                        dm_embed.add_field(
                            name=t(
                                target_locale, 'player-embed-field-balance',
                                characterName=member_active_character[CharacterFields.NAME]
                            ),
                            value=sender_balance_str_dm, inline=False
                        )
                        dm_embed.add_field(
                            name=t(
                                target_locale, 'player-embed-field-balance',
                                characterName=target_active_character[CharacterFields.NAME]
                            ),
                            value=receiver_currency_str_dm, inline=False
                        )
                    else:
                        dm_embed.add_field(
                            name=t(target_locale, 'player-embed-field-item'),
                            value=escape_markdown(titlecase(item_name))
                        )
                        dm_embed.add_field(
                            name=t(target_locale, 'player-embed-field-quantity'),
                            value=quantity
                        )
                    dm_embed.set_footer(text=t(
                        target_locale, 'player-embed-footer-transaction-id',
                        transactionId=transaction_id
                    ))
                    await self.target.send(embed=dm_embed)
                else:
                    await self.target.send(embed=trade_embed)
            except discord.errors.Forbidden as e:
                logger.warning(
                    f'Could not send trade DM to {self.target}. '
                    f'They might have DMs disabled. {e}'
                )
            if log_channel:
                guild_locale = await resolve_locale(bot=bot, guild_id=guild_id)
                if guild_locale != locale:
                    log_embed = discord.Embed(
                        title=t(guild_locale, 'player-embed-title-trade'),
                        description=(
                            t(guild_locale, 'player-embed-desc-trade-sender',
                              senderMention=interaction.user.mention,
                              senderCharacter=member_active_character[CharacterFields.NAME]) + '\n' +
                            t(guild_locale, 'player-embed-desc-trade-recipient',
                              recipientMention=self.target.mention,
                              recipientCharacter=target_active_character[CharacterFields.NAME]) + '\n'
                        ),
                        type='rich'
                    )
                    if is_currency:
                        log_embed.add_field(
                            name=t(guild_locale, 'player-embed-field-currency'),
                            value=escape_markdown(titlecase(item_name))
                        )
                        log_embed.add_field(
                            name=t(guild_locale, 'player-embed-field-amount'),
                            value=quantity
                        )
                        log_embed.add_field(
                            name=t(guild_locale, 'player-embed-field-balance',
                                   characterName=member_active_character[CharacterFields.NAME]),
                            value=sender_balance_str, inline=False
                        )
                        log_embed.add_field(
                            name=t(guild_locale, 'player-embed-field-balance',
                                   characterName=target_active_character[CharacterFields.NAME]),
                            value=receiver_currency_str, inline=False
                        )
                    else:
                        log_embed.add_field(
                            name=t(guild_locale, 'player-embed-field-item'),
                            value=escape_markdown(titlecase(item_name))
                        )
                        log_embed.add_field(
                            name=t(guild_locale, 'player-embed-field-quantity'),
                            value=quantity
                        )
                    log_embed.set_footer(text=t(
                        guild_locale, 'player-embed-footer-transaction-id',
                        transactionId=transaction_id
                    ))
                    await log_channel.send(embed=log_embed)
                else:
                    await log_channel.send(embed=trade_embed)

        except Exception as e:
            await log_exception(e, interaction)


class CharacterRegisterModal(LocaleModal):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'player-modal-title-register')[:DiscordLimits.MODAL_TITLE],
            timeout=180
        )
        self.name_text_input = discord.ui.TextInput(
            custom_id='character_name_text_input',
            placeholder=t(locale, 'player-modal-placeholder-char-name')[
                :DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            max_length=40
        )
        self.name_label = discord.ui.Label(
            text=t(locale, 'player-modal-label-char-name')[:DiscordLimits.LABEL_LABEL],
            component=self.name_text_input
        )
        self.note_text_input = discord.ui.TextInput(
            custom_id='character_note_text_input',
            placeholder=t(locale, 'player-modal-placeholder-char-note')[
                :DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            max_length=80
        )
        self.note_label = discord.ui.Label(
            text=t(locale, 'player-modal-label-char-note')[:DiscordLimits.LABEL_LABEL],
            component=self.note_text_input
        )
        self.add_item(self.name_label)
        self.add_item(self.note_label)
        self.calling_view = calling_view

    async def on_submit(self, interaction: discord.Interaction):
        try:
            await interaction.response.defer()
            bot = interaction.client
            character_id = str(shortuuid.uuid())
            member_id = interaction.user.id
            guild_id = interaction.guild_id
            date = datetime.now(timezone.utc)
            character_name = self.name_text_input.value
            character_note = self.note_text_input.value

            inventory_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.INVENTORY_CONFIG,
                query={CommonFields.ID: guild_id}
            )
            inventory_type = (
                inventory_config.get(ConfigFields.INVENTORY_TYPE, InventoryType.DISABLED.value)
                if inventory_config else InventoryType.DISABLED.value
            )

            if inventory_type == InventoryType.DISABLED.value:
                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.mdb,
                    collection_name=DatabaseCollections.CHARACTERS,
                    query={CommonFields.ID: member_id},
                    update_data={'$set': {
                        f'{CharacterFields.ACTIVE_CHARACTERS}.{guild_id}': character_id,
                        f'{CharacterFields.CHARACTERS}.{character_id}': {
                            CharacterFields.NAME: character_name,
                            'note': character_note,
                            'registeredDate': date,
                            CharacterFields.ATTRIBUTES: {
                                'level': None,
                                CharacterFields.EXPERIENCE: None,
                                CharacterFields.INVENTORY: {},
                                CharacterFields.CURRENCY: {}
                            }
                        }
                    }}
                )
                await setup_view(self.calling_view, interaction)
                await interaction.edit_original_response(view=self.calling_view)
            else:
                pending_character = {
                    'character_id': character_id,
                    'name': character_name,
                    'note': character_note,
                    'registered_date': date,
                    'inventory_type': inventory_type
                }
                pending_id = f'{member_id}_{guild_id}'
                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name=DatabaseCollections.PENDING_CHARACTERS,
                    query={CommonFields.ID: pending_id},
                    update_data={'$set': {
                        'user_id': member_id,
                        'guild_id': guild_id,
                        'character_id': character_id,
                        'name': character_name,
                        'note': character_note,
                        'registered_date': date,
                        'inventory_type': inventory_type,
                        'wizard_state': {},
                        'created_at': date
                    }}
                )

                from ReQuest.ui.player.views import NewCharacterWizardView
                locale = getattr(self, '_locale', DEFAULT_LOCALE)
                view = NewCharacterWizardView(pending_character, inventory_type, locale=locale)
                await interaction.edit_original_response(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class OpenInventoryInputModal(LocaleModal):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'player-modal-title-starting-inventory')[:DiscordLimits.MODAL_TITLE],
            timeout=600
        )
        self.calling_view = calling_view
        self.items_input = discord.ui.TextInput(
            placeholder=t(locale, 'player-modal-placeholder-inventory-input')[
                :DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            style=discord.TextStyle.paragraph,
            required=False
        )
        self.items_label = discord.ui.Label(
            text=t(locale, 'player-modal-label-inventory')[:DiscordLimits.LABEL_LABEL],
            component=self.items_input
        )
        self.add_item(self.items_label)

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
                from ReQuest.ui.player.views import ValidationErrorView
                error_view = ValidationErrorView(errors, self.calling_view)
                await interaction.response.edit_message(view=error_view)
                return

            await self.calling_view.submit_open_inventory(interaction, items)

        except Exception as e:
            await log_exception(e, interaction)


class DenyReasonModal(LocaleModal):
    def __init__(self, approval_view):
        locale = getattr(approval_view, 'locale', DEFAULT_LOCALE)
        super().__init__(
            title=t(locale, 'player-modal-title-deny-reason')[:DiscordLimits.MODAL_TITLE],
            timeout=180
        )
        self.approval_view = approval_view
        self.reason_input = discord.ui.TextInput(
            style=discord.TextStyle.paragraph,
            custom_id='deny_reason_input',
            placeholder=t(locale, 'player-modal-placeholder-deny-reason')[
                :DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            required=False,
            max_length=500
        )
        self.reason_label = discord.ui.Label(
            text=t(locale, 'player-modal-label-deny-reason')[:DiscordLimits.LABEL_LABEL],
            component=self.reason_input
        )
        self.add_item(self.reason_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            reason = self.reason_input.value.strip() if self.reason_input.value else ''
            await self.approval_view.process_denial(interaction, reason)
        except Exception as e:
            await log_exception(e, interaction)


class SpendCurrencyModal(LocaleModal):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'player-modal-title-spend-currency')[:DiscordLimits.MODAL_TITLE],
            timeout=180
        )
        self.calling_view = calling_view
        self.currency_name_text_input = discord.ui.TextInput(
            placeholder=t(locale, 'player-modal-placeholder-currency-name')[
                :DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            custom_id='currency_name_text_input',
            required=True
        )
        self.currency_name_label = discord.ui.Label(
            text=t(locale, 'player-modal-label-currency-name')[:DiscordLimits.LABEL_LABEL],
            component=self.currency_name_text_input
        )
        self.currency_amount_text_input = discord.ui.TextInput(
            placeholder=t(locale, 'player-modal-placeholder-currency-amount')[
                :DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            custom_id='currency_amount_text_input',
            required=True,
            max_length=13
        )
        self.currency_amount_label = discord.ui.Label(
            text=t(locale, 'player-modal-label-currency-amount')[:DiscordLimits.LABEL_LABEL],
            component=self.currency_amount_text_input
        )
        self.add_item(self.currency_name_label)
        self.add_item(self.currency_amount_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            await interaction.response.defer()
            locale = getattr(self.calling_view, 'locale', DEFAULT_LOCALE)
            currency_name = self.currency_name_text_input.value.strip()
            try:
                amount = float(self.currency_amount_text_input.value.strip())
                if not math.isfinite(amount):
                    raise ValueError
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
            if amount > DisplayLimits.MAX_CURRENCY_AMOUNT:
                raise UserFeedbackError(
                    t(locale, 'player-error-amount-exceeds-maximum',
                      max=str(DisplayLimits.MAX_CURRENCY_AMOUNT)),
                    message_id='player-error-amount-exceeds-maximum',
                    max=str(DisplayLimits.MAX_CURRENCY_AMOUNT)
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

            can_afford, message = check_sufficient_funds(
                current_wallet, currency_config, currency_name, amount, locale=locale
            )
            if not can_afford:
                raise UserFeedbackError(message)

            await update_character_inventory(interaction, member_id, active_character_id, currency_name, -amount)

            updated_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name=DatabaseCollections.CHARACTERS,
                query={CommonFields.ID: member_id}
            )

            new_wallet = (
                updated_query[CharacterFields.CHARACTERS][active_character_id]
                [CharacterFields.ATTRIBUTES].get(CharacterFields.CURRENCY, {})
            )

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
            spend_transaction_id = shortuuid.uuid()[:12]
            trade_embed.set_footer(text=t(
                locale, 'player-embed-footer-transaction-id',
                transactionId=spend_transaction_id
            ))

            await setup_view(self.calling_view, interaction)
            await interaction.edit_original_response(view=self.calling_view)
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
                    guild_locale = await resolve_locale(bot=bot, guild_id=guild_id)
                    if guild_locale != locale:
                        log_embed = discord.Embed(
                            title=t(guild_locale, 'player-embed-title-spend'),
                            description=(
                                t(guild_locale, 'player-embed-desc-spend-player',
                                  playerMention=interaction.user.mention,
                                  characterName=character_name) + '\n' +
                                t(guild_locale, 'player-embed-desc-spend-transaction',
                                  characterName=character_name,
                                  formattedAmount=formatted_amount)
                            ),
                            color=discord.Color.gold(),
                            type='rich'
                        )
                        log_embed.set_author(
                            name=interaction.user.display_name,
                            icon_url=interaction.user.display_avatar.url if interaction.user.display_avatar else None
                        )
                        log_embed.add_field(
                            name=t(guild_locale, 'player-embed-field-balance', characterName=character_name),
                            value=balance_str, inline=False
                        )
                        log_embed.add_field(
                            name=t(guild_locale, 'player-embed-field-channel'),
                            value=interaction.channel.mention
                        )
                        log_embed.add_field(
                            name=t(guild_locale, 'player-embed-field-receipt'),
                            value=receipt.jump_url
                        )
                        log_embed.set_footer(text=t(
                            guild_locale, 'player-embed-footer-transaction-id',
                            transactionId=spend_transaction_id
                        ))
                        await log_channel.send(embed=log_embed)
                    else:
                        trade_embed.add_field(
                            name=t(locale, 'player-embed-field-channel'),
                            value=interaction.channel.mention
                        )
                        trade_embed.add_field(
                            name=t(locale, 'player-embed-field-receipt'),
                            value=receipt.jump_url
                        )
                        await log_channel.send(embed=trade_embed)
        except Exception as e:
            await log_exception(e, interaction)


class CreatePlayerPostModal(LocaleModal):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'player-modal-title-create-post')[:DiscordLimits.MODAL_TITLE],
            timeout=600
        )
        self.title_text_input = discord.ui.TextInput(
            custom_id='title_text_input',
            placeholder=t(locale, 'player-modal-placeholder-post-title')[
                :DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            max_length=80
        )
        self.title_label = discord.ui.Label(
            text=t(locale, 'player-modal-label-post-title')[:DiscordLimits.LABEL_LABEL],
            component=self.title_text_input
        )
        self.content_text_input = discord.ui.TextInput(
            style=discord.TextStyle.paragraph,
            custom_id='content_text_input',
            placeholder=t(locale, 'player-modal-placeholder-post-content')[
                :DiscordLimits.TEXT_INPUT_PLACEHOLDER]
        )
        self.content_label = discord.ui.Label(
            text=t(locale, 'player-modal-label-post-content')[:DiscordLimits.LABEL_LABEL],
            component=self.content_text_input
        )
        self.calling_view = calling_view
        self.add_item(self.title_label)
        self.add_item(self.content_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            title = self.title_text_input.value
            content = self.content_text_input.value
            await self.calling_view.create_post(title, content, interaction)
        except Exception as e:
            await log_exception(e, interaction)


class EditPlayerPostModal(LocaleModal):
    def __init__(self, calling_view, post):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'player-modal-title-edit-post')[:DiscordLimits.MODAL_TITLE],
            timeout=600
        )
        self.calling_view = calling_view
        self.post = post
        self.title_text_input = discord.ui.TextInput(
            custom_id='title_text_input',
            placeholder=t(locale, 'player-modal-placeholder-post-title')[
                :DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            default=post['title'],
            max_length=80,
            required=False
        )
        self.title_label = discord.ui.Label(
            text=t(locale, 'player-modal-label-post-title')[:DiscordLimits.LABEL_LABEL],
            component=self.title_text_input
        )
        self.content_text_input = discord.ui.TextInput(
            style=discord.TextStyle.paragraph,
            custom_id='content_text_input',
            placeholder=t(locale, 'player-modal-placeholder-post-content')[
                :DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            default=post['content'],
            required=False
        )
        self.content_label = discord.ui.Label(
            text=t(locale, 'player-modal-label-post-content')[:DiscordLimits.LABEL_LABEL],
            component=self.content_text_input
        )
        self.add_item(self.title_label)
        self.add_item(self.content_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            title = self.title_text_input.value
            content = self.content_text_input.value
            await self.calling_view.edit_post(self.post, title, content, interaction)
        except Exception as e:
            await log_exception(e, interaction)


class WizardEditCartItemModal(LocaleModal):
    def __init__(self, cart_view, item_key, current_quantity):
        locale = getattr(cart_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'player-modal-title-edit-cart-qty')[:DiscordLimits.MODAL_TITLE],
            timeout=600
        )
        self.cart_view = cart_view
        self.item_key = item_key

        self.quantity_text_input = discord.ui.TextInput(
            default=str(current_quantity),
            min_length=1,
            max_length=5,
            placeholder=t(locale, 'player-modal-placeholder-cart-qty')[:DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            custom_id='wiz_cart_qty_input'
        )
        self.quantity_label = discord.ui.Label(
            text=t(locale, 'player-modal-label-cart-qty')[:DiscordLimits.LABEL_LABEL],
            component=self.quantity_text_input
        )
        self.add_item(self.quantity_label)

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
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'player-modal-title-create-container')[:DiscordLimits.MODAL_TITLE],
            timeout=180
        )
        self.calling_view = calling_view
        self.name_input = discord.ui.TextInput(
            placeholder=t(locale, 'player-modal-placeholder-container-name')[
                :DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            custom_id='container_name_input',
            max_length=50,
            required=True
        )
        self.name_label = discord.ui.Label(
            text=t(locale, 'player-modal-label-container-name')[:DiscordLimits.LABEL_LABEL],
            component=self.name_input
        )
        self.add_item(self.name_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            await interaction.response.defer()
            name = self.name_input.value.strip()
            await create_container(
                interaction.client,
                interaction.user.id,
                self.calling_view.character_id,
                name
            )

            await setup_view(self.calling_view, interaction)
            await interaction.edit_original_response(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RenameContainerModal(LocaleModal):
    def __init__(self, calling_view, container_id: str, current_name: str):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'player-modal-title-rename-container')[:DiscordLimits.MODAL_TITLE],
            timeout=180
        )
        self.calling_view = calling_view
        self.container_id = container_id
        self.name_input = discord.ui.TextInput(
            placeholder=t(locale, 'player-modal-placeholder-new-container-name')[
                :DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            custom_id='container_rename_input',
            default=current_name,
            max_length=50,
            required=True
        )
        self.name_label = discord.ui.Label(
            text=t(locale, 'player-modal-label-new-container-name')[:DiscordLimits.LABEL_LABEL],
            component=self.name_input
        )
        self.add_item(self.name_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            await interaction.response.defer()
            new_name = self.name_input.value.strip()
            await rename_container(
                interaction.client,
                interaction.user.id,
                self.calling_view.character_id,
                self.container_id,
                new_name
            )

            await setup_view(self.calling_view, interaction)
            await interaction.edit_original_response(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ConsumeFromContainerModal(LocaleModal):
    def __init__(self, calling_view, item_name: str, max_quantity: int):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'player-modal-title-consume')[:DiscordLimits.MODAL_TITLE],
            timeout=180
        )
        self.calling_view = calling_view
        self.item_name = item_name
        self.max_quantity = max_quantity

        self.quantity_input = discord.ui.TextInput(
            placeholder=t(locale, 'player-modal-placeholder-consume-qty')[
                :DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            custom_id='consume_quantity_input',
            default='1',
            required=True
        )
        self.quantity_label = discord.ui.Label(
            text=t(locale, 'player-modal-label-consume-qty', maxQuantity=max_quantity)[
                :DiscordLimits.LABEL_LABEL],
            component=self.quantity_input
        )
        self.add_item(self.quantity_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            await interaction.response.defer()
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

            await consume_item_from_container(
                interaction.client,
                interaction.user.id,
                self.calling_view.character_id,
                self.item_name,
                quantity,
                self.calling_view.container_id
            )

            self.calling_view.selected_item = None
            await setup_view(self.calling_view, interaction)
            await interaction.edit_original_response(view=self.calling_view)

            bot = interaction.client
            guild_id = interaction.guild_id
            guild_locale = await resolve_locale(bot=bot, guild_id=guild_id)
            container_name = get_container_name(
                self.calling_view.character_data,
                self.calling_view.container_id,
                locale=guild_locale
            )
            consume_transaction_id = shortuuid.uuid()[:12]
            character_name = self.calling_view.character_data[CharacterFields.NAME]
            item_display = escape_markdown(titlecase(self.item_name))

            receipt_embed = discord.Embed(
                title=t(guild_locale, 'player-embed-title-consume'),
                description=(
                    t(guild_locale, 'player-embed-desc-consume',
                      playerMention=interaction.user.mention,
                      characterName=character_name) + '\n' +
                    t(guild_locale, 'player-embed-desc-consume-removed',
                      quantity=quantity,
                      itemName=item_display,
                      containerName=container_name)
                ),
                color=discord.Color.gold(),
                type='rich'
            )
            receipt_embed.set_author(
                name=interaction.user.display_name,
                icon_url=interaction.user.display_avatar.url if interaction.user.display_avatar else None
            )
            receipt_embed.set_footer(text=t(
                guild_locale, 'player-embed-footer-transaction-id',
                transactionId=consume_transaction_id
            ))

            receipt_message = await interaction.followup.send(embed=receipt_embed, wait=True)

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
                    log_embed = discord.Embed(
                        title=receipt_embed.title,
                        description=receipt_embed.description,
                        color=discord.Color.gold(),
                        type='rich'
                    )
                    log_embed.set_author(
                        name=interaction.user.display_name,
                        icon_url=interaction.user.display_avatar.url if interaction.user.display_avatar else None
                    )
                    log_embed.add_field(
                        name=t(guild_locale, 'player-embed-field-channel'),
                        value=interaction.channel.mention
                    )
                    log_embed.add_field(
                        name=t(guild_locale, 'player-embed-field-receipt'),
                        value=receipt_message.jump_url
                    )
                    log_embed.set_footer(text=receipt_embed.footer.text)
                    await log_channel.send(embed=log_embed)
        except Exception as e:
            await log_exception(e, interaction)


class MoveItemQuantityModal(LocaleModal):
    def __init__(self, calling_view, item_name: str, max_quantity: int):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'player-modal-title-move-item')[:DiscordLimits.MODAL_TITLE],
            timeout=180
        )
        self.calling_view = calling_view
        self.item_name = item_name
        self.max_quantity = max_quantity

        self.quantity_input = discord.ui.TextInput(
            placeholder=t(locale, 'player-modal-placeholder-move-qty')[:DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            custom_id='move_quantity_input',
            default=str(max_quantity),
            required=True
        )
        self.quantity_label = discord.ui.Label(
            text=t(locale, 'player-modal-label-move-qty', maxQuantity=max_quantity)[
                :DiscordLimits.LABEL_LABEL],
            component=self.quantity_input
        )
        self.add_item(self.quantity_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            await interaction.response.defer()
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

            from ReQuest.ui.player.views import ContainerItemsView
            view = ContainerItemsView(
                self.calling_view.source_view.character_id,
                self.calling_view.source_view.character_data,
                self.calling_view.source_container_id
            )
            await setup_view(view, interaction)
            await interaction.edit_original_response(view=view)

        except Exception as e:
            await log_exception(e, interaction)
