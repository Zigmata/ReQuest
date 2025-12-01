import json
import logging

import jsonschema
import shortuuid
from jsonschema import validate

import discord
import discord.ui
from discord.ui import Modal, Label

from ReQuest.utilities.supportFunctions import log_exception, purge_player_board, setup_view, \
    find_currency_or_denomination, titlecase

logging.basicConfig(level=logging.INFO)
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
            guild_id = interaction.guild_id
            view = self.calling_view
            collection = interaction.client.gdb['currency']
            query = await collection.find_one({'_id': guild_id})
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
                await collection.update_one({'_id': guild_id},
                                            {'$push': {'currencies': {'name': self.text_input.value,
                                                                      'isDouble': False, 'denominations': []}}},
                                            upsert=True)
                await setup_view(view, interaction)
                await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class AddCurrencyDenominationTextModal(Modal):
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
            guild_id = interaction.guild_id
            new_name = self.denomination_name_text_input.value
            collection = interaction.client.gdb['currency']
            query = await collection.find_one({'_id': guild_id})
            for currency in query['currencies']:
                if new_name.lower() == currency['name'].lower():
                    raise Exception(f'New denomination name cannot match an existing currency on this server! Found '
                                    f'existing currency named \"{currency['name']}\".')
                for denomination in currency['denominations']:
                    if new_name.lower() == denomination['name'].lower():
                        raise Exception(f'New denomination name cannot match an existing denomination on this server! '
                                        f'Found existing denomination named \"{denomination['name']}\" under the '
                                        f'currency named \"{currency['name']}\".')
            base_currency = next((item for item in query['currencies'] if item['name'] == self.base_currency_name),
                                 None)
            if base_currency:
                for denomination in base_currency['denominations']:
                    if float(self.denomination_value_text_input.value) == denomination['value']:
                        using_name = denomination['name']
                        raise Exception(f'Denominations under a single currency must have unique values! '
                                        f'{using_name} already has this value assigned.')

                await collection.update_one({'_id': guild_id, 'currencies.name': self.base_currency_name},
                                            {'$push': {'currencies.$.denominations': {
                                                'name': new_name,
                                                'value': float(self.denomination_value_text_input.value)}}},
                                            upsert=True)
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
            names = []
            for name in self.names_text_input.value.strip().split(','):
                names.append(name.lower().strip())
            config_collection = interaction.client.gdb['forbiddenRoles']
            await config_collection.update_one({'_id': interaction.guild_id},
                                               {'$set': {'forbiddenRoles': names}},
                                               upsert=True)
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
            age = int(self.age_text_input.value)
            await purge_player_board(age, interaction)
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
        self.experience_text_input = discord.ui.TextInput(
            label='Experience',
            custom_id='experience_text_input',
            placeholder='Enter a number',
            default=current_rewards['experience'] if current_rewards and current_rewards['experience'] else None,
            required=False
        )
        self.items_text_input = discord.ui.TextInput(
            label='Items',
            style=discord.TextStyle.paragraph,
            custom_id='items_text_input',
            placeholder='{item}: {quantity}\n'
                        '{item2}: {quantity}\n'
                        'etc.',
            default=(self.parse_items_to_string(current_rewards['items'])
                     if current_rewards and current_rewards['items']
                     else None),
            required=False
        )
        self.add_item(self.experience_text_input)
        self.add_item(self.items_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            experience = int(self.experience_text_input.value) if self.experience_text_input.value else None

            items = None
            if self.items_text_input.value:
                items = {}
                for item in self.items_text_input.value.strip().split('\n'):
                    item_name, quantity = item.split(':', 1)
                    items[item_name.strip().capitalize()] = int(quantity.strip())

            gm_rewards_collection = interaction.client.gdb['gmRewards']
            await gm_rewards_collection.update_one({'_id': interaction.guild_id},
                                                   {'$set': {'experience': experience, 'items': items}},
                                                   upsert=True)
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)

    @staticmethod
    def parse_items_to_string(items) -> str:
        item_list = []
        for item_name, quantity in items.items():
            item_list.append(f'{item_name.capitalize()}: {quantity}')
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
            guild_id = interaction.guild_id
            collection = interaction.client.gdb['shops']

            if self.existing_channel_id:
                channel_id = self.existing_channel_id
            else:
                if not self.shop_channel_select or not self.shop_channel_select.values:
                    raise Exception('No channel selected for the shop.')
                channel_id = str(self.shop_channel_select.values[0].id)

            if not self.existing_channel_id:
                query = await collection.find_one({'_id': guild_id})
                if query and channel_id in query.get('shopChannels', {}):
                    raise Exception('A shop is already registered in the selected channel. '
                                    'Please choose a different channel or edit the existing shop.')

            shop_data = {
                'shopName': self.shop_name_text_input.value,
                'shopKeeper': self.shop_keeper_text_input.value,
                'shopDescription': self.shop_description_text_input.value,
                'shopImage': self.shop_image_text_input.value,
                'shopStock': []
            }

            if self.existing_channel_id:
                existing_query = await collection.find_one({'_id': guild_id})
                existing_shop_data = existing_query.get('shopChannels', {}).get(channel_id, {})
                shop_data['shopStock'] = existing_shop_data.get('shopStock', [])

            await collection.update_one(
                {'_id': guild_id},
                {'$set': {f'shopChannels.{channel_id}': shop_data}},
                upsert=True
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
            guild_id = interaction.guild_id
            collection = interaction.client.gdb['shops']
            channel_id = str(self.shop_channel_select.values[0].id)

            query = await collection.find_one({'_id': guild_id})
            if query and channel_id in query.get('shopChannels', {}):
                raise Exception('A shop is already registered in the selected channel. '
                                'Please choose a different channel or edit the existing shop.')

            if not self.shop_json_file_upload.values:
                raise Exception('No JSON file uploaded for the shop.')

            uploaded_file = self.shop_json_file_upload.values[0]
            if not uploaded_file.filename.endswith('.json'):
                raise Exception('Uploaded file must be a JSON file (.json).')

            file_bytes = await uploaded_file.read()

            file_content = file_bytes.decode('utf-8')

            try:
                shop_data = json.loads(file_content)
            except json.JSONDecodeError as jde:
                raise Exception(f'Invalid JSON format: {str(jde)}')

            try:
                validate(instance=shop_data, schema=SHOP_SCHEMA)
            except jsonschema.exceptions.ValidationError as ve:
                raise Exception(f'JSON does not conform to schema: {str(ve)}')

            await collection.update_one(
                {'_id': guild_id},
                {'$set': {f'shopChannels.{channel_id}': shop_data}},
                upsert=True
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
            guild_id = interaction.guild_id
            view = self.calling_view
            collection = interaction.client.gdb['shops']
            channel_id = view.channel_id

            quantity_str = self.item_quantity_text_input.value
            if not quantity_str.isdigit() or int(quantity_str) < 1:
                raise Exception('Item quantity must be a positive integer.')

            price_str = self.item_price_text_input.value
            if not price_str.isdigit() or int(price_str) < 0:
                raise Exception('Item price must be a non-negative integer.')

            new_item = {
                'name': self.item_name_text_input.value,
                'description': self.item_description_text_input.value,
                'price': int(self.item_price_text_input.value),
                'quantity': int(self.item_quantity_text_input.value),
                'currency': self.item_currency_text_input.value.lower()
            }

            shop_query = await collection.find_one({'_id': guild_id})
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
                        raise Exception(f'An item named {new_item["name"]} already exists in this shop.')
                shop_data['shopStock'].append(new_item)

            await collection.update_one(
                {'_id': guild_id},
                {'$set': {f'shopChannels.{channel_id}': shop_data}},
                upsert=True
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
            guild_id = interaction.guild_id
            collection = interaction.client.gdb['shops']
            channel_id = self.calling_view.selected_channel_id

            if not self.shop_json_file_upload.values:
                raise Exception("No file was uploaded.")

            uploaded_file = self.shop_json_file_upload.values[0]
            if not uploaded_file.filename.endswith('.json'):
                raise Exception("File must be a `.json` file.")

            file_bytes = await uploaded_file.read()
            file_content = file_bytes.decode('utf-8')

            try:
                shop_data = json.loads(file_content)
            except json.JSONDecodeError as jde:
                raise Exception(f'Invalid JSON format: {str(jde)}')

            try:
                validate(instance=shop_data, schema=SHOP_SCHEMA)
            except jsonschema.exceptions.ValidationError as err:
                raise Exception(f"JSON validation failed: {err.message}")

            await collection.update_one(
                {'_id': guild_id},
                {'$set': {f'shopChannels.{channel_id}': shop_data}},
                upsert=False
            )

            if hasattr(self.calling_view, 'update_details'):
                self.calling_view.update_details(shop_data)
                self.calling_view.build_view()
                await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class NewCharacterShopItemModal(Modal):
    def __init__(self, calling_view, existing_item = None):
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
            guild_id = interaction.guild_id
            collection = interaction.client.gdb['newCharacterShop']

            quantity_string = self.item_quantity_text_input.value
            if not quantity_string.isdigit() or int(quantity_string) < 1:
                raise Exception('Item quantity must be a positive integer.')

            price_str = self.item_price_text_input.value
            if not price_str.isdigit() or float(price_str) < 0:
                raise Exception('Item price must be a non-negative number.')

            currency_val = self.item_currency_text_input.value.lower()
            if int(price_str) > 0 and not currency_val:
                raise Exception('Currency is required if price is greater than 0.')

            new_item = {
                'name': self.item_name_text_input.value,
                'description': self.item_description_text_input.value,
                'price': int(self.item_price_text_input.value),
                'quantity': int(self.item_quantity_text_input.value),
                'currency': currency_val
            }

            query = await collection.find_one({'_id': guild_id})
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
                        raise Exception(f'An item named {new_item["name"]} already exists in the New Character shop.')
                shop_stock.append(new_item)

            await collection.update_one(
                {'_id': guild_id},
                {'$set': {'shopStock': shop_stock}},
                upsert=True
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
            guild_id = interaction.guild_id
            collection = interaction.client.gdb['newCharacterShop']

            if not self.shop_json_file_upload.values:
                raise Exception('No JSON file uploaded.')

            uploaded_file = self.shop_json_file_upload.values[0]
            if not uploaded_file.filename.endswith('.json'):
                raise Exception('Uploaded file must be a JSON file (.json).')

            file_bytes = await uploaded_file.read()
            file_content = file_bytes.decode('utf-8')

            try:
                shop_data = json.loads(file_content)
            except json.JSONDecodeError as jde:
                raise Exception(f'Invalid JSON format: {str(jde)}')

            if 'shopStock' not in shop_data or not isinstance(shop_data['shopStock'], list):
                raise Exception("JSON must contain a 'shopStock' array.")

            for item in shop_data['shopStock']:
                if 'name' not in item or 'price' not in item:
                    raise Exception("All items must have 'name' and 'price'.")

            await collection.update_one(
                {'_id': guild_id},
                {'$set': {'shopStock': shop_data['shopStock']}},
                upsert=True
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
            guild_id = interaction.guild_id

            if not self.amount_text_input.value.replace('.', '', 1).isdigit():
                raise ValueError('Amount must be a number.')
            amount = float(self.amount_text_input.value)

            inventory_config_collection = interaction.client.gdb['inventoryConfig']

            if amount <= 0:
                await inventory_config_collection.update_one(
                    {'_id': interaction.guild_id},
                    {'$unset': {'newCharacterWealth': ''}},
                    upsert=True
                )
            else:
                currency_input = self.currency_name_text_input.value.strip()
                currency_collection = interaction.client.gdb['currency']
                currency_config = await currency_collection.find_one({'_id': guild_id})

                if not currency_config:
                    raise Exception('No currencies are configured on this server.')

                is_currency, parent_name = find_currency_or_denomination(currency_config, currency_input)

                if not is_currency:
                    raise Exception(f'Currency or denomination named {currency_input} not found. Please use a valid '
                                    f'currency.')

                await inventory_config_collection.update_one(
                    {'_id': interaction.guild_id},
                    {'$set': {'newCharacterWealth': {'currency': parent_name, 'amount': amount}}},
                    upsert=True
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
            guild_id = interaction.guild_id
            collection = interaction.client.gdb['staticKits']
            kit_id = str(shortuuid.uuid()[:8])
            kit_name = self.kit_name_text_input.value.strip().lower()

            kit_query = await collection.find_one({'_id': guild_id})
            existing_kits = kit_query.get('kits', {}) if kit_query else {}
            if existing_kits:
                for kit_data in existing_kits.values():
                    if kit_name == kit_data['name'].lower():
                        raise Exception(f'A static kit named "{titlecase(kit_name)}" already exists. Please '
                                        f'choose a different name.')

            kit_data = {
                'name': kit_name,
                'description': self.kit_description_text_input.value.strip(),
                'items': [],
                'currency': {}
            }

            await collection.update_one(
                {'_id': guild_id},
                {'$set': {f'kits.{kit_id}': kit_data}},
                upsert=True
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

            kit_id = self.calling_view.kit_id
            collection = interaction.client.gdb['staticKits']

            query = await collection.find_one({'_id': interaction.guild_id})
            kits = query.get('kits', {})
            current_kit = kits.get(kit_id)

            if not current_kit:
                raise Exception("Kit not found.")

            items = current_kit.get('items', [])

            if self.index is not None:
                items[self.index] = item_data
            else:
                items.append(item_data)

            await collection.update_one(
                {'_id': interaction.guild_id},
                {'$set': {f'kits.{kit_id}.items': items}}
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
            currency_input = self.currency_name_text_input.value.strip()
            if not self.amount_text_input.value.replace('.', '', 1).isdigit():
                raise ValueError("Amount must be a number.")
            amount = float(self.amount_text_input.value)

            currency_config = await interaction.client.gdb['currency'].find_one({'_id': interaction.guild_id})
            if not currency_config:
                raise Exception("No currencies configured on server.")

            is_valid, parent_name = find_currency_or_denomination(currency_config, currency_input)
            if not is_valid:
                raise Exception(f"Currency '{currency_input}' not found.")

            kit_id = self.calling_view.kit_id
            collection = interaction.client.gdb['staticKits']

            await collection.update_one(
                {'_id': interaction.guild_id},
                {'$set': {f'kits.{kit_id}.currency.{parent_name}': amount}}
            )

            if 'currency' not in self.calling_view.kit_data:
                self.calling_view.kit_data['currency'] = {}
            self.calling_view.kit_data['currency'][parent_name] = amount

            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)
