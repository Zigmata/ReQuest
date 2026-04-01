class CharacterFields:
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
    QUEST_ROLE_MODE = 'questRoleMode'
    XP = 'xp'


class ShopFields:
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
    RESTOCK_INCREMENT = 'restockIncrement'
    ENABLED = 'enabled'
    CHANNEL_TYPE = 'channelType'
    PARENT_FORUM_ID = 'parentForumId'


class CurrencyFields:
    CURRENCIES = 'currencies'
    DENOMINATIONS = 'denominations'
    VALUE = 'value'
    IS_DOUBLE = 'isDouble'


class ConfigFields:
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
    QUEST_ROLE_MODE = 'questRoleMode'
    QUEST_ROLE_ASSIGNMENTS = 'questRoleAssignments'


MAX_QUEST_ROLES_PER_GM = 20

FIRST_RESTOCK_GRACE_HOURLY = 2   # minutes
FIRST_RESTOCK_GRACE_DAILY = 10   # minutes
FIRST_RESTOCK_GRACE_WEEKLY = 30  # minutes


class RoleplayFields:
    ENABLED = 'enabled'
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
    ITEMS = 'items'
    CURRENCY = 'currency'
    XP = 'xp'


class RestockFields:
    ENABLED = 'enabled'
    SCHEDULE = 'schedule'
    HOUR = 'hour'
    MINUTE = 'minute'
    DAY_OF_WEEK = 'dayOfWeek'
    MODE = 'mode'
    INCREMENT_AMOUNT = 'incrementAmount'
    LAST_RESTOCK = 'lastRestock'


class CartFields:
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
    NAME = 'name'
    ITEMS = 'items'
    ORDER = 'order'


class CommonFields:
    ID = '_id'
    NAME = 'name'
    QUANTITY = 'quantity'
    MENTION = 'mention'
    AMOUNT = 'amount'
    ITEMS = 'items'


class DatabaseCollections:
    SERVER_ALLOWLIST = 'serverAllowlist'
    ANNOUNCE_ROLE = 'announceRole'
    APPROVAL_QUEUE_CHANNEL = 'approvalQueueChannel'
    APPROVALS = 'approvals'
    ARCHIVE_CHANNEL = 'archiveChannel'
    CURRENCY = 'currency'
    FORBIDDEN_ROLES = 'forbiddenRoles'
    GM_REWARDS = 'gmRewards'
    GM_ROLES = 'gmRoles'
    GM_TRANSACTION_LOG_CHANNEL = 'gmTransactionLogChannel'
    INVENTORY_CONFIG = 'inventoryConfig'
    NEW_CHARACTER_SHOP = 'newCharacterShop'
    PLAYER_BOARD = 'playerBoard'
    PLAYER_BOARD_CHANNEL = 'playerBoardChannel'
    PLAYER_EXPERIENCE = 'playerExperience'
    PLAYER_TRANSACTION_LOG_CHANNEL = 'playerTransactionLogChannel'
    QUEST_CHANNEL = 'questChannel'
    QUEST_SUMMARY = 'questSummary'
    QUEST_WAIT_LIST = 'questWaitList'
    QUESTS = 'quests'
    ROLEPLAY_CONFIG = 'roleplayConfig'
    ROLEPLAY_DATA = 'roleplayData'
    SHOP_CARTS = 'shopCarts'
    SHOP_LOG_CHANNEL = 'shopLogChannel'
    SHOP_STOCK = 'shopStock'
    SHOPS = 'shops'
    STATIC_KITS = 'staticKits'
    USER_LOCALE = 'userLocale'
    GUILD_LOCALE = 'guildLocale'
    QUEST_ROLE_MODE = 'questRoleMode'
    QUEST_ROLE_ASSIGNMENTS = 'questRoleAssignments'
    CHARACTERS = 'characters'
    PENDING_CHARACTERS = 'pendingCharacters'


class DisplayLimits:
    """Character limits for TextDisplay components. Discord enforces a 4000-char aggregate limit."""
    TEXT_DISPLAY_MAX = 4000
    SHOP_NAME = 50
    SHOPKEEPER_NAME = 32
    SHOP_DESCRIPTION = 300
    ITEM_NAME = 50
    ITEM_DESCRIPTION = 256
    MAX_CURRENCY_AMOUNT = 9_999_999_999
