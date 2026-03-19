## Administrationsmodul-Zeichenketten

# Admin-Cog
admin-embed-title-unauthorized = Nicht autorisierter Server
admin-embed-desc-unauthorized =
    Vielen Dank für Ihr Interesse an ReQuest! Ihr Server befindet sich nicht in der Liste der autorisierten Testserver von ReQuest.
    Bitte treten Sie dem Support-Discord bei und kontaktieren Sie das Entwicklungsteam, um Testzugang anzufordern.

    [ReQuest Development Discord](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Die folgenden Befehle wurden mit { $guildName }, ID { $guildId } synchronisiert
admin-embed-title-sync-global = Die folgenden Befehle wurden global synchronisiert
admin-error-missing-scope = ReQuest hat nicht den korrekten Geltungsbereich im Zielserver. Fügen Sie die Berechtigung `applications.commands` hinzu und versuchen Sie es erneut.
admin-error-sync-failed = Beim Synchronisieren der Befehle ist ein Fehler aufgetreten: { $error }
admin-msg-commands-cleared = Befehle gelöscht.

# Admin-Schaltflächen
admin-btn-shutdown = Herunterfahren
admin-modal-title-confirm-shutdown = Herunterfahren bestätigen
admin-modal-label-shutdown-warning = Warnung! Dies wird den Bot herunterfahren. Geben Sie CONFIRM ein, um fortzufahren.
admin-msg-shutting-down = Wird heruntergefahren!
admin-btn-add-server = Neuen Server hinzufügen
admin-btn-load-cog = Cog laden
admin-msg-extension-loaded = Erweiterung erfolgreich geladen: `{ $module }`
admin-btn-reload-cog = Cog neu laden
admin-msg-extension-reloaded = Erweiterung erfolgreich neu geladen: `{ $module }`
admin-btn-output-guilds = Serverliste ausgeben
admin-msg-connected-guilds = Verbunden mit { $count } Servern:

# Admin-Dialoge
admin-modal-title-add-server = Server-ID zur Erlaubnisliste hinzufügen
admin-modal-label-server-name = Servername
admin-modal-placeholder-server-name = Geben Sie einen Kurznamen für den Discord-Server ein
admin-modal-label-server-id = Server-ID
admin-modal-placeholder-server-id = Geben Sie die ID des Discord-Servers ein
admin-select-placeholder-server = Wählen Sie einen Server zum Entfernen aus
admin-modal-title-cog-action = Cog { $action }
admin-modal-label-cog-name = Name
admin-modal-placeholder-cog-name = Geben Sie den Namen des Cogs ein, um { $action } auszuführen

# Admin-Ansichten
admin-title-main-menu = Administration - Hauptmenü
admin-desc-allowlist = Konfigurieren Sie die Server-Erlaubnisliste für Einladungsbeschränkungen.
admin-desc-cogs = Cogs laden oder neu laden.
admin-desc-guild-list = Gibt eine Liste aller Server zurück, in denen der Bot Mitglied ist.
admin-desc-shutdown = Fährt den Bot herunter
admin-title-allowlist = Administration - Server-Erlaubnisliste
admin-desc-allowlist-warning =
    Fügen Sie eine neue Discord-Server-ID zur Erlaubnisliste hinzu.
    {"**"}WARNUNG: Es gibt keine Möglichkeit zu überprüfen, ob die angegebene Server-ID gültig ist, ohne dass der Bot Servermitglied ist. Überprüfen Sie Ihre Eingaben sorgfältig!{"**"}
admin-msg-no-servers = Keine Server in der Erlaubnisliste.

# Admin-Bestätigungsdialoge
admin-modal-title-confirm-server-removal = Serverentfernung bestätigen
admin-modal-label-server-removal = Server von der Erlaubnisliste entfernen?

# Admin-Cog-Ansicht
admin-title-cogs = Administration - Cogs
admin-desc-load-cog = Laden Sie einen Bot-Cog nach Name. Die Datei muss `<name>.py` heißen und in ReQuest\cogs\ gespeichert sein.
admin-desc-reload-cog = Laden Sie einen geladenen Cog nach Name neu. Dieselben Benennungs- und Dateipfadbeschränkungen gelten.
