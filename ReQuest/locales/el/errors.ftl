## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ Ουπς!
error-report-description =
    Παρουσιάστηκε εξαίρεση:

    ```{ $exception }```

    Αν αυτό το σφάλμα είναι απροσδόκητο ή υποψιάζεστε ότι το bot δεν λειτουργεί σωστά, παρακαλούμε υποβάλετε αναφορά σφάλματος στο [Επίσημο Discord Υποστήριξης του ReQuest](https://discord.gg/Zq37gj4).

# Check failures
error-owner-only = Μόνο ο ιδιοκτήτης του bot μπορεί να χρησιμοποιήσει αυτή την εντολή!
error-no-permission = Δεν έχετε δικαιώματα για να εκτελέσετε αυτή την εντολή!
error-no-active-character = Δεν έχετε ενεργό χαρακτήρα σε αυτόν τον διακομιστή!
error-no-registered-characters = Δεν έχετε κανέναν εγγεγραμμένο χαρακτήρα!
error-no-characters = Ο παίκτης-στόχος δεν έχει κανέναν εγγεγραμμένο χαρακτήρα.
error-no-active-character-target = Ο παίκτης-στόχος δεν έχει ενεργοποιημένο χαρακτήρα σε αυτόν τον διακομιστή.
error-player-not-found = Τα δεδομένα παίκτη δεν βρέθηκαν.
error-character-not-found = Τα δεδομένα χαρακτήρα δεν βρέθηκαν.

# Currency/transaction errors
error-transaction-cannot-complete = Η συναλλαγή δεν μπορεί να ολοκληρωθεί:
    { $reason }
error-insufficient-item-trade = Έχετε { $owned }x { $itemName } αλλά προσπαθείτε να δώσετε { $quantity }.
error-currency-process-failed = Το νόμισμα { $currencyName } δεν μπόρεσε να επεξεργαστεί.
error-insufficient-funds-transaction = Ανεπαρκές υπόλοιπο για αυτή τη συναλλαγή.
error-insufficient-funds = Ανεπαρκές υπόλοιπο.
error-insufficient-items = Ανεπαρκή αντικείμενα: { $itemName }
error-currency-not-configured = Το νόμισμα '{ $currencyName }' δεν είναι ρυθμισμένο σε αυτόν τον διακομιστή.
error-cost-currency-system-mismatch = Το νόμισμα κόστους '{ $currencyName }' δεν ανήκει στο δικό του σύστημα νομισμάτων.
error-currency-config-error = Σφάλμα ρύθμισης νομίσματος: τιμή ονομαστικής αξίας 0 ή αρνητική.
error-currency-validation = Παρουσιάστηκε σφάλμα κατά την επικύρωση νομίσματος: { $error }
error-invalid-currency = Το { $itemName } δεν είναι έγκυρο νόμισμα.
error-insufficient-funds-for-transaction = Ανεπαρκές υπόλοιπο για αυτή τη συναλλαγή.

# Cart errors
error-cart-not-found = Το καλάθι δεν βρέθηκε.
error-item-not-in-cart = Το αντικείμενο δεν βρίσκεται στο καλάθι.
error-not-enough-stock = Δεν υπάρχει αρκετό απόθεμα.

# Container errors
error-container-not-found = Το δοχείο δεν βρέθηκε.
error-container-name-empty = Το όνομα δοχείου δεν μπορεί να είναι κενό.
error-container-name-too-long = Το όνομα δοχείου δεν μπορεί να υπερβαίνει τους { $maxLength } χαρακτήρες.
error-max-containers-reached = Δεν μπορείτε να δημιουργήσετε περισσότερα από { $maxContainers } δοχεία.
error-container-name-exists = Ένα δοχείο με το όνομα "{ $containerName }" υπάρχει ήδη.
error-item-already-in-container = Το αντικείμενο βρίσκεται ήδη σε αυτό το δοχείο.
error-quantity-minimum = Η ποσότητα πρέπει να είναι τουλάχιστον 1.
error-source-container-not-found = Το δοχείο προέλευσης δεν βρέθηκε.
error-item-not-in-source = Το αντικείμενο "{ $itemName }" δεν βρέθηκε στο δοχείο προέλευσης.
error-insufficient-quantity-in-container = Ανεπαρκής ποσότητα. Έχετε { $available } σε αυτό το δοχείο.
error-dest-container-not-found = Το δοχείο προορισμού δεν βρέθηκε.
error-item-not-in-container = Το αντικείμενο "{ $itemName }" δεν βρέθηκε σε αυτό το δοχείο.
error-insufficient-quantity-consume = Έχετε μόνο { $available } από αυτό το αντικείμενο σε αυτό το δοχείο.
