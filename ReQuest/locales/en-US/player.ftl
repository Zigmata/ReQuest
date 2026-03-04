## Player module strings

# --- Cog ---

player-cmd-name = Trade
player-cmd-desc = Player Menus

# --- Buttons ---

# Character management
player-btn-register-character = Register New Character
player-btn-activate = Activate
player-btn-active = Active

# Player board
player-btn-create-post = Create Post
player-btn-open-starting-shop = Open Starting Shop
player-btn-select-kit = Select Kit
player-btn-input-inventory = Input Inventory

# Wizard / shop buttons
player-btn-add-to-cart = Add to Cart
player-btn-add-to-cart-cost = Add to Cart ({ $costString })
player-btn-view-purchase-options = View Purchase Options
player-btn-review-submit = Review & Submit ({ $count })
player-btn-submit-character = Submit Character
player-btn-keep-shopping = Keep Shopping
player-btn-edit-quantity = Edit Quantity
player-btn-clear-cart = Clear Cart

# Kit buttons
player-btn-confirm-selection = Confirm Selection
player-btn-back-to-kits = Back to Kits

# Inventory management
player-btn-spend-currency = Spend Currency
player-btn-print-inventory = Print Inventory

# Container management
player-btn-manage-containers = Manage Containers
player-btn-create-new = + Create New
player-btn-consume-destroy = Consume/Destroy
player-btn-move = Move
player-btn-move-all = Move All
player-btn-move-some = Move Some...
player-btn-back-to-overview = ← Back to Overview
player-btn-cancel-move = ← Cancel
player-btn-up = ▲ Up
player-btn-down = ▼ Down

# --- Modals ---

# Trade modal
player-modal-title-trade = Trading with { $targetName }
player-modal-label-trade-name = Name
player-modal-placeholder-trade-name = Enter the name of the item you are trading
player-modal-label-trade-quantity = Quantity
player-modal-placeholder-trade-quantity = Enter the amount you are trading

# Character register modal
player-modal-title-register = Register New Character
player-modal-label-char-name = Name
player-modal-placeholder-char-name = Enter your character's name.
player-modal-label-char-note = Note
player-modal-placeholder-char-note = Enter a note to identify your character

# Open inventory input modal
player-modal-title-starting-inventory = Starting Inventory Input
player-modal-label-inventory = Inventory
player-modal-placeholder-inventory-input =
    One per line in <name>: <quantity> format, e.g.:
    Sword: 1
    gold: 30

# Spend currency modal
player-modal-title-spend-currency = Spend Currency
player-modal-label-currency-name = Currency Name
player-modal-placeholder-currency-name = Enter the name of the currency you are spending
player-modal-label-currency-amount = Amount
player-modal-placeholder-currency-amount = Enter the amount to spend

# Create player post modal
player-modal-title-create-post = Create Player Board Post
player-modal-label-post-title = Title
player-modal-placeholder-post-title = Enter a title for your post
player-modal-label-post-content = Post Content
player-modal-placeholder-post-content = Enter the body of your post

# Edit player post modal
player-modal-title-edit-post = Edit Player Board Post

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = Edit Cart Quantity
player-modal-label-cart-qty = Quantity
player-modal-placeholder-cart-qty = Enter new quantity (0 to remove)

# Create container modal
player-modal-title-create-container = Create New Container
player-modal-label-container-name = Container Name
player-modal-placeholder-container-name = Enter a name for your container (e.g., Backpack)

# Rename container modal
player-modal-title-rename-container = Rename Container
player-modal-label-new-container-name = New Container Name
player-modal-placeholder-new-container-name = Enter the new name

# Consume from container modal
player-modal-title-consume = Consume/Destroy Item
player-modal-label-consume-qty = Quantity (max: { $maxQuantity })
player-modal-placeholder-consume-qty = Enter amount to consume/destroy

# Move item quantity modal
player-modal-title-move-item = Move Item
player-modal-label-move-qty = Quantity to move (max: { $maxQuantity })
player-modal-placeholder-move-qty = Enter amount to move

# --- Selects ---

player-select-placeholder-no-characters = You have no registered characters
player-select-placeholder-remove-character = Select a character to remove
player-select-placeholder-post = Select a post
player-select-placeholder-container-view = Select a container to view...
player-select-placeholder-item = Select an item...
player-select-placeholder-destination = Select destination...
player-select-placeholder-container = Select a container...
player-select-option-no-containers = No containers
player-select-option-no-items = No items
player-select-option-no-destinations = No destinations

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}Player Commands - Main Menu{"**"}
player-menu-btn-characters = Characters
player-menu-desc-characters = Register, view, and activate player characters.
player-menu-btn-inventory = Inventory
player-menu-desc-inventory = View your active character's inventory and spend currency.
player-menu-btn-player-board = Player Board
player-menu-btn-player-board-disabled = Player Board (Not Configured)
player-menu-desc-player-board = Create a post for the Player Board

# CharacterBaseView
player-title-characters = {"**"}Player Commands - Characters{"**"}
player-desc-register-character = Register a new character.
player-msg-no-characters = You have no characters registered.
player-label-active = (Active)
player-label-xp = { $xp } XP

# Confirm character removal
player-modal-title-confirm-char-removal = Confirm Character Removal
player-modal-label-confirm-char-delete = Delete { $characterName }?

# Confirm post removal
player-modal-title-confirm-post-removal = Confirm Post Removal
player-modal-label-post-removal-warning = WARNING: This action is irreversible!

# InventoryOverviewView
player-title-inventory = {"**"}Player Commands - Inventory{"**"}
player-title-char-inventory = {"**"}{ $characterName }'s Inventory{"**"}
player-msg-no-active-character = No Active Character: Activate a character for this server to use these menus.
player-msg-no-characters-registered = No Characters: Register a character to use these menus.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } items
player-label-currency = {"**"}Currency{"**"}
player-msg-inventory-empty = Inventory is empty.

# Print inventory embed
player-embed-title-inventory = { $characterName }'s Inventory

# ContainerItemsView
player-msg-container-empty = This container is empty.
player-label-selected-item = Selected: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Move "{ $itemName }"{"**"} ({ $available } available)
player-msg-no-other-containers = No other containers available.
player-msg-select-destination = Select destination container:
player-label-destination = Destination: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Manage Containers{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } items){ $suffix }
player-label-default-suffix = { " " }(default)
player-msg-no-containers = No containers.
player-label-selected-container = Selected: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = Confirm Container Deletion
player-modal-label-container-has-items = Has { $itemCount } items. Will move to Loose Items.
player-modal-label-confirm-container-delete = Delete "{ $containerName }"?

# Container errors
player-error-cannot-rename-loose = Cannot rename Loose Items.
player-error-cannot-delete-loose = Cannot delete Loose Items.

# PlayerBoardView
player-title-player-board = {"**"}Player Commands - Player Board{"**"}
player-desc-create-post = Create a new post for the Player Board.
player-msg-no-posts = You don't have any current posts.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Author
player-embed-footer-post-id = Post ID: { $postId }
player-error-board-channel-not-found = Player Board channel not found.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Setup Inventory for { $characterName }{"**"}
player-desc-browse-shop = Browse the Starting Shop to equip your character.
player-desc-select-kit = Select a Starting Kit.
player-desc-input-inventory = Manually input your starting inventory.

# StaticKitSelectView
player-title-select-kit = {"**"}Select a Kit for { $characterName }{"**"}
player-msg-no-kits = No starting kits are available.
player-label-and-more-items = ...and { $count } more items
player-label-empty-kit = {"*"}Empty Kit{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Confirm Selection: { $kitName }{"**"}
player-label-items-heading = {"**"}Items:{"**"}
player-label-currency-heading = {"**"}Currency:{"**"}
player-msg-kit-empty = This kit is empty.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Purchase Options: { $itemName }{"**"}
player-msg-no-cost-options = This item has no cost options available.
player-label-cost-option = {"**"}Option { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Starting Shop ({ $inventoryType }){"**"}
player-label-starting-wealth = Starting Wealth: { $formattedCurrency }
player-label-in-cart = {"**"}(In Cart: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Review Cart{"**"}
player-msg-cart-empty = Your cart is empty.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Total: { $totalQuantity })
player-label-insufficient-currency = Insufficient { $currencyName }
player-label-total-cost = {"**"}Total Cost:{"**"}
player-label-total-cost-free = {"**"}Total Cost:{"**"} Free
player-label-cart-page = Page { $current } of { $total }

# Trade embed
player-embed-title-trade = Trade Report
player-embed-desc-trade-sender = Sender: { $senderMention } as `{ $senderCharacter }`
player-embed-desc-trade-recipient = Recipient: { $recipientMention } as `{ $recipientCharacter }`
player-embed-field-currency = Currency
player-embed-field-amount = Amount
player-embed-field-balance = { $characterName }'s Balance
player-embed-field-item = Item
player-embed-field-quantity = Quantity
player-embed-footer-transaction-id = Transaction ID: { $transactionId }

# Trade errors
player-error-trade-no-characters = The player you are attempting to trade with has no characters!
player-error-trade-no-active = The player you are attempting to trade with does not have an active character on this server!

# Spend currency embed
player-embed-title-spend = Player Transaction Report
player-embed-desc-spend-player = Player: { $playerMention } as `{ $characterName }`
player-embed-desc-spend-transaction = Transaction: {"**"}{ $characterName }{"**"} spent {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Channel
player-embed-field-receipt = Receipt

# Spend currency errors
player-error-amount-not-number = Amount must be a number.
player-error-amount-positive = You must spend a positive amount.
player-error-no-active-character-server = You do not have an active character on this server.
player-error-no-currency-config = A currency configuration was not found for this server.

# Consume item embed
player-embed-title-consume = Item Consumption Report
player-embed-desc-consume = Player: { $playerMention } as `{ $characterName }`
player-embed-desc-consume-removed = Removed: {"**"}{ $quantity }x { $itemName }{"**"} from {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = Quantity must be a positive integer.
player-error-qty-at-least-one = Quantity must be at least 1.
player-error-qty-only-have = You only have { $maxQuantity } of this item.

# Inventory input errors
player-error-invalid-format = Invalid format: "{ $line }". Use <name>: <quantity>.
player-error-empty-name = Item name cannot be empty in line: "{ $line }".
player-error-invalid-quantity = Invalid quantity for "{ $name }": "{ $quantity }". Must be a positive integer.
player-error-input-errors-header = Errors in inventory input:
player-msg-no-valid-items = No valid items provided. Initializing with empty inventory.

# Cart quantity validation
player-error-enter-valid-number = Please enter a valid positive number.

# Submission embeds (approval queue)
player-embed-title-approval = Inventory Approval: { $characterName }
player-embed-desc-submitted-by = Submitted by { $userMention }
player-embed-field-items = Items
player-embed-field-currency-received = Currency
player-embed-footer-submission-id = Submission ID: { $submissionId }
player-label-approval-thread = Approval: { $characterName }
player-embed-title-submission-sent = Inventory Submission Sent
player-embed-desc-submission-sent =
    Your submission for {"**"}{ $characterName }{"**"} has been sent to the GM team for approval!
    You will be notified once it has been reviewed.
    [View Submission Thread]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = Starting Inventory Applied
player-embed-desc-starting-inventory = Player: { $playerMention } as `{ $characterName }`
player-embed-field-items-received = Items Received
player-embed-field-currency-received-label = Currency Received
player-label-untitled = Untitled
