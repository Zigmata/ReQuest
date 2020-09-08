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
    async def register(self, ctx, character_name):
        """
        Registers a new player character.

        Arguments:
        [character_name]: The name of the character.
        """
        guild_id = ctx.message.guild.id
        member_id = ctx.author.id
        character_id = str(shortuuid.uuid())
        collection = mdb['members']

        collection.insert_one({'memberId': member_id, 'guildId': [guild_id]})


def setup(bot):
    bot.add_cog(Player(bot))