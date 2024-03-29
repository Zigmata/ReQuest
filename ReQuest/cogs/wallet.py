from datetime import datetime

import discord
import shortuuid
from discord.ext import commands
from discord.ext.commands import Cog

from ..utilities.checks import has_gm_or_mod, has_active_character
from ..utilities.supportFunctions import strip_id

listener = Cog.listener


class Wallet(Cog):
    def __init__(self, bot):
        self.bot = bot
        self.gdb = bot.gdb
        self.mdb = bot.mdb

    @commands.group(aliases=['c'], case_insensitive=True, invoke_without_subcommand=True)
    async def currency(self, ctx):
        """
        Commands for management of currency.
        """
        if ctx.invoked_subcommand is None:
            member_id = ctx.author.id
            guild_id = ctx.message.guild.id
            collection = self.mdb['characters']
            guild_collection = self.gdb['currency']
            query = await collection.find_one({'_id': member_id})
            currency_query = await guild_collection.find_one({'_id': guild_id})
            currency_names = []
            
            if currency_query:
                for currency in currency_query['currencies']:
                    currency_names.append(currency['name'].lower())
                    if 'denoms' in currency:
                        for denom in currency['denoms']:
                            currency_names.append(denom['name'].lower())
            else:
                await ctx.send('You have no spendable currency for this server!')
                return

            if not query:
                await ctx.send('You do not have any registered characters!')
                return
            elif str(guild_id) not in query['activeChars']:
                await ctx.send('You do not have an active character for this server!')
                return

            active_id = query['activeChars'][f'{guild_id}']
            character = query['characters'][active_id]
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
            await ctx.send(embed=post_embed)

    @currency.command(name='mod')
    @has_gm_or_mod()
    async def currency_mod(self, ctx, currency_name, quantity: int, *user_mentions):
        """
        Modifies a player's currently active character's inventory. GM Command.
        Requires an assigned GM role or Server Moderator privileges.

        Arguments:
        <name>: The name of the inventory.
        <quantity>: Quantity to give or take.
        <user_mentions>: User mention(s) of the receiving player(s). Can be chained.
        """
        if quantity == 0:
            await ctx.send('Stop being a tease and enter an actual quantity!')
            return

        gm_member_id = ctx.author.id
        guild_id = ctx.message.guild.id
        character_collection = self.mdb['characters']
        guild_collection = self.gdb['currency']
        transaction_id = str(shortuuid.uuid()[:12])

        # Make sure the referenced inventory is a valid name used in the server
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
            await ctx.send('No inventory with that name is used on this server!')
            return

        members = []
        for user in user_mentions:
            members.append(strip_id(user))

        recipient_strings = []
        for member_id in members:
            query = await character_collection.find_one({'_id': member_id})
            active_character = query['activeChars'][str(guild_id)]
            inventory = query['characters'][active_character]['attributes']['inventory']
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

            recipient_strings.append(f'<@!{member_id}> as {query["characters"][active_character]["name"]}')

        currency_embed = discord.Embed(type='rich')
        if len(user_mentions) > 1:
            if quantity > 0:
                currency_embed.title = 'Currency Awarded!'
            elif quantity < 0:
                currency_embed.title = 'Currency Removed!'
            currency_embed.description = f'Currency: **{cname}**\nQuantity: **{abs(quantity)}** each'
            currency_embed.add_field(name="Recipients", value='\n'.join(recipient_strings))
        else:
            if quantity > 0:
                currency_embed.title = 'Currency Awarded!'
            elif quantity < 0:
                currency_embed.title = 'Currency Removed!'
            currency_embed.description = f'Currency: **{cname}**\nQuantity: **{abs(quantity)}**'
            currency_embed.add_field(name="Recipient", value='\n'.join(recipient_strings))
        currency_embed.add_field(name='Game Master', value=f'<@!{gm_member_id}>', inline=False)
        currency_embed.set_footer(text=f'{datetime.utcnow().strftime("%Y-%m-%d")} Transaction ID: {transaction_id}')
        await ctx.send(embed=currency_embed)

    @currency.command(name='give')
    @has_active_character()
    async def currency_give(self, ctx, user_mention, currency_name, quantity: int = 1):
        """
        Gives currency from your active character to another player's active character.

        Arguments:
        <user_mention>: The recipient of the currency.
        <currency_name>: The name of the currency.
        [quantity]: The amount of currency to give. Defaults to 1 if not specified.
        """
        donor_id = ctx.author.id
        recipient_id = strip_id(user_mention)
        guild_id = ctx.message.guild.id
        guild_collection = self.gdb['currency']
        character_collection = self.mdb['characters']

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
            await ctx.send('No currency with that name is used on this server!')
            return

        recipient_query = await character_collection.find_one({'_id': recipient_id})
        if not recipient_query:
            await ctx.send('That player does not have any registered characters!')
            return

        if str(guild_id) not in recipient_query['activeChars']:
            await ctx.send('That player does not have an active character on this server!')
            return

        transaction_id = str(shortuuid.uuid()[:12])
        donor_query = await character_collection.find_one({'_id': donor_id})
        donor_active = donor_query['activeChars'][str(guild_id)]
        inventory = donor_query['characters'][donor_active]['attributes']['inventory']
        if cname in inventory:  # First make sure the player has the currency
            source_current_quantity = int(inventory[cname])
            if source_current_quantity >= quantity:  # Then make sure the player has enough to give
                new_quantity = source_current_quantity - quantity
                if new_quantity == 0:  # If the transaction results in a 0 quantity, pull the currency.
                    await character_collection.update_one({'_id': donor_id}, {
                        '$unset': {f'characters.{donor_active}.attributes.inventory.{cname}': ''}}, upsert=True)
                else:  # Otherwise, just update the donor's quantity
                    await character_collection.update_one({'_id': donor_id}, {
                        '$set': {f'characters.{donor_active}.attributes.inventory.{cname}': new_quantity}}, upsert=True)

                recipient_active = recipient_query['activeChars'][str(guild_id)]
                recipient_inventory = recipient_query['characters'][recipient_active]['attributes']['inventory']
                if cname in recipient_inventory:  # Check to see if the recipient has the currency already
                    recipient_current_quantity = recipient_inventory[cname]
                    new_quantity = recipient_current_quantity + quantity  # Add to the quantity if they do
                else:  # If not, simply set the quantity given.
                    new_quantity = quantity

                await character_collection.update_one({'_id': recipient_id}, {
                    '$set': {f'characters.{recipient_active}.attributes.inventory.{cname}': new_quantity}}, upsert=True)
            else:
                await ctx.send('You are attempting to give more than you have. Check your wallet!')
                return
        else:
            await ctx.send(f'`{currency_name}` was not found in your wallet. Check your spelling!')
            return

        trade_embed = discord.Embed(title='Trade Completed!', type='rich',
                                    description=f'<@!{donor_id}> as '
                                                f'**{donor_query["characters"][donor_active]["name"]}**\n\n'
                                                f'gives **{quantity} {cname}** to\n\n<@!{recipient_id}> as '
                                                f'**{recipient_query["characters"][recipient_active]["name"]}**')
        trade_embed.set_footer(text=f'{datetime.utcnow().strftime("%Y-%m-%d")} Transaction ID: {transaction_id}')

        await ctx.send(embed=trade_embed)

    @currency.command(name='spend')
    @has_active_character()
    async def currency_spend(self, ctx, currency_name, quantity: int):
        """
        Spends (consumes) a given quantity of your active character's currency.

        Currently, requires individual spending of currencies. Related denominations will be automatically consumed
        in a future update.

        Arguments:
        <currency_name>: Name of the currency to spend.
        <quantity>: The amount to spend.
        """
        member_id = ctx.author.id
        guild_id = ctx.message.guild.id
        guild_collection = self.gdb['currency']
        character_collection = self.mdb['characters']

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
            await ctx.send('No currency with that name is used on this server!')
            return

        query = await character_collection.find_one({'_id': member_id})
        active_character = query['activeChars'][f'{guild_id}']
        character = query['characters'][active_character]
        name = character['name']
        inventory = character['attributes']['inventory']

        if cname in inventory:
            current_quantity = inventory[cname]
            if current_quantity >= quantity:
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
                post_embed.set_footer(text=f'{datetime.utcnow().strftime("%Y-%m-%d")} Transaction ID: {transaction_id}')

                await ctx.send(embed=post_embed)
            else:
                await ctx.send(f'You do not have enough {cname} in your wallet!')
        else:
            await ctx.send(f'`{currency_name}` was not found in your wallet. Check your spelling!')


async def setup(bot):
    await bot.add_cog(Wallet(bot))
