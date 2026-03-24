## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = Wissen
config-btn-remove-gm-roles = GM-rollen verwijderen
config-btn-forbidden-roles = Verboden rollen

# Quests
config-btn-toggle-quest-summary = Quest-samenvatting wisselen
config-btn-toggle-player-experience = Spelerervaring wisselen
config-btn-toggle-display = Weergave wisselen
config-btn-purge-player-board = Spelerbord opschonen
config-btn-add-modify-rewards = Beloningen toevoegen/aanpassen

# Currency
config-btn-add-denomination = Denominatie toevoegen
config-btn-add-new-currency = Nieuwe valuta toevoegen
config-btn-remove-currency = Valuta verwijderen

# Shops - creation
config-btn-add-shop-wizard = Winkel toevoegen (Wizard)
config-btn-add-shop-json = Winkel toevoegen (JSON)
config-btn-edit-shop-wizard = Winkel bewerken (Wizard)
config-btn-edit-shop-json = Winkel bewerken (JSON)
config-btn-remove-shop = Winkel verwijderen
config-btn-add-item = Voorwerp toevoegen
config-btn-edit-shop-details = Winkelgegevens bewerken
config-btn-download-json = JSON downloaden
config-btn-done-editing = Klaar met bewerken
config-btn-scan-server-configs = Serverconfiguraties scannen
config-btn-re-scan = Opnieuw scannen

# New character shop
config-btn-upload-json = JSON uploaden
config-btn-configure-new-character-wealth = Startkapitaal configureren
config-btn-configure-new-character-shop = Nieuw-personagewinkel configureren
config-btn-clear-shop = Winkel legen
config-btn-configure-static-kits = Statische kits configureren
config-btn-new-character-settings = Nieuw-personage-instellingen
config-btn-disabled-no-currency = Uitgeschakeld (geen valuta geconfigureerd)
config-btn-disabled-no-wealth = Uitgeschakeld (geen startkapitaal geconfigureerd)

# Static kits
config-btn-create-new-kit = Nieuwe kit aanmaken
config-btn-delete-kit = Kit verwijderen
config-btn-add-currency = Valuta toevoegen

# Roleplay
config-btn-toggle-rp-rewards = RP-beloningen wisselen
config-btn-clear-channels = Kanalen wissen
config-btn-edit-settings = Instellingen bewerken
config-btn-configure-rewards = Beloningen configureren

# Stock
config-btn-stock-limits = Voorraadlimieten
config-btn-set-limit = Limiet instellen
config-btn-edit-limit = Limiet bewerken
config-btn-remove-limit = Limiet verwijderen
config-btn-configure-restock-schedule = Herbevoorrading configureren
config-btn-back-to-shop-editor = Terug naar winkelbewerker

# Forum shop
config-btn-create-new-thread = Nieuw topic aanmaken
config-btn-use-existing-thread = Bestaand topic gebruiken

# Wizard
config-btn-quit = Afsluiten
config-btn-configure-channels = Kanalen configureren
config-btn-configure-roles = Rollen configureren
config-btn-configure-quests = Quests configureren
config-btn-configure-players = Spelers configureren
config-btn-configure-currency = Valuta configureren
config-btn-configure-rp-rewards = RP-beloningen configureren
config-btn-configure-shops = Winkels configureren
config-btn-new-char-setup = Nieuw pers. instellen

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = Bevestig rolverwijdering
config-modal-title-confirm-removal = Bevestig verwijdering
config-modal-title-confirm-currency-removal = Bevestig valutaverwijdering
config-modal-title-confirm-shop-removal = Bevestig winkelverwijdering
config-modal-title-confirm-kit-deletion = Bevestig kitverwijdering
config-modal-title-confirm-remove-stock-limit = Bevestig verwijdering voorraadlimiet
config-modal-title-clear-shop = Bevestig winkel legen

# Confirm modal prompt labels
config-modal-label-remove-role = { $roleName } verwijderen?
config-modal-label-remove-denomination = { $denominationName } verwijderen?
config-modal-label-remove-currency = { $currencyName } verwijderen?
config-modal-label-shop-removal-warning = WAARSCHUWING: Deze actie is onomkeerbaar!
config-modal-label-kit-deletion-warning = WAARSCHUWING: Onomkeerbaar!
config-modal-label-remove-stock-limit = Typ BEVESTIG om de voorraadlimiet te verwijderen
config-modal-label-clear-shop = Alle items uit deze winkel verwijderen?

# Error messages from buttons
config-error-shop-data-not-found = Fout: Kan de gegevens van die winkel niet vinden.
config-msg-shop-json-download = Hier is de JSON-definitie voor {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Hier is de JSON-definitie voor de Nieuw-personagewinkel.
config-error-select-forum-first = Selecteer eerst een forumkanaal.
config-error-select-thread-first = Selecteer eerst een topic.

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Nieuwe valuta toevoegen
config-modal-label-currency-name = Valutanaam
config-error-currency-already-exists = Een valuta of denominatie met de naam { $name } bestaat al!

# RenameCurrencyModal
config-modal-title-rename-currency = Valuta hernoemen
config-modal-label-new-currency-name = Nieuwe valutanaam
config-error-currency-name-exists = Een valuta met de naam "{ $name }" bestaat al.
config-error-denomination-name-exists = Een denominatie met de naam "{ $name }" bestaat al.

# RenameDenominationModal
config-modal-title-rename-denomination = Denominatie hernoemen
config-modal-label-new-denomination-name = Nieuwe denominatienaam

# AddCurrencyDenominationModal
config-modal-title-add-denomination = { $currencyName }-denominatie toevoegen
config-modal-label-denomination-name = Naam
config-modal-placeholder-denomination-name = bijv. Zilver
config-modal-label-denomination-value = Waarde
config-modal-placeholder-denomination-value = bijv. 0.1
config-error-denomination-matches-currency = Nieuwe denominatienaam mag niet overeenkomen met een bestaande valuta op deze server! Bestaande valuta gevonden met de naam "{ $existingName }".
config-error-denomination-matches-denomination = Nieuwe denominatienaam mag niet overeenkomen met een bestaande denominatie op deze server! Bestaande denominatie gevonden met de naam "{ $denominationName }" onder de valuta "{ $currencyName }".
config-error-denomination-value-exists = Denominaties onder een enkele valuta moeten unieke waarden hebben! { $denominationName } heeft deze waarde al toegewezen.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Verboden rolnamen
config-modal-label-names = Namen
config-modal-placeholder-names = Voer namen in, gescheiden door komma's
config-msg-forbidden-roles-updated = Verboden rollen bijgewerkt!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Spelerbord opschonen
config-modal-label-age = Leeftijd
config-modal-placeholder-age = Voer de maximale berichtleeftijd (in dagen) in om te bewaren
config-msg-posts-purged = Berichten ouder dan { $days } dagen zijn opgeschoond!

# GMRewardsModal
config-modal-title-gm-rewards = Beloningen toevoegen/aanpassen
config-modal-label-experience = Ervaring
config-modal-placeholder-enter-number = Voer een nummer in
config-modal-label-items = Voorwerpen
config-modal-placeholder-items =
    Naam: Hoeveelheid
    Naam2: Hoeveelheid
    enz.
config-error-experience-invalid = Ervaring moet een geldig geheel getal zijn (bijv. 2000).
config-error-item-format-invalid = Ongeldig voorwerpformaat: "{ $item }". Elk voorwerp moet op een nieuwe regel staan, in het formaat "Naam: Hoeveelheid".

# ConfigShopDetailsModal
config-modal-title-shop-details = Winkelgegevens toevoegen/bewerken
config-modal-label-shop-channel = Selecteer een kanaal
config-modal-placeholder-shop-channel = Selecteer het kanaal voor deze winkel
config-modal-label-shop-name = Winkelnaam
config-modal-placeholder-shop-name = Voer de naam van de winkel in
config-modal-label-shopkeeper-name = Winkelier
config-modal-placeholder-shopkeeper-name = Voer de naam van de winkelier in
config-modal-label-shop-description = Winkelbeschrijving
config-modal-placeholder-shop-description = Voer een beschrijving voor de winkel in
config-modal-label-shop-image-url = Winkelafbeelding-URL
config-modal-placeholder-shop-image-url = Voer een URL in voor de winkelafbeelding
config-error-no-channel-selected = Geen kanaal geselecteerd voor de winkel.
config-error-shop-already-in-channel = Er is al een winkel geregistreerd in het geselecteerde kanaal. Kies een ander kanaal of bewerk de bestaande winkel.

# build_shop_header_view
config-label-shopkeeper = {"**"}Winkelier:{"**"} { $name }
config-msg-use-shop-command = Gebruik het `/shop`-commando om voorwerpen te bekijken en te kopen.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Forum-topicwinkel aanmaken
config-modal-label-thread-name = Topicnaam
config-modal-placeholder-thread-name = Voer de naam voor het winkeltopic in
config-error-forum-not-found = Kan het geselecteerde forumkanaal niet vinden.
config-error-shop-already-in-thread = Er is al een winkel geregistreerd in dit topic. Dit zou niet moeten voorkomen bij een nieuw topic.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Nieuwe winkel toevoegen via JSON
config-modal-label-upload-json = Upload een .json-bestand met de winkelgegevens
config-error-no-json-uploaded = Geen JSON-bestand geüpload voor de winkel.
config-error-file-must-be-json = Het geüploade bestand moet een JSON-bestand (.json) zijn.
config-error-invalid-json = Ongeldig JSON-formaat: { $error }
config-error-json-validation-failed = JSON voldoet niet aan het schema: { $error }

# ShopItemModal
config-modal-title-shop-item = Winkelvoorwerp toevoegen/bewerken
config-modal-label-item-name = Voorwerpnaam
config-modal-placeholder-item-name = Voer de naam van het voorwerp in
config-modal-label-item-description = Voorwerpbeschrijving
config-modal-placeholder-item-description = Voer een beschrijving voor het voorwerp in
config-modal-label-item-quantity = Voorwerphoeveelheid
config-modal-placeholder-item-quantity = Voer de hoeveelheid in die per aankoop verkocht wordt
config-modal-label-item-costs = Voorwerpkosten
config-modal-placeholder-item-costs = Bijv.: 10 goud + 5 zilver\nOF: 50 rep\n(Gebruik + voor EN, nieuwe regels voor OF)
config-error-item-quantity-positive = Voorwerphoeveelheid moet een positief geheel getal zijn.
config-error-cost-format-invalid = Ongeldig kostenformaat in optie: "{ $option }". Elke kost moet een bedrag en een valuta bevatten, gescheiden door een spatie, bijv. "10 goud".
config-error-cost-amount-invalid = Ongeldig bedrag "{ $amount }" voor valuta: "{ $currency }". Bedrag moet een positief getal zijn.
config-error-unknown-currency = Onbekende valuta `{ $currency }`. Gebruik een geldige valuta die voor deze server is geconfigureerd.
config-error-item-already-exists = Een voorwerp met de naam { $itemName } bestaat al in deze winkel.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Winkel bijwerken via JSON
config-modal-label-upload-new-json = Nieuwe JSON-definitie uploaden
config-error-no-file-uploaded = Er is geen bestand geüpload.
config-error-file-must-be-json-ext = Bestand moet een `.json`-bestand zijn.
config-error-json-validation-message = JSON-validatie mislukt: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Nieuw-personage-uitrusting toevoegen/bewerken
config-modal-placeholder-item-quantity-selection = Voer de hoeveelheid in die per selectie wordt ontvangen
config-modal-label-item-cost = Voorwerpkosten
config-error-cost-format-short = Ongeldig kostenformaat: '{ $component }'. Verwacht 'Bedrag Valuta'.
config-error-amount-invalid-short = Ongeldig bedrag '{ $amount }' voor valuta '{ $currency }'.
config-error-item-exists-new-char = Een voorwerp met de naam { $itemName } bestaat al in de Nieuw-personagewinkel.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Nieuw-personagewinkel uploaden (JSON)
config-error-no-json-uploaded-short = Geen JSON-bestand geüpload.
config-error-json-must-have-shopstock = JSON moet een 'shopStock'-array bevatten.
config-error-items-must-have-name-price = Alle voorwerpen moeten 'name' en 'price' hebben.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Startkapitaal instellen
config-modal-label-amount = Bedrag
config-modal-placeholder-amount = Voer het bedrag van deze valuta in.
config-modal-placeholder-currency-name = Voer de naam in van een valuta die op deze server is gedefinieerd
config-error-no-currencies-configured = Er zijn geen valuta's geconfigureerd op deze server.
config-error-currency-not-found = Valuta of denominatie met de naam { $name } niet gevonden. Gebruik een geldige valuta.

# CreateStaticKitModal
config-modal-title-create-kit = Nieuwe statische kit aanmaken
config-modal-label-kit-name = Kitnaam
config-modal-placeholder-kit-name = bijv. Krijger-starterkit
config-modal-label-description = Beschrijving
config-modal-placeholder-kit-description = Optionele beschrijving voor deze kit
config-error-kit-name-exists = Een statische kit met de naam "{ $kitName }" bestaat al. Kies een andere naam.

# StaticKitItemModal
config-modal-title-kit-item = Kitvoorwerp toevoegen/bewerken
config-modal-placeholder-kit-item-quantity = Voer de hoeveelheid van dit voorwerp in die in de kit opgenomen wordt

# StaticKitCurrencyModal
config-modal-title-kit-currency = Kitvaluta toevoegen
config-modal-placeholder-currency-eg = bijv. Goud
config-modal-placeholder-amount-eg = bijv. 100
config-error-amount-must-be-number = Bedrag moet een getal zijn.
config-error-no-currencies-on-server = Geen valuta's geconfigureerd op de server.
config-error-currency-not-found-short = Valuta "{ $currency }" niet gevonden.
config-error-denomination-not-found = Denominatie "{ $denomination }" niet gevonden in de valutaconfiguratie.

# RoleplaySettingsModal
config-modal-title-rp-settings = Roleplay-instellingen
config-modal-label-min-message-length = Minimale berichtlengte (tekens)
config-modal-placeholder-min-message-length = # tekens vereist voor een bericht om in aanmerking te komen. 0 voor geen limiet
config-modal-label-cooldown = Afkoeltijd (seconden)
config-modal-placeholder-cooldown = Wachttijd, in seconden, tussen het tellen van berichten als in aanmerking komend voor beloningen
config-modal-label-message-threshold = Berichtdrempel
config-modal-placeholder-message-threshold = Aantal berichten vereist om beloning te activeren
config-modal-label-frequency = Frequentie (# berichten)
config-modal-placeholder-frequency = Aantal in aanmerking komende berichten vereist om beloningen te verdienen
config-error-min-length-invalid = Minimale berichtlengte moet een niet-negatief geheel getal zijn.
config-error-cooldown-invalid = Afkoeltijd moet een niet-negatief geheel getal zijn.
config-error-threshold-invalid = Berichtdrempel moet een positief geheel getal zijn.
config-error-frequency-invalid = Frequentie moet een positief geheel getal zijn.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Roleplay-beloningen configureren
config-modal-label-items-name-quantity = Voorwerpen (Naam: Hoeveelheid)
config-modal-label-currency-name-amount = Valuta (Naam: Bedrag)
config-error-experience-non-negative = Ervaring moet een niet-negatief geheel getal zijn.
config-error-item-quantity-positive-named = Voorwerphoeveelheid voor "{ $itemName }" moet een positief geheel getal zijn.
config-error-currency-amount-positive = Valutabedrag voor "{ $currencyName }" moet een positief getal zijn.

# SetItemStockModal
config-modal-title-stock-limit = Voorraadlimiet: { $itemName }
config-modal-label-max-stock = Maximale voorraad
config-modal-placeholder-max-stock = Voer maximale voorraad in (bijv. 10)
config-modal-label-current-stock = Huidige voorraad
config-modal-placeholder-current-stock = Voer huidige beschikbare voorraad in
config-modal-label-restock-increment = Aanvulhoeveelheid (per cyclus)
config-modal-placeholder-restock-increment = Hoeveelheid per aanvulcyclus (standaard: 1)
config-error-max-stock-positive = Maximale voorraad moet een positief geheel getal zijn.
config-error-current-stock-non-negative = Huidige voorraad moet een niet-negatief geheel getal zijn.
config-error-current-exceeds-max = Huidige voorraad kan de maximale voorraad niet overschrijden.
config-error-item-not-in-shop = Voorwerp "{ $itemName }" niet gevonden in de winkel.

# RestockScheduleModal
config-modal-title-restock-schedule = Herbevoorrading configureren
config-modal-restock-schedule-label = Schema
config-modal-restock-schedule-none = Geen (Uitgeschakeld)
config-modal-restock-schedule-hourly = Elk uur
config-modal-restock-schedule-daily = Dagelijks
config-modal-restock-schedule-weekly = Wekelijks
config-modal-label-time = Tijd (UU:MM in UTC)
config-modal-desc-current-time = Huidige tijd: { $utcTime }
config-modal-placeholder-time = bijv. 14:30 voor 14:30 UTC
config-modal-restock-day-label = Dag van de week (alleen wekelijks)
config-modal-restock-mode-label = Aanvulmodus
config-modal-restock-mode-full = Volledig (reset naar maximum)
config-modal-restock-mode-incremental = Geleidelijk (hoeveelheid toevoegen)
config-error-time-format-invalid = Tijd moet in UU:MM-formaat zijn (bijv. 14:30).
config-error-increment-positive = Toevoegbedrag moet een positief geheel getal zijn.

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Zoek je { $configName }-kanaal

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Kies je quest-aankondigingsrol

# AddGMRoleSelect
config-select-placeholder-gm-roles = Kies je GM-rol(len)

# ConfigWaitListSelect
config-select-placeholder-wait-list = Selecteer wachtlijstgrootte
config-select-option-disabled = 0 (Uitgeschakeld)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Selecteer inventarismodus
config-select-option-disabled-label = Uitgeschakeld
config-select-desc-disabled = Spelers beginnen met lege inventarissen.
config-select-option-selection = Selectie
config-select-desc-selection = Spelers kiezen vrij voorwerpen uit de Nieuw-personagewinkel.
config-select-option-purchase = Aankoop
config-select-desc-purchase = Spelers kopen voorwerpen uit de Nieuw-personagewinkel met een gegeven bedrag aan valuta.
config-select-option-open = Open
config-select-desc-open = Spelers voeren handmatig hun eigen inventaris in.
config-select-option-static = Statisch
config-select-desc-static = Spelers krijgen een vooraf gedefinieerde startinventaris.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Selecteer in aanmerking komende kanalen

# RoleplayModeSelect
config-select-placeholder-rp-mode = Selecteer modus
config-select-option-scheduled = Gepland
config-select-desc-scheduled = Beloningen worden eenmaal uitgereikt binnen een gespecificeerde resetperiode.
config-select-option-accrued = Opgebouwd
config-select-desc-accrued = Beloningen worden herhaaldelijk uitgereikt op basis van gespecificeerde activiteitsniveaus.

# RoleplayResetSelect
config-select-placeholder-reset-period = Selecteer resetperiode
config-select-option-hourly = Elk uur
config-select-desc-hourly = Reset elk uur.
config-select-option-daily = Dagelijks
config-select-desc-daily = Reset elke 24 uur.
config-select-option-weekly = Wekelijks
config-select-desc-weekly = Reset elke 7 dagen.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Selecteer resetdag

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Selecteer resettijd (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Selecteer een forumkanaal

# ForumThreadSelect
config-select-placeholder-thread = Selecteer een topic
config-select-option-no-threads = Geen actieve topics gevonden
config-select-desc-no-threads = Maak een nieuw topic aan of bekijk gearchiveerde topics
config-select-option-select-forum-first = Selecteer eerst een forum
config-select-desc-select-forum-first = Selecteer hierboven eerst een forumkanaal
config-select-desc-thread-id = Topic-ID: { $threadId }
config-error-select-valid-thread = Selecteer een geldig topic of maak een nieuw aan.
config-error-thread-not-found = Kan het geselecteerde topic niet vinden. Het is mogelijk verwijderd of gearchiveerd.

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = Serverconfiguratie - Hoofdmenu
config-menu-config-wizard = Configuratiewizard
config-menu-desc-config-wizard = Controleer met een snelle scan of je server klaar is om ReQuest te gebruiken.
config-menu-channels = Kanalen
config-menu-desc-channels = Stel aangewezen kanalen in voor ReQuest-berichten.
config-menu-currency = Valuta
config-menu-desc-currency = Globale valuta-instellingen.
config-menu-players = Spelers
config-menu-desc-players = Globale spelerinstellingen, zoals het bijhouden van ervaringspunten.
config-menu-quests = Quests
config-menu-desc-quests = Globale quest-instellingen, zoals wachtlijsten.
config-menu-rp-rewards = RP-beloningen
config-menu-desc-rp-rewards = Roleplay-beloningen configureren.
config-menu-roles = Rollen
config-menu-desc-roles = Configuratieopties voor pingbare of geprivilegieerde rollen.
config-menu-shops = Winkels
config-menu-desc-shops = Aangepaste winkels configureren.
config-menu-language = Taal
config-menu-desc-language = Stel de standaardtaal in voor deze server.

## Wizard View
config-title-wizard = {"**"}Serverconfiguratie - Wizard{"**"}
config-wizard-intro =
    {"**"}Welkom bij de ReQuest-configuratiewizard!{"**"}

    Deze wizard helpt je ervoor te zorgen dat je server correct is geconfigureerd om de functies van ReQuest te gebruiken.
    Het scant je huidige instellingen en geeft aanbevelingen voor eventuele aanpassingen.

    Gebruik de knop "Scan starten" hieronder om het validatieproces te beginnen. Zodra de scan is voltooid,
    ontvang je een gedetailleerd rapport van de configuratie van je server samen met eventuele aanbevolen wijzigingen.

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}Globale botmachtigingen{"**"}__
config-wizard-bot-permissions-desc = Dit gedeelte controleert of ReQuest de juiste machtigingen heeft om correct te functioneren.
config-wizard-bot-role = Botrol: { $roleMention }
config-wizard-status-warnings = {"**"}Status: ⚠️ WAARSCHUWINGEN GEVONDEN{"**"}
config-wizard-missing-perm = - ⚠️ Ontbreekt: `{ $permissionName }`
config-wizard-ensure-permissions = Zorg ervoor dat de hoogste rol van de bot deze machtigingen globaal heeft toegekend.
config-wizard-status-ok = {"**"}Status: ✅ OK{"**"}
config-wizard-bot-permissions-ok = De bot heeft alle vereiste globale machtigingen.
config-wizard-status-scan-failed = {"**"}Status: ❌ SCAN MISLUKT{"**"}
config-wizard-scan-error = Er is een onverwachte fout opgetreden bij het controleren van botmachtigingen.
config-wizard-error-type = Fout: { $errorType }
config-wizard-required-permissions = {"**"}Vereiste machtigingen voor de botrol:{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = Kanalen bekijken
config-wizard-perm-manage-roles = Rollen beheren
config-wizard-perm-send-messages = Berichten versturen
config-wizard-perm-attach-files = Bestanden bijvoegen
config-wizard-perm-add-reactions = Reacties toevoegen
config-wizard-perm-use-external-emoji = Externe emoji gebruiken
config-wizard-perm-manage-messages = Berichten beheren
config-wizard-perm-read-message-history = Berichtgeschiedenis lezen

# Wizard - Role Validation
config-wizard-role-header = __{"**"}Rolconfiguraties{"**"}__
config-wizard-role-desc =
    Dit gedeelte controleert het volgende:

    - GM-rollen (vereist) en aankondigingsrol (optioneel) zijn geconfigureerd.
    - De standaard (@everyone) rol heeft de vereiste machtigingen voor gebruikers om botfuncties te gebruiken.
    - De standaard (@everyone) rol heeft geen gevaarlijke machtigingen.
    - GM- en aankondigingsrollen worden gecontroleerd op machtigingsescalaties ten opzichte van de standaardrol.

    Waarschuwingen hier zijn uitsluitend aanbevelingen op basis van een standaardconfiguratie. Afhankelijk van de behoeften van je server kun je redenen hebben om sommige van deze aanbevelingen te negeren.

config-wizard-default-role-label = {"**"}Standaardrol:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Gevaarlijke machtigingen gevonden:
config-wizard-default-role-ok = - ✅ @everyone: OK
config-wizard-missing-permission = - Ontbrekende machtiging: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}GM-rollen:{"**"}
config-wizard-no-gm-roles = - ⚠️ Geen GM-rollen geconfigureerd
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Geconfigureerde rol niet gevonden/verwijderd van de server
config-wizard-role-ok = - ✅ { $roleMention }: OK
config-wizard-announcement-role-label = {"**"}Aankondigingsrol:{"**"}
config-wizard-no-announcement-role = - ℹ️ Geen aankondigingsrol geconfigureerd
config-wizard-announcement-role-not-found = - ⚠️ Geconfigureerde rol niet gevonden/verwijderd van de server
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Machtigingsescalaties gedetecteerd - { $escalations }
config-wizard-escalation-more = , en { $count } meer...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = Berichten versturen in topics
config-wizard-perm-use-application-commands = Toepassingscommando's gebruiken

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = Kanalen beheren
config-wizard-perm-manage-webhooks = Webhooks beheren
config-wizard-perm-manage-server = Server beheren
config-wizard-perm-manage-nicknames = Bijnamen beheren
config-wizard-perm-kick-members = Leden verwijderen
config-wizard-perm-ban-members = Leden verbannen
config-wizard-perm-timeout-members = Leden time-out geven
config-wizard-perm-mention-everyone = @everyone vermelden
config-wizard-perm-manage-threads = Topics beheren
config-wizard-perm-administrator = Beheerder

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}Kanaalconfiguraties{"**"}__
config-wizard-channel-desc =
    Dit gedeelte controleert het volgende:

    - Geconfigureerde kanalen bestaan.
    - De bot heeft toestemming om berichten te bekijken en te versturen in de geconfigureerde kanalen.
    - De standaard (@everyone) rol heeft geen `Berichten versturen`-machtigingen.

config-wizard-channel-no-config-required = - ⚠️ Geen kanaal geconfigureerd
config-wizard-channel-not-configured = - ℹ️ Niet geconfigureerd (optioneel)
config-wizard-channel-not-found = - ⚠️ Geconfigureerd kanaal niet gevonden/verwijderd van de server
config-wizard-channel-ok = - ✅ OK
config-wizard-bot-cannot-view = - ⚠️ { $botMention } kan dit kanaal niet bekijken.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } kan geen berichten versturen in dit kanaal.
config-wizard-everyone-can-send = - ⚠️ @everyone kan berichten versturen in dit kanaal.

# Wizard - Channel names
config-wizard-channel-quest-board = Quest-bord
config-wizard-channel-player-board = Spelerbord
config-wizard-channel-quest-archive = Quest-archief
config-wizard-channel-gm-transaction-log = GM-transactielogboek
config-wizard-channel-player-transaction-log = Spelertransactielogboek
config-wizard-channel-shop-log = Winkellogboek
config-wizard-channel-approval-queue = Personagegoedkeuringswachtrij

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}Instellingendashboard{"**"}__
config-wizard-dashboard-desc = Dit gedeelte biedt een overzicht van niet-essentiële configuraties ter referentie.
config-wizard-quest-settings = {"**"}Quest-instellingen{"**"}
config-wizard-quest-wait-list = - Quest-wachtlijstgrootte: { $size }
config-wizard-quest-summary = - Quest-samenvatting: { $status }
config-wizard-gm-rewards-per-quest = {"**"}GM-beloningen (per quest){"**"}
config-wizard-player-settings = {"**"}Spelerinstellingen{"**"}
config-wizard-player-experience = - Spelerervaring: { $status }
config-wizard-currency-settings = {"**"}Valuta-instellingen{"**"}
config-wizard-rp-rewards = {"**"}Roleplay-beloningen{"**"}
config-wizard-rp-status = - Status: { $status }
config-wizard-rp-mode = - Modus: { $mode }
config-wizard-rp-channels = - Gemonitorde kanalen: { $count }
config-wizard-shops = {"**"}Winkels{"**"}
config-wizard-shops-count = - Geconfigureerde winkels: { $count }
config-wizard-shops-more = - ...en { $count } meer
config-wizard-new-char-setup = {"**"}Nieuw-personage-instelling{"**"}
config-wizard-inventory-type = - Inventaristype: { $type }
config-wizard-new-char-shop-items = - Nieuw-personagewinkelvoorwerpen: { $count }
config-wizard-static-kits = - Statische kits: { $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ Geen valuta's geconfigureerd
config-wizard-configured-currencies = {"**"}Geconfigureerde valuta's:{"**"}
config-wizard-no-denominations = - Geen denominaties geconfigureerd
config-wizard-gm-rewards-disabled = {"**"}Status:{"**"} Uitgeschakeld
config-wizard-gm-rewards-enabled = {"**"}Status:{"**"} Ingeschakeld
config-wizard-gm-rewards-experience = - Ervaring: { $xp }
config-wizard-gm-rewards-items = - Voorwerpen:
config-wizard-unnamed-shop = Naamloze winkel

## Roles View
config-title-roles = {"**"}Serverconfiguratie - Rollen{"**"}
config-label-announcement-role = {"**"}Aankondigingsrol:{"**"} { $status }
config-desc-announcement-role = Deze rol wordt vermeld wanneer een quest wordt geplaatst.
config-label-announcement-role-default = {"**"}Aankondigingsrol:{"**"} Niet geconfigureerd
config-label-gm-roles = {"**"}GM-rol(len):{"**"} { $roles }
config-desc-gm-roles = Deze rollen verlenen toegang tot Game Master-commando's en -functies.
config-label-gm-roles-default = {"**"}GM-rol(len):{"**"} Niet geconfigureerd
config-title-forbidden-roles = __{"**"}Verboden rollen{"**"}__
config-desc-forbidden-roles =
    Configureert een lijst van rolnamen die niet door Game Masters kunnen worden gebruikt voor hun groepsrollen.
    Standaard kunnen `everyone`, `administrator`, `gm` en `game master` niet worden gebruikt. Deze configuratie
    breidt die lijst uit.

## GM Role Remove View
config-title-remove-gm-roles = {"**"}Serverconfiguratie - GM-rol(len) verwijderen{"**"}
config-msg-no-gm-roles = Geen GM-rollen geconfigureerd.

## Channels View
config-title-channels = {"**"}Serverconfiguratie - Kanalen{"**"}

config-label-quest-board = {"**"}Quest-bord:{"**"} { $channel }
config-desc-quest-board = Het kanaal waar nieuwe/actieve quests worden geplaatst.
config-label-quest-board-default = {"**"}Quest-bord:{"**"} Niet geconfigureerd

config-label-player-board = {"**"}Spelerbord:{"**"} { $channel }
config-desc-player-board = Een optioneel aankondigings-/berichtenbord voor gebruik door spelers.
config-label-player-board-default = {"**"}Spelerbord:{"**"} Niet geconfigureerd

config-label-quest-archive = {"**"}Quest-archief:{"**"} { $channel }
config-desc-quest-archive = Een optioneel kanaal waar voltooide quests naartoe worden verplaatst, met samenvattingsinformatie.
config-label-quest-archive-default = {"**"}Quest-archief:{"**"} Niet geconfigureerd

config-label-gm-transaction-log = {"**"}GM-transactielogboek:{"**"} { $channel }
config-desc-gm-transaction-log = Een optioneel kanaal waar GM-transacties (bijv. Speler aanpassen-commando's) worden vastgelegd.
config-label-gm-transaction-log-default = {"**"}GM-transactielogboek:{"**"} Niet geconfigureerd

config-label-player-transaction-log = {"**"}Spelertransactielogboek:{"**"} { $channel }
config-desc-player-transaction-log = Een optioneel kanaal waar spelertransacties zoals handelen en het verbruiken van voorwerpen worden vastgelegd.
config-label-player-transaction-log-default = {"**"}Spelertransactielogboek:{"**"} Niet geconfigureerd

config-label-shop-log = {"**"}Winkellogboek:{"**"} { $channel }
config-desc-shop-log = Een optioneel kanaal waar winkeltransacties worden vastgelegd.
config-label-shop-log-default = {"**"}Winkellogboek:{"**"} Niet geconfigureerd

## Quests View
config-title-quests = {"**"}Serverconfiguratie - Quests{"**"}

config-label-wait-list = {"**"}Quest-wachtlijstgrootte:{"**"} { $size }
config-desc-wait-list = Een wachtlijst stelt het opgegeven aantal spelers in staat om in de rij te staan voor een quest die vol is, voor het geval een speler afhaakt.
config-label-wait-list-disabled = {"**"}Quest-wachtlijstgrootte:{"**"} Uitgeschakeld

config-label-quest-summary = {"**"}Quest-samenvatting:{"**"} { $status }
config-desc-quest-summary = Deze optie stelt GM's in staat om een korte samenvatting te geven bij het afsluiten van quests.
config-label-quest-summary-disabled = {"**"}Quest-samenvatting:{"**"} Uitgeschakeld

config-label-gm-rewards = GM-beloningen
config-desc-gm-rewards = Configureer beloningen die GM's ontvangen bij het voltooien van quests.

## GM Rewards View
config-title-gm-rewards = {"**"}Serverconfiguratie - GM-beloningen{"**"}
config-desc-gm-rewards-detail =
    {"**"}Beloningen toevoegen/aanpassen{"**"}
    Opent een invoervenster om GM-beloningen toe te voegen, aan te passen of te verwijderen.

    > Geconfigureerde beloningen gelden per quest. Elke keer dat een Game Master een quest voltooit, ontvangt
    deze de hieronder geconfigureerde beloningen op het actieve personage.
config-msg-no-rewards = Geen beloningen geconfigureerd.
config-label-gm-experience = {"**"}Ervaring:{"**"} { $xp }
config-label-gm-items = {"**"}Voorwerpen:{"**"}

## Players View
config-title-players = {"**"}Serverconfiguratie - Spelers{"**"}

config-label-player-experience = {"**"}Spelerervaring:{"**"} { $status }
config-desc-player-experience = Schakelt het gebruik van ervaringspunten (of vergelijkbare waardegebaseerde personageprogressie) in of uit.
config-label-player-experience-disabled = {"**"}Spelerervaring:{"**"} Uitgeschakeld

config-label-new-char-settings = {"**"}Nieuw-personage-instellingen{"**"}
config-desc-new-char-settings = Configureer instellingen met betrekking tot nieuwe spelerpersonages en hoe hun startinventaris wordt ingesteld.

config-label-player-board-purge = {"**"}Spelerbord opschonen{"**"}
config-desc-player-board-purge = Schoont berichten op van het spelerbord (indien ingeschakeld).

## New Character Settings View
config-title-new-character = {"**"}Serverconfiguratie - Nieuw-personage-instellingen{"**"}

config-label-inventory-type = {"**"}Inventaristype nieuw personage:{"**"} { $type }
config-desc-inventory-type = Bepaalt hoe nieuw geregistreerde personages hun inventaris initialiseren.
config-label-inventory-type-disabled = {"**"}Inventaristype nieuw personage:{"**"} Uitgeschakeld

config-label-new-char-wealth = {"**"}Startkapitaal nieuw personage:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Startkapitaal nieuw personage:{"**"} Uitgeschakeld

config-label-approval-queue = {"**"}Goedkeuringswachtrij:{"**"} { $channel }
config-desc-approval-queue = Indien ingesteld, moeten nieuwe personages door een GM worden goedgekeurd in dit Forum-kanaal voordat ze actief zijn.
config-label-approval-queue-disabled = {"**"}Goedkeuringswachtrij:{"**"} Uitgeschakeld
config-label-approval-queue-not-configured = {"**"}Goedkeuringswachtrij:{"**"} Niet geconfigureerd

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = Spelers beginnen met lege inventarissen.
config-desc-inv-type-selection = Spelers kiezen vrij voorwerpen uit de Nieuw-personagewinkel.
config-desc-inv-type-purchase = Spelers kopen voorwerpen uit de Nieuw-personagewinkel met een gegeven bedrag aan valuta.
config-desc-inv-type-open = Spelers voeren handmatig hun inventarisvoorwerpen in.
config-desc-inv-type-static = Spelers krijgen een vooraf gedefinieerde startinventaris.

## New Character Shop View
config-title-new-char-shop = {"**"}Serverconfiguratie - Nieuw-personagewinkel{"**"}
config-label-inv-type-selection = {"**"}Inventaristype:{"**"} Selectie
config-desc-inv-type-selection-shop = Spelers kiezen vrij voorwerpen uit de Nieuw-personagewinkel.
config-label-inv-type-purchase = {"**"}Inventaristype:{"**"} Aankoop
config-desc-inv-type-purchase-shop = Spelers kopen voorwerpen uit de Nieuw-personagewinkel met een gegeven bedrag aan valuta.
config-label-inv-type-other = {"**"}Inventaristype:{"**"} { $type }
config-desc-inv-type-not-in-use = Nieuw-personagewinkel is niet in gebruik.
config-msg-define-shop-items = Definieer de winkelvoorwerpen.
config-msg-no-items = Geen voorwerpen geconfigureerd.

## Static Kits View
config-title-static-kits = {"**"}Serverconfiguratie - Statische kits{"**"}
config-desc-create-kit = Maak een nieuwe kitdefinitie aan.
config-msg-no-kits = Geen kits geconfigureerd.
config-label-kit-more-items = ...en { $count } meer voorwerpen
config-label-empty-kit = {"*"}Lege kit{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}Kit bewerken: { $kitName }{"**"}
config-msg-kit-empty = Deze kit is leeg. Gebruik de knoppen hierboven om valuta of voorwerpen toe te voegen.
config-label-kit-currency = {"**"}Valuta:{"**"} { $display }
config-label-kit-item = {"**"}Voorwerp:{"**"} { $name }

## Currency View
config-title-currency = {"**"}Serverconfiguratie - Valuta{"**"}
config-desc-create-currency = Maak een nieuwe valuta aan.
config-msg-no-currencies = Geen valuta's geconfigureerd.
config-label-currency-display-type = Weergavetype: { $type } | Denominaties: { $count }
config-label-currency-type-double = Decimaal
config-label-currency-type-integer = Geheel getal

## Edit Currency View
config-title-manage-currency = {"**"}Valuta beheren: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Valuta en denominaties{"**"}__
    - De opgegeven naam van je valuta wordt beschouwd als de basisvaluta en heeft een waarde van 1.
    {"```"}Voorbeeld: "goud" is geconfigureerd als valuta.{"```"}
    - Het toevoegen van een denominatie vereist het opgeven van een naam en een waarde ten opzichte van de basisvaluta.
    {"```"}Voorbeeld: Goud krijgt twee denominaties: zilver (waarde 0.1) en koper (waarde 0.01).{"```"}
    - Alle transacties met een basisvaluta of de denominaties ervan worden automatisch omgerekend.
    {"```"}Voorbeeld: Een speler heeft 10 goud en geeft 3 koper uit. Het nieuwe saldo wordt automatisch weergegeven als
    9 goud, 9 zilver en 7 koper.{"```"}
    - Valuta's die als geheel getal worden weergegeven tonen elke denominatie, terwijl valuta's die als decimaal
    worden weergegeven alleen als basisvaluta worden getoond.
    {"```"}Voorbeeld: De speler hierboven met decimale weergave toont 9.97 goud.{"```"}
config-btn-toggle-display-current = Weergave wisselen (Huidig: { $type })
config-msg-no-denominations = Geen denominaties geconfigureerd.

## Shops View
config-title-shops = {"**"}Serverconfiguratie - Winkels{"**"}
config-desc-add-shop-wizard =
    {"**"}Winkel toevoegen (Wizard){"**"}
    Maak een nieuwe, lege winkel aan via een formulier.
config-desc-add-shop-json =
    {"**"}Winkel toevoegen (JSON){"**"}
    Maak een nieuwe winkel aan door een volledige JSON-definitie te verstrekken. (Geavanceerd)
config-btn-example-json = Voorbeeld JSON
config-desc-example-json =
    {"**"}Voorbeeld JSON{"**"}
    Download een voorbeeld JSON-bestand dat het verwachte formaat toont.
config-msg-example-json = Hier is een voorbeeld JSON-bestand dat het verwachte formaat toont.
config-msg-no-shops = Geen winkels geconfigureerd.
config-label-shop-type-forum = (Forum)
config-label-shop-channel = Kanaal: <#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}Winkel toevoegen - Kies locatietype{"**"}
config-label-text-channel = {"**"}Tekstkanaal{"**"}
config-desc-text-channel = Maak een winkel in een standaard tekstkanaal.
config-label-forum-thread = {"**"}Forum-topic{"**"}
config-desc-forum-thread = Maak een winkel in een forum-topic (nieuw of bestaand).

## Forum Shop Setup View
config-title-forum-setup = {"**"}Winkel toevoegen - Forum-topic instellen{"**"}
config-label-step1 = {"**"}Stap 1: Selecteer een forumkanaal{"**"}
config-label-step2 = {"**"}Stap 2: Kies topicoptie{"**"}
config-label-step3 = {"**"}Stap 3: Selecteer een bestaand topic{"**"}
config-desc-create-new-thread =
    {"**"}Nieuw topic aanmaken{"**"}
    Opent een formulier om een nieuw topic aan te maken en de winkel te configureren.
config-label-selected-thread = {"**"}Geselecteerd topic:{"**"} { $threadName }
config-desc-click-to-configure = Klik om de winkel in dit topic te configureren.

## Manage Shop View
config-title-manage-shop = {"**"}Winkel beheren: { $shopName }{"**"}
config-label-shop-type = {"**"}Type:{"**"} { $type }
config-label-shop-type-text = Tekstkanaal
config-label-shop-type-forum-thread = Forum-topic
config-label-shopkeeper = {"**"}Winkelier:{"**"} { $name }
config-label-shop-description = {"**"}Beschrijving:{"**"} { $description }
config-label-shop-channel-info = {"**"}Kanaal:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Bewerk winkelgegevens en voorwerpen via Wizard.
config-desc-upload-json = Upload een nieuwe JSON-definitie voor deze winkel.
config-desc-download-json = Download de huidige JSON-definitie.
config-desc-remove-shop = Verwijder deze winkel permanent.

## Edit Shop View
config-title-editing-shop = {"**"}Winkel bewerken: { $shopName }{"**"}
config-label-shop-shopkeeper = Winkelier: {"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}Voorraadconfiguratie: { $shopName }{"**"}
config-label-current-utc = Huidige UTC-tijd: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Herbevoorradingsschema:{"**"} { $schedule }
config-label-restock-hourly = op minuut :{ $minute }
config-label-restock-daily = om { $time } UTC
config-label-restock-weekly = op { $day } om { $time } UTC
config-label-restock-mode = {"**"}Modus:{"**"} { $mode }
config-label-restock-full = Volledige herbevoorrading
config-label-restock-incremental = Geleidelijk (hoeveelheden per item)
config-label-restock-disabled = {"**"}Herbevoorradingsschema:{"**"} Uitgeschakeld
config-label-item-stock-limits = {"**"}Voorraadlimieten per voorwerp{"**"}
config-msg-no-items-in-shop = Geen voorwerpen in deze winkel.
config-label-stock-with-available = Max: { $max } | Beschikbaar: { $available }
config-label-stock-increment = Aanvulling: +{ $increment }/cyclus
config-label-stock-reserved = Gereserveerd: { $reserved }
config-label-stock-not-initialized = Max: { $max } | Beschikbaar: (niet geïnitialiseerd)
config-label-stock-unlimited = Voorraad: Onbeperkt

## Roleplay View
config-title-roleplay = {"**"}Serverconfiguratie - Roleplay-beloningen{"**"}
config-label-rp-status = {"**"}Status:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Servertijd:{"**"} `{ $time }`
config-label-rp-enabled = Ingeschakeld
config-label-rp-disabled = Uitgeschakeld

config-desc-rp-mode-scheduled = {"```"}Beloningen worden eenmaal uitgereikt na het versturen van het vereiste aantal in aanmerking komende berichten binnen de ingestelde tijdsperiode (elk uur, dagelijks of wekelijks).{"```"}
config-desc-rp-mode-accrued = {"```"}Beloningen worden herhaaldelijk uitgereikt telkens wanneer een ingesteld aantal in aanmerking komende berichten is verstuurd.{"```"}

config-label-rp-config-details = {"**"}Configuratiedetails:{"**"}
config-label-rp-mode = {"**"}Modus:{"**"} { $mode }
config-label-rp-min-length = {"**"}Minimale berichtlengte:{"**"} { $length } tekens
config-label-rp-cooldown = {"**"}Afkoeltijd:{"**"} { $seconds } seconden
config-label-rp-frequency-once = {"**"}Frequentie:{"**"} Eenmaal per { $period }
config-label-rp-reset-time = {"**"}Resettijd:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Drempel:{"**"} { $count } in aanmerking komende berichten
config-label-rp-frequency-every = {"**"}Frequentie:{"**"} Elke { $count } in aanmerking komende berichten

config-label-rp-channels = {"**"}Roleplay-kanalen:{"**"}
config-msg-rp-no-channels = Geen geconfigureerd.
config-label-rp-channels-more = ...en { $count } meer.

config-label-rp-rewards = {"**"}Beloningen:{"**"}
config-msg-rp-no-rewards = Geen geconfigureerd.
config-label-rp-experience = {"**"}Ervaring:{"**"} { $xp }
config-label-rp-items = {"**"}Voorwerpen:{"**"}
config-label-rp-currency = {"**"}Valuta:{"**"}

## Language View
config-title-language = {"**"}Serverconfiguratie - Taal{"**"}
config-server-language-help =
    Met deze instelling kun je de standaardtaal specificeren voor de {"**"}openbare{"**"} reacties en berichten van ReQuest op deze server. Openbare reacties omvatten:
    - Quest- en spelerbordberichten
    - Quest-samenvatting en logkanaalberichten
    - Winkelherbevoorrading
    - Verbruik van spelervoorwerpen

    Deze instelling beïnvloedt alleen statische tekst die door de bot wordt gegenereerd, en vertaalt geen dynamische inhoud zoals door gebruikers ingevoerde voorwerpnamen of questbeschrijvingen.

    Persoonlijke reacties en menu's worden niet beïnvloed door deze instelling.
config-label-server-language = {"**"}Servertaal:{"**"} { $language }
config-label-server-language-default = {"**"}Servertaal:{"**"} Standaard (geen overschrijving)
config-select-placeholder-server-language = Selecteer servertaal
config-select-option-default = Standaard (geen overschrijving)
config-select-desc-default = Gebruik de voorkeur van elke gebruiker of de Discord-taalinstelling.

# Questrollen
config-btn-quest-roles = Questrollen
config-btn-manage-gm-quest-roles = Beheren

config-modal-title-confirm-quest-role-removal = Rolverwijdering bevestigen
config-modal-label-remove-quest-role = { $roleName } verwijderen van { $gmName }?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Selecteer questrolmodus
config-select-option-quest-role-disabled = Uitgeschakeld
config-select-desc-quest-role-disabled = Er worden geen rollen aangemaakt of toegewezen.
config-select-option-quest-role-temporary = Tijdelijk
config-select-desc-quest-role-temporary = GM's kunnen tijdelijke rollen per quest aanmaken.
config-select-option-quest-role-static = Statisch
config-select-desc-quest-role-static = GM's kiezen uit vooraf toegewezen serverrollen.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Serverrol(len) toewijzen aan deze GM

## Questrollen weergave
config-title-quest-roles = {"**"}Serverconfiguratie - Questrollen{"**"}
config-label-quest-roles = Questrollen
config-desc-quest-roles =
    Configureer hoe groepsrollen worden afgehandeld tijdens quests.

config-label-quest-role-mode-disabled = {"**"}Questrolmodus:{"**"} Uitgeschakeld
    Er worden geen rollen aangemaakt of toegewezen tijdens quests.
config-label-quest-role-mode-temporary = {"**"}Questrolmodus:{"**"} Tijdelijk
    GM's kunnen optioneel een tijdelijke rol aanmaken bij het maken van een quest.
    De rol wordt verwijderd wanneer de quest is voltooid of geannuleerd.
config-label-quest-role-mode-static = {"**"}Questrolmodus:{"**"} Statisch
    GM's kiezen uit vooraf toegewezen serverrollen. Rollen worden toegewezen aan
    groepsleden tijdens quests maar worden nooit verwijderd.

## Statische questrol toewijzingen weergave
config-title-static-quest-roles = {"**"}Serverconfiguratie - Statische questrol toewijzingen{"**"}
config-label-manage-assignments = Roltoewijzingen beheren
config-desc-manage-assignments =
    Wijs bestaande serverrollen toe aan GM's voor gebruik tijdens quests.
    Rollen moeten lager zijn dan de hoogste rol van ReQuest in de serverhiërarchie.
config-msg-no-gm-members = Er zijn geen leden met een GM-rol gevonden op deze server.
config-label-no-roles-assigned = Geen questrollen toegewezen

## GM questrol toewijzing weergave
config-title-gm-quest-role-assign = {"**"}Questrollen beheren — { $gmName }{"**"}
config-error-unmanageable-roles = De volgende rollen kunnen niet worden toegewezen omdat ze worden beheerd door een integratie, de standaardrol zijn, of boven de hoogste rol van ReQuest staan: { $roles }
config-error-quest-role-limit = Deze GM heeft het maximum van { $limit } toegewezen questrollen bereikt.
config-label-quest-role-count = Toegewezen rollen: { $count }/{ $limit }
