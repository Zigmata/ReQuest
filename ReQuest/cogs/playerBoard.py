from datetime import datetime

import discord
import shortuuid
from discord import app_commands
from discord.ext import commands
from discord.ext.commands import Cog

from ..utilities.enums import EditTarget
from ..utilities.supportFunctions import attempt_delete
from ..utilities.checks import is_author_or_mod

listener = Cog.listener


class PlayerBoard(Cog, app_commands.Group, name='playerboard', description='Commands for use of the player board.'):
    def __init__(self, bot):
        self.bot = bot
        self.gdb = bot.gdb
        super().__init__()

    edit_group = app_commands.Group(name='edit', description='Commands for editing existing posts.')

    # --- Support Functions ---

    @staticmethod
    async def edit_post(post) -> discord.Embed:

        player, post_id, title, content = (post['player'], post['postId'], post['title'], post['content'])

        # Construct the embed object and edit the post with the new embed
        post_embed = discord.Embed(title=title, type='rich', description=content)
        post_embed.add_field(name='Author', value=f'<@!{player}>')
        post_embed.set_footer(text='Post ID: ' + post_id)

        return post_embed

    # ----- Player Board Commands -----

    @app_commands.command(name='post')
    async def player_board_post(self, interaction: discord.Interaction, title: str, content: str):
        """
        Posts a new message to the player board.

        Arguments:
        [title]: The title of the post.
        [content]: The body of the post.
        """
        guild_id = interaction.guild_id
        guild = self.bot.get_guild(guild_id)

        # Get the player board channel
        pquery = await self.gdb['playerBoardChannel'].find_one({'guildId': guild_id})
        if not pquery:
            error_embed = discord.Embed(title='Missing Configuration!', description='Player Board Channel is disabled!',
                                        type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)
        else:
            channel_id = pquery['playerBoardChannel']
            channel = guild.get_channel(channel_id)

            # Build the post embed
            player = interaction.user.id
            post_id = str(shortuuid.uuid()[:8])
            post_embed = discord.Embed(title=title, type='rich',
                                       description=content).set_footer(text=f'Post ID: {post_id}')
            post_embed.add_field(name='Author', value=f'<@!{player}>')

            msg = await channel.send(embed=post_embed)
            message_id = msg.id
            timestamp = msg.created_at
            await interaction.response.send_message(f'Post `{post_id}`: **{title}** posted!', ephemeral=True)

            # Store the message in the database
            await self.gdb['playerBoard'].insert_one({'guildId': guild_id, 'player': player, 'postId': post_id,
                                                      'messageId': message_id, 'timestamp': timestamp, 'title': title,
                                                      'content': content})

    @app_commands.command(name='delete')
    async def player_board_delete(self, interaction: discord.Interaction, post_id: str):
        """
        Deletes a post.

        Arguments:
        [post_id]: The ID of the post.
        """
        guild_id = interaction.guild_id
        guild = self.bot.get_guild(guild_id)
        error_title = None
        error_message = None

        # Get the player board channel
        post_query = await self.gdb['playerBoardChannel'].find_one({'guildId': guild_id})
        if not post_query:
            error_title = 'Missing Configuration!'
            error_message = 'Player board channel disabled!'
        else:
            channel_id = post_query['playerBoardChannel']
            channel = guild.get_channel(channel_id)

            # Find the post to delete
            post = await self.gdb['playerBoard'].find_one({'postId': post_id})
            if not post:
                error_title = 'Error!'
                error_message = 'Post not found!'
            # Ensure only the author can delete
            else:
                if not await is_author_or_mod(self.bot, interaction.user, EditTarget.POST, post_id):
                    error_title = 'Operation Cancelled!'
                    error_message = 'Posts can only be deleted by the author!'
                else:
                    title = post['title']
                    # Delete the post from the database and player board channel
                    await self.gdb['playerBoard'].delete_one({'postId': post_id})
                    msg = channel.get_partial_message(post['messageId'])
                    await msg.delete()

                    await interaction.response.send_message(f'Post `{post_id}`: **{title}** deleted!', ephemeral=True)

        if not error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    # TODO: Explore options of combining edit commands into a single modal
    @edit_group.command(name='title')
    async def pbtitle(self, interaction: discord.Interaction, post_id: str, new_title: str):
        """
        Edits the title of a post.

        Arguments:
        [post_id]: The post ID to edit.
        [new_title]: The new title of the post.
        """
        guild_id = interaction.guild_id
        guild = self.bot.get_guild(guild_id)
        error_title = None
        error_message = None

        # Get the player board channel
        pquery = await self.gdb['playerBoardChannel'].find_one({'guildId': guild_id})
        if not pquery:
            error_title = 'Missing Configuration!'
            error_message = 'Player board channel disabled!'
        else:
            channel_id = pquery['playerBoardChannel']
            channel = guild.get_channel(channel_id)

            # Find the post to edit
            post = await self.gdb['playerBoard'].find_one({'postId': post_id})
            if not post:
                error_title = 'Error!'
                error_message = 'Post not found!'
            else:
                # Ensure only the author can edit
                if not await is_author_or_mod(self.bot, interaction.user, EditTarget.POST, post_id):
                    error_title = 'Post not edited'
                    error_message = 'Posts can only be edited by the author!'
                else:
                    # Update the database
                    await self.gdb['playerBoard'].update_one({'postId': post_id}, {'$set': {'title': new_title}},
                                                             upsert=True)

                    # Grab the updated document
                    updated_post = await self.gdb['playerBoard'].find_one({'postId': post_id})

                    # Build the embed and post
                    post_embed = await self.edit_post(updated_post)
                    msg = channel.get_partial_message(post['messageId'])
                    await msg.edit(embed=post_embed)

                    await interaction.response.send_message('Post updated!', ephemeral=True)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    @edit_group.command(name='content')
    async def pbcontent(self, interaction: discord.Interaction, post_id: str, new_content: str):
        """
        Edits the content of a post.

        Arguments:
        [post_id]: The post ID to edit.
        [new_content]: The new content of the post.
        """
        guild_id = interaction.guild_id
        guild = self.bot.get_guild(guild_id)
        error_title = None
        error_message = None

        # Get the player board channel
        pquery = await self.gdb['playerBoardChannel'].find_one({'guildId': guild_id})
        if not pquery:
            error_title = 'Missing Configuration!'
            error_message = 'Player board channel disabled!'
        else:
            channel_id = pquery['playerBoardChannel']
            channel = guild.get_channel(channel_id)

            # Find the post to edit
            post = await self.gdb['playerBoard'].find_one({'postId': post_id})
            if not post:
                error_title = 'Error!'
                error_message = 'Post not found!'
            else:
                # Ensure only the author can edit
                if not await is_author_or_mod(self.bot, interaction.user, EditTarget.POST, post_id):
                    error_title = 'Post not update'
                    error_message = 'Posts can only be edited by the author!'
                else:
                    # Update the database
                    await self.gdb['playerBoard'].update_one({'postId': post_id}, {'$set': {'content': new_content}},
                                                             upsert=True)
                    # Grab the updated document
                    updated_post = await self.gdb['playerBoard'].find_one({'postId': post_id})

                    # Build the embed and post
                    post_embed = await self.edit_post(updated_post)
                    msg = channel.get_partial_message(post['messageId'])
                    await msg.edit(embed=post_embed)

                    await interaction.response.send_message('Post updated!', ephemeral=True)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    # ----- Admin Commands -----

    @commands.has_guild_permissions(manage_guild=True)
    @app_commands.command(name='purge')
    async def purge(self, interaction: discord.Interaction, days: str):
        """
        Purges player board posts.

        Arguments:
        [days]: The number of days before a post is purged.
        --<all>: Purges all posts.
        """

        # TODO: Refactor with channel.delete_messages() or possibly channel.purge()

        # TODO: Experiment with channel.history() to get all messages and pass to pymongo unordered bulk write

        # Get the guild object
        guild_id = interaction.guild_id
        guild = self.bot.get_guild(guild_id)

        # Fetch the player board channel
        pquery = await self.gdb['playerBoardChannel'].find_one({'guildId': guild_id})
        if not pquery:
            error_embed = discord.Embed(title='Missing Configuration!',
                                        description='Player board channel not configured!', type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)
        else:
            pb_channel_id = pquery['playerBoardChannel']
            pb_channel = guild.get_channel(pb_channel_id)

            await interaction.response.send_message('Searching for posts to purge . . .', ephemeral=True)
            # Find each post in the db older than the specified time
            message_ids = []
            if days == 'all':  # gets every post if this arg is provided
                for post in await self.gdb['playerBoard'].find({'guildId': guild_id}):
                    message_ids.append(int(post['messageId']))
            else:
                try:
                    duration = int(days)
                except TypeError:
                    await interaction.edit_original_message(content='Argument must be either a number or `all`!',
                                                            embed=None, view=None)
                    return

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

                await interaction.edit_original_message(content=f'{len(message_ids)} expired posts deleted!',
                                                        embed=None, view=None)
            elif days == 'all':
                await interaction.edit_original_message(content='All player board posts deleted!',
                                                        embed=None, view=None)
            else:
                await interaction.edit_original_message(content='No posts fall outside the provided number of days.',
                                                        embed=None, view=None)


async def setup(bot):
    await bot.add_cog(PlayerBoard(bot))
