from enum import Enum


class ChannelType(Enum):
    QUEST_BOARD = 'quest_board'
    PLAYER_BOARD = 'player_board'
    QUEST_ARCHIVE = 'quest_archive'
    GM_TRANSACTION_LOG = 'gm_transaction_log'
    PLAYER_TRADING_LOG = 'player_trading_log'
    SHOP_LOG = 'shop_log'
    APPROVAL_QUEUE = 'approval_queue'


class InventoryType(Enum):
    DISABLED = 'disabled'
    SELECTION = 'selection'
    PURCHASE = 'purchase'
    OPEN = 'open'
    STATIC = 'static'
