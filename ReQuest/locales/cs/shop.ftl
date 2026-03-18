## Shop module strings

# Shop cog
shop-error-no-shops = Na tomto serveru nejsou nakonfigurovány žádné obchody.
shop-error-not-shop-channel =
    Tento kanál není zaregistrován jako kanál obchodu.
    Pokud si myslíte, že by zde měl být obchod, dejte vědět administrátorovi serveru.

# Shop buttons
shop-btn-out-of-stock = Vyprodáno
shop-btn-view-options = Zobrazit možnosti nákupu
shop-btn-add-to-cart = Přidat do košíku ({ $cost })
shop-btn-view-cart = Zobrazit košík
shop-btn-view-cart-count = Zobrazit košík ({ $count })
shop-btn-back-to-shop = Zpět do obchodu
shop-btn-clear-cart = Vyprázdnit košík
shop-btn-checkout = Zaplatit
shop-btn-edit-quantity = Upravit množství

# Shop modals
shop-modal-title-edit-cart-qty = Upravit množství v košíku
shop-modal-label-quantity = Množství
shop-modal-placeholder-quantity = Zadejte nové množství tohoto předmětu
shop-error-invalid-number = Zadejte prosím platné číslo.

# Shop views
shop-label-shopkeeper = Obchodník: {"**"}{ $name }{"**"}
shop-label-unknown-item = Neznámý předmět
shop-label-out-of-stock = VYPRODÁNO
shop-label-stock-available = Zásoby: { $available }
shop-label-in-cart = (V košíku: { $quantity })
shop-title-cart = 🛒 {"**"}Nákupní košík{"**"}
shop-msg-cart-empty = Váš košík je prázdný.
shop-warning-no-active-character = ⚠️ Nebyla nalezena aktivní postava. Nelze ověřit prostředky.
shop-warning-insufficient-funds = ⚠️ Nedostatečné prostředky pro { $currency }
shop-label-invalid-cost = Neplatná cena
shop-label-total-cost = {"**"}Celková cena:{"**"}
shop-label-warning = {"**"}Varování:{"**"}
shop-error-no-active-character = Na tomto serveru nemáte aktivní postavu.
shop-error-checkout-insufficient = Platba selhala: Nedostatečné { $currency }.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} je vyprodáno.

# Shop report embed
shop-embed-title-report = Zpráva o nákupu
shop-embed-field-purchased = Zakoupeno
shop-label-no-items = Žádné předměty
shop-embed-field-total-paid = Celkem zaplaceno

# Purchase options
shop-title-purchase-options = Možnosti nákupu: { $itemName }
shop-msg-no-options = Pro tento předmět nejsou k dispozici žádné možnosti nákupu.

# Shop messages
shop-msg-item-removed = Předmět odebrán z košíku.
shop-msg-cart-updated = Košík aktualizován.

# Restock notifications
shop-restock-more-items = . . . a dalších { $remaining }.
shop-embed-title-restocked = Obchod doplněn!
shop-embed-footer-restocked = { $count } { $count ->
    [one] předmět
    [few] předměty
   *[other] předmětů
} doplněno
