## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = Tyhjennä
config-btn-remove-gm-roles = Poista GM-roolit
config-btn-forbidden-roles = Kielletyt roolit

# Quests
config-btn-toggle-quest-summary = Vaihda quest-yhteenveto
config-btn-toggle-player-experience = Vaihda pelaajan kokemus
config-btn-toggle-display = Vaihda näyttö
config-btn-purge-player-board = Tyhjennä pelaajataulu
config-btn-add-modify-rewards = Lisää/muokkaa palkintoja
config-btn-configure-rewards = Määritä palkinnot

# Currency
config-btn-add-denomination = Lisää nimellisarvo
config-btn-add-new-currency = Lisää uusi valuutta
config-btn-remove-currency = Poista valuutta

# Shops - creation
config-btn-add-shop-wizard = Lisää kauppa (velho)
config-btn-add-shop-json = Lisää kauppa (JSON)
config-btn-edit-shop-wizard = Muokkaa kauppaa (velho)
config-btn-edit-shop-json = Muokkaa kauppaa (JSON)
config-btn-remove-shop = Poista kauppa
config-btn-add-item = Lisää esine
config-btn-edit-shop-details = Muokkaa kaupan tietoja
config-btn-download-json = Lataa JSON
config-btn-done-editing = Muokkaus valmis
config-btn-scan-server-configs = Tarkista palvelimen asetukset
config-btn-re-scan = Tarkista uudelleen

# New character shop
config-btn-upload-json = Lataa JSON
config-btn-configure-new-character-wealth = Määritä uuden hahmon varallisuus
config-btn-configure-new-character-shop = Määritä uuden hahmon kauppa
config-btn-clear-shop = Tyhjennä kauppa
config-btn-configure-static-kits = Määritä kiinteät varustesarjat
config-btn-new-character-settings = Uuden hahmon asetukset
config-btn-disabled-no-currency = Pois käytöstä (valuuttaa ei ole määritetty)
config-btn-disabled-no-wealth = Pois käytöstä (aloitusvarallisuutta ei ole määritetty)

# Static kits
config-btn-create-new-kit = Luo uusi varustesarja
config-btn-delete-kit = Poista varustesarja
config-btn-add-currency = Lisää valuutta

# Roleplay
config-btn-toggle-rp-rewards = Vaihda RP-palkinnot
config-btn-clear-channels = Tyhjennä kanavat
config-btn-edit-settings = Muokkaa asetuksia
config-btn-configure-rewards = Määritä palkinnot

# Stock
config-btn-stock-limits = Varastorajat
config-btn-set-limit = Aseta raja
config-btn-edit-limit = Muokkaa rajaa
config-btn-remove-limit = Poista raja
config-btn-configure-restock-schedule = Määritä täydennysaikataulu
config-btn-back-to-shop-editor = Takaisin kauppaeditoriin

# Forum shop
config-btn-create-new-thread = Luo uusi ketju
config-btn-use-existing-thread = Käytä olemassa olevaa ketjua

# Wizard
config-btn-quit = Lopeta
config-btn-configure-channels = Määritä kanavat
config-btn-configure-roles = Määritä roolit
config-btn-configure-quests = Määritä questit
config-btn-configure-players = Määritä pelaajat
config-btn-configure-currency = Määritä valuutta
config-btn-configure-rp-rewards = Määritä RP-palkinnot
config-btn-configure-shops = Määritä kaupat
config-btn-new-char-setup = Uuden hahmon asetukset

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = Vahvista roolin poisto
config-modal-title-confirm-removal = Vahvista poisto
config-modal-title-confirm-currency-removal = Vahvista valuutan poisto
config-modal-title-confirm-shop-removal = Vahvista kaupan poisto
config-modal-title-confirm-kit-deletion = Vahvista varustesarjan poisto
config-modal-title-confirm-remove-stock-limit = Vahvista varastorajan poisto
config-modal-title-clear-shop = Vahvista kaupan tyhjennys

# Confirm modal prompt labels
config-modal-label-remove-role = Poistetaanko { $roleName }?
config-modal-label-remove-denomination = Poistetaanko { $denominationName }?
config-modal-label-remove-currency = Poistetaanko { $currencyName }?
config-modal-label-shop-removal-warning = VAROITUS: Tätä toimintoa ei voi kumota!
config-modal-label-kit-deletion-warning = VAROITUS: Peruuttamaton!
config-modal-label-remove-stock-limit = Kirjoita VAHVISTA poistaaksesi varastorajan
config-modal-label-clear-shop = Tyhjennä kaikki tuotteet tästä kaupasta?

# Error messages from buttons
config-error-shop-data-not-found = Virhe: Kyseisen kaupan tietoja ei löytynyt.
config-msg-shop-json-download = Tässä on JSON-määritys kaupalle {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Tässä on JSON-määritys uuden hahmon kaupalle.
config-error-select-forum-first = Valitse ensin foorumikanava.
config-error-select-thread-first = Valitse ensin ketju.

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Lisää uusi valuutta
config-modal-label-currency-name = Valuutan nimi
config-error-currency-already-exists = Valuutta tai nimellisarvo nimeltä { $name } on jo olemassa!

# RenameCurrencyModal
config-modal-title-rename-currency = Nimeä valuutta uudelleen
config-modal-label-new-currency-name = Uusi valuutan nimi
config-error-currency-name-exists = Valuutta nimeltä "{ $name }" on jo olemassa.
config-error-denomination-name-exists = Nimellisarvo nimeltä "{ $name }" on jo olemassa.

# RenameDenominationModal
config-modal-title-rename-denomination = Nimeä nimellisarvo uudelleen
config-modal-label-new-denomination-name = Uusi nimellisarvon nimi

# AddCurrencyDenominationModal
config-modal-title-add-denomination = Lisää { $currencyName } -nimellisarvo
config-modal-label-denomination-name = Nimi
config-modal-placeholder-denomination-name = esim. Hopea
config-modal-label-denomination-value = Arvo
config-modal-placeholder-denomination-value = esim. 0.1
config-error-denomination-matches-currency = Uuden nimellisarvon nimi ei voi vastata olemassa olevaa valuuttaa tällä palvelimella! Löydettiin olemassa oleva valuutta nimeltä "{ $existingName }".
config-error-denomination-matches-denomination = Uuden nimellisarvon nimi ei voi vastata olemassa olevaa nimellisarvoa tällä palvelimella! Löydettiin olemassa oleva nimellisarvo nimeltä "{ $denominationName }" valuutan "{ $currencyName }" alla.
config-error-denomination-value-exists = Yksittäisen valuutan nimellisarvoilla on oltava yksilölliset arvot! { $denominationName } -nimellisarvolle on jo määritetty tämä arvo.
config-label-denomination-info = **{ $name }** (Arvo: { $value })

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Kiellettyjen roolien nimet
config-modal-label-names = Nimet
config-modal-placeholder-names = Syötä nimet pilkuilla erotettuna
config-msg-forbidden-roles-updated = Kielletyt roolit päivitetty!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Tyhjennä pelaajataulu
config-modal-label-age = Ikä
config-modal-placeholder-age = Syötä säilytettävien viestien enimmäisikä (päivinä)
config-msg-posts-purged = Yli { $days } päivää vanhat viestit on tyhjennetty!

# GMRewardsModal
config-modal-title-gm-rewards = Lisää/muokkaa GM-palkintoja
config-modal-label-experience = Kokemus
config-modal-placeholder-enter-number = Syötä numero
config-modal-label-items = Esineet
config-modal-placeholder-items =
    Nimi: Määrä
    Nimi2: Määrä
    jne.
config-error-experience-invalid = Kokemuksen on oltava kelvollinen kokonaisluku (esim. 2000).
config-error-item-format-invalid = Virheellinen esinemuoto: "{ $item }". Jokainen esine on oltava omalla rivillään muodossa "Nimi: Määrä".

# ConfigShopDetailsModal
config-modal-title-shop-details = Lisää/muokkaa kaupan tietoja
config-modal-label-shop-channel = Valitse kanava
config-modal-placeholder-shop-channel = Valitse kanava tälle kaupalle
config-modal-label-shop-name = Kaupan nimi
config-modal-placeholder-shop-name = Syötä kaupan nimi
config-modal-label-shopkeeper-name = Kauppiaan nimi
config-modal-placeholder-shopkeeper-name = Syötä kauppiaan nimi
config-modal-label-shop-description = Kaupan kuvaus
config-modal-placeholder-shop-description = Syötä kaupan kuvaus
config-modal-label-shop-image-url = Kaupan kuvan URL
config-modal-placeholder-shop-image-url = Syötä kaupan kuvan URL
config-error-no-channel-selected = Kaupalle ei ole valittu kanavaa.
config-error-shop-already-in-channel = Valittuun kanavaan on jo rekisteröity kauppa. Valitse toinen kanava tai muokkaa olemassa olevaa kauppaa.

# build_shop_header_view
config-label-shopkeeper = {"**"}Kauppias:{"**"} { $name }
config-msg-use-shop-command = Käytä `/shop`-komentoa selataksesi ja ostaaksesi esineitä.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Luo foorumiketjukauppa
config-modal-label-thread-name = Ketjun nimi
config-modal-placeholder-thread-name = Syötä kauppaketjun nimi
config-error-forum-not-found = Valittua foorumikanavaa ei löytynyt.
config-error-shop-already-in-thread = Tähän ketjuun on jo rekisteröity kauppa. Tämän ei pitäisi tapahtua uudelle ketjulle.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Lisää uusi kauppa JSON-muodossa
config-modal-label-upload-json = Lataa .json-tiedosto, joka sisältää kaupan tiedot
config-error-no-json-uploaded = Kaupalle ei ladattu JSON-tiedostoa.
config-error-file-must-be-json = Ladatun tiedoston on oltava JSON-tiedosto (.json).
config-error-invalid-json = Virheellinen JSON-muoto: { $error }
config-error-json-validation-failed = JSON ei vastaa skeemaa: { $error }

# ShopItemModal
config-modal-title-shop-item = Lisää/muokkaa kaupan esinettä
config-modal-label-item-name = Esineen nimi
config-modal-placeholder-item-name = Syötä esineen nimi
config-modal-label-item-description = Esineen kuvaus
config-modal-placeholder-item-description = Syötä esineen kuvaus
config-modal-label-item-quantity = Esineen määrä
config-modal-placeholder-item-quantity = Syötä ostettava määrä per osto
config-modal-label-item-costs = Esineen hinnat
config-modal-placeholder-item-costs = Esim.: 10 gold + 5 silver\nTAI: 50 rep\n(Käytä + JA-yhdistämiseen, uudet rivit TAI-vaihtoehdoille)
config-error-item-quantity-positive = Esineen määrän on oltava positiivinen kokonaisluku.
config-error-cost-format-invalid = Virheellinen hintamuoto vaihtoehdossa: "{ $option }". Jokaisen hinnan on sisällettävä summa ja valuutta välilyönnillä erotettuna, esim. "10 gold".
config-error-cost-amount-invalid = Virheellinen summa "{ $amount }" valuutalle: "{ $currency }". Summan on oltava positiivinen luku.
config-error-unknown-currency = Tuntematon valuutta `{ $currency }`. Käytä tälle palvelimelle määritettyä kelvollista valuuttaa.
config-error-item-already-exists = Esine nimeltä { $itemName } on jo olemassa tässä kaupassa.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Päivitä kauppa JSON-muodossa
config-modal-label-upload-new-json = Lataa uusi JSON-määritys
config-error-no-file-uploaded = Tiedostoa ei ladattu.
config-error-file-must-be-json-ext = Tiedoston on oltava `.json`-tiedosto.
config-error-json-validation-message = JSON-validointi epäonnistui: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Lisää/muokkaa uuden hahmon varustetta
config-modal-placeholder-item-quantity-selection = Syötä valinnan mukana saatava määrä
config-modal-label-item-cost = Esineen hinta
config-error-cost-format-short = Virheellinen hintamuoto: '{ $component }'. Odotettu muoto: 'Summa Valuutta'.
config-error-amount-invalid-short = Virheellinen summa '{ $amount }' valuutalle '{ $currency }'.
config-error-item-exists-new-char = Esine nimeltä { $itemName } on jo olemassa uuden hahmon kaupassa.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Lataa uuden hahmon kauppa (JSON)
config-error-no-json-uploaded-short = JSON-tiedostoa ei ladattu.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Aseta uuden hahmon varallisuus
config-modal-label-amount = Summa
config-modal-placeholder-amount = Syötä tämän valuutan summa.
config-modal-placeholder-currency-name = Syötä tällä palvelimella määritetyn valuutan nimi
config-error-no-currencies-configured = Tälle palvelimelle ei ole määritetty valuuttoja.
config-error-currency-not-found = Valuuttaa tai nimellisarvoa nimeltä { $name } ei löytynyt. Käytä kelvollista valuuttaa.

# CreateStaticKitModal
config-modal-title-create-kit = Luo uusi kiinteä varustesarja
config-modal-label-kit-name = Varustesarjan nimi
config-modal-placeholder-kit-name = esim. Soturin aloitusvarusteet
config-modal-label-description = Kuvaus
config-modal-placeholder-kit-description = Valinnainen kuvaus tälle varustesarjalle
config-error-kit-name-exists = Kiinteä varustesarja nimeltä "{ $kitName }" on jo olemassa. Valitse toinen nimi.

# StaticKitItemModal
config-modal-title-kit-item = Lisää/muokkaa varustesarjan esinettä
config-modal-placeholder-kit-item-quantity = Syötä sarjaan sisällytettävän esineen määrä

# StaticKitCurrencyModal
config-modal-title-kit-currency = Lisää varustesarjan valuutta
config-modal-placeholder-currency-eg = esim. Kulta
config-modal-placeholder-amount-eg = esim. 100
config-error-amount-must-be-number = Summan on oltava numero.
config-error-amount-exceeds-maximum = Summa ei voi ylittää { $max }.
config-error-no-currencies-on-server = Palvelimelle ei ole määritetty valuuttoja.
config-error-currency-not-found-short = Valuuttaa "{ $currency }" ei löytynyt.
config-error-denomination-not-found = Nimellisarvoa "{ $denomination }" ei löytynyt valuuttamäärittelystä.

# RoleplaySettingsModal
config-modal-title-rp-settings = Roolipeliasetukset
config-modal-label-min-message-length = Viestin vähimmäispituus (merkkejä)
config-modal-placeholder-min-message-length = Merkkimäärä, joka vaaditaan viestin kelpoisuuteen. 0 = ei rajaa
config-modal-label-cooldown = Jäähdytysaika (sekunteja)
config-modal-placeholder-cooldown = Odotusaika sekunteina ennen kuin seuraava viesti lasketaan palkintokelpoiseksi
config-modal-label-message-threshold = Viestikynnys
config-modal-placeholder-message-threshold = Vaadittu viestimäärä palkinnon laukaisemiseksi
config-modal-label-frequency = Tiheys (viestimäärä)
config-modal-placeholder-frequency = Kelpoisten viestien määrä palkintojen ansaitsemiseksi
config-error-min-length-invalid = Viestin vähimmäispituuden on oltava ei-negatiivinen kokonaisluku.
config-error-cooldown-invalid = Jäähdytysajan on oltava ei-negatiivinen kokonaisluku.
config-error-threshold-invalid = Viestikynnyksen on oltava positiivinen kokonaisluku.
config-error-frequency-invalid = Tiheyden on oltava positiivinen kokonaisluku.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Määritä roolipelipalkinnot
config-modal-label-items-name-quantity = Esineet (Nimi: Määrä)
config-modal-label-currency-name-amount = Valuutta (Nimi: Summa)
config-error-experience-non-negative = Kokemuksen on oltava ei-negatiivinen kokonaisluku.
config-error-item-quantity-positive-named = Esineen "{ $itemName }" määrän on oltava positiivinen kokonaisluku.
config-error-currency-amount-positive = Valuutan "{ $currencyName }" summan on oltava positiivinen luku.

# SetItemStockModal
config-modal-title-stock-limit = Varastoraja: { $itemName }
config-modal-label-max-stock = Enimmäisvarasto
config-modal-placeholder-max-stock = Syötä enimmäisvarasto (esim. 10)
config-modal-label-current-stock = Nykyinen varasto
config-modal-placeholder-current-stock = Syötä nykyinen saatavilla oleva varasto
config-modal-label-restock-increment = Täydennysmäärä (per kierros)
config-modal-placeholder-restock-increment = Lisättävä määrä per täydennyskierros (oletus: 1)
config-error-max-stock-positive = Enimmäisvaraston on oltava positiivinen kokonaisluku.
config-error-current-stock-non-negative = Nykyisen varaston on oltava ei-negatiivinen kokonaisluku.
config-error-current-exceeds-max = Nykyinen varasto ei voi ylittää enimmäisvarastoa.
config-error-item-not-in-shop = Esinettä "{ $itemName }" ei löytynyt kaupasta.

# RestockScheduleModal
config-modal-title-restock-schedule = Määritä täydennysaikataulu
config-modal-restock-schedule-label = Aikataulu
config-modal-restock-schedule-none = Ei mitään (Pois käytöstä)
config-modal-restock-schedule-hourly = Tunnittain
config-modal-restock-schedule-daily = Päivittäin
config-modal-restock-schedule-weekly = Viikoittain
config-modal-label-time = Aika (HH:MM UTC-ajassa)
config-modal-desc-current-time = Nykyinen aika: { $utcTime }
config-modal-placeholder-time = esim. 14:30 vastaa klo 14:30 UTC
config-modal-restock-day-label = Viikonpäivä (vain viikoittain)
config-modal-restock-mode-label = Täydennystila
config-modal-restock-mode-full = Täysi (nollaa maksimiin)
config-modal-restock-mode-incremental = Asteittainen (lisää määrä)
config-error-time-format-invalid = Ajan on oltava muodossa HH:MM (esim. 14:30).
config-error-increment-positive = Lisäysmäärän on oltava positiivinen kokonaisluku.

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Etsi { $configName }-kanavasi

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Valitse quest-ilmoitusrooli

# AddGMRoleSelect
config-select-placeholder-gm-roles = Valitse GM-roolisi

# ConfigWaitListSelect
config-select-placeholder-wait-list = Valitse jonotuslistan koko
config-select-option-disabled = 0 (Pois käytöstä)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Valitse inventaariotila
config-select-option-disabled-label = Pois käytöstä
config-select-desc-disabled = Pelaajat aloittavat tyhjällä inventaariolla.
config-select-option-selection = Valinta
config-select-desc-selection = Pelaajat valitsevat esineitä vapaasti uuden hahmon kaupasta.
config-select-option-purchase = Osto
config-select-desc-purchase = Pelaajat ostavat esineitä uuden hahmon kaupasta annetulla valuuttamäärällä.
config-select-option-open = Avoin
config-select-desc-open = Pelaajat syöttävät inventaarionsa manuaalisesti.
config-select-option-static = Kiinteä
config-select-desc-static = Pelaajille annetaan ennalta määritetty aloitusinventaario.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Valitse kelpoiset kanavat

# RoleplayModeSelect
config-select-placeholder-rp-mode = Valitse tila
config-select-option-scheduled = Ajastettu
config-select-desc-scheduled = Palkinnot myönnetään kerran määritetyn nollausjakson aikana.
config-select-option-accrued = Kertyvä
config-select-desc-accrued = Palkinnot myönnetään toistuvasti määritettyjen aktiivisuustasojen perusteella.

# RoleplayResetSelect
config-select-placeholder-reset-period = Valitse nollausjakso
config-select-option-hourly = Tunneittain
config-select-desc-hourly = Nollautuu joka tunti.
config-select-option-daily = Päivittäin
config-select-desc-daily = Nollautuu 24 tunnin välein.
config-select-option-weekly = Viikottain
config-select-desc-weekly = Nollautuu 7 päivän välein.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Valitse nollauspäivä

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Valitse nollausaika (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Valitse foorumikanava

# ForumThreadSelect
config-select-placeholder-thread = Valitse ketju
config-select-option-no-threads = Aktiivisia ketjuja ei löytynyt
config-select-desc-no-threads = Luo uusi ketju tai tarkista arkistoidut ketjut
config-select-option-select-forum-first = Valitse ensin foorumi
config-select-desc-select-forum-first = Valitse yllä oleva foorumikanava
config-select-desc-thread-id = Ketjun ID: { $threadId }
config-error-select-valid-thread = Valitse kelvollinen ketju tai luo uusi.
config-error-thread-not-found = Valittua ketjua ei löytynyt. Se on saattanut olla poistettu tai arkistoitu.

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = Palvelimen asetukset - Päävalikko
config-menu-config-wizard = Asetusvelho
config-menu-desc-config-wizard = Tarkista nopealla skannauksella, että palvelimesi on valmis käyttämään ReQuestia.
config-menu-channels = Kanavat
config-menu-desc-channels = Aseta kanavat ReQuestin julkaisuja varten.
config-menu-currency = Valuutta
config-menu-desc-currency = Yleiset valuutta-asetukset.
config-menu-players = Pelaajat
config-menu-desc-players = Yleiset pelaaja-asetukset, kuten kokemuspisteiden seuranta.
config-menu-quests = Questit
config-menu-desc-quests = Yleiset quest-asetukset, kuten jonotuslistat.
config-menu-rp-rewards = RP-palkinnot
config-menu-desc-rp-rewards = Määritä roolipelipalkinnot.
config-menu-roles = Roolit
config-menu-desc-roles = Pingattavien tai etuoikeutettujen roolien asetukset.
config-menu-shops = Kaupat
config-menu-desc-shops = Määritä mukautettuja kauppoja.
config-menu-language = Kieli
config-menu-desc-language = Aseta tämän palvelimen oletuskieli.

## Wizard View
config-title-wizard = {"**"}Palvelimen asetukset - Velho{"**"}
config-wizard-intro =
    {"**"}Tervetuloa ReQuestin asetusvelhoon!{"**"}

    Tämä velho auttaa varmistamaan, että palvelimesi on asianmukaisesti määritetty ReQuestin ominaisuuksien käyttöön. Se skannaa nykyiset asetuksesi ja antaa suosituksia tarvittavista muutoksista.

    Käytä alla olevaa "Käynnistä skannaus" -painiketta aloittaaksesi tarkistusprosessin. Skannauksen valmistuttua saat yksityiskohtaisen raportin palvelimesi asetuksista sekä suositellut muutokset.

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}Botin yleiset oikeudet{"**"}__
config-wizard-bot-permissions-desc = Tämä osio tarkistaa, että ReQuestilla on oikeat oikeudet toimiakseen oikein.
config-wizard-bot-role = Botin rooli: { $roleMention }
config-wizard-status-warnings = {"**"}Tila: ⚠️ VAROITUKSIA LÖYTYI{"**"}
config-wizard-missing-perm = - ⚠️ Puuttuu: `{ $permissionName }`
config-wizard-ensure-permissions = Varmista, että botin korkeimmalla roolilla on nämä oikeudet myönnettynä globaalisti.
config-wizard-status-ok = {"**"}Tila: ✅ OK{"**"}
config-wizard-bot-permissions-ok = Botilla on kaikki vaaditut yleiset oikeudet.
config-wizard-status-scan-failed = {"**"}Tila: ❌ SKANNAUS EPÄONNISTUI{"**"}
config-wizard-scan-error = Odottamaton virhe tapahtui tarkistettaessa botin oikeuksia.
config-wizard-error-type = Virhe: { $errorType }
config-wizard-required-permissions = {"**"}Botin roolin vaaditut oikeudet:{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = Näytä kanavat
config-wizard-perm-manage-roles = Hallinnoi rooleja
config-wizard-perm-send-messages = Lähetä viestejä
config-wizard-perm-attach-files = Liitä tiedostoja
config-wizard-perm-add-reactions = Lisää reaktioita
config-wizard-perm-use-external-emoji = Käytä ulkoisia emojeja
config-wizard-perm-manage-messages = Hallinnoi viestejä
config-wizard-perm-read-message-history = Lue viestihistoria

# Wizard - Role Validation
config-wizard-role-header = __{"**"}Roolimääritykset{"**"}__
config-wizard-role-desc =
    Tämä osio tarkistaa seuraavat:

    - GM-roolit (vaadittu) ja ilmoitusrooli (valinnainen) on määritetty.
    - Oletusroolilla (@everyone) on vaaditut oikeudet botin ominaisuuksien käyttöön.
    - Oletusroolilla (@everyone) ei ole vaarallisia oikeuksia.
    - GM- ja ilmoitusrooleilla tarkistetaan, onko niillä oikeuksien laajennuksia oletusroolin yli.

    Tässä olevat varoitukset ovat ainoastaan suosituksia oletusasetusten perusteella. Palvelimesi tarpeista riippuen sinulla voi olla syy ohittaa joitakin näistä suosituksista.

config-wizard-default-role-label = {"**"}Oletusrooli:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Vaarallisia oikeuksia löydetty:
config-wizard-default-role-ok = - ✅ @everyone: OK
config-wizard-missing-permission = - Puuttuva oikeus: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}GM-roolit:{"**"}
config-wizard-no-gm-roles = - ⚠️ GM-rooleja ei ole määritetty
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Määritettyä roolia ei löydy / poistettu palvelimelta
config-wizard-role-ok = - ✅ { $roleMention }: OK
config-wizard-announcement-role-label = {"**"}Ilmoitusrooli:{"**"}
config-wizard-no-announcement-role = - ℹ️ Ilmoitusroolia ei ole määritetty
config-wizard-announcement-role-not-found = - ⚠️ Määritettyä roolia ei löydy / poistettu palvelimelta
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Oikeuksien laajennuksia havaittu - { $escalations }
config-wizard-escalation-more = , ja { $count } lisää...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = Lähetä viestejä ketjuihin
config-wizard-perm-use-application-commands = Käytä sovelluskomentoja

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = Hallinnoi kanavia
config-wizard-perm-manage-webhooks = Hallinnoi webhookeja
config-wizard-perm-manage-server = Hallinnoi palvelinta
config-wizard-perm-manage-nicknames = Hallinnoi nimimerkkejä
config-wizard-perm-kick-members = Potkaise jäseniä
config-wizard-perm-ban-members = Estä jäseniä
config-wizard-perm-timeout-members = Aikakatkaise jäseniä
config-wizard-perm-mention-everyone = Mainitse @everyone
config-wizard-perm-manage-threads = Hallinnoi ketjuja
config-wizard-perm-administrator = Ylläpitäjä

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}Kanavamääritykset{"**"}__
config-wizard-channel-desc =
    Tämä osio tarkistaa seuraavat:

    - Määritetyt kanavat ovat olemassa.
    - Botilla on oikeus nähdä ja lähettää viestejä määritetyissä kanavissa.
    - Oletusroolilla (@everyone) ei ole `Lähetä viestejä` -oikeutta.

config-wizard-channel-no-config-required = - ⚠️ Kanavaa ei ole määritetty
config-wizard-channel-not-configured = - ℹ️ Ei määritetty (valinnainen)
config-wizard-channel-not-found = - ⚠️ Määritettyä kanavaa ei löydy / poistettu palvelimelta
config-wizard-channel-ok = - ✅ OK
config-wizard-bot-cannot-view = - ⚠️ { $botMention } ei voi nähdä tätä kanavaa.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } ei voi lähettää viestejä tähän kanavaan.
config-wizard-everyone-can-send = - ⚠️ @everyone voi lähettää viestejä tähän kanavaan.

# Wizard - Channel names
config-wizard-channel-quest-board = Quest-taulu
config-wizard-channel-player-board = Pelaajataulu
config-wizard-channel-quest-archive = Quest-arkisto
config-wizard-channel-gm-transaction-log = GM-tapahtumaloki
config-wizard-channel-player-transaction-log = Pelaajan tapahtumaloki
config-wizard-channel-shop-log = Kauppaloki
config-wizard-channel-approval-queue = Hahmon hyväksyntäjono

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}Asetuspaneeli{"**"}__
config-wizard-dashboard-desc = Tämä osio tarjoaa yleiskatsauksen ei-välttämättömistä asetuksista pikaviittausta varten.
config-wizard-quest-settings = {"**"}Quest-asetukset{"**"}
config-wizard-quest-wait-list = - Quest-jonotuslistan koko: { $size }
config-wizard-quest-summary = - Quest-yhteenveto: { $status }
config-wizard-gm-rewards-per-quest = {"**"}GM-palkinnot (per quest){"**"}
config-wizard-player-settings = {"**"}Pelaaja-asetukset{"**"}
config-wizard-player-experience = - Pelaajan kokemus: { $status }
config-wizard-currency-settings = {"**"}Valuutta-asetukset{"**"}
config-wizard-rp-rewards = {"**"}Roolipelipalkinnot{"**"}
config-wizard-rp-status = - Tila: { $status }
config-wizard-rp-mode = - Tila: { $mode }
config-wizard-rp-channels = - Seurattavat kanavat: { $count }
config-wizard-shops = {"**"}Kaupat{"**"}
config-wizard-shops-count = - Määritetyt kaupat: { $count }
config-wizard-shops-more = - ...ja { $count } lisää
config-wizard-new-char-setup = {"**"}Uuden hahmon asetukset{"**"}
config-wizard-inventory-type = - Inventaariotyyppi: { $type }
config-wizard-new-char-shop-items = - Uuden hahmon kaupan esineet: { $count }
config-wizard-static-kits = - Kiinteät varustesarjat: { $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ Valuuttoja ei ole määritetty
config-wizard-configured-currencies = {"**"}Määritetyt valuutat:{"**"}
config-wizard-no-denominations = - Nimellisarvoja ei ole määritetty
config-wizard-gm-rewards-disabled = {"**"}Tila:{"**"} Pois käytöstä
config-wizard-gm-rewards-enabled = {"**"}Tila:{"**"} Käytössä
config-wizard-gm-rewards-experience = - Kokemus: { $xp }
config-wizard-gm-rewards-items = - Esineet:

# Wizard - Palvelimen kieli (Sivu 1)
config-wizard-server-language-desc =
    Tämä on kieli, jota ReQuest käyttää kaikissa julkisissa viesteissä, kuten tehtäväjulkaisuissa, kaupan täydennysviesteissä ja tapahtumalokissa.
config-wizard-server-language = {"**"}Palvelimen kieli:{"**"} { $language }
config-wizard-server-language-default = Oletus (englanti)

# Wizard - Kaupan täydennystiedot
config-wizard-shop-restock-not-scheduled = ℹ️ Täydennystä ei ole ajoitettu

# Wizard - Tehtäväasetukset (Sivu 5)
config-wizard-quest-header = __{"**"}Tehtäväasetukset{"**"}__
config-wizard-quest-header-desc =
    Tämä osio tarjoaa yleiskatsauksen tehtäviin liittyvistä asetuksista.
config-wizard-quest-role-mode = - Tehtäväroolien tila: { $mode }
config-wizard-quest-roles-label = {"**"}GM:n tehtäväroolit{"**"}
config-wizard-quest-roles-count = - GM:ille määritetyt roolit: { $count }
config-wizard-quest-roles-all-ok = - ✅ Kaikki roolit OK
config-wizard-quest-roles-assigned-to = {"    "}Määritetty: { $gmNames }
config-wizard-quest-roles-not-found = - ⚠️ Rooli-ID { $roleId }: Ei löydy/Poistettu palvelimelta
config-wizard-quest-roles-no-assignments = - ℹ️ Ei määritettyjä tehtävärooleja

## Roles View
config-title-roles = {"**"}Palvelimen asetukset - Roolit{"**"}
config-label-announcement-role = {"**"}Ilmoitusrooli:{"**"} { $status }
config-desc-announcement-role = Tätä roolia mainitaan, kun quest julkaistaan.
config-label-announcement-role-default = {"**"}Ilmoitusrooli:{"**"} Ei määritetty
config-label-gm-roles = {"**"}GM-rooli(t):{"**"} { $roles }
config-desc-gm-roles = Nämä roolit myöntävät pääsyn pelinjohtajakomentoihin ja -ominaisuuksiin.
config-label-gm-roles-default = {"**"}GM-rooli(t):{"**"} Ei määritetty
config-title-forbidden-roles = __{"**"}Kielletyt roolit{"**"}__
config-desc-forbidden-roles =
    Määrittää listan roolien nimistä, joita pelinjohtajat eivät voi käyttää ryhmärooleinaan.
    Oletuksena `everyone`, `administrator`, `gm` ja `game master` eivät ole sallittuja. Tämä asetus
    laajentaa kyseistä listaa.

## GM Role Remove View
config-title-remove-gm-roles = {"**"}Palvelimen asetukset - Poista GM-rooli(t){"**"}
config-msg-no-gm-roles = GM-rooleja ei ole määritetty.

## Channels View
config-title-channels = {"**"}Palvelimen asetukset - Kanavat{"**"}

config-label-quest-board = {"**"}Quest-taulu:{"**"} { $channel }
config-desc-quest-board = Kanava, johon uudet/aktiiviset questit julkaistaan.
config-label-quest-board-default = {"**"}Quest-taulu:{"**"} Ei määritetty

config-label-player-board = {"**"}Pelaajataulu:{"**"} { $channel }
config-desc-player-board = Valinnainen ilmoitus-/viestintätaulu pelaajien käyttöön.
config-label-player-board-default = {"**"}Pelaajataulu:{"**"} Ei määritetty

config-label-quest-archive = {"**"}Quest-arkisto:{"**"} { $channel }
config-desc-quest-archive = Valinnainen kanava, johon valmiit questit siirretään yhteenvetotiedoilla.
config-label-quest-archive-default = {"**"}Quest-arkisto:{"**"} Ei määritetty

config-label-gm-transaction-log = {"**"}GM-tapahtumaloki:{"**"} { $channel }
config-desc-gm-transaction-log = Valinnainen kanava, johon GM-tapahtumat (esim. Muokkaa pelaajaa -komennot) kirjataan.
config-label-gm-transaction-log-default = {"**"}GM-tapahtumaloki:{"**"} Ei määritetty

config-label-player-transaction-log = {"**"}Pelaajan tapahtumaloki:{"**"} { $channel }
config-desc-player-transaction-log = Valinnainen kanava, johon pelaajien tapahtumat kuten vaihtokauppa ja esineiden kulutus kirjataan.
config-label-player-transaction-log-default = {"**"}Pelaajan tapahtumaloki:{"**"} Ei määritetty

config-label-shop-log = {"**"}Kauppaloki:{"**"} { $channel }
config-desc-shop-log = Valinnainen kanava, johon kauppatapahtumat kirjataan.
config-label-shop-log-default = {"**"}Kauppaloki:{"**"} Ei määritetty

## Quests View
config-title-quests = {"**"}Palvelimen asetukset - Questit{"**"}

config-label-wait-list = {"**"}Quest-jonotuslistan koko:{"**"} { $size }
config-desc-wait-list = Jonotuslista sallii määritetyn määrän pelaajia jonottaa täyteen questiin siltä varalta, että joku pelaaja poistuu.
config-label-wait-list-disabled = {"**"}Quest-jonotuslistan koko:{"**"} Pois käytöstä

config-label-quest-summary = {"**"}Quest-yhteenveto:{"**"} { $status }
config-desc-quest-summary = Tämä asetus mahdollistaa pelinjohtajille lyhyen yhteenvedon antamisen questin päättyessä.
config-label-quest-summary-disabled = {"**"}Quest-yhteenveto:{"**"} Pois käytöstä

config-label-gm-rewards = GM-palkinnot
config-desc-gm-rewards = Määritä palkinnot, jotka pelinjohtajat saavat questin suorittamisesta.

## GM Rewards View
config-title-gm-rewards = {"**"}Palvelimen asetukset - GM-palkinnot{"**"}
config-desc-gm-rewards-detail =
    {"**"}Lisää/muokkaa palkintoja{"**"}
    Avaa syötemodaalin palkintojen lisäämiseksi, muokkaamiseksi tai poistamiseksi.

    > Määritetyt palkinnot ovat quest-kohtaisia. Joka kerta kun pelinjohtaja suorittaa questin,
    hän saa alla määritetyt palkinnot aktiiviselle hahmolleen.
config-msg-no-rewards = Palkintoja ei ole määritetty.
config-label-gm-experience = {"**"}Kokemus:{"**"} { $xp }
config-label-gm-items = {"**"}Esineet:{"**"}

## Players View
config-title-players = {"**"}Palvelimen asetukset - Pelaajat{"**"}

config-label-player-experience = {"**"}Pelaajan kokemus:{"**"} { $status }
config-desc-player-experience = Ottaa käyttöön/poistaa käytöstä kokemuspistemäärän (tai vastaavan arvoihin perustuvan hahmon etenemisen).
config-label-player-experience-disabled = {"**"}Pelaajan kokemus:{"**"} Pois käytöstä

config-label-new-char-settings = {"**"}Uuden hahmon asetukset{"**"}
config-desc-new-char-settings = Määritä asetukset uusille pelaajahahmoille ja niiden alkuinventaarion asettamiselle.

config-label-player-board-purge = {"**"}Pelaajataulun tyhjennys{"**"}
config-desc-player-board-purge = Tyhjentää viestit pelaajataulusta (jos käytössä).

## New Character Settings View
config-title-new-character = {"**"}Palvelimen asetukset - Uuden hahmon asetukset{"**"}

config-label-inventory-type = {"**"}Uuden hahmon inventaariotyyppi:{"**"} { $type }
config-desc-inventory-type = Määrittää, miten uudet rekisteröidyt hahmot alustavat inventaarionsa.
config-label-inventory-type-disabled = {"**"}Uuden hahmon inventaariotyyppi:{"**"} Pois käytöstä

config-label-new-char-wealth = {"**"}Uuden hahmon varallisuus:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Uuden hahmon varallisuus:{"**"} Pois käytöstä

config-label-approval-queue = {"**"}Hyväksyntäjono:{"**"} { $channel }
config-desc-approval-queue = Jos asetettu, GM:n on hyväksyttävä uudet hahmot tässä Forum-kanavassa ennen kuin ne aktivoituvat.
config-label-approval-queue-disabled = {"**"}Hyväksyntäjono:{"**"} Pois käytöstä
config-label-approval-queue-not-configured = {"**"}Hyväksyntäjono:{"**"} Ei määritetty

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = Pelaajat aloittavat tyhjällä inventaariolla.
config-desc-inv-type-selection = Pelaajat valitsevat esineitä vapaasti uuden hahmon kaupasta.
config-desc-inv-type-purchase = Pelaajat ostavat esineitä uuden hahmon kaupasta annetulla valuuttamäärällä.
config-desc-inv-type-open = Pelaajat syöttävät inventaarionsa esineet manuaalisesti.
config-desc-inv-type-static = Pelaajille annetaan ennalta määritetty aloitusinventaario.

## New Character Shop View
config-title-new-char-shop = {"**"}Palvelimen asetukset - Uuden hahmon kauppa{"**"}
config-label-inv-type-selection = {"**"}Inventaariotyyppi:{"**"} Valinta
config-desc-inv-type-selection-shop = Pelaajat valitsevat esineitä vapaasti uuden hahmon kaupasta.
config-label-inv-type-purchase = {"**"}Inventaariotyyppi:{"**"} Osto
config-desc-inv-type-purchase-shop = Pelaajat ostavat esineitä uuden hahmon kaupasta annetulla valuuttamäärällä.
config-label-inv-type-other = {"**"}Inventaariotyyppi:{"**"} { $type }
config-desc-inv-type-not-in-use = Uuden hahmon kauppa ei ole käytössä.
config-msg-define-shop-items = Määritä kaupan esineet.
config-msg-no-items = Esineitä ei ole määritetty.

## Static Kits View
config-title-static-kits = {"**"}Palvelimen asetukset - Kiinteät varustesarjat{"**"}
config-desc-create-kit = Luo uusi varustesarjan määrittely.
config-msg-no-kits = Varustesarjoja ei ole määritetty.
config-label-kit-more-items = ...ja { $count } esinettä lisää
config-label-empty-kit = {"*"}Tyhjä varustesarja{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}Muokataan varustesarjaa: { $kitName }{"**"}
config-msg-kit-empty = Tämä varustesarja on tyhjä. Käytä yllä olevia painikkeita lisätäksesi valuuttaa tai esineitä.
config-label-kit-currency = {"**"}Valuutta:{"**"} { $display }
config-label-kit-item = {"**"}Esine:{"**"} { $name }

## Currency View
config-title-currency = {"**"}Palvelimen asetukset - Valuutta{"**"}
config-desc-create-currency = Luo uusi valuutta.
config-msg-no-currencies = Valuuttoja ei ole määritetty.
config-label-currency-display-type = Näyttötyyppi: { $type } | Nimellisarvot: { $count }
config-label-currency-type-double = Desimaaliluku
config-label-currency-type-integer = Kokonaisluku

## Edit Currency View
config-title-manage-currency = {"**"}Hallinnoi valuuttaa: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Valuutta ja nimellisarvot{"**"}__
    - Valuuttasi annettu nimi on perusvaluutta ja sen arvo on 1.
    {"```"}Esimerkki: "kulta" on määritetty valuutaksi.{"```"}
    - Nimellisarvon lisääminen vaatii nimen ja arvon suhteessa perusvaluuttaan.
    {"```"}Esimerkki: Kullalle on annettu kaksi nimellisarvoa: hopea (arvo 0.1) ja kupari (arvo 0.01).{"```"}
    - Kaikki tapahtumat, jotka koskevat perusvaluuttaa tai sen nimellisarvoja, muunnetaan automaattisesti.
    {"```"}Esimerkki: Pelaajalla on 10 kultaa ja hän käyttää 3 kuparia. Uusi saldo näkyy automaattisesti
    9 kultaa, 9 hopeaa ja 7 kuparia.{"```"}
    - Kokonaislukuna näytetyt valuutat näyttävät jokaisen nimellisarvon, kun taas desimaalilukuna näytetyt
    näyttävät vain perusvaluutan.
    {"```"}Esimerkki: Yllä oleva pelaaja desimaalinäytöllä näkyy muodossa 9.97 kultaa.{"```"}
config-btn-toggle-display-current = Vaihda näyttö (Nykyinen: { $type })
config-msg-no-denominations = Nimellisarvoja ei ole määritetty.

## Shops View
config-title-shops = {"**"}Palvelimen asetukset - Kaupat{"**"}
config-desc-add-shop-wizard =
    {"**"}Lisää kauppa (velho){"**"}
    Luo uusi tyhjä kauppa lomakkeella.
config-desc-add-shop-json =
    {"**"}Lisää kauppa (JSON){"**"}
    Luo uusi kauppa tarjoamalla täydellinen JSON-määritys. (Edistynyt)
config-btn-example-json = Esimerkki JSON
config-desc-example-json =
    {"**"}Esimerkki JSON{"**"}
    Lataa esimerkki-JSON-tiedosto, joka näyttää odotetun muodon.
config-msg-example-json = Tässä on esimerkki-JSON-tiedosto, joka näyttää odotetun muodon.
config-msg-no-shops = Kauppoja ei ole määritetty.
config-label-shop-type-forum = (Forum)
config-label-shop-channel = Kanava: <#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}Lisää kauppa - Valitse sijaintityyppi{"**"}
config-label-text-channel = {"**"}Tekstikanava{"**"}
config-desc-text-channel = Luo kauppa tavalliseen tekstikanavaan.
config-label-forum-thread = {"**"}Forum-ketju{"**"}
config-desc-forum-thread = Luo kauppa foorumiketjuun (uuteen tai olemassa olevaan).

## Forum Shop Setup View
config-title-forum-setup = {"**"}Lisää kauppa - Forum-ketjun asetukset{"**"}
config-label-step1 = {"**"}Vaihe 1: Valitse foorumikanava{"**"}
config-label-step2 = {"**"}Vaihe 2: Valitse ketjuvaihtoehto{"**"}
config-label-step3 = {"**"}Vaihe 3: Valitse olemassa oleva ketju{"**"}
config-desc-create-new-thread =
    {"**"}Luo uusi ketju{"**"}
    Avaa lomakkeen uuden ketjun luomiseksi ja kaupan määrittämiseksi.
config-label-selected-thread = {"**"}Valittu ketju:{"**"} { $threadName }
config-desc-click-to-configure = Napsauta määrittääksesi kauppa tässä ketjussa.

## Manage Shop View
config-title-manage-shop = {"**"}Hallinnoi kauppaa: { $shopName }{"**"}
config-label-shop-type = {"**"}Tyyppi:{"**"} { $type }
config-label-shop-type-text = Tekstikanava
config-label-shop-type-forum-thread = Forum-ketju
config-label-shopkeeper = {"**"}Kauppias:{"**"} { $name }
config-label-shop-description = {"**"}Kuvaus:{"**"} { $description }
config-label-shop-channel-info = {"**"}Kanava:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Muokkaa kaupan tietoja ja esineitä velholla.
config-desc-upload-json = Lataa uusi JSON-määritys tälle kaupalle.
config-desc-download-json = Lataa nykyinen JSON-määritys.
config-desc-remove-shop = Poista tämä kauppa pysyvästi.

## Edit Shop View
config-title-editing-shop = {"**"}Muokataan kauppaa: { $shopName }{"**"}
config-label-shop-shopkeeper = Kauppias: {"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}Varastomääritykset: { $shopName }{"**"}
config-label-current-utc = Nykyinen UTC-aika: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Täydennysaikataulu:{"**"} { $schedule }
config-label-restock-hourly = minuutilla :{ $minute }
config-label-restock-daily = klo { $time } UTC
config-label-restock-weekly = { $day } klo { $time } UTC
config-label-restock-mode = {"**"}Tila:{"**"} { $mode }
config-label-restock-full = Täysi täydennys
config-label-restock-incremental = Asteittainen (määrät tuotekohtaisesti)
config-label-restock-disabled = {"**"}Täydennysaikataulu:{"**"} Pois käytöstä
config-label-item-stock-limits = {"**"}Esineiden varastorajat{"**"}
config-msg-no-items-in-shop = Kaupassa ei ole esineitä.
config-label-stock-with-available = Maks: { $max } | Saatavilla: { $available }
config-label-stock-increment = Täydennys: +{ $increment }/kierros
config-label-stock-reserved = Varattu: { $reserved }
config-label-stock-not-initialized = Maks: { $max } | Saatavilla: (ei alustettu)
config-label-stock-unlimited = Varasto: Rajoittamaton

## Roleplay View
config-title-roleplay = {"**"}Palvelimen asetukset - Roolipelipalkinnot{"**"}
config-label-rp-status = {"**"}Tila:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Palvelimen aika:{"**"} `{ $time }`
config-label-rp-enabled = Käytössä
config-label-rp-disabled = Pois käytöstä

config-desc-rp-mode-scheduled = {"```"}Palkinnot jaetaan kerran, kun vaadittu määrä kelpoisia viestejä on lähetetty asetetun ajanjakson aikana (tunneittain, päivittäin tai viikottain).{"```"}
config-desc-rp-mode-accrued = {"```"}Palkinnot jaetaan toistuvasti joka kerta, kun asetettu määrä kelpoisia viestejä on lähetetty.{"```"}

config-label-rp-config-details = {"**"}Asetustiedot:{"**"}
config-label-rp-mode = {"**"}Tila:{"**"} { $mode }
config-label-rp-min-length = {"**"}Viestin vähimmäispituus:{"**"} { $length } merkkiä
config-label-rp-cooldown = {"**"}Jäähdytysaika:{"**"} { $seconds } sekuntia
config-label-rp-frequency-once = {"**"}Tiheys:{"**"} Kerran per { $period }
config-label-rp-reset-time = {"**"}Nollausaika:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Kynnys:{"**"} { $count } kelpoista viestiä
config-label-rp-frequency-every = {"**"}Tiheys:{"**"} Joka { $count } kelpoista viestiä

config-label-rp-channels = {"**"}Roolipelikanavat:{"**"}
config-msg-rp-no-channels = Ei määritetty.
config-label-rp-channels-more = ...ja { $count } lisää.

config-label-rp-rewards = {"**"}Palkinnot:{"**"}
config-msg-rp-no-rewards = Ei määritetty.
config-label-rp-experience = {"**"}Kokemus:{"**"} { $xp }
config-label-rp-items = {"**"}Esineet:{"**"}
config-label-rp-currency = {"**"}Valuutta:{"**"}

## Language View
config-title-language = {"**"}Palvelimen asetukset - Kieli{"**"}
config-server-language-help =
    Tämä asetus mahdollistaa ReQuestin {"**"}julkisten{"**"} vastausten ja viestien oletuskielen määrittämisen tällä palvelimella. Julkisiin vastauksiin kuuluvat:
    - Quest- ja pelaajataulun julkaisut
    - Quest-yhteenveto ja lokikanavan viestit
    - Kaupan täydennykset
    - Pelaajan esineiden kulutus

    Tämä asetus vaikuttaa vain botin tuottamaan staattiseen tekstiin, eikä käännä dynaamista sisältöä kuten käyttäjien syöttämiä esineiden nimiä tai questien kuvauksia.

    Henkilökohtaisiin vastauksiin ja valikkoihin tämä asetus ei vaikuta.
config-label-server-language = {"**"}Palvelimen kieli:{"**"} { $language }
config-label-server-language-default = {"**"}Palvelimen kieli:{"**"} Oletus (ei ohitusta)
config-select-placeholder-server-language = Valitse palvelimen kieli
config-select-option-default = Oletus (ei ohitusta)
config-select-desc-default = Käytä kunkin käyttäjän omaa asetusta tai Discord-kieltä.

# Quest Roles
config-btn-quest-roles = Quest-roolit
config-btn-manage-gm-quest-roles = Hallinnoi

config-modal-title-confirm-quest-role-removal = Vahvista roolin poisto
config-modal-label-remove-quest-role = Poistetaanko { $roleName } käyttäjältä { $gmName }?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Valitse quest-roolitila
config-select-option-quest-role-disabled = Pois käytöstä
config-select-desc-quest-role-disabled = Rooleja ei luoda eikä määritetä.
config-select-option-quest-role-temporary = Väliaikainen
config-select-desc-quest-role-temporary = GM:t voivat luoda väliaikaisia rooleja questikohtaisesti.
config-select-option-quest-role-static = Kiinteä
config-select-desc-quest-role-static = GM:t valitsevat ennalta määritetyistä palvelinrooleista.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Määritä palvelinrooli(t) tälle GM:lle

## Quest Roles View
config-title-quest-roles = {"**"}Palvelimen asetukset - Quest-roolit{"**"}

config-label-quest-role-mode-disabled = {"**"}Quest-roolitila:{"**"} Pois käytöstä
    Rooleja ei luoda eikä määritetä questien aikana.
config-label-quest-role-mode-temporary = {"**"}Quest-roolitila:{"**"} Väliaikainen
    GM:t voivat halutessaan luoda väliaikaisen roolin questin luonnin yhteydessä.
    Rooli poistetaan, kun quest valmistuu tai peruutetaan.
config-label-quest-role-mode-static = {"**"}Quest-roolitila:{"**"} Kiinteä
    GM:t valitsevat ennalta määritetyistä palvelinrooleista. Roolit annetaan
    ryhmän jäsenille questien aikana, mutta niitä ei koskaan poisteta.

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}Palvelimen asetukset - Kiinteät quest-roolimääritykset{"**"}
config-label-manage-assignments = Hallinnoi roolimäärityksiä
config-desc-manage-assignments =
    Määritä olemassa olevia palvelinrooleja GM:ille käytettäväksi questien aikana.
    Roolien on oltava alempana kuin ReQuestin korkein rooli palvelinhierarkiassa.
config-msg-no-gm-members = Palvelimelta ei löytynyt jäseniä, joilla on GM-rooli.
config-label-no-roles-assigned = Quest-rooleja ei ole määritetty
config-label-more-roles = (+{ $count } lisää)

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}Hallinnoi quest-rooleja — { $gmName }{"**"}
config-error-unmanageable-roles = Seuraavia rooleja ei voida määrittää, koska ne ovat integraation hallinnoimia, oletusrooli tai ReQuestin korkeimman roolin yläpuolella: { $roles }
config-error-quest-role-limit = Tämä GM on saavuttanut enimmäismäärän { $limit } määritettyä quest-roolia.
config-label-quest-role-count = Määritetyt roolit: { $count }/{ $limit }
