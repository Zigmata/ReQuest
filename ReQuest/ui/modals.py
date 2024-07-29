from datetime import datetime, timezone

import discord
import discord.ui
import shortuuid
from discord.ui import Modal

from .inputs import AddCurrencyDenominationTextInput
from ..utilities.supportFunctions import find_currency_or_denomination, log_exception, trade_currency, trade_item


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


class CharacterRegisterModal(discord.ui.Modal):
    def __init__(self, calling_view, mdb, member_id, guild_id):
        super().__init__(
            title='Register New Character',
            timeout=180
        )
        self.name_text_input = discord.ui.TextInput(
            label='Name',
            style=discord.TextStyle.short,
            custom_id='character_name_text_input',
            placeholder='Enter your character\'s name.',
            max_length=40
        )
        self.note_text_input = discord.ui.TextInput(
            label='Note',
            style=discord.TextStyle.short,
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

            await interaction.response.send_message(f'{character_name} was born!', ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


class AddCurrencyTextModal(discord.ui.Modal):
    def __init__(self, guild_id, gdb, calling_view):
        super().__init__(
            title='Add New Currency',
            timeout=180
        )
        self.calling_view = calling_view
        self.guild_id = guild_id
        self.gdb = gdb
        self.text_input = discord.ui.TextInput(label='Currency Name', style=discord.TextStyle.short, required=True,
                                               custom_id='new_currency_name_text_input')
        self.add_item(self.text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            collection = self.gdb['currency']
            query = await collection.find_one({'_id': self.guild_id})
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
                    await collection.update_one({'_id': self.guild_id},
                                                {'$push': {'currencies': {'name': self.text_input.value,
                                                                          'isDouble': False, 'denominations': []}}},
                                                upsert=True)
                    await self.calling_view.setup_embed()
                    await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
            else:
                await collection.update_one({'_id': self.guild_id},
                                            {'$push': {'currencies': {'name': self.text_input.value,
                                                                      'isDouble': False, 'denominations': []}}},
                                            upsert=True)
                await self.calling_view.setup_embed()
                await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class AddCurrencyDenominationTextModal(discord.ui.Modal):
    def __init__(self, guild_id, gdb, calling_view, base_currency_name):
        super().__init__(
            title=f'Add {base_currency_name} Denomination',
            timeout=300
        )
        self.guild_id = guild_id
        self.gdb = gdb
        self.calling_view = calling_view
        self.base_currency_name = base_currency_name
        self.denomination_name_text_input = AddCurrencyDenominationTextInput(input_type='Name',
                                                                             placeholder='e.g., Silver')
        self.denomination_value_text_input = AddCurrencyDenominationTextInput(input_type='Value',
                                                                              placeholder='e.g., 0.1')
        self.add_item(self.denomination_name_text_input)
        self.add_item(self.denomination_value_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            new_name = self.denomination_name_text_input.value
            collection = self.gdb['currency']
            query = await collection.find_one({'_id': self.guild_id})
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

            await collection.update_one({'_id': self.guild_id, 'currencies.name': self.base_currency_name},
                                        {'$push': {'currencies.$.denominations': {
                                            'name': new_name,
                                            'value': float(self.denomination_value_text_input.value)}}},
                                        upsert=True)
            await self.calling_view.setup_select()
            await self.calling_view.setup_embed(self.base_currency_name)
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class AllowServerModal(discord.ui.Modal):
    def __init__(self, cdb, calling_view, bot):
        super().__init__(
            title='Add Server ID to Allowlist',
            timeout=180
        )
        self.cdb = cdb
        self.calling_view = calling_view
        self.allow_server_name_input = discord.ui.TextInput(
            label='Server Name',
            style=discord.TextStyle.short,
            custom_id='allow_server_name_input',
            placeholder='Type a short name for the Discord Server',
            required=True
        )
        self.allow_server_id_input = discord.ui.TextInput(
            label='Server ID',
            style=discord.TextStyle.short,
            custom_id='allow_server_text_input',
            placeholder='Type the ID of the Discord Server',
            required=True
        )
        self.add_item(self.allow_server_name_input)
        self.add_item(self.allow_server_id_input)
        self.bot = bot

    async def on_submit(self, interaction: discord.Interaction):
        try:
            input_name = self.allow_server_name_input.value
            guild_id = int(self.allow_server_id_input.value)
            collection = self.cdb['serverAllowlist']
            self.bot.allow_list.append(guild_id)
            await collection.update_one({'servers': {'$exists': True}},
                                        {'$push': {'servers': {'name': input_name, 'id': guild_id}}},
                                        upsert=True)
            await self.calling_view.setup_select()
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class AdminCogTextModal(discord.ui.Modal):
    def __init__(self, function, on_submit):
        super().__init__(
            title=f'{function.capitalize()} Cog',
            timeout=180
        )
        self.text_input = discord.ui.TextInput(label='Name', style=discord.TextStyle.short,
                                               placeholder=f'Enter the name of the Cog to {function}',
                                               custom_id='cog_name_text_input', required=True)
        self.add_item(self.text_input)
        self._on_submit = on_submit

    async def on_submit(self, interaction: discord.Interaction):
        try:
            await self._on_submit(interaction, self.text_input.value)
        except Exception as e:
            await log_exception(e, interaction)
