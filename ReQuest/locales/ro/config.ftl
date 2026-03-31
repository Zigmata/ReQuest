## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = Golește
config-btn-remove-gm-roles = Elimină roluri GM
config-btn-forbidden-roles = Roluri interzise

# Quests
config-btn-toggle-quest-summary = Comută rezumatul quest-ului
config-btn-toggle-player-experience = Comută experiența jucătorului
config-btn-toggle-display = Comută afișarea
config-btn-purge-player-board = Curăță panoul jucătorilor
config-btn-add-modify-rewards = Adaugă/Modifică recompense

# Currency
config-btn-add-denomination = Adaugă denominație
config-btn-add-new-currency = Adaugă monedă nouă
config-btn-remove-currency = Elimină monedă

# Shops - creation
config-btn-add-shop-wizard = Adaugă magazin (Asistent)
config-btn-add-shop-json = Adaugă magazin (JSON)
config-btn-edit-shop-wizard = Editează magazin (Asistent)
config-btn-edit-shop-json = Editează magazin (JSON)
config-btn-remove-shop = Elimină magazin
config-btn-add-item = Adaugă obiect
config-btn-edit-shop-details = Editează detalii magazin
config-btn-download-json = Descarcă JSON
config-btn-done-editing = Editare terminată
config-btn-scan-server-configs = Scanează configurațiile serverului
config-btn-re-scan = Re-scanează

# New character shop
config-btn-upload-json = Încarcă JSON
config-btn-configure-new-character-wealth = Configurează averea personajului nou
config-btn-configure-new-character-shop = Configurează magazinul personajului nou
config-btn-clear-shop = Golește magazinul
config-btn-configure-static-kits = Configurează kituri statice
config-btn-new-character-settings = Setări personaj nou
config-btn-disabled-no-currency = Dezactivat (Nicio monedă configurată)
config-btn-disabled-no-wealth = Dezactivat (Nicio avere inițială configurată)

# Static kits
config-btn-create-new-kit = Creează kit nou
config-btn-delete-kit = Șterge kit
config-btn-add-currency = Adaugă monedă

# Roleplay
config-btn-toggle-rp-rewards = Comută recompense RP
config-btn-clear-channels = Golește canale
config-btn-edit-settings = Editează setări
config-btn-configure-rewards = Configurează recompense

# Stock
config-btn-stock-limits = Limite de stoc
config-btn-set-limit = Setează limită
config-btn-edit-limit = Editează limită
config-btn-remove-limit = Elimină limită
config-btn-configure-restock-schedule = Configurează programul de reaprovizionare
config-btn-back-to-shop-editor = Înapoi la editorul de magazine

# Forum shop
config-btn-create-new-thread = Creează un fir nou
config-btn-use-existing-thread = Folosește un fir existent

# Wizard
config-btn-quit = Ieși
config-btn-configure-channels = Configurează canale
config-btn-configure-roles = Configurează roluri
config-btn-configure-quests = Configurează quest-uri
config-btn-configure-players = Configurează jucători
config-btn-configure-currency = Configurează moneda
config-btn-configure-rp-rewards = Configurează recompense RP
config-btn-configure-shops = Configurează magazine
config-btn-new-char-setup = Configurare personaj nou

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = Confirmă eliminarea rolului
config-modal-title-confirm-removal = Confirmă eliminarea
config-modal-title-confirm-currency-removal = Confirmă eliminarea monedei
config-modal-title-confirm-shop-removal = Confirmă eliminarea magazinului
config-modal-title-confirm-kit-deletion = Confirmă ștergerea kitului
config-modal-title-confirm-remove-stock-limit = Confirmă eliminarea limitei de stoc
config-modal-title-clear-shop = Confirmați golirea magazinului

# Confirm modal prompt labels
config-modal-label-remove-role = Eliminați { $roleName }?
config-modal-label-remove-denomination = Eliminați { $denominationName }?
config-modal-label-remove-currency = Eliminați { $currencyName }?
config-modal-label-shop-removal-warning = ATENȚIE: Această acțiune este ireversibilă!
config-modal-label-kit-deletion-warning = ATENȚIE: Ireversibil!
config-modal-label-remove-stock-limit = Tastați CONFIRMĂ pentru a elimina limita de stoc
config-modal-label-clear-shop = Goliți toate articolele din acest magazin?

# Error messages from buttons
config-error-shop-data-not-found = Eroare: Nu s-au putut găsi datele acelui magazin.
config-msg-shop-json-download = Iată definiția JSON pentru {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Iată definiția JSON pentru magazinul personajului nou.
config-error-select-forum-first = Vă rugăm să selectați mai întâi un canal de tip Forum.
config-error-select-thread-first = Vă rugăm să selectați mai întâi un fir.

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Adaugă monedă nouă
config-modal-label-currency-name = Numele monedei
config-error-currency-already-exists = O monedă sau denominație cu numele { $name } există deja!

# RenameCurrencyModal
config-modal-title-rename-currency = Redenumește moneda
config-modal-label-new-currency-name = Noul nume al monedei
config-error-currency-name-exists = O monedă cu numele „{ $name }" există deja.
config-error-denomination-name-exists = O denominație cu numele „{ $name }" există deja.

# RenameDenominationModal
config-modal-title-rename-denomination = Redenumește denominația
config-modal-label-new-denomination-name = Noul nume al denominației

# AddCurrencyDenominationModal
config-modal-title-add-denomination = Adaugă denominație { $currencyName }
config-modal-label-denomination-name = Nume
config-modal-placeholder-denomination-name = de ex., Argint
config-modal-label-denomination-value = Valoare
config-modal-placeholder-denomination-value = de ex., 0.1
config-error-denomination-matches-currency = Noul nume de denominație nu poate coincide cu o monedă existentă pe acest server! S-a găsit o monedă existentă cu numele „{ $existingName }".
config-error-denomination-matches-denomination = Noul nume de denominație nu poate coincide cu o denominație existentă pe acest server! S-a găsit o denominație existentă cu numele „{ $denominationName }" sub moneda numită „{ $currencyName }".
config-error-denomination-value-exists = Denominațiile sub aceeași monedă trebuie să aibă valori unice! { $denominationName } are deja această valoare atribuită.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Nume de roluri interzise
config-modal-label-names = Nume
config-modal-placeholder-names = Introduceți numele separate prin virgule
config-msg-forbidden-roles-updated = Rolurile interzise au fost actualizate!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Curăță panoul jucătorilor
config-modal-label-age = Vechime
config-modal-placeholder-age = Introduceți vechimea maximă a postărilor (în zile) de păstrat
config-msg-posts-purged = Postările mai vechi de { $days } zile au fost curățate!

# GMRewardsModal
config-modal-title-gm-rewards = Adaugă/Modifică recompense GM
config-modal-label-experience = Experiență
config-modal-placeholder-enter-number = Introduceți un număr
config-modal-label-items = Obiecte
config-modal-placeholder-items =
    Nume: Cantitate
    Nume2: Cantitate
    etc.
config-error-experience-invalid = Experiența trebuie să fie un număr întreg valid (de ex. 2000).
config-error-item-format-invalid = Format de obiect invalid: „{ $item }". Fiecare obiect trebuie să fie pe o linie nouă, în formatul „Nume: Cantitate".

# ConfigShopDetailsModal
config-modal-title-shop-details = Adaugă/Editează detalii magazin
config-modal-label-shop-channel = Selectați un canal
config-modal-placeholder-shop-channel = Selectați canalul pentru acest magazin
config-modal-label-shop-name = Numele magazinului
config-modal-placeholder-shop-name = Introduceți numele magazinului
config-modal-label-shopkeeper-name = Numele vânzătorului
config-modal-placeholder-shopkeeper-name = Introduceți numele vânzătorului
config-modal-label-shop-description = Descrierea magazinului
config-modal-placeholder-shop-description = Introduceți o descriere pentru magazin
config-modal-label-shop-image-url = URL imagine magazin
config-modal-placeholder-shop-image-url = Introduceți un URL pentru imaginea magazinului
config-error-no-channel-selected = Niciun canal selectat pentru magazin.
config-error-shop-already-in-channel = Un magazin este deja înregistrat în canalul selectat. Vă rugăm să alegeți un alt canal sau să editați magazinul existent.

# build_shop_header_view
config-label-shopkeeper = {"**"}Vânzător:{"**"} { $name }
config-msg-use-shop-command = Folosiți comanda `/shop` pentru a răsfoi și cumpăra obiecte.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Creează magazin în fir de Forum
config-modal-label-thread-name = Numele firului
config-modal-placeholder-thread-name = Introduceți numele firului pentru magazin
config-error-forum-not-found = Nu s-a putut găsi canalul Forum selectat.
config-error-shop-already-in-thread = Un magazin este deja înregistrat în acest fir. Acest lucru nu ar trebui să se întâmple pentru un fir nou.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Adaugă magazin nou prin JSON
config-modal-label-upload-json = Încărcați un fișier .json care conține datele magazinului
config-error-no-json-uploaded = Niciun fișier JSON încărcat pentru magazin.
config-error-file-must-be-json = Fișierul încărcat trebuie să fie un fișier JSON (.json).
config-error-invalid-json = Format JSON invalid: { $error }
config-error-json-validation-failed = JSON-ul nu se conformează schemei: { $error }

# ShopItemModal
config-modal-title-shop-item = Adaugă/Editează obiect de magazin
config-modal-label-item-name = Numele obiectului
config-modal-placeholder-item-name = Introduceți numele obiectului
config-modal-label-item-description = Descrierea obiectului
config-modal-placeholder-item-description = Introduceți o descriere pentru obiect
config-modal-label-item-quantity = Cantitatea obiectului
config-modal-placeholder-item-quantity = Introduceți cantitatea vândută per achiziție
config-modal-label-item-costs = Costurile obiectului
config-modal-placeholder-item-costs = De ex.: 10 gold + 5 silver\nSAU: 50 rep\n(Folosiți + pentru ȘI, Rânduri noi pentru SAU)
config-error-item-quantity-positive = Cantitatea obiectului trebuie să fie un număr întreg pozitiv.
config-error-cost-format-invalid = Format de cost invalid în opțiunea: „{ $option }". Fiecare cost trebuie să aibă o sumă și o monedă separate prin spațiu, de ex. „10 gold".
config-error-cost-amount-invalid = Suma invalidă „{ $amount }" pentru moneda: „{ $currency }". Suma trebuie să fie un număr pozitiv.
config-error-unknown-currency = Monedă necunoscută `{ $currency }`. Vă rugăm să folosiți o monedă validă configurată pentru acest server.
config-error-item-already-exists = Un obiect cu numele { $itemName } există deja în acest magazin.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Actualizează magazin prin JSON
config-modal-label-upload-new-json = Încărcați noua definiție JSON
config-error-no-file-uploaded = Niciun fișier încărcat.
config-error-file-must-be-json-ext = Fișierul trebuie să fie un fișier `.json`.
config-error-json-validation-message = Validarea JSON a eșuat: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Adaugă/Editează echipament personaj nou
config-modal-placeholder-item-quantity-selection = Introduceți cantitatea primită per selecție
config-modal-label-item-cost = Costul obiectului
config-error-cost-format-short = Format de cost invalid: „{ $component }". Așteptat „Sumă Monedă".
config-error-amount-invalid-short = Sumă invalidă „{ $amount }" pentru moneda „{ $currency }".
config-error-item-exists-new-char = Un obiect cu numele { $itemName } există deja în magazinul personajului nou.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Încarcă magazin personaj nou (JSON)
config-error-no-json-uploaded-short = Niciun fișier JSON încărcat.
config-error-json-must-have-shopstock = JSON-ul trebuie să conțină un array „shopStock".
config-error-items-must-have-name-price = Toate obiectele trebuie să aibă „name" și „price".

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Setează averea personajului nou
config-modal-label-amount = Sumă
config-modal-placeholder-amount = Introduceți suma acestei monede.
config-modal-placeholder-currency-name = Introduceți numele unei monede definite pe acest server
config-error-no-currencies-configured = Nicio monedă nu este configurată pe acest server.
config-error-currency-not-found = Moneda sau denominația cu numele { $name } nu a fost găsită. Vă rugăm să folosiți o monedă validă.

# CreateStaticKitModal
config-modal-title-create-kit = Creează kit static nou
config-modal-label-kit-name = Numele kitului
config-modal-placeholder-kit-name = de ex., Kit de luptător începător
config-modal-label-description = Descriere
config-modal-placeholder-kit-description = Descriere opțională pentru acest kit
config-error-kit-name-exists = Un kit static cu numele „{ $kitName }" există deja. Vă rugăm să alegeți un alt nume.

# StaticKitItemModal
config-modal-title-kit-item = Adaugă/Editează obiect de kit
config-modal-placeholder-kit-item-quantity = Introduceți cantitatea acestui obiect de inclus în kit

# StaticKitCurrencyModal
config-modal-title-kit-currency = Adaugă monedă la kit
config-modal-placeholder-currency-eg = de ex., Aur
config-modal-placeholder-amount-eg = de ex., 100
config-error-amount-must-be-number = Suma trebuie să fie un număr.
config-error-amount-exceeds-maximum = Suma nu poate depăși { $max }.
config-error-no-currencies-on-server = Nicio monedă configurată pe server.
config-error-currency-not-found-short = Moneda „{ $currency }" nu a fost găsită.
config-error-denomination-not-found = Denominația „{ $denomination }" nu a fost găsită în configurarea monedei.

# RoleplaySettingsModal
config-modal-title-rp-settings = Setări roleplay
config-modal-label-min-message-length = Lungimea minimă a mesajului (caractere)
config-modal-placeholder-min-message-length = Nr. de caractere necesare pentru ca un mesaj să fie eligibil. 0 pentru fără limită
config-modal-label-cooldown = Pauză de așteptare (secunde)
config-modal-placeholder-cooldown = Timpul de așteptare, în secunde, între numărarea mesajelor ca eligibile pentru recompense
config-modal-label-message-threshold = Prag de mesaje
config-modal-placeholder-message-threshold = Numărul de mesaje necesare pentru a declanșa recompensa
config-modal-label-frequency = Frecvență (nr. de mesaje)
config-modal-placeholder-frequency = Numărul de mesaje eligibile necesare pentru a câștiga recompense
config-error-min-length-invalid = Lungimea minimă a mesajului trebuie să fie un număr întreg non-negativ.
config-error-cooldown-invalid = Pauza de așteptare trebuie să fie un număr întreg non-negativ.
config-error-threshold-invalid = Pragul de mesaje trebuie să fie un număr întreg pozitiv.
config-error-frequency-invalid = Frecvența trebuie să fie un număr întreg pozitiv.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Configurează recompense roleplay
config-modal-label-items-name-quantity = Obiecte (Nume: Cantitate)
config-modal-label-currency-name-amount = Monedă (Nume: Sumă)
config-error-experience-non-negative = Experiența trebuie să fie un număr întreg non-negativ.
config-error-item-quantity-positive-named = Cantitatea obiectului „{ $itemName }" trebuie să fie un număr întreg pozitiv.
config-error-currency-amount-positive = Suma monedei „{ $currencyName }" trebuie să fie un număr pozitiv.

# SetItemStockModal
config-modal-title-stock-limit = Limită de stoc: { $itemName }
config-modal-label-max-stock = Stoc maxim
config-modal-placeholder-max-stock = Introduceți stocul maxim (de ex., 10)
config-modal-label-current-stock = Stoc curent
config-modal-placeholder-current-stock = Introduceți stocul disponibil curent
config-modal-label-restock-increment = Cantitate reaprovizionare (per ciclu)
config-modal-placeholder-restock-increment = Cantitate adăugată per ciclu (implicit: 1)
config-error-max-stock-positive = Stocul maxim trebuie să fie un număr întreg pozitiv.
config-error-current-stock-non-negative = Stocul curent trebuie să fie un număr întreg non-negativ.
config-error-current-exceeds-max = Stocul curent nu poate depăși stocul maxim.
config-error-item-not-in-shop = Obiectul „{ $itemName }" nu a fost găsit în magazin.

# RestockScheduleModal
config-modal-title-restock-schedule = Configurează programul de reaprovizionare
config-modal-restock-schedule-label = Programare
config-modal-restock-schedule-none = Niciunul (Dezactivat)
config-modal-restock-schedule-hourly = La fiecare oră
config-modal-restock-schedule-daily = Zilnic
config-modal-restock-schedule-weekly = Săptămânal
config-modal-label-time = Ora (HH:MM în UTC)
config-modal-desc-current-time = Ora curentă: { $utcTime }
config-modal-placeholder-time = de ex., 14:30 pentru 2:30 PM UTC
config-modal-restock-day-label = Ziua săptămânii (doar săptămânal)
config-modal-restock-mode-label = Mod de reaprovizionare
config-modal-restock-mode-full = Complet (resetare la maxim)
config-modal-restock-mode-incremental = Incremental (adaugă cantitate)
config-error-time-format-invalid = Ora trebuie să fie în formatul HH:MM (de ex., 14:30).
config-error-increment-positive = Cantitatea de incrementare trebuie să fie un număr întreg pozitiv.

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Căutați canalul { $configName }

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Alegeți rolul de anunțare a quest-urilor

# AddGMRoleSelect
config-select-placeholder-gm-roles = Alegeți rolul/rolurile GM

# ConfigWaitListSelect
config-select-placeholder-wait-list = Selectați dimensiunea listei de așteptare
config-select-option-disabled = 0 (Dezactivat)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Selectați modul de inventar
config-select-option-disabled-label = Dezactivat
config-select-desc-disabled = Jucătorii încep cu inventare goale.
config-select-option-selection = Selecție
config-select-desc-selection = Jucătorii aleg obiecte liber din magazinul personajului nou.
config-select-option-purchase = Achiziție
config-select-desc-purchase = Jucătorii cumpără obiecte din magazinul personajului nou cu o sumă dată de monedă.
config-select-option-open = Deschis
config-select-desc-open = Jucătorii introduc manual propriile inventare.
config-select-option-static = Static
config-select-desc-static = Jucătorilor li se oferă un inventar inițial predefinit.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Selectați canalele eligibile

# RoleplayModeSelect
config-select-placeholder-rp-mode = Selectați modul
config-select-option-scheduled = Programat
config-select-desc-scheduled = Recompensele sunt acordate o singură dată în cadrul unei perioade de resetare specificate.
config-select-option-accrued = Acumulat
config-select-desc-accrued = Recompensele sunt acordate repetat pe baza nivelurilor de activitate specificate.

# RoleplayResetSelect
config-select-placeholder-reset-period = Selectați perioada de resetare
config-select-option-hourly = Din oră în oră
config-select-desc-hourly = Se resetează în fiecare oră.
config-select-option-daily = Zilnic
config-select-desc-daily = Se resetează la fiecare 24 de ore.
config-select-option-weekly = Săptămânal
config-select-desc-weekly = Se resetează la fiecare 7 zile.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Selectați ziua de resetare

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Selectați ora de resetare (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Selectați un canal Forum

# ForumThreadSelect
config-select-placeholder-thread = Selectați un fir
config-select-option-no-threads = Nu s-au găsit fire active
config-select-desc-no-threads = Creați un fir nou sau verificați firele arhivate
config-select-option-select-forum-first = Selectați mai întâi un Forum
config-select-desc-select-forum-first = Vă rugăm să selectați un canal Forum mai sus
config-select-desc-thread-id = ID fir: { $threadId }
config-error-select-valid-thread = Vă rugăm să selectați un fir valid sau să creați unul nou.
config-error-thread-not-found = Nu s-a putut găsi firul selectat. Este posibil să fi fost șters sau arhivat.

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = Configurare server - Meniu principal
config-menu-config-wizard = Asistent de configurare
config-menu-desc-config-wizard = Verificați dacă serverul dumneavoastră este pregătit pentru a folosi ReQuest cu o scanare rapidă.
config-menu-channels = Canale
config-menu-desc-channels = Setați canalele desemnate pentru postările ReQuest.
config-menu-currency = Monedă
config-menu-desc-currency = Setări globale de monedă.
config-menu-players = Jucători
config-menu-desc-players = Setări globale pentru jucători, cum ar fi urmărirea punctelor de experiență.
config-menu-quests = Quest-uri
config-menu-desc-quests = Setări globale pentru quest-uri, cum ar fi listele de așteptare.
config-menu-rp-rewards = Recompense RP
config-menu-desc-rp-rewards = Configurați recompensele de roleplay.
config-menu-roles = Roluri
config-menu-desc-roles = Opțiuni de configurare pentru roluri pingabile sau privilegiate.
config-menu-shops = Magazine
config-menu-desc-shops = Configurați magazine personalizate.
config-menu-language = Limbă
config-menu-desc-language = Setați limba implicită pentru acest server.

## Wizard View
config-title-wizard = {"**"}Configurare server - Asistent{"**"}
config-wizard-intro =
    {"**"}Bine ați venit la Asistentul de Configurare ReQuest!{"**"}

    Acest asistent vă va ajuta să vă asigurați că serverul este configurat corect pentru a folosi funcționalitățile ReQuest.
    Va scana setările curente și va oferi recomandări pentru orice ajustări necesare.

    Folosiți butonul „Lansează scanarea" de mai jos pentru a începe procesul de validare. Odată ce scanarea este completă,
    veți primi un raport detaliat al configurației serverului împreună cu orice modificări recomandate.

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}Permisiuni globale bot{"**"}__
config-wizard-bot-permissions-desc = Această secțiune verifică dacă ReQuest are permisiunile corecte pentru a funcționa corect.
config-wizard-bot-role = Rol bot: { $roleMention }
config-wizard-status-warnings = {"**"}Status: ⚠️ AVERTISMENTE GĂSITE{"**"}
config-wizard-missing-perm = - ⚠️ Lipsă: `{ $permissionName }`
config-wizard-ensure-permissions = Vă rugăm să vă asigurați că rolul cel mai înalt al botului are aceste permisiuni acordate global.
config-wizard-status-ok = {"**"}Status: ✅ OK{"**"}
config-wizard-bot-permissions-ok = Botul are toate permisiunile globale necesare.
config-wizard-status-scan-failed = {"**"}Status: ❌ SCANARE EȘUATĂ{"**"}
config-wizard-scan-error = A apărut o eroare neașteptată la verificarea permisiunilor botului.
config-wizard-error-type = Eroare: { $errorType }
config-wizard-required-permissions = {"**"}Permisiuni necesare pentru rolul botului:{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = Vizualizare canale
config-wizard-perm-manage-roles = Gestionare roluri
config-wizard-perm-send-messages = Trimitere mesaje
config-wizard-perm-attach-files = Atașare fișiere
config-wizard-perm-add-reactions = Adăugare reacții
config-wizard-perm-use-external-emoji = Folosire emoji externe
config-wizard-perm-manage-messages = Gestionare mesaje
config-wizard-perm-read-message-history = Citire istoric mesaje

# Wizard - Role Validation
config-wizard-role-header = __{"**"}Configurări roluri{"**"}__
config-wizard-role-desc =
    Această secțiune verifică următoarele:

    - Rolurile GM (necesare) și rolul de anunțare (opțional) sunt configurate.
    - Rolul implicit (@everyone) are permisiunile necesare pentru ca utilizatorii să acceseze funcționalitățile botului.
    - Rolul implicit (@everyone) nu are permisiuni periculoase.
    - Rolurile GM și de anunțare sunt verificate pentru a vedea dacă au escaladări de permisiuni dincolo de rolul implicit.

    Orice avertismente de aici sunt doar recomandări bazate pe o configurare implicită. În funcție de nevoile serverului dumneavoastră, ați putea avea motive să ignorați unele dintre aceste recomandări.

config-wizard-default-role-label = {"**"}Rol implicit:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Permisiuni periculoase găsite:
config-wizard-default-role-ok = - ✅ @everyone: OK
config-wizard-missing-permission = - Permisiune lipsă: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}Roluri GM:{"**"}
config-wizard-no-gm-roles = - ⚠️ Niciun rol GM configurat
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Rolul configurat nu a fost găsit/a fost șters de pe server
config-wizard-role-ok = - ✅ { $roleMention }: OK
config-wizard-announcement-role-label = {"**"}Rol de anunțare:{"**"}
config-wizard-no-announcement-role = - ℹ️ Niciun rol de anunțare configurat
config-wizard-announcement-role-not-found = - ⚠️ Rolul configurat nu a fost găsit/a fost șters de pe server
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Escaladări de permisiuni detectate - { $escalations }
config-wizard-escalation-more = , și încă { $count }...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = Trimitere mesaje în fire
config-wizard-perm-use-application-commands = Folosire comenzi aplicație

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = Gestionare canale
config-wizard-perm-manage-webhooks = Gestionare webhook-uri
config-wizard-perm-manage-server = Gestionare server
config-wizard-perm-manage-nicknames = Gestionare porecle
config-wizard-perm-kick-members = Expulzare membri
config-wizard-perm-ban-members = Interzicere membri
config-wizard-perm-timeout-members = Suspendare membri
config-wizard-perm-mention-everyone = Menționare @everyone
config-wizard-perm-manage-threads = Gestionare fire
config-wizard-perm-administrator = Administrator

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}Configurări canale{"**"}__
config-wizard-channel-desc =
    Această secțiune verifică următoarele:

    - Canalele configurate există.
    - Botul are permisiunea de a vizualiza și trimite mesaje în canalele configurate.
    - Rolul implicit (@everyone) nu are permisiunea `Trimitere mesaje`.

config-wizard-channel-no-config-required = - ⚠️ Niciun canal configurat
config-wizard-channel-not-configured = - ℹ️ Neconfigurat (Opțional)
config-wizard-channel-not-found = - ⚠️ Canalul configurat nu a fost găsit/a fost șters de pe server
config-wizard-channel-ok = - ✅ OK
config-wizard-bot-cannot-view = - ⚠️ { $botMention } nu poate vizualiza acest canal.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } nu poate trimite mesaje în acest canal.
config-wizard-everyone-can-send = - ⚠️ @everyone poate trimite mesaje în acest canal.

# Wizard - Channel names
config-wizard-channel-quest-board = Panou quest-uri
config-wizard-channel-player-board = Panou jucători
config-wizard-channel-quest-archive = Arhivă quest-uri
config-wizard-channel-gm-transaction-log = Jurnal tranzacții GM
config-wizard-channel-player-transaction-log = Jurnal tranzacții jucători
config-wizard-channel-shop-log = Jurnal magazin
config-wizard-channel-approval-queue = Coadă de aprobare caractere

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}Panou de setări{"**"}__
config-wizard-dashboard-desc = Această secțiune oferă o prezentare generală a configurărilor neesențiale pentru referință rapidă.
config-wizard-quest-settings = {"**"}Setări quest-uri{"**"}
config-wizard-quest-wait-list = - Dimensiune listă de așteptare quest: { $size }
config-wizard-quest-summary = - Rezumat quest: { $status }
config-wizard-gm-rewards-per-quest = {"**"}Recompense GM (per quest){"**"}
config-wizard-player-settings = {"**"}Setări jucători{"**"}
config-wizard-player-experience = - Experiență jucător: { $status }
config-wizard-currency-settings = {"**"}Setări monedă{"**"}
config-wizard-rp-rewards = {"**"}Recompense roleplay{"**"}
config-wizard-rp-status = - Status: { $status }
config-wizard-rp-mode = - Mod: { $mode }
config-wizard-rp-channels = - Canale monitorizate: { $count }
config-wizard-shops = {"**"}Magazine{"**"}
config-wizard-shops-count = - Magazine configurate: { $count }
config-wizard-shops-more = - ...și încă { $count }
config-wizard-new-char-setup = {"**"}Configurare personaj nou{"**"}
config-wizard-inventory-type = - Tip inventar: { $type }
config-wizard-new-char-shop-items = - Obiecte magazin personaj nou: { $count }
config-wizard-static-kits = - Kituri statice: { $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ Nicio monedă configurată
config-wizard-configured-currencies = {"**"}Monede configurate:{"**"}
config-wizard-no-denominations = - Nicio denominație configurată
config-wizard-gm-rewards-disabled = {"**"}Status:{"**"} Dezactivat
config-wizard-gm-rewards-enabled = {"**"}Status:{"**"} Activat
config-wizard-gm-rewards-experience = - Experiență: { $xp }
config-wizard-gm-rewards-items = - Obiecte:
config-wizard-unnamed-shop = Magazin fără nume

## Roles View
config-title-roles = {"**"}Configurare server - Roluri{"**"}
config-label-announcement-role = {"**"}Rol de anunțare:{"**"} { $status }
config-desc-announcement-role = Acest rol este menționat când un quest este postat.
config-label-announcement-role-default = {"**"}Rol de anunțare:{"**"} Neconfigurat
config-label-gm-roles = {"**"}Rol(uri) GM:{"**"} { $roles }
config-desc-gm-roles = Aceste roluri vor acorda acces la comenzile și funcționalitățile Game Master.
config-label-gm-roles-default = {"**"}Rol(uri) GM:{"**"} Neconfigurat
config-title-forbidden-roles = __{"**"}Roluri interzise{"**"}__
config-desc-forbidden-roles =
    Configurează o listă de nume de roluri care nu pot fi folosite de Game Masteri pentru rolurile lor de echipă.
    În mod implicit, `everyone`, `administrator`, `gm` și `game master` nu pot fi folosite. Această configurare
    extinde lista respectivă.

## GM Role Remove View
config-title-remove-gm-roles = {"**"}Configurare server - Eliminare rol(uri) GM{"**"}
config-msg-no-gm-roles = Niciun rol GM configurat.

## Channels View
config-title-channels = {"**"}Configurare server - Canale{"**"}

config-label-quest-board = {"**"}Panou quest-uri:{"**"} { $channel }
config-desc-quest-board = Canalul unde quest-urile noi/active vor fi postate.
config-label-quest-board-default = {"**"}Panou quest-uri:{"**"} Neconfigurat

config-label-player-board = {"**"}Panou jucători:{"**"} { $channel }
config-desc-player-board = Un canal opțional de anunțuri/mesaje pentru jucători.
config-label-player-board-default = {"**"}Panou jucători:{"**"} Neconfigurat

config-label-quest-archive = {"**"}Arhivă quest-uri:{"**"} { $channel }
config-desc-quest-archive = Un canal opțional unde quest-urile finalizate vor fi mutate, cu informații rezumate.
config-label-quest-archive-default = {"**"}Arhivă quest-uri:{"**"} Neconfigurat

config-label-gm-transaction-log = {"**"}Jurnal tranzacții GM:{"**"} { $channel }
config-desc-gm-transaction-log = Un canal opțional unde tranzacțiile GM (adică comenzile de Modificare Jucător) sunt înregistrate.
config-label-gm-transaction-log-default = {"**"}Jurnal tranzacții GM:{"**"} Neconfigurat

config-label-player-transaction-log = {"**"}Jurnal tranzacții jucători:{"**"} { $channel }
config-desc-player-transaction-log = Un canal opțional unde tranzacțiile jucătorilor, cum ar fi schimburile și consumarea obiectelor, sunt înregistrate.
config-label-player-transaction-log-default = {"**"}Jurnal tranzacții jucători:{"**"} Neconfigurat

config-label-shop-log = {"**"}Jurnal magazin:{"**"} { $channel }
config-desc-shop-log = Un canal opțional unde tranzacțiile magazinului sunt înregistrate.
config-label-shop-log-default = {"**"}Jurnal magazin:{"**"} Neconfigurat

## Quests View
config-title-quests = {"**"}Configurare server - Quest-uri{"**"}

config-label-wait-list = {"**"}Dimensiune listă de așteptare quest:{"**"} { $size }
config-desc-wait-list = O listă de așteptare permite numărului specificat de jucători să se pună la coadă pentru un quest care este plin, în cazul în care un jucător se retrage.
config-label-wait-list-disabled = {"**"}Dimensiune listă de așteptare quest:{"**"} Dezactivat

config-label-quest-summary = {"**"}Rezumat quest:{"**"} { $status }
config-desc-quest-summary = Această opțiune permite GM-ilor să furnizeze un rezumat scurt la încheierea quest-urilor.
config-label-quest-summary-disabled = {"**"}Rezumat quest:{"**"} Dezactivat

config-label-gm-rewards = Recompense GM
config-desc-gm-rewards = Configurați recompensele pe care GM-ii le primesc la finalizarea quest-urilor.

## GM Rewards View
config-title-gm-rewards = {"**"}Configurare server - Recompense GM{"**"}
config-desc-gm-rewards-detail =
    {"**"}Adaugă/Modifică recompense{"**"}
    Deschide un formular de introducere pentru a adăuga, modifica sau elimina recompensele GM.

    > Recompensele configurate sunt pe bază de quest. De fiecare dată când un Game Master finalizează un quest, va
    primi recompensele configurate mai jos pe personajul său activ.
config-msg-no-rewards = Nicio recompensă configurată.
config-label-gm-experience = {"**"}Experiență:{"**"} { $xp }
config-label-gm-items = {"**"}Obiecte:{"**"}

## Players View
config-title-players = {"**"}Configurare server - Jucători{"**"}

config-label-player-experience = {"**"}Experiență jucător:{"**"} { $status }
config-desc-player-experience = Activează/Dezactivează folosirea punctelor de experiență (sau a unei progresii bazate pe valori similare).
config-label-player-experience-disabled = {"**"}Experiență jucător:{"**"} Dezactivat

config-label-new-char-settings = {"**"}Setări personaj nou{"**"}
config-desc-new-char-settings = Configurați setările legate de personajele noi și modul în care inventarele lor inițiale sunt configurate.

config-label-player-board-purge = {"**"}Curățare panou jucători{"**"}
config-desc-player-board-purge = Curăță postările de pe panoul jucătorilor (dacă este activat).

## New Character Settings View
config-title-new-character = {"**"}Configurare server - Setări personaj nou{"**"}

config-label-inventory-type = {"**"}Tip inventar personaj nou:{"**"} { $type }
config-desc-inventory-type = Determină modul în care personajele nou-înregistrate își inițializează inventarele.
config-label-inventory-type-disabled = {"**"}Tip inventar personaj nou:{"**"} Dezactivat

config-label-new-char-wealth = {"**"}Avere personaj nou:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Avere personaj nou:{"**"} Dezactivat

config-label-approval-queue = {"**"}Coadă de aprobare:{"**"} { $channel }
config-desc-approval-queue = Dacă este setat, personajele noi trebuie aprobate de un GM în acest canal Forum înainte de a fi active.
config-label-approval-queue-disabled = {"**"}Coadă de aprobare:{"**"} Dezactivat
config-label-approval-queue-not-configured = {"**"}Coadă de aprobare:{"**"} Neconfigurat

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = Jucătorii încep cu inventare goale.
config-desc-inv-type-selection = Jucătorii aleg obiecte liber din magazinul personajului nou.
config-desc-inv-type-purchase = Jucătorii cumpără obiecte din magazinul personajului nou cu o sumă dată de monedă.
config-desc-inv-type-open = Jucătorii introduc manual obiectele din inventar.
config-desc-inv-type-static = Jucătorilor li se oferă un inventar inițial predefinit.

## New Character Shop View
config-title-new-char-shop = {"**"}Configurare server - Magazin personaj nou{"**"}
config-label-inv-type-selection = {"**"}Tip inventar:{"**"} Selecție
config-desc-inv-type-selection-shop = Jucătorii aleg obiecte liber din magazinul personajului nou.
config-label-inv-type-purchase = {"**"}Tip inventar:{"**"} Achiziție
config-desc-inv-type-purchase-shop = Jucătorii cumpără obiecte din magazinul personajului nou cu o sumă dată de monedă.
config-label-inv-type-other = {"**"}Tip inventar:{"**"} { $type }
config-desc-inv-type-not-in-use = Magazinul personajului nou nu este în uz.
config-msg-define-shop-items = Definiți obiectele magazinului.
config-msg-no-items = Niciun obiect configurat.

## Static Kits View
config-title-static-kits = {"**"}Configurare server - Kituri statice{"**"}
config-desc-create-kit = Creați o nouă definiție de kit.
config-msg-no-kits = Niciun kit configurat.
config-label-kit-more-items = ...și încă { $count } obiecte
config-label-empty-kit = {"*"}Kit gol{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}Editare kit: { $kitName }{"**"}
config-msg-kit-empty = Acest kit este gol. Folosiți butoanele de mai sus pentru a adăuga monedă sau obiecte.
config-label-kit-currency = {"**"}Monedă:{"**"} { $display }
config-label-kit-item = {"**"}Obiect:{"**"} { $name }

## Currency View
config-title-currency = {"**"}Configurare server - Monedă{"**"}
config-desc-create-currency = Creați o monedă nouă.
config-msg-no-currencies = Nicio monedă configurată.
config-label-currency-display-type = Tip afișare: { $type } | Denominații: { $count }
config-label-currency-type-double = Zecimal
config-label-currency-type-integer = Întreg

## Edit Currency View
config-title-manage-currency = {"**"}Gestionare monedă: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Monedă și denominații{"**"}__
    - Numele dat monedei dumneavoastră este considerat moneda de bază și are o valoare de 1.
    {"```"}Exemplu: „aur" este configurat ca monedă.{"```"}
    - Adăugarea unei denominații necesită specificarea unui nume și a unei valori relative la moneda de bază.
    {"```"}Exemplu: Aurul primește două denominații: argint (valoare de 0.1) și cupru (valoare de 0.01).{"```"}
    - Orice tranzacții care implică o monedă de bază sau denominațiile sale le vor converti automat.
    {"```"}Exemplu: Un jucător are 10 aur și cheltuiește 3 cupru. Noul său sold va afișa automat
    9 aur, 9 argint și 7 cupru.{"```"}
    - Monedele afișate ca întreg vor arăta fiecare denominație, în timp ce monedele afișate ca zecimal
    vor arăta doar ca moneda de bază.
    {"```"}Exemplu: Jucătorul de mai sus cu afișarea zecimală activată va fi arătat ca 9.97 aur.{"```"}
config-btn-toggle-display-current = Comută afișarea (Curent: { $type })
config-msg-no-denominations = Nicio denominație configurată.

## Shops View
config-title-shops = {"**"}Configurare server - Magazine{"**"}
config-desc-add-shop-wizard =
    {"**"}Adaugă magazin (Asistent){"**"}
    Creați un magazin nou și gol dintr-un formular.
config-desc-add-shop-json =
    {"**"}Adaugă magazin (JSON){"**"}
    Creați un magazin nou furnizând o definiție JSON completă. (Avansat)
config-btn-example-json = Exemplu JSON
config-desc-example-json =
    {"**"}Exemplu JSON{"**"}
    Descărcați un fișier JSON exemplu care arată formatul așteptat.
config-msg-example-json = Iată un fișier JSON exemplu care arată formatul așteptat.
config-msg-no-shops = Niciun magazin configurat.
config-label-shop-type-forum = (Forum)
config-label-shop-channel = Canal: <#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}Adaugă magazin - Alegeți tipul locației{"**"}
config-label-text-channel = {"**"}Canal text{"**"}
config-desc-text-channel = Creați un magazin într-un canal text standard.
config-label-forum-thread = {"**"}Fir Forum{"**"}
config-desc-forum-thread = Creați un magazin într-un fir de Forum (nou sau existent).

## Forum Shop Setup View
config-title-forum-setup = {"**"}Adaugă magazin - Configurare fir Forum{"**"}
config-label-step1 = {"**"}Pasul 1: Selectați un canal Forum{"**"}
config-label-step2 = {"**"}Pasul 2: Alegeți opțiunea firului{"**"}
config-label-step3 = {"**"}Pasul 3: Selectați un fir existent{"**"}
config-desc-create-new-thread =
    {"**"}Creează fir nou{"**"}
    Deschide un formular pentru a crea un fir nou și a configura magazinul.
config-label-selected-thread = {"**"}Fir selectat:{"**"} { $threadName }
config-desc-click-to-configure = Faceți clic pentru a configura magazinul în acest fir.

## Manage Shop View
config-title-manage-shop = {"**"}Gestionare magazin: { $shopName }{"**"}
config-label-shop-type = {"**"}Tip:{"**"} { $type }
config-label-shop-type-text = Canal text
config-label-shop-type-forum-thread = Fir Forum
config-label-shopkeeper = {"**"}Vânzător:{"**"} { $name }
config-label-shop-description = {"**"}Descriere:{"**"} { $description }
config-label-shop-channel-info = {"**"}Canal:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Editați detaliile și obiectele magazinului prin Asistent.
config-desc-upload-json = Încărcați o nouă definiție JSON pentru acest magazin.
config-desc-download-json = Descărcați definiția JSON curentă.
config-desc-remove-shop = Eliminați permanent acest magazin.

## Edit Shop View
config-title-editing-shop = {"**"}Editare magazin: { $shopName }{"**"}
config-label-shop-shopkeeper = Vânzător: {"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}Configurare stoc: { $shopName }{"**"}
config-label-current-utc = Ora UTC curentă: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Program reaprovizionare:{"**"} { $schedule }
config-label-restock-hourly = la minutul :{ $minute }
config-label-restock-daily = la { $time } UTC
config-label-restock-weekly = { $day } la { $time } UTC
config-label-restock-mode = {"**"}Mod:{"**"} { $mode }
config-label-restock-full = Reaprovizionare completă
config-label-restock-incremental = Incremental (cantități per articol)
config-label-restock-disabled = {"**"}Program reaprovizionare:{"**"} Dezactivat
config-label-item-stock-limits = {"**"}Limite de stoc obiecte{"**"}
config-msg-no-items-in-shop = Niciun obiect în acest magazin.
config-label-stock-with-available = Maxim: { $max } | Disponibil: { $available }
config-label-stock-increment = Reaprovizionare: +{ $increment }/ciclu
config-label-stock-reserved = Rezervat: { $reserved }
config-label-stock-not-initialized = Maxim: { $max } | Disponibil: (neinițializat)
config-label-stock-unlimited = Stoc: Nelimitat

## Roleplay View
config-title-roleplay = {"**"}Configurare server - Recompense roleplay{"**"}
config-label-rp-status = {"**"}Status:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Ora serverului:{"**"} `{ $time }`
config-label-rp-enabled = Activat
config-label-rp-disabled = Dezactivat

config-desc-rp-mode-scheduled = {"```"}Recompensele sunt distribuite o singură dată, la trimiterea numărului necesar de mesaje eligibile în perioada de timp setată (din oră în oră, zilnic sau săptămânal).{"```"}
config-desc-rp-mode-accrued = {"```"}Recompensele sunt distribuite în mod recurent de fiecare dată când un număr setat de mesaje eligibile este trimis.{"```"}

config-label-rp-config-details = {"**"}Detalii configurare:{"**"}
config-label-rp-mode = {"**"}Mod:{"**"} { $mode }
config-label-rp-min-length = {"**"}Lungimea minimă a mesajului:{"**"} { $length } caractere
config-label-rp-cooldown = {"**"}Pauză de așteptare:{"**"} { $seconds } secunde
config-label-rp-frequency-once = {"**"}Frecvență:{"**"} O dată per { $period }
config-label-rp-reset-time = {"**"}Ora de resetare:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Prag:{"**"} { $count } mesaje eligibile
config-label-rp-frequency-every = {"**"}Frecvență:{"**"} La fiecare { $count } mesaje eligibile

config-label-rp-channels = {"**"}Canale de roleplay:{"**"}
config-msg-rp-no-channels = Niciunul configurat.
config-label-rp-channels-more = ...și încă { $count }.

config-label-rp-rewards = {"**"}Recompense:{"**"}
config-msg-rp-no-rewards = Niciuna configurată.
config-label-rp-experience = {"**"}Experiență:{"**"} { $xp }
config-label-rp-items = {"**"}Obiecte:{"**"}
config-label-rp-currency = {"**"}Monedă:{"**"}

## Language View
config-title-language = {"**"}Configurare server - Limbă{"**"}
config-server-language-help =
    Această setare vă permite să specificați limba implicită pentru răspunsurile și mesajele {"**"}publice{"**"} ale ReQuest pe acest server. Răspunsurile publice includ:
    - Postări pe panoul de quest-uri și panoul jucătorilor
    - Rezumate quest-uri și mesaje în canalele de jurnale
    - Reaprovizionare magazine
    - Consumarea obiectelor de către jucători

    Această setare afectează doar textul static generat de bot și nu traduce conținutul dinamic, cum ar fi numele obiectelor introduse de utilizatori sau descrierile quest-urilor.

    Răspunsurile și meniurile personale nu sunt afectate de această setare.
config-label-server-language = {"**"}Limba serverului:{"**"} { $language }
config-label-server-language-default = {"**"}Limba serverului:{"**"} Implicit (fără suprascriere)
config-select-placeholder-server-language = Selectați limba serverului
config-select-option-default = Implicit (fără suprascriere)
config-select-desc-default = Folosiți preferința fiecărui utilizator sau setarea Discord.

# Quest Roles
config-btn-quest-roles = Roluri de Quest
config-btn-manage-gm-quest-roles = Gestionează

config-modal-title-confirm-quest-role-removal = Confirmă eliminarea rolului
config-modal-label-remove-quest-role = Eliminați { $roleName } de la { $gmName }?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Selectați modul rolurilor de quest
config-select-option-quest-role-disabled = Dezactivat
config-select-desc-quest-role-disabled = Nu se creează sau atribuie roluri.
config-select-option-quest-role-temporary = Temporar
config-select-desc-quest-role-temporary = GM-ii pot crea roluri temporare per quest.
config-select-option-quest-role-static = Static
config-select-desc-quest-role-static = GM-ii aleg din roluri de server pre-atribuite.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Atribuiți rol(uri) de server acestui GM

## Quest Roles View
config-title-quest-roles = {"**"}Configurare server - Roluri de Quest{"**"}
config-label-quest-roles = Roluri de Quest
config-desc-quest-roles =
    Configurați modul în care rolurile de echipă sunt gestionate în timpul quest-urilor.

config-label-quest-role-mode-disabled = {"**"}Mod roluri de quest:{"**"} Dezactivat
    Nu se creează sau atribuie roluri în timpul quest-urilor.
config-label-quest-role-mode-temporary = {"**"}Mod roluri de quest:{"**"} Temporar
    GM-ii pot crea opțional un rol temporar în timpul creării quest-ului.
    Rolul este șters când quest-ul este finalizat sau anulat.
config-label-quest-role-mode-static = {"**"}Mod roluri de quest:{"**"} Static
    GM-ii aleg din roluri de server pre-atribuite. Rolurile sunt atribuite
    membrilor echipei în timpul quest-urilor, dar nu sunt niciodată șterse.

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}Configurare server - Atribuiri roluri statice de quest{"**"}
config-label-manage-assignments = Gestionare atribuiri roluri
config-desc-manage-assignments =
    Atribuiți roluri existente de server GM-ilor pentru utilizare în timpul quest-urilor.
    Rolurile trebuie să fie mai jos decât cel mai înalt rol al ReQuest în ierarhia serverului.
config-msg-no-gm-members = Nu s-au găsit membri cu rol de GM pe acest server.
config-label-no-roles-assigned = Niciun rol de quest atribuit
config-label-more-roles = (+{ $count } în plus)

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}Gestionare roluri de quest — { $gmName }{"**"}
config-error-unmanageable-roles = Următoarele roluri nu pot fi atribuite deoarece sunt gestionate de o integrare, sunt rolul implicit sau sunt deasupra celui mai înalt rol al ReQuest: { $roles }
config-error-quest-role-limit = Acest GM a atins maximul de { $limit } roluri de quest atribuite.
config-label-quest-role-count = Roluri atribuite: { $count }/{ $limit }
