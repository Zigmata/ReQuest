## Konfigurationsmodul-Zeichenketten

# ==========================================
# SCHALTFLÄCHEN
# ==========================================

# Rollen
config-btn-clear = Leeren
config-btn-remove-gm-roles = GM-Rollen entfernen
config-btn-forbidden-roles = Verbotene Rollen

# Quests
config-btn-toggle-quest-summary = Quest-Zusammenfassung umschalten
config-btn-toggle-player-experience = Spielererfahrung umschalten
config-btn-toggle-display = Anzeige umschalten
config-btn-purge-player-board = Spielertafel bereinigen
config-btn-add-modify-rewards = Belohnungen hinzufügen/ändern

# Währung
config-btn-add-denomination = Stückelung hinzufügen
config-btn-add-new-currency = Neue Währung hinzufügen
config-btn-remove-currency = Währung entfernen

# Shops - Erstellung
config-btn-add-shop-wizard = Shop hinzufügen (Assistent)
config-btn-add-shop-json = Shop hinzufügen (JSON)
config-btn-edit-shop-wizard = Shop bearbeiten (Assistent)
config-btn-edit-shop-json = Shop bearbeiten (JSON)
config-btn-remove-shop = Shop entfernen
config-btn-add-item = Gegenstand hinzufügen
config-btn-edit-shop-details = Shopdetails bearbeiten
config-btn-download-json = JSON herunterladen
config-btn-done-editing = Bearbeitung abschließen
config-btn-scan-server-configs = Serverkonfigurationen prüfen
config-btn-re-scan = Erneut prüfen

# Neuer-Charakter-Shop
config-btn-upload-json = JSON hochladen
config-btn-configure-new-character-wealth = Neues Charaktervermögen konfigurieren
config-btn-configure-new-character-shop = Neuen-Charakter-Shop konfigurieren
config-btn-clear-shop = Laden leeren
config-btn-configure-static-kits = Statische Ausrüstungssets konfigurieren
config-btn-new-character-settings = Neuer-Charakter-Einstellungen
config-btn-disabled-no-currency = Deaktiviert (Keine Währung konfiguriert)
config-btn-disabled-no-wealth = Deaktiviert (Kein Startvermögen konfiguriert)

# Statische Ausrüstungssets
config-btn-create-new-kit = Neues Set erstellen
config-btn-delete-kit = Set löschen
config-btn-add-currency = Währung hinzufügen

# Rollenspiel
config-btn-toggle-rp-rewards = RP-Belohnungen umschalten
config-btn-clear-channels = Kanäle leeren
config-btn-edit-settings = Einstellungen bearbeiten
config-btn-configure-rewards = Belohnungen konfigurieren

# Bestand
config-btn-stock-limits = Bestandsgrenzen
config-btn-set-limit = Grenze setzen
config-btn-edit-limit = Grenze bearbeiten
config-btn-remove-limit = Grenze entfernen
config-btn-configure-restock-schedule = Nachfüllzeitplan konfigurieren
config-btn-back-to-shop-editor = Zurück zum Shop-Editor

# Forum-Shop
config-btn-create-new-thread = Neuen Thread erstellen
config-btn-use-existing-thread = Vorhandenen Thread verwenden

# Assistent
config-btn-quit = Beenden
config-btn-configure-channels = Kanäle konfigurieren
config-btn-configure-roles = Rollen konfigurieren
config-btn-configure-quests = Quests konfigurieren
config-btn-configure-players = Spieler konfigurieren
config-btn-configure-currency = Währung konfigurieren
config-btn-configure-rp-rewards = RP-Belohnungen konfigurieren
config-btn-configure-shops = Shops konfigurieren
config-btn-new-char-setup = Neuer-Charakter-Setup

# Bestätigungsdialog-Titel (an gemeinsamen ConfirmModal übergeben)
config-modal-title-confirm-role-removal = Rollenentfernung bestätigen
config-modal-title-confirm-removal = Entfernung bestätigen
config-modal-title-confirm-currency-removal = Währungsentfernung bestätigen
config-modal-title-confirm-shop-removal = Shopentfernung bestätigen
config-modal-title-confirm-kit-deletion = Set-Löschung bestätigen
config-modal-title-confirm-remove-stock-limit = Bestandsgrenze entfernen bestätigen
config-modal-title-clear-shop = Laden leeren bestätigen

# Bestätigungsdialog-Bezeichnungen
config-modal-label-remove-role = { $roleName } entfernen?
config-modal-label-remove-denomination = { $denominationName } entfernen?
config-modal-label-remove-currency = { $currencyName } entfernen?
config-modal-label-shop-removal-warning = WARNUNG: Diese Aktion ist unwiderruflich!
config-modal-label-kit-deletion-warning = WARNUNG: Unwiderruflich!
config-modal-label-remove-stock-limit = Geben Sie BESTÄTIGEN ein, um die Bestandsgrenze zu entfernen
config-modal-label-clear-shop = Alle Artikel aus diesem Laden entfernen?

# Fehlermeldungen von Schaltflächen
config-error-shop-data-not-found = Fehler: Shopdaten konnten nicht gefunden werden.
config-msg-shop-json-download = Hier ist die JSON-Definition für {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Hier ist die JSON-Definition für den Neuen-Charakter-Shop.
config-error-select-forum-first = Bitte wählen Sie zuerst einen Forumskanal aus.
config-error-select-thread-first = Bitte wählen Sie zuerst einen Thread aus.

# ==========================================
# DIALOGE
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Neue Währung hinzufügen
config-modal-label-currency-name = Währungsname
config-error-currency-already-exists = Eine Währung oder Stückelung mit dem Namen { $name } existiert bereits!

# RenameCurrencyModal
config-modal-title-rename-currency = Währung umbenennen
config-modal-label-new-currency-name = Neuer Währungsname
config-error-currency-name-exists = Eine Währung mit dem Namen "{ $name }" existiert bereits.
config-error-denomination-name-exists = Eine Stückelung mit dem Namen "{ $name }" existiert bereits.

# RenameDenominationModal
config-modal-title-rename-denomination = Stückelung umbenennen
config-modal-label-new-denomination-name = Neuer Stückelungsname

# AddCurrencyDenominationModal
config-modal-title-add-denomination = { $currencyName }-Stückelung hinzufügen
config-modal-label-denomination-name = Name
config-modal-placeholder-denomination-name = z.B. Silber
config-modal-label-denomination-value = Wert
config-modal-placeholder-denomination-value = z.B. 0,1
config-error-denomination-matches-currency = Der Name der neuen Stückelung darf nicht mit einer bestehenden Währung auf diesem Server übereinstimmen! Bestehende Währung mit dem Namen "{ $existingName }" gefunden.
config-error-denomination-matches-denomination = Der Name der neuen Stückelung darf nicht mit einer bestehenden Stückelung auf diesem Server übereinstimmen! Bestehende Stückelung mit dem Namen "{ $denominationName }" unter der Währung "{ $currencyName }" gefunden.
config-error-denomination-value-exists = Stückelungen innerhalb einer Währung müssen eindeutige Werte haben! { $denominationName } hat diesen Wert bereits zugewiesen.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Verbotene Rollennamen
config-modal-label-names = Namen
config-modal-placeholder-names = Namen durch Kommas getrennt eingeben
config-msg-forbidden-roles-updated = Verbotene Rollen aktualisiert!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Spielertafel bereinigen
config-modal-label-age = Alter
config-modal-placeholder-age = Geben Sie das maximale Beitragsalter (in Tagen) ein, das beibehalten werden soll
config-msg-posts-purged = Beiträge, die älter als { $days } Tage sind, wurden bereinigt!

# GMRewardsModal
config-modal-title-gm-rewards = GM-Belohnungen hinzufügen/ändern
config-modal-label-experience = Erfahrung
config-modal-placeholder-enter-number = Geben Sie eine Zahl ein
config-modal-label-items = Gegenstände
config-modal-placeholder-items =
    Name: Menge
    Name2: Menge
    usw.
config-error-experience-invalid = Erfahrung muss eine gültige Ganzzahl sein (z.B. 2000).
config-error-item-format-invalid = Ungültiges Gegenstandsformat: "{ $item }". Jeder Gegenstand muss in einer neuen Zeile stehen und das Format "Name: Menge" haben.

# ConfigShopDetailsModal
config-modal-title-shop-details = Shopdetails hinzufügen/bearbeiten
config-modal-label-shop-channel = Kanal auswählen
config-modal-placeholder-shop-channel = Wählen Sie den Kanal für diesen Shop aus
config-modal-label-shop-name = Shopname
config-modal-placeholder-shop-name = Geben Sie den Namen des Shops ein
config-modal-label-shopkeeper-name = Name des Shopbesitzers
config-modal-placeholder-shopkeeper-name = Geben Sie den Namen des Shopbesitzers ein
config-modal-label-shop-description = Shopbeschreibung
config-modal-placeholder-shop-description = Geben Sie eine Beschreibung für den Shop ein
config-modal-label-shop-image-url = Shop-Bild-URL
config-modal-placeholder-shop-image-url = Geben Sie eine URL für das Shopbild ein
config-error-no-channel-selected = Kein Kanal für den Shop ausgewählt.
config-error-shop-already-in-channel = Im ausgewählten Kanal ist bereits ein Shop registriert. Bitte wählen Sie einen anderen Kanal oder bearbeiten Sie den bestehenden Shop.

# build_shop_header_view
config-label-shopkeeper = {"**"}Shopbesitzer:{"**"} { $name }
config-msg-use-shop-command = Verwenden Sie den Befehl `/shop`, um Gegenstände zu durchsuchen und zu kaufen.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Forum-Thread-Shop erstellen
config-modal-label-thread-name = Threadname
config-modal-placeholder-thread-name = Geben Sie den Namen für den Shop-Thread ein
config-error-forum-not-found = Der ausgewählte Forumskanal konnte nicht gefunden werden.
config-error-shop-already-in-thread = In diesem Thread ist bereits ein Shop registriert. Dies sollte bei einem neuen Thread nicht vorkommen.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Neuen Shop via JSON hinzufügen
config-modal-label-upload-json = Laden Sie eine .json-Datei mit den Shopdaten hoch
config-error-no-json-uploaded = Keine JSON-Datei für den Shop hochgeladen.
config-error-file-must-be-json = Die hochgeladene Datei muss eine JSON-Datei (.json) sein.
config-error-invalid-json = Ungültiges JSON-Format: { $error }
config-error-json-validation-failed = JSON entspricht nicht dem Schema: { $error }

# ShopItemModal
config-modal-title-shop-item = Shopgegenstand hinzufügen/bearbeiten
config-modal-label-item-name = Gegenstandsname
config-modal-placeholder-item-name = Geben Sie den Namen des Gegenstands ein
config-modal-label-item-description = Gegenstandsbeschreibung
config-modal-placeholder-item-description = Geben Sie eine Beschreibung für den Gegenstand ein
config-modal-label-item-quantity = Gegenstandsmenge
config-modal-placeholder-item-quantity = Geben Sie die verkaufte Menge pro Kauf ein
config-modal-label-item-costs = Gegenstandskosten
config-modal-placeholder-item-costs = Z.B.: 10 Gold + 5 Silber\nODER: 50 Ruf\n(+ für UND, Neue Zeilen für ODER)
config-error-item-quantity-positive = Die Gegenstandsmenge muss eine positive Ganzzahl sein.
config-error-cost-format-invalid = Ungültiges Kostenformat in Option: "{ $option }". Jede Kostenangabe muss einen Betrag und eine Währung durch ein Leerzeichen getrennt enthalten, z.B. "10 Gold".
config-error-cost-amount-invalid = Ungültiger Betrag "{ $amount }" für Währung: "{ $currency }". Der Betrag muss eine positive Zahl sein.
config-error-unknown-currency = Unbekannte Währung `{ $currency }`. Bitte verwenden Sie eine gültige, für diesen Server konfigurierte Währung.
config-error-item-already-exists = Ein Gegenstand mit dem Namen { $itemName } existiert bereits in diesem Shop.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Shop via JSON aktualisieren
config-modal-label-upload-new-json = Neue JSON-Definition hochladen
config-error-no-file-uploaded = Keine Datei hochgeladen.
config-error-file-must-be-json-ext = Die Datei muss eine `.json`-Datei sein.
config-error-json-validation-message = JSON-Validierung fehlgeschlagen: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Neuer-Charakter-Ausrüstung hinzufügen/bearbeiten
config-modal-placeholder-item-quantity-selection = Geben Sie die erhaltene Menge pro Auswahl ein
config-modal-label-item-cost = Gegenstandskosten
config-error-cost-format-short = Ungültiges Kostenformat: '{ $component }'. Erwartet: 'Betrag Währung'.
config-error-amount-invalid-short = Ungültiger Betrag '{ $amount }' für Währung '{ $currency }'.
config-error-item-exists-new-char = Ein Gegenstand mit dem Namen { $itemName } existiert bereits im Neuen-Charakter-Shop.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Neuen-Charakter-Shop hochladen (JSON)
config-error-no-json-uploaded-short = Keine JSON-Datei hochgeladen.
config-error-json-must-have-shopstock = JSON muss ein 'shopStock'-Array enthalten.
config-error-items-must-have-name-price = Alle Gegenstände müssen 'name' und 'price' haben.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Neues Charaktervermögen festlegen
config-modal-label-amount = Betrag
config-modal-placeholder-amount = Geben Sie den Betrag dieser Währung ein.
config-modal-placeholder-currency-name = Geben Sie den Namen einer auf diesem Server definierten Währung ein
config-error-no-currencies-configured = Auf diesem Server sind keine Währungen konfiguriert.
config-error-currency-not-found = Währung oder Stückelung mit dem Namen { $name } nicht gefunden. Bitte verwenden Sie eine gültige Währung.

# CreateStaticKitModal
config-modal-title-create-kit = Neues statisches Set erstellen
config-modal-label-kit-name = Set-Name
config-modal-placeholder-kit-name = z.B. Krieger-Starterpaket
config-modal-label-description = Beschreibung
config-modal-placeholder-kit-description = Optionale Beschreibung für dieses Set
config-error-kit-name-exists = Ein statisches Set mit dem Namen "{ $kitName }" existiert bereits. Bitte wählen Sie einen anderen Namen.

# StaticKitItemModal
config-modal-title-kit-item = Set-Gegenstand hinzufügen/bearbeiten
config-modal-placeholder-kit-item-quantity = Geben Sie die Menge dieses Gegenstands ein, die im Set enthalten sein soll

# StaticKitCurrencyModal
config-modal-title-kit-currency = Set-Währung hinzufügen
config-modal-placeholder-currency-eg = z.B. Gold
config-modal-placeholder-amount-eg = z.B. 100
config-error-amount-must-be-number = Der Betrag muss eine Zahl sein.
config-error-no-currencies-on-server = Keine Währungen auf dem Server konfiguriert.
config-error-currency-not-found-short = Währung "{ $currency }" nicht gefunden.
config-error-denomination-not-found = Stückelung "{ $denomination }" in der Währungskonfiguration nicht gefunden.

# RoleplaySettingsModal
config-modal-title-rp-settings = Rollenspiel-Einstellungen
config-modal-label-min-message-length = Mindestlänge der Nachricht (Zeichen)
config-modal-placeholder-min-message-length = Anzahl der Zeichen, die eine Nachricht haben muss, um berechtigt zu sein. 0 für kein Limit
config-modal-label-cooldown = Abklingzeit (Sekunden)
config-modal-placeholder-cooldown = Wartezeit in Sekunden zwischen der Zählung von Nachrichten als belohnungsberechtigt
config-modal-label-message-threshold = Nachrichtenschwelle
config-modal-placeholder-message-threshold = Anzahl der Nachrichten, die erforderlich sind, um eine Belohnung auszulösen
config-modal-label-frequency = Häufigkeit (Anzahl Nachrichten)
config-modal-placeholder-frequency = Anzahl berechtigter Nachrichten, die erforderlich sind, um Belohnungen zu erhalten
config-error-min-length-invalid = Die Mindestlänge der Nachricht muss eine nicht-negative Ganzzahl sein.
config-error-cooldown-invalid = Die Abklingzeit muss eine nicht-negative Ganzzahl sein.
config-error-threshold-invalid = Die Nachrichtenschwelle muss eine positive Ganzzahl sein.
config-error-frequency-invalid = Die Häufigkeit muss eine positive Ganzzahl sein.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Rollenspiel-Belohnungen konfigurieren
config-modal-label-items-name-quantity = Gegenstände (Name: Menge)
config-modal-label-currency-name-amount = Währung (Name: Betrag)
config-error-experience-non-negative = Erfahrung muss eine nicht-negative Ganzzahl sein.
config-error-item-quantity-positive-named = Die Menge für "{ $itemName }" muss eine positive Ganzzahl sein.
config-error-currency-amount-positive = Der Währungsbetrag für "{ $currencyName }" muss eine positive Zahl sein.

# SetItemStockModal
config-modal-title-stock-limit = Bestandsgrenze: { $itemName }
config-modal-label-max-stock = Maximaler Bestand
config-modal-placeholder-max-stock = Geben Sie den maximalen Bestand ein (z.B. 10)
config-modal-label-current-stock = Aktueller Bestand
config-modal-placeholder-current-stock = Geben Sie den aktuell verfügbaren Bestand ein
config-modal-label-restock-increment = Nachfüllmenge (pro Zyklus)
config-modal-placeholder-restock-increment = Menge pro Nachfüllzyklus (Standard: 1)
config-error-max-stock-positive = Der maximale Bestand muss eine positive Ganzzahl sein.
config-error-current-stock-non-negative = Der aktuelle Bestand muss eine nicht-negative Ganzzahl sein.
config-error-current-exceeds-max = Der aktuelle Bestand darf den maximalen Bestand nicht überschreiten.
config-error-item-not-in-shop = Gegenstand "{ $itemName }" im Shop nicht gefunden.

# RestockScheduleModal
config-modal-title-restock-schedule = Nachfüllzeitplan konfigurieren
config-modal-restock-schedule-label = Zeitplan
config-modal-restock-schedule-none = Keiner (Deaktiviert)
config-modal-restock-schedule-hourly = Stündlich
config-modal-restock-schedule-daily = Täglich
config-modal-restock-schedule-weekly = Wöchentlich
config-modal-label-time = Uhrzeit (HH:MM in UTC)
config-modal-desc-current-time = Aktuelle Uhrzeit: { $utcTime }
config-modal-placeholder-time = z.B. 14:30 für 14:30 Uhr UTC
config-modal-restock-day-label = Wochentag (nur wöchentlich)
config-modal-restock-mode-label = Nachfüllmodus
config-modal-restock-mode-full = Vollständig (auf Maximum zurücksetzen)
config-modal-restock-mode-incremental = Schrittweise (Menge hinzufügen)
config-error-time-format-invalid = Die Uhrzeit muss im Format HH:MM angegeben werden (z.B. 14:30).
config-error-increment-positive = Die Nachfüllmenge muss eine positive Ganzzahl sein.

# ==========================================
# AUSWAHLMENÜS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Suchen Sie Ihren { $configName }-Kanal

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Wählen Sie Ihre Quest-Ankündigungsrolle

# AddGMRoleSelect
config-select-placeholder-gm-roles = Wählen Sie Ihre GM-Rolle(n)

# ConfigWaitListSelect
config-select-placeholder-wait-list = Wartelistengröße auswählen
config-select-option-disabled = 0 (Deaktiviert)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Inventarmodus auswählen
config-select-option-disabled-label = Deaktiviert
config-select-desc-disabled = Spieler starten mit leerem Inventar.
config-select-option-selection = Auswahl
config-select-desc-selection = Spieler wählen Gegenstände frei aus dem Neuen-Charakter-Shop.
config-select-option-purchase = Kauf
config-select-desc-purchase = Spieler kaufen Gegenstände aus dem Neuen-Charakter-Shop mit einem vorgegebenen Währungsbetrag.
config-select-option-open = Offen
config-select-desc-open = Spieler geben ihr eigenes Inventar manuell ein.
config-select-option-static = Statisch
config-select-desc-static = Spieler erhalten ein vordefiniertes Startinventar.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Berechtigte Kanäle auswählen

# RoleplayModeSelect
config-select-placeholder-rp-mode = Modus auswählen
config-select-option-scheduled = Geplant
config-select-desc-scheduled = Belohnungen werden einmal innerhalb eines festgelegten Rücksetzungszeitraums vergeben.
config-select-option-accrued = Angesammelt
config-select-desc-accrued = Belohnungen werden wiederholt basierend auf festgelegten Aktivitätsniveaus vergeben.

# RoleplayResetSelect
config-select-placeholder-reset-period = Rücksetzungszeitraum auswählen
config-select-option-hourly = Stündlich
config-select-desc-hourly = Wird jede Stunde zurückgesetzt.
config-select-option-daily = Täglich
config-select-desc-daily = Wird alle 24 Stunden zurückgesetzt.
config-select-option-weekly = Wöchentlich
config-select-desc-weekly = Wird alle 7 Tage zurückgesetzt.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Rücksetzungstag auswählen

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Rücksetzungszeit auswählen (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Forumskanal auswählen

# ForumThreadSelect
config-select-placeholder-thread = Thread auswählen
config-select-option-no-threads = Keine aktiven Threads gefunden
config-select-desc-no-threads = Erstellen Sie einen neuen Thread oder prüfen Sie archivierte Threads
config-select-option-select-forum-first = Zuerst ein Forum auswählen
config-select-desc-select-forum-first = Bitte wählen Sie oben einen Forumskanal aus
config-select-desc-thread-id = Thread-ID: { $threadId }
config-error-select-valid-thread = Bitte wählen Sie einen gültigen Thread aus oder erstellen Sie einen neuen.
config-error-thread-not-found = Der ausgewählte Thread konnte nicht gefunden werden. Er wurde möglicherweise gelöscht oder archiviert.

# ==========================================
# ANSICHTEN
# ==========================================

## Hauptmenü
config-title-main-menu = Serverkonfiguration - Hauptmenü
config-menu-config-wizard = Konfigurationsassistent
config-menu-desc-config-wizard = Überprüfen Sie mit einem schnellen Scan, ob Ihr Server für die Nutzung von ReQuest bereit ist.
config-menu-channels = Kanäle
config-menu-desc-channels = Legen Sie bestimmte Kanäle für ReQuest-Beiträge fest.
config-menu-currency = Währung
config-menu-desc-currency = Globale Währungseinstellungen.
config-menu-players = Spieler
config-menu-desc-players = Globale Spielereinstellungen, wie z.B. Erfahrungspunkte-Verfolgung.
config-menu-quests = Quests
config-menu-desc-quests = Globale Quest-Einstellungen, wie z.B. Wartelisten.
config-menu-rp-rewards = RP-Belohnungen
config-menu-desc-rp-rewards = Rollenspiel-Belohnungen konfigurieren.
config-menu-roles = Rollen
config-menu-desc-roles = Konfigurationsoptionen für pingbare oder privilegierte Rollen.
config-menu-shops = Shops
config-menu-desc-shops = Benutzerdefinierte Shops konfigurieren.
config-menu-language = Sprache
config-menu-desc-language = Standardsprache für diesen Server festlegen.

## Assistenten-Ansicht
config-title-wizard = {"**"}Serverkonfiguration - Assistent{"**"}
config-wizard-intro =
    {"**"}Willkommen beim ReQuest-Konfigurationsassistenten!{"**"}

    Dieser Assistent hilft Ihnen sicherzustellen, dass Ihr Server ordnungsgemäß für die Nutzung der ReQuest-Funktionen konfiguriert ist.
    Er scannt Ihre aktuellen Einstellungen und gibt Empfehlungen für erforderliche Anpassungen.

    Verwenden Sie die Schaltfläche „Scan starten" unten, um den Validierungsprozess zu beginnen. Nach Abschluss des Scans
    erhalten Sie einen detaillierten Bericht über die Konfiguration Ihres Servers zusammen mit empfohlenen Änderungen.

# Assistent - Bot-Berechtigungsvalidierung
config-wizard-bot-permissions-header = __{"**"}Globale Bot-Berechtigungen{"**"}__
config-wizard-bot-permissions-desc = Dieser Abschnitt überprüft, ob ReQuest die korrekten Berechtigungen hat, um ordnungsgemäß zu funktionieren.
config-wizard-bot-role = Bot-Rolle: { $roleMention }
config-wizard-status-warnings = {"**"}Status: ⚠️ WARNUNGEN GEFUNDEN{"**"}
config-wizard-missing-perm = - ⚠️ Fehlend: `{ $permissionName }`
config-wizard-ensure-permissions = Bitte stellen Sie sicher, dass die höchste Rolle des Bots diese Berechtigungen global gewährt hat.
config-wizard-status-ok = {"**"}Status: ✅ OK{"**"}
config-wizard-bot-permissions-ok = Der Bot hat alle erforderlichen globalen Berechtigungen.
config-wizard-status-scan-failed = {"**"}Status: ❌ SCAN FEHLGESCHLAGEN{"**"}
config-wizard-scan-error = Beim Überprüfen der Bot-Berechtigungen ist ein unerwarteter Fehler aufgetreten.
config-wizard-error-type = Fehler: { $errorType }
config-wizard-required-permissions = {"**"}Erforderliche Berechtigungen für die Bot-Rolle:{"**"}

# Assistent - Berechtigungsnamen
config-wizard-perm-view-channels = Kanäle anzeigen
config-wizard-perm-manage-roles = Rollen verwalten
config-wizard-perm-send-messages = Nachrichten senden
config-wizard-perm-attach-files = Dateien anhängen
config-wizard-perm-add-reactions = Reaktionen hinzufügen
config-wizard-perm-use-external-emoji = Externe Emoji verwenden
config-wizard-perm-manage-messages = Nachrichten verwalten
config-wizard-perm-read-message-history = Nachrichtenverlauf lesen

# Assistent - Rollenvalidierung
config-wizard-role-header = __{"**"}Rollenkonfigurationen{"**"}__
config-wizard-role-desc =
    Dieser Abschnitt überprüft Folgendes:

    - GM-Rollen (erforderlich) und Ankündigungsrolle (optional) sind konfiguriert.
    - Die Standardrolle (@everyone) hat die erforderlichen Berechtigungen, damit Benutzer auf Bot-Funktionen zugreifen können.
    - Die Standardrolle (@everyone) hat keine gefährlichen Berechtigungen.
    - GM- und Ankündigungsrollen werden darauf überprüft, ob sie Berechtigungseskalationen über die Standardrolle hinaus haben.

    Warnungen hier sind ausschließlich Empfehlungen basierend auf einer Standardkonfiguration. Je nach den Anforderungen Ihres Servers können Sie Gründe haben, einige dieser Empfehlungen zu ignorieren.

config-wizard-default-role-label = {"**"}Standardrolle:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Gefährliche Berechtigungen gefunden:
config-wizard-default-role-ok = - ✅ @everyone: OK
config-wizard-missing-permission = - Fehlende Berechtigung: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}GM-Rollen:{"**"}
config-wizard-no-gm-roles = - ⚠️ Keine GM-Rollen konfiguriert
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Konfigurierte Rolle nicht gefunden/vom Server gelöscht
config-wizard-role-ok = - ✅ { $roleMention }: OK
config-wizard-announcement-role-label = {"**"}Ankündigungsrolle:{"**"}
config-wizard-no-announcement-role = - ℹ️ Keine Ankündigungsrolle konfiguriert
config-wizard-announcement-role-not-found = - ⚠️ Konfigurierte Rolle nicht gefunden/vom Server gelöscht
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Berechtigungseskalationen erkannt - { $escalations }
config-wizard-escalation-more = , und { $count } weitere...

# Assistent - Erforderliche Standardberechtigungen
config-wizard-perm-send-messages-in-threads = Nachrichten in Threads senden
config-wizard-perm-use-application-commands = Anwendungsbefehle verwenden

# Assistent - Gefährliche Berechtigungen
config-wizard-perm-manage-channels = Kanäle verwalten
config-wizard-perm-manage-webhooks = Webhooks verwalten
config-wizard-perm-manage-server = Server verwalten
config-wizard-perm-manage-nicknames = Spitznamen verwalten
config-wizard-perm-kick-members = Mitglieder kicken
config-wizard-perm-ban-members = Mitglieder bannen
config-wizard-perm-timeout-members = Mitglieder in Auszeit setzen
config-wizard-perm-mention-everyone = @everyone erwähnen
config-wizard-perm-manage-threads = Threads verwalten
config-wizard-perm-administrator = Administrator

# Assistent - Kanalvalidierung
config-wizard-channel-header = __{"**"}Kanalkonfigurationen{"**"}__
config-wizard-channel-desc =
    Dieser Abschnitt überprüft Folgendes:

    - Konfigurierte Kanäle existieren.
    - Der Bot hat die Berechtigung, in den konfigurierten Kanälen Nachrichten anzuzeigen und zu senden.
    - Die Standardrolle (@everyone) hat keine `Nachrichten senden`-Berechtigung.

config-wizard-channel-no-config-required = - ⚠️ Kein Kanal konfiguriert
config-wizard-channel-not-configured = - ℹ️ Nicht konfiguriert (Optional)
config-wizard-channel-not-found = - ⚠️ Konfigurierter Kanal nicht gefunden/vom Server gelöscht
config-wizard-channel-ok = - ✅ OK
config-wizard-bot-cannot-view = - ⚠️ { $botMention } kann diesen Kanal nicht sehen.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } kann in diesem Kanal keine Nachrichten senden.
config-wizard-everyone-can-send = - ⚠️ @everyone kann in diesem Kanal Nachrichten senden.

# Assistent - Kanalnamen
config-wizard-channel-quest-board = Quest-Tafel
config-wizard-channel-player-board = Spielertafel
config-wizard-channel-quest-archive = Quest-Archiv
config-wizard-channel-gm-transaction-log = GM-Transaktionsprotokoll
config-wizard-channel-player-transaction-log = Spieler-Transaktionsprotokoll
config-wizard-channel-shop-log = Shop-Protokoll
config-wizard-channel-approval-queue = Charakter-Genehmigungswarteschlange

# Assistent - Dashboard
config-wizard-dashboard-header = __{"**"}Einstellungs-Dashboard{"**"}__
config-wizard-dashboard-desc = Dieser Abschnitt bietet einen Überblick über nicht-essentielle Konfigurationen zur schnellen Referenz.
config-wizard-quest-settings = {"**"}Quest-Einstellungen{"**"}
config-wizard-quest-wait-list = - Quest-Wartelistengröße: { $size }
config-wizard-quest-summary = - Quest-Zusammenfassung: { $status }
config-wizard-gm-rewards-per-quest = {"**"}GM-Belohnungen (pro Quest){"**"}
config-wizard-player-settings = {"**"}Spielereinstellungen{"**"}
config-wizard-player-experience = - Spielererfahrung: { $status }
config-wizard-currency-settings = {"**"}Währungseinstellungen{"**"}
config-wizard-rp-rewards = {"**"}Rollenspiel-Belohnungen{"**"}
config-wizard-rp-status = - Status: { $status }
config-wizard-rp-mode = - Modus: { $mode }
config-wizard-rp-channels = - Überwachte Kanäle: { $count }
config-wizard-shops = {"**"}Shops{"**"}
config-wizard-shops-count = - Konfigurierte Shops: { $count }
config-wizard-shops-more = - ...und { $count } weitere
config-wizard-new-char-setup = {"**"}Neuer-Charakter-Einrichtung{"**"}
config-wizard-inventory-type = - Inventartyp: { $type }
config-wizard-new-char-shop-items = - Neuer-Charakter-Shop-Gegenstände: { $count }
config-wizard-static-kits = - Statische Sets: { $count }

# Assistent - GM-Belohnungen-Bericht
config-wizard-no-currencies = - ℹ️ Keine Währungen konfiguriert
config-wizard-configured-currencies = {"**"}Konfigurierte Währungen:{"**"}
config-wizard-no-denominations = - Keine Stückelungen konfiguriert
config-wizard-gm-rewards-disabled = {"**"}Status:{"**"} Deaktiviert
config-wizard-gm-rewards-enabled = {"**"}Status:{"**"} Aktiviert
config-wizard-gm-rewards-experience = - Erfahrung: { $xp }
config-wizard-gm-rewards-items = - Gegenstände:
config-wizard-unnamed-shop = Unbenannter Shop

## Rollenansicht
config-title-roles = {"**"}Serverkonfiguration - Rollen{"**"}
config-label-announcement-role = {"**"}Ankündigungsrolle:{"**"} { $status }
config-desc-announcement-role = Diese Rolle wird erwähnt, wenn ein Quest veröffentlicht wird.
config-label-announcement-role-default = {"**"}Ankündigungsrolle:{"**"} Nicht konfiguriert
config-label-gm-roles = {"**"}GM-Rolle(n):{"**"} { $roles }
config-desc-gm-roles = Diese Rollen gewähren Zugriff auf Spielleiter-Befehle und -Funktionen.
config-label-gm-roles-default = {"**"}GM-Rolle(n):{"**"} Nicht konfiguriert
config-title-forbidden-roles = __{"**"}Verbotene Rollen{"**"}__
config-desc-forbidden-roles =
    Konfiguriert eine Liste von Rollennamen, die von Spielleitern nicht für ihre Gruppenrollen verwendet werden dürfen.
    Standardmäßig können `everyone`, `administrator`, `gm` und `game master` nicht verwendet werden. Diese Konfiguration
    erweitert diese Liste.

## GM-Rollen-Entfernungsansicht
config-title-remove-gm-roles = {"**"}Serverkonfiguration - GM-Rolle(n) entfernen{"**"}
config-msg-no-gm-roles = Keine GM-Rollen konfiguriert.

## Kanalansicht
config-title-channels = {"**"}Serverkonfiguration - Kanäle{"**"}

config-label-quest-board = {"**"}Quest-Tafel:{"**"} { $channel }
config-desc-quest-board = Der Kanal, in dem neue/aktive Quests veröffentlicht werden.
config-label-quest-board-default = {"**"}Quest-Tafel:{"**"} Nicht konfiguriert

config-label-player-board = {"**"}Spielertafel:{"**"} { $channel }
config-desc-player-board = Eine optionale Ankündigungs-/Nachrichtentafel zur Nutzung durch Spieler.
config-label-player-board-default = {"**"}Spielertafel:{"**"} Nicht konfiguriert

config-label-quest-archive = {"**"}Quest-Archiv:{"**"} { $channel }
config-desc-quest-archive = Ein optionaler Kanal, in den abgeschlossene Quests mit Zusammenfassungsinformationen verschoben werden.
config-label-quest-archive-default = {"**"}Quest-Archiv:{"**"} Nicht konfiguriert

config-label-gm-transaction-log = {"**"}GM-Transaktionsprotokoll:{"**"} { $channel }
config-desc-gm-transaction-log = Ein optionaler Kanal, in dem GM-Transaktionen (z.B. Spieler-bearbeiten-Befehle) protokolliert werden.
config-label-gm-transaction-log-default = {"**"}GM-Transaktionsprotokoll:{"**"} Nicht konfiguriert

config-label-player-transaction-log = {"**"}Spieler-Transaktionsprotokoll:{"**"} { $channel }
config-desc-player-transaction-log = Ein optionaler Kanal, in dem Spielertransaktionen wie Handeln und Verbrauchen von Gegenständen protokolliert werden.
config-label-player-transaction-log-default = {"**"}Spieler-Transaktionsprotokoll:{"**"} Nicht konfiguriert

config-label-shop-log = {"**"}Shop-Protokoll:{"**"} { $channel }
config-desc-shop-log = Ein optionaler Kanal, in dem Shop-Transaktionen protokolliert werden.
config-label-shop-log-default = {"**"}Shop-Protokoll:{"**"} Nicht konfiguriert

## Quest-Ansicht
config-title-quests = {"**"}Serverkonfiguration - Quests{"**"}

config-label-wait-list = {"**"}Quest-Wartelistengröße:{"**"} { $size }
config-desc-wait-list = Eine Warteliste ermöglicht es der angegebenen Anzahl von Spielern, sich für einen vollen Quest in die Warteschlange zu stellen, falls ein Spieler abspringt.
config-label-wait-list-disabled = {"**"}Quest-Wartelistengröße:{"**"} Deaktiviert

config-label-quest-summary = {"**"}Quest-Zusammenfassung:{"**"} { $status }
config-desc-quest-summary = Diese Option ermöglicht es GMs, eine kurze Zusammenfassung beim Abschließen von Quests zu verfassen.
config-label-quest-summary-disabled = {"**"}Quest-Zusammenfassung:{"**"} Deaktiviert

config-label-gm-rewards = GM-Belohnungen
config-desc-gm-rewards = Konfigurieren Sie Belohnungen, die GMs beim Abschluss von Quests erhalten.

## GM-Belohnungen-Ansicht
config-title-gm-rewards = {"**"}Serverkonfiguration - GM-Belohnungen{"**"}
config-desc-gm-rewards-detail =
    {"**"}Belohnungen hinzufügen/ändern{"**"}
    Öffnet ein Eingabedialog zum Hinzufügen, Ändern oder Entfernen von GM-Belohnungen.

    > Die konfigurierten Belohnungen gelten pro Quest. Jedes Mal, wenn ein Spielleiter einen Quest abschließt, erhält er
    die unten konfigurierten Belohnungen auf seinen aktiven Charakter.
config-msg-no-rewards = Keine Belohnungen konfiguriert.
config-label-gm-experience = {"**"}Erfahrung:{"**"} { $xp }
config-label-gm-items = {"**"}Gegenstände:{"**"}

## Spieleransicht
config-title-players = {"**"}Serverkonfiguration - Spieler{"**"}

config-label-player-experience = {"**"}Spielererfahrung:{"**"} { $status }
config-desc-player-experience = Aktiviert/Deaktiviert die Verwendung von Erfahrungspunkten (oder ähnlicher wertbasierter Charakterprogression).
config-label-player-experience-disabled = {"**"}Spielererfahrung:{"**"} Deaktiviert

config-label-new-char-settings = {"**"}Neuer-Charakter-Einstellungen{"**"}
config-desc-new-char-settings = Konfigurieren Sie Einstellungen für neue Spielercharaktere und deren anfängliche Inventareinrichtung.

config-label-player-board-purge = {"**"}Spielertafel-Bereinigung{"**"}
config-desc-player-board-purge = Bereinigt Beiträge von der Spielertafel (falls aktiviert).

## Neuer-Charakter-Einstellungen-Ansicht
config-title-new-character = {"**"}Serverkonfiguration - Neuer-Charakter-Einstellungen{"**"}

config-label-inventory-type = {"**"}Neuer-Charakter-Inventartyp:{"**"} { $type }
config-desc-inventory-type = Bestimmt, wie neu registrierte Charaktere ihr Inventar initialisieren.
config-label-inventory-type-disabled = {"**"}Neuer-Charakter-Inventartyp:{"**"} Deaktiviert

config-label-new-char-wealth = {"**"}Neues Charaktervermögen:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Neues Charaktervermögen:{"**"} Deaktiviert

config-label-approval-queue = {"**"}Genehmigungswarteschlange:{"**"} { $channel }
config-desc-approval-queue = Falls festgelegt, müssen neue Charaktere von einem GM in diesem Forumskanal genehmigt werden, bevor sie aktiv sind.
config-label-approval-queue-disabled = {"**"}Genehmigungswarteschlange:{"**"} Deaktiviert
config-label-approval-queue-not-configured = {"**"}Genehmigungswarteschlange:{"**"} Nicht konfiguriert

# Inventartyp-Beschreibungen (in der Einrichtung verwendet)
config-desc-inv-type-disabled = Spieler starten mit leerem Inventar.
config-desc-inv-type-selection = Spieler wählen Gegenstände frei aus dem Neuen-Charakter-Shop.
config-desc-inv-type-purchase = Spieler kaufen Gegenstände aus dem Neuen-Charakter-Shop mit einem vorgegebenen Währungsbetrag.
config-desc-inv-type-open = Spieler geben ihre Inventargegenstände manuell ein.
config-desc-inv-type-static = Spieler erhalten ein vordefiniertes Startinventar.

## Neuer-Charakter-Shop-Ansicht
config-title-new-char-shop = {"**"}Serverkonfiguration - Neuer-Charakter-Shop{"**"}
config-label-inv-type-selection = {"**"}Inventartyp:{"**"} Auswahl
config-desc-inv-type-selection-shop = Spieler wählen Gegenstände frei aus dem Neuen-Charakter-Shop.
config-label-inv-type-purchase = {"**"}Inventartyp:{"**"} Kauf
config-desc-inv-type-purchase-shop = Spieler kaufen Gegenstände aus dem Neuen-Charakter-Shop mit einem vorgegebenen Währungsbetrag.
config-label-inv-type-other = {"**"}Inventartyp:{"**"} { $type }
config-desc-inv-type-not-in-use = Neuer-Charakter-Shop wird nicht verwendet.
config-msg-define-shop-items = Definieren Sie die Shopgegenstände.
config-msg-no-items = Keine Gegenstände konfiguriert.

## Statische-Sets-Ansicht
config-title-static-kits = {"**"}Serverkonfiguration - Statische Ausrüstungssets{"**"}
config-desc-create-kit = Erstellen Sie eine neue Set-Definition.
config-msg-no-kits = Keine Sets konfiguriert.
config-label-kit-more-items = ...und { $count } weitere Gegenstände
config-label-empty-kit = {"*"}Leeres Set{"*"}

## Statisches-Set-Bearbeitung-Ansicht
config-title-editing-kit = {"**"}Set bearbeiten: { $kitName }{"**"}
config-msg-kit-empty = Dieses Set ist leer. Verwenden Sie die Schaltflächen oben, um Währung oder Gegenstände hinzuzufügen.
config-label-kit-currency = {"**"}Währung:{"**"} { $display }
config-label-kit-item = {"**"}Gegenstand:{"**"} { $name }

## Währungsansicht
config-title-currency = {"**"}Serverkonfiguration - Währung{"**"}
config-desc-create-currency = Erstellen Sie eine neue Währung.
config-msg-no-currencies = Keine Währungen konfiguriert.
config-label-currency-display-type = Anzeigetyp: { $type } | Stückelungen: { $count }
config-label-currency-type-double = Dezimal
config-label-currency-type-integer = Ganzzahl

## Währung-Bearbeiten-Ansicht
config-title-manage-currency = {"**"}Währung verwalten: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Währung und Stückelungen{"**"}__
    - Der gegebene Name Ihrer Währung gilt als Basiswährung und hat einen Wert von 1.
    {"```"}Beispiel: "Gold" ist als Währung konfiguriert.{"```"}
    - Das Hinzufügen einer Stückelung erfordert die Angabe eines Namens und eines Werts relativ zur Basiswährung.
    {"```"}Beispiel: Gold erhält zwei Stückelungen: Silber (Wert 0,1) und Kupfer (Wert 0,01).{"```"}
    - Alle Transaktionen mit einer Basiswährung oder ihren Stückelungen werden automatisch umgerechnet.
    {"```"}Beispiel: Ein Spieler hat 10 Gold und gibt 3 Kupfer aus. Sein neues Guthaben wird automatisch als
    9 Gold, 9 Silber und 7 Kupfer angezeigt.{"```"}
    - Währungen, die als Ganzzahl angezeigt werden, zeigen jede Stückelung, während Währungen, die als Dezimal angezeigt werden,
    nur als Basiswährung angezeigt werden.
    {"```"}Beispiel: Der oben genannte Spieler mit aktivierter Dezimalanzeige wird als 9,97 Gold angezeigt.{"```"}
config-btn-toggle-display-current = Anzeige umschalten (Aktuell: { $type })
config-msg-no-denominations = Keine Stückelungen konfiguriert.

## Shop-Ansicht
config-title-shops = {"**"}Serverkonfiguration - Shops{"**"}
config-desc-add-shop-wizard =
    {"**"}Shop hinzufügen (Assistent){"**"}
    Erstellen Sie einen neuen, leeren Shop über ein Formular.
config-desc-add-shop-json =
    {"**"}Shop hinzufügen (JSON){"**"}
    Erstellen Sie einen neuen Shop durch Angabe einer vollständigen JSON-Definition. (Fortgeschritten)
config-btn-example-json = Beispiel-JSON
config-desc-example-json =
    {"**"}Beispiel-JSON{"**"}
    Laden Sie eine Beispiel-JSON-Datei herunter, die das erwartete Format zeigt.
config-msg-example-json = Hier ist eine Beispiel-JSON-Datei, die das erwartete Format zeigt.
config-msg-no-shops = Keine Shops konfiguriert.
config-label-shop-type-forum = (Forum)
config-label-shop-channel = Kanal: <#{ $channelId }>

## Shop-Kanaltyp-Auswahl-Ansicht
config-title-choose-location = {"**"}Shop hinzufügen - Standorttyp wählen{"**"}
config-label-text-channel = {"**"}Textkanal{"**"}
config-desc-text-channel = Erstellen Sie einen Shop in einem Standard-Textkanal.
config-label-forum-thread = {"**"}Forum-Thread{"**"}
config-desc-forum-thread = Erstellen Sie einen Shop in einem Forum-Thread (neu oder bestehend).

## Forum-Shop-Einrichtung-Ansicht
config-title-forum-setup = {"**"}Shop hinzufügen - Forum-Thread-Einrichtung{"**"}
config-label-step1 = {"**"}Schritt 1: Forumskanal auswählen{"**"}
config-label-step2 = {"**"}Schritt 2: Thread-Option wählen{"**"}
config-label-step3 = {"**"}Schritt 3: Vorhandenen Thread auswählen{"**"}
config-desc-create-new-thread =
    {"**"}Neuen Thread erstellen{"**"}
    Öffnet ein Formular zum Erstellen eines neuen Threads und zur Konfiguration des Shops.
config-label-selected-thread = {"**"}Ausgewählter Thread:{"**"} { $threadName }
config-desc-click-to-configure = Klicken Sie, um den Shop in diesem Thread zu konfigurieren.

## Shop-Verwaltung-Ansicht
config-title-manage-shop = {"**"}Shop verwalten: { $shopName }{"**"}
config-label-shop-type = {"**"}Typ:{"**"} { $type }
config-label-shop-type-text = Textkanal
config-label-shop-type-forum-thread = Forum-Thread
config-label-shopkeeper = {"**"}Shopbesitzer:{"**"} { $name }
config-label-shop-description = {"**"}Beschreibung:{"**"} { $description }
config-label-shop-channel-info = {"**"}Kanal:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Shopdetails und Gegenstände über den Assistenten bearbeiten.
config-desc-upload-json = Neue JSON-Definition für diesen Shop hochladen.
config-desc-download-json = Aktuelle JSON-Definition herunterladen.
config-desc-remove-shop = Diesen Shop dauerhaft entfernen.

## Shop-Bearbeiten-Ansicht
config-title-editing-shop = {"**"}Shop bearbeiten: { $shopName }{"**"}
config-label-shop-shopkeeper = Shopbesitzer: {"**"}{ $name }{"**"}

## Bestandsgrenzen-Ansicht
config-title-stock-config = {"**"}Bestandskonfiguration: { $shopName }{"**"}
config-label-current-utc = Aktuelle UTC-Zeit: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Nachfüllzeitplan:{"**"} { $schedule }
config-label-restock-hourly = zur Minute :{ $minute }
config-label-restock-daily = um { $time } UTC
config-label-restock-weekly = am { $day } um { $time } UTC
config-label-restock-mode = {"**"}Modus:{"**"} { $mode }
config-label-restock-full = Vollständige Auffüllung
config-label-restock-incremental = Schrittweise (Mengen pro Artikel)
config-label-restock-disabled = {"**"}Nachfüllzeitplan:{"**"} Deaktiviert
config-label-item-stock-limits = {"**"}Gegenstandsbestandsgrenzen{"**"}
config-msg-no-items-in-shop = Keine Gegenstände in diesem Shop.
config-label-stock-with-available = Max: { $max } | Verfügbar: { $available }
config-label-stock-increment = Nachfüllung: +{ $increment }/Zyklus
config-label-stock-reserved = Reserviert: { $reserved }
config-label-stock-not-initialized = Max: { $max } | Verfügbar: (nicht initialisiert)
config-label-stock-unlimited = Bestand: Unbegrenzt

## Rollenspiel-Ansicht
config-title-roleplay = {"**"}Serverkonfiguration - Rollenspiel-Belohnungen{"**"}
config-label-rp-status = {"**"}Status:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Serverzeit:{"**"} `{ $time }`
config-label-rp-enabled = Aktiviert
config-label-rp-disabled = Deaktiviert

config-desc-rp-mode-scheduled = {"```"}Belohnungen werden einmal verteilt, wenn die erforderliche Schwelle an berechtigten Nachrichten innerhalb des festgelegten Zeitraums (stündlich, täglich oder wöchentlich) gesendet wurde.{"```"}
config-desc-rp-mode-accrued = {"```"}Belohnungen werden wiederkehrend verteilt, jedes Mal wenn eine festgelegte Anzahl berechtigter Nachrichten gesendet wird.{"```"}

config-label-rp-config-details = {"**"}Konfigurationsdetails:{"**"}
config-label-rp-mode = {"**"}Modus:{"**"} { $mode }
config-label-rp-min-length = {"**"}Mindestlänge der Nachricht:{"**"} { $length } Zeichen
config-label-rp-cooldown = {"**"}Abklingzeit:{"**"} { $seconds } Sekunden
config-label-rp-frequency-once = {"**"}Häufigkeit:{"**"} Einmal pro { $period }
config-label-rp-reset-time = {"**"}Rücksetzungszeit:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Schwelle:{"**"} { $count } berechtigte Nachrichten
config-label-rp-frequency-every = {"**"}Häufigkeit:{"**"} Alle { $count } berechtigten Nachrichten

config-label-rp-channels = {"**"}Rollenspiel-Kanäle:{"**"}
config-msg-rp-no-channels = Keine konfiguriert.
config-label-rp-channels-more = ...und { $count } weitere.

config-label-rp-rewards = {"**"}Belohnungen:{"**"}
config-msg-rp-no-rewards = Keine konfiguriert.
config-label-rp-experience = {"**"}Erfahrung:{"**"} { $xp }
config-label-rp-items = {"**"}Gegenstände:{"**"}
config-label-rp-currency = {"**"}Währung:{"**"}

## Sprachansicht
config-title-language = {"**"}Serverkonfiguration - Sprache{"**"}
config-server-language-help =
    Diese Einstellung ermöglicht es Ihnen, die Standardsprache für die {"**"}öffentlichen{"**"} Antworten und Nachrichten von ReQuest auf diesem Server festzulegen. Öffentliche Antworten umfassen:
    - Quest- und Spielertafel-Beiträge
    - Quest-Zusammenfassungen und Protokollkanal-Nachrichten
    - Shop-Nachfüllungen
    - Spieler-Gegenstandsverbrauch

    Diese Einstellung betrifft nur statischen, vom Bot generierten Text und übersetzt keine dynamischen Inhalte wie benutzerdefinierte Gegenstandsnamen oder Quest-Beschreibungen.

    Persönliche Antworten und Menüs werden von dieser Einstellung nicht beeinflusst.
config-label-server-language = {"**"}Serversprache:{"**"} { $language }
config-label-server-language-default = {"**"}Serversprache:{"**"} Standard (keine Überschreibung)
config-select-placeholder-server-language = Serversprache auswählen
config-select-option-default = Standard (keine Überschreibung)
config-select-desc-default = Verwendet die Präferenz jedes Benutzers oder die Discord-Spracheinstellung.

# Quest Roles
config-btn-quest-roles = Quest-Rollen
config-btn-manage-gm-quest-roles = Verwalten

config-modal-title-confirm-quest-role-removal = Rollenentfernung bestätigen
config-modal-label-remove-quest-role = { $roleName } von { $gmName } entfernen?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Quest-Rollenmodus auswählen
config-select-option-quest-role-disabled = Deaktiviert
config-select-desc-quest-role-disabled = Es werden keine Rollen erstellt oder zugewiesen.
config-select-option-quest-role-temporary = Temporär
config-select-desc-quest-role-temporary = SL können temporäre Rollen pro Quest erstellen.
config-select-option-quest-role-static = Statisch
config-select-desc-quest-role-static = SL wählen aus vordefinierten Serverrollen.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Serverrolle(n) diesem SL zuweisen

## Quest Roles View
config-title-quest-roles = {"**"}Serverkonfiguration - Quest-Rollen{"**"}
config-label-quest-roles = Quest-Rollen
config-desc-quest-roles =
    Konfigurieren Sie, wie Gruppenrollen während Quests verwaltet werden.

config-label-quest-role-mode-disabled = {"**"}Quest-Rollenmodus:{"**"} Deaktiviert
    Während Quests werden keine Rollen erstellt oder zugewiesen.
config-label-quest-role-mode-temporary = {"**"}Quest-Rollenmodus:{"**"} Temporär
    SL können optional eine temporäre Rolle bei der Quest-Erstellung erstellen.
    Die Rolle wird gelöscht, wenn der Quest abgeschlossen oder abgebrochen wird.
config-label-quest-role-mode-static = {"**"}Quest-Rollenmodus:{"**"} Statisch
    SL wählen aus vordefinierten Serverrollen. Rollen werden den
    Gruppenmitgliedern während Quests zugewiesen, aber nie gelöscht.

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}Serverkonfiguration - Statische Quest-Rollenzuweisungen{"**"}
config-label-manage-assignments = Rollenzuweisungen verwalten
config-desc-manage-assignments =
    Weisen Sie vorhandene Serverrollen den SL für die Verwendung während Quests zu.
    Rollen müssen niedriger als die höchste Rolle von ReQuest in der Serverhierarchie sein.
config-msg-no-gm-members = Auf diesem Server wurden keine Mitglieder mit einer SL-Rolle gefunden.
config-label-no-roles-assigned = Keine Quest-Rollen zugewiesen

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}Quest-Rollen verwalten — { $gmName }{"**"}
config-error-unmanageable-roles = Die folgenden Rollen können nicht zugewiesen werden, da sie von einer Integration verwaltet werden, die Standardrolle sind oder über der höchsten Rolle von ReQuest liegen: { $roles }
config-error-quest-role-limit = Dieser SL hat das Maximum von { $limit } zugewiesenen Quest-Rollen erreicht.
config-label-quest-role-count = Zugewiesene Rollen: { $count }/{ $limit }
