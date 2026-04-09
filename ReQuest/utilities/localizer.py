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
SUPPORTED_LOCALES = [
    'en-US', 'pt-BR', 'uk', 'es-419', 'es-ES', 'ru', 'ko', 'fr', 'de', 'it',
    'bg', 'zh-CN', 'zh-TW', 'hr', 'cs', 'da', 'nl', 'fi', 'el', 'hi',
    'hu', 'id', 'ja', 'lt', 'no', 'pl', 'ro', 'sv-SE', 'th', 'tr', 'vi',
]
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


def validate_locale_setup():
    """Verify that every SUPPORTED_LOCALE has matching entries in UI registries and on-disk files.

    Call this once after all modules have loaded (e.g. in setup_hook) to catch configuration drift.
    """
    from ReQuest.ui.info.selects import LOCALE_LABELS, LOCALE_DESCRIPTIONS, LOCALE_EMOJI

    locales_dir = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'locales')
    errors = []

    for locale in SUPPORTED_LOCALES:
        if locale not in LOCALE_LABELS:
            errors.append(f'{locale}: missing from LOCALE_LABELS')
        if locale not in LOCALE_DESCRIPTIONS:
            errors.append(f'{locale}: missing from LOCALE_DESCRIPTIONS')
        if locale not in LOCALE_EMOJI:
            errors.append(f'{locale}: missing from LOCALE_EMOJI')
        locale_dir = os.path.join(locales_dir, locale)
        if not os.path.isdir(locale_dir):
            errors.append(f'{locale}: missing locale directory {locale_dir}')

    if errors:
        raise RuntimeError(
            'Locale configuration drift detected:\n  ' + '\n  '.join(errors)
        )


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
    discord.Locale.ukrainian: 'uk',
    discord.Locale.latin_american_spanish: 'es-419',
    discord.Locale.spain_spanish: 'es-ES',
    discord.Locale.russian: 'ru',
    discord.Locale.korean: 'ko',
    discord.Locale.french: 'fr',
    discord.Locale.german: 'de',
    discord.Locale.italian: 'it',
    discord.Locale.bulgarian: 'bg',
    discord.Locale.chinese: 'zh-CN',
    discord.Locale.taiwan_chinese: 'zh-TW',
    discord.Locale.croatian: 'hr',
    discord.Locale.czech: 'cs',
    discord.Locale.danish: 'da',
    discord.Locale.dutch: 'nl',
    discord.Locale.finnish: 'fi',
    discord.Locale.greek: 'el',
    discord.Locale.hindi: 'hi',
    discord.Locale.hungarian: 'hu',
    discord.Locale.indonesian: 'id',
    discord.Locale.japanese: 'ja',
    discord.Locale.lithuanian: 'lt',
    discord.Locale.norwegian: 'no',
    discord.Locale.polish: 'pl',
    discord.Locale.romanian: 'ro',
    discord.Locale.swedish: 'sv-SE',
    discord.Locale.thai: 'th',
    discord.Locale.turkish: 'tr',
    discord.Locale.vietnamese: 'vi',
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


async def _lookup_user_locale(bot, user_id):
    """Return the user's DB locale preference, or None."""
    try:
        from ReQuest.utilities.db_cache import get_cached_data
        locale_data = await get_cached_data(
            bot=bot,
            mongo_database=bot.mdb,
            collection_name=DatabaseCollections.USER_LOCALE,
            query={CommonFields.ID: user_id}
        )
        if locale_data and 'locale' in locale_data:
            user_locale = locale_data['locale']
            if user_locale in SUPPORTED_LOCALES:
                return user_locale
    except Exception as e:
        logger.debug(f'Could not resolve user locale preference: {e}')
    return None


async def _lookup_guild_locale(bot, guild_id):
    """Return the guild's DB locale preference, or None."""
    if not guild_id:
        return None
    try:
        from ReQuest.utilities.db_cache import get_cached_data
        guild_locale_data = await get_cached_data(
            bot=bot,
            mongo_database=bot.gdb,
            collection_name=DatabaseCollections.GUILD_LOCALE,
            query={CommonFields.ID: guild_id}
        )
        if guild_locale_data and 'locale' in guild_locale_data:
            guild_locale = guild_locale_data['locale']
            if guild_locale in SUPPORTED_LOCALES:
                return guild_locale
    except Exception as e:
        logger.debug(f'Could not resolve guild locale preference: {e}')
    return None


async def resolve_locale(interaction=None, *, bot=None, guild_id=None, user_id=None):
    """Resolve a locale using one of three fallback chains.

    Mode is inferred from the arguments provided:

    CALLER mode — resolve_locale(interaction):
        user DB pref > interaction.locale > DEFAULT_LOCALE
        Used for ephemeral responses to the interaction caller.

    GUILD mode — resolve_locale(bot=bot, guild_id=gid):
        guild DB pref > DEFAULT_LOCALE
        Used for public embeds and posts.

    TARGET_USER mode — resolve_locale(bot=bot, user_id=uid, guild_id=gid):
        user DB pref > guild DB pref > DEFAULT_LOCALE
        Used for DMs to a specific (non-interacting) user.
    """
    # ── CALLER mode ──
    if interaction is not None:
        _bot = bot or interaction.client
        result = await _lookup_user_locale(_bot, interaction.user.id)
        if result:
            return result

        discord_locale = str(interaction.locale) if interaction.locale else None
        if discord_locale and discord_locale in SUPPORTED_LOCALES:
            return discord_locale

        return DEFAULT_LOCALE

    # ── keyword-only modes require bot ──
    if bot is None:
        raise TypeError('resolve_locale() requires either interaction or bot=')

    # ── TARGET_USER mode ──
    if user_id is not None:
        result = await _lookup_user_locale(bot, user_id)
        if result:
            return result

        if guild_id:
            guild_result = await _lookup_guild_locale(bot, guild_id)
            if guild_result:
                return guild_result

        return DEFAULT_LOCALE

    # ── GUILD mode ──
    if guild_id is not None:
        result = await _lookup_guild_locale(bot, guild_id)
        if result:
            return result
        return DEFAULT_LOCALE

    raise TypeError(
        'resolve_locale() requires interaction, or bot= with guild_id= and/or user_id='
    )
