import asyncio
import logging
import re
import traceback

import discord

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


# Deletes command invocations
async def attempt_delete(message):
    try:
        await message.delete()
    except discord.HTTPException:
        pass


def strip_id(mention) -> int:
    stripped_mention = re.sub(r'[<>#!@&]', '', mention)
    parsed_id = int(stripped_mention)
    return parsed_id


def parse_list(mentions) -> [int]:
    stripped_list = [re.sub(r'[<>#!@&]', '', item) for item in mentions]
    mapped_list = list(map(int, stripped_list))
    return mapped_list


async def log_exception(exception, interaction=None):
    logger.error(f'{type(exception).__name__}: {exception}')
    logger.error(traceback.format_exc())
    if interaction:
        await interaction.response.defer()
        await interaction.followup.send(exception, ephemeral=True)


def find_currency_or_denomination(currency_def_query, search_name):
    search_name = search_name.lower()
    for currency in currency_def_query['currencies']:
        if currency['name'].lower() == search_name:
            return currency['name'], currency['name']
        if 'denominations' in currency:
            for denomination in currency['denominations']:
                if denomination['name'].lower() == search_name:
                    return denomination['name'], currency['name']
    return None, None


def normalize_currency_keys(currency_dict):
    return {k.lower(): v for k, v in currency_dict.items()}


def consolidate_currency(currency_dict, denominations):
    consolidated = {}
    sorted_denoms = sorted(denominations.items(), key=lambda x: -x[1])
    remaining_amount = sum(currency_dict.get(denom.lower(), 0) * value for denom, value in denominations.items())
    for denom, value in sorted_denoms:
        if remaining_amount >= value:
            consolidated[denom] = int(remaining_amount // value)
            remaining_amount %= value
    return consolidated


def make_change(sender_currency, remaining_amount, denom_value, denominations):
    higher_denoms = sorted([(denom, value) for denom, value in denominations.items() if value > denom_value],
                           key=lambda x: -x[1])

    for higher_denom, higher_value in higher_denoms:
        qty = sender_currency.get(higher_denom.lower(), 0)

        if qty > 0:
            total_value = qty * higher_value

            if total_value >= remaining_amount:
                needed_qty = (remaining_amount + higher_value - 1) // higher_value
                sender_currency[higher_denom.lower()] -= needed_qty
                change_amount = needed_qty * higher_value - remaining_amount
                lower_denom_qty = change_amount / denom_value
                if denom_value not in sender_currency:
                    sender_currency[denom_value] = 0
                sender_currency[denom_value] += lower_denom_qty
                remaining_amount = 0
                break
            else:
                sender_currency[higher_denom.lower()] = 0
                remaining_amount -= total_value
                lower_denom_qty = total_value / denom_value
                if denom_value not in sender_currency:
                    sender_currency[denom_value] = 0
                sender_currency[denom_value] += lower_denom_qty

    return remaining_amount


async def trade_currency(mdb, gdb, currency_name, amount, sending_member_id, receiving_member_id, guild_id):
    collection = mdb['characters']

    sender_data = await collection.find_one({'_id': sending_member_id})
    sender_character_id = sender_data['activeCharacters'][str(guild_id)]
    sender_character = sender_data['characters'][sender_character_id]

    receiver_data = await collection.find_one({'_id': receiving_member_id})
    receiver_character_id = receiver_data['activeCharacters'][str(guild_id)]
    receiver_character = receiver_data['characters'][receiver_character_id]

    currency_collection = gdb['currency']
    currency_query = await currency_collection.find_one({'_id': guild_id})
    if not currency_query:
        raise Exception('Currency definition not found')

    currencies = currency_query['currencies']

    base_currency_name, currency_parent_name = find_currency_or_denomination(currency_query, currency_name)
    if not base_currency_name:
        raise Exception('Currency or denomination not found')

    base_currency_name = currency_parent_name

    denominations = {d['name'].lower(): d['value'] for currency in currencies if
                     currency['name'].lower() == base_currency_name.lower() for d in currency['denominations']}
    denominations[base_currency_name.lower()] = 1

    logger.info(f"Denominations: {denominations}")

    sender_currency = normalize_currency_keys(sender_character['attributes'].get('currency', {}))
    receiver_currency = normalize_currency_keys(receiver_character['attributes'].get('currency', {}))

    # Convert the total currency of the sender to the lowest denomination
    sender_total_in_lowest_denom = sum(
        sender_currency.get(denom, 0) * (value / min(denominations.values())) for denom, value in denominations.items())
    amount_in_lowest_denom = amount * (denominations[currency_name.lower()] / min(denominations.values()))

    logger.info(f"Sender's total in lowest denomination: {sender_total_in_lowest_denom}")
    logger.info(f"Amount in lowest denomination: {amount_in_lowest_denom}")

    if sender_total_in_lowest_denom < amount_in_lowest_denom:
        logger.info(f"Insufficient funds: {sender_total_in_lowest_denom} < {amount_in_lowest_denom}")
        raise Exception('Insufficient funds')

    # Deduct the amount from the sender's total in the lowest denomination
    sender_total_in_lowest_denom -= amount_in_lowest_denom

    # Convert the sender's remaining total back to the original denominations
    remaining_sender_currency = {}
    for denom, value in sorted(denominations.items(), key=lambda x: -x[1]):
        denom_value_in_lowest_denom = value / min(denominations.values())
        if sender_total_in_lowest_denom >= denom_value_in_lowest_denom:
            remaining_sender_currency[denom] = int(sender_total_in_lowest_denom // denom_value_in_lowest_denom)
            sender_total_in_lowest_denom %= denom_value_in_lowest_denom

    # Consolidate the sender's currency
    sender_currency = consolidate_currency(remaining_sender_currency, denominations)
    logger.info(f"Sender's currency after deduction: {sender_currency}")

    # Add the amount to the receiver's total in the lowest denomination
    receiver_total_in_lowest_denom = sum(
        receiver_currency.get(denom, 0) * (value / min(denominations.values())) for denom, value in
        denominations.items())
    receiver_total_in_lowest_denom += amount_in_lowest_denom

    # Convert the receiver's total back to the original denominations
    remaining_receiver_currency = {}
    for denom, value in sorted(denominations.items(), key=lambda x: -x[1]):
        denom_value_in_lowest_denom = value / min(denominations.values())
        if receiver_total_in_lowest_denom >= denom_value_in_lowest_denom:
            remaining_receiver_currency[denom] = int(receiver_total_in_lowest_denom // denom_value_in_lowest_denom)
            receiver_total_in_lowest_denom %= denom_value_in_lowest_denom

    # Consolidate the receiver's currency
    receiver_currency = consolidate_currency(remaining_receiver_currency, denominations)
    logger.info(f"Receiver's currency after addition: {receiver_currency}")

    sender_currency_db = {k.capitalize(): v for k, v in sender_currency.items()}
    receiver_currency_db = {k.capitalize(): v for k, v in receiver_currency.items()}

    await collection.update_one(
        {'_id': sending_member_id, f'characters.{sender_character_id}.attributes.currency': {'$exists': True}},
        {'$set': {f'characters.{sender_character_id}.attributes.currency': sender_currency_db}}
    )
    await collection.update_one(
        {'_id': receiving_member_id, f'characters.{receiver_character_id}.attributes.currency': {'$exists': True}},
        {'$set': {f'characters.{receiver_character_id}.attributes.currency': receiver_currency_db}}
    )

    return sender_currency_db, receiver_currency_db


async def trade_item(mdb, item_name, quantity, sending_member_id, receiving_member_id, guild_id):
    collection = mdb['characters']

    # Normalize the item name for consistent storage and comparison
    normalized_item_name = ' '.join(word.capitalize() for word in item_name.split())

    # Fetch sending character
    sender_data = await collection.find_one({'_id': sending_member_id})
    sender_character_id = sender_data['activeCharacters'][str(guild_id)]
    sender_character = sender_data['characters'][sender_character_id]

    # Fetch receiving character
    receiver_data = await collection.find_one({'_id': receiving_member_id})
    receiver_character_id = receiver_data['activeCharacters'][str(guild_id)]
    receiver_character = receiver_data['characters'][receiver_character_id]

    # Check if sender has enough items (case-insensitive comparison)
    sender_inventory = {k.lower(): v for k, v in sender_character['attributes']['inventory'].items()}
    if sender_inventory.get(normalized_item_name.lower(), 0) < quantity:
        raise Exception('Insufficient items')

    # Perform the trade operation
    sender_inventory[normalized_item_name.lower()] -= quantity
    if sender_inventory[normalized_item_name.lower()] == 0:
        del sender_inventory[normalized_item_name.lower()]
    receiver_inventory = {k.lower(): v for k, v in receiver_character['attributes']['inventory'].items()}
    receiver_inventory[normalized_item_name.lower()] = receiver_inventory.get(normalized_item_name.lower(),
                                                                              0) + quantity

    # Normalize the inventories for MongoDB update
    sender_character['attributes']['inventory'] = {k.capitalize(): v for k, v in sender_inventory.items()}
    receiver_character['attributes']['inventory'] = {k.capitalize(): v for k, v in receiver_inventory.items()}

    # Update MongoDB
    await collection.update_one(
        {'_id': sending_member_id, f'characters.{sender_character_id}.attributes.inventory': {'$exists': True}},
        {'$set': {
            f'characters.{sender_character_id}.attributes.inventory': sender_character['attributes']['inventory']}}
    )
    await collection.update_one(
        {'_id': receiving_member_id, f'characters.{receiver_character_id}.attributes.inventory': {'$exists': True}},
        {'$set': {
            f'characters.{receiver_character_id}.attributes.inventory': receiver_character['attributes']['inventory']}}
    )


# --------- Quest Posts -------------------


async def cancel_reaction(bot, payload, reason):
    try:
        emoji = payload.emoji
        user_id = payload.user_id
        user = bot.get_user(user_id)
        channel = bot.get_channel(payload.channel_id)
        message_id = payload.message_id
        message = channel.get_partial_message(message_id)

        await message.remove_reaction(emoji, user)
        await user.send(reason)
    except Exception as e:
        await log_exception(e)


async def update_quest_embed(bot, quest, is_archival=False) -> discord.Embed:
    try:
        (guild_id, quest_id, message_id, title, description, max_party_size, restrictions, gm, party,
         wait_list, max_wait_list_size, lock_state) = (quest['guildId'], quest['questId'], quest['messageId'],
                                                       quest['title'], quest['description'], quest['maxPartySize'],
                                                       quest['restrictions'], quest['gm'], quest['party'],
                                                       quest['waitList'], quest['maxWaitListSize'],
                                                       quest['lockState'])

        current_party_size = len(party)
        current_wait_list_size = 0
        if wait_list:
            current_wait_list_size = len(wait_list)

        formatted_party = []
        # Map int list to string for formatting, then format the list of users as user mentions
        if len(party) > 0:
            for member in party:
                for key in member:
                    character_query = await bot.mdb['characters'].find_one({'_id': int(key)})
                    character_name = character_query['characters'][member[key]]['name']
                    formatted_party.append(f'- <@!{key}> as {character_name}')

        formatted_wait_list = []
        # Only format the wait list if there is one.
        if len(wait_list) > 0:
            for member in wait_list:
                for key in member:
                    character_query = await bot.mdb['characters'].find_one({'_id': int(key)})
                    character_name = character_query['characters'][member[key]]['name']
                    formatted_wait_list.append(f'- <@!{key}> as {character_name}')

        # Shows the quest is locked if applicable, unless it is being archived.
        if lock_state is True and is_archival is False:
            title = title + ' (LOCKED)'

        # Construct the embed object and edit the post with the new embed
        if restrictions:
            embed_description = (f'**GM:** <@!{gm}>\n**Party Restrictions:** {restrictions}\n\n{description}'
                                 f'\n\n------')
        else:
            embed_description = f'**GM:** <@!{gm}>\n\n{description}\n\n------'
        post_embed = discord.Embed(title=title, type='rich',
                                   description=embed_description)
        if len(formatted_party) == 0:
            post_embed.add_field(name=f'__Party ({current_party_size}/{max_party_size})__',
                                 value='None')
        else:
            post_embed.add_field(name=f'__Party ({current_party_size}/{max_party_size})__',
                                 value='\n'.join(formatted_party))

        # Add a wait list field if one is present, unless the quest is being archived.
        if max_wait_list_size > 0 and is_archival is False:
            if len(formatted_wait_list) == 0:
                post_embed.add_field(name=f'__Wait List ({current_wait_list_size}/{max_wait_list_size})__',
                                     value='None')
            else:
                post_embed.add_field(name=f'__Wait List ({current_wait_list_size}/{max_wait_list_size})__',
                                     value='\n'.join(formatted_wait_list))

        post_embed.set_footer(text='Quest ID: ' + quest_id)

        return post_embed
    except Exception as e:
        await log_exception(e)


async def reaction_operation(bot, payload):
    """Handles addition/removal of user mentions when reacting to quest posts"""
    try:
        # TODO: Level restrictions if enabled
        guild_id = payload.guild_id
        user_id = payload.user_id
        user = bot.get_user(user_id)
        if user.bot:
            return

        # Find the configured Quest Channel and get the name (string in <#channelID> format)
        query = await bot.gdb['questChannel'].find_one({'_id': guild_id})
        if not query:
            raise Exception('A channel has not yet been designated for quest posts. Contact a server admin to '
                            'configure the Quest Channel.')
        quest_channel = query['questChannel']
        # Ensure that only posts in the configured Quest Channel are modified.
        if strip_id(quest_channel) != payload.channel_id:
            return

        channel = bot.get_channel(payload.channel_id)
        message_id = payload.message_id
        message = channel.get_partial_message(message_id)

        collection = bot.gdb['quests']
        quest = await collection.find_one({'messageId': message_id})  # Get the quest that matches the message ID
        if not quest:
            await cancel_reaction(bot, payload, f'Error: Quest not found in database.')
            return

        current_party = quest['party']
        current_wait_list = quest['waitList']
        max_wait_list_size = quest['maxWaitListSize']
        max_party_size = quest['maxPartySize']
        member_collection = bot.mdb['characters']
        player_characters = await member_collection.find_one({'_id': user_id})
        if ('activeCharacters' not in player_characters or
                str(guild_id) not in player_characters['activeCharacters']):
            await cancel_reaction(bot, payload, f'Error joining quest **{quest["title"]}**: '
                                                f'You do not have an active character on that server. Use the '
                                                f'`/player` menu commands to activate or register!')
            return
        active_character_id = player_characters['activeCharacters'][str(guild_id)]

        # If a reaction is added, add the reacting user to the party/wait list if there is room
        if payload.event_type == 'REACTION_ADD':
            if quest['lockState']:
                await cancel_reaction(bot, payload, f'Error joining quest **{quest["title"]}**: '
                                                    f'The quest is locked and not accepting players.')
                return
            else:
                if str(guild_id) not in player_characters['activeCharacters']:
                    await cancel_reaction(bot, payload, f'Error joining quest **{quest["title"]}**: '
                                                        f'You have no active characters on that server!')
                    return

                # If the wait list is enabled, this section formats the embed to include the wait list
                if max_wait_list_size > 0:
                    # --- Database operations ---

                    # If there is room in the party, add the user.
                    if len(current_party) < max_party_size:
                        await collection.update_one({'messageId': message_id},
                                                    {'$push': {'party': {f'{user_id}': active_character_id}}})
                    # If the party is full but the wait list is not, add the user to wait list.
                    elif len(current_party) >= max_party_size and len(current_wait_list) < max_wait_list_size:
                        await collection.update_one({'messageId': message_id},
                                                    {'$push': {'waitList': {f'{user_id}': active_character_id}}})

                    # Otherwise, DM the user that the party/wait list is full
                    else:
                        await cancel_reaction(bot, payload, f'Error joining quest **{quest["title"]}**: '
                                                            f'The quest roster is full!')
                        return

                    # --- Post edit generation ---

                    # The document is queried again to build the updated post
                    quest = await collection.find_one({'messageId': message_id})

                    post_embed = await update_quest_embed(bot, quest)

                    await message.edit(embed=post_embed)

                # If there is no wait list, this section formats the embed without it
                else:
                    # --- Database operations ---

                    # If there is room in the party, add the user.
                    if len(current_party) < max_party_size:
                        await collection.update_one({'messageId': message_id},
                                                    {'$push': {'party': {f'{user_id}': active_character_id}}})
                    else:
                        await cancel_reaction(bot, payload, f'Error joining quest **{quest["title"]}**: '
                                                            f'The quest roster is full!')
                        return

                    # --- Post edit generation ---

                    # The document is queried again to build the updated post
                    quest = await collection.find_one({'messageId': message_id})
                    post_embed = await update_quest_embed(bot, quest)
                    await message.edit(embed=post_embed)

        # This path is chosen if a reaction is removed.
        else:
            # If the wait list is enabled, this section formats the embed to include the wait list

            guild = bot.get_guild(guild_id)
            role_query = await bot.gdb['partyRole'].find_one({'_id': guild_id, 'gm': quest['gm']})

            # If the quest list is locked and a party role exists, fetch the role.
            role = None
            if quest['lockState'] and role_query:
                role = guild.get_role(role_query['role'])

                # Get the member object and remove the role
                member = guild.get_member(user_id)
                await member.remove_roles(role)

            if max_wait_list_size > 0:
                # Find which list the user is in, and remove them from the database
                for entry in current_party:
                    if str(user_id) in entry:
                        await collection.update_one({'messageId': message_id},
                                                    {'$pull': {'party': {f'{user_id}': {'$exists': True}}}})
                        # If there is a wait list, move the first entry into the party automatically
                        if len(current_wait_list) > 0:
                            for new_player in current_wait_list:
                                for key in new_player:
                                    new_member = guild.get_member(int(key))

                                    await collection.update_one({'messageId': message_id},
                                                                {'$push': {'party': new_player}})
                                    await collection.update_one({'messageId': message_id},
                                                                {'$pull': {'waitList': new_player}})

                                    # Notify the member they have been moved into the main party
                                    await new_member.send(f'You have been added to the party for '
                                                          f'**{quest["title"]}**, due to a player dropping!')

                                    # If a role is set, assign it to the player
                                    if role:
                                        await new_member.add_roles(role)

                for entry in current_wait_list:
                    if str(user_id) in entry:
                        await collection.update_one({'messageId': message_id},
                                                    {'$pull': {'waitList': {f'{user_id}': {'$exists': True}}}})

                # Refresh the query with the new document and edit the post
                quest = await collection.find_one({'messageId': message_id})
                post_embed = await update_quest_embed(bot, quest)
                await message.edit(embed=post_embed)
            # If there is no wait list, this section formats the embed without it
            else:
                # Remove the user from the quest in the database
                await collection.update_one({'messageId': message_id},
                                            {'$pull': {'party': {f'{user_id}': {'$exists': True}}}})

                quest = await collection.find_one({'messageId': message_id})
                post_embed = await update_quest_embed(bot, quest)
                await message.edit(embed=post_embed)
    except Exception as e:
        await log_exception(e)


async def quest_ready_toggle(interaction: discord.Interaction, quest_id: str):
    guild_id = interaction.guild_id
    user_id = interaction.user.id
    guild = interaction.client.get_guild(guild_id)

    # Fetch the quest
    quest_collection = interaction.client.gdb['quests']
    quest = await quest_collection.find_one({'questId': quest_id})

    # Fetch the quest channel to retrieve the message object
    channel_collection = interaction.client.gdb['questChannel']
    channel_id_query = await channel_collection.find_one({'_id': guild_id})
    if not channel_id_query:
        raise Exception('Quest channel has not been set!')
    channel_id = strip_id(channel_id_query['questChannel'])
    channel = interaction.client.get_channel(channel_id)

    # Retrieve the message object
    message_id = quest['messageId']
    message = channel.get_partial_message(message_id)

    # Check to see if the GM has a party role configured
    role_collection = interaction.client.gdb['partyRole']
    role_query = await role_collection.find_one({'_id': guild_id, 'gm': user_id})
    if role_query and role_query['role']:
        role_id = role_query['role']
        role = guild.get_role(role_id)
    else:
        role = None

    party = quest['party']
    title = quest['title']
    tasks = []

    # Locks the quest roster and alerts party members that the quest is ready.
    if not quest['lockState']:
        await quest_collection.update_one({'questId': quest_id}, {'$set': {'lockState': True}})

        # Fetch the updated quest
        updated_quest = await quest_collection.find_one({'questId': quest_id})

        # Notify each party member that the quest is ready
        for player in party:
            for key in player:
                member = guild.get_member(int(key))
                # If the GM has a party role configured, assign it to each party member
                if role:
                    tasks.append(await member.add_roles(role))
                tasks.append(await member.send(f'Game Master <@{user_id}> has marked your quest, **"{title}"**, '
                                               f'ready to start!'))

        await interaction.user.send('Quest roster locked and party notified!')
    # Unlocks a quest if members are not ready.
    else:
        # Remove the role from the players
        if role:
            for player in party:
                for key in player:
                    member = guild.get_member(int(key))
                    tasks.append(await member.remove_roles(role))

        # Unlock the quest
        await quest_collection.update_one({'questId': quest_id}, {'$set': {'lockState': False}})

        # Fetch the updated quest
        updated_quest = await quest_collection.find_one({'questId': quest_id})

        await interaction.user.send('Quest roster has been unlocked.')

    if len(tasks) > 0:
        await asyncio.gather(*tasks)

    # Create the updated embed, and edit the message
    post_embed = await update_quest_embed(interaction.client, updated_quest)
    await message.edit(embed=post_embed)


async def remove_party_member(interaction, quest, removed_member_id):
    quest_collection = interaction.client.gdb['quests']
    guild_id = interaction.guild_id
    message_id = quest['messageId']
    quest_id = quest['questId']

    # Fetch the quest channel to retrieve the message object
    channel_collection = interaction.client.gdb['questChannel']
    channel_id_query = await channel_collection.find_one({'_id': guild_id})
    if not channel_id_query:
        raise Exception('Quest channel has not been set!')
    channel_id = strip_id(channel_id_query['questChannel'])
    channel = interaction.client.get_channel(channel_id)
    message = channel.get_partial_message(message_id)

    # Remove the player from the party
    await quest_collection.update_one({'questId': quest_id}, {'$pull': {'party': removed_member_id}})
    guild = interaction.client.get_guild(guild_id)
    member = guild.get_member(removed_member_id)

    # Remove the player's reactions from the post.
    [await reaction.gm_remove(member) for reaction in message.reactions]

    # Notify the player they have been removed.
    await member.send(f'You have been removed from the party for the quest, **{quest["title"]}**.')

    # If there is a wait list, move the first player into the party and remove them from the wait list
    if quest['waitList']:
        replacement = quest['waitList'][0]
        replacement_member = guild.get_member(replacement)
        await quest_collection.update_one({'questId': quest_id}, {'$push': {'party': replacement}})
        await quest_collection.update_one({'questId': quest_id}, {'$pull': {'waitList': replacement}})

        # Notify player they are now in the party
        await replacement_member.send(f'You have been added to the party for the quest, '
                                      f'**{quest["title"]}**, due to a player dropping!')

#
# @app_commands.command(name='complete')
# async def complete(self, interaction: discord.Interaction, quest_id: str, summary: str = None):
#     """
#     Closes a quest and issues rewards.
#
#     Arguments:
#     [quest_id]: The ID of the quest.
#     [summary](Optional): A summary of the quest, if enabled (see help config quest summary).
#     """
#     # TODO: Implement quest removal/archival, optional summary, player and GM reward distribution
#     guild_id = interaction.guild_id
#     user_id = interaction.user.id
#     guild = self.bot.get_guild(guild_id)
#
#     # Fetch the quest
#     quest = await self.gdb['quests'].find_one({'questId': quest_id})
#
#     # Confirm the user calling the command is the GM that created the quest
#     if not quest['gm'] == user_id:
#         error_embed = discord.Embed(title='Quest Not Edited!', description='GMs can only manage their own quests!',
#                                     type='rich')
#         await interaction.response.send_message(embed=error_embed, ephemeral=True)
#     else:
#         # Check if there is a configured quest archive channel
#         archive_channel = None
#         archive_query = await self.gdb['archiveChannel'].find_one({'guildId': guild_id})
#         if archive_query:
#             archive_channel = archive_query['archiveChannel']
#
#         # Check if a GM role was configured
#         gm_role = None
#         gm = quest['gm']
#         role_query = await self.gdb['partyRole'].find_one({'guildId': guild_id, 'gm': gm})
#         if role_query:
#             gm_role = role_query['role']
#
#         # Get party members and message them with results
#         party = quest['party']
#         title = quest['title']
#         xp_value = quest['xp']
#         rewards = quest['rewards']
#         reward_summary = []
#         member_collection = self.mdb['characters']
#         for entry in party:
#             for player_id in entry:
#                 player = int(player_id)
#                 member = guild.get_member(player)
#                 # Remove the party role, if applicable
#                 if gm_role:
#                     role = guild.get_role(gm_role)
#                     await member.remove_roles(role)
#
#                 character_query = await member_collection.find_one({'_id': player})
#                 character_id = entry[player_id]
#                 character = character_query['characters'][character_id]
#                 reward_strings = []
#
#                 if str(player) in rewards:
#                     if archive_channel:
#                         reward_summary.append(f'\n<@!{player}>')
#                     inventory = character['attributes']['inventory']
#                     for item_name in rewards[f'{player}']:
#                         quantity = rewards[f'{player}'][item_name]
#                         if item_name in inventory:
#                             current_quantity = inventory[item_name]
#                             new_quantity = current_quantity + quantity
#                             await member_collection.update_one(
#                                 {'_id': player},
#                                 {'$set': {
#                                     f'characters.{character_id}.attributes.inventory.{item_name}': new_quantity}},
#                                 upsert=True)
#                         else:
#                             await member_collection.update_one({'_id': player}, {
#                                 '$set': {f'characters.{character_id}.attributes.inventory.{item_name}': quantity}},
#                                                          upsert=True)
#
#                         reward_strings.append(f'{quantity}x {item_name}')
#                         if archive_channel:
#                             reward_summary.append(f'{quantity}x {item_name}')
#
#                 if xp_value:
#                     current_xp = character['attributes']['experience']
#
#                     if current_xp:
#                         current_xp += xp_value
#                     else:
#                         current_xp = xp_value
#
#                     # Update the db
#                     await member_collection.update_one({'_id': player}, {
#                         '$set': {f'characters.{character_id}.attributes.experience': current_xp}}, upsert=True)
#
#                     reward_strings.append(f'{xp_value} experience points')
#
#                 dm_embed = discord.Embed(title=f'Quest Complete: {title}',
#                                          type='rich')
#                 if reward_strings:
#                     dm_embed.add_field(name='Rewards', value='\n'.join(reward_strings))
#
#                 await member.send(embed=dm_embed)
#
#         # Archive the quest, if applicable
#         if archive_channel:
#             # Fetch the channel object
#             channel = guild.get_channel(archive_channel)
#
#             # Build the embed
#             post_embed = await self.update_quest_embed(quest, True)
#             # If quest summary is configured, add it
#             summary_enabled = await self.gdb['questSummary'].find_one({'guildId': guild_id})
#             if summary_enabled and summary_enabled['questSummary']:
#                 post_embed.add_field(name='Summary', value=summary, inline=False)
#
#             if rewards:
#                 post_embed.add_field(name='Rewards', value='\n'.join(reward_summary), inline=True)
#
#             if xp_value:
#                 post_embed.add_field(name='Experience Points', value=f'{xp_value} each', inline=True)
#
#             await channel.send(embed=post_embed)
#
#         # Delete the quest from the database
#         await self.gdb['quests'].delete_one({'questId': quest_id})
#
#         # Delete the quest from the quest channel
#         channel_query = await self.gdb['questChannel'].find_one({'guildId': guild_id})
#         channel_id = channel_query['questChannel']
#         quest_channel = guild.get_channel(channel_id)
#         message_id = quest['messageId']
#         message = quest_channel.get_partial_message(message_id)
#         await attempt_delete(message)
#
#         await interaction.response.send_message(f'Quest `{quest_id}`: **{title}** completed!', ephemeral=True)
