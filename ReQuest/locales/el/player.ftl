## Player module strings

# --- Cog ---

player-cmd-name = Ανταλλαγή
player-cmd-desc = Μενού Παίκτη

# --- Buttons ---

# Character management
player-btn-register-character = Εγγραφή Νέου Χαρακτήρα
player-btn-activate = Ενεργοποίηση
player-btn-active = Ενεργός

# Player board
player-btn-create-post = Δημιουργία Δημοσίευσης
player-btn-open-starting-shop = Άνοιγμα Αρχικού Καταστήματος
player-btn-select-kit = Επιλογή Κιτ
player-btn-input-inventory = Εισαγωγή Εξοπλισμού

# Wizard / shop buttons
player-btn-add-to-cart = Προσθήκη στο Καλάθι
player-btn-add-to-cart-cost = Προσθήκη στο Καλάθι ({ $costString })
player-btn-view-purchase-options = Προβολή Επιλογών Αγοράς
player-btn-review-submit = Έλεγχος & Υποβολή ({ $count })
player-btn-submit-character = Υποβολή Χαρακτήρα
player-btn-keep-shopping = Συνέχεια Αγορών
player-btn-edit-quantity = Επεξεργασία Ποσότητας
player-btn-clear-cart = Εκκαθάριση Καλαθιού

# Kit buttons
player-btn-confirm-selection = Επιβεβαίωση Επιλογής
player-btn-back-to-kits = Πίσω στα Κιτ

# Inventory management
player-btn-spend-currency = Δαπάνη Νομίσματος
player-btn-print-inventory = Εκτύπωση Εξοπλισμού

# Container management
player-btn-manage-containers = Διαχείριση Δοχείων
player-btn-create-new = + Δημιουργία Νέου
player-btn-consume-destroy = Κατανάλωση/Καταστροφή
player-btn-move = Μετακίνηση
player-btn-move-all = Μετακίνηση Όλων
player-btn-move-some = Μετακίνηση Μερικών...
player-btn-back-to-overview = ← Πίσω στην Επισκόπηση
player-btn-cancel-move = ← Ακύρωση
player-btn-up = ▲ Πάνω
player-btn-down = ▼ Κάτω

# --- Modals ---

# Trade modal
player-modal-title-trade = Ανταλλαγή με { $targetName }
player-modal-label-trade-name = Όνομα
player-modal-placeholder-trade-name = Εισάγετε το όνομα του αντικειμένου που ανταλλάσσετε
player-modal-label-trade-quantity = Ποσότητα
player-modal-placeholder-trade-quantity = Εισάγετε την ποσότητα που ανταλλάσσετε

# Character register modal
player-modal-title-register = Εγγραφή Νέου Χαρακτήρα
player-modal-label-char-name = Όνομα
player-modal-placeholder-char-name = Εισάγετε το όνομα του χαρακτήρα σας.
player-modal-label-char-note = Σημείωση
player-modal-placeholder-char-note = Εισάγετε μια σημείωση για αναγνώριση του χαρακτήρα σας

# Open inventory input modal
player-modal-title-starting-inventory = Εισαγωγή Αρχικού Εξοπλισμού
player-modal-label-inventory = Εξοπλισμός
player-modal-placeholder-inventory-input =
    Ένα ανά γραμμή σε μορφή <όνομα>: <ποσότητα>, π.χ.:
    Σπαθί: 1
    χρυσός: 30

# Spend currency modal
player-modal-title-spend-currency = Δαπάνη Νομίσματος
player-modal-label-currency-name = Όνομα Νομίσματος
player-modal-placeholder-currency-name = Εισάγετε το όνομα του νομίσματος που ξοδεύετε
player-modal-label-currency-amount = Ποσό
player-modal-placeholder-currency-amount = Εισάγετε το ποσό για δαπάνη

# Create player post modal
player-modal-title-create-post = Δημιουργία Δημοσίευσης Πίνακα Παικτών
player-modal-label-post-title = Τίτλος
player-modal-placeholder-post-title = Εισάγετε τίτλο για τη δημοσίευσή σας
player-modal-label-post-content = Περιεχόμενο Δημοσίευσης
player-modal-placeholder-post-content = Εισάγετε το κείμενο της δημοσίευσής σας

# Edit player post modal
player-modal-title-edit-post = Επεξεργασία Δημοσίευσης Πίνακα Παικτών

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = Επεξεργασία Ποσότητας Καλαθιού
player-modal-label-cart-qty = Ποσότητα
player-modal-placeholder-cart-qty = Εισάγετε νέα ποσότητα (0 για αφαίρεση)

# Create container modal
player-modal-title-create-container = Δημιουργία Νέου Δοχείου
player-modal-label-container-name = Όνομα Δοχείου
player-modal-placeholder-container-name = Εισάγετε όνομα για το δοχείο σας (π.χ., Σακίδιο)

# Rename container modal
player-modal-title-rename-container = Μετονομασία Δοχείου
player-modal-label-new-container-name = Νέο Όνομα Δοχείου
player-modal-placeholder-new-container-name = Εισάγετε το νέο όνομα

# Consume from container modal
player-modal-title-consume = Κατανάλωση/Καταστροφή Αντικειμένου
player-modal-label-consume-qty = Ποσότητα (μέγ.: { $maxQuantity })
player-modal-placeholder-consume-qty = Εισάγετε ποσότητα για κατανάλωση/καταστροφή

# Move item quantity modal
player-modal-title-move-item = Μετακίνηση Αντικειμένου
player-modal-label-move-qty = Ποσότητα μετακίνησης (μέγ.: { $maxQuantity })
player-modal-placeholder-move-qty = Εισάγετε ποσότητα για μετακίνηση

# --- Selects ---

player-select-placeholder-no-characters = Δεν έχετε εγγεγραμμένους χαρακτήρες
player-select-placeholder-remove-character = Επιλέξτε χαρακτήρα για αφαίρεση
player-select-placeholder-post = Επιλέξτε δημοσίευση
player-select-placeholder-container-view = Επιλέξτε δοχείο για προβολή...
player-select-placeholder-item = Επιλέξτε αντικείμενο...
player-select-placeholder-destination = Επιλέξτε προορισμό...
player-select-placeholder-container = Επιλέξτε δοχείο...
player-select-option-no-containers = Χωρίς δοχεία
player-select-option-no-items = Χωρίς αντικείμενα
player-select-option-no-destinations = Χωρίς προορισμούς

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}Εντολές Παίκτη - Κύριο Μενού{"**"}
player-menu-btn-characters = Χαρακτήρες
player-menu-desc-characters = Εγγραφή, προβολή και ενεργοποίηση χαρακτήρων.
player-menu-btn-inventory = Εξοπλισμός
player-menu-desc-inventory = Προβολή εξοπλισμού ενεργού χαρακτήρα και δαπάνη νομίσματος.
player-menu-btn-player-board = Πίνακας Παικτών
player-menu-btn-player-board-disabled = Πίνακας Παικτών (Δεν Έχει Ρυθμιστεί)
player-menu-desc-player-board = Δημιουργία δημοσίευσης για τον Πίνακα Παικτών

# CharacterBaseView
player-title-characters = {"**"}Εντολές Παίκτη - Χαρακτήρες{"**"}
player-desc-register-character = Εγγραφή νέου χαρακτήρα.
player-msg-no-characters = Δεν έχετε εγγεγραμμένους χαρακτήρες.
player-label-active = (Ενεργός)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Χαρακτήρας σε εξέλιξη: { $characterName }{"**"}
    Η εγγραφή του χαρακτήρα σας αναμένει ρύθμιση εξοπλισμού.
player-btn-resume = Συνέχεια
player-btn-discard = Απόρριψη
player-modal-title-discard-character = Απόρριψη χαρακτήρα
player-modal-label-discard-confirm = Απόρριψη { $characterName };

# Confirm character removal
player-modal-title-confirm-char-removal = Επιβεβαίωση Αφαίρεσης Χαρακτήρα
player-modal-label-confirm-char-delete = Διαγραφή { $characterName };

# Confirm post removal
player-modal-title-confirm-post-removal = Επιβεβαίωση Αφαίρεσης Δημοσίευσης
player-modal-label-post-removal-warning = ΠΡΟΣΟΧΗ: Αυτή η ενέργεια είναι μη αναστρέψιμη!

# InventoryOverviewView
player-title-inventory = {"**"}Εντολές Παίκτη - Εξοπλισμός{"**"}
player-title-char-inventory = {"**"}Εξοπλισμός του { $characterName }{"**"}
player-msg-no-active-character = Χωρίς Ενεργό Χαρακτήρα: Ενεργοποιήστε έναν χαρακτήρα για αυτόν τον διακομιστή για να χρησιμοποιήσετε αυτά τα μενού.
player-msg-no-characters-registered = Χωρίς Χαρακτήρες: Εγγράψτε έναν χαρακτήρα για να χρησιμοποιήσετε αυτά τα μενού.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } αντικείμενα
player-label-currency = {"**"}Νόμισμα{"**"}
player-msg-inventory-empty = Ο εξοπλισμός είναι άδειος.

# Print inventory embed
player-embed-title-inventory = Εξοπλισμός του { $characterName }

# ContainerItemsView
player-msg-container-empty = Αυτό το δοχείο είναι άδειο.
player-label-selected-item = Επιλεγμένο: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Μετακίνηση "{ $itemName }"{"**"} ({ $available } διαθέσιμα)
player-msg-no-other-containers = Δεν υπάρχουν άλλα διαθέσιμα δοχεία.
player-msg-select-destination = Επιλέξτε δοχείο προορισμού:
player-label-destination = Προορισμός: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Διαχείριση Δοχείων{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } αντικείμενα){ $suffix }
player-label-default-suffix = { " " }(προεπιλογή)
player-msg-no-containers = Χωρίς δοχεία.
player-label-selected-container = Επιλεγμένο: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = Επιβεβαίωση Διαγραφής Δοχείου
player-modal-label-container-has-items = Περιέχει { $itemCount } αντικείμενα. Θα μεταφερθούν στα Ελεύθερα Αντικείμενα.
player-modal-label-confirm-container-delete = Διαγραφή "{ $containerName }";

# Container errors
player-error-cannot-rename-loose = Δεν είναι δυνατή η μετονομασία των Ελεύθερων Αντικειμένων.
player-error-cannot-delete-loose = Δεν είναι δυνατή η διαγραφή των Ελεύθερων Αντικειμένων.

# PlayerBoardView
player-title-player-board = {"**"}Εντολές Παίκτη - Πίνακας Παικτών{"**"}
player-desc-create-post = Δημιουργία νέας δημοσίευσης για τον Πίνακα Παικτών.
player-msg-no-posts = Δεν έχετε τρέχουσες δημοσιεύσεις.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Συγγραφέας
player-embed-footer-post-id = ID Δημοσίευσης: { $postId }
player-error-board-channel-not-found = Το κανάλι Πίνακα Παικτών δεν βρέθηκε.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Ρύθμιση Εξοπλισμού για { $characterName }{"**"}
player-desc-browse-shop = Περιηγηθείτε στο Αρχικό Κατάστημα για να εξοπλίσετε τον χαρακτήρα σας.
player-desc-select-kit = Επιλέξτε ένα Αρχικό Κιτ.
player-desc-input-inventory = Χειροκίνητη εισαγωγή αρχικού εξοπλισμού.

# StaticKitSelectView
player-title-select-kit = {"**"}Επιλογή Κιτ για { $characterName }{"**"}
player-msg-no-kits = Δεν υπάρχουν διαθέσιμα αρχικά κιτ.
player-label-and-more-items = ...και { $count } ακόμα αντικείμενα
player-label-empty-kit = {"*"}Κενό Κιτ{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Επιβεβαίωση Επιλογής: { $kitName }{"**"}
player-label-items-heading = {"**"}Αντικείμενα:{"**"}
player-label-currency-heading = {"**"}Νόμισμα:{"**"}
player-msg-kit-empty = Αυτό το κιτ είναι κενό.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Επιλογές Αγοράς: { $itemName }{"**"}
player-msg-no-cost-options = Αυτό το αντικείμενο δεν έχει διαθέσιμες επιλογές κόστους.
player-label-cost-option = {"**"}Επιλογή { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Αρχικό Κατάστημα ({ $inventoryType }){"**"}
player-label-starting-wealth = Αρχικός Πλούτος: { $formattedCurrency }
player-label-in-cart = {"**"}(Στο Καλάθι: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Έλεγχος Καλαθιού{"**"}
player-msg-cart-empty = Το καλάθι σας είναι άδειο.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Σύνολο: { $totalQuantity })
player-label-insufficient-currency = Ανεπαρκές { $currencyName }
player-label-total-cost = {"**"}Συνολικό Κόστος:{"**"}
player-label-total-cost-free = {"**"}Συνολικό Κόστος:{"**"} Δωρεάν
player-label-cart-page = Σελίδα { $current } από { $total }

# Trade embed
player-embed-title-trade = Αναφορά Ανταλλαγής
player-embed-desc-trade-sender = Αποστολέας: { $senderMention } ως `{ $senderCharacter }`
player-embed-desc-trade-recipient = Παραλήπτης: { $recipientMention } ως `{ $recipientCharacter }`
player-embed-field-currency = Νόμισμα
player-embed-field-amount = Ποσό
player-embed-field-balance = Υπόλοιπο του { $characterName }
player-embed-field-item = Αντικείμενο
player-embed-field-quantity = Ποσότητα
player-embed-footer-transaction-id = ID Συναλλαγής: { $transactionId }

# Trade errors
player-error-trade-no-characters = Ο παίκτης με τον οποίο προσπαθείτε να ανταλλάξετε δεν έχει χαρακτήρες!
player-error-trade-no-active = Ο παίκτης με τον οποίο προσπαθείτε να ανταλλάξετε δεν έχει ενεργό χαρακτήρα σε αυτόν τον διακομιστή!

# Spend currency embed
player-embed-title-spend = Αναφορά Συναλλαγής Παίκτη
player-embed-desc-spend-player = Παίκτης: { $playerMention } ως `{ $characterName }`
player-embed-desc-spend-transaction = Συναλλαγή: Ο/Η {"**"}{ $characterName }{"**"} ξόδεψε {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Κανάλι
player-embed-field-receipt = Απόδειξη

# Spend currency errors
player-error-amount-not-number = Το ποσό πρέπει να είναι αριθμός.
player-error-amount-positive = Πρέπει να ξοδέψετε θετικό ποσό.
player-error-amount-exceeds-maximum = Το ποσό δεν μπορεί να υπερβαίνει το { $max }.
player-error-no-active-character-server = Δεν έχετε ενεργό χαρακτήρα σε αυτόν τον διακομιστή.
player-error-no-currency-config = Δεν βρέθηκε ρύθμιση νομίσματος για αυτόν τον διακομιστή.

# Consume item embed
player-embed-title-consume = Αναφορά Κατανάλωσης Αντικειμένου
player-embed-desc-consume = Παίκτης: { $playerMention } ως `{ $characterName }`
player-embed-desc-consume-removed = Αφαιρέθηκαν: {"**"}{ $quantity }x { $itemName }{"**"} από {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = Η ποσότητα πρέπει να είναι θετικός ακέραιος.
player-error-qty-at-least-one = Η ποσότητα πρέπει να είναι τουλάχιστον 1.
player-error-qty-only-have = Έχετε μόνο { $maxQuantity } από αυτό το αντικείμενο.

# Inventory input errors
player-error-invalid-format = Μη έγκυρη μορφή: "{ $line }". Χρησιμοποιήστε <όνομα>: <ποσότητα>.
player-error-empty-name = Το όνομα αντικειμένου δεν μπορεί να είναι κενό στη γραμμή: "{ $line }".
player-error-invalid-quantity = Μη έγκυρη ποσότητα για "{ $name }": "{ $quantity }". Πρέπει να είναι θετικός ακέραιος.
player-error-input-errors-header = Σφάλματα στην εισαγωγή εξοπλισμού:
player-msg-no-valid-items = Δεν δόθηκαν έγκυρα αντικείμενα. Αρχικοποίηση με κενό εξοπλισμό.

# Validation error view
player-validation-error-title = Σφάλματα εισαγωγής
player-validation-btn-retry = Δοκιμάστε ξανά

# Cart quantity validation
player-error-enter-valid-number = Παρακαλώ εισάγετε έγκυρο θετικό αριθμό.

# Submission embeds (approval queue)
player-embed-title-approval = Έγκριση Εξοπλισμού: { $characterName }
player-embed-desc-submitted-by = Υποβλήθηκε από { $userMention }
player-embed-field-items = Αντικείμενα
player-embed-field-currency-received = Νόμισμα
player-embed-footer-submission-id = ID Υποβολής: { $submissionId }
player-label-approval-thread = Έγκριση: { $characterName }
player-embed-title-submission-sent = Υποβολή Εξοπλισμού Εστάλη
player-embed-desc-submission-sent =
    Η υποβολή σας για τον {"**"}{ $characterName }{"**"} εστάλη στην ομάδα GM για έγκριση!
    Θα ειδοποιηθείτε μόλις εξεταστεί.
    [Προβολή Νήματος Υποβολής]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = Αρχικός Εξοπλισμός Εφαρμόστηκε
player-embed-desc-starting-inventory = Παίκτης: { $playerMention } ως `{ $characterName }`
player-embed-field-items-received = Αντικείμενα που Λήφθηκαν
player-embed-field-currency-received-label = Νόμισμα που Λήφθηκε
player-label-untitled = Χωρίς Τίτλο

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventory Submission: { $characterName }{"**"}
    Submitted by { $userMention }
player-approval-post-items = Αντικείμενα
player-approval-post-currency = Νόμισμα
player-approval-resolved = Αυτή η υποβολή έχει επιλυθεί.
player-approval-btn-approve = Έγκριση
player-approval-btn-deny = Απόρριψη
player-approval-btn-edit = Επεξεργασία
player-approval-error-no-permission = Δεν έχετε δικαίωμα για αυτή την ενέργεια.
player-approval-error-not-submitter = Μόνο ο αρχικός υποβάλλων μπορεί να επεξεργαστεί αυτή την υποβολή.
player-approval-thread-instructions =
    This thread was created for the approval of {"**"}{ $characterName }{"**"}.
    A Game Master will review the submission and approve or deny it.
    Once approved or denied, this thread will be locked.

    {"**"}Game Masters:{"**"} Discuss any required changes with your
    player until the inventory is in an acceptable state. Only use
    the `Deny` button for irreconcilable submissions.

    { $playerMention }: Use the `Edit` button to make any changes
    requested here by a Game Master.
player-approval-approved-by = Αυτή η υποβολή εγκρίθηκε από { $approver }.
player-approval-denied-by = Αυτή η υποβολή απορρίφθηκε από { $denier }.
player-approval-deny-reason = Αιτία: { $reason }
player-msg-submission-updated = Η υποβολή σας ενημερώθηκε.


# Denial modal
player-modal-title-deny-reason = Απόρριψη υποβολής
player-modal-label-deny-reason = Αιτία απόρριψης
player-modal-placeholder-deny-reason = Προαιρετικό: εξηγήστε γιατί απορρίφθηκε
# Approval DM notifications
player-dm-title-approved = Χαρακτήρας εγκρίθηκε
player-dm-desc-approved =
    Your character {"**"}{ $characterName }{"**"} has been approved
    by { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Χαρακτήρας απορρίφθηκε
player-dm-desc-denied =
    Your character {"**"}{ $characterName }{"**"} has been denied
    by { $denier } in {"**"}{ $guildName }{"**"}.
