import logging
import os
import re
from contextvars import ContextVar

import discord
from discord import app_commands
from fluent.runtime import FluentLocalization, FluentResourceLoader

from ReQuest.utilities.constants import CommonFields, DatabaseCollections

logger = logging.getLogger(__name__)

DEFAULT_LOCALE = 'en-US'
SUPPORTED_LOCALES = ['en-US', 'pt-BR']
FTL_DIR = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'locales', '{locale}')

_resource_loader = FluentResourceLoader(FTL_DIR)
_FTL_FILES = ['common.ftl', 'errors.ftl', 'info.ftl', 'admin.ftl', 'config.ftl', 'gm.ftl', 'player.ftl', 'shop.ftl',
              'commands.ftl']


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

_render_locale: ContextVar[str | None] = ContextVar('_render_locale', default=None)


def set_locale_context(locale: str):
    """Set the active locale for the current asyncio task."""
    _render_locale.set(locale)


def get_localizer():
    return _localizer


def t(locale, message_id, **kwargs):
    """
    Primary localization API.

    When *locale* is DEFAULT_LOCALE, the context variable set by
    set_locale_context() is checked first, allowing UI code to pick up
    the user's real locale without changing call sites.
    """
    if locale == DEFAULT_LOCALE:
        ctx_locale = _render_locale.get()
        if ctx_locale is not None:
            locale = ctx_locale
    return get_localizer().format(locale, message_id, **kwargs)


_DISCORD_LOCALE_MAP = {
    discord.Locale.american_english: 'en-US',
    discord.Locale.british_english: 'en-US',
    discord.Locale.brazil_portuguese: 'pt-BR',
}


def _slugify(name):
    """Convert a context menu name like 'Modify Player' to 'modify-player'."""
    return re.sub(r'[^a-z0-9]+', '-', name.lower()).strip('-')


class FluentTranslator(app_commands.Translator):
    """Translates Discord slash command metadata via Fluent."""

    async def translate(self, string: app_commands.locale_str, locale: discord.Locale,
                        context: app_commands.TranslationContext) -> str | None:
        our_locale = _DISCORD_LOCALE_MAP.get(locale)
        if not our_locale or our_locale == DEFAULT_LOCALE:
            return None

        location = context.location

        if location is app_commands.TranslationContextLocation.command_description:
            msg_id = f'cmd-desc-{context.data.qualified_name}'
        elif location is app_commands.TranslationContextLocation.other:
            msg_id = f'cmd-context-name-{_slugify(string.message)}'
        else:
            return None

        result = t(our_locale, msg_id)
        if result == msg_id:
            return None
        return result


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
