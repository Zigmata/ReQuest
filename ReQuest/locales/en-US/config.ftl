## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = Clear
config-btn-remove-gm-roles = Remove GM Roles
config-btn-forbidden-roles = Forbidden Roles

# Quests
config-btn-toggle-quest-summary = Toggle Quest Summary
config-btn-toggle-player-experience = Toggle Player Experience
config-btn-toggle-display = Toggle Display
config-btn-purge-player-board = Purge Player Board
config-btn-add-modify-rewards = Add/Modify Rewards

# Currency
config-btn-add-denomination = Add Denomination
config-btn-add-new-currency = Add New Currency
config-btn-remove-currency = Remove Currency

# Shops - creation
config-btn-add-shop-wizard = Add Shop (Wizard)
config-btn-add-shop-json = Add Shop (JSON)
config-btn-edit-shop-wizard = Edit Shop (Wizard)
config-btn-edit-shop-json = Edit Shop (JSON)
config-btn-remove-shop = Remove Shop
config-btn-add-item = Add Item
config-btn-edit-shop-details = Edit Shop Details
config-btn-download-json = Download JSON
config-btn-done-editing = Done Editing
config-btn-scan-server-configs = Scan Server Configs
config-btn-re-scan = Re-Scan

# New character shop
config-btn-upload-json = Upload JSON
config-btn-configure-new-character-wealth = Configure New Character Wealth
config-btn-configure-new-character-shop = Configure New Character Shop
config-btn-configure-static-kits = Configure Static Kits
config-btn-new-character-settings = New Character Settings
config-btn-disabled-no-currency = Disabled (No Currency Configured)
config-btn-disabled-no-wealth = Disabled (No Starting Wealth Configured)

# Static kits
config-btn-create-new-kit = Create New Kit
config-btn-delete-kit = Delete Kit
config-btn-add-currency = Add Currency

# Roleplay
config-btn-toggle-rp-rewards = Toggle RP Rewards
config-btn-clear-channels = Clear Channels
config-btn-edit-settings = Edit Settings
config-btn-configure-rewards = Configure Rewards

# Stock
config-btn-stock-limits = Stock Limits
config-btn-set-limit = Set Limit
config-btn-edit-limit = Edit Limit
config-btn-remove-limit = Remove Limit
config-btn-configure-restock-schedule = Configure Restock Schedule
config-btn-back-to-shop-editor = Back to Shop Editor

# Forum shop
config-btn-create-new-thread = Create New Thread
config-btn-use-existing-thread = Use Existing Thread

# Wizard
config-btn-quit = Quit
config-btn-configure-channels = Configure Channels
config-btn-configure-roles = Configure Roles
config-btn-configure-quests = Configure Quests
config-btn-configure-players = Configure Players
config-btn-configure-currency = Configure Currency
config-btn-configure-rp-rewards = Configure RP Rewards
config-btn-configure-shops = Configure Shops
config-btn-new-char-setup = New Char Setup

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = Confirm Role Removal
config-modal-title-confirm-removal = Confirm Removal
config-modal-title-confirm-currency-removal = Confirm Currency Removal
config-modal-title-confirm-shop-removal = Confirm Shop Removal
config-modal-title-confirm-kit-deletion = Confirm Kit Deletion
config-modal-title-confirm-remove-stock-limit = Confirm Remove Stock Limit

# Confirm modal prompt labels
config-modal-label-remove-role = Remove { $roleName }?
config-modal-label-remove-denomination = Remove { $denominationName }?
config-modal-label-remove-currency = Remove { $currencyName }?
config-modal-label-shop-removal-warning = WARNING: This action is irreversible!
config-modal-label-kit-deletion-warning = WARNING: Irreversible!
config-modal-label-remove-stock-limit = Type CONFIRM to remove the stock limit
config-modal-placeholder-type-confirm = Type CONFIRM

# Error messages from buttons
config-error-shop-data-not-found = Error: Could not find that shop's data.
config-msg-shop-json-download = Here is the JSON definition for {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Here is the JSON definition for the New Character Shop.
config-error-select-forum-first = Please select a forum channel first.
config-error-select-thread-first = Please select a thread first.

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Add New Currency
config-modal-label-currency-name = Currency Name
config-error-currency-already-exists = A currency or denomination named { $name } already exists!

# RenameCurrencyModal
config-modal-title-rename-currency = Rename Currency
config-modal-label-new-currency-name = New Currency Name
config-error-currency-name-exists = A currency named "{ $name }" already exists.
config-error-denomination-name-exists = A denomination named "{ $name }" already exists.

# RenameDenominationModal
config-modal-title-rename-denomination = Rename Denomination
config-modal-label-new-denomination-name = New Denomination Name

# AddCurrencyDenominationModal
config-modal-title-add-denomination = Add { $currencyName } Denomination
config-modal-label-denomination-name = Name
config-modal-placeholder-denomination-name = e.g., Silver
config-modal-label-denomination-value = Value
config-modal-placeholder-denomination-value = e.g., 0.1
config-error-denomination-matches-currency = New denomination name cannot match an existing currency on this server! Found existing currency named "{ $existingName }".
config-error-denomination-matches-denomination = New denomination name cannot match an existing denomination on this server! Found existing denomination named "{ $denominationName }" under the currency named "{ $currencyName }".
config-error-denomination-value-exists = Denominations under a single currency must have unique values! { $denominationName } already has this value assigned.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Forbidden Role Names
config-modal-label-names = Names
config-modal-placeholder-names = Input names separated by commas
config-msg-forbidden-roles-updated = Forbidden roles updated!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Purge Player Board
config-modal-label-age = Age
config-modal-placeholder-age = Enter the maximum post age (in days) to keep
config-msg-posts-purged = Posts older than { $days } days have been purged!

# GMRewardsModal
config-modal-title-gm-rewards = Add/Modify GM Rewards
config-modal-label-experience = Experience
config-modal-placeholder-enter-number = Enter a number
config-modal-label-items = Items
config-modal-placeholder-items =
    Name: Quantity
    Name2: Quantity
    etc.
config-error-experience-invalid = Experience must be a valid integer (e.g. 2000).
config-error-item-format-invalid = Invalid item format: "{ $item }". Each item must be on a new line, and in the format "Name: Quantity".

# ConfigShopDetailsModal
config-modal-title-shop-details = Add/Edit Shop Details
config-modal-label-shop-channel = Select a channel
config-modal-placeholder-shop-channel = Select the channel for this shop
config-modal-label-shop-name = Shop Name
config-modal-placeholder-shop-name = Enter the name of the shop
config-modal-label-shopkeeper-name = Shopkeeper Name
config-modal-placeholder-shopkeeper-name = Enter the name of the shopkeeper
config-modal-label-shop-description = Shop Description
config-modal-placeholder-shop-description = Enter a description for the shop
config-modal-label-shop-image-url = Shop Image URL
config-modal-placeholder-shop-image-url = Enter a URL for the shop image
config-error-no-channel-selected = No channel selected for the shop.
config-error-shop-already-in-channel = A shop is already registered in the selected channel. Please choose a different channel or edit the existing shop.

# build_shop_header_view
config-label-shopkeeper = {"**"}Shopkeeper:{"**"} { $name }
config-msg-use-shop-command = Use the `/shop` command to browse and purchase items.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Create Forum Thread Shop
config-modal-label-thread-name = Thread Name
config-modal-placeholder-thread-name = Enter the name for the shop thread
config-error-forum-not-found = Could not find the selected forum channel.
config-error-shop-already-in-thread = A shop is already registered in this thread. This should not happen for a new thread.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Add New Shop via JSON
config-modal-label-upload-json = Upload a .json file containing the shop data
config-error-no-json-uploaded = No JSON file uploaded for the shop.
config-error-file-must-be-json = Uploaded file must be a JSON file (.json).
config-error-invalid-json = Invalid JSON format: { $error }
config-error-json-validation-failed = JSON does not conform to schema: { $error }

# ShopItemModal
config-modal-title-shop-item = Add/Edit Shop Item
config-modal-label-item-name = Item Name
config-modal-placeholder-item-name = Enter the name of the item
config-modal-label-item-description = Item Description
config-modal-placeholder-item-description = Enter a description for the item
config-modal-label-item-quantity = Item Quantity
config-modal-placeholder-item-quantity = Enter the quantity sold per purchase
config-modal-label-item-costs = Item Costs
config-modal-placeholder-item-costs = E.g.: 10 gold + 5 silver\nOR: 50 rep\n(Use + for AND, New Lines for OR)
config-error-item-quantity-positive = Item quantity must be a positive integer.
config-error-cost-format-invalid = Invalid cost format in option: "{ $option }". Each cost must have an amount and a currency separated by a space, e.g. "10 gold".
config-error-cost-amount-invalid = Invalid amount "{ $amount }" for currency: "{ $currency }". Amount must be a positive number.
config-error-unknown-currency = Unknown currency `{ $currency }`. Please use a valid currency configured for this server.
config-error-item-already-exists = An item named { $itemName } already exists in this shop.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Update Shop via JSON
config-modal-label-upload-new-json = Upload new JSON definition
config-error-no-file-uploaded = No file was uploaded.
config-error-file-must-be-json-ext = File must be a `.json` file.
config-error-json-validation-message = JSON validation failed: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Add/Edit NewCharacter Gear
config-modal-placeholder-item-quantity-selection = Enter the quantity received per selection
config-modal-label-item-cost = Item Cost
config-error-cost-format-short = Invalid cost format: '{ $component }'. Expected 'Amount Currency'.
config-error-amount-invalid-short = Invalid amount '{ $amount }' for currency '{ $currency }'.
config-error-item-exists-new-char = An item named { $itemName } already exists in the New Character shop.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Upload New Character Shop (JSON)
config-error-no-json-uploaded-short = No JSON file uploaded.
config-error-json-must-have-shopstock = JSON must contain a 'shopStock' array.
config-error-items-must-have-name-price = All items must have 'name' and 'price'.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Set New Character Wealth
config-modal-label-amount = Amount
config-modal-placeholder-amount = Enter the amount of this currency.
config-modal-placeholder-currency-name = Enter the name of a currency defined on this server
config-error-no-currencies-configured = No currencies are configured on this server.
config-error-currency-not-found = Currency or denomination named { $name } not found. Please use a valid currency.

# CreateStaticKitModal
config-modal-title-create-kit = Create New Static Kit
config-modal-label-kit-name = Kit Name
config-modal-placeholder-kit-name = e.g., Warrior Starter Kit
config-modal-label-description = Description
config-modal-placeholder-kit-description = Optional description for this kit
config-error-kit-name-exists = A static kit named "{ $kitName }" already exists. Please choose a different name.

# StaticKitItemModal
config-modal-title-kit-item = Add/Edit Kit Item
config-modal-placeholder-kit-item-quantity = Enter the quantity of this item to be included in the kit

# StaticKitCurrencyModal
config-modal-title-kit-currency = Add Kit Currency
config-modal-placeholder-currency-eg = e.g., Gold
config-modal-placeholder-amount-eg = e.g., 100
config-error-amount-must-be-number = Amount must be a number.
config-error-no-currencies-on-server = No currencies configured on server.
config-error-currency-not-found-short = Currency "{ $currency }" not found.
config-error-denomination-not-found = Denomination "{ $denomination }" not found in currency configuration.

# RoleplaySettingsModal
config-modal-title-rp-settings = Roleplay Settings
config-modal-label-min-message-length = Minimum Message Length (characters)
config-modal-placeholder-min-message-length = # of characters required for a message to be eligible. 0 for no limit
config-modal-label-cooldown = Cooldown (seconds)
config-modal-placeholder-cooldown = Wait time, in seconds, between counting messages as eligible for rewards
config-modal-label-message-threshold = Message Threshold
config-modal-placeholder-message-threshold = Number of messages required to trigger reward
config-modal-label-frequency = Frequency (# of messages)
config-modal-placeholder-frequency = Number of eligible messages required to earn rewards
config-error-min-length-invalid = Minimum Message Length must be a non-negative integer.
config-error-cooldown-invalid = Cooldown must be a non-negative integer.
config-error-threshold-invalid = Message Threshold must be a positive integer.
config-error-frequency-invalid = Frequency must be a positive integer.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Configure Roleplay Rewards
config-modal-label-items-name-quantity = Items (Name: Quantity)
config-modal-label-currency-name-amount = Currency (Name: Amount)
config-error-experience-non-negative = Experience must be a non-negative integer.
config-error-item-quantity-positive-named = Item quantity for "{ $itemName }" must be a positive integer.
config-error-currency-amount-positive = Currency amount for "{ $currencyName }" must be a positive number.

# SetItemStockModal
config-modal-title-stock-limit = Stock Limit: { $itemName }
config-modal-label-max-stock = Maximum Stock
config-modal-placeholder-max-stock = Enter max stock (e.g., 10)
config-modal-label-current-stock = Current Stock
config-modal-placeholder-current-stock = Enter current available stock
config-error-max-stock-positive = Maximum stock must be a positive integer.
config-error-current-stock-non-negative = Current stock must be a non-negative integer.
config-error-current-exceeds-max = Current stock cannot exceed maximum stock.
config-error-item-not-in-shop = Item "{ $itemName }" not found in shop.

# RestockScheduleModal
config-modal-title-restock-schedule = Configure Restock Schedule
config-modal-label-schedule = Schedule (hourly/daily/weekly/none)
config-modal-placeholder-schedule = Enter: hourly, daily, weekly, or none
config-modal-label-time = Time (HH:MM in UTC)
config-modal-desc-current-time = Current time: { $utcTime }
config-modal-placeholder-time = e.g., 14:30 for 2:30 PM UTC
config-modal-label-day-of-week = Day of Week (0=Mon, 6=Sun) - Weekly only
config-modal-placeholder-day-of-week = Enter 0-6 (Monday=0, Sunday=6)
config-modal-label-mode = Mode (full/incremental)
config-modal-placeholder-mode = full = reset to max, incremental = add amount
config-modal-label-increment = Increment Amount (for incremental mode)
config-modal-placeholder-increment = Amount to add per restock cycle
config-error-schedule-invalid = Schedule must be one of: hourly, daily, weekly, or none.
config-error-time-format-invalid = Time must be in HH:MM format (e.g., 14:30).
config-error-day-of-week-invalid = Day of week must be 0-6 (Monday=0, Sunday=6).
config-error-mode-invalid = Mode must be either "full" or "incremental".
config-error-increment-positive = Increment amount must be a positive integer.

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Search for your { $configName } Channel

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Choose your Quest Announcement Role

# AddGMRoleSelect
config-select-placeholder-gm-roles = Choose your GM Role(s)

# ConfigWaitListSelect
config-select-placeholder-wait-list = Select Wait List size
config-select-option-disabled = 0 (Disabled)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Select Inventory Mode
config-select-option-disabled-label = Disabled
config-select-desc-disabled = Players start with empty inventories.
config-select-option-selection = Selection
config-select-desc-selection = Players choose items freely from the New Character Shop.
config-select-option-purchase = Purchase
config-select-desc-purchase = Players purchase items from the New Character Shop with a given amount of currency.
config-select-option-open = Open
config-select-desc-open = Players manually input their own inventories.
config-select-option-static = Static
config-select-desc-static = Players are given a predefined starting inventory.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Select Eligible Channels

# RoleplayModeSelect
config-select-placeholder-rp-mode = Select Mode
config-select-option-scheduled = Scheduled
config-select-desc-scheduled = Rewards are granted once within a specified reset period.
config-select-option-accrued = Accrued
config-select-desc-accrued = Rewards are repeatedly granted based on specified activity levels.

# RoleplayResetSelect
config-select-placeholder-reset-period = Select Reset Period
config-select-option-hourly = Hourly
config-select-desc-hourly = Resets every hour.
config-select-option-daily = Daily
config-select-desc-daily = Resets every 24 hours.
config-select-option-weekly = Weekly
config-select-desc-weekly = Resets every 7 days.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Select Reset Day

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Select Reset Time (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Select a forum channel

# ForumThreadSelect
config-select-placeholder-thread = Select a thread
config-select-option-no-threads = No active threads found
config-select-desc-no-threads = Create a new thread or check archived threads
config-select-option-select-forum-first = Select a forum first
config-select-desc-select-forum-first = Please select a forum channel above
config-select-desc-thread-id = Thread ID: { $threadId }
config-error-select-valid-thread = Please select a valid thread or create a new one.
config-error-thread-not-found = Could not find the selected thread. It may have been deleted or archived.

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = Server Configuration - Main Menu
config-menu-config-wizard = Config Wizard
config-menu-desc-config-wizard = Validate your server is ready to use ReQuest with a quick scan.
config-menu-channels = Channels
config-menu-desc-channels = Set designated channels for ReQuest posts.
config-menu-currency = Currency
config-menu-desc-currency = Global currency settings.
config-menu-players = Players
config-menu-desc-players = Global player settings, such as experience point tracking.
config-menu-quests = Quests
config-menu-desc-quests = Global quest settings, such as wait lists.
config-menu-rp-rewards = RP Rewards
config-menu-desc-rp-rewards = Configure roleplaying rewards.
config-menu-roles = Roles
config-menu-desc-roles = Configuration options for pingable or privileged roles.
config-menu-shops = Shops
config-menu-desc-shops = Configure custom shops.
config-menu-language = Language
config-menu-desc-language = Set the default language for this server.

## Wizard View
config-title-wizard = {"**"}Server Configuration - Wizard{"**"}
config-wizard-intro =
    {"**"}Welcome to the ReQuest Configuration Wizard!{"**"}

    This wizard will help you ensure that your server is properly configured to use ReQuest's features.
    It will scan your current settings and provide recommendations for any adjustments needed.

    Use the "Launch Scan" button below to begin the validation process. Once the scan is complete,
    you will receive a detailed report of your server's configuration along with any recommended changes.

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}Bot Global Permissions{"**"}__
config-wizard-bot-permissions-desc = This section verifies that ReQuest has the correct permissions to function correctly.
config-wizard-bot-role = Bot Role: { $roleMention }
config-wizard-status-warnings = {"**"}Status: ⚠️ WARNINGS FOUND{"**"}
config-wizard-missing-perm = - ⚠️ Missing: `{ $permissionName }`
config-wizard-ensure-permissions = Please ensure the bot's highest role has these permissions granted globally.
config-wizard-status-ok = {"**"}Status: ✅ OK{"**"}
config-wizard-bot-permissions-ok = The bot has all required global permissions.
config-wizard-status-scan-failed = {"**"}Status: ❌ SCAN FAILED{"**"}
config-wizard-scan-error = An unexpected error occurred while checking bot permissions.
config-wizard-error-type = Error: { $errorType }
config-wizard-required-permissions = {"**"}Required Permissions for the Bot's Role:{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = View Channels
config-wizard-perm-manage-roles = Manage Roles
config-wizard-perm-send-messages = Send Messages
config-wizard-perm-attach-files = Attach Files
config-wizard-perm-add-reactions = Add Reactions
config-wizard-perm-use-external-emoji = Use External Emoji
config-wizard-perm-manage-messages = Manage Messages
config-wizard-perm-read-message-history = Read Message History

# Wizard - Role Validation
config-wizard-role-header = __{"**"}Role Configurations{"**"}__
config-wizard-role-desc =
    This section verifies the following:

    - GM roles (required) and Announcement role (optional) are configured.
    - The default (@everyone) role has required permissions for users to access bot features.
    - The default (@everyone) role does not have dangerous permissions.
    - GM and Announcement roles are checked to see if they have any permission escalations beyond the default role.

    Any warnings here are solely recommendations based on a default setup. Depending on your server's needs, you may have reason to disregard some of these recommendations.

config-wizard-default-role-label = {"**"}Default Role:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Dangerous Permissions Found:
config-wizard-default-role-ok = - ✅ @everyone: OK
config-wizard-missing-permission = - Missing Permission: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}GM Roles:{"**"}
config-wizard-no-gm-roles = - ⚠️ No GM Roles Configured
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Configured Role Not Found/Deleted from Server
config-wizard-role-ok = - ✅ { $roleMention }: OK
config-wizard-announcement-role-label = {"**"}Announcement Role:{"**"}
config-wizard-no-announcement-role = - ℹ️ No Announcement Role Configured
config-wizard-announcement-role-not-found = - ⚠️ Configured Role Not Found/Deleted from Server
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Permission Escalations Detected - { $escalations }
config-wizard-escalation-more = , and { $count } more...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = Send Messages in Threads
config-wizard-perm-use-application-commands = Use Application Commands

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = Manage Channels
config-wizard-perm-manage-webhooks = Manage Webhooks
config-wizard-perm-manage-server = Manage Server
config-wizard-perm-manage-nicknames = Manage Nicknames
config-wizard-perm-kick-members = Kick Members
config-wizard-perm-ban-members = Ban Members
config-wizard-perm-timeout-members = Timeout Members
config-wizard-perm-mention-everyone = Mention @everyone
config-wizard-perm-manage-threads = Manage Threads
config-wizard-perm-administrator = Administrator

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}Channel Configurations{"**"}__
config-wizard-channel-desc =
    This section verifies the following:

    - Configured channels exist.
    - The bot has permission to view and send messages in the configured channels.
    - The default (@everyone) role does not have `Send Messages` permissions.

config-wizard-channel-no-config-required = - ⚠️ No Channel Configured
config-wizard-channel-not-configured = - ℹ️ Not Configured (Optional)
config-wizard-channel-not-found = - ⚠️ Configured Channel Not Found/Deleted from Server
config-wizard-channel-ok = - ✅ OK
config-wizard-bot-cannot-view = - ⚠️ { $botMention } cannot view this channel.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } cannot send messages in this channel.
config-wizard-everyone-can-send = - ⚠️ @everyone can send messages in this channel.

# Wizard - Channel names
config-wizard-channel-quest-board = Quest Board
config-wizard-channel-player-board = Player Board
config-wizard-channel-quest-archive = Quest Archive
config-wizard-channel-gm-transaction-log = GM Transaction Log
config-wizard-channel-player-transaction-log = Player Transaction Log
config-wizard-channel-shop-log = Shop Log
config-wizard-channel-approval-queue = Character Approval Queue

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}Settings Dashboard{"**"}__
config-wizard-dashboard-desc = This section provides an overview of non-essential configurations for quick reference.
config-wizard-quest-settings = {"**"}Quest Settings{"**"}
config-wizard-quest-wait-list = - Quest Wait List Size: { $size }
config-wizard-quest-summary = - Quest Summary: { $status }
config-wizard-gm-rewards-per-quest = {"**"}GM Rewards (Per Quest){"**"}
config-wizard-player-settings = {"**"}Player Settings{"**"}
config-wizard-player-experience = - Player Experience: { $status }
config-wizard-currency-settings = {"**"}Currency Settings{"**"}
config-wizard-rp-rewards = {"**"}Roleplay Rewards{"**"}
config-wizard-rp-status = - Status: { $status }
config-wizard-rp-mode = - Mode: { $mode }
config-wizard-rp-channels = - Monitored Channels: { $count }
config-wizard-shops = {"**"}Shops{"**"}
config-wizard-shops-count = - Configured Shops: { $count }
config-wizard-shops-more = - ...and { $count } more
config-wizard-new-char-setup = {"**"}New Character Setup{"**"}
config-wizard-inventory-type = - Inventory Type: { $type }
config-wizard-new-char-shop-items = - New Character Shop Items: { $count }
config-wizard-static-kits = - Static Kits: { $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ No Currencies Configured
config-wizard-configured-currencies = {"**"}Configured Currencies:{"**"}
config-wizard-no-denominations = - No Denominations Configured
config-wizard-gm-rewards-disabled = {"**"}Status:{"**"} Disabled
config-wizard-gm-rewards-enabled = {"**"}Status:{"**"} Enabled
config-wizard-gm-rewards-experience = - Experience: { $xp }
config-wizard-gm-rewards-items = - Items:
config-wizard-unnamed-shop = Unnamed Shop

## Roles View
config-title-roles = {"**"}Server Configuration - Roles{"**"}
config-label-announcement-role = {"**"}Announcement Role:{"**"} { $status }
config-desc-announcement-role = This role is mentioned when a quest is posted.
config-label-announcement-role-default = {"**"}Announcement Role:{"**"} Not Configured
config-label-gm-roles = {"**"}GM Role(s):{"**"} { $roles }
config-desc-gm-roles = These roles will grant access to Game Master commands and features.
config-label-gm-roles-default = {"**"}GM Role(s):{"**"} Not Configured
config-title-forbidden-roles = __{"**"}Forbidden Roles{"**"}__
config-desc-forbidden-roles =
    Configures a list of role names that cannot be used by Game Masters for their party roles.
    By default, `everyone`, `administrator`, `gm`, and `game master` cannot be used. This configuration
    extends that list.

## GM Role Remove View
config-title-remove-gm-roles = {"**"}Server Configuration - Remove GM Role(s){"**"}
config-msg-no-gm-roles = No GM roles configured.

## Channels View
config-title-channels = {"**"}Server Configuration - Channels{"**"}

config-label-quest-board = {"**"}Quest Board:{"**"} { $channel }
config-desc-quest-board = The channel where new/active quests will be posted.
config-label-quest-board-default = {"**"}Quest Board:{"**"} Not Configured

config-label-player-board = {"**"}Player Board:{"**"} { $channel }
config-desc-player-board = An optional announcement/message board for use by players.
config-label-player-board-default = {"**"}Player Board:{"**"} Not Configured

config-label-quest-archive = {"**"}Quest Archive:{"**"} { $channel }
config-desc-quest-archive = An optional channel where completed quests will move to, with summary information.
config-label-quest-archive-default = {"**"}Quest Archive:{"**"} Not Configured

config-label-gm-transaction-log = {"**"}GM Transaction Log:{"**"} { $channel }
config-desc-gm-transaction-log = An optional channel where GM transactions (i.e. Modify Player commands) are logged.
config-label-gm-transaction-log-default = {"**"}GM Transaction Log:{"**"} Not Configured

config-label-player-transaction-log = {"**"}Player Transaction Log:{"**"} { $channel }
config-desc-player-transaction-log = An optional channel where player transactions such as trading and consuming items are logged.
config-label-player-transaction-log-default = {"**"}Player Transaction Log:{"**"} Not Configured

config-label-shop-log = {"**"}Shop Log:{"**"} { $channel }
config-desc-shop-log = An optional channel where shop transactions are logged.
config-label-shop-log-default = {"**"}Shop Log:{"**"} Not Configured

## Quests View
config-title-quests = {"**"}Server Configuration - Quests{"**"}

config-label-wait-list = {"**"}Quest Wait List Size:{"**"} { $size }
config-desc-wait-list = A wait list allows the specified number of players to queue for a quest that is full, in case a player drops.
config-label-wait-list-disabled = {"**"}Quest Wait List Size:{"**"} Disabled

config-label-quest-summary = {"**"}Quest Summary:{"**"} { $status }
config-desc-quest-summary = This option enables GMs to provide a short summary when closing out quests.
config-label-quest-summary-disabled = {"**"}Quest Summary:{"**"} Disabled

config-label-gm-rewards = {"**"}GM Rewards{"**"}
config-desc-gm-rewards = Configure rewards for GMs to receive upon completing quests.

## GM Rewards View
config-title-gm-rewards = {"**"}Server Configuration - GM Rewards{"**"}
config-desc-gm-rewards-detail =
    {"**"}Add/Modify Rewards{"**"}
    Opens an input modal to add, modify, or remove GM rewards.

    > Rewards configured are on a per-quest basis. Every time a Game Master completes a quest, they will
    receive the rewards configured below on their active character.
config-msg-no-rewards = No rewards configured.
config-label-gm-experience = {"**"}Experience:{"**"} { $xp }
config-label-gm-items = {"**"}Items:{"**"}

## Players View
config-title-players = {"**"}Server Configuration - Players{"**"}

config-label-player-experience = {"**"}Player Experience:{"**"} { $status }
config-desc-player-experience = Enables/Disables the use of experience points (or similar value-based character progression.
config-label-player-experience-disabled = {"**"}Player Experience:{"**"} Disabled

config-label-new-char-settings = {"**"}New Character Settings{"**"}
config-desc-new-char-settings = Configure settings related to new player characters and how their initial inventories are set up.

config-label-player-board-purge = {"**"}Player Board Purge{"**"}
config-desc-player-board-purge = Purges posts from the player board (if enabled).

## New Character Settings View
config-title-new-character = {"**"}Server Configuration - New Character Settings{"**"}

config-label-inventory-type = {"**"}New Character Inventory Type:{"**"} { $type }
config-desc-inventory-type = Determines how newly-registered characters initialize their inventories.
config-label-inventory-type-disabled = {"**"}New Character Inventory Type:{"**"} Disabled

config-label-new-char-wealth = {"**"}New Character Wealth:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}New Character Wealth:{"**"} Disabled

config-label-approval-queue = {"**"}Approval Queue:{"**"} { $channel }
config-desc-approval-queue = If set, new characters must be approved by a GM in this Forum Channel before they are active.
config-label-approval-queue-disabled = {"**"}Approval Queue:{"**"} Disabled
config-label-approval-queue-not-configured = {"**"}Approval Queue:{"**"} Not Configured

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = Players start with empty inventories.
config-desc-inv-type-selection = Players choose items freely from the New Character Shop.
config-desc-inv-type-purchase = Players purchase items from the New Character Shop with a given amount of currency.
config-desc-inv-type-open = Players manually input their inventory items.
config-desc-inv-type-static = Players are given a predefined starting inventory.

## New Character Shop View
config-title-new-char-shop = {"**"}Server Configuration - New Character Shop{"**"}
config-label-inv-type-selection = {"**"}Inventory Type:{"**"} Selection
config-desc-inv-type-selection-shop = Players choose items freely from the New Character Shop.
config-label-inv-type-purchase = {"**"}Inventory Type:{"**"} Purchase
config-desc-inv-type-purchase-shop = Players purchase items from the New Character Shop with a given amount of currency.
config-label-inv-type-other = {"**"}Inventory Type:{"**"} { $type }
config-desc-inv-type-not-in-use = New Character Shop is not in use.
config-msg-define-shop-items = Define the shop items.
config-msg-no-items = No items configured.

## Static Kits View
config-title-static-kits = {"**"}Server Configuration - Static Kits{"**"}
config-desc-create-kit = Create a new kit definition.
config-msg-no-kits = No kits configured.
config-label-kit-more-items = ...and { $count } more items
config-label-empty-kit = {"*"}Empty Kit{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}Editing Kit: { $kitName }{"**"}
config-msg-kit-empty = This kit is empty. Use the buttons above to add currency or items.
config-label-kit-currency = {"**"}Currency:{"**"} { $display }
config-label-kit-item = {"**"}Item:{"**"} { $name }

## Currency View
config-title-currency = {"**"}Server Configuration - Currency{"**"}
config-desc-create-currency = Create a new currency.
config-msg-no-currencies = No currencies configured.
config-label-currency-display-type = Display Type: { $type } | Denominations: { $count }
config-label-currency-type-double = Double
config-label-currency-type-integer = Integer

## Edit Currency View
config-title-manage-currency = {"**"}Manage Currency: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Currency and Denominations{"**"}__
    - The given name of your currency is considered the base currency and has a value of 1.
    {"```"}Example: "gold" is configured as a currency.{"```"}
    - Adding a denomination requires specifying a name and a value relative to the base currency.
    {"```"}Example: Gold is given two denominations: silver (value of 0.1), and copper (value of 0.01).{"```"}
    - Any transactions involving a base currency or its denominations will automatically convert them.
    {"```"}Example: A player has 10 gold and spends 3 copper. Their new balance will automatically display
    9 gold, 9 silver, and 7 copper.{"```"}
    - Currencies displayed as an integer will show each denomination, while currencies displayed as a double
    will show only as the base currency.
    {"```"}Example: The player above with double display enabled will show as 9.97 gold.{"```"}
config-btn-toggle-display-current = Toggle Display (Current: { $type })
config-msg-no-denominations = No denominations configured.

## Shops View
config-title-shops = {"**"}Server Configuration - Shops{"**"}
config-desc-add-shop-wizard =
    {"**"}Add Shop (Wizard){"**"}
    Create a new, empty shop from a form.
config-desc-add-shop-json =
    {"**"}Add Shop (JSON){"**"}
    Create a new shop by providing a full JSON definition. (Advanced)
config-msg-no-shops = No shops configured.
config-label-shop-type-forum = (Forum)
config-label-shop-channel = Channel: <#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}Add Shop - Choose Location Type{"**"}
config-label-text-channel = {"**"}Text Channel{"**"}
config-desc-text-channel = Create a shop in a standard text channel.
config-label-forum-thread = {"**"}Forum Thread{"**"}
config-desc-forum-thread = Create a shop in a forum thread (new or existing).

## Forum Shop Setup View
config-title-forum-setup = {"**"}Add Shop - Forum Thread Setup{"**"}
config-label-step1 = {"**"}Step 1: Select a Forum Channel{"**"}
config-label-step2 = {"**"}Step 2: Choose Thread Option{"**"}
config-label-step3 = {"**"}Step 3: Select an Existing Thread{"**"}
config-desc-create-new-thread =
    {"**"}Create New Thread{"**"}
    Opens a form to create a new thread and configure the shop.
config-label-selected-thread = {"**"}Selected Thread:{"**"} { $threadName }
config-desc-click-to-configure = Click to configure the shop in this thread.

## Manage Shop View
config-title-manage-shop = {"**"}Manage Shop: { $shopName }{"**"}
config-label-shop-type = {"**"}Type:{"**"} { $type }
config-label-shop-type-text = Text Channel
config-label-shop-type-forum-thread = Forum Thread
config-label-shopkeeper = {"**"}Shopkeeper:{"**"} { $name }
config-label-shop-description = {"**"}Description:{"**"} { $description }
config-label-shop-channel-info = {"**"}Channel:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Edit Shop details and items via Wizard.
config-desc-upload-json = Upload a new JSON definition for this shop.
config-desc-download-json = Download the current JSON definition.
config-desc-remove-shop = Permanently remove this shop.

## Edit Shop View
config-title-editing-shop = {"**"}Editing Shop: { $shopName }{"**"}
config-label-shop-shopkeeper = Shopkeeper: {"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}Stock Configuration: { $shopName }{"**"}
config-label-current-utc = Current UTC Time: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Restock Schedule:{"**"} { $schedule }
config-label-restock-hourly = at minute :{ $minute }
config-label-restock-daily = at { $time } UTC
config-label-restock-weekly = on { $day } at { $time } UTC
config-label-restock-mode = {"**"}Mode:{"**"} { $mode }
config-label-restock-full = Full restock
config-label-restock-incremental = Add { $amount } per cycle (up to max)
config-label-restock-disabled = {"**"}Restock Schedule:{"**"} Disabled
config-label-item-stock-limits = {"**"}Item Stock Limits{"**"}
config-msg-no-items-in-shop = No items in this shop.
config-label-stock-with-available = Max: { $max } | Available: { $available }
config-label-stock-reserved = | Reserved: { $reserved }
config-label-stock-not-initialized = Max: { $max } | Available: (not initialized)
config-label-stock-unlimited = Stock: Unlimited

## Roleplay View
config-title-roleplay = {"**"}Server Configuration - Roleplay Rewards{"**"}
config-label-rp-status = {"**"}Status:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Server Time:{"**"} `{ $time }`
config-label-rp-enabled = Enabled
config-label-rp-disabled = Disabled

config-desc-rp-mode-scheduled = {"```"}Rewards are distributed once, upon sending the required threshold of eligible messages within the set time period (hourly, daily, or weekly).{"```"}
config-desc-rp-mode-accrued = {"```"}Rewards are distributed on a recurring basis each time a set number of eligible messages are sent.{"```"}

config-label-rp-config-details = {"**"}Configuration Details:{"**"}
config-label-rp-mode = {"**"}Mode:{"**"} { $mode }
config-label-rp-min-length = {"**"}Minimum Message Length:{"**"} { $length } characters
config-label-rp-cooldown = {"**"}Cooldown:{"**"} { $seconds } seconds
config-label-rp-frequency-once = {"**"}Frequency:{"**"} Once per { $period }
config-label-rp-reset-time = {"**"}Reset Time:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Threshold:{"**"} { $count } eligible messages
config-label-rp-frequency-every = {"**"}Frequency:{"**"} Every { $count } eligible messages

config-label-rp-channels = {"**"}Roleplaying Channels:{"**"}
config-msg-rp-no-channels = None configured.
config-label-rp-channels-more = ...and { $count } more.

config-label-rp-rewards = {"**"}Rewards:{"**"}
config-msg-rp-no-rewards = None configured.
config-label-rp-experience = {"**"}Experience:{"**"} { $xp }
config-label-rp-items = {"**"}Items:{"**"}
config-label-rp-currency = {"**"}Currency:{"**"}

## Language View
config-title-language = {"**"}Server Configuration - Language{"**"}
config-label-server-language = {"**"}Server Language:{"**"} { $language }
config-label-server-language-default = {"**"}Server Language:{"**"} Default (no override)
config-select-placeholder-server-language = Select server language
config-select-option-default = Default (no override)
config-select-desc-default = Use each user's preference or Discord locale.
