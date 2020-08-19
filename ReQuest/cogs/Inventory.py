import itertools
import bson
import re

import pymongo
from pymongo import MongoClient

import discord
from discord.utils import get
from discord.ext import commands
from discord.ext.commands import Cog, command

from ..utilities.supportFunctions import delete_command

listener = Cog.listener

class Inventory(Cog):
    def __init__(self, bot):
        global config
        global gdb
        self.bot = bot
        config = bot.config
        connection = MongoClient(config['dbServer'],config['port'])
        gdb = connection[config['guildCollection']]

def setup(bot):
    bot.add_cog(Inventory(bot))