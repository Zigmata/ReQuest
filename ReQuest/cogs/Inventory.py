from datetime import datetime
import itertools
import bson

import pymongo
from pymongo import MongoClient

import discord
from discord.ext.commands import Cog, command

listener = Cog.listener
connection = MongoClient('localhost', 27017)
db = connection['members']

class Inventory(Cog):
    def __init__(self, bot):
        self.bot = bot

def setup(bot):
    bot.add_cog(Inventory(bot))