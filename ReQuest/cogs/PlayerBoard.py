import itertools
import bson

import pymongo
from pymongo import MongoClient

import discord
from discord.ext.commands import Cog, command

listener = Cog.listener

class PlayerBoard(Cog):
    def __init__(self, bot):
        global config
        global connection
        global db
        self.bot = bot
        config = bot.config
        connection = MongoClient(config['dbServer'],config['port'])
        db = connection[config['guildCollection']]

def setup(bot):
    bot.add_cog(PlayerBoard(bot))