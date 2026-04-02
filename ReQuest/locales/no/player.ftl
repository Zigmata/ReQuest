## Player module strings

# --- Cog ---

player-cmd-name = Bytte
player-cmd-desc = Spillermenyer

# --- Buttons ---

# Character management
player-btn-register-character = Registrer ny karakter
player-btn-activate = Aktiver
player-btn-active = Aktiv

# Player board
player-btn-create-post = Opprett innlegg
player-btn-open-starting-shop = Åpne startbutikk
player-btn-select-kit = Velg sett
player-btn-input-inventory = Skriv inn inventar

# Wizard / shop buttons
player-btn-add-to-cart = Legg i handlekurv
player-btn-add-to-cart-cost = Legg i handlekurv ({ $costString })
player-btn-view-purchase-options = Vis kjøpsalternativer
player-btn-review-submit = Gjennomgå og send inn ({ $count })
player-btn-submit-character = Send inn karakter
player-btn-keep-shopping = Fortsett å handle
player-btn-edit-quantity = Rediger antall
player-btn-clear-cart = Tøm handlekurv

# Kit buttons
player-btn-confirm-selection = Bekreft valg
player-btn-back-to-kits = Tilbake til sett

# Inventory management
player-btn-spend-currency = Bruk valuta
player-btn-print-inventory = Skriv ut inventar

# Container management
player-btn-manage-containers = Administrer beholdere
player-btn-create-new = + Opprett ny
player-btn-consume-destroy = Forbruk/ødelegg
player-btn-move = Flytt
player-btn-move-all = Flytt alle
player-btn-move-some = Flytt noen...
player-btn-back-to-overview = ← Tilbake til oversikt
player-btn-cancel-move = ← Avbryt
player-btn-up = ▲ Opp
player-btn-down = ▼ Ned

# --- Modals ---

# Trade modal
player-modal-title-trade = Handler med { $targetName }
player-modal-label-trade-name = Navn
player-modal-placeholder-trade-name = Skriv inn navnet på gjenstanden du handler
player-modal-label-trade-quantity = Antall
player-modal-placeholder-trade-quantity = Skriv inn mengden du handler

# Character register modal
player-modal-title-register = Registrer ny karakter
player-modal-label-char-name = Navn
player-modal-placeholder-char-name = Skriv inn karakterens navn.
player-modal-label-char-note = Notat
player-modal-placeholder-char-note = Skriv inn et notat for å identifisere karakteren din

# Open inventory input modal
player-modal-title-starting-inventory = Inntasting av startinventar
player-modal-label-inventory = Inventar
player-modal-placeholder-inventory-input =
    Én per linje i <navn>: <antall>-format, f.eks.:
    Sverd: 1
    gull: 30

# Spend currency modal
player-modal-title-spend-currency = Bruk valuta
player-modal-label-currency-name = Valutanavn
player-modal-placeholder-currency-name = Skriv inn navnet på valutaen du vil bruke
player-modal-label-currency-amount = Beløp
player-modal-placeholder-currency-amount = Skriv inn beløpet som skal brukes

# Create player post modal
player-modal-title-create-post = Opprett spillertavleinnlegg
player-modal-label-post-title = Tittel
player-modal-placeholder-post-title = Skriv inn en tittel for innlegget ditt
player-modal-label-post-content = Innhold
player-modal-placeholder-post-content = Skriv inn innholdet i innlegget ditt

# Edit player post modal
player-modal-title-edit-post = Rediger spillertavleinnlegg

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = Rediger handlekurvantall
player-modal-label-cart-qty = Antall
player-modal-placeholder-cart-qty = Skriv inn nytt antall (0 for å fjerne)

# Create container modal
player-modal-title-create-container = Opprett ny beholder
player-modal-label-container-name = Beholdernavn
player-modal-placeholder-container-name = Skriv inn et navn for beholderen (f.eks. Ryggsekk)

# Rename container modal
player-modal-title-rename-container = Gi beholder nytt navn
player-modal-label-new-container-name = Nytt beholdernavn
player-modal-placeholder-new-container-name = Skriv inn det nye navnet

# Consume from container modal
player-modal-title-consume = Forbruk/ødelegg gjenstand
player-modal-label-consume-qty = Antall (maks: { $maxQuantity })
player-modal-placeholder-consume-qty = Skriv inn antall som skal forbrukes/ødelegges

# Move item quantity modal
player-modal-title-move-item = Flytt gjenstand
player-modal-label-move-qty = Antall å flytte (maks: { $maxQuantity })
player-modal-placeholder-move-qty = Skriv inn antall som skal flyttes

# --- Selects ---

player-select-placeholder-no-characters = Du har ingen registrerte karakterer
player-select-placeholder-remove-character = Velg en karakter å fjerne
player-select-placeholder-post = Velg et innlegg
player-select-placeholder-container-view = Velg en beholder å vise...
player-select-placeholder-item = Velg en gjenstand...
player-select-placeholder-destination = Velg destinasjon...
player-select-placeholder-container = Velg en beholder...
player-select-option-no-containers = Ingen beholdere
player-select-option-no-items = Ingen gjenstander
player-select-option-no-destinations = Ingen destinasjoner

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}Spillerkommandoer - Hovedmeny{"**"}
player-menu-btn-characters = Karakterer
player-menu-desc-characters = Registrer, vis og aktiver spillerkarakterer.
player-menu-btn-inventory = Inventar
player-menu-desc-inventory = Se din aktive karakters inventar og bruk valuta.
player-menu-btn-player-board = Spillertavle
player-menu-btn-player-board-disabled = Spillertavle (ikke konfigurert)
player-menu-desc-player-board = Opprett et innlegg for spillertavlen

# CharacterBaseView
player-title-characters = {"**"}Spillerkommandoer - Karakterer{"**"}
player-desc-register-character = Registrer en ny karakter.
player-msg-no-characters = Du har ingen registrerte karakterer.
player-label-active = (Aktiv)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Karakter pågår: { $characterName }{"**"}
    Karakterregistreringen din venter på inventaroppsett.
player-btn-resume = Gjenoppta
player-btn-discard = Forkast
player-modal-title-discard-character = Forkast karakter
player-modal-label-discard-confirm = Forkaste { $characterName }?

# Confirm character removal
player-modal-title-confirm-char-removal = Bekreft fjerning av karakter
player-modal-label-confirm-char-delete = Slette { $characterName }?

# Confirm post removal
player-modal-title-confirm-post-removal = Bekreft fjerning av innlegg
player-modal-label-post-removal-warning = ADVARSEL: Denne handlingen kan ikke angres!

# InventoryOverviewView
player-title-inventory = {"**"}Spillerkommandoer - Inventar{"**"}
player-title-char-inventory = {"**"}{ $characterName }s inventar{"**"}
player-msg-no-active-character = Ingen aktiv karakter: Aktiver en karakter for denne serveren for å bruke disse menyene.
player-msg-no-characters-registered = Ingen karakterer: Registrer en karakter for å bruke disse menyene.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } gjenstander
player-label-currency = {"**"}Valuta{"**"}
player-msg-inventory-empty = Inventaret er tomt.

# Print inventory embed
player-embed-title-inventory = { $characterName }s inventar

# ContainerItemsView
player-msg-container-empty = Denne beholderen er tom.
player-label-selected-item = Valgt: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Flytt "{ $itemName }"{"**"} ({ $available } tilgjengelig)
player-msg-no-other-containers = Ingen andre beholdere tilgjengelige.
player-msg-select-destination = Velg destinasjonsbeholder:
player-label-destination = Destinasjon: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Administrer beholdere{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } gjenstander){ $suffix }
player-label-default-suffix = { " " }(standard)
player-msg-no-containers = Ingen beholdere.
player-label-selected-container = Valgt: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = Bekreft sletting av beholder
player-modal-label-container-has-items = Har { $itemCount } gjenstander. Flyttes til løse gjenstander.
player-modal-label-confirm-container-delete = Slette "{ $containerName }"?

# Container errors
player-error-cannot-rename-loose = Kan ikke gi nytt navn til løse gjenstander.
player-error-cannot-delete-loose = Kan ikke slette løse gjenstander.

# PlayerBoardView
player-title-player-board = {"**"}Spillerkommandoer - Spillertavle{"**"}
player-desc-create-post = Opprett et nytt innlegg for spillertavlen.
player-msg-no-posts = Du har ingen gjeldende innlegg.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Forfatter
player-embed-footer-post-id = Innleggs-ID: { $postId }
player-error-board-channel-not-found = Spillertavlekanal ikke funnet.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Sett opp inventar for { $characterName }{"**"}
player-desc-browse-shop = Bla gjennom startbutikken for å utstyre karakteren din.
player-desc-select-kit = Velg et startsett.
player-desc-input-inventory = Skriv inn startinventaret ditt manuelt.

# StaticKitSelectView
player-title-select-kit = {"**"}Velg et sett for { $characterName }{"**"}
player-msg-no-kits = Ingen startsett er tilgjengelige.
player-label-and-more-items = ...og { $count } gjenstander til
player-label-empty-kit = {"*"}Tomt sett{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Bekreft valg: { $kitName }{"**"}
player-label-items-heading = {"**"}Gjenstander:{"**"}
player-label-currency-heading = {"**"}Valuta:{"**"}
player-msg-kit-empty = Dette settet er tomt.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Kjøpsalternativer: { $itemName }{"**"}
player-msg-no-cost-options = Denne gjenstanden har ingen tilgjengelige kjøpsalternativer.
player-label-cost-option = {"**"}Alternativ { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Startbutikk ({ $inventoryType }){"**"}
player-label-starting-wealth = Startformue: { $formattedCurrency }
player-label-in-cart = {"**"}(I handlekurven: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Gjennomgå handlekurv{"**"}
player-msg-cart-empty = Handlekurven din er tom.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Totalt: { $totalQuantity })
player-label-insufficient-currency = Ikke nok { $currencyName }
player-label-total-cost = {"**"}Totalkostnad:{"**"}
player-label-total-cost-free = {"**"}Totalkostnad:{"**"} Gratis
player-label-cart-page = Side { $current } av { $total }

# Trade embed
player-embed-title-trade = Bytterapport
player-embed-desc-trade-sender = Avsender: { $senderMention } som `{ $senderCharacter }`
player-embed-desc-trade-recipient = Mottaker: { $recipientMention } som `{ $recipientCharacter }`
player-embed-field-currency = Valuta
player-embed-field-amount = Beløp
player-embed-field-balance = { $characterName }s saldo
player-embed-field-item = Gjenstand
player-embed-field-quantity = Antall
player-embed-footer-transaction-id = Transaksjons-ID: { $transactionId }

# Trade errors
player-error-trade-no-characters = Spilleren du prøver å bytte med har ingen karakterer!
player-error-trade-no-active = Spilleren du prøver å bytte med har ingen aktiv karakter på denne serveren!

# Spend currency embed
player-embed-title-spend = Spillertransaksjonsrapport
player-embed-desc-spend-player = Spiller: { $playerMention } som `{ $characterName }`
player-embed-desc-spend-transaction = Transaksjon: {"**"}{ $characterName }{"**"} brukte {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Kanal
player-embed-field-receipt = Kvittering

# Spend currency errors
player-error-amount-not-number = Beløp må være et tall.
player-error-amount-positive = Du må bruke et positivt beløp.
player-error-amount-exceeds-maximum = Beløpet kan ikke overstige { $max }.
player-error-no-active-character-server = Du har ingen aktiv karakter på denne serveren.
player-error-no-currency-config = En valutakonfigurasjon ble ikke funnet for denne serveren.

# Consume item embed
player-embed-title-consume = Gjenstandsforbruksrapport
player-embed-desc-consume = Spiller: { $playerMention } som `{ $characterName }`
player-embed-desc-consume-removed = Fjernet: {"**"}{ $quantity }x { $itemName }{"**"} fra {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = Antall må være et positivt heltall.
player-error-qty-at-least-one = Antall må være minst 1.
player-error-qty-only-have = Du har bare { $maxQuantity } av denne gjenstanden.

# Inventory input errors
player-error-invalid-format = Ugyldig format: "{ $line }". Bruk <navn>: <antall>.
player-error-empty-name = Gjenstandsnavn kan ikke være tomt i linjen: "{ $line }".
player-error-invalid-quantity = Ugyldig antall for "{ $name }": "{ $quantity }". Må være et positivt heltall.
player-error-input-errors-header = Feil i inventarinntasting:
player-msg-no-valid-items = Ingen gyldige gjenstander oppgitt. Initialiserer med tomt inventar.

# Validation error view
player-validation-error-title = Inndatafeil
player-validation-btn-retry = Prøv igjen

# Cart quantity validation
player-error-enter-valid-number = Vennligst skriv inn et gyldig positivt tall.

# Submission embeds (approval queue)
player-embed-title-approval = Inventargodkjenning: { $characterName }
player-embed-desc-submitted-by = Sendt inn av { $userMention }
player-embed-field-items = Gjenstander
player-embed-field-currency-received = Valuta
player-embed-footer-submission-id = Innsendings-ID: { $submissionId }
player-label-approval-thread = Godkjenning: { $characterName }
player-embed-title-submission-sent = Inventarinnsending sendt
player-embed-desc-submission-sent =
    Din innsending for {"**"}{ $characterName }{"**"} har blitt sendt til GM-teamet for godkjenning!
    Du vil bli varslet når den har blitt gjennomgått.
    [Vis innsendingstråd]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = Startinventar brukt
player-embed-desc-starting-inventory = Spiller: { $playerMention } som `{ $characterName }`
player-embed-field-items-received = Gjenstander mottatt
player-embed-field-currency-received-label = Valuta mottatt
player-label-untitled = Uten tittel

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventory Submission: { $characterName }{"**"}
    Submitted by { $userMention }
player-approval-post-items = Gjenstander
player-approval-post-currency = Valuta
player-approval-resolved = Denne innsendingen er behandlet.
player-approval-btn-approve = Godkjenn
player-approval-btn-deny = Avslå
player-approval-btn-edit = Rediger
player-approval-error-no-permission = Du har ikke tillatelse til denne handlingen.
player-approval-error-not-submitter = Kun den opprinnelige innsenderen kan redigere denne innsendingen.
player-approval-thread-instructions =
    This thread was created for the approval of {"**"}{ $characterName }{"**"}.
    A Game Master will review the submission and approve or deny it.
    Once approved or denied, this thread will be locked.

    {"**"}Game Masters:{"**"} Discuss any required changes with your
    player until the inventory is in an acceptable state. Only use
    the `Deny` button for irreconcilable submissions.

    { $playerMention }: Use the `Edit` button to make any changes
    requested here by a Game Master.
player-approval-approved-by = Denne innsendingen ble godkjent av { $approver }.
player-approval-denied-by = Denne innsendingen ble avslått av { $denier }.
player-approval-deny-reason = Grunn: { $reason }
player-msg-submission-updated = Innsendingen din er oppdatert.


# Denial modal
player-modal-title-deny-reason = Avslå innsending
player-modal-label-deny-reason = Grunn for avslag
player-modal-placeholder-deny-reason = Valgfritt: forklar grunnen til avslaget
# Approval DM notifications
player-dm-title-approved = Karakter godkjent
player-dm-desc-approved =
    Your character {"**"}{ $characterName }{"**"} has been approved
    by { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Karakter avslått
player-dm-desc-denied =
    Your character {"**"}{ $characterName }{"**"} has been denied
    by { $denier } in {"**"}{ $guildName }{"**"}.
