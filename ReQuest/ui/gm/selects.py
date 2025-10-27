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