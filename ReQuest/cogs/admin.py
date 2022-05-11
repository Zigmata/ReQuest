import discord
from discord import app_commands
from discord.ext import commands
from discord.ext.commands import Cog


class Admin(Cog, app_commands.Group, name='admin', description='Administrative commands for bot options.'):
    """Administrative commands for bot options."""

    def __init__(self, bot):
        self.bot = bot
        self.gdb = bot.gdb
        self.cdb = bot.cdb
        super().__init__()

    whitelist_group = app_commands.Group(name='whitelist', description='Commands for adding and removing guilds from '
                                                                       'the testing white list.')

    # # -----------------Listeners----------------
    #
    # @commands.Cog.listener()
    # async def on_guild_join(self, guild):
    #     if not self.bot.white_list or guild.id in self.bot.white_list:
    #         return
    #     else:
    #         await guild.owner.send('Thank you for your interest in ReQuest! Your server is not in ReQuest\'s list of '
    #                                'authorized testing servers. Please join the support server and contact the '
    #                                'development team to request test access.')
    #         return await guild.leave()
    #
    # # -------------Private Commands-------------
    #
    # # Reload a cog by name
    # @commands.is_owner()  # TODO: Not working, validate command checks post-interactions
    # @app_commands.command(name='reload')
    # async def reload(self, interaction: discord.Interaction, module: str):
    #     await self.bot.reload_extension('ReQuest.cogs.' + module)
    #
    #     await interaction.response.send_message(f'Extension successfully reloaded: `{module}`', ephemeral=True)
    #
    # Echoes the first argument provided
    # @commands.is_owner()  # TODO: Not working, validate command checks post-interactions
    @app_commands.command(name='echo')
    async def echo(self, interaction: discord.Interaction, text: str):
        await interaction.response.send_message(text, ephemeral=True)

    #
    # # Loads a cog that hasn't yet been loaded
    # @commands.is_owner()  # TODO: Not working, validate command checks post-interactions
    # @app_commands.command(name='load')
    # async def load(self, interaction: discord.Interaction, module: str):
    #     await self.bot.load_extension('ReQuest.cogs.' + module)
    #
    #     await interaction.response.send_message(f'Extension successfully loaded: `{module}`', ephemeral=True)
    #
    # # Shut down the bot
    # @commands.is_owner()  # TODO: Not working, validate command checks post-interactions
    # @app_commands.command(name='shutdown')
    # async def shutdown(self, interaction: discord.Interaction):
    #     try:
    #         await interaction.response.send_message('Shutting down!', ephemeral=True)
    #         await self.bot.close()
    #     except Exception as e:
    #         await interaction.response.send_message(f'{type(e).__name__}: {e}', ephemeral=True)

    @commands.is_owner()  # TODO: Not working, validate command checks post-interactions
    @whitelist_group.command(name='add')
    async def whitelist_add(self, interaction: discord.Interaction, guild: str):
        collection = self.cdb['botWhiteList']
        guild_id = int(guild)
        self.bot.white_list.append(guild_id)

        await collection.update_one({'servers': {'$exists': True}}, {'$push': {'servers': guild_id}}, upsert=True)

        await interaction.response.send_message(f'Guild ID `{guild_id}` added to whitelist!', ephemeral=True)

    @commands.is_owner()  # TODO: Not working, validate command checks post-interactions
    @whitelist_group.command(name='remove')
    async def whitelist_remove(self, interaction: discord.Interaction, guild: str):
        collection = self.cdb['botWhiteList']
        guild_id = int(guild)
        self.bot.white_list.remove(guild_id)

        if await collection.count_documents({'servers': {'$exists': True}}, limit=1) != 0:
            await collection.update_one({'servers': {'$exists': True}}, {'$pull': {'servers': guild_id}})
        else:
            return

        await interaction.response.send_message(f'Guild ID `{guild_id}` removed from whitelist!', ephemeral=True)

    @commands.is_owner()  # TODO: Not working, validate command checks post-interactions
    @commands.command(name='commandsync', case_insensitive=True, hidden=True, pass_context=True)
    async def command_sync(self, ctx, guild_id=None):
        """
        Syncs the application commands to Discord.

        NOTE: Provide a guild_id argument when testing to sync to a specific guild. ONLY sync globally (no argument)
        when you are creating a new command and are finished testing it locally.
        """

        try:
            guild = self.bot.get_guild(int(guild_id))
            self.bot.tree.copy_global_to(guild=guild)
            status = await self.bot.tree.sync(guild=guild)
            synced_commands = []
            if guild_id:
                embed_title = f"The following commands were synchronized to guild ID {guild_id}"
            else:
                embed_title = "The following commands were synchronized globally"

            for synced_command in status:
                synced_commands.append(synced_command.name)

            message_embed = discord.Embed(title=embed_title, description='\n'.join(synced_commands))
            await ctx.author.send(embed=message_embed)
        except discord.Forbidden:
            await ctx.send(f'ReQuest does not have the correct scope in the target guild. Add `applications.commands`'
                           f' permission and try again.')
        except Exception as e:
            await ctx.send(f'There was an error syncing commands: {e}')


async def setup(bot):
    await bot.add_cog(Admin(bot))
