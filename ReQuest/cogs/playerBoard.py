import itertools
import datetime
import shortuuid
import bson
import re

import pymongo
from pymongo import MongoClient

import discord
from discord.ext import commands
from discord.utils import get, find
from discord.ext.commands import Cog, command

from ..utilities.supportFunctions import delete_command

listener = Cog.listener

class PlayerBoard(Cog):
    def __init__(self, bot):
        self.bot = bot
        global gdb
        global mdb
        gdb = bot.gdb
        mdb = bot.mdb

    # ----- Player Board Commands -----

    @commands.group(name = 'playerboard', aliases = ['pb', 'pboard'], pass_context = True)
    async def player_board(self, ctx):
        """
        Commands for management of player board postings.
        """
        if ctx.invoked_subcommand is None:
            await delete_command(ctx.message)
            return

    @player_board.command(name = 'post', pass_context = True)
    async def pbpost(self, ctx, content):
        """
        Posts a new message to the player board.
        """
        # TODO: Implement post embed, postID, timestamp, signup roster

    # ----- Admin Commands -----

    @commands.has_guild_permissions(manage_guild = True)
    @player_board.command()
    async def purge(self, ctx, days : int):
        """
        Purges all player board posts older than the specified number of days.
        """
        # Get the guild object
        guild_id = ctx.message.guild.id
        guild = self.bot.get_guild(guild_id)

        # Fetch the player board channel
        pquery = gdb['playerBoardChannel'].find_one({'guildId': guild_id})
        if not pquery:
            await ctx.send('Player board channel not configured!')
            await delete_command(ctx.message)
            return
        pb_channel_id = pquery['playerBoardChannel']
        pb_channel = guild.get_channel(pb_channel_id)

        # Find each post in the db older than the specified time
        posts = []
        now = datetime.utcnow()
        for post in gdb['pbExpiration'].find():
            if floor((now - post['timestamp']) > expiration):
                posts.append(post['messageId'])

def setup(bot):
    bot.add_cog(PlayerBoard(bot))
