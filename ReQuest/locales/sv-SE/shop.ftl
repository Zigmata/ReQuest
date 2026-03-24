## Shop module strings

# Shop cog
shop-error-no-shops = Inga butiker är konfigurerade för denna server.
shop-error-not-shop-channel =
    Denna kanal är inte registrerad som en butikskanal.
    Om du tror att det borde finnas en butik här, meddela din serveradministratör.

# Shop buttons
shop-btn-out-of-stock = Slut i lager
shop-btn-view-options = Visa köpalternativ
shop-btn-add-to-cart = Lägg i kundvagn ({ $cost })
shop-btn-view-cart = Visa kundvagn
shop-btn-view-cart-count = Visa kundvagn ({ $count })
shop-btn-back-to-shop = Tillbaka till butiken
shop-btn-clear-cart = Töm kundvagn
shop-btn-checkout = Betala
shop-btn-edit-quantity = Ändra antal

# Shop modals
shop-modal-title-edit-cart-qty = Ändra kundvagnsantal
shop-modal-label-quantity = Antal
shop-modal-placeholder-quantity = Ange det nya antalet för detta föremål
shop-error-invalid-number = Ange ett giltigt nummer.

# Shop views
shop-label-shopkeeper = Butiksinnehavare: {"**"}{ $name }{"**"}
shop-label-unknown-item = Okänt föremål
shop-label-out-of-stock = SLUT I LAGER
shop-label-stock-available = Lager: { $available }
shop-label-in-cart = (I kundvagn: { $quantity })
shop-title-cart = 🛒 {"**"}Kundvagn{"**"}
shop-msg-cart-empty = Din kundvagn är tom.
shop-warning-no-active-character = ⚠️ Ingen aktiv karaktär hittades. Kan inte verifiera medel.
shop-warning-insufficient-funds = ⚠️ Otillräckliga medel för { $currency }
shop-label-invalid-cost = Ogiltig kostnad
shop-label-total-cost = {"**"}Total kostnad:{"**"}
shop-label-warning = {"**"}Varning:{"**"}
shop-error-no-active-character = Du har ingen aktiv karaktär på denna server.
shop-error-checkout-insufficient = Betalning misslyckades: Otillräckligt { $currency }.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} är slut i lager.

# Shop report embed
shop-embed-title-report = Shoppingrapport
shop-embed-field-purchased = Köpt
shop-label-no-items = Inga föremål
shop-embed-field-total-paid = Totalt betalt

# Purchase options
shop-title-purchase-options = Köpalternativ: { $itemName }
shop-msg-no-options = Det finns inga köpalternativ tillgängliga för detta föremål.

# Shop messages
shop-msg-item-removed = Föremål borttaget från kundvagnen.
shop-msg-cart-updated = Kundvagn uppdaterad.

# Restock notifications
shop-restock-more-items = . . . och { $remaining } till.
shop-embed-title-restocked = Butiken har fyllts på!
shop-embed-footer-restocked = { $count } { $count ->
    [one] föremål
   *[other] föremål
} påfyllt
