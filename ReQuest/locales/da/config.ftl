## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = Ryd
config-btn-remove-gm-roles = Fjern GM-roller
config-btn-forbidden-roles = Forbudte roller

# Quests
config-btn-toggle-quest-summary = Skift quest-resumé
config-btn-toggle-player-experience = Skift spillererfaring
config-btn-toggle-display = Skift visning
config-btn-purge-player-board = Ryd spillertavlen
config-btn-add-modify-rewards = Tilføj/Rediger belønninger

# Currency
config-btn-add-denomination = Tilføj denomination
config-btn-add-new-currency = Tilføj ny valuta
config-btn-remove-currency = Fjern valuta

# Shops - creation
config-btn-add-shop-wizard = Tilføj butik (guide)
config-btn-add-shop-json = Tilføj butik (JSON)
config-btn-edit-shop-wizard = Rediger butik (guide)
config-btn-edit-shop-json = Rediger butik (JSON)
config-btn-remove-shop = Fjern butik
config-btn-add-item = Tilføj genstand
config-btn-edit-shop-details = Rediger butiksdetaljer
config-btn-download-json = Download JSON
config-btn-done-editing = Færdig med redigering
config-btn-scan-server-configs = Scan serverkonfigurationer
config-btn-re-scan = Scan igen

# New character shop
config-btn-upload-json = Upload JSON
config-btn-configure-new-character-wealth = Konfigurer ny karakters formue
config-btn-configure-new-character-shop = Konfigurer ny karakters butik
config-btn-configure-static-kits = Konfigurer statiske pakker
config-btn-new-character-settings = Nye karakterindstillinger
config-btn-disabled-no-currency = Deaktiveret (ingen valuta konfigureret)
config-btn-disabled-no-wealth = Deaktiveret (ingen startformue konfigureret)

# Static kits
config-btn-create-new-kit = Opret ny pakke
config-btn-delete-kit = Slet pakke
config-btn-add-currency = Tilføj valuta

# Roleplay
config-btn-toggle-rp-rewards = Skift RP-belønninger
config-btn-clear-channels = Ryd kanaler
config-btn-edit-settings = Rediger indstillinger
config-btn-configure-rewards = Konfigurer belønninger

# Stock
config-btn-stock-limits = Lagergrænser
config-btn-set-limit = Sæt grænse
config-btn-edit-limit = Rediger grænse
config-btn-remove-limit = Fjern grænse
config-btn-configure-restock-schedule = Konfigurer genopfyldningsplan
config-btn-back-to-shop-editor = Tilbage til butiksredigering

# Forum shop
config-btn-create-new-thread = Opret ny tråd
config-btn-use-existing-thread = Brug eksisterende tråd

# Wizard
config-btn-quit = Afslut
config-btn-configure-channels = Konfigurer kanaler
config-btn-configure-roles = Konfigurer roller
config-btn-configure-quests = Konfigurer quests
config-btn-configure-players = Konfigurer spillere
config-btn-configure-currency = Konfigurer valuta
config-btn-configure-rp-rewards = Konfigurer RP-belønninger
config-btn-configure-shops = Konfigurer butikker
config-btn-new-char-setup = Ny karakter-opsætning

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = Bekræft rollefjernelse
config-modal-title-confirm-removal = Bekræft fjernelse
config-modal-title-confirm-currency-removal = Bekræft valutafjernelse
config-modal-title-confirm-shop-removal = Bekræft butiksfjernelse
config-modal-title-confirm-kit-deletion = Bekræft pakkesletning
config-modal-title-confirm-remove-stock-limit = Bekræft fjernelse af lagergrænse

# Confirm modal prompt labels
config-modal-label-remove-role = Fjern { $roleName }?
config-modal-label-remove-denomination = Fjern { $denominationName }?
config-modal-label-remove-currency = Fjern { $currencyName }?
config-modal-label-shop-removal-warning = ADVARSEL: Denne handling er irreversibel!
config-modal-label-kit-deletion-warning = ADVARSEL: Irreversibelt!
config-modal-label-remove-stock-limit = Skriv CONFIRM for at fjerne lagergrænsen
config-modal-placeholder-type-confirm = Skriv CONFIRM

# Error messages from buttons
config-error-shop-data-not-found = Fejl: Kunne ikke finde den butiks data.
config-msg-shop-json-download = Her er JSON-definitionen for {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Her er JSON-definitionen for den nye karakterbutik.
config-error-select-forum-first = Vælg venligst en forumkanal først.
config-error-select-thread-first = Vælg venligst en tråd først.

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Tilføj ny valuta
config-modal-label-currency-name = Valutanavn
config-error-currency-already-exists = En valuta eller denomination med navnet { $name } findes allerede!

# RenameCurrencyModal
config-modal-title-rename-currency = Omdøb valuta
config-modal-label-new-currency-name = Nyt valutanavn
config-error-currency-name-exists = En valuta med navnet "{ $name }" findes allerede.
config-error-denomination-name-exists = En denomination med navnet "{ $name }" findes allerede.

# RenameDenominationModal
config-modal-title-rename-denomination = Omdøb denomination
config-modal-label-new-denomination-name = Nyt denominationsnavn

# AddCurrencyDenominationModal
config-modal-title-add-denomination = Tilføj { $currencyName }-denomination
config-modal-label-denomination-name = Navn
config-modal-placeholder-denomination-name = f.eks., Sølv
config-modal-label-denomination-value = Værdi
config-modal-placeholder-denomination-value = f.eks., 0.1
config-error-denomination-matches-currency = Nyt denominationsnavn kan ikke matche en eksisterende valuta på denne server! Fandt eksisterende valuta med navnet "{ $existingName }".
config-error-denomination-matches-denomination = Nyt denominationsnavn kan ikke matche en eksisterende denomination på denne server! Fandt eksisterende denomination med navnet "{ $denominationName }" under valutaen "{ $currencyName }".
config-error-denomination-value-exists = Denominationer under en enkelt valuta skal have unikke værdier! { $denominationName } har allerede denne værdi tildelt.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Forbudte rollenavne
config-modal-label-names = Navne
config-modal-placeholder-names = Indtast navne adskilt med kommaer
config-msg-forbidden-roles-updated = Forbudte roller opdateret!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Ryd spillertavlen
config-modal-label-age = Alder
config-modal-placeholder-age = Indtast den maksimale postalder (i dage) der skal beholdes
config-msg-posts-purged = Opslag ældre end { $days } dage er blevet slettet!

# GMRewardsModal
config-modal-title-gm-rewards = Tilføj/Rediger GM-belønninger
config-modal-label-experience = Erfaring
config-modal-placeholder-enter-number = Indtast et tal
config-modal-label-items = Genstande
config-modal-placeholder-items =
    Navn: Antal
    Navn2: Antal
    osv.
config-error-experience-invalid = Erfaring skal være et gyldigt heltal (f.eks. 2000).
config-error-item-format-invalid = Ugyldigt genstandsformat: "{ $item }". Hver genstand skal være på en ny linje i formatet "Navn: Antal".

# ConfigShopDetailsModal
config-modal-title-shop-details = Tilføj/Rediger butiksdetaljer
config-modal-label-shop-channel = Vælg en kanal
config-modal-placeholder-shop-channel = Vælg kanalen til denne butik
config-modal-label-shop-name = Butiksnavn
config-modal-placeholder-shop-name = Indtast navnet på butikken
config-modal-label-shopkeeper-name = Butiksindehaverens navn
config-modal-placeholder-shopkeeper-name = Indtast butiksindehaverens navn
config-modal-label-shop-description = Butiksbeskrivelse
config-modal-placeholder-shop-description = Indtast en beskrivelse af butikken
config-modal-label-shop-image-url = Butiksbillede-URL
config-modal-placeholder-shop-image-url = Indtast en URL til butiksbilledet
config-error-no-channel-selected = Ingen kanal valgt til butikken.
config-error-shop-already-in-channel = Der er allerede en butik registreret i den valgte kanal. Vælg venligst en anden kanal eller rediger den eksisterende butik.

# build_shop_header_view
config-label-shopkeeper = {"**"}Butiksindehaver:{"**"} { $name }
config-msg-use-shop-command = Brug kommandoen `/shop` til at gennemse og købe genstande.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Opret Forum-tråd-butik
config-modal-label-thread-name = Trådnavn
config-modal-placeholder-thread-name = Indtast navnet på butikstråden
config-error-forum-not-found = Kunne ikke finde den valgte forumkanal.
config-error-shop-already-in-thread = Der er allerede en butik registreret i denne tråd. Dette burde ikke ske for en ny tråd.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Tilføj ny butik via JSON
config-modal-label-upload-json = Upload en .json-fil med butiksdata
config-error-no-json-uploaded = Ingen JSON-fil uploadet til butikken.
config-error-file-must-be-json = Den uploadede fil skal være en JSON-fil (.json).
config-error-invalid-json = Ugyldigt JSON-format: { $error }
config-error-json-validation-failed = JSON overholder ikke skemaet: { $error }

# ShopItemModal
config-modal-title-shop-item = Tilføj/Rediger butiksgenstand
config-modal-label-item-name = Genstandsnavn
config-modal-placeholder-item-name = Indtast genstandens navn
config-modal-label-item-description = Genstandsbeskrivelse
config-modal-placeholder-item-description = Indtast en beskrivelse af genstanden
config-modal-label-item-quantity = Genstandsantal
config-modal-placeholder-item-quantity = Indtast antal der sælges per køb
config-modal-label-item-costs = Genstandsomkostninger
config-modal-placeholder-item-costs = F.eks.: 10 guld + 5 sølv\nELLER: 50 ry\n(Brug + for OG, nye linjer for ELLER)
config-error-item-quantity-positive = Genstandsantal skal være et positivt heltal.
config-error-cost-format-invalid = Ugyldigt omkostningsformat i mulighed: "{ $option }". Hver omkostning skal have et beløb og en valuta adskilt af et mellemrum, f.eks. "10 guld".
config-error-cost-amount-invalid = Ugyldigt beløb "{ $amount }" for valuta: "{ $currency }". Beløb skal være et positivt tal.
config-error-unknown-currency = Ukendt valuta `{ $currency }`. Brug venligst en gyldig valuta konfigureret for denne server.
config-error-item-already-exists = En genstand med navnet { $itemName } findes allerede i denne butik.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Opdater butik via JSON
config-modal-label-upload-new-json = Upload ny JSON-definition
config-error-no-file-uploaded = Ingen fil blev uploadet.
config-error-file-must-be-json-ext = Filen skal være en `.json`-fil.
config-error-json-validation-message = JSON-validering mislykkedes: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Tilføj/Rediger ny karakter-udstyr
config-modal-placeholder-item-quantity-selection = Indtast antal modtaget per valg
config-modal-label-item-cost = Genstandsomkostning
config-error-cost-format-short = Ugyldigt omkostningsformat: '{ $component }'. Forventet 'Beløb Valuta'.
config-error-amount-invalid-short = Ugyldigt beløb '{ $amount }' for valuta '{ $currency }'.
config-error-item-exists-new-char = En genstand med navnet { $itemName } findes allerede i den nye karakterbutik.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Upload ny karakterbutik (JSON)
config-error-no-json-uploaded-short = Ingen JSON-fil uploadet.
config-error-json-must-have-shopstock = JSON skal indeholde et 'shopStock'-array.
config-error-items-must-have-name-price = Alle genstande skal have 'name' og 'price'.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Indstil ny karakters formue
config-modal-label-amount = Beløb
config-modal-placeholder-amount = Indtast beløbet for denne valuta.
config-modal-placeholder-currency-name = Indtast navnet på en valuta defineret på denne server
config-error-no-currencies-configured = Ingen valutaer er konfigureret på denne server.
config-error-currency-not-found = Valuta eller denomination med navnet { $name } blev ikke fundet. Brug venligst en gyldig valuta.

# CreateStaticKitModal
config-modal-title-create-kit = Opret ny statisk pakke
config-modal-label-kit-name = Pakkenavn
config-modal-placeholder-kit-name = f.eks., Kriger-startpakke
config-modal-label-description = Beskrivelse
config-modal-placeholder-kit-description = Valgfri beskrivelse af denne pakke
config-error-kit-name-exists = En statisk pakke med navnet "{ $kitName }" findes allerede. Vælg venligst et andet navn.

# StaticKitItemModal
config-modal-title-kit-item = Tilføj/Rediger pakkegenstand
config-modal-placeholder-kit-item-quantity = Indtast antallet af denne genstand der skal inkluderes i pakken

# StaticKitCurrencyModal
config-modal-title-kit-currency = Tilføj pakkevaluta
config-modal-placeholder-currency-eg = f.eks., Guld
config-modal-placeholder-amount-eg = f.eks., 100
config-error-amount-must-be-number = Beløb skal være et tal.
config-error-no-currencies-on-server = Ingen valutaer konfigureret på serveren.
config-error-currency-not-found-short = Valutaen "{ $currency }" blev ikke fundet.
config-error-denomination-not-found = Denominationen "{ $denomination }" blev ikke fundet i valutakonfigurationen.

# RoleplaySettingsModal
config-modal-title-rp-settings = Rollespiksindstillinger
config-modal-label-min-message-length = Minimum beskedlængde (tegn)
config-modal-placeholder-min-message-length = Antal tegn påkrævet for at en besked er kvalificeret. 0 for ingen grænse
config-modal-label-cooldown = Afkøling (sekunder)
config-modal-placeholder-cooldown = Ventetid i sekunder mellem optælling af beskeder som kvalificerede for belønninger
config-modal-label-message-threshold = Beskedgrænse
config-modal-placeholder-message-threshold = Antal beskeder påkrævet for at udløse belønning
config-modal-label-frequency = Frekvens (antal beskeder)
config-modal-placeholder-frequency = Antal kvalificerede beskeder påkrævet for at optjene belønninger
config-error-min-length-invalid = Minimum beskedlængde skal være et ikke-negativt heltal.
config-error-cooldown-invalid = Afkøling skal være et ikke-negativt heltal.
config-error-threshold-invalid = Beskedgrænse skal være et positivt heltal.
config-error-frequency-invalid = Frekvens skal være et positivt heltal.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Konfigurer rollespilsbelønninger
config-modal-label-items-name-quantity = Genstande (Navn: Antal)
config-modal-label-currency-name-amount = Valuta (Navn: Beløb)
config-error-experience-non-negative = Erfaring skal være et ikke-negativt heltal.
config-error-item-quantity-positive-named = Genstandsantal for "{ $itemName }" skal være et positivt heltal.
config-error-currency-amount-positive = Valutabeløb for "{ $currencyName }" skal være et positivt tal.

# SetItemStockModal
config-modal-title-stock-limit = Lagergrænse: { $itemName }
config-modal-label-max-stock = Maksimalt lager
config-modal-placeholder-max-stock = Indtast maks. lager (f.eks. 10)
config-modal-label-current-stock = Nuværende lager
config-modal-placeholder-current-stock = Indtast nuværende tilgængeligt lager
config-error-max-stock-positive = Maksimalt lager skal være et positivt heltal.
config-error-current-stock-non-negative = Nuværende lager skal være et ikke-negativt heltal.
config-error-current-exceeds-max = Nuværende lager kan ikke overstige maksimalt lager.
config-error-item-not-in-shop = Genstand "{ $itemName }" blev ikke fundet i butikken.

# RestockScheduleModal
config-modal-title-restock-schedule = Konfigurer genopfyldningsplan
config-modal-label-schedule = Plan (hourly/daily/weekly/none)
config-modal-placeholder-schedule = Indtast: hourly, daily, weekly eller none
config-modal-label-time = Tid (HH:MM i UTC)
config-modal-desc-current-time = Nuværende tid: { $utcTime }
config-modal-placeholder-time = f.eks. 14:30 for kl. 14:30 UTC
config-modal-label-day-of-week = Ugedag (0=man, 6=søn) - Kun ugentlig
config-modal-placeholder-day-of-week = Indtast 0-6 (mandag=0, søndag=6)
config-modal-label-mode = Tilstand (full/incremental)
config-modal-placeholder-mode = full = nulstil til maks., incremental = tilføj antal
config-modal-label-increment = Forøgelsesmængde (til incremental-tilstand)
config-modal-placeholder-increment = Antal der tilføjes per genopfyldningscyklus
config-error-schedule-invalid = Plan skal være en af: hourly, daily, weekly eller none.
config-error-time-format-invalid = Tid skal være i HH:MM-format (f.eks. 14:30).
config-error-day-of-week-invalid = Ugedag skal være 0-6 (mandag=0, søndag=6).
config-error-mode-invalid = Tilstand skal være enten "full" eller "incremental".
config-error-increment-positive = Forøgelsesmængde skal være et positivt heltal.

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Søg efter din { $configName }-kanal

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Vælg din quest-meddelelsesrolle

# AddGMRoleSelect
config-select-placeholder-gm-roles = Vælg dine GM-rolle(r)

# ConfigWaitListSelect
config-select-placeholder-wait-list = Vælg ventelistestørrelse
config-select-option-disabled = 0 (Deaktiveret)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Vælg inventartilstand
config-select-option-disabled-label = Deaktiveret
config-select-desc-disabled = Spillere starter med tomme inventarer.
config-select-option-selection = Valg
config-select-desc-selection = Spillere vælger frit genstande fra den nye karakterbutik.
config-select-option-purchase = Køb
config-select-desc-purchase = Spillere køber genstande fra den nye karakterbutik med et givet beløb valuta.
config-select-option-open = Åben
config-select-desc-open = Spillere indtaster manuelt deres egne inventarer.
config-select-option-static = Statisk
config-select-desc-static = Spillere får et foruddefineret startinventar.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Vælg kvalificerede kanaler

# RoleplayModeSelect
config-select-placeholder-rp-mode = Vælg tilstand
config-select-option-scheduled = Planlagt
config-select-desc-scheduled = Belønninger gives én gang inden for en specificeret nulstillingsperiode.
config-select-option-accrued = Optjent
config-select-desc-accrued = Belønninger gives gentagne gange baseret på specificerede aktivitetsniveauer.

# RoleplayResetSelect
config-select-placeholder-reset-period = Vælg nulstillingsperiode
config-select-option-hourly = Hver time
config-select-desc-hourly = Nulstilles hver time.
config-select-option-daily = Dagligt
config-select-desc-daily = Nulstilles hver 24. time.
config-select-option-weekly = Ugentligt
config-select-desc-weekly = Nulstilles hver 7. dag.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Vælg nulstillingsdag

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Vælg nulstillingstidspunkt (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Vælg en forumkanal

# ForumThreadSelect
config-select-placeholder-thread = Vælg en tråd
config-select-option-no-threads = Ingen aktive tråde fundet
config-select-desc-no-threads = Opret en ny tråd eller tjek arkiverede tråde
config-select-option-select-forum-first = Vælg et forum først
config-select-desc-select-forum-first = Vælg venligst en forumkanal ovenfor
config-select-desc-thread-id = Tråd-ID: { $threadId }
config-error-select-valid-thread = Vælg venligst en gyldig tråd eller opret en ny.
config-error-thread-not-found = Kunne ikke finde den valgte tråd. Den kan være slettet eller arkiveret.

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = Serverkonfiguration - Hovedmenu
config-menu-config-wizard = Konfigurationsguide
config-menu-desc-config-wizard = Bekræft at din server er klar til at bruge ReQuest med en hurtig scanning.
config-menu-channels = Kanaler
config-menu-desc-channels = Indstil udpegede kanaler til ReQuest-opslag.
config-menu-currency = Valuta
config-menu-desc-currency = Globale valutaindstillinger.
config-menu-players = Spillere
config-menu-desc-players = Globale spillerindstillinger, såsom erfaringspoint-sporing.
config-menu-quests = Quests
config-menu-desc-quests = Globale quest-indstillinger, såsom ventelister.
config-menu-rp-rewards = RP-belønninger
config-menu-desc-rp-rewards = Konfigurer rollespilsbelønninger.
config-menu-roles = Roller
config-menu-desc-roles = Konfigurationsmuligheder for pingbare eller privilegerede roller.
config-menu-shops = Butikker
config-menu-desc-shops = Konfigurer tilpassede butikker.
config-menu-language = Sprog
config-menu-desc-language = Indstil standardsproget for denne server.

## Wizard View
config-title-wizard = {"**"}Serverkonfiguration - Guide{"**"}
config-wizard-intro =
    {"**"}Velkommen til ReQuest-konfigurationsguiden!{"**"}

    Denne guide hjælper dig med at sikre, at din server er korrekt konfigureret til at bruge ReQuests funktioner.
    Den scanner dine nuværende indstillinger og giver anbefalinger til eventuelle nødvendige justeringer.

    Brug knappen "Start scanning" nedenfor for at begynde valideringsprocessen. Når scanningen er færdig,
    modtager du en detaljeret rapport over din servers konfiguration sammen med eventuelle anbefalede ændringer.

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}Bot globale tilladelser{"**"}__
config-wizard-bot-permissions-desc = Denne sektion verificerer, at ReQuest har de korrekte tilladelser til at fungere korrekt.
config-wizard-bot-role = Botrolle: { $roleMention }
config-wizard-status-warnings = {"**"}Status: ⚠️ ADVARSLER FUNDET{"**"}
config-wizard-missing-perm = - ⚠️ Mangler: `{ $permissionName }`
config-wizard-ensure-permissions = Sørg venligst for, at bottens højeste rolle har disse tilladelser givet globalt.
config-wizard-status-ok = {"**"}Status: ✅ OK{"**"}
config-wizard-bot-permissions-ok = Botten har alle påkrævede globale tilladelser.
config-wizard-status-scan-failed = {"**"}Status: ❌ SCANNING FEJLEDE{"**"}
config-wizard-scan-error = Der opstod en uventet fejl under kontrol af bottilladelser.
config-wizard-error-type = Fejl: { $errorType }
config-wizard-required-permissions = {"**"}Påkrævede tilladelser for bottens rolle:{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = Se kanaler
config-wizard-perm-manage-roles = Administrer roller
config-wizard-perm-send-messages = Send beskeder
config-wizard-perm-attach-files = Vedhæft filer
config-wizard-perm-add-reactions = Tilføj reaktioner
config-wizard-perm-use-external-emoji = Brug eksterne emojis
config-wizard-perm-manage-messages = Administrer beskeder
config-wizard-perm-read-message-history = Læs beskedhistorik

# Wizard - Role Validation
config-wizard-role-header = __{"**"}Rollekonfigurationer{"**"}__
config-wizard-role-desc =
    Denne sektion verificerer følgende:

    - GM-roller (påkrævet) og meddelelsesrolle (valgfri) er konfigureret.
    - Standardrollen (@everyone) har de påkrævede tilladelser, så brugere kan tilgå botfunktioner.
    - Standardrollen (@everyone) har ikke farlige tilladelser.
    - GM- og meddelelsesroller kontrolleres for, om de har tilladelsesoptrappelser ud over standardrollen.

    Eventuelle advarsler her er udelukkende anbefalinger baseret på en standardopsætning. Afhængigt af din servers behov kan du have grund til at ignorere nogle af disse anbefalinger.

config-wizard-default-role-label = {"**"}Standardrolle:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Farlige tilladelser fundet:
config-wizard-default-role-ok = - ✅ @everyone: OK
config-wizard-missing-permission = - Manglende tilladelse: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}GM-roller:{"**"}
config-wizard-no-gm-roles = - ⚠️ Ingen GM-roller konfigureret
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Konfigureret rolle ikke fundet/slettet fra serveren
config-wizard-role-ok = - ✅ { $roleMention }: OK
config-wizard-announcement-role-label = {"**"}Meddelelsesrolle:{"**"}
config-wizard-no-announcement-role = - ℹ️ Ingen meddelelsesrolle konfigureret
config-wizard-announcement-role-not-found = - ⚠️ Konfigureret rolle ikke fundet/slettet fra serveren
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Tilladelsesoptrappelser registreret - { $escalations }
config-wizard-escalation-more = , og { $count } mere...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = Send beskeder i tråde
config-wizard-perm-use-application-commands = Brug programkommandoer

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = Administrer kanaler
config-wizard-perm-manage-webhooks = Administrer webhooks
config-wizard-perm-manage-server = Administrer server
config-wizard-perm-manage-nicknames = Administrer kaldenavne
config-wizard-perm-kick-members = Smid medlemmer ud
config-wizard-perm-ban-members = Udeluk medlemmer
config-wizard-perm-timeout-members = Timeout medlemmer
config-wizard-perm-mention-everyone = Nævn @everyone
config-wizard-perm-manage-threads = Administrer tråde
config-wizard-perm-administrator = Administrator

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}Kanalkonfigurationer{"**"}__
config-wizard-channel-desc =
    Denne sektion verificerer følgende:

    - Konfigurerede kanaler eksisterer.
    - Botten har tilladelse til at se og sende beskeder i de konfigurerede kanaler.
    - Standardrollen (@everyone) har ikke tilladelsen `Send beskeder`.

config-wizard-channel-no-config-required = - ⚠️ Ingen kanal konfigureret
config-wizard-channel-not-configured = - ℹ️ Ikke konfigureret (valgfri)
config-wizard-channel-not-found = - ⚠️ Konfigureret kanal ikke fundet/slettet fra serveren
config-wizard-channel-ok = - ✅ OK
config-wizard-bot-cannot-view = - ⚠️ { $botMention } kan ikke se denne kanal.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } kan ikke sende beskeder i denne kanal.
config-wizard-everyone-can-send = - ⚠️ @everyone kan sende beskeder i denne kanal.

# Wizard - Channel names
config-wizard-channel-quest-board = Quest-tavle
config-wizard-channel-player-board = Spillertavle
config-wizard-channel-quest-archive = Quest-arkiv
config-wizard-channel-gm-transaction-log = GM-transaktionslog
config-wizard-channel-player-transaction-log = Spillertransaktionslog
config-wizard-channel-shop-log = Butikslog
config-wizard-channel-approval-queue = Karaktergodkendelseskø

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}Indstillingsoversigt{"**"}__
config-wizard-dashboard-desc = Denne sektion giver et overblik over ikke-essentielle konfigurationer til hurtig reference.
config-wizard-quest-settings = {"**"}Quest-indstillinger{"**"}
config-wizard-quest-wait-list = - Quest-ventelistestørrelse: { $size }
config-wizard-quest-summary = - Quest-resumé: { $status }
config-wizard-gm-rewards-per-quest = {"**"}GM-belønninger (per quest){"**"}
config-wizard-player-settings = {"**"}Spillerindstillinger{"**"}
config-wizard-player-experience = - Spillererfaring: { $status }
config-wizard-currency-settings = {"**"}Valutaindstillinger{"**"}
config-wizard-rp-rewards = {"**"}Rollespilsbelønninger{"**"}
config-wizard-rp-status = - Status: { $status }
config-wizard-rp-mode = - Tilstand: { $mode }
config-wizard-rp-channels = - Overvågede kanaler: { $count }
config-wizard-shops = {"**"}Butikker{"**"}
config-wizard-shops-count = - Konfigurerede butikker: { $count }
config-wizard-shops-more = - ...og { $count } mere
config-wizard-new-char-setup = {"**"}Ny karakter-opsætning{"**"}
config-wizard-inventory-type = - Inventartype: { $type }
config-wizard-new-char-shop-items = - Ny karakterbutik genstande: { $count }
config-wizard-static-kits = - Statiske pakker: { $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ Ingen valutaer konfigureret
config-wizard-configured-currencies = {"**"}Konfigurerede valutaer:{"**"}
config-wizard-no-denominations = - Ingen denominationer konfigureret
config-wizard-gm-rewards-disabled = {"**"}Status:{"**"} Deaktiveret
config-wizard-gm-rewards-enabled = {"**"}Status:{"**"} Aktiveret
config-wizard-gm-rewards-experience = - Erfaring: { $xp }
config-wizard-gm-rewards-items = - Genstande:
config-wizard-unnamed-shop = Unavngiven butik

## Roles View
config-title-roles = {"**"}Serverkonfiguration - Roller{"**"}
config-label-announcement-role = {"**"}Meddelelsesrolle:{"**"} { $status }
config-desc-announcement-role = Denne rolle nævnes, når en quest offentliggøres.
config-label-announcement-role-default = {"**"}Meddelelsesrolle:{"**"} Ikke konfigureret
config-label-gm-roles = {"**"}GM-rolle(r):{"**"} { $roles }
config-desc-gm-roles = Disse roller giver adgang til GM-kommandoer og -funktioner.
config-label-gm-roles-default = {"**"}GM-rolle(r):{"**"} Ikke konfigureret
config-title-forbidden-roles = __{"**"}Forbudte roller{"**"}__
config-desc-forbidden-roles =
    Konfigurerer en liste over rollenavne, som ikke kan bruges af GM'er til deres grupperoller.
    Som standard kan `everyone`, `administrator`, `gm` og `game master` ikke bruges. Denne konfiguration
    udvider denne liste.

## GM Role Remove View
config-title-remove-gm-roles = {"**"}Serverkonfiguration - Fjern GM-rolle(r){"**"}
config-msg-no-gm-roles = Ingen GM-roller konfigureret.

## Channels View
config-title-channels = {"**"}Serverkonfiguration - Kanaler{"**"}

config-label-quest-board = {"**"}Quest-tavle:{"**"} { $channel }
config-desc-quest-board = Kanalen hvor nye/aktive quests vil blive opslået.
config-label-quest-board-default = {"**"}Quest-tavle:{"**"} Ikke konfigureret

config-label-player-board = {"**"}Spillertavle:{"**"} { $channel }
config-desc-player-board = En valgfri meddelelsstavle til brug af spillere.
config-label-player-board-default = {"**"}Spillertavle:{"**"} Ikke konfigureret

config-label-quest-archive = {"**"}Quest-arkiv:{"**"} { $channel }
config-desc-quest-archive = En valgfri kanal, hvor afsluttede quests flyttes til med resuméinformation.
config-label-quest-archive-default = {"**"}Quest-arkiv:{"**"} Ikke konfigureret

config-label-gm-transaction-log = {"**"}GM-transaktionslog:{"**"} { $channel }
config-desc-gm-transaction-log = En valgfri kanal, hvor GM-transaktioner (dvs. Rediger spiller-kommandoer) logges.
config-label-gm-transaction-log-default = {"**"}GM-transaktionslog:{"**"} Ikke konfigureret

config-label-player-transaction-log = {"**"}Spillertransaktionslog:{"**"} { $channel }
config-desc-player-transaction-log = En valgfri kanal, hvor spillertransaktioner som handel og forbrug af genstande logges.
config-label-player-transaction-log-default = {"**"}Spillertransaktionslog:{"**"} Ikke konfigureret

config-label-shop-log = {"**"}Butikslog:{"**"} { $channel }
config-desc-shop-log = En valgfri kanal, hvor butikstransaktioner logges.
config-label-shop-log-default = {"**"}Butikslog:{"**"} Ikke konfigureret

## Quests View
config-title-quests = {"**"}Serverkonfiguration - Quests{"**"}

config-label-wait-list = {"**"}Quest-ventelistestørrelse:{"**"} { $size }
config-desc-wait-list = En venteliste giver det angivne antal spillere mulighed for at stå i kø til en quest, der er fuld, i tilfælde af at en spiller falder fra.
config-label-wait-list-disabled = {"**"}Quest-ventelistestørrelse:{"**"} Deaktiveret

config-label-quest-summary = {"**"}Quest-resumé:{"**"} { $status }
config-desc-quest-summary = Denne mulighed giver GM'er mulighed for at skrive et kort resumé ved afslutning af quests.
config-label-quest-summary-disabled = {"**"}Quest-resumé:{"**"} Deaktiveret

config-label-gm-rewards = GM-belønninger
config-desc-gm-rewards = Konfigurer belønninger, som GM'er modtager, når de afslutter quests.

## GM Rewards View
config-title-gm-rewards = {"**"}Serverkonfiguration - GM-belønninger{"**"}
config-desc-gm-rewards-detail =
    {"**"}Tilføj/Rediger belønninger{"**"}
    Åbner en inputformular til at tilføje, ændre eller fjerne GM-belønninger.

    > Konfigurerede belønninger er per quest. Hver gang en GM afslutter en quest, modtager de
    belønningerne konfigureret nedenfor på deres aktive karakter.
config-msg-no-rewards = Ingen belønninger konfigureret.
config-label-gm-experience = {"**"}Erfaring:{"**"} { $xp }
config-label-gm-items = {"**"}Genstande:{"**"}

## Players View
config-title-players = {"**"}Serverkonfiguration - Spillere{"**"}

config-label-player-experience = {"**"}Spillererfaring:{"**"} { $status }
config-desc-player-experience = Aktiverer/deaktiverer brugen af erfaringspoint (eller lignende værdibaseret karakterprogression).
config-label-player-experience-disabled = {"**"}Spillererfaring:{"**"} Deaktiveret

config-label-new-char-settings = {"**"}Nye karakterindstillinger{"**"}
config-desc-new-char-settings = Konfigurer indstillinger relateret til nye spillerkarakterer og hvordan deres startinventarer opsættes.

config-label-player-board-purge = {"**"}Ryd spillertavlen{"**"}
config-desc-player-board-purge = Rydder opslag fra spillertavlen (hvis aktiveret).

## New Character Settings View
config-title-new-character = {"**"}Serverkonfiguration - Nye karakterindstillinger{"**"}

config-label-inventory-type = {"**"}Ny karakter-inventartype:{"**"} { $type }
config-desc-inventory-type = Bestemmer hvordan nyregistrerede karakterer initialiserer deres inventarer.
config-label-inventory-type-disabled = {"**"}Ny karakter-inventartype:{"**"} Deaktiveret

config-label-new-char-wealth = {"**"}Ny karakters formue:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Ny karakters formue:{"**"} Deaktiveret

config-label-approval-queue = {"**"}Godkendelseskø:{"**"} { $channel }
config-desc-approval-queue = Hvis indstillet, skal nye karakterer godkendes af en GM i denne Forum-kanal, før de er aktive.
config-label-approval-queue-disabled = {"**"}Godkendelseskø:{"**"} Deaktiveret
config-label-approval-queue-not-configured = {"**"}Godkendelseskø:{"**"} Ikke konfigureret

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = Spillere starter med tomme inventarer.
config-desc-inv-type-selection = Spillere vælger frit genstande fra den nye karakterbutik.
config-desc-inv-type-purchase = Spillere køber genstande fra den nye karakterbutik med et givet beløb valuta.
config-desc-inv-type-open = Spillere indtaster manuelt deres inventargenstande.
config-desc-inv-type-static = Spillere får et foruddefineret startinventar.

## New Character Shop View
config-title-new-char-shop = {"**"}Serverkonfiguration - Ny karakterbutik{"**"}
config-label-inv-type-selection = {"**"}Inventartype:{"**"} Valg
config-desc-inv-type-selection-shop = Spillere vælger frit genstande fra den nye karakterbutik.
config-label-inv-type-purchase = {"**"}Inventartype:{"**"} Køb
config-desc-inv-type-purchase-shop = Spillere køber genstande fra den nye karakterbutik med et givet beløb valuta.
config-label-inv-type-other = {"**"}Inventartype:{"**"} { $type }
config-desc-inv-type-not-in-use = Ny karakterbutik er ikke i brug.
config-msg-define-shop-items = Definer butiksgenstande.
config-msg-no-items = Ingen genstande konfigureret.

## Static Kits View
config-title-static-kits = {"**"}Serverkonfiguration - Statiske pakker{"**"}
config-desc-create-kit = Opret en ny pakkedefinition.
config-msg-no-kits = Ingen pakker konfigureret.
config-label-kit-more-items = ...og { $count } flere genstande
config-label-empty-kit = {"*"}Tom pakke{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}Redigerer pakke: { $kitName }{"**"}
config-msg-kit-empty = Denne pakke er tom. Brug knapperne ovenfor til at tilføje valuta eller genstande.
config-label-kit-currency = {"**"}Valuta:{"**"} { $display }
config-label-kit-item = {"**"}Genstand:{"**"} { $name }

## Currency View
config-title-currency = {"**"}Serverkonfiguration - Valuta{"**"}
config-desc-create-currency = Opret en ny valuta.
config-msg-no-currencies = Ingen valutaer konfigureret.
config-label-currency-display-type = Visningstype: { $type } | Denominationer: { $count }
config-label-currency-type-double = Decimal
config-label-currency-type-integer = Heltal

## Edit Currency View
config-title-manage-currency = {"**"}Administrer valuta: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Valuta og denominationer{"**"}__
    - Det angivne navn på din valuta betragtes som basisvalutaen og har en værdi af 1.
    {"```"}Eksempel: "guld" er konfigureret som en valuta.{"```"}
    - Tilføjelse af en denomination kræver angivelse af et navn og en værdi relativt til basisvalutaen.
    {"```"}Eksempel: Guld får to denominationer: sølv (værdi 0,1) og kobber (værdi 0,01).{"```"}
    - Alle transaktioner med en basisvaluta eller dens denominationer vil automatisk konvertere dem.
    {"```"}Eksempel: En spiller har 10 guld og bruger 3 kobber. Deres nye saldo vil automatisk vise
    9 guld, 9 sølv og 7 kobber.{"```"}
    - Valutaer vist som heltal viser hver denomination, mens valutaer vist som decimal
    kun vises som basisvalutaen.
    {"```"}Eksempel: Spilleren ovenfor med decimalvisning aktiveret vil vises som 9,97 guld.{"```"}
config-btn-toggle-display-current = Skift visning (nuværende: { $type })
config-msg-no-denominations = Ingen denominationer konfigureret.

## Shops View
config-title-shops = {"**"}Serverkonfiguration - Butikker{"**"}
config-desc-add-shop-wizard =
    {"**"}Tilføj butik (guide){"**"}
    Opret en ny, tom butik via en formular.
config-desc-add-shop-json =
    {"**"}Tilføj butik (JSON){"**"}
    Opret en ny butik ved at angive en fuld JSON-definition. (Avanceret)
config-btn-example-json = Eksempel JSON
config-desc-example-json =
    {"**"}Eksempel JSON{"**"}
    Download en eksempel JSON-fil der viser det forventede format.
config-msg-example-json = Her er en eksempel JSON-fil der viser det forventede format.
config-msg-no-shops = Ingen butikker konfigureret.
config-label-shop-type-forum = (Forum)
config-label-shop-channel = Kanal: <#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}Tilføj butik - Vælg placeringstype{"**"}
config-label-text-channel = {"**"}Tekstkanal{"**"}
config-desc-text-channel = Opret en butik i en standard tekstkanal.
config-label-forum-thread = {"**"}Forum-tråd{"**"}
config-desc-forum-thread = Opret en butik i en forum-tråd (ny eller eksisterende).

## Forum Shop Setup View
config-title-forum-setup = {"**"}Tilføj butik - Forum-tråd-opsætning{"**"}
config-label-step1 = {"**"}Trin 1: Vælg en forumkanal{"**"}
config-label-step2 = {"**"}Trin 2: Vælg trådmulighed{"**"}
config-label-step3 = {"**"}Trin 3: Vælg en eksisterende tråd{"**"}
config-desc-create-new-thread =
    {"**"}Opret ny tråd{"**"}
    Åbner en formular til at oprette en ny tråd og konfigurere butikken.
config-label-selected-thread = {"**"}Valgt tråd:{"**"} { $threadName }
config-desc-click-to-configure = Klik for at konfigurere butikken i denne tråd.

## Manage Shop View
config-title-manage-shop = {"**"}Administrer butik: { $shopName }{"**"}
config-label-shop-type = {"**"}Type:{"**"} { $type }
config-label-shop-type-text = Tekstkanal
config-label-shop-type-forum-thread = Forum-tråd
config-label-shopkeeper = {"**"}Butiksindehaver:{"**"} { $name }
config-label-shop-description = {"**"}Beskrivelse:{"**"} { $description }
config-label-shop-channel-info = {"**"}Kanal:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Rediger butiksdetaljer og genstande via guiden.
config-desc-upload-json = Upload en ny JSON-definition til denne butik.
config-desc-download-json = Download den nuværende JSON-definition.
config-desc-remove-shop = Fjern denne butik permanent.

## Edit Shop View
config-title-editing-shop = {"**"}Redigerer butik: { $shopName }{"**"}
config-label-shop-shopkeeper = Butiksindehaver: {"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}Lagerkonfiguration: { $shopName }{"**"}
config-label-current-utc = Nuværende UTC-tid: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Genopfyldningsplan:{"**"} { $schedule }
config-label-restock-hourly = ved minut :{ $minute }
config-label-restock-daily = kl. { $time } UTC
config-label-restock-weekly = om { $day } kl. { $time } UTC
config-label-restock-mode = {"**"}Tilstand:{"**"} { $mode }
config-label-restock-full = Fuld genopfyldning
config-label-restock-incremental = Tilføj { $amount } per cyklus (op til maks.)
config-label-restock-disabled = {"**"}Genopfyldningsplan:{"**"} Deaktiveret
config-label-item-stock-limits = {"**"}Genstandslagergrænser{"**"}
config-msg-no-items-in-shop = Ingen genstande i denne butik.
config-label-stock-with-available = Maks.: { $max } | Tilgængeligt: { $available }
config-label-stock-reserved = | Reserveret: { $reserved }
config-label-stock-not-initialized = Maks.: { $max } | Tilgængeligt: (ikke initialiseret)
config-label-stock-unlimited = Lager: Ubegrænset

## Roleplay View
config-title-roleplay = {"**"}Serverkonfiguration - Rollespilsbelønninger{"**"}
config-label-rp-status = {"**"}Status:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Servertid:{"**"} `{ $time }`
config-label-rp-enabled = Aktiveret
config-label-rp-disabled = Deaktiveret

config-desc-rp-mode-scheduled = {"```"}Belønninger uddeles én gang, når det påkrævede antal kvalificerede beskeder er sendt inden for den angivne tidsperiode (hver time, dagligt eller ugentligt).{"```"}
config-desc-rp-mode-accrued = {"```"}Belønninger uddeles løbende, hver gang et bestemt antal kvalificerede beskeder er sendt.{"```"}

config-label-rp-config-details = {"**"}Konfigurationsdetaljer:{"**"}
config-label-rp-mode = {"**"}Tilstand:{"**"} { $mode }
config-label-rp-min-length = {"**"}Minimum beskedlængde:{"**"} { $length } tegn
config-label-rp-cooldown = {"**"}Afkøling:{"**"} { $seconds } sekunder
config-label-rp-frequency-once = {"**"}Frekvens:{"**"} Én gang per { $period }
config-label-rp-reset-time = {"**"}Nulstillingstidspunkt:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Grænse:{"**"} { $count } kvalificerede beskeder
config-label-rp-frequency-every = {"**"}Frekvens:{"**"} Hver { $count } kvalificerede beskeder

config-label-rp-channels = {"**"}Rollespilskanaler:{"**"}
config-msg-rp-no-channels = Ingen konfigureret.
config-label-rp-channels-more = ...og { $count } mere.

config-label-rp-rewards = {"**"}Belønninger:{"**"}
config-msg-rp-no-rewards = Ingen konfigureret.
config-label-rp-experience = {"**"}Erfaring:{"**"} { $xp }
config-label-rp-items = {"**"}Genstande:{"**"}
config-label-rp-currency = {"**"}Valuta:{"**"}

## Language View
config-title-language = {"**"}Serverkonfiguration - Sprog{"**"}
config-server-language-help =
    Denne indstilling lader dig angive standardsproget for ReQuests {"**"}offentlige{"**"} svar og beskeder på denne server. Offentlige svar inkluderer:
    - Quest- og spillertavleopslag
    - Quest-resumé og logkanalbeskeder
    - Butiksgenopfyldning
    - Spillers genstandsforbrug

    Denne indstilling påvirker kun statisk tekst genereret af botten og oversætter ikke dynamisk indhold som brugerindtastede genstandsnavne eller quest-beskrivelser.

    Personlige svar og menuer påvirkes ikke af denne indstilling.
config-label-server-language = {"**"}Serversprog:{"**"} { $language }
config-label-server-language-default = {"**"}Serversprog:{"**"} Standard (ingen tilsidesættelse)
config-select-placeholder-server-language = Vælg serversprog
config-select-option-default = Standard (ingen tilsidesættelse)
config-select-desc-default = Brug hver brugers præference eller Discord-sprog.
