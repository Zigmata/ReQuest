## Shop module strings

# Shop cog
shop-error-no-shops = Nincsenek boltok konfigurálva ezen a szerveren.
shop-error-not-shop-channel =
    Ez a csatorna nincs bolt csatornaként regisztrálva.
    Ha úgy gondolod, hogy itt boltnak kellene lennie, szólj a szerver adminisztrátornak.

# Shop buttons
shop-btn-out-of-stock = Elfogyott
shop-btn-view-options = Vásárlási lehetőségek megtekintése
shop-btn-add-to-cart = Kosárba ({ $cost })
shop-btn-view-cart = Kosár megtekintése
shop-btn-view-cart-count = Kosár megtekintése ({ $count })
shop-btn-back-to-shop = Vissza a boltba
shop-btn-clear-cart = Kosár ürítése
shop-btn-checkout = Fizetés
shop-btn-edit-quantity = Mennyiség szerkesztése

# Shop modals
shop-modal-title-edit-cart-qty = Kosár mennyiségének szerkesztése
shop-modal-label-quantity = Mennyiség
shop-modal-placeholder-quantity = Add meg a tárgy új mennyiségét
shop-error-invalid-number = Kérjük, adj meg egy érvényes számot.

# Shop views
shop-label-shopkeeper = Boltos: {"**"}{ $name }{"**"}
shop-label-unknown-item = Ismeretlen tárgy
shop-label-out-of-stock = ELFOGYOTT
shop-label-stock-available = Készlet: { $available }
shop-label-in-cart = (Kosárban: { $quantity })
shop-title-cart = 🛒 {"**"}Bevásárlókosár{"**"}
shop-msg-cart-empty = A kosarad üres.
shop-warning-no-active-character = ⚠️ Nem található aktív karakter. Nem lehet a fedezetet ellenőrizni.
shop-warning-insufficient-funds = ⚠️ Nem elegendő { $currency }
shop-label-invalid-cost = Érvénytelen ár
shop-label-total-cost = {"**"}Összköltség:{"**"}
shop-label-warning = {"**"}Figyelmeztetés:{"**"}
shop-error-no-active-character = Nincs aktív karaktered ezen a szerveren.
shop-error-checkout-insufficient = Fizetés sikertelen: Nem elegendő { $currency }.
shop-error-item-out-of-stock = A(z) {"**"}{ $itemName }{"**"} elfogyott.

# Shop report embed
shop-embed-title-report = Vásárlási jelentés
shop-embed-field-purchased = Megvásárolt
shop-label-no-items = Nincsenek tárgyak
shop-embed-field-total-paid = Összesen fizetve

# Purchase options
shop-title-purchase-options = Vásárlási lehetőségek: { $itemName }
shop-msg-no-options = Ehhez a tárgyhoz nincsenek elérhető vásárlási lehetőségek.

# Shop messages
shop-msg-item-removed = Tárgy eltávolítva a kosárból.
shop-msg-cart-updated = Kosár frissítve.

# Restock notifications
shop-restock-more-items = . . . és még { $remaining } további.
shop-embed-title-restocked = Bolt feltöltve!
shop-embed-footer-restocked = { $count } { $count ->
    [one] tárgy
   *[other] tárgy
} feltöltve
