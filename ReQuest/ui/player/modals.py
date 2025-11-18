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
    check_sufficient_funds,
    update_character_inventory, format_currency_display, setup_view
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
                sender_balance_str = '\n'.join(format_currency_display(sender_currency, currency_query)) or "None"
                receiver_currency_str = '\n'.join(format_currency_display(receiver_currency, currency_query)) or "None"
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


class CharacterRegisterModal(Modal):
    def __init__(self):
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

    async def on_submit(self, interaction: discord.Interaction):
        try:
            character_id = str(shortuuid.uuid())
            collection = interaction.client.mdb['characters']
            member_id = interaction.user.id
            guild_id = interaction.guild_id
            date = datetime.now(timezone.utc)
            character_name = self.name_text_input.value
            character_note = self.note_text_input.value

            await collection.update_one({'_id': member_id},
                                        {'$set': {f'activeCharacters.{guild_id}': character_id,
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

            await interaction.response.send_message(f'{character_name} was born!', ephemeral=True, delete_after=10)
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
            amount = float(self.currency_amount_text_input.value.strip())

            if amount <= 0:
                raise ValueError('You must spend a positive amount.')

            member_id = interaction.user.id
            guild_id = interaction.guild_id
            mdb = interaction.client.mdb
            gdb = interaction.client.gdb

            character_query = await mdb['characters'].find_one({'_id': member_id})
            if not character_query or str(guild_id) not in character_query['activeCharacters']:
                raise Exception("You do not have an active character on this server.")

            active_character_id = character_query['activeCharacters'][str(guild_id)]
            player_currency = character_query['characters'][active_character_id]['attributes'].get('currency', {})

            currency_config = await gdb['currency'].find_one({'_id': guild_id})
            if not currency_config:
                raise Exception("Currency is not configured on this server.")

            can_afford, message = check_sufficient_funds(player_currency, currency_config, currency_name, amount)
            if not can_afford:
                raise Exception(message)

            await update_character_inventory(interaction, member_id, active_character_id, currency_name, -amount)

            await setup_view(self.calling_view, interaction)

            await interaction.response.edit_message(view=self.calling_view)
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
