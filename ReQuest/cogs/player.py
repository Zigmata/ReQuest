from datetime import datetime

import discord
import shortuuid
from discord.ext import commands
from discord.ext.commands import Cog

from ..utilities.supportFunctions import delete_command, strip_id
from ..utilities.checks import has_gm_or_mod

listener = Cog.listener

global gdb
global mdb


class Player(Cog):
    def __init__(self, bot):
        self.bot = bot
        global gdb
        global mdb
        gdb = bot.gdb
        mdb = bot.mdb

    @commands.group(aliases=['char'], invoke_without_command=True, case_insensitive=True)
    async def character(self, ctx, character_name: str = None):
        if ctx.invoked_subcommand is None:
            member_id = ctx.author.id
            guild_id = ctx.message.guild.id
            collection = mdb['characters']
            query = collection.find_one({'memberId': member_id})

            if character_name:
                ids = []
                if not query:
                    await ctx.send('You have no registered characters!')
                    await delete_command(ctx.message)
                    return
                else:
                    for character_id in query['characters']:
                        ids.append(character_id)

                name = character_name.lower()
                matches = []
                for character_id in ids:
                    char = query['characters'][character_id]
                    if name in char['name'].lower():
                        matches.append(character_id)

                if not matches:
                    await ctx.send('No characters found with that name!')
                    await delete_command(ctx.message)
                    return
                elif len(matches) == 1:
                    char = query['characters'][matches[0]]
                    collection.update_one({'memberId': member_id}, {'$set': {f'activeChars.{guild_id}': matches[0]}})
                    await ctx.send(f'Active character changed to {char["name"]} ({char["note"]})')
                elif len(matches) > 1:
                    content = ''
                    for i in range(len(matches)):
                        content += '{}: {} ({})\n'.format(i + 1, query['characters'][matches[i]]['name'],
                                                          query['characters'][matches[i]]['note'])

                    match_embed = discord.Embed(title="Your query returned more than one result!", type='rich',
                                                description=content)

                    match_msg = await ctx.send(embed=match_embed)

                    reply = await self.bot.wait_for('message', check=lambda message: message.author == ctx.author)
                    if int(reply.content) > len(matches):
                        await delete_command(ctx.message)
                        await delete_command(match_msg)
                        await delete_command(reply)
                        await ctx.send('Selection is outside the list of options.')
                        return
                    else:
                        await delete_command(match_msg)
                        await delete_command(reply)
                        selection = query['characters'][matches[int(reply.content) - 1]]
                        await ctx.send(f'Active character changed to {selection["name"]} ({selection["note"]})')
                        collection.update_one({'memberId': member_id},
                                              {'$set': {f'activeChars.{guild_id}': matches[int(reply.content) - 1]}})
            else:
                if not query:
                    await ctx.send('You have no registered characters!')
                    await delete_command(ctx.message)
                    return
                elif not str(guild_id) in query['activeChars']:
                    await ctx.send('You have no active characters on this server!')
                    await delete_command(ctx.message)
                    return
                else:
                    active_character = query['activeChars'][str(guild_id)]
                    await ctx.send(f'Active character: {query["characters"][active_character]["name"]} '
                                   f'({query["characters"][active_character]["note"]})')

        await delete_command(ctx.message)

    @character.command(name='list')
    async def character_list(self, ctx):
        member_id = ctx.author.id
        guild_id = ctx.guild.id
        collection = mdb['characters']
        query = collection.find_one({'memberId': member_id})
        if not query:
            await ctx.send('You have no registered characters!')
            await delete_command(ctx.message)
            return

        ids = []
        for character_id in query['characters']:
            ids.append(character_id)

        post_embed = discord.Embed(title='Registered Characters', type='rich')
        for character_id in ids:
            char = query['characters'][character_id]
            if str(guild_id) in query['activeChars']:
                if character_id == query['activeChars'][str(guild_id)]:
                    post_embed.add_field(name=char['name'] + ' (Active)', value=char['note'], inline=False)
                    continue

            post_embed.add_field(name=char['name'], value=char['note'], inline=False)

        await ctx.send(embed=post_embed)

        await delete_command(ctx.message)

    @character.command(name='register', aliases=['reg'])
    async def character_register(self, ctx, character_name, character_note):
        """
        Registers a new player character.

        Arguments:
        [character_name]: The name of the character.
        [character_note]: A note to uniquely identify the character.
        """
        guild_id = ctx.message.guild.id
        member_id = ctx.author.id
        character_id = str(shortuuid.uuid())
        collection = mdb['characters']
        date = datetime.utcnow()
        char_xp = None
        inventory = {}

        # Prompt user to initialize fields such as inventory, xp, etc.
        await ctx.send(f'{character_name} registered with ID `{character_id}`!')
        # Adds the provided character info to the db
        collection.update_one({'memberId': member_id},
                              {'$set': {f'activeChars.{guild_id}': character_id, f'characters.{character_id}': {
                                  'name': character_name,
                                  'note': character_note,
                                  'registeredDate': date,
                                  'attributes': {
                                      'level': None,
                                      'experience': char_xp,
                                      'inventory': inventory,
                                      'currency': None}}}},
                              upsert=True)

        await delete_command(ctx.message)

    @character.command(name='delete', aliases=['remove', 'del', 'rem'])
    async def character_delete(self, ctx, character_name):
        """
        Deletes a player character.

        Arguments:
        [character_name]: The name of the character.
        """
        member_id = ctx.author.id
        collection = mdb['characters']
        query = collection.find_one({'memberId': member_id})

        ids = []
        if not query:
            await ctx.send('You have no registered characters!')
            await delete_command(ctx.message)
            return
        else:
            for character_id in query['characters']:
                ids.append(character_id)

        name = character_name.lower()
        matches = []
        for character_id in ids:
            char = query['characters'][character_id]
            if name in char['name'].lower():
                matches.append(character_id)

        if not matches:
            await ctx.send('No characters found with that name!')
            await delete_command(ctx.message)
            return
        elif len(matches) == 1:
            char = query['characters'][matches[0]]
            collection.update_one({'memberId': member_id}, {'$pull': {'characters': char}})
            # TODO: Set active character to first in list
        elif len(matches) > 1:
            content = ''
            for i in range(len(matches)):
                content += '{}: {} ({})\n'.format(i + 1, query['characters'][matches[i]]['name'],
                                                  query['characters'][matches[i]]['note'])

            match_embed = discord.Embed(title="Your query returned more than one result!", type='rich',
                                        description=content)

            match_msg = await ctx.send(embed=match_embed)

            reply = await self.bot.wait_for('message', check=lambda message: message.author == ctx.author)
            if int(reply.content) > len(matches):
                await delete_command(ctx.message)
                await delete_command(match_msg)
                await delete_command(reply)
                await ctx.send('Selection is outside the list of options.')
                return
            else:
                await delete_command(match_msg)
                await delete_command(reply)
                collection.update_one({'memberId': member_id},
                                      {'$pull': {'characters': matches[int(reply.content) - 1]}})
                # TODO: Set active character to first in list

    @character.command(name='experience', aliases=['xp', 'exp'])
    async def character_xp(self, ctx):
        """
        Displays the currently active character's experience points.
        """
        member_id = ctx.author.id
        collection = mdb['characters']

        # Load the author's characters
        query = collection.find_one({'memberId': member_id})
        if not query:  # If none exist, output the error
            await ctx.send('You have no registered characters!')
            await delete_command(ctx.message)
            return

        # Otherwise, proceed to query the active character and retrieve its xp
        active_character = query['activeChar']
        char = query['characters'][active_character]
        name = char['name']
        xp = char['attributes']['experience']

        if xp:
            post_embed = discord.Embed(title=f'{name}\'s Experience', type='rich',
                                       description=f'Total Experience: {xp}')
            await ctx.send(embed=post_embed)
        else:
            await ctx.send(f'{name} is rather inexperienced! Did you forget to add some?')

    @commands.group(name='experience', aliases=['xp', 'exp'], invoke_without_command=True, case_insensitive=True)
    async def experience(self, ctx):
        """
        Commands for modifying experience points. Displays the current value if no subcommand is used.
        """
        # TODO: error handling for non integer values given
        member_id = ctx.author.id
        guild_id = ctx.message.guild.id
        collection = mdb['characters']

        # Load the player's characters
        query = collection.find_one({'memberId': member_id})
        if not query:  # If none exist, output the error
            await ctx.send('Player has no registered characters!')
            await delete_command(ctx.message)
            return
        elif not str(guild_id) in query['activeChars']:
            await ctx.send('Player has no active characters on this server!')
            await delete_command(ctx.message)
            return

        # Otherwise, proceed to query the active character and retrieve its xp
        active_character = query['activeChars'][str(guild_id)]
        char = query['characters'][active_character]
        name = char['name']
        xp = char['attributes']['experience']

        xp_embed = discord.Embed(title=f'{name}', type='rich', description=f'Total Experience: **{xp}**')
        await ctx.send(embed=xp_embed)

        await delete_command(ctx.message)

    @experience.command(name='mod')
    @has_gm_or_mod()
    async def mod_experience(self, ctx, value: int, *user_mentions):
        """
        GM Command: Modifies the experience points of a player's currently active character.
        Requires an assigned GM role or Server Moderator privileges.

        Arguments:
        <value>: The amount of experience given.
        <user_mentions>: User mention(s) of the receiving player(s). Can be chained.
        """
        gm_member_id = ctx.author.id
        if value == 0:
            await ctx.send('Stop being a tease and enter an actual quantity!')
            await delete_command(ctx.message)
            return

        guild_id = ctx.message.guild.id
        collection = mdb['characters']
        transaction_id = str(shortuuid.uuid()[:12])

        recipient_strings = []
        for member in user_mentions:
            member_id = (strip_id(member))
            user = await self.bot.fetch_user(member_id)
            query = collection.find_one({'memberId': member_id})
            if not query:  # If none exist, output the error
                await ctx.send(f'{user.name} has no registered characters!')
                await delete_command(ctx.message)
                continue
            elif not str(guild_id) in query['activeChars']:
                await ctx.send(f'{user.name} has no active characters on this server!')
                await delete_command(ctx.message)
                continue

            # Otherwise, proceed to query the active character and retrieve its xp
            active_character = query['activeChars'][str(guild_id)]
            char = query['characters'][active_character]
            name = char['name']
            xp = char['attributes']['experience']

            if xp:
                xp += value
            else:
                xp = value

            recipient_strings.append(f'<@!{member_id}> as {name}\nTotal XP: **{xp}**')

            # Update the db
            collection.update_one({'memberId': member_id},
                                  {'$set': {f'characters.{active_character}.attributes.experience': xp}}, upsert=True)

        # Dynamic feedback based on the operation performed
        function = 'gained'
        if value < 0:
            function = 'lost'
        absolute = abs(value)
        xp_embed = discord.Embed(title=f'{absolute} experience points {function}!', type='rich',
                                 description='\n\n'.join(recipient_strings))
        xp_embed.add_field(name='Game Master', value=f'<@!{gm_member_id}>')
        xp_embed.set_footer(text=f'{datetime.utcnow().strftime("%Y-%m-%d")} Transaction ID: {transaction_id}')

        await ctx.send(embed=xp_embed)

        await delete_command(ctx.message)


def setup(bot):
    bot.add_cog(Player(bot))
