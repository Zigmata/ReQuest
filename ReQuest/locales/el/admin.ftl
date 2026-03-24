## Admin module strings

# Admin cog
admin-embed-title-unauthorized = Μη Εξουσιοδοτημένος Διακομιστής
admin-embed-desc-unauthorized =
    Σας ευχαριστούμε για το ενδιαφέρον σας στο ReQuest! Ο διακομιστής σας δεν βρίσκεται στη λίστα εξουσιοδοτημένων διακομιστών δοκιμών του ReQuest.
    Παρακαλούμε εγγραφείτε στο Discord υποστήριξης παρακάτω και επικοινωνήστε με την ομάδα ανάπτυξης για να ζητήσετε πρόσβαση δοκιμής.

    [Discord Ανάπτυξης ReQuest](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Οι παρακάτω εντολές συγχρονίστηκαν στο { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Οι παρακάτω εντολές συγχρονίστηκαν παγκοσμίως
admin-error-missing-scope = Το ReQuest δεν έχει το σωστό scope στον διακομιστή-στόχο. Προσθέστε το δικαίωμα `applications.commands` και δοκιμάστε ξανά.
admin-error-sync-failed = Παρουσιάστηκε σφάλμα κατά τον συγχρονισμό εντολών: { $error }
admin-msg-commands-cleared = Οι εντολές διαγράφηκαν.

# Admin buttons
admin-btn-shutdown = Τερματισμός
admin-modal-title-confirm-shutdown = Επιβεβαίωση Τερματισμού
admin-modal-label-shutdown-warning = Προειδοποίηση! Αυτό θα τερματίσει το bot. Πληκτρολογήστε ΕΠΙΒΕΒΑΙΩΣΗ για να συνεχίσετε.
admin-msg-shutting-down = Γίνεται τερματισμός!
admin-btn-add-server = Προσθήκη Νέου Διακομιστή
admin-btn-load-cog = Φόρτωση Cog
admin-msg-extension-loaded = Η επέκταση φορτώθηκε επιτυχώς: `{ $module }`
admin-btn-reload-cog = Επαναφόρτωση Cog
admin-msg-extension-reloaded = Η επέκταση επαναφορτώθηκε επιτυχώς: `{ $module }`
admin-btn-output-guilds = Εξαγωγή Λίστας Διακομιστών
admin-msg-connected-guilds = Συνδεδεμένο σε { $count } διακομιστές:

# Admin modals
admin-modal-title-add-server = Προσθήκη ID Διακομιστή στη Λίστα Επιτρεπόμενων
admin-modal-label-server-name = Όνομα Διακομιστή
admin-modal-placeholder-server-name = Πληκτρολογήστε ένα σύντομο όνομα για τον Discord Διακομιστή
admin-modal-label-server-id = ID Διακομιστή
admin-modal-placeholder-server-id = Πληκτρολογήστε το ID του Discord Διακομιστή
admin-select-placeholder-server = Επιλέξτε διακομιστή για αφαίρεση
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = Όνομα
admin-modal-placeholder-cog-name = Εισάγετε το όνομα του Cog για { $action }

# Admin views
admin-title-main-menu = Διαχείριση - Κύριο Μενού
admin-desc-allowlist = Ρύθμιση της λίστας επιτρεπόμενων διακομιστών για περιορισμούς πρόσκλησης.
admin-desc-cogs = Φόρτωση ή επαναφόρτωση cogs.
admin-desc-guild-list = Επιστρέφει λίστα όλων των διακομιστών στους οποίους είναι μέλος το bot.
admin-desc-shutdown = Τερματίζει το bot
admin-title-allowlist = Διαχείριση - Λίστα Επιτρεπόμενων Διακομιστών
admin-desc-allowlist-warning =
    Προσθέστε ένα νέο ID Discord Διακομιστή στη λίστα επιτρεπόμενων.
    {"**"}ΠΡΟΕΙΔΟΠΟΙΗΣΗ: Δεν υπάρχει τρόπος επαλήθευσης ότι το ID διακομιστή που δόθηκε είναι έγκυρο χωρίς το bot να είναι μέλος του διακομιστή. Ελέγξτε διπλά τα δεδομένα σας!{"**"}
admin-msg-no-servers = Δεν υπάρχουν διακομιστές στη λίστα επιτρεπόμενων.

# Admin confirm modals
admin-modal-title-confirm-server-removal = Επιβεβαίωση Αφαίρεσης Διακομιστή
admin-modal-label-server-removal = Αφαίρεση διακομιστή από τη λίστα επιτρεπόμενων;

# Admin cog view
admin-title-cogs = Διαχείριση - Cogs
admin-desc-load-cog = Φόρτωση ενός cog του bot με βάση το όνομα. Το αρχείο πρέπει να ονομάζεται `<name>.py` και να βρίσκεται στο ReQuest/cogs/.
admin-desc-reload-cog = Επαναφόρτωση ενός φορτωμένου cog με βάση το όνομα. Ισχύουν οι ίδιοι περιορισμοί ονομασίας και διαδρομής αρχείου.
