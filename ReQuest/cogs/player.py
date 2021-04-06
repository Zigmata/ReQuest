import asyncio
from datetime import datetime

import discord
import shortuuid
from discord.ext import commands
from discord.ext.commands import Cog, command

from ..utilities.supportFunctions import delete_command

listener = Cog.listener

global gdb
global mdb


class Player(Cog):
    def __init__(self, bot):
        self.bot = bot
        global gdb
        global mdb
        gdb = bot.gdb
        mdb = bot.mdb

    @commands.group(aliases=['char'], invoke_without_command=True, case_insensitive=True)
    async def character(self, ctx, character_name: str = None):
        if ctx.invoked_subcommand is None:
            member_id = ctx.author.id
            collection = mdb['characters']
            query = collection.find_one({'memberId': member_id})

            if character_name:
                ids = []
                if not query:
                    await ctx.send('You have no registered characters!')
                    await delete_command(ctx.message)
                    return
                else:
                    for character_id in query['characters']:
                        ids.append(character_id)

                name = character_name.lower()
                matches = []
                for character_id in ids:
                    char = query['characters'][character_id]
                    if name in char['name'].lower():
                        matches.append(character_id)

                if not matches:
                    await ctx.send('No characters found with that name!')
                    await delete_command(ctx.message)
                    return
                elif len(matches) == 1:
                    char = query['characters'][matches[0]]
                    collection.update_one({'memberId': member_id}, {'$set': {'activeChar': matches[0]}})
                    await ctx.send('Active character changed to {} ({})'.format(char['name'], char['note']))
                elif len(matches) > 1:
                    content = ''
                    for i in range(len(matches)):
                        content += '{}: {} ({})\n'.format(i + 1, query['characters'][matches[i]]['name'],
                                                          query['characters'][matches[i]]['note'])

                    match_embed = discord.Embed(title="Your query returned more than one result!", type='rich',
                                                description=content)

                    match_msg = await ctx.send(embed=match_embed)

                    reply = await self.bot.wait_for('message', check=lambda message: message.author == ctx.author)
                    if int(reply.content) > len(matches):
                        await delete_command(ctx.message)
                        await delete_command(match_msg)
                        await delete_command(reply)
                        await ctx.send('Selection is outside the list of options.')
                        return
                    else:
                        await delete_command(match_msg)
                        await delete_command(reply)
                        selection = query['characters'][matches[int(reply.content) - 1]]
                        await ctx.send(
                            'Active character changed to {} ({})'.format(selection['name'], selection['note']))
                        collection.update_one({'memberId': member_id},
                                              {'$set': {'activeChar': matches[int(reply.content) - 1]}})
            else:
                active_character = query['activeChar']
                await ctx.send('Active character: {} ({})'.format(query['characters'][active_character]['name'],
                                                                  query['characters'][active_character]['note']))

        await delete_command(ctx.message)

    @character.command(name='list')
    async def character_list(self, ctx):
        member_id = ctx.author.id
        collection = mdb['characters']
        query = collection.find_one({'memberId': member_id})
        if not query:
            await ctx.send('You have no registered characters!')
            await delete_command(ctx.message)
            return

        ids = []
        for character_id in query['characters']:
            ids.append(character_id)

        characters = []
        post_embed = discord.Embed(title='Registered Characters', type='rich',
                                   description='\n'.join(characters))
        for character_id in ids:
            char = query['characters'][character_id]
            if character_id == query['activeChar']:
                post_embed.add_field(name=char['name'] + ' (Active)', value=char['note'], inline=False)
                # characters.append('**{}: {}**'.format(char['name'], char['note']))
            else:
                post_embed.add_field(name=char['name'], value=char['note'], inline=False)
                # characters.append('{}: {}'.format(char['name'], char['note']))

        await ctx.send(embed=post_embed)

        await delete_command(ctx.message)

    @character.command(name='register', aliases=['reg'])
    async def character_register(self, ctx, character_name, character_note):
        """
        Registers a new player character.

        Arguments:
        [character_name]: The name of the character.
        [character_note]: A note to uniquely identify the character.
        """
        member_id = ctx.author.id
        guild_id = ctx.message.guild.id
        character_id = str(shortuuid.uuid())
        collection = mdb['characters']
        date = datetime.utcnow()
        char_xp = None
        inventory = {}

        # Prompt user to initialize fields such as inventory, xp, etc.
        await ctx.send(
            f'{character_name} registered with ID `{character_id}`!\nDo you wish to set up initial attributes?\n('
            f'**Y**)es or (**N**)o')
        reply = await self.bot.wait_for('message', check=lambda message: message.author == ctx.author)
        if any(x in reply.content.lower() for x in ['no', 'n']):
            # Adds the provided character info to the db
            collection.update_one({'memberId': member_id}, {'$set': {'activeChar': character_id,
                                                                     f'characters.{character_id}': {
                                                                         'name': character_name,
                                                                         'note': character_note, 'registeredDate': date,
                                                                         'attributes': {'level': None,
                                                                                        'experience': char_xp,
                                                                                        'inventory': inventory,
                                                                                        'currency': None}}}},
                                  upsert=True)

            await delete_command(reply)
        elif any(x in reply.content.lower() for x in ['y', 'yes']):
            await delete_command(reply)
            await ctx.send('Prompts for player info based on server config.')

            # Check to see if server is configured to use experience points
            char_settings = gdb['characterSettings'].find_one({'guildId': guild_id})
            if char_settings['xp']:
                await ctx.send('Enter {}\'s experience points:'.format(character_name))
                # TODO: Check for int
                xp_reply = await self.bot.wait_for('message', check=lambda message: message.author == ctx.author)
                char_xp = int(xp_reply.content)

            collection.update_one({'memberId': member_id}, {'$set': {'activeChar': character_id,
                                                                     f'characters.{character_id}': {
                                                                         'name': character_name,
                                                                         'note': character_note, 'registeredDate': date,
                                                                         'attributes': {'level': None,
                                                                                        'experience': char_xp,
                                                                                        'inventory': inventory,
                                                                                        'currency': None}}}},
                                  upsert=True)

            reply = True
            while reply:
                await ctx.send('Add an item and quantity to initial inventory (**c** to cancel)\nFor example: Torch 3')
                inventory_reply = await self.bot.wait_for('message', check=lambda message: message.author == ctx.author)
                if not inventory_reply.content.lower() == 'c':
                    item = inventory_reply.content.split()
                    name = item[0]
                    quantity = int(item[1])

                    query = collection.find_one({'memberId': member_id})
                    current_inventory = query['characters'][character_id]['attributes']['inventory']
                    if name in current_inventory:
                        current_quantity = current_inventory[name]
                        new_quantity = current_quantity + quantity
                        collection.update_one({'memberId': member_id}, {
                            '$set': {f'characters.{character_id}.attributes.inventory.{name}': new_quantity}},
                                              upsert=True)
                    else:
                        collection.update_one({'memberId': member_id}, {
                            '$set': {f'characters.{character_id}.attributes.inventory.{name}': quantity}}, upsert=True)
                else:
                    reply = False

            # # Prompt for initial inventory
            # await ctx.send('Import inventory as JSON (**c** to cancel)')
            # inventory_reply = await self.bot.wait_for('message', check=lambda message: message.author == ctx.author)
            # if not 'c' in inventory_reply.content.lower():
            #    inventory = inventory_reply.content

        await ctx.send('Character registration saved!')

        await delete_command(ctx.message)

    @character.command(name='delete', aliases=['remove', 'del', 'rem'])
    async def character_delete(self, ctx, character_name):
        """
        Deletes a player character.

        Arguments:
        [character_name]: The name of the character.
        """
        member_id = ctx.author.id
        collection = mdb['characters']
        query = collection.find_one({'memberId': member_id})

        ids = []
        if not query:
            await ctx.send('You have no registered characters!')
            await delete_command(ctx.message)
            return
        else:
            for character_id in query['characters']:
                ids.append(character_id)

        name = character_name.lower()
        matches = []
        for character_id in ids:
            char = query['characters'][character_id]
            if name in char['name'].lower():
                matches.append(character_id)

        if not matches:
            await ctx.send('No characters found with that name!')
            await delete_command(ctx.message)
            return
        elif len(matches) == 1:
            char = query['characters'][matches[0]]
            collection.update_one({'memberId': member_id}, {'$pull': {'characters': char}})
            # TODO: Set active character to first in list
        elif len(matches) > 1:
            content = ''
            for i in range(len(matches)):
                content += '{}: {} ({})\n'.format(i + 1, query['characters'][matches[i]]['name'],
                                                  query['characters'][matches[i]]['note'])

            match_embed = discord.Embed(title="Your query returned more than one result!", type='rich',
                                        description=content)

            match_msg = await ctx.send(embed=match_embed)

            reply = await self.bot.wait_for('message', check=lambda message: message.author == ctx.author)
            if int(reply.content) > len(matches):
                await delete_command(ctx.message)
                await delete_command(match_msg)
                await delete_command(reply)
                await ctx.send('Selection is outside the list of options.')
                return
            else:
                await delete_command(match_msg)
                await delete_command(reply)
                selection = query['characters'][matches[int(reply.content) - 1]]
                collection.update_one({'memberId': member_id},
                                      {'$pull': {'characters': matches[int(reply.content) - 1]}})
                # TODO: Set active character to first in list

    @character.command(hidden=True)
    async def give(self, ctx, item_name, quantity: int):
        # TODO: Testing only / refactor for GM use later
        member_id = ctx.author.id
        collection = mdb['characters']

        query = collection.find_one({'memberId': member_id})
        active_character = query['activeChar']

        inventory = query['characters'][active_character]['attributes']['inventory']
        if item_name in inventory:
            current_quantity = inventory[item_name]
            new_quantity = current_quantity + quantity
            collection.update_one({'memberId': member_id}, {
                '$set': {f'characters.{active_character}.attributes.inventory.{item_name}': new_quantity}}, upsert=True)
        else:
            collection.update_one({'memberId': member_id}, {
                '$set': {f'characters.{active_character}.attributes.inventory.{item_name}': quantity}}, upsert=True)

        response = await ctx.send(f'{quantity} of {item_name} added to inventory!')

        await asyncio.sleep(1)

        await delete_command(ctx.message)
        await response.delete()

    @command()
    async def xp(self, ctx, value: int = None):
        # TODO: error handling for non integer values given
        member_id = ctx.author.id
        collection = mdb['characters']

        # Load the author's characters
        query = collection.find_one({'memberId': member_id})
        if not query:  # If none exist, output the error
            await ctx.send('You have no registered characters!')
            await delete_command(ctx.message)
            return

        # Otherwise, proceed to query the active character and retrieve its xp
        active_character = query['activeChar']
        char = query['characters'][active_character]
        name = char['name']
        xp = char['attributes']['experience']

        # If no argument was provided, output the character's current experience
        if value is None:
            if xp:
                post_embed = discord.Embed(title=f'{name}\'s Experience', type='rich',
                                           description=f'Total Experience: {xp}')
                await ctx.send(embed=post_embed)
            else:
                await ctx.send(f'{name} is rather inexperienced! Did you forget to add some?')
        else:  # Otherwise, adjust the xp based on the value given.
            if xp:
                xp = xp + value
            else:
                xp = value

            # Update the db
            collection.update_one({'memberId': member_id},
                                  {'$set': {f'characters.{active_character}.attributes.experience': xp}}, upsert=True)

            # Dynamic feedback based on the operation performed
            function = 'adds'
            if value < 0:
                function = 'removes'
            absolute = abs(value)
            post_embed = discord.Embed(title=f'{name} {function} {absolute} experience points!', type='rich',
                                       description=f'Total Experience: {xp}')
            await ctx.send(embed=post_embed)

        await delete_command(ctx.message)


def setup(bot):
    bot.add_cog(Player(bot))
