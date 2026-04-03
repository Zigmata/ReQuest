## Player module strings

# --- Cog ---

player-cmd-name = Schimb
player-cmd-desc = Meniuri jucător

# --- Buttons ---

# Character management
player-btn-register-character = Înregistrează personaj nou
player-btn-activate = Activează
player-btn-active = Activ

# Player board
player-btn-create-post = Creează postare
player-btn-open-starting-shop = Deschide magazinul de start
player-btn-select-kit = Selectează kit
player-btn-input-inventory = Introdu inventar

# Wizard / shop buttons
player-btn-add-to-cart = Adaugă în coș
player-btn-add-to-cart-cost = Adaugă în coș ({ $costString })
player-btn-view-purchase-options = Vezi opțiunile de cumpărare
player-btn-review-submit = Revizuiește și trimite ({ $count })
player-btn-submit-character = Trimite personajul
player-btn-keep-shopping = Continuă cumpărăturile
player-btn-edit-quantity = Editează cantitatea
player-btn-clear-cart = Golește coșul

# Kit buttons
player-btn-confirm-selection = Confirmă selecția
player-btn-back-to-kits = Înapoi la kituri

# Inventory management
player-btn-spend-currency = Cheltuiește monedă
player-btn-print-inventory = Afișează inventar

# Container management
player-btn-manage-containers = Gestionează containerele
player-btn-create-new = + Creează nou
player-btn-consume-destroy = Consumă/Distruge
player-btn-move = Mută
player-btn-move-all = Mută tot
player-btn-move-some = Mută o parte...
player-btn-back-to-overview = ← Înapoi la prezentare
player-btn-cancel-move = ← Anulează
player-btn-up = ▲ Sus
player-btn-down = ▼ Jos

# --- Modals ---

# Trade modal
player-modal-title-trade = Schimb cu { $targetName }
player-modal-label-trade-name = Nume
player-modal-placeholder-trade-name = Introduceți numele obiectului pe care îl schimbați
player-modal-label-trade-quantity = Cantitate
player-modal-placeholder-trade-quantity = Introduceți cantitatea pe care o schimbați

# Character register modal
player-modal-title-register = Înregistrează personaj nou
player-modal-label-char-name = Nume
player-modal-placeholder-char-name = Introduceți numele personajului dumneavoastră.
player-modal-label-char-note = Notă
player-modal-placeholder-char-note = Introduceți o notă pentru a identifica personajul

# Open inventory input modal
player-modal-title-starting-inventory = Introdu inventarul de start
player-modal-label-inventory = Inventar
player-modal-placeholder-inventory-input =
    Câte unul pe linie în format <nume>: <cantitate>, de ex.:
    Sabie: 1
    aur: 30

# Spend currency modal
player-modal-title-spend-currency = Cheltuiește monedă
player-modal-label-currency-name = Numele monedei
player-modal-placeholder-currency-name = Introduceți numele monedei pe care o cheltuiți
player-modal-label-currency-amount = Sumă
player-modal-placeholder-currency-amount = Introduceți suma de cheltuit

# Create player post modal
player-modal-title-create-post = Creează postare pe panoul jucătorilor
player-modal-label-post-title = Titlu
player-modal-placeholder-post-title = Introduceți un titlu pentru postare
player-modal-label-post-content = Conținutul postării
player-modal-placeholder-post-content = Introduceți corpul postării

# Edit player post modal
player-modal-title-edit-post = Editează postarea de pe panoul jucătorilor

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = Editează cantitatea din coș
player-modal-label-cart-qty = Cantitate
player-modal-placeholder-cart-qty = Introduceți noua cantitate (0 pentru a elimina)

# Create container modal
player-modal-title-create-container = Creează container nou
player-modal-label-container-name = Numele containerului
player-modal-placeholder-container-name = Introduceți un nume pentru container (de ex., Rucsac)

# Rename container modal
player-modal-title-rename-container = Redenumește containerul
player-modal-label-new-container-name = Noul nume al containerului
player-modal-placeholder-new-container-name = Introduceți noul nume

# Consume from container modal
player-modal-title-consume = Consumă/Distruge obiect
player-modal-label-consume-qty = Cantitate (max: { $maxQuantity })
player-modal-placeholder-consume-qty = Introduceți cantitatea de consumat/distrus

# Move item quantity modal
player-modal-title-move-item = Mută obiect
player-modal-label-move-qty = Cantitate de mutat (max: { $maxQuantity })
player-modal-placeholder-move-qty = Introduceți cantitatea de mutat

# --- Selects ---

player-select-placeholder-no-characters = Nu aveți personaje înregistrate
player-select-placeholder-remove-character = Selectați un personaj de eliminat
player-select-placeholder-post = Selectați o postare
player-select-placeholder-container-view = Selectați un container de vizualizat...
player-select-placeholder-item = Selectați un obiect...
player-select-placeholder-destination = Selectați destinația...
player-select-placeholder-container = Selectați un container...
player-select-option-no-containers = Niciun container
player-select-option-no-items = Niciun obiect
player-select-option-no-destinations = Nicio destinație

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}Comenzi jucător - Meniu principal{"**"}
player-menu-btn-characters = Personaje
player-menu-desc-characters = Înregistrați, vizualizați și activați personajele jucătorului.
player-menu-btn-inventory = Inventar
player-menu-desc-inventory = Vizualizați inventarul personajului activ și cheltuiți monedă.
player-menu-btn-player-board = Panou jucători
player-menu-btn-player-board-disabled = Panou jucători (Neconfigurat)
player-menu-desc-player-board = Creați o postare pe panoul jucătorilor

# CharacterBaseView
player-title-characters = {"**"}Comenzi jucător - Personaje{"**"}
player-desc-register-character = Înregistrați un personaj nou.
player-msg-no-characters = Nu aveți personaje înregistrate.
player-label-active = (Activ)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Personaj în curs: { $characterName }{"**"}
    Înregistrarea personajului tău așteaptă configurarea inventarului.
player-btn-resume = Reia
player-btn-discard = Renunță
player-modal-title-discard-character = Renunță la personaj
player-modal-label-discard-confirm = Renunți la { $characterName }?

# Confirm character removal
player-modal-title-confirm-char-removal = Confirmă eliminarea personajului
player-modal-label-confirm-char-delete = Ștergeți { $characterName }?

# Confirm post removal
player-modal-title-confirm-post-removal = Confirmă eliminarea postării
player-modal-label-post-removal-warning = ATENȚIE: Această acțiune este ireversibilă!

# InventoryOverviewView
player-title-inventory = {"**"}Comenzi jucător - Inventar{"**"}
player-title-char-inventory = {"**"}Inventarul lui { $characterName }{"**"}
player-msg-no-active-character = Niciun personaj activ: Activați un personaj pentru acest server pentru a folosi aceste meniuri.
player-msg-no-characters-registered = Niciun personaj: Înregistrați un personaj pentru a folosi aceste meniuri.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } obiecte
player-label-currency = {"**"}Monedă{"**"}
player-msg-inventory-empty = Inventarul este gol.

# Print inventory embed
player-embed-title-inventory = Inventarul lui { $characterName }

# ContainerItemsView
player-msg-container-empty = Acest container este gol.
player-label-selected-item = Selectat: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Mută „{ $itemName }"{"**"} ({ $available } disponibil)
player-msg-no-other-containers = Niciun alt container disponibil.
player-msg-select-destination = Selectați containerul destinație:
player-label-destination = Destinație: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Gestionare containere{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } obiecte){ $suffix }
player-label-default-suffix = { " " }(implicit)
player-msg-no-containers = Niciun container.
player-label-selected-container = Selectat: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = Confirmă ștergerea containerului
player-modal-label-container-has-items = Are { $itemCount } obiecte. Vor fi mutate în Obiecte libere.
player-modal-label-confirm-container-delete = Ștergeți „{ $containerName }"?

# Container errors
player-error-cannot-rename-loose = Nu se poate redenumi Obiecte libere.
player-error-cannot-delete-loose = Nu se poate șterge Obiecte libere.

# PlayerBoardView
player-title-player-board = {"**"}Comenzi jucător - Panou jucători{"**"}
player-desc-create-post = Creați o postare nouă pe panoul jucătorilor.
player-msg-no-posts = Nu aveți nicio postare curentă.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Autor
player-embed-footer-post-id = ID postare: { $postId }
player-error-board-channel-not-found = Canalul panoului jucătorilor nu a fost găsit.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Configurare inventar pentru { $characterName }{"**"}
player-desc-browse-shop = Răsfoiți magazinul de start pentru a echipa personajul.
player-desc-select-kit = Selectați un kit de start.
player-desc-input-inventory = Introduceți manual inventarul de start.

# StaticKitSelectView
player-title-select-kit = {"**"}Selectați un kit pentru { $characterName }{"**"}
player-msg-no-kits = Niciun kit de start disponibil.
player-label-and-more-items = ...și încă { $count } obiecte
player-label-empty-kit = {"*"}Kit gol{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Confirmă selecția: { $kitName }{"**"}
player-label-items-heading = {"**"}Obiecte:{"**"}
player-label-currency-heading = {"**"}Monedă:{"**"}
player-msg-kit-empty = Acest kit este gol.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Opțiuni de cumpărare: { $itemName }{"**"}
player-msg-no-cost-options = Acest obiect nu are opțiuni de cost disponibile.
player-label-cost-option = {"**"}Opțiunea { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Magazin de start ({ $inventoryType }){"**"}
player-label-starting-wealth = Avere de start: { $formattedCurrency }
player-label-in-cart = {"**"}(În coș: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Revizuire coș{"**"}
player-msg-cart-empty = Coșul dumneavoastră este gol.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Total: { $totalQuantity })
player-label-insufficient-currency = { $currencyName } insuficient
player-label-total-cost = {"**"}Cost total:{"**"}
player-label-total-cost-free = {"**"}Cost total:{"**"} Gratuit
player-label-cart-page = Pagina { $current } din { $total }

# Trade embed
player-embed-title-trade = Raport de schimb
player-embed-desc-trade-sender = Expeditor: { $senderMention } ca `{ $senderCharacter }`
player-embed-desc-trade-recipient = Destinatar: { $recipientMention } ca `{ $recipientCharacter }`
player-embed-field-currency = Monedă
player-embed-field-amount = Sumă
player-embed-field-balance = Soldul lui { $characterName }
player-embed-field-item = Obiect
player-embed-field-quantity = Cantitate
player-embed-footer-transaction-id = ID tranzacție: { $transactionId }

# Trade errors
player-error-trade-no-characters = Jucătorul cu care încercați să faceți schimb nu are personaje!
player-error-trade-no-active = Jucătorul cu care încercați să faceți schimb nu are un personaj activ pe acest server!

# Spend currency embed
player-embed-title-spend = Raport tranzacție jucător
player-embed-desc-spend-player = Jucător: { $playerMention } ca `{ $characterName }`
player-embed-desc-spend-transaction = Tranzacție: {"**"}{ $characterName }{"**"} a cheltuit {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Canal
player-embed-field-receipt = Chitanță

# Spend currency errors
player-error-amount-not-number = Suma trebuie să fie un număr.
player-error-amount-positive = Trebuie să cheltuiți o sumă pozitivă.
player-error-amount-exceeds-maximum = Suma nu poate depăși { $max }.
player-error-no-active-character-server = Nu aveți un personaj activ pe acest server.
player-error-no-currency-config = Configurarea monedei nu a fost găsită pentru acest server.

# Consume item embed
player-embed-title-consume = Raport consumare obiect
player-embed-desc-consume = Jucător: { $playerMention } ca `{ $characterName }`
player-embed-desc-consume-removed = Eliminat: {"**"}{ $quantity }x { $itemName }{"**"} din {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = Cantitatea trebuie să fie un număr întreg pozitiv.
player-error-qty-at-least-one = Cantitatea trebuie să fie cel puțin 1.
player-error-qty-only-have = Aveți doar { $maxQuantity } din acest obiect.

# Inventory input errors
player-error-invalid-format = Format invalid: „{ $line }". Folosiți <nume>: <cantitate>.
player-error-empty-name = Numele obiectului nu poate fi gol în linia: „{ $line }".
player-error-invalid-quantity = Cantitate invalidă pentru „{ $name }": „{ $quantity }". Trebuie să fie un număr întreg pozitiv.
player-error-input-errors-header = Erori la introducerea inventarului:
player-msg-no-valid-items = Niciun obiect valid furnizat. Se inițializează cu inventar gol.

# Validation error view
player-validation-error-title = Erori de introducere
player-validation-btn-retry = Încearcă din nou

# Cart quantity validation
player-error-enter-valid-number = Vă rugăm să introduceți un număr pozitiv valid.

# Submission embeds (approval queue)
player-embed-title-approval = Aprobare inventar: { $characterName }
player-embed-desc-submitted-by = Trimis de { $userMention }
player-embed-field-items = Obiecte
player-embed-field-currency-received = Monedă
player-embed-footer-submission-id = ID trimitere: { $submissionId }
player-label-approval-thread = Aprobare: { $characterName }
player-embed-title-submission-sent = Trimitere inventar trimisă
player-embed-desc-submission-sent =
    Trimiterea dumneavoastră pentru {"**"}{ $characterName }{"**"} a fost trimisă echipei GM pentru aprobare!
    Veți fi notificat odată ce a fost revizuită.
    [Vezi firul trimiterii]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = Inventar de start aplicat
player-embed-desc-starting-inventory = Jucător: { $playerMention } ca `{ $characterName }`
player-embed-field-items-received = Obiecte primite
player-embed-field-currency-received-label = Monedă primită
player-label-untitled = Fără titlu

# ApprovalPostView
player-approval-post-header =
    {"**"}Cerere de Inventar: { $characterName }{"**"}
    Trimis de { $userMention }
player-approval-post-items = Obiecte
player-approval-post-currency = Monedă
player-approval-resolved = Această cerere a fost rezolvată.
player-approval-btn-approve = Aprobă
player-approval-btn-deny = Respinge
player-approval-btn-edit = Editează
player-approval-error-no-permission = Nu ai permisiunea de a efectua această acțiune.
player-approval-error-not-submitter = Doar expeditorul original poate edita această cerere.
player-approval-thread-instructions =
    Acest fir a fost creat pentru aprobarea lui {"**"}{ $characterName }{"**"}.
    Un Game Master va revizui cererea și o va aproba sau respinge.
    Odată aprobată sau respinsă, acest fir va fi blocat.

    {"**"}Game Masters:{"**"} Discutați orice modificări necesare cu
    jucătorul dvs. până când inventarul este într-o stare acceptabilă.
    Folosiți butonul `Respinge` doar pentru cereri ireconciliabile.

    { $playerMention }: Folosește butonul `Editează` pentru a face orice
    modificări solicitate aici de un Game Master.
player-approval-approved-by = Această cerere a fost aprobată de { $approver }.
player-approval-denied-by = Această cerere a fost respinsă de { $denier }.
player-approval-deny-reason = Motiv: { $reason }
player-msg-submission-updated = Cererea ta a fost actualizată.


# Denial modal
player-modal-title-deny-reason = Respinge cererea
player-modal-label-deny-reason = Motivul respingerii
player-modal-placeholder-deny-reason = Opțional: explicați motivul respingerii
# Approval DM notifications
player-dm-title-approved = Personaj aprobat
player-dm-desc-approved =
    Personajul tău {"**"}{ $characterName }{"**"} a fost aprobat
    de { $approver } în {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Personaj respins
player-dm-desc-denied =
    Personajul tău {"**"}{ $characterName }{"**"} a fost respins
    de { $denier } în {"**"}{ $guildName }{"**"}.
