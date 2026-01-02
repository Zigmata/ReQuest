import json
import logging
from datetime import datetime

import discord
import discord.ui
import jsonschema
import shortuuid
from discord.ui import Modal, Label
from jsonschema import validate
from titlecase import titlecase

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
    initialize_item_stock
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
                await setup_view(self.calling_view, interaction)
                await interaction.response.edit_message(view=self.calling_view)
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
        quantity_default = str(existing_item.get('quantity', '1')) if existing_item else '1'

        costs_default = ''
        if existing_item and 'costs' in existing_item:
            lines = []
            for option in existing_item['costs']:
                components = [f'{amount} {currency}' for currency, amount in option.items()]
                lines.append(' + '.join(components))
            costs_default = '\n'.join(lines)

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
        self.item_quantity_text_input = discord.ui.TextInput(
            label='Item Quantity',
            custom_id='item_quantity_text_input',
            placeholder='Enter the quantity sold per purchase',
            default=quantity_default,
            required=False
        )
        self.item_cost_text_input = discord.ui.TextInput(
            label='Item Costs',
            style=discord.TextStyle.paragraph,
            custom_id='item_cost_text_input',
            placeholder='E.g.: 10 gold + 5 silver\nOR: 50 rep\n(Use + for AND, New Lines for OR)',
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
                raise UserFeedbackError('Item quantity must be a positive integer.')

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
                                f'Invalid cost format in option: "{option}". Each cost must have an amount and a '
                                f'currency separated by a space, e.g. "10 gold".'
                            )

                        amount_string = parts[0]
                        currency_name = parts[1]

                        try:
                            amount = float(amount_string)
                            if amount <= 0:
                                raise ValueError
                        except ValueError:
                            raise UserFeedbackError(
                                f'Invalid amount "{amount_string}" for currency: "{currency_name}". Amount must be a '
                                f'positive number.'
                            )

                        currency_key = currency_name.lower()
                        currency_config = await get_cached_data(
                            bot=bot,
                            mongo_database=bot.gdb,
                            collection_name='currency',
                            query={'_id': guild_id}
                        )
                        currency_config_entry = find_currency_or_denomination(currency_config, currency_key)

                        if not currency_config_entry:
                            raise UserFeedbackError(
                                f'Unknown currency `{currency_name}`. Please use a valid currency configured for this '
                                f'server.'
                            )

                        current_options[currency_key] = amount

                    if current_options:
                        parsed_costs.append(current_options)

            new_item = {
                'name': self.item_name_text_input.value,
                'description': self.item_description_text_input.value,
                'quantity': int(self.item_quantity_text_input.value),
                'costs': parsed_costs
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
    def __init__(self, calling_view, inventory_type, existing_item=None):
        super().__init__(
            title='Add/Edit NewCharacter Gear',
            timeout=600
        )
        self.calling_view = calling_view
        self.inventory_type = inventory_type
        self.existing_item_name = existing_item.get('name') if existing_item else None

        name_default = existing_item.get('name', '') if existing_item else ''
        description_default = existing_item.get('description', '') if existing_item else ''
        quantity_default = str(existing_item.get('quantity', '1')) if existing_item else '1'

        costs_default = ''
        if existing_item and 'costs' in existing_item:
            lines = []
            for option in existing_item['costs']:
                components = [f'{amount} {currency}' for currency, amount in option.items()]
                lines.append(' + '.join(components))
            costs_default = '\n'.join(lines)

        self.item_name_text_input = discord.ui.TextInput(
            label='Item Name',
            custom_id='item_name_text_input',
            placeholder='Enter the name of the item',
            default=name_default
        )
        self.add_item(self.item_name_text_input)

        self.item_description_text_input = discord.ui.TextInput(
            label='Item Description',
            style=discord.TextStyle.paragraph,
            custom_id='item_description_text_input',
            placeholder='Enter a description for the item',
            default=description_default,
            required=False
        )
        self.add_item(self.item_description_text_input)

        self.item_quantity_text_input = discord.ui.TextInput(
            label='Item Quantity',
            custom_id='item_quantity_text_input',
            placeholder='Enter the quantity received per selection',
            default=quantity_default,
            required=False
        )
        self.add_item(self.item_quantity_text_input)

        if inventory_type == 'purchase':
            self.item_cost_text_input = discord.ui.TextInput(
                label='Item Cost',
                custom_id='item_cost_text_input',
                placeholder='E.g.: 10 gold + 5 silver\nOR: 50 rep\n(Use + for AND, New Lines for OR)',
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
                raise UserFeedbackError('Item quantity must be a positive integer.')

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
                                    f"Invalid cost format: '{component}'. Expected 'Amount Currency'.")

                            amount_str = parts[0]
                            currency_name = parts[1]

                            try:
                                amount = float(amount_str)
                                if amount <= 0:
                                    raise ValueError
                            except ValueError:
                                raise UserFeedbackError(
                                    f"Invalid amount '{amount_str}' for currency '{currency_name}'.")

                            currency_key = currency_name.lower()
                            currency_config = await get_cached_data(
                                bot=bot,
                                mongo_database=bot.gdb,
                                collection_name='currency',
                                query={'_id': guild_id}
                            )
                            currency_config_entry = find_currency_or_denomination(currency_config, currency_key)

                            if not currency_config_entry:
                                raise UserFeedbackError(
                                    f'Unknown currency `{currency_name}`. Please use a valid currency configured for '
                                    f'this server.'
                                )

                            current_option_dict[currency_key] = amount

                        if current_option_dict:
                            parsed_costs.append(current_option_dict)

            new_item = {
                'name': self.item_name_text_input.value,
                'description': self.item_description_text_input.value,
                'quantity': int(self.item_quantity_text_input.value),
                'costs': parsed_costs
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
                            f'A static kit named "{titlecase(kit_name)}" already exists. Please choose a '
                            f'different name.'
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


class RoleplaySettingsModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Roleplay Settings'
        )
        self.calling_view = calling_view
        config = calling_view.config
        mode_config = config.get('config', {})
        self.mode = config.get('mode', 'accrued')

        self.minimum_length_text_input = discord.ui.TextInput(
            label='Minimum Message Length (characters)',
            placeholder='# of characters required for a message to be eligible. 0 for no limit',
            default=str(mode_config.get('minLength', 0)),
            max_length=4
        )
        self.add_item(self.minimum_length_text_input)

        self.cooldown_text_input = discord.ui.TextInput(
            label='Cooldown (seconds)',
            placeholder='Wait time, in seconds, between counting messages as eligible for rewards',
            default=str(mode_config.get('cooldown', 30)),
            max_length=4
        )
        self.add_item(self.cooldown_text_input)

        if self.mode == 'scheduled':
            self.threshold_text_input = discord.ui.TextInput(
                label='Message Threshold',
                placeholder='Number of messages required to trigger reward',
                default=str(mode_config.get('threshold', 20)),
                max_length=4
            )
            self.add_item(self.threshold_text_input)

        elif self.mode == 'accrued':
            self.frequency_text_input = discord.ui.TextInput(
                label='Frequency (# of messages)',
                placeholder='Number of eligible messages required to earn rewards',
                default=str(mode_config.get('frequency', 20)),
                max_length=4
            )
            self.add_item(self.frequency_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            new_config = self.calling_view.config.get('config', {})

            # Minimum Length
            try:
                minimum_length = int(self.minimum_length_text_input.value)
                if minimum_length < 0:
                    raise ValueError
            except ValueError:
                raise UserFeedbackError('Minimum Message Length must be a non-negative integer.')

            new_config['minLength'] = minimum_length

            # Cooldown
            try:
                cooldown_seconds = int(self.cooldown_text_input.value)
                if cooldown_seconds < 0:
                    raise ValueError
            except ValueError:
                raise UserFeedbackError('Cooldown must be a non-negative integer.')

            new_config['cooldown'] = cooldown_seconds

            # Validate and add scheduled settings
            if self.mode == 'scheduled':
                try:
                    threshold = int(self.threshold_text_input.value)
                    if threshold < 1:
                        raise ValueError
                except ValueError:
                    raise UserFeedbackError('Message Threshold must be a positive integer.')

                new_config['threshold'] = threshold

            # Validate and add accrued settings
            elif self.mode == 'accrued':
                try:
                    frequency = int(self.frequency_text_input.value)
                    if frequency < 1:
                        raise ValueError
                except ValueError:
                    raise UserFeedbackError('Frequency must be a positive integer.')

                new_config['frequency'] = frequency

            # Push updates to db
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
    def __init__(self, calling_view, xp_enabled):
        super().__init__(title='Configure Roleplay Rewards')
        self.calling_view = calling_view
        rewards = calling_view.config.get('rewards', {})

        self.xp_enabled = xp_enabled
        if self.xp_enabled:
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
            if self.xp_enabled:
                try:
                    xp = int(self.experience_text_input.value.strip())
                    if xp < 0:
                        raise ValueError
                except ValueError:
                    raise UserFeedbackError('Experience must be a non-negative integer.')

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
                            raise UserFeedbackError(f'Item quantity for "{k.strip()}" must be a positive integer.')

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
                            raise UserFeedbackError(f'Currency amount for "{k.strip()}" must be a positive number.')

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


class SetItemStockModal(Modal):
    def __init__(self, calling_view, item_name: str, current_max: int | None = None,
                 current_stock: int | None = None):
        super().__init__(
            title=f'Stock Limit: {item_name[:40]}',
            timeout=600
        )
        self.calling_view = calling_view
        self.item_name = item_name

        self.max_stock_text_input = discord.ui.TextInput(
            label='Maximum Stock',
            custom_id='max_stock_text_input',
            placeholder='Enter max stock (e.g., 10)',
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
            label='Current Stock',
            custom_id='current_stock_text_input',
            placeholder='Enter current available stock',
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
                raise UserFeedbackError('Maximum stock must be a positive integer.')

            # Validate current stock
            current_stock_str = self.current_stock_text_input.value.strip()
            try:
                current_stock = int(current_stock_str)
                if current_stock < 0:
                    raise ValueError
            except ValueError:
                raise UserFeedbackError('Current stock must be a non-negative integer.')

            if current_stock > max_stock:
                raise UserFeedbackError('Current stock cannot exceed maximum stock.')

            # Update the shop config with maxStock for this item
            shop_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='shops',
                query={'_id': guild_id}
            )
            shop_data = shop_query.get('shopChannels', {}).get(channel_id, {})
            shop_stock = shop_data.get('shopStock', [])

            # Find and update the item
            item_found = False
            for item in shop_stock:
                if item.get('name') == self.item_name:
                    item['maxStock'] = max_stock
                    item_found = True
                    break

            if not item_found:
                raise UserFeedbackError(f'Item "{self.item_name}" not found in shop.')

            # Save shop config
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='shops',
                query={'_id': guild_id},
                update_data={'$set': {f'shopChannels.{channel_id}': shop_data}}
            )

            # Initialize/update the runtime stock tracking
            await initialize_item_stock(bot, guild_id, channel_id, self.item_name, max_stock, current_stock)

            # Refresh the view
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RestockScheduleModal(Modal):
    def __init__(self, calling_view, current_config: dict | None = None):
        super().__init__(
            title='Configure Restock Schedule',
            timeout=600
        )
        self.calling_view = calling_view

        # Get current UTC time for display
        now = datetime.now()
        utc_time_str = now.strftime('%Y-%m-%d %H:%M UTC')

        current_config = current_config or {}
        schedule = current_config.get('schedule', '')
        hour = current_config.get('hour', 0)
        minute = current_config.get('minute', 0)
        day = current_config.get('dayOfWeek', 0)
        mode = current_config.get('mode', 'full')
        increment = current_config.get('incrementAmount', 1)

        self.schedule_text_input = discord.ui.TextInput(
            label='Schedule (hourly/daily/weekly/none)',
            custom_id='schedule_text_input',
            placeholder='Enter: hourly, daily, weekly, or none',
            default=schedule if schedule else 'none',
            required=True
        )

        self.time_text_input = discord.ui.TextInput(
            custom_id='time_text_input',
            placeholder='e.g., 14:30 for 2:30 PM UTC',
            default=f'{hour:02d}:{minute:02d}',
            required=False
        )

        self.time_label = Label(
            text='Time (HH:MM in UTC)',
            description=f'Current time: {utc_time_str}',
            component=self.time_text_input
        )

        self.day_text_input = discord.ui.TextInput(
            label='Day of Week (0=Mon, 6=Sun) - Weekly only',
            custom_id='day_text_input',
            placeholder='Enter 0-6 (Monday=0, Sunday=6)',
            default=str(day),
            required=False
        )

        self.mode_text_input = discord.ui.TextInput(
            label='Mode (full/incremental)',
            custom_id='mode_text_input',
            placeholder='full = reset to max, incremental = add amount',
            default=mode,
            required=True
        )

        self.increment_text_input = discord.ui.TextInput(
            label='Increment Amount (for incremental mode)',
            custom_id='increment_text_input',
            placeholder='Amount to add per restock cycle',
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
            if schedule not in ['hourly', 'daily', 'weekly', 'none', '']:
                raise UserFeedbackError('Schedule must be one of: hourly, daily, weekly, or none.')

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
                    raise UserFeedbackError('Time must be in HH:MM format (e.g., 14:30).')

            # Parse day of week
            day = 0
            if schedule == 'weekly':
                day_str = self.day_text_input.value.strip()
                try:
                    day = int(day_str)
                    if not (0 <= day <= 6):
                        raise ValueError
                except ValueError:
                    raise UserFeedbackError('Day of week must be 0-6 (Monday=0, Sunday=6).')

            # Parse mode
            mode = self.mode_text_input.value.strip().lower()
            if mode not in ['full', 'incremental']:
                raise UserFeedbackError('Mode must be either "full" or "incremental".')

            # Parse increment amount
            increment_amount = 1
            if mode == 'incremental':
                increment_str = self.increment_text_input.value.strip()
                if increment_str:
                    try:
                        increment_amount = int(increment_str)
                        if increment_amount < 1:
                            raise ValueError
                    except ValueError:
                        raise UserFeedbackError('Increment amount must be a positive integer.')

            # Build restock config
            if schedule in ['none', '']:
                restock_config = {'enabled': False}
            else:
                restock_config = {
                    'enabled': True,
                    'schedule': schedule,
                    'hour': hour,
                    'minute': minute,
                    'dayOfWeek': day,
                    'mode': mode,
                    'incrementAmount': increment_amount
                }

            # Update shop config
            shop_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='shops',
                query={'_id': guild_id}
            )
            shop_data = shop_query.get('shopChannels', {}).get(channel_id, {})
            shop_data['restockConfig'] = restock_config

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name='shops',
                query={'_id': guild_id},
                update_data={'$set': {f'shopChannels.{channel_id}': shop_data}}
            )

            # Refresh the view
            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)
