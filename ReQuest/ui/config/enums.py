from enum import Enum


class ChannelType(Enum):
    QUEST_BOARD = 'quest_board'
    PLAYER_BOARD = 'player_board'
    QUEST_ARCHIVE = 'quest_archive'
    GM_TRANSACTION_LOG = 'gm_transaction_log'
    PLAYER_TRANSACTION_LOG = 'player_transaction_log'
    SHOP_LOG = 'shop_log'
    APPROVAL_QUEUE = 'approval_queue'
