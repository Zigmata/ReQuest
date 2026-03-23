## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = Očisti
config-btn-remove-gm-roles = Ukloni GM uloge
config-btn-forbidden-roles = Zabranjene uloge

# Quests
config-btn-toggle-quest-summary = Uključi/isključi sažetak questa
config-btn-toggle-player-experience = Uključi/isključi iskustvo igrača
config-btn-toggle-display = Uključi/isključi prikaz
config-btn-purge-player-board = Očisti ploču igrača
config-btn-add-modify-rewards = Dodaj/Izmijeni nagrade
config-btn-configure-restock-schedule = Konfiguriraj raspored dopune

# Currency
config-btn-add-denomination = Dodaj apoen
config-btn-add-new-currency = Dodaj novu valutu
config-btn-remove-currency = Ukloni valutu

# Shops - creation
config-btn-add-shop-wizard = Dodaj trgovinu (čarobnjak)
config-btn-add-shop-json = Dodaj trgovinu (JSON)
config-btn-edit-shop-wizard = Uredi trgovinu (čarobnjak)
config-btn-edit-shop-json = Uredi trgovinu (JSON)
config-btn-remove-shop = Ukloni trgovinu
config-btn-add-item = Dodaj predmet
config-btn-edit-shop-details = Uredi detalje trgovine
config-btn-download-json = Preuzmi JSON
config-btn-done-editing = Završi uređivanje
config-btn-scan-server-configs = Skeniraj konfiguracije poslužitelja
config-btn-re-scan = Ponovno skeniraj

# New character shop
config-btn-upload-json = Učitaj JSON
config-btn-configure-new-character-wealth = Konfiguriraj bogatstvo novog lika
config-btn-configure-new-character-shop = Konfiguriraj trgovinu za nove likove
config-btn-clear-shop = Isprazni trgovinu
config-btn-configure-static-kits = Konfiguriraj statičke setove
config-btn-new-character-settings = Postavke novog lika
config-btn-disabled-no-currency = Onemogućeno (valuta nije konfigurirana)
config-btn-disabled-no-wealth = Onemogućeno (početno bogatstvo nije konfigurirano)

# Static kits
config-btn-create-new-kit = Stvori novi set
config-btn-delete-kit = Obriši set
config-btn-add-currency = Dodaj valutu

# Roleplay
config-btn-toggle-rp-rewards = Uključi/isključi RP nagrade
config-btn-clear-channels = Očisti kanale
config-btn-edit-settings = Uredi postavke
config-btn-configure-rewards = Konfiguriraj nagrade

# Stock
config-btn-stock-limits = Ograničenja zaliha
config-btn-set-limit = Postavi ograničenje
config-btn-edit-limit = Uredi ograničenje
config-btn-remove-limit = Ukloni ograničenje
config-btn-back-to-shop-editor = Natrag na uređivač trgovine

# Forum shop
config-btn-create-new-thread = Stvori novu temu
config-btn-use-existing-thread = Koristi postojeću temu

# Wizard
config-btn-quit = Zatvori
config-btn-configure-channels = Konfiguriraj kanale
config-btn-configure-roles = Konfiguriraj uloge
config-btn-configure-quests = Konfiguriraj questove
config-btn-configure-players = Konfiguriraj igrače
config-btn-configure-currency = Konfiguriraj valutu
config-btn-configure-rp-rewards = Konfiguriraj RP nagrade
config-btn-configure-shops = Konfiguriraj trgovine
config-btn-new-char-setup = Postav. novog lika

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = Potvrdi uklanjanje uloge
config-modal-title-confirm-removal = Potvrdi uklanjanje
config-modal-title-confirm-currency-removal = Potvrdi uklanjanje valute
config-modal-title-confirm-shop-removal = Potvrdi uklanjanje trgovine
config-modal-title-confirm-kit-deletion = Potvrdi brisanje seta
config-modal-title-confirm-remove-stock-limit = Potvrdi uklanjanje ograničenja zaliha
config-modal-title-clear-shop = Potvrdi pražnjenje trgovine

# Confirm modal prompt labels
config-modal-label-remove-role = Ukloniti { $roleName }?
config-modal-label-remove-denomination = Ukloniti { $denominationName }?
config-modal-label-remove-currency = Ukloniti { $currencyName }?
config-modal-label-shop-removal-warning = UPOZORENJE: Ova radnja je nepovratna!
config-modal-label-kit-deletion-warning = UPOZORENJE: Nepovratno!
config-modal-label-remove-stock-limit = Upišite CONFIRM za uklanjanje ograničenja zaliha
config-modal-label-clear-shop = Isprazniti sve predmete iz ove trgovine?

# Error messages from buttons
config-error-shop-data-not-found = Greška: Podaci te trgovine nisu pronađeni.
config-msg-shop-json-download = Ovdje je JSON definicija za {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Ovdje je JSON definicija za trgovinu za nove likove.
config-error-select-forum-first = Najprije odaberite forum kanal.
config-error-select-thread-first = Najprije odaberite temu.

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Dodaj novu valutu
config-modal-label-currency-name = Naziv valute
config-error-currency-already-exists = Valuta ili apoen s nazivom { $name } već postoji!

# RenameCurrencyModal
config-modal-title-rename-currency = Preimenuj valutu
config-modal-label-new-currency-name = Novi naziv valute
config-error-currency-name-exists = Valuta s nazivom "{ $name }" već postoji.
config-error-denomination-name-exists = Apoen s nazivom "{ $name }" već postoji.

# RenameDenominationModal
config-modal-title-rename-denomination = Preimenuj apoen
config-modal-label-new-denomination-name = Novi naziv apoena

# AddCurrencyDenominationModal
config-modal-title-add-denomination = Dodaj apoen za { $currencyName }
config-modal-label-denomination-name = Naziv
config-modal-placeholder-denomination-name = npr. Srebrnjak
config-modal-label-denomination-value = Vrijednost
config-modal-placeholder-denomination-value = npr. 0.1
config-error-denomination-matches-currency = Naziv novog apoena ne može odgovarati postojećoj valuti na ovom poslužitelju! Pronađena postojeća valuta s nazivom "{ $existingName }".
config-error-denomination-matches-denomination = Naziv novog apoena ne može odgovarati postojećem apoenu na ovom poslužitelju! Pronađen postojeći apoen s nazivom "{ $denominationName }" pod valutom "{ $currencyName }".
config-error-denomination-value-exists = Apoeni unutar jedne valute moraju imati jedinstvene vrijednosti! { $denominationName } već ima dodijeljenu tu vrijednost.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Nazivi zabranjenih uloga
config-modal-label-names = Nazivi
config-modal-placeholder-names = Unesite nazive odvojene zarezima
config-msg-forbidden-roles-updated = Zabranjene uloge ažurirane!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Očisti ploču igrača
config-modal-label-age = Starost
config-modal-placeholder-age = Unesite maksimalnu starost objave (u danima) za zadržavanje
config-msg-posts-purged = Objave starije od { $days } dana su obrisane!

# GMRewardsModal
config-modal-title-gm-rewards = Dodaj/Izmijeni GM nagrade
config-modal-label-experience = Iskustvo
config-modal-placeholder-enter-number = Unesite broj
config-modal-label-items = Predmeti
config-modal-placeholder-items =
    Naziv: Količina
    Naziv2: Količina
    itd.
config-error-experience-invalid = Iskustvo mora biti valjani cijeli broj (npr. 2000).
config-error-item-format-invalid = Neispravan format predmeta: "{ $item }". Svaki predmet mora biti u novom retku, u formatu "Naziv: Količina".

# ConfigShopDetailsModal
config-modal-title-shop-details = Dodaj/Uredi detalje trgovine
config-modal-label-shop-channel = Odaberite kanal
config-modal-placeholder-shop-channel = Odaberite kanal za ovu trgovinu
config-modal-label-shop-name = Naziv trgovine
config-modal-placeholder-shop-name = Unesite naziv trgovine
config-modal-label-shopkeeper-name = Ime trgovca
config-modal-placeholder-shopkeeper-name = Unesite ime trgovca
config-modal-label-shop-description = Opis trgovine
config-modal-placeholder-shop-description = Unesite opis trgovine
config-modal-label-shop-image-url = URL slike trgovine
config-modal-placeholder-shop-image-url = Unesite URL za sliku trgovine
config-error-no-channel-selected = Nije odabran kanal za trgovinu.
config-error-shop-already-in-channel = Trgovina je već registrirana u odabranom kanalu. Odaberite drugi kanal ili uredite postojeću trgovinu.

# build_shop_header_view
config-label-shopkeeper = {"**"}Trgovac:{"**"} { $name }
config-msg-use-shop-command = Koristite naredbu `/shop` za pregledavanje i kupnju predmeta.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Stvori Forum Thread trgovinu
config-modal-label-thread-name = Naziv teme
config-modal-placeholder-thread-name = Unesite naziv za temu trgovine
config-error-forum-not-found = Odabrani forum kanal nije pronađen.
config-error-shop-already-in-thread = Trgovina je već registrirana u ovoj temi. Ovo se ne bi trebalo dogoditi za novu temu.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Dodaj novu trgovinu putem JSON-a
config-modal-label-upload-json = Učitajte .json datoteku s podacima trgovine
config-error-no-json-uploaded = Nije učitana JSON datoteka za trgovinu.
config-error-file-must-be-json = Učitana datoteka mora biti JSON datoteka (.json).
config-error-invalid-json = Neispravan JSON format: { $error }
config-error-json-validation-failed = JSON ne odgovara shemi: { $error }

# ShopItemModal
config-modal-title-shop-item = Dodaj/Uredi predmet trgovine
config-modal-label-item-name = Naziv predmeta
config-modal-placeholder-item-name = Unesite naziv predmeta
config-modal-label-item-description = Opis predmeta
config-modal-placeholder-item-description = Unesite opis predmeta
config-modal-label-item-quantity = Količina predmeta
config-modal-placeholder-item-quantity = Unesite količinu prodanu po kupnji
config-modal-label-item-costs = Cijene predmeta
config-modal-placeholder-item-costs = Npr.: 10 gold + 5 silver\nILI: 50 rep\n(Koristite + za I, nove retke za ILI)
config-error-item-quantity-positive = Količina predmeta mora biti pozitivan cijeli broj.
config-error-cost-format-invalid = Neispravan format cijene u opciji: "{ $option }". Svaka cijena mora imati iznos i valutu odvojene razmakom, npr. "10 gold".
config-error-cost-amount-invalid = Neispravan iznos "{ $amount }" za valutu: "{ $currency }". Iznos mora biti pozitivan broj.
config-error-unknown-currency = Nepoznata valuta `{ $currency }`. Koristite valjanu valutu konfiguriranu za ovaj poslužitelj.
config-error-item-already-exists = Predmet s nazivom { $itemName } već postoji u ovoj trgovini.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Ažuriraj trgovinu putem JSON-a
config-modal-label-upload-new-json = Učitajte novu JSON definiciju
config-error-no-file-uploaded = Nije učitana nijedna datoteka.
config-error-file-must-be-json-ext = Datoteka mora biti `.json` datoteka.
config-error-json-validation-message = JSON validacija neuspješna: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Dodaj/Uredi opremu novog lika
config-modal-placeholder-item-quantity-selection = Unesite količinu primljenu po odabiru
config-modal-label-item-cost = Cijena predmeta
config-error-cost-format-short = Neispravan format cijene: '{ $component }'. Očekivano 'Iznos Valuta'.
config-error-amount-invalid-short = Neispravan iznos '{ $amount }' za valutu '{ $currency }'.
config-error-item-exists-new-char = Predmet s nazivom { $itemName } već postoji u trgovini za nove likove.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Učitaj trgovinu za nove likove (JSON)
config-error-no-json-uploaded-short = JSON datoteka nije učitana.
config-error-json-must-have-shopstock = JSON mora sadržavati polje 'shopStock'.
config-error-items-must-have-name-price = Svi predmeti moraju imati 'name' i 'price'.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Postavi bogatstvo novog lika
config-modal-label-amount = Iznos
config-modal-placeholder-amount = Unesite iznos ove valute.
config-modal-placeholder-currency-name = Unesite naziv valute definirane na ovom poslužitelju
config-error-no-currencies-configured = Nijedna valuta nije konfigurirana na ovom poslužitelju.
config-error-currency-not-found = Valuta ili apoen s nazivom { $name } nije pronađen. Koristite valjanu valutu.

# CreateStaticKitModal
config-modal-title-create-kit = Stvori novi statički set
config-modal-label-kit-name = Naziv seta
config-modal-placeholder-kit-name = npr. Ratnički početni set
config-modal-label-description = Opis
config-modal-placeholder-kit-description = Neobavezni opis ovog seta
config-error-kit-name-exists = Statički set s nazivom "{ $kitName }" već postoji. Odaberite drugi naziv.

# StaticKitItemModal
config-modal-title-kit-item = Dodaj/Uredi predmet seta
config-modal-placeholder-kit-item-quantity = Unesite količinu ovog predmeta za uključivanje u set

# StaticKitCurrencyModal
config-modal-title-kit-currency = Dodaj valutu seta
config-modal-placeholder-currency-eg = npr. Zlato
config-modal-placeholder-amount-eg = npr. 100
config-error-amount-must-be-number = Iznos mora biti broj.
config-error-no-currencies-on-server = Nijedna valuta nije konfigurirana na poslužitelju.
config-error-currency-not-found-short = Valuta "{ $currency }" nije pronađena.
config-error-denomination-not-found = Apoen "{ $denomination }" nije pronađen u konfiguraciji valute.

# RoleplaySettingsModal
config-modal-title-rp-settings = Postavke igranja uloga
config-modal-label-min-message-length = Minimalna duljina poruke (znakovi)
config-modal-placeholder-min-message-length = Broj znakova potrebnih da poruka bude prihvatljiva. 0 za bez ograničenja
config-modal-label-cooldown = Hlađenje (sekunde)
config-modal-placeholder-cooldown = Vrijeme čekanja, u sekundama, između brojanja poruka kao prihvatljivih za nagrade
config-modal-label-message-threshold = Prag poruka
config-modal-placeholder-message-threshold = Broj poruka potrebnih za pokretanje nagrade
config-modal-label-frequency = Učestalost (broj poruka)
config-modal-placeholder-frequency = Broj prihvatljivih poruka potrebnih za zarađivanje nagrada
config-error-min-length-invalid = Minimalna duljina poruke mora biti nenegativan cijeli broj.
config-error-cooldown-invalid = Hlađenje mora biti nenegativan cijeli broj.
config-error-threshold-invalid = Prag poruka mora biti pozitivan cijeli broj.
config-error-frequency-invalid = Učestalost mora biti pozitivan cijeli broj.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Konfiguriraj nagrade za igranje uloga
config-modal-label-items-name-quantity = Predmeti (Naziv: Količina)
config-modal-label-currency-name-amount = Valuta (Naziv: Iznos)
config-error-experience-non-negative = Iskustvo mora biti nenegativan cijeli broj.
config-error-item-quantity-positive-named = Količina predmeta za "{ $itemName }" mora biti pozitivan cijeli broj.
config-error-currency-amount-positive = Iznos valute za "{ $currencyName }" mora biti pozitivan broj.

# SetItemStockModal
config-modal-title-stock-limit = Ograničenje zaliha: { $itemName }
config-modal-label-max-stock = Maksimalne zalihe
config-modal-placeholder-max-stock = Unesite maks. zalihe (npr. 10)
config-modal-label-current-stock = Trenutne zalihe
config-modal-placeholder-current-stock = Unesite trenutne raspoložive zalihe
config-modal-label-restock-increment = Korak nadopune (po ciklusu)
config-modal-placeholder-restock-increment = Količina po ciklusu nadopune (zadano: 1)
config-error-max-stock-positive = Maksimalne zalihe moraju biti pozitivan cijeli broj.
config-error-current-stock-non-negative = Trenutne zalihe moraju biti nenegativan cijeli broj.
config-error-current-exceeds-max = Trenutne zalihe ne mogu premašiti maksimalne zalihe.
config-error-item-not-in-shop = Predmet "{ $itemName }" nije pronađen u trgovini.

# RestockScheduleModal
config-modal-title-restock-schedule = Konfiguriraj raspored dopune
config-modal-restock-schedule-label = Raspored
config-modal-restock-schedule-none = Ništa (Onemogućeno)
config-modal-restock-schedule-hourly = Svaki sat
config-modal-restock-schedule-daily = Dnevno
config-modal-restock-schedule-weekly = Tjedno
config-modal-label-time = Vrijeme (HH:MM u UTC)
config-modal-desc-current-time = Trenutno vrijeme: { $utcTime }
config-modal-placeholder-time = npr. 14:30 za 14:30 UTC
config-modal-restock-day-label = Dan u tjednu (samo tjedno)
config-modal-restock-mode-label = Način nadopune
config-modal-restock-mode-full = Potpuna (resetiraj na maksimum)
config-modal-restock-mode-incremental = Postupna (dodaj količinu)
config-error-time-format-invalid = Vrijeme mora biti u formatu HH:MM (npr. 14:30).
config-error-increment-positive = Količina povećanja mora biti pozitivan cijeli broj.

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Potražite svoj kanal za { $configName }

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Odaberite svoju ulogu za objave questova

# AddGMRoleSelect
config-select-placeholder-gm-roles = Odaberite svoju GM ulogu (uloge)

# ConfigWaitListSelect
config-select-placeholder-wait-list = Odaberite veličinu liste čekanja
config-select-option-disabled = 0 (Onemogućeno)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Odaberite način inventara
config-select-option-disabled-label = Onemogućeno
config-select-desc-disabled = Igrači počinju s praznim inventarom.
config-select-option-selection = Odabir
config-select-desc-selection = Igrači slobodno biraju predmete iz trgovine za nove likove.
config-select-option-purchase = Kupnja
config-select-desc-purchase = Igrači kupuju predmete iz trgovine za nove likove s danim iznosom valute.
config-select-option-open = Otvoreno
config-select-desc-open = Igrači ručno unose vlastiti inventar.
config-select-option-static = Statički
config-select-desc-static = Igrači dobivaju unaprijed definirani početni inventar.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Odaberite prihvatljive kanale

# RoleplayModeSelect
config-select-placeholder-rp-mode = Odaberite način
config-select-option-scheduled = Zakazano
config-select-desc-scheduled = Nagrade se dodjeljuju jednom unutar određenog perioda resetiranja.
config-select-option-accrued = Kumulativno
config-select-desc-accrued = Nagrade se ponavljajuće dodjeljuju na temelju određenih razina aktivnosti.

# RoleplayResetSelect
config-select-placeholder-reset-period = Odaberite period resetiranja
config-select-option-hourly = Svaki sat
config-select-desc-hourly = Resetira se svaki sat.
config-select-option-daily = Dnevno
config-select-desc-daily = Resetira se svakih 24 sata.
config-select-option-weekly = Tjedno
config-select-desc-weekly = Resetira se svakih 7 dana.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Odaberite dan resetiranja

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Odaberite vrijeme resetiranja (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Odaberite forum kanal

# ForumThreadSelect
config-select-placeholder-thread = Odaberite temu
config-select-option-no-threads = Nema aktivnih tema
config-select-desc-no-threads = Stvorite novu temu ili provjerite arhivirane teme
config-select-option-select-forum-first = Najprije odaberite forum
config-select-desc-select-forum-first = Molimo najprije odaberite forum kanal iznad
config-select-desc-thread-id = Thread ID: { $threadId }
config-error-select-valid-thread = Odaberite valjanu temu ili stvorite novu.
config-error-thread-not-found = Odabrana tema nije pronađena. Možda je obrisana ili arhivirana.

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = Konfiguracija poslužitelja - Glavni izbornik
config-menu-config-wizard = Čarobnjak za konfiguraciju
config-menu-desc-config-wizard = Provjerite je li vaš poslužitelj spreman za korištenje ReQuesta brzim skeniranjem.
config-menu-channels = Kanali
config-menu-desc-channels = Postavite označene kanale za ReQuest objave.
config-menu-currency = Valuta
config-menu-desc-currency = Globalne postavke valute.
config-menu-players = Igrači
config-menu-desc-players = Globalne postavke igrača, poput praćenja bodova iskustva.
config-menu-quests = Questovi
config-menu-desc-quests = Globalne postavke questova, poput lista čekanja.
config-menu-rp-rewards = RP nagrade
config-menu-desc-rp-rewards = Konfigurirajte nagrade za igranje uloga.
config-menu-roles = Uloge
config-menu-desc-roles = Opcije konfiguracije za uloge s mogućnošću pinganja ili povlaštene uloge.
config-menu-shops = Trgovine
config-menu-desc-shops = Konfigurirajte prilagođene trgovine.
config-menu-language = Jezik
config-menu-desc-language = Postavite zadani jezik za ovaj poslužitelj.

## Wizard View
config-title-wizard = {"**"}Konfiguracija poslužitelja - Čarobnjak{"**"}
config-wizard-intro =
    {"**"}Dobrodošli u čarobnjak za konfiguraciju ReQuesta!{"**"}

    Ovaj čarobnjak će vam pomoći da osigurate da je vaš poslužitelj ispravno konfiguriran za korištenje značajki ReQuesta.
    Skenirat će vaše trenutne postavke i pružiti preporuke za potrebne prilagodbe.

    Koristite gumb "Pokreni skeniranje" u nastavku za početak procesa validacije. Nakon završetka skeniranja,
    primit ćete detaljni izvještaj o konfiguraciji vašeg poslužitelja zajedno s preporučenim promjenama.

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}Globalne dozvole bota{"**"}__
config-wizard-bot-permissions-desc = Ovaj odjeljak provjerava ima li ReQuest ispravne dozvole za ispravno funkcioniranje.
config-wizard-bot-role = Uloga bota: { $roleMention }
config-wizard-status-warnings = {"**"}Status: ⚠️ PRONAĐENA UPOZORENJA{"**"}
config-wizard-missing-perm = - ⚠️ Nedostaje: `{ $permissionName }`
config-wizard-ensure-permissions = Molimo osigurajte da najviša uloga bota ima ove dozvole dodijeljene globalno.
config-wizard-status-ok = {"**"}Status: ✅ U REDU{"**"}
config-wizard-bot-permissions-ok = Bot ima sve potrebne globalne dozvole.
config-wizard-status-scan-failed = {"**"}Status: ❌ SKENIRANJE NEUSPJEŠNO{"**"}
config-wizard-scan-error = Došlo je do neočekivane greške prilikom provjere dozvola bota.
config-wizard-error-type = Greška: { $errorType }
config-wizard-required-permissions = {"**"}Potrebne dozvole za ulogu bota:{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = Pregledavanje kanala
config-wizard-perm-manage-roles = Upravljanje ulogama
config-wizard-perm-send-messages = Slanje poruka
config-wizard-perm-attach-files = Prilaganje datoteka
config-wizard-perm-add-reactions = Dodavanje reakcija
config-wizard-perm-use-external-emoji = Korištenje vanjskih emotikona
config-wizard-perm-manage-messages = Upravljanje porukama
config-wizard-perm-read-message-history = Čitanje povijesti poruka

# Wizard - Role Validation
config-wizard-role-header = __{"**"}Konfiguracije uloga{"**"}__
config-wizard-role-desc =
    Ovaj odjeljak provjerava sljedeće:

    - GM uloge (obavezno) i uloga za objave (neobavezno) su konfigurirane.
    - Zadana (@everyone) uloga ima potrebne dozvole za pristup korisnika značajkama bota.
    - Zadana (@everyone) uloga nema opasne dozvole.
    - GM i uloge za objave se provjeravaju za eskalacije dozvola izvan zadane uloge.

    Sva upozorenja ovdje su isključivo preporuke temeljene na zadanom postavljanju. Ovisno o potrebama vašeg poslužitelja, možda imate razlog zanemariti neke od ovih preporuka.

config-wizard-default-role-label = {"**"}Zadana uloga:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Pronađene opasne dozvole:
config-wizard-default-role-ok = - ✅ @everyone: U redu
config-wizard-missing-permission = - Nedostaje dozvola: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}GM uloge:{"**"}
config-wizard-no-gm-roles = - ⚠️ GM uloge nisu konfigurirane
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Konfigurirana uloga nije pronađena/obrisana s poslužitelja
config-wizard-role-ok = - ✅ { $roleMention }: U redu
config-wizard-announcement-role-label = {"**"}Uloga za objave:{"**"}
config-wizard-no-announcement-role = - ℹ️ Uloga za objave nije konfigurirana
config-wizard-announcement-role-not-found = - ⚠️ Konfigurirana uloga nije pronađena/obrisana s poslužitelja
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Otkrivene eskalacije dozvola - { $escalations }
config-wizard-escalation-more = , i još { $count }...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = Slanje poruka u temama
config-wizard-perm-use-application-commands = Korištenje naredbi aplikacije

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = Upravljanje kanalima
config-wizard-perm-manage-webhooks = Upravljanje webhookovima
config-wizard-perm-manage-server = Upravljanje poslužiteljem
config-wizard-perm-manage-nicknames = Upravljanje nadimcima
config-wizard-perm-kick-members = Izbacivanje članova
config-wizard-perm-ban-members = Zabrana pristupa članovima
config-wizard-perm-timeout-members = Istek vremena članova
config-wizard-perm-mention-everyone = Spominjanje @everyone
config-wizard-perm-manage-threads = Upravljanje temama
config-wizard-perm-administrator = Administrator

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}Konfiguracije kanala{"**"}__
config-wizard-channel-desc =
    Ovaj odjeljak provjerava sljedeće:

    - Konfigurirani kanali postoje.
    - Bot ima dozvolu za pregled i slanje poruka u konfiguriranim kanalima.
    - Zadana (@everyone) uloga nema dozvolu `Slanje poruka`.

config-wizard-channel-no-config-required = - ⚠️ Kanal nije konfiguriran
config-wizard-channel-not-configured = - ℹ️ Nije konfigurirano (neobavezno)
config-wizard-channel-not-found = - ⚠️ Konfigurirani kanal nije pronađen/obrisan s poslužitelja
config-wizard-channel-ok = - ✅ U redu
config-wizard-bot-cannot-view = - ⚠️ { $botMention } ne može pregledati ovaj kanal.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } ne može slati poruke u ovaj kanal.
config-wizard-everyone-can-send = - ⚠️ @everyone može slati poruke u ovaj kanal.

# Wizard - Channel names
config-wizard-channel-quest-board = Ploča questova
config-wizard-channel-player-board = Ploča igrača
config-wizard-channel-quest-archive = Arhiva questova
config-wizard-channel-gm-transaction-log = Dnevnik GM transakcija
config-wizard-channel-player-transaction-log = Dnevnik transakcija igrača
config-wizard-channel-shop-log = Dnevnik trgovine
config-wizard-channel-approval-queue = Red čekanja za odobrenje likova

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}Nadzorna ploča postavki{"**"}__
config-wizard-dashboard-desc = Ovaj odjeljak pruža pregled neobaveznih konfiguracija za brzi uvid.
config-wizard-quest-settings = {"**"}Postavke questova{"**"}
config-wizard-quest-wait-list = - Veličina liste čekanja za quest: { $size }
config-wizard-quest-summary = - Sažetak questa: { $status }
config-wizard-gm-rewards-per-quest = {"**"}GM nagrade (po questu){"**"}
config-wizard-player-settings = {"**"}Postavke igrača{"**"}
config-wizard-player-experience = - Iskustvo igrača: { $status }
config-wizard-currency-settings = {"**"}Postavke valute{"**"}
config-wizard-rp-rewards = {"**"}Nagrade za igranje uloga{"**"}
config-wizard-rp-status = - Status: { $status }
config-wizard-rp-mode = - Način: { $mode }
config-wizard-rp-channels = - Nadzirani kanali: { $count }
config-wizard-shops = {"**"}Trgovine{"**"}
config-wizard-shops-count = - Konfigurirane trgovine: { $count }
config-wizard-shops-more = - ...i još { $count }
config-wizard-new-char-setup = {"**"}Postavljanje novog lika{"**"}
config-wizard-inventory-type = - Vrsta inventara: { $type }
config-wizard-new-char-shop-items = - Predmeti trgovine za nove likove: { $count }
config-wizard-static-kits = - Statički setovi: { $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ Nijedna valuta nije konfigurirana
config-wizard-configured-currencies = {"**"}Konfigurirane valute:{"**"}
config-wizard-no-denominations = - Apoeni nisu konfigurirani
config-wizard-gm-rewards-disabled = {"**"}Status:{"**"} Onemogućeno
config-wizard-gm-rewards-enabled = {"**"}Status:{"**"} Omogućeno
config-wizard-gm-rewards-experience = - Iskustvo: { $xp }
config-wizard-gm-rewards-items = - Predmeti:
config-wizard-unnamed-shop = Neimenovana trgovina

## Roles View
config-title-roles = {"**"}Konfiguracija poslužitelja - Uloge{"**"}
config-label-announcement-role = {"**"}Uloga za objave:{"**"} { $status }
config-desc-announcement-role = Ova uloga se spominje kada se objavi quest.
config-label-announcement-role-default = {"**"}Uloga za objave:{"**"} Nije konfigurirano
config-label-gm-roles = {"**"}GM uloga(e):{"**"} { $roles }
config-desc-gm-roles = Ove uloge omogućuju pristup naredbama i značajkama Voditelja igre.
config-label-gm-roles-default = {"**"}GM uloga(e):{"**"} Nije konfigurirano
config-title-forbidden-roles = __{"**"}Zabranjene uloge{"**"}__
config-desc-forbidden-roles =
    Konfigurira popis naziva uloga koje Voditelji igre ne mogu koristiti za uloge družine.
    Po zadanom, `everyone`, `administrator`, `gm` i `game master` se ne mogu koristiti. Ova konfiguracija
    proširuje taj popis.

## GM Role Remove View
config-title-remove-gm-roles = {"**"}Konfiguracija poslužitelja - Ukloni GM ulogu(e){"**"}
config-msg-no-gm-roles = GM uloge nisu konfigurirane.

## Channels View
config-title-channels = {"**"}Konfiguracija poslužitelja - Kanali{"**"}

config-label-quest-board = {"**"}Ploča questova:{"**"} { $channel }
config-desc-quest-board = Kanal u kojem se objavljuju novi/aktivni questovi.
config-label-quest-board-default = {"**"}Ploča questova:{"**"} Nije konfigurirano

config-label-player-board = {"**"}Ploča igrača:{"**"} { $channel }
config-desc-player-board = Neobavezna ploča za objave/poruke igrača.
config-label-player-board-default = {"**"}Ploča igrača:{"**"} Nije konfigurirano

config-label-quest-archive = {"**"}Arhiva questova:{"**"} { $channel }
config-desc-quest-archive = Neobavezni kanal u koji se premještaju dovršeni questovi, sa sažetim informacijama.
config-label-quest-archive-default = {"**"}Arhiva questova:{"**"} Nije konfigurirano

config-label-gm-transaction-log = {"**"}Dnevnik GM transakcija:{"**"} { $channel }
config-desc-gm-transaction-log = Neobavezni kanal u koji se bilježe GM transakcije (tj. naredbe Modify Player).
config-label-gm-transaction-log-default = {"**"}Dnevnik GM transakcija:{"**"} Nije konfigurirano

config-label-player-transaction-log = {"**"}Dnevnik transakcija igrača:{"**"} { $channel }
config-desc-player-transaction-log = Neobavezni kanal u koji se bilježe transakcije igrača poput trgovanja i trošenja predmeta.
config-label-player-transaction-log-default = {"**"}Dnevnik transakcija igrača:{"**"} Nije konfigurirano

config-label-shop-log = {"**"}Dnevnik trgovine:{"**"} { $channel }
config-desc-shop-log = Neobavezni kanal u koji se bilježe transakcije trgovine.
config-label-shop-log-default = {"**"}Dnevnik trgovine:{"**"} Nije konfigurirano

## Quests View
config-title-quests = {"**"}Konfiguracija poslužitelja - Questovi{"**"}

config-label-wait-list = {"**"}Veličina liste čekanja za quest:{"**"} { $size }
config-desc-wait-list = Lista čekanja omogućuje zadanom broju igrača da se stave u red za quest koji je pun, u slučaju da igrač odustane.
config-label-wait-list-disabled = {"**"}Veličina liste čekanja za quest:{"**"} Onemogućeno

config-label-quest-summary = {"**"}Sažetak questa:{"**"} { $status }
config-desc-quest-summary = Ova opcija omogućuje GM-ovima da pruže kratki sažetak prilikom zatvaranja questova.
config-label-quest-summary-disabled = {"**"}Sažetak questa:{"**"} Onemogućeno

config-label-gm-rewards = GM nagrade
config-desc-gm-rewards = Konfigurirajte nagrade koje GM-ovi primaju po dovršetku questova.

## GM Rewards View
config-title-gm-rewards = {"**"}Konfiguracija poslužitelja - GM nagrade{"**"}
config-desc-gm-rewards-detail =
    {"**"}Dodaj/Izmijeni nagrade{"**"}
    Otvara modalni unos za dodavanje, izmjenu ili uklanjanje GM nagrada.

    > Konfigurirane nagrade su po questu. Svaki put kada Voditelj igre dovrši quest,
    primit će nagrade konfigurirane u nastavku na svog aktivnog lika.
config-msg-no-rewards = Nagrade nisu konfigurirane.
config-label-gm-experience = {"**"}Iskustvo:{"**"} { $xp }
config-label-gm-items = {"**"}Predmeti:{"**"}

## Players View
config-title-players = {"**"}Konfiguracija poslužitelja - Igrači{"**"}

config-label-player-experience = {"**"}Iskustvo igrača:{"**"} { $status }
config-desc-player-experience = Omogućuje/onemogućuje korištenje bodova iskustva (ili sličnog napredovanja lika temeljenog na vrijednostima).
config-label-player-experience-disabled = {"**"}Iskustvo igrača:{"**"} Onemogućeno

config-label-new-char-settings = {"**"}Postavke novog lika{"**"}
config-desc-new-char-settings = Konfigurirajte postavke vezane uz nove likove igrača i kako se postavljaju njihovi početni inventari.

config-label-player-board-purge = {"**"}Čišćenje ploče igrača{"**"}
config-desc-player-board-purge = Briše objave s ploče igrača (ako je omogućena).

## New Character Settings View
config-title-new-character = {"**"}Konfiguracija poslužitelja - Postavke novog lika{"**"}

config-label-inventory-type = {"**"}Vrsta inventara novog lika:{"**"} { $type }
config-desc-inventory-type = Određuje kako novoregistrirani likovi inicijaliziraju svoj inventar.
config-label-inventory-type-disabled = {"**"}Vrsta inventara novog lika:{"**"} Onemogućeno

config-label-new-char-wealth = {"**"}Bogatstvo novog lika:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Bogatstvo novog lika:{"**"} Onemogućeno

config-label-approval-queue = {"**"}Red čekanja za odobrenje:{"**"} { $channel }
config-desc-approval-queue = Ako je postavljeno, nove likove mora odobriti GM u ovom Forum kanalu prije nego postanu aktivni.
config-label-approval-queue-disabled = {"**"}Red čekanja za odobrenje:{"**"} Onemogućeno
config-label-approval-queue-not-configured = {"**"}Red čekanja za odobrenje:{"**"} Nije konfigurirano

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = Igrači počinju s praznim inventarom.
config-desc-inv-type-selection = Igrači slobodno biraju predmete iz trgovine za nove likove.
config-desc-inv-type-purchase = Igrači kupuju predmete iz trgovine za nove likove s danim iznosom valute.
config-desc-inv-type-open = Igrači ručno unose svoje predmete u inventar.
config-desc-inv-type-static = Igrači dobivaju unaprijed definirani početni inventar.

## New Character Shop View
config-title-new-char-shop = {"**"}Konfiguracija poslužitelja - Trgovina za nove likove{"**"}
config-label-inv-type-selection = {"**"}Vrsta inventara:{"**"} Odabir
config-desc-inv-type-selection-shop = Igrači slobodno biraju predmete iz trgovine za nove likove.
config-label-inv-type-purchase = {"**"}Vrsta inventara:{"**"} Kupnja
config-desc-inv-type-purchase-shop = Igrači kupuju predmete iz trgovine za nove likove s danim iznosom valute.
config-label-inv-type-other = {"**"}Vrsta inventara:{"**"} { $type }
config-desc-inv-type-not-in-use = Trgovina za nove likove nije u upotrebi.
config-msg-define-shop-items = Definirajte predmete trgovine.
config-msg-no-items = Predmeti nisu konfigurirani.

## Static Kits View
config-title-static-kits = {"**"}Konfiguracija poslužitelja - Statički setovi{"**"}
config-desc-create-kit = Stvorite novu definiciju seta.
config-msg-no-kits = Setovi nisu konfigurirani.
config-label-kit-more-items = ...i još { $count } predmeta
config-label-empty-kit = {"*"}Prazan set{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}Uređivanje seta: { $kitName }{"**"}
config-msg-kit-empty = Ovaj set je prazan. Koristite gumbe iznad za dodavanje valute ili predmeta.
config-label-kit-currency = {"**"}Valuta:{"**"} { $display }
config-label-kit-item = {"**"}Predmet:{"**"} { $name }

## Currency View
config-title-currency = {"**"}Konfiguracija poslužitelja - Valuta{"**"}
config-desc-create-currency = Stvorite novu valutu.
config-msg-no-currencies = Nijedna valuta nije konfigurirana.
config-label-currency-display-type = Vrsta prikaza: { $type } | Apoeni: { $count }
config-label-currency-type-double = Decimalni
config-label-currency-type-integer = Cijeli broj

## Edit Currency View
config-title-manage-currency = {"**"}Upravljanje valutom: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Valuta i apoeni{"**"}__
    - Zadani naziv vaše valute smatra se osnovnom valutom i ima vrijednost 1.
    {"```"}Primjer: "zlato" je konfigurirano kao valuta.{"```"}
    - Dodavanje apoena zahtijeva navođenje naziva i vrijednosti u odnosu na osnovnu valutu.
    {"```"}Primjer: Zlato ima dva apoena: srebro (vrijednost 0.1) i bakar (vrijednost 0.01).{"```"}
    - Sve transakcije koje uključuju osnovnu valutu ili njezine apoene automatski će ih pretvoriti.
    {"```"}Primjer: Igrač ima 10 zlata i troši 3 bakra. Njihov novi saldo će se automatski prikazati
    kao 9 zlata, 9 srebra i 7 bakra.{"```"}
    - Valute prikazane kao cijeli broj prikazuju svaki apoen, dok se valute prikazane kao decimalni broj
    prikazuju samo kao osnovna valuta.
    {"```"}Primjer: Gore navedeni igrač s omogućenim decimalnim prikazom prikazat će se kao 9.97 zlata.{"```"}
config-btn-toggle-display-current = Promijeni prikaz (Trenutno: { $type })
config-msg-no-denominations = Apoeni nisu konfigurirani.

## Shops View
config-title-shops = {"**"}Konfiguracija poslužitelja - Trgovine{"**"}
config-desc-add-shop-wizard =
    {"**"}Dodaj trgovinu (čarobnjak){"**"}
    Stvorite novu, praznu trgovinu iz obrasca.
config-desc-add-shop-json =
    {"**"}Dodaj trgovinu (JSON){"**"}
    Stvorite novu trgovinu pružajući potpunu JSON definiciju. (Napredno)
config-btn-example-json = Primjer JSON
config-desc-example-json =
    {"**"}Primjer JSON{"**"}
    Preuzmite primjer JSON datoteke koja pokazuje očekivani format.
config-msg-example-json = Evo primjera JSON datoteke koja pokazuje očekivani format.
config-msg-no-shops = Trgovine nisu konfigurirane.
config-label-shop-type-forum = (Forum)
config-label-shop-channel = Kanal: <#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}Dodaj trgovinu - Odaberite vrstu lokacije{"**"}
config-label-text-channel = {"**"}Tekstualni kanal{"**"}
config-desc-text-channel = Stvorite trgovinu u standardnom tekstualnom kanalu.
config-label-forum-thread = {"**"}Forum tema{"**"}
config-desc-forum-thread = Stvorite trgovinu u forum temi (novoj ili postojećoj).

## Forum Shop Setup View
config-title-forum-setup = {"**"}Dodaj trgovinu - Postavljanje forum teme{"**"}
config-label-step1 = {"**"}Korak 1: Odaberite forum kanal{"**"}
config-label-step2 = {"**"}Korak 2: Odaberite opciju teme{"**"}
config-label-step3 = {"**"}Korak 3: Odaberite postojeću temu{"**"}
config-desc-create-new-thread =
    {"**"}Stvori novu temu{"**"}
    Otvara obrazac za stvaranje nove teme i konfiguraciju trgovine.
config-label-selected-thread = {"**"}Odabrana tema:{"**"} { $threadName }
config-desc-click-to-configure = Kliknite za konfiguraciju trgovine u ovoj temi.

## Manage Shop View
config-title-manage-shop = {"**"}Upravljanje trgovinom: { $shopName }{"**"}
config-label-shop-type = {"**"}Vrsta:{"**"} { $type }
config-label-shop-type-text = Tekstualni kanal
config-label-shop-type-forum-thread = Forum tema
config-label-shopkeeper = {"**"}Trgovac:{"**"} { $name }
config-label-shop-description = {"**"}Opis:{"**"} { $description }
config-label-shop-channel-info = {"**"}Kanal:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Uredite detalje i predmete trgovine putem čarobnjaka.
config-desc-upload-json = Učitajte novu JSON definiciju za ovu trgovinu.
config-desc-download-json = Preuzmite trenutnu JSON definiciju.
config-desc-remove-shop = Trajno uklonite ovu trgovinu.

## Edit Shop View
config-title-editing-shop = {"**"}Uređivanje trgovine: { $shopName }{"**"}
config-label-shop-shopkeeper = Trgovac: {"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}Konfiguracija zaliha: { $shopName }{"**"}
config-label-current-utc = Trenutno UTC vrijeme: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Raspored dopune:{"**"} { $schedule }
config-label-restock-hourly = u minutu :{ $minute }
config-label-restock-daily = u { $time } UTC
config-label-restock-weekly = { $day } u { $time } UTC
config-label-restock-mode = {"**"}Način:{"**"} { $mode }
config-label-restock-full = Potpuna dopuna
config-label-restock-incremental = Postupna (količine po artiklu)
config-label-restock-disabled = {"**"}Raspored dopune:{"**"} Onemogućeno
config-label-item-stock-limits = {"**"}Ograničenja zaliha predmeta{"**"}
config-msg-no-items-in-shop = Nema predmeta u ovoj trgovini.
config-label-stock-with-available = Maks.: { $max } | Raspoloživo: { $available }
config-label-stock-increment = Nadopuna: +{ $increment }/ciklus
config-label-stock-reserved =  | Rezervirano: { $reserved }
config-label-stock-not-initialized = Maks.: { $max } | Raspoloživo: (nije inicijalizirano)
config-label-stock-unlimited = Zalihe: Neograničeno

## Roleplay View
config-title-roleplay = {"**"}Konfiguracija poslužitelja - Nagrade za igranje uloga{"**"}
config-label-rp-status = {"**"}Status:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Vrijeme poslužitelja:{"**"} `{ $time }`
config-label-rp-enabled = Omogućeno
config-label-rp-disabled = Onemogućeno

config-desc-rp-mode-scheduled = {"```"}Nagrade se dodjeljuju jednom, po slanju potrebnog praga prihvatljivih poruka unutar postavljenog vremenskog perioda (satno, dnevno ili tjedno).{"```"}
config-desc-rp-mode-accrued = {"```"}Nagrade se dodjeljuju na ponavljajućoj osnovi svaki put kada se pošalje zadani broj prihvatljivih poruka.{"```"}

config-label-rp-config-details = {"**"}Detalji konfiguracije:{"**"}
config-label-rp-mode = {"**"}Način:{"**"} { $mode }
config-label-rp-min-length = {"**"}Minimalna duljina poruke:{"**"} { $length } znakova
config-label-rp-cooldown = {"**"}Hlađenje:{"**"} { $seconds } sekundi
config-label-rp-frequency-once = {"**"}Učestalost:{"**"} Jednom po { $period }
config-label-rp-reset-time = {"**"}Vrijeme resetiranja:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Prag:{"**"} { $count } prihvatljivih poruka
config-label-rp-frequency-every = {"**"}Učestalost:{"**"} Svakih { $count } prihvatljivih poruka

config-label-rp-channels = {"**"}Kanali za igranje uloga:{"**"}
config-msg-rp-no-channels = Nije konfigurirano.
config-label-rp-channels-more = ...i još { $count }.

config-label-rp-rewards = {"**"}Nagrade:{"**"}
config-msg-rp-no-rewards = Nije konfigurirano.
config-label-rp-experience = {"**"}Iskustvo:{"**"} { $xp }
config-label-rp-items = {"**"}Predmeti:{"**"}
config-label-rp-currency = {"**"}Valuta:{"**"}

## Language View
config-title-language = {"**"}Konfiguracija poslužitelja - Jezik{"**"}
config-server-language-help =
    Ova postavka vam omogućuje da odredite zadani jezik za {"**"}javne{"**"} odgovore i poruke ReQuesta na ovom poslužitelju. Javni odgovori uključuju:
    - Objave na ploči questova i igrača
    - Sažetak questa i poruke kanala dnevnika
    - Dopunu trgovine
    - Trošenje predmeta od strane igrača

    Ova postavka utječe samo na statički tekst koji generira bot i ne prevodi dinamički sadržaj kao što su korisničkim unosom zadani nazivi predmeta ili opisi questova.

    Osobni odgovori i izbornici nisu pogođeni ovom postavkom.
config-label-server-language = {"**"}Jezik poslužitelja:{"**"} { $language }
config-label-server-language-default = {"**"}Jezik poslužitelja:{"**"} Zadano (bez premošćivanja)
config-select-placeholder-server-language = Odaberite jezik poslužitelja
config-select-option-default = Zadano (bez premošćivanja)
config-select-desc-default = Koristi postavke svakog korisnika ili Discord lokalizaciju.

# Quest Roles
config-btn-quest-roles = Uloge questa
config-btn-manage-gm-quest-roles = Upravljaj

config-modal-title-confirm-quest-role-removal = Potvrda uklanjanja uloge
config-modal-label-remove-quest-role = Ukloniti { $roleName } od { $gmName }?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Odaberite način uloga questa
config-select-option-quest-role-disabled = Onemogućeno
config-select-desc-quest-role-disabled = Uloge se ne stvaraju niti dodjeljuju.
config-select-option-quest-role-temporary = Privremeno
config-select-desc-quest-role-temporary = GM-ovi mogu stvoriti privremene uloge po questu.
config-select-option-quest-role-static = Statično
config-select-desc-quest-role-static = GM-ovi biraju iz unaprijed dodijeljenih uloga poslužitelja.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Dodijelite ulogu(e) poslužitelja ovom GM-u

## Quest Roles View
config-title-quest-roles = {"**"}Konfiguracija poslužitelja - Uloge questa{"**"}
config-label-quest-roles = Uloge questa
config-desc-quest-roles =
    Konfigurirajte kako se uloge družine upravljaju tijekom questova.

config-label-quest-role-mode-disabled = {"**"}Način uloga questa:{"**"} Onemogućeno
    Uloge se ne stvaraju niti dodjeljuju tijekom questova.
config-label-quest-role-mode-temporary = {"**"}Način uloga questa:{"**"} Privremeno
    GM-ovi mogu opcionalno stvoriti privremenu ulogu prilikom stvaranja questa.
    Uloga se briše kada se quest dovrši ili otkaže.
config-label-quest-role-mode-static = {"**"}Način uloga questa:{"**"} Statično
    GM-ovi biraju iz unaprijed dodijeljenih uloga poslužitelja. Uloge se dodjeljuju
    članovima družine tijekom questova, ali se nikada ne brišu.

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}Konfiguracija poslužitelja - Dodjele statičnih uloga questa{"**"}
config-label-manage-assignments = Upravljanje dodjelom uloga
config-desc-manage-assignments =
    Dodijelite postojeće uloge poslužitelja GM-ovima za korištenje tijekom questova.
    Uloge moraju biti niže od najviše uloge ReQuesta u hijerarhiji poslužitelja.
config-msg-no-gm-members = Na ovom poslužitelju nisu pronađeni članovi s GM ulogom.
config-label-no-roles-assigned = Nema dodijeljenih uloga questa

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}Upravljanje ulogama questa — { $gmName }{"**"}
config-error-unmanageable-roles = Sljedeće uloge se ne mogu dodijeliti jer ih upravlja integracija, zadana su uloga ili su iznad najviše uloge ReQuesta: { $roles }
config-error-quest-role-limit = Ovaj GM je dosegnuo maksimum od { $limit } dodijeljenih uloga questa.
config-label-quest-role-count = Dodijeljene uloge: { $count }/{ $limit }
