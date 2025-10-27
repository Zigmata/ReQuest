import logging
from datetime import datetime, timezone

import discord
import discord.ui
import shortuuid
from discord.ui import Modal

from ReQuest.ui.inputs import AddCurrencyDenominationTextInput
from ReQuest.utilities.supportFunctions import find_currency_or_denomination, log_exception, trade_currency, trade_item, \
    normalize_currency_keys, consolidate_currency, strip_id, update_character_inventory, update_character_experience, \
    purge_player_board

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


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

    async def on_submit(self, interaction):
        try:
            guild_id = interaction.guild_id
            view = self.calling_view
            collection = interaction.client.gdb['currency']
            query = await collection.find_one({'_id': guild_id})
            if query:
                matches = 0
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
                    await view.setup(bot=interaction.client, guild=interaction.guild)
                    await interaction.response.edit_message(embed=view.embed, view=view)
            else:
                await collection.update_one({'_id': guild_id},
                                            {'$push': {'currencies': {'name': self.text_input.value,
                                                                      'isDouble': False, 'denominations': []}}},
                                            upsert=True)
                await view.setup(bot=interaction.client, guild=interaction.guild)
                await interaction.response.edit_message(embed=view.embed, view=view)
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

    async def on_submit(self, interaction):
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
            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
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

    async def on_submit(self, interaction):
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

    async def on_submit(self, interaction):
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

    async def on_submit(self, interaction):
        try:
            experience = int(self.experience_text_input.value) if self.experience_text_input.value else None

            items = None
            if self.items_text_input.value:
                items = {}
                for item in self.items_text_input.value.strip().split('\n'):
                    item_name, quantity = item.split(':', 1)
                    items[item_name.strip().capitalize()] = int(quantity.strip())

            gm_rewards_collection = interaction.client.gdb['gmRewards']
            await gm_rewards_collection.update_one({'_id': interaction.guild.id},
                                                   {'$set': {'experience': experience, 'items': items}},
                                                   upsert=True)
            await self.calling_view.setup(bot=interaction.client, user=interaction.user, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)

    @staticmethod
    def parse_items_to_string(items) -> str:
        item_list = []
        for item_name, quantity in items.items():
            item_list.append(f'{item_name.capitalize()}: {quantity}')
        item_string = '\n'.join(item_list)
        return item_string
