"""
Backward-compatibility shim. All functions have moved to focused modules
under ReQuest.utilities.*. This file re-exports them so existing
``from ReQuest.utilities.supportFunctions import X`` continues to work.

New modules:
    exceptions.py    — UserFeedbackError, log_exception
    db_cache.py      — build_cache_key, get/update/replace/delete_cached_data
    discord_utils.py — attempt_delete, strip_id, truncate_text, escape_markdown, get_guild_member
    currency.py      — currency formatting, denomination maps, fund checks
    containers.py    — container CRUD, inventory formatting
    character.py     — trade, inventory updates, XP, apply_*_local
    shop.py          — stock management, cart CRUD, cart cleanup
    quests.py        — quest embeds, role hierarchy, setup_view, XP config
"""

from ReQuest.utilities.exceptions import *       # noqa: F401,F403
from ReQuest.utilities.db_cache import *         # noqa: F401,F403
from ReQuest.utilities.discord_utils import *    # noqa: F401,F403
from ReQuest.utilities.currency import *         # noqa: F401,F403
from ReQuest.utilities.containers import *       # noqa: F401,F403
from ReQuest.utilities.character import *        # noqa: F401,F403
from ReQuest.utilities.shop import *             # noqa: F401,F403
from ReQuest.utilities.quests import *           # noqa: F401,F403
