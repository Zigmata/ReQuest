## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = Tøm
config-btn-remove-gm-roles = Fjern GM-roller
config-btn-forbidden-roles = Forbudte roller

# Quests
config-btn-toggle-quest-summary = Veksle quest-sammendrag
config-btn-toggle-player-experience = Veksle spillererfaring
config-btn-toggle-display = Veksle visning
config-btn-purge-player-board = Tøm spillertavle
config-btn-add-modify-rewards = Legg til/endre belønninger

# Currency
config-btn-add-denomination = Legg til valør
config-btn-add-new-currency = Legg til ny valuta
config-btn-remove-currency = Fjern valuta

# Shops - creation
config-btn-add-shop-wizard = Legg til butikk (veiviser)
config-btn-add-shop-json = Legg til butikk (JSON)
config-btn-edit-shop-wizard = Rediger butikk (veiviser)
config-btn-edit-shop-json = Rediger butikk (JSON)
config-btn-remove-shop = Fjern butikk
config-btn-add-item = Legg til gjenstand
config-btn-edit-shop-details = Rediger butikkdetaljer
config-btn-download-json = Last ned JSON
config-btn-done-editing = Ferdig med redigering
config-btn-scan-server-configs = Skann serverkonfigurasjoner
config-btn-re-scan = Skann på nytt

# New character shop
config-btn-upload-json = Last opp JSON
config-btn-configure-new-character-wealth = Konfigurer startformue
config-btn-configure-new-character-shop = Konfigurer ny karakter-butikk
config-btn-clear-shop = Tøm butikk
config-btn-configure-static-kits = Konfigurer statiske sett
config-btn-new-character-settings = Innstillinger for ny karakter
config-btn-disabled-no-currency = Deaktivert (ingen valuta konfigurert)
config-btn-disabled-no-wealth = Deaktivert (ingen startformue konfigurert)

# Static kits
config-btn-create-new-kit = Opprett nytt sett
config-btn-delete-kit = Slett sett
config-btn-add-currency = Legg til valuta

# Roleplay
config-btn-toggle-rp-rewards = Veksle RP-belønninger
config-btn-clear-channels = Tøm kanaler
config-btn-edit-settings = Rediger innstillinger
config-btn-configure-rewards = Konfigurer belønninger

# Stock
config-btn-stock-limits = Lagerbegrensninger
config-btn-set-limit = Sett grense
config-btn-edit-limit = Rediger grense
config-btn-remove-limit = Fjern grense
config-btn-configure-restock-schedule = Konfigurer påfyllingsplan
config-btn-back-to-shop-editor = Tilbake til butikkredigering

# Forum shop
config-btn-create-new-thread = Opprett ny tråd
config-btn-use-existing-thread = Bruk eksisterende tråd

# Wizard
config-btn-quit = Avslutt
config-btn-configure-channels = Konfigurer kanaler
config-btn-configure-roles = Konfigurer roller
config-btn-configure-quests = Konfigurer quester
config-btn-configure-players = Konfigurer spillere
config-btn-configure-currency = Konfigurer valuta
config-btn-configure-rp-rewards = Konfigurer RP-belønninger
config-btn-configure-shops = Konfigurer butikker
config-btn-new-char-setup = Oppsett ny karakter

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = Bekreft fjerning av rolle
config-modal-title-confirm-removal = Bekreft fjerning
config-modal-title-confirm-currency-removal = Bekreft fjerning av valuta
config-modal-title-confirm-shop-removal = Bekreft fjerning av butikk
config-modal-title-confirm-kit-deletion = Bekreft sletting av sett
config-modal-title-confirm-remove-stock-limit = Bekreft fjerning av lagergrense
config-modal-title-clear-shop = Bekreft tømming av butikk

# Confirm modal prompt labels
config-modal-label-remove-role = Fjerne { $roleName }?
config-modal-label-remove-denomination = Fjerne { $denominationName }?
config-modal-label-remove-currency = Fjerne { $currencyName }?
config-modal-label-shop-removal-warning = ADVARSEL: Denne handlingen kan ikke angres!
config-modal-label-kit-deletion-warning = ADVARSEL: Kan ikke angres!
config-modal-label-remove-stock-limit = Skriv CONFIRM for å fjerne lagergrensen
config-modal-label-clear-shop = Fjern alle gjenstander fra denne butikken?

# Error messages from buttons
config-error-shop-data-not-found = Feil: Kunne ikke finne dataene for den butikken.
config-msg-shop-json-download = Her er JSON-definisjonen for {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Her er JSON-definisjonen for ny karakter-butikken.
config-error-select-forum-first = Vennligst velg en forumkanal først.
config-error-select-thread-first = Vennligst velg en tråd først.

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Legg til ny valuta
config-modal-label-currency-name = Valutanavn
config-error-currency-already-exists = En valuta eller valør med navnet { $name } eksisterer allerede!

# RenameCurrencyModal
config-modal-title-rename-currency = Gi valuta nytt navn
config-modal-label-new-currency-name = Nytt valutanavn
config-error-currency-name-exists = En valuta med navnet "{ $name }" eksisterer allerede.
config-error-denomination-name-exists = En valør med navnet "{ $name }" eksisterer allerede.

# RenameDenominationModal
config-modal-title-rename-denomination = Gi valør nytt navn
config-modal-label-new-denomination-name = Nytt valørnavn

# AddCurrencyDenominationModal
config-modal-title-add-denomination = Legg til { $currencyName }-valør
config-modal-label-denomination-name = Navn
config-modal-placeholder-denomination-name = f.eks. Sølv
config-modal-label-denomination-value = Verdi
config-modal-placeholder-denomination-value = f.eks. 0.1
config-error-denomination-matches-currency = Nytt valørnavn kan ikke være likt en eksisterende valuta på denne serveren! Fant eksisterende valuta med navnet "{ $existingName }".
config-error-denomination-matches-denomination = Nytt valørnavn kan ikke være likt en eksisterende valør på denne serveren! Fant eksisterende valør med navnet "{ $denominationName }" under valutaen "{ $currencyName }".
config-error-denomination-value-exists = Valører under en enkelt valuta må ha unike verdier! { $denominationName } har allerede denne verdien tildelt.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Forbudte rollenavn
config-modal-label-names = Navn
config-modal-placeholder-names = Skriv inn navn adskilt med komma
config-msg-forbidden-roles-updated = Forbudte roller oppdatert!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Tøm spillertavle
config-modal-label-age = Alder
config-modal-placeholder-age = Angi maksimal innleggsalder (i dager) å beholde
config-msg-posts-purged = Innlegg eldre enn { $days } dager har blitt slettet!

# GMRewardsModal
config-modal-title-gm-rewards = Legg til/endre GM-belønninger
config-modal-label-experience = Erfaring
config-modal-placeholder-enter-number = Skriv inn et tall
config-modal-label-items = Gjenstander
config-modal-placeholder-items =
    Navn: Antall
    Navn2: Antall
    osv.
config-error-experience-invalid = Erfaring må være et gyldig heltall (f.eks. 2000).
config-error-item-format-invalid = Ugyldig gjenstandsformat: "{ $item }". Hver gjenstand må være på en ny linje, i formatet "Navn: Antall".

# ConfigShopDetailsModal
config-modal-title-shop-details = Legg til/rediger butikkdetaljer
config-modal-label-shop-channel = Velg en kanal
config-modal-placeholder-shop-channel = Velg kanalen for denne butikken
config-modal-label-shop-name = Butikknavn
config-modal-placeholder-shop-name = Skriv inn navnet på butikken
config-modal-label-shopkeeper-name = Butikkeiers navn
config-modal-placeholder-shopkeeper-name = Skriv inn navnet på butikkeieren
config-modal-label-shop-description = Butikkbeskrivelse
config-modal-placeholder-shop-description = Skriv inn en beskrivelse for butikken
config-modal-label-shop-image-url = Butikkbilde-URL
config-modal-placeholder-shop-image-url = Skriv inn en URL for butikkbildet
config-error-no-channel-selected = Ingen kanal valgt for butikken.
config-error-shop-already-in-channel = En butikk er allerede registrert i den valgte kanalen. Vennligst velg en annen kanal eller rediger den eksisterende butikken.

# build_shop_header_view
config-label-shopkeeper = {"**"}Butikkeier:{"**"} { $name }
config-msg-use-shop-command = Bruk kommandoen `/shop` for å bla gjennom og kjøpe gjenstander.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Opprett forumtråd-butikk
config-modal-label-thread-name = Trådnavn
config-modal-placeholder-thread-name = Skriv inn navnet for butikktråden
config-error-forum-not-found = Kunne ikke finne den valgte forumkanalen.
config-error-shop-already-in-thread = En butikk er allerede registrert i denne tråden. Dette burde ikke skje for en ny tråd.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Legg til ny butikk via JSON
config-modal-label-upload-json = Last opp en .json-fil med butikkdataene
config-error-no-json-uploaded = Ingen JSON-fil lastet opp for butikken.
config-error-file-must-be-json = Opplastet fil må være en JSON-fil (.json).
config-error-invalid-json = Ugyldig JSON-format: { $error }
config-error-json-validation-failed = JSON samsvarer ikke med skjemaet: { $error }

# ShopItemModal
config-modal-title-shop-item = Legg til/rediger butikkgjenstand
config-modal-label-item-name = Gjenstandsnavn
config-modal-placeholder-item-name = Skriv inn navnet på gjenstanden
config-modal-label-item-description = Gjenstandsbeskrivelse
config-modal-placeholder-item-description = Skriv inn en beskrivelse for gjenstanden
config-modal-label-item-quantity = Gjenstandsantall
config-modal-placeholder-item-quantity = Skriv inn antall som selges per kjøp
config-modal-label-item-costs = Gjenstandskostnader
config-modal-placeholder-item-costs = F.eks.: 10 gold + 5 silver\nELLER: 50 rep\n(Bruk + for OG, nye linjer for ELLER)
config-error-item-quantity-positive = Gjenstandsantall må være et positivt heltall.
config-error-cost-format-invalid = Ugyldig kostnadsformat i alternativ: "{ $option }". Hver kostnad må ha et beløp og en valuta atskilt med mellomrom, f.eks. "10 gold".
config-error-cost-amount-invalid = Ugyldig beløp "{ $amount }" for valuta: "{ $currency }". Beløpet må være et positivt tall.
config-error-unknown-currency = Ukjent valuta `{ $currency }`. Vennligst bruk en gyldig valuta konfigurert for denne serveren.
config-error-item-already-exists = En gjenstand med navnet { $itemName } eksisterer allerede i denne butikken.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Oppdater butikk via JSON
config-modal-label-upload-new-json = Last opp ny JSON-definisjon
config-error-no-file-uploaded = Ingen fil ble lastet opp.
config-error-file-must-be-json-ext = Filen må være en `.json`-fil.
config-error-json-validation-message = JSON-validering mislyktes: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Legg til/rediger utstyr for ny karakter
config-modal-placeholder-item-quantity-selection = Skriv inn antall mottatt per valg
config-modal-label-item-cost = Gjenstandskostnad
config-error-cost-format-short = Ugyldig kostnadsformat: '{ $component }'. Forventet 'Beløp Valuta'.
config-error-amount-invalid-short = Ugyldig beløp '{ $amount }' for valuta '{ $currency }'.
config-error-item-exists-new-char = En gjenstand med navnet { $itemName } eksisterer allerede i ny karakter-butikken.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Last opp ny karakter-butikk (JSON)
config-error-no-json-uploaded-short = Ingen JSON-fil lastet opp.
config-error-json-must-have-shopstock = JSON må inneholde en 'shopStock'-matrise.
config-error-items-must-have-name-price = Alle gjenstander må ha 'name' og 'price'.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Angi startformue for ny karakter
config-modal-label-amount = Beløp
config-modal-placeholder-amount = Skriv inn beløpet for denne valutaen.
config-modal-placeholder-currency-name = Skriv inn navnet på en valuta definert på denne serveren
config-error-no-currencies-configured = Ingen valutaer er konfigurert på denne serveren.
config-error-currency-not-found = Valuta eller valør med navnet { $name } ble ikke funnet. Vennligst bruk en gyldig valuta.

# CreateStaticKitModal
config-modal-title-create-kit = Opprett nytt statisk sett
config-modal-label-kit-name = Settnavn
config-modal-placeholder-kit-name = f.eks. Krigerstartsett
config-modal-label-description = Beskrivelse
config-modal-placeholder-kit-description = Valgfri beskrivelse for dette settet
config-error-kit-name-exists = Et statisk sett med navnet "{ $kitName }" eksisterer allerede. Vennligst velg et annet navn.

# StaticKitItemModal
config-modal-title-kit-item = Legg til/rediger settgjenstand
config-modal-placeholder-kit-item-quantity = Skriv inn antallet av denne gjenstanden som skal inkluderes i settet

# StaticKitCurrencyModal
config-modal-title-kit-currency = Legg til settvaluta
config-modal-placeholder-currency-eg = f.eks. Gull
config-modal-placeholder-amount-eg = f.eks. 100
config-error-amount-must-be-number = Beløp må være et tall.
config-error-no-currencies-on-server = Ingen valutaer konfigurert på serveren.
config-error-currency-not-found-short = Valutaen "{ $currency }" ble ikke funnet.
config-error-denomination-not-found = Valøren "{ $denomination }" ble ikke funnet i valutakonfigurasjonen.

# RoleplaySettingsModal
config-modal-title-rp-settings = Rollespillinnstillinger
config-modal-label-min-message-length = Minimum meldingslengde (tegn)
config-modal-placeholder-min-message-length = Antall tegn som kreves for at en melding skal være kvalifisert. 0 for ingen grense
config-modal-label-cooldown = Nedkjøling (sekunder)
config-modal-placeholder-cooldown = Ventetid, i sekunder, mellom telling av meldinger som kvalifiserte for belønninger
config-modal-label-message-threshold = Meldingsterskel
config-modal-placeholder-message-threshold = Antall meldinger som kreves for å utløse belønning
config-modal-label-frequency = Frekvens (antall meldinger)
config-modal-placeholder-frequency = Antall kvalifiserte meldinger som kreves for å tjene belønninger
config-error-min-length-invalid = Minimum meldingslengde må være et ikke-negativt heltall.
config-error-cooldown-invalid = Nedkjøling må være et ikke-negativt heltall.
config-error-threshold-invalid = Meldingsterskel må være et positivt heltall.
config-error-frequency-invalid = Frekvens må være et positivt heltall.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Konfigurer rollespillbelønninger
config-modal-label-items-name-quantity = Gjenstander (Navn: Antall)
config-modal-label-currency-name-amount = Valuta (Navn: Beløp)
config-error-experience-non-negative = Erfaring må være et ikke-negativt heltall.
config-error-item-quantity-positive-named = Gjenstandsantall for "{ $itemName }" må være et positivt heltall.
config-error-currency-amount-positive = Valutabeløp for "{ $currencyName }" må være et positivt tall.

# SetItemStockModal
config-modal-title-stock-limit = Lagergrense: { $itemName }
config-modal-label-max-stock = Maksimalt lager
config-modal-placeholder-max-stock = Skriv inn maks lager (f.eks. 10)
config-modal-label-current-stock = Nåværende lager
config-modal-placeholder-current-stock = Skriv inn nåværende tilgjengelig lager
config-modal-label-restock-increment = Påfyllingsmengde (per syklus)
config-modal-placeholder-restock-increment = Mengde lagt til per påfyllingssyklus (standard: 1)
config-error-max-stock-positive = Maksimalt lager må være et positivt heltall.
config-error-current-stock-non-negative = Nåværende lager må være et ikke-negativt heltall.
config-error-current-exceeds-max = Nåværende lager kan ikke overstige maksimalt lager.
config-error-item-not-in-shop = Gjenstanden "{ $itemName }" ble ikke funnet i butikken.

# RestockScheduleModal
config-modal-title-restock-schedule = Konfigurer påfyllingsplan
config-modal-restock-schedule-label = Tidsplan
config-modal-restock-schedule-none = Ingen (Deaktivert)
config-modal-restock-schedule-hourly = Hver time
config-modal-restock-schedule-daily = Daglig
config-modal-restock-schedule-weekly = Ukentlig
config-modal-label-time = Tid (TT:MM i UTC)
config-modal-desc-current-time = Gjeldende tid: { $utcTime }
config-modal-placeholder-time = f.eks. 14:30 for 14:30 UTC
config-modal-restock-day-label = Ukedag (kun ukentlig)
config-modal-restock-mode-label = Påfyllingsmodus
config-modal-restock-mode-full = Full (tilbakestill til maks)
config-modal-restock-mode-incremental = Gradvis (legg til mengde)
config-error-time-format-invalid = Tid må være i TT:MM-format (f.eks. 14:30).
config-error-increment-positive = Påfyllingsbeløp må være et positivt heltall.

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Søk etter din { $configName }-kanal

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Velg din kunngjøringsrolle for quester

# AddGMRoleSelect
config-select-placeholder-gm-roles = Velg din(e) GM-rolle(r)

# ConfigWaitListSelect
config-select-placeholder-wait-list = Velg ventelistestørrelse
config-select-option-disabled = 0 (Deaktivert)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Velg inventarmodus
config-select-option-disabled-label = Deaktivert
config-select-desc-disabled = Spillere starter med tomme inventarer.
config-select-option-selection = Utvalg
config-select-desc-selection = Spillere velger gjenstander fritt fra ny karakter-butikken.
config-select-option-purchase = Kjøp
config-select-desc-purchase = Spillere kjøper gjenstander fra ny karakter-butikken med et gitt beløp valuta.
config-select-option-open = Åpen
config-select-desc-open = Spillere skriver inn sitt eget inventar manuelt.
config-select-option-static = Statisk
config-select-desc-static = Spillere får et forhåndsdefinert startinventar.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Velg kvalifiserte kanaler

# RoleplayModeSelect
config-select-placeholder-rp-mode = Velg modus
config-select-option-scheduled = Planlagt
config-select-desc-scheduled = Belønninger gis én gang innenfor en angitt tilbakestillingsperiode.
config-select-option-accrued = Opptjent
config-select-desc-accrued = Belønninger gis gjentatte ganger basert på angitte aktivitetsnivåer.

# RoleplayResetSelect
config-select-placeholder-reset-period = Velg tilbakestillingsperiode
config-select-option-hourly = Hver time
config-select-desc-hourly = Tilbakestilles hver time.
config-select-option-daily = Daglig
config-select-desc-daily = Tilbakestilles hver 24. time.
config-select-option-weekly = Ukentlig
config-select-desc-weekly = Tilbakestilles hver 7. dag.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Velg tilbakestillingsdag

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Velg tilbakestillingstid (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Velg en forumkanal

# ForumThreadSelect
config-select-placeholder-thread = Velg en tråd
config-select-option-no-threads = Ingen aktive tråder funnet
config-select-desc-no-threads = Opprett en ny tråd eller sjekk arkiverte tråder
config-select-option-select-forum-first = Velg et forum først
config-select-desc-select-forum-first = Vennligst velg en forumkanal ovenfor
config-select-desc-thread-id = Tråd-ID: { $threadId }
config-error-select-valid-thread = Vennligst velg en gyldig tråd eller opprett en ny.
config-error-thread-not-found = Kunne ikke finne den valgte tråden. Den kan ha blitt slettet eller arkivert.

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = Serverkonfigurasjon - Hovedmeny
config-menu-config-wizard = Konfigurasjonsveiviser
config-menu-desc-config-wizard = Valider at serveren din er klar til å bruke ReQuest med en rask skanning.
config-menu-channels = Kanaler
config-menu-desc-channels = Angi dedikerte kanaler for ReQuest-innlegg.
config-menu-currency = Valuta
config-menu-desc-currency = Globale valutainnstillinger.
config-menu-players = Spillere
config-menu-desc-players = Globale spillerinnstillinger, som erfaringspoengsporing.
config-menu-quests = Quester
config-menu-desc-quests = Globale quest-innstillinger, som ventelister.
config-menu-rp-rewards = RP-belønninger
config-menu-desc-rp-rewards = Konfigurer rollespillbelønninger.
config-menu-roles = Roller
config-menu-desc-roles = Konfigurasjonsalternativer for pingbare eller privilegerte roller.
config-menu-shops = Butikker
config-menu-desc-shops = Konfigurer tilpassede butikker.
config-menu-language = Språk
config-menu-desc-language = Angi standardspråket for denne serveren.

## Wizard View
config-title-wizard = {"**"}Serverkonfigurasjon - Veiviser{"**"}
config-wizard-intro =
    {"**"}Velkommen til ReQuest-konfigurasjonsveiviseren!{"**"}

    Denne veiviseren hjelper deg med å sikre at serveren din er riktig konfigurert for å bruke ReQuests funksjoner.
    Den vil skanne gjeldende innstillinger og gi anbefalinger for eventuelle justeringer.

    Bruk «Start skanning»-knappen nedenfor for å starte valideringsprosessen. Når skanningen er fullført,
    vil du motta en detaljert rapport om serverens konfigurasjon sammen med eventuelle anbefalte endringer.

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}Botens globale tillatelser{"**"}__
config-wizard-bot-permissions-desc = Denne seksjonen verifiserer at ReQuest har de riktige tillatelsene til å fungere korrekt.
config-wizard-bot-role = Botrolle: { $roleMention }
config-wizard-status-warnings = {"**"}Status: ⚠️ ADVARSLER FUNNET{"**"}
config-wizard-missing-perm = - ⚠️ Mangler: `{ $permissionName }`
config-wizard-ensure-permissions = Vennligst sørg for at botens høyeste rolle har disse tillatelsene gitt globalt.
config-wizard-status-ok = {"**"}Status: ✅ OK{"**"}
config-wizard-bot-permissions-ok = Boten har alle nødvendige globale tillatelser.
config-wizard-status-scan-failed = {"**"}Status: ❌ SKANNING MISLYKTES{"**"}
config-wizard-scan-error = En uventet feil oppstod under sjekk av bottillatelser.
config-wizard-error-type = Feil: { $errorType }
config-wizard-required-permissions = {"**"}Nødvendige tillatelser for botens rolle:{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = Vis kanaler
config-wizard-perm-manage-roles = Administrer roller
config-wizard-perm-send-messages = Send meldinger
config-wizard-perm-attach-files = Legg ved filer
config-wizard-perm-add-reactions = Legg til reaksjoner
config-wizard-perm-use-external-emoji = Bruk eksterne emojier
config-wizard-perm-manage-messages = Administrer meldinger
config-wizard-perm-read-message-history = Les meldingshistorikk

# Wizard - Role Validation
config-wizard-role-header = __{"**"}Rollekonfigurasjoner{"**"}__
config-wizard-role-desc =
    Denne seksjonen verifiserer følgende:

    - GM-roller (påkrevd) og kunngjøringsrolle (valgfri) er konfigurert.
    - Standardrollen (@everyone) har nødvendige tillatelser for at brukere kan bruke botens funksjoner.
    - Standardrollen (@everyone) har ikke farlige tillatelser.
    - GM- og kunngjøringsroller sjekkes for eventuelle tillatelseseskaleringer utover standardrollen.

    Eventuelle advarsler her er utelukkende anbefalinger basert på et standardoppsett. Avhengig av serverens behov kan du ha grunn til å se bort fra noen av disse anbefalingene.

config-wizard-default-role-label = {"**"}Standardrolle:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Farlige tillatelser funnet:
config-wizard-default-role-ok = - ✅ @everyone: OK
config-wizard-missing-permission = - Manglende tillatelse: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}GM-roller:{"**"}
config-wizard-no-gm-roles = - ⚠️ Ingen GM-roller konfigurert
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Konfigurert rolle ikke funnet/slettet fra serveren
config-wizard-role-ok = - ✅ { $roleMention }: OK
config-wizard-announcement-role-label = {"**"}Kunngjøringsrolle:{"**"}
config-wizard-no-announcement-role = - ℹ️ Ingen kunngjøringsrolle konfigurert
config-wizard-announcement-role-not-found = - ⚠️ Konfigurert rolle ikke funnet/slettet fra serveren
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Tillatelseseskaleringer oppdaget - { $escalations }
config-wizard-escalation-more = , og { $count } til...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = Send meldinger i tråder
config-wizard-perm-use-application-commands = Bruk applikasjonskommandoer

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = Administrer kanaler
config-wizard-perm-manage-webhooks = Administrer webhooks
config-wizard-perm-manage-server = Administrer server
config-wizard-perm-manage-nicknames = Administrer kallenavn
config-wizard-perm-kick-members = Spark medlemmer
config-wizard-perm-ban-members = Utesteng medlemmer
config-wizard-perm-timeout-members = Timeout medlemmer
config-wizard-perm-mention-everyone = Nevn @everyone
config-wizard-perm-manage-threads = Administrer tråder
config-wizard-perm-administrator = Administrator

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}Kanalkonfigurasjoner{"**"}__
config-wizard-channel-desc =
    Denne seksjonen verifiserer følgende:

    - Konfigurerte kanaler eksisterer.
    - Boten har tillatelse til å vise og sende meldinger i de konfigurerte kanalene.
    - Standardrollen (@everyone) har ikke `Send meldinger`-tillatelser.

config-wizard-channel-no-config-required = - ⚠️ Ingen kanal konfigurert
config-wizard-channel-not-configured = - ℹ️ Ikke konfigurert (valgfri)
config-wizard-channel-not-found = - ⚠️ Konfigurert kanal ikke funnet/slettet fra serveren
config-wizard-channel-ok = - ✅ OK
config-wizard-bot-cannot-view = - ⚠️ { $botMention } kan ikke se denne kanalen.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } kan ikke sende meldinger i denne kanalen.
config-wizard-everyone-can-send = - ⚠️ @everyone kan sende meldinger i denne kanalen.

# Wizard - Channel names
config-wizard-channel-quest-board = Quest-tavle
config-wizard-channel-player-board = Spillertavle
config-wizard-channel-quest-archive = Quest-arkiv
config-wizard-channel-gm-transaction-log = GM-transaksjonslogg
config-wizard-channel-player-transaction-log = Spillertransaksjonslogg
config-wizard-channel-shop-log = Butikklogg
config-wizard-channel-approval-queue = Godkjenningskø for karakterer

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}Innstillingsoversikt{"**"}__
config-wizard-dashboard-desc = Denne seksjonen gir en oversikt over ikke-essensielle konfigurasjoner for rask referanse.
config-wizard-quest-settings = {"**"}Quest-innstillinger{"**"}
config-wizard-quest-wait-list = - Quest-ventelistestørrelse: { $size }
config-wizard-quest-summary = - Quest-sammendrag: { $status }
config-wizard-gm-rewards-per-quest = {"**"}GM-belønninger (per quest){"**"}
config-wizard-player-settings = {"**"}Spillerinnstillinger{"**"}
config-wizard-player-experience = - Spillererfaring: { $status }
config-wizard-currency-settings = {"**"}Valutainnstillinger{"**"}
config-wizard-rp-rewards = {"**"}Rollespillbelønninger{"**"}
config-wizard-rp-status = - Status: { $status }
config-wizard-rp-mode = - Modus: { $mode }
config-wizard-rp-channels = - Overvåkede kanaler: { $count }
config-wizard-shops = {"**"}Butikker{"**"}
config-wizard-shops-count = - Konfigurerte butikker: { $count }
config-wizard-shops-more = - ...og { $count } til
config-wizard-new-char-setup = {"**"}Oppsett for ny karakter{"**"}
config-wizard-inventory-type = - Inventartype: { $type }
config-wizard-new-char-shop-items = - Gjenstander i ny karakter-butikk: { $count }
config-wizard-static-kits = - Statiske sett: { $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ Ingen valutaer konfigurert
config-wizard-configured-currencies = {"**"}Konfigurerte valutaer:{"**"}
config-wizard-no-denominations = - Ingen valører konfigurert
config-wizard-gm-rewards-disabled = {"**"}Status:{"**"} Deaktivert
config-wizard-gm-rewards-enabled = {"**"}Status:{"**"} Aktivert
config-wizard-gm-rewards-experience = - Erfaring: { $xp }
config-wizard-gm-rewards-items = - Gjenstander:
config-wizard-unnamed-shop = Navnløs butikk

## Roles View
config-title-roles = {"**"}Serverkonfigurasjon - Roller{"**"}
config-label-announcement-role = {"**"}Kunngjøringsrolle:{"**"} { $status }
config-desc-announcement-role = Denne rollen nevnes når en quest publiseres.
config-label-announcement-role-default = {"**"}Kunngjøringsrolle:{"**"} Ikke konfigurert
config-label-gm-roles = {"**"}GM-rolle(r):{"**"} { $roles }
config-desc-gm-roles = Disse rollene gir tilgang til spillleder-kommandoer og -funksjoner.
config-label-gm-roles-default = {"**"}GM-rolle(r):{"**"} Ikke konfigurert
config-title-forbidden-roles = __{"**"}Forbudte roller{"**"}__
config-desc-forbidden-roles =
    Konfigurerer en liste over rollenavn som ikke kan brukes av spillledere for sine grupperoller.
    Som standard kan `everyone`, `administrator`, `gm` og `game master` ikke brukes. Denne konfigurasjonen
    utvider den listen.

## GM Role Remove View
config-title-remove-gm-roles = {"**"}Serverkonfigurasjon - Fjern GM-rolle(r){"**"}
config-msg-no-gm-roles = Ingen GM-roller konfigurert.

## Channels View
config-title-channels = {"**"}Serverkonfigurasjon - Kanaler{"**"}

config-label-quest-board = {"**"}Quest-tavle:{"**"} { $channel }
config-desc-quest-board = Kanalen der nye/aktive quester vil bli publisert.
config-label-quest-board-default = {"**"}Quest-tavle:{"**"} Ikke konfigurert

config-label-player-board = {"**"}Spillertavle:{"**"} { $channel }
config-desc-player-board = En valgfri kunngjørings-/meldingstavle for bruk av spillere.
config-label-player-board-default = {"**"}Spillertavle:{"**"} Ikke konfigurert

config-label-quest-archive = {"**"}Quest-arkiv:{"**"} { $channel }
config-desc-quest-archive = En valgfri kanal der fullførte quester flyttes til, med sammendragsinformasjon.
config-label-quest-archive-default = {"**"}Quest-arkiv:{"**"} Ikke konfigurert

config-label-gm-transaction-log = {"**"}GM-transaksjonslogg:{"**"} { $channel }
config-desc-gm-transaction-log = En valgfri kanal der GM-transaksjoner (dvs. Endre spiller-kommandoer) logges.
config-label-gm-transaction-log-default = {"**"}GM-transaksjonslogg:{"**"} Ikke konfigurert

config-label-player-transaction-log = {"**"}Spillertransaksjonslogg:{"**"} { $channel }
config-desc-player-transaction-log = En valgfri kanal der spillertransaksjoner som bytting og forbruk av gjenstander logges.
config-label-player-transaction-log-default = {"**"}Spillertransaksjonslogg:{"**"} Ikke konfigurert

config-label-shop-log = {"**"}Butikklogg:{"**"} { $channel }
config-desc-shop-log = En valgfri kanal der butikktransaksjoner logges.
config-label-shop-log-default = {"**"}Butikklogg:{"**"} Ikke konfigurert

## Quests View
config-title-quests = {"**"}Serverkonfigurasjon - Quester{"**"}

config-label-wait-list = {"**"}Quest-ventelistestørrelse:{"**"} { $size }
config-desc-wait-list = En venteliste lar det angitte antallet spillere stå i kø for en quest som er full, i tilfelle en spiller trekker seg.
config-label-wait-list-disabled = {"**"}Quest-ventelistestørrelse:{"**"} Deaktivert

config-label-quest-summary = {"**"}Quest-sammendrag:{"**"} { $status }
config-desc-quest-summary = Dette alternativet lar spillledere gi et kort sammendrag når quester avsluttes.
config-label-quest-summary-disabled = {"**"}Quest-sammendrag:{"**"} Deaktivert

config-label-gm-rewards = GM-belønninger
config-desc-gm-rewards = Konfigurer belønninger som spillledere mottar ved fullføring av quester.

## GM Rewards View
config-title-gm-rewards = {"**"}Serverkonfigurasjon - GM-belønninger{"**"}
config-desc-gm-rewards-detail =
    {"**"}Legg til/endre belønninger{"**"}
    Åpner et inndataskjema for å legge til, endre eller fjerne GM-belønninger.

    > Belønninger som konfigureres er per quest. Hver gang en spillleder fullfører en quest, vil de
    motta belønningene konfigurert nedenfor på sin aktive karakter.
config-msg-no-rewards = Ingen belønninger konfigurert.
config-label-gm-experience = {"**"}Erfaring:{"**"} { $xp }
config-label-gm-items = {"**"}Gjenstander:{"**"}

## Players View
config-title-players = {"**"}Serverkonfigurasjon - Spillere{"**"}

config-label-player-experience = {"**"}Spillererfaring:{"**"} { $status }
config-desc-player-experience = Aktiverer/deaktiverer bruk av erfaringspoeng (eller lignende verdibasert karakterprogresjon).
config-label-player-experience-disabled = {"**"}Spillererfaring:{"**"} Deaktivert

config-label-new-char-settings = {"**"}Innstillinger for ny karakter{"**"}
config-desc-new-char-settings = Konfigurer innstillinger relatert til nye spillerkarakterer og hvordan deres startinventar settes opp.

config-label-player-board-purge = {"**"}Tømming av spillertavle{"**"}
config-desc-player-board-purge = Tømmer innlegg fra spillertavlen (hvis aktivert).

## New Character Settings View
config-title-new-character = {"**"}Serverkonfigurasjon - Innstillinger for ny karakter{"**"}

config-label-inventory-type = {"**"}Inventartype for ny karakter:{"**"} { $type }
config-desc-inventory-type = Bestemmer hvordan nyregistrerte karakterer initialiserer sine inventarer.
config-label-inventory-type-disabled = {"**"}Inventartype for ny karakter:{"**"} Deaktivert

config-label-new-char-wealth = {"**"}Startformue for ny karakter:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Startformue for ny karakter:{"**"} Deaktivert

config-label-approval-queue = {"**"}Godkjenningskø:{"**"} { $channel }
config-desc-approval-queue = Hvis angitt, må nye karakterer godkjennes av en GM i denne forumkanalen før de er aktive.
config-label-approval-queue-disabled = {"**"}Godkjenningskø:{"**"} Deaktivert
config-label-approval-queue-not-configured = {"**"}Godkjenningskø:{"**"} Ikke konfigurert

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = Spillere starter med tomme inventarer.
config-desc-inv-type-selection = Spillere velger gjenstander fritt fra ny karakter-butikken.
config-desc-inv-type-purchase = Spillere kjøper gjenstander fra ny karakter-butikken med et gitt beløp valuta.
config-desc-inv-type-open = Spillere skriver inn sine inventargjenstander manuelt.
config-desc-inv-type-static = Spillere får et forhåndsdefinert startinventar.

## New Character Shop View
config-title-new-char-shop = {"**"}Serverkonfigurasjon - Ny karakter-butikk{"**"}
config-label-inv-type-selection = {"**"}Inventartype:{"**"} Utvalg
config-desc-inv-type-selection-shop = Spillere velger gjenstander fritt fra ny karakter-butikken.
config-label-inv-type-purchase = {"**"}Inventartype:{"**"} Kjøp
config-desc-inv-type-purchase-shop = Spillere kjøper gjenstander fra ny karakter-butikken med et gitt beløp valuta.
config-label-inv-type-other = {"**"}Inventartype:{"**"} { $type }
config-desc-inv-type-not-in-use = Ny karakter-butikken er ikke i bruk.
config-msg-define-shop-items = Definer butikkgjenstandene.
config-msg-no-items = Ingen gjenstander konfigurert.

## Static Kits View
config-title-static-kits = {"**"}Serverkonfigurasjon - Statiske sett{"**"}
config-desc-create-kit = Opprett en ny settdefinisjon.
config-msg-no-kits = Ingen sett konfigurert.
config-label-kit-more-items = ...og { $count } gjenstander til
config-label-empty-kit = {"*"}Tomt sett{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}Redigerer sett: { $kitName }{"**"}
config-msg-kit-empty = Dette settet er tomt. Bruk knappene ovenfor for å legge til valuta eller gjenstander.
config-label-kit-currency = {"**"}Valuta:{"**"} { $display }
config-label-kit-item = {"**"}Gjenstand:{"**"} { $name }

## Currency View
config-title-currency = {"**"}Serverkonfigurasjon - Valuta{"**"}
config-desc-create-currency = Opprett en ny valuta.
config-msg-no-currencies = Ingen valutaer konfigurert.
config-label-currency-display-type = Visningstype: { $type } | Valører: { $count }
config-label-currency-type-double = Desimal
config-label-currency-type-integer = Heltall

## Edit Currency View
config-title-manage-currency = {"**"}Administrer valuta: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Valuta og valører{"**"}__
    - Det gitte navnet på valutaen din regnes som basisvalutaen og har en verdi på 1.
    {"```"}Eksempel: "gull" er konfigurert som en valuta.{"```"}
    - Å legge til en valør krever at du oppgir et navn og en verdi relativt til basisvalutaen.
    {"```"}Eksempel: Gull får to valører: sølv (verdi 0.1) og kobber (verdi 0.01).{"```"}
    - Alle transaksjoner som involverer en basisvaluta eller dens valører vil automatisk konvertere dem.
    {"```"}Eksempel: En spiller har 10 gull og bruker 3 kobber. Den nye saldoen vil automatisk vise
    9 gull, 9 sølv og 7 kobber.{"```"}
    - Valutaer som vises som heltall vil vise hver valør, mens valutaer som vises som desimal
    bare vil vises som basisvalutaen.
    {"```"}Eksempel: Spilleren ovenfor med desimalvisning aktivert vil vises som 9.97 gull.{"```"}
config-btn-toggle-display-current = Veksle visning (nåværende: { $type })
config-msg-no-denominations = Ingen valører konfigurert.

## Shops View
config-title-shops = {"**"}Serverkonfigurasjon - Butikker{"**"}
config-desc-add-shop-wizard =
    {"**"}Legg til butikk (veiviser){"**"}
    Opprett en ny, tom butikk fra et skjema.
config-desc-add-shop-json =
    {"**"}Legg til butikk (JSON){"**"}
    Opprett en ny butikk ved å oppgi en fullstendig JSON-definisjon. (Avansert)
config-btn-example-json = Eksempel JSON
config-desc-example-json =
    {"**"}Eksempel JSON{"**"}
    Last ned en eksempel JSON-fil som viser det forventede formatet.
config-msg-example-json = Her er en eksempel JSON-fil som viser det forventede formatet.
config-msg-no-shops = Ingen butikker konfigurert.
config-label-shop-type-forum = (Forum)
config-label-shop-channel = Kanal: <#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}Legg til butikk - Velg plassering{"**"}
config-label-text-channel = {"**"}Tekstkanal{"**"}
config-desc-text-channel = Opprett en butikk i en standard tekstkanal.
config-label-forum-thread = {"**"}Forumtråd{"**"}
config-desc-forum-thread = Opprett en butikk i en forumtråd (ny eller eksisterende).

## Forum Shop Setup View
config-title-forum-setup = {"**"}Legg til butikk - Forumtråd-oppsett{"**"}
config-label-step1 = {"**"}Steg 1: Velg en forumkanal{"**"}
config-label-step2 = {"**"}Steg 2: Velg trådalternativ{"**"}
config-label-step3 = {"**"}Steg 3: Velg en eksisterende tråd{"**"}
config-desc-create-new-thread =
    {"**"}Opprett ny tråd{"**"}
    Åpner et skjema for å opprette en ny tråd og konfigurere butikken.
config-label-selected-thread = {"**"}Valgt tråd:{"**"} { $threadName }
config-desc-click-to-configure = Klikk for å konfigurere butikken i denne tråden.

## Manage Shop View
config-title-manage-shop = {"**"}Administrer butikk: { $shopName }{"**"}
config-label-shop-type = {"**"}Type:{"**"} { $type }
config-label-shop-type-text = Tekstkanal
config-label-shop-type-forum-thread = Forumtråd
config-label-shopkeeper = {"**"}Butikkeier:{"**"} { $name }
config-label-shop-description = {"**"}Beskrivelse:{"**"} { $description }
config-label-shop-channel-info = {"**"}Kanal:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Rediger butikkdetaljer og gjenstander via veiviseren.
config-desc-upload-json = Last opp en ny JSON-definisjon for denne butikken.
config-desc-download-json = Last ned gjeldende JSON-definisjon.
config-desc-remove-shop = Fjern denne butikken permanent.

## Edit Shop View
config-title-editing-shop = {"**"}Redigerer butikk: { $shopName }{"**"}
config-label-shop-shopkeeper = Butikkeier: {"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}Lagerkonfigurasjon: { $shopName }{"**"}
config-label-current-utc = Gjeldende UTC-tid: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Påfyllingsplan:{"**"} { $schedule }
config-label-restock-hourly = ved minutt :{ $minute }
config-label-restock-daily = kl. { $time } UTC
config-label-restock-weekly = på { $day } kl. { $time } UTC
config-label-restock-mode = {"**"}Modus:{"**"} { $mode }
config-label-restock-full = Full påfylling
config-label-restock-incremental = Gradvis (mengder per vare)
config-label-restock-disabled = {"**"}Påfyllingsplan:{"**"} Deaktivert
config-label-item-stock-limits = {"**"}Lagergrenser for gjenstander{"**"}
config-msg-no-items-in-shop = Ingen gjenstander i denne butikken.
config-label-stock-with-available = Maks: { $max } | Tilgjengelig: { $available }
config-label-stock-increment = Påfylling: +{ $increment }/syklus
config-label-stock-reserved =  | Reservert: { $reserved }
config-label-stock-not-initialized = Maks: { $max } | Tilgjengelig: (ikke initialisert)
config-label-stock-unlimited = Lager: Ubegrenset

## Roleplay View
config-title-roleplay = {"**"}Serverkonfigurasjon - Rollespillbelønninger{"**"}
config-label-rp-status = {"**"}Status:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Servertid:{"**"} `{ $time }`
config-label-rp-enabled = Aktivert
config-label-rp-disabled = Deaktivert

config-desc-rp-mode-scheduled = {"```"}Belønninger deles ut én gang ved sending av nødvendig antall kvalifiserte meldinger innenfor den angitte tidsperioden (hver time, daglig eller ukentlig).{"```"}
config-desc-rp-mode-accrued = {"```"}Belønninger deles ut gjentatte ganger hver gang et angitt antall kvalifiserte meldinger sendes.{"```"}

config-label-rp-config-details = {"**"}Konfigurasjonsdetaljer:{"**"}
config-label-rp-mode = {"**"}Modus:{"**"} { $mode }
config-label-rp-min-length = {"**"}Minimum meldingslengde:{"**"} { $length } tegn
config-label-rp-cooldown = {"**"}Nedkjøling:{"**"} { $seconds } sekunder
config-label-rp-frequency-once = {"**"}Frekvens:{"**"} Én gang per { $period }
config-label-rp-reset-time = {"**"}Tilbakestillingstid:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Terskel:{"**"} { $count } kvalifiserte meldinger
config-label-rp-frequency-every = {"**"}Frekvens:{"**"} Hver { $count } kvalifiserte meldinger

config-label-rp-channels = {"**"}Rollespillkanaler:{"**"}
config-msg-rp-no-channels = Ingen konfigurert.
config-label-rp-channels-more = ...og { $count } til.

config-label-rp-rewards = {"**"}Belønninger:{"**"}
config-msg-rp-no-rewards = Ingen konfigurert.
config-label-rp-experience = {"**"}Erfaring:{"**"} { $xp }
config-label-rp-items = {"**"}Gjenstander:{"**"}
config-label-rp-currency = {"**"}Valuta:{"**"}

## Language View
config-title-language = {"**"}Serverkonfigurasjon - Språk{"**"}
config-server-language-help =
    Denne innstillingen lar deg angi standardspråket for ReQuests {"**"}offentlige{"**"} svar og meldinger på denne serveren. Offentlige svar inkluderer:
    - Quest- og spillertavleinnlegg
    - Quest-sammendrag og loggkanalmeldinger
    - Butikkpåfylling
    - Spillerens forbruk av gjenstander

    Denne innstillingen påvirker bare statisk tekst generert av boten, og oversetter ikke dynamisk innhold som brukerinntastede gjenstandsnavn eller quest-beskrivelser.

    Personlige svar og menyer påvirkes ikke av denne innstillingen.
config-label-server-language = {"**"}Serverspråk:{"**"} { $language }
config-label-server-language-default = {"**"}Serverspråk:{"**"} Standard (ingen overstyring)
config-select-placeholder-server-language = Velg serverspråk
config-select-option-default = Standard (ingen overstyring)
config-select-desc-default = Bruk hver brukers preferanse eller Discord-lokale.

# Quest-roller
config-btn-quest-roles = Quest-roller
config-btn-manage-gm-quest-roles = Administrer

config-modal-title-confirm-quest-role-removal = Bekreft rollefjerning
config-modal-label-remove-quest-role = Fjerne { $roleName } fra { $gmName }?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Velg quest-rollemodus
config-select-option-quest-role-disabled = Deaktivert
config-select-desc-quest-role-disabled = Ingen roller opprettes eller tildeles.
config-select-option-quest-role-temporary = Midlertidig
config-select-desc-quest-role-temporary = Spillledere kan opprette midlertidige roller per quest.
config-select-option-quest-role-static = Statisk
config-select-desc-quest-role-static = Spillledere velger fra forhåndstildelte serverroller.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Tildel serverrolle(r) til denne spilllederen

## Quest-roller visning
config-title-quest-roles = {"**"}Serverkonfigurasjon - Quest-roller{"**"}
config-label-quest-roles = Quest-roller
config-desc-quest-roles =
    Konfigurer hvordan grupperoller håndteres under quester.

config-label-quest-role-mode-disabled = {"**"}Quest-rollemodus:{"**"} Deaktivert
    Ingen roller opprettes eller tildeles under quester.
config-label-quest-role-mode-temporary = {"**"}Quest-rollemodus:{"**"} Midlertidig
    Spillledere kan valgfritt opprette en midlertidig rolle ved quest-opprettelse.
    Rollen slettes når questen fullføres eller avbrytes.
config-label-quest-role-mode-static = {"**"}Quest-rollemodus:{"**"} Statisk
    Spillledere velger fra forhåndstildelte serverroller. Roller tildeles
    gruppemedlemmer under quester, men slettes aldri.

## Statiske quest-rolletildelinger visning
config-title-static-quest-roles = {"**"}Serverkonfigurasjon - Statiske quest-rolletildelinger{"**"}
config-label-manage-assignments = Administrer rolletildelinger
config-desc-manage-assignments =
    Tildel eksisterende serverroller til spillledere for bruk under quester.
    Roller må være lavere enn ReQuests høyeste rolle i serverhierarkiet.
config-msg-no-gm-members = Ingen medlemmer med en spilllederrolle ble funnet på denne serveren.
config-label-no-roles-assigned = Ingen quest-roller tildelt

## GM quest-rolletildeling visning
config-title-gm-quest-role-assign = {"**"}Administrer quest-roller — { $gmName }{"**"}
config-error-unmanageable-roles = Følgende roller kan ikke tildeles fordi de administreres av en integrasjon, er standardrollen, eller er over ReQuests høyeste rolle: { $roles }
config-error-quest-role-limit = Denne spilllederen har nådd maksimalt { $limit } tildelte quest-roller.
config-label-quest-role-count = Tildelte roller: { $count }/{ $limit }
