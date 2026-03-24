## Shop module strings

# Shop cog
shop-error-no-shops = Nijedna trgovina nije konfigurirana za ovaj poslužitelj.
shop-error-not-shop-channel =
    Ovaj kanal nije registriran kao kanal trgovine.
    Ako mislite da bi ovdje trebala biti trgovina, obavijestite administratora poslužitelja.

# Shop buttons
shop-btn-out-of-stock = Nema na zalihi
shop-btn-view-options = Pogledaj opcije kupnje
shop-btn-add-to-cart = Dodaj u košaricu ({ $cost })
shop-btn-view-cart = Pogledaj košaricu
shop-btn-view-cart-count = Pogledaj košaricu ({ $count })
shop-btn-back-to-shop = Natrag u trgovinu
shop-btn-clear-cart = Isprazni košaricu
shop-btn-checkout = Naplata
shop-btn-edit-quantity = Uredi količinu

# Shop modals
shop-modal-title-edit-cart-qty = Uredi količinu u košarici
shop-modal-label-quantity = Količina
shop-modal-placeholder-quantity = Unesite novu količinu za ovaj predmet
shop-error-invalid-number = Unesite valjani broj.

# Shop views
shop-label-shopkeeper = Trgovac: {"**"}{ $name }{"**"}
shop-label-unknown-item = Nepoznati predmet
shop-label-out-of-stock = NEMA NA ZALIHI
shop-label-stock-available = Zalihe: { $available }
shop-label-in-cart = (U košarici: { $quantity })
shop-title-cart = 🛒 {"**"}Košarica{"**"}
shop-msg-cart-empty = Vaša košarica je prazna.
shop-warning-no-active-character = ⚠️ Aktivan lik nije pronađen. Nije moguće provjeriti sredstva.
shop-warning-insufficient-funds = ⚠️ Nedovoljno sredstava za { $currency }
shop-label-invalid-cost = Neispravna cijena
shop-label-total-cost = {"**"}Ukupna cijena:{"**"}
shop-label-warning = {"**"}Upozorenje:{"**"}
shop-error-no-active-character = Nemate aktivnog lika na ovom poslužitelju.
shop-error-checkout-insufficient = Naplata neuspješna: Nedovoljno { $currency }.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} nema na zalihi.

# Shop report embed
shop-embed-title-report = Izvješće o kupnji
shop-embed-field-purchased = Kupljeno
shop-label-no-items = Nema predmeta
shop-embed-field-total-paid = Ukupno plaćeno

# Purchase options
shop-title-purchase-options = Opcije kupnje: { $itemName }
shop-msg-no-options = Nema dostupnih opcija kupnje za ovaj predmet.

# Shop messages
shop-msg-item-removed = Predmet uklonjen iz košarice.
shop-msg-cart-updated = Košarica ažurirana.

# Restock notifications
shop-restock-more-items = . . . i još { $remaining }.
shop-embed-title-restocked = Trgovina dopunjena!
shop-embed-footer-restocked = { $count } { $count ->
    [one] predmet dopunjen
    [few] predmeta dopunjena
   *[other] predmeta dopunjeno
}
