import inspect
import logging

from discord import ButtonStyle
from discord.ui import Button

import ReQuest.ui.modals as modals
from ..utilities.supportFunctions import log_exception

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class BaseViewButton(Button):
    def __init__(self, target_view_class, label, style, custom_id):
        super().__init__(
            label=label,
            style=style,
            custom_id=custom_id
        )
        self.target_view_class = target_view_class

    async def callback(self, interaction):
        try:
            view = self.target_view_class()
            if hasattr(view, 'setup'):
                setup_function = view.setup
                sig = inspect.signature(setup_function)
                params = sig.parameters

                kwargs = {}
                if 'bot' in params:
                    kwargs['bot'] = interaction.client
                if 'user' in params:
                    kwargs['user'] = interaction.user
                if 'guild' in params:
                    kwargs['guild'] = interaction.guild

                await setup_function(**kwargs)
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class MenuViewButton(BaseViewButton):
    def __init__(self, target_view_class, label):
        super().__init__(
            target_view_class=target_view_class,
            label=label,
            style=ButtonStyle.primary,
            custom_id=f'{label.lower()}_view_button'
        )


class BackButton(BaseViewButton):
    def __init__(self, target_view_class):
        super().__init__(
            target_view_class=target_view_class,
            label='Back',
            style=ButtonStyle.secondary,
            custom_id='menu_back_button'
        )


class RegisterCharacterButton(Button):
    def __init__(self):
        super().__init__(
            label='Register',
            style=ButtonStyle.primary,
            custom_id='register_character_button'
        )

    async def callback(self, interaction):
        try:
            modal = modals.CharacterRegisterModal(self, interaction.client.mdb, interaction.user.id,
                                                  interaction.guild_id)
            await interaction.response.send_modal(modal)
        except Exception as e: \
                await log_exception(e, interaction)


class AdminShutdownButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Shutdown',
            style=ButtonStyle.danger,
            custom_id='shutdown_bot_button'
        )
        self.confirm = False
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            if self.confirm:
                await interaction.response.send_message('Shutting down!', ephemeral=True)
                await interaction.client.close()
            else:
                self.confirm = True
                self.label = 'CONFIRM SHUTDOWN?'
                await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e)


class MenuDoneButton(Button):
    def __init__(self):
        super().__init__(
            label='Done',
            style=ButtonStyle.gray,
            custom_id='done_button'
        )

    async def callback(self, interaction):
        try:
            await interaction.response.defer()
            await interaction.followup.delete_message(interaction.message.id)
        except Exception as e:
            await log_exception(e, interaction)


class ConfirmButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Confirm',
            style=ButtonStyle.danger,
            custom_id='confirm_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            await self.calling_view.confirm_callback(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class QuestAnnounceRoleRemoveButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Remove Quest Announcement Role',
            style=ButtonStyle.red,
            custom_id='quest_announce_role_remove_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            collection = interaction.client.gdb['announceRole']
            query = await collection.find_one({'_id': interaction.guild_id})
            if query:
                await collection.delete_one({'_id': interaction.guild_id})

            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class GMRoleRemoveViewButton(BaseViewButton):
    def __init__(self, target_view_class):
        super().__init__(
            target_view_class=target_view_class,
            label='Remove GM Roles',
            style=ButtonStyle.danger,
            custom_id='gm_role_remove_view_button'
        )


class QuestSummaryToggleButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Toggle Quest Summary',
            style=ButtonStyle.primary,
            custom_id='quest_summary_toggle_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
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

            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed)
        except Exception as e:
            await log_exception(e, interaction)


class PlayerExperienceToggleButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Toggle Player Experience',
            style=ButtonStyle.primary,
            custom_id='config_player_experience_toggle_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
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

            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=self.calling_view.embed)
        except Exception as e:
            await log_exception(e, interaction)


class RemoveDenominationConfirmButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Confirm',
            style=ButtonStyle.danger,
            custom_id='remove_denomination_confirm_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            await self.calling_view.remove_currency_denomination(self.calling_view.selected_denomination_name,
                                                                 interaction.client, interaction.guild)
            await self.calling_view.setup(bot=interaction.client, guild=interaction.guild)
            self.disabled = True
            self.label = 'Confirm'
            await interaction.response.edit_message(embed=self.calling_view.embed, view=self.calling_view)
        except Exception as e:
            await log_exception(e)


class ToggleDoubleButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Select a currency',
            style=ButtonStyle.secondary,
            custom_id='toggle_double_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
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
            await view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e)


class AddDenominationButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Select a currency',
            style=ButtonStyle.success,
            custom_id='add_denomination_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            new_modal = modals.AddCurrencyDenominationTextModal(
                calling_view=self.calling_view,
                base_currency_name=self.calling_view.selected_currency_name
            )
            await interaction.response.send_modal(new_modal)
        except Exception as e:
            await log_exception(e)


class RemoveDenominationButton(BaseViewButton):
    def __init__(self, target_view_class):
        super().__init__(
            target_view_class=target_view_class,
            label='Select a currency',
            style=ButtonStyle.danger,
            custom_id='remove_denomination_button'
        )


class AddCurrencyButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Add New Currency',
            style=ButtonStyle.success,
            custom_id='add_currency_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            await interaction.response.send_modal(modals.AddCurrencyTextModal(self.calling_view))
        except Exception as e:
            await log_exception(e)


class EditCurrencyButton(BaseViewButton):
    def __init__(self, target_view_class):
        super().__init__(
            target_view_class=target_view_class,
            label='Edit Currency',
            style=ButtonStyle.secondary,
            custom_id='edit_currency_button'
        )


class RemoveCurrencyButton(BaseViewButton):
    def __init__(self, target_view_class):
        super().__init__(
            target_view_class=target_view_class,
            label='Remove Currency',
            style=ButtonStyle.danger,
            custom_id='remove_currency_button'
        )


class RemoveCurrencyConfirmButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Confirm',
            style=ButtonStyle.danger,
            custom_id='remove_currency_confirm_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            view = self.calling_view
            await view.remove_currency(bot=interaction.client, guild=interaction.guild)
            await view.setup(bot=interaction.client, guild=interaction.guild)
            view.remove_currency_confirm_button.disabled = True
            view.remove_currency_confirm_button.label = 'Confirm'
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e)


class AllowlistAddServerButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Add New Server',
            style=ButtonStyle.success,
            custom_id='allowlist_add_server_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            new_modal = modals.AllowServerModal(self.calling_view)
            await interaction.response.send_modal(new_modal)
        except Exception as e:
            await log_exception(e, interaction)


class ConfirmAllowlistRemoveButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Confirm',
            style=ButtonStyle.danger,
            custom_id='confirm_allowlist_remove_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            view = self.calling_view
            collection = interaction.client.cdb['serverAllowlist']
            await collection.update_one({'servers': {'$exists': True}},
                                        {'$pull': {'servers': {'id': view.selected_guild}}})
            await view.setup(bot=interaction.client)
            view.confirm_allowlist_remove_button.disabled = True
            view.confirm_allowlist_remove_button.label = 'Confirm'
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class AdminLoadCogButton(Button):
    def __init__(self):
        super().__init__(
            label='Load Cog',
            style=ButtonStyle.secondary,
            custom_id='admin_load_cog_button'
        )

    async def callback(self, interaction):
        try:
            async def modal_callback(modal_interaction, input_value):
                module = input_value.lower()
                await interaction.client.load_extension(f'ReQuest.cogs.{module}')
                await modal_interaction.response.send_message(f'Extension successfully loaded: `{module}`',
                                                              ephemeral=True)

            modal = modals.AdminCogTextModal('load', modal_callback)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class AdminReloadCogButton(Button):
    def __init__(self):
        super().__init__(
            label='Reload Cog',
            style=ButtonStyle.secondary,
            custom_id='admin_reload_cog_button'
        )

    async def callback(self, interaction):
        try:
            async def modal_callback(modal_interaction, input_value):
                module = input_value.lower()
                await interaction.client.reload_extension(f'ReQuest.cogs.{module}')
                await modal_interaction.response.send_message(f'Extension successfully reloaded: `{module}`',
                                                              ephemeral=True)

            modal = modals.AdminCogTextModal('reload', modal_callback)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class ViewInventoryButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='View',
            style=ButtonStyle.secondary,
            custom_id='view_inventory_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
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

            await view.setup(bot=interaction.client, user=interaction.user, guild=interaction.guild)
            view.embed.add_field(name='Possessions',
                                 value='\n'.join(items))
            view.embed.add_field(name='Currency',
                                 value='\n'.join(currencies))

            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class SpendCurrencyButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Spend Currency',
            style=ButtonStyle.secondary,
            custom_id='spend_currency_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            modal = modals.SpendCurrencyModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class CreateQuestButton(Button):
    def __init__(self, quest_view_class):
        super().__init__(
            label='Create',
            style=ButtonStyle.success,
            custom_id='create_quest_button'
        )
        self.quest_view_class = quest_view_class

    async def callback(self, interaction):
        try:
            modal = modals.CreateQuestModal(self.quest_view_class)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestButton(Button):
    def __init__(self, calling_view, quest_post_view_class):
        super().__init__(
            label='Edit',
            style=ButtonStyle.secondary,
            custom_id='edit_quest_button',
            disabled=True
        )
        self.calling_view = calling_view
        self.quest_post_view_class = quest_post_view_class

    async def callback(self, interaction):
        try:
            quest = self.calling_view.selected_quest
            modal = modals.EditQuestModal(self.calling_view, quest, self.quest_post_view_class)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class ToggleReadyButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Toggle Ready',
            style=ButtonStyle.secondary,
            custom_id='toggle_ready_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            await self.calling_view.quest_ready_toggle(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class RewardsMenuButton(Button):
    def __init__(self, calling_view, rewards_view_class):
        super().__init__(
            label='Rewards',
            style=ButtonStyle.secondary,
            custom_id='rewards_menu_button',
            disabled=True
        )
        self.calling_view = calling_view
        self.rewards_view_class = rewards_view_class

    async def callback(self, interaction):
        try:
            new_view = self.rewards_view_class(self.calling_view)
            await new_view.setup()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class RemovePlayerButton(Button):
    def __init__(self, calling_view, target_view_class):
        super().__init__(
            label='Remove Player',
            style=ButtonStyle.danger,
            custom_id='remove_player_button',
            disabled=True
        )
        self.calling_view = calling_view
        self.target_view_class = target_view_class

    async def callback(self, interaction):
        try:
            quest = self.calling_view.selected_quest
            new_view = self.target_view_class(quest)
            await new_view.setup()
            await interaction.response.edit_message(embed=new_view.embed, view=new_view)
        except Exception as e:
            await log_exception(e, interaction)


class CancelQuestButton(Button):
    def __init__(self, calling_view, target_view_class):
        super().__init__(
            label='Cancel Quest',
            style=ButtonStyle.danger,
            custom_id='cancel_quest_button',
            disabled=True
        )
        self.calling_view = calling_view
        self.target_view_class = target_view_class

    async def callback(self, interaction):
        try:
            view = self.target_view_class(self.calling_view.selected_quest)
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class PartyRewardsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Party Rewards',
            style=ButtonStyle.secondary,
            custom_id='party_rewards_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            rewards_modal = modals.RewardsModal(self)
            await interaction.response.send_modal(rewards_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def modal_callback(self, interaction, xp, items):
        try:
            view = self.calling_view
            quest = view.quest
            # Initialize the party key if it is not present
            if 'party' not in quest['rewards']:
                quest['rewards']['party'] = {}

            # Set the XP if provided, otherwise reset to 0
            if xp and xp > 0:
                quest['rewards']['party']['xp'] = xp
            elif xp is not None and xp == 0:
                quest['rewards']['party']['xp'] = 0

            if items and items == 'none':
                quest['rewards']['party']['items'] = {}
            else:
                # Initialize the items key if not present
                if 'items' not in quest['rewards']['party']:
                    quest['rewards']['party']['items'] = {}

                # If the items dict is empty, set it to the provided item dict. Otherwise, merge the two
                if len(quest['rewards']['party']['items']) == 0:
                    quest['rewards']['party']['items'] = items
                else:
                    merged_items: dict = quest['rewards']['party']['items']
                    merged_items.update(items)
                    quest['rewards']['party']['items'] = merged_items

            quest_collection = interaction.client.gdb['quests']
            await quest_collection.update_one({'guildId': quest['guildId'], 'questId': quest['questId']},
                                              {'$set': quest})
            await view.setup()
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class IndividualRewardsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Individual Rewards',
            style=ButtonStyle.secondary,
            custom_id='individual_rewards_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            rewards_modal = modals.RewardsModal(self)
            await interaction.response.send_modal(rewards_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def modal_callback(self, interaction, xp, items):
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
            await view.setup()
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class JoinQuestButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Join',
            style=ButtonStyle.success,
            custom_id='join_quest_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            await self.calling_view.join_callback(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class LeaveQuestButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Leave',
            style=ButtonStyle.danger,
            custom_id='leave_quest_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            await self.calling_view.leave_callback(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class CompleteQuestButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Confirm?',
            style=ButtonStyle.danger,
            custom_id='complete_quest_button',
            disabled=True
        )
        self.calling_view = calling_view
        self.quest_summary_modal = modals.QuestSummaryModal(self)

    async def callback(self, interaction):
        try:
            quest_summary_collection = interaction.client.gdb['questSummary']
            quest_summary_config_query = await quest_summary_collection.find_one({'_id': interaction.guild_id})
            if quest_summary_config_query and quest_summary_config_query['questSummary']:
                await interaction.response.send_modal(self.quest_summary_modal)
            else:
                await self.calling_view.complete_quest(interaction)
        except Exception as e:
            await log_exception(e, interaction)

    async def modal_callback(self, interaction):
        try:
            summary = self.quest_summary_modal.summary_input.value
            await self.calling_view.complete_quest(interaction, summary=summary)
        except Exception as e:
            await log_exception(e, interaction)


class ClearChannelsButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Clear Channels',
            style=ButtonStyle.danger,
            custom_id='clear_channels_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            view = self.calling_view
            await interaction.client.gdb['questChannel'].delete_one({'_id': interaction.guild_id})
            await interaction.client.gdb['playerBoardChannel'].delete_one({'_id': interaction.guild_id})
            await interaction.client.gdb['archiveChannel'].delete_one({'_id': interaction.guild_id})
            await view.setup(bot=interaction.client, guild=interaction.guild)
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class CreatePartyRoleButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Create Role',
            style=ButtonStyle.success,
            custom_id='create_party_role_button',
            disabled=False
        )
        self.calling_view = calling_view
        self.create_party_role_modal = None

    async def callback(self, interaction):
        try:
            self.create_party_role_modal = modals.CreatePartyRoleModal(self)
            await interaction.response.send_modal(self.create_party_role_modal)
        except Exception as e:
            await log_exception(e, interaction)

    async def modal_callback(self, interaction):
        try:
            guild = interaction.guild
            role_name = self.create_party_role_modal.role_name_input.value
            default_forbidden_names = [
                'everyone',
                'administrator',
                'game master',
                'gm',
            ]
            custom_forbidden_names = []
            config_collection = interaction.client.gdb['forbiddenRoles']
            config_query = await config_collection.find_one({'_id': interaction.guild_id})
            if config_query and config_query['forbiddenRoles']:
                for name in config_query['forbiddenRoles']:
                    custom_forbidden_names.append(name)

            if role_name.lower() in default_forbidden_names or role_name.lower() in custom_forbidden_names:
                raise Exception('That name is forbidden.')

            for role in guild.roles:
                if role.name.lower() == role_name.lower():
                    raise Exception('The proposed name for your role already exists on this server!')

            role = await guild.create_role(
                name=role_name,
                reason=f'Automated party role creation from ReQuest. Requested by {interaction.user.name}.'
            )
            party_role_collection = interaction.client.gdb['partyRole']
            await party_role_collection.update_one({'guildId': interaction.guild_id, 'gm': interaction.user.id},
                                                   {'$set': {'roleId': role.id}},
                                                   upsert=True)
            view = self.calling_view
            await view.setup(bot=interaction.client, user=interaction.user, guild=interaction.guild)
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class RemovePartyRoleButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Remove Role',
            style=ButtonStyle.danger,
            custom_id='remove_party_role_button',
            disabled=False
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            # Get the current role ID
            party_role_collection = interaction.client.gdb['partyRole']
            party_role_query = await party_role_collection.find_one({'guildId': interaction.guild_id,
                                                                     'gm': interaction.user.id})
            role_id = party_role_query['roleId']

            # Remove the role from the guild
            guild = interaction.guild
            role = guild.get_role(role_id)
            await role.delete()

            # Delete the db entry
            await party_role_collection.delete_one({'guildId': interaction.guild_id, 'gm': interaction.user.id})

            # Update the view
            view = self.calling_view
            await view.setup(bot=interaction.client, user=interaction.user, guild=interaction.guild)
            await interaction.response.edit_message(embed=view.embed, view=view)
        except Exception as e:
            await log_exception(e, interaction)


class ForbiddenRolesButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Forbidden Roles',
            style=ButtonStyle.secondary,
            custom_id='forbidden_roles_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            current_roles = []
            config_collection = interaction.client.gdb['forbiddenRoles']
            config_query = await config_collection.find_one({'_id': interaction.guild_id})
            if config_query and config_query['forbiddenRoles']:
                current_roles = config_query['forbiddenRoles']
            modal = modals.ForbiddenRolesModal(current_roles)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class CreatePlayerPostButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Create Post',
            style=ButtonStyle.success,
            custom_id='create_player_post_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            modal = modals.CreatePlayerPostModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class RemovePlayerPostButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Remove Post',
            style=ButtonStyle.danger,
            custom_id='remove_player_post_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            await self.calling_view.remove_post(interaction)
        except Exception as e:
            await log_exception(e, interaction)


class EditPlayerPostButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Edit Post',
            style=ButtonStyle.secondary,
            custom_id='edit_player_post_button',
            disabled=True
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            modal = modals.EditPlayerPostModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)


class PlayerBoardPurgeButton(Button):
    def __init__(self, calling_view):
        super().__init__(
            label='Purge Player Board',
            style=ButtonStyle.danger,
            custom_id='player_board_purge_button'
        )
        self.calling_view = calling_view

    async def callback(self, interaction):
        try:
            modal = modals.PlayerBoardPurgeModal(self.calling_view)
            await interaction.response.send_modal(modal)
        except Exception as e:
            await log_exception(e, interaction)
