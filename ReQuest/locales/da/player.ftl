## Player module strings

# --- Cog ---

player-cmd-name = Byt
player-cmd-desc = Spillermenuer

# --- Buttons ---

# Character management
player-btn-register-character = Registrer ny karakter
player-btn-activate = Aktiver
player-btn-active = Aktiv

# Player board
player-btn-create-post = Opret opslag
player-btn-open-starting-shop = Åbn startbutik
player-btn-select-kit = Vælg pakke
player-btn-input-inventory = Indtast inventar

# Wizard / shop buttons
player-btn-add-to-cart = Læg i kurv
player-btn-add-to-cart-cost = Læg i kurv ({ $costString })
player-btn-view-purchase-options = Se købsmuligheder
player-btn-review-submit = Gennemgå og indsend ({ $count })
player-btn-submit-character = Indsend karakter
player-btn-keep-shopping = Fortsæt med at handle
player-btn-edit-quantity = Rediger antal
player-btn-clear-cart = Tøm kurv

# Kit buttons
player-btn-confirm-selection = Bekræft valg
player-btn-back-to-kits = Tilbage til pakker

# Inventory management
player-btn-spend-currency = Brug valuta
player-btn-print-inventory = Udskriv inventar

# Container management
player-btn-manage-containers = Administrer beholdere
player-btn-create-new = + Opret ny
player-btn-consume-destroy = Forbrug/Ødelæg
player-btn-move = Flyt
player-btn-move-all = Flyt alt
player-btn-move-some = Flyt noget...
player-btn-back-to-overview = ← Tilbage til oversigt
player-btn-cancel-move = ← Annuller
player-btn-up = ▲ Op
player-btn-down = ▼ Ned

# --- Modals ---

# Trade modal
player-modal-title-trade = Handler med { $targetName }
player-modal-label-trade-name = Navn
player-modal-placeholder-trade-name = Indtast navnet på den genstand du handler
player-modal-label-trade-quantity = Antal
player-modal-placeholder-trade-quantity = Indtast det antal du handler

# Character register modal
player-modal-title-register = Registrer ny karakter
player-modal-label-char-name = Navn
player-modal-placeholder-char-name = Indtast din karakters navn.
player-modal-label-char-note = Note
player-modal-placeholder-char-note = Indtast en note til at identificere din karakter

# Open inventory input modal
player-modal-title-starting-inventory = Startinventar-indtastning
player-modal-label-inventory = Inventar
player-modal-placeholder-inventory-input =
    Én per linje i <navn>: <antal> format, f.eks.:
    Sværd: 1
    guld: 30

# Spend currency modal
player-modal-title-spend-currency = Brug valuta
player-modal-label-currency-name = Valutanavn
player-modal-placeholder-currency-name = Indtast navnet på den valuta du bruger
player-modal-label-currency-amount = Beløb
player-modal-placeholder-currency-amount = Indtast beløbet der skal bruges

# Create player post modal
player-modal-title-create-post = Opret spillertavleopslag
player-modal-label-post-title = Titel
player-modal-placeholder-post-title = Indtast en titel til dit opslag
player-modal-label-post-content = Opslagsindhold
player-modal-placeholder-post-content = Indtast indholdet af dit opslag

# Edit player post modal
player-modal-title-edit-post = Rediger spillertavleopslag

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = Rediger kurvantal
player-modal-label-cart-qty = Antal
player-modal-placeholder-cart-qty = Indtast nyt antal (0 for at fjerne)

# Create container modal
player-modal-title-create-container = Opret ny beholder
player-modal-label-container-name = Beholdernavn
player-modal-placeholder-container-name = Indtast et navn til din beholder (f.eks. Rygsæk)

# Rename container modal
player-modal-title-rename-container = Omdøb beholder
player-modal-label-new-container-name = Nyt beholdernavn
player-modal-placeholder-new-container-name = Indtast det nye navn

# Consume from container modal
player-modal-title-consume = Forbrug/Ødelæg genstand
player-modal-label-consume-qty = Antal (maks.: { $maxQuantity })
player-modal-placeholder-consume-qty = Indtast antal der skal forbruges/ødelægges

# Move item quantity modal
player-modal-title-move-item = Flyt genstand
player-modal-label-move-qty = Antal der skal flyttes (maks.: { $maxQuantity })
player-modal-placeholder-move-qty = Indtast antal der skal flyttes

# --- Selects ---

player-select-placeholder-no-characters = Du har ingen registrerede karakterer
player-select-placeholder-remove-character = Vælg en karakter at fjerne
player-select-placeholder-post = Vælg et opslag
player-select-placeholder-container-view = Vælg en beholder at se...
player-select-placeholder-item = Vælg en genstand...
player-select-placeholder-destination = Vælg destination...
player-select-placeholder-container = Vælg en beholder...
player-select-option-no-containers = Ingen beholdere
player-select-option-no-items = Ingen genstande
player-select-option-no-destinations = Ingen destinationer

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}Spillerkommandoer - Hovedmenu{"**"}
player-menu-btn-characters = Karakterer
player-menu-desc-characters = Registrer, se og aktiver spillerkarakterer.
player-menu-btn-inventory = Inventar
player-menu-desc-inventory = Se din aktive karakters inventar og brug valuta.
player-menu-btn-player-board = Spillertavle
player-menu-btn-player-board-disabled = Spillertavle (ikke konfigureret)
player-menu-desc-player-board = Opret et opslag til spillertavlen

# CharacterBaseView
player-title-characters = {"**"}Spillerkommandoer - Karakterer{"**"}
player-desc-register-character = Registrer en ny karakter.
player-msg-no-characters = Du har ingen registrerede karakterer.
player-label-active = (Aktiv)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Karakter i gang: { $characterName }{"**"}
    Din karakterregistrering afventer opsætning af inventar.
player-btn-resume = Genoptag
player-btn-discard = Kassér
player-modal-title-discard-character = Kassér karakter
player-modal-label-discard-confirm = Kassér { $characterName }?

# Confirm character removal
player-modal-title-confirm-char-removal = Bekræft karakterfjernelse
player-modal-label-confirm-char-delete = Slet { $characterName }?

# Confirm post removal
player-modal-title-confirm-post-removal = Bekræft opslagsfjernelse
player-modal-label-post-removal-warning = ADVARSEL: Denne handling er irreversibel!

# InventoryOverviewView
player-title-inventory = {"**"}Spillerkommandoer - Inventar{"**"}
player-title-char-inventory = {"**"}{ $characterName }s inventar{"**"}
player-msg-no-active-character = Ingen aktiv karakter: Aktiver en karakter for denne server for at bruge disse menuer.
player-msg-no-characters-registered = Ingen karakterer: Registrer en karakter for at bruge disse menuer.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } genstande
player-label-currency = {"**"}Valuta{"**"}
player-msg-inventory-empty = Inventaret er tomt.

# Print inventory embed
player-embed-title-inventory = { $characterName }s inventar

# ContainerItemsView
player-msg-container-empty = Denne beholder er tom.
player-label-selected-item = Valgt: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Flyt "{ $itemName }"{"**"} ({ $available } tilgængelige)
player-msg-no-other-containers = Ingen andre beholdere tilgængelige.
player-msg-select-destination = Vælg destinationsbeholder:
player-label-destination = Destination: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Administrer beholdere{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } genstande){ $suffix }
player-label-default-suffix = { " " }(standard)
player-msg-no-containers = Ingen beholdere.
player-label-selected-container = Valgt: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = Bekræft beholderssletning
player-modal-label-container-has-items = Har { $itemCount } genstande. Flyttes til Løse genstande.
player-modal-label-confirm-container-delete = Slet "{ $containerName }"?

# Container errors
player-error-cannot-rename-loose = Kan ikke omdøbe Løse genstande.
player-error-cannot-delete-loose = Kan ikke slette Løse genstande.

# PlayerBoardView
player-title-player-board = {"**"}Spillerkommandoer - Spillertavle{"**"}
player-desc-create-post = Opret et nyt opslag til spillertavlen.
player-msg-no-posts = Du har ingen aktuelle opslag.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Forfatter
player-embed-footer-post-id = Opslags-ID: { $postId }
player-error-board-channel-not-found = Spillertavlekanal ikke fundet.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Opsæt inventar for { $characterName }{"**"}
player-desc-browse-shop = Gennemse startbutikken for at udruste din karakter.
player-desc-select-kit = Vælg en startpakke.
player-desc-input-inventory = Indtast dit startinventar manuelt.

# StaticKitSelectView
player-title-select-kit = {"**"}Vælg en pakke til { $characterName }{"**"}
player-msg-no-kits = Ingen startpakker er tilgængelige.
player-label-and-more-items = ...og { $count } flere genstande
player-label-empty-kit = {"*"}Tom pakke{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Bekræft valg: { $kitName }{"**"}
player-label-items-heading = {"**"}Genstande:{"**"}
player-label-currency-heading = {"**"}Valuta:{"**"}
player-msg-kit-empty = Denne pakke er tom.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Købsmuligheder: { $itemName }{"**"}
player-msg-no-cost-options = Denne genstand har ingen tilgængelige købsmuligheder.
player-label-cost-option = {"**"}Mulighed { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Startbutik ({ $inventoryType }){"**"}
player-label-starting-wealth = Startformue: { $formattedCurrency }
player-label-in-cart = {"**"}(I kurv: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Gennemgå kurv{"**"}
player-msg-cart-empty = Din kurv er tom.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (I alt: { $totalQuantity })
player-label-insufficient-currency = Utilstrækkelig { $currencyName }
player-label-total-cost = {"**"}Samlede omkostninger:{"**"}
player-label-total-cost-free = {"**"}Samlede omkostninger:{"**"} Gratis
player-label-cart-page = Side { $current } af { $total }

# Trade embed
player-embed-title-trade = Handelsrapport
player-embed-desc-trade-sender = Afsender: { $senderMention } som `{ $senderCharacter }`
player-embed-desc-trade-recipient = Modtager: { $recipientMention } som `{ $recipientCharacter }`
player-embed-field-currency = Valuta
player-embed-field-amount = Beløb
player-embed-field-balance = { $characterName }s saldo
player-embed-field-item = Genstand
player-embed-field-quantity = Antal
player-embed-footer-transaction-id = Transaktions-ID: { $transactionId }

# Trade errors
player-error-trade-no-characters = Spilleren du forsøger at handle med har ingen karakterer!
player-error-trade-no-active = Spilleren du forsøger at handle med har ikke en aktiv karakter på denne server!

# Spend currency embed
player-embed-title-spend = Spillertransaktionsrapport
player-embed-desc-spend-player = Spiller: { $playerMention } som `{ $characterName }`
player-embed-desc-spend-transaction = Transaktion: {"**"}{ $characterName }{"**"} brugte {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Kanal
player-embed-field-receipt = Kvittering

# Spend currency errors
player-error-amount-not-number = Beløb skal være et tal.
player-error-amount-positive = Du skal bruge et positivt beløb.
player-error-amount-exceeds-maximum = Beløbet må ikke overstige { $max }.
player-error-no-active-character-server = Du har ikke en aktiv karakter på denne server.
player-error-no-currency-config = Der blev ikke fundet en valutakonfiguration for denne server.

# Consume item embed
player-embed-title-consume = Genstandsforbrugsrapport
player-embed-desc-consume = Spiller: { $playerMention } som `{ $characterName }`
player-embed-desc-consume-removed = Fjernet: {"**"}{ $quantity }x { $itemName }{"**"} fra {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = Antal skal være et positivt heltal.
player-error-qty-at-least-one = Antal skal være mindst 1.
player-error-qty-only-have = Du har kun { $maxQuantity } af denne genstand.

# Inventory input errors
player-error-invalid-format = Ugyldigt format: "{ $line }". Brug <navn>: <antal>.
player-error-empty-name = Genstandsnavn kan ikke være tomt i linje: "{ $line }".
player-error-invalid-quantity = Ugyldigt antal for "{ $name }": "{ $quantity }". Skal være et positivt heltal.
player-error-input-errors-header = Fejl i inventarindtastning:
player-msg-no-valid-items = Ingen gyldige genstande angivet. Initialiserer med tomt inventar.

# Validation error view
player-validation-error-title = Inputfejl
player-validation-btn-retry = Prøv igen

# Cart quantity validation
player-error-enter-valid-number = Indtast venligst et gyldigt positivt tal.

# Submission embeds (approval queue)
player-embed-title-approval = Inventargodkendelse: { $characterName }
player-embed-desc-submitted-by = Indsendt af { $userMention }
player-embed-field-items = Genstande
player-embed-field-currency-received = Valuta
player-embed-footer-submission-id = Indsendelses-ID: { $submissionId }
player-label-approval-thread = Godkendelse: { $characterName }
player-embed-title-submission-sent = Inventarindsendelse sendt
player-embed-desc-submission-sent =
    Din indsendelse for {"**"}{ $characterName }{"**"} er sendt til GM-teamet til godkendelse!
    Du vil blive underrettet, når den er gennemgået.
    [Se indsendelsestråd]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = Startinventar tilføjet
player-embed-desc-starting-inventory = Spiller: { $playerMention } som `{ $characterName }`
player-embed-field-items-received = Modtagne genstande
player-embed-field-currency-received-label = Modtaget valuta
player-label-untitled = Uden titel

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventory Submission: { $characterName }{"**"}
    Submitted by { $userMention }
player-approval-post-items = Genstande
player-approval-post-currency = Valuta
player-approval-resolved = Denne anmodning er blevet behandlet.
player-approval-btn-approve = Godkend
player-approval-btn-deny = Afvis
player-approval-btn-edit = Rediger
player-approval-error-no-permission = Du har ikke tilladelse til denne handling.
player-approval-error-not-submitter = Kun den originale indsender kan redigere denne anmodning.
player-approval-thread-instructions =
    This thread was created for the approval of {"**"}{ $characterName }{"**"}.
    A Game Master will review the submission and approve or deny it.
    Once approved or denied, this thread will be locked.

    {"**"}Game Masters:{"**"} Discuss any required changes with your
    player until the inventory is in an acceptable state. Only use
    the `Deny` button for irreconcilable submissions.

    { $playerMention }: Use the `Edit` button to make any changes
    requested here by a Game Master.
player-approval-approved-by = Denne anmodning blev godkendt af { $approver }.
player-approval-denied-by = Denne anmodning blev afvist af { $denier }.
player-approval-deny-reason = Årsag: { $reason }
player-msg-submission-updated = Din anmodning er blevet opdateret.


# Denial modal
player-modal-title-deny-reason = Afvis anmodning
player-modal-label-deny-reason = Årsag til afvisning
player-modal-placeholder-deny-reason = Valgfrit: forklar hvorfor anmodningen blev afvist
# Approval DM notifications
player-dm-title-approved = Karakter godkendt
player-dm-desc-approved =
    Your character {"**"}{ $characterName }{"**"} has been approved
    by { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Karakter afvist
player-dm-desc-denied =
    Your character {"**"}{ $characterName }{"**"} has been denied
    by { $denier } in {"**"}{ $guildName }{"**"}.
