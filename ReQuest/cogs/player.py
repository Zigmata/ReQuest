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
            collection = mdb[f'{member_id}']
            actives = collection.find_one({'_id': 'activeChars'})
            query = collection.find({'_id': {'$ne': 'activeChars'}}).sort('name')

            if character_name:
                if not query:
                    await ctx.send('You have no registered characters!')
                    await delete_command(ctx.message)
                    return

                name = character_name.lower()
                matches = []
                for character in query:
                    if name in character['name'].lower():
                        matches.append(character)

                if not matches:
                    await ctx.send('No characters found with that name!')
                    await delete_command(ctx.message)
                    return
                elif len(matches) == 1:
                    selection = matches[0]
                    collection.update_one({'_id': 'activeChars'}, {'$set': {f'{guild_id}': selection['_id']}})
                    await ctx.send(f'Active character changed to {selection["name"]} ({selection["note"]})')
                elif len(matches) > 1:
                    content = ''
                    for i in range(len(matches)):
                        content += '{}: {} ({})\n'.format(i + 1, matches[i]['name'], matches[i]['note'])

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
                        selection = matches[int(reply.content) - 1]
                        await ctx.send(f'Active character changed to {selection["name"]} ({selection["note"]})')
                        collection.update_one({'_id': 'activeChars'},
                                              {'$set': {f'{guild_id}': matches[int(reply.content) - 1]['_id']}})
            else:
                if not query:
                    await ctx.send('You have no registered characters!')
                    await delete_command(ctx.message)
                    return
                elif not str(guild_id) in actives:
                    await ctx.send('You have no active characters on this server!')
                    await delete_command(ctx.message)
                    return
                else:
                    for character in query:
                        if character['_id'] == actives[f'{guild_id}']:
                            await ctx.send(f'Active character: {character["name"]} ({character["note"]})')

        await delete_command(ctx.message)

    @character.command(name='list')
    async def character_list(self, ctx):
        member_id = ctx.author.id
        guild_id = ctx.guild.id
        collection = mdb[f'{member_id}']
        query = collection.find({'_id': {'$ne': 'activeChars'}}).sort('name')
        active_characters = collection.find_one({'_id': 'activeChars'})
        if not query:
            await ctx.send('You have no registered characters!')
            await delete_command(ctx.message)
            return

        names = []
        for result in query:
            if (str(guild_id) in active_characters) and result['_id'] == active_characters[str(guild_id)]:
                names.append((f'{result["name"]} (Active)', result['note']))
            else:
                names.append((result['name'], result['note']))

        post_embed = discord.Embed(title='Registered Characters', type='rich')
        for name in names:
            post_embed.add_field(name=name[0], value=name[1], inline=False)

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
        collection = mdb[f'{member_id}']
        date = datetime.utcnow()
        inventory = []

        collection.insert_one({
            '_id': character_id,
            'name': character_name,
            'note': character_note,
            'registeredDate': date,
            'level': 0,
            'experience': 0,
            'inventory': inventory,
            'currency': []
        })

        # Set the recently created character as the active character for the server.
        collection.update_one({'_id': 'activeChars'}, {'$set': {f'{guild_id}': character_id}}, upsert=True)

        await ctx.send(f'`{character_name}` registered and set as this server\'s active character!')

        await delete_command(ctx.message)

    @character.command(name='delete', aliases=['remove', 'del', 'rem'])
    async def character_delete(self, ctx, character_name):
        """
        Deletes a player character.

        Arguments:
        [character_name]: The name of the character.
        """
        member_id = ctx.author.id
        guild_id = ctx.message.guild.id
        collection = mdb[f'{member_id}']
        query = collection.find({'_id': {'$ne': 'activeChars'}}).sort('name')
        actives = collection.find_one({'_id': 'activeChars'})

        if not query:
            await ctx.send('You have no registered characters!')
            await delete_command(ctx.message)
            return

        name = character_name.lower()
        matches = []
        for character in query:
            if name in character['name'].lower():
                matches.append(character)

        if not matches:
            await ctx.send('No characters found with that name!')
            await delete_command(ctx.message)
            return
        elif len(matches) == 1:
            char = matches[0]
            await ctx.send(f'Delete character `{char["name"]} ({char["note"]})`? **Y**es/**N**o?')
            confirm = await self.bot.wait_for('message', check=lambda message: message.author == ctx.author)

            if 'y' in confirm.content.lower():
                char_id = char['_id']
                name = char['name']
                await delete_command(confirm)
                if (str(guild_id) in actives) and (char_id == actives[f'{guild_id}']):
                    collection.update_one({'_id': 'activeChars'}, {'$unset': {f'{guild_id}': 1}})
                collection.delete_one({'_id': char_id})
                await ctx.send(f'`{name}` deleted!')
            else:
                await ctx.send('Aborted!')
                await delete_command(confirm)

        elif len(matches) > 1:
            content = ''
            for i in range(len(matches)):
                content += f'{i + 1}: {matches[i]["name"]} ({matches[i]["note"]})\n'

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
                char = matches[int(reply.content) - 1]
                char_id = char['_id']
                name = char['name']
                note = char['note']
                await delete_command(match_msg)
                await delete_command(reply)
                await ctx.send(f'Delete character `{name} ({note})`? **Y**es/**N**o?')
                confirm = await self.bot.wait_for('message', check=lambda message: message.author == ctx.author)

                if 'y' in confirm.content.lower():
                    # await delete_command(confirm)
                    if (str(guild_id) in actives) and (char_id == actives[f'{guild_id}']):
                        collection.update_one({'_id': 'activeChars'}, {'$unset': {f'{guild_id}': 1}})
                    collection.delete_one({'_id': char_id})
                    await ctx.send(f'`{name}` deleted!')
                else:
                    await ctx.send('Aborted!')
                    await delete_command(confirm)

        await delete_command(ctx.message)

    @commands.group(name='experience', aliases=['xp', 'exp'], invoke_without_command=True, case_insensitive=True)
    async def experience(self, ctx):
        """
        Commands for modifying experience points. Displays the current value if no subcommand is used.
        """
        if ctx.invoked_subcommand is None:
            member_id = ctx.author.id
            guild_id = ctx.message.guild.id
            collection = mdb[f'{member_id}']
            query = collection.find({'_id': {'$ne': 'activeChars'}}).sort('name')
            actives = collection.find_one({'_id': 'activeChars'})

            # Not sure why, but operating off 'query' alone produces incorrect output here unless you map to a list
            results = list(query)

            # Load the player's characters
            if len(results) == 0:  # If none exist, output the error
                await ctx.send('You have no registered characters!')
                await delete_command(ctx.message)
                return
            if not actives or str(guild_id) not in actives:
                await ctx.send('You have no active characters on this server!')
                await delete_command(ctx.message)
                return

            # Otherwise, proceed to query the active character and retrieve its xp
            for char in results:
                if char['_id'] == actives[f'{guild_id}']:
                    name = char['name']
                    xp = char['experience']

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
        if value == 0:
            await ctx.send('Stop being a tease and enter an actual quantity!')
            await delete_command(ctx.message)
            return

        gm_member_id = ctx.author.id
        guild_id = ctx.message.guild.id
        transaction_id = str(shortuuid.uuid()[:12])

        recipient_strings = []
        for member in user_mentions:
            member_id = (strip_id(member))
            collection = mdb[f'{member_id}']
            user = await self.bot.fetch_user(member_id)
            active = collection.find_one({'_id': 'activeChars'})
            if not active or str(guild_id) not in active:
                await ctx.send(f'{user.name} has no active characters on this server!')
                await delete_command(ctx.message)
                continue

            character_id = active[f'{guild_id}']
            character = collection.find_one({'_id': character_id})
            if not character:  # If none exist, output the error
                await ctx.send(f'{user.name} has no registered characters!')
                await delete_command(ctx.message)
                continue

            # Otherwise, proceed to query the active character and retrieve its xp
            name = character['name']
            xp = character['experience']

            if xp:
                xp += value
            else:
                xp = value

            recipient_strings.append(f'<@!{member_id}> as {name}\nTotal XP: **{xp}**')

            # Update the db
            collection.update_one({'_id': character_id}, {'$set': {'experience': xp}}, upsert=True)

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
