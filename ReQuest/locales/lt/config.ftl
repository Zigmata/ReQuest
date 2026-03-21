## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = Išvalyti
config-btn-remove-gm-roles = Pašalinti GM roles
config-btn-forbidden-roles = Draudžiamos rolės

# Quests
config-btn-toggle-quest-summary = Perjungti quest santrauką
config-btn-toggle-player-experience = Perjungti žaidėjo patirtį
config-btn-toggle-display = Perjungti rodymą
config-btn-purge-player-board = Išvalyti žaidėjų lentą
config-btn-add-modify-rewards = Pridėti/Keisti atlygius
config-btn-add-shop-wizard = Pridėti parduotuvę (vedlys)

# Currency
config-btn-add-denomination = Pridėti nominalą
config-btn-add-new-currency = Pridėti naują valiutą
config-btn-remove-currency = Pašalinti valiutą

# Shops - creation
config-btn-add-shop-json = Pridėti parduotuvę (JSON)
config-btn-edit-shop-wizard = Redaguoti parduotuvę (vedlys)
config-btn-edit-shop-json = Redaguoti parduotuvę (JSON)
config-btn-remove-shop = Pašalinti parduotuvę
config-btn-add-item = Pridėti daiktą
config-btn-edit-shop-details = Redaguoti parduotuvės informaciją
config-btn-download-json = Atsisiųsti JSON
config-btn-done-editing = Baigti redagavimą
config-btn-scan-server-configs = Nuskaityti serverio konfigūracijas
config-btn-re-scan = Nuskaityti iš naujo

# New character shop
config-btn-upload-json = Įkelti JSON
config-btn-configure-new-character-wealth = Konfigūruoti naujo personažo turtą
config-btn-configure-new-character-shop = Konfigūruoti naujo personažo parduotuvę
config-btn-clear-shop = Išvalyti parduotuvę
config-btn-configure-static-kits = Konfigūruoti statinius rinkinius
config-btn-new-character-settings = Naujo personažo nustatymai
config-btn-disabled-no-currency = Išjungta (valiuta nesukonfigūruota)
config-btn-disabled-no-wealth = Išjungta (pradinis turtas nesukonfigūruotas)

# Static kits
config-btn-create-new-kit = Sukurti naują rinkinį
config-btn-delete-kit = Ištrinti rinkinį
config-btn-add-currency = Pridėti valiutą

# Roleplay
config-btn-toggle-rp-rewards = Perjungti RP atlygius
config-btn-clear-channels = Išvalyti kanalus
config-btn-edit-settings = Redaguoti nustatymus
config-btn-configure-rewards = Konfigūruoti atlygius

# Stock
config-btn-stock-limits = Atsargų limitai
config-btn-set-limit = Nustatyti limitą
config-btn-edit-limit = Redaguoti limitą
config-btn-remove-limit = Pašalinti limitą
config-btn-configure-restock-schedule = Konfigūruoti papildymo tvarkaraštį
config-btn-back-to-shop-editor = Grįžti į parduotuvės redaktorių

# Forum shop
config-btn-create-new-thread = Sukurti naują giją
config-btn-use-existing-thread = Naudoti esamą giją

# Wizard
config-btn-quit = Išeiti
config-btn-configure-channels = Konfigūruoti kanalus
config-btn-configure-roles = Konfigūruoti roles
config-btn-configure-quests = Konfigūruoti quest'us
config-btn-configure-players = Konfigūruoti žaidėjus
config-btn-configure-currency = Konfigūruoti valiutą
config-btn-configure-rp-rewards = Konfigūruoti RP atlygius
config-btn-configure-shops = Konfigūruoti parduotuves
config-btn-new-char-setup = Naujo pers. sąranka

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = Patvirtinti rolės pašalinimą
config-modal-title-confirm-removal = Patvirtinti pašalinimą
config-modal-title-confirm-currency-removal = Patvirtinti valiutos pašalinimą
config-modal-title-confirm-shop-removal = Patvirtinti parduotuvės pašalinimą
config-modal-title-confirm-kit-deletion = Patvirtinti rinkinio ištrinimą
config-modal-title-confirm-remove-stock-limit = Patvirtinti atsargų limito pašalinimą
config-modal-title-clear-shop = Patvirtinti parduotuvės išvalymą

# Confirm modal prompt labels
config-modal-label-remove-role = Pašalinti { $roleName }?
config-modal-label-remove-denomination = Pašalinti { $denominationName }?
config-modal-label-remove-currency = Pašalinti { $currencyName }?
config-modal-label-shop-removal-warning = DĖMESIO: Šio veiksmo negalima atšaukti!
config-modal-label-kit-deletion-warning = DĖMESIO: Negrįžtamas veiksmas!
config-modal-label-remove-stock-limit = Įveskite CONFIRM, kad pašalintumėte atsargų limitą
config-modal-label-clear-shop = Išvalyti visus daiktus iš šios parduotuvės?
config-modal-placeholder-type-confirm = Įveskite CONFIRM

# Error messages from buttons
config-error-shop-data-not-found = Klaida: Nepavyko rasti tos parduotuvės duomenų.
config-msg-shop-json-download = Čia yra JSON apibrėžimas parduotuvei {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Čia yra JSON apibrėžimas naujo personažo parduotuvei.
config-error-select-forum-first = Pirmiausia pasirinkite forumo kanalą.
config-error-select-thread-first = Pirmiausia pasirinkite giją.

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Pridėti naują valiutą
config-modal-label-currency-name = Valiutos pavadinimas
config-error-currency-already-exists = Valiuta arba nominalas pavadinimu { $name } jau egzistuoja!

# RenameCurrencyModal
config-modal-title-rename-currency = Pervadinti valiutą
config-modal-label-new-currency-name = Naujas valiutos pavadinimas
config-error-currency-name-exists = Valiuta pavadinimu „{ $name }" jau egzistuoja.
config-error-denomination-name-exists = Nominalas pavadinimu „{ $name }" jau egzistuoja.

# RenameDenominationModal
config-modal-title-rename-denomination = Pervadinti nominalą
config-modal-label-new-denomination-name = Naujas nominalo pavadinimas

# AddCurrencyDenominationModal
config-modal-title-add-denomination = Pridėti { $currencyName } nominalą
config-modal-label-denomination-name = Pavadinimas
config-modal-placeholder-denomination-name = pvz., Sidabras
config-modal-label-denomination-value = Reikšmė
config-modal-placeholder-denomination-value = pvz., 0.1
config-error-denomination-matches-currency = Naujo nominalo pavadinimas negali sutapti su esama valiuta šiame serveryje! Rasta esama valiuta pavadinimu „{ $existingName }".
config-error-denomination-matches-denomination = Naujo nominalo pavadinimas negali sutapti su esamu nominalu šiame serveryje! Rastas esamas nominalas pavadinimu „{ $denominationName }" prie valiutos „{ $currencyName }".
config-error-denomination-value-exists = Nominalai vienoje valiutoje turi turėti unikalias reikšmes! { $denominationName } jau turi priskirtą šią reikšmę.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Draudžiamų rolių pavadinimai
config-modal-label-names = Pavadinimai
config-modal-placeholder-names = Įveskite pavadinimus, atskirtus kableliais
config-msg-forbidden-roles-updated = Draudžiamos rolės atnaujintos!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Išvalyti žaidėjų lentą
config-modal-label-age = Amžius
config-modal-placeholder-age = Įveskite maksimalų įrašų amžių (dienomis), kurį norite palikti
config-msg-posts-purged = Įrašai senesni nei { $days } dienų buvo išvalyti!

# GMRewardsModal
config-modal-title-gm-rewards = Pridėti/Keisti GM atlygius
config-modal-label-experience = Patirtis
config-modal-placeholder-enter-number = Įveskite skaičių
config-modal-label-items = Daiktai
config-modal-placeholder-items =
    Pavadinimas: Kiekis
    Pavadinimas2: Kiekis
    ir t.t.
config-error-experience-invalid = Patirtis turi būti galiojantis sveikasis skaičius (pvz., 2000).
config-error-item-format-invalid = Neteisingas daikto formatas: „{ $item }". Kiekvienas daiktas turi būti naujoje eilutėje formatu „Pavadinimas: Kiekis".

# ConfigShopDetailsModal
config-modal-title-shop-details = Pridėti/Redaguoti parduotuvės informaciją
config-modal-label-shop-channel = Pasirinkite kanalą
config-modal-placeholder-shop-channel = Pasirinkite kanalą šiai parduotuvei
config-modal-label-shop-name = Parduotuvės pavadinimas
config-modal-placeholder-shop-name = Įveskite parduotuvės pavadinimą
config-modal-label-shopkeeper-name = Pardavėjo vardas
config-modal-placeholder-shopkeeper-name = Įveskite pardavėjo vardą
config-modal-label-shop-description = Parduotuvės aprašymas
config-modal-placeholder-shop-description = Įveskite parduotuvės aprašymą
config-modal-label-shop-image-url = Parduotuvės paveikslo URL
config-modal-placeholder-shop-image-url = Įveskite parduotuvės paveikslo URL
config-error-no-channel-selected = Parduotuvei nepasirinktas kanalas.
config-error-shop-already-in-channel = Pasirinktame kanale jau yra užregistruota parduotuvė. Pasirinkite kitą kanalą arba redaguokite esamą parduotuvę.

# build_shop_header_view
config-label-shopkeeper = {"**"}Pardavėjas:{"**"} { $name }
config-msg-use-shop-command = Naudokite `/shop` komandą, kad naršytumėte ir pirktumėte daiktus.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Sukurti forumo gijos parduotuvę
config-modal-label-thread-name = Gijos pavadinimas
config-modal-placeholder-thread-name = Įveskite parduotuvės gijos pavadinimą
config-error-forum-not-found = Nepavyko rasti pasirinkto forumo kanalo.
config-error-shop-already-in-thread = Šioje gijoje jau yra užregistruota parduotuvė. Naujai gijai tai neturėtų nutikti.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Pridėti naują parduotuvę per JSON
config-modal-label-upload-json = Įkelkite .json failą su parduotuvės duomenimis
config-error-no-json-uploaded = Parduotuvei neįkeltas JSON failas.
config-error-file-must-be-json = Įkeltas failas turi būti JSON failas (.json).
config-error-invalid-json = Neteisingas JSON formatas: { $error }
config-error-json-validation-failed = JSON neatitinka schemos: { $error }

# ShopItemModal
config-modal-title-shop-item = Pridėti/Redaguoti parduotuvės daiktą
config-modal-label-item-name = Daikto pavadinimas
config-modal-placeholder-item-name = Įveskite daikto pavadinimą
config-modal-label-item-description = Daikto aprašymas
config-modal-placeholder-item-description = Įveskite daikto aprašymą
config-modal-label-item-quantity = Daikto kiekis
config-modal-placeholder-item-quantity = Įveskite parduodamą kiekį per pirkimą
config-modal-label-item-costs = Daikto kainos
config-modal-placeholder-item-costs = Pvz.: 10 gold + 5 silver\nARBA: 50 rep\n(Naudokite + IR, Naujas eilutes ARBA)
config-error-item-quantity-positive = Daikto kiekis turi būti teigiamas sveikasis skaičius.
config-error-cost-format-invalid = Neteisingas kainos formatas variante: „{ $option }". Kiekviena kaina turi turėti sumą ir valiutą, atskirtus tarpu, pvz., „10 gold".
config-error-cost-amount-invalid = Neteisinga suma „{ $amount }" valiutai: „{ $currency }". Suma turi būti teigiamas skaičius.
config-error-unknown-currency = Nežinoma valiuta `{ $currency }`. Naudokite galiojančią šiam serveriui sukonfigūruotą valiutą.
config-error-item-already-exists = Daiktas pavadinimu { $itemName } jau egzistuoja šioje parduotuvėje.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Atnaujinti parduotuvę per JSON
config-modal-label-upload-new-json = Įkelti naują JSON apibrėžimą
config-error-no-file-uploaded = Failas nebuvo įkeltas.
config-error-file-must-be-json-ext = Failas turi būti `.json` failas.
config-error-json-validation-message = JSON tikrinimas nepavyko: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Pridėti/Redaguoti naujo personažo įrangą
config-modal-placeholder-item-quantity-selection = Įveskite gaunamą kiekį per pasirinkimą
config-modal-label-item-cost = Daikto kaina
config-error-cost-format-short = Neteisingas kainos formatas: „{ $component }". Tikėtasi „Suma Valiuta".
config-error-amount-invalid-short = Neteisinga suma „{ $amount }" valiutai „{ $currency }".
config-error-item-exists-new-char = Daiktas pavadinimu { $itemName } jau egzistuoja naujo personažo parduotuvėje.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Įkelti naujo personažo parduotuvę (JSON)
config-error-no-json-uploaded-short = JSON failas neįkeltas.
config-error-json-must-have-shopstock = JSON turi turėti „shopStock" masyvą.
config-error-items-must-have-name-price = Visi daiktai turi turėti „name" ir „price".

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Nustatyti naujo personažo turtą
config-modal-label-amount = Suma
config-modal-placeholder-amount = Įveskite šios valiutos sumą.
config-modal-placeholder-currency-name = Įveskite šiame serveryje apibrėžtos valiutos pavadinimą
config-error-no-currencies-configured = Šiame serveryje nėra sukonfigūruotų valiutų.
config-error-currency-not-found = Valiuta arba nominalas pavadinimu { $name } nerastas. Naudokite galiojančią valiutą.

# CreateStaticKitModal
config-modal-title-create-kit = Sukurti naują statinį rinkinį
config-modal-label-kit-name = Rinkinio pavadinimas
config-modal-placeholder-kit-name = pvz., Kario pradinis rinkinys
config-modal-label-description = Aprašymas
config-modal-placeholder-kit-description = Neprivalomas šio rinkinio aprašymas
config-error-kit-name-exists = Statinis rinkinys pavadinimu „{ $kitName }" jau egzistuoja. Pasirinkite kitą pavadinimą.

# StaticKitItemModal
config-modal-title-kit-item = Pridėti/Redaguoti rinkinio daiktą
config-modal-placeholder-kit-item-quantity = Įveskite šio daikto kiekį, įtraukiamą į rinkinį

# StaticKitCurrencyModal
config-modal-title-kit-currency = Pridėti rinkinio valiutą
config-modal-placeholder-currency-eg = pvz., Auksas
config-modal-placeholder-amount-eg = pvz., 100
config-error-amount-must-be-number = Suma turi būti skaičius.
config-error-no-currencies-on-server = Serveryje nėra sukonfigūruotų valiutų.
config-error-currency-not-found-short = Valiuta „{ $currency }" nerasta.
config-error-denomination-not-found = Nominalas „{ $denomination }" nerastas valiutos konfigūracijoje.

# RoleplaySettingsModal
config-modal-title-rp-settings = Vaidmenų žaidimo nustatymai
config-modal-label-min-message-length = Minimalus žinutės ilgis (simboliais)
config-modal-placeholder-min-message-length = Simbolių skaičius, reikalingas, kad žinutė būtų tinkama. 0 be limito
config-modal-label-cooldown = Atvėsimo laikas (sekundėmis)
config-modal-placeholder-cooldown = Laukimo laikas sekundėmis tarp žinučių skaičiavimo kaip tinkamų atlygiams
config-modal-label-message-threshold = Žinučių slenkstis
config-modal-placeholder-message-threshold = Žinučių skaičius, reikalingas atlygiui gauti
config-modal-label-frequency = Dažnis (žinučių skaičius)
config-modal-placeholder-frequency = Tinkamų žinučių skaičius, reikalingas atlygiams gauti
config-error-min-length-invalid = Minimalus žinutės ilgis turi būti neneigiamas sveikasis skaičius.
config-error-cooldown-invalid = Atvėsimo laikas turi būti neneigiamas sveikasis skaičius.
config-error-threshold-invalid = Žinučių slenkstis turi būti teigiamas sveikasis skaičius.
config-error-frequency-invalid = Dažnis turi būti teigiamas sveikasis skaičius.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Konfigūruoti vaidmenų žaidimo atlygius
config-modal-label-items-name-quantity = Daiktai (Pavadinimas: Kiekis)
config-modal-label-currency-name-amount = Valiuta (Pavadinimas: Suma)
config-error-experience-non-negative = Patirtis turi būti neneigiamas sveikasis skaičius.
config-error-item-quantity-positive-named = Daikto „{ $itemName }" kiekis turi būti teigiamas sveikasis skaičius.
config-error-currency-amount-positive = Valiutos „{ $currencyName }" suma turi būti teigiamas skaičius.

# SetItemStockModal
config-modal-title-stock-limit = Atsargų limitas: { $itemName }
config-modal-label-max-stock = Didžiausios atsargos
config-modal-placeholder-max-stock = Įveskite maks. atsargas (pvz., 10)
config-modal-label-current-stock = Dabartinės atsargos
config-modal-placeholder-current-stock = Įveskite dabartines turimas atsargas
config-error-max-stock-positive = Didžiausios atsargos turi būti teigiamas sveikasis skaičius.
config-error-current-stock-non-negative = Dabartinės atsargos turi būti neneigiamas sveikasis skaičius.
config-error-current-exceeds-max = Dabartinės atsargos negali viršyti didžiausių atsargų.
config-error-item-not-in-shop = Daiktas „{ $itemName }" nerastas parduotuvėje.

# RestockScheduleModal
config-modal-title-restock-schedule = Konfigūruoti papildymo tvarkaraštį
config-modal-label-schedule = Tvarkaraštis (hourly/daily/weekly/none)
config-modal-placeholder-schedule = Įveskite: hourly, daily, weekly arba none
config-modal-label-time = Laikas (HH:MM UTC formatu)
config-modal-desc-current-time = Dabartinis laikas: { $utcTime }
config-modal-placeholder-time = pvz., 14:30 reiškia 14:30 UTC
config-modal-label-day-of-week = Savaitės diena (0=Pirm., 6=Sekm.) - Tik savaitiniam
config-modal-placeholder-day-of-week = Įveskite 0-6 (Pirmadienis=0, Sekmadienis=6)
config-modal-label-mode = Režimas (full/incremental)
config-modal-placeholder-mode = full = grąžinti iki maks., incremental = pridėti kiekį
config-modal-label-increment = Papildymo kiekis (incrementaliam režimui)
config-modal-placeholder-increment = Pridedamas kiekis per papildymo ciklą
config-error-schedule-invalid = Tvarkaraštis turi būti vienas iš: hourly, daily, weekly arba none.
config-error-time-format-invalid = Laikas turi būti HH:MM formatu (pvz., 14:30).
config-error-day-of-week-invalid = Savaitės diena turi būti 0-6 (Pirmadienis=0, Sekmadienis=6).
config-error-mode-invalid = Režimas turi būti „full" arba „incremental".
config-error-increment-positive = Papildymo kiekis turi būti teigiamas sveikasis skaičius.

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Ieškokite savo { $configName } kanalo

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Pasirinkite quest pranešimų rolę

# AddGMRoleSelect
config-select-placeholder-gm-roles = Pasirinkite savo GM rolę (-es)

# ConfigWaitListSelect
config-select-placeholder-wait-list = Pasirinkite laukimo sąrašo dydį
config-select-option-disabled = 0 (Išjungta)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Pasirinkite inventoriaus režimą
config-select-option-disabled-label = Išjungta
config-select-desc-disabled = Žaidėjai pradeda su tuščiais inventoriais.
config-select-option-selection = Pasirinkimas
config-select-desc-selection = Žaidėjai laisvai renkasi daiktus iš naujo personažo parduotuvės.
config-select-option-purchase = Pirkimas
config-select-desc-purchase = Žaidėjai perka daiktus iš naujo personažo parduotuvės su nurodyta valiutos suma.
config-select-option-open = Laisvas
config-select-desc-open = Žaidėjai patys įveda savo inventoriaus daiktus.
config-select-option-static = Statinis
config-select-desc-static = Žaidėjams suteikiamas iš anksto nustatytas pradinis inventorius.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Pasirinkite tinkamus kanalus

# RoleplayModeSelect
config-select-placeholder-rp-mode = Pasirinkite režimą
config-select-option-scheduled = Suplanuotas
config-select-desc-scheduled = Atlygiai skiriami vieną kartą per nurodytą atstatymo laikotarpį.
config-select-option-accrued = Kaupiamas
config-select-desc-accrued = Atlygiai skiriami pakartotinai pagal nurodytus aktyvumo lygius.

# RoleplayResetSelect
config-select-placeholder-reset-period = Pasirinkite atstatymo laikotarpį
config-select-option-hourly = Kas valandą
config-select-desc-hourly = Atstatoma kas valandą.
config-select-option-daily = Kasdien
config-select-desc-daily = Atstatoma kas 24 valandas.
config-select-option-weekly = Kas savaitę
config-select-desc-weekly = Atstatoma kas 7 dienas.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Pasirinkite atstatymo dieną

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Pasirinkite atstatymo laiką (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Pasirinkite forumo kanalą

# ForumThreadSelect
config-select-placeholder-thread = Pasirinkite giją
config-select-option-no-threads = Aktyvių gijų nerasta
config-select-desc-no-threads = Sukurkite naują giją arba patikrinkite archyvuotas gijas
config-select-option-select-forum-first = Pirmiausia pasirinkite forumą
config-select-desc-select-forum-first = Pirmiausia pasirinkite forumo kanalą aukščiau
config-select-desc-thread-id = Gijos ID: { $threadId }
config-error-select-valid-thread = Pasirinkite galiojančią giją arba sukurkite naują.
config-error-thread-not-found = Nepavyko rasti pasirinktos gijos. Ji galėjo būti ištrinta arba archyvuota.

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = Serverio konfigūracija - Pagrindinis meniu
config-menu-config-wizard = Konfigūracijos vedlys
config-menu-desc-config-wizard = Patikrinkite, ar jūsų serveris paruoštas naudoti ReQuest, atlikdami greitą nuskaitymą.
config-menu-channels = Kanalai
config-menu-desc-channels = Nustatyti paskirtus kanalus ReQuest įrašams.
config-menu-currency = Valiuta
config-menu-desc-currency = Globalūs valiutos nustatymai.
config-menu-players = Žaidėjai
config-menu-desc-players = Globalūs žaidėjų nustatymai, tokie kaip patirties taškų sekimas.
config-menu-quests = Quest'ai
config-menu-desc-quests = Globalūs quest nustatymai, tokie kaip laukimo sąrašai.
config-menu-rp-rewards = RP atlygiai
config-menu-desc-rp-rewards = Konfigūruoti vaidmenų žaidimo atlygius.
config-menu-roles = Rolės
config-menu-desc-roles = Rolių, kurias galima paminėti arba kurioms suteiktos privilegijos, konfigūravimas.
config-menu-shops = Parduotuvės
config-menu-desc-shops = Konfigūruoti pasirinktines parduotuves.
config-menu-language = Kalba
config-menu-desc-language = Nustatyti numatytąją šio serverio kalbą.

## Wizard View
config-title-wizard = {"**"}Serverio konfigūracija - Vedlys{"**"}
config-wizard-intro =
    {"**"}Sveiki atvykę į ReQuest konfigūracijos vedlį!{"**"}

    Šis vedlys padės užtikrinti, kad jūsų serveris tinkamai sukonfigūruotas naudoti ReQuest funkcijas.
    Jis nuskaitys dabartinius nustatymus ir pateiks rekomendacijas dėl reikalingų pakeitimų.

    Naudokite žemiau esantį mygtuką „Pradėti nuskaitymą", kad pradėtumėte tikrinimo procesą. Kai nuskaitymas bus baigtas,
    gausite išsamią serverio konfigūracijos ataskaitą kartu su rekomenduojamais pakeitimais.

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}Boto globalūs leidimai{"**"}__
config-wizard-bot-permissions-desc = Ši sekcija patikrina, ar ReQuest turi teisingus leidimus tinkamai veikti.
config-wizard-bot-role = Boto rolė: { $roleMention }
config-wizard-status-warnings = {"**"}Būsena: ⚠️ RASTI ĮSPĖJIMAI{"**"}
config-wizard-missing-perm = - ⚠️ Trūksta: `{ $permissionName }`
config-wizard-ensure-permissions = Užtikrinkite, kad aukščiausia boto rolė turėtų šiuos leidimus suteiktus globaliai.
config-wizard-status-ok = {"**"}Būsena: ✅ GERAI{"**"}
config-wizard-bot-permissions-ok = Botas turi visus reikiamus globalius leidimus.
config-wizard-status-scan-failed = {"**"}Būsena: ❌ NUSKAITYMAS NEPAVYKO{"**"}
config-wizard-scan-error = Tikrinant boto leidimus įvyko netikėta klaida.
config-wizard-error-type = Klaida: { $errorType }
config-wizard-required-permissions = {"**"}Reikalingi boto rolės leidimai:{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = Peržiūrėti kanalus
config-wizard-perm-manage-roles = Valdyti roles
config-wizard-perm-send-messages = Siųsti žinutes
config-wizard-perm-attach-files = Pridėti failus
config-wizard-perm-add-reactions = Pridėti reakcijas
config-wizard-perm-use-external-emoji = Naudoti išorinius jaustukus
config-wizard-perm-manage-messages = Valdyti žinutes
config-wizard-perm-read-message-history = Skaityti žinučių istoriją

# Wizard - Role Validation
config-wizard-role-header = __{"**"}Rolių konfigūracijos{"**"}__
config-wizard-role-desc =
    Ši sekcija patikrina:

    - Ar sukonfigūruotos GM rolės (privaloma) ir pranešimų rolė (neprivaloma).
    - Ar numatytoji (@everyone) rolė turi reikalingus leidimus, kad vartotojai galėtų naudotis boto funkcijomis.
    - Ar numatytoji (@everyone) rolė neturi pavojingų leidimų.
    - Ar GM ir pranešimų rolės neturi leidimų eskalacijos, viršijančios numatytąją rolę.

    Visi čia esantys įspėjimai yra tik rekomendacijos, pagrįstos numatytąja sąranka. Priklausomai nuo jūsų serverio poreikių, galite turėti priežasčių nepaisyti kai kurių rekomendacijų.

config-wizard-default-role-label = {"**"}Numatytoji rolė:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Rasti pavojingi leidimai:
config-wizard-default-role-ok = - ✅ @everyone: Gerai
config-wizard-missing-permission = - Trūksta leidimo: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}GM rolės:{"**"}
config-wizard-no-gm-roles = - ⚠️ GM rolės nesukonfigūruotos
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Sukonfigūruota rolė nerasta / ištrinta iš serverio
config-wizard-role-ok = - ✅ { $roleMention }: Gerai
config-wizard-announcement-role-label = {"**"}Pranešimų rolė:{"**"}
config-wizard-no-announcement-role = - ℹ️ Pranešimų rolė nesukonfigūruota
config-wizard-announcement-role-not-found = - ⚠️ Sukonfigūruota rolė nerasta / ištrinta iš serverio
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Aptiktos leidimų eskalacijos - { $escalations }
config-wizard-escalation-more = , ir dar { $count }...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = Siųsti žinutes gijose
config-wizard-perm-use-application-commands = Naudoti programų komandas

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = Valdyti kanalus
config-wizard-perm-manage-webhooks = Valdyti webhook'us
config-wizard-perm-manage-server = Valdyti serverį
config-wizard-perm-manage-nicknames = Valdyti slapyvardžius
config-wizard-perm-kick-members = Išmesti narius
config-wizard-perm-ban-members = Blokuoti narius
config-wizard-perm-timeout-members = Nutildyti narius
config-wizard-perm-mention-everyone = Paminėti @everyone
config-wizard-perm-manage-threads = Valdyti gijas
config-wizard-perm-administrator = Administratorius

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}Kanalų konfigūracijos{"**"}__
config-wizard-channel-desc =
    Ši sekcija patikrina:

    - Ar sukonfigūruoti kanalai egzistuoja.
    - Ar botas turi leidimą peržiūrėti ir siųsti žinutes sukonfigūruotuose kanaluose.
    - Ar numatytoji (@everyone) rolė neturi leidimo „Siųsti žinutes".

config-wizard-channel-no-config-required = - ⚠️ Kanalas nesukonfigūruotas
config-wizard-channel-not-configured = - ℹ️ Nesukonfigūruotas (neprivalomas)
config-wizard-channel-not-found = - ⚠️ Sukonfigūruotas kanalas nerastas / ištrintas iš serverio
config-wizard-channel-ok = - ✅ Gerai
config-wizard-bot-cannot-view = - ⚠️ { $botMention } negali peržiūrėti šio kanalo.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } negali siųsti žinučių šiame kanale.
config-wizard-everyone-can-send = - ⚠️ @everyone gali siųsti žinutes šiame kanale.

# Wizard - Channel names
config-wizard-channel-quest-board = Quest lenta
config-wizard-channel-player-board = Žaidėjų lenta
config-wizard-channel-quest-archive = Quest archyvas
config-wizard-channel-gm-transaction-log = GM sandorių žurnalas
config-wizard-channel-player-transaction-log = Žaidėjų sandorių žurnalas
config-wizard-channel-shop-log = Parduotuvės žurnalas
config-wizard-channel-approval-queue = Personažų patvirtinimo eilė

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}Nustatymų apžvalga{"**"}__
config-wizard-dashboard-desc = Ši sekcija pateikia neesminių konfigūracijų apžvalgą greitam peržiūrėjimui.
config-wizard-quest-settings = {"**"}Quest nustatymai{"**"}
config-wizard-quest-wait-list = - Quest laukimo sąrašo dydis: { $size }
config-wizard-quest-summary = - Quest santrauka: { $status }
config-wizard-gm-rewards-per-quest = {"**"}GM atlygiai (per quest'ą){"**"}
config-wizard-player-settings = {"**"}Žaidėjų nustatymai{"**"}
config-wizard-player-experience = - Žaidėjo patirtis: { $status }
config-wizard-currency-settings = {"**"}Valiutos nustatymai{"**"}
config-wizard-rp-rewards = {"**"}Vaidmenų žaidimo atlygiai{"**"}
config-wizard-rp-status = - Būsena: { $status }
config-wizard-rp-mode = - Režimas: { $mode }
config-wizard-rp-channels = - Stebimi kanalai: { $count }
config-wizard-shops = {"**"}Parduotuvės{"**"}
config-wizard-shops-count = - Sukonfigūruotos parduotuvės: { $count }
config-wizard-shops-more = - ...ir dar { $count }
config-wizard-new-char-setup = {"**"}Naujo personažo sąranka{"**"}
config-wizard-inventory-type = - Inventoriaus tipas: { $type }
config-wizard-new-char-shop-items = - Naujo personažo parduotuvės daiktai: { $count }
config-wizard-static-kits = - Statiniai rinkiniai: { $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ Valiutos nesukonfigūruotos
config-wizard-configured-currencies = {"**"}Sukonfigūruotos valiutos:{"**"}
config-wizard-no-denominations = - Nominalai nesukonfigūruoti
config-wizard-gm-rewards-disabled = {"**"}Būsena:{"**"} Išjungta
config-wizard-gm-rewards-enabled = {"**"}Būsena:{"**"} Įjungta
config-wizard-gm-rewards-experience = - Patirtis: { $xp }
config-wizard-gm-rewards-items = - Daiktai:
config-wizard-unnamed-shop = Bevardė parduotuvė

## Roles View
config-title-roles = {"**"}Serverio konfigūracija - Rolės{"**"}
config-label-announcement-role = {"**"}Pranešimų rolė:{"**"} { $status }
config-desc-announcement-role = Ši rolė paminima, kai skelbiamas quest.
config-label-announcement-role-default = {"**"}Pranešimų rolė:{"**"} Nesukonfigūruota
config-label-gm-roles = {"**"}GM rolė (-ės):{"**"} { $roles }
config-desc-gm-roles = Šios rolės suteiks prieigą prie GM komandų ir funkcijų.
config-label-gm-roles-default = {"**"}GM rolė (-ės):{"**"} Nesukonfigūruota
config-title-forbidden-roles = __{"**"}Draudžiamos rolės{"**"}__
config-desc-forbidden-roles =
    Konfigūruoja rolių pavadinimų sąrašą, kurių GM negali naudoti savo grupių rolėms.
    Pagal numatytuosius nustatymus, `everyone`, `administrator`, `gm` ir `game master` negali būti naudojami. Ši konfigūracija
    išplečia tą sąrašą.

## GM Role Remove View
config-title-remove-gm-roles = {"**"}Serverio konfigūracija - Pašalinti GM rolę (-es){"**"}
config-msg-no-gm-roles = GM rolės nesukonfigūruotos.

## Channels View
config-title-channels = {"**"}Serverio konfigūracija - Kanalai{"**"}

config-label-quest-board = {"**"}Quest lenta:{"**"} { $channel }
config-desc-quest-board = Kanalas, kuriame bus skelbiami nauji/aktyvūs quest'ai.
config-label-quest-board-default = {"**"}Quest lenta:{"**"} Nesukonfigūruota

config-label-player-board = {"**"}Žaidėjų lenta:{"**"} { $channel }
config-desc-player-board = Neprivalomas pranešimų/žinučių kanalas žaidėjams.
config-label-player-board-default = {"**"}Žaidėjų lenta:{"**"} Nesukonfigūruota

config-label-quest-archive = {"**"}Quest archyvas:{"**"} { $channel }
config-desc-quest-archive = Neprivalomas kanalas, į kurį bus perkelti užbaigti quest'ai su santraukos informacija.
config-label-quest-archive-default = {"**"}Quest archyvas:{"**"} Nesukonfigūruota

config-label-gm-transaction-log = {"**"}GM sandorių žurnalas:{"**"} { $channel }
config-desc-gm-transaction-log = Neprivalomas kanalas, kuriame registruojami GM sandoriai (pvz., žaidėjo modifikavimo komandos).
config-label-gm-transaction-log-default = {"**"}GM sandorių žurnalas:{"**"} Nesukonfigūruota

config-label-player-transaction-log = {"**"}Žaidėjų sandorių žurnalas:{"**"} { $channel }
config-desc-player-transaction-log = Neprivalomas kanalas, kuriame registruojami žaidėjų sandoriai, tokie kaip mainai ir daiktų naudojimas.
config-label-player-transaction-log-default = {"**"}Žaidėjų sandorių žurnalas:{"**"} Nesukonfigūruota

config-label-shop-log = {"**"}Parduotuvės žurnalas:{"**"} { $channel }
config-desc-shop-log = Neprivalomas kanalas, kuriame registruojami parduotuvės sandoriai.
config-label-shop-log-default = {"**"}Parduotuvės žurnalas:{"**"} Nesukonfigūruota

## Quests View
config-title-quests = {"**"}Serverio konfigūracija - Quest'ai{"**"}

config-label-wait-list = {"**"}Quest laukimo sąrašo dydis:{"**"} { $size }
config-desc-wait-list = Laukimo sąrašas leidžia nurodytam žaidėjų skaičiui laukti eilėje prie pilno quest'o, jei žaidėjas pasitrauks.
config-label-wait-list-disabled = {"**"}Quest laukimo sąrašo dydis:{"**"} Išjungta

config-label-quest-summary = {"**"}Quest santrauka:{"**"} { $status }
config-desc-quest-summary = Ši parinktis leidžia GM pateikti trumpą santrauką užbaigiant quest'us.
config-label-quest-summary-disabled = {"**"}Quest santrauka:{"**"} Išjungta

config-label-gm-rewards = GM atlygiai
config-desc-gm-rewards = Konfigūruoti atlygius, kuriuos GM gauna užbaigę quest'us.

## GM Rewards View
config-title-gm-rewards = {"**"}Serverio konfigūracija - GM atlygiai{"**"}
config-desc-gm-rewards-detail =
    {"**"}Pridėti/Keisti atlygius{"**"}
    Atidaro įvesties langą, kad galėtumėte pridėti, keisti arba pašalinti GM atlygius.

    > Sukonfigūruoti atlygiai yra kiekvienam quest'ui. Kiekvieną kartą, kai GM užbaigia quest'ą,
    jis gaus žemiau sukonfigūruotus atlygius savo aktyviam personažui.
config-msg-no-rewards = Atlygiai nesukonfigūruoti.
config-label-gm-experience = {"**"}Patirtis:{"**"} { $xp }
config-label-gm-items = {"**"}Daiktai:{"**"}

## Players View
config-title-players = {"**"}Serverio konfigūracija - Žaidėjai{"**"}

config-label-player-experience = {"**"}Žaidėjo patirtis:{"**"} { $status }
config-desc-player-experience = Įjungia/Išjungia patirties taškų (ar panašios vertės pagrįstos personažo progresijos) naudojimą.
config-label-player-experience-disabled = {"**"}Žaidėjo patirtis:{"**"} Išjungta

config-label-new-char-settings = {"**"}Naujo personažo nustatymai{"**"}
config-desc-new-char-settings = Konfigūruoti nustatymus, susijusius su naujais žaidėjų personažais ir jų pradinių inventorių sąranka.

config-label-player-board-purge = {"**"}Žaidėjų lentos valymas{"**"}
config-desc-player-board-purge = Valo įrašus iš žaidėjų lentos (jei įjungta).

## New Character Settings View
config-title-new-character = {"**"}Serverio konfigūracija - Naujo personažo nustatymai{"**"}

config-label-inventory-type = {"**"}Naujo personažo inventoriaus tipas:{"**"} { $type }
config-desc-inventory-type = Nustato, kaip naujai užregistruoti personažai inicializuoja savo inventorius.
config-label-inventory-type-disabled = {"**"}Naujo personažo inventoriaus tipas:{"**"} Išjungta

config-label-new-char-wealth = {"**"}Naujo personažo turtas:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Naujo personažo turtas:{"**"} Išjungta

config-label-approval-queue = {"**"}Patvirtinimo eilė:{"**"} { $channel }
config-desc-approval-queue = Jei nustatyta, nauji personažai turi būti patvirtinti GM šiame Forum kanale prieš juos aktyvuojant.
config-label-approval-queue-disabled = {"**"}Patvirtinimo eilė:{"**"} Išjungta
config-label-approval-queue-not-configured = {"**"}Patvirtinimo eilė:{"**"} Nesukonfigūruota

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = Žaidėjai pradeda su tuščiais inventoriais.
config-desc-inv-type-selection = Žaidėjai laisvai renkasi daiktus iš naujo personažo parduotuvės.
config-desc-inv-type-purchase = Žaidėjai perka daiktus iš naujo personažo parduotuvės su nurodyta valiutos suma.
config-desc-inv-type-open = Žaidėjai patys įveda savo inventoriaus daiktus.
config-desc-inv-type-static = Žaidėjams suteikiamas iš anksto nustatytas pradinis inventorius.

## New Character Shop View
config-title-new-char-shop = {"**"}Serverio konfigūracija - Naujo personažo parduotuvė{"**"}
config-label-inv-type-selection = {"**"}Inventoriaus tipas:{"**"} Pasirinkimas
config-desc-inv-type-selection-shop = Žaidėjai laisvai renkasi daiktus iš naujo personažo parduotuvės.
config-label-inv-type-purchase = {"**"}Inventoriaus tipas:{"**"} Pirkimas
config-desc-inv-type-purchase-shop = Žaidėjai perka daiktus iš naujo personažo parduotuvės su nurodyta valiutos suma.
config-label-inv-type-other = {"**"}Inventoriaus tipas:{"**"} { $type }
config-desc-inv-type-not-in-use = Naujo personažo parduotuvė nenaudojama.
config-msg-define-shop-items = Apibrėžkite parduotuvės daiktus.
config-msg-no-items = Daiktai nesukonfigūruoti.

## Static Kits View
config-title-static-kits = {"**"}Serverio konfigūracija - Statiniai rinkiniai{"**"}
config-desc-create-kit = Sukurti naują rinkinio apibrėžimą.
config-msg-no-kits = Rinkiniai nesukonfigūruoti.
config-label-kit-more-items = ...ir dar { $count } daiktų
config-label-empty-kit = {"*"}Tuščias rinkinys{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}Redaguojamas rinkinys: { $kitName }{"**"}
config-msg-kit-empty = Šis rinkinys tuščias. Naudokite aukščiau esančius mygtukus, kad pridėtumėte valiutą ar daiktus.
config-label-kit-currency = {"**"}Valiuta:{"**"} { $display }
config-label-kit-item = {"**"}Daiktas:{"**"} { $name }

## Currency View
config-title-currency = {"**"}Serverio konfigūracija - Valiuta{"**"}
config-desc-create-currency = Sukurti naują valiutą.
config-msg-no-currencies = Valiutos nesukonfigūruotos.
config-label-currency-display-type = Rodymo tipas: { $type } | Nominalai: { $count }
config-label-currency-type-double = Slankusis
config-label-currency-type-integer = Sveikasis

## Edit Currency View
config-title-manage-currency = {"**"}Valdyti valiutą: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Valiuta ir nominalai{"**"}__
    - Jūsų valiutos suteiktas pavadinimas laikomas bazine valiuta ir turi reikšmę 1.
    {"```"}Pavyzdys: „auksas" sukonfigūruotas kaip valiuta.{"```"}
    - Pridedant nominalą reikia nurodyti pavadinimą ir reikšmę, palyginti su bazine valiuta.
    {"```"}Pavyzdys: Auksui pridedami du nominalai: sidabras (reikšmė 0,1) ir varis (reikšmė 0,01).{"```"}
    - Visi sandoriai, susiję su bazine valiuta ar jos nominalais, bus automatiškai konvertuojami.
    {"```"}Pavyzdys: Žaidėjas turi 10 aukso ir išleidžia 3 vario. Jo naujas balansas automatiškai rodys
    9 aukso, 9 sidabro ir 7 vario.{"```"}
    - Valiutos, rodomos kaip sveikasis skaičius, rodys kiekvieną nominalą, o valiutos, rodomos kaip slankusis skaičius,
    rodys tik bazinę valiutą.
    {"```"}Pavyzdys: Aukščiau minėtas žaidėjas su slankiojo rodymu bus rodomas kaip 9,97 aukso.{"```"}
config-btn-toggle-display-current = Perjungti rodymą (Dabartinis: { $type })
config-msg-no-denominations = Nominalai nesukonfigūruoti.

## Shops View
config-title-shops = {"**"}Serverio konfigūracija - Parduotuvės{"**"}
config-desc-add-shop-wizard =
    {"**"}Pridėti parduotuvę (vedlys){"**"}
    Sukurti naują, tuščią parduotuvę iš formos.
config-desc-add-shop-json =
    {"**"}Pridėti parduotuvę (JSON){"**"}
    Sukurti naują parduotuvę pateikiant pilną JSON apibrėžimą. (Pažengusiems)
config-btn-example-json = JSON pavyzdys
config-desc-example-json =
    {"**"}JSON pavyzdys{"**"}
    Atsisiųskite JSON failo pavyzdį, rodantį numatomą formatą.
config-msg-example-json = Štai JSON failo pavyzdys, rodantis numatomą formatą.
config-msg-no-shops = Parduotuvės nesukonfigūruotos.
config-label-shop-type-forum = (Forum)
config-label-shop-channel = Kanalas: <#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}Pridėti parduotuvę - Pasirinkti vietos tipą{"**"}
config-label-text-channel = {"**"}Teksto kanalas{"**"}
config-desc-text-channel = Sukurti parduotuvę standartiniame teksto kanale.
config-label-forum-thread = {"**"}Forum gija{"**"}
config-desc-forum-thread = Sukurti parduotuvę forumo gijoje (naujoje arba esamoje).

## Forum Shop Setup View
config-title-forum-setup = {"**"}Pridėti parduotuvę - Forum gijos sąranka{"**"}
config-label-step1 = {"**"}1 žingsnis: Pasirinkite Forum kanalą{"**"}
config-label-step2 = {"**"}2 žingsnis: Pasirinkite gijos parinktį{"**"}
config-label-step3 = {"**"}3 žingsnis: Pasirinkite esamą giją{"**"}
config-desc-create-new-thread =
    {"**"}Sukurti naują giją{"**"}
    Atidaro formą naujos gijos sukūrimui ir parduotuvės konfigūravimui.
config-label-selected-thread = {"**"}Pasirinkta gija:{"**"} { $threadName }
config-desc-click-to-configure = Spustelėkite, kad sukonfigūruotumėte parduotuvę šioje gijoje.

## Manage Shop View
config-title-manage-shop = {"**"}Valdyti parduotuvę: { $shopName }{"**"}
config-label-shop-type = {"**"}Tipas:{"**"} { $type }
config-label-shop-type-text = Teksto kanalas
config-label-shop-type-forum-thread = Forum gija
config-label-shopkeeper = {"**"}Pardavėjas:{"**"} { $name }
config-label-shop-description = {"**"}Aprašymas:{"**"} { $description }
config-label-shop-channel-info = {"**"}Kanalas:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Redaguoti parduotuvės informaciją ir daiktus per vedlį.
config-desc-upload-json = Įkelti naują JSON apibrėžimą šiai parduotuvei.
config-desc-download-json = Atsisiųsti dabartinį JSON apibrėžimą.
config-desc-remove-shop = Visam laikui pašalinti šią parduotuvę.

## Edit Shop View
config-title-editing-shop = {"**"}Redaguojama parduotuvė: { $shopName }{"**"}
config-label-shop-shopkeeper = Pardavėjas: {"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}Atsargų konfigūracija: { $shopName }{"**"}
config-label-current-utc = Dabartinis UTC laikas: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Papildymo tvarkaraštis:{"**"} { $schedule }
config-label-restock-hourly = minutę :{ $minute }
config-label-restock-daily = { $time } UTC
config-label-restock-weekly = { $day } { $time } UTC
config-label-restock-mode = {"**"}Režimas:{"**"} { $mode }
config-label-restock-full = Pilnas papildymas
config-label-restock-incremental = Pridėti { $amount } per ciklą (iki maks.)
config-label-restock-disabled = {"**"}Papildymo tvarkaraštis:{"**"} Išjungta
config-label-item-stock-limits = {"**"}Daiktų atsargų limitai{"**"}
config-msg-no-items-in-shop = Šioje parduotuvėje nėra daiktų.
config-label-stock-with-available = Maks.: { $max } | Turima: { $available }
config-label-stock-reserved = | Rezervuota: { $reserved }
config-label-stock-not-initialized = Maks.: { $max } | Turima: (neinicializuota)
config-label-stock-unlimited = Atsargos: Neribotos

## Roleplay View
config-title-roleplay = {"**"}Serverio konfigūracija - Vaidmenų žaidimo atlygiai{"**"}
config-label-rp-status = {"**"}Būsena:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Serverio laikas:{"**"} `{ $time }`
config-label-rp-enabled = Įjungta
config-label-rp-disabled = Išjungta

config-desc-rp-mode-scheduled = {"```"}Atlygiai skiriami vieną kartą, nusiuntus reikiamą skaičių tinkamų žinučių per nustatytą laikotarpį (kas valandą, kasdien arba kas savaitę).{"```"}
config-desc-rp-mode-accrued = {"```"}Atlygiai skiriami pakartotinai kiekvieną kartą, kai nusiunčiamas nustatytas skaičius tinkamų žinučių.{"```"}

config-label-rp-config-details = {"**"}Konfigūracijos detalės:{"**"}
config-label-rp-mode = {"**"}Režimas:{"**"} { $mode }
config-label-rp-min-length = {"**"}Minimalus žinutės ilgis:{"**"} { $length } simbolių
config-label-rp-cooldown = {"**"}Atvėsimo laikas:{"**"} { $seconds } sekundžių
config-label-rp-frequency-once = {"**"}Dažnis:{"**"} Kartą per { $period }
config-label-rp-reset-time = {"**"}Atstatymo laikas:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Slenkstis:{"**"} { $count } tinkamų žinučių
config-label-rp-frequency-every = {"**"}Dažnis:{"**"} Kas { $count } tinkamų žinučių

config-label-rp-channels = {"**"}Vaidmenų žaidimo kanalai:{"**"}
config-msg-rp-no-channels = Nesukonfigūruota.
config-label-rp-channels-more = ...ir dar { $count }.

config-label-rp-rewards = {"**"}Atlygiai:{"**"}
config-msg-rp-no-rewards = Nesukonfigūruota.
config-label-rp-experience = {"**"}Patirtis:{"**"} { $xp }
config-label-rp-items = {"**"}Daiktai:{"**"}
config-label-rp-currency = {"**"}Valiuta:{"**"}

## Language View
config-title-language = {"**"}Serverio konfigūracija - Kalba{"**"}
config-server-language-help =
    Šis nustatymas leidžia nurodyti numatytąją ReQuest {"**"}viešų{"**"} atsakymų ir žinučių kalbą šiame serveryje. Viešos žinutės apima:
    - Quest ir žaidėjų lentos įrašus
    - Quest santraukos ir žurnalo kanalų žinutes
    - Parduotuvės papildymą
    - Žaidėjų daiktų naudojimą

    Šis nustatymas veikia tik statinį boto generuojamą tekstą ir neverčia dinaminio turinio, tokio kaip vartotojų įvesti daiktų pavadinimai ar quest aprašymai.

    Asmeniniai atsakymai ir meniu šio nustatymo neveikiami.
config-label-server-language = {"**"}Serverio kalba:{"**"} { $language }
config-label-server-language-default = {"**"}Serverio kalba:{"**"} Numatytoji (be pakeitimo)
config-select-placeholder-server-language = Pasirinkite serverio kalbą
config-select-option-default = Numatytoji (be pakeitimo)
config-select-desc-default = Naudoti kiekvieno vartotojo nuostatą arba Discord lokalę.

# Quest Roles
config-btn-quest-roles = Quest Roles
config-btn-manage-gm-quest-roles = Manage

config-modal-title-confirm-quest-role-removal = Confirm Role Removal
config-modal-label-remove-quest-role = Remove { $roleName } from { $gmName }?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Select Quest Role Mode
config-select-option-quest-role-disabled = Disabled
config-select-desc-quest-role-disabled = No roles are created or assigned.
config-select-option-quest-role-temporary = Temporary
config-select-desc-quest-role-temporary = GMs can create temporary roles per quest.
config-select-option-quest-role-static = Static
config-select-desc-quest-role-static = GMs pick from pre-assigned server roles.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Assign server role(s) to this GM

## Quest Roles View
config-title-quest-roles = {"**"}Server Configuration - Quest Roles{"**"}
config-label-quest-roles = Quest Roles
config-desc-quest-roles =
    Configure how party roles are handled during quests.

config-label-quest-role-mode-disabled = {"**"}Quest Role Mode:{"**"} Disabled
    No roles are created or assigned during quests.
config-label-quest-role-mode-temporary = {"**"}Quest Role Mode:{"**"} Temporary
    GMs can optionally create a temporary role during quest creation.
    The role is deleted when the quest completes or is cancelled.
config-label-quest-role-mode-static = {"**"}Quest Role Mode:{"**"} Static
    GMs pick from pre-assigned server roles. Roles are assigned to
    party members during quests but are never deleted.

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}Server Configuration - Static Quest Role Assignments{"**"}
config-label-manage-assignments = Manage Role Assignments
config-desc-manage-assignments =
    Assign existing server roles to GMs for use during quests.
    Roles must be lower than ReQuest's highest role in the server hierarchy.
config-msg-no-gm-members = No members with a GM role were found on this server.
config-label-no-roles-assigned = No quest roles assigned

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}Manage Quest Roles — { $gmName }{"**"}
config-error-unmanageable-roles = The following roles cannot be assigned because they are managed by an integration, are the default role, or are above ReQuest's highest role: { $roles }
config-error-quest-role-limit = This GM has reached the maximum of { $limit } assigned quest roles.
