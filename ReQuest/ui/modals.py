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

    async def on_submit(self, interaction):
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


    async def on_submit(self, interaction):
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
        self.denomination_name_text_input = AddCurrencyDenominationTextInput(input_type='Name',
                                                                             placeholder='e.g., Silver')
        self.denomination_value_text_input = AddCurrencyDenominationTextInput(input_type='Value',
                                                                              placeholder='e.g., 0.1')
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


class AllowServerModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title='Add Server ID to Allowlist',
            timeout=180
        )
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

    async def on_submit(self, interaction):
        try:
            input_name = self.allow_server_name_input.value
            guild_id = int(self.allow_server_id_input.value)
            collection = interaction.client.cdb['serverAllowlist']
            interaction.client.allow_list.append(guild_id)
            await collection.update_one({'servers': {'$exists': True}},
                                        {'$push': {'servers': {'name': input_name, 'id': guild_id}}},
                                        upsert=True)
            await self.calling_view.setup(bot=interaction.client)
            await self.calling_view.embed.add_field(name=f'{input_name} added to allowlist', value=f'ID: `{guild_id}`')
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class AdminCogTextModal(Modal):
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

    async def on_submit(self, interaction):
        try:
            await self._on_submit(interaction, self.text_input.value)
        except Exception as e:
            await log_exception(e, interaction)


class SpendCurrencyModal(Modal):
    def __init__(self, calling_view):
        super().__init__(
            title=f'Spend Currency',
            timeout=180
        )
        self.calling_view = calling_view
        self.currency_name_text_input = discord.ui.TextInput(label='Currency Name',
                                                             style=discord.TextStyle.short,
                                                             placeholder=f'Enter the name of the currency you are '
                                                                         f'spending',
                                                             custom_id='currency_name_text_input',
                                                             required=True)
        self.currency_amount_text_input = discord.ui.TextInput(label='Amount',
                                                               style=discord.TextStyle.short,
                                                               placeholder='Enter the amount to spend',
                                                               custom_id='currency_amount_text_input',
                                                               required=True)
        self.add_item(self.currency_name_text_input)
        self.add_item(self.currency_amount_text_input)

    async def on_submit(self, interaction):
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


class CreateQuestModal(Modal):
    def __init__(self, quest_view_class):
        super().__init__(
            title='Create New Quest',
            timeout=None
        )
        self.quest_view_class = quest_view_class
        self.quest_title_text_input = discord.ui.TextInput(label='Quest Title',
                                                           custom_id='quest_title_text_input',
                                                           placeholder='Title of your quest')
        self.quest_restrictions_text_input = discord.ui.TextInput(label='Restrictions',
                                                                  custom_id='quest_restrictions_text_input',
                                                                  placeholder='Restrictions, if any, such as player '
                                                                              'levels',
                                                                  required=False)
        self.quest_party_size_text_input = discord.ui.TextInput(label='Maximum Party Size',
                                                                custom_id='quest_party_size_text_input',
                                                                placeholder='Max size of the party for this quest',
                                                                max_length=2)
        self.quest_party_role_text_input = discord.ui.TextInput(label='Party Role',
                                                                custom_id='quest_party_role',
                                                                placeholder='Create a role for this quest (Optional)',
                                                                required=False)
        self.quest_description_text_input = discord.ui.TextInput(label='Description',
                                                                 style=discord.TextStyle.paragraph,
                                                                 custom_id='quest_description_text_input',
                                                                 placeholder='Write the details of your quest here')

        self.add_item(self.quest_title_text_input)
        self.add_item(self.quest_restrictions_text_input)
        self.add_item(self.quest_party_size_text_input)
        self.add_item(self.quest_party_role_text_input)
        self.add_item(self.quest_description_text_input)

    async def on_submit(self, interaction):
        try:
            title = self.quest_title_text_input.value
            restrictions = self.quest_restrictions_text_input.value
            max_party_size = int(self.quest_party_size_text_input.value)
            party_role_name = self.quest_party_role_text_input.value
            description = self.quest_description_text_input.value

            guild = interaction.guild
            guild_id = guild.id
            quest_id = str(shortuuid.uuid()[:8])
            bot = interaction.client
            max_wait_list_size = 0

            # Validate the party role name, if provided
            party_role_id = None
            if party_role_name:
                default_forbidden_names = [
                    'everyone',
                    'administrator',
                    'game master',
                    'gm',
                ]
                custom_forbidden_names = []
                config_collection = interaction.client.gdb['forbiddenRoles']
                config_query = await config_collection.find_one({'_id': interaction.guild_id})
                if config_query and config_query['forbiddenRoles']:
                    for name in config_query['forbiddenRoles']:
                        custom_forbidden_names.append(name)

                if (party_role_name.lower() in default_forbidden_names or
                        party_role_name.lower() in custom_forbidden_names):
                    raise Exception('The name provided for the party role is forbidden.')

                for role in guild.roles:
                    if role.name.lower() == party_role_name.lower():
                        raise Exception('The name provided for the party role already exists on this server!')

                party_role = await guild.create_role(
                    name=party_role_name,
                    reason=f'Automated party role creation from ReQuest for quest ID {quest_id}. Requested by '
                           f'game master: {interaction.user.mention}.'
                )
                party_role_id = party_role.id

            # Get the server's wait list configuration
            wait_list_query = await bot.gdb['questWaitList'].find_one({'_id': guild_id})
            if wait_list_query:
                max_wait_list_size = wait_list_query['questWaitList']

            # Query the collection to see if a channel is set
            quest_channel_query = await bot.gdb['questChannel'].find_one({'_id': guild_id})

            # Inform user if quest channel is not set. Otherwise, get the channel string
            if not quest_channel_query:
                raise Exception('A channel has not yet been designated for quest posts. Contact a server admin to '
                                'configure the Quest Channel.')
            else:
                quest_channel_mention = quest_channel_query['questChannel']

            # Query the collection to see if a role is set
            announce_role_query = await bot.gdb['announceRole'].find_one({'_id': guild_id})

            # Grab the announcement role, if configured.
            announce_role = None
            if announce_role_query:
                announce_role = announce_role_query['announceRole']

            quest_collection = bot.gdb['quests']
            # Get the channel object.
            quest_channel = bot.get_channel(strip_id(quest_channel_mention))

            # Log the author, then post the new quest with an emoji reaction.
            author_id = interaction.user.id
            party: [int] = []
            wait_list: [int] = []
            lock_state = False

            # If an announcement role is set, ping it and then delete the message.
            if announce_role != 0:
                ping_msg = await quest_channel.send(f'{announce_role} **NEW QUEST!**')
                await ping_msg.delete()

            quest = {
                'guildId': guild_id,
                'questId': quest_id,
                'messageId': 0,
                'title': title,
                'description': description,
                'maxPartySize': max_party_size,
                'restrictions': restrictions,
                'gm': author_id,
                'party': party,
                'partyRoleId': party_role_id,
                'waitList': wait_list,
                'maxWaitListSize': max_wait_list_size,
                'lockState': lock_state,
                'rewards': {}
            }

            view = self.quest_view_class(quest)
            await view.setup()
            msg = await quest_channel.send(embed=view.embed, view=view)
            quest['messageId'] = msg.id

            await quest_collection.insert_one(quest)
            await interaction.response.send_message(f'Quest `{quest_id}`: **{title}** posted!', ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestModal(Modal):
    def __init__(self, calling_view, quest, quest_post_view_class):
        super().__init__(
            title=f'Editing {quest['title']}',
            timeout=600
        )

        # Get the current quest's values
        self.calling_view = calling_view
        self.quest = quest
        self.quest_post_view_class = quest_post_view_class
        title = quest['title']
        restrictions = quest['restrictions']
        max_party_size = quest['maxPartySize']
        description = quest['description']

        # Build the text inputs w/ the existing values
        self.title_text_input = discord.ui.TextInput(
            label='Title',
            style=discord.TextStyle.short,
            default=title,
            custom_id='title_text_input',
            required=False
        )
        self.restrictions_text_input = discord.ui.TextInput(
            label='Restrictions',
            style=discord.TextStyle.short,
            default=restrictions,
            custom_id='restrictions_text_input',
            required=False
        )
        self.max_party_size_text_input = discord.ui.TextInput(
            label='Max Party Size',
            style=discord.TextStyle.short,
            default=max_party_size,
            custom_id='max_party_size_text_input',
            required=False
        )
        self.description_text_input = discord.ui.TextInput(
            label='Description',
            style=discord.TextStyle.paragraph,
            default=description,
            custom_id='description_text_input',
            required=False
        )
        self.add_item(self.title_text_input)
        self.add_item(self.restrictions_text_input)
        self.add_item(self.max_party_size_text_input)
        self.add_item(self.description_text_input)

    async def on_submit(self, interaction):
        try:
            # Push the updates
            gdb = interaction.client.gdb
            guild_id = interaction.guild_id
            quest_collection = gdb['quests']
            await quest_collection.update_one({'guildId': interaction.guild_id, 'questId': self.quest['questId']},
                                              {'$set': {'title': self.title_text_input.value,
                                                        'restrictions': self.restrictions_text_input.value,
                                                        'maxPartySize': int(self.max_party_size_text_input.value),
                                                        'description': self.description_text_input.value}})

            # Get the updated quest
            updated_quest = await quest_collection.find_one({'guildId': interaction.guild_id,
                                                             'questId': self.quest['questId']})

            # Get the quest board channel
            quest_channel_collection = gdb['questChannel']
            quest_channel_query = await quest_channel_collection.find_one({'_id': guild_id})
            quest_channel_id = strip_id(quest_channel_query['questChannel'])
            guild = interaction.client.get_guild(guild_id)
            quest_channel = guild.get_channel(quest_channel_id)

            # Get the original quest post message object and create a new embed
            message = quest_channel.get_partial_message(self.quest['messageId'])

            # Create a fresh quest view, and update the original post message
            quest_view = self.quest_post_view_class(updated_quest)
            await quest_view.setup_embed()
            await message.edit(embed=quest_view.embed, view=quest_view)

            # Reload the UI view
            view = self.calling_view
            await view.setup(bot=interaction.client, user=interaction.user, guild=interaction.guild)
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class RewardsModal(Modal):
    def __init__(self, caller):
        super().__init__(
            title='Add Reward',
            timeout=600
        )
        self.caller = caller
        self.xp_input = discord.ui.TextInput(
            label='Experience Points',
            style=discord.TextStyle.short,
            custom_id='experience_text_input',
            placeholder='Enter a number',
            required=False
        )
        self.item_input = discord.ui.TextInput(
            label='Items',
            style=discord.TextStyle.paragraph,
            custom_id='items_text_input',
            placeholder='{item}: {quantity}\n'
                        '{item2}: {quantity}\n'
                        'etc.',
            required=False
        )
        self.add_item(self.xp_input)
        self.add_item(self.item_input)

    async def on_submit(self, interaction):
        try:
            xp = None
            items = None
            if self.xp_input.value:
                xp = int(self.xp_input.value)
            if self.item_input.value:
                if self.item_input.value.lower() == 'none':
                    items = 'none'
                else:
                    items = {}
                    for item in self.item_input.value.strip().split('\n'):
                        item_name, quantity = item.split(':', 1)
                        items[item_name.strip().capitalize()] = int(quantity.strip())

            logger.debug(f'xp: {xp}, items: {items}')
            await self.caller.modal_callback(interaction, xp, items)
        except Exception as e:
            await log_exception(e, interaction)


class QuestSummaryModal(Modal):
    def __init__(self, calling_button):
        super().__init__(
            title='Add Quest Summary',
            timeout=None
        )
        self.calling_button = calling_button
        self.summary_input = discord.ui.TextInput(
            label='Summary',
            style=discord.TextStyle.paragraph,
            custom_id='summary_input',
            placeholder='Add a story summary of the quest'
        )
        self.add_item(self.summary_input)

    async def on_submit(self, interaction):
        try:
            await self.calling_button.modal_callback(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class CreatePartyRoleModal(Modal):
    def __init__(self, calling_button):
        super().__init__(
            title='Create Party Role',
            timeout=600
        )
        self.calling_button = calling_button
        self.role_name_input = discord.ui.TextInput(
            label='Role Name',
            style=discord.TextStyle.short,
            custom_id='role_name_input',
            placeholder='Name for the new role.'
        )
        self.add_item(self.role_name_input)

    async def on_submit(self, interaction):
        try:
            await self.calling_button.modal_callback(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class ModPlayerModal(Modal):
    def __init__(self, member: discord.Member, character_id, character_data):
        super().__init__(
            title=f'Modifying {member.name}',
            timeout=600
        )
        self.member = member
        self.character_id = character_id
        self.character_data = character_data
        self.experience_text_input = discord.ui.TextInput(
            label='Experience Points',
            placeholder='Enter a positive or negative number.',
            custom_id='experience_text_input',
            required=False
        )
        self.inventory_text_input = discord.ui.TextInput(
            label='Inventory',
            style=discord.TextStyle.paragraph,
            placeholder='{item}: {quantity}\n'
                        '{item2}: {quantity}\n'
                        'etc.',
            custom_id='inventory_text_input',
            required=False
        )
        self.add_item(self.experience_text_input)
        self.add_item(self.inventory_text_input)

    async def on_submit(self, interaction):
        try:
            xp = None
            items = None
            if self.experience_text_input.value:
                xp = int(self.experience_text_input.value)
            if self.inventory_text_input.value:
                items = {}
                for item in self.inventory_text_input.value.strip().split('\n'):
                    item_name, quantity = item.split(':', 1)
                    items[item_name.strip().capitalize()] = int(quantity.strip())

            logger.debug(f'xp: {xp}, items: {items}')

            mod_summary_embed = discord.Embed(
                title=f'GM Player Modification Report',
                description=(
                    f'Game Master: {interaction.user.mention}\n'
                    f'Recipient: {self.member.mention} as `{self.character_data['name']}`'
                ),
                type='rich'
            )

            if xp:
                await update_character_experience(interaction, self.member.id, self.character_id, xp)
                mod_summary_embed.add_field(name='Experience', value=xp)
            if items:
                for item_name, quantity in items.items():
                    await update_character_inventory(interaction, self.member.id, self.character_id,
                                                     item_name, quantity)
                    mod_summary_embed.add_field(name=item_name.lower().capitalize(), value=quantity)

            transaction_id = shortuuid.uuid()[:12]
            mod_summary_embed.set_footer(text=f'Transaction ID: {transaction_id}')

            await interaction.response.send_message(embed=mod_summary_embed, ephemeral=True)
            await self.member.send(embed=mod_summary_embed)
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

    async def on_submit(self, interaction):
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

    async def on_submit(self, interaction):
        try:
            title = self.title_text_input.value
            content = self.content_text_input.value
            await self.calling_view.edit_post(title, content, interaction)
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


class CreateCustomQueueModal(Modal):
    def __init__(self, calling_view):
        self.calling_view = calling_view
        super().__init__(
            title='Create Custom Queue',
            timeout=600
        )
        self.queue_name_text_input = discord.ui.TextInput(
            label='Queue Name',
            custom_id='queue_name_text_input',
            placeholder='Enter a name for your custom queue'
        )
        self.queue_channel_select = discord.ui.ChannelSelect(
            custom_id='queue_channel_select',
            placeholder='Select the channel for this queue',
            channel_types=[discord.ChannelType['text']],
            max_values=1,
            min_values=1,
            required=True
        )
        self.queue_submission_roles_select = discord.ui.RoleSelect(
            custom_id='queue_submission_roles_select',
            placeholder='(Optional) Choose up to 5 roles required to submit to this queue. Default is @everyone.',
            max_values=5,
            min_values=1,
            required=False
        )
        self.queue_approver_roles_select = discord.ui.RoleSelect(
            custom_id='queue_approver_roles_select',
            placeholder='(Optional) Choose up to 5 roles that can approve submissions, in addition to the default of'
                        'anyone with Server Admin permissions.',
            max_values=5,
            min_values=0,
            required=False
        )
        self.queue_log_channel_select = discord.ui.ChannelSelect(
            custom_id='queue_log_channel_select',
            placeholder='(Optional) Select a channel to log queue submissions and approvals.',
            channel_types=[discord.ChannelType['text']],
            max_values=1,
            min_values=0,
            required=False
        )
        self.add_item(self.queue_name_text_input)
        self.add_item(self.queue_channel_select)
        self.add_item(self.queue_submission_roles_select)
        self.add_item(self.queue_approver_roles_select)
        self.add_item(self.queue_log_channel_select)

    async def on_submit(self, interaction):
        try:
            queue_name = self.queue_name_text_input.value
            queue_channel = self.queue_channel_select.values[0]
            submission_roles = (self.queue_submission_roles_select.values
                                if self.queue_submission_roles_select.values
                                else None)
            approver_roles = (self.queue_approver_roles_select.values
                              if self.queue_approver_roles_select.values
                              else None)
            log_channel = (self.queue_log_channel_select.values[0]
                           if self.queue_log_channel_select.values
                           else None)
            await self.calling_view.create_custom_queue(queue_name, queue_channel, submission_roles, approver_roles,
                                                        log_channel, interaction)
        except Exception as e:
            await log_exception(e, interaction)
