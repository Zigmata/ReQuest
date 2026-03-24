## Shop module strings

# Shop cog
shop-error-no-shops = Na tym serwerze nie skonfigurowano żadnych sklepów.
shop-error-not-shop-channel =
    Ten kanał nie jest zarejestrowany jako kanał sklepowy.
    Jeśli uważasz, że powinien tu być sklep, poinformuj administratora serwera.

# Shop buttons
shop-btn-out-of-stock = Brak w magazynie
shop-btn-view-options = Wyświetl opcje zakupu
shop-btn-add-to-cart = Dodaj do koszyka ({ $cost })
shop-btn-view-cart = Wyświetl koszyk
shop-btn-view-cart-count = Wyświetl koszyk ({ $count })
shop-btn-back-to-shop = Powrót do sklepu
shop-btn-clear-cart = Wyczyść koszyk
shop-btn-checkout = Kasa
shop-btn-edit-quantity = Edytuj ilość

# Shop modals
shop-modal-title-edit-cart-qty = Edytuj ilość w koszyku
shop-modal-label-quantity = Ilość
shop-modal-placeholder-quantity = Wpisz nową ilość tego przedmiotu
shop-error-invalid-number = Proszę wpisać prawidłową liczbę.

# Shop views
shop-label-shopkeeper = Sklepikarz: {"**"}{ $name }{"**"}
shop-label-unknown-item = Nieznany przedmiot
shop-label-out-of-stock = BRAK W MAGAZYNIE
shop-label-stock-available = Zapas: { $available }
shop-label-in-cart = (W koszyku: { $quantity })
shop-title-cart = 🛒 {"**"}Koszyk{"**"}
shop-msg-cart-empty = Twój koszyk jest pusty.
shop-warning-no-active-character = ⚠️ Nie znaleziono aktywnej postaci. Nie można zweryfikować środków.
shop-warning-insufficient-funds = ⚠️ Niewystarczające środki na { $currency }
shop-label-invalid-cost = Nieprawidłowy koszt
shop-label-total-cost = {"**"}Łączny koszt:{"**"}
shop-label-warning = {"**"}Ostrzeżenie:{"**"}
shop-error-no-active-character = Nie masz aktywnej postaci na tym serwerze.
shop-error-checkout-insufficient = Płatność nieudana: Niewystarczające środki { $currency }.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} jest niedostępny.

# Shop report embed
shop-embed-title-report = Raport zakupów
shop-embed-field-purchased = Zakupione
shop-label-no-items = Brak przedmiotów
shop-embed-field-total-paid = Zapłacono łącznie

# Purchase options
shop-title-purchase-options = Opcje zakupu: { $itemName }
shop-msg-no-options = Dla tego przedmiotu nie są dostępne żadne opcje zakupu.

# Shop messages
shop-msg-item-removed = Przedmiot usunięty z koszyka.
shop-msg-cart-updated = Koszyk zaktualizowany.

# Restock notifications
shop-restock-more-items = . . . i jeszcze { $remaining }.
shop-embed-title-restocked = Sklep uzupełniony!
shop-embed-footer-restocked = { $count ->
    [one] { $count } przedmiot uzupełniony
    [few] { $count } przedmioty uzupełnione
    [many] { $count } przedmiotów uzupełnionych
   *[other] { $count } przedmiotów uzupełnionych
}
