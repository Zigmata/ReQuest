## Shop module strings

# Shop cog
shop-error-no-shops = No shops are configured for this server.
shop-error-not-shop-channel =
    This channel is not registered as a shop channel.
    If you think there is supposed to be a shop here, let your server admin know.

# Shop buttons
shop-btn-out-of-stock = Out of Stock
shop-btn-view-options = View Purchase Options
shop-btn-add-to-cart = Add to Cart ({ $cost })
shop-btn-view-cart = View Cart
shop-btn-view-cart-count = View Cart ({ $count })
shop-btn-back-to-shop = Back to Shop
shop-btn-clear-cart = Clear Cart
shop-btn-checkout = Checkout
shop-btn-edit-quantity = Edit Quantity

# Shop modals
shop-modal-title-edit-cart-qty = Edit Cart Quantity
shop-modal-label-quantity = Quantity
shop-modal-placeholder-quantity = Enter the new quantity for this item
shop-error-invalid-number = Please enter a valid number.

# Shop views
shop-label-shopkeeper = Shopkeeper: {"**"}{ $name }{"**"}
shop-label-unknown-item = Unknown Item
shop-label-out-of-stock = OUT OF STOCK
shop-label-stock-available = Stock: { $available }
shop-label-in-cart = (In Cart: { $quantity })
shop-title-cart = 🛒 {"**"}Shopping Cart{"**"}
shop-msg-cart-empty = Your cart is empty.
shop-warning-no-active-character = ⚠️ No active character found. Cannot verify funds.
shop-warning-insufficient-funds = ⚠️ Insufficient funds for { $currency }
shop-label-invalid-cost = Invalid Cost
shop-label-total-cost = {"**"}Total Cost:{"**"}
shop-label-warning = {"**"}Warning:{"**"}
shop-error-no-active-character = You do not have an active character on this server.
shop-error-checkout-insufficient = Checkout failed: Insufficient { $currency }.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} is out of stock.

# Shop report embed
shop-embed-title-report = Shopping Report
shop-embed-field-purchased = Purchased
shop-label-no-items = No Items
shop-embed-field-total-paid = Total Paid

# Purchase options
shop-title-purchase-options = Purchase Options: { $itemName }
shop-msg-no-options = There are no purchase options available for this item.

# Shop messages
shop-msg-item-removed = Item removed from cart.
shop-msg-cart-updated = Cart updated.

# Restock notifications
shop-restock-more-items = . . . and { $remaining } more.
shop-embed-title-restocked = Shop Restocked!
shop-embed-footer-restocked = { $count } { $count ->
    [one] item
   *[other] items
} restocked
