from datetime import datetime

import discord
import shortuuid
from discord.ext import commands
from discord.ext.commands import Cog

from ..utilities.enums import EditTarget
from ..utilities.supportFunctions import attempt_delete
from ..utilities.checks import is_author_or_mod

listener = Cog.listener


class PlayerBoard(Cog):
    def __init__(self, bot):
        self.bot = bot
        self.gdb = bot.gdb

    # --- Support Functions ---

    @staticmethod
    def edit_post(post) -> discord.Embed:

        player, post_id, title, content = (post['player'], post['postId'], post['title'], post['content'])

        # Construct the embed object and edit the post with the new embed
        post_embed = discord.Embed(title=title, type='rich', description=content)
        post_embed.add_field(name='Author', value=f'<@!{player}>')
        post_embed.set_footer(text='Post ID: ' + post_id)

        return post_embed

    # ----- Player Board Commands -----

    @commands.group(name='playerboard', aliases=['pb', 'pboard'], case_insensitive=True, pass_context=True)
    async def player_board(self, ctx):
        """
        Commands for player board posts and edits.
        """
        if ctx.invoked_subcommand is None:
            return

    @player_board.command(name='post', pass_context=True)
    async def pbpost(self, ctx, title, *, content):
        """
        Posts a new message to the player board.

        Arguments:
        [title]: The title of the post.
        [content]: The body of the post.
        """
        guild_id = ctx.message.guild.id
        guild = self.bot.get_guild(guild_id)

        # Get the player board channel
        pquery = await self.gdb['playerBoardChannel'].find_one({'guildId': guild_id})
        if not pquery:
            await ctx.send('Player Board Channel is disabled!')
            return
        else:
            channel_id = pquery['playerBoardChannel']
            channel = guild.get_channel(channel_id)

        # Build the post embed
        player = ctx.author.id
        post_id = str(shortuuid.uuid()[:8])
        post_embed = discord.Embed(title=title, type='rich', description=content)
        post_embed.add_field(name='Author', value=f'<@!{player}>')
        post_embed.set_footer(text=f'Post ID: {post_id}')

        msg = await channel.send(embed=post_embed)
        message_id = msg.id
        timestamp = msg.created_at
        await ctx.send(f'Post `{post_id}`: **{title}** posted!')

        # Store the message in the database
        await self.gdb['playerBoard'].insert_one({'guildId': guild_id, 'player': player, 'postId': post_id,
                                                  'messageId': message_id, 'timestamp': timestamp, 'title': title,
                                                  'content': content})

    @player_board.command(name='delete', pass_context=True)
    async def pbdelete(self, ctx, post_id):
        """
        Deletes a post.

        Arguments:
        [post_id]: The ID of the post.
        """
        guild_id = ctx.message.guild.id
        guild = self.bot.get_guild(guild_id)

        # Get the player board channel
        pquery = await self.gdb['playerBoardChannel'].find_one({'guildId': guild_id})
        if not pquery:
            await ctx.send('Player board channel disabled!')
            return
        else:
            channel_id = pquery['playerBoardChannel']
            channel = guild.get_channel(channel_id)

        # Find the post to delete
        post = await self.gdb['playerBoard'].find_one({'postId': post_id})
        if not post:
            await ctx.send('Post not found!')
            return

        # Ensure only the author can delete
        if not await is_author_or_mod(ctx, EditTarget.POST, post_id):
            await ctx.send('Posts can only be deleted by the author!')
            return

        title = post['title']
        # Delete the post from the database and player board channel
        await self.gdb['playerBoard'].delete_one({'postId': post_id})
        msg = channel.get_partial_message(post['messageId'])
        await msg.delete()

        await ctx.send(f'Post `{post_id}`: **{title}** deleted!')

    @player_board.group(name='edit', case_insensitive=True, pass_context=True)
    async def pbedit(self, ctx):
        """
        Commands for editing player board posts.
        """
        if ctx.invoked_subcommand is None:
            # TODO: Error reporting and logging
            return

    @pbedit.command(name='title', pass_context=True)
    async def pbtitle(self, ctx, post_id, *, new_title):
        """
        Edits the title of a post.

        Arguments:
        [post_id]: The post ID to edit.
        [new_title]: The new title of the post.
        """
        guild_id = ctx.message.guild.id
        guild = self.bot.get_guild(guild_id)

        # Get the player board channel
        pquery = await self.gdb['playerBoardChannel'].find_one({'guildId': guild_id})
        if not pquery:
            await ctx.send('Player board channel disabled!')
            return
        else:
            channel_id = pquery['playerBoardChannel']
            channel = guild.get_channel(channel_id)

        # Find the post to edit
        post = await self.gdb['playerBoard'].find_one({'postId': post_id})
        if not post:
            await ctx.send('Post not found!')
            return

        # Ensure only the author can edit
        if not await is_author_or_mod(ctx, EditTarget.POST, post_id):
            await ctx.send('Posts can only be edited by the author!')
            return

        # Update the database
        await self.gdb['playerBoard'].update_one({'postId': post_id}, {'$set': {'title': new_title}}, upsert=True)

        # Grab the updated document
        updated_post = await self.gdb['playerBoard'].find_one({'postId': post_id})

        # Build the embed and post
        post_embed = self.edit_post(updated_post)
        msg = channel.get_partial_message(post['messageId'])
        await msg.edit(embed=post_embed)

        await ctx.send('Post updated!')

    @pbedit.command(name='content', pass_context=True)
    async def pbcontent(self, ctx, post_id, *, new_content):
        """
        Edits the content of a post.

        Arguments:
        [post_id]: The post ID to edit.
        [new_content]: The new content of the post.
        """
        guild_id = ctx.message.guild.id
        guild = self.bot.get_guild(guild_id)

        # Get the player board channel
        pquery = await self.gdb['playerBoardChannel'].find_one({'guildId': guild_id})
        if not pquery:
            await ctx.send('Player board channel disabled!')
            return
        else:
            channel_id = pquery['playerBoardChannel']
            channel = guild.get_channel(channel_id)

        # Find the post to edit
        post = await self.gdb['playerBoard'].find_one({'postId': post_id})
        if not post:
            await ctx.send('Post not found!')
            return

        # Ensure only the author can edit
        if not await is_author_or_mod(ctx, EditTarget.POST, post_id):
            await ctx.send('Posts can only be edited by the author!')
            return

        # Update the database
        await self.gdb['playerBoard'].update_one({'postId': post_id}, {'$set': {'content': new_content}}, upsert=True)

        # Grab the updated document
        updated_post = await self.gdb['playerBoard'].find_one({'postId': post_id})

        # Build the embed and post
        post_embed = self.edit_post(updated_post)
        msg = channel.get_partial_message(post['messageId'])
        await msg.edit(embed=post_embed)

        await ctx.send('Post updated!')

    # ----- Admin Commands -----

    @commands.has_guild_permissions(manage_guild=True)
    @player_board.command()
    async def purge(self, ctx, days):
        """
        Purges player board posts.

        Arguments:
        [days]: The number of days before a post is purged.
        --<all>: Purges all posts.
        """

        # TODO: Refactor with channel.delete_messages() or possibly channel.purge()

        # TODO: Experiment with channel.history() to get all messages and pass to pymongo unordered bulk write

        # Get the guild object
        guild_id = ctx.message.guild.id
        guild = self.bot.get_guild(guild_id)

        # Fetch the player board channel
        pquery = await self.gdb['playerBoardChannel'].find_one({'guildId': guild_id})
        if not pquery:
            await ctx.send('Player board channel not configured!')
            return
        pb_channel_id = pquery['playerBoardChannel']
        pb_channel = guild.get_channel(pb_channel_id)

        standby_message = await ctx.send('Searching for posts to purge . . .')

        # Find each post in the db older than the specified time
        message_ids = []
        if days == 'all':  # gets every post if this arg is provided
            for post in await self.gdb['playerBoard'].find({'guildId': guild_id}):
                message_ids.append(int(post['messageId']))
        else:
            duration = None
            try:
                duration = int(days)
            except TypeError:
                await ctx.send('Argument must be either a number or `all`!')

            now = datetime.utcnow()
            cursor = self.gdb['playerBoard'].find({'guildId': guild_id})
            posts = await cursor.to_list(500)
            for post in posts:
                delta = now - post['timestamp']
                if delta.days > duration:
                    message_ids.append(int(post['messageId']))

        # If any qualifying message ids are found, delete the posts and the db records
        if message_ids:
            for message_id in message_ids:
                msg = pb_channel.get_partial_message(message_id)
                await attempt_delete(msg)
                await self.gdb['playerBoard'].delete_one({'messageId': message_id})

            await ctx.send('{} expired posts deleted!'.format(len(message_ids)))
        elif days == 'all':
            await ctx.send('All player board posts deleted!')
        else:
            await ctx.send('No posts fall outside the provided number of days.')

        await standby_message.delete()


async def setup(bot):
    await bot.add_cog(PlayerBoard(bot))
