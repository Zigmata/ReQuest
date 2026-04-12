import logging
from titlecase import titlecase

import discord
import discord.ui
import shortuuid
from ReQuest.ui.common.modals import LocaleModal

from ReQuest.ui.common.enums import RewardType
from ReQuest.utilities.constants import (QuestFields, QuestStatus, ConfigFields, CommonFields, DatabaseCollections,
                                         DiscordLimits)
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE, resolve_locale
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
            title=t(locale, 'gm-modal-title-create-quest')[:DiscordLimits.MODAL_TITLE],
            timeout=None
        )
        self.calling_view = calling_view

        self.quest_title_text_input = discord.ui.TextInput(
            custom_id='quest_title_text_input',
            placeholder=t(locale, 'gm-modal-placeholder-quest-title')[:DiscordLimits.TEXT_INPUT_PLACEHOLDER]
        )
        self.quest_title_label = discord.ui.Label(
            text=t(locale, 'gm-modal-label-quest-title')[:DiscordLimits.LABEL_LABEL],
            component=self.quest_title_text_input
        )
        self.add_item(self.quest_title_label)

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


class EditQuestDetailsComboModal(LocaleModal):
    """Combined modal for editing title, restrictions, party size, description, and party role."""

    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        self._locale = locale
        quest = calling_view.quest
        quest_role_mode = getattr(calling_view, 'quest_role_mode', 'disabled')
        assigned_roles = getattr(calling_view, 'assigned_roles', [])
        super().__init__(
            title=t(locale, 'gm-modal-title-edit-details')[:DiscordLimits.MODAL_TITLE],
            timeout=None
        )
        self.calling_view = calling_view
        self.quest_role_mode = quest_role_mode
        self.role_label = None
        self.party_role_input = None

        self.title_input = discord.ui.TextInput(
            custom_id='edit_combo_title',
            default=quest.get(QuestFields.TITLE, ''),
            required=True
        )
        self.title_label = discord.ui.Label(
            text=t(locale, 'gm-modal-label-quest-title')[:DiscordLimits.LABEL_LABEL],
            component=self.title_input
        )
        self.restrictions_input = discord.ui.TextInput(
            custom_id='edit_combo_restrictions',
            placeholder=t(locale, 'gm-modal-placeholder-restrictions')[:DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            default=quest.get(QuestFields.RESTRICTIONS, ''),
            required=False
        )
        self.restrictions_label = discord.ui.Label(
            text=t(locale, 'gm-modal-label-restrictions')[:DiscordLimits.LABEL_LABEL],
            component=self.restrictions_input
        )
        self.party_size_input = discord.ui.TextInput(
            custom_id='edit_combo_party_size',
            placeholder=t(locale, 'gm-modal-placeholder-max-party')[:DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            default=str(quest.get(QuestFields.MAX_PARTY_SIZE, 0) or ''),
            max_length=2,
            required=False
        )
        self.party_size_label = discord.ui.Label(
            text=t(locale, 'gm-modal-label-max-party')[:DiscordLimits.LABEL_LABEL],
            component=self.party_size_input
        )

        self.add_item(self.title_label)
        self.add_item(self.restrictions_label)
        self.add_item(self.party_size_label)

        # Party role — 4th field, mode-dependent
        if quest_role_mode == 'temporary':
            current_name = quest.get(QuestFields.PARTY_ROLE_NAME, '') or ''
            self.party_role_input = discord.ui.TextInput(
                custom_id='edit_combo_party_role',
                placeholder=t(
                    locale, 'gm-modal-placeholder-party-role'
                )[:DiscordLimits.TEXT_INPUT_PLACEHOLDER],
                default=current_name,
                max_length=100,
                required=False
            )
            self.party_role_label = discord.ui.Label(
                text=t(locale, 'gm-modal-label-party-role')[:DiscordLimits.LABEL_LABEL],
                component=self.party_role_input
            )
            self.add_item(self.party_role_label)
        elif quest_role_mode == 'static' and assigned_roles:
            options = [discord.SelectOption(
                label=t(locale, 'gm-select-option-no-role')[:DiscordLimits.STRING_SELECT_OPTION_LABEL],
                value='none'
            )]
            for role_assignment in assigned_roles:
                options.append(discord.SelectOption(
                    label=role_assignment['roleName'][:DiscordLimits.STRING_SELECT_OPTION_LABEL],
                    value=str(role_assignment['roleId'])[:DiscordLimits.STRING_SELECT_OPTION_VALUE]
                ))
            role_select = discord.ui.Select(
                placeholder=t(locale, 'gm-select-placeholder-party-role')[:DiscordLimits.SELECT_PLACEHOLDER],
                options=options,
                custom_id='edit_combo_party_role_select'
            )
            self.role_label = discord.ui.Label(
                text=t(locale, 'gm-modal-label-party-role')[:DiscordLimits.LABEL_LABEL],
                component=role_select
            )
            self.add_item(self.role_label)

        self.description_input = discord.ui.TextInput(
            style=discord.TextStyle.paragraph,
            custom_id='edit_combo_description',
            placeholder=t(locale, 'gm-modal-placeholder-description')[:DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            default=quest.get(QuestFields.DESCRIPTION, ''),
            required=False
        )
        self.description_label = discord.ui.Label(
            text=t(locale, 'gm-modal-label-description')[:DiscordLimits.LABEL_LABEL],
            component=self.description_input
        )
        self.add_item(self.description_label)

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

            # Handle party role based on mode
            if self.quest_role_mode == 'temporary' and self.party_role_input:
                role_name = self.party_role_input.value.strip() if self.party_role_input.value else ''
                updates[QuestFields.PARTY_ROLE_NAME] = role_name or None
                updates[QuestFields.PARTY_ROLE_ID] = None
            elif self.quest_role_mode == 'static' and self.role_label:
                selected_value = self.role_label.component.values[0]
                updates[QuestFields.PARTY_ROLE_ID] = int(selected_value) if selected_value != 'none' else None

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
            title=t(locale, 'gm-modal-title-edit-images')[:DiscordLimits.MODAL_TITLE],
            timeout=None
        )
        self.calling_view = calling_view

        self.thumbnail_input = discord.ui.TextInput(
            custom_id='edit_combo_thumbnail',
            placeholder=t(locale, 'gm-modal-placeholder-image-url')[:DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            default=quest.get(QuestFields.IMAGE_URL) or '',
            required=False
        )
        self.thumbnail_label = discord.ui.Label(
            text=t(locale, 'gm-modal-label-image-url')[:DiscordLimits.LABEL_LABEL],
            component=self.thumbnail_input
        )
        self.image_input = discord.ui.TextInput(
            custom_id='edit_combo_large_image',
            placeholder=t(locale, 'gm-modal-placeholder-image-url')[:DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            default=quest.get(QuestFields.LARGE_IMAGE_URL) or '',
            required=False
        )
        self.image_label = discord.ui.Label(
            text=t(locale, 'gm-modal-label-large-image-url')[:DiscordLimits.LABEL_LABEL],
            component=self.image_input
        )
        self.add_item(self.thumbnail_label)
        self.add_item(self.image_label)

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
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        super().__init__(
            title=t(locale, 'gm-modal-title-add-reward')[:DiscordLimits.MODAL_TITLE],
            timeout=600
        )
        self._locale = locale
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
                style=discord.TextStyle.short,
                custom_id='experience_text_input',
                placeholder=t(
                    locale, 'gm-modal-placeholder-experience'
                )[:DiscordLimits.TEXT_INPUT_PLACEHOLDER],
                default=xp_default,
                required=False
            )
            self.xp_label = discord.ui.Label(
                text=t(locale, 'gm-modal-label-experience')[:DiscordLimits.LABEL_LABEL],
                component=self.xp_input
            )
            self.add_item(self.xp_label)

        items_default = ''
        if rewards.get(CommonFields.ITEMS):
            lines = [f'{name}: {quantity}' for name, quantity in rewards[CommonFields.ITEMS].items()]
            items_default = '\n'.join(lines)

        self.item_input = discord.ui.TextInput(
            style=discord.TextStyle.paragraph,
            custom_id='items_text_input',
            placeholder=t(locale, 'gm-modal-placeholder-items')[:DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            default=items_default,
            required=False
        )
        self.item_label = discord.ui.Label(
            text=t(locale, 'gm-modal-label-items')[:DiscordLimits.LABEL_LABEL],
            component=self.item_input
        )
        self.add_item(self.item_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            locale = self._locale
            xp = 0
            items = None
            if self.xp_enabled and hasattr(self, 'xp_input') and self.xp_input.value:
                try:
                    xp = int(self.xp_input.value)
                except ValueError:
                    raise UserFeedbackError(
                        t(locale, 'gm-error-invalid-xp-value'),
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
                                t(locale, 'gm-error-invalid-item-format', item=item),
                                message_id='gm-error-invalid-item-format'
                            )

            await self.caller.modal_callback(interaction, xp, items)
        except Exception as e:
            await log_exception(e, interaction)


class QuestSummaryModal(LocaleModal):
    def __init__(self, calling_view):
        locale = getattr(calling_view, 'locale', DEFAULT_LOCALE)
        super().__init__(
            title=t(locale, 'gm-modal-title-add-summary')[:DiscordLimits.MODAL_TITLE],
            timeout=None
        )
        self._locale = locale
        self.calling_view = calling_view
        self.summary_input = discord.ui.TextInput(
            style=discord.TextStyle.paragraph,
            custom_id='summary_input',
            placeholder=t(locale, 'gm-modal-placeholder-summary')[:DiscordLimits.TEXT_INPUT_PLACEHOLDER]
        )
        self.summary_label = discord.ui.Label(
            text=t(locale, 'gm-modal-label-summary')[:DiscordLimits.LABEL_LABEL],
            component=self.summary_input
        )
        self.add_item(self.summary_label)

    async def on_submit(self, interaction: discord.Interaction):
        try:
            await self.calling_view.complete_quest(interaction, self.summary_input.value)
        except Exception as e:
            await log_exception(e, interaction)


class ModPlayerModal(LocaleModal):
    def __init__(self, member: discord.Member, character_id, character_data, xp_enabled=True,
                 locale=DEFAULT_LOCALE):
        super().__init__(
            title=t(
                locale, 'gm-modal-title-modifying-player', playerName=member.name
            )[:DiscordLimits.MODAL_TITLE],
            timeout=600
        )
        self._locale = locale
        self.member = member
        self.character_id = character_id
        self.character_data = character_data
        self.xp_enabled = xp_enabled

        if self.xp_enabled:
            self.experience_text_input = discord.ui.TextInput(
                placeholder=t(
                    locale, 'gm-modal-placeholder-xp-add-remove'
                )[:DiscordLimits.TEXT_INPUT_PLACEHOLDER],
                custom_id='experience_text_input',
                required=False
            )
            self.experience_label = discord.ui.Label(
                text=t(locale, 'gm-modal-label-experience')[:DiscordLimits.LABEL_LABEL],
                component=self.experience_text_input
            )
            self.add_item(self.experience_label)

        self.inventory_text_input = discord.ui.TextInput(
            style=discord.TextStyle.paragraph,
            placeholder=t(
                locale, 'gm-modal-placeholder-inventory-modify'
            )[:DiscordLimits.TEXT_INPUT_PLACEHOLDER],
            custom_id='inventory_text_input',
            required=False
        )
        self.inventory_label = discord.ui.Label(
            text=t(locale, 'gm-modal-label-inventory')[:DiscordLimits.LABEL_LABEL],
            component=self.inventory_text_input
        )
        self.add_item(self.inventory_label)

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
            guild_locale = await resolve_locale(bot=bot, guild_id=guild_id)

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
                member_locale = await resolve_locale(bot=bot, user_id=self.member.id, guild_id=guild_id)
                if member_locale != caller_locale:
                    await self.member.send(embed=build_mod_embed(member_locale))
                else:
                    await self.member.send(embed=caller_embed)
            except discord.errors.Forbidden as e:
                logger.warning(f'Could not send DM to {self.member} regarding GM modification: {e}')
        except Exception as e:
            await log_exception(e, interaction)
