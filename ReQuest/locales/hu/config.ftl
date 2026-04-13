## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = Törlés
config-btn-remove-gm-roles = GM szerepek eltávolítása
config-btn-forbidden-roles = Tiltott szerepek

# Quests
config-btn-toggle-quest-summary = Quest összefoglaló váltása
config-btn-toggle-player-experience = Játékos tapasztalat váltása
config-btn-toggle-display = Megjelenítés váltása
config-btn-purge-player-board = Játékos hirdetőtábla törlése
config-btn-add-modify-rewards = Jutalmak hozzáadása/módosítása

# Currency
config-btn-add-denomination = Címlet hozzáadása
config-btn-add-new-currency = Új valuta hozzáadása
config-btn-remove-currency = Valuta eltávolítása

# Shops - creation
config-btn-add-shop-wizard = Bolt hozzáadása (Varázsló)
config-btn-add-shop-json = Bolt hozzáadása (JSON)
config-btn-edit-shop-wizard = Bolt szerkesztése (Varázsló)
config-btn-edit-shop-json = Bolt szerkesztése (JSON)
config-btn-remove-shop = Bolt eltávolítása
config-btn-add-item = Tárgy hozzáadása
config-btn-edit-shop-details = Bolt részleteinek szerkesztése
config-btn-download-json = JSON letöltése
config-btn-done-editing = Szerkesztés befejezése
config-btn-scan-server-configs = Szerver konfiguráció ellenőrzése
config-btn-re-scan = Újraellenőrzés

# New character shop
config-btn-upload-json = JSON feltöltése
config-btn-configure-new-character-wealth = Kezdő vagyon beállítása
config-btn-configure-new-character-shop = Új karakter bolt beállítása
config-btn-clear-shop = Bolt törlése
config-btn-configure-static-kits = Statikus készletek beállítása
config-btn-new-character-settings = Új karakter beállítások
config-btn-disabled-no-currency = Letiltva (Nincs valuta konfigurálva)
config-btn-disabled-no-wealth = Letiltva (Nincs kezdő vagyon konfigurálva)

# Static kits
config-btn-create-new-kit = Új készlet létrehozása
config-btn-delete-kit = Készlet törlése
config-btn-add-currency = Valuta hozzáadása

# Roleplay
config-btn-toggle-rp-rewards = RP jutalmak váltása
config-btn-clear-channels = Csatornák törlése
config-btn-edit-settings = Beállítások szerkesztése
config-btn-configure-rewards = Jutalmak beállítása

# Stock
config-btn-stock-limits = Készletkorlátok
config-btn-set-limit = Korlát beállítása
config-btn-edit-limit = Korlát szerkesztése
config-btn-remove-limit = Korlát eltávolítása
config-btn-configure-restock-schedule = Feltöltési ütemezés beállítása
config-btn-back-to-shop-editor = Vissza a boltszerkesztőhöz

# Forum shop
config-btn-create-new-thread = Új téma létrehozása
config-btn-use-existing-thread = Meglévő téma használata

# Wizard
config-btn-quit = Kilépés
config-btn-configure-channels = Csatornák beállítása
config-btn-configure-roles = Szerepek beállítása
config-btn-configure-quests = Questek beállítása
config-btn-configure-players = Játékosok beállítása
config-btn-configure-currency = Valuta beállítása
config-btn-configure-rp-rewards = RP jutalmak beállítása
config-btn-configure-shops = Boltok beállítása
config-btn-new-char-setup = Új karakter beáll.

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = Szerep eltávolításának megerősítése
config-modal-title-confirm-removal = Eltávolítás megerősítése
config-modal-title-confirm-currency-removal = Valuta eltávolításának megerősítése
config-modal-title-confirm-shop-removal = Bolt eltávolításának megerősítése
config-modal-title-confirm-kit-deletion = Készlet törlésének megerősítése
config-modal-title-confirm-remove-stock-limit = Készletkorlát eltávolításának megerősítése
config-modal-title-clear-shop = Bolt törlésének megerősítése

# Confirm modal prompt labels
config-modal-label-remove-role = Eltávolítod a(z) { $roleName } szerepet?
config-modal-label-remove-denomination = Eltávolítod a(z) { $denominationName } címletet?
config-modal-label-remove-currency = Eltávolítod a(z) { $currencyName } valutát?
config-modal-label-shop-removal-warning = FIGYELEM: Ez a művelet visszafordíthatatlan!
config-modal-label-kit-deletion-warning = FIGYELEM: Visszafordíthatatlan!
config-modal-label-remove-stock-limit = Írd be: MEGERŐSÍT a készletkorlát eltávolításához
config-modal-label-clear-shop = Az összes tárgy törlése ebből a boltból?

# Error messages from buttons
config-error-shop-data-not-found = Hiba: A bolt adatai nem találhatók.
config-msg-shop-json-download = Itt a JSON definíció a(z) {"**"}{ $shopName }{"**"} bolthoz.
config-msg-new-char-shop-json-download = Itt a JSON definíció az Új karakter bolthoz.
config-error-select-forum-first = Kérjük, először válassz egy Forum csatornát.
config-error-select-thread-first = Kérjük, először válassz egy témát.

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Új valuta hozzáadása
config-modal-label-currency-name = Valuta neve
config-error-currency-already-exists = Már létezik egy { $name } nevű valuta vagy címlet!

# RenameCurrencyModal
config-modal-title-rename-currency = Valuta átnevezése
config-modal-label-new-currency-name = Új valutanév
config-error-currency-name-exists = Már létezik egy „{ $name }" nevű valuta.
config-error-denomination-name-exists = Már létezik egy „{ $name }" nevű címlet.

# RenameDenominationModal
config-modal-title-rename-denomination = Címlet átnevezése
config-modal-label-new-denomination-name = Új címletnév

# AddCurrencyDenominationModal
config-modal-title-add-denomination = { $currencyName } címlet hozzáadása
config-modal-label-denomination-name = Név
config-modal-placeholder-denomination-name = pl. Ezüst
config-modal-label-denomination-value = Érték
config-modal-placeholder-denomination-value = pl. 0.1
config-error-denomination-matches-currency = Az új címlet neve nem egyezhet meg egy meglévő valutával ezen a szerveren! Meglévő valuta: „{ $existingName }".
config-error-denomination-matches-denomination = Az új címlet neve nem egyezhet meg egy meglévő címlettel ezen a szerveren! Meglévő címlet: „{ $denominationName }" a „{ $currencyName }" valuta alatt.
config-error-denomination-value-exists = Egy valuta címletei egyedi értékekkel kell rendelkezzenek! A(z) { $denominationName } már rendelkezik ezzel az értékkel.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Tiltott szerepnevek
config-modal-label-names = Nevek
config-modal-placeholder-names = Add meg a neveket vesszővel elválasztva
config-msg-forbidden-roles-updated = Tiltott szerepek frissítve!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Játékos hirdetőtábla törlése
config-modal-label-age = Kor
config-modal-placeholder-age = Add meg a megtartandó bejegyzések maximális korát (napokban)
config-msg-posts-purged = A { $days } napnál régebbi bejegyzések törölve lettek!

# GMRewardsModal
config-modal-title-gm-rewards = GM jutalmak hozzáadása/módosítása
config-modal-label-experience = Tapasztalat
config-modal-placeholder-enter-number = Adj meg egy számot
config-modal-label-items = Tárgyak
config-modal-placeholder-items =
    Név: Mennyiség
    Név2: Mennyiség
    stb.
config-error-experience-invalid = A tapasztalatnak érvényes egész számnak kell lennie (pl. 2000).
config-error-item-format-invalid = Érvénytelen tárgyformátum: „{ $item }". Minden tárgyat új sorba kell írni, „Név: Mennyiség" formátumban.

# ConfigShopDetailsModal
config-modal-title-shop-details = Bolt részleteinek hozzáadása/szerkesztése
config-modal-label-shop-channel = Válassz csatornát
config-modal-placeholder-shop-channel = Válaszd ki a bolt csatornáját
config-modal-label-shop-name = Bolt neve
config-modal-placeholder-shop-name = Add meg a bolt nevét
config-modal-label-shopkeeper-name = Boltos neve
config-modal-placeholder-shopkeeper-name = Add meg a boltos nevét
config-modal-label-shop-description = Bolt leírása
config-modal-placeholder-shop-description = Adj meg leírást a bolthoz
config-modal-label-shop-image-url = Bolt kép URL
config-modal-placeholder-shop-image-url = Adj meg URL-t a bolt képéhez
config-error-no-channel-selected = Nincs csatorna kiválasztva a bolthoz.
config-error-shop-already-in-channel = A kiválasztott csatornában már van bolt regisztrálva. Kérjük, válassz másik csatornát, vagy szerkeszd a meglévő boltot.

# build_shop_header_view
config-label-shopkeeper = {"**"}Boltos:{"**"} { $name }
config-msg-use-shop-command = Használd a `/shop` parancsot a tárgyak böngészéséhez és vásárlásához.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Forum téma bolt létrehozása
config-modal-label-thread-name = Téma neve
config-modal-placeholder-thread-name = Add meg a bolt témájának nevét
config-error-forum-not-found = A kiválasztott Forum csatorna nem található.
config-error-shop-already-in-thread = Ebben a témában már van regisztrált bolt. Ez nem fordulhat elő új téma esetén.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Új bolt hozzáadása JSON-nal
config-modal-label-upload-json = Tölts fel egy .json fájlt a bolt adataival
config-error-no-json-uploaded = Nem lett JSON fájl feltöltve a bolthoz.
config-error-file-must-be-json = A feltöltött fájlnak JSON fájlnak (.json) kell lennie.
config-error-invalid-json = Érvénytelen JSON formátum: { $error }
config-error-json-validation-failed = A JSON nem felel meg a sémának: { $error }

# ShopItemModal
config-modal-title-shop-item = Bolt tárgy hozzáadása/szerkesztése
config-modal-label-item-name = Tárgy neve
config-modal-placeholder-item-name = Add meg a tárgy nevét
config-modal-label-item-description = Tárgy leírása
config-modal-placeholder-item-description = Adj meg leírást a tárgyhoz
config-modal-label-item-quantity = Tárgy mennyisége
config-modal-placeholder-item-quantity = Add meg a vásárlásonként eladott mennyiséget
config-modal-label-item-costs = Tárgy árak
config-modal-placeholder-item-costs = Pl.: 10 arany + 5 ezüst\nVAGY: 50 hírnév\n(Használj +-t az ÉS-hez, új sort a VAGY-hoz)
config-error-item-quantity-positive = A tárgy mennyiségének pozitív egész számnak kell lennie.
config-error-cost-format-invalid = Érvénytelen árformátum: „{ $option }". Minden árnak tartalmaznia kell egy összeget és egy valutát szóközzel elválasztva, pl. „10 arany".
config-error-cost-amount-invalid = Érvénytelen összeg „{ $amount }" a(z) „{ $currency }" valutához. Az összegnek pozitív számnak kell lennie.
config-error-unknown-currency = Ismeretlen valuta `{ $currency }`. Kérjük, használj egy, a szerveren konfigurált érvényes valutát.
config-error-item-already-exists = Már létezik egy { $itemName } nevű tárgy ebben a boltban.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Bolt frissítése JSON-nal
config-modal-label-upload-new-json = Új JSON definíció feltöltése
config-error-no-file-uploaded = Nem lett fájl feltöltve.
config-error-file-must-be-json-ext = A fájlnak `.json` fájlnak kell lennie.
config-error-json-validation-message = JSON érvényesítés sikertelen: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Új karakter felszerelés hozzáadása/szerkesztése
config-modal-placeholder-item-quantity-selection = Add meg a kiválasztásonként kapott mennyiséget
config-modal-label-item-cost = Tárgy ára
config-error-cost-format-short = Érvénytelen árformátum: '{ $component }'. Várt formátum: 'Összeg Valuta'.
config-error-amount-invalid-short = Érvénytelen összeg '{ $amount }' a '{ $currency }' valutához.
config-error-item-exists-new-char = Már létezik egy { $itemName } nevű tárgy az Új karakter boltban.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Új karakter bolt feltöltése (JSON)
config-error-no-json-uploaded-short = Nem lett JSON fájl feltöltve.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Kezdő vagyon beállítása
config-modal-label-amount = Összeg
config-modal-placeholder-amount = Add meg ennek a valutának az összegét.
config-modal-placeholder-currency-name = Add meg a szerveren definiált valuta nevét
config-error-no-currencies-configured = Nincsenek valuták konfigurálva ezen a szerveren.
config-error-currency-not-found = A(z) { $name } nevű valuta vagy címlet nem található. Kérjük, használj érvényes valutát.

# CreateStaticKitModal
config-modal-title-create-kit = Új statikus készlet létrehozása
config-modal-label-kit-name = Készlet neve
config-modal-placeholder-kit-name = pl. Harcos kezdőcsomag
config-modal-label-description = Leírás
config-modal-placeholder-kit-description = Opcionális leírás ehhez a készlethez
config-error-kit-name-exists = Már létezik egy „{ $kitName }" nevű statikus készlet. Kérjük, válassz másik nevet.

# StaticKitItemModal
config-modal-title-kit-item = Készlet tárgy hozzáadása/szerkesztése
config-modal-placeholder-kit-item-quantity = Add meg a készletbe kerülő mennyiséget

# StaticKitCurrencyModal
config-modal-title-kit-currency = Készlet valuta hozzáadása
config-modal-placeholder-currency-eg = pl. Arany
config-modal-placeholder-amount-eg = pl. 100
config-error-amount-must-be-number = Az összegnek számnak kell lennie.
config-error-amount-exceeds-maximum = Az összeg nem haladhatja meg a { $max } értéket.
config-error-no-currencies-on-server = Nincsenek valuták konfigurálva a szerveren.
config-error-currency-not-found-short = A(z) „{ $currency }" valuta nem található.
config-error-denomination-not-found = A(z) „{ $denomination }" címlet nem található a valutakonfigurációban.

# RoleplaySettingsModal
config-modal-title-rp-settings = Szerepjáték beállítások
config-modal-label-min-message-length = Minimális üzenethossz (karakterek)
config-modal-placeholder-min-message-length = A jogosultsághoz szükséges karakterek száma. 0 = nincs korlát
config-modal-label-cooldown = Lehűlési idő (másodperc)
config-modal-placeholder-cooldown = Várakozási idő, másodpercben, mielőtt az üzenet ismét számítana
config-modal-label-message-threshold = Üzenetküszöb
config-modal-placeholder-message-threshold = A jutalom kiváltásához szükséges üzenetek száma
config-modal-label-frequency = Gyakoriság (üzenetek száma)
config-modal-placeholder-frequency = A jutalom megszerzéséhez szükséges jogosult üzenetek száma
config-error-min-length-invalid = A minimális üzenethossznak nemnegatív egész számnak kell lennie.
config-error-cooldown-invalid = A lehűlési időnek nemnegatív egész számnak kell lennie.
config-error-threshold-invalid = Az üzenetküszöbnek pozitív egész számnak kell lennie.
config-error-frequency-invalid = A gyakoriságnak pozitív egész számnak kell lennie.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Szerepjáték jutalmak beállítása
config-modal-label-items-name-quantity = Tárgyak (Név: Mennyiség)
config-modal-label-currency-name-amount = Valuta (Név: Összeg)
config-error-experience-non-negative = A tapasztalatnak nemnegatív egész számnak kell lennie.
config-error-item-quantity-positive-named = A(z) „{ $itemName }" tárgy mennyiségének pozitív egész számnak kell lennie.
config-error-currency-amount-positive = A(z) „{ $currencyName }" valuta összegének pozitív számnak kell lennie.

# SetItemStockModal
config-modal-title-stock-limit = Készletkorlát: { $itemName }
config-modal-label-max-stock = Maximális készlet
config-modal-placeholder-max-stock = Add meg a maximális készletet (pl. 10)
config-modal-label-current-stock = Jelenlegi készlet
config-modal-placeholder-current-stock = Add meg a jelenleg elérhető készletet
config-modal-label-restock-increment = Feltöltési lépés (ciklusonként)
config-modal-placeholder-restock-increment = Ciklusonként hozzáadott mennyiség (alapértelmezett: 1)
config-error-max-stock-positive = A maximális készletnek pozitív egész számnak kell lennie.
config-error-current-stock-non-negative = A jelenlegi készletnek nemnegatív egész számnak kell lennie.
config-error-current-exceeds-max = A jelenlegi készlet nem haladhatja meg a maximális készletet.
config-error-item-not-in-shop = A(z) „{ $itemName }" tárgy nem található a boltban.

# RestockScheduleModal
config-modal-title-restock-schedule = Feltöltési ütemezés beállítása
config-modal-restock-schedule-label = Ütemezés
config-modal-restock-schedule-none = Nincs (Kikapcsolva)
config-modal-restock-schedule-hourly = Óránként
config-modal-restock-schedule-daily = Naponta
config-modal-restock-schedule-weekly = Hetente
config-modal-label-time = Időpont (ÓÓ:PP UTC-ben)
config-modal-desc-current-time = Jelenlegi idő: { $utcTime }
config-modal-placeholder-time = pl. 14:30 = 14:30 UTC
config-modal-restock-day-label = A hét napja (csak hetente)
config-modal-restock-mode-label = Feltöltési mód
config-modal-restock-mode-full = Teljes (visszaállítás maximumra)
config-modal-restock-mode-incremental = Fokozatos (mennyiség hozzáadása)
config-error-time-format-invalid = Az időpontnak ÓÓ:PP formátumúnak kell lennie (pl. 14:30).
config-error-increment-positive = A növekményes összegnek pozitív egész számnak kell lennie.

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Keresd meg a(z) { $configName } csatornát

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Válaszd ki a Quest bejelentési szerepet

# AddGMRoleSelect
config-select-placeholder-gm-roles = Válaszd ki a GM szerep(ek)et

# ConfigWaitListSelect
config-select-placeholder-wait-list = Válaszd ki a várólista méretét
config-select-option-disabled = 0 (Letiltva)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Válaszd ki a leltár módot
config-select-option-disabled-label = Letiltva
config-select-desc-disabled = A játékosok üres leltárral kezdenek.
config-select-option-selection = Kiválasztás
config-select-desc-selection = A játékosok szabadon válogatnak az Új karakter boltból.
config-select-option-purchase = Vásárlás
config-select-desc-purchase = A játékosok tárgyakat vásárolnak az Új karakter boltból adott valutával.
config-select-option-open = Szabad
config-select-desc-open = A játékosok kézzel adják meg saját leltárukat.
config-select-option-static = Statikus
config-select-desc-static = A játékosok előre meghatározott kezdő leltárt kapnak.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Válaszd ki a jogosult csatornákat

# RoleplayModeSelect
config-select-placeholder-rp-mode = Válassz módot
config-select-option-scheduled = Ütemezett
config-select-desc-scheduled = A jutalmak a megadott visszaállítási időszakon belül egyszer kerülnek kiosztásra.
config-select-option-accrued = Gyűjtött
config-select-desc-accrued = A jutalmak ismételten kiosztásra kerülnek a megadott aktivitási szintek alapján.

# RoleplayResetSelect
config-select-placeholder-reset-period = Válaszd ki a visszaállítási időszakot
config-select-option-hourly = Óránként
config-select-desc-hourly = Óránként visszaáll.
config-select-option-daily = Naponta
config-select-desc-daily = 24 óránként visszaáll.
config-select-option-weekly = Hetente
config-select-desc-weekly = 7 naponta visszaáll.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Válaszd ki a visszaállítás napját

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Válaszd ki a visszaállítás időpontját (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Válassz Forum csatornát

# ForumThreadSelect
config-select-placeholder-thread = Válassz témát
config-select-option-no-threads = Nem található aktív téma
config-select-desc-no-threads = Hozz létre új témát vagy ellenőrizd az archivált témákat
config-select-option-select-forum-first = Először válassz Forumot
config-select-desc-select-forum-first = Kérjük, válassz egy Forum csatornát fent
config-select-desc-thread-id = Téma ID: { $threadId }
config-error-select-valid-thread = Kérjük, válassz érvényes témát vagy hozz létre újat.
config-error-thread-not-found = A kiválasztott téma nem található. Lehet, hogy törölték vagy archiválták.

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = Szerver konfiguráció - Főmenü
config-menu-config-wizard = Konfigurációs varázsló
config-menu-desc-config-wizard = Ellenőrizd, hogy a szervered készen áll-e a ReQuest használatára egy gyors vizsgálattal.
config-menu-channels = Csatornák
config-menu-desc-channels = Kijelölt csatornák beállítása a ReQuest bejegyzésekhez.
config-menu-currency = Valuta
config-menu-desc-currency = Globális valutabeállítások.
config-menu-players = Játékosok
config-menu-desc-players = Globális játékosbeállítások, például tapasztalatpont-követés.
config-menu-quests = Questek
config-menu-desc-quests = Globális quest beállítások, például várólisták.
config-menu-rp-rewards = RP jutalmak
config-menu-desc-rp-rewards = Szerepjáték jutalmak beállítása.
config-menu-roles = Szerepek
config-menu-desc-roles = Konfigurációs lehetőségek pingelendő vagy kiváltságos szerepekhez.
config-menu-shops = Boltok
config-menu-desc-shops = Egyéni boltok beállítása.
config-menu-language = Nyelv
config-menu-desc-language = A szerver alapértelmezett nyelvének beállítása.

## Wizard View
config-title-wizard = {"**"}Szerver konfiguráció - Varázsló{"**"}
config-wizard-intro =
    {"**"}Üdvözlünk a ReQuest konfigurációs varázslóban!{"**"}

    Ez a varázsló segít abban, hogy a szervered megfelelően legyen konfigurálva a ReQuest funkcióinak használatához. A varázsló átvizsgálja a jelenlegi beállításaidat, és javaslatokat tesz a szükséges módosításokhoz.

    Kattints az alábbi „Vizsgálat indítása" gombra az érvényesítési folyamat elindításához. A vizsgálat befejezése után részletes jelentést kapsz a szervered konfigurációjáról és a javasolt módosításokról.

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}Bot globális jogosultságok{"**"}__
config-wizard-bot-permissions-desc = Ez a szakasz ellenőrzi, hogy a ReQuest rendelkezik-e a megfelelő jogosultságokkal a helyes működéshez.
config-wizard-bot-role = Bot szerep: { $roleMention }
config-wizard-status-warnings = {"**"}Állapot: ⚠️ FIGYELMEZTETÉSEK TALÁLHATÓK{"**"}
config-wizard-missing-perm = - ⚠️ Hiányzik: `{ $permissionName }`
config-wizard-ensure-permissions = Kérjük, győződj meg róla, hogy a bot legmagasabb szerepe rendelkezik ezekkel a jogosultságokkal globálisan.
config-wizard-status-ok = {"**"}Állapot: ✅ RENDBEN{"**"}
config-wizard-bot-permissions-ok = A bot rendelkezik az összes szükséges globális jogosultsággal.
config-wizard-status-scan-failed = {"**"}Állapot: ❌ VIZSGÁLAT SIKERTELEN{"**"}
config-wizard-scan-error = Váratlan hiba történt a bot jogosultságainak ellenőrzése során.
config-wizard-error-type = Hiba: { $errorType }
config-wizard-required-permissions = {"**"}A bot szerepéhez szükséges jogosultságok:{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = Csatornák megtekintése
config-wizard-perm-manage-roles = Szerepek kezelése
config-wizard-perm-send-messages = Üzenetek küldése
config-wizard-perm-attach-files = Fájlok csatolása
config-wizard-perm-add-reactions = Reakciók hozzáadása
config-wizard-perm-use-external-emoji = Külső emojik használata
config-wizard-perm-manage-messages = Üzenetek kezelése
config-wizard-perm-read-message-history = Üzenetelőzmények olvasása

# Wizard - Role Validation
config-wizard-role-header = __{"**"}Szerep konfigurációk{"**"}__
config-wizard-role-desc =
    Ez a szakasz a következőket ellenőrzi:

    - GM szerepek (kötelező) és Bejelentési szerep (opcionális) konfigurálva vannak-e.
    - Az alapértelmezett (@everyone) szerep rendelkezik-e a szükséges jogosultságokkal a bot funkcióinak eléréséhez.
    - Az alapértelmezett (@everyone) szerep nem rendelkezik-e veszélyes jogosultságokkal.
    - A GM és Bejelentési szerepeknél jogosultság-eszkalációk ellenőrzése az alapértelmezett szerephez képest.

    Az itt megjelenő figyelmeztetések kizárólag az alapértelmezett beállításon alapuló javaslatok. A szervered igényeitől függően indokolt lehet figyelmen kívül hagyni egyes javaslatokat.

config-wizard-default-role-label = {"**"}Alapértelmezett szerep:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Veszélyes jogosultságok találhatók:
config-wizard-default-role-ok = - ✅ @everyone: Rendben
config-wizard-missing-permission = - Hiányzó jogosultság: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}GM szerepek:{"**"}
config-wizard-no-gm-roles = - ⚠️ Nincsenek GM szerepek konfigurálva
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} A konfigurált szerep nem található/törölve lett a szerverről
config-wizard-role-ok = - ✅ { $roleMention }: Rendben
config-wizard-announcement-role-label = {"**"}Bejelentési szerep:{"**"}
config-wizard-no-announcement-role = - ℹ️ Nincs bejelentési szerep konfigurálva
config-wizard-announcement-role-not-found = - ⚠️ A konfigurált szerep nem található/törölve lett a szerverről
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Jogosultság-eszkalációk észlelve - { $escalations }
config-wizard-escalation-more = , és még { $count } további...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = Üzenetek küldése témákban
config-wizard-perm-use-application-commands = Alkalmazásparancsok használata

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = Csatornák kezelése
config-wizard-perm-manage-webhooks = Webhookok kezelése
config-wizard-perm-manage-server = Szerver kezelése
config-wizard-perm-manage-nicknames = Becenév kezelése
config-wizard-perm-kick-members = Tagok kirúgása
config-wizard-perm-ban-members = Tagok kitiltása
config-wizard-perm-timeout-members = Tagok időkorlátja
config-wizard-perm-mention-everyone = @everyone megemlítése
config-wizard-perm-manage-threads = Témák kezelése
config-wizard-perm-administrator = Adminisztrátor

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}Csatorna konfigurációk{"**"}__
config-wizard-channel-desc =
    Ez a szakasz a következőket ellenőrzi:

    - A konfigurált csatornák léteznek-e.
    - A bot rendelkezik-e jogosultsággal a konfigurált csatornák megtekintéséhez és üzenetküldéshez.
    - Az alapértelmezett (@everyone) szerep nem rendelkezik-e `Üzenetek küldése` jogosultsággal.

config-wizard-channel-no-config-required = - ⚠️ Nincs csatorna konfigurálva
config-wizard-channel-not-configured = - ℹ️ Nincs konfigurálva (opcionális)
config-wizard-channel-not-found = - ⚠️ A konfigurált csatorna nem található/törölve lett a szerverről
config-wizard-channel-ok = - ✅ Rendben
config-wizard-bot-cannot-view = - ⚠️ { $botMention } nem tudja megtekinteni ezt a csatornát.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } nem tud üzeneteket küldeni ebben a csatornában.
config-wizard-everyone-can-send = - ⚠️ @everyone küldhet üzeneteket ebben a csatornában.

# Wizard - Channel names
config-wizard-channel-quest-board = Quest hirdetőtábla
config-wizard-channel-player-board = Játékos hirdetőtábla
config-wizard-channel-quest-archive = Quest archívum
config-wizard-channel-gm-transaction-log = GM tranzakciós napló
config-wizard-channel-player-transaction-log = Játékos tranzakciós napló
config-wizard-channel-shop-log = Bolt napló
config-wizard-channel-approval-queue = Karakter jóváhagyási sor

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}Beállítások áttekintése{"**"}__
config-wizard-dashboard-desc = Ez a szakasz áttekintést nyújt a nem alapvető konfigurációkról gyors hivatkozásként.
config-wizard-quest-settings = {"**"}Quest beállítások{"**"}
config-wizard-quest-wait-list = - Quest várólista mérete: { $size }
config-wizard-quest-summary = - Quest összefoglaló: { $status }
config-wizard-gm-rewards-per-quest = {"**"}GM jutalmak (questenként){"**"}
config-wizard-player-settings = {"**"}Játékos beállítások{"**"}
config-wizard-player-experience = - Játékos tapasztalat: { $status }
config-wizard-currency-settings = {"**"}Valuta beállítások{"**"}
config-wizard-rp-rewards = {"**"}Szerepjáték jutalmak{"**"}
config-wizard-rp-status = - Állapot: { $status }
config-wizard-rp-mode = - Mód: { $mode }
config-wizard-rp-channels = - Figyelt csatornák: { $count }
config-wizard-shops = {"**"}Boltok{"**"}
config-wizard-shops-count = - Konfigurált boltok: { $count }
config-wizard-shops-more = - ...és még { $count } további
config-wizard-new-char-setup = {"**"}Új karakter beállítás{"**"}
config-wizard-inventory-type = - Leltár típusa: { $type }
config-wizard-new-char-shop-items = - Új karakter bolt tárgyai: { $count }
config-wizard-static-kits = - Statikus készletek: { $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ Nincsenek valuták konfigurálva
config-wizard-configured-currencies = {"**"}Konfigurált valuták:{"**"}
config-wizard-no-denominations = - Nincsenek címletek konfigurálva
config-wizard-gm-rewards-disabled = {"**"}Állapot:{"**"} Letiltva
config-wizard-gm-rewards-enabled = {"**"}Állapot:{"**"} Engedélyezve
config-wizard-gm-rewards-experience = - Tapasztalat: { $xp }
config-wizard-gm-rewards-items = - Tárgyak:

# Wizard - Szerver nyelve (1. oldal)
config-wizard-server-language-desc =
    Ez az a nyelv, amelyet a ReQuest fog használni minden nyilvános üzenethez, mint például a küldetés-bejegyzések, bolt-feltöltési üzenetek és tranzakciós naplók.
config-wizard-server-language = {"**"}Szerver nyelve:{"**"} { $language }
config-wizard-server-language-default = Alapértelmezett (angol)

# Wizard - Bolt feltöltési információ
config-wizard-shop-restock-not-scheduled = ℹ️ Feltöltés nincs ütemezve

# Wizard - Küldetés beállítások (5. oldal)
config-wizard-quest-header = __{"**"}Küldetés beállítások{"**"}__
config-wizard-quest-header-desc =
    Ez a rész áttekintést nyújt a küldetésekkel kapcsolatos konfigurációkról.
config-wizard-quest-role-mode = - Küldetés szerepkör mód: { $mode }
config-wizard-quest-roles-label = {"**"}GM küldetés szerepkörök{"**"}
config-wizard-quest-roles-count = - GM-ekhez rendelt szerepkörök: { $count }
config-wizard-quest-roles-all-ok = - ✅ Minden szerepkör rendben
config-wizard-quest-roles-assigned-to = {"    "}Hozzárendelve: { $gmNames }
config-wizard-quest-roles-not-found = - ⚠️ Szerepkör-azonosító { $roleId }: Nem található/Törölve a szerverről
config-wizard-quest-roles-no-assignments = - ℹ️ Nincsenek küldetés szerepkörök hozzárendelve

## Roles View
config-title-roles = {"**"}Szerver konfiguráció - Szerepek{"**"}
config-label-announcement-role = {"**"}Bejelentési szerep:{"**"} { $status }
config-desc-announcement-role = Ez a szerep kerül megemlítésre, amikor egy quest közzétételre kerül.
config-label-announcement-role-default = {"**"}Bejelentési szerep:{"**"} Nincs konfigurálva
config-label-gm-roles = {"**"}GM szerep(ek):{"**"} { $roles }
config-desc-gm-roles = Ezek a szerepek biztosítanak hozzáférést a GM parancsokhoz és funkciókhoz.
config-label-gm-roles-default = {"**"}GM szerep(ek):{"**"} Nincs konfigurálva
config-title-forbidden-roles = __{"**"}Tiltott szerepek{"**"}__
config-desc-forbidden-roles =
    A GM-ek által csapatszerepeikhez nem használható szerepnevek listájának beállítása.
    Alapértelmezés szerint az `everyone`, `administrator`, `gm` és `game master` nevek nem használhatók. Ez a beállítás
    kibővíti ezt a listát.

## GM Role Remove View
config-title-remove-gm-roles = {"**"}Szerver konfiguráció - GM szerep(ek) eltávolítása{"**"}
config-msg-no-gm-roles = Nincsenek GM szerepek konfigurálva.

## Channels View
config-title-channels = {"**"}Szerver konfiguráció - Csatornák{"**"}

config-label-quest-board = {"**"}Quest hirdetőtábla:{"**"} { $channel }
config-desc-quest-board = A csatorna, ahol az új/aktív questek kerülnek közzétételre.
config-label-quest-board-default = {"**"}Quest hirdetőtábla:{"**"} Nincs konfigurálva

config-label-player-board = {"**"}Játékos hirdetőtábla:{"**"} { $channel }
config-desc-player-board = Opcionális bejelentési/üzenet tábla a játékosok számára.
config-label-player-board-default = {"**"}Játékos hirdetőtábla:{"**"} Nincs konfigurálva

config-label-quest-archive = {"**"}Quest archívum:{"**"} { $channel }
config-desc-quest-archive = Opcionális csatorna, ahová a befejezett questek kerülnek összefoglaló információkkal.
config-label-quest-archive-default = {"**"}Quest archívum:{"**"} Nincs konfigurálva

config-label-gm-transaction-log = {"**"}GM tranzakciós napló:{"**"} { $channel }
config-desc-gm-transaction-log = Opcionális csatorna, ahol a GM tranzakciók (pl. Játékos módosítása parancsok) naplózásra kerülnek.
config-label-gm-transaction-log-default = {"**"}GM tranzakciós napló:{"**"} Nincs konfigurálva

config-label-player-transaction-log = {"**"}Játékos tranzakciós napló:{"**"} { $channel }
config-desc-player-transaction-log = Opcionális csatorna, ahol a játékos tranzakciók, például kereskedés és tárgyak felhasználása naplózásra kerülnek.
config-label-player-transaction-log-default = {"**"}Játékos tranzakciós napló:{"**"} Nincs konfigurálva

config-label-shop-log = {"**"}Bolt napló:{"**"} { $channel }
config-desc-shop-log = Opcionális csatorna, ahol a bolt tranzakciók naplózásra kerülnek.
config-label-shop-log-default = {"**"}Bolt napló:{"**"} Nincs konfigurálva

## Quests View
config-title-quests = {"**"}Szerver konfiguráció - Questek{"**"}

config-label-wait-list = {"**"}Quest várólista mérete:{"**"} { $size }
config-desc-wait-list = A várólista lehetővé teszi, hogy a megadott számú játékos sorban álljon egy teli questhez, ha egy játékos kiesik.
config-label-wait-list-disabled = {"**"}Quest várólista mérete:{"**"} Letiltva

config-label-quest-summary = {"**"}Quest összefoglaló:{"**"} { $status }
config-desc-quest-summary = Ez az opció lehetővé teszi a GM-ek számára, hogy rövid összefoglalót adjanak a questek lezárásakor.
config-label-quest-summary-disabled = {"**"}Quest összefoglaló:{"**"} Letiltva

config-label-gm-rewards = GM jutalmak
config-desc-gm-rewards = A GM-ek által questek befejezésekor kapott jutalmak beállítása.

## GM Rewards View
config-title-gm-rewards = {"**"}Szerver konfiguráció - GM jutalmak{"**"}
config-desc-gm-rewards-detail =
    {"**"}Jutalmak hozzáadása/módosítása{"**"}
    Megnyit egy beviteli ablakot a GM jutalmak hozzáadásához, módosításához vagy eltávolításához.

    > A konfigurált jutalmak questenként értendők. Minden alkalommal, amikor egy GM befejez egy questet, az aktív
    karaktere megkapja az alább beállított jutalmakat.
config-msg-no-rewards = Nincsenek jutalmak konfigurálva.
config-label-gm-experience = {"**"}Tapasztalat:{"**"} { $xp }
config-label-gm-items = {"**"}Tárgyak:{"**"}

## Players View
config-title-players = {"**"}Szerver konfiguráció - Játékosok{"**"}

config-label-player-experience = {"**"}Játékos tapasztalat:{"**"} { $status }
config-desc-player-experience = A tapasztalatpontok (vagy hasonló értékalapú karakterfejlődés) használatának engedélyezése/letiltása.
config-label-player-experience-disabled = {"**"}Játékos tapasztalat:{"**"} Letiltva

config-label-new-char-settings = {"**"}Új karakter beállítások{"**"}
config-desc-new-char-settings = Az új játékoskarakterekkel és kezdő leltáruk beállításával kapcsolatos beállítások konfigurálása.

config-label-player-board-purge = {"**"}Játékos hirdetőtábla törlése{"**"}
config-desc-player-board-purge = Bejegyzések törlése a játékos hirdetőtábláról (ha engedélyezve van).

## New Character Settings View
config-title-new-character = {"**"}Szerver konfiguráció - Új karakter beállítások{"**"}

config-label-inventory-type = {"**"}Új karakter leltár típusa:{"**"} { $type }
config-desc-inventory-type = Meghatározza, hogyan inicializálják leltárukat az újonnan regisztrált karakterek.
config-label-inventory-type-disabled = {"**"}Új karakter leltár típusa:{"**"} Letiltva

config-label-new-char-wealth = {"**"}Új karakter vagyon:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Új karakter vagyon:{"**"} Letiltva

config-label-approval-queue = {"**"}Jóváhagyási sor:{"**"} { $channel }
config-desc-approval-queue = Ha be van állítva, az új karaktereket egy GM-nek kell jóváhagynia ebben a Forum csatornában, mielőtt aktívvá válnának.
config-label-approval-queue-disabled = {"**"}Jóváhagyási sor:{"**"} Letiltva
config-label-approval-queue-not-configured = {"**"}Jóváhagyási sor:{"**"} Nincs konfigurálva

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = A játékosok üres leltárral kezdenek.
config-desc-inv-type-selection = A játékosok szabadon válogatnak az Új karakter boltból.
config-desc-inv-type-purchase = A játékosok tárgyakat vásárolnak az Új karakter boltból adott valutával.
config-desc-inv-type-open = A játékosok kézzel adják meg saját leltártárgyaikat.
config-desc-inv-type-static = A játékosok előre meghatározott kezdő leltárt kapnak.

## New Character Shop View
config-title-new-char-shop = {"**"}Szerver konfiguráció - Új karakter bolt{"**"}
config-label-inv-type-selection = {"**"}Leltár típusa:{"**"} Kiválasztás
config-desc-inv-type-selection-shop = A játékosok szabadon válogatnak az Új karakter boltból.
config-label-inv-type-purchase = {"**"}Leltár típusa:{"**"} Vásárlás
config-desc-inv-type-purchase-shop = A játékosok tárgyakat vásárolnak az Új karakter boltból adott valutával.
config-label-inv-type-other = {"**"}Leltár típusa:{"**"} { $type }
config-desc-inv-type-not-in-use = Az Új karakter bolt nincs használatban.
config-msg-define-shop-items = Határozd meg a bolt tárgyait.
config-msg-no-items = Nincsenek tárgyak konfigurálva.

## Static Kits View
config-title-static-kits = {"**"}Szerver konfiguráció - Statikus készletek{"**"}
config-desc-create-kit = Új készletdefiníció létrehozása.
config-msg-no-kits = Nincsenek készletek konfigurálva.
config-label-kit-more-items = ...és még { $count } tárgy
config-label-empty-kit = {"*"}Üres készlet{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}Készlet szerkesztése: { $kitName }{"**"}
config-msg-kit-empty = Ez a készlet üres. Használd a fenti gombokat valuta vagy tárgyak hozzáadásához.
config-label-kit-currency = {"**"}Valuta:{"**"} { $display }
config-label-kit-item = {"**"}Tárgy:{"**"} { $name }

## Currency View
config-title-currency = {"**"}Szerver konfiguráció - Valuta{"**"}
config-desc-create-currency = Új valuta létrehozása.
config-msg-no-currencies = Nincsenek valuták konfigurálva.
config-label-currency-display-type = Megjelenítés típusa: { $type } | Címletek: { $count }
config-label-currency-type-double = Tizedes
config-label-currency-type-integer = Egész szám

## Edit Currency View
config-title-manage-currency = {"**"}Valuta kezelése: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Valuta és címletek{"**"}__
    - A valutádnak adott neve az alapvaluta, amelynek értéke 1.
    {"```"}Példa: „arany" van konfigurálva valutaként.{"```"}
    - Címlet hozzáadásához meg kell adni egy nevet és egy értéket az alapvalutához viszonyítva.
    {"```"}Példa: Az arany két címletet kap: ezüst (értéke 0,1) és réz (értéke 0,01).{"```"}
    - Az alapvalutát vagy annak címleteit érintő tranzakciók automatikusan átváltásra kerülnek.
    {"```"}Példa: Egy játékosnak van 10 aranya, és elkölt 3 rezet. Az új egyenlege automatikusan
    9 arany, 9 ezüst és 7 rézként jelenik meg.{"```"}
    - Az egész számként megjelenített valuták minden címletet megmutatnak, míg a tizedesként megjelenítettek
    csak az alapvalutát mutatják.
    {"```"}Példa: A fenti játékos tizedes megjelenítéssel 9,97 aranyként jelenik meg.{"```"}
config-btn-toggle-display-current = Megjelenítés váltása (Jelenlegi: { $type })
config-msg-no-denominations = Nincsenek címletek konfigurálva.

## Shops View
config-title-shops = {"**"}Szerver konfiguráció - Boltok{"**"}
config-desc-add-shop-wizard =
    {"**"}Bolt hozzáadása (Varázsló){"**"}
    Új, üres bolt létrehozása űrlap segítségével.
config-desc-add-shop-json =
    {"**"}Bolt hozzáadása (JSON){"**"}
    Új bolt létrehozása teljes JSON definíció megadásával. (Haladó)
config-btn-example-json = Példa JSON
config-desc-example-json =
    {"**"}Példa JSON{"**"}
    Töltsön le egy példa JSON-fájlt, amely bemutatja a várt formátumot.
config-msg-example-json = Itt egy példa JSON-fájl, amely bemutatja a várt formátumot.
config-msg-no-shops = Nincsenek boltok konfigurálva.
config-label-shop-type-forum = (Forum)
config-label-shop-channel = Csatorna: <#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}Bolt hozzáadása - Helytípus kiválasztása{"**"}
config-label-text-channel = {"**"}Szöveges csatorna{"**"}
config-desc-text-channel = Bolt létrehozása egy szabványos szöveges csatornában.
config-label-forum-thread = {"**"}Forum téma{"**"}
config-desc-forum-thread = Bolt létrehozása egy Forum témában (új vagy meglévő).

## Forum Shop Setup View
config-title-forum-setup = {"**"}Bolt hozzáadása - Forum téma beállítás{"**"}
config-label-step1 = {"**"}1. lépés: Válassz Forum csatornát{"**"}
config-label-step2 = {"**"}2. lépés: Válassz téma opciót{"**"}
config-label-step3 = {"**"}3. lépés: Válassz meglévő témát{"**"}
config-desc-create-new-thread =
    {"**"}Új téma létrehozása{"**"}
    Megnyit egy űrlapot egy új téma létrehozásához és a bolt beállításához.
config-label-selected-thread = {"**"}Kiválasztott téma:{"**"} { $threadName }
config-desc-click-to-configure = Kattints a bolt beállításához ebben a témában.

## Manage Shop View
config-title-manage-shop = {"**"}Bolt kezelése: { $shopName }{"**"}
config-label-shop-type = {"**"}Típus:{"**"} { $type }
config-label-shop-type-text = Szöveges csatorna
config-label-shop-type-forum-thread = Forum téma
config-label-shopkeeper = {"**"}Boltos:{"**"} { $name }
config-label-shop-description = {"**"}Leírás:{"**"} { $description }
config-label-shop-channel-info = {"**"}Csatorna:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Bolt részleteinek és tárgyainak szerkesztése varázslóval.
config-desc-upload-json = Új JSON definíció feltöltése ehhez a bolthoz.
config-desc-download-json = A jelenlegi JSON definíció letöltése.
config-desc-remove-shop = A bolt végleges eltávolítása.

## Edit Shop View
config-title-editing-shop = {"**"}Bolt szerkesztése: { $shopName }{"**"}
config-label-shop-shopkeeper = Boltos: {"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}Készlet konfiguráció: { $shopName }{"**"}
config-label-current-utc = Jelenlegi UTC idő: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Feltöltési ütemezés:{"**"} { $schedule }
config-label-restock-hourly = a(z) :{ $minute } perckor
config-label-restock-daily = { $time } UTC-kor
config-label-restock-weekly = { $day } { $time } UTC-kor
config-label-restock-mode = {"**"}Mód:{"**"} { $mode }
config-label-restock-full = Teljes feltöltés
config-label-restock-incremental = Fokozatos (tételenkénti mennyiségek)
config-label-restock-disabled = {"**"}Feltöltési ütemezés:{"**"} Letiltva
config-label-item-stock-limits = {"**"}Tárgy készletkorlátok{"**"}
config-msg-no-items-in-shop = Nincsenek tárgyak ebben a boltban.
config-label-stock-with-available = Max: { $max } | Elérhető: { $available }
config-label-stock-increment = Feltöltés: +{ $increment }/ciklus
config-label-stock-reserved = Foglalt: { $reserved }
config-label-stock-not-initialized = Max: { $max } | Elérhető: (nincs inicializálva)
config-label-stock-unlimited = Készlet: Korlátlan

## Roleplay View
config-title-roleplay = {"**"}Szerver konfiguráció - Szerepjáték jutalmak{"**"}
config-label-rp-status = {"**"}Állapot:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Szerver idő:{"**"} `{ $time }`
config-label-rp-enabled = Engedélyezve
config-label-rp-disabled = Letiltva

config-desc-rp-mode-scheduled = {"```"}A jutalmak egyszer kerülnek kiosztásra, a szükséges küszöb elérésekor a beállított időszakon belül (óránként, naponta vagy hetente).{"```"}
config-desc-rp-mode-accrued = {"```"}A jutalmak ismétlődően kerülnek kiosztásra, valahányszor a megadott számú jogosult üzenet elküldésre kerül.{"```"}

config-label-rp-config-details = {"**"}Konfiguráció részletei:{"**"}
config-label-rp-mode = {"**"}Mód:{"**"} { $mode }
config-label-rp-min-length = {"**"}Minimális üzenethossz:{"**"} { $length } karakter
config-label-rp-cooldown = {"**"}Lehűlési idő:{"**"} { $seconds } másodperc
config-label-rp-frequency-once = {"**"}Gyakoriság:{"**"} { $period }-ként egyszer
config-label-rp-reset-time = {"**"}Visszaállítás időpontja:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Küszöb:{"**"} { $count } jogosult üzenet
config-label-rp-frequency-every = {"**"}Gyakoriság:{"**"} Minden { $count } jogosult üzenetenként

config-label-rp-channels = {"**"}Szerepjáték csatornák:{"**"}
config-msg-rp-no-channels = Nincs konfigurálva.
config-label-rp-channels-more = ...és még { $count } további.

config-label-rp-rewards = {"**"}Jutalmak:{"**"}
config-msg-rp-no-rewards = Nincs konfigurálva.
config-label-rp-experience = {"**"}Tapasztalat:{"**"} { $xp }
config-label-rp-items = {"**"}Tárgyak:{"**"}
config-label-rp-currency = {"**"}Valuta:{"**"}

## Language View
config-title-language = {"**"}Szerver konfiguráció - Nyelv{"**"}
config-server-language-help =
    Ez a beállítás lehetővé teszi a ReQuest {"**"}nyilvános{"**"} válaszainak és üzeneteinek alapértelmezett nyelvét a szerveren. A nyilvános válaszok közé tartoznak:
    - Quest és játékos hirdetőtábla bejegyzések
    - Quest összefoglaló és naplócsatorna üzenetek
    - Bolt feltöltés
    - Játékos tárgy felhasználás

    Ez a beállítás csak a bot által generált statikus szövegekre vonatkozik, és nem fordítja le a dinamikus tartalmat, például a felhasználó által megadott tárgyneveket vagy quest leírásokat.

    A személyes válaszok és menük nem érintettek ettől a beállítástól.
config-label-server-language = {"**"}Szerver nyelve:{"**"} { $language }
config-label-server-language-default = {"**"}Szerver nyelve:{"**"} Alapértelmezett (nincs felülírás)
config-select-placeholder-server-language = Válaszd ki a szerver nyelvét
config-select-option-default = Alapértelmezett (nincs felülírás)
config-select-desc-default = A felhasználók egyéni beállítása vagy a Discord nyelve alapján.

# Quest Roles
config-btn-quest-roles = Quest szerepek
config-btn-manage-gm-quest-roles = Kezelés

config-modal-title-confirm-quest-role-removal = Szerep eltávolításának megerősítése
config-modal-label-remove-quest-role = Eltávolítod a(z) { $roleName } szerepet { $gmName } GM-től?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Quest szerep mód kiválasztása
config-select-option-quest-role-disabled = Letiltva
config-select-desc-quest-role-disabled = Szerepek nem jönnek létre és nem kerülnek kiosztásra.
config-select-option-quest-role-temporary = Ideiglenes
config-select-desc-quest-role-temporary = A GM-ek questenként ideiglenes szerepeket hozhatnak létre.
config-select-option-quest-role-static = Statikus
config-select-desc-quest-role-static = A GM-ek előre kiosztott szerver szerepekből választanak.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Szerver szerep(ek) hozzárendelése ehhez a GM-hez

## Quest Roles View
config-title-quest-roles = {"**"}Szerver konfiguráció - Quest szerepek{"**"}

config-label-quest-role-mode-disabled = {"**"}Quest szerep mód:{"**"} Letiltva
    Szerepek nem jönnek létre és nem kerülnek kiosztásra a questek során.
config-label-quest-role-mode-temporary = {"**"}Quest szerep mód:{"**"} Ideiglenes
    A GM-ek opcionálisan ideiglenes szerepet hozhatnak létre quest létrehozásakor.
    A szerep törlődik, amikor a quest befejeződik vagy törlésre kerül.
config-label-quest-role-mode-static = {"**"}Quest szerep mód:{"**"} Statikus
    A GM-ek előre kiosztott szerver szerepekből választanak. A szerepek a
    csapattagokhoz kerülnek kiosztásra a questek során, de soha nem törlődnek.

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}Szerver konfiguráció - Statikus quest szerep kiosztások{"**"}
config-label-manage-assignments = Szerep kiosztások kezelése
config-desc-manage-assignments =
    Meglévő szerver szerepek hozzárendelése GM-ekhez questek során való használatra.
    A szerepeknek a ReQuest legmagasabb szerepe alatt kell lenniük a szerver hierarchiában.
config-msg-no-gm-members = Nem találhatók GM szereppel rendelkező tagok ezen a szerveren.
config-label-no-roles-assigned = Nincsenek kiosztott quest szerepek
config-label-more-roles = (+{ $count } további)

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}Quest szerepek kezelése — { $gmName }{"**"}
config-error-unmanageable-roles = A következő szerepek nem oszthatók ki, mert egy integráció kezeli őket, alapértelmezett szerepek, vagy a ReQuest legmagasabb szerepe felett vannak: { $roles }
config-error-quest-role-limit = Ez a GM elérte a maximum { $limit } kiosztott quest szerep korlátot.
config-label-quest-role-count = Kiosztott szerepek: { $count }/{ $limit }
