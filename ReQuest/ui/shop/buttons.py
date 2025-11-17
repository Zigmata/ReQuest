import discord
import shortuuid
from discord import ButtonStyle
from discord.ui import Button

from ReQuest.utilities.supportFunctions import log_exception, check_sufficient_funds, apply_item_change_local, \
    apply_currency_change_local, format_currency_display


class ShopItemButton(Button):
    def __init__(self, item):
        super().__init__(
            label=f'Buy for {item["price"]} {item["currency"]}',
            style=ButtonStyle.primary,
            custom_id=f'shop_item_button_{item["name"]}'
        )
        self.item = item

    async def callback(self, interaction: discord.Interaction):
        try:
            mdb = interaction.client.mdb
            gdb = interaction.client.gdb
            member_id = interaction.user.id
            guild_id = interaction.guild_id

            character_query = await mdb['characters'].find_one({'_id': member_id})
            if not character_query:
                raise Exception("You do not have any characters.")
            if str(guild_id) not in character_query['activeCharacters']:
                raise Exception("You do not have an active character on this server.")

            active_character_id = character_query['activeCharacters'][str(guild_id)]
            character_data = character_query['characters'][active_character_id]

            currency_config = await gdb['currency'].find_one({'_id': guild_id})
            if not currency_config:
                raise Exception("Currency is not configured on this server.")

            item_cost = float(self.item['price'])
            item_currency = self.item['currency']
            item_quantity = int(self.item.get('quantity', 1))

            can_afford, message = check_sufficient_funds(
                character_data['attributes'].get('currency', {}),
                currency_config,
                item_currency,
                item_cost
            )

            if not can_afford:
                await interaction.response.send_message(f"You cannot afford this: {message}", ephemeral=True)
                return

            character_data = apply_item_change_local(character_data, self.item['name'], item_quantity)
            character_data = apply_currency_change_local(character_data, currency_config, item_currency, -item_cost)

            await mdb['characters'].update_one(
                {'_id': member_id},
                {'$set': {f'characters.{active_character_id}': character_data}}
            )

            character_name = character_data['name']
            item_display_name = f'{item_quantity}x {self.item["name"]}' if item_quantity > 1 else self.item['name']
            embed = discord.Embed(
                title=f"{character_name} purchased {item_display_name} for {self.item['price']} "
                      f"{self.item['currency']}",
                type='rich'
            )

            inventory = character_data['attributes'].get('inventory', {})
            player_currencies = character_data['attributes'].get('currency', {})

            items = [f"{k}: **{v}**" for k, v in inventory.items()] or ['None']
            currencies = format_currency_display(player_currencies, currency_config) or ['None']

            embed.add_field(name='Current Possessions', value='\n'.join(items))
            embed.add_field(name='Remaining Currency', value='\n'.join(currencies))

            transaction_id = shortuuid.uuid()[:12]
            embed.set_footer(text=f'Transaction ID: {transaction_id}')
            await interaction.response.send_message(embed=embed, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)
