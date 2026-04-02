## Spielermodul-Zeichenketten

# --- Cog ---

player-cmd-name = Handeln
player-cmd-desc = Spielermenüs

# --- Schaltflächen ---

# Charakterverwaltung
player-btn-register-character = Neuen Charakter registrieren
player-btn-activate = Aktivieren
player-btn-active = Aktiv

# Spielertafel
player-btn-create-post = Beitrag erstellen
player-btn-open-starting-shop = Startershop öffnen
player-btn-select-kit = Set auswählen
player-btn-input-inventory = Inventar eingeben

# Assistenten-/Shop-Schaltflächen
player-btn-add-to-cart = In den Warenkorb
player-btn-add-to-cart-cost = In den Warenkorb ({ $costString })
player-btn-view-purchase-options = Kaufoptionen anzeigen
player-btn-review-submit = Prüfen & Einreichen ({ $count })
player-btn-submit-character = Charakter einreichen
player-btn-keep-shopping = Weiter einkaufen
player-btn-edit-quantity = Menge bearbeiten
player-btn-clear-cart = Warenkorb leeren

# Set-Schaltflächen
player-btn-confirm-selection = Auswahl bestätigen
player-btn-back-to-kits = Zurück zu den Sets

# Inventarverwaltung
player-btn-spend-currency = Währung ausgeben
player-btn-print-inventory = Inventar drucken

# Behälterverwaltung
player-btn-manage-containers = Behälter verwalten
player-btn-create-new = + Neu erstellen
player-btn-consume-destroy = Verbrauchen/Zerstören
player-btn-move = Verschieben
player-btn-move-all = Alles verschieben
player-btn-move-some = Teilweise verschieben...
player-btn-back-to-overview = ← Zurück zur Übersicht
player-btn-cancel-move = ← Abbrechen
player-btn-up = ▲ Hoch
player-btn-down = ▼ Runter

# --- Dialoge ---

# Handelsdialog
player-modal-title-trade = Handel mit { $targetName }
player-modal-label-trade-name = Name
player-modal-placeholder-trade-name = Geben Sie den Namen des Gegenstands ein, den Sie handeln
player-modal-label-trade-quantity = Menge
player-modal-placeholder-trade-quantity = Geben Sie die Menge ein, die Sie handeln

# Charakter-Registrierungsdialog
player-modal-title-register = Neuen Charakter registrieren
player-modal-label-char-name = Name
player-modal-placeholder-char-name = Geben Sie den Namen Ihres Charakters ein.
player-modal-label-char-note = Notiz
player-modal-placeholder-char-note = Geben Sie eine Notiz zur Identifizierung Ihres Charakters ein

# Offener Inventareingabedialog
player-modal-title-starting-inventory = Startinventar eingeben
player-modal-label-inventory = Inventar
player-modal-placeholder-inventory-input =
    Eines pro Zeile im Format <Name>: <Menge>, z.B.:
    Schwert: 1
    Gold: 30

# Währung-ausgeben-Dialog
player-modal-title-spend-currency = Währung ausgeben
player-modal-label-currency-name = Währungsname
player-modal-placeholder-currency-name = Geben Sie den Namen der Währung ein, die Sie ausgeben
player-modal-label-currency-amount = Betrag
player-modal-placeholder-currency-amount = Geben Sie den auszugebenden Betrag ein

# Spielertafel-Beitrag-erstellen-Dialog
player-modal-title-create-post = Spielertafel-Beitrag erstellen
player-modal-label-post-title = Titel
player-modal-placeholder-post-title = Geben Sie einen Titel für Ihren Beitrag ein
player-modal-label-post-content = Beitragsinhalt
player-modal-placeholder-post-content = Geben Sie den Inhalt Ihres Beitrags ein

# Spielertafel-Beitrag-bearbeiten-Dialog
player-modal-title-edit-post = Spielertafel-Beitrag bearbeiten

# Assistenten-Warenkorb-Menge-bearbeiten-Dialog
player-modal-title-edit-cart-qty = Warenkorbmenge bearbeiten
player-modal-label-cart-qty = Menge
player-modal-placeholder-cart-qty = Neue Menge eingeben (0 zum Entfernen)

# Behälter-erstellen-Dialog
player-modal-title-create-container = Neuen Behälter erstellen
player-modal-label-container-name = Behältername
player-modal-placeholder-container-name = Geben Sie einen Namen für Ihren Behälter ein (z.B. Rucksack)

# Behälter-umbenennen-Dialog
player-modal-title-rename-container = Behälter umbenennen
player-modal-label-new-container-name = Neuer Behältername
player-modal-placeholder-new-container-name = Geben Sie den neuen Namen ein

# Verbrauchen-aus-Behälter-Dialog
player-modal-title-consume = Gegenstand verbrauchen/zerstören
player-modal-label-consume-qty = Menge (max: { $maxQuantity })
player-modal-placeholder-consume-qty = Geben Sie die zu verbrauchende/zerstörende Menge ein

# Gegenstand-verschieben-Menge-Dialog
player-modal-title-move-item = Gegenstand verschieben
player-modal-label-move-qty = Zu verschiebende Menge (max: { $maxQuantity })
player-modal-placeholder-move-qty = Geben Sie die zu verschiebende Menge ein

# --- Auswahlmenüs ---

player-select-placeholder-no-characters = Sie haben keine registrierten Charaktere
player-select-placeholder-remove-character = Charakter zum Entfernen auswählen
player-select-placeholder-post = Beitrag auswählen
player-select-placeholder-container-view = Behälter zum Anzeigen auswählen...
player-select-placeholder-item = Gegenstand auswählen...
player-select-placeholder-destination = Ziel auswählen...
player-select-placeholder-container = Behälter auswählen...
player-select-option-no-containers = Keine Behälter
player-select-option-no-items = Keine Gegenstände
player-select-option-no-destinations = Keine Ziele

# --- Ansichten ---

# PlayerBaseView - Hauptmenü
player-title-main-menu = {"**"}Spielerbefehle - Hauptmenü{"**"}
player-menu-btn-characters = Charaktere
player-menu-desc-characters = Spielercharaktere registrieren, anzeigen und aktivieren.
player-menu-btn-inventory = Inventar
player-menu-desc-inventory = Inventar Ihres aktiven Charakters anzeigen und Währung ausgeben.
player-menu-btn-player-board = Spielertafel
player-menu-btn-player-board-disabled = Spielertafel (Nicht konfiguriert)
player-menu-desc-player-board = Einen Beitrag für die Spielertafel erstellen

# CharacterBaseView
player-title-characters = {"**"}Spielerbefehle - Charaktere{"**"}
player-desc-register-character = Einen neuen Charakter registrieren.
player-msg-no-characters = Sie haben keine registrierten Charaktere.
player-label-active = (Aktiv)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Charakter in Bearbeitung: { $characterName }{"**"}
    Deine Charakterregistrierung wartet auf die Inventareinrichtung.
player-btn-resume = Fortsetzen
player-btn-discard = Verwerfen
player-modal-title-discard-character = Charakter verwerfen
player-modal-label-discard-confirm = { $characterName } verwerfen?

# Charakterentfernung bestätigen
player-modal-title-confirm-char-removal = Charakterentfernung bestätigen
player-modal-label-confirm-char-delete = { $characterName } löschen?

# Beitragsentfernung bestätigen
player-modal-title-confirm-post-removal = Beitragsentfernung bestätigen
player-modal-label-post-removal-warning = WARNUNG: Diese Aktion ist unwiderruflich!

# InventoryOverviewView
player-title-inventory = {"**"}Spielerbefehle - Inventar{"**"}
player-title-char-inventory = {"**"}Inventar von { $characterName }{"**"}
player-msg-no-active-character = Kein aktiver Charakter: Aktivieren Sie einen Charakter für diesen Server, um diese Menüs zu verwenden.
player-msg-no-characters-registered = Keine Charaktere: Registrieren Sie einen Charakter, um diese Menüs zu verwenden.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } Gegenstände
player-label-currency = {"**"}Währung{"**"}
player-msg-inventory-empty = Das Inventar ist leer.

# Inventar-Einbettung drucken
player-embed-title-inventory = Inventar von { $characterName }

# ContainerItemsView
player-msg-container-empty = Dieser Behälter ist leer.
player-label-selected-item = Ausgewählt: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}"{ $itemName }" verschieben{"**"} ({ $available } verfügbar)
player-msg-no-other-containers = Keine anderen Behälter verfügbar.
player-msg-select-destination = Zielbehälter auswählen:
player-label-destination = Ziel: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Behälter verwalten{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } Gegenstände){ $suffix }
player-label-default-suffix = { " " }(Standard)
player-msg-no-containers = Keine Behälter.
player-label-selected-container = Ausgewählt: {"**"}{ $containerName }{"**"}

# Behälterlöschung bestätigen
player-modal-title-confirm-container-delete = Behälterlöschung bestätigen
player-modal-label-container-has-items = Enthält { $itemCount } Gegenstände. Werden zu Lose Gegenstände verschoben.
player-modal-label-confirm-container-delete = "{ $containerName }" löschen?

# Behälterfehler
player-error-cannot-rename-loose = Lose Gegenstände können nicht umbenannt werden.
player-error-cannot-delete-loose = Lose Gegenstände können nicht gelöscht werden.

# PlayerBoardView
player-title-player-board = {"**"}Spielerbefehle - Spielertafel{"**"}
player-desc-create-post = Einen neuen Beitrag für die Spielertafel erstellen.
player-msg-no-posts = Sie haben keine aktuellen Beiträge.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Autor
player-embed-footer-post-id = Beitrags-ID: { $postId }
player-error-board-channel-not-found = Spielertafel-Kanal nicht gefunden.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Inventar einrichten für { $characterName }{"**"}
player-desc-browse-shop = Durchsuchen Sie den Startershop, um Ihren Charakter auszurüsten.
player-desc-select-kit = Wählen Sie ein Starterpaket aus.
player-desc-input-inventory = Geben Sie Ihr Startinventar manuell ein.

# StaticKitSelectView
player-title-select-kit = {"**"}Set auswählen für { $characterName }{"**"}
player-msg-no-kits = Keine Starterpakete verfügbar.
player-label-and-more-items = ...und { $count } weitere Gegenstände
player-label-empty-kit = {"*"}Leeres Set{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Auswahl bestätigen: { $kitName }{"**"}
player-label-items-heading = {"**"}Gegenstände:{"**"}
player-label-currency-heading = {"**"}Währung:{"**"}
player-msg-kit-empty = Dieses Set ist leer.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Kaufoptionen: { $itemName }{"**"}
player-msg-no-cost-options = Für diesen Gegenstand sind keine Kaufoptionen verfügbar.
player-label-cost-option = {"**"}Option { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Startershop ({ $inventoryType }){"**"}
player-label-starting-wealth = Startvermögen: { $formattedCurrency }
player-label-in-cart = {"**"}(Im Warenkorb: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Warenkorb prüfen{"**"}
player-msg-cart-empty = Ihr Warenkorb ist leer.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Gesamt: { $totalQuantity })
player-label-insufficient-currency = Unzureichend { $currencyName }
player-label-total-cost = {"**"}Gesamtkosten:{"**"}
player-label-total-cost-free = {"**"}Gesamtkosten:{"**"} Kostenlos
player-label-cart-page = Seite { $current } von { $total }

# Handelseinbettung
player-embed-title-trade = Handelsbericht
player-embed-desc-trade-sender = Absender: { $senderMention } als `{ $senderCharacter }`
player-embed-desc-trade-recipient = Empfänger: { $recipientMention } als `{ $recipientCharacter }`
player-embed-field-currency = Währung
player-embed-field-amount = Betrag
player-embed-field-balance = Guthaben von { $characterName }
player-embed-field-item = Gegenstand
player-embed-field-quantity = Menge
player-embed-footer-transaction-id = Transaktions-ID: { $transactionId }

# Handelsfehler
player-error-trade-no-characters = Der Spieler, mit dem Sie handeln möchten, hat keine Charaktere!
player-error-trade-no-active = Der Spieler, mit dem Sie handeln möchten, hat keinen aktiven Charakter auf diesem Server!

# Währung-ausgeben-Einbettung
player-embed-title-spend = Spieler-Transaktionsbericht
player-embed-desc-spend-player = Spieler: { $playerMention } als `{ $characterName }`
player-embed-desc-spend-transaction = Transaktion: {"**"}{ $characterName }{"**"} hat {"**"}{ $formattedAmount }{"**"} ausgegeben.
player-embed-field-channel = Kanal
player-embed-field-receipt = Beleg

# Währung-ausgeben-Fehler
player-error-amount-not-number = Der Betrag muss eine Zahl sein.
player-error-amount-positive = Sie müssen einen positiven Betrag ausgeben.
player-error-amount-exceeds-maximum = Der Betrag darf { $max } nicht überschreiten.
player-error-no-active-character-server = Sie haben keinen aktiven Charakter auf diesem Server.
player-error-no-currency-config = Für diesen Server wurde keine Währungskonfiguration gefunden.

# Gegenstand-verbrauchen-Einbettung
player-embed-title-consume = Gegenstandsverbrauchsbericht
player-embed-desc-consume = Spieler: { $playerMention } als `{ $characterName }`
player-embed-desc-consume-removed = Entfernt: {"**"}{ $quantity }x { $itemName }{"**"} aus {"**"}{ $containerName }{"**"}

# Gegenstand-verbrauchen-Fehler
player-error-qty-positive-integer = Die Menge muss eine positive Ganzzahl sein.
player-error-qty-at-least-one = Die Menge muss mindestens 1 betragen.
player-error-qty-only-have = Sie haben nur { $maxQuantity } von diesem Gegenstand.

# Inventareingabefehler
player-error-invalid-format = Ungültiges Format: "{ $line }". Verwenden Sie <Name>: <Menge>.
player-error-empty-name = Gegenstandsname darf in Zeile "{ $line }" nicht leer sein.
player-error-invalid-quantity = Ungültige Menge für "{ $name }": "{ $quantity }". Muss eine positive Ganzzahl sein.
player-error-input-errors-header = Fehler bei der Inventareingabe:
player-msg-no-valid-items = Keine gültigen Gegenstände angegeben. Initialisierung mit leerem Inventar.

# Warenkorbmengen-Validierung
player-error-enter-valid-number = Bitte geben Sie eine gültige positive Zahl ein.

# Einreichungseinbettungen (Genehmigungswarteschlange)
player-embed-title-approval = Inventargenehmigung: { $characterName }
player-embed-desc-submitted-by = Eingereicht von { $userMention }
player-embed-field-items = Gegenstände
player-embed-field-currency-received = Währung
player-embed-footer-submission-id = Einreichungs-ID: { $submissionId }
player-label-approval-thread = Genehmigung: { $characterName }
player-embed-title-submission-sent = Inventareinreichung gesendet
player-embed-desc-submission-sent =
    Ihre Einreichung für {"**"}{ $characterName }{"**"} wurde zur Genehmigung an das GM-Team gesendet!
    Sie werden benachrichtigt, sobald sie geprüft wurde.
    [Einreichungs-Thread anzeigen]({ $threadUrl })

# Direkte Anwendung (keine Genehmigungswarteschlange)
player-embed-title-starting-inventory = Startinventar angewendet
player-embed-desc-starting-inventory = Spieler: { $playerMention } als `{ $characterName }`
player-embed-field-items-received = Erhaltene Gegenstände
player-embed-field-currency-received-label = Erhaltene Währung
player-label-untitled = Ohne Titel

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventory Submission: { $characterName }{"**"}
    Submitted by { $userMention }
player-approval-post-items = Gegenstände
player-approval-post-currency = Währung
player-approval-resolved = Diese Einreichung wurde bearbeitet.
player-approval-btn-approve = Genehmigen
player-approval-btn-deny = Ablehnen
player-approval-btn-edit = Bearbeiten
player-approval-error-no-permission = Du hast keine Berechtigung für diese Aktion.
player-approval-error-not-submitter = Nur der ursprüngliche Einreicher kann diese Einreichung bearbeiten.
player-approval-thread-instructions =
    This thread was created for the approval of {"**"}{ $characterName }{"**"}.
    A Game Master will review the submission and approve or deny it.
    Once approved or denied, this thread will be locked.

    {"**"}Game Masters:{"**"} Discuss any required changes with your
    player until the inventory is in an acceptable state. Only use
    the `Deny` button for irreconcilable submissions.

    { $playerMention }: Use the `Edit` button to make any changes
    requested here by a Game Master.
player-approval-approved-by = Diese Einreichung wurde von { $approver } genehmigt.
player-approval-denied-by = Diese Einreichung wurde von { $denier } abgelehnt.
player-approval-deny-reason = Grund: { $reason }
player-msg-submission-updated = Deine Einreichung wurde aktualisiert.


# Denial modal
player-modal-title-deny-reason = Einreichung ablehnen
player-modal-label-deny-reason = Grund der Ablehnung
player-modal-placeholder-deny-reason = Optional: Grund der Ablehnung angeben
# Approval DM notifications
player-dm-title-approved = Charakter genehmigt
player-dm-desc-approved =
    Your character {"**"}{ $characterName }{"**"} has been approved
    by { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Charakter abgelehnt
player-dm-desc-denied =
    Your character {"**"}{ $characterName }{"**"} has been denied
    by { $denier } in {"**"}{ $guildName }{"**"}.
