import logging

import discord
from discord.ui import Select, RoleSelect, ChannelSelect

from ReQuest.utilities.supportFunctions import log_exception, find_member_and_character_id_in_lists

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class GMRoleRemoveSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select Role(s)',
            options=[]
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            collection = interaction.client.gdb['gmRoles']
            for value in self.values:
                await collection.update_one({'_id': interaction.guild_id}, {'$pull': {'gmRoles': {'name': value}}})
            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class SingleChannelConfigSelect(ChannelSelect):
    def __init__(self, calling_view, config_type, config_name):
        super().__init__(
            channel_types=[discord.ChannelType.text],
            placeholder=f'Search for your {config_name} Channel',
            custom_id=f'config_{config_type}_channel_select'
        )
        self.calling_view = calling_view
        self.config_type = config_type

    async def callback(self, interaction):
        try:
            collection = interaction.client.gdb[self.config_type]
            await collection.update_one({'_id': interaction.guild_id},
                                        {'$set': {self.config_type: self.values[0].mention}},
                                        upsert=True)
            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            return await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


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


class QuestAnnounceRoleSelect(RoleSelect):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Search for your Quest Announcement Role',
            custom_id='quest_announce_role_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            collection = interaction.client.gdb['announceRole']
            await collection.update_one({'_id': interaction.guild_id},
                                        {'$set': {'announceRole': self.values[0].mention}},
                                        upsert=True)
            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class AddGMRoleSelect(RoleSelect):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Search for your GM Role(s)',
            custom_id='add_gm_role_select',
            max_values=25
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
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

            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ConfigWaitListSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            options=[
                discord.SelectOption(label='0 (Disabled)', value='0'),
                discord.SelectOption(label='1', value='1'),
                discord.SelectOption(label='2', value='2'),
                discord.SelectOption(label='3', value='3'),
                discord.SelectOption(label='4', value='4'),
                discord.SelectOption(label='5', value='5')
            ],
            placeholder='Select Wait List size',
            custom_id='config_wait_list_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            collection = interaction.client.gdb['questWaitList']
            await collection.update_one({'_id': interaction.guild_id},
                                        {'$set': {'questWaitList': int(self.values[0])}},
                                        upsert=True)
            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveDenominationSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select a denomination',
            options=[],
            custom_id='remove_denomination_select',
            row=0
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            denomination_name = self.values[0]
            self.calling_view.selected_denomination_name = denomination_name
            self.calling_view.remove_denomination_confirm_button.label = f'Confirm deletion of {denomination_name}'
            self.calling_view.remove_denomination_confirm_button.disabled = False
            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e)


class EditCurrencySelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Choose a currency to edit',
            options=[],
            custom_id='edit_currency_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            view = self.calling_view
            view.selected_currency_name = self.values[0]

            await view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e)


class RemoveCurrencySelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select a currency',
            options=[],
            custom_id='remove_currency_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            view = self.calling_view
            view.selected_currency_name = self.values[0]
            view.remove_currency_confirm_button.label = f'Confirm deletion of {self.values[0]}'
            view.remove_currency_confirm_button.disabled = False
            await view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e)


class RemoveGuildAllowlistSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select a server to remove',
            options=[],
            custom_id='remove_guild_allowlist_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            view = self.calling_view
            guild_id = int(self.values[0])
            collection = interaction.client.cdb['serverAllowlist']
            query = await collection.find_one({'servers': {'$exists': True}, 'servers.id': guild_id})
            server = next((server for server in query['servers'] if server['id'] == guild_id))
            logger.debug(f'Found server: {server}')
            view.selected_guild = server['id']
            view.confirm_allowlist_remove_button.disabled = False
            view.confirm_allowlist_remove_button.label = f'Confirm removal of {server['name']}'
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class ManageQuestSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select a quest to manage',
            options=[],
            custom_id='manage_quest_select',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            quest_id = self.values[0]
            view = self.calling_view
            quest_collection = interaction.client.gdb['quests']
            quest = await quest_collection.find_one({'guildId': interaction.guild_id, 'questId': quest_id})
            view.selected_quest = quest
            view.edit_quest_button.disabled = False
            view.toggle_ready_button.disabled = False
            view.rewards_menu_button.disabled = False
            view.remove_player_button.disabled = False
            view.cancel_quest_button.disabled = False
            await view.setup(bot=interaction.client, user=interaction.user, guild=interaction.guild)

            view.embed.add_field(name='Selected Quest', value=f'`{quest_id}`: **{quest['title']}**')
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class PartyMemberSelect(Select):
    def __init__(self, calling_view, disabled_components=None):
        super().__init__(
            placeholder='Select a party member',
            options=[],
            custom_id='party_member_select',
            disabled=True
        )
        self.calling_view = calling_view
        self.disabled_components = disabled_components

    async def callback(self, interaction):
        try:
            character_id = self.values[0]
            view = self.calling_view
            quest = view.quest
            for player in quest['party']:
                for member_id in player:
                    for character_id_key in player[str(member_id)]:
                        if character_id_key == character_id:
                            character = player[str(member_id)][character_id]
                            view.selected_character = character
                            view.selected_character_id = character_id
            await view.setup()
            if self.disabled_components:
                for component in self.disabled_components:
                    component.disabled = False
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class RemovePlayerSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select a party member',
            options=[],
            custom_id='remove_player_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            view = self.calling_view
            party = view.quest['party']
            wait_list = view.quest['waitList']
            member_id, character_id = find_member_and_character_id_in_lists([party, wait_list], self.values[0])
            view.selected_character_id = character_id
            view.selected_member_id = member_id
            view.confirm_button.disabled = False
            view.confirm_button.label = 'Confirm?'
            await view.setup()
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class ManageableQuestSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select a quest',
            options=[],
            custom_id='manageable_quest_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            await self.calling_view.select_callback(interaction)
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
