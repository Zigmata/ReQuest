from datetime import datetime, timezone
import discord
import shortuuid
from discord import app_commands
from discord.ext.commands import Cog
from ..utilities.supportFunctions import strip_id
from ..utilities.checks import has_gm_or_mod
from ..utilities.ui import SingleChoiceDropdown, DropdownView

listener = Cog.listener


class Player(Cog, app_commands.Group, name='player', description='Commands for manipulating player characters.'):
    def __init__(self, bot):
        self.bot = bot
        self.mdb = bot.mdb
        super().__init__()

    experience_group = app_commands.Group(name='experience', description='Commands for viewing and modifing experience')

    @app_commands.command(name='character')
    async def character(self, interaction: discord.Interaction, character_name: str = None):
        """
        Commands for registration and management of player characters.

        Arguments:
        <none>: Displays current active character for this server.
        <character_name>: Name of the character to set as active for this server.
        """
        member_id = interaction.user.id
        guild_id = interaction.guild_id
        collection = self.mdb['characters']
        query = await collection.find_one({'_id': member_id})
        error_title = None
        error_message = None

        if character_name:
            ids = []
            if not query:
                error_title = 'Error'
                error_message = 'You have no registered characters!'
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
                error_title = 'Search failed.'
                error_message = 'No characters found with that name!'
            elif len(matches) == 1:
                char = query['characters'][matches[0]]
                await collection.update_one({'_id': member_id}, {'$set': {f'activeChars.{guild_id}': matches[0]}})
                await interaction.response.send_message(f'Active character changed to {char["name"]} ({char["note"]})',
                                                        ephemeral=True)
            elif len(matches) > 1:
                options = []
                for match in matches:
                    char = query['characters'][match]
                    options.append(discord.SelectOption(label=f'{char["name"][:40]} ({char["note"][:40]})',
                                                        value=match))
                select = SingleChoiceDropdown(placeholder='Choose One', options=options)
                view = DropdownView(select)
                await interaction.response.send_message('Multiple matches found!', view=view, ephemeral=True)
                await view.wait()
                selection_id = select.values[0]
                selection = query['characters'][selection_id]
                await interaction.edit_original_message(content=f'Active character changed to {selection["name"]} '
                                                        f'({selection["note"]})', embed=None, view=None)
                await collection.update_one({'_id': member_id}, {'$set': {f'activeChars.{guild_id}': selection_id}})
        else:
            if not query:
                error_title = 'Error'
                error_message = 'You have no registered characters!'
            elif not str(guild_id) in query['activeChars']:
                error_title = 'Error'
                error_message = 'You have no active characters on this server!'
            else:
                active_character = query['activeChars'][str(guild_id)]
                await interaction.response.send_message(f'Active character: '
                                                        f'{query["characters"][active_character]["name"]} '
                                                        f'({query["characters"][active_character]["note"]})',
                                                        ephemeral=True)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            interaction.response.send_message(embed=error_embed, ephemeral=True)

    @app_commands.command(name='list')
    async def character_list(self, interaction: discord.Interaction):
        """
        Lists the player's registered characters.
        """
        member_id = interaction.user.id
        guild_id = interaction.guild_id
        collection = self.mdb['characters']
        query = await collection.find_one({'_id': member_id})

        if not query or not query['characters']:
            error_embed = discord.Embed(title='Error', description='You have no registered characters!', type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)
        else:
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

            await interaction.response.send_message(embed=post_embed, ephemeral=True)

    # TODO: Implement max_length of 40 for names and notes
    @app_commands.command(name='register')
    async def character_register(self, interaction: discord.Interaction, character_name: str, character_note: str):
        """
        Registers a new player character.

        Arguments:
        <character_name>: The name of the character.
        <character_note>: A note for you to uniquely identify the character.
        """
        member_id = interaction.user.id
        guild_id = interaction.guild_id
        character_id = str(shortuuid.uuid())
        collection = self.mdb['characters']
        date = datetime.now(timezone.utc)

        await collection.update_one({
            '_id': member_id}, {
                '$set': {
                    f'activeChars.{guild_id}': character_id,
                    f'characters.{character_id}': {
                        'name': character_name,
                        'note': character_note,
                        'registeredDate': date,
                        'attributes': {
                            'level': None,
                            'experience': None,
                            'inventory': {},
                            'currency': {}
                        }}}}, upsert=True)

        await interaction.response.send_message(f'`{character_name}` registered and set to active for this server!',
                                                ephemeral=True)

    @app_commands.command(name='delete')
    async def character_delete(self, interaction: discord.Interaction, character_name: str):
        """
        Deletes a player character.

        Arguments:
        <character_name>: The name of the character.
        """
        member_id = interaction.user.id
        guild_id = interaction.guild_id
        collection = self.mdb['characters']
        query = await collection.find_one({'_id': member_id})
        error_title = None
        error_message = None

        ids = []
        if not query:
            error_title = 'Error!'
            error_message = 'You have no registered characters!'
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
                error_title = 'Error!'
                error_message = 'No characters found with that name!'
            elif len(matches) == 1:
                name = query['characters'][matches[0]]['name']

                # TODO: Create confirmation modal
                await collection.update_one({'_id': member_id}, {'$unset': {f'characters.{matches[0]}': ''}},
                                            upsert=True)
                for guild in query['activeChars']:
                    if query[f'activeChars'][guild] == matches[0]:
                        await collection.update_one({'_id': member_id}, {'$unset': {f'activeChars.{guild_id}': ''}},
                                                    upsert=True)
                await interaction.response.send_message(f'`{name}` deleted!', ephemeral=True)
            else:
                options = []
                for match in matches:
                    char = query['characters'][match]
                    options.append(discord.SelectOption(label=f'{char["name"][:40]} ({char["note"][:40]})',
                                                        value=match))
                select = SingleChoiceDropdown(placeholder='Choose One', options=options)
                view = DropdownView(select)
                await interaction.response.send_message('Multiple matches found!', view=view, ephemeral=True)
                await view.wait()
                selection_id = select.values[0]
                await collection.update_one({'_id': member_id}, {'$unset': {f'characters.{selection_id}': ''}},
                                            upsert=True)
                for guild in query['activeChars']:
                    if query[f'activeChars'][guild] == selection_id:
                        await collection.update_one({'_id': member_id}, {'$unset': {f'activeChars.{guild_id}': ''}},
                                                    upsert=True)
                await interaction.edit_original_message(content=f'`{query["characters"][selection_id]["name"]}` '
                                                                f'deleted!', embed=None, view=None)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    @experience_group.command(name='view')
    async def view_experience(self, interaction: discord.Interaction):
        """
        Commands for modifying experience points. Displays the current value if no subcommand is used.
        """
        member_id = interaction.user.id
        guild_id = interaction.guild_id
        collection = self.mdb['characters']
        error_title = None
        error_message = None

        # Load the player's characters
        query = await collection.find_one({'_id': member_id})
        if not query:  # If none exist, output the error
            error_title = 'Error!'
            error_message = 'You have no registered characters!'
        elif not str(guild_id) in query['activeChars']:
            error_title = 'Error!'
            error_message = 'You have no active characters on this server!'
        else:  # Otherwise, proceed to query the active character and retrieve its xp
            active_character = query['activeChars'][str(guild_id)]
            char = query['characters'][active_character]
            name = char['name']
            xp = char['attributes']['experience']

            xp_embed = discord.Embed(title=f'{name}', type='rich', description=f'Total Experience: **{xp}**')
            await interaction.response.send_message(embed=xp_embed, ephemeral=True)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)

    @experience_group.command(name='mod')
    @has_gm_or_mod()
    async def mod_experience(self, interaction: discord.Interaction, value: int, user_mention: str):
        """
        GM Command: Modifies the experience points of a player's currently active character.
        Requires an assigned GM role or Server Moderator privileges.

        Arguments:
        <value>: The amount of experience given.
        <user_mentions>: User mention(s) of the receiving player(s). Can be chained.
        """
        gm_member_id = interaction.user.id
        guild_id = interaction.guild_id
        collection = self.mdb['characters']
        transaction_id = str(shortuuid.uuid()[:12])
        error_title = None
        error_message = None

        if value == 0:
            error_title = 'Invalid value'
            error_message = 'Stop being a tease and enter an actual quantity!'
        else:
            member_id = (strip_id(user_mention))
            user = await self.bot.fetch_user(member_id)
            query = await collection.find_one({'_id': member_id})

            if not query:  # If none exist, output the error
                error_title = 'Error!'
                error_message = f'{user.name} has no registered characters!'
            elif not str(guild_id) in query['activeChars']:
                error_title = 'Error!'
                error_message = f'{user.name} has no active characters on this server!'
            else:
                # Otherwise, proceed to query the active character and retrieve its xp
                active_character = query['activeChars'][str(guild_id)]
                char = query['characters'][active_character]
                name = char['name']
                xp = char['attributes']['experience']

                if xp:
                    xp += value
                else:
                    xp = value

                # Update the db
                await collection.update_one({'_id': member_id},
                                            {'$set': {f'characters.{active_character}.attributes.experience': xp}},
                                            upsert=True)

                # Dynamic feedback based on the operation performed
                function = 'gained'
                if value < 0:
                    function = 'lost'
                absolute = abs(value)
                xp_embed = discord.Embed(title=f'{absolute} experience points {function}!', type='rich',
                                         description=f'<@!{member_id}> as {name}\nTotal XP: **{xp}**')
                xp_embed.add_field(name='Game Master', value=f'<@!{gm_member_id}>')
                xp_embed.set_footer(text=f'{datetime.utcnow().strftime("%Y-%m-%d")} Transaction ID: {transaction_id}')
                await interaction.response.send_message(embed=xp_embed, ephemeral=True)

        if error_message:
            error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
            await interaction.response.send_message(embed=error_embed, ephemeral=True)


async def setup(bot):
    await bot.add_cog(Player(bot))
