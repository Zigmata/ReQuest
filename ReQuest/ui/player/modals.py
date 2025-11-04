import logging
from datetime import datetime, timezone

import discord
import discord.ui
import shortuuid
from discord.ui import Modal

from ReQuest.utilities.supportFunctions import (
    find_currency_or_denomination,
    log_exception,
    trade_currency,
    trade_item,
    normalize_currency_keys,
    consolidate_currency
)

logging.basicConfig(level=logging.INFO)
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
            transaction_id = shortuuid.uuid()[:12]
            mdb = interaction.client.mdb
            gdb = interaction.client.gdb
            member_id = interaction.user.id
            target_id = self.target.id
            guild_id = interaction.guild_id
            quantity = float(self.item_quantity_text_input.value)
            item_name = self.item_name_text_input.value

            collection = mdb['characters']
            member_query = await collection.find_one({'_id': member_id})
            member_active_character_id = member_query['activeCharacters'][str(guild_id)]
            member_active_character = member_query['characters'][member_active_character_id]

            target_query = await collection.find_one({'_id': target_id})
            if not target_query:
                raise Exception('The player you are attempting to trade with has no characters!')
            elif str(guild_id) not in target_query['activeCharacters']:
                raise Exception('The player you are attempting to trade with does not have an active character on this'
                                'server!')
            target_active_character_id = target_query['activeCharacters'][str(guild_id)]
            target_active_character = target_query['characters'][target_active_character_id]

            currency_collection = gdb['currency']
            currency_query = await currency_collection.find_one({'_id': guild_id})

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
                sender_currency, receiver_currency = await trade_currency(mdb, gdb, item_name, quantity, member_id,
                                                                          target_id, guild_id)
                sender_balance_str = self.format_currency_string(sender_currency)
                receiver_currency_str = self.format_currency_string(receiver_currency)
                trade_embed.add_field(name='Currency', value=item_name.lower().capitalize())
                trade_embed.add_field(name='Amount', value=quantity)
                trade_embed.add_field(name=f'{member_active_character['name']}\'s Balance', value=sender_balance_str,
                                      inline=False)
                trade_embed.add_field(name=f'{target_active_character['name']}\'s Balance', value=receiver_currency_str,
                                      inline=False)
            else:
                quantity = int(quantity)
                await trade_item(mdb, item_name, quantity, member_id, target_id, guild_id)
                trade_embed.add_field(name='Item', value=item_name.lower().capitalize())
                trade_embed.add_field(name='Quantity', value=quantity)

            trade_embed.set_footer(text=f'Transaction ID: {transaction_id}')

            await interaction.response.send_message(embed=trade_embed)

        except Exception as e:
            await log_exception(e, interaction)

    @staticmethod
    def format_currency_string(currency_dict):
        if not currency_dict:
            return "No currency"
        return ", ".join([f"{amount} {name}" for name, amount in currency_dict.items()])


class CharacterRegisterModal(Modal):
    def __init__(self, calling_view, mdb, member_id, guild_id):
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
        self.calling_view = calling_view
        self.mdb = mdb
        self.member_id = member_id
        self.guild_id = guild_id
        self.add_item(self.name_text_input)
        self.add_item(self.note_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            character_id = str(shortuuid.uuid())
            collection = self.mdb['characters']
            date = datetime.now(timezone.utc)
            character_name = self.name_text_input.value
            character_note = self.note_text_input.value

            await collection.update_one({'_id': self.member_id},
                                        {'$set': {f'activeCharacters.{self.guild_id}': character_id,
                                                  f'characters.{character_id}': {
                                                      'name': character_name,
                                                      'note': character_note,
                                                      'registeredDate': date,
                                                      'attributes': {
                                                          'level': None,
                                                          'experience': None,
                                                          'inventory': {},
                                                          'currency': {}
                                                      }}}},
                                        upsert=True)

            await interaction.response.send_message(f'{character_name} was born!', ephemeral=True, delete_after=5)
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
            currency_collection = interaction.client.gdb['currency']
            currency_query = await currency_collection.find_one({'_id': interaction.guild_id})

            if not currency_query:
                raise Exception('Currency definition not found for this server')

            # Validate currency name
            currency_name = self.currency_name_text_input.value.strip().lower()
            amount = float(self.currency_amount_text_input.value.strip())

            if amount <= 0:
                raise ValueError('You cannot spend a negative amount of currency')

            base_currency_name, currency_parent_name = find_currency_or_denomination(currency_query, currency_name)
            if not base_currency_name:
                raise Exception('Currency or denomination not found')

            base_currency_name = currency_parent_name
            denominations = {d['name'].lower(): d['value'] for currency in currency_query['currencies'] if
                             currency['name'].lower() == base_currency_name.lower() for d in currency['denominations']}
            denominations[base_currency_name.lower()] = 1.0

            logger.debug(f'Denominations: {denominations}')

            user_id = interaction.user.id
            guild_id = interaction.guild_id
            character_collection = interaction.client.mdb['characters']

            character_query = await character_collection.find_one({'_id': user_id})
            if not character_query:
                raise Exception('You do not have any characters!')

            if not str(guild_id) in character_query['activeCharacters']:
                raise Exception('You do not have any characters activated on this server!')

            active_character_id = character_query['activeCharacters'][str(guild_id)]
            character = character_query['characters'][active_character_id]

            user_currency = normalize_currency_keys(character['attributes'].get('currency', {}))

            # Convert the total currency of the user to the lowest denomination
            user_total_in_lowest_denomination = sum(
                user_currency.get(denomination, 0) * (value / min(denominations.values())) for
                denomination, value in denominations.items())
            amount_in_lowest_denomination = amount * (denominations[currency_name] / min(denominations.values()))

            if user_total_in_lowest_denomination < amount_in_lowest_denomination:
                raise Exception('You have insufficient funds to cover that transaction.')

            # Deduct the amount from the user's total in the lowest denomination
            user_total_in_lowest_denomination -= amount_in_lowest_denomination

            # Convert the user's remaining total back to the original denominations
            remaining_user_currency = {}
            for denomination, value in sorted(denominations.items(), key=lambda x: -x[1]):
                denomination_value_in_lowest_denomination = value / min(denominations.values())
                if user_total_in_lowest_denomination >= denomination_value_in_lowest_denomination:
                    remaining_user_currency[denomination] = int(user_total_in_lowest_denomination //
                                                                denomination_value_in_lowest_denomination)
                    user_total_in_lowest_denomination %= denomination_value_in_lowest_denomination

            # Consolidate the user's currency
            user_currency = consolidate_currency(remaining_user_currency, denominations)

            user_currency_db = {k.capitalize(): v for k, v in user_currency.items()}

            await character_collection.update_one(
                {'_id': user_id,
                 f'characters.{active_character_id}.attributes.currency': {'$exists': True}},
                {'$set': {f'characters.{active_character_id}.attributes.currency': user_currency_db}}, upsert=True
            )

            await self.calling_view.setup(bot=interaction.client, user=interaction.user, guild=interaction.guild)
            self.calling_view.embed.add_field(name='Spent',
                                              value=f'{int(amount)} {currency_name.capitalize()}',
                                              inline=False)
            self.calling_view.embed.add_field(name=f'Remaining',
                                              value=', '.join([f'{amount} {denomination}' for denomination, amount
                                                               in user_currency_db.items()]))
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
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
            placeholder='Enter a title for your post'
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
    def __init__(self, calling_view):
        super().__init__(
            title='Edit Player Board Post',
            timeout=600
        )
        self.calling_view = calling_view
        post = calling_view.selected_post
        self.title_text_input = discord.ui.TextInput(
            label='Title',
            custom_id='title_text_input',
            placeholder='Enter a title for your post',
            default=post['title'],
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
            await self.calling_view.edit_post(title, content, interaction)
        except Exception as e:
            await log_exception(e, interaction)
