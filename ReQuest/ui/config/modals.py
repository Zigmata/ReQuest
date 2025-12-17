import datetime
import json
import logging
from titlecase import titlecase

import jsonschema
import shortuuid
from jsonschema import validate

import discord
import discord.ui
from discord.ui import Modal, Label

from ReQuest.utilities.supportFunctions import (
    log_exception,
    setup_view,
    find_currency_or_denomination,
    get_cached_data,
    get_denomination_map,
    update_cached_data,
    UserFeedbackError,
    delete_cached_data,
    strip_id, get_xp_config
)

logger = logging.getLogger(__name__)

SHOP_SCHEMA = {
    "type": "object",
    "properties": {
        "shopName": {"type": "string"},
        "shopKeeper": {"type": "string"},
        "shopDescription": {"type": "string"},
        "shopImage": {"type": "string", "format": "uri"},
        "shopStock": {
            "type": "array",
            "items": {
                "type": "object",
                "properties": {
                    "name": {"type": "string"},
                    "description": {"type": "string"},
                    "price": {"type": "number"},
                    "quantity": {"type": "integer", "minimum": 1},
                    "currency": {"type": "string"}
                },
                "required": ["name", "price", "currency"]
            }
        }
    },
    "required": ["shopName", "shopStock"]
}


class AddCurrencyTextModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Add New Currency',
            timeout=180
        )
        self.calling_view = calling_view
        self.text_input = discord.ui.TextInput(
            label='Currency Name',
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
                collection_name='currency',
                query={'_id': guild_id}
            )
            matches = 0
            if query:
                for currency in query['currencies']:
                    if currency['name'].lower() == self.text_input.value.lower():
                        matches += 1
                    if currency['denominations'] and len(currency['denominations']) > 0:
                        for denomination in currency['denominations']:
                            if denomination['name'].lower() == self.text_input.value.lower():
                                matches += 1

            if matches > 0:
                await interaction.response.defer(ephemeral=True, thinking=True)
                await interaction.followup.send(f'A currency or denomination named {self.text_input.value} '
                                                f'already exists!')
            else:
                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name='currency',
                    query={'_id': guild_id},
                    update_data={'$push': {'currencies': {'name': self.text_input.value,
                                                          'isDouble': False, 'denominations': []}}}
                )
                await setup_view(view, interaction)
                await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class AddCurrencyDenominationModal(Modal):
    def __init__(self, calling_view, base_currency_name):
        super().__init__(
            title=f'Add {base_currency_name} Denomination',
            timeout=300
        )
        self.calling_view = calling_view
        self.base_currency_name = base_currency_name

        self.denomination_name_text_input = discord.ui.TextInput(
            label='Name',
            placeholder='e.g., Silver',
            custom_id='denomination_name_text_input'
        )
        self.denomination_value_text_input = discord.ui.TextInput(
            label='Value',
            placeholder='e.g., 0.1',
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
                collection_name='currency',
                query={'_id': guild_id}
            )
            for currency in query['currencies']:
                if new_name.lower() == currency['name'].lower():
                    raise UserFeedbackError(
                        f'New denomination name cannot match an existing currency on this server! Found existing '
                        f'currency named \"{currency['name']}\".'
                    )
                for denomination in currency['denominations']:
                    if new_name.lower() == denomination['name'].lower():
                        raise UserFeedbackError(
                            f'New denomination name cannot match an existing denomination on this server! Found '
                            f'existing denomination named \"{denomination['name']}\" under the currency named '
                            f'\"{currency['name']}\".'
                        )
            base_currency = next((item for item in query['currencies'] if item['name'] == self.base_currency_name),
                                 None)
            if base_currency:
                for denomination in base_currency['denominations']:
                    if float(self.denomination_value_text_input.value) == denomination['value']:
                        using_name = denomination['name']
                        raise UserFeedbackError(
                            f'Denominations under a single currency must have unique values! {using_name} already has '
                            f'this value assigned.'
                        )

                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name='currency',
                    query={'_id': guild_id, 'currencies.name': self.base_currency_name},
                    update_data={
                        '$push': {'currencies.$.denominations': {
                            'name': new_name,
                            'value': float(self.denomination_value_text_input.value)}
                        }
                    }
                )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ForbiddenRolesModal(Modal):
    def __init__(self, current_list):
        super().__init__(
            title='Forbidden Role Names',
            timeout=600
        )
        self.names_text_input = discord.ui.TextInput(
            label='Names',
            style=discord.TextStyle.paragraph,
            placeholder='Input names separated by commas',
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
                collection_name='forbiddenRoles',
                query={'_id': interaction.guild_id},
                update_data={'$set': {'forbiddenRoles': names}}
            )
            await interaction.response.send_message('Forbidden roles updated!', ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


class PlayerBoardPurgeModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Purge Player Board',
            timeout=600
        )
        self.calling_view = calling_view
        self.age_text_input = discord.ui.TextInput(
            label='Age',
            custom_id='age_text_input',
            placeholder='Enter the maximum post age (in days) to keep'
        )
        self.add_item(self.age_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            age = int(self.age_text_input.value)

            # Get the current datetime and calculate the cutoff date
            current_datetime = datetime.datetime.now(datetime.UTC)
            cutoff_date = current_datetime - datetime.timedelta(days=age)

            # Delete all records in the db matching this guild that are older than the cutoff
            await delete_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='playerBoard',
                search_filter={'guildId': interaction.guild_id, 'timestamp': {'$lt': cutoff_date}},
                is_single=False,
                cache_id=interaction.guild_id
            )

            # Get the channel object and purge all messages older than the cutoff
            config_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='playerBoardChannel',
                query={'_id': interaction.guild_id}
            )
            channel_id = strip_id(config_query['playerBoardChannel'])
            channel = interaction.guild.get_channel(channel_id)
            await channel.purge(before=cutoff_date)

            await interaction.response.send_message(f'Posts older than {age} days have been purged!',
                                                    ephemeral=True,
                                                    delete_after=10)
        except Exception as e:
            await log_exception(e, interaction)


class GMRewardsModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Add/Modify GM Rewards',
            timeout=600
        )
        self.calling_view = calling_view
        current_rewards = calling_view.current_rewards
        self.xp_enabled = getattr(calling_view, 'xp_enabled', True)

        if self.xp_enabled:
            self.experience_text_input = discord.ui.TextInput(
                label='Experience',
                custom_id='experience_text_input',
                placeholder='Enter a number',
                default=current_rewards['experience'] if current_rewards and current_rewards['experience'] else None,
                required=False
            )
            self.add_item(self.experience_text_input)

        self.items_text_input = discord.ui.TextInput(
            label='Items',
            style=discord.TextStyle.paragraph,
            custom_id='items_text_input',
            placeholder='Name: Quantity\n'
                        'Name2: Quantity\n'
                        'etc.',
            default=(self.parse_items_to_string(current_rewards['items'])
                     if current_rewards and current_rewards['items']
                     else None),
            required=False
        )
        self.add_item(self.items_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            experience = None
            if self.xp_enabled and hasattr(self, 'experience_text_input') and self.experience_text_input.value:
                experience = int(self.experience_text_input.value)

            items = None
            if self.items_text_input.value:
                items = {}
                for item in self.items_text_input.value.strip().split('\n'):
                    item_name, quantity = item.split(':', 1)
                    items[titlecase(item_name.strip())] = int(quantity.strip())

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='gmRewards',
                query={'_id': interaction.guild_id},
                update_data={'$set': {'experience': experience, 'items': items}}
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


class ConfigShopDetailsModal(Modal):
    def __init__(self, calling_view, existing_shop_data=None, existing_channel_id=None):
        super().__init__(
            title='Add/Edit Shop Details',
            timeout=600
        )
        self.calling_view = calling_view
        self.existing_channel_id = existing_channel_id

        self.shop_channel_select = None

        name_default = existing_shop_data.get('shopName', '') if existing_shop_data else ''
        keeper_default = existing_shop_data.get('shopKeeper', '') if existing_shop_data else ''
        description_default = existing_shop_data.get('shopDescription', '') if existing_shop_data else ''
        image_default = existing_shop_data.get('shopImage', '') if existing_shop_data else ''

        if not self.existing_channel_id:
            self.shop_channel_select = discord.ui.ChannelSelect(
                channel_types=[discord.ChannelType.text],
                placeholder='Select the channel for this shop',
                custom_id='shop_channel_select',
                required=True
            )
            self.channel_label = Label(
                text='Select a channel',
                component=self.shop_channel_select
            )
            self.add_item(self.channel_label)
        self.shop_name_text_input = discord.ui.TextInput(
            label='Shop Name',
            custom_id='shop_name_text_input',
            placeholder='Enter the name of the shop',
            default=name_default,
            required=True
        )
        self.shop_keeper_text_input = discord.ui.TextInput(
            label='Shopkeeper Name',
            custom_id='shop_keeper_text_input',
            placeholder='Enter the name of the shopkeeper',
            default=keeper_default,
            required=False
        )
        self.shop_description_text_input = discord.ui.TextInput(
            label='Shop Description',
            style=discord.TextStyle.paragraph,
            custom_id='shop_description_text_input',
            placeholder='Enter a description for the shop',
            default=description_default,
            required=False
        )
        self.shop_image_text_input = discord.ui.TextInput(
            label='Shop Image URL',
            custom_id='shop_image_text_input',
            placeholder='Enter a URL for the shop image',
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
            else:
                if not self.shop_channel_select or not self.shop_channel_select.values:
                    raise UserFeedbackError('No channel selected for the shop.')
                channel_id = str(self.shop_channel_select.values[0].id)

            if not self.existing_channel_id:
                query = await get_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name='shops',
                    query={'_id': guild_id}
                )
                if query and channel_id in query.get('shopChannels', {}):
                    raise UserFeedbackError(
                        'A shop is already registered in the selected channel. Please choose a different channel or '
                        'edit the existing shop.'
                    )

            shop_data = {
                'shopName': self.shop_name_text_input.value,
                'shopKeeper': self.shop_keeper_text_input.value,
                'shopDescription': self.shop_description_text_input.value,
                'shopImage': self.shop_image_text_input.value,
                'shopStock': []
            }

            if self.existing_channel_id:
                existing_query = await get_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name='shops',
                    query={'_id': guild_id}
                )
                existing_shop_data = existing_query.get('shopChannels', {}).get(channel_id, {})
                shop_data['shopStock'] = existing_shop_data.get('shopStock', [])

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='shops',
                query={'_id': guild_id},
                update_data={'$set': {f'shopChannels.{channel_id}': shop_data}}
            )

            if hasattr(self.calling_view, 'update_details'):
                self.calling_view.update_details(shop_data)
                self.calling_view.build_view()
                await interaction.response.edit_message(view=self.calling_view)
            else:
                await interaction.response.defer()
        except Exception as e:
            await log_exception(e, interaction)


class ConfigShopJSONModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Add New Shop via JSON',
            timeout=600
        )
        self.calling_view = calling_view

        self.shop_channel_select = discord.ui.ChannelSelect(
            channel_types=[discord.ChannelType.text],
            placeholder='Select the channel for this shop',
            custom_id='shop_channel_select'
        )
        self.shop_json_file_upload = discord.ui.FileUpload(
            custom_id='shop_json_file_upload'
        )
        self.select_label = Label(
            text='Select a channel',
            component=self.shop_channel_select
        )
        self.upload_label = Label(
            text='Upload a .json file containing the shop data',
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
                collection_name='shops',
                query={'_id': guild_id}
            )
            if query and channel_id in query.get('shopChannels', {}):
                raise UserFeedbackError(
                    'A shop is already registered in the selected channel. Please choose a different channel or edit '
                    'the existing shop.'
                )

            if not self.shop_json_file_upload.values:
                raise UserFeedbackError('No JSON file uploaded for the shop.')

            uploaded_file = self.shop_json_file_upload.values[0]
            if not uploaded_file.filename.endswith('.json'):
                raise UserFeedbackError('Uploaded file must be a JSON file (.json).')

            file_bytes = await uploaded_file.read()

            file_content = file_bytes.decode('utf-8')

            try:
                shop_data = json.loads(file_content)
            except json.JSONDecodeError as jde:
                raise UserFeedbackError(f'Invalid JSON format: {str(jde)}')

            try:
                validate(instance=shop_data, schema=SHOP_SCHEMA)
            except jsonschema.exceptions.ValidationError as ve:
                raise UserFeedbackError(f'JSON does not conform to schema: {str(ve)}')

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='shops',
                query={'_id': guild_id},
                update_data={'$set': {f'shopChannels.{channel_id}': shop_data}}
            )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ShopItemModal(Modal):
    def __init__(self, calling_view, existing_item=None):
        super().__init__(
            title='Add/Edit Shop Item',
            timeout=600
        )
        self.calling_view = calling_view
        self.existing_item_name = existing_item.get('name') if existing_item else None

        name_default = existing_item.get('name', '') if existing_item else ''
        description_default = existing_item.get('description', '') if existing_item else ''
        price_default = str(existing_item.get('price', '')) if existing_item else ''
        quantity_default = str(existing_item.get('quantity', '1')) if existing_item else '1'
        currency_default = existing_item.get('currency', '') if existing_item else ''

        self.item_name_text_input = discord.ui.TextInput(
            label='Item Name',
            custom_id='item_name_text_input',
            placeholder='Enter the name of the item',
            default=name_default
        )
        self.item_description_text_input = discord.ui.TextInput(
            label='Item Description',
            style=discord.TextStyle.paragraph,
            custom_id='item_description_text_input',
            placeholder='Enter a description for the item',
            default=description_default,
            required=False
        )
        self.item_price_text_input = discord.ui.TextInput(
            label='Item Price',
            custom_id='item_price_text_input',
            placeholder='Enter the price of the item',
            default=price_default
        )
        self.item_quantity_text_input = discord.ui.TextInput(
            label='Item Quantity',
            custom_id='item_quantity_text_input',
            placeholder='Enter the quantity sold per purchase',
            default=quantity_default,
            required=False
        )
        self.item_currency_text_input = discord.ui.TextInput(
            label='Currency',
            custom_id='item_currency_text_input',
            placeholder='Enter the currency for the item price',
            default=currency_default
        )
        self.add_item(self.item_name_text_input)
        self.add_item(self.item_description_text_input)
        self.add_item(self.item_price_text_input)
        self.add_item(self.item_quantity_text_input)
        self.add_item(self.item_currency_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            view = self.calling_view
            channel_id = view.channel_id

            quantity_str = self.item_quantity_text_input.value
            if not quantity_str.isdigit() or int(quantity_str) < 1:
                raise UserFeedbackError('Item quantity must be a positive integer.')

            price_str = self.item_price_text_input.value
            if not price_str.isdigit() or int(price_str) < 0:
                raise UserFeedbackError('Item price must be a non-negative integer.')

            new_item = {
                'name': self.item_name_text_input.value,
                'description': self.item_description_text_input.value,
                'price': int(self.item_price_text_input.value),
                'quantity': int(self.item_quantity_text_input.value),
                'currency': self.item_currency_text_input.value.lower()
            }

            shop_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='shops',
                query={'_id': guild_id}
            )
            shop_data = shop_query.get('shopChannels', {}).get(channel_id, {})
            shop_stock = shop_data.get('shopStock', [])

            if self.existing_item_name:
                new_stock = []
                found = False
                for item in shop_stock:
                    if item.get('name') == self.existing_item_name:
                        new_stock.append(new_item)
                        found = True
                    else:
                        new_stock.append(item)
                if not found:
                    raise Exception('Existing item not found in shop stock.')
                shop_data['shopStock'] = new_stock
            else:
                for item in shop_stock:
                    if item.get('name').lower() == new_item['name'].lower():
                        raise UserFeedbackError(f'An item named {new_item["name"]} already exists in this shop.')
                shop_data['shopStock'].append(new_item)

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='shops',
                query={'_id': guild_id},
                update_data={'$set': {f'shopChannels.{channel_id}': shop_data}}
            )

            self.calling_view.update_stock(shop_data['shopStock'])
            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ConfigUpdateShopJSONModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Update Shop via JSON',
            timeout=600
        )
        self.calling_view = calling_view

        self.shop_json_file_upload = discord.ui.FileUpload(
            max_values=1,
            custom_id='shop_json_file_upload',
            required=True
        )
        self.upload_label = Label(
            text=f"Upload new JSON definition",
            component=self.shop_json_file_upload
        )
        self.add_item(self.upload_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id
            channel_id = self.calling_view.selected_channel_id

            if not self.shop_json_file_upload.values:
                raise UserFeedbackError("No file was uploaded.")

            uploaded_file = self.shop_json_file_upload.values[0]
            if not uploaded_file.filename.endswith('.json'):
                raise UserFeedbackError("File must be a `.json` file.")

            file_bytes = await uploaded_file.read()
            file_content = file_bytes.decode('utf-8')

            try:
                shop_data = json.loads(file_content)
            except json.JSONDecodeError as jde:
                raise UserFeedbackError(f'Invalid JSON format: {str(jde)}')

            try:
                validate(instance=shop_data, schema=SHOP_SCHEMA)
            except jsonschema.exceptions.ValidationError as err:
                raise UserFeedbackError(f"JSON validation failed: {err.message}")

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='shops',
                query={'_id': guild_id},
                update_data={'$set': {f'shopChannels.{channel_id}': shop_data}}
            )

            if hasattr(self.calling_view, 'update_details'):
                self.calling_view.update_details(shop_data)
                self.calling_view.build_view()
                await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class NewCharacterShopItemModal(Modal):
    def __init__(self, calling_view, existing_item=None):
        super().__init__(
            title='Add/Edit NewCharacter Gear',
            timeout=600
        )
        self.calling_view = calling_view
        self.existing_item_name = existing_item.get('name') if existing_item else None

        name_default = existing_item.get('name', '') if existing_item else ''
        description_default = existing_item.get('description', '') if existing_item else ''
        price_default = str(existing_item.get('price', '0')) if existing_item else '0'
        quantity_default = str(existing_item.get('quantity', '1')) if existing_item else '1'
        currency_default = existing_item.get('currency', '') if existing_item else ''

        self.item_name_text_input = discord.ui.TextInput(
            label='Item Name',
            custom_id='item_name_text_input',
            placeholder='Enter the name of the item',
            default=name_default
        )
        self.item_description_text_input = discord.ui.TextInput(
            label='Item Description',
            style=discord.TextStyle.paragraph,
            custom_id='item_description_text_input',
            placeholder='Enter a description for the item',
            default=description_default,
            required=False
        )
        self.item_price_text_input = discord.ui.TextInput(
            label='Item Price',
            custom_id='item_price_text_input',
            placeholder='Enter the price (0 for free/selection)',
            default=price_default
        )
        self.item_quantity_text_input = discord.ui.TextInput(
            label='Item Quantity',
            custom_id='item_quantity_text_input',
            placeholder='Enter the quantity received per selection',
            default=quantity_default,
            required=False
        )
        self.item_currency_text_input = discord.ui.TextInput(
            label='Currency (Optional)',
            custom_id='item_currency_text_input',
            placeholder='Required if price > 0',
            default=currency_default,
            required=False
        )
        self.add_item(self.item_name_text_input)
        self.add_item(self.item_description_text_input)
        self.add_item(self.item_price_text_input)
        self.add_item(self.item_quantity_text_input)
        self.add_item(self.item_currency_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id

            quantity_string = self.item_quantity_text_input.value
            if not quantity_string.isdigit() or int(quantity_string) < 1:
                raise UserFeedbackError('Item quantity must be a positive integer.')

            price_str = self.item_price_text_input.value
            try:
                price_value = float(price_str)
                if price_value < 0:
                    raise UserFeedbackError('Item price must be a non-negative number.')
            except ValueError:
                raise UserFeedbackError('Item price must be a non-negative number.')

            currency_val = self.item_currency_text_input.value.lower()
            if int(price_str) > 0 and not currency_val:
                raise UserFeedbackError('Currency is required if price is greater than 0.')

            new_item = {
                'name': self.item_name_text_input.value,
                'description': self.item_description_text_input.value,
                'price': int(self.item_price_text_input.value),
                'quantity': int(self.item_quantity_text_input.value),
                'currency': currency_val
            }

            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='newCharacterShop',
                query={'_id': guild_id}
            )
            shop_stock = query.get('shopStock', []) if query else []

            if self.existing_item_name:
                new_stock = []
                found = False
                for item in shop_stock:
                    if item.get('name') == self.existing_item_name:
                        new_stock.append(new_item)
                        found = True
                    else:
                        new_stock.append(item)
                if not found:
                    raise Exception('Existing item not found in shop stock.')
                shop_stock = new_stock
            else:
                for item in shop_stock:
                    if item.get('name').lower() == new_item['name'].lower():
                        raise UserFeedbackError(
                            f'An item named {new_item["name"]} already exists in the New Character shop.'
                        )
                shop_stock.append(new_item)

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='newCharacterShop',
                query={'_id': guild_id},
                update_data={'$set': {'shopStock': shop_stock}}
            )

            self.calling_view.update_stock(shop_stock)
            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class NewCharacterShopJSONModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Upload New Character Shop (JSON)',
            timeout=600
        )
        self.calling_view = calling_view

        self.shop_json_file_upload = discord.ui.FileUpload(
            custom_id='shop_json_file_upload'
        )
        self.upload_label = Label(
            text='Upload a .json file containing the shop data',
            component=self.shop_json_file_upload
        )
        self.add_item(self.upload_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            guild_id = interaction.guild_id

            if not self.shop_json_file_upload.values:
                raise UserFeedbackError('No JSON file uploaded.')

            uploaded_file = self.shop_json_file_upload.values[0]
            if not uploaded_file.filename.endswith('.json'):
                raise UserFeedbackError('Uploaded file must be a JSON file (.json).')

            file_bytes = await uploaded_file.read()
            file_content = file_bytes.decode('utf-8')

            try:
                shop_data = json.loads(file_content)
            except json.JSONDecodeError as jde:
                raise UserFeedbackError(f'Invalid JSON format: {str(jde)}')

            if 'shopStock' not in shop_data or not isinstance(shop_data['shopStock'], list):
                raise UserFeedbackError("JSON must contain a 'shopStock' array.")

            for item in shop_data['shopStock']:
                if 'name' not in item or 'price' not in item:
                    raise UserFeedbackError("All items must have 'name' and 'price'.")

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='newCharacterShop',
                query={'_id': guild_id},
                update_data={'$set': {'shopStock': shop_data['shopStock']}}
            )

            self.calling_view.update_stock(shop_data['shopStock'])
            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ConfigNewCharacterWealthModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Set New Character Wealth',
            timeout=600
        )
        self.amount_text_input = discord.ui.TextInput(
            label='Amount',
            custom_id='amount_text_input',
            placeholder='Enter the amount of this currency.'
        )
        self.currency_name_text_input = discord.ui.TextInput(
            label='Currency Name',
            custom_id='currency_name_text_input',
            placeholder='Enter the name of a currency defined on this server'
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
                    collection_name='inventoryConfig',
                    query={'_id': guild_id},
                    update_data={'$unset': {'newCharacterWealth': ''}}
                )
            else:
                currency_input = self.currency_name_text_input.value.strip()
                currency_config = await get_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name='currency',
                    query={'_id': guild_id}
                )

                if not currency_config:
                    raise UserFeedbackError('No currencies are configured on this server.')

                is_currency, parent_name = find_currency_or_denomination(currency_config, currency_input)

                if not is_currency:
                    raise UserFeedbackError(
                        f'Currency or denomination named {currency_input} not found. Please use a valid currency.'
                    )

                await update_cached_data(
                    bot=bot,
                    mongo_database=bot.gdb,
                    collection_name='inventoryConfig',
                    query={'_id': guild_id},
                    update_data={'$set': {'newCharacterWealth': {'currency': parent_name, 'amount': amount}}}
                )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class CreateStaticKitModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Create New Static Kit',
            timeout=600
        )
        self.calling_view = calling_view

        self.kit_name_text_input = discord.ui.TextInput(
            label='Kit Name',
            custom_id='kit_name_text_input',
            placeholder='e.g., Warrior Starter Kit',
            max_length=50
        )
        self.kit_description_text_input = discord.ui.TextInput(
            label='Description',
            style=discord.TextStyle.paragraph,
            custom_id='kit_description_text_input',
            placeholder='Optional description for this kit',
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
                collection_name='staticKits',
                query={'_id': guild_id}
            )
            existing_kits = kit_query.get('kits', {}) if kit_query else {}
            if existing_kits:
                for kit_data in existing_kits.values():
                    if kit_name.lower() == kit_data['name'].lower():
                        raise UserFeedbackError(
                            f'A static kit named "{titlecase(kit_name)}" already exists. Please choose a different name.'
                        )

            kit_data = {
                'name': titlecase(kit_name),
                'description': self.kit_description_text_input.value.strip(),
                'items': [],
                'currency': {}
            }

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='staticKits',
                query={'_id': guild_id},
                update_data={'$set': {f'kits.{kit_id}': kit_data}}
            )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class StaticKitItemModal(Modal):
    def __init__(self, calling_view, existing_item=None, index=None):
        super().__init__(
            title='Add/Edit Kit Item',
            timeout=600
        )
        self.calling_view = calling_view
        self.index = index

        name_default = existing_item.get('name', '') if existing_item else ''
        description_default = existing_item.get('description', '') if existing_item else ''
        quantity_default = str(existing_item.get('quantity', '1')) if existing_item else '1'

        self.item_name_text_input = discord.ui.TextInput(
            label='Item Name',
            custom_id='item_name_text_input',
            placeholder='Enter the name of the item',
            default=name_default
        )
        self.description_text_input = discord.ui.TextInput(
            label='Item Description',
            style=discord.TextStyle.paragraph,
            custom_id='item_description_text_input',
            placeholder='Enter a description for the item',
            default=description_default,
            required=False
        )
        self.item_quantity_text_input = discord.ui.TextInput(
            label='Item Quantity',
            custom_id='item_quantity_text_input',
            placeholder='Enter the quantity of this item to be included in the kit',
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
                'name': self.item_name_text_input.value,
                'description': self.description_text_input.value,
                'quantity': int(self.item_quantity_text_input.value)
            }

            bot = interaction.client
            kit_id = self.calling_view.kit_id

            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='staticKits',
                query={'_id': interaction.guild_id}
            )
            kits = query.get('kits', {})
            current_kit = kits.get(kit_id)

            if not current_kit:
                raise Exception("Kit not found.")

            items = current_kit.get('items', [])

            if self.index is not None:
                items[self.index] = item_data
            else:
                items.append(item_data)

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='staticKits',
                query={'_id': interaction.guild_id},
                update_data={'$set': {f'kits.{kit_id}.items': items}}
            )

            self.calling_view.kit_data['items'] = items
            self.calling_view.items = items
            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class StaticKitCurrencyModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Add Kit Currency',
            timeout=600
        )
        self.calling_view = calling_view
        self.currency_name_text_input = discord.ui.TextInput(
            label='Currency Name',
            custom_id='currency_name_text_input',
            placeholder='e.g., Gold'
        )
        self.amount_text_input = discord.ui.TextInput(
            label='Amount',
            custom_id='amount_text_input',
            placeholder='e.g., 100'
        )
        self.add_item(self.currency_name_text_input)
        self.add_item(self.amount_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            currency_input = self.currency_name_text_input.value.strip()
            if not self.amount_text_input.value.replace('.', '', 1).isdigit():
                raise UserFeedbackError("Amount must be a number.")
            amount = float(self.amount_text_input.value)

            currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='currency',
                query={'_id': interaction.guild_id}
            )
            if not currency_config:
                raise UserFeedbackError("No currencies configured on server.")

            denomination_map, parent_name = get_denomination_map(currency_config, currency_input)

            if not denomination_map:
                raise UserFeedbackError(f'Currency "{currency_input}" not found.')

            multiplier = denomination_map.get(currency_input.lower())
            if multiplier is None:
                raise UserFeedbackError(f'Denomination "{currency_input}" not found in currency configuration.')

            converted_amount = amount * multiplier

            kit_id = self.calling_view.kit_id

            query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='staticKits',
                query={'_id': interaction.guild_id}
            )

            existing_amount = 0

            if query and 'kits' in query:
                existing_amount = query['kits'].get(kit_id, {}).get('currency', {}).get(parent_name, 0)

            final_amount = existing_amount + converted_amount

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='staticKits',
                query={'_id': interaction.guild_id},
                update_data={'$set': {f'kits.{kit_id}.currency.{parent_name}': final_amount}}
            )

            if 'currency' not in self.calling_view.kit_data:
                self.calling_view.kit_data['currency'] = {}

            self.calling_view.kit_data['currency'][parent_name] = final_amount

            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayGeneralSettingsModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Roleplay General Settings'
        )
        self.calling_view = calling_view
        current_minimum = calling_view.config.get('minLength', 0)

        self.minimum_length_text_input = discord.ui.TextInput(
            label='Minimum Message Length',
            placeholder='0 for no limit',
            default=str(current_minimum),
            max_length=4
        )
        self.add_item(self.minimum_length_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            minimum_length = int(self.minimum_length_text_input.value)
            if minimum_length < 0:
                raise ValueError

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='roleplayConfig',
                query={'_id': interaction.guild_id},
                update_data={'$set': {'minLength': minimum_length}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayScheduledConfigModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Scheduled Mode Config'
        )
        self.calling_view = calling_view
        config = calling_view.config.get('config', {})

        self.threshold_text_input = discord.ui.TextInput(
            label='Message Threshold',
            placeholder='Number of messages required to trigger reward',
            default=str(config.get('threshold', 20))
        )

        self.reset_time_text_input = discord.ui.TextInput(
            label='Reset Time (UTC HH:MM)',
            placeholder='The time of day when message counts reset. Format: HH:MM',
            default=config.get('resetTime', '00:00'),
            min_length=5, max_length=5
        )

        self.add_item(self.threshold_text_input)
        self.add_item(self.reset_time_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            try:
                datetime.datetime.strptime(self.reset_time_text_input.value, '%H:%M')
            except ValueError:
                raise UserFeedbackError("Invalid Time Format. Use HH:MM (24-hour).")

            threshold = int(self.threshold_text_input.value)
            if threshold < 1:
                raise ValueError

            new_config = self.calling_view.config.get('config', {})
            new_config['threshold'] = threshold
            new_config['resetTime'] = self.reset_time_text_input.value

            await update_cached_data(
                bot=interaction.client,
                mongo_database=interaction.client.gdb,
                collection_name='roleplayConfig',
                query={'_id': interaction.guild_id},
                update_data={'$set': {'config': new_config}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayAccruedConfigModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Accrued Mode Config'
        )
        self.calling_view = calling_view
        config = calling_view.config.get('config', {})

        self.frequency_text_input = discord.ui.TextInput(
            label='Frequency (# of eligible messages between rewards)',
            placeholder='Reward every X messages',
            default=str(config.get('frequency', 20))
        )
        self.cooldown_text_input = discord.ui.TextInput(
            label='Cooldown (Seconds)',
            placeholder='Wait time between eligible messages',
            default=str(config.get('cooldown', 30))
        )
        self.add_item(self.frequency_text_input)
        self.add_item(self.cooldown_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            frequency = int(self.frequency_text_input.value)
            cooldown_seconds = int(self.cooldown_text_input.value)
            if frequency < 1 or cooldown_seconds < 0: raise ValueError

            new_config = {
                'frequency': frequency,
                'cooldown': cooldown_seconds
            }

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='roleplayConfig',
                query={'_id': interaction.guild_id},
                update_data={'$set': {'config': new_config}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RoleplayRewardsModal(Modal):
    def __init__(self, calling_view, bot, guild_id):
        super().__init__(title='Configure Roleplay Rewards')
        self.calling_view = calling_view
        rewards = calling_view.config.get('rewards', {})

        self.xp_config = get_xp_config(bot, guild_id)
        if self.xp_config:
            self.experience_text_input = discord.ui.TextInput(
                label='Experience',
                default=str(rewards.get('xp', 0)),
                required=False
            )
            self.add_item(self.experience_text_input)

        item_display = ''
        if items := rewards.get('items'):
            item_display = '\n'.join([f'{k}: {v}' for k, v in sorted(items.items())])

        self.items = discord.ui.TextInput(
            label='Items (Name: Quantity)',
            style=discord.TextStyle.paragraph,
            default=item_display,
            required=False
        )
        self.add_item(self.items)


        currency_display = ''
        if currency := rewards.get('currency'):
            currency_display = '\n'.join([f'{k}: {v}' for k, v in currency.items()])

        self.currency = discord.ui.TextInput(
            label='Currency (Name: Amount)',
            style=discord.TextStyle.paragraph,
            default=currency_display,
            required=False
        )
        self.add_item(self.currency)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client

            xp = 0
            if self.xp_config:
                xp = int(self.experience_text_input.value) if self.experience_text_input.value.isdigit() else 0

            items = {}
            if self.items.value:
                for line in self.items.value.split('\n'):
                    if ':' in line:
                        k, v = line.split(':', 1)
                        items[k.strip().title()] = int(v.strip())

            currency = {}
            if self.currency.value:
                for line in self.currency.value.split('\n'):
                    if ':' in line:
                        k, v = line.split(':', 1)
                        currency[k.strip().lower()] = float(v.strip())

            new_rewards = {
                'xp': xp,
                'items': items,
                'currency': currency
            }

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='roleplayConfig',
                query={'_id': interaction.guild_id},
                update_data={'$set': {'rewards': new_rewards}}
            )
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)
