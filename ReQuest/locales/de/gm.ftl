## Spielleitermodul-Zeichenketten

# GM-Schaltflächen
gm-btn-create = Erstellen
gm-btn-edit-details = Details bearbeiten
gm-btn-toggle-ready = Bereitschaft umschalten
gm-btn-configure-rewards = Belohnungen konfigurieren
gm-btn-remove-player = Spieler entfernen
gm-btn-cancel-quest = Quest abbrechen
gm-btn-manage-party-rewards = Gruppenbelohnungen verwalten
gm-btn-manage-individual-rewards = Einzelbelohnungen verwalten
gm-btn-join = Beitreten
gm-btn-leave = Verlassen
gm-btn-complete-quest = Quest abschließen
gm-btn-review-submission = Einreichung prüfen
gm-btn-approve = Genehmigen
gm-btn-deny = Ablehnen

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
gm-modal-title-editing-quest = { $questTitle } bearbeiten
gm-modal-label-title = Titel
gm-modal-label-max-party-size = Maximale Gruppengröße
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
gm-modal-title-review-submission = Einreichung prüfen
gm-modal-label-submission-id = Einreichungs-ID
gm-modal-placeholder-submission-id = Geben Sie die 8-stellige ID ein

# GM-Fehler
gm-error-forbidden-role-name = Der angegebene Name für die Gruppenrolle ist verboten.
gm-error-role-already-exists = Eine Rolle mit diesem Namen existiert bereits auf diesem Server.
gm-error-no-quest-channel = Es wurde noch kein Kanal für Quest-Beiträge festgelegt. Wenden Sie sich an einen Serveradministrator, um den Quest-Kanal zu konfigurieren.
gm-error-cannot-ping-announce = Ankündigungsrolle { $role } konnte im Kanal { $channel } nicht gepingt werden. Überprüfen Sie die Kanal- und ReQuest-Rollenberechtigungen mit Ihrem/Ihren Serveradministrator(en).
gm-error-invalid-item-format = Ungültiges Gegenstandsformat: "{ $item }". Jeder Gegenstand muss in einer neuen Zeile stehen und das Format "Name: Menge" haben.
gm-error-submission-not-found = Einreichung nicht gefunden.
gm-error-already-on-quest = Sie sind bereits als { $characterName } bei diesem Quest dabei.
gm-error-no-active-character-long = Sie haben keinen aktiven Charakter auf diesem Server. Verwenden Sie `/player`, um einen Charakter zu registrieren oder zu aktivieren.
gm-error-quest-locked = Fehler beim Beitreten zum Quest {"**"}{ $questTitle }{"**"}: Der Quest ist vom GM gesperrt.
gm-error-quest-full = Fehler beim Beitreten zum Quest {"**"}{ $questTitle }{"**"}: Die Quest-Liste ist voll!
gm-error-not-signed-up = Sie sind nicht für diesen Quest angemeldet.
gm-error-quest-channel-not-set = Quest-Kanal wurde nicht festgelegt!
gm-error-empty-roster = Sie können einen Quest mit leerer Teilnehmerliste nicht abschließen. Versuchen Sie stattdessen, ihn abzubrechen.
gm-error-invalid-xp-value = XP-Wert muss eine positive Ganzzahl sein!

# GM-Bestätigungsdialoge
gm-modal-title-cancel-quest = Quest abbrechen
gm-modal-label-cancel-quest = Geben Sie CONFIRM ein, um den Quest abzubrechen.
gm-modal-placeholder-cancel-quest = Geben Sie "CONFIRM" ein, um fortzufahren.
gm-modal-title-remove-from-quest = Charakter vom Quest entfernen
gm-modal-label-remove-from-quest = Charakterentfernung bestätigen?
gm-modal-placeholder-remove-from-quest = Geben Sie "CONFIRM" ein, um fortzufahren.

# GM-Direktnachrichten
gm-dm-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} wurde vom GM abgebrochen.
gm-dm-quest-ready = Quest {"**"}{ $questTitle }{"**"} ist jetzt bereit!
gm-dm-quest-unlocked = Quest {"**"}{ $questTitle }{"**"} ist nicht mehr gesperrt.
gm-dm-quest-locked = Quest {"**"}{ $questTitle }{"**"} ist jetzt vom GM gesperrt.
gm-dm-player-removed = Sie wurden vom Quest {"**"}{ $questTitle }{"**"} entfernt.
gm-dm-player-removed-waitlist = Sie wurden von der Warteliste für {"**"}{ $questTitle }{"**"} entfernt.
gm-dm-party-promotion = Sie wurden der Gruppe für {"**"}{ $questTitle }{"**"} hinzugefügt, da ein Spieler abgesprungen ist!
gm-dm-roster-locked = Quest-Liste gesperrt und Gruppe benachrichtigt!
gm-dm-roster-unlocked = Quest-Liste wurde entsperrt.
gm-dm-rewards-no-characters =
    Ihr Serveradministrator hat Belohnungen für Spielleiter konfiguriert, die beim Abschluss von
    Quests vergeben werden. Da Sie jedoch keine registrierten Charaktere haben, konnten Ihre Belohnungen
    zu diesem Zeitpunkt nicht automatisch ausgegeben werden.
gm-dm-rewards-no-active-character =
    Ihr Serveradministrator hat Belohnungen für Spielleiter konfiguriert, die beim Abschluss von
    Quests vergeben werden. Da Sie jedoch keinen aktiven Charakter auf diesem Server haben, konnten Ihre Belohnungen
    zu diesem Zeitpunkt nicht automatisch ausgegeben werden.
gm-dm-rewards-issued = Folgendes wurde Ihrem aktiven Charakter { $characterName } verliehen

# GM-Auswahlmenüs
gm-select-placeholder-party-member = Gruppenmitglied auswählen

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
gm-msg-player-removed = Spieler entfernt und Quest-Liste aktualisiert!

# GM-Ansichten
gm-title-main-menu = Spielleiter - Hauptmenü
gm-menu-quests = Quests
gm-menu-desc-quests = Quests erstellen, bearbeiten und verwalten.
gm-menu-players = Spieler
gm-menu-desc-players = Spielerinventare verwalten und Charaktere bearbeiten.
gm-menu-approvals = Charaktergenehmigungen
gm-menu-desc-approvals = Charaktereinreichungen prüfen und genehmigen/ablehnen.

gm-title-quest-management = Spielleiter - Quest-Verwaltung
gm-desc-create-quest = Einen neuen Quest erstellen.
gm-msg-no-quests = Keine Quests gefunden.
gm-label-quest-locked = (Gesperrt)
gm-title-manage-quest = Quest verwalten - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Quest-Details wie Titel, Beschreibung und Gruppengröße bearbeiten.
gm-desc-toggle-ready = Bereitschaftsstatus umschalten (Aktuell: {"**"}{ $status }{"**"})
    - Sperrt die Quest-Liste und benachrichtigt Gruppenmitglieder, dass der Quest bald beginnt. Wenn eine Rolle konfiguriert ist, wird sie den Gruppenmitgliedern bei Sperrung zugewiesen.
    - Entsperrt die Liste, wenn auf Offen gesetzt.
gm-label-ready-locked = Gesperrt/Bereit
gm-label-ready-open = Offen
gm-desc-configure-rewards = Belohnungen für den ausgewählten Quest konfigurieren.
gm-desc-complete-quest = Einen Quest abschließen. Vergibt Belohnungen, falls vorhanden, an Gruppenmitglieder.
gm-desc-remove-player = Einen Spieler aus der Quest-Liste entfernen und benachrichtigen.
gm-desc-cancel-quest = Den Quest abbrechen und von der Quest-Tafel löschen.
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
gm-title-approvals = Spielleiter - Inventargenehmigungen
gm-desc-review-submission = Geben Sie eine Einreichungs-ID ein, um sie zu prüfen und zu genehmigen/ablehnen.
gm-title-reviewing = Prüfung: { $characterName }
gm-label-items = {"**"}Gegenstände:{"**"}
gm-label-currency = {"**"}Währung:{"**"}
gm-embed-title-approved = Inventaraktualisierung genehmigt
gm-embed-desc-approved = Das Inventar für {"**"}{ $characterName }{"**"} wurde von { $approver } genehmigt.
gm-embed-title-denied = Inventaraktualisierung abgelehnt
gm-embed-desc-denied = Das Inventar für {"**"}{ $characterName }{"**"} wurde von { $denier } abgelehnt.

gm-modal-label-select-party-role = Party Role
gm-modal-desc-select-party-role = Select a role to assign to the quest party.
gm-select-option-no-role = None (No Party Role)

gm-error-role-hierarchy = ReQuest cannot manage the role "{ $roleName }" (ID: { $roleId }) because it is positioned higher than ReQuest's highest role in the server hierarchy. Please contact a server administrator to move the role below ReQuest's role, or assign ReQuest a higher role, then retry the operation.
gm-dm-role-removal-failed =
    ⚠️ Failed to remove the role {"**"}{ $roleName }{"**"} from the following members: { $members }.
    Please notify a server administrator to remove the role manually.
