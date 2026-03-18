## Shop module strings

# Shop cog
shop-error-no-shops = Tälle palvelimelle ei ole määritetty kauppoja.
shop-error-not-shop-channel =
    Tämä kanava ei ole rekisteröity kauppakanavaksi.
    Jos uskot, että täällä pitäisi olla kauppa, ilmoita asiasta palvelimesi ylläpitäjälle.

# Shop buttons
shop-btn-out-of-stock = Loppuunmyyty
shop-btn-view-options = Näytä ostovaihtoehdot
shop-btn-add-to-cart = Lisää ostoskoriin ({ $cost })
shop-btn-view-cart = Näytä ostoskori
shop-btn-view-cart-count = Näytä ostoskori ({ $count })
shop-btn-back-to-shop = Takaisin kauppaan
shop-btn-clear-cart = Tyhjennä ostoskori
shop-btn-checkout = Kassa
shop-btn-edit-quantity = Muokkaa määrää

# Shop modals
shop-modal-title-edit-cart-qty = Muokkaa ostoskorin määrää
shop-modal-label-quantity = Määrä
shop-modal-placeholder-quantity = Syötä uusi määrä tälle tuotteelle
shop-error-invalid-number = Syötä kelvollinen luku.

# Shop views
shop-label-shopkeeper = Kauppias: {"**"}{ $name }{"**"}
shop-label-unknown-item = Tuntematon tuote
shop-label-out-of-stock = LOPPUUNMYYTY
shop-label-stock-available = Varasto: { $available }
shop-label-in-cart = (Ostoskorissa: { $quantity })
shop-title-cart = 🛒 {"**"}Ostoskori{"**"}
shop-msg-cart-empty = Ostoskorisi on tyhjä.
shop-warning-no-active-character = ⚠️ Aktiivista hahmoa ei löytynyt. Varojen tarkistus ei onnistu.
shop-warning-insufficient-funds = ⚠️ Riittämättömät varat valuutalle { $currency }
shop-label-invalid-cost = Virheellinen hinta
shop-label-total-cost = {"**"}Kokonaishinta:{"**"}
shop-label-warning = {"**"}Varoitus:{"**"}
shop-error-no-active-character = Sinulla ei ole aktiivista hahmoa tällä palvelimella.
shop-error-checkout-insufficient = Maksu epäonnistui: riittämätön { $currency }.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} on loppuunmyyty.

# Shop report embed
shop-embed-title-report = Ostoraportti
shop-embed-field-purchased = Ostettu
shop-label-no-items = Ei tuotteita
shop-embed-field-total-paid = Maksettu yhteensä

# Purchase options
shop-title-purchase-options = Ostovaihtoehdot: { $itemName }
shop-msg-no-options = Tälle tuotteelle ei ole saatavilla ostovaihtoehtoja.

# Shop messages
shop-msg-item-removed = Tuote poistettu ostoskorista.
shop-msg-cart-updated = Ostoskori päivitetty.

# Restock notifications
shop-restock-more-items = . . . ja { $remaining } lisää.
shop-embed-title-restocked = Kauppa täydennetty!
shop-embed-footer-restocked = { $count } { $count ->
    [one] tuote
   *[other] tuotetta
} täydennetty
