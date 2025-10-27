import logging

import discord
from discord.ui import Select, RoleSelect, ChannelSelect

from ReQuest.utilities.supportFunctions import log_exception, find_member_and_character_id_in_lists

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)




class ActiveCharacterSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='You have no registered characters',
            options=[],
            custom_id='active_character_select',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            selected_character_id = self.values[0]
            collection = interaction.client.mdb['characters']
            await collection.update_one({'_id': interaction.user.id},
                                        {'$set': {f'activeCharacters.{interaction.guild_id}': selected_character_id}},
                                        upsert=True)
            await self.calling_view.setup(bot=interaction.client, user=interaction.user, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveCharacterSelect(Select):
    def __init__(self, calling_view, confirm_button):
        super().__init__(
            placeholder='Select a character to remove',
            options=[],
            custom_id='remove_character_select'
        )
        self.calling_view = calling_view
        self.confirm_button = confirm_button

    async def callback(self, interaction):
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


class ManageablePostSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select a post',
            options=[],
            custom_id='manageable_post_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            await self.calling_view.select_callback(interaction)
        except Exception as e:
            await log_exception(e, interaction)
