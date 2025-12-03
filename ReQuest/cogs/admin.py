import discord
from discord import app_commands
from discord.ext import commands
from discord.ext.commands import Cog

from ReQuest.ui.admin import views
from ReQuest.utilities.checks import is_owner
from ReQuest.utilities.supportFunctions import log_exception


class Admin(Cog):
    def __init__(self, bot):
        self.bot = bot
        self.cdb = bot.cdb
        super().__init__()

    # -----------------Listeners----------------

    @commands.Cog.listener()
    async def on_guild_join(self, guild):
        try:
            if self.bot.allow_list_enabled:
                if guild.id in self.bot.allow_list:
                    return None
                else:
                    await guild.owner.send(
                        'Thank you for your interest in ReQuest! Your server is not in ReQuest\'s list of '
                        'authorized testing servers. Please join the support server and contact the '
                        'development team to request test access.')
                    return await guild.leave()
        except Exception as e:
            await log_exception(e)

    # -------------Private Commands-------------

    @commands.command(name='commandsync', hidden=True)
    @commands.dm_only()
    @commands.is_owner()
    async def command_sync(self, ctx, guild_id=None):
        """
        Syncs the application commands to Discord.

        NOTE: Provide a guild_id argument when testing to sync to a specific guild. ONLY sync globally (no argument)
        when you are creating a new command and are finished testing it locally.
        """

        try:
            if guild_id:
                guild = self.bot.get_guild(int(guild_id))
                self.bot.tree.copy_global_to(guild=guild)
            else:
                guild = None

            status = await self.bot.tree.sync(guild=guild)
            synced_commands = []
            if guild_id:
                embed_title = f'The following commands were synchronized to {guild.name}, ID {guild_id}'
            else:
                embed_title = 'The following commands were synchronized globally'

            for synced_command in status:
                synced_commands.append(synced_command.name)

            message_embed = discord.Embed(title=embed_title, description='\n'.join(synced_commands))
            await ctx.author.send(embed=message_embed)
        except discord.Forbidden:
            await ctx.send(f'ReQuest does not have the correct scope in the target guild. Add `applications.commands` '
                           f'permission and try again.')
        except Exception as e:
            await ctx.send(f'There was an error syncing commands: {e}')

    @commands.command(name='commandclear', hidden=True)
    @commands.dm_only()
    @commands.is_owner()
    async def command_clear(self, ctx, guild_id=None):
        """
        Clears application commands. Sync your commands after doing this.

        NOTE: Provide a guild_id argument when testing to clear a specific guild. No argument performs a global clear.
        """

        try:
            if guild_id:
                guild = self.bot.get_guild(int(guild_id))
            else:
                guild = None

            self.bot.tree.clear_commands(guild=guild)

            await ctx.author.send('Commands cleared.')
        except discord.Forbidden:
            await ctx.send(f'ReQuest does not have the correct scope in the target guild. Add `applications.commands` '
                           f'permission and try again.')
        except Exception as e:
            await ctx.send(f'There was an error syncing commands: {e}')

    @app_commands.command(name='admin')
    @is_owner()
    @app_commands.dm_only()
    async def admin(self, interaction: discord.Interaction):
        """
        Administration wizard. Bot owner only
        """
        try:
            view = views.AdminBaseView()
            await interaction.response.send_message(view=view, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


async def setup(bot):
    await bot.add_cog(Admin(bot))
