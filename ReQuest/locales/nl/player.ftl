## Player module strings

# --- Cog ---


# --- Buttons ---

# Character management
player-btn-register-character = Nieuw personage registreren
player-btn-activate = Activeren
player-btn-active = Actief

# Player board
player-btn-create-post = Bericht aanmaken
player-btn-open-starting-shop = Startwinkel openen
player-btn-select-kit = Kit selecteren
player-btn-input-inventory = Inventaris invoeren

# Wizard / shop buttons
player-btn-add-to-cart = Aan winkelwagen toevoegen
player-btn-add-to-cart-cost = Aan winkelwagen toevoegen ({ $costString })
player-btn-view-purchase-options = Aankoopopties bekijken
player-btn-review-submit = Beoordelen & indienen ({ $count })
player-btn-submit-character = Personage indienen
player-btn-keep-shopping = Verder winkelen
player-btn-edit-quantity = Hoeveelheid bewerken
player-btn-clear-cart = Winkelwagen legen

# Kit buttons
player-btn-confirm-selection = Selectie bevestigen
player-btn-back-to-kits = Terug naar kits

# Inventory management
player-btn-spend-currency = Valuta uitgeven
player-btn-print-inventory = Inventaris afdrukken

# Container management
player-btn-manage-containers = Containers beheren
player-btn-create-new = + Nieuwe aanmaken
player-btn-consume-destroy = Verbruiken/Vernietigen
player-btn-move = Verplaatsen
player-btn-move-all = Alles verplaatsen
player-btn-move-some = Aantal verplaatsen...
player-btn-back-to-overview = ← Terug naar overzicht
player-btn-cancel-move = ← Annuleren
player-btn-up = ▲ Omhoog
player-btn-down = ▼ Omlaag

# --- Modals ---

# Trade modal
player-modal-title-trade = Handelen met { $targetName }
player-modal-label-trade-name = Naam
player-modal-placeholder-trade-name = Voer de naam in van het voorwerp dat je verhandelt
player-modal-label-trade-quantity = Hoeveelheid
player-modal-placeholder-trade-quantity = Voer het aantal in dat je verhandelt

# Character register modal
player-modal-title-register = Nieuw personage registreren
player-modal-label-char-name = Naam
player-modal-placeholder-char-name = Voer de naam van je personage in.
player-modal-label-char-note = Notitie
player-modal-placeholder-char-note = Voer een notitie in om je personage te identificeren

# Open inventory input modal
player-modal-title-starting-inventory = Startinventaris invoeren
player-modal-label-inventory = Inventaris
player-modal-placeholder-inventory-input =
    Eén per regel in <naam>: <hoeveelheid> formaat, bijv.:
    Zwaard: 1
    goud: 30

# Spend currency modal
player-modal-title-spend-currency = Valuta uitgeven
player-modal-label-currency-name = Valutanaam
player-modal-placeholder-currency-name = Voer de naam in van de valuta die je uitgeeft
player-modal-label-currency-amount = Bedrag
player-modal-placeholder-currency-amount = Voer het uit te geven bedrag in

# Create player post modal
player-modal-title-create-post = Spelerbord-bericht aanmaken
player-modal-label-post-title = Titel
player-modal-placeholder-post-title = Voer een titel in voor je bericht
player-modal-label-post-content = Berichtinhoud
player-modal-placeholder-post-content = Voer de inhoud van je bericht in

# Edit player post modal
player-modal-title-edit-post = Spelerbord-bericht bewerken

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = Winkelwagenhoeveelheid bewerken
player-modal-label-cart-qty = Hoeveelheid
player-modal-placeholder-cart-qty = Voer nieuwe hoeveelheid in (0 om te verwijderen)

# Create container modal
player-modal-title-create-container = Nieuwe container aanmaken
player-modal-label-container-name = Containernaam
player-modal-placeholder-container-name = Voer een naam in voor je container (bijv. Rugzak)

# Rename container modal
player-modal-title-rename-container = Container hernoemen
player-modal-label-new-container-name = Nieuwe containernaam
player-modal-placeholder-new-container-name = Voer de nieuwe naam in

# Consume from container modal
player-modal-title-consume = Voorwerp verbruiken/vernietigen
player-modal-label-consume-qty = Hoeveelheid (max: { $maxQuantity })
player-modal-placeholder-consume-qty = Voer het aantal in om te verbruiken/vernietigen

# Move item quantity modal
player-modal-title-move-item = Voorwerp verplaatsen
player-modal-label-move-qty = Te verplaatsen hoeveelheid (max: { $maxQuantity })
player-modal-placeholder-move-qty = Voer het te verplaatsen aantal in

# --- Selects ---

player-select-placeholder-no-characters = Je hebt geen geregistreerde personages
player-select-placeholder-remove-character = Selecteer een personage om te verwijderen
player-select-placeholder-post = Selecteer een bericht
player-select-placeholder-container-view = Selecteer een container om te bekijken...
player-select-placeholder-item = Selecteer een voorwerp...
player-select-placeholder-destination = Selecteer bestemming...
player-select-placeholder-container = Selecteer een container...
player-select-option-no-containers = Geen containers
player-select-option-no-items = Geen voorwerpen
player-select-option-no-destinations = Geen bestemmingen

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}Spelercommando's - Hoofdmenu{"**"}
player-menu-btn-characters = Personages
player-menu-desc-characters = Registreer, bekijk en activeer spelerpersonages.
player-menu-btn-inventory = Inventaris
player-menu-desc-inventory = Bekijk de inventaris van je actieve personage en geef valuta uit.
player-menu-btn-player-board = Spelerbord
player-menu-btn-player-board-disabled = Spelerbord (niet geconfigureerd)
player-menu-desc-player-board = Maak een bericht aan voor het spelerbord

# CharacterBaseView
player-title-characters = {"**"}Spelercommando's - Personages{"**"}
player-desc-register-character = Registreer een nieuw personage.
player-msg-no-characters = Je hebt geen geregistreerde personages.
player-label-active = (Actief)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Karakter in voortgang: { $characterName }{"**"}
    Je karakterregistratie wacht op inventarisconfiguratie.
player-btn-resume = Hervatten
player-btn-discard = Verwijderen
player-modal-title-discard-character = Karakter verwijderen
player-modal-label-discard-confirm = { $characterName } verwijderen?

# Confirm character removal
player-modal-title-confirm-char-removal = Bevestig personageverwijdering
player-modal-label-confirm-char-delete = { $characterName } verwijderen?

# Confirm post removal
player-modal-title-confirm-post-removal = Bevestig berichtverwijdering
player-modal-label-post-removal-warning = WAARSCHUWING: Deze actie is onomkeerbaar!

# InventoryOverviewView
player-title-inventory = {"**"}Spelercommando's - Inventaris{"**"}
player-title-char-inventory = {"**"}Inventaris van { $characterName }{"**"}
player-msg-no-active-character = Geen actief personage: Activeer een personage voor deze server om deze menu's te gebruiken.
player-msg-no-characters-registered = Geen personages: Registreer een personage om deze menu's te gebruiken.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } voorwerpen
player-label-currency = {"**"}Valuta{"**"}
player-msg-inventory-empty = Inventaris is leeg.

# Print inventory embed
player-embed-title-inventory = Inventaris van { $characterName }

# ContainerItemsView
player-msg-container-empty = Deze container is leeg.
player-label-selected-item = Geselecteerd: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}"{ $itemName }" verplaatsen{"**"} ({ $available } beschikbaar)
player-msg-no-other-containers = Geen andere containers beschikbaar.
player-msg-select-destination = Selecteer doelcontainer:
player-label-destination = Bestemming: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Containers beheren{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } voorwerpen){ $suffix }
player-label-default-suffix = { " " }(standaard)
player-msg-no-containers = Geen containers.
player-label-selected-container = Geselecteerd: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = Bevestig containerverwijdering
player-modal-label-container-has-items = Bevat { $itemCount } voorwerpen. Worden verplaatst naar Losse voorwerpen.
player-modal-label-confirm-container-delete = "{ $containerName }" verwijderen?

# Container errors
player-error-cannot-rename-loose = Kan Losse voorwerpen niet hernoemen.
player-error-cannot-delete-loose = Kan Losse voorwerpen niet verwijderen.

# PlayerBoardView
player-title-player-board = {"**"}Spelercommando's - Spelerbord{"**"}
player-desc-create-post = Maak een nieuw bericht aan voor het spelerbord.
player-msg-no-posts = Je hebt geen huidige berichten.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Auteur
player-embed-footer-post-id = Bericht-ID: { $postId }
player-error-board-channel-not-found = Spelerbord-kanaal niet gevonden.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Inventaris instellen voor { $characterName }{"**"}
player-desc-browse-shop = Blader door de startwinkel om je personage uit te rusten.
player-desc-select-kit = Selecteer een starterkit.
player-desc-input-inventory = Voer handmatig je startinventaris in.

# StaticKitSelectView
player-title-select-kit = {"**"}Selecteer een kit voor { $characterName }{"**"}
player-msg-no-kits = Er zijn geen starterkits beschikbaar.
player-label-and-more-items = ...en { $count } meer voorwerpen
player-label-empty-kit = {"*"}Lege kit{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Selectie bevestigen: { $kitName }{"**"}
player-msg-kit-empty = Deze kit is leeg.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Aankoopopties: { $itemName }{"**"}
player-msg-no-cost-options = Dit voorwerp heeft geen beschikbare kostenopties.
player-label-cost-option = {"**"}Optie { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Startwinkel ({ $inventoryType }){"**"}
player-label-starting-wealth = Startkapitaal: { $formattedCurrency }
player-label-in-cart = {"**"}(In winkelwagen: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Winkelwagen bekijken{"**"}
player-msg-cart-empty = Je winkelwagen is leeg.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Totaal: { $totalQuantity })
player-label-insufficient-currency = Onvoldoende { $currencyName }
player-label-total-cost = {"**"}Totale kosten:{"**"}
player-label-total-cost-free = {"**"}Totale kosten:{"**"} Gratis
player-label-cart-page = Pagina { $current } van { $total }

# Trade embed
player-embed-title-trade = Handelsrapport
player-embed-desc-trade-sender = Afzender: { $senderMention } als `{ $senderCharacter }`
player-embed-desc-trade-recipient = Ontvanger: { $recipientMention } als `{ $recipientCharacter }`
player-embed-field-currency = Valuta
player-embed-field-amount = Bedrag
player-embed-field-balance = Saldo van { $characterName }
player-embed-field-item = Voorwerp
player-embed-field-quantity = Hoeveelheid
player-embed-footer-transaction-id = Transactie-ID: { $transactionId }

# Trade errors
player-error-trade-no-characters = De speler waarmee je probeert te handelen heeft geen personages!
player-error-trade-no-active = De speler waarmee je probeert te handelen heeft geen actief personage op deze server!

# Spend currency embed
player-embed-title-spend = Spelertransactierapport
player-embed-desc-spend-player = Speler: { $playerMention } als `{ $characterName }`
player-embed-desc-spend-transaction = Transactie: {"**"}{ $characterName }{"**"} heeft {"**"}{ $formattedAmount }{"**"} uitgegeven.
player-embed-field-channel = Kanaal
player-embed-field-receipt = Bewijs

# Spend currency errors
player-error-amount-not-number = Bedrag moet een getal zijn.
player-error-amount-positive = Je moet een positief bedrag uitgeven.
player-error-amount-exceeds-maximum = Het bedrag mag niet hoger zijn dan { $max }.
player-error-no-active-character-server = Je hebt geen actief personage op deze server.
player-error-no-currency-config = Er is geen valutaconfiguratie gevonden voor deze server.

# Consume item embed
player-embed-title-consume = Voorwerpverbruiksrapport
player-embed-desc-consume = Speler: { $playerMention } als `{ $characterName }`
player-embed-desc-consume-removed = Verwijderd: {"**"}{ $quantity }x { $itemName }{"**"} uit {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = Hoeveelheid moet een positief geheel getal zijn.
player-error-qty-at-least-one = Hoeveelheid moet minimaal 1 zijn.
player-error-qty-only-have = Je hebt slechts { $maxQuantity } van dit voorwerp.

# Inventory input errors
player-error-invalid-format = Ongeldig formaat: "{ $line }". Gebruik <naam>: <hoeveelheid>.
player-error-empty-name = Voorwerpnaam mag niet leeg zijn in regel: "{ $line }".
player-error-invalid-quantity = Ongeldige hoeveelheid voor "{ $name }": "{ $quantity }". Moet een positief geheel getal zijn.

# Validation error view
player-validation-error-title = Invoerfouten
player-validation-btn-retry = Opnieuw proberen

# Cart quantity validation
player-error-enter-valid-number = Voer een geldig positief getal in.

# Submission embeds (approval queue)
player-embed-field-items = Voorwerpen
player-embed-field-currency-received = Valuta
player-label-approval-thread = Goedkeuring: { $characterName }
player-embed-title-submission-sent = Inventarisinzending verstuurd
player-embed-desc-submission-sent =
    Je inzending voor {"**"}{ $characterName }{"**"} is ter goedkeuring naar het GM-team gestuurd!
    Je ontvangt een melding zodra deze is beoordeeld.
    [Inzendingstopic bekijken]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = Startinventaris toegepast
player-embed-desc-starting-inventory = Speler: { $playerMention } als `{ $characterName }`
player-embed-field-items-received = Ontvangen voorwerpen
player-embed-field-currency-received-label = Ontvangen valuta
player-label-untitled = Zonder titel

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventarisinzending: { $characterName }{"**"}
    Ingediend door { $userMention }
player-approval-post-items = Voorwerpen
player-approval-post-currency = Valuta
player-approval-resolved = Deze inzending is afgehandeld.
player-approval-btn-approve = Goedkeuren
player-approval-btn-deny = Afwijzen
player-approval-btn-edit = Bewerken
player-approval-error-no-permission = Je hebt geen toestemming voor deze actie.
player-approval-error-not-submitter = Alleen de originele indiener kan deze inzending bewerken.
player-approval-thread-instructions =
    Deze thread is aangemaakt voor de goedkeuring van {"**"}{ $characterName }{"**"}.
    Een Game Master zal de inzending beoordelen en goedkeuren of afwijzen.
    Na goedkeuring of afwijzing wordt deze thread vergrendeld.

    {"**"}Game Masters:{"**"} Bespreek eventuele vereiste wijzigingen met je
    speler totdat de inventaris in een acceptabele staat is. Gebruik de
    `Afwijzen`-knop alleen voor onverenigbare inzendingen.

    { $playerMention }: Gebruik de `Bewerken`-knop om wijzigingen aan te
    brengen die hier door een Game Master zijn gevraagd.
player-approval-approved-by = Deze inzending is goedgekeurd door { $approver }.
player-approval-denied-by = Deze inzending is afgewezen door { $denier }.
player-approval-deny-reason = Reden: { $reason }
player-msg-submission-updated = Je inzending is bijgewerkt.


# Denial modal
player-modal-title-deny-reason = Inzending afwijzen
player-modal-label-deny-reason = Reden van afwijzing
player-modal-placeholder-deny-reason = Optioneel: leg uit waarom de inzending is afgewezen
# Approval DM notifications
player-dm-title-approved = Karakter goedgekeurd
player-dm-desc-approved =
    Je personage {"**"}{ $characterName }{"**"} is goedgekeurd
    door { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Karakter afgewezen
player-dm-desc-denied =
    Je personage {"**"}{ $characterName }{"**"} is afgewezen
    door { $denier } in {"**"}{ $guildName }{"**"}.
