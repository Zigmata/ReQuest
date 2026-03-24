## Shop-Modul-Zeichenketten

# Shop-Cog
shop-error-no-shops = Für diesen Server sind keine Shops konfiguriert.
shop-error-not-shop-channel =
    Dieser Kanal ist nicht als Shop-Kanal registriert.
    Wenn Sie glauben, dass hier ein Shop sein sollte, informieren Sie Ihren Serveradministrator.

# Shop-Schaltflächen
shop-btn-out-of-stock = Nicht vorrätig
shop-btn-view-options = Kaufoptionen anzeigen
shop-btn-add-to-cart = In den Warenkorb ({ $cost })
shop-btn-view-cart = Warenkorb anzeigen
shop-btn-view-cart-count = Warenkorb anzeigen ({ $count })
shop-btn-back-to-shop = Zurück zum Shop
shop-btn-clear-cart = Warenkorb leeren
shop-btn-checkout = Zur Kasse
shop-btn-edit-quantity = Menge bearbeiten

# Shop-Dialoge
shop-modal-title-edit-cart-qty = Warenkorbmenge bearbeiten
shop-modal-label-quantity = Menge
shop-modal-placeholder-quantity = Geben Sie die neue Menge für diesen Gegenstand ein
shop-error-invalid-number = Bitte geben Sie eine gültige Zahl ein.

# Shop-Ansichten
shop-label-shopkeeper = Shopbesitzer: {"**"}{ $name }{"**"}
shop-label-unknown-item = Unbekannter Gegenstand
shop-label-out-of-stock = NICHT VORRÄTIG
shop-label-stock-available = Bestand: { $available }
shop-label-in-cart = (Im Warenkorb: { $quantity })
shop-title-cart = 🛒 {"**"}Warenkorb{"**"}
shop-msg-cart-empty = Ihr Warenkorb ist leer.
shop-warning-no-active-character = ⚠️ Kein aktiver Charakter gefunden. Guthaben kann nicht überprüft werden.
shop-warning-insufficient-funds = ⚠️ Unzureichendes Guthaben für { $currency }
shop-label-invalid-cost = Ungültige Kosten
shop-label-total-cost = {"**"}Gesamtkosten:{"**"}
shop-label-warning = {"**"}Warnung:{"**"}
shop-error-no-active-character = Sie haben keinen aktiven Charakter auf diesem Server.
shop-error-checkout-insufficient = Kauf fehlgeschlagen: Unzureichend { $currency }.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} ist nicht vorrätig.

# Shop-Berichtseinbettung
shop-embed-title-report = Einkaufsbericht
shop-embed-field-purchased = Gekauft
shop-label-no-items = Keine Gegenstände
shop-embed-field-total-paid = Gesamt bezahlt

# Kaufoptionen
shop-title-purchase-options = Kaufoptionen: { $itemName }
shop-msg-no-options = Für diesen Gegenstand sind keine Kaufoptionen verfügbar.

# Shop-Nachrichten
shop-msg-item-removed = Gegenstand aus dem Warenkorb entfernt.
shop-msg-cart-updated = Warenkorb aktualisiert.

# Nachfüllbenachrichtigungen
shop-restock-more-items = . . . und { $remaining } weitere.
shop-embed-title-restocked = Shop aufgefüllt!
shop-embed-footer-restocked = { $count } { $count ->
    [one] Artikel aufgefüllt
   *[other] Artikel aufgefüllt
}
