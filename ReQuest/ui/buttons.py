import logging

import discord
import discord.ui
from discord import ButtonStyle, Interaction
from discord.ui import Button

import ReQuest.ui.modals as modals
from ..utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class RegisterCharacterButton(Button):
    def __init__(self):
        super().__init__(
            label='Register',
            style=ButtonStyle.success,
            custom_id='register_character_button'
        )

    async def callback(self, interaction: Interaction):
        try:
            modal = modals.CharacterRegisterModal(self, interaction.client.mdb, interaction.user.id,
                                                  interaction.guild_id)
            await interaction.response.send_modal(modal)
        except Exception as e: \
                await log_exception(e, interaction)


class ListCharactersButton(Button):
    def __init__(self, target_view):
        super().__init__(
            label='List/Activate',
            style=ButtonStyle.secondary,
            custom_id='list_characters_button'
        )
        self.target_view = target_view

    async def callback(self, interaction: Interaction):
        try:
            await self.target_view.setup_select()
            await self.target_view.setup_embed()
            await interaction.response.edit_message(embed=self.target_view.embed, view=self.target_view)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveCharacterButton(Button):
    def __init__(self, target_view):
        super().__init__(
            label='Remove',
            style=ButtonStyle.danger,
            custom_id='remove_character_button'
        )
        self.target_view = target_view

    async def callback(self, interaction: Interaction):
        try:
            await self.target_view.setup_select()
            await interaction.response.edit_message(embed=self.target_view.embed, view=self.target_view)
        except Exception as e:
            await log_exception(e, interaction)


class BackButton(discord.ui.Button):
    def __init__(self, new_view):
        super().__init__(
            label='Back',
            style=discord.ButtonStyle.secondary,
            custom_id='menu_back_button'
        )
        self.new_view = new_view

    async def callback(self, interaction: discord.Interaction):
        try:
            if hasattr(self.new_view, 'setup_select'):
                await self.new_view.setup_select()
            if hasattr(self.new_view, 'setup_embed'):
                await self.new_view.setup_embed()
            await interaction.response.edit_message(embed=self.new_view.embed, view=self.new_view)
        except Exception as e:
            await log_exception(e, interaction)


class AdminShutdownButton(discord.ui.Button):
    def __init__(self, bot, calling_view):
        super().__init__(
            label='Shutdown',
            style=discord.ButtonStyle.danger,
            custom_id='shutdown_bot_button'
        )
        self.confirm = False
        self.bot = bot
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            if self.confirm:
                await interaction.response.send_message('Shutting down!', ephemeral=True)
                await self.bot.close()
            else:
                self.confirm = True
                self.label = 'CONFIRM SHUTDOWN?'
                await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e)


class ConfigBackButton(discord.ui.Button):
    def __init__(self, returning_view_class, guild_id, db, setup_embed=True, setup_select=True):
        super().__init__(
            label='Back',
            style=discord.ButtonStyle.primary,
            custom_id='back_button')
        self.guild_id = guild_id
        self.db = db
        self.returning_view_class = returning_view_class
        self.setup_embed = setup_embed
        self.setup_select = setup_select

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.returning_view_class(self.guild_id, self.db)
            if hasattr(new_view, 'setup_select') and self.setup_select:
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed') and self.setup_embed:
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class AdminBackButton(discord.ui.Button):
    def __init__(self, returning_view_class, cdb, bot, setup_embed=True, setup_select=True):
        super().__init__(
            label='Back',
            style=discord.ButtonStyle.primary,
            custom_id='back_button')
        self.cdb = cdb
        self.bot = bot
        self.returning_view_class = returning_view_class
        self.setup_embed = setup_embed
        self.setup_select = setup_select

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.returning_view_class(self.cdb, self.bot)
            if hasattr(new_view, 'setup_select') and self.setup_select:
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed') and self.setup_embed:
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class PlayerBackButton(discord.ui.Button):
    def __init__(self, returning_view_class, mdb, bot, member_id, guild_id, setup_embed=True, setup_select=True):
        super().__init__(
            label='Back',
            style=discord.ButtonStyle.primary,
            custom_id='back_button')
        self.mdb = mdb
        self.bot = bot
        self.member_id = member_id
        self.guild_id = guild_id
        self.returning_view_class = returning_view_class
        self.setup_embed = setup_embed
        self.setup_select = setup_select

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.returning_view_class(self.mdb, self.bot, self.member_id, self.guild_id)
            if hasattr(new_view, 'setup_select') and self.setup_select:
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed') and self.setup_embed:
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class ConfigMenuButton(discord.ui.Button):
    def __init__(self, submenu_view_class, label, guild_id, gdb):
        super().__init__(
            label=label,
            style=discord.ButtonStyle.primary,
            custom_id=f'config_{label.lower()}_button'
        )
        self.guild_id = guild_id
        self.gdb = gdb
        self.submenu_view_class = submenu_view_class

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.submenu_view_class(self.guild_id, self.gdb)
            await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class AdminMenuButton(discord.ui.Button):
    def __init__(self, submenu_view_class, label, cdb, bot, setup_select=True, setup_embed=True):
        super().__init__(
            label=label,
            style=discord.ButtonStyle.primary,
            custom_id=f'admin_{label.lower()}_button'
        )
        self.cdb = cdb
        self.submenu_view_class = submenu_view_class
        self.bot = bot
        self.setup_select = setup_select
        self.setup_embed = setup_embed

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.submenu_view_class(self.cdb, self.bot)
            if hasattr(new_view, 'setup_select') and self.setup_select:
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed') and self.setup_embed:
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class PlayerMenuButton(discord.ui.Button):
    def __init__(self, submenu_view_class, label, mdb, bot, member_id, guild_id, setup_select=True, setup_embed=True):
        super().__init__(
            label=label,
            style=discord.ButtonStyle.primary,
            custom_id=f'player_{label.lower()}_button'
        )
        self.submenu_view_class = submenu_view_class
        self.mdb = mdb
        self.bot = bot
        self.member_id = member_id
        self.guild_id = guild_id
        self.setup_select = setup_select
        self.setup_embed = setup_embed

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.submenu_view_class(self.mdb, self.bot, self.member_id, self.guild_id)
            if hasattr(new_view, 'setup_select') and self.setup_select:
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed') and self.setup_embed:
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class MenuForwardButton(discord.ui.Button):
    def __init__(self, menu_view, label, bot, member_id, guild_id):
        super().__init__(
            label=label,
            style=discord.ButtonStyle.primary,
            custom_id=f'{label.lower()}_menu_button'
        )
        self.menu_view = menu_view
        self.bot = bot
        self.member_id = member_id
        self.guild_id = guild_id

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.menu_view
            if hasattr(new_view, 'setup_select'):
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed'):
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class MenuDoneButton(discord.ui.Button):
    def __init__(self):
        super().__init__(
            label='Done',
            style=discord.ButtonStyle.gray,
            custom_id='done_button'
        )

    async def callback(self, interaction: discord.Interaction):
        try:

            await interaction.response.defer()
            await interaction.followup.delete_message(interaction.message.id)
        except Exception as e:
            await log_exception(e, interaction)


class ConfirmButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Confirm',
            style=discord.ButtonStyle.danger,
            custom_id='confirm_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        await self.calling_view.confirm_callback(interaction)


class QuestAnnounceRoleRemoveButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Remove Quest Announcement Role',
            style=discord.ButtonStyle.red,
            custom_id='quest_announce_role_remove_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            collection = interaction.client.gdb['announceRole']
            query = await collection.find_one({'_id': interaction.guild_id})
            if query:
                await collection.delete_one({'_id': interaction.guild_id})

            await self.calling_view.setup_embed()
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class GMRoleRemoveButton(discord.ui.Button):
    def __init__(self, new_view):
        super().__init__(
            label='Remove GM Roles',
            style=discord.ButtonStyle.red,
            custom_id='gm_role_remove_button'
        )
        self.new_view = new_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.new_view.setup_select()
            await self.new_view.setup_embed()
            await interaction.response.edit_message(embed=self.new_view.embed, view=self.new_view)
        except Exception as e:
            await log_exception(e, interaction)


class QuestSummaryToggleButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Toggle Quest Summary',
            style=discord.ButtonStyle.primary,
            custom_id='quest_summary_toggle_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            guild_id = interaction.guild_id
            collection = interaction.client.gdb['questSummary']
            query = await collection.find_one({'_id': guild_id})
            if not query:
                await collection.insert_one({'_id': guild_id, 'questSummary': True})
            else:
                if query['questSummary']:
                    await collection.update_one({'_id': guild_id}, {'$set': {'questSummary': False}})
                else:
                    await collection.update_one({'_id': guild_id}, {'$set': {'questSummary': True}})

            await self.calling_view.setup_embed()
            await interaction.response.edit_message(embed=self.calling_view.embed)
        except Exception as e:
            await log_exception(e, interaction)


class PlayerExperienceToggleButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Toggle Player Experience',
            style=discord.ButtonStyle.primary,
            custom_id='config_player_experience_toggle_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            guild_id = interaction.guild_id
            collection = interaction.client.gdb['playerExperience']
            query = await collection.find_one({'_id': guild_id})
            if query and query['playerExperience']:
                await collection.update_one({'_id': guild_id}, {'$set': {'playerExperience': False}},
                                            upsert=True)
            else:
                await collection.update_one({'_id': guild_id}, {'$set': {'playerExperience': True}},
                                            upsert=True)

            await self.calling_view.setup_embed()
            await interaction.response.edit_message(embed=self.calling_view.embed)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveDenominationConfirmButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Confirm',
            style=discord.ButtonStyle.danger,
            custom_id='remove_denomination_confirm_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.calling_view.remove_currency_denomination(self.calling_view.selected_denomination_name)
            self.calling_view.embed.clear_fields()
            await self.calling_view.setup_select()
            self.disabled = True
            self.label = 'Confirm'
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e)


class ToggleDoubleButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Select a currency',
            style=discord.ButtonStyle.secondary,
            custom_id='toggle_double_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.calling_view
            currency_name = view.selected_currency_name
            collection = interaction.client.gdb['currency']
            query = await collection.find_one({'_id': interaction.guild_id, 'currencies.name': currency_name})
            currency = next((item for item in query['currencies'] if item['name'] == currency_name), None)
            if currency['isDouble']:
                value = False
            else:
                value = True
            await collection.update_one({'_id': interaction.guild_id, 'currencies.name': currency_name},
                                        {'$set': {'currencies.$.isDouble': value}})
            await view.setup_embed(currency_name)
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e)


class AddDenominationButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Select a currency',
            style=discord.ButtonStyle.success,
            custom_id='add_denomination_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            new_modal = modals.AddCurrencyDenominationTextModal(
                calling_view=self.calling_view,
                base_currency_name=self.calling_view.selected_currency_name
            )
            await interaction.response.send_modal(new_modal)
        except Exception as e:
            await log_exception(e)


class RemoveDenominationButton(discord.ui.Button):
    def __init__(self, new_view):
        super().__init__(
            label='Select a currency',
            style=discord.ButtonStyle.danger,
            custom_id='remove_denomination_button',
            disabled=True
        )
        self.new_view = new_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.new_view.setup_select()
            await interaction.response.edit_message(embed=self.new_view.embed, view=self.new_view)
        except Exception as e:
            await log_exception(e)


class AddCurrencyButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Add New Currency',
            style=discord.ButtonStyle.success,
            custom_id='add_currency_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await interaction.response.send_modal(modals.AddCurrencyTextModal(guild_id=interaction.guild_id,
                                                                              gdb=interaction.client.gdb,
                                                                              calling_view=self.calling_view))
        except Exception as e:
            await log_exception(e)


class EditCurrencyButton(discord.ui.Button):
    def __init__(self, new_view):
        super().__init__(
            label='Edit Currency',
            style=discord.ButtonStyle.secondary,
            custom_id='edit_currency_button'
        )
        self.new_view = new_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.new_view.setup_select()
            await interaction.response.edit_message(embed=self.new_view.embed, view=self.new_view)
        except Exception as e:
            await log_exception(e)


class RemoveCurrencyButton(discord.ui.Button):
    def __init__(self, new_view):
        super().__init__(
            label='Remove Currency',
            style=discord.ButtonStyle.danger,
            custom_id='remove_currency_button'
        )
        self.new_view = new_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.new_view.setup_select()
            await interaction.response.edit_message(embed=self.new_view.embed, view=self.new_view)
        except Exception as e:
            await log_exception(e)


class RemoveCurrencyConfirmButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Confirm',
            style=discord.ButtonStyle.danger,
            custom_id='remove_currency_confirm_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.calling_view
            await view.remove_currency(view.selected_currency)
            view.embed.clear_fields()
            await view.setup_select()
            view.remove_currency_confirm_button.disabled = True
            view.remove_currency_confirm_button.label = 'Confirm'
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e)


class AllowlistAddServerButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Add New Server',
            style=discord.ButtonStyle.success,
            custom_id='allowlist_add_server_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            new_modal = modals.AllowServerModal(interaction.client.cdb, self.calling_view, interaction.client)
            await interaction.response.send_modal(new_modal)
        except Exception as e:
            await log_exception(e, interaction)


class ConfirmAllowlistRemoveButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Confirm',
            style=discord.ButtonStyle.danger,
            custom_id='confirm_allowlist_remove_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.calling_view
            collection = interaction.client.cdb['serverAllowlist']
            await collection.update_one({'servers': {'$exists': True}},
                                        {'$pull': {'servers': {'id': view.selected_guild}}})
            await view.setup_select()
            view.confirm_allowlist_remove_button.disabled = True
            view.confirm_allowlist_remove_button.label = 'Confirm'
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class AdminLoadCogButton(discord.ui.Button):
    def __init__(self):
        super().__init__(
            label='Load Cog',
            style=discord.ButtonStyle.secondary,
            custom_id='admin_load_cog_button'
        )

    async def callback(self, interaction: discord.Interaction):
        try:
            async def modal_callback(modal_interaction: discord.Interaction, input_value):
                module = input_value.lower()
                await interaction.client.load_extension(f'ReQuest.cogs.{module}')
                await modal_interaction.response.send_message(f'Extension successfully loaded: `{module}`',
                                                              ephemeral=True)

            modal = modals.AdminCogTextModal('load', modal_callback)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class AdminReloadCogButton(discord.ui.Button):
    def __init__(self):
        super().__init__(
            label='Reload Cog',
            style=discord.ButtonStyle.secondary,
            custom_id='admin_reload_cog_button'
        )

    async def callback(self, interaction: discord.Interaction):
        try:
            async def modal_callback(modal_interaction: discord.Interaction, input_value):
                module = input_value.lower()
                await interaction.client.reload_extension(f'ReQuest.cogs.{module}')
                await modal_interaction.response.send_message(f'Extension successfully reloaded: `{module}`',
                                                              ephemeral=True)

            modal = modals.AdminCogTextModal('reload', modal_callback)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class ViewInventoryButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='View',
            style=discord.ButtonStyle.secondary,
            custom_id='view_inventory_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.calling_view
            character = view.active_character
            inventory = character['attributes']['inventory']
            player_currencies = character['attributes']['currency']
            items = []
            currencies = []

            for item in inventory:
                pair = (str(item), f'**{inventory[item]}**')
                value = ': '.join(pair)
                items.append(value)

            for currency in player_currencies:
                pair = (str(currency), f'**{player_currencies[currency]}**')
                value = ': '.join(pair)
                currencies.append(value)

            await view.setup_embed()
            view.embed.add_field(name='Possessions',
                                 value='\n'.join(items))
            view.embed.add_field(name='Currency',
                                 value='\n'.join(currencies))

            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class SpendCurrencyButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Spend Currency',
            style=discord.ButtonStyle.secondary,
            custom_id='spend_currency_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.SpendCurrencyModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class MenuViewButton(discord.ui.Button):
    def __init__(self, target_view_class, label, setup_select=False, setup_embed=False):
        super().__init__(
            label=label,
            style=discord.ButtonStyle.primary,
            custom_id=f'{label.lower()}_view_button'
        )
        self.target_view_class = target_view_class
        self.setup_select = setup_select
        self.setup_embed = setup_embed

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.target_view_class(bot=interaction.client, user=interaction.user,
                                              guild_id=interaction.guild_id)
            if hasattr(new_view, 'setup_select') and self.setup_select:
                await new_view.setup_select()
            if hasattr(new_view, 'setup_embed') and self.setup_embed:
                await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class CreateQuestButton(discord.ui.Button):
    def __init__(self, quest_view_class):
        super().__init__(
            label='Create',
            style=discord.ButtonStyle.success,
            custom_id='create_quest_button'
        )
        self.quest_view_class = quest_view_class

    async def callback(self, interaction: discord.Interaction):
        try:
            modal = modals.CreateQuestModal(self.quest_view_class)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestButton(discord.ui.Button):
    def __init__(self, calling_view, quest_post_view_class):
        super().__init__(
            label='Edit',
            style=discord.ButtonStyle.secondary,
            custom_id='edit_quest_button',
            disabled=True
        )
        self.calling_view = calling_view
        self.quest_post_view_class = quest_post_view_class

    async def callback(self, interaction: discord.Interaction):
        try:
            quest = self.calling_view.selected_quest
            modal = modals.EditQuestModal(self.calling_view, quest, self.quest_post_view_class)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class ToggleReadyButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Toggle Ready',
            style=discord.ButtonStyle.secondary,
            custom_id='toggle_ready_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.calling_view.quest_ready_toggle(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class RewardsMenuButton(discord.ui.Button):
    def __init__(self, calling_view, rewards_view_class):
        super().__init__(
            label='Rewards',
            style=discord.ButtonStyle.secondary,
            custom_id='rewards_menu_button',
            disabled=True
        )
        self.calling_view = calling_view
        self.rewards_view_class = rewards_view_class

    async def callback(self, interaction: discord.Interaction):
        try:
            new_view = self.rewards_view_class(self.calling_view, interaction.client, interaction.guild_id)
            await new_view.setup_select()
            await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class RemovePlayerButton(discord.ui.Button):
    def __init__(self, calling_view, target_view_class):
        super().__init__(
            label='Remove Player',
            style=discord.ButtonStyle.danger,
            custom_id='remove_player_button',
            disabled=True
        )
        self.calling_view = calling_view
        self.target_view_class = target_view_class

    async def callback(self, interaction: discord.Interaction):
        try:
            quest = self.calling_view.selected_quest
            new_view = self.target_view_class(quest)
            await new_view.setup_select()
            await new_view.setup_embed()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class CancelQuestButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Cancel Quest',
            style=discord.ButtonStyle.danger,
            custom_id='cancel_quest_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            raise Exception('Not implemented!')
        except Exception as e:
            await log_exception(e, interaction)


class PartyRewardsButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Party Rewards',
            style=discord.ButtonStyle.secondary,
            custom_id='party_rewards_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            rewards_modal = modals.RewardsModal(self)
            await interaction.response.send_modal(rewards_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def modal_callback(self, interaction: discord.Interaction, xp, items):
        try:
            view = self.calling_view
            quest = view.quest
            if 'party' not in quest['rewards']:
                quest['rewards']['party'] = {}
            if xp and xp > 0:
                quest['rewards']['party']['xp'] = xp
            elif xp is not None and xp == 0:
                quest['rewards']['party']['xp'] = 0

            if items == 'none':
                quest['rewards']['party']['items'] = {}
            elif items:
                if len(quest['rewards']['party']['items']) == 0:
                    quest['rewards']['party']['items'] = items
                else:
                    merged_items: dict = quest['rewards']['party']['items']
                    merged_items.update(items)
                    quest['rewards']['party']['items'] = merged_items

            quest_collection = interaction.client.gdb['quests']
            await quest_collection.update_one({'guildId': quest['guildId'], 'questId': quest['questId']},
                                              {'$set': quest})
            await view.setup_embed()
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class IndividualRewardsButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Individual Rewards',
            style=discord.ButtonStyle.secondary,
            custom_id='individual_rewards_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            rewards_modal = modals.RewardsModal(self)
            await interaction.response.send_modal(rewards_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def modal_callback(self, interaction: discord.Interaction, xp, items):
        try:
            view = self.calling_view
            quest = view.quest
            character_id = view.selected_character_id
            if character_id not in quest['rewards']:
                quest['rewards'][character_id] = {}
            if 'items' not in quest['rewards'][character_id]:
                quest['rewards'][character_id]['items'] = {}
            if 'xp' not in quest['rewards'][character_id]:
                quest['rewards'][character_id]['xp'] = 0

            if xp and xp > 0:
                quest['rewards'][character_id]['xp'] = xp
            elif xp is not None and xp == 0:
                quest['rewards'][character_id]['xp'] = 0

            if items == 'none':
                quest['rewards'][character_id]['items'] = {}
            elif items:
                if len(quest['rewards'][character_id]['items']) == 0:
                    quest['rewards'][character_id]['items'] = items
                else:
                    merged_items: dict = quest['rewards'][character_id]['items']
                    merged_items.update(items)
                    quest['rewards'][character_id]['items'] = merged_items

            quest_collection = interaction.client.gdb['quests']
            await quest_collection.update_one({'guildId': quest['guildId'], 'questId': quest['questId']},
                                              {'$set': quest})
            view.quest = quest
            await view.setup_embed()
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class JoinQuestButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Join',
            style=discord.ButtonStyle.success,
            custom_id='join_quest_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.calling_view.join_callback(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class LeaveQuestButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Leave',
            style=discord.ButtonStyle.danger,
            custom_id='leave_quest_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            await self.calling_view.leave_callback(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class CompleteQuestButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Confirm?',
            style=discord.ButtonStyle.danger,
            custom_id='complete_quest_button',
            disabled=True
        )
        self.calling_view = calling_view
        self.quest_summary_modal = modals.QuestSummaryModal(self)

    async def callback(self, interaction: discord.Interaction):
        try:
            quest_summary_collection = interaction.client.gdb['questSummary']
            quest_summary_config_query = await quest_summary_collection.find_one({'_id': interaction.guild_id})
            if quest_summary_config_query and quest_summary_config_query['questSummary']:
                await interaction.response.send_modal(self.quest_summary_modal)
            else:
                await self.calling_view.complete_quest(interaction)
        except Exception as e:
            await log_exception(e, interaction)

    async def modal_callback(self, interaction: discord.Interaction):
        try:
            summary = self.quest_summary_modal.summary_input.value
            await self.calling_view.complete_quest(interaction, summary=summary)
        except Exception as e:
            await log_exception(e, interaction)


class ClearChannelsButton(discord.ui.Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Clear Channels',
            style=discord.ButtonStyle.danger,
            custom_id='clear_channels_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction: discord.Interaction):
        try:
            view = self.calling_view
            await interaction.client.gdb['questChannel'].delete_one({'_id': interaction.guild_id})
            await interaction.client.gdb['playerBoardChannel'].delete_one({'_id': interaction.guild_id})
            await interaction.client.gdb['archiveChannel'].delete_one({'_id': interaction.guild_id})
            await view.setup_embed()
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)
