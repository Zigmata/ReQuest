## Player module strings

# --- Cog ---


# --- Buttons ---

# Character management
player-btn-register-character = Registrera ny karaktär
player-btn-activate = Aktivera
player-btn-active = Aktiv

# Player board
player-btn-create-post = Skapa inlägg
player-btn-open-starting-shop = Öppna startbutiken
player-btn-select-kit = Välj utrustningspaket
player-btn-input-inventory = Ange inventarie

# Wizard / shop buttons
player-btn-add-to-cart = Lägg i kundvagn
player-btn-add-to-cart-cost = Lägg i kundvagn ({ $costString })
player-btn-view-purchase-options = Visa köpalternativ
player-btn-review-submit = Granska och skicka ({ $count })
player-btn-submit-character = Skicka in karaktär
player-btn-keep-shopping = Fortsätt handla
player-btn-edit-quantity = Ändra antal
player-btn-clear-cart = Töm kundvagn

# Kit buttons
player-btn-confirm-selection = Bekräfta val
player-btn-back-to-kits = Tillbaka till utrustningspaket

# Inventory management
player-btn-spend-currency = Spendera valuta
player-btn-print-inventory = Skriv ut inventarie

# Container management
player-btn-manage-containers = Hantera behållare
player-btn-create-new = + Skapa ny
player-btn-consume-destroy = Konsumera/Förstör
player-btn-move = Flytta
player-btn-move-all = Flytta allt
player-btn-move-some = Flytta några...
player-btn-back-to-overview = ← Tillbaka till översikt
player-btn-cancel-move = ← Avbryt
player-btn-up = ▲ Upp
player-btn-down = ▼ Ner

# --- Modals ---

# Trade modal
player-modal-title-trade = Byter med { $targetName }
player-modal-label-trade-name = Namn
player-modal-placeholder-trade-name = Ange namnet på föremålet du byter
player-modal-label-trade-quantity = Antal
player-modal-placeholder-trade-quantity = Ange mängden du byter

# Character register modal
player-modal-title-register = Registrera ny karaktär
player-modal-label-char-name = Namn
player-modal-placeholder-char-name = Ange din karaktärs namn.
player-modal-label-char-note = Anteckning
player-modal-placeholder-char-note = Ange en anteckning för att identifiera din karaktär

# Open inventory input modal
player-modal-title-starting-inventory = Startinventariesinmatning
player-modal-label-inventory = Inventarie
player-modal-placeholder-inventory-input =
    Ett per rad i formatet <namn>: <antal>, t.ex.:
    Svärd: 1
    guld: 30

# Spend currency modal
player-modal-title-spend-currency = Spendera valuta
player-modal-label-currency-name = Valutanamn
player-modal-placeholder-currency-name = Ange namnet på valutan du spenderar
player-modal-label-currency-amount = Belopp
player-modal-placeholder-currency-amount = Ange beloppet att spendera

# Create player post modal
player-modal-title-create-post = Skapa spelartavleinlägg
player-modal-label-post-title = Titel
player-modal-placeholder-post-title = Ange en titel för ditt inlägg
player-modal-label-post-content = Inläggsinnehåll
player-modal-placeholder-post-content = Ange innehållet i ditt inlägg

# Edit player post modal
player-modal-title-edit-post = Redigera spelartavleinlägg

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = Ändra kundvagnsantal
player-modal-label-cart-qty = Antal
player-modal-placeholder-cart-qty = Ange nytt antal (0 för att ta bort)

# Create container modal
player-modal-title-create-container = Skapa ny behållare
player-modal-label-container-name = Behållarnamn
player-modal-placeholder-container-name = Ange ett namn för din behållare (t.ex. Ryggsäck)

# Rename container modal
player-modal-title-rename-container = Byt namn på behållare
player-modal-label-new-container-name = Nytt behållarnamn
player-modal-placeholder-new-container-name = Ange det nya namnet

# Consume from container modal
player-modal-title-consume = Konsumera/Förstör föremål
player-modal-label-consume-qty = Antal (max: { $maxQuantity })
player-modal-placeholder-consume-qty = Ange mängd att konsumera/förstöra

# Move item quantity modal
player-modal-title-move-item = Flytta föremål
player-modal-label-move-qty = Antal att flytta (max: { $maxQuantity })
player-modal-placeholder-move-qty = Ange mängd att flytta

# --- Selects ---

player-select-placeholder-no-characters = Du har inga registrerade karaktärer
player-select-placeholder-remove-character = Välj en karaktär att ta bort
player-select-placeholder-post = Välj ett inlägg
player-select-placeholder-container-view = Välj en behållare att visa...
player-select-placeholder-item = Välj ett föremål...
player-select-placeholder-destination = Välj destination...
player-select-placeholder-container = Välj en behållare...
player-select-option-no-containers = Inga behållare
player-select-option-no-items = Inga föremål
player-select-option-no-destinations = Inga destinationer

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}Spelarkommandon - Huvudmeny{"**"}
player-menu-btn-characters = Karaktärer
player-menu-desc-characters = Registrera, visa och aktivera spelarkaraktärer.
player-menu-btn-inventory = Inventarie
player-menu-desc-inventory = Visa din aktiva karaktärs inventarie och spendera valuta.
player-menu-btn-player-board = Spelartavla
player-menu-btn-player-board-disabled = Spelartavla (inte konfigurerad)
player-menu-desc-player-board = Skapa ett inlägg för spelartavlan

# CharacterBaseView
player-title-characters = {"**"}Spelarkommandon - Karaktärer{"**"}
player-desc-register-character = Registrera en ny karaktär.
player-msg-no-characters = Du har inga registrerade karaktärer.
player-label-active = (Aktiv)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Karaktär pågår: { $characterName }{"**"}
    Din karaktärsregistrering väntar på inventarieinställning.
player-btn-resume = Återuppta
player-btn-discard = Kassera
player-modal-title-discard-character = Kassera karaktär
player-modal-label-discard-confirm = Kassera { $characterName }?

# Confirm character removal
player-modal-title-confirm-char-removal = Bekräfta borttagning av karaktär
player-modal-label-confirm-char-delete = Radera { $characterName }?

# Confirm post removal
player-modal-title-confirm-post-removal = Bekräfta borttagning av inlägg
player-modal-label-post-removal-warning = VARNING: Denna åtgärd är oåterkallelig!

# InventoryOverviewView
player-title-inventory = {"**"}Spelarkommandon - Inventarie{"**"}
player-title-char-inventory = {"**"}{ $characterName }s inventarie{"**"}
player-msg-no-active-character = Ingen aktiv karaktär: Aktivera en karaktär för denna server för att använda dessa menyer.
player-msg-no-characters-registered = Inga karaktärer: Registrera en karaktär för att använda dessa menyer.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } föremål
player-label-currency = {"**"}Valuta{"**"}
player-msg-inventory-empty = Inventariet är tomt.

# Print inventory embed
player-embed-title-inventory = { $characterName }s inventarie

# ContainerItemsView
player-msg-container-empty = Denna behållare är tom.
player-label-selected-item = Valt: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Flytta "{ $itemName }"{"**"} ({ $available } tillgängliga)
player-msg-no-other-containers = Inga andra behållare tillgängliga.
player-msg-select-destination = Välj destinationsbehållare:
player-label-destination = Destination: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Hantera behållare{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } föremål){ $suffix }
player-label-default-suffix = { " " }(standard)
player-msg-no-containers = Inga behållare.
player-label-selected-container = Vald: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = Bekräfta radering av behållare
player-modal-label-container-has-items = Har { $itemCount } föremål. Flyttas till Lösa föremål.
player-modal-label-confirm-container-delete = Radera "{ $containerName }"?

# Container errors
player-error-cannot-rename-loose = Kan inte byta namn på Lösa föremål.
player-error-cannot-delete-loose = Kan inte radera Lösa föremål.

# PlayerBoardView
player-title-player-board = {"**"}Spelarkommandon - Spelartavla{"**"}
player-desc-create-post = Skapa ett nytt inlägg för spelartavlan.
player-msg-no-posts = Du har inga aktuella inlägg.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Författare
player-embed-footer-post-id = Inläggs-ID: { $postId }
player-error-board-channel-not-found = Spelartavlans kanal hittades inte.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Konfigurera inventarie för { $characterName }{"**"}
player-desc-browse-shop = Bläddra i startbutiken för att utrusta din karaktär.
player-desc-select-kit = Välj ett startutrustningspaket.
player-desc-input-inventory = Ange ditt startinventarie manuellt.

# StaticKitSelectView
player-title-select-kit = {"**"}Välj ett utrustningspaket för { $characterName }{"**"}
player-msg-no-kits = Inga startutrustningspaket är tillgängliga.
player-label-and-more-items = ...och { $count } föremål till
player-label-empty-kit = {"*"}Tomt utrustningspaket{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Bekräfta val: { $kitName }{"**"}
player-msg-kit-empty = Detta utrustningspaket är tomt.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Köpalternativ: { $itemName }{"**"}
player-msg-no-cost-options = Detta föremål har inga köpalternativ tillgängliga.
player-label-cost-option = {"**"}Alternativ { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Startbutik ({ $inventoryType }){"**"}
player-label-starting-wealth = Startförmögenhet: { $formattedCurrency }
player-label-in-cart = {"**"}(I kundvagn: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Granska kundvagn{"**"}
player-msg-cart-empty = Din kundvagn är tom.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Totalt: { $totalQuantity })
player-label-insufficient-currency = Otillräckligt { $currencyName }
player-label-total-cost = {"**"}Total kostnad:{"**"}
player-label-total-cost-free = {"**"}Total kostnad:{"**"} Gratis
player-label-cart-page = Sida { $current } av { $total }

# Trade embed
player-embed-title-trade = Bytesrapport
player-embed-desc-trade-sender = Avsändare: { $senderMention } som `{ $senderCharacter }`
player-embed-desc-trade-recipient = Mottagare: { $recipientMention } som `{ $recipientCharacter }`
player-embed-field-currency = Valuta
player-embed-field-amount = Belopp
player-embed-field-balance = { $characterName }s saldo
player-embed-field-item = Föremål
player-embed-field-quantity = Antal
player-embed-footer-transaction-id = Transaktions-ID: { $transactionId }

# Trade errors
player-error-trade-no-characters = Spelaren du försöker byta med har inga karaktärer!
player-error-trade-no-active = Spelaren du försöker byta med har ingen aktiv karaktär på denna server!

# Spend currency embed
player-embed-title-spend = Spelartransaktionsrapport
player-embed-desc-spend-player = Spelare: { $playerMention } som `{ $characterName }`
player-embed-desc-spend-transaction = Transaktion: {"**"}{ $characterName }{"**"} spenderade {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Kanal
player-embed-field-receipt = Kvitto

# Spend currency errors
player-error-amount-not-number = Beloppet måste vara ett nummer.
player-error-amount-positive = Du måste spendera ett positivt belopp.
player-error-amount-exceeds-maximum = Beloppet får inte överstiga { $max }.
player-error-no-active-character-server = Du har ingen aktiv karaktär på denna server.
player-error-no-currency-config = Ingen valutakonfiguration hittades för denna server.

# Consume item embed
player-embed-title-consume = Rapport om föremålskonsumtion
player-embed-desc-consume = Spelare: { $playerMention } som `{ $characterName }`
player-embed-desc-consume-removed = Borttaget: {"**"}{ $quantity }x { $itemName }{"**"} från {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = Antal måste vara ett positivt heltal.
player-error-qty-at-least-one = Antal måste vara minst 1.
player-error-qty-only-have = Du har bara { $maxQuantity } av detta föremål.

# Inventory input errors
player-error-invalid-format = Ogiltigt format: "{ $line }". Använd <namn>: <antal>.
player-error-empty-name = Föremålsnamn kan inte vara tomt i raden: "{ $line }".
player-error-invalid-quantity = Ogiltigt antal för "{ $name }": "{ $quantity }". Måste vara ett positivt heltal.

# Validation error view
player-validation-error-title = Inmatningsfel
player-validation-btn-retry = Försök igen

# Cart quantity validation
player-error-enter-valid-number = Ange ett giltigt positivt nummer.

# Submission embeds (approval queue)
player-embed-field-items = Föremål
player-embed-field-currency-received = Valuta
player-label-approval-thread = Godkännande: { $characterName }
player-embed-title-submission-sent = Inventarieinlämning skickad
player-embed-desc-submission-sent =
    Din inlämning för {"**"}{ $characterName }{"**"} har skickats till GM-teamet för godkännande!
    Du kommer att meddelas när den har granskats.
    [Visa inlämningstråd]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = Startinventarie tillämpat
player-embed-desc-starting-inventory = Spelare: { $playerMention } som `{ $characterName }`
player-embed-field-items-received = Mottagna föremål
player-embed-field-currency-received-label = Mottagen valuta
player-label-untitled = Utan titel

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventarieinlämning: { $characterName }{"**"}
    Inskickad av { $userMention }
player-approval-post-items = Föremål
player-approval-post-currency = Valuta
player-approval-resolved = Denna inlämning har behandlats.
player-approval-btn-approve = Godkänn
player-approval-btn-deny = Avslå
player-approval-btn-edit = Redigera
player-approval-error-no-permission = Du har inte behörighet för denna åtgärd.
player-approval-error-not-submitter = Endast den ursprungliga inlämnaren kan redigera denna inlämning.
player-approval-thread-instructions =
    Denna tråd skapades för godkännande av {"**"}{ $characterName }{"**"}.
    En spelledare kommer att granska inlämningen och godkänna eller avslå den.
    När den har godkänts eller avslagits kommer denna tråd att låsas.

    {"**"}Spelledare:{"**"} Diskutera eventuella nödvändiga ändringar med din
    spelare tills inventariet är i ett acceptabelt skick. Använd bara
    knappen `Avslå` för oförenliga inlämningar.

    { $playerMention }: Använd knappen `Redigera` för att göra eventuella
    ändringar som begärts här av en spelledare.
player-approval-approved-by = Denna inlämning godkändes av { $approver }.
player-approval-denied-by = Denna inlämning avslogs av { $denier }.
player-approval-deny-reason = Anledning: { $reason }
player-msg-submission-updated = Din inlämning har uppdaterats.


# Denial modal
player-modal-title-deny-reason = Avslå inlämning
player-modal-label-deny-reason = Anledning till avslag
player-modal-placeholder-deny-reason = Valfritt: förklara varför inlämningen avslogs
# Approval DM notifications
player-dm-title-approved = Karaktär godkänd
player-dm-desc-approved =
    Din karaktär {"**"}{ $characterName }{"**"} har godkänts
    av { $approver } i {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Karaktär avslagen
player-dm-desc-denied =
    Din karaktär {"**"}{ $characterName }{"**"} har avslagits
    av { $denier } i {"**"}{ $guildName }{"**"}.
