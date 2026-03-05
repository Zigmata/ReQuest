import discord
from discord import app_commands
from discord.ext import commands
from discord.ext.commands import Cog

from ReQuest.ui.admin import views
from ReQuest.utilities.checks import is_owner
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE
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
                    embed = discord.Embed(
                        title=t(DEFAULT_LOCALE, 'admin-embed-title-unauthorized'),
                        description=t(DEFAULT_LOCALE, 'admin-embed-desc-unauthorized'),
                        color=discord.Color.red()
                    )
                    await guild.owner.send(embed=embed)
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
                embed_title = t(DEFAULT_LOCALE, 'admin-embed-title-sync-guild', guildName=guild.name, guildId=guild_id)
            else:
                embed_title = t(DEFAULT_LOCALE, 'admin-embed-title-sync-global')

            for synced_command in status:
                synced_commands.append(synced_command.name)

            message_embed = discord.Embed(title=embed_title, description='\n'.join(synced_commands))
            await ctx.author.send(embed=message_embed)
        except discord.Forbidden:
            await ctx.send(t(DEFAULT_LOCALE, 'admin-error-missing-scope'))
        except Exception as e:
            await ctx.send(t(DEFAULT_LOCALE, 'admin-error-sync-failed', error=str(e)))

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

            await ctx.author.send(t(DEFAULT_LOCALE, 'admin-msg-commands-cleared'))
        except discord.Forbidden:
            await ctx.send(t(DEFAULT_LOCALE, 'admin-error-missing-scope'))
        except Exception as e:
            await ctx.send(t(DEFAULT_LOCALE, 'admin-error-sync-failed', error=str(e)))

    @app_commands.command(
        name='admin',
        description=app_commands.locale_str('Administration wizard. Bot owner only')
    )
    @is_owner()
    @app_commands.dm_only()
    async def admin(self, interaction: discord.Interaction):
        try:
            view = views.AdminBaseView()
            await interaction.response.send_message(view=view, ephemeral=True)
        except Exception as e:
            await log_exception(e, interaction)


async def setup(bot):
    await bot.add_cog(Admin(bot))
