import discord

from ReQuest.utilities.supportFunctions import log_exception


class GMRoleRemoveSelect(discord.ui.Select):
    def __init__(self, new_view):
        super().__init__(
            placeholder='Select Role(s)',
            options=[]
        )
        self.new_view = new_view

    async def callback(self, interaction: discord.Interaction):
        try:
            collection = interaction.client.gdb['gmRoles']
            for value in self.values:
                await collection.update_one({'_id': interaction.guild_id}, {'$pull': {'gmRoles': {'name': value}}})
            await self.new_view.setup_select()
            await self.new_view.setup_embed()
            await interaction.response.edit_message(embed=self.new_view.embed, view=self.new_view)
        except Exception as e:
            await log_exception(e, interaction)


class SingleChannelConfigSelect(discord.ui.ChannelSelect):
    def __init__(self, calling_view, config_type, config_name, guild_id, gdb):
        super().__init__(
            channel_types=[discord.ChannelType.text],
            placeholder=f'Search for your {config_name} Channel',
            custom_id=f'config_{config_type}_channel_select'
        )
        self.calling_view = calling_view
        self.config_type = config_type
        self.guild_id = guild_id
        self.gdb = gdb

    async def callback(self, interaction: discord.Interaction):
        try:
            collection = self.gdb[self.config_type]
            await collection.update_one({'_id': self.guild_id}, {'$set': {self.config_type: self.values[0].mention}},
                                        upsert=True)
            await self.calling_view.setup_embed()
            return await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ActiveCharacterSelect(discord.ui.Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='You have no registered characters',
            options=[],
            custom_id='active_character_select',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            selected_character_id = self.values[0]
            collection = interaction.client.mdb['characters']
            await collection.update_one({'_id': interaction.user.id},
                                        {'$set': {f'activeCharacters.{interaction.guild_id}': selected_character_id}},
                                        upsert=True)
            await self.calling_view.setup_embed()
            await self.calling_view.setup_select()
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveCharacterSelect(discord.ui.Select):
    def __init__(self, calling_view, confirm_button):
        super().__init__(
            placeholder='Select a character to remove',
            options=[],
            custom_id='remove_character_select'
        )
        self.calling_view = calling_view
        self.confirm_button = confirm_button

    async def callback(self, interaction: discord.Interaction):
        try:
            selected_character_id = self.values[0]
            self.calling_view.selected_character_id = selected_character_id
            collection = interaction.client.mdb['characters']
            query = await collection.find_one({'_id': interaction.user.id})
            character_name = query['characters'][selected_character_id]['name']
            self.calling_view.embed.add_field(name=f'Removing {character_name}',
                                              value='**This action is permanent!** Confirm?')
            self.confirm_button.disabled = False
            self.confirm_button.label = f'Confirm removal of {character_name}'
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class QuestAnnounceRoleSelect(discord.ui.RoleSelect):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Search for your Quest Announcement Role',
            custom_id='quest_announce_role_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            collection = interaction.client.gdb['announceRole']
            await collection.update_one({'_id': interaction.guild_id},
                                        {'$set': {'announceRole': self.values[0].mention}},
                                        upsert=True)
            await self.calling_view.setup_embed()
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class AddGMRoleSelect(discord.ui.RoleSelect):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Search for your GM Role(s)',
            custom_id='add_gm_role_select',
            max_values=25
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            collection = interaction.client.gdb['gmRoles']
            query = await collection.find_one({'_id': interaction.guild_id})
            if not query:
                for value in self.values:
                    await collection.update_one({'_id': interaction.guild_id},
                                                {'$push': {'gmRoles': {'mention': value.mention, 'name': value.name}}},
                                                upsert=True)
            else:
                for value in self.values:
                    matches = 0
                    for role in query['gmRoles']:
                        if value.mention in role['mention']:
                            matches += 1

                    if matches == 0:
                        await collection.update_one({'_id': interaction.guild_id},
                                                    {'$push': {
                                                        'gmRoles': {'mention': value.mention, 'name': value.name}}},
                                                    upsert=True)

            await self.calling_view.setup_embed()
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)
