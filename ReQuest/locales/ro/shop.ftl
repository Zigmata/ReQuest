## Shop module strings

# Shop cog
shop-error-no-shops = Niciun magazin nu este configurat pentru acest server.
shop-error-not-shop-channel =
    Acest canal nu este înregistrat ca un canal de magazin.
    Dacă credeți că ar trebui să fie un magazin aici, anunțați administratorul serverului.

# Shop buttons
shop-btn-out-of-stock = Stoc epuizat
shop-btn-view-options = Vezi opțiunile de cumpărare
shop-btn-add-to-cart = Adaugă în coș ({ $cost })
shop-btn-view-cart = Vezi coșul
shop-btn-view-cart-count = Vezi coșul ({ $count })
shop-btn-back-to-shop = Înapoi la magazin
shop-btn-clear-cart = Golește coșul
shop-btn-checkout = Finalizează comanda
shop-btn-edit-quantity = Editează cantitatea

# Shop modals
shop-modal-title-edit-cart-qty = Editează cantitatea din coș
shop-modal-label-quantity = Cantitate
shop-modal-placeholder-quantity = Introduceți noua cantitate pentru acest obiect
shop-error-invalid-number = Vă rugăm să introduceți un număr valid.

# Shop views
shop-label-shopkeeper = Vânzător: {"**"}{ $name }{"**"}
shop-label-unknown-item = Obiect necunoscut
shop-label-out-of-stock = STOC EPUIZAT
shop-label-stock-available = Stoc: { $available }
shop-label-in-cart = (În coș: { $quantity })
shop-title-cart = 🛒 {"**"}Coș de cumpărături{"**"}
shop-msg-cart-empty = Coșul dumneavoastră este gol.
shop-warning-no-active-character = ⚠️ Niciun personaj activ găsit. Nu se pot verifica fondurile.
shop-warning-insufficient-funds = ⚠️ Fonduri insuficiente pentru { $currency }
shop-label-invalid-cost = Cost invalid
shop-label-total-cost = {"**"}Cost total:{"**"}
shop-label-warning = {"**"}Atenție:{"**"}
shop-error-no-active-character = Nu aveți un personaj activ pe acest server.
shop-error-checkout-insufficient = Finalizare eșuată: { $currency } insuficient.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} nu mai este în stoc.

# Shop report embed
shop-embed-title-report = Raport cumpărături
shop-embed-field-purchased = Cumpărat
shop-label-no-items = Niciun obiect
shop-embed-field-total-paid = Total plătit

# Purchase options
shop-title-purchase-options = Opțiuni de cumpărare: { $itemName }
shop-msg-no-options = Nu există opțiuni de cumpărare disponibile pentru acest obiect.

# Shop messages
shop-msg-item-removed = Obiect eliminat din coș.
shop-msg-cart-updated = Coșul a fost actualizat.

# Restock notifications
shop-restock-more-items = . . . și încă { $remaining }.
shop-embed-title-restocked = Magazin reaprovizionat!
shop-embed-footer-restocked = { $count } { $count ->
    [one] obiect
    [few] obiecte
   *[other] obiecte
} reaprovizionat{ $count ->
    [one] {""}
   *[other] e
}
