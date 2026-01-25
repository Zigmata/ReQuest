from enum import Enum


class RewardType(Enum):
    PARTY = 'party'
    INDIVIDUAL = 'individual'


class ScheduleType(Enum):
    HOURLY = 'hourly'
    DAILY = 'daily'
    WEEKLY = 'weekly'


class InventoryType(Enum):
    DISABLED = 'disabled'
    SELECTION = 'selection'
    PURCHASE = 'purchase'
    OPEN = 'open'
    STATIC = 'static'


class RestockMode(Enum):
    FULL = 'full'
    INCREMENTAL = 'incremental'


class RoleplayMode(Enum):
    SCHEDULED = 'scheduled'
    ACCRUED = 'accrued'


class DayOfWeek(Enum):
    MONDAY = 'monday'
    TUESDAY = 'tuesday'
    WEDNESDAY = 'wednesday'
    THURSDAY = 'thursday'
    FRIDAY = 'friday'
    SATURDAY = 'saturday'
    SUNDAY = 'sunday'


class ShopChannelType(Enum):
    TEXT_CHANNEL = 'text_channel'
    FORUM_THREAD = 'forum_thread'
