import logging
import math

import discord
from discord.ui import Select

from ReQuest.utilities.constants import CommonFields, DatabaseCollections
from ReQuest.utilities.localizer import DEFAULT_LOCALE, SUPPORTED_LOCALES, t
from ReQuest.utilities.db_cache import update_cached_data
from ReQuest.utilities.exceptions import log_exception
from ReQuest.utilities.discord_utils import setup_view

logger = logging.getLogger(__name__)

LOCALES_PER_PAGE = 25

LOCALE_LABELS = {
    'en-US': 'info-language-label-en-us',
    'pt-BR': 'info-language-label-pt-br',
    'uk': 'info-language-label-uk',
    'es-419': 'info-language-label-es-419',
    'es-ES': 'info-language-label-es-es',
    'ru': 'info-language-label-ru',
    'ko': 'info-language-label-ko',
    'fr': 'info-language-label-fr',
    'de': 'info-language-label-de',
    'it': 'info-language-label-it',
    'bg': 'info-language-label-bg',
    'zh-CN': 'info-language-label-zh-cn',
    'zh-TW': 'info-language-label-zh-tw',
    'hr': 'info-language-label-hr',
    'cs': 'info-language-label-cs',
    'da': 'info-language-label-da',
    'nl': 'info-language-label-nl',
    'fi': 'info-language-label-fi',
    'el': 'info-language-label-el',
    'hi': 'info-language-label-hi',
    'hu': 'info-language-label-hu',
    'id': 'info-language-label-id',
    'ja': 'info-language-label-ja',
    'lt': 'info-language-label-lt',
    'no': 'info-language-label-no',
    'pl': 'info-language-label-pl',
    'ro': 'info-language-label-ro',
    'sv-SE': 'info-language-label-sv-se',
    'th': 'info-language-label-th',
    'tr': 'info-language-label-tr',
    'vi': 'info-language-label-vi',
}

LOCALE_DESCRIPTIONS = {
    'en-US': 'info-language-desc-en-us',
    'pt-BR': 'info-language-desc-pt-br',
    'uk': 'info-language-desc-uk',
    'es-419': 'info-language-desc-es-419',
    'es-ES': 'info-language-desc-es-es',
    'ru': 'info-language-desc-ru',
    'ko': 'info-language-desc-ko',
    'fr': 'info-language-desc-fr',
    'de': 'info-language-desc-de',
    'it': 'info-language-desc-it',
    'bg': 'info-language-desc-bg',
    'zh-CN': 'info-language-desc-zh-cn',
    'zh-TW': 'info-language-desc-zh-tw',
    'hr': 'info-language-desc-hr',
    'cs': 'info-language-desc-cs',
    'da': 'info-language-desc-da',
    'nl': 'info-language-desc-nl',
    'fi': 'info-language-desc-fi',
    'el': 'info-language-desc-el',
    'hi': 'info-language-desc-hi',
    'hu': 'info-language-desc-hu',
    'id': 'info-language-desc-id',
    'ja': 'info-language-desc-ja',
    'lt': 'info-language-desc-lt',
    'no': 'info-language-desc-no',
    'pl': 'info-language-desc-pl',
    'ro': 'info-language-desc-ro',
    'sv-SE': 'info-language-desc-sv-se',
    'th': 'info-language-desc-th',
    'tr': 'info-language-desc-tr',
    'vi': 'info-language-desc-vi',
}

LOCALE_EMOJI = {
    'en-US': '\U0001f1fa\U0001f1f8',
    'pt-BR': '\U0001f1e7\U0001f1f7',
    'uk': '\U0001f1fa\U0001f1e6',
    'es-419': '\U0001f30e',
    'es-ES': '\U0001f1ea\U0001f1f8',
    'ru': '\U0001f1f7\U0001f1fa',
    'ko': '\U0001f1f0\U0001f1f7',
    'fr': '\U0001f1eb\U0001f1f7',
    'de': '\U0001f1e9\U0001f1ea',
    'it': '\U0001f1ee\U0001f1f9',
    'bg': '\U0001f1e7\U0001f1ec',
    'zh-CN': '\U0001f1e8\U0001f1f3',
    'zh-TW': '\U0001f1f9\U0001f1fc',
    'hr': '\U0001f1ed\U0001f1f7',
    'cs': '\U0001f1e8\U0001f1ff',
    'da': '\U0001f1e9\U0001f1f0',
    'nl': '\U0001f1f3\U0001f1f1',
    'fi': '\U0001f1eb\U0001f1ee',
    'el': '\U0001f1ec\U0001f1f7',
    'hi': '\U0001f1ee\U0001f1f3',
    'hu': '\U0001f1ed\U0001f1fa',
    'id': '\U0001f1ee\U0001f1e9',
    'ja': '\U0001f1ef\U0001f1f5',
    'lt': '\U0001f1f1\U0001f1f9',
    'no': '\U0001f1f3\U0001f1f4',
    'pl': '\U0001f1f5\U0001f1f1',
    'ro': '\U0001f1f7\U0001f1f4',
    'sv-SE': '\U0001f1f8\U0001f1ea',
    'th': '\U0001f1f9\U0001f1ed',
    'tr': '\U0001f1f9\U0001f1f7',
    'vi': '\U0001f1fb\U0001f1f3',
}


def get_locale_total_pages():
    return math.ceil(len(SUPPORTED_LOCALES) / LOCALES_PER_PAGE)


def get_locale_page(locale_code):
    """Return the page number that contains the given locale in the user language select."""
    try:
        index = SUPPORTED_LOCALES.index(locale_code)
    except ValueError:
        return 0
    return index // LOCALES_PER_PAGE


def get_config_locale_total_pages():
    """Total pages for config select, which has a 'Default' option taking one slot on page 0."""
    return math.ceil((len(SUPPORTED_LOCALES) + 1) / LOCALES_PER_PAGE)


def get_config_locale_page(locale_code):
    """Return the page number that contains the given locale in the config language select.

    Page 0 has the 'Default' option + (LOCALES_PER_PAGE - 1) locales.
    Subsequent pages have LOCALES_PER_PAGE locales each.
    If locale_code is None (default/no override), returns 0.
    """
    if locale_code is None:
        return 0
    try:
        index = SUPPORTED_LOCALES.index(locale_code)
    except ValueError:
        return 0
    per_page_0 = LOCALES_PER_PAGE - 1
    if index < per_page_0:
        return 0
    return 1 + (index - per_page_0) // LOCALES_PER_PAGE


class LanguageSelect(Select):
    def __init__(self, calling_view):
        super().__init__(
            placeholder=t(DEFAULT_LOCALE, 'info-language-select-placeholder'),
            options=[],
            custom_id='language_select'
        )
        self.calling_view = calling_view

    def populate(self, locale, page=0):
        self.options.clear()
        total_pages = get_locale_total_pages()
        if total_pages > 1:
            self.placeholder = t(locale, 'info-language-select-placeholder-paged',
                                 current=page + 1, total=total_pages)
        else:
            self.placeholder = t(locale, 'info-language-select-placeholder')
        start = page * LOCALES_PER_PAGE
        end = start + LOCALES_PER_PAGE
        page_locales = SUPPORTED_LOCALES[start:end]
        for supported_locale in page_locales:
            self.options.append(discord.SelectOption(
                label=t(locale, LOCALE_LABELS[supported_locale]),
                description=t(locale, LOCALE_DESCRIPTIONS[supported_locale])[:100],
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
