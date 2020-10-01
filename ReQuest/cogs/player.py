from datetime import datetime
import asyncio
import shortuuid
import itertools
import bson
import re

import pymongo
from pymongo import MongoClient

import discord
from discord.ext import commands
from discord.ext.commands import Cog, command

from ..utilities.supportFunctions import delete_command, has_gm_role

listener = Cog.listener

class Player(Cog):
    def __init__(self, bot):
        self.bot = bot
        global gdb
        global mdb
        gdb = bot.gdb
        mdb = bot.mdb

    @commands.group(aliases = ['char'], hidden = True, invoke_without_command = True, case_insensitive = True)
    async def character(self, ctx, character_name : str = None):
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
                    for id in query['characters']:
                        ids.append(id)

                name = character_name.lower()
                matches = []
                for id in ids:
                    char = query['characters'][id]
                    if name in char['name'].lower():
                        matches.append(id)

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
                        content += '{}: {} ({})\n'.format(i+1, query['characters'][matches[i]]['name'], query['characters'][matches[i]]['note'])

                    match_embed = discord.Embed(title = "Your query returned more than one result!", type = 'rich',
                        description = content)

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
                        selection = query['characters'][matches[int(reply.content)-1]]
                        await ctx.send('Active character changed to {} ({})'.format(selection['name'], selection['note']))
                        collection.update_one({'memberId': member_id}, {'$set': {'activeChar': matches[int(reply.content)-1]}})
            else:
                active_character = query['activeChar']
                await ctx.send('Active character: {} ({})'.format(query['characters'][active_character]['name'], query['characters'][active_character]['note']))

        await delete_command(ctx.message)

    @character.command(name = 'list')
    async def character_list(self, ctx):
        member_id = ctx.author.id
        collection = mdb['characters']
        query = collection.find_one({'memberId': member_id})
        if not query:
            await ctx.send('You have no registered characters!')
            await delete_command(ctx.message)
            return

        ids = []
        for id in query['characters']:
            ids.append(id)

        characters = []
        post_embed = discord.Embed(title='Registered Characters', type='rich',
            description='\n'.join(characters))
        for id in ids:
            char = query['characters'][id]
            if id == query['activeChar']:
                post_embed.add_field(name=char['name']+' (Active)', value=char['note'], inline = False)
                #characters.append('**{}: {}**'.format(char['name'], char['note']))
            else:
                post_embed.add_field(name=char['name'], value=char['note'], inline = False)
                #characters.append('{}: {}'.format(char['name'], char['note']))

        await ctx.send(embed=post_embed)

        await delete_command(ctx.message)

    @character.command(name = 'register', aliases = ['reg'])
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
        
        # Adds the provided character info to the db
        collection.update_one({'memberId': member_id}, {'$set': {'activeChar': character_id,
            f'characters.{character_id}': {'name': character_name,
            'note': character_note, 'registeredDate': date, 'attributes': {'level': None,
            'experience': None, 'inventory': {}, 'currency': None}}}}, upsert = True)

        # Prompt user to initialize fields such as inventory, xp, etc.
        await ctx.send(f'{character_name} registered with ID `{character_id}`!\nDo you wish to set up initial attributes?\n(**Y**)es or (**N**)o')
        reply = await self.bot.wait_for('message', check=lambda message: message.author == ctx.author)
        if any(x in reply.content.lower() for x in ['no', 'n']):
            await delete_command(reply)
            await delete_command(ctx.message)
            return
        elif any(x in reply.content.lower() for x in ['y', 'yes']):
            await delete_command(reply)
            await ctx.send('Prompts for player info based on server config.')

        await delete_command(ctx.message)

    @character.command(hidden = True)
    async def give(self, ctx, item_name, quantity: int):
        member_id = ctx.author.id
        guild_id = ctx.message.guild.id
        collection = mdb['characters']

        query = collection.find_one({'memberId': member_id})
        active_character = query['activeChar']

        inventory = query['characters'][active_character]['attributes']['inventory']
        if item_name in inventory:
            current_quantity = inventory[item_name]
            new_quantity = current_quantity + quantity
            collection.update_one({'memberId': member_id}, {'$set': {f'characters.{active_character}.attributes.inventory.{item_name}': new_quantity}}, upsert = True)
        else:
            collection.update_one({'memberId': member_id}, {'$set': {f'characters.{active_character}.attributes.inventory.{item_name}': quantity}}, upsert = True)

        await ctx.send(f'{quantity} of {item_name} added to inventory!')

        await delete_command(ctx.message)

def setup(bot):
    bot.add_cog(Player(bot))
