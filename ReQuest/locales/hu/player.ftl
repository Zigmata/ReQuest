## Player module strings

# --- Cog ---

player-cmd-name = Kereskedés
player-cmd-desc = Játékos menük

# --- Buttons ---

# Character management
player-btn-register-character = Új karakter regisztrálása
player-btn-activate = Aktiválás
player-btn-active = Aktív

# Player board
player-btn-create-post = Bejegyzés létrehozása
player-btn-open-starting-shop = Kezdő bolt megnyitása
player-btn-select-kit = Készlet kiválasztása
player-btn-input-inventory = Leltár megadása

# Wizard / shop buttons
player-btn-add-to-cart = Kosárba
player-btn-add-to-cart-cost = Kosárba ({ $costString })
player-btn-view-purchase-options = Vásárlási lehetőségek megtekintése
player-btn-review-submit = Áttekintés és beküldés ({ $count })
player-btn-submit-character = Karakter beküldése
player-btn-keep-shopping = Tovább vásárlás
player-btn-edit-quantity = Mennyiség szerkesztése
player-btn-clear-cart = Kosár ürítése

# Kit buttons
player-btn-confirm-selection = Kiválasztás megerősítése
player-btn-back-to-kits = Vissza a készletekhez

# Inventory management
player-btn-spend-currency = Valuta költése
player-btn-print-inventory = Leltár nyomtatása

# Container management
player-btn-manage-containers = Tárolók kezelése
player-btn-create-new = + Új létrehozása
player-btn-consume-destroy = Felhasználás/Megsemmisítés
player-btn-move = Áthelyezés
player-btn-move-all = Összes áthelyezése
player-btn-move-some = Néhány áthelyezése...
player-btn-back-to-overview = ← Vissza az áttekintéshez
player-btn-cancel-move = ← Mégse
player-btn-up = ▲ Fel
player-btn-down = ▼ Le

# --- Modals ---

# Trade modal
player-modal-title-trade = Kereskedés { $targetName } játékossal
player-modal-label-trade-name = Név
player-modal-placeholder-trade-name = Add meg a kereskedett tárgy nevét
player-modal-label-trade-quantity = Mennyiség
player-modal-placeholder-trade-quantity = Add meg a kereskedett mennyiséget

# Character register modal
player-modal-title-register = Új karakter regisztrálása
player-modal-label-char-name = Név
player-modal-placeholder-char-name = Add meg a karaktered nevét.
player-modal-label-char-note = Megjegyzés
player-modal-placeholder-char-note = Adj meg egy megjegyzést a karaktered azonosításához

# Open inventory input modal
player-modal-title-starting-inventory = Kezdő leltár megadása
player-modal-label-inventory = Leltár
player-modal-placeholder-inventory-input =
    Soronként egy, <név>: <mennyiség> formátumban, pl.:
    Kard: 1
    arany: 30

# Spend currency modal
player-modal-title-spend-currency = Valuta költése
player-modal-label-currency-name = Valuta neve
player-modal-placeholder-currency-name = Add meg a költeni kívánt valuta nevét
player-modal-label-currency-amount = Összeg
player-modal-placeholder-currency-amount = Add meg a költendő összeget

# Create player post modal
player-modal-title-create-post = Játékos hirdetőtábla bejegyzés létrehozása
player-modal-label-post-title = Cím
player-modal-placeholder-post-title = Adj meg egy címet a bejegyzésedhez
player-modal-label-post-content = Bejegyzés tartalma
player-modal-placeholder-post-content = Írd meg a bejegyzésed szövegét

# Edit player post modal
player-modal-title-edit-post = Játékos hirdetőtábla bejegyzés szerkesztése

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = Kosár mennyiségének szerkesztése
player-modal-label-cart-qty = Mennyiség
player-modal-placeholder-cart-qty = Add meg az új mennyiséget (0 = eltávolítás)

# Create container modal
player-modal-title-create-container = Új tároló létrehozása
player-modal-label-container-name = Tároló neve
player-modal-placeholder-container-name = Adj meg egy nevet a tárolónak (pl. Hátizsák)

# Rename container modal
player-modal-title-rename-container = Tároló átnevezése
player-modal-label-new-container-name = Új tároló név
player-modal-placeholder-new-container-name = Add meg az új nevet

# Consume from container modal
player-modal-title-consume = Tárgy felhasználása/megsemmisítése
player-modal-label-consume-qty = Mennyiség (max: { $maxQuantity })
player-modal-placeholder-consume-qty = Add meg a felhasználandó/megsemmisítendő mennyiséget

# Move item quantity modal
player-modal-title-move-item = Tárgy áthelyezése
player-modal-label-move-qty = Áthelyezendő mennyiség (max: { $maxQuantity })
player-modal-placeholder-move-qty = Add meg az áthelyezendő mennyiséget

# --- Selects ---

player-select-placeholder-no-characters = Nincsenek regisztrált karaktereid
player-select-placeholder-remove-character = Válassz egy karaktert az eltávolításhoz
player-select-placeholder-post = Válassz bejegyzést
player-select-placeholder-container-view = Válassz egy tárolót a megtekintéshez...
player-select-placeholder-item = Válassz tárgyat...
player-select-placeholder-destination = Válassz célt...
player-select-placeholder-container = Válassz tárolót...
player-select-option-no-containers = Nincsenek tárolók
player-select-option-no-items = Nincsenek tárgyak
player-select-option-no-destinations = Nincsenek célok

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}Játékos parancsok - Főmenü{"**"}
player-menu-btn-characters = Karakterek
player-menu-desc-characters = Játékoskarakterek regisztrálása, megtekintése és aktiválása.
player-menu-btn-inventory = Leltár
player-menu-desc-inventory = Az aktív karaktered leltárának megtekintése és valuta költése.
player-menu-btn-player-board = Játékos hirdetőtábla
player-menu-btn-player-board-disabled = Játékos hirdetőtábla (Nincs konfigurálva)
player-menu-desc-player-board = Bejegyzés létrehozása a Játékos hirdetőtáblára

# CharacterBaseView
player-title-characters = {"**"}Játékos parancsok - Karakterek{"**"}
player-desc-register-character = Új karakter regisztrálása.
player-msg-no-characters = Nincsenek regisztrált karaktereid.
player-label-active = (Aktív)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Folyamatban lévő karakter: { $characterName }{"**"}
    A karakter regisztrációja a felszerelés beállítására vár.
player-btn-resume = Folytatás
player-btn-discard = Elvetés
player-modal-title-discard-character = Karakter elvetése
player-modal-label-discard-confirm = { $characterName } elvetése?

# Confirm character removal
player-modal-title-confirm-char-removal = Karakter eltávolításának megerősítése
player-modal-label-confirm-char-delete = Törlöd a következőt: { $characterName }?

# Confirm post removal
player-modal-title-confirm-post-removal = Bejegyzés eltávolításának megerősítése
player-modal-label-post-removal-warning = FIGYELEM: Ez a művelet visszafordíthatatlan!

# InventoryOverviewView
player-title-inventory = {"**"}Játékos parancsok - Leltár{"**"}
player-title-char-inventory = {"**"}{ $characterName } leltára{"**"}
player-msg-no-active-character = Nincs aktív karakter: Aktiválj egy karaktert ezen a szerveren a menük használatához.
player-msg-no-characters-registered = Nincs karakter: Regisztrálj egy karaktert a menük használatához.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } tárgy
player-label-currency = {"**"}Valuta{"**"}
player-msg-inventory-empty = A leltár üres.

# Print inventory embed
player-embed-title-inventory = { $characterName } leltára

# ContainerItemsView
player-msg-container-empty = Ez a tároló üres.
player-label-selected-item = Kiválasztva: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}„{ $itemName }" áthelyezése{"**"} ({ $available } elérhető)
player-msg-no-other-containers = Nincs más elérhető tároló.
player-msg-select-destination = Válaszd ki a céltárolót:
player-label-destination = Cél: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Tárolók kezelése{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } tárgy){ $suffix }
player-label-default-suffix = { " " }(alapértelmezett)
player-msg-no-containers = Nincsenek tárolók.
player-label-selected-container = Kiválasztva: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = Tároló törlésének megerősítése
player-modal-label-container-has-items = { $itemCount } tárgyat tartalmaz. Szabad tárgyak közé kerülnek.
player-modal-label-confirm-container-delete = Törlöd a(z) „{ $containerName }" tárolót?

# Container errors
player-error-cannot-rename-loose = A Szabad tárgyak nem nevezhető át.
player-error-cannot-delete-loose = A Szabad tárgyak nem törölhető.

# PlayerBoardView
player-title-player-board = {"**"}Játékos parancsok - Játékos hirdetőtábla{"**"}
player-desc-create-post = Új bejegyzés létrehozása a Játékos hirdetőtáblára.
player-msg-no-posts = Nincsenek jelenlegi bejegyzéseid.
player-label-post-info = {"**"}{ $title }{"**"} (Azon: `{ $postId }`)
player-embed-field-author = Szerző
player-embed-footer-post-id = Bejegyzés ID: { $postId }
player-error-board-channel-not-found = A Játékos hirdetőtábla csatorna nem található.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Leltár beállítása: { $characterName }{"**"}
player-desc-browse-shop = Böngészd a Kezdő boltot a karaktered felszereléséhez.
player-desc-select-kit = Válassz egy Kezdő készletet.
player-desc-input-inventory = Kézzel add meg a kezdő leltáradat.

# StaticKitSelectView
player-title-select-kit = {"**"}Készlet kiválasztása: { $characterName }{"**"}
player-msg-no-kits = Nincsenek elérhető kezdő készletek.
player-label-and-more-items = ...és még { $count } tárgy
player-label-empty-kit = {"*"}Üres készlet{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Kiválasztás megerősítése: { $kitName }{"**"}
player-label-items-heading = {"**"}Tárgyak:{"**"}
player-label-currency-heading = {"**"}Valuta:{"**"}
player-msg-kit-empty = Ez a készlet üres.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Vásárlási lehetőségek: { $itemName }{"**"}
player-msg-no-cost-options = Ehhez a tárgyhoz nincs elérhető vásárlási lehetőség.
player-label-cost-option = {"**"}{ $index }. lehetőség:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Kezdő bolt ({ $inventoryType }){"**"}
player-label-starting-wealth = Kezdő vagyon: { $formattedCurrency }
player-label-in-cart = {"**"}(Kosárban: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Kosár áttekintése{"**"}
player-msg-cart-empty = A kosarad üres.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Összesen: { $totalQuantity })
player-label-insufficient-currency = Nem elegendő { $currencyName }
player-label-total-cost = {"**"}Összköltség:{"**"}
player-label-total-cost-free = {"**"}Összköltség:{"**"} Ingyenes
player-label-cart-page = { $current }. oldal / { $total }

# Trade embed
player-embed-title-trade = Kereskedési jelentés
player-embed-desc-trade-sender = Küldő: { $senderMention } mint `{ $senderCharacter }`
player-embed-desc-trade-recipient = Címzett: { $recipientMention } mint `{ $recipientCharacter }`
player-embed-field-currency = Valuta
player-embed-field-amount = Összeg
player-embed-field-balance = { $characterName } egyenlege
player-embed-field-item = Tárgy
player-embed-field-quantity = Mennyiség
player-embed-footer-transaction-id = Tranzakció ID: { $transactionId }

# Trade errors
player-error-trade-no-characters = A játékosnak, akivel kereskedni próbálsz, nincsenek karakterei!
player-error-trade-no-active = A játékosnak, akivel kereskedni próbálsz, nincs aktív karaktere ezen a szerveren!

# Spend currency embed
player-embed-title-spend = Játékos tranzakciós jelentés
player-embed-desc-spend-player = Játékos: { $playerMention } mint `{ $characterName }`
player-embed-desc-spend-transaction = Tranzakció: {"**"}{ $characterName }{"**"} elköltött {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Csatorna
player-embed-field-receipt = Nyugta

# Spend currency errors
player-error-amount-not-number = Az összegnek számnak kell lennie.
player-error-amount-positive = Pozitív összeget kell költened.
player-error-amount-exceeds-maximum = Az összeg nem haladhatja meg a { $max } értéket.
player-error-no-active-character-server = Nincs aktív karaktered ezen a szerveren.
player-error-no-currency-config = Nem található valutakonfiguráció ehhez a szerverhez.

# Consume item embed
player-embed-title-consume = Tárgy felhasználási jelentés
player-embed-desc-consume = Játékos: { $playerMention } mint `{ $characterName }`
player-embed-desc-consume-removed = Eltávolítva: {"**"}{ $quantity }x { $itemName }{"**"} a(z) {"**"}{ $containerName }{"**"} tárolóból

# Consume item errors
player-error-qty-positive-integer = A mennyiségnek pozitív egész számnak kell lennie.
player-error-qty-at-least-one = A mennyiségnek legalább 1-nek kell lennie.
player-error-qty-only-have = Csak { $maxQuantity } darab van ebből a tárgyból.

# Inventory input errors
player-error-invalid-format = Érvénytelen formátum: „{ $line }". Használd a <név>: <mennyiség> formátumot.
player-error-empty-name = A tárgy neve nem lehet üres ebben a sorban: „{ $line }".
player-error-invalid-quantity = Érvénytelen mennyiség „{ $name }" tárgyhoz: „{ $quantity }". Pozitív egész számnak kell lennie.
player-error-input-errors-header = Hibák a leltár megadásában:
player-msg-no-valid-items = Nem adtál meg érvényes tárgyakat. Üres leltár inicializálása.

# Validation error view
player-validation-error-title = Beviteli hibák
player-validation-btn-retry = Újrapróbálás

# Cart quantity validation
player-error-enter-valid-number = Kérjük, adj meg egy érvényes pozitív számot.

# Submission embeds (approval queue)
player-embed-title-approval = Leltár jóváhagyás: { $characterName }
player-embed-desc-submitted-by = Beküldő: { $userMention }
player-embed-field-items = Tárgyak
player-embed-field-currency-received = Valuta
player-embed-footer-submission-id = Beküldés ID: { $submissionId }
player-label-approval-thread = Jóváhagyás: { $characterName }
player-embed-title-submission-sent = Leltár beküldés elküldve
player-embed-desc-submission-sent =
    A(z) {"**"}{ $characterName }{"**"} beküldésed elküldve a GM csapatnak jóváhagyásra!
    Értesítést kapsz, amint felülvizsgálták.
    [Beküldés témájának megtekintése]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = Kezdő leltár alkalmazva
player-embed-desc-starting-inventory = Játékos: { $playerMention } mint `{ $characterName }`
player-embed-field-items-received = Kapott tárgyak
player-embed-field-currency-received-label = Kapott valuta
player-label-untitled = Névtelen

# ApprovalPostView
player-approval-post-header =
    {"**"}Leltár beadvány: { $characterName }{"**"}
    Beküldő: { $userMention }
player-approval-post-items = Tárgyak
player-approval-post-currency = Pénznem
player-approval-resolved = Ez a beadvány feldolgozásra került.
player-approval-btn-approve = Jóváhagyás
player-approval-btn-deny = Elutasítás
player-approval-btn-edit = Szerkesztés
player-approval-error-no-permission = Nincs jogosultságod ehhez a művelethez.
player-approval-error-not-submitter = Csak az eredeti benyújtó szerkesztheti ezt a beadványt.
player-approval-thread-instructions =
    Ez a szál a(z) {"**"}{ $characterName }{"**"} jóváhagyásához jött létre.
    Egy Játékmester felülvizsgálja a beadványt, és jóváhagyja vagy elutasítja.
    Jóváhagyás vagy elutasítás után ez a szál lezárásra kerül.

    {"**"}Játékmesterek:{"**"} Beszéljétek meg a szükséges
    változtatásokat a játékossal, amíg a leltár elfogadható
    állapotba nem kerül. Az `Elutasítás` gombot csak
    összeegyeztethetetlen beadványok esetén használjátok.

    { $playerMention }: Használd a `Szerkesztés` gombot a
    Játékmester által itt kért módosítások elvégzéséhez.
player-approval-approved-by = Ezt a beadványt { $approver } jóváhagyta.
player-approval-denied-by = Ezt a beadványt { $denier } elutasította.
player-approval-deny-reason = Indok: { $reason }
player-msg-submission-updated = A beadványod frissítve lett.


# Denial modal
player-modal-title-deny-reason = Beadvány elutasítása
player-modal-label-deny-reason = Elutasítás indoka
player-modal-placeholder-deny-reason = Opcionális: magyarázza el az elutasítás okát
# Approval DM notifications
player-dm-title-approved = Karakter jóváhagyva
player-dm-desc-approved =
    A(z) {"**"}{ $characterName }{"**"} karakteredet jóváhagyta
    { $approver } a(z) {"**"}{ $guildName }{"**"} szerveren!
player-dm-title-denied = Karakter elutasítva
player-dm-desc-denied =
    A(z) {"**"}{ $characterName }{"**"} karakteredet elutasította
    { $denier } a(z) {"**"}{ $guildName }{"**"} szerveren.
