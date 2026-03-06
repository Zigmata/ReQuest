## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ Oops!
error-report-description =
    An exception occurred:

    ```{ $exception }```

    If this error is unexpected, or you suspect the bot is not functioning correctly, please submit a bug report in the [Official ReQuest Support Discord](https://discord.gg/Zq37gj4).

# Check failures
error-owner-only = Only the bot owner can use this command!
error-no-permission = You do not have permissions to run this command!
error-no-active-character = You do not have an active character on this server!
error-no-registered-characters = You do not have any registered characters!
error-no-characters = The target player does not have any registered characters.
error-no-active-character-target = The target player does not have a character activated on this server.
error-player-not-found = Player data not found.
error-character-not-found = Character data not found.

# Currency/transaction errors
error-transaction-cannot-complete = The transaction cannot be completed:
    { $reason }
error-insufficient-item-trade = You have { $owned }x { $itemName } but are trying to give { $quantity }.
error-currency-process-failed = Currency { $currencyName } could not be processed.
error-insufficient-funds-transaction = Insufficient funds to cover this transaction.
error-insufficient-funds = Insufficient funds.
error-insufficient-items = Insufficient item(s): { $itemName }
error-currency-not-configured = Currency '{ $currencyName }' is not configured on this server.
error-cost-currency-system-mismatch = Cost currency '{ $currencyName }' is not part of its own currency system.
error-currency-config-error = Currency configuration error: 0 or negative denomination value.
error-currency-validation = An error occurred during currency validation: { $error }
error-invalid-currency = { $itemName } is not a valid currency.
error-insufficient-funds-for-transaction = Insufficient funds for this transaction.

# Cart errors
error-cart-not-found = Cart not found.
error-item-not-in-cart = Item not in cart.
error-not-enough-stock = Not enough stock available.

# Container errors
error-container-not-found = Container not found.
error-container-name-empty = Container name cannot be empty.
error-container-name-too-long = Container name cannot exceed { $maxLength } characters.
error-max-containers-reached = You cannot create more than { $maxContainers } containers.
error-container-name-exists = A container named "{ $containerName }" already exists.
error-item-already-in-container = Item is already in this container.
error-quantity-minimum = Quantity must be at least 1.
error-source-container-not-found = Source container not found.
error-item-not-in-source = Item "{ $itemName }" not found in the source container.
error-insufficient-quantity-in-container = Insufficient quantity. You have { $available } in this container.
error-dest-container-not-found = Destination container not found.
error-item-not-in-container = Item "{ $itemName }" not found in this container.
error-insufficient-quantity-consume = You only have { $available } of this item in this container.
