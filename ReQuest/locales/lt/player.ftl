## Player module strings

# --- Cog ---

player-cmd-name = Prekyba
player-cmd-desc = Žaidėjo meniu

# --- Buttons ---

# Character management
player-btn-register-character = Registruoti naują veikėją
player-btn-activate = Aktyvuoti
player-btn-active = Aktyvus

# Player board
player-btn-create-post = Sukurti įrašą
player-btn-open-starting-shop = Atidaryti pradinę parduotuvę
player-btn-select-kit = Pasirinkti rinkinį
player-btn-input-inventory = Įvesti inventorių

# Wizard / shop buttons
player-btn-add-to-cart = Įdėti į krepšelį
player-btn-add-to-cart-cost = Įdėti į krepšelį ({ $costString })
player-btn-view-purchase-options = Peržiūrėti pirkimo parinktis
player-btn-review-submit = Peržiūrėti ir pateikti ({ $count })
player-btn-submit-character = Pateikti veikėją
player-btn-keep-shopping = Tęsti apsipirkimą
player-btn-edit-quantity = Redaguoti kiekį
player-btn-clear-cart = Išvalyti krepšelį

# Kit buttons
player-btn-confirm-selection = Patvirtinti pasirinkimą
player-btn-back-to-kits = Grįžti prie rinkinių

# Inventory management
player-btn-spend-currency = Išleisti valiutą
player-btn-print-inventory = Spausdinti inventorių

# Container management
player-btn-manage-containers = Tvarkyti konteinerius
player-btn-create-new = + Sukurti naują
player-btn-consume-destroy = Sunaudoti/Sunaikinti
player-btn-move = Perkelti
player-btn-move-all = Perkelti viską
player-btn-move-some = Perkelti dalį...
player-btn-back-to-overview = ← Grįžti į apžvalgą
player-btn-cancel-move = ← Atšaukti
player-btn-up = ▲ Aukštyn
player-btn-down = ▼ Žemyn

# --- Modals ---

# Trade modal
player-modal-title-trade = Prekyba su { $targetName }
player-modal-label-trade-name = Pavadinimas
player-modal-placeholder-trade-name = Įveskite daikto, kuriuo prekiaujate, pavadinimą
player-modal-label-trade-quantity = Kiekis
player-modal-placeholder-trade-quantity = Įveskite kiekį, kuriuo prekiaujate

# Character register modal
player-modal-title-register = Registruoti naują veikėją
player-modal-label-char-name = Vardas
player-modal-placeholder-char-name = Įveskite savo veikėjo vardą.
player-modal-label-char-note = Pastaba
player-modal-placeholder-char-note = Įveskite pastabą veikėjui identifikuoti

# Open inventory input modal
player-modal-title-starting-inventory = Pradinio inventoriaus įvedimas
player-modal-label-inventory = Inventorius
player-modal-placeholder-inventory-input =
    Po vieną eilutėje formatu <pavadinimas>: <kiekis>, pvz.:
    Kardas: 1
    auksas: 30

# Spend currency modal
player-modal-title-spend-currency = Išleisti valiutą
player-modal-label-currency-name = Valiutos pavadinimas
player-modal-placeholder-currency-name = Įveskite valiutos, kurią leidžiate, pavadinimą
player-modal-label-currency-amount = Suma
player-modal-placeholder-currency-amount = Įveskite sumą, kurią norite išleisti

# Create player post modal
player-modal-title-create-post = Sukurti žaidėjų skelbimų įrašą
player-modal-label-post-title = Pavadinimas
player-modal-placeholder-post-title = Įveskite savo įrašo pavadinimą
player-modal-label-post-content = Įrašo turinys
player-modal-placeholder-post-content = Įveskite savo įrašo tekstą

# Edit player post modal
player-modal-title-edit-post = Redaguoti žaidėjų skelbimų įrašą

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = Redaguoti krepšelio kiekį
player-modal-label-cart-qty = Kiekis
player-modal-placeholder-cart-qty = Įveskite naują kiekį (0, kad pašalintumėte)

# Create container modal
player-modal-title-create-container = Sukurti naują konteinerį
player-modal-label-container-name = Konteinerio pavadinimas
player-modal-placeholder-container-name = Įveskite konteinerio pavadinimą (pvz., Kuprinė)

# Rename container modal
player-modal-title-rename-container = Pervadinti konteinerį
player-modal-label-new-container-name = Naujas konteinerio pavadinimas
player-modal-placeholder-new-container-name = Įveskite naują pavadinimą

# Consume from container modal
player-modal-title-consume = Sunaudoti/Sunaikinti daiktą
player-modal-label-consume-qty = Kiekis (maks.: { $maxQuantity })
player-modal-placeholder-consume-qty = Įveskite kiekį sunaudojimui/sunaikinimui

# Move item quantity modal
player-modal-title-move-item = Perkelti daiktą
player-modal-label-move-qty = Kiekis perkėlimui (maks.: { $maxQuantity })
player-modal-placeholder-move-qty = Įveskite kiekį perkėlimui

# --- Selects ---

player-select-placeholder-no-characters = Neturite registruotų veikėjų
player-select-placeholder-remove-character = Pasirinkite veikėją pašalinimui
player-select-placeholder-post = Pasirinkite įrašą
player-select-placeholder-container-view = Pasirinkite konteinerį peržiūrai...
player-select-placeholder-item = Pasirinkite daiktą...
player-select-placeholder-destination = Pasirinkite paskirties vietą...
player-select-placeholder-container = Pasirinkite konteinerį...
player-select-option-no-containers = Nėra konteinerių
player-select-option-no-items = Nėra daiktų
player-select-option-no-destinations = Nėra paskirties vietų

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}Žaidėjo komandos – Pagrindinis meniu{"**"}
player-menu-btn-characters = Veikėjai
player-menu-desc-characters = Registruokite, peržiūrėkite ir aktyvuokite žaidėjų veikėjus.
player-menu-btn-inventory = Inventorius
player-menu-desc-inventory = Peržiūrėkite aktyvaus veikėjo inventorių ir leiskite valiutą.
player-menu-btn-player-board = Žaidėjų skelbimų lenta
player-menu-btn-player-board-disabled = Žaidėjų skelbimų lenta (Nesukonfigūruota)
player-menu-desc-player-board = Sukurkite įrašą žaidėjų skelbimų lentai

# CharacterBaseView
player-title-characters = {"**"}Žaidėjo komandos – Veikėjai{"**"}
player-desc-register-character = Registruoti naują veikėją.
player-msg-no-characters = Neturite registruotų veikėjų.
player-label-active = (Aktyvus)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Kuriamas veikėjas: { $characterName }{"**"}
    Jūsų veikėjo registracija laukia inventoriaus nustatymo.
player-btn-resume = Tęsti
player-btn-discard = Atmesti
player-modal-title-discard-character = Atmesti veikėją
player-modal-label-discard-confirm = Atmesti { $characterName }?

# Confirm character removal
player-modal-title-confirm-char-removal = Patvirtinti veikėjo pašalinimą
player-modal-label-confirm-char-delete = Ištrinti { $characterName }?

# Confirm post removal
player-modal-title-confirm-post-removal = Patvirtinti įrašo pašalinimą
player-modal-label-post-removal-warning = DĖMESIO: Šis veiksmas negrįžtamas!

# InventoryOverviewView
player-title-inventory = {"**"}Žaidėjo komandos – Inventorius{"**"}
player-title-char-inventory = {"**"}{ $characterName } inventorius{"**"}
player-msg-no-active-character = Nėra aktyvaus veikėjo: aktyvuokite veikėją šiame serveryje, kad galėtumėte naudoti šiuos meniu.
player-msg-no-characters-registered = Nėra veikėjų: užregistruokite veikėją, kad galėtumėte naudoti šiuos meniu.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } daiktų
player-label-currency = {"**"}Valiuta{"**"}
player-msg-inventory-empty = Inventorius tuščias.

# Print inventory embed
player-embed-title-inventory = { $characterName } inventorius

# ContainerItemsView
player-msg-container-empty = Šis konteineris tuščias.
player-label-selected-item = Pasirinkta: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Perkelti „{ $itemName }"{"**"} ({ $available } turima)
player-msg-no-other-containers = Nėra kitų galimų konteinerių.
player-msg-select-destination = Pasirinkite paskirties konteinerį:
player-label-destination = Paskirtis: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Konteinerių valdymas{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } daiktų){ $suffix }
player-label-default-suffix = { " " }(numatytasis)
player-msg-no-containers = Nėra konteinerių.
player-label-selected-container = Pasirinkta: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = Patvirtinti konteinerio ištrynimą
player-modal-label-container-has-items = Turi { $itemCount } daiktų. Bus perkelti į Laisvus daiktus.
player-modal-label-confirm-container-delete = Ištrinti „{ $containerName }"?

# Container errors
player-error-cannot-rename-loose = Negalima pervadinti Laisvų daiktų.
player-error-cannot-delete-loose = Negalima ištrinti Laisvų daiktų.

# PlayerBoardView
player-title-player-board = {"**"}Žaidėjo komandos – Žaidėjų skelbimų lenta{"**"}
player-desc-create-post = Sukurti naują įrašą žaidėjų skelbimų lentai.
player-msg-no-posts = Neturite jokių dabartinių įrašų.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Autorius
player-embed-footer-post-id = Įrašo ID: { $postId }
player-error-board-channel-not-found = Žaidėjų skelbimų lentos kanalas nerastas.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Inventoriaus nustatymas veikėjui { $characterName }{"**"}
player-desc-browse-shop = Naršykite pradinę parduotuvę, kad aprūpintumėte savo veikėją.
player-desc-select-kit = Pasirinkite pradinį rinkinį.
player-desc-input-inventory = Rankiniu būdu įveskite pradinį inventorių.

# StaticKitSelectView
player-title-select-kit = {"**"}Pasirinkite rinkinį veikėjui { $characterName }{"**"}
player-msg-no-kits = Nėra galimų pradinių rinkinių.
player-label-and-more-items = ...ir dar { $count } daiktų
player-label-empty-kit = {"*"}Tuščias rinkinys{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Patvirtinti pasirinkimą: { $kitName }{"**"}
player-label-items-heading = {"**"}Daiktai:{"**"}
player-label-currency-heading = {"**"}Valiuta:{"**"}
player-msg-kit-empty = Šis rinkinys tuščias.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Pirkimo parinktys: { $itemName }{"**"}
player-msg-no-cost-options = Šiam daiktui nėra galimų kainų parinkčių.
player-label-cost-option = {"**"}Parinktis { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Pradinė parduotuvė ({ $inventoryType }){"**"}
player-label-starting-wealth = Pradinis turtas: { $formattedCurrency }
player-label-in-cart = {"**"}(Krepšelyje: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Krepšelio peržiūra{"**"}
player-msg-cart-empty = Jūsų krepšelis tuščias.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Iš viso: { $totalQuantity })
player-label-insufficient-currency = Nepakanka { $currencyName }
player-label-total-cost = {"**"}Bendra kaina:{"**"}
player-label-total-cost-free = {"**"}Bendra kaina:{"**"} Nemokamai
player-label-cart-page = { $current } psl. iš { $total }

# Trade embed
player-embed-title-trade = Prekybos ataskaita
player-embed-desc-trade-sender = Siuntėjas: { $senderMention } kaip `{ $senderCharacter }`
player-embed-desc-trade-recipient = Gavėjas: { $recipientMention } kaip `{ $recipientCharacter }`
player-embed-field-currency = Valiuta
player-embed-field-amount = Suma
player-embed-field-balance = { $characterName } likutis
player-embed-field-item = Daiktas
player-embed-field-quantity = Kiekis
player-embed-footer-transaction-id = Sandorio ID: { $transactionId }

# Trade errors
player-error-trade-no-characters = Žaidėjas, su kuriuo bandote prekiauti, neturi veikėjų!
player-error-trade-no-active = Žaidėjas, su kuriuo bandote prekiauti, neturi aktyvaus veikėjo šiame serveryje!

# Spend currency embed
player-embed-title-spend = Žaidėjo sandorio ataskaita
player-embed-desc-spend-player = Žaidėjas: { $playerMention } kaip `{ $characterName }`
player-embed-desc-spend-transaction = Sandoris: {"**"}{ $characterName }{"**"} išleido {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Kanalas
player-embed-field-receipt = Kvitas

# Spend currency errors
player-error-amount-not-number = Suma turi būti skaičius.
player-error-amount-positive = Turite išleisti teigiamą sumą.
player-error-amount-exceeds-maximum = Suma negali viršyti { $max }.
player-error-no-active-character-server = Neturite aktyvaus veikėjo šiame serveryje.
player-error-no-currency-config = Šiam serveriui nerasta valiutos konfigūracija.

# Consume item embed
player-embed-title-consume = Daikto sunaudojimo ataskaita
player-embed-desc-consume = Žaidėjas: { $playerMention } kaip `{ $characterName }`
player-embed-desc-consume-removed = Pašalinta: {"**"}{ $quantity }x { $itemName }{"**"} iš {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = Kiekis turi būti teigiamas sveikasis skaičius.
player-error-qty-at-least-one = Kiekis turi būti bent 1.
player-error-qty-only-have = Turite tik { $maxQuantity } šio daikto.

# Inventory input errors
player-error-invalid-format = Netinkamas formatas: „{ $line }". Naudokite <pavadinimas>: <kiekis>.
player-error-empty-name = Daikto pavadinimas negali būti tuščias eilutėje: „{ $line }".
player-error-invalid-quantity = Netinkamas kiekis „{ $name }": „{ $quantity }". Turi būti teigiamas sveikasis skaičius.
player-error-input-errors-header = Inventoriaus įvedimo klaidos:
player-msg-no-valid-items = Nepateikta tinkamų daiktų. Inicializuojama su tuščiu inventoriumi.

# Cart quantity validation
player-error-enter-valid-number = Įveskite tinkamą teigiamą skaičių.

# Submission embeds (approval queue)
player-embed-title-approval = Inventoriaus patvirtinimas: { $characterName }
player-embed-desc-submitted-by = Pateikė { $userMention }
player-embed-field-items = Daiktai
player-embed-field-currency-received = Valiuta
player-embed-footer-submission-id = Pateikimo ID: { $submissionId }
player-label-approval-thread = Patvirtinimas: { $characterName }
player-embed-title-submission-sent = Inventoriaus pateikimas išsiųstas
player-embed-desc-submission-sent =
    Jūsų pateikimas veikėjui {"**"}{ $characterName }{"**"} buvo išsiųstas GM komandai patvirtinti!
    Būsite informuoti, kai jis bus peržiūrėtas.
    [Peržiūrėti pateikimo giją]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = Pradinis inventorius pritaikytas
player-embed-desc-starting-inventory = Žaidėjas: { $playerMention } kaip `{ $characterName }`
player-embed-field-items-received = Gauti daiktai
player-embed-field-currency-received-label = Gauta valiuta
player-label-untitled = Be pavadinimo

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventory Submission: { $characterName }{"**"}
    Submitted by { $userMention }
player-approval-post-items = Daiktai
player-approval-post-currency = Valiuta
player-approval-resolved = Ši paraiška buvo išspręsta.
player-approval-btn-approve = Patvirtinti
player-approval-btn-deny = Atmesti
player-approval-btn-edit = Redaguoti
player-approval-error-no-permission = Neturite leidimo atlikti šį veiksmą.
player-approval-error-not-submitter = Tik pradinis pateikėjas gali redaguoti šią paraišką.
player-approval-thread-instructions =
    This thread was created for the approval of {"**"}{ $characterName }{"**"}.
    A Game Master will review the submission and approve or deny it.
    Once approved or denied, this thread will be locked.

    {"**"}Game Masters:{"**"} Discuss any required changes with your
    player until the inventory is in an acceptable state. Only use
    the `Deny` button for irreconcilable submissions.

    { $playerMention }: Use the `Edit` button to make any changes
    requested here by a Game Master.
player-approval-approved-by = Ši paraiška buvo patvirtinta { $approver }.
player-approval-denied-by = Ši paraiška buvo atmesta { $denier }.
player-approval-deny-reason = Priežastis: { $reason }
player-msg-submission-updated = Jūsų paraiška atnaujinta.


# Denial modal
player-modal-title-deny-reason = Atmesti paraišką
player-modal-label-deny-reason = Atmetimo priežastis
player-modal-placeholder-deny-reason = Neprivaloma: paaiškinkite atmetimo priežastį
# Approval DM notifications
player-dm-title-approved = Veikėjas patvirtintas
player-dm-desc-approved =
    Your character {"**"}{ $characterName }{"**"} has been approved
    by { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Veikėjas atmestas
player-dm-desc-denied =
    Your character {"**"}{ $characterName }{"**"} has been denied
    by { $denier } in {"**"}{ $guildName }{"**"}.
