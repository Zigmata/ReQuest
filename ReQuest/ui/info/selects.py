import logging

import discord
from discord.ui import Select

from ReQuest.utilities.constants import CommonFields, DatabaseCollections
from ReQuest.utilities.localizer import DEFAULT_LOCALE, SUPPORTED_LOCALES, t
from ReQuest.utilities.supportFunctions import log_exception, setup_view, update_cached_data

logger = logging.getLogger(__name__)

LOCALE_LABELS = {
    'en-US': 'info-language-label-en-us',
    'pt-BR': 'info-language-label-pt-br',
}

LOCALE_DESCRIPTIONS = {
    'en-US': 'info-language-desc-en-us',
    'pt-BR': 'info-language-desc-pt-br',
}

LOCALE_EMOJI = {
    'en-US': '\U0001f1fa\U0001f1f8',
    'pt-BR': '\U0001f1e7\U0001f1f7',
}


class LanguageSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder=t(DEFAULT_LOCALE, 'info-language-select-placeholder'),
            options=[],
            custom_id='language_select'
        )
        self.calling_view = calling_view

    def populate(self, locale):
        self.options.clear()
        self.placeholder = t(locale, 'info-language-select-placeholder')
        for supported_locale in SUPPORTED_LOCALES:
            self.options.append(discord.SelectOption(
                label=t(locale, LOCALE_LABELS[supported_locale]),
                description=t(locale, LOCALE_DESCRIPTIONS[supported_locale]),
                emoji=LOCALE_EMOJI.get(supported_locale),
                value=supported_locale,
                default=(supported_locale == locale)
            ))

    async def callback(self, interaction: discord.Interaction):
        try:
            selected_locale = self.values[0]
            view = self.calling_view

            await update_cached_data(
                bot=interaction.client,
                mongo_database=interaction.client.mdb,
                collection_name=DatabaseCollections.USER_LOCALE,
                query={CommonFields.ID: interaction.user.id},
                update_data={'$set': {'locale': selected_locale}}
            )

            await setup_view(view, interaction)
            await interaction.response.edit_message(view=view)
        except Exception as e:
            await log_exception(e, interaction)
