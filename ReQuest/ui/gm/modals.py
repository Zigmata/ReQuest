import logging
from titlecase import titlecase

import discord
import discord.ui
import shortuuid
from ReQuest.ui.common.modals import LocaleModal

from ReQuest.ui.common.enums import RewardType
from ReQuest.utilities.constants import QuestFields, QuestStatus, ConfigFields, CommonFields, DatabaseCollections
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE, resolve_locale, resolve_user_locale, resolve_guild_locale
from ReQuest.utilities.character import update_character_inventory, update_character_experience
from ReQuest.utilities.currency import find_currency_or_denomination, get_denomination_map
from ReQuest.utilities.db_cache import update_cached_data, get_cached_data, build_cache_key
from ReQuest.utilities.discord_utils import setup_view, strip_id, escape_markdown
from ReQuest.utilities.exceptions import log_exception, UserFeedbackError

logger = logging.getLogger(__name__)


class CreateQuestModal(LocaleModal):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'gm-modal-title-create-quest'),
            timeout=None
        )
        self.calling_view = calling_view

        self.quest_title_text_input = discord.ui.TextInput(
            label=t(locale, 'gm-modal-label-quest-title'),
            custom_id='quest_title_text_input',
            placeholder=t(locale, 'gm-modal-placeholder-quest-title')
        )
        self.add_item(self.quest_title_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            title = self.quest_title_text_input.value
            guild_id = interaction.guild_id
            quest_id = str(shortuuid.uuid()[:8])
            bot = interaction.client
            author_id = interaction.user.id

            quest = {
                QuestFields.GUILD_ID: guild_id,
                QuestFields.QUEST_ID: quest_id,
                QuestFields.MESSAGE_ID: 0,
                QuestFields.TITLE: title,
                QuestFields.DESCRIPTION: '',
                QuestFields.MAX_PARTY_SIZE: 1,
                QuestFields.RESTRICTIONS: '',
                QuestFields.GM: author_id,
                QuestFields.PARTY: [],
                QuestFields.PARTY_ROLE_ID: None,
                QuestFields.PARTY_ROLE_NAME: None,
                QuestFields.QUEST_ROLE_MODE: 'temporary',
                QuestFields.WAIT_LIST: [],
                QuestFields.MAX_WAIT_LIST_SIZE: 0,
                QuestFields.LOCK_STATE: False,
                QuestFields.REWARDS: {},
                QuestFields.STATUS: QuestStatus.DRAFT,
                QuestFields.IMAGE_URL: None,
                QuestFields.LARGE_IMAGE_URL: None,
            }

            quest_collection = bot.gdb[DatabaseCollections.QUESTS]
            await quest_collection.insert_one(quest)

            # Clear the cached quest lists
            admin_key = build_cache_key(bot.gdb.name, f'guild_quests:{guild_id}', 'quests')
            await bot.rdb.delete(admin_key)
            gm_key = build_cache_key(bot.gdb.name, f'gm_quests:{guild_id}:{author_id}', 'quests')
            await bot.rdb.delete(gm_key)

            # Navigate to the Manage Quest view for the new draft
            from ReQuest.ui.gm.views import ManageQuestsView
            view = ManageQuestsView(quest)
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestModal(LocaleModal):
    def __init__(self, calling_view, quest):
        header = t(DEFAULT_LOCALE, 'gm-modal-title-editing-quest', questTitle=quest[QuestFields.TITLE])
        if len(header) > 45:
            header = header[:42] + '...'
        super().__init__(
            title=header,
            timeout=600
        )

        # Get the current quest's values
        self.calling_view = calling_view
        self.quest = quest
        title = quest[QuestFields.TITLE]
        restrictions = quest[QuestFields.RESTRICTIONS]
        max_party_size = quest[QuestFields.MAX_PARTY_SIZE]
        description = quest[QuestFields.DESCRIPTION]

        # Build the text inputs w/ the existing values
        self.title_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'gm-modal-label-title'),
            style=discord.TextStyle.short,
            default=title,
            custom_id='title_text_input',
            required=False
        )
        self.restrictions_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'gm-modal-label-restrictions'),
            style=discord.TextStyle.short,
            default=restrictions,
            custom_id='restrictions_text_input',
            required=False
        )
        self.max_party_size_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'gm-modal-label-max-party-size'),
            style=discord.TextStyle.short,
            default=max_party_size,
            custom_id='max_party_size_text_input',
            required=False
        )
        self.description_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'gm-modal-label-description'),
            style=discord.TextStyle.paragraph,
            default=description,
            custom_id='description_text_input',
            required=False
        )
        self.add_item(self.title_text_input)
        self.add_item(self.restrictions_text_input)
        self.add_item(self.max_party_size_text_input)
        self.add_item(self.description_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            # Push the updates
            bot = interaction.client
            guild_id = interaction.guild_id
            updates = {
                QuestFields.TITLE: self.title_text_input.value,
                QuestFields.RESTRICTIONS: self.restrictions_text_input.value,
                QuestFields.MAX_PARTY_SIZE: int(self.max_party_size_text_input.value),
                QuestFields.DESCRIPTION: self.description_text_input.value
            }

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUESTS,
                query={QuestFields.GUILD_ID: guild_id, QuestFields.QUEST_ID: self.quest[QuestFields.QUEST_ID]},
                update_data={'$set': updates},
                cache_id=f'{guild_id}:{self.quest[QuestFields.QUEST_ID]}'
            )

            # Get the updated quest
            self.quest.update(updates)

            # Get the quest board channel
            quest_channel_query = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUEST_CHANNEL,
                query={CommonFields.ID: guild_id}
            )
            quest_channel_id = strip_id(quest_channel_query[ConfigFields.QUEST_CHANNEL])
            guild = interaction.client.get_guild(guild_id)
            quest_channel = guild.get_channel(quest_channel_id)

            # Get the original quest post message object and create a new embed
            message = quest_channel.get_partial_message(self.quest[QuestFields.MESSAGE_ID])

            # Create a fresh quest view, and update the original post message
            from ReQuest.ui.gm.views import QuestPostView
            quest_view = QuestPostView(self.quest)
            await setup_view(quest_view, interaction)
            await message.edit(view=quest_view)

            # Reload the UI view
            view = self.calling_view
            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestTitleModal(LocaleModal):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'gm-modal-title-edit-title'),
            timeout=None
        )
        self.calling_view = calling_view
        quest = calling_view.quest

        self.title_input = discord.ui.TextInput(
            label=t(locale, 'gm-modal-label-quest-title'),
            style=discord.TextStyle.short,
            custom_id='edit_quest_title_input',
            default=quest[QuestFields.TITLE],
            required=True
        )
        self.add_item(self.title_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            quest = self.calling_view.quest
            guild_id = quest[QuestFields.GUILD_ID]
            quest_id = quest[QuestFields.QUEST_ID]

            value = self.title_input.value

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUESTS,
                query={QuestFields.GUILD_ID: guild_id, QuestFields.QUEST_ID: quest_id},
                update_data={'$set': {QuestFields.TITLE: value}},
                cache_id=f'{guild_id}:{quest_id}'
            )
            quest[QuestFields.TITLE] = value

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestDescriptionModal(LocaleModal):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'gm-modal-title-edit-description'),
            timeout=None
        )
        self.calling_view = calling_view
        quest = calling_view.quest

        self.description_input = discord.ui.TextInput(
            label=t(locale, 'gm-modal-label-description'),
            style=discord.TextStyle.paragraph,
            custom_id='edit_quest_description_input',
            default=quest[QuestFields.DESCRIPTION],
            required=False
        )
        self.add_item(self.description_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            quest = self.calling_view.quest
            guild_id = quest[QuestFields.GUILD_ID]
            quest_id = quest[QuestFields.QUEST_ID]

            value = self.description_input.value or ''

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUESTS,
                query={QuestFields.GUILD_ID: guild_id, QuestFields.QUEST_ID: quest_id},
                update_data={'$set': {QuestFields.DESCRIPTION: value}},
                cache_id=f'{guild_id}:{quest_id}'
            )
            quest[QuestFields.DESCRIPTION] = value

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestRestrictionsModal(LocaleModal):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'gm-modal-title-edit-restrictions'),
            timeout=None
        )
        self.calling_view = calling_view
        quest = calling_view.quest

        self.restrictions_input = discord.ui.TextInput(
            label=t(locale, 'gm-modal-label-restrictions'),
            style=discord.TextStyle.short,
            custom_id='edit_quest_restrictions_input',
            default=quest[QuestFields.RESTRICTIONS],
            required=False
        )
        self.add_item(self.restrictions_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            quest = self.calling_view.quest
            guild_id = quest[QuestFields.GUILD_ID]
            quest_id = quest[QuestFields.QUEST_ID]

            value = self.restrictions_input.value or ''

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUESTS,
                query={QuestFields.GUILD_ID: guild_id, QuestFields.QUEST_ID: quest_id},
                update_data={'$set': {QuestFields.RESTRICTIONS: value}},
                cache_id=f'{guild_id}:{quest_id}'
            )
            quest[QuestFields.RESTRICTIONS] = value

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestMaxPartySizeModal(LocaleModal):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'gm-modal-title-edit-party-size'),
            timeout=None
        )
        self.calling_view = calling_view
        quest = calling_view.quest

        self.max_party_size_input = discord.ui.TextInput(
            label=t(locale, 'gm-modal-label-max-party'),
            style=discord.TextStyle.short,
            custom_id='edit_quest_max_party_size_input',
            default=str(quest[QuestFields.MAX_PARTY_SIZE]),
            max_length=2,
            required=True
        )
        self.add_item(self.max_party_size_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            quest = self.calling_view.quest
            guild_id = quest[QuestFields.GUILD_ID]
            quest_id = quest[QuestFields.QUEST_ID]
            locale = getattr(self.calling_view, 'locale', DEFAULT_LOCALE)

            try:
                value = int(self.max_party_size_input.value)
            except ValueError:
                raise UserFeedbackError(
                    t(locale, 'gm-error-party-size-positive'),
                    message_id='gm-error-party-size-positive'
                )

            if value <= 0:
                raise UserFeedbackError(
                    t(locale, 'gm-error-party-size-positive'),
                    message_id='gm-error-party-size-positive'
                )

            current_party_size = len(quest.get(QuestFields.PARTY, []))
            if current_party_size > value:
                raise UserFeedbackError(
                    t(locale, 'gm-error-party-size-too-small', currentSize=current_party_size),
                    message_id='gm-error-party-size-too-small'
                )

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUESTS,
                query={QuestFields.GUILD_ID: guild_id, QuestFields.QUEST_ID: quest_id},
                update_data={'$set': {QuestFields.MAX_PARTY_SIZE: value}},
                cache_id=f'{guild_id}:{quest_id}'
            )
            quest[QuestFields.MAX_PARTY_SIZE] = value

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestPartyRoleModal(LocaleModal):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'gm-modal-title-edit-party-role'),
            timeout=None
        )
        self.calling_view = calling_view

        current_name = calling_view.quest.get(QuestFields.PARTY_ROLE_NAME, '') or ''
        self.party_role_input = discord.ui.TextInput(
            label=t(locale, 'gm-modal-label-party-role'),
            style=discord.TextStyle.short,
            custom_id='edit_quest_party_role_input',
            placeholder=t(locale, 'gm-modal-placeholder-party-role'),
            default=current_name,
            max_length=100,
            required=False
        )
        self.add_item(self.party_role_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            quest = self.calling_view.quest
            guild_id = quest[QuestFields.GUILD_ID]
            quest_id = quest[QuestFields.QUEST_ID]

            role_name = self.party_role_input.value.strip() if self.party_role_input.value else ''

            # Store the role name — actual Discord role creation happens at publish time
            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUESTS,
                query={QuestFields.GUILD_ID: guild_id, QuestFields.QUEST_ID: quest_id},
                update_data={'$set': {
                    QuestFields.PARTY_ROLE_NAME: role_name or None,
                    QuestFields.PARTY_ROLE_ID: None,
                }},
                cache_id=f'{guild_id}:{quest_id}'
            )
            quest[QuestFields.PARTY_ROLE_NAME] = role_name or None
            quest[QuestFields.PARTY_ROLE_ID] = None

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestPartyRoleStaticModal(LocaleModal):
    """Modal with a Label+Select for choosing a party role in static mode."""

    def __init__(self, calling_view, assigned_roles):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'gm-modal-title-edit-party-role'),
            timeout=None
        )
        self.calling_view = calling_view

        options = [discord.SelectOption(
            label=t(locale, 'gm-select-option-no-role'),
            value='none'
        )]
        for role_assignment in assigned_roles:
            options.append(discord.SelectOption(
                label=role_assignment['roleName'],
                value=str(role_assignment['roleId'])
            ))

        role_select = discord.ui.Select(
            placeholder=t(locale, 'gm-select-placeholder-party-role'),
            options=options,
            custom_id='edit_quest_party_role_static_select'
        )
        self.role_label = discord.ui.Label(
            text=t(locale, 'gm-modal-label-party-role'),
            component=role_select
        )
        self.add_item(self.role_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            quest = self.calling_view.quest
            guild_id = quest[QuestFields.GUILD_ID]
            quest_id = quest[QuestFields.QUEST_ID]

            selected_value = self.role_label.component.values[0]
            party_role_id = int(selected_value) if selected_value != 'none' else None

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUESTS,
                query={QuestFields.GUILD_ID: guild_id, QuestFields.QUEST_ID: quest_id},
                update_data={'$set': {QuestFields.PARTY_ROLE_ID: party_role_id}},
                cache_id=f'{guild_id}:{quest_id}'
            )
            quest[QuestFields.PARTY_ROLE_ID] = party_role_id

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestImageUrlModal(LocaleModal):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'gm-modal-title-edit-image'),
            timeout=None
        )
        self.calling_view = calling_view
        quest = calling_view.quest

        self.image_url_input = discord.ui.TextInput(
            label=t(locale, 'gm-modal-label-image-url'),
            style=discord.TextStyle.short,
            custom_id='edit_quest_image_url_input',
            placeholder=t(locale, 'gm-modal-placeholder-image-url'),
            default=quest.get(QuestFields.IMAGE_URL) or '',
            required=False
        )
        self.add_item(self.image_url_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            quest = self.calling_view.quest
            guild_id = quest[QuestFields.GUILD_ID]
            quest_id = quest[QuestFields.QUEST_ID]

            value = self.image_url_input.value.strip() if self.image_url_input.value else None
            value = value or None  # Convert empty string to None

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUESTS,
                query={QuestFields.GUILD_ID: guild_id, QuestFields.QUEST_ID: quest_id},
                update_data={'$set': {QuestFields.IMAGE_URL: value}},
                cache_id=f'{guild_id}:{quest_id}'
            )
            quest[QuestFields.IMAGE_URL] = value

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestLargeImageUrlModal(LocaleModal):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        super().__init__(
            title=t(locale, 'gm-modal-title-edit-large-image'),
            timeout=None
        )
        self.calling_view = calling_view
        quest = calling_view.quest

        self.large_image_url_input = discord.ui.TextInput(
            label=t(locale, 'gm-modal-label-large-image-url'),
            style=discord.TextStyle.short,
            custom_id='edit_quest_large_image_url_input',
            placeholder=t(locale, 'gm-modal-placeholder-image-url'),
            default=quest.get(QuestFields.LARGE_IMAGE_URL) or '',
            required=False
        )
        self.add_item(self.large_image_url_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            quest = self.calling_view.quest
            guild_id = quest[QuestFields.GUILD_ID]
            quest_id = quest[QuestFields.QUEST_ID]

            value = self.large_image_url_input.value.strip() if self.large_image_url_input.value else None
            value = value or None  # Convert empty string to None

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUESTS,
                query={QuestFields.GUILD_ID: guild_id, QuestFields.QUEST_ID: quest_id},
                update_data={'$set': {QuestFields.LARGE_IMAGE_URL: value}},
                cache_id=f'{guild_id}:{quest_id}'
            )
            quest[QuestFields.LARGE_IMAGE_URL] = value

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestDetailsComboModal(LocaleModal):
    """Combined modal for editing title, restrictions, party size, and description."""

    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        quest = calling_view.quest
        super().__init__(
            title=t(locale, 'gm-modal-title-edit-details'),
            timeout=None
        )
        self.calling_view = calling_view

        self.title_input = discord.ui.TextInput(
            label=t(locale, 'gm-modal-label-quest-title'),
            custom_id='edit_combo_title',
            default=quest.get(QuestFields.TITLE, ''),
            required=True
        )
        self.restrictions_input = discord.ui.TextInput(
            label=t(locale, 'gm-modal-label-restrictions'),
            custom_id='edit_combo_restrictions',
            placeholder=t(locale, 'gm-modal-placeholder-restrictions'),
            default=quest.get(QuestFields.RESTRICTIONS, ''),
            required=False
        )
        self.party_size_input = discord.ui.TextInput(
            label=t(locale, 'gm-modal-label-max-party'),
            custom_id='edit_combo_party_size',
            placeholder=t(locale, 'gm-modal-placeholder-max-party'),
            default=str(quest.get(QuestFields.MAX_PARTY_SIZE, 0) or ''),
            max_length=2,
            required=False
        )
        self.description_input = discord.ui.TextInput(
            label=t(locale, 'gm-modal-label-description'),
            style=discord.TextStyle.paragraph,
            custom_id='edit_combo_description',
            placeholder=t(locale, 'gm-modal-placeholder-description'),
            default=quest.get(QuestFields.DESCRIPTION, ''),
            required=False
        )
        self.add_item(self.title_input)
        self.add_item(self.restrictions_input)
        self.add_item(self.party_size_input)
        self.add_item(self.description_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            quest = self.calling_view.quest
            guild_id = quest[QuestFields.GUILD_ID]
            quest_id = quest[QuestFields.QUEST_ID]
            locale = getattr(self.calling_view, 'locale', DEFAULT_LOCALE)

            # Validate party size if provided
            party_size_value = self.party_size_input.value.strip()
            if party_size_value:
                try:
                    max_party_size = int(party_size_value)
                except ValueError:
                    raise UserFeedbackError(
                        t(locale, 'gm-error-party-size-positive'),
                        message_id='gm-error-party-size-positive'
                    )
                if max_party_size <= 0:
                    raise UserFeedbackError(
                        t(locale, 'gm-error-party-size-positive'),
                        message_id='gm-error-party-size-positive'
                    )
                current_party_size = len(quest.get(QuestFields.PARTY, []))
                if max_party_size < current_party_size:
                    raise UserFeedbackError(
                        t(locale, 'gm-error-party-size-too-small', currentSize=current_party_size),
                        message_id='gm-error-party-size-too-small'
                    )
            else:
                max_party_size = quest.get(QuestFields.MAX_PARTY_SIZE, 1)

            updates = {
                QuestFields.TITLE: self.title_input.value,
                QuestFields.RESTRICTIONS: self.restrictions_input.value,
                QuestFields.MAX_PARTY_SIZE: max_party_size,
                QuestFields.DESCRIPTION: self.description_input.value,
            }

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUESTS,
                query={QuestFields.GUILD_ID: guild_id, QuestFields.QUEST_ID: quest_id},
                update_data={'$set': updates},
                cache_id=f'{guild_id}:{quest_id}'
            )
            quest.update(updates)

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class EditQuestImagesComboModal(LocaleModal):
    """Combined modal for editing thumbnail and large image URLs."""

    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        quest = calling_view.quest
        super().__init__(
            title=t(locale, 'gm-modal-title-edit-images'),
            timeout=None
        )
        self.calling_view = calling_view

        self.thumbnail_input = discord.ui.TextInput(
            label=t(locale, 'gm-modal-label-image-url'),
            custom_id='edit_combo_thumbnail',
            placeholder=t(locale, 'gm-modal-placeholder-image-url'),
            default=quest.get(QuestFields.IMAGE_URL) or '',
            required=False
        )
        self.image_input = discord.ui.TextInput(
            label=t(locale, 'gm-modal-label-large-image-url'),
            custom_id='edit_combo_large_image',
            placeholder=t(locale, 'gm-modal-placeholder-image-url'),
            default=quest.get(QuestFields.LARGE_IMAGE_URL) or '',
            required=False
        )
        self.add_item(self.thumbnail_input)
        self.add_item(self.image_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            quest = self.calling_view.quest
            guild_id = quest[QuestFields.GUILD_ID]
            quest_id = quest[QuestFields.QUEST_ID]

            thumbnail = self.thumbnail_input.value.strip() or None
            large_image = self.image_input.value.strip() or None

            updates = {
                QuestFields.IMAGE_URL: thumbnail,
                QuestFields.LARGE_IMAGE_URL: large_image,
            }

            await update_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.QUESTS,
                query={QuestFields.GUILD_ID: guild_id, QuestFields.QUEST_ID: quest_id},
                update_data={'$set': updates},
                cache_id=f'{guild_id}:{quest_id}'
            )
            quest.update(updates)

            await setup_view(self.calling_view, interaction)
            await interaction.response.edit_message(view=self.calling_view)
        except Exception as e:
            await log_exception(e, interaction)


class RewardsModal(LocaleModal):
    def __init__(self, caller, calling_view, reward_type: RewardType):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'gm-modal-title-add-reward'),
            timeout=600
        )
        self.caller = caller
        self.calling_view = calling_view
        self.reward_type = reward_type
        self.xp_enabled = getattr(calling_view, 'xp_enabled', True)

        if self.reward_type == RewardType.PARTY:
            rewards = calling_view.current_party_rewards
        else:
            rewards = calling_view.current_individual_rewards

        if self.xp_enabled:
            xp_value = rewards.get(QuestFields.XP)
            xp_default = str(xp_value) if xp_value is not None else '0'
            self.xp_input = discord.ui.TextInput(
                label=t(DEFAULT_LOCALE, 'gm-modal-label-experience'),
                style=discord.TextStyle.short,
                custom_id='experience_text_input',
                placeholder=t(DEFAULT_LOCALE, 'gm-modal-placeholder-experience'),
                default=xp_default,
                required=False
            )
            self.add_item(self.xp_input)

        items_default = ''
        if rewards.get(CommonFields.ITEMS):
            lines = [f'{name}: {quantity}' for name, quantity in rewards[CommonFields.ITEMS].items()]
            items_default = '\n'.join(lines)

        self.item_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'gm-modal-label-items'),
            style=discord.TextStyle.paragraph,
            custom_id='items_text_input',
            placeholder=t(DEFAULT_LOCALE, 'gm-modal-placeholder-items'),
            default=items_default,
            required=False
        )
        self.add_item(self.item_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            xp = 0
            items = None
            if self.xp_enabled and hasattr(self, 'xp_input') and self.xp_input.value:
                try:
                    xp = int(self.xp_input.value)
                except ValueError:
                    raise UserFeedbackError(
                        t(DEFAULT_LOCALE, 'gm-error-invalid-xp-value'),
                        message_id='gm-error-invalid-xp-value'
                    )
            if self.item_input.value:
                if self.item_input.value.lower() == 'none':
                    items = 'none'
                else:
                    items = {}
                    for item in self.item_input.value.strip().split('\n'):
                        try:
                            item_name, quantity = item.split(':', 1)
                            items[titlecase(item_name.strip())] = int(quantity.strip())
                        except ValueError:
                            raise UserFeedbackError(
                                t(DEFAULT_LOCALE, 'gm-error-invalid-item-format', item=item),
                                message_id='gm-error-invalid-item-format'
                            )

            await self.caller.modal_callback(interaction, xp, items)
        except Exception as e:
            await log_exception(e, interaction)


class QuestSummaryModal(LocaleModal):
    def __init__(self, calling_view):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'gm-modal-title-add-summary'),
            timeout=None
        )
        self.calling_view = calling_view
        self.summary_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'gm-modal-label-summary'),
            style=discord.TextStyle.paragraph,
            custom_id='summary_input',
            placeholder=t(DEFAULT_LOCALE, 'gm-modal-placeholder-summary')
        )
        self.add_item(self.summary_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            await self.calling_view.complete_quest(interaction, self.summary_input.value)
        except Exception as e:
            await log_exception(e, interaction)


class ModPlayerModal(LocaleModal):
    def __init__(self, member: discord.Member, character_id, character_data, xp_enabled=True):
        super().__init__(
            title=t(DEFAULT_LOCALE, 'gm-modal-title-modifying-player', playerName=member.name),
            timeout=600
        )
        self.member = member
        self.character_id = character_id
        self.character_data = character_data
        self.xp_enabled = xp_enabled

        if self.xp_enabled:
            self.experience_text_input = discord.ui.TextInput(
                label=t(DEFAULT_LOCALE, 'gm-modal-label-experience'),
                placeholder=t(DEFAULT_LOCALE, 'gm-modal-placeholder-xp-add-remove'),
                custom_id='experience_text_input',
                required=False
            )
            self.add_item(self.experience_text_input)

        self.inventory_text_input = discord.ui.TextInput(
            label=t(DEFAULT_LOCALE, 'gm-modal-label-inventory'),
            style=discord.TextStyle.paragraph,
            placeholder=t(DEFAULT_LOCALE, 'gm-modal-placeholder-inventory-modify'),
            custom_id='inventory_text_input',
            required=False
        )
        self.add_item(self.inventory_text_input)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            bot = interaction.client
            xp = 0
            guild_id = interaction.guild_id
            currency_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.CURRENCY,
                query={CommonFields.ID: guild_id}
            )
            log_channel_config = await get_cached_data(
                bot=bot,
                mongo_database=bot.gdb,
                collection_name=DatabaseCollections.GM_TRANSACTION_LOG_CHANNEL,
                query={CommonFields.ID: guild_id}
            )
            log_channel = None
            if log_channel_config:
                log_channel_id = strip_id(log_channel_config[ConfigFields.GM_TRANSACTION_LOG_CHANNEL])
                log_channel = interaction.client.get_channel(log_channel_id)

            item_changes = {}
            currency_changes = {}

            if self.xp_enabled and hasattr(self, 'experience_text_input') and self.experience_text_input.value:
                xp = int(self.experience_text_input.value)

            if self.inventory_text_input.value:
                for item_line in self.inventory_text_input.value.strip().split('\n'):
                    try:
                        item_name_str, quantity_str = item_line.split(':', 1)
                        item_name = item_name_str.strip()
                        quantity = float(quantity_str.strip())
                    except ValueError:
                        continue

                    is_currency, parent_name = None, None
                    if currency_config:
                        is_currency, parent_name = find_currency_or_denomination(currency_config, item_name)

                    if is_currency:
                        denomination_map, _ = get_denomination_map(currency_config, item_name)
                        if not denomination_map:
                            item_changes[item_name.lower()] = (item_changes.get(item_name.lower(), 0) +
                                                               int(quantity))
                            continue

                        item_value_in_base = denomination_map[item_name.lower()]
                        total_value_to_add = quantity * item_value_in_base

                        currency_changes[parent_name] = currency_changes.get(parent_name, 0.0) + total_value_to_add

                    else:
                        item_changes[item_name.lower()] = (item_changes.get(item_name.lower(), 0) +
                                                           int(quantity))

            # Apply DB changes
            if self.xp_enabled and xp:
                await update_character_experience(interaction, self.member.id, self.character_id, xp)

            for base_currency_name, total_value in currency_changes.items():
                if total_value == 0:
                    continue
                await update_character_inventory(interaction, self.member.id, self.character_id,
                                                 base_currency_name, total_value)

            for item_name, quantity in item_changes.items():
                if quantity == 0:
                    continue
                await update_character_inventory(interaction, self.member.id, self.character_id,
                                                 item_name.lower(), int(quantity))

            transaction_id = shortuuid.uuid()[:12]
            description = (
                f'Game Master: {interaction.user.mention}\n'
                f'Recipient: {self.member.mention} as `{self.character_data[CommonFields.NAME]}`'
            )

            def build_mod_embed(loc):
                embed = discord.Embed(
                    title=t(loc, 'gm-embed-title-mod-report'),
                    description=description,
                    type='rich'
                )
                if self.xp_enabled and xp:
                    embed.add_field(name=t(loc, 'gm-embed-field-experience'), value=xp)
                for cn, tv in currency_changes.items():
                    if tv == 0:
                        continue
                    dv = f"{tv:.2f}" if isinstance(tv, float) and tv % 1 != 0 else str(tv)
                    embed.add_field(name=escape_markdown(titlecase(cn)), value=dv)
                for itn, qty in item_changes.items():
                    if qty == 0:
                        continue
                    embed.add_field(name=escape_markdown(titlecase(itn)), value=int(qty))
                embed.set_footer(text=t(loc, 'common-embed-footer-transaction-id', transactionId=transaction_id))
                return embed

            # Ephemeral response to GM in their locale
            caller_locale = await resolve_locale(interaction)
            guild_locale = await resolve_guild_locale(bot, guild_id)

            caller_embed = build_mod_embed(caller_locale)
            await interaction.response.send_message(embed=caller_embed, ephemeral=True)

            # Log channel in guild locale
            if log_channel:
                if guild_locale != caller_locale:
                    await log_channel.send(embed=build_mod_embed(guild_locale))
                else:
                    await log_channel.send(embed=caller_embed)

            # DM to target member in their locale
            try:
                member_locale = await resolve_user_locale(bot, self.member.id, guild_id)
                if member_locale != caller_locale:
                    await self.member.send(embed=build_mod_embed(member_locale))
                else:
                    await self.member.send(embed=caller_embed)
            except discord.errors.Forbidden as e:
                logger.warning(f'Could not send DM to {self.member} regarding GM modification: {e}')
        except Exception as e:
            await log_exception(e, interaction)


