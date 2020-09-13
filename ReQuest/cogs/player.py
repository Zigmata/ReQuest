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

    @command(aliases = ['reg'], hidden = True)
    async def register(self, ctx, character_name, character_note):
        """
        Registers a new player character.

        Arguments:
        [character_name]: The name of the character.
        """
        member_id = ctx.author.id
        guild_id = ctx.message.guild.id
        character_id = str(shortuuid.uuid())
        collection = mdb['characters']
        date = datetime.utcnow()
        
        # Adds the provided character info to the db
        #collection.update_one({'memberId': member_id}, {'$set': {'activeChar': character_id},
        #    '$push': {'characters': {character_id: {'name': character_name,
        #    'note': character_note, 'registeredDate': date, 'attributes': {'level': None,
        #    'experience': None, 'inventory': None, 'currency': None}}}}}, upsert = True)

        collection.update_one({'memberId': member_id}, {'$set': {'activeChar': character_id,
            f'characters.{character_id}': {'name': character_name,
            'note': character_note, 'registeredDate': date, 'attributes': {'level': None,
            'experience': None, 'inventory': {}, 'currency': None}}}}, upsert = True)

        await ctx.send(f'{character_name} registered with ID `{character_id}`!')
        await ctx.send('Do you wish to set up initial attributes?\n(**Y**)es or (**N**)o')
        reply = await self.bot.wait_for('message', check=lambda message: message.author == ctx.author)
        if reply.content.lower() == 'n':
            await delete_command(reply)
            await delete_command(ctx.message)
            return
        elif reply.content.lower() == 'y':
            await delete_command(reply)
            await ctx.send('Prompts for player info based on server config.')

        await delete_command(ctx.message)

    @command(hidden = True)
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
