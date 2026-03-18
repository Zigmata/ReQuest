## Game Master module strings

# GM buttons
gm-btn-create = Δημιουργία
gm-btn-edit-details = Επεξεργασία Λεπτομερειών
gm-btn-toggle-ready = Εναλλαγή Ετοιμότητας
gm-btn-configure-rewards = Ρύθμιση Ανταμοιβών
gm-btn-remove-player = Αφαίρεση Παίκτη
gm-btn-cancel-quest = Ακύρωση Quest
gm-btn-manage-party-rewards = Διαχείριση Ανταμοιβών Ομάδας
gm-btn-manage-individual-rewards = Διαχείριση Ατομικών Ανταμοιβών
gm-btn-join = Συμμετοχή
gm-btn-leave = Αποχώρηση
gm-btn-complete-quest = Ολοκλήρωση Quest
gm-btn-review-submission = Εξέταση Υποβολής
gm-btn-approve = Έγκριση
gm-btn-deny = Απόρριψη

# GM modals
gm-modal-title-create-quest = Δημιουργία Νέου Quest
gm-modal-label-quest-title = Τίτλος Quest
gm-modal-placeholder-quest-title = Τίτλος του quest σας
gm-modal-label-restrictions = Περιορισμοί
gm-modal-placeholder-restrictions = Περιορισμοί, αν υπάρχουν, όπως επίπεδα παικτών
gm-modal-label-max-party = Μέγιστο Μέγεθος Ομάδας
gm-modal-placeholder-max-party = Μέγιστο μέγεθος ομάδας για αυτό το quest
gm-modal-label-party-role = Ρόλος Ομάδας
gm-modal-placeholder-party-role = Δημιουργία ρόλου για αυτό το quest (Προαιρετικό)
gm-modal-label-description = Περιγραφή
gm-modal-placeholder-description = Γράψτε τις λεπτομέρειες του quest σας εδώ
gm-modal-title-editing-quest = Επεξεργασία { $questTitle }
gm-modal-label-title = Τίτλος
gm-modal-label-max-party-size = Μέγιστο Μέγεθος Ομάδας
gm-modal-title-add-reward = Προσθήκη Ανταμοιβής
gm-modal-label-experience = Πόντοι Εμπειρίας
gm-modal-placeholder-experience = Εισάγετε αριθμό
gm-modal-label-items = Αντικείμενα
gm-modal-placeholder-items =
    αντικείμενο: ποσότητα
    αντικείμενο2: ποσότητα
    κ.λπ.
gm-modal-title-add-summary = Προσθήκη Περίληψης Quest
gm-modal-label-summary = Περίληψη
gm-modal-placeholder-summary = Προσθέστε μια περίληψη της ιστορίας του quest
gm-modal-title-modifying-player = Τροποποίηση { $playerName }
gm-modal-placeholder-xp-add-remove = Εισάγετε θετικό ή αρνητικό αριθμό.
gm-modal-label-inventory = Εξοπλισμός
gm-modal-placeholder-inventory-modify =
    αντικείμενο: ποσότητα
    αντικείμενο2: ποσότητα
    κ.λπ.
gm-modal-title-review-submission = Εξέταση Υποβολής
gm-modal-label-submission-id = ID Υποβολής
gm-modal-placeholder-submission-id = Εισάγετε το 8-ψήφιο ID

# GM errors
gm-error-forbidden-role-name = Το όνομα που δόθηκε για τον ρόλο ομάδας δεν επιτρέπεται.
gm-error-role-already-exists = Ένας ρόλος με αυτό το όνομα υπάρχει ήδη σε αυτόν τον διακομιστή.
gm-error-no-quest-channel = Δεν έχει οριστεί κανάλι για δημοσιεύσεις quest. Επικοινωνήστε με τον διαχειριστή του διακομιστή για να ρυθμίσει το Κανάλι Quest.
gm-error-cannot-ping-announce = Δεν ήταν δυνατή η ειδοποίηση του ρόλου { $role } στο κανάλι { $channel }. Ελέγξτε τα δικαιώματα καναλιού και ρόλου ReQuest με τον/τους διαχειριστή/-ές του διακομιστή σας.
gm-error-invalid-item-format = Μη έγκυρη μορφή αντικειμένου: "{ $item }". Κάθε αντικείμενο πρέπει να είναι σε νέα γραμμή, στη μορφή "Όνομα: Ποσότητα".
gm-error-submission-not-found = Η υποβολή δεν βρέθηκε.
gm-error-already-on-quest = Είστε ήδη σε αυτό το quest ως { $characterName }.
gm-error-no-active-character-long = Δεν έχετε ενεργό χαρακτήρα σε αυτόν τον διακομιστή. Χρησιμοποιήστε `/player` για να εγγράψετε ή να ενεργοποιήσετε έναν χαρακτήρα.
gm-error-quest-locked = Σφάλμα συμμετοχής στο quest {"**"}{ $questTitle }{"**"}: Το quest είναι κλειδωμένο από τον GM.
gm-error-quest-full = Σφάλμα συμμετοχής στο quest {"**"}{ $questTitle }{"**"}: Η λίστα ομάδας είναι γεμάτη!
gm-error-not-signed-up = Δεν είστε εγγεγραμμένος σε αυτό το quest.
gm-error-quest-channel-not-set = Το κανάλι quest δεν έχει οριστεί!
gm-error-empty-roster = Δεν μπορείτε να ολοκληρώσετε ένα quest με άδεια λίστα ομάδας. Δοκιμάστε να το ακυρώσετε.
gm-error-invalid-xp-value = Η τιμή XP πρέπει να είναι θετικός ακέραιος!

# GM confirm modals
gm-modal-title-cancel-quest = Ακύρωση Quest
gm-modal-label-cancel-quest = Πληκτρολογήστε CONFIRM για ακύρωση του quest.
gm-modal-placeholder-cancel-quest = Πληκτρολογήστε "CONFIRM" για να συνεχίσετε.
gm-modal-title-remove-from-quest = Αφαίρεση χαρακτήρα από quest
gm-modal-label-remove-from-quest = Επιβεβαίωση αφαίρεσης χαρακτήρα;
gm-modal-placeholder-remove-from-quest = Πληκτρολογήστε "CONFIRM" για να συνεχίσετε.

# GM DM messages
gm-dm-quest-cancelled = Το quest {"**"}{ $questTitle }{"**"} ακυρώθηκε από τον GM.
gm-dm-quest-ready = Το quest {"**"}{ $questTitle }{"**"} είναι τώρα έτοιμο!
gm-dm-quest-unlocked = Το quest {"**"}{ $questTitle }{"**"} δεν είναι πλέον κλειδωμένο.
gm-dm-quest-locked = Το quest {"**"}{ $questTitle }{"**"} είναι τώρα κλειδωμένο από τον GM.
gm-dm-player-removed = Αφαιρεθήκατε από το quest {"**"}{ $questTitle }{"**"}.
gm-dm-player-removed-waitlist = Αφαιρεθήκατε από τη λίστα αναμονής για το {"**"}{ $questTitle }{"**"}.
gm-dm-party-promotion = Προστεθήκατε στην ομάδα για το {"**"}{ $questTitle }{"**"}, λόγω αποχώρησης παίκτη!
gm-dm-roster-locked = Η λίστα ομάδας κλειδώθηκε και η ομάδα ειδοποιήθηκε!
gm-dm-roster-unlocked = Η λίστα ομάδας ξεκλειδώθηκε.
gm-dm-rewards-no-characters =
    Ο διαχειριστής του διακομιστή σας έχει ρυθμίσει ανταμοιβές για τους Game Master
    όταν ολοκληρώνουν quest. Ωστόσο, εφόσον δεν έχετε εγγεγραμμένους χαρακτήρες,
    οι ανταμοιβές σας δεν μπόρεσαν να εκδοθούν αυτόματα αυτή τη στιγμή.
gm-dm-rewards-no-active-character =
    Ο διαχειριστής του διακομιστή σας έχει ρυθμίσει ανταμοιβές για τους Game Master
    όταν ολοκληρώνουν quest. Ωστόσο, εφόσον δεν έχετε ενεργό χαρακτήρα σε αυτόν
    τον διακομιστή, οι ανταμοιβές σας δεν μπόρεσαν να εκδοθούν αυτόματα αυτή τη στιγμή.
gm-dm-rewards-issued = Τα παρακάτω απονεμήθηκαν στον ενεργό χαρακτήρα σας, { $characterName }

# GM select menus
gm-select-placeholder-party-member = Επιλέξτε μέλος ομάδας

# GM embeds
gm-embed-title-mod-report = Αναφορά Τροποποίησης Παίκτη από GM
gm-embed-field-experience = Εμπειρία
gm-embed-title-quest-complete = Quest Ολοκληρώθηκε: { $questTitle }
gm-embed-title-quest-completed = QUEST ΟΛΟΚΛΗΡΩΘΗΚΕ: { $questTitle }
gm-embed-field-rewards = Ανταμοιβές
gm-embed-field-party = __Ομάδα__
gm-embed-field-summary = Περίληψη
gm-embed-title-gm-rewards = Ανταμοιβές GM Εκδόθηκαν
gm-embed-field-items = Αντικείμενα
gm-msg-player-removed = Ο παίκτης αφαιρέθηκε και η λίστα ομάδας ενημερώθηκε!

# GM views
gm-title-main-menu = Game Master - Κύριο Μενού
gm-menu-quests = Quest
gm-menu-desc-quests = Δημιουργία, επεξεργασία και διαχείριση quest.
gm-menu-players = Παίκτες
gm-menu-desc-players = Διαχείριση εξοπλισμού παικτών και τροποποίηση χαρακτήρων.
gm-menu-approvals = Εγκρίσεις Χαρακτήρων
gm-menu-desc-approvals = Εξέταση και έγκριση/απόρριψη υποβολών χαρακτήρων.

gm-title-quest-management = Game Master - Διαχείριση Quest
gm-desc-create-quest = Δημιουργία νέου quest.
gm-msg-no-quests = Δεν βρέθηκαν quest.
gm-label-quest-locked = (Κλειδωμένο)
gm-title-manage-quest = Διαχείριση Quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Επεξεργασία λεπτομερειών quest όπως τίτλος, περιγραφή και μέγεθος ομάδας.
gm-desc-toggle-ready = Εναλλαγή κατάστασης ετοιμότητας (Τρέχουσα: {"**"}{ $status }{"**"})
    - Κλειδώνει τη λίστα ομάδας του quest και ειδοποιεί τα μέλη ότι το quest θα ξεκινήσει σύντομα. Αν έχει ρυθμιστεί ρόλος, θα ανατεθεί στα μέλη της ομάδας κατά το κλείδωμα.
    - Ξεκλειδώνει τη λίστα όταν ορίζεται σε Ανοιχτό.
gm-label-ready-locked = Κλειδωμένο/Έτοιμο
gm-label-ready-open = Ανοιχτό
gm-desc-configure-rewards = Ρύθμιση ανταμοιβών για το επιλεγμένο quest.
gm-desc-complete-quest = Ολοκλήρωση quest. Εκδίδει ανταμοιβές, αν υπάρχουν, στα μέλη της ομάδας.
gm-desc-remove-player = Αφαίρεση παίκτη από τη λίστα ομάδας και ειδοποίησή του.
gm-desc-cancel-quest = Ακύρωση του quest και διαγραφή του από τον πίνακα quest.
gm-title-player-management = Game Master - Διαχείριση Παικτών
gm-desc-player-management =
    Αυτές οι εντολές έχουν μεταφερθεί σε μενού περιβάλλοντος. Κάντε δεξί κλικ (υπολογιστής) ή παρατεταμένο πάτημα (κινητό) στο προφίλ ενός παίκτη για τις ακόλουθες επιλογές:

    - {"**"}Τροποποίηση Παίκτη{"**"}: Προσθήκη ή αφαίρεση αντικειμένων και εμπειρίας από έναν παίκτη.
    - {"**"}Προβολή Παίκτη{"**"}: Προβολή των λεπτομερειών ενεργού χαρακτήρα ενός παίκτη.
gm-title-remove-player = Αφαίρεση Παίκτη από Quest - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Σημειώσεις Αφαίρεσης Παίκτη{"**"}__

    - Επιλέξτε έναν παίκτη από το αναπτυσσόμενο μενού παρακάτω για να τον αφαιρέσετε από τη λίστα ομάδας.
    - Αν υπάρχουν παίκτες σε λίστα αναμονής, ο πρώτος παίκτης στη λίστα θα προαχθεί στην ομάδα.
    - Οι ατομικές ανταμοιβές του αφαιρεθέντος παίκτη θα διαγραφούν από το quest.
    - Αν θέλετε να ανταμείψετε τον παίκτη για προηγούμενη συνεισφορά, χρησιμοποιήστε το μενού περιβάλλοντος `Τροποποίηση Παίκτη` για να του δώσετε ανταμοιβές απευθείας.
gm-label-no-players-in-roster = Δεν υπάρχουν παίκτες στη λίστα ομάδας
gm-title-character-sheet = Φύλλο Χαρακτήρα για { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Πόντοι Εμπειρίας:{"**"}__
gm-label-possessions = __{"**"}Αντικείμενα{"**"}__
gm-label-currency-heading = {"**"}Νόμισμα{"**"}
gm-msg-inventory-empty = Ο εξοπλισμός είναι άδειος.

# GM approvals
gm-title-approvals = Game Master - Εγκρίσεις Εξοπλισμού
gm-desc-review-submission = Εισάγετε ένα ID Υποβολής για εξέταση και έγκριση/απόρριψη.
gm-title-reviewing = Εξέταση: { $characterName }
gm-label-items = {"**"}Αντικείμενα:{"**"}
gm-label-currency = {"**"}Νόμισμα:{"**"}
gm-embed-title-approved = Ενημέρωση Εξοπλισμού Εγκρίθηκε
gm-embed-desc-approved = Ο εξοπλισμός του {"**"}{ $characterName }{"**"} εγκρίθηκε από τον/την { $approver }.
gm-embed-title-denied = Ενημέρωση Εξοπλισμού Απορρίφθηκε
gm-embed-desc-denied = Ο εξοπλισμός του {"**"}{ $characterName }{"**"} απορρίφθηκε από τον/την { $denier }.
