import json
import logging
from datetime import datetime, timezone, timedelta

import discord
import discord.ui
import jsonschema
import shortuuid
from discord.ui import (
    Label,
    LayoutView,
    Container,
    Section,
    TextDisplay,
    Separator,
    Thumbnail
)
from jsonschema import validate
from titlecase import titlecase

from ReQuest.ui.common.enums import ShopChannelType, RestockMode, ScheduleType
from ReQuest.ui.common.modals import LocaleModal
from ReQuest.utilities.constants import (
    CharacterFields, ConfigFields, CurrencyFields, QuestFields, ShopFields, RestockFields, RoleplayFields, CommonFields,
    DatabaseCollections
)
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
from ReQuest.utilities.supportFunctions import (
    log_exception,
    setup_view,
    find_currency_or_denomination,
    get_cached_data,
    get_denomination_map,
    update_cached_data,
    UserFeedbackError,
    delete_cached_data,
    strip_id,
    initialize_item_stock,
    get_item_stock,
    encode_mongo_key,
    format_currency_amount
)

logger = logging.getLogger(__name__)

SHOP_SCHEMA = {
    "type": "object",
    "properties": {
        "shopName": {"type": "string"},
        "shopKeeper": {"type": "string"},
        "shopDescription": {"type": "string"},
        "shopImage": {"type": "string", "format": "uri"},
        "restockConfig": {
            "type": "object",
            "properties": {
                "enabled": {"type": "boolean"},
                "schedule": {"type": "string", "enum": ["hourly", "daily", "weekly"]},
                "dayOfWeek": {"type": "integer", "minimum": 0, "maximum": 6},
                "hour": {"type": "integer", "minimum": 0, "maximum": 23},
                "minute": {"type": "integer", "minimum": 0, "maximum": 59},
                "mode": {"type": "string", "enum": ["full", "incremental"]},
                "incrementAmount": {"type": "integer", "minimum": 1}
            }
        },
        "shopStock": {
            "type": "array",
            "items": {
                "type": "object",
                "properties": {
                    "name": {"type": "string"},
                    "description": {"type": "string"},
                    "quantity": {"type": "integer", "minimum": 1},
                    "maxStock": {"type": "integer", "minimum": 1},
                    "costs": {
                        "type": "array",
                        "items": {
                            "type": "object",
                            "patternProperties": {
                                "^.*$": {"type": "number"}
                            }
                        }
                    }
                },
                "required": ["name", "costs"]
            }
        }
    },
    "required": ["shopName", "shopStock"]
}


class AddCurrencyTextModal(LocaleModal):
    def __init__(self, calling_view):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-add-currency'),
            timeout=180
        )
        self.calling_view = calling_view
        self.text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-currency-name'),
            required=True,
            custom_id='new_currency_name_text_input')
        self.add_item(self.text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            view = self.calling_view
            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: guild_id}
            )
            matches = 0
            if query:
                for currency in query[CurrencyFields.CURRENCIES]:
                    if currency[CommonFields.NAME].lower() == self.text_input.value.lower():
                        matches += 1
                    for denomination in currency[CurrencyFields.DENOMINATIONS]:
                        if denomination[CommonFields.NAME].lower() == self.text_input.value.lower():
                            matches += 1

            if matches > 0:
                locale = getattr(self, '_locale', DEFAULT_LOCALE)
                await interaction.response.defer(ephemeral=True, thinking=True)
                await interaction.followup.send(
                    t(locale, 'config-error-currency-already-exists', **{'name': self.text_input.value})
                )
            else:
                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name=DatabaseCollections.CURRENCY,
                    query={CommonFields.ID: guild_id},
                    update_data={'$push': {CurrencyFields.CURRENCIES: {CommonFields.NAME: self.text_input.value,
                                                          CurrencyFields.IS_DOUBLE: False, CurrencyFields.DENOMINATIONS: []}}}
                )
                await setup_view(view, interaction)
                await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class RenameCurrencyModal(LocaleModal):
    def __init__(self, calling_view, old_currency_name):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-rename-currency'),
            timeout=180
        )
        self.calling_view = calling_view
        self.old_currency_name = old_currency_name
        self.text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-new-currency-name'),
            required=True,
            default=old_currency_name,
            custom_id='rename_currency_text_input'
        )
        self.add_item(self.text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            new_name = self.text_input.value.strip()

            if new_name.lower() == self.old_currency_name.lower():
                # No actual change, just refresh
                await setup_view(self.calling_view, interaction)
                await interaction.response.edit_message(view=self.calling_view)
                return

            # Check for duplicate names
            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: guild_id}
            )

            if query:
                for currency in query.get(CurrencyFields.CURRENCIES, []):
                    if currency[CommonFields.NAME].lower() == new_name.lower():
                        raise UserFeedbackError(
                            t(DEFAULT_LOCALE, 'config-error-currency-name-exists', **{'name': new_name}),
                            message_id='config-error-currency-name-exists'
                        )
                    for denomination in currency.get(CurrencyFields.DENOMINATIONS, []):
                        if denomination[CommonFields.NAME].lower() == new_name.lower():
                            raise UserFeedbackError(
                                t(DEFAULT_LOCALE, 'config-error-denomination-name-exists', **{'name': new_name}),
                                message_id='config-error-denomination-name-exists'
                            )

            # Update the currency name
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: guild_id, f'{CurrencyFields.CURRENCIES}.{CommonFields.NAME}': self.old_currency_name},
                update_data={'$set': {f'{CurrencyFields.CURRENCIES}.$.{CommonFields.NAME}': new_name}}
            )

            # Update the view with the new name and refresh
            self.calling_view.currency_name = new_name
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RenameDenominationModal(LocaleModal):
    def __init__(self, calling_view, currency_name, old_denomination_name):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-rename-denomination'),
            timeout=180
        )
        self.calling_view = calling_view
        self.currency_name = currency_name
        self.old_denomination_name = old_denomination_name
        self.text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-new-denomination-name'),
            required=True,
            default=old_denomination_name,
            custom_id='rename_denomination_text_input'
        )
        self.add_item(self.text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            new_name = self.text_input.value.strip()

            if new_name.lower() == self.old_denomination_name.lower():
                # No actual change, just refresh
                await setup_view(self.calling_view, interaction)
                await interaction.response.edit_message(view=self.calling_view)
                return

            # Check for duplicate names
            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: guild_id}
            )

            if query:
                for currency in query.get(CurrencyFields.CURRENCIES, []):
                    if currency[CommonFields.NAME].lower() == new_name.lower():
                        raise UserFeedbackError(
                            t(DEFAULT_LOCALE, 'config-error-currency-name-exists', **{'name': new_name}),
                            message_id='config-error-currency-name-exists'
                        )
                    for denomination in currency.get(CurrencyFields.DENOMINATIONS, []):
                        if denomination[CommonFields.NAME].lower() == new_name.lower():
                            raise UserFeedbackError(
                                t(DEFAULT_LOCALE, 'config-error-denomination-name-exists', **{'name': new_name}),
                                message_id='config-error-denomination-name-exists'
                            )

            # Update the denomination name using arrayFilters
            collection = bot.gdb[DatabaseCollections.CURRENCY]
            await collection.update_one(
                {CommonFields.ID: guild_id, f'{CurrencyFields.CURRENCIES}.{CommonFields.NAME}': self.currency_name},
                {'$set': {f'{CurrencyFields.CURRENCIES}.$.{CurrencyFields.DENOMINATIONS}.$[denom].{CommonFields.NAME}': new_name}},
                array_filters=[{f'denom.{CommonFields.NAME}': self.old_denomination_name}]
            )

            # Invalidate cache
            from ReQuest.utilities.supportFunctions import build_cache_key
            cache_key = build_cache_key(bot.gdb.name, guild_id, DatabaseCollections.CURRENCY)
            await bot.rdb.delete(cache_key)

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class AddCurrencyDenominationModal(LocaleModal):
    def __init__(self, calling_view, base_currency_name):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-add-denomination', **{'currencyName': base_currency_name}),
            timeout=300
        )
        self.calling_view = calling_view
        self.base_currency_name = base_currency_name

        self.denomination_name_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-denomination-name'),
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-denomination-name'),
            custom_id='denomination_name_text_input'
        )
        self.denomination_value_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-denomination-value'),
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-denomination-value'),
            custom_id='denomination_value_text_input'
        )
        self.add_item(self.denomination_name_text_input)
        self.add_item(self.denomination_value_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            new_name = self.denomination_name_text_input.value

            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: guild_id}
            )
            for currency in query[CurrencyFields.CURRENCIES]:
                if new_name.lower() == currency[CommonFields.NAME].lower():
                    raise UserFeedbackError(
                        t(DEFAULT_LOCALE, 'config-error-denomination-matches-currency', **{'existingName': currency[CommonFields.NAME]}),
                        message_id='config-error-denomination-matches-currency'
                    )
                for denomination in currency[CurrencyFields.DENOMINATIONS]:
                    if new_name.lower() == denomination[CommonFields.NAME].lower():
                        raise UserFeedbackError(
                            t(DEFAULT_LOCALE, 'config-error-denomination-matches-denomination', **{'denominationName': denomination[CommonFields.NAME],
                               'currencyName': currency[CommonFields.NAME]}),
                            message_id='config-error-denomination-matches-denomination'
                        )
            base_currency = next((item for item in query[CurrencyFields.CURRENCIES] if item[CommonFields.NAME] == self.base_currency_name),
                                 None)
            if base_currency:
                for denomination in base_currency[CurrencyFields.DENOMINATIONS]:
                    if float(self.denomination_value_text_input.value) == denomination[CurrencyFields.VALUE]:
                        using_name = denomination[CommonFields.NAME]
                        raise UserFeedbackError(
                            t(DEFAULT_LOCALE, 'config-error-denomination-value-exists', **{'denominationName': using_name}),
                            message_id='config-error-denomination-value-exists'
                        )

                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name=DatabaseCollections.CURRENCY,
                    query={CommonFields.ID: guild_id, f'{CurrencyFields.CURRENCIES}.{CommonFields.NAME}': self.base_currency_name},
                    update_data={
                        '$push': {f'{CurrencyFields.CURRENCIES}.$.{CurrencyFields.DENOMINATIONS}': {
                            CommonFields.NAME: new_name,
                            CurrencyFields.VALUE: float(self.denomination_value_text_input.value)}
                        }
                    }
                )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ForbiddenRolesModal(LocaleModal):
    def __init__(self, current_list):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-forbidden-roles'),
            timeout=600
        )
        self.names_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-names'),
            style=discord.TextStyle.paragraph,
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-names'),
            default=', '.join(current_list),
            custom_id='names_text_input',
            required=False
        )
        self.add_item(self.names_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            names = []
            for name in self.names_text_input.value.strip().split(','):
                names.append(name.lower().strip())

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.FORBIDDEN_ROLES,
                query={CommonFields.ID: interaction.guild_id},
                update_data={'$set': {ConfigFields.FORBIDDEN_ROLES: names}}
            )
            locale = getattr(self, '_locale', DEFAULT_LOCALE)
            await interaction.response.send_message(
                t(locale, 'config-msg-forbidden-roles-updated'), ephemeral=True
            )
        except Exception as e:
            await log_exception(e, interaction)


class PlayerBoardPurgeModal(LocaleModal):
    def __init__(self, calling_view):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-purge-player-board'),
            timeout=600
        )
        self.calling_view = calling_view
        self.age_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-age'),
            custom_id='age_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-age')
        )
        self.add_item(self.age_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            age = int(self.age_text_input.value)

            # Get the current datetime and calculate the cutoff date
            current_datetime = datetime.now(timezone.utc)
            cutoff_date = current_datetime - timedelta(days=age)

            # Delete all records in the db matching this guild that are older than the cutoff
            await delete_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.PLAYER_BOARD,
                search_filter={QuestFields.GUILD_ID: interaction.guild_id, 'timestamp': {'$lt': cutoff_date}},
                is_single=False,
                cache_id=interaction.guild_id
            )

            # Get the channel object and purge all messages older than the cutoff
            config_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.PLAYER_BOARD_CHANNEL,
                query={CommonFields.ID: interaction.guild_id}
            )
            channel_id = strip_id(config_query[ConfigFields.PLAYER_BOARD_CHANNEL])
            channel = interaction.guild.get_channel(channel_id)
            await channel.purge(before=cutoff_date)

            locale = getattr(self, '_locale', DEFAULT_LOCALE)
            await interaction.response.send_message(
                t(locale, 'config-msg-posts-purged', **{'days': str(age)}),
                ephemeral=True,
                delete_after=10
            )
        except Exception as e:
            await log_exception(e, interaction)


class GMRewardsModal(LocaleModal):
    def __init__(self, calling_view):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-gm-rewards'),
            timeout=600
        )
        self.calling_view = calling_view
        current_rewards = calling_view.current_rewards
        self.xp_enabled = getattr(calling_view, 'xp_enabled', True)

        if self.xp_enabled:
            self.experience_text_input = discord.ui.TextInput(
                label=t(DEFAULT_LOCALE, 'config-modal-label-experience'),
                custom_id='experience_text_input',
                placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-enter-number'),
                default=current_rewards[CharacterFields.EXPERIENCE] if current_rewards and current_rewards[CharacterFields.EXPERIENCE] else None,
                required=False
            )
            self.add_item(self.experience_text_input)

        self.items_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-items'),
            style=discord.TextStyle.paragraph,
            custom_id='items_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-items'),
            default=(self.parse_items_to_string(current_rewards[CommonFields.ITEMS])
                     if current_rewards and current_rewards[CommonFields.ITEMS]
                     else None),
            required=False
        )
        self.add_item(self.items_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            experience = None
            if self.xp_enabled and hasattr(self, 'experience_text_input') and self.experience_text_input.value:
                try:
                    experience = int(self.experience_text_input.value)
                except ValueError:
                    raise UserFeedbackError(
                        t(DEFAULT_LOCALE, 'config-error-experience-invalid'),
                        message_id='config-error-experience-invalid'
                    )

            items = None
            if self.items_text_input.value:
                items = {}
                for item in self.items_text_input.value.strip().split('\n'):
                    try:
                        item_name, quantity = item.split(':', 1)
                        items[titlecase(item_name.strip())] = int(quantity.strip())
                    except ValueError:
                        raise UserFeedbackError(
                            t(DEFAULT_LOCALE, 'config-error-item-format-invalid', **{'item': item}),
                            message_id='config-error-item-format-invalid'
                        )

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.GM_REWARDS,
                query={CommonFields.ID: interaction.guild_id},
                update_data={'$set': {CharacterFields.EXPERIENCE: experience, CommonFields.ITEMS: items}}
            )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)

    @staticmethod
    def parse_items_to_string(items) -> str:
        item_list = []
        for item_name, quantity in items.items():
            item_list.append(f'{titlecase(item_name)}: {quantity}')
        item_string = '\n'.join(item_list)
        return item_string


class ConfigShopDetailsModal(LocaleModal):
    def __init__(self, calling_view, existing_shop_data=None, existing_channel_id=None,
                 channel_type='text', parent_forum_id=None, preselected_channel=None):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-shop-details'),
            timeout=600
        )
        self.calling_view = calling_view
        self.existing_channel_id = existing_channel_id
        self.channel_type = channel_type
        self.parent_forum_id = parent_forum_id
        self.preselected_channel = preselected_channel

        self.shop_channel_select = None

        name_default = existing_shop_data.get(ShopFields.SHOP_NAME, '') if existing_shop_data else ''
        keeper_default = existing_shop_data.get(ShopFields.SHOP_KEEPER, '') if existing_shop_data else ''
        description_default = existing_shop_data.get(ShopFields.SHOP_DESCRIPTION, '') if existing_shop_data else ''
        image_default = existing_shop_data.get(ShopFields.SHOP_IMAGE, '') if existing_shop_data else ''

        # Only show channel select if no existing channel AND no preselected channel (forum thread)
        if not self.existing_channel_id and not self.preselected_channel:
            self.shop_channel_select = discord.ui.ChannelSelect(
                channel_types=[discord.ChannelType.text],
                placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-shop-channel'),
                custom_id='shop_channel_select',
                required=True
            )
            self.channel_label = Label(
                text=t(DEFAULT_LOCALE, 'config-modal-label-shop-channel'),
                component=self.shop_channel_select
            )
            self.add_item(self.channel_label)
        self.shop_name_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-shop-name'),
            custom_id='shop_name_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-shop-name'),
            default=name_default,
            required=True
        )
        self.shop_keeper_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-shopkeeper-name'),
            custom_id='shop_keeper_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-shopkeeper-name'),
            default=keeper_default,
            required=False
        )
        self.shop_description_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-shop-description'),
            style=discord.TextStyle.paragraph,
            custom_id='shop_description_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-shop-description'),
            default=description_default,
            required=False
        )
        self.shop_image_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-shop-image-url'),
            custom_id='shop_image_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-shop-image-url'),
            default=image_default,
            required=False
        )
        self.add_item(self.shop_name_text_input)
        self.add_item(self.shop_keeper_text_input)
        self.add_item(self.shop_description_text_input)
        self.add_item(self.shop_image_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id

            if self.existing_channel_id:
                channel_id = self.existing_channel_id
            elif self.preselected_channel:
                # Forum thread case - channel already selected
                channel_id = str(self.preselected_channel.id)
            else:
                if not self.shop_channel_select or not self.shop_channel_select.values:
                    raise UserFeedbackError(
                        t(DEFAULT_LOCALE, 'config-error-no-channel-selected'),
                        message_id='config-error-no-channel-selected'
                    )
                channel_id = str(self.shop_channel_select.values[0].id)

            if not self.existing_channel_id:
                query = await get_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name=DatabaseCollections.SHOPS,
                    query={CommonFields.ID: guild_id}
                )
                if query and channel_id in query.get(ShopFields.SHOP_CHANNELS, {}):
                    raise UserFeedbackError(
                        t(DEFAULT_LOCALE, 'config-error-shop-already-in-channel'),
                        message_id='config-error-shop-already-in-channel'
                    )

            shop_data = {
                ShopFields.SHOP_NAME: self.shop_name_text_input.value,
                ShopFields.SHOP_KEEPER: self.shop_keeper_text_input.value,
                ShopFields.SHOP_DESCRIPTION: self.shop_description_text_input.value,
                ShopFields.SHOP_IMAGE: self.shop_image_text_input.value,
                ShopFields.SHOP_STOCK: [],
                ShopFields.CHANNEL_TYPE: self.channel_type
            }

            # Add parent forum ID for forum thread shops
            if self.channel_type == ShopChannelType.FORUM_THREAD.value and self.parent_forum_id:
                shop_data[ShopFields.PARENT_FORUM_ID] = self.parent_forum_id

            if self.existing_channel_id:
                existing_query = await get_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name=DatabaseCollections.SHOPS,
                    query={CommonFields.ID: guild_id}
                )
                existing_shop_data = existing_query.get(ShopFields.SHOP_CHANNELS, {}).get(channel_id, {})
                shop_data[ShopFields.SHOP_STOCK] = existing_shop_data.get(ShopFields.SHOP_STOCK, [])

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={CommonFields.ID: guild_id},
                update_data={'$set': {f'{ShopFields.SHOP_CHANNELS}.{channel_id}': shop_data}}
            )

            if hasattr(self.calling_view, 'update_details'):
                self.calling_view.update_details(shop_data)
                self.calling_view.build_view()
                await interaction.response.edit_message(view=self.calling_view)
            else:
                from ReQuest.ui.config.views import ConfigShopsView
                shops_view = ConfigShopsView()
                await setup_view(shops_view, interaction)
                await interaction.response.edit_message(view=shops_view)
        except Exception as e:
            await log_exception(e, interaction)


def build_shop_header_view(shop_data: dict) -> LayoutView:
    """
    Builds a static LayoutView displaying shop header information.

    :param shop_data: The shop configuration data
    :return: A LayoutView with the shop header
    """
    view = LayoutView(timeout=None)
    container = Container()
    header_items = []

    if shop_name := shop_data.get(ShopFields.SHOP_NAME):
        header_items.append(TextDisplay(f'# {shop_name}'))
    if shop_keeper := shop_data.get(ShopFields.SHOP_KEEPER):
        header_items.append(TextDisplay(t(DEFAULT_LOCALE, 'config-label-shopkeeper', **{'name': shop_keeper})))
    if shop_description := shop_data.get(ShopFields.SHOP_DESCRIPTION):
        header_items.append(TextDisplay(f'*{shop_description}*'))

    if shop_image := shop_data.get(ShopFields.SHOP_IMAGE):
        thumbnail = Thumbnail(media=shop_image)
        shop_header = Section(accessory=thumbnail)
        for item in header_items:
            shop_header.add_item(item)
        container.add_item(shop_header)
    else:
        for item in header_items:
            container.add_item(item)

    container.add_item(Separator())
    container.add_item(TextDisplay(t(DEFAULT_LOCALE, 'config-msg-use-shop-command')))

    view.add_item(container)
    return view


class ForumThreadShopModal(LocaleModal):
    """Modal for creating a shop in a new forum thread."""
    def __init__(self, calling_view, forum_channel):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-forum-thread-shop'),
            timeout=600
        )
        self.calling_view = calling_view
        self.forum_channel = forum_channel

        self.thread_name_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-thread-name'),
            custom_id='thread_name_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-thread-name'),
            required=True
        )
        self.shop_name_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-shop-name'),
            custom_id='shop_name_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-shop-name'),
            required=True
        )
        self.shop_keeper_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-shopkeeper-name'),
            custom_id='shop_keeper_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-shopkeeper-name'),
            required=False
        )
        self.shop_description_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-shop-description'),
            style=discord.TextStyle.paragraph,
            custom_id='shop_description_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-shop-description'),
            required=False
        )
        self.shop_image_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-shop-image-url'),
            custom_id='shop_image_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-shop-image-url'),
            required=False
        )

        self.add_item(self.thread_name_input)
        self.add_item(self.shop_name_input)
        self.add_item(self.shop_keeper_input)
        self.add_item(self.shop_description_input)
        self.add_item(self.shop_image_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id

            # Fetch the actual ForumChannel object (self.forum_channel is an AppCommandChannel)
            forum = interaction.guild.get_channel(self.forum_channel.id)
            if not forum:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-forum-not-found'),
                    message_id='config-error-forum-not-found'
                )

            # Build shop data first so we can create the header view
            thread_name = self.thread_name_input.value
            shop_data = {
                ShopFields.SHOP_NAME: self.shop_name_input.value,
                ShopFields.SHOP_KEEPER: self.shop_keeper_input.value,
                ShopFields.SHOP_DESCRIPTION: self.shop_description_input.value,
                ShopFields.SHOP_IMAGE: self.shop_image_input.value,
                ShopFields.SHOP_STOCK: [],
                ShopFields.CHANNEL_TYPE: ShopChannelType.FORUM_THREAD.value,
                ShopFields.PARENT_FORUM_ID: str(self.forum_channel.id)
            }

            # Create the shop header view for the initial post
            header_view = build_shop_header_view(shop_data)

            # Create the forum thread with the shop header view
            thread_with_message = await forum.create_thread(
                name=thread_name,
                view=header_view
            )

            # Get the thread ID (create_thread returns a ThreadWithMessage)
            thread = thread_with_message.thread
            channel_id = str(thread.id)

            # Check if a shop already exists for this thread (shouldn't happen for new thread, but safety check)
            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={CommonFields.ID: guild_id}
            )
            if query and channel_id in query.get(ShopFields.SHOP_CHANNELS, {}):
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-shop-already-in-thread'),
                    message_id='config-error-shop-already-in-thread'
                )

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={CommonFields.ID: guild_id},
                update_data={'$set': {f'{ShopFields.SHOP_CHANNELS}.{channel_id}': shop_data}}
            )

            # Navigate back to shop config view
            from ReQuest.ui.config.views import ConfigShopsView
            new_view = ConfigShopsView()
            await setup_view(new_view, interaction)
            await interaction.response.edit_message(view=new_view)

        except Exception as e:
            await log_exception(e, interaction)


class ConfigShopJSONModal(LocaleModal):
    def __init__(self, calling_view):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-add-shop-json'),
            timeout=600
        )
        self.calling_view = calling_view

        self.shop_channel_select = discord.ui.ChannelSelect(
            channel_types=[discord.ChannelType.text],
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-shop-channel'),
            custom_id='shop_channel_select'
        )
        self.shop_json_file_upload = discord.ui.FileUpload(
            custom_id='shop_json_file_upload'
        )
        self.select_label = Label(
            text=t(DEFAULT_LOCALE, 'config-modal-label-shop-channel'),
            component=self.shop_channel_select
        )
        self.upload_label = Label(
            text=t(DEFAULT_LOCALE, 'config-modal-label-upload-json'),
            component=self.shop_json_file_upload
        )
        self.add_item(self.select_label)
        self.add_item(self.upload_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            channel_id = str(self.shop_channel_select.values[0].id)

            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={CommonFields.ID: guild_id}
            )
            if query and channel_id in query.get(ShopFields.SHOP_CHANNELS, {}):
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-shop-already-in-channel'),
                    message_id='config-error-shop-already-in-channel'
                )

            if not self.shop_json_file_upload.values:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-no-json-uploaded'),
                    message_id='config-error-no-json-uploaded'
                )

            uploaded_file = self.shop_json_file_upload.values[0]
            if not uploaded_file.filename.endswith('.json'):
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-file-must-be-json'),
                    message_id='config-error-file-must-be-json'
                )

            file_bytes = await uploaded_file.read()

            file_content = file_bytes.decode('utf-8')

            try:
                shop_data = json.loads(file_content)
            except json.JSONDecodeError as jde:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-invalid-json', **{'error': str(jde)}),
                    message_id='config-error-invalid-json'
                )

            try:
                validate(instance=shop_data, schema=SHOP_SCHEMA)
            except jsonschema.exceptions.ValidationError as ve:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-json-validation-failed', **{'error': str(ve)}),
                    message_id='config-error-json-validation-failed'
                )

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={CommonFields.ID: guild_id},
                update_data={'$set': {f'{ShopFields.SHOP_CHANNELS}.{channel_id}': shop_data}}
            )

            # Initialize runtime stock for items with maxStock
            shop_stock = shop_data.get(ShopFields.SHOP_STOCK, [])
            for item in shop_stock:
                max_stock = item.get(ShopFields.MAX_STOCK)
                if max_stock is not None:
                    item_name = item.get(CommonFields.NAME)
                    # Initialize with max stock as available
                    await initialize_item_stock(bot, guild_id, channel_id, item_name, max_stock, max_stock)

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ShopItemModal(LocaleModal):
    def __init__(self, calling_view, existing_item=None):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-shop-item'),
            timeout=600
        )
        self.calling_view = calling_view
        self.existing_item_name = existing_item.get(CommonFields.NAME) if existing_item else None

        name_default = existing_item.get(CommonFields.NAME, '') if existing_item else ''
        description_default = existing_item.get('description', '') if existing_item else ''
        quantity_default = str(existing_item.get(CommonFields.QUANTITY, '1')) if existing_item else '1'

        costs_default = ''
        if existing_item and ShopFields.COSTS in existing_item:
            lines = []
            for option in existing_item[ShopFields.COSTS]:
                components = [f'{amount} {currency}' for currency, amount in option.items()]
                lines.append(' + '.join(components))
            costs_default = '\n'.join(lines)

        self.item_name_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-item-name'),
            custom_id='item_name_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-item-name'),
            default=name_default
        )
        self.item_description_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-item-description'),
            style=discord.TextStyle.paragraph,
            custom_id='item_description_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-item-description'),
            default=description_default,
            required=False
        )
        self.item_quantity_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-item-quantity'),
            custom_id='item_quantity_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-item-quantity'),
            default=quantity_default,
            required=False
        )
        self.item_cost_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-item-costs'),
            style=discord.TextStyle.paragraph,
            custom_id='item_cost_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-item-costs'),
            default=costs_default,
            required=False
        )
        self.add_item(self.item_name_text_input)
        self.add_item(self.item_description_text_input)
        self.add_item(self.item_quantity_text_input)
        self.add_item(self.item_cost_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            view = self.calling_view
            channel_id = view.channel_id

            quantity_str = self.item_quantity_text_input.value.strip()
            try:
                quantity = int(quantity_str)
                if quantity < 1:
                    raise ValueError
            except ValueError:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-item-quantity-positive'),
                    message_id='config-error-item-quantity-positive'
                )

            cost_string = self.item_cost_text_input.value
            parsed_costs = []

            if cost_string.strip():
                options = cost_string.strip().split('\n')
                for option in options:
                    if not option.strip():
                        continue
                    current_options = {}
                    components = option.split('+')
                    for component in components:
                        parts = component.strip().split(' ', 1)
                        if len(parts) < 2:
                            raise UserFeedbackError(
                                t(DEFAULT_LOCALE, 'config-error-cost-format-invalid', **{'option': option}),
                                message_id='config-error-cost-format-invalid'
                            )

                        amount_string = parts[0]
                        currency_name = parts[1]

                        try:
                            amount = float(amount_string)
                            if amount <= 0:
                                raise ValueError
                        except ValueError:
                            raise UserFeedbackError(
                                t(DEFAULT_LOCALE, 'config-error-cost-amount-invalid', **{'amount': amount_string, 'currency': currency_name}),
                                message_id='config-error-cost-amount-invalid'
                            )

                        currency_key = currency_name.lower()
                        currency_config = await get_cached_data(
                            bot=bot,
                            mongo_database=bot.gdb,
                            collection_name=DatabaseCollections.CURRENCY,
                            query={CommonFields.ID: guild_id}
                        )
                        currency_config_entry = find_currency_or_denomination(currency_config, currency_key)

                        if not currency_config_entry:
                            raise UserFeedbackError(
                                t(DEFAULT_LOCALE, 'config-error-unknown-currency', **{'currency': currency_name}),
                                message_id='config-error-unknown-currency'
                            )

                        current_options[currency_key] = amount

                    if current_options:
                        parsed_costs.append(current_options)

            new_item = {
                CommonFields.NAME: self.item_name_text_input.value,
                'description': self.item_description_text_input.value,
                CommonFields.QUANTITY: int(self.item_quantity_text_input.value),
                ShopFields.COSTS: parsed_costs
            }

            shop_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={CommonFields.ID: guild_id}
            )
            shop_data = shop_query.get(ShopFields.SHOP_CHANNELS, {}).get(channel_id, {})
            shop_stock = shop_data.get(ShopFields.SHOP_STOCK, [])

            if self.existing_item_name:
                new_stock = []
                found = False
                for item in shop_stock:
                    if item.get(CommonFields.NAME) == self.existing_item_name:
                        new_stock.append(new_item)
                        found = True
                    else:
                        new_stock.append(item)
                if not found:
                    raise Exception('Existing item not found in shop stock.')
                shop_data[ShopFields.SHOP_STOCK] = new_stock
            else:
                for item in shop_stock:
                    if item.get(CommonFields.NAME).lower() == new_item[CommonFields.NAME].lower():
                        raise UserFeedbackError(
                            t(DEFAULT_LOCALE, 'config-error-item-already-exists', **{'itemName': new_item[CommonFields.NAME]}),
                            message_id='config-error-item-already-exists'
                        )
                shop_data[ShopFields.SHOP_STOCK].append(new_item)

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={CommonFields.ID: guild_id},
                update_data={'$set': {f'{ShopFields.SHOP_CHANNELS}.{channel_id}': shop_data}}
            )

            self.calling_view.update_stock(shop_data[ShopFields.SHOP_STOCK])
            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ConfigUpdateShopJSONModal(LocaleModal):
    def __init__(self, calling_view):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-update-shop-json'),
            timeout=600
        )
        self.calling_view = calling_view

        self.shop_json_file_upload = discord.ui.FileUpload(
            max_values=1,
            custom_id='shop_json_file_upload',
            required=True
        )
        self.upload_label = Label(
            text=t(DEFAULT_LOCALE, 'config-modal-label-upload-new-json'),
            component=self.shop_json_file_upload
        )
        self.add_item(self.upload_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            channel_id = self.calling_view.selected_channel_id

            if not self.shop_json_file_upload.values:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-no-file-uploaded'),
                    message_id='config-error-no-file-uploaded'
                )

            uploaded_file = self.shop_json_file_upload.values[0]
            if not uploaded_file.filename.endswith('.json'):
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-file-must-be-json-ext'),
                    message_id='config-error-file-must-be-json-ext'
                )

            file_bytes = await uploaded_file.read()
            file_content = file_bytes.decode('utf-8')

            try:
                shop_data = json.loads(file_content)
            except json.JSONDecodeError as jde:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-invalid-json', **{'error': str(jde)}),
                    message_id='config-error-invalid-json'
                )

            try:
                validate(instance=shop_data, schema=SHOP_SCHEMA)
            except jsonschema.exceptions.ValidationError as err:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-json-validation-message', **{'error': err.message}),
                    message_id='config-error-json-validation-message'
                )

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={CommonFields.ID: guild_id},
                update_data={'$set': {f'{ShopFields.SHOP_CHANNELS}.{channel_id}': shop_data}}
            )

            # Initialize runtime stock for items with maxStock that don't have stock entries yet
            shop_stock = shop_data.get(ShopFields.SHOP_STOCK, [])
            for item in shop_stock:
                max_stock = item.get(ShopFields.MAX_STOCK)
                if max_stock is not None:
                    item_name = item.get(CommonFields.NAME)
                    # Check if stock already exists for this item
                    existing_stock = await get_item_stock(bot, guild_id, channel_id, item_name)
                    if existing_stock is None or ShopFields.AVAILABLE not in existing_stock:
                        # Initialize with max stock as available
                        await initialize_item_stock(bot, guild_id, channel_id, item_name, max_stock, max_stock)

            if hasattr(self.calling_view, 'update_details'):
                self.calling_view.update_details(shop_data)
                self.calling_view.build_view()
                await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class NewCharacterShopItemModal(LocaleModal):
    def __init__(self, calling_view, inventory_type, existing_item=None):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-new-char-item'),
            timeout=600
        )
        self.calling_view = calling_view
        self.inventory_type = inventory_type
        self.existing_item_name = existing_item.get(CommonFields.NAME) if existing_item else None

        name_default = existing_item.get(CommonFields.NAME, '') if existing_item else ''
        description_default = existing_item.get('description', '') if existing_item else ''
        quantity_default = str(existing_item.get(CommonFields.QUANTITY, '1')) if existing_item else '1'

        costs_default = ''
        if existing_item and ShopFields.COSTS in existing_item:
            lines = []
            for option in existing_item[ShopFields.COSTS]:
                components = [f'{amount} {currency}' for currency, amount in option.items()]
                lines.append(' + '.join(components))
            costs_default = '\n'.join(lines)

        self.item_name_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-item-name'),
            custom_id='item_name_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-item-name'),
            default=name_default
        )
        self.add_item(self.item_name_text_input)

        self.item_description_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-item-description'),
            style=discord.TextStyle.paragraph,
            custom_id='item_description_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-item-description'),
            default=description_default,
            required=False
        )
        self.add_item(self.item_description_text_input)

        self.item_quantity_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-item-quantity'),
            custom_id='item_quantity_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-item-quantity-selection'),
            default=quantity_default,
            required=False
        )
        self.add_item(self.item_quantity_text_input)

        if inventory_type == 'purchase':
            self.item_cost_text_input = discord.ui.TextInput(
                label=t(DEFAULT_LOCALE, 'config-modal-label-item-cost'),
                custom_id='item_cost_text_input',
                placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-item-costs'),
                style=discord.TextStyle.paragraph,
                default=costs_default,
                required=False
            )
            self.add_item(self.item_cost_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id

            quantity_string = self.item_quantity_text_input.value
            if not quantity_string.isdigit() or int(quantity_string) < 1:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-item-quantity-positive'),
                    message_id='config-error-item-quantity-positive'
                )

            parsed_costs = []
            if self.inventory_type == 'purchase':
                cost_string = self.item_cost_text_input.value

                if cost_string.strip():
                    options = cost_string.strip().split('\n')
                    for option in options:
                        if not option.strip():
                            continue
                        current_option_dict = {}
                        components = option.split('+')
                        for component in components:
                            parts = component.strip().split(' ', 1)
                            if len(parts) < 2:
                                raise UserFeedbackError(
                                    t(DEFAULT_LOCALE, 'config-error-cost-format-short', **{'component': component.strip()}),
                                    message_id='config-error-cost-format-short'
                                )

                            amount_str = parts[0]
                            currency_name = parts[1]

                            try:
                                amount = float(amount_str)
                                if amount <= 0:
                                    raise ValueError
                            except ValueError:
                                raise UserFeedbackError(
                                    t(DEFAULT_LOCALE, 'config-error-amount-invalid-short', **{'amount': amount_str, 'currency': currency_name}),
                                    message_id='config-error-amount-invalid-short'
                                )

                            currency_key = currency_name.lower()
                            currency_config = await get_cached_data(
                                bot=bot,
                                mongo_database=bot.gdb,
                                collection_name=DatabaseCollections.CURRENCY,
                                query={CommonFields.ID: guild_id}
                            )
                            currency_config_entry = find_currency_or_denomination(currency_config, currency_key)

                            if not currency_config_entry:
                                raise UserFeedbackError(
                                    t(DEFAULT_LOCALE, 'config-error-unknown-currency', **{'currency': currency_name}),
                                    message_id='config-error-unknown-currency'
                                )

                            current_option_dict[currency_key] = amount

                        if current_option_dict:
                            parsed_costs.append(current_option_dict)

            new_item = {
                CommonFields.NAME: self.item_name_text_input.value,
                'description': self.item_description_text_input.value,
                CommonFields.QUANTITY: int(self.item_quantity_text_input.value),
                ShopFields.COSTS: parsed_costs
            }

            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.NEW_CHARACTER_SHOP,
                query={CommonFields.ID: guild_id}
            )
            shop_stock = query.get(ShopFields.SHOP_STOCK, []) if query else []

            if self.existing_item_name:
                new_stock = []
                found = False
                for item in shop_stock:
                    if item.get(CommonFields.NAME) == self.existing_item_name:
                        new_stock.append(new_item)
                        found = True
                    else:
                        new_stock.append(item)
                if not found:
                    raise Exception('Existing item not found in shop stock.')
                shop_stock = new_stock
            else:
                for item in shop_stock:
                    if item.get(CommonFields.NAME).lower() == new_item[CommonFields.NAME].lower():
                        raise UserFeedbackError(
                            t(DEFAULT_LOCALE, 'config-error-item-exists-new-char', **{'itemName': new_item[CommonFields.NAME]}),
                            message_id='config-error-item-exists-new-char'
                        )
                shop_stock.append(new_item)

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.NEW_CHARACTER_SHOP,
                query={CommonFields.ID: guild_id},
                update_data={'$set': {ShopFields.SHOP_STOCK: shop_stock}}
            )

            self.calling_view.update_stock(shop_stock)
            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class NewCharacterShopJSONModal(LocaleModal):
    def __init__(self, calling_view):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-upload-new-char-json'),
            timeout=600
        )
        self.calling_view = calling_view

        self.shop_json_file_upload = discord.ui.FileUpload(
            custom_id='shop_json_file_upload'
        )
        self.upload_label = Label(
            text=t(DEFAULT_LOCALE, 'config-modal-label-upload-json'),
            component=self.shop_json_file_upload
        )
        self.add_item(self.upload_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id

            if not self.shop_json_file_upload.values:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-no-json-uploaded-short'),
                    message_id='config-error-no-json-uploaded-short'
                )

            uploaded_file = self.shop_json_file_upload.values[0]
            if not uploaded_file.filename.endswith('.json'):
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-file-must-be-json'),
                    message_id='config-error-file-must-be-json'
                )

            file_bytes = await uploaded_file.read()
            file_content = file_bytes.decode('utf-8')

            try:
                shop_data = json.loads(file_content)
            except json.JSONDecodeError as jde:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-invalid-json', **{'error': str(jde)}),
                    message_id='config-error-invalid-json'
                )

            if ShopFields.SHOP_STOCK not in shop_data or not isinstance(shop_data[ShopFields.SHOP_STOCK], list):
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-json-must-have-shopstock'),
                    message_id='config-error-json-must-have-shopstock'
                )

            for item in shop_data[ShopFields.SHOP_STOCK]:
                if CommonFields.NAME not in item or 'price' not in item:
                    raise UserFeedbackError(
                        t(DEFAULT_LOCALE, 'config-error-items-must-have-name-price'),
                        message_id='config-error-items-must-have-name-price'
                    )

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.NEW_CHARACTER_SHOP,
                query={CommonFields.ID: guild_id},
                update_data={'$set': {ShopFields.SHOP_STOCK: shop_data[ShopFields.SHOP_STOCK]}}
            )

            self.calling_view.update_stock(shop_data[ShopFields.SHOP_STOCK])
            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ConfigNewCharacterWealthModal(LocaleModal):
    def __init__(self, calling_view, current_amount=None, current_currency=None):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-set-wealth'),
            timeout=600
        )
        self.amount_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-amount'),
            custom_id='amount_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-amount'),
            default=current_amount if current_amount is not None else ''
        )
        self.currency_name_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-currency-name'),
            custom_id='currency_name_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-currency-name'),
            default=current_currency or ''
        )
        self.calling_view = calling_view
        self.add_item(self.amount_text_input)
        self.add_item(self.currency_name_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id

            if not self.amount_text_input.value.replace('.', '', 1).isdigit():
                raise ValueError('Amount must be a number.')
            amount = float(self.amount_text_input.value)

            if amount <= 0:
                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name=DatabaseCollections.INVENTORY_CONFIG,
                    query={CommonFields.ID: guild_id},
                    update_data={'$unset': {ConfigFields.NEW_CHARACTER_WEALTH: ''}}
                )
            else:
                currency_input = self.currency_name_text_input.value.strip()
                currency_config = await get_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name=DatabaseCollections.CURRENCY,
                    query={CommonFields.ID: guild_id}
                )

                if not currency_config:
                    raise UserFeedbackError(
                        t(DEFAULT_LOCALE, 'config-error-no-currencies-configured'),
                        message_id='config-error-no-currencies-configured'
                    )

                found_name, parent_name = find_currency_or_denomination(currency_config, currency_input)

                if not found_name:
                    raise UserFeedbackError(
                        t(DEFAULT_LOCALE, 'config-error-currency-not-found', **{'name': currency_input}),
                        message_id='config-error-currency-not-found'
                    )

                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name=DatabaseCollections.INVENTORY_CONFIG,
                    query={CommonFields.ID: guild_id},
                    update_data={'$set': {ConfigFields.NEW_CHARACTER_WEALTH: {CharacterFields.CURRENCY: found_name, CommonFields.AMOUNT: amount}}}
                )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class CreateStaticKitModal(LocaleModal):
    def __init__(self, calling_view):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-create-kit'),
            timeout=600
        )
        self.calling_view = calling_view

        self.kit_name_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-kit-name'),
            custom_id='kit_name_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-kit-name'),
            max_length=50
        )
        self.kit_description_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-description'),
            style=discord.TextStyle.paragraph,
            custom_id='kit_description_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-kit-description'),
            required=False,
            max_length=200
        )
        self.add_item(self.kit_name_text_input)
        self.add_item(self.kit_description_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            kit_id = str(shortuuid.uuid()[:8])
            kit_name = self.kit_name_text_input.value.strip()

            kit_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.STATIC_KITS,
                query={CommonFields.ID: guild_id}
            )
            existing_kits = kit_query.get('kits', {}) if kit_query else {}
            if existing_kits:
                for kit_data in existing_kits.values():
                    if kit_name.lower() == kit_data[CommonFields.NAME].lower():
                        raise UserFeedbackError(
                            t(DEFAULT_LOCALE, 'config-error-kit-name-exists', **{'kitName': titlecase(kit_name)}),
                            message_id='config-error-kit-name-exists'
                        )

            kit_data = {
                CommonFields.NAME: titlecase(kit_name),
                'description': self.kit_description_text_input.value.strip(),
                CommonFields.ITEMS: [],
                CharacterFields.CURRENCY: {}
            }

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.STATIC_KITS,
                query={CommonFields.ID: guild_id},
                update_data={'$set': {f'kits.{kit_id}': kit_data}}
            )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class StaticKitItemModal(LocaleModal):
    def __init__(self, calling_view, existing_item=None, index=None):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-kit-item'),
            timeout=600
        )
        self.calling_view = calling_view
        self.index = index

        name_default = existing_item.get(CommonFields.NAME, '') if existing_item else ''
        description_default = existing_item.get('description', '') if existing_item else ''
        quantity_default = str(existing_item.get(CommonFields.QUANTITY, '1')) if existing_item else '1'

        self.item_name_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-item-name'),
            custom_id='item_name_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-item-name'),
            default=name_default
        )
        self.description_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-item-description'),
            style=discord.TextStyle.paragraph,
            custom_id='item_description_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-item-description'),
            default=description_default,
            required=False
        )
        self.item_quantity_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-item-quantity'),
            custom_id='item_quantity_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-kit-item-quantity'),
            default=quantity_default
        )
        self.add_item(self.item_name_text_input)
        self.add_item(self.description_text_input)
        self.add_item(self.item_quantity_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            if not self.item_quantity_text_input.value.isdigit() or int(self.item_quantity_text_input.value) < 1:
                raise ValueError("Quantity must be a positive integer.")

            item_data = {
                CommonFields.NAME: self.item_name_text_input.value,
                'description': self.description_text_input.value,
                CommonFields.QUANTITY: int(self.item_quantity_text_input.value)
            }

            bot = interaction.client
            kit_id = self.calling_view.kit_id

            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.STATIC_KITS,
                query={CommonFields.ID: interaction.guild_id}
            )
            kits = query.get('kits', {})
            current_kit = kits.get(kit_id)

            if not current_kit:
                raise Exception("Kit not found.")

            items = current_kit.get(CommonFields.ITEMS, [])

            if self.index is not None:
                items[self.index] = item_data
            else:
                items.append(item_data)

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.STATIC_KITS,
                query={CommonFields.ID: interaction.guild_id},
                update_data={'$set': {f'kits.{kit_id}.items': items}}
            )

            self.calling_view.kit_data[CommonFields.ITEMS] = items
            self.calling_view.items = items
            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class StaticKitCurrencyModal(LocaleModal):
    def __init__(self, calling_view):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-kit-currency'),
            timeout=600
        )
        self.calling_view = calling_view
        self.currency_name_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-currency-name'),
            custom_id='currency_name_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-currency-eg')
        )
        self.amount_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-amount'),
            custom_id='amount_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-amount-eg')
        )
        self.add_item(self.currency_name_text_input)
        self.add_item(self.amount_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            currency_input = self.currency_name_text_input.value.strip()
            if not self.amount_text_input.value.replace('.', '', 1).isdigit():
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-amount-must-be-number'),
                    message_id='config-error-amount-must-be-number'
                )
            amount = float(self.amount_text_input.value)

            currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: interaction.guild_id}
            )
            if not currency_config:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-no-currencies-on-server'),
                    message_id='config-error-no-currencies-on-server'
                )

            denomination_map, parent_name = get_denomination_map(currency_config, currency_input)

            if not denomination_map:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-currency-not-found-short', **{'currency': currency_input}),
                    message_id='config-error-currency-not-found-short'
                )

            multiplier = denomination_map.get(currency_input.lower())
            if multiplier is None:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-denomination-not-found', **{'denomination': currency_input}),
                    message_id='config-error-denomination-not-found'
                )

            converted_amount = amount * multiplier

            kit_id = self.calling_view.kit_id

            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.STATIC_KITS,
                query={CommonFields.ID: interaction.guild_id}
            )

            existing_amount = 0

            encoded_currency = encode_mongo_key(parent_name)
            if query and 'kits' in query:
                existing_amount = query['kits'].get(kit_id, {}).get(CharacterFields.CURRENCY, {}).get(encoded_currency, 0)

            final_amount = existing_amount + converted_amount

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.STATIC_KITS,
                query={CommonFields.ID: interaction.guild_id},
                update_data={'$set': {f'kits.{kit_id}.currency.{encoded_currency}': final_amount}}
            )

            if CharacterFields.CURRENCY not in self.calling_view.kit_data:
                self.calling_view.kit_data[CharacterFields.CURRENCY] = {}

            self.calling_view.kit_data[CharacterFields.CURRENCY][encoded_currency] = final_amount

            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplaySettingsModal(LocaleModal):
    def __init__(self, calling_view):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-rp-settings')
        )
        self.calling_view = calling_view
        config = calling_view.config
        mode_config = config.get(RoleplayFields.CONFIG, {})
        self.mode = config.get(RoleplayFields.MODE, 'accrued')

        self.minimum_length_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-min-message-length'),
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-min-message-length'),
            default=str(mode_config.get(RoleplayFields.MIN_LENGTH, 0)),
            max_length=4
        )
        self.add_item(self.minimum_length_text_input)

        self.cooldown_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-cooldown'),
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-cooldown'),
            default=str(mode_config.get(RoleplayFields.COOLDOWN, 30)),
            max_length=4
        )
        self.add_item(self.cooldown_text_input)

        if self.mode == 'scheduled':
            self.threshold_text_input = discord.ui.TextInput(
                label=t(DEFAULT_LOCALE, 'config-modal-label-message-threshold'),
                placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-message-threshold'),
                default=str(mode_config.get(RoleplayFields.THRESHOLD, 20)),
                max_length=4
            )
            self.add_item(self.threshold_text_input)

        elif self.mode == 'accrued':
            self.frequency_text_input = discord.ui.TextInput(
                label=t(DEFAULT_LOCALE, 'config-modal-label-frequency'),
                placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-frequency'),
                default=str(mode_config.get(RoleplayFields.FREQUENCY, 20)),
                max_length=4
            )
            self.add_item(self.frequency_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            new_config = self.calling_view.config.get(RoleplayFields.CONFIG, {})

            # Minimum Length
            try:
                minimum_length = int(self.minimum_length_text_input.value)
                if minimum_length < 0:
                    raise ValueError
            except ValueError:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-min-length-invalid'),
                    message_id='config-error-min-length-invalid'
                )

            new_config[RoleplayFields.MIN_LENGTH] = minimum_length

            # Cooldown
            try:
                cooldown_seconds = int(self.cooldown_text_input.value)
                if cooldown_seconds < 0:
                    raise ValueError
            except ValueError:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-cooldown-invalid'),
                    message_id='config-error-cooldown-invalid'
                )

            new_config[RoleplayFields.COOLDOWN] = cooldown_seconds

            # Validate and add scheduled settings
            if self.mode == 'scheduled':
                try:
                    threshold = int(self.threshold_text_input.value)
                    if threshold < 1:
                        raise ValueError
                except ValueError:
                    raise UserFeedbackError(
                        t(DEFAULT_LOCALE, 'config-error-threshold-invalid'),
                        message_id='config-error-threshold-invalid'
                    )

                new_config[RoleplayFields.THRESHOLD] = threshold

            # Validate and add accrued settings
            elif self.mode == 'accrued':
                try:
                    frequency = int(self.frequency_text_input.value)
                    if frequency < 1:
                        raise ValueError
                except ValueError:
                    raise UserFeedbackError(
                        t(DEFAULT_LOCALE, 'config-error-frequency-invalid'),
                        message_id='config-error-frequency-invalid'
                    )

                new_config[RoleplayFields.FREQUENCY] = frequency

            # Push updates to db
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.ROLEPLAY_CONFIG,
                query={CommonFields.ID: interaction.guild_id},
                update_data={'$set': {RoleplayFields.CONFIG: new_config}}
            )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayRewardsModal(LocaleModal):
    def __init__(self, calling_view, xp_enabled):
        super().__init__(title=t(DEFAULT_LOCALE, 'config-modal-title-rp-rewards'))
        self.calling_view = calling_view
        rewards = calling_view.config.get(RoleplayFields.REWARDS, {})

        self.xp_enabled = xp_enabled
        if self.xp_enabled:
            self.experience_text_input = discord.ui.TextInput(
                label=t(DEFAULT_LOCALE, 'config-modal-label-experience'),
                default=str(rewards.get(RoleplayFields.XP, 0)),
                required=False
            )
            self.add_item(self.experience_text_input)

        item_display = ''
        if items := rewards.get(RoleplayFields.ITEMS):
            item_display = '\n'.join([f'{k}: {v}' for k, v in sorted(items.items())])

        self.items = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-items-name-quantity'),
            style=discord.TextStyle.paragraph,
            default=item_display,
            required=False
        )
        self.add_item(self.items)

        currency_display = ''
        if currency := rewards.get(RoleplayFields.CURRENCY):
            currency_config = getattr(calling_view, 'currency_config', None)
            formatted_lines = []
            for k, v in currency.items():
                if currency_config:
                    formatted_lines.append(f'{k}: {format_currency_amount(v, k, currency_config)}')
                else:
                    formatted_lines.append(f'{k}: {v}')
            currency_display = '\n'.join(formatted_lines)

        self.currency = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-currency-name-amount'),
            style=discord.TextStyle.paragraph,
            default=currency_display,
            required=False
        )
        self.add_item(self.currency)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client

            xp = 0
            if self.xp_enabled:
                try:
                    xp = int(self.experience_text_input.value.strip())
                    if xp < 0:
                        raise ValueError
                except ValueError:
                    raise UserFeedbackError(
                        t(DEFAULT_LOCALE, 'config-error-experience-non-negative'),
                        message_id='config-error-experience-non-negative'
                    )

            items = {}
            if self.items.value:
                for line in self.items.value.split('\n'):
                    if ':' in line:
                        k, v = line.split(':', 1)
                        try:
                            items[titlecase(k.strip())] = int(v.strip())
                            if int(v.strip()) < 1:
                                raise ValueError
                        except ValueError:
                            raise UserFeedbackError(
                                t(DEFAULT_LOCALE, 'config-error-item-quantity-positive-named', **{'itemName': k.strip()}),
                                message_id='config-error-item-quantity-positive-named'
                            )

            currency = {}
            if self.currency.value:
                for line in self.currency.value.split('\n'):
                    if ':' in line:
                        k, v = line.split(':', 1)
                        try:
                            currency[k.strip().lower()] = float(v.strip())
                            if float(v.strip()) <= 0:
                                raise ValueError
                        except ValueError:
                            raise UserFeedbackError(
                                t(DEFAULT_LOCALE, 'config-error-currency-amount-positive', **{'currencyName': k.strip()}),
                                message_id='config-error-currency-amount-positive'
                            )

            new_rewards = {
                RoleplayFields.XP: xp,
                RoleplayFields.ITEMS: items,
                RoleplayFields.CURRENCY: currency
            }

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.ROLEPLAY_CONFIG,
                query={CommonFields.ID: interaction.guild_id},
                update_data={'$set': {RoleplayFields.REWARDS: new_rewards}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class SetItemStockModal(LocaleModal):
    def __init__(self, calling_view, item_name: str, current_max: int | None = None,
                 current_stock: int | None = None):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-stock-limit', **{'itemName': item_name[:40]}),
            timeout=600
        )
        self.calling_view = calling_view
        self.item_name = item_name

        self.max_stock_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-max-stock'),
            custom_id='max_stock_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-max-stock'),
            default=str(current_max) if current_max is not None else '',
            required=True
        )

        # Default current stock to max if setting up for first time
        default_current = ''
        if current_stock is not None:
            default_current = str(current_stock)
        elif current_max is not None:
            default_current = str(current_max)

        self.current_stock_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-current-stock'),
            custom_id='current_stock_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-current-stock'),
            default=default_current,
            required=True
        )

        self.add_item(self.max_stock_text_input)
        self.add_item(self.current_stock_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            channel_id = self.calling_view.channel_id

            # Validate max stock
            max_stock_str = self.max_stock_text_input.value.strip()
            try:
                max_stock = int(max_stock_str)
                if max_stock < 1:
                    raise ValueError
            except ValueError:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-max-stock-positive'),
                    message_id='config-error-max-stock-positive'
                )

            # Validate current stock
            current_stock_str = self.current_stock_text_input.value.strip()
            try:
                current_stock = int(current_stock_str)
                if current_stock < 0:
                    raise ValueError
            except ValueError:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-current-stock-non-negative'),
                    message_id='config-error-current-stock-non-negative'
                )

            if current_stock > max_stock:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-current-exceeds-max'),
                    message_id='config-error-current-exceeds-max'
                )

            # Update the shop config with maxStock for this item
            shop_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={CommonFields.ID: guild_id}
            )
            shop_data = shop_query.get(ShopFields.SHOP_CHANNELS, {}).get(channel_id, {})
            shop_stock = shop_data.get(ShopFields.SHOP_STOCK, [])

            # Find and update the item
            item_found = False
            for item in shop_stock:
                if item.get(CommonFields.NAME) == self.item_name:
                    item[ShopFields.MAX_STOCK] = max_stock
                    item_found = True
                    break

            if not item_found:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-item-not-in-shop', **{'itemName': self.item_name}),
                    message_id='config-error-item-not-in-shop'
                )

            # Save shop config
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={CommonFields.ID: guild_id},
                update_data={'$set': {f'{ShopFields.SHOP_CHANNELS}.{channel_id}': shop_data}}
            )

            # Initialize/update the runtime stock tracking
            await initialize_item_stock(bot, guild_id, channel_id, self.item_name, max_stock, current_stock)

            # Refresh the view
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RestockScheduleModal(LocaleModal):
    def __init__(self, calling_view, current_config: dict | None = None):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'config-modal-title-restock-schedule'),
            timeout=600
        )
        self.calling_view = calling_view

        # Get current UTC time for display
        now = datetime.now(timezone.utc)
        utc_time_str = now.strftime('%Y-%m-%d %H:%M UTC')

        current_config = current_config or {}
        schedule = current_config.get(RestockFields.SCHEDULE, '')
        hour = current_config.get(RestockFields.HOUR, 0)
        minute = current_config.get(RestockFields.MINUTE, 0)
        day = current_config.get(RestockFields.DAY_OF_WEEK, 0)
        mode = current_config.get(RestockFields.MODE, RestockMode.FULL.value)
        increment = current_config.get(RestockFields.INCREMENT_AMOUNT, 1)

        self.schedule_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-schedule'),
            custom_id='schedule_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-schedule'),
            default=schedule if schedule else 'none',
            required=True
        )

        self.time_text_input = discord.ui.TextInput(
            custom_id='time_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-time'),
            default=f'{hour:02d}:{minute:02d}',
            required=False
        )

        self.time_label = Label(
            text=t(DEFAULT_LOCALE, 'config-modal-label-time'),
            description=t(DEFAULT_LOCALE, 'config-modal-desc-current-time', **{'utcTime': utc_time_str}),
            component=self.time_text_input
        )

        self.day_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-day-of-week'),
            custom_id='day_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-day-of-week'),
            default=str(day),
            required=False
        )

        self.mode_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-mode'),
            custom_id='mode_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-mode'),
            default=mode,
            required=True
        )

        self.increment_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'config-modal-label-increment'),
            custom_id='increment_text_input',
            placeholder=t(DEFAULT_LOCALE, 'config-modal-placeholder-increment'),
            default=str(increment),
            required=False
        )

        self.add_item(self.schedule_text_input)
        self.add_item(self.time_label)
        self.add_item(self.day_text_input)
        self.add_item(self.mode_text_input)
        self.add_item(self.increment_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            channel_id = self.calling_view.channel_id

            schedule = self.schedule_text_input.value.strip().lower()
            valid_schedules = [s.value for s in ScheduleType] + ['none', '']
            if schedule not in valid_schedules:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-schedule-invalid'),
                    message_id='config-error-schedule-invalid'
                )

            # Parse time
            hour, minute = 0, 0
            time_str = self.time_text_input.value.strip()
            if time_str and schedule not in ['none', '']:
                try:
                    parts = time_str.split(':')
                    hour = int(parts[0])
                    minute = int(parts[1]) if len(parts) > 1 else 0
                    if not (0 <= hour <= 23 and 0 <= minute <= 59):
                        raise ValueError
                except (ValueError, IndexError):
                    raise UserFeedbackError(
                        t(DEFAULT_LOCALE, 'config-error-time-format-invalid'),
                        message_id='config-error-time-format-invalid'
                    )

            # Parse day of week
            day = 0
            if schedule == ScheduleType.WEEKLY.value:
                day_str = self.day_text_input.value.strip()
                try:
                    day = int(day_str)
                    if not (0 <= day <= 6):
                        raise ValueError
                except ValueError:
                    raise UserFeedbackError(
                        t(DEFAULT_LOCALE, 'config-error-day-of-week-invalid'),
                        message_id='config-error-day-of-week-invalid'
                    )

            # Parse mode
            mode = self.mode_text_input.value.strip().lower()
            valid_modes = [m.value for m in RestockMode]
            if mode not in valid_modes:
                raise UserFeedbackError(
                    t(DEFAULT_LOCALE, 'config-error-mode-invalid'),
                    message_id='config-error-mode-invalid'
                )

            # Parse increment amount
            increment_amount = 1
            if mode == RestockMode.INCREMENTAL.value:
                increment_str = self.increment_text_input.value.strip()
                if increment_str:
                    try:
                        increment_amount = int(increment_str)
                        if increment_amount < 1:
                            raise ValueError
                    except ValueError:
                        raise UserFeedbackError(
                            t(DEFAULT_LOCALE, 'config-error-increment-positive'),
                            message_id='config-error-increment-positive'
                        )

            # Build restock config
            if schedule in ['none', '']:
                restock_config = {RestockFields.ENABLED: False}
            else:
                restock_config = {
                    RestockFields.ENABLED: True,
                    RestockFields.SCHEDULE: schedule,
                    RestockFields.HOUR: hour,
                    RestockFields.MINUTE: minute,
                    RestockFields.DAY_OF_WEEK: day,
                    RestockFields.MODE: mode,
                    RestockFields.INCREMENT_AMOUNT: increment_amount
                }

            # Update shop config
            shop_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={CommonFields.ID: guild_id}
            )
            shop_data = shop_query.get(ShopFields.SHOP_CHANNELS, {}).get(channel_id, {})
            shop_data[ShopFields.RESTOCK_CONFIG] = restock_config

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.SHOPS,
                query={CommonFields.ID: guild_id},
                update_data={'$set': {f'{ShopFields.SHOP_CHANNELS}.{channel_id}': shop_data}}
            )

            # Refresh the view
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)
