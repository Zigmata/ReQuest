import logging

import discord
import shortuuid

from .supportFunctions import log_exception, find_currency_or_denomination
from ..cogs.inventory import trade_item, trade_currency

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


# -------- BUTTONS --------
class ConfigBackButton(discord.ui.Button):
    def __init__(self, returning_view_class, guild_id, db, setup_embed=True, setup_select=True):
        super().__init__(
            label='Back',
            style=discord.ButtonStyle.primary,
            custom_id='back_button')
        self.guild_id = guild_id
        self.db = db
        self.returning_view_class = returning_view_class
        self.setup_embed = setup_embed
        self.setup_select = setup_select

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.returning_view_class(self.guild_id, self.db)
            if hasattr(new_view, 'setup_select') and self.setup_select:
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed') and self.setup_embed:
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class AdminBackButton(discord.ui.Button):
    def __init__(self, returning_view_class, cdb, bot, setup_embed=True, setup_select=True):
        super().__init__(
            label='Back',
            style=discord.ButtonStyle.primary,
            custom_id='back_button')
        self.cdb = cdb
        self.bot = bot
        self.returning_view_class = returning_view_class
        self.setup_embed = setup_embed
        self.setup_select = setup_select

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.returning_view_class(self.cdb, self.bot)
            if hasattr(new_view, 'setup_select') and self.setup_select:
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed') and self.setup_embed:
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class PlayerBackButton(discord.ui.Button):
    def __init__(self, returning_view_class, mdb, bot, member_id, guild_id, setup_embed=True, setup_select=True):
        super().__init__(
            label='Back',
            style=discord.ButtonStyle.primary,
            custom_id='back_button')
        self.mdb = mdb
        self.bot = bot
        self.member_id = member_id
        self.guild_id = guild_id
        self.returning_view_class = returning_view_class
        self.setup_embed = setup_embed
        self.setup_select = setup_select

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.returning_view_class(self.mdb, self.bot, self.member_id, self.guild_id)
            if hasattr(new_view, 'setup_select') and self.setup_select:
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed') and self.setup_embed:
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class ConfigMenuButton(discord.ui.Button):
    def __init__(self, submenu_view_class, label, guild_id, gdb):
        super().__init__(
            label=label,
            style=discord.ButtonStyle.primary,
            custom_id=f'config_{label.lower()}_button'
        )
        self.guild_id = guild_id
        self.gdb = gdb
        self.submenu_view_class = submenu_view_class

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.submenu_view_class(self.guild_id, self.gdb)
            await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class AdminMenuButton(discord.ui.Button):
    def __init__(self, submenu_view_class, label, cdb, bot, setup_select=True, setup_embed=True):
        super().__init__(
            label=label,
            style=discord.ButtonStyle.primary,
            custom_id=f'admin_{label.lower()}_button'
        )
        self.cdb = cdb
        self.submenu_view_class = submenu_view_class
        self.bot = bot
        self.setup_select = setup_select
        self.setup_embed = setup_embed

    async def callback(self, interaction: discord.Interaction, ):
        try:
            new_view = self.submenu_view_class(self.cdb, self.bot)
            if hasattr(new_view, 'setup_select') and self.setup_select:
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed') and self.setup_embed:
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class PlayerMenuButton(discord.ui.Button):
    def __init__(self, submenu_view_class, label, mdb, bot, member_id, guild_id, setup_select=True, setup_embed=True):
        super().__init__(
            label=label,
            style=discord.ButtonStyle.primary,
            custom_id=f'player_{label.lower()}_button'
        )
        self.submenu_view_class = submenu_view_class
        self.mdb = mdb
        self.bot = bot
        self.member_id = member_id
        self.guild_id = guild_id
        self.setup_select = setup_select
        self.setup_embed = setup_embed

    async def callback(self, interaction: discord.Interaction, ):
        try:
            new_view = self.submenu_view_class(self.mdb, self.bot, self.member_id, self.guild_id)
            if hasattr(new_view, 'setup_select') and self.setup_select:
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed') and self.setup_embed:
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class MenuDoneButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Done',
            style=discord.ButtonStyle.gray,
            custom_id='done_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            for child in self.calling_view.children.copy():
                self.calling_view.remove_item(child)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


# -------- SELECTS --------


class SingleChannelConfigSelect(discord.ui.ChannelSelect):
    def __init__(self, calling_view, config_type, config_name, guild_id, gdb):
        super().__init__(
            channel_types=[discord.ChannelType.text],
            placeholder=f'Search for your {config_name} Channel',
            custom_id=f'config_{config_type}_channel_select'
        )
        self.calling_view = calling_view
        self.config_type = config_type
        self.guild_id = guild_id
        self.gdb = gdb

    async def callback(self, interaction: discord.Interaction):
        try:
            collection = self.gdb[self.config_type]
            await collection.update_one({'_id': self.guild_id}, {'$set': {self.config_type: self.values[0].mention}},
                                        upsert=True)
            await self.calling_view.setup_embed()
            return await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)

# -------- MODALS --------


class TradeModal(discord.ui.Modal):
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

    def format_currency_string(self, currency_dict):
        if not currency_dict:
            return "No currency"
        return ", ".join([f"{amount} {name}" for name, amount in currency_dict.items()])
