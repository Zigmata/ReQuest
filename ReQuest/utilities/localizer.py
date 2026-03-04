import logging
import os

from fluent.runtime import FluentLocalization, FluentResourceLoader

from ReQuest.utilities.constants import CommonFields, DatabaseCollections

logger = logging.getLogger(__name__)

DEFAULT_LOCALE = 'en-US'
SUPPORTED_LOCALES = ['en-US', 'pt-BR']
FTL_DIR = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'locales', '{locale}')

_resource_loader = FluentResourceLoader(FTL_DIR)
_FTL_FILES = ['common.ftl', 'errors.ftl', 'info.ftl']


class Localizer:
    """
    Wraps FluentLocalization with per-locale caching.
    """
    def __init__(self):
        self._cache = {}

    def _get_localization(self, locale):
        if locale not in self._cache:
            fallback_chain = [locale]
            if locale != DEFAULT_LOCALE:
                fallback_chain.append(DEFAULT_LOCALE)
            self._cache[locale] = FluentLocalization(
                fallback_chain, _FTL_FILES, _resource_loader
            )
        return self._cache[locale]

    def format(self, locale, message_id, **kwargs):
        l10n = self._get_localization(locale)
        return l10n.format_value(message_id, kwargs if kwargs else None)


_localizer = Localizer()


def get_localizer():
    return _localizer


def t(locale, message_id, **kwargs):
    """
    Primary localization API.
    """
    return get_localizer().format(locale, message_id, **kwargs)


async def resolve_locale(interaction):
    """
    Resolve the user's preferred locale via the fallback chain:
    user DB preference > interaction.locale > DEFAULT_LOCALE.
    """
    bot = interaction.client

    try:
        from ReQuest.utilities.supportFunctions import get_cached_data
        locale_data = await get_cached_data(
            bot=bot,
            mongo_database=bot.mdb,
            collection_name=DatabaseCollections.USER_LOCALE,
            query={CommonFields.ID: interaction.user.id}
        )
        if locale_data and 'locale' in locale_data:
            user_locale = locale_data['locale']
            if user_locale in SUPPORTED_LOCALES:
                return user_locale
    except Exception as e:
        logger.debug(f'Could not resolve user locale preference: {e}')

    discord_locale = str(interaction.locale) if interaction.locale else None
    if discord_locale and discord_locale in SUPPORTED_LOCALES:
        return discord_locale

    return DEFAULT_LOCALE
