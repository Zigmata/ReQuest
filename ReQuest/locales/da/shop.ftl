## Shop module strings

# Shop cog
shop-error-no-shops = Der er ingen butikker konfigureret for denne server.
shop-error-not-shop-channel =
    Denne kanal er ikke registreret som en butikskanal.
    Hvis du mener, der burde være en butik her, så giv din serveradministrator besked.

# Shop buttons
shop-btn-out-of-stock = Udsolgt
shop-btn-view-options = Se købsmuligheder
shop-btn-add-to-cart = Læg i kurv ({ $cost })
shop-btn-view-cart = Se kurv
shop-btn-view-cart-count = Se kurv ({ $count })
shop-btn-back-to-shop = Tilbage til butik
shop-btn-clear-cart = Tøm kurv
shop-btn-checkout = Betal
shop-btn-edit-quantity = Rediger antal

# Shop modals
shop-modal-title-edit-cart-qty = Rediger kurvantal
shop-modal-label-quantity = Antal
shop-modal-placeholder-quantity = Indtast det nye antal for denne genstand
shop-error-invalid-number = Indtast venligst et gyldigt tal.

# Shop views
shop-label-shopkeeper = Butiksindehaver: {"**"}{ $name }{"**"}
shop-label-unknown-item = Ukendt genstand
shop-label-out-of-stock = UDSOLGT
shop-label-stock-available = Lager: { $available }
shop-label-in-cart = (I kurv: { $quantity })
shop-title-cart = 🛒 {"**"}Indkøbskurv{"**"}
shop-msg-cart-empty = Din kurv er tom.
shop-warning-no-active-character = ⚠️ Ingen aktiv karakter fundet. Kan ikke bekræfte midler.
shop-warning-insufficient-funds = ⚠️ Utilstrækkelige midler til { $currency }
shop-label-invalid-cost = Ugyldig omkostning
shop-label-total-cost = {"**"}Samlede omkostninger:{"**"}
shop-label-warning = {"**"}Advarsel:{"**"}
shop-error-no-active-character = Du har ikke en aktiv karakter på denne server.
shop-error-checkout-insufficient = Betaling mislykkedes: Utilstrækkelig { $currency }.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} er udsolgt.

# Shop report embed
shop-embed-title-report = Indkøbsrapport
shop-embed-field-purchased = Købt
shop-label-no-items = Ingen genstande
shop-embed-field-total-paid = Betalt i alt

# Purchase options
shop-title-purchase-options = Købsmuligheder: { $itemName }
shop-msg-no-options = Der er ingen tilgængelige købsmuligheder for denne genstand.

# Shop messages
shop-msg-item-removed = Genstand fjernet fra kurven.
shop-msg-cart-updated = Kurv opdateret.

# Restock notifications
shop-restock-more-items = . . . og { $remaining } mere.
shop-embed-title-restocked = Butik genopfyldt!
shop-embed-footer-restocked = { $count } { $count ->
    [one] genstand
   *[other] genstande
} genopfyldt
