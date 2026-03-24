## Shop module strings

# Shop cog
shop-error-no-shops = Ingen butikker er konfigurert for denne serveren.
shop-error-not-shop-channel =
    Denne kanalen er ikke registrert som en butikkanal.
    Hvis du tror det skulle vært en butikk her, gi beskjed til serveradministratoren din.

# Shop buttons
shop-btn-out-of-stock = Utsolgt
shop-btn-view-options = Vis kjøpsalternativer
shop-btn-add-to-cart = Legg i handlekurv ({ $cost })
shop-btn-view-cart = Vis handlekurv
shop-btn-view-cart-count = Vis handlekurv ({ $count })
shop-btn-back-to-shop = Tilbake til butikk
shop-btn-clear-cart = Tøm handlekurv
shop-btn-checkout = Gå til kassen
shop-btn-edit-quantity = Rediger antall

# Shop modals
shop-modal-title-edit-cart-qty = Rediger handlekurvantall
shop-modal-label-quantity = Antall
shop-modal-placeholder-quantity = Skriv inn det nye antallet for denne gjenstanden
shop-error-invalid-number = Vennligst skriv inn et gyldig tall.

# Shop views
shop-label-shopkeeper = Butikkeier: {"**"}{ $name }{"**"}
shop-label-unknown-item = Ukjent gjenstand
shop-label-out-of-stock = UTSOLGT
shop-label-stock-available = Lager: { $available }
shop-label-in-cart = (I handlekurven: { $quantity })
shop-title-cart = 🛒 {"**"}Handlekurv{"**"}
shop-msg-cart-empty = Handlekurven din er tom.
shop-warning-no-active-character = ⚠️ Ingen aktiv karakter funnet. Kan ikke verifisere midler.
shop-warning-insufficient-funds = ⚠️ Ikke nok midler for { $currency }
shop-label-invalid-cost = Ugyldig kostnad
shop-label-total-cost = {"**"}Totalkostnad:{"**"}
shop-label-warning = {"**"}Advarsel:{"**"}
shop-error-no-active-character = Du har ingen aktiv karakter på denne serveren.
shop-error-checkout-insufficient = Utsjekking mislyktes: Ikke nok { $currency }.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} er utsolgt.

# Shop report embed
shop-embed-title-report = Handlerapport
shop-embed-field-purchased = Kjøpt
shop-label-no-items = Ingen gjenstander
shop-embed-field-total-paid = Totalt betalt

# Purchase options
shop-title-purchase-options = Kjøpsalternativer: { $itemName }
shop-msg-no-options = Det finnes ingen kjøpsalternativer tilgjengelig for denne gjenstanden.

# Shop messages
shop-msg-item-removed = Gjenstand fjernet fra handlekurven.
shop-msg-cart-updated = Handlekurven er oppdatert.

# Restock notifications
shop-restock-more-items = . . . og { $remaining } til.
shop-embed-title-restocked = Butikken er påfylt!
shop-embed-footer-restocked = { $count } { $count ->
    [one] gjenstand
   *[other] gjenstander
} påfylt
