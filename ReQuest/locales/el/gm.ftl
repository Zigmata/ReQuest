## Game Master module strings

# GM buttons
gm-btn-create = Δημιουργία
gm-btn-edit-details = Επεξεργασία Quest
gm-btn-toggle-ready = Εναλλαγή Ετοιμότητας
gm-btn-configure-rewards = Ρύθμιση Ανταμοιβών
gm-btn-remove-player = Αφαίρεση Παίκτη
gm-btn-cancel-quest = Ακύρωση Quest
gm-btn-manage-party-rewards = Διαχείριση Ανταμοιβών Ομάδας
gm-btn-manage-individual-rewards = Διαχείριση Ατομικών Ανταμοιβών
gm-btn-join = Συμμετοχή
gm-btn-leave = Αποχώρηση
gm-btn-complete-quest = Ολοκλήρωση Quest
gm-btn-edit-details-modal = Επεξεργασία Λεπτομερειών
gm-btn-edit-images = Επεξεργασία Εικόνων
gm-btn-publish = Δημοσίευση
gm-btn-update-post = Ενημέρωση Δημοσίευσης
gm-select-placeholder-party-role = Επιλέξτε ρόλο ομάδας...
gm-modal-title-edit-details = Επεξεργασία Λεπτομερειών Quest
gm-modal-title-edit-images = Επεξεργασία Εικόνων Quest

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
gm-modal-label-image-url = URL Μικρογραφίας
gm-modal-label-large-image-url = URL Μεγάλης Εικόνας
gm-modal-placeholder-image-url = Εισάγετε URL εικόνας (ή αφήστε κενό για αφαίρεση)
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

# GM errors
gm-error-forbidden-role-name = Το όνομα που δόθηκε για τον ρόλο ομάδας δεν επιτρέπεται.
gm-error-role-already-exists = Ένας ρόλος με αυτό το όνομα υπάρχει ήδη σε αυτόν τον διακομιστή.
gm-error-no-quest-channel = Δεν έχει οριστεί κανάλι για δημοσιεύσεις quest. Επικοινωνήστε με τον διαχειριστή του διακομιστή για να ρυθμίσει το Κανάλι Quest.
gm-error-cannot-ping-announce = Δεν ήταν δυνατή η ειδοποίηση του ρόλου { $role } στο κανάλι { $channel }. Ελέγξτε τα δικαιώματα καναλιού και ρόλου ReQuest με τον/τους διαχειριστή/-ές του διακομιστή σας.
gm-error-invalid-item-format = Μη έγκυρη μορφή αντικειμένου: "{ $item }". Κάθε αντικείμενο πρέπει να είναι σε νέα γραμμή, στη μορφή "Όνομα: Ποσότητα".
gm-error-already-on-quest = Είστε ήδη σε αυτό το quest ως { $characterName }.
gm-error-no-active-character-long = Δεν έχετε ενεργό χαρακτήρα σε αυτόν τον διακομιστή. Χρησιμοποιήστε `/player` για να εγγράψετε ή να ενεργοποιήσετε έναν χαρακτήρα.
gm-error-quest-locked = Σφάλμα συμμετοχής στο quest {"**"}{ $questTitle }{"**"}: Το quest είναι κλειδωμένο από τον GM.
gm-error-quest-full = Σφάλμα συμμετοχής στο quest {"**"}{ $questTitle }{"**"}: Η λίστα ομάδας είναι γεμάτη!
gm-error-not-signed-up = Δεν είστε εγγεγραμμένος σε αυτό το quest.
gm-error-quest-not-found = Η αποστολή δεν υπάρχει πλέον.
gm-error-quest-channel-not-set = Το κανάλι quest δεν έχει οριστεί!
gm-error-empty-roster = Δεν μπορείτε να ολοκληρώσετε ένα quest με άδεια λίστα ομάδας. Δοκιμάστε να το ακυρώσετε.
gm-error-invalid-xp-value = Η τιμή XP πρέπει να είναι θετικός ακέραιος!
gm-error-party-size-positive = Το μέγεθος ομάδας πρέπει να είναι θετικός αριθμός.
gm-error-party-size-too-small = Το μέγεθος ομάδας δεν μπορεί να είναι μικρότερο από την τρέχουσα ομάδα ({ $currentSize } μέλη).
gm-error-role-name-forbidden = Το όνομα ρόλου "{ $roleName }" είναι απαγορευμένο σε αυτόν τον διακομιστή.
gm-error-role-name-exists = Ένας ρόλος με το όνομα "{ $roleName }" υπάρχει ήδη σε αυτόν τον διακομιστή.

# GM confirm modals
gm-modal-title-cancel-quest = Ακύρωση Quest
gm-modal-label-cancel-quest = Πληκτρολογήστε ΕΠΙΒΕΒΑΙΩΣΗ για ακύρωση του quest.
gm-modal-title-remove-from-quest = Αφαίρεση χαρακτήρα από quest
gm-modal-label-remove-from-quest = Επιβεβαίωση αφαίρεσης χαρακτήρα;

# GM DM embeds
gm-dm-title-quest-cancelled = Quest Ακυρώθηκε
gm-dm-desc-quest-cancelled = Το quest {"**"}{ $questTitle }{"**"} ακυρώθηκε από τον GM.
gm-dm-title-quest-ready = Quest Έτοιμο
gm-dm-desc-quest-ready = Το quest {"**"}{ $questTitle }{"**"} είναι τώρα έτοιμο! Ο GM σας θα ξεκινήσει το quest σύντομα.
gm-dm-title-player-removed = Αφαιρέθηκε από το Quest
gm-dm-desc-player-removed = Αφαιρεθήκατε από το quest {"**"}{ $questTitle }{"**"} από τον GM.
gm-dm-desc-player-removed-waitlist = Αφαιρεθήκατε από τη λίστα αναμονής για το {"**"}{ $questTitle }{"**"}.
gm-dm-title-party-promotion = Προαγωγή στην Ομάδα
gm-dm-desc-party-promotion =
    Έχετε προαχθεί στην κύρια ομάδα για το {"**"}{ $questTitle }{"**"}
    λόγω αποχώρησης παίκτη.
gm-dm-title-roster-locked = Λίστα Κλειδωμένη
gm-dm-desc-roster-locked =
    Η λίστα ομάδας για το {"**"}{ $questTitle }{"**"} κλειδώθηκε
    και όλα τα μέλη της ομάδας ειδοποιήθηκαν.
gm-dm-title-roster-unlocked = Λίστα Ξεκλειδωμένη
gm-dm-desc-roster-unlocked = Η λίστα ομάδας για το {"**"}{ $questTitle }{"**"} ξεκλειδώθηκε.
gm-dm-title-player-removed-confirm = Παίκτης Αφαιρέθηκε
gm-dm-desc-player-removed-confirm =
    Ο παίκτης αφαιρέθηκε από το {"**"}{ $questTitle }{"**"}
    και η λίστα ομάδας ενημερώθηκε.
gm-dm-footer-quest = ID Quest: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    Ο διαχειριστής του διακομιστή σας έχει ρυθμίσει ανταμοιβές για τους Game Master
    όταν ολοκληρώνουν quest. Ωστόσο, εφόσον δεν έχετε εγγεγραμμένους χαρακτήρες,
    οι ανταμοιβές σας δεν μπόρεσαν να εκδοθούν αυτόματα αυτή τη στιγμή.
gm-dm-rewards-no-active-character =
    Ο διαχειριστής του διακομιστή σας έχει ρυθμίσει ανταμοιβές για τους Game Master
    όταν ολοκληρώνουν quest. Ωστόσο, εφόσον δεν έχετε ενεργό χαρακτήρα σε αυτόν
    τον διακομιστή, οι ανταμοιβές σας δεν μπόρεσαν να εκδοθούν αυτόματα αυτή τη στιγμή.
gm-dm-rewards-issued = Τα παρακάτω απονεμήθηκαν στον ενεργό χαρακτήρα σας, { $characterName }
gm-dm-role-removal-failed =
    ⚠️ Αποτυχία αφαίρεσης του ρόλου {"**"}{ $roleName }{"**"} από τα ακόλουθα μέλη: { $members }.
    Ενημερώστε τον διαχειριστή του διακομιστή για να αφαιρέσει τον ρόλο χειροκίνητα.
gm-dm-role-not-found =
    ⚠️ Ο ρόλος quest (ID: { $roleId }) για το quest {"**"}{ $questTitle }{"**"} δεν υπάρχει πλέον στον διακομιστή.
    Οι λειτουργίες ρόλων παραλείφθηκαν. Ενημερώστε τον διαχειριστή του διακομιστή αν αυτό είναι απρόσμενο.

# GM select menus
gm-select-placeholder-party-member = Επιλέξτε μέλος ομάδας
gm-modal-label-select-party-role = Ρόλος Ομάδας
gm-modal-desc-select-party-role = Επιλέξτε έναν ρόλο για ανάθεση στην ομάδα του quest.
gm-select-option-no-role = Κανένας (Χωρίς Ρόλο Ομάδας)

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

# GM views
gm-title-main-menu = Game Master - Κύριο Μενού
gm-menu-quests = Quest
gm-menu-desc-quests = Δημιουργία, επεξεργασία και διαχείριση quest.
gm-menu-players = Παίκτες
gm-menu-desc-players = Διαχείριση εξοπλισμού παικτών και τροποποίηση χαρακτήρων.

gm-title-quest-management = Game Master - Διαχείριση Quest
gm-desc-create-quest = Δημιουργία νέου quest.
gm-msg-no-quests = Δεν βρέθηκαν quest.
gm-label-quest-locked = (Κλειδωμένο)
gm-label-quest-draft = (Πρόχειρο)
gm-title-manage-quest = Διαχείριση Quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Επεξεργασία λεπτομερειών quest όπως τίτλος, περιγραφή και μέγεθος ομάδας.
gm-title-edit-quest = Επεξεργασία Quest - { $questTitle }
gm-label-field-not-set = Δεν έχει οριστεί
gm-label-description-not-set = Η περιγραφή δεν έχει οριστεί
gm-label-current-title = {"**"}Τίτλος:{"**"} { $value }
gm-label-current-description = {"**"}Περιγραφή{"**"}
gm-label-current-restrictions = {"**"}Περιορισμοί:{"**"} { $value }
gm-label-current-party-size = {"**"}Μέγιστο Μέγεθος Ομάδας:{"**"} { $value }
gm-label-current-party-role = {"**"}Ρόλος Ομάδας:{"**"} { $value }
gm-label-current-image = {"**"}Μικρογραφία{"**"}
gm-label-current-large-image = {"**"}Εικόνα{"**"}
gm-desc-publish-quest = Δημοσίευση αυτού του quest στον πίνακα quest.
gm-desc-update-quest-post = Ενημέρωση της δημοσίευσης quest στον πίνακα quest.
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

gm-error-role-hierarchy = Το ReQuest δεν μπορεί να διαχειριστεί τον ρόλο "{ $roleName }" (ID: { $roleId }) επειδή βρίσκεται ψηλότερα από τον υψηλότερο ρόλο του ReQuest στην ιεραρχία του διακομιστή. Επικοινωνήστε με τον διαχειριστή του διακομιστή για να μετακινήσει τον ρόλο κάτω από τον ρόλο του ReQuest, ή να αναθέσει στο ReQuest υψηλότερο ρόλο, και δοκιμάστε ξανά.
