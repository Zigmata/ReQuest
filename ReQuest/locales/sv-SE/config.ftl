## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = Rensa
config-btn-remove-gm-roles = Ta bort GM-roller
config-btn-forbidden-roles = Förbjudna roller

# Quests
config-btn-toggle-quest-summary = Växla quest-sammanfattning
config-btn-toggle-player-experience = Växla spelarerfarenhet
config-btn-toggle-display = Växla visning
config-btn-purge-player-board = Rensa spelartavlan
config-btn-add-modify-rewards = Lägg till/ändra belöningar

# Currency
config-btn-add-denomination = Lägg till valör
config-btn-add-new-currency = Lägg till ny valuta
config-btn-remove-currency = Ta bort valuta

# Shops - creation
config-btn-add-shop-wizard = Lägg till butik (guide)
config-btn-add-shop-json = Lägg till butik (JSON)
config-btn-edit-shop-wizard = Redigera butik (guide)
config-btn-edit-shop-json = Redigera butik (JSON)
config-btn-remove-shop = Ta bort butik
config-btn-add-item = Lägg till föremål
config-btn-edit-shop-details = Redigera butiksdetaljer
config-btn-download-json = Ladda ner JSON
config-btn-done-editing = Klar med redigering
config-btn-scan-server-configs = Skanna serverkonfigurationer
config-btn-re-scan = Skanna igen

# New character shop
config-btn-upload-json = Ladda upp JSON
config-btn-configure-new-character-wealth = Konfigurera nykaraktärsförmögenhet
config-btn-configure-new-character-shop = Konfigurera nykaraktärsbutik
config-btn-clear-shop = Rensa butik
config-btn-configure-static-kits = Konfigurera statiska utrustningspaket
config-btn-new-character-settings = Nykaraktärsinställningar
config-btn-disabled-no-currency = Inaktiverad (ingen valuta konfigurerad)
config-btn-disabled-no-wealth = Inaktiverad (ingen startförmögenhet konfigurerad)

# Static kits
config-btn-create-new-kit = Skapa nytt utrustningspaket
config-btn-delete-kit = Radera utrustningspaket
config-btn-add-currency = Lägg till valuta

# Roleplay
config-btn-toggle-rp-rewards = Växla RP-belöningar
config-btn-clear-channels = Rensa kanaler
config-btn-edit-settings = Redigera inställningar
config-btn-configure-rewards = Konfigurera belöningar

# Stock
config-btn-stock-limits = Lagergränser
config-btn-set-limit = Ange gräns
config-btn-edit-limit = Redigera gräns
config-btn-remove-limit = Ta bort gräns
config-btn-configure-restock-schedule = Konfigurera påfyllningsschema
config-btn-back-to-shop-editor = Tillbaka till butiksredigeraren

# Forum shop
config-btn-create-new-thread = Skapa ny tråd
config-btn-use-existing-thread = Använd befintlig tråd

# Wizard
config-btn-quit = Avsluta
config-btn-configure-channels = Konfigurera kanaler
config-btn-configure-roles = Konfigurera roller
config-btn-configure-quests = Konfigurera quests
config-btn-configure-players = Konfigurera spelare
config-btn-configure-currency = Konfigurera valuta
config-btn-configure-rp-rewards = Konfigurera RP-belöningar
config-btn-configure-shops = Konfigurera butiker
config-btn-new-char-setup = Nykaraktärsinst.

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = Bekräfta borttagning av roll
config-modal-title-confirm-removal = Bekräfta borttagning
config-modal-title-confirm-currency-removal = Bekräfta borttagning av valuta
config-modal-title-confirm-shop-removal = Bekräfta borttagning av butik
config-modal-title-confirm-kit-deletion = Bekräfta radering av utrustningspaket
config-modal-title-confirm-remove-stock-limit = Bekräfta borttagning av lagergräns
config-modal-title-clear-shop = Bekräfta rensning av butik

# Confirm modal prompt labels
config-modal-label-remove-role = Ta bort { $roleName }?
config-modal-label-remove-denomination = Ta bort { $denominationName }?
config-modal-label-remove-currency = Ta bort { $currencyName }?
config-modal-label-shop-removal-warning = VARNING: Denna åtgärd är oåterkallelig!
config-modal-label-kit-deletion-warning = VARNING: Oåterkalleligt!
config-modal-label-remove-stock-limit = Skriv CONFIRM för att ta bort lagergränsen
config-modal-label-clear-shop = Rensa alla föremål från denna butik?
config-modal-placeholder-type-confirm = Skriv CONFIRM

# Error messages from buttons
config-error-shop-data-not-found = Fel: Kunde inte hitta butikens data.
config-msg-shop-json-download = Här är JSON-definitionen för {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Här är JSON-definitionen för nykaraktärsbutiken.
config-error-select-forum-first = Välj en forumkanal först.
config-error-select-thread-first = Välj en tråd först.

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Lägg till ny valuta
config-modal-label-currency-name = Valutanamn
config-error-currency-already-exists = En valuta eller valör med namnet { $name } finns redan!

# RenameCurrencyModal
config-modal-title-rename-currency = Byt namn på valuta
config-modal-label-new-currency-name = Nytt valutanamn
config-error-currency-name-exists = En valuta med namnet "{ $name }" finns redan.
config-error-denomination-name-exists = En valör med namnet "{ $name }" finns redan.

# RenameDenominationModal
config-modal-title-rename-denomination = Byt namn på valör
config-modal-label-new-denomination-name = Nytt valörnamn

# AddCurrencyDenominationModal
config-modal-title-add-denomination = Lägg till { $currencyName }-valör
config-modal-label-denomination-name = Namn
config-modal-placeholder-denomination-name = t.ex. Silver
config-modal-label-denomination-value = Värde
config-modal-placeholder-denomination-value = t.ex. 0.1
config-error-denomination-matches-currency = Nytt valörnamn kan inte matcha en befintlig valuta på denna server! Hittade befintlig valuta med namnet "{ $existingName }".
config-error-denomination-matches-denomination = Nytt valörnamn kan inte matcha en befintlig valör på denna server! Hittade befintlig valör med namnet "{ $denominationName }" under valutan "{ $currencyName }".
config-error-denomination-value-exists = Valörer under en enskild valuta måste ha unika värden! { $denominationName } har redan detta värde tilldelat.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Förbjudna rollnamn
config-modal-label-names = Namn
config-modal-placeholder-names = Ange namn separerade med kommatecken
config-msg-forbidden-roles-updated = Förbjudna roller uppdaterade!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Rensa spelartavlan
config-modal-label-age = Ålder
config-modal-placeholder-age = Ange maximal inläggsålder (i dagar) att behålla
config-msg-posts-purged = Inlägg äldre än { $days } dagar har rensats!

# GMRewardsModal
config-modal-title-gm-rewards = Lägg till/ändra GM-belöningar
config-modal-label-experience = Erfarenhet
config-modal-placeholder-enter-number = Ange ett nummer
config-modal-label-items = Föremål
config-modal-placeholder-items =
    Namn: Antal
    Namn2: Antal
    osv.
config-error-experience-invalid = Erfarenhet måste vara ett giltigt heltal (t.ex. 2000).
config-error-item-format-invalid = Ogiltigt föremålsformat: "{ $item }". Varje föremål måste vara på en ny rad, i formatet "Namn: Antal".

# ConfigShopDetailsModal
config-modal-title-shop-details = Lägg till/redigera butiksdetaljer
config-modal-label-shop-channel = Välj en kanal
config-modal-placeholder-shop-channel = Välj kanalen för denna butik
config-modal-label-shop-name = Butiksnamn
config-modal-placeholder-shop-name = Ange butikens namn
config-modal-label-shopkeeper-name = Butiksinnehavarens namn
config-modal-placeholder-shopkeeper-name = Ange butiksinnehavarens namn
config-modal-label-shop-description = Butiksbeskrivning
config-modal-placeholder-shop-description = Ange en beskrivning för butiken
config-modal-label-shop-image-url = Butiksbild-URL
config-modal-placeholder-shop-image-url = Ange en URL för butiksbilden
config-error-no-channel-selected = Ingen kanal vald för butiken.
config-error-shop-already-in-channel = En butik är redan registrerad i den valda kanalen. Välj en annan kanal eller redigera den befintliga butiken.

# build_shop_header_view
config-label-shopkeeper = {"**"}Butiksinnehavare:{"**"} { $name }
config-msg-use-shop-command = Använd kommandot `/shop` för att bläddra och köpa föremål.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Skapa forumtrådsbutik
config-modal-label-thread-name = Trådnamn
config-modal-placeholder-thread-name = Ange namnet för butikstråden
config-error-forum-not-found = Kunde inte hitta den valda forumkanalen.
config-error-shop-already-in-thread = En butik är redan registrerad i denna tråd. Detta borde inte hända för en ny tråd.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Lägg till ny butik via JSON
config-modal-label-upload-json = Ladda upp en .json-fil med butiksdata
config-error-no-json-uploaded = Ingen JSON-fil uppladdad för butiken.
config-error-file-must-be-json = Uppladdad fil måste vara en JSON-fil (.json).
config-error-invalid-json = Ogiltigt JSON-format: { $error }
config-error-json-validation-failed = JSON överensstämmer inte med schemat: { $error }

# ShopItemModal
config-modal-title-shop-item = Lägg till/redigera butiksföremål
config-modal-label-item-name = Föremålsnamn
config-modal-placeholder-item-name = Ange föremålets namn
config-modal-label-item-description = Föremålsbeskrivning
config-modal-placeholder-item-description = Ange en beskrivning för föremålet
config-modal-label-item-quantity = Föremålsantal
config-modal-placeholder-item-quantity = Ange antalet som säljs per köp
config-modal-label-item-costs = Föremålskostnad
config-modal-placeholder-item-costs = T.ex.: 10 gold + 5 silver\nELLER: 50 rep\n(Använd + för OCH, nya rader för ELLER)
config-error-item-quantity-positive = Föremålsantal måste vara ett positivt heltal.
config-error-cost-format-invalid = Ogiltigt kostnadsformat i alternativ: "{ $option }". Varje kostnad måste ha ett belopp och en valuta separerade med mellanslag, t.ex. "10 gold".
config-error-cost-amount-invalid = Ogiltigt belopp "{ $amount }" för valuta: "{ $currency }". Beloppet måste vara ett positivt tal.
config-error-unknown-currency = Okänd valuta `{ $currency }`. Använd en giltig valuta konfigurerad för denna server.
config-error-item-already-exists = Ett föremål med namnet { $itemName } finns redan i denna butik.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Uppdatera butik via JSON
config-modal-label-upload-new-json = Ladda upp ny JSON-definition
config-error-no-file-uploaded = Ingen fil uppladdad.
config-error-file-must-be-json-ext = Filen måste vara en `.json`-fil.
config-error-json-validation-message = JSON-validering misslyckades: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Lägg till/redigera nykaraktärsutrustning
config-modal-placeholder-item-quantity-selection = Ange antalet som erhålls per val
config-modal-label-item-cost = Föremålskostnad
config-error-cost-format-short = Ogiltigt kostnadsformat: '{ $component }'. Förväntat 'Belopp Valuta'.
config-error-amount-invalid-short = Ogiltigt belopp '{ $amount }' för valuta '{ $currency }'.
config-error-item-exists-new-char = Ett föremål med namnet { $itemName } finns redan i nykaraktärsbutiken.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Ladda upp nykaraktärsbutik (JSON)
config-error-no-json-uploaded-short = Ingen JSON-fil uppladdad.
config-error-json-must-have-shopstock = JSON måste innehålla en 'shopStock'-array.
config-error-items-must-have-name-price = Alla föremål måste ha 'name' och 'price'.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Ange nykaraktärsförmögenhet
config-modal-label-amount = Belopp
config-modal-placeholder-amount = Ange beloppet av denna valuta.
config-modal-placeholder-currency-name = Ange namnet på en valuta definierad på denna server
config-error-no-currencies-configured = Inga valutor är konfigurerade på denna server.
config-error-currency-not-found = Valuta eller valör med namnet { $name } hittades inte. Använd en giltig valuta.

# CreateStaticKitModal
config-modal-title-create-kit = Skapa nytt utrustningspaket
config-modal-label-kit-name = Paketnamn
config-modal-placeholder-kit-name = t.ex. Krigarens startpaket
config-modal-label-description = Beskrivning
config-modal-placeholder-kit-description = Valfri beskrivning för detta utrustningspaket
config-error-kit-name-exists = Ett utrustningspaket med namnet "{ $kitName }" finns redan. Välj ett annat namn.

# StaticKitItemModal
config-modal-title-kit-item = Lägg till/redigera paketföremål
config-modal-placeholder-kit-item-quantity = Ange antalet av detta föremål som ska ingå i paketet

# StaticKitCurrencyModal
config-modal-title-kit-currency = Lägg till paketvaluta
config-modal-placeholder-currency-eg = t.ex. Guld
config-modal-placeholder-amount-eg = t.ex. 100
config-error-amount-must-be-number = Beloppet måste vara ett tal.
config-error-no-currencies-on-server = Inga valutor konfigurerade på servern.
config-error-currency-not-found-short = Valutan "{ $currency }" hittades inte.
config-error-denomination-not-found = Valören "{ $denomination }" hittades inte i valutakonfigurationen.

# RoleplaySettingsModal
config-modal-title-rp-settings = Rollspelsinställningar
config-modal-label-min-message-length = Minsta meddelandelängd (tecken)
config-modal-placeholder-min-message-length = Antal tecken som krävs för att ett meddelande ska vara giltigt. 0 för ingen gräns
config-modal-label-cooldown = Nedkylning (sekunder)
config-modal-placeholder-cooldown = Väntetid, i sekunder, mellan att meddelanden räknas som giltiga för belöningar
config-modal-label-message-threshold = Meddelandetröskel
config-modal-placeholder-message-threshold = Antal meddelanden som krävs för att utlösa belöning
config-modal-label-frequency = Frekvens (antal meddelanden)
config-modal-placeholder-frequency = Antal giltiga meddelanden som krävs för att tjäna belöningar
config-error-min-length-invalid = Minsta meddelandelängd måste vara ett icke-negativt heltal.
config-error-cooldown-invalid = Nedkylning måste vara ett icke-negativt heltal.
config-error-threshold-invalid = Meddelandetröskel måste vara ett positivt heltal.
config-error-frequency-invalid = Frekvens måste vara ett positivt heltal.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Konfigurera rollspelsbelöningar
config-modal-label-items-name-quantity = Föremål (Namn: Antal)
config-modal-label-currency-name-amount = Valuta (Namn: Belopp)
config-error-experience-non-negative = Erfarenhet måste vara ett icke-negativt heltal.
config-error-item-quantity-positive-named = Föremålsantal för "{ $itemName }" måste vara ett positivt heltal.
config-error-currency-amount-positive = Valutabelopp för "{ $currencyName }" måste vara ett positivt tal.

# SetItemStockModal
config-modal-title-stock-limit = Lagergräns: { $itemName }
config-modal-label-max-stock = Maximalt lager
config-modal-placeholder-max-stock = Ange max lager (t.ex. 10)
config-modal-label-current-stock = Nuvarande lager
config-modal-placeholder-current-stock = Ange nuvarande tillgängligt lager
config-error-max-stock-positive = Maximalt lager måste vara ett positivt heltal.
config-error-current-stock-non-negative = Nuvarande lager måste vara ett icke-negativt heltal.
config-error-current-exceeds-max = Nuvarande lager kan inte överstiga maximalt lager.
config-error-item-not-in-shop = Föremålet "{ $itemName }" hittades inte i butiken.

# RestockScheduleModal
config-modal-title-restock-schedule = Konfigurera påfyllningsschema
config-modal-label-schedule = Schema (hourly/daily/weekly/none)
config-modal-placeholder-schedule = Ange: hourly, daily, weekly eller none
config-modal-label-time = Tid (HH:MM i UTC)
config-modal-desc-current-time = Nuvarande tid: { $utcTime }
config-modal-placeholder-time = t.ex. 14:30 för 14:30 UTC
config-modal-label-day-of-week = Veckodag (0=Mån, 6=Sön) - Endast veckovis
config-modal-placeholder-day-of-week = Ange 0-6 (Måndag=0, Söndag=6)
config-modal-label-mode = Läge (full/incremental)
config-modal-placeholder-mode = full = återställ till max, incremental = lägg till antal
config-modal-label-increment = Påfyllningsmängd (för inkrementellt läge)
config-modal-placeholder-increment = Mängd att lägga till per påfyllningscykel
config-error-schedule-invalid = Schema måste vara ett av: hourly, daily, weekly eller none.
config-error-time-format-invalid = Tid måste vara i HH:MM-format (t.ex. 14:30).
config-error-day-of-week-invalid = Veckodag måste vara 0-6 (Måndag=0, Söndag=6).
config-error-mode-invalid = Läge måste vara antingen "full" eller "incremental".
config-error-increment-positive = Påfyllningsmängd måste vara ett positivt heltal.

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Sök efter din { $configName }-kanal

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Välj din quest-aviseringsroll

# AddGMRoleSelect
config-select-placeholder-gm-roles = Välj dina GM-roll(er)

# ConfigWaitListSelect
config-select-placeholder-wait-list = Välj väntelistans storlek
config-select-option-disabled = 0 (Inaktiverad)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Välj inventarieläge
config-select-option-disabled-label = Inaktiverad
config-select-desc-disabled = Spelare börjar med tomma inventarier.
config-select-option-selection = Val
config-select-desc-selection = Spelare väljer föremål fritt från nykaraktärsbutiken.
config-select-option-purchase = Köp
config-select-desc-purchase = Spelare köper föremål från nykaraktärsbutiken med ett givet belopp valuta.
config-select-option-open = Öppen
config-select-desc-open = Spelare anger manuellt sina egna inventarier.
config-select-option-static = Statisk
config-select-desc-static = Spelare får ett fördefinierat startinventarie.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Välj giltiga kanaler

# RoleplayModeSelect
config-select-placeholder-rp-mode = Välj läge
config-select-option-scheduled = Schemalagd
config-select-desc-scheduled = Belöningar delas ut en gång inom en angiven återställningsperiod.
config-select-option-accrued = Ackumulerad
config-select-desc-accrued = Belöningar delas ut upprepade gånger baserat på angivna aktivitetsnivåer.

# RoleplayResetSelect
config-select-placeholder-reset-period = Välj återställningsperiod
config-select-option-hourly = Varje timme
config-select-desc-hourly = Återställs varje timme.
config-select-option-daily = Dagligen
config-select-desc-daily = Återställs var 24:e timme.
config-select-option-weekly = Veckovis
config-select-desc-weekly = Återställs var 7:e dag.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Välj återställningsdag

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Välj återställningstid (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Välj en forumkanal

# ForumThreadSelect
config-select-placeholder-thread = Välj en tråd
config-select-option-no-threads = Inga aktiva trådar hittades
config-select-desc-no-threads = Skapa en ny tråd eller kontrollera arkiverade trådar
config-select-option-select-forum-first = Välj ett forum först
config-select-desc-select-forum-first = Välj en forumkanal ovan
config-select-desc-thread-id = Tråd-ID: { $threadId }
config-error-select-valid-thread = Välj en giltig tråd eller skapa en ny.
config-error-thread-not-found = Kunde inte hitta den valda tråden. Den kan ha raderats eller arkiverats.

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = Serverkonfiguration - Huvudmeny
config-menu-config-wizard = Konfigurationsguide
config-menu-desc-config-wizard = Kontrollera att din server är redo att använda ReQuest med en snabb genomsökning.
config-menu-channels = Kanaler
config-menu-desc-channels = Ange dedikerade kanaler för ReQuest-inlägg.
config-menu-currency = Valuta
config-menu-desc-currency = Globala valutainställningar.
config-menu-players = Spelare
config-menu-desc-players = Globala spelarinställningar, såsom erfarenhetspoängsspårning.
config-menu-quests = Quests
config-menu-desc-quests = Globala quest-inställningar, såsom väntelistor.
config-menu-rp-rewards = RP-belöningar
config-menu-desc-rp-rewards = Konfigurera rollspelsbelöningar.
config-menu-roles = Roller
config-menu-desc-roles = Konfigurationsalternativ för pingbara eller privilegierade roller.
config-menu-shops = Butiker
config-menu-desc-shops = Konfigurera anpassade butiker.
config-menu-language = Språk
config-menu-desc-language = Ange standardspråket för denna server.

## Wizard View
config-title-wizard = {"**"}Serverkonfiguration - Guide{"**"}
config-wizard-intro =
    {"**"}Välkommen till ReQuest-konfigurationsguiden!{"**"}

    Denna guide hjälper dig att se till att din server är korrekt konfigurerad för att använda ReQuests funktioner.
    Den skannar dina nuvarande inställningar och ger rekommendationer för eventuella justeringar som behövs.

    Använd knappen "Starta skanning" nedan för att påbörja valideringsprocessen. När skanningen är klar
    får du en detaljerad rapport om din servers konfiguration samt eventuella rekommenderade ändringar.

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}Botens globala behörigheter{"**"}__
config-wizard-bot-permissions-desc = Denna sektion verifierar att ReQuest har rätt behörigheter för att fungera korrekt.
config-wizard-bot-role = Botroll: { $roleMention }
config-wizard-status-warnings = {"**"}Status: ⚠️ VARNINGAR HITTADES{"**"}
config-wizard-missing-perm = - ⚠️ Saknas: `{ $permissionName }`
config-wizard-ensure-permissions = Se till att botens högsta roll har dessa behörigheter beviljade globalt.
config-wizard-status-ok = {"**"}Status: ✅ OK{"**"}
config-wizard-bot-permissions-ok = Boten har alla nödvändiga globala behörigheter.
config-wizard-status-scan-failed = {"**"}Status: ❌ SKANNINGEN MISSLYCKADES{"**"}
config-wizard-scan-error = Ett oväntat fel uppstod vid kontroll av botens behörigheter.
config-wizard-error-type = Fel: { $errorType }
config-wizard-required-permissions = {"**"}Nödvändiga behörigheter för botens roll:{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = Visa kanaler
config-wizard-perm-manage-roles = Hantera roller
config-wizard-perm-send-messages = Skicka meddelanden
config-wizard-perm-attach-files = Bifoga filer
config-wizard-perm-add-reactions = Lägg till reaktioner
config-wizard-perm-use-external-emoji = Använd externa emojis
config-wizard-perm-manage-messages = Hantera meddelanden
config-wizard-perm-read-message-history = Läs meddelandehistorik

# Wizard - Role Validation
config-wizard-role-header = __{"**"}Rollkonfigurationer{"**"}__
config-wizard-role-desc =
    Denna sektion verifierar följande:

    - GM-roller (obligatoriska) och aviseringsroll (valfri) är konfigurerade.
    - Standardrollen (@everyone) har nödvändiga behörigheter för att användare ska kunna använda botens funktioner.
    - Standardrollen (@everyone) har inte farliga behörigheter.
    - GM- och aviseringsroller kontrolleras för eventuella behörighetseskaleringar utöver standardrollen.

    Eventuella varningar här är enbart rekommendationer baserade på en standardkonfiguration. Beroende på din servers behov kan du ha anledning att bortse från vissa av dessa rekommendationer.

config-wizard-default-role-label = {"**"}Standardroll:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Farliga behörigheter hittades:
config-wizard-default-role-ok = - ✅ @everyone: OK
config-wizard-missing-permission = - Saknad behörighet: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}GM-roller:{"**"}
config-wizard-no-gm-roles = - ⚠️ Inga GM-roller konfigurerade
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Konfigurerad roll hittades inte/raderad från servern
config-wizard-role-ok = - ✅ { $roleMention }: OK
config-wizard-announcement-role-label = {"**"}Aviseringsroll:{"**"}
config-wizard-no-announcement-role = - ℹ️ Ingen aviseringsroll konfigurerad
config-wizard-announcement-role-not-found = - ⚠️ Konfigurerad roll hittades inte/raderad från servern
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Behörighetseskaleringar upptäckta - { $escalations }
config-wizard-escalation-more = , och { $count } till...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = Skicka meddelanden i trådar
config-wizard-perm-use-application-commands = Använd applikationskommandon

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = Hantera kanaler
config-wizard-perm-manage-webhooks = Hantera webhooks
config-wizard-perm-manage-server = Hantera server
config-wizard-perm-manage-nicknames = Hantera smeknamn
config-wizard-perm-kick-members = Sparka medlemmar
config-wizard-perm-ban-members = Banna medlemmar
config-wizard-perm-timeout-members = Tysta medlemmar
config-wizard-perm-mention-everyone = Nämn @everyone
config-wizard-perm-manage-threads = Hantera trådar
config-wizard-perm-administrator = Administratör

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}Kanalkonfigurationer{"**"}__
config-wizard-channel-desc =
    Denna sektion verifierar följande:

    - Konfigurerade kanaler existerar.
    - Boten har behörighet att visa och skicka meddelanden i de konfigurerade kanalerna.
    - Standardrollen (@everyone) har inte behörigheten `Skicka meddelanden`.

config-wizard-channel-no-config-required = - ⚠️ Ingen kanal konfigurerad
config-wizard-channel-not-configured = - ℹ️ Inte konfigurerad (valfri)
config-wizard-channel-not-found = - ⚠️ Konfigurerad kanal hittades inte/raderad från servern
config-wizard-channel-ok = - ✅ OK
config-wizard-bot-cannot-view = - ⚠️ { $botMention } kan inte visa denna kanal.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } kan inte skicka meddelanden i denna kanal.
config-wizard-everyone-can-send = - ⚠️ @everyone kan skicka meddelanden i denna kanal.

# Wizard - Channel names
config-wizard-channel-quest-board = Quest-tavla
config-wizard-channel-player-board = Spelartavla
config-wizard-channel-quest-archive = Quest-arkiv
config-wizard-channel-gm-transaction-log = GM-transaktionslogg
config-wizard-channel-player-transaction-log = Spelartransaktionslogg
config-wizard-channel-shop-log = Butikslogg
config-wizard-channel-approval-queue = Karaktärsgodkännandekö

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}Inställningsöversikt{"**"}__
config-wizard-dashboard-desc = Denna sektion ger en översikt över icke-nödvändiga konfigurationer för snabb referens.
config-wizard-quest-settings = {"**"}Quest-inställningar{"**"}
config-wizard-quest-wait-list = - Quest-väntelista: { $size }
config-wizard-quest-summary = - Quest-sammanfattning: { $status }
config-wizard-gm-rewards-per-quest = {"**"}GM-belöningar (per quest){"**"}
config-wizard-player-settings = {"**"}Spelarinställningar{"**"}
config-wizard-player-experience = - Spelarerfarenhet: { $status }
config-wizard-currency-settings = {"**"}Valutainställningar{"**"}
config-wizard-rp-rewards = {"**"}Rollspelsbelöningar{"**"}
config-wizard-rp-status = - Status: { $status }
config-wizard-rp-mode = - Läge: { $mode }
config-wizard-rp-channels = - Övervakade kanaler: { $count }
config-wizard-shops = {"**"}Butiker{"**"}
config-wizard-shops-count = - Konfigurerade butiker: { $count }
config-wizard-shops-more = - ...och { $count } till
config-wizard-new-char-setup = {"**"}Nykaraktärsinställningar{"**"}
config-wizard-inventory-type = - Inventarietyp: { $type }
config-wizard-new-char-shop-items = - Nykaraktärsbutiksföremål: { $count }
config-wizard-static-kits = - Statiska utrustningspaket: { $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ Inga valutor konfigurerade
config-wizard-configured-currencies = {"**"}Konfigurerade valutor:{"**"}
config-wizard-no-denominations = - Inga valörer konfigurerade
config-wizard-gm-rewards-disabled = {"**"}Status:{"**"} Inaktiverad
config-wizard-gm-rewards-enabled = {"**"}Status:{"**"} Aktiverad
config-wizard-gm-rewards-experience = - Erfarenhet: { $xp }
config-wizard-gm-rewards-items = - Föremål:
config-wizard-unnamed-shop = Namnlös butik

## Roles View
config-title-roles = {"**"}Serverkonfiguration - Roller{"**"}
config-label-announcement-role = {"**"}Aviseringsroll:{"**"} { $status }
config-desc-announcement-role = Denna roll nämns när en quest publiceras.
config-label-announcement-role-default = {"**"}Aviseringsroll:{"**"} Inte konfigurerad
config-label-gm-roles = {"**"}GM-roll(er):{"**"} { $roles }
config-desc-gm-roles = Dessa roller ger åtkomst till GM-kommandon och funktioner.
config-label-gm-roles-default = {"**"}GM-roll(er):{"**"} Inte konfigurerad
config-title-forbidden-roles = __{"**"}Förbjudna roller{"**"}__
config-desc-forbidden-roles =
    Konfigurerar en lista med rollnamn som inte kan användas av GM:ar för sina gruppoller.
    Som standard kan `everyone`, `administrator`, `gm` och `game master` inte användas. Denna konfiguration
    utökar den listan.

## GM Role Remove View
config-title-remove-gm-roles = {"**"}Serverkonfiguration - Ta bort GM-roll(er){"**"}
config-msg-no-gm-roles = Inga GM-roller konfigurerade.

## Channels View
config-title-channels = {"**"}Serverkonfiguration - Kanaler{"**"}

config-label-quest-board = {"**"}Quest-tavla:{"**"} { $channel }
config-desc-quest-board = Kanalen där nya/aktiva quests publiceras.
config-label-quest-board-default = {"**"}Quest-tavla:{"**"} Inte konfigurerad

config-label-player-board = {"**"}Spelartavla:{"**"} { $channel }
config-desc-player-board = En valfri aviserings-/anslagstavla för spelare.
config-label-player-board-default = {"**"}Spelartavla:{"**"} Inte konfigurerad

config-label-quest-archive = {"**"}Quest-arkiv:{"**"} { $channel }
config-desc-quest-archive = En valfri kanal dit avslutade quests flyttas, med sammanfattningsinformation.
config-label-quest-archive-default = {"**"}Quest-arkiv:{"**"} Inte konfigurerad

config-label-gm-transaction-log = {"**"}GM-transaktionslogg:{"**"} { $channel }
config-desc-gm-transaction-log = En valfri kanal där GM-transaktioner (dvs. Ändra spelare-kommandon) loggas.
config-label-gm-transaction-log-default = {"**"}GM-transaktionslogg:{"**"} Inte konfigurerad

config-label-player-transaction-log = {"**"}Spelartransaktionslogg:{"**"} { $channel }
config-desc-player-transaction-log = En valfri kanal där spelartransaktioner som byte och konsumtion av föremål loggas.
config-label-player-transaction-log-default = {"**"}Spelartransaktionslogg:{"**"} Inte konfigurerad

config-label-shop-log = {"**"}Butikslogg:{"**"} { $channel }
config-desc-shop-log = En valfri kanal där butikstransaktioner loggas.
config-label-shop-log-default = {"**"}Butikslogg:{"**"} Inte konfigurerad

## Quests View
config-title-quests = {"**"}Serverkonfiguration - Quests{"**"}

config-label-wait-list = {"**"}Quest-väntelistans storlek:{"**"} { $size }
config-desc-wait-list = En väntelista tillåter det angivna antalet spelare att köa till en quest som är full, ifall en spelare hoppar av.
config-label-wait-list-disabled = {"**"}Quest-väntelistans storlek:{"**"} Inaktiverad

config-label-quest-summary = {"**"}Quest-sammanfattning:{"**"} { $status }
config-desc-quest-summary = Detta alternativ möjliggör för GM:ar att ge en kort sammanfattning vid avslutning av quests.
config-label-quest-summary-disabled = {"**"}Quest-sammanfattning:{"**"} Inaktiverad

config-label-gm-rewards = GM-belöningar
config-desc-gm-rewards = Konfigurera belöningar som GM:ar får vid avslutade quests.

## GM Rewards View
config-title-gm-rewards = {"**"}Serverkonfiguration - GM-belöningar{"**"}
config-desc-gm-rewards-detail =
    {"**"}Lägg till/ändra belöningar{"**"}
    Öppnar ett inmatningsfönster för att lägga till, ändra eller ta bort GM-belöningar.

    > Belöningar som konfigureras gäller per quest. Varje gång en GM avslutar en quest
    får de belöningarna konfigurerade nedan på sin aktiva karaktär.
config-msg-no-rewards = Inga belöningar konfigurerade.
config-label-gm-experience = {"**"}Erfarenhet:{"**"} { $xp }
config-label-gm-items = {"**"}Föremål:{"**"}

## Players View
config-title-players = {"**"}Serverkonfiguration - Spelare{"**"}

config-label-player-experience = {"**"}Spelarerfarenhet:{"**"} { $status }
config-desc-player-experience = Aktiverar/inaktiverar användning av erfarenhetspoäng (eller liknande värdebaserad karaktärsutveckling).
config-label-player-experience-disabled = {"**"}Spelarerfarenhet:{"**"} Inaktiverad

config-label-new-char-settings = {"**"}Nykaraktärsinställningar{"**"}
config-desc-new-char-settings = Konfigurera inställningar relaterade till nya spelarkaraktärer och hur deras startinventarier sätts upp.

config-label-player-board-purge = {"**"}Rensning av spelartavla{"**"}
config-desc-player-board-purge = Rensar inlägg från spelartavlan (om aktiverad).

## New Character Settings View
config-title-new-character = {"**"}Serverkonfiguration - Nykaraktärsinställningar{"**"}

config-label-inventory-type = {"**"}Nykaraktärsinventarietyp:{"**"} { $type }
config-desc-inventory-type = Bestämmer hur nyregistrerade karaktärer initialiserar sina inventarier.
config-label-inventory-type-disabled = {"**"}Nykaraktärsinventarietyp:{"**"} Inaktiverad

config-label-new-char-wealth = {"**"}Nykaraktärsförmögenhet:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Nykaraktärsförmögenhet:{"**"} Inaktiverad

config-label-approval-queue = {"**"}Godkännandekö:{"**"} { $channel }
config-desc-approval-queue = Om inställd måste nya karaktärer godkännas av en GM i denna Forum-kanal innan de aktiveras.
config-label-approval-queue-disabled = {"**"}Godkännandekö:{"**"} Inaktiverad
config-label-approval-queue-not-configured = {"**"}Godkännandekö:{"**"} Inte konfigurerad

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = Spelare börjar med tomma inventarier.
config-desc-inv-type-selection = Spelare väljer föremål fritt från nykaraktärsbutiken.
config-desc-inv-type-purchase = Spelare köper föremål från nykaraktärsbutiken med ett givet belopp valuta.
config-desc-inv-type-open = Spelare anger manuellt sina inventarieföremål.
config-desc-inv-type-static = Spelare får ett fördefinierat startinventarie.

## New Character Shop View
config-title-new-char-shop = {"**"}Serverkonfiguration - Nykaraktärsbutik{"**"}
config-label-inv-type-selection = {"**"}Inventarietyp:{"**"} Val
config-desc-inv-type-selection-shop = Spelare väljer föremål fritt från nykaraktärsbutiken.
config-label-inv-type-purchase = {"**"}Inventarietyp:{"**"} Köp
config-desc-inv-type-purchase-shop = Spelare köper föremål från nykaraktärsbutiken med ett givet belopp valuta.
config-label-inv-type-other = {"**"}Inventarietyp:{"**"} { $type }
config-desc-inv-type-not-in-use = Nykaraktärsbutiken används inte.
config-msg-define-shop-items = Definiera butiksföremålen.
config-msg-no-items = Inga föremål konfigurerade.

## Static Kits View
config-title-static-kits = {"**"}Serverkonfiguration - Statiska utrustningspaket{"**"}
config-desc-create-kit = Skapa en ny paketdefinition.
config-msg-no-kits = Inga utrustningspaket konfigurerade.
config-label-kit-more-items = ...och { $count } föremål till
config-label-empty-kit = {"*"}Tomt utrustningspaket{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}Redigerar utrustningspaket: { $kitName }{"**"}
config-msg-kit-empty = Detta utrustningspaket är tomt. Använd knapparna ovan för att lägga till valuta eller föremål.
config-label-kit-currency = {"**"}Valuta:{"**"} { $display }
config-label-kit-item = {"**"}Föremål:{"**"} { $name }

## Currency View
config-title-currency = {"**"}Serverkonfiguration - Valuta{"**"}
config-desc-create-currency = Skapa en ny valuta.
config-msg-no-currencies = Inga valutor konfigurerade.
config-label-currency-display-type = Visningstyp: { $type } | Valörer: { $count }
config-label-currency-type-double = Decimal
config-label-currency-type-integer = Heltal

## Edit Currency View
config-title-manage-currency = {"**"}Hantera valuta: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Valuta och valörer{"**"}__
    - Det givna namnet på din valuta betraktas som basvalutan och har ett värde av 1.
    {"```"}Exempel: "guld" är konfigurerat som en valuta.{"```"}
    - Att lägga till en valör kräver att man anger ett namn och ett värde relativt basvalutan.
    {"```"}Exempel: Guld ges två valörer: silver (värde 0.1) och koppar (värde 0.01).{"```"}
    - Alla transaktioner som involverar en basvaluta eller dess valörer konverteras automatiskt.
    {"```"}Exempel: En spelare har 10 guld och spenderar 3 koppar. Deras nya saldo visas automatiskt som
    9 guld, 9 silver och 7 koppar.{"```"}
    - Valutor som visas som heltal visar varje valör, medan valutor som visas som decimal
    bara visas som basvalutan.
    {"```"}Exempel: Spelaren ovan med decimalvisning aktiverad visas som 9.97 guld.{"```"}
config-btn-toggle-display-current = Växla visning (nuvarande: { $type })
config-msg-no-denominations = Inga valörer konfigurerade.

## Shops View
config-title-shops = {"**"}Serverkonfiguration - Butiker{"**"}
config-desc-add-shop-wizard =
    {"**"}Lägg till butik (guide){"**"}
    Skapa en ny, tom butik från ett formulär.
config-desc-add-shop-json =
    {"**"}Lägg till butik (JSON){"**"}
    Skapa en ny butik genom att tillhandahålla en fullständig JSON-definition. (Avancerat)
config-btn-example-json = Exempel JSON
config-desc-example-json =
    {"**"}Exempel JSON{"**"}
    Ladda ner en exempel-JSON-fil som visar det förväntade formatet.
config-msg-example-json = Här är en exempel-JSON-fil som visar det förväntade formatet.
config-msg-no-shops = Inga butiker konfigurerade.
config-label-shop-type-forum = (Forum)
config-label-shop-channel = Kanal: <#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}Lägg till butik - Välj platstyp{"**"}
config-label-text-channel = {"**"}Textkanal{"**"}
config-desc-text-channel = Skapa en butik i en vanlig textkanal.
config-label-forum-thread = {"**"}Forumtråd{"**"}
config-desc-forum-thread = Skapa en butik i en forumtråd (ny eller befintlig).

## Forum Shop Setup View
config-title-forum-setup = {"**"}Lägg till butik - Forumtrådsinställning{"**"}
config-label-step1 = {"**"}Steg 1: Välj en forumkanal{"**"}
config-label-step2 = {"**"}Steg 2: Välj trådalternativ{"**"}
config-label-step3 = {"**"}Steg 3: Välj en befintlig tråd{"**"}
config-desc-create-new-thread =
    {"**"}Skapa ny tråd{"**"}
    Öppnar ett formulär för att skapa en ny tråd och konfigurera butiken.
config-label-selected-thread = {"**"}Vald tråd:{"**"} { $threadName }
config-desc-click-to-configure = Klicka för att konfigurera butiken i denna tråd.

## Manage Shop View
config-title-manage-shop = {"**"}Hantera butik: { $shopName }{"**"}
config-label-shop-type = {"**"}Typ:{"**"} { $type }
config-label-shop-type-text = Textkanal
config-label-shop-type-forum-thread = Forumtråd
config-label-shopkeeper = {"**"}Butiksinnehavare:{"**"} { $name }
config-label-shop-description = {"**"}Beskrivning:{"**"} { $description }
config-label-shop-channel-info = {"**"}Kanal:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Redigera butiksdetaljer och föremål via guiden.
config-desc-upload-json = Ladda upp en ny JSON-definition för denna butik.
config-desc-download-json = Ladda ner den aktuella JSON-definitionen.
config-desc-remove-shop = Ta bort denna butik permanent.

## Edit Shop View
config-title-editing-shop = {"**"}Redigerar butik: { $shopName }{"**"}
config-label-shop-shopkeeper = Butiksinnehavare: {"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}Lagerkonfiguration: { $shopName }{"**"}
config-label-current-utc = Nuvarande UTC-tid: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Påfyllningsschema:{"**"} { $schedule }
config-label-restock-hourly = vid minut :{ $minute }
config-label-restock-daily = klockan { $time } UTC
config-label-restock-weekly = på { $day } klockan { $time } UTC
config-label-restock-mode = {"**"}Läge:{"**"} { $mode }
config-label-restock-full = Full påfyllning
config-label-restock-incremental = Lägg till { $amount } per cykel (upp till max)
config-label-restock-disabled = {"**"}Påfyllningsschema:{"**"} Inaktiverat
config-label-item-stock-limits = {"**"}Lagergränser för föremål{"**"}
config-msg-no-items-in-shop = Inga föremål i denna butik.
config-label-stock-with-available = Max: { $max } | Tillgängligt: { $available }
config-label-stock-reserved = | Reserverat: { $reserved }
config-label-stock-not-initialized = Max: { $max } | Tillgängligt: (ej initialiserat)
config-label-stock-unlimited = Lager: Obegränsat

## Roleplay View
config-title-roleplay = {"**"}Serverkonfiguration - Rollspelsbelöningar{"**"}
config-label-rp-status = {"**"}Status:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Servertid:{"**"} `{ $time }`
config-label-rp-enabled = Aktiverad
config-label-rp-disabled = Inaktiverad

config-desc-rp-mode-scheduled = {"```"}Belöningar delas ut en gång, vid sändning av det erforderliga antalet giltiga meddelanden inom den angivna tidsperioden (varje timme, dagligen eller veckovis).{"```"}
config-desc-rp-mode-accrued = {"```"}Belöningar delas ut löpande varje gång ett angivet antal giltiga meddelanden skickas.{"```"}

config-label-rp-config-details = {"**"}Konfigurationsdetaljer:{"**"}
config-label-rp-mode = {"**"}Läge:{"**"} { $mode }
config-label-rp-min-length = {"**"}Minsta meddelandelängd:{"**"} { $length } tecken
config-label-rp-cooldown = {"**"}Nedkylning:{"**"} { $seconds } sekunder
config-label-rp-frequency-once = {"**"}Frekvens:{"**"} En gång per { $period }
config-label-rp-reset-time = {"**"}Återställningstid:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Tröskel:{"**"} { $count } giltiga meddelanden
config-label-rp-frequency-every = {"**"}Frekvens:{"**"} Var { $count }:e giltiga meddelande

config-label-rp-channels = {"**"}Rollspelskanaler:{"**"}
config-msg-rp-no-channels = Inga konfigurerade.
config-label-rp-channels-more = ...och { $count } till.

config-label-rp-rewards = {"**"}Belöningar:{"**"}
config-msg-rp-no-rewards = Inga konfigurerade.
config-label-rp-experience = {"**"}Erfarenhet:{"**"} { $xp }
config-label-rp-items = {"**"}Föremål:{"**"}
config-label-rp-currency = {"**"}Valuta:{"**"}

## Language View
config-title-language = {"**"}Serverkonfiguration - Språk{"**"}
config-server-language-help =
    Denna inställning låter dig ange standardspråket för ReQuests {"**"}offentliga{"**"} svar och meddelanden på denna server. Offentliga svar inkluderar:
    - Quest- och spelartavleinlägg
    - Quest-sammanfattning och loggkanalmeddelanden
    - Butikspåfyllning
    - Spelares föremålskonsumtion

    Denna inställning påverkar bara statisk text som genereras av boten, och översätter inte dynamiskt innehåll såsom användarinmatade föremålsnamn eller quest-beskrivningar.

    Personliga svar och menyer påverkas inte av denna inställning.
config-label-server-language = {"**"}Serverspråk:{"**"} { $language }
config-label-server-language-default = {"**"}Serverspråk:{"**"} Standard (ingen åsidosättning)
config-select-placeholder-server-language = Välj serverspråk
config-select-option-default = Standard (ingen åsidosättning)
config-select-desc-default = Använd varje användares inställning eller Discord-språk.

# Quest Roles
config-btn-quest-roles = Quest-roller
config-btn-manage-gm-quest-roles = Hantera

config-modal-title-confirm-quest-role-removal = Bekräfta rollborttagning
config-modal-label-remove-quest-role = Ta bort { $roleName } från { $gmName }?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Välj quest-rollläge
config-select-option-quest-role-disabled = Inaktiverat
config-select-desc-quest-role-disabled = Inga roller skapas eller tilldelas.
config-select-option-quest-role-temporary = Tillfällig
config-select-desc-quest-role-temporary = GM:ar kan skapa tillfälliga roller per quest.
config-select-option-quest-role-static = Statisk
config-select-desc-quest-role-static = GM:ar väljer från förtilldelade serverroller.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Tilldela serverroll(er) till denna GM

## Quest Roles View
config-title-quest-roles = {"**"}Serverkonfiguration - Quest-roller{"**"}
config-label-quest-roles = Quest-roller
config-desc-quest-roles =
    Konfigurera hur grupproller hanteras under quests.

config-label-quest-role-mode-disabled = {"**"}Quest-rollläge:{"**"} Inaktiverat
    Inga roller skapas eller tilldelas under quests.
config-label-quest-role-mode-temporary = {"**"}Quest-rollläge:{"**"} Tillfällig
    GM:ar kan valfritt skapa en tillfällig roll vid quest-skapande.
    Rollen raderas när questen avslutas eller avbryts.
config-label-quest-role-mode-static = {"**"}Quest-rollläge:{"**"} Statisk
    GM:ar väljer från förtilldelade serverroller. Roller tilldelas
    gruppmedlemmar under quests men raderas aldrig.

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}Serverkonfiguration - Statiska quest-rolltilldelningar{"**"}
config-label-manage-assignments = Hantera rolltilldelningar
config-desc-manage-assignments =
    Tilldela befintliga serverroller till GM:ar för användning under quests.
    Roller måste vara lägre än ReQuests högsta roll i serverhierarkin.
config-msg-no-gm-members = Inga medlemmar med en GM-roll hittades på denna server.
config-label-no-roles-assigned = Inga quest-roller tilldelade

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}Hantera quest-roller — { $gmName }{"**"}
config-error-unmanageable-roles = Följande roller kan inte tilldelas eftersom de hanteras av en integration, är standardrollen eller är ovanför ReQuests högsta roll: { $roles }
config-error-quest-role-limit = Denna GM har nått maxgränsen på { $limit } tilldelade quest-roller.
config-label-quest-role-count = Tilldelade roller: { $count }/{ $limit }
