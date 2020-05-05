import bson
import itertools

import discord
from discord.ext import commands

import pymongo
from pymongo import MongoClient

# -----COGS-----

COGS = ['cogs.questBoard','cogs.help','cogs.inventory','cogs.playerBoard']

connection = MongoClient('localhost', 27017)
db = connection['quests']

class ReQuest(commands.AutoShardedBot):
    def __init__(self, prefix, **options):
        super(ReQuest, self).__init__(prefix, **options)

bot = ReQuest(prefix="r!", activity=discord.Game(name=f'by Post'))

for cog in COGS:
    bot.load_extension(cog)

f=open('token.txt','r')
if f.mode == 'r':
    token=f.read()
f.close()

bot.run(token, bot=True)