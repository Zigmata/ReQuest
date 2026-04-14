import logging
import traceback

import discord
from discord import app_commands

logger = logging.getLogger(__name__)

__all__ = ['UserFeedbackError', 'log_exception', 'log_task_exception']


class UserFeedbackError(Exception):
    """
    This is used for errors that should be reported to the user directly but do not need to log a stack trace.
    """

    def __init__(self, message, *, message_id=None, **variables):
        self.message_id = message_id
        self.variables = variables
        super().__init__(message)

    def resolve(self, locale):
        if self.message_id:
            from ReQuest.utilities.localizer import t
            return t(locale, self.message_id, **self.variables)
        return str(self)


def _is_invalid_media_url_error(exception) -> bool:
    """
    Detect Discord's 50035 'Invalid Form Body' response caused by a malformed media URL.
    """
    if not isinstance(exception, discord.HTTPException):
        return False
    if getattr(exception, 'code', None) != 50035:
        return False
    text = str(getattr(exception, 'text', '') or exception)
    return 'media.url' in text or 'Not a well formed URL' in text


async def log_exception(exception, interaction=None):
    """
    Logs an exception and sends a user-friendly message if interaction is provided.
    """
    from ReQuest.utilities.localizer import resolve_locale, t, DEFAULT_LOCALE

    locale = DEFAULT_LOCALE
    if interaction:
        try:
            locale = await resolve_locale(interaction)
        except Exception:
            pass

    if isinstance(exception, app_commands.CommandInvokeError):
        exception = exception.original

    if interaction and _is_invalid_media_url_error(exception):
        status = getattr(exception, 'status', 'unknown')
        code = getattr(exception, 'code', 'unknown')
        logger.warning(
            f'Discord rejected a media URL for user {interaction.user.id} '
            f'(status={status} code={code})'
        )
        exception = UserFeedbackError(
            t(locale, 'error-invalid-image-url'),
            message_id='error-invalid-image-url'
        )

    if isinstance(exception, (UserFeedbackError, app_commands.CheckFailure)):
        if isinstance(exception, UserFeedbackError):
            exception_text = exception.resolve(locale)
        else:
            exception_text = str(exception)

        error_embed = discord.Embed(
            title=t(locale, 'error-oops-title'),
            description=t(locale, 'error-report-description', exception=exception_text),
            color=discord.Color.red(),
            type='rich'
        )

        logger.debug(f'User feedback triggered: {exception}\nUser: {interaction.user.id if interaction else "Unknown"}')

        if interaction:
            try:
                if not interaction.response.is_done():
                    await interaction.response.send_message(embed=error_embed, ephemeral=True)
                else:
                    await interaction.followup.send(embed=error_embed, ephemeral=True)
            except discord.errors.InteractionResponded:
                try:
                    await interaction.followup.send(embed=error_embed, ephemeral=True)
                except Exception as e:
                    logger.error(f'Failed to send followup user feedback message: {e}')
            except Exception as e:
                logger.error(f'Failed to handle user feedback in log_exception: {e}')
        return

    logger.error(f'{type(exception).__name__}: {exception}')
    logger.error(''.join(traceback.format_exception(exception)))

    error_embed = discord.Embed(
        title=t(locale, 'error-oops-title'),
        description=t(locale, 'error-report-unexpected'),
        color=discord.Color.red(),
        type='rich'
    )

    if interaction:
        logger.error(f'Logged from guild ID: {interaction.guild_id}, user ID: {interaction.user.id}')
        try:
            if not interaction.response.is_done():
                await interaction.response.defer(ephemeral=True)
                await interaction.followup.send(embed=error_embed, ephemeral=True)
            else:
                await interaction.followup.send(embed=error_embed, ephemeral=True)
        except discord.errors.InteractionResponded:
            try:
                await interaction.followup.send(embed=error_embed, ephemeral=True)
            except Exception as e:
                logger.error(f'Failed to send followup error message: {e}')
        except Exception as e:
            logger.error(f'Failed to handle exception in log_exception: {e}')


def log_task_exception(exception, context=''):
    """
    Categorized logging for background task errors.

    Classifies exceptions into transient (warning), expected (debug),
    or unexpected (error with traceback) to reduce log noise from
    routine issues like temporary DB blips or deleted channels.
    """
    import pymongo.errors

    ctx = f' in {context}' if context else ''

    if isinstance(exception, (pymongo.errors.ConnectionFailure, pymongo.errors.ServerSelectionTimeoutError)):
        logger.warning(f'Transient DB error{ctx}: {exception}')
    elif isinstance(exception, discord.NotFound):
        logger.debug(f'Resource not found{ctx}: {exception}')
    elif isinstance(exception, discord.Forbidden):
        logger.debug(f'Missing permissions{ctx}: {exception}')
    elif isinstance(exception, discord.HTTPException):
        logger.warning(f'Discord API error{ctx}: {exception}')
    else:
        logger.error(f'{type(exception).__name__}{ctx}: {exception}')
        logger.error(''.join(traceback.format_exception(exception)))
