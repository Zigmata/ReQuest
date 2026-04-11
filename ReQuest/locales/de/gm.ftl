## Spielleitermodul-Zeichenketten

# GM-Schaltflächen
gm-btn-create = Erstellen
gm-btn-edit-details = Quest bearbeiten
gm-btn-toggle-ready = Bereitschaft umschalten
gm-btn-configure-rewards = Belohnungen konfigurieren
gm-btn-remove-player = Spieler entfernen
gm-btn-cancel-quest = Quest abbrechen
gm-btn-manage-party-rewards = Gruppenbelohnungen verwalten
gm-btn-manage-individual-rewards = Einzelbelohnungen verwalten
gm-btn-join = Beitreten
gm-btn-leave = Verlassen
gm-btn-complete-quest = Quest abschließen
gm-btn-edit-details-modal = Details bearbeiten
gm-btn-edit-images = Bilder bearbeiten
gm-select-placeholder-party-role = Wählen Sie eine Gruppenrolle...
gm-modal-title-edit-details = Quest-Details bearbeiten
gm-modal-title-edit-images = Quest-Bilder bearbeiten
gm-btn-publish = Veröffentlichen
gm-btn-update-post = Beitrag aktualisieren

# GM-Dialoge
gm-modal-title-create-quest = Neuen Quest erstellen
gm-modal-label-quest-title = Quest-Titel
gm-modal-placeholder-quest-title = Titel Ihres Quests
gm-modal-label-restrictions = Einschränkungen
gm-modal-placeholder-restrictions = Einschränkungen, falls vorhanden, wie z.B. Spielerstufen
gm-modal-label-max-party = Maximale Gruppengröße
gm-modal-placeholder-max-party = Maximale Größe der Gruppe für diesen Quest
gm-modal-label-party-role = Gruppenrolle
gm-modal-placeholder-party-role = Eine Rolle für diesen Quest erstellen (Optional)
gm-modal-label-description = Beschreibung
gm-modal-placeholder-description = Schreiben Sie hier die Details Ihres Quests
gm-modal-label-image-url = Miniatur-URL
gm-modal-label-large-image-url = Großbild-URL
gm-modal-placeholder-image-url = Geben Sie eine Bild-URL ein (oder leer lassen zum Entfernen)
gm-modal-title-add-reward = Belohnung hinzufügen
gm-modal-label-experience = Erfahrungspunkte
gm-modal-placeholder-experience = Geben Sie eine Zahl ein
gm-modal-label-items = Gegenstände
gm-modal-placeholder-items =
    Gegenstand: Menge
    Gegenstand2: Menge
    usw.
gm-modal-title-add-summary = Quest-Zusammenfassung hinzufügen
gm-modal-label-summary = Zusammenfassung
gm-modal-placeholder-summary = Fügen Sie eine Handlungszusammenfassung des Quests hinzu
gm-modal-title-modifying-player = { $playerName } bearbeiten
gm-modal-placeholder-xp-add-remove = Geben Sie eine positive oder negative Zahl ein.
gm-modal-label-inventory = Inventar
gm-modal-placeholder-inventory-modify =
    Gegenstand: Menge
    Gegenstand2: Menge
    usw.

# GM-Fehler
gm-error-forbidden-role-name = Der angegebene Name für die Gruppenrolle ist verboten.
gm-error-role-already-exists = Eine Rolle mit diesem Namen existiert bereits auf diesem Server.
gm-error-no-quest-channel = Es wurde noch kein Kanal für Quest-Beiträge festgelegt. Wenden Sie sich an einen Serveradministrator, um den Quest-Kanal zu konfigurieren.
gm-error-cannot-ping-announce = Ankündigungsrolle { $role } konnte im Kanal { $channel } nicht gepingt werden. Überprüfen Sie die Kanal- und ReQuest-Rollenberechtigungen mit Ihrem/Ihren Serveradministrator(en).
gm-error-invalid-item-format = Ungültiges Gegenstandsformat: "{ $item }". Jeder Gegenstand muss in einer neuen Zeile stehen und das Format "Name: Menge" haben.
gm-error-already-on-quest = Sie sind bereits als { $characterName } bei diesem Quest dabei.
gm-error-no-active-character-long = Sie haben keinen aktiven Charakter auf diesem Server. Verwenden Sie `/player`, um einen Charakter zu registrieren oder zu aktivieren.
gm-error-quest-locked = Fehler beim Beitreten zum Quest {"**"}{ $questTitle }{"**"}: Der Quest ist vom GM gesperrt.
gm-error-quest-full = Fehler beim Beitreten zum Quest {"**"}{ $questTitle }{"**"}: Die Quest-Liste ist voll!
gm-error-not-signed-up = Sie sind nicht für diesen Quest angemeldet.
gm-error-quest-not-found = Quest existiert nicht mehr.
gm-error-quest-channel-not-set = Quest-Kanal wurde nicht festgelegt!
gm-error-empty-roster = Sie können einen Quest mit leerer Teilnehmerliste nicht abschließen. Versuchen Sie stattdessen, ihn abzubrechen.
gm-error-invalid-xp-value = XP-Wert muss eine positive Ganzzahl sein!
gm-error-party-size-positive = Die Gruppengröße muss eine positive Zahl sein.
gm-error-party-size-too-small = Die Gruppengröße kann nicht kleiner sein als die aktuelle Gruppe ({ $currentSize } Mitglieder).
gm-error-role-name-forbidden = Der Rollenname "{ $roleName }" ist auf diesem Server verboten.
gm-error-role-name-exists = Eine Rolle mit dem Namen "{ $roleName }" existiert bereits auf diesem Server.

# GM-Bestätigungsdialoge
gm-modal-title-cancel-quest = Quest abbrechen
gm-modal-label-cancel-quest = Geben Sie BESTÄTIGEN ein, um den Quest abzubrechen.
gm-modal-title-remove-from-quest = Charakter vom Quest entfernen
gm-modal-label-remove-from-quest = Charakterentfernung bestätigen?

# GM DM embeds
gm-dm-title-quest-cancelled = Quest abgebrochen
gm-dm-desc-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} wurde vom GM abgebrochen.
gm-dm-title-quest-ready = Quest bereit
gm-dm-desc-quest-ready = Quest {"**"}{ $questTitle }{"**"} ist jetzt bereit! Ihr GM wird den Quest bald beginnen.
gm-dm-title-player-removed = Vom Quest entfernt
gm-dm-desc-player-removed = Sie wurden vom GM aus Quest {"**"}{ $questTitle }{"**"} entfernt.
gm-dm-desc-player-removed-waitlist = Sie wurden von der Warteliste für Quest {"**"}{ $questTitle }{"**"} entfernt.
gm-dm-title-party-promotion = Gruppenbeförderung
gm-dm-desc-party-promotion =
    Sie wurden in die Hauptgruppe für {"**"}{ $questTitle }{"**"} befördert,
    da ein Spieler den Quest verlassen hat.
gm-dm-title-roster-locked = Liste gesperrt
gm-dm-desc-roster-locked =
    Die Liste für {"**"}{ $questTitle }{"**"} wurde gesperrt
    und alle Gruppenmitglieder wurden benachrichtigt.
gm-dm-title-roster-unlocked = Liste entsperrt
gm-dm-desc-roster-unlocked = Die Liste für {"**"}{ $questTitle }{"**"} wurde entsperrt.
gm-dm-title-player-removed-confirm = Spieler entfernt
gm-dm-desc-player-removed-confirm =
    Der Spieler wurde aus {"**"}{ $questTitle }{"**"} entfernt
    und die Quest-Liste wurde aktualisiert.
gm-dm-footer-quest = Quest-ID: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    Ihr Serveradministrator hat Belohnungen für Spielleiter konfiguriert, die beim Abschluss von
    Quests vergeben werden. Da Sie jedoch keine registrierten Charaktere haben, konnten Ihre Belohnungen
    zu diesem Zeitpunkt nicht automatisch ausgegeben werden.
gm-dm-rewards-no-active-character =
    Ihr Serveradministrator hat Belohnungen für Spielleiter konfiguriert, die beim Abschluss von
    Quests vergeben werden. Da Sie jedoch keinen aktiven Charakter auf diesem Server haben, konnten Ihre Belohnungen
    zu diesem Zeitpunkt nicht automatisch ausgegeben werden.
gm-dm-rewards-issued = Folgendes wurde Ihrem aktiven Charakter { $characterName } verliehen
gm-dm-role-removal-failed =
    ⚠️ Die Rolle {"**"}{ $roleName }{"**"} konnte nicht von den folgenden Mitgliedern entfernt werden: { $members }.
    Bitte benachrichtigen Sie einen Serveradministrator, um die Rolle manuell zu entfernen.

gm-dm-role-not-found =
    ⚠️ Die Quest-Rolle (ID: { $roleId }) für Quest {"**"}{ $questTitle }{"**"} existiert nicht mehr auf dem Server.
    Rollenoperationen wurden übersprungen. Bitte benachrichtigen Sie einen Serveradministrator, falls dies unerwartet ist.

# GM-Auswahlmenüs
gm-select-placeholder-party-member = Gruppenmitglied auswählen
gm-modal-label-select-party-role = Gruppenrolle
gm-modal-desc-select-party-role = Wählen Sie eine Rolle für die Quest-Gruppe aus.
gm-select-option-no-role = Keine (Keine Gruppenrolle)

# GM-Einbettungen
gm-embed-title-mod-report = GM-Spieleränderungsbericht
gm-embed-field-experience = Erfahrung
gm-embed-title-quest-complete = Quest abgeschlossen: { $questTitle }
gm-embed-title-quest-completed = QUEST ABGESCHLOSSEN: { $questTitle }
gm-embed-field-rewards = Belohnungen
gm-embed-field-party = __Gruppe__
gm-embed-field-summary = Zusammenfassung
gm-embed-title-gm-rewards = GM-Belohnungen vergeben
gm-embed-field-items = Gegenstände

# GM-Ansichten
gm-title-main-menu = Spielleiter - Hauptmenü
gm-menu-quests = Quests
gm-menu-desc-quests = Quests erstellen, bearbeiten und verwalten.
gm-menu-players = Spieler
gm-menu-desc-players = Spielerinventare verwalten und Charaktere bearbeiten.

gm-title-quest-management = Spielleiter - Quest-Verwaltung
gm-desc-create-quest = Einen neuen Quest erstellen.
gm-msg-no-quests = Keine Quests gefunden.
gm-label-quest-locked = (Gesperrt)
gm-label-quest-draft = (Entwurf)
gm-title-manage-quest = Quest verwalten - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Quest-Details wie Titel, Beschreibung und Gruppengröße bearbeiten.
gm-title-edit-quest = Quest bearbeiten - { $questTitle }
gm-label-field-not-set = Nicht festgelegt
gm-label-description-not-set = Beschreibung nicht festgelegt
gm-label-current-title = {"**"}Titel:{"**"} { $value }
gm-label-current-description = {"**"}Beschreibung{"**"}
gm-label-current-restrictions = {"**"}Einschränkungen:{"**"} { $value }
gm-label-current-party-size = {"**"}Maximale Gruppengröße:{"**"} { $value }
gm-label-current-party-role = {"**"}Gruppenrolle:{"**"} { $value }
gm-label-current-image = {"**"}Miniatur{"**"}
gm-label-current-large-image = {"**"}Bild{"**"}
gm-desc-toggle-ready = Bereitschaftsstatus umschalten (Aktuell: {"**"}{ $status }{"**"})
    - Sperrt die Quest-Liste und benachrichtigt Gruppenmitglieder, dass der Quest bald beginnt. Wenn eine Rolle konfiguriert ist, wird sie den Gruppenmitgliedern bei Sperrung zugewiesen.
    - Entsperrt die Liste, wenn auf Offen gesetzt.
gm-label-ready-locked = Gesperrt/Bereit
gm-label-ready-open = Offen
gm-desc-configure-rewards = Belohnungen für den ausgewählten Quest konfigurieren.
gm-desc-complete-quest = Einen Quest abschließen. Vergibt Belohnungen, falls vorhanden, an Gruppenmitglieder.
gm-desc-remove-player = Einen Spieler aus der Quest-Liste entfernen und benachrichtigen.
gm-desc-cancel-quest = Den Quest abbrechen und von der Quest-Tafel löschen.
gm-desc-publish-quest = Diesen Quest auf der Quest-Tafel veröffentlichen.
gm-desc-update-quest-post = Den Quest-Beitrag auf der Quest-Tafel aktualisieren.
gm-error-role-hierarchy = ReQuest kann die Rolle "{ $roleName }" (ID: { $roleId }) nicht verwalten, da sie höher als die höchste Rolle von ReQuest in der Serverhierarchie positioniert ist. Bitte wenden Sie sich an einen Serveradministrator, um die Rolle unter die Rolle von ReQuest zu verschieben, oder weisen Sie ReQuest eine höhere Rolle zu, und versuchen Sie es dann erneut.
gm-title-player-management = Spielleiter - Spielerverwaltung
gm-desc-player-management =
    Diese Befehle sind zu Kontextmenüs migriert. Klicken Sie mit der rechten Maustaste (Desktop) oder halten Sie lange gedrückt (Mobil) auf das Profil eines Spielers für die folgenden Menüoptionen:

    - {"**"}Spieler bearbeiten{"**"}: Gegenstände und Erfahrung eines Spielers hinzufügen oder entfernen.
    - {"**"}Spieler anzeigen{"**"}: Die aktiven Charakterdetails eines Spielers einsehen.
gm-title-remove-player = Spieler vom Quest entfernen - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Hinweise zur Spielerentfernung{"**"}__

    - Wählen Sie einen Spieler aus dem Dropdown-Menü unten, um ihn aus der Quest-Liste zu entfernen.
    - Falls Spieler auf einer Warteliste stehen, wird der erste Spieler auf der Liste in die Gruppe befördert.
    - Einzelbelohnungen für den entfernten Spieler werden aus dem Quest gelöscht.
    - Wenn Sie den Spieler für frühere Beiträge belohnen möchten, verwenden Sie das Kontextmenü `Spieler bearbeiten`, um ihm Belohnungen direkt zu vergeben.
gm-label-no-players-in-roster = Keine Spieler in der Quest-Liste
gm-title-character-sheet = Charakterbogen für { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Erfahrungspunkte:{"**"}__
gm-label-possessions = __{"**"}Besitztümer{"**"}__
gm-label-currency-heading = {"**"}Währung{"**"}
gm-msg-inventory-empty = Das Inventar ist leer.

# GM-Genehmigungen
