## Player module strings

# --- Cog ---

player-cmd-name = Razmjena
player-cmd-desc = Izbornici igrača

# --- Buttons ---

# Character management
player-btn-register-character = Registriraj novog lika
player-btn-activate = Aktiviraj
player-btn-active = Aktivan

# Player board
player-btn-create-post = Stvori objavu
player-btn-open-starting-shop = Otvori početnu trgovinu
player-btn-select-kit = Odaberi set
player-btn-input-inventory = Unesi inventar

# Wizard / shop buttons
player-btn-add-to-cart = Dodaj u košaricu
player-btn-add-to-cart-cost = Dodaj u košaricu ({ $costString })
player-btn-view-purchase-options = Pogledaj opcije kupnje
player-btn-review-submit = Pregledaj i pošalji ({ $count })
player-btn-submit-character = Pošalji lika
player-btn-keep-shopping = Nastavi kupovati
player-btn-edit-quantity = Uredi količinu
player-btn-clear-cart = Isprazni košaricu

# Kit buttons
player-btn-confirm-selection = Potvrdi odabir
player-btn-back-to-kits = Natrag na setove

# Inventory management
player-btn-spend-currency = Potroši valutu
player-btn-print-inventory = Ispiši inventar

# Container management
player-btn-manage-containers = Upravljaj spremnicima
player-btn-create-new = + Stvori novi
player-btn-consume-destroy = Potroši/Uništi
player-btn-move = Premjesti
player-btn-move-all = Premjesti sve
player-btn-move-some = Premjesti dio...
player-btn-back-to-overview = ← Natrag na pregled
player-btn-cancel-move = ← Odustani
player-btn-up = ▲ Gore
player-btn-down = ▼ Dolje

# --- Modals ---

# Trade modal
player-modal-title-trade = Trgovanje s { $targetName }
player-modal-label-trade-name = Naziv
player-modal-placeholder-trade-name = Unesite naziv predmeta koji trgujete
player-modal-label-trade-quantity = Količina
player-modal-placeholder-trade-quantity = Unesite količinu koju trgujete

# Character register modal
player-modal-title-register = Registriraj novog lika
player-modal-label-char-name = Ime
player-modal-placeholder-char-name = Unesite ime svog lika.
player-modal-label-char-note = Bilješka
player-modal-placeholder-char-note = Unesite bilješku za identifikaciju svog lika

# Open inventory input modal
player-modal-title-starting-inventory = Unos početnog inventara
player-modal-label-inventory = Inventar
player-modal-placeholder-inventory-input =
    Jedan po retku u formatu <naziv>: <količina>, npr.:
    Mač: 1
    zlato: 30

# Spend currency modal
player-modal-title-spend-currency = Potroši valutu
player-modal-label-currency-name = Naziv valute
player-modal-placeholder-currency-name = Unesite naziv valute koju trošite
player-modal-label-currency-amount = Iznos
player-modal-placeholder-currency-amount = Unesite iznos za trošenje

# Create player post modal
player-modal-title-create-post = Stvori objavu na ploči igrača
player-modal-label-post-title = Naslov
player-modal-placeholder-post-title = Unesite naslov za svoju objavu
player-modal-label-post-content = Sadržaj objave
player-modal-placeholder-post-content = Unesite tijelo svoje objave

# Edit player post modal
player-modal-title-edit-post = Uredi objavu na ploči igrača

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = Uredi količinu u košarici
player-modal-label-cart-qty = Količina
player-modal-placeholder-cart-qty = Unesite novu količinu (0 za uklanjanje)

# Create container modal
player-modal-title-create-container = Stvori novi spremnik
player-modal-label-container-name = Naziv spremnika
player-modal-placeholder-container-name = Unesite naziv za svoj spremnik (npr. Ruksak)

# Rename container modal
player-modal-title-rename-container = Preimenuj spremnik
player-modal-label-new-container-name = Novi naziv spremnika
player-modal-placeholder-new-container-name = Unesite novi naziv

# Consume from container modal
player-modal-title-consume = Potroši/Uništi predmet
player-modal-label-consume-qty = Količina (maks.: { $maxQuantity })
player-modal-placeholder-consume-qty = Unesite količinu za trošenje/uništavanje

# Move item quantity modal
player-modal-title-move-item = Premjesti predmet
player-modal-label-move-qty = Količina za premještanje (maks.: { $maxQuantity })
player-modal-placeholder-move-qty = Unesite količinu za premještanje

# --- Selects ---

player-select-placeholder-no-characters = Nemate registriranih likova
player-select-placeholder-remove-character = Odaberite lika za uklanjanje
player-select-placeholder-post = Odaberite objavu
player-select-placeholder-container-view = Odaberite spremnik za pregled...
player-select-placeholder-item = Odaberite predmet...
player-select-placeholder-destination = Odaberite odredište...
player-select-placeholder-container = Odaberite spremnik...
player-select-option-no-containers = Nema spremnika
player-select-option-no-items = Nema predmeta
player-select-option-no-destinations = Nema odredišta

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}Naredbe igrača - Glavni izbornik{"**"}
player-menu-btn-characters = Likovi
player-menu-desc-characters = Registrirajte, pregledajte i aktivirajte likove igrača.
player-menu-btn-inventory = Inventar
player-menu-desc-inventory = Pregledajte inventar svog aktivnog lika i trošite valutu.
player-menu-btn-player-board = Ploča igrača
player-menu-btn-player-board-disabled = Ploča igrača (nije konfigurirana)
player-menu-desc-player-board = Stvorite objavu za ploču igrača

# CharacterBaseView
player-title-characters = {"**"}Naredbe igrača - Likovi{"**"}
player-desc-register-character = Registrirajte novog lika.
player-msg-no-characters = Nemate registriranih likova.
player-label-active = (Aktivan)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Lik u tijeku: { $characterName }{"**"}
    Registracija vašeg lika čeka postavljanje inventara.
player-btn-resume = Nastavi
player-btn-discard = Odbaci
player-modal-title-discard-character = Odbaci lik
player-modal-label-discard-confirm = Odbaci { $characterName }?

# Confirm character removal
player-modal-title-confirm-char-removal = Potvrdi uklanjanje lika
player-modal-label-confirm-char-delete = Obrisati { $characterName }?

# Confirm post removal
player-modal-title-confirm-post-removal = Potvrdi uklanjanje objave
player-modal-label-post-removal-warning = UPOZORENJE: Ova radnja je nepovratna!

# InventoryOverviewView
player-title-inventory = {"**"}Naredbe igrača - Inventar{"**"}
player-title-char-inventory = {"**"}Inventar lika { $characterName }{"**"}
player-msg-no-active-character = Nema aktivnog lika: Aktivirajte lika za ovaj poslužitelj da biste koristili ove izbornike.
player-msg-no-characters-registered = Nema likova: Registrirajte lika da biste koristili ove izbornike.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } predmeta
player-label-currency = {"**"}Valuta{"**"}
player-msg-inventory-empty = Inventar je prazan.

# Print inventory embed
player-embed-title-inventory = Inventar lika { $characterName }

# ContainerItemsView
player-msg-container-empty = Ovaj spremnik je prazan.
player-label-selected-item = Odabrano: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Premjesti "{ $itemName }"{"**"} ({ $available } raspoloživo)
player-msg-no-other-containers = Nema drugih dostupnih spremnika.
player-msg-select-destination = Odaberite odredišni spremnik:
player-label-destination = Odredište: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Upravljanje spremnicima{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } predmeta){ $suffix }
player-label-default-suffix = { " " }(zadano)
player-msg-no-containers = Nema spremnika.
player-label-selected-container = Odabrano: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = Potvrdi brisanje spremnika
player-modal-label-container-has-items = Sadrži { $itemCount } predmeta. Premjestit će se u Slobodne predmete.
player-modal-label-confirm-container-delete = Obrisati "{ $containerName }"?

# Container errors
player-error-cannot-rename-loose = Nije moguće preimenovati Slobodne predmete.
player-error-cannot-delete-loose = Nije moguće obrisati Slobodne predmete.

# PlayerBoardView
player-title-player-board = {"**"}Naredbe igrača - Ploča igrača{"**"}
player-desc-create-post = Stvorite novu objavu za ploču igrača.
player-msg-no-posts = Nemate trenutnih objava.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Autor
player-embed-footer-post-id = ID objave: { $postId }
player-error-board-channel-not-found = Kanal ploče igrača nije pronađen.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Postavljanje inventara za { $characterName }{"**"}
player-desc-browse-shop = Pregledajte početnu trgovinu za opremanje svog lika.
player-desc-select-kit = Odaberite početni set.
player-desc-input-inventory = Ručno unesite svoj početni inventar.

# StaticKitSelectView
player-title-select-kit = {"**"}Odaberite set za { $characterName }{"**"}
player-msg-no-kits = Nema dostupnih početnih setova.
player-label-and-more-items = ...i još { $count } predmeta
player-label-empty-kit = {"*"}Prazan set{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Potvrdite odabir: { $kitName }{"**"}
player-label-items-heading = {"**"}Predmeti:{"**"}
player-label-currency-heading = {"**"}Valuta:{"**"}
player-msg-kit-empty = Ovaj set je prazan.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Opcije kupnje: { $itemName }{"**"}
player-msg-no-cost-options = Ovaj predmet nema dostupnih opcija cijene.
player-label-cost-option = {"**"}Opcija { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Početna trgovina ({ $inventoryType }){"**"}
player-label-starting-wealth = Početno bogatstvo: { $formattedCurrency }
player-label-in-cart = {"**"}(U košarici: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Pregled košarice{"**"}
player-msg-cart-empty = Vaša košarica je prazna.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Ukupno: { $totalQuantity })
player-label-insufficient-currency = Nedovoljno { $currencyName }
player-label-total-cost = {"**"}Ukupna cijena:{"**"}
player-label-total-cost-free = {"**"}Ukupna cijena:{"**"} Besplatno
player-label-cart-page = Stranica { $current } od { $total }

# Trade embed
player-embed-title-trade = Izvješće o trgovanju
player-embed-desc-trade-sender = Pošiljatelj: { $senderMention } kao `{ $senderCharacter }`
player-embed-desc-trade-recipient = Primatelj: { $recipientMention } kao `{ $recipientCharacter }`
player-embed-field-currency = Valuta
player-embed-field-amount = Iznos
player-embed-field-balance = Saldo lika { $characterName }
player-embed-field-item = Predmet
player-embed-field-quantity = Količina
player-embed-footer-transaction-id = ID transakcije: { $transactionId }

# Trade errors
player-error-trade-no-characters = Igrač s kojim pokušavate trgovati nema likova!
player-error-trade-no-active = Igrač s kojim pokušavate trgovati nema aktivnog lika na ovom poslužitelju!

# Spend currency embed
player-embed-title-spend = Izvješće o transakciji igrača
player-embed-desc-spend-player = Igrač: { $playerMention } kao `{ $characterName }`
player-embed-desc-spend-transaction = Transakcija: {"**"}{ $characterName }{"**"} je potrošio {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Kanal
player-embed-field-receipt = Račun

# Spend currency errors
player-error-amount-not-number = Iznos mora biti broj.
player-error-amount-positive = Morate potrošiti pozitivan iznos.
player-error-amount-exceeds-maximum = Iznos ne može premašiti { $max }.
player-error-no-active-character-server = Nemate aktivnog lika na ovom poslužitelju.
player-error-no-currency-config = Konfiguracija valute nije pronađena za ovaj poslužitelj.

# Consume item embed
player-embed-title-consume = Izvješće o trošenju predmeta
player-embed-desc-consume = Igrač: { $playerMention } kao `{ $characterName }`
player-embed-desc-consume-removed = Uklonjeno: {"**"}{ $quantity }x { $itemName }{"**"} iz {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = Količina mora biti pozitivan cijeli broj.
player-error-qty-at-least-one = Količina mora biti najmanje 1.
player-error-qty-only-have = Imate samo { $maxQuantity } ovog predmeta.

# Inventory input errors
player-error-invalid-format = Neispravan format: "{ $line }". Koristite <naziv>: <količina>.
player-error-empty-name = Naziv predmeta ne smije biti prazan u retku: "{ $line }".
player-error-invalid-quantity = Neispravna količina za "{ $name }": "{ $quantity }". Mora biti pozitivan cijeli broj.
player-error-input-errors-header = Greške u unosu inventara:
player-msg-no-valid-items = Nema valjanih predmeta. Inicijalizacija s praznim inventarom.

# Cart quantity validation
player-error-enter-valid-number = Unesite valjani pozitivan broj.

# Submission embeds (approval queue)
player-embed-title-approval = Odobrenje inventara: { $characterName }
player-embed-desc-submitted-by = Poslao { $userMention }
player-embed-field-items = Predmeti
player-embed-field-currency-received = Valuta
player-embed-footer-submission-id = ID prijave: { $submissionId }
player-label-approval-thread = Odobrenje: { $characterName }
player-embed-title-submission-sent = Prijava inventara poslana
player-embed-desc-submission-sent =
    Vaša prijava za {"**"}{ $characterName }{"**"} je poslana GM timu na odobrenje!
    Bit ćete obaviješteni kada bude pregledana.
    [Pogledaj temu prijave]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = Početni inventar primijenjen
player-embed-desc-starting-inventory = Igrač: { $playerMention } kao `{ $characterName }`
player-embed-field-items-received = Primljeni predmeti
player-embed-field-currency-received-label = Primljena valuta
player-label-untitled = Bez naslova

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventory Submission: { $characterName }{"**"}
    Submitted by { $userMention }
player-approval-post-items = Predmeti
player-approval-post-currency = Valuta
player-approval-resolved = Ovaj zahtjev je riješen.
player-approval-btn-approve = Odobri
player-approval-btn-deny = Odbij
player-approval-btn-edit = Uredi
player-approval-error-no-permission = Nemate dozvolu za ovu radnju.
player-approval-error-not-submitter = Samo izvorni podnositelj može urediti ovaj zahtjev.
player-approval-thread-instructions =
    This thread was created for the approval of a character's starting inventory.
    A Game Master will review the submission and approve or deny it.
    The submitting player may use the Edit button to modify and re-submit.
    Once approved or denied, this thread will be locked.
player-msg-submission-updated = Vaš zahtjev je ažuriran.

# Approval DM notifications
player-dm-title-approved = Lik odobren
player-dm-desc-approved =
    Your character {"**"}{ $characterName }{"**"} has been approved
    by { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Lik odbijen
player-dm-desc-denied =
    Your character {"**"}{ $characterName }{"**"} has been denied
    by { $denier } in {"**"}{ $guildName }{"**"}. You may re-submit.
