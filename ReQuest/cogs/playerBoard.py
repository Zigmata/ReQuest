import itertools
from datetime import datetime
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

    # --- Support Functions ---

    def edit_post(self, post) -> discord.Embed:

        player, post_id, title, content = (post['player'], post['postId'], post['title'], post['content'])

        # Construct the embed object and edit the post with the new embed
        post_embed = discord.Embed(title=title, type='rich', description=f'**Player:** <@!{player}>\n\n{content}')
        post_embed.set_footer(text='Post ID: '+post_id)

        return post_embed

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
    async def pbpost(self, ctx, title, *, content):
        """
        Posts a new message to the player board.
        """
        guild_id = ctx.message.guild.id
        guild = self.bot.get_guild(guild_id)

        # Get the player board channel
        pquery = gdb['playerBoardChannel'].find_one({'guildId': guild_id})
        channel = None
        if not pquery:
            await ctx.send('Player Board Channel is disabled!')
            await delete_command(ctx.message)
            return
        else:
            channel_id = pquery['playerBoardChannel']
            channel = guild.get_channel(channel_id)

        # Build the post embed
        player = ctx.author.id
        post_id = str(shortuuid.uuid()[:8])
        post_embed = discord.Embed(title=title, type='rich', description=f'**Player:** <@!{player}>\n\n{content}')
        post_embed.set_footer(text='Post ID: '+post_id)

        msg = await channel.send(embed=post_embed)
        message_id = msg.id
        timestamp = msg.created_at
        await ctx.send(f'Post `{post_id}`: **{title}** posted!')

        # Store the message in the database
        gdb['playerBoard'].insert_one({'guildId': guild_id, 'player': player, 'postId': post_id,
            'messageId': message_id, 'timestamp': timestamp, 'title': title, 'content': content})

        await delete_command(ctx.message)

    @player_board.group(name = 'edit', pass_context = True)
    async def pbedit(self, ctx):
        """
        Commands for editing player board posts.
        """
        if ctx.invoked_subcommand is None:
            # TODO: Error reporting and logging
            await delete_command(ctx.message)
            return

    @pbedit.command(name = 'title', pass_context = True)
    async def pbtitle(self, ctx, post_id, *, new_title):
        """
        Edits the title of a post.

        Arguments:
        [post_id]: The post ID to edit.
        [new_title]: The new title of the post.
        """
        guild_id = ctx.message.guild.id
        guild = self.bot.get_guild(guild_id)
        player = ctx.author.id

        # Get the player board channel
        channel = None
        pquery = gdb['playerBoardChannel'].find_one({'guildId': guild_id})
        if not pquery:
            await ctx.send('Player board channel disabled!')
            await delete_command(ctx.message)
            return
        else:
            channel_id = pquery['playerBoardChannel']
            channel = guild.get_channel(channel_id)

        # Find the post to edit
        post = gdb['playerBoard'].find_one({'postId': post_id})
        if not post:
            await ctx.send('Post not found!')
            await delete_command(ctx.message)
            return

        # Ensure only the author can edit
        if not post['player'] == player:
            await ctx.send('Posts can only be edited by the author!')
            await delete_command(ctx.message)
            return

        # Update the database
        gdb['playerBoard'].update_one({'postId': post_id}, {'$set': {'title': new_title}}, upsert = True)

        # Grab the updated document
        updated_post = gdb['playerBoard'].find_one({'postId': post_id})

        # Build the embed and post
        post_embed = self.edit_post(updated_post)
        msg = await fetch_message(post['messageId'])
        await msg.edit(embed = post_embed)

        await ctx.send('Post updated!')

        await delete_command(ctx.message)

    @pbedit.command(name = 'content', pass_context = True)
    async def pbcontent(self, ctx, post_id, *, new_content):
        """
        Edits the content of a post.

        Arguments:
        [post_id]: The post ID to edit.
        [new_content]: The new title of the post.
        """
        guild_id = ctx.message.guild.id
        guild = self.bot.get_guild(guild_id)
        player = ctx.author.id

        # Get the player board channel
        channel = None
        pquery = gdb['playerBoardChannel'].find_one({'guildId': guild_id})
        if not pquery:
            await ctx.send('Player board channel disabled!')
            await delete_command(ctx.message)
            return
        else:
            channel_id = pquery['playerBoardChannel']
            channel = guild.get_channel(channel_id)

        # Find the post to edit
        post = gdb['playerBoard'].find_one({'postId': post_id})
        if not post:
            await ctx.send('Post not found!')
            await delete_command(ctx.message)
            return

        # Ensure only the author can edit
        if not post['player'] == player:
            await ctx.send('Posts can only be edited by the author!')
            await delete_command(ctx.message)
            return

        # Update the database
        gdb['playerBoard'].update_one({'postId': post_id}, {'$set': {'content': new_content}}, upsert = True)

        # Grab the updated document
        updated_post = gdb['playerBoard'].find_one({'postId': post_id})

        # Build the embed and post
        post_embed = self.edit_post(updated_post)
        msg = await fetch_message(post['messageId'])
        await msg.edit(embed = post_embed)

        await ctx.send('Post updated!')

        await delete_command(ctx.message)

    # ----- Admin Commands -----

    @commands.has_guild_permissions(manage_guild = True)
    @player_board.command()
    async def purge(self, ctx, days):
        """
        Purges player board posts.

        Arguments:
        [#]: The number of days before a post is purged.
        [all]: Purges all posts.
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

        await delete_command(ctx.message)

        standby_message = await ctx.send('Searching for posts to purge . . .')

        # Find each post in the db older than the specified time
        message_ids = []
        if days == 'all':
            for post in gdb['playerBoard'].find():
                message_ids.append(post['messageId'])
        else:
            duration = None
            try:
                duration = int(days)
            except:
                await ctx.send('Argument must be either a number or `all`!')

            now = datetime.utcnow()
            for post in gdb['playerBoard'].find():
                delta = now - post['timestamp']
                if delta.days > duration:
                    message_ids.append(post['messageId'])

        # If any expired posts are found, delete them
        if message_ids:
            for id in message_ids:
                msg = await pb_channel.fetch_message(id)
                await msg.delete()
                gdb['playerBoard'].delete_one({'messageId': id})

            await ctx.send('{} expired posts deleted!'.format(len(message_ids)))
        else:
            await ctx.send('No posts fall outside the provided number of days.')

        await standby_message.delete()


def setup(bot):
    bot.add_cog(PlayerBoard(bot))
