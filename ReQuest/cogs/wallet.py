from datetime import datetime

import discord
import shortuuid
from discord import app_commands
from discord.ext.commands import Cog

from ..utilities.checks import has_gm_or_mod, has_active_character
from ..utilities.supportFunctions import strip_id
from ..utilities.ui import SingleChoiceDropdown, DropdownView

listener = Cog.listener


class Wallet(Cog):
    def __init__(self, bot):
        self.bot = bot
        self.gdb = bot.gdb
        self.mdb = bot.mdb
        
    currency_group = app_commands.Group(name='currency', description='Commands for manipulation of character ledgers.')

    @currency_group.command(name='view')
    async def currency_view(self, interaction: discord.Interaction, private: bool = False):
        """
        Commands for management of currency.
        """
        user_id = interaction.user.id
        guild_id = interaction.guild_id
        member_collection = self.mdb['characters']
        guild_collection = self.gdb['currency']
        character_query = await member_collection.find_one({'_id': user_id})
        currency_query = await guild_collection.find_one({'_id': guild_id})
        currency_names = []
        error_title = None
        error_message = None

        if not currency_query:
            error_title = 'Your pockets are empty!'
            error_message = 'You have no spendable currency for this server!'
        elif not character_query:
            error_title = 'Error!'
            error_message = 'You do not have any registered characters!'
        elif str(guild_id) not in character_query['activeChars']:
            error_title = 'Error!'
            error_message = 'You do not have an active character for this server!'
        else:
            for currency in currency_query['currencies']:
                currency_names.append(currency['name'].lower())
                if 'denoms' in currency:
                    for denom in currency['denoms']:
                        currency_names.append(denom['name'].lower())

            active_id = character_query['activeChars'][f'{guild_id}']
            character = character_query['characters'][active_id]
            name = character['name']
            inventory = character['attributes']['inventory']

            post_embed = discord.Embed(title=f'{name}\'s Currency', type='rich')

            if inventory is None:
                post_embed.description = f'{name} doesn\'t believe in holding currency.'
            else:
                for currency_type in sorted(inventory):
                    if currency_type.lower() in currency_names:
                        post_embed.add_field(name=f'{currency_type}',
                                             value=f'{inventory[f"{currency_type}"]}', inline=False)

            post_embed.set_footer(text='Yeah, this output sucks. I\'ll have related denominations nested more'
                                       ' cleanly in a future patch.')
            await interaction.response.send_message(embed=post_embed, ephemeral=private)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    @has_gm_or_mod()
    @currency_group.command(name='mod')
    async def currency_mod(self, interaction: discord.Interaction, user_mention: str, currency_name: str,
                           quantity: int = 1):
        """
        Modifies a player's currently active character's inventory. GM Command.
        Requires an assigned GM role or Server Moderator privileges.

        Arguments:
        <name>: The name of the inventory.
        <quantity>: Quantity to give or take.
        <user_mentions>: User mention(s) of the receiving player(s). Can be chained.
        """
        gm_user_id = interaction.user.id
        guild_id = interaction.guild_id
        character_collection = self.mdb['characters']
        guild_collection = self.gdb['currency']
        transaction_id = str(shortuuid.uuid()[:12])
        error_title = None
        error_message = None

        # Make sure the referenced currency is a valid name used in the server
        currency_query = await guild_collection.find_one({'_id': guild_id})
        # TODO: Extract to validation function
        matches = []
        for currency in currency_query['currencies']:
            if currency_name.lower() in currency['name'].lower():
                matches.append(currency['name'])
            if 'denoms' in currency:
                denominations = currency['denoms']
                for i in range(len(denominations)):
                    if currency_name.lower() in denominations[i]['name'].lower():
                        matches.append(denominations[i]['name'])
        if quantity == 0:
            error_title = 'Invalid Quantity!'
            error_message = 'Stop being a tease and enter an actual quantity!'
        elif not matches:
            error_title = 'Incorrect Currency Name!'
            error_message = 'No currency with that name is used on this server!'
        else:
            member_id = strip_id(user_mention)
            query = await character_collection.find_one({'_id': member_id})
            active_character = query['activeChars'][str(guild_id)]
            inventory = query['characters'][active_character]['attributes']['inventory']

            if len(matches) == 1:
                cname = matches[0]
            else:
                options = []
                for match in matches:
                    options.append(discord.SelectOption(label=match))
                select = SingleChoiceDropdown(placeholder='Choose One', options=options)
                view = DropdownView(select)
                if not interaction.response.is_done():  # Make sure this is the first response
                    await interaction.response.send_message(f'Multiple matches found for {currency_name}!',
                                                            view=view, ephemeral=True)
                else:  # If the interaction has been responded to, update the original message
                    await interaction.edit_original_response(
                        content=f'Multiple matches found for {currency_name}!', view=view)
                await view.wait()
                cname = select.values[0]

            if cname in inventory:
                current_quantity = inventory[cname]
                new_quantity = current_quantity + quantity
                if new_quantity == 0:
                    await character_collection.update_one({'_id': member_id}, {
                        '$unset': {f'characters.{active_character}.attributes.inventory.{cname}': ''}}, upsert=True)
                else:
                    await character_collection.update_one({'_id': member_id}, {
                        '$set': {f'characters.{active_character}.attributes.inventory.{cname}': new_quantity}},
                                                          upsert=True)
            else:
                await character_collection.update_one({'_id': member_id}, {
                    '$set': {f'characters.{active_character}.attributes.inventory.{cname}': quantity}}, upsert=True)

            recipient_string = f'<@!{member_id}> as {query["characters"][active_character]["name"]}'

            currency_embed = discord.Embed(type='rich')
            if quantity > 0:
                currency_embed.title = 'Currency Awarded!'
            elif quantity < 0:
                currency_embed.title = 'Currency Removed!'
            currency_embed.description = f'Currency: **{cname}**\nQuantity: **{abs(quantity)}**'
            currency_embed.add_field(name="Recipient", value=recipient_string)
            currency_embed.add_field(name='Game Master', value=f'<@!{gm_user_id}>', inline=False)
            currency_embed.set_footer(text=f'{datetime.utcnow().strftime("%Y-%m-%d")} Transaction ID: {transaction_id}')
            if interaction.response.is_done():
                await interaction.edit_original_response(content=None, embed=currency_embed, view=None)
            else:
                await interaction.response.send_message(embed=currency_embed)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    @has_active_character()
    @currency_group.command(name='give')
    async def currency_give(self, interaction: discord.Interaction, user_mention: str, currency_name: str,
                            quantity: int = 1):
        """
        Gives currency from your active character to another player's active character.

        Arguments:
        <user_mention>: The recipient of the currency.
        <currency_name>: The name of the currency.
        [quantity]: The amount of currency to give. Defaults to 1 if not specified.
        """
        donor_id = interaction.user.id
        recipient_id = strip_id(user_mention)
        guild_id = interaction.guild_id
        guild_collection = self.gdb['currency']
        character_collection = self.mdb['characters']
        recipient_query = await character_collection.find_one({'_id': recipient_id})

        error_title = None
        error_message = None

        # Make sure the referenced currency is a valid name used in the server
        guild_currencies = await guild_collection.find_one({'_id': guild_id})
        # TODO: Multiple-match logic
        valid = False
        cname = ''
        for currency_type in guild_currencies['currencies']:
            if currency_name.lower() in currency_type['name'].lower():
                cname = currency_type['name']
                valid = True
            if 'denoms' in currency_type:
                denominations = currency_type['denoms']
                for i in range(len(denominations)):
                    if currency_name.lower() in denominations[i]['name'].lower():
                        cname = denominations[i]['name']
                        valid = True
        if not valid:
            error_title = 'Error!'
            error_message = 'No currency with that name is used on this server!'
        elif not recipient_query:
            error_title = 'Error!'
            error_message = f'{user_mention} does not have any registered characters!'
        elif str(guild_id) not in recipient_query['activeChars']:
            error_title = 'Error!'
            error_message = f'{user_mention} does not have an active character on this server!'
        else:
            transaction_id = str(shortuuid.uuid()[:12])
            donor_query = await character_collection.find_one({'_id': donor_id})
            donor_active = donor_query['activeChars'][str(guild_id)]
            inventory = donor_query['characters'][donor_active]['attributes']['inventory']

            if cname not in inventory:
                error_title = 'Invalid Currency!'
                error_message = f'`{currency_name}` was not found in your wallet. Check your spelling!'
            else:  # First make sure the player has the currency
                source_current_quantity = int(inventory[cname])
                if source_current_quantity < quantity:  # Make sure the player has enough to give
                    error_title = 'Quantity Error!'
                    error_message = 'You are attempting to give more than you have. Check your wallet!'
                else:
                    new_quantity = source_current_quantity - quantity
                    if new_quantity == 0:  # If the transaction results in a 0 quantity, pull the currency.
                        await character_collection.update_one({'_id': donor_id}, {
                            '$unset': {f'characters.{donor_active}.attributes.inventory.{cname}': ''}}, upsert=True)
                    else:  # Otherwise, just update the donor's quantity
                        await character_collection.update_one({'_id': donor_id},
                                                              {'$set': {f'characters.{donor_active}.attributes.'
                                                                        f'inventory.{cname}': new_quantity}},
                                                              upsert=True)

                    recipient_active = recipient_query['activeChars'][str(guild_id)]
                    recipient_inventory = recipient_query['characters'][recipient_active]['attributes']['inventory']
                    if cname in recipient_inventory:  # Check to see if the recipient has the currency already
                        recipient_current_quantity = recipient_inventory[cname]
                        new_quantity = recipient_current_quantity + quantity  # Add to the quantity if they do
                    else:  # If not, simply set the quantity given.
                        new_quantity = quantity

                    await character_collection.update_one({'_id': recipient_id},
                                                          {'$set': {f'characters.{recipient_active}.attributes.'
                                                                    f'inventory.{cname}': new_quantity}},
                                                          upsert=True)

                    trade_embed = discord.Embed(
                        title='Trade Completed!',
                        type='rich',
                        description=f'<@!{donor_id}> as **{donor_query["characters"][donor_active]["name"]}'
                                    f'**\n\ngives **{quantity} {cname}** to\n\n<@!{recipient_id}> as '
                                    f'**{recipient_query["characters"][recipient_active]["name"]}**')
                    trade_embed.set_footer(text=f'{datetime.utcnow().strftime("%Y-%m-%d")} '
                                                f'Transaction ID: {transaction_id}')

                    await interaction.response.send_message(embed=trade_embed)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    @has_active_character()
    @currency_group.command(name='spend')
    async def currency_spend(self, interaction: discord.Interaction, currency_name: str, quantity: int = 1):
        """
        Spends (consumes) a given quantity of your active character's currency.

        Currently, requires individual spending of currencies. Related denominations will be automatically consumed
        in a future update.

        Arguments:
        <currency_name>: Name of the currency to spend.
        <quantity>: The amount to spend.
        """
        member_id = interaction.user.id
        guild_id = interaction.guild_id
        guild_collection = self.gdb['currency']
        character_collection = self.mdb['characters']
        error_title = None
        error_message = None

        # Make sure the referenced currency is a valid name used in the server
        guild_currencies = await guild_collection.find_one({'_id': guild_id})
        # TODO: Multiple-match logic
        valid = False
        cname = ''
        for currency_type in guild_currencies['currencies']:
            if currency_name.lower() in currency_type['name'].lower():
                cname = currency_type['name']
                valid = True
            if 'denoms' in currency_type:
                denominations = currency_type['denoms']
                for i in range(len(denominations)):
                    if currency_name.lower() in denominations[i]['name'].lower():
                        cname = denominations[i]['name']
                        valid = True

        if not valid:
            error_title = 'Incorrect Currency!'
            error_message = 'No currency with that name is used on this server!'
        else:
            query = await character_collection.find_one({'_id': member_id})
            active_character = query['activeChars'][f'{guild_id}']
            character = query['characters'][active_character]
            name = character['name']
            inventory = character['attributes']['inventory']

            if cname not in inventory:
                error_title = 'Error!'
                error_message = f'`{currency_name}` was not found in your wallet. Check your spelling!'
            else:
                current_quantity = inventory[cname]
                if current_quantity < quantity:
                    error_title = 'Quantity Error!'
                    error_message = f'You do not have enough {cname} in your wallet!'
                else:
                    transaction_id = str(shortuuid.uuid()[:12])
                    new_quantity = current_quantity - quantity
                    if new_quantity == 0:
                        await character_collection.update_one({'_id': member_id}, {
                            '$unset': {f'characters.{active_character}.attributes.inventory.{cname}': ''}}, upsert=True)
                    else:
                        await character_collection.update_one({'_id': member_id}, {
                            '$set': {f'characters.{active_character}.attributes.inventory.{cname}': new_quantity}},
                                                              upsert=True)

                    post_embed = discord.Embed(title=f'{name} spends some currency!', type='rich',
                                               description=f'Item: **{cname}**\n'
                                                           f'Quantity: **{quantity}**\n'
                                                           f'Balance: **{new_quantity}**')
                    post_embed.set_footer(text=f'{datetime.utcnow().strftime("%Y-%m-%d")}'
                                               f' Transaction ID: {transaction_id}')

                    await interaction.response.send_message(embed=post_embed)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)


async def setup(bot):
    await bot.add_cog(Wallet(bot))
