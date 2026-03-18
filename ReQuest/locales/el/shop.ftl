## Shop module strings

# Shop cog
shop-error-no-shops = Δεν υπάρχουν ρυθμισμένα καταστήματα για αυτόν τον διακομιστή.
shop-error-not-shop-channel =
    Αυτό το κανάλι δεν είναι εγγεγραμμένο ως κανάλι καταστήματος.
    Αν πιστεύετε ότι θα έπρεπε να υπάρχει κατάστημα εδώ, ενημερώστε τον διαχειριστή του διακομιστή σας.

# Shop buttons
shop-btn-out-of-stock = Εξαντλημένο
shop-btn-view-options = Προβολή Επιλογών Αγοράς
shop-btn-add-to-cart = Προσθήκη στο Καλάθι ({ $cost })
shop-btn-view-cart = Προβολή Καλαθιού
shop-btn-view-cart-count = Προβολή Καλαθιού ({ $count })
shop-btn-back-to-shop = Πίσω στο Κατάστημα
shop-btn-clear-cart = Εκκαθάριση Καλαθιού
shop-btn-checkout = Ολοκλήρωση Αγοράς
shop-btn-edit-quantity = Επεξεργασία Ποσότητας

# Shop modals
shop-modal-title-edit-cart-qty = Επεξεργασία Ποσότητας Καλαθιού
shop-modal-label-quantity = Ποσότητα
shop-modal-placeholder-quantity = Εισάγετε τη νέα ποσότητα για αυτό το αντικείμενο
shop-error-invalid-number = Παρακαλώ εισάγετε έγκυρο αριθμό.

# Shop views
shop-label-shopkeeper = Καταστηματάρχης: {"**"}{ $name }{"**"}
shop-label-unknown-item = Άγνωστο Αντικείμενο
shop-label-out-of-stock = ΕΞΑΝΤΛΗΜΕΝΟ
shop-label-stock-available = Απόθεμα: { $available }
shop-label-in-cart = (Στο Καλάθι: { $quantity })
shop-title-cart = 🛒 {"**"}Καλάθι Αγορών{"**"}
shop-msg-cart-empty = Το καλάθι σας είναι άδειο.
shop-warning-no-active-character = ⚠️ Δεν βρέθηκε ενεργός χαρακτήρας. Αδυναμία επαλήθευσης κεφαλαίων.
shop-warning-insufficient-funds = ⚠️ Ανεπαρκή κεφάλαια για { $currency }
shop-label-invalid-cost = Μη Έγκυρο Κόστος
shop-label-total-cost = {"**"}Συνολικό Κόστος:{"**"}
shop-label-warning = {"**"}Προειδοποίηση:{"**"}
shop-error-no-active-character = Δεν έχετε ενεργό χαρακτήρα σε αυτόν τον διακομιστή.
shop-error-checkout-insufficient = Η αγορά απέτυχε: Ανεπαρκές { $currency }.
shop-error-item-out-of-stock = Το {"**"}{ $itemName }{"**"} έχει εξαντληθεί.

# Shop report embed
shop-embed-title-report = Αναφορά Αγορών
shop-embed-field-purchased = Αγοράστηκαν
shop-label-no-items = Χωρίς Αντικείμενα
shop-embed-field-total-paid = Σύνολο Πληρωμής

# Purchase options
shop-title-purchase-options = Επιλογές Αγοράς: { $itemName }
shop-msg-no-options = Δεν υπάρχουν διαθέσιμες επιλογές αγοράς για αυτό το αντικείμενο.

# Shop messages
shop-msg-item-removed = Το αντικείμενο αφαιρέθηκε από το καλάθι.
shop-msg-cart-updated = Το καλάθι ενημερώθηκε.

# Restock notifications
shop-restock-more-items = . . . και { $remaining } ακόμα.
shop-embed-title-restocked = Το Κατάστημα Ανανεώθηκε!
shop-embed-footer-restocked = { $count } { $count ->
    [one] αντικείμενο
   *[other] αντικείμενα
} ανανεώθηκε
