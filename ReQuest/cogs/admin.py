import asyncio

import discord
from discord.ext import commands
from discord.ext.commands import Cog, command


class Admin(Cog):
    """Administrative commands such as server configuration and bot options."""

    def __init__(self, bot):
        self.bot = bot
        self.gdb = bot.gdb
        self.cdb = bot.cdb

    # -----------------Listeners----------------

    @commands.Cog.listener()
    async def on_guild_join(self, server):
        # TODO: Message guild owner about whitelisting
        # TODO: Expand function to check guild db on valid join and initialize if new
        if not self.white_list or server.id in self.white_list:
            return
        else:
            return await server.leave()

    # -------------Private Commands-------------

    # Reload a cog by name
    @commands.is_owner()
    @command(hidden=True)
    async def reload(self, ctx, module: str):
        await self.bot.reload_extension('ReQuest.cogs.' + module)

        msg = await ctx.send(f'Extension successfully reloaded: `{module}`')
        await asyncio.sleep(3)
        await msg.delete()

    # Echoes the first argument provided
    @commands.is_owner()
    @command(hidden=True)
    async def echo(self, ctx, *, text):
        if not text:
            await ctx.send('Give me something to echo!')
        else:
            await ctx.send(text)

    # Loads a cog that hasn't yet been loaded
    @commands.is_owner()
    @command(hidden=True)
    async def load(self, ctx, module: str):
        await self.bot.load_extension('ReQuest.cogs.' + module)

        msg = await ctx.send(f'Extension successfully loaded: `{module}`')
        await asyncio.sleep(3)
        await msg.delete()

    # Shut down the bot
    @commands.is_owner()
    @command(hidden=True)
    async def shutdown(self, ctx):
        try:
            await ctx.send('Shutting down!')
            await self.bot.close()
        except Exception as e:
            await ctx.send(f'{type(e).__name__}: {e}')

    @commands.is_owner()
    @commands.group(name='whitelist', hidden=True, case_insensitive=True, pass_context=True)
    async def white_list(self, ctx):
        if ctx.invoked_subcommand is None:
            return  # TODO: Error message feedback

    @white_list.command(name='add', pass_context=True)
    async def whitelist_add(self, ctx, guild):
        collection = self.cdb['botWhiteList']
        guild_id = int(guild)
        self.bot.white_list.append(guild_id)

        await collection.update_one({'servers': {'$exists': True}}, {'$push': {'servers': guild_id}}, upsert=True)

        msg = await ctx.send(f'Guild `{guild_id}` added to whitelist!')

        await asyncio.sleep(3)

        await msg.delete()

    @white_list.command(name='remove', pass_context=True)
    async def whitelist_remove(self, ctx, guild):
        collection = self.cdb['botWhiteList']
        guild_id = int(guild)
        self.bot.white_list.gm_remove(guild_id)

        if await collection.count_documents({'servers': {'$exists': True}}, limit=1) != 0:
            await collection.update_one({'servers': {'$exists': True}}, {'$pull': {'servers': guild_id}})
        else:
            return

        msg = await ctx.send(f'Guild `{guild_id}` removed from whitelist!')

        await asyncio.sleep(3)

        await msg.delete()

    @commands.is_owner()
    @command(name='commandsync', case_insensitive=True, hidden=True, pass_context=True)
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
            if guild_id:
                await ctx.send(f"The following commands were synchronized to guild ID {guild_id}")
            else:
                await ctx.send("The following commands were synchronized globally:")
            for synced_command in status:
                await ctx.send(synced_command.name)
        except discord.Forbidden:
            await ctx.send(f'ReQuest does not have the correct scope in the target guild. Add `applications.commands`'
                           f' permission and try again.')
        except Exception as e:
            await ctx.send(f'There was an error syncing commands: {e}')


async def setup(bot):
    await bot.add_cog(Admin(bot))
