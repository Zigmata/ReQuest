from datetime import datetime
import discord
import shortuuid
from discord.ext import commands
from discord.ext.commands import Cog

from ..utilities.supportFunctions import delete_command, strip_id
from ..utilities.checks import has_gm_or_mod, has_active_character

listener = Cog.listener

global gdb
global mdb


class Currency(Cog):
    def __init__(self, bot):
        self.bot = bot
        global gdb
        global mdb
        gdb = bot.gdb
        mdb = bot.mdb

    @commands.group(aliases=['c'], case_insensitive=True, invoke_without_subcommand=True)
    async def currency(self, ctx):
        """
        Commands for management of currency.
        """
        if ctx.invoked_subcommand is None:
            member_id = ctx.author.id
            guild_id = ctx.message.guild.id
            collection = mdb['characters']
            query = collection.find_one({'_id': member_id})

            if not query:
                await ctx.send('You do not have any registered characters!')
                await delete_command(ctx.message)
                return
            elif str(guild_id) not in query['activeChars']:
                await ctx.send('You do not have an active character for this server!')
                await delete_command(ctx.message)
                return

            active_id = query['activeChars'][f'{guild_id}']
            character = query['characters'][active_id]
            name = character['name']
            currency = character['attributes']['currency']

            post_embed = discord.Embed(title=f'{name}\'s Currency', type='rich')

            if currency is None:
                post_embed.description = f'{name} doesn\'t believe in holding currency.'
            else:
                for currency_type in currency:
                    post_embed.add_field(name=f'{currency_type}.name', value=f'{currency_type}.value')

        await delete_command(ctx.message)

    @currency.command(name='mod')
    @has_gm_or_mod()
    async def currency_mod(self, ctx, currency_name, quantity: int, *user_mentions):
        """

        """
        return

    @currency.command(name='give')
    @has_active_character()
    async def currency_give(self, ctx, user_mention, currency_name, quantity: int = 1):
        """

        """
        return

    @currency.command(name='spend')
    @has_active_character()
    async def currency_spend(self, ctx, currency_name, quantity: int):
        """

        """
        return


def setup(bot):
    bot.add_cog(Currency(bot))
