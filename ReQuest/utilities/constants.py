"""
Database field name constants for ReQuest.

This module provides centralized constants for MongoDB document field names
to prevent typos and enable IDE autocomplete throughout the codebase.
"""


class CharacterFields:
    """Character document field names."""
    CHARACTERS = 'characters'
    ACTIVE_CHARACTERS = 'activeCharacters'
    ATTRIBUTES = 'attributes'
    CURRENCY = 'currency'
    INVENTORY = 'inventory'
    CONTAINERS = 'containers'
    ITEMS = 'items'
    EXPERIENCE = 'experience'
    NAME = 'name'


class QuestFields:
    """Quest document field names."""
    QUEST_ID = 'questId'
    GUILD_ID = 'guildId'
    MESSAGE_ID = 'messageId'
    TITLE = 'title'
    DESCRIPTION = 'description'
    MAX_PARTY_SIZE = 'maxPartySize'
    RESTRICTIONS = 'restrictions'
    GM = 'gm'
    PARTY = 'party'
    WAIT_LIST = 'waitList'
    MAX_WAIT_LIST_SIZE = 'maxWaitListSize'
    LOCK_STATE = 'lockState'
    REWARDS = 'rewards'
    PARTY_ROLE_ID = 'partyRoleId'
    XP = 'xp'


class ShopFields:
    """Shop document field names."""
    SHOP_CHANNELS = 'shopChannels'
    SHOP_STOCK = 'shopStock'
    SHOPS = 'shops'
    SHOP_NAME = 'shopName'
    SHOP_DESCRIPTION = 'shopDescription'
    SHOP_KEEPER = 'shopKeeper'
    SHOP_IMAGE = 'shopImage'
    RESTOCK_CONFIG = 'restockConfig'
    MAX_STOCK = 'maxStock'
    AVAILABLE = 'available'
    RESERVED = 'reserved'
    COSTS = 'costs'
    ENABLED = 'enabled'
    CHANNEL_TYPE = 'channelType'
    PARENT_FORUM_ID = 'parentForumId'


class CurrencyFields:
    """Currency document field names."""
    CURRENCIES = 'currencies'
    DENOMINATIONS = 'denominations'
    VALUE = 'value'
    IS_DOUBLE = 'isDouble'


class ConfigFields:
    """Guild configuration field names."""
    QUEST_CHANNEL = 'questChannel'
    PLAYER_BOARD_CHANNEL = 'playerBoardChannel'
    PLAYER_TRANSACTION_LOG_CHANNEL = 'playerTransactionLogChannel'
    GM_TRANSACTION_LOG_CHANNEL = 'gmTransactionLogChannel'
    SHOP_LOG_CHANNEL = 'shopLogChannel'
    ARCHIVE_CHANNEL = 'archiveChannel'
    APPROVAL_QUEUE_CHANNEL = 'approvalQueueChannel'
    GM_ROLES = 'gmRoles'
    ANNOUNCE_ROLE = 'announceRole'
    FORBIDDEN_ROLES = 'forbiddenRoles'
    PLAYER_EXPERIENCE = 'playerExperience'
    INVENTORY_TYPE = 'inventoryType'
    NEW_CHARACTER_WEALTH = 'newCharacterWealth'
    QUEST_WAIT_LIST = 'questWaitList'


class RoleplayFields:
    """Roleplay configuration field names."""
    CHANNELS = 'channels'
    MODE = 'mode'
    CONFIG = 'config'
    RESET_PERIOD = 'resetPeriod'
    RESET_DAY = 'resetDay'
    RESET_TIME = 'resetTime'
    THRESHOLD = 'threshold'
    FREQUENCY = 'frequency'
    COOLDOWN = 'cooldown'
    MIN_LENGTH = 'minLength'
    REWARDS = 'rewards'
    XP = 'xp'


class RestockFields:
    """Restock configuration field names."""
    SCHEDULE = 'schedule'
    HOUR = 'hour'
    MINUTE = 'minute'
    DAY_OF_WEEK = 'dayOfWeek'
    MODE = 'mode'
    INCREMENT_AMOUNT = 'incrementAmount'
    LAST_RESTOCK = 'lastRestock'


class CartFields:
    """Shopping cart field names."""
    GUILD_ID = 'guildId'
    USER_ID = 'userId'
    CHANNEL_ID = 'channelId'
    ITEMS = 'items'
    ITEM = 'item'
    QUANTITY = 'quantity'
    OPTION_INDEX = 'optionIndex'
    CREATED_AT = 'createdAt'
    UPDATED_AT = 'updatedAt'
    EXPIRES_AT = 'expiresAt'
    RESERVED_AT = 'reservedAt'


class ContainerFields:
    """Container field names for character inventory containers."""
    NAME = 'name'
    ITEMS = 'items'
    ORDER = 'order'


class CommonFields:
    """Commonly used field names across multiple domains."""
    ID = '_id'
    NAME = 'name'
    QUANTITY = 'quantity'
    MENTION = 'mention'
    AMOUNT = 'amount'
    ITEMS = 'items'
