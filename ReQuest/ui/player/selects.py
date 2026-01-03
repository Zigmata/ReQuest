import logging

import discord
from discord.ui import Select

from ReQuest.utilities.supportFunctions import log_exception, setup_view, update_cached_data
from ReQuest.ui.common import modals

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

    async def callback(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            selected_character_id = self.values[0]

            await update_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name='characters',
                query={'_id': interaction.user.id},
                update_data={'$set': {f'activeCharacters.{interaction.guild_id}': selected_character_id}}
            )

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveCharacterSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder='Select a character to remove',
            options=[],
            custom_id='remove_character_select'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            selected_character_id = self.values[0]
            self.calling_view.selected_character_id = selected_character_id
            confirm_modal = modals.ConfirmModal(
                title='Confirm Character Removal',
                prompt_label='WARNING: This action is irreversible!',
                prompt_placeholder='Type CONFIRM to proceed',
                confirm_callback=self.calling_view.confirm_callback
            )
            await interaction.response.send_modal(confirm_modal)
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

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.calling_view.select_callback(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class ContainerOverviewSelect(Select):
    def __init__(self, calling_view, containers: list[dict], current_page: int = 0):
        options = []
        for container in containers:
            value = container['id'] if container['id'] else 'loose'
            label = f"{container['name']} ({container['count']} items)"
            if len(label) > 100:
                label = label[:97] + '...'
            options.append(discord.SelectOption(label=label, value=value))

        super().__init__(
            placeholder='Select a container to view...',
            options=options if options else [discord.SelectOption(label='No containers', value='none')],
            custom_id=f'container_overview_select_{current_page}',
            disabled=not options
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            selected = self.values[0]
            if selected == 'none':
                return

            container_id = None if selected == 'loose' else selected

            from ReQuest.ui.player.views import ContainerItemsView
            view = ContainerItemsView(
                self.calling_view.active_character_id,
                self.calling_view.active_character,
                container_id
            )
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class ContainerItemSelect(Select):
    def __init__(self, calling_view, items: list[tuple[str, int]], current_page: int = 0):
        options = []
        for item_name, quantity in items:
            label = f'{item_name}: {quantity}'
            if len(label) > 100:
                label = label[:97] + '...'
            options.append(discord.SelectOption(label=label, value=item_name))

        super().__init__(
            placeholder='Select an item...',
            options=options if options else [discord.SelectOption(label='No items', value='none')],
            custom_id=f'container_item_select_{current_page}',
            disabled=not options
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            selected = self.values[0]
            if selected == 'none':
                return

            self.calling_view.selected_item = selected
            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class DestinationContainerSelect(Select):
    def __init__(self, calling_view, containers: list[dict], current_page: int = 0):
        options = []
        for container in containers:
            value = container['id'] if container['id'] else 'loose'
            label = container['name']
            if len(label) > 100:
                label = label[:97] + '...'
            options.append(discord.SelectOption(label=label, value=value))

        super().__init__(
            placeholder='Select destination...',
            options=options if options else [discord.SelectOption(label='No destinations', value='none')],
            custom_id=f'dest_container_select_{current_page}',
            disabled=not options
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            selected = self.values[0]
            if selected == 'none':
                return

            if selected == 'loose':
                self.calling_view.selected_destination = None
                self.calling_view._loose_items_selected = True
            else:
                self.calling_view.selected_destination = selected
                self.calling_view._loose_items_selected = False

            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class ManageContainerSelect(Select):
    def __init__(self, calling_view, containers: list[dict], current_page: int = 0):
        options = []
        for container in containers:
            value = container['id'] if container['id'] else 'loose'
            label = f"{container['name']} ({container['count']} items)"
            if len(label) > 100:
                label = label[:97] + '...'
            options.append(discord.SelectOption(label=label, value=value))

        super().__init__(
            placeholder='Select a container...',
            options=options if options else [discord.SelectOption(label='No containers', value='none')],
            custom_id=f'manage_container_select_{current_page}',
            disabled=not options
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            selected = self.values[0]
            if selected == 'none':
                return

            self.calling_view.selected_container_id = None if selected == 'loose' else selected
            self.calling_view.has_selection = True
            self.calling_view.build_view()
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)
