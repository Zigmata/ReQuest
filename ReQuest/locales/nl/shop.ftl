## Shop module strings

# Shop cog
shop-error-no-shops = Er zijn geen winkels geconfigureerd voor deze server.
shop-error-not-shop-channel =
    Dit kanaal is niet geregistreerd als winkelkanaal.
    Als je denkt dat hier een winkel hoort te zijn, laat het je serverbeheerder weten.

# Shop buttons
shop-btn-out-of-stock = Niet op voorraad
shop-btn-view-options = Aankoopopties bekijken
shop-btn-add-to-cart = Aan winkelwagen toevoegen ({ $cost })
shop-btn-view-cart = Winkelwagen bekijken
shop-btn-view-cart-count = Winkelwagen bekijken ({ $count })
shop-btn-back-to-shop = Terug naar winkel
shop-btn-clear-cart = Winkelwagen legen
shop-btn-checkout = Afrekenen
shop-btn-edit-quantity = Hoeveelheid bewerken

# Shop modals
shop-modal-title-edit-cart-qty = Winkelwagenhoeveelheid bewerken
shop-modal-label-quantity = Hoeveelheid
shop-modal-placeholder-quantity = Voer de nieuwe hoeveelheid in voor dit voorwerp
shop-error-invalid-number = Voer een geldig getal in.

# Shop views
shop-label-shopkeeper = Winkelier: {"**"}{ $name }{"**"}
shop-label-unknown-item = Onbekend voorwerp
shop-label-out-of-stock = NIET OP VOORRAAD
shop-label-stock-available = Voorraad: { $available }
shop-label-in-cart = (In winkelwagen: { $quantity })
shop-title-cart = 🛒 {"**"}Winkelwagen{"**"}
shop-msg-cart-empty = Je winkelwagen is leeg.
shop-warning-no-active-character = ⚠️ Geen actief personage gevonden. Kan saldo niet verifiëren.
shop-warning-insufficient-funds = ⚠️ Onvoldoende saldo voor { $currency }
shop-label-invalid-cost = Ongeldige kosten
shop-label-total-cost = {"**"}Totale kosten:{"**"}
shop-label-warning = {"**"}Waarschuwing:{"**"}
shop-error-no-active-character = Je hebt geen actief personage op deze server.
shop-error-checkout-insufficient = Afrekenen mislukt: Onvoldoende { $currency }.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} is niet op voorraad.

# Shop report embed
shop-embed-title-report = Winkelrapport
shop-embed-field-purchased = Gekocht
shop-label-no-items = Geen voorwerpen
shop-embed-field-total-paid = Totaal betaald

# Purchase options
shop-title-purchase-options = Aankoopopties: { $itemName }
shop-msg-no-options = Er zijn geen aankoopopties beschikbaar voor dit voorwerp.

# Shop messages
shop-msg-item-removed = Voorwerp verwijderd uit winkelwagen.
shop-msg-cart-updated = Winkelwagen bijgewerkt.

# Restock notifications
shop-restock-more-items = . . . en nog { $remaining }.
shop-embed-title-restocked = Winkel aangevuld!
shop-embed-footer-restocked = { $count } { $count ->
    [one] voorwerp
   *[other] voorwerpen
} aangevuld
