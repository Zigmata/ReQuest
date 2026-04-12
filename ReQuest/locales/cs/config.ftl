## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = Vymazat
config-btn-remove-gm-roles = Odebrat role GM
config-btn-forbidden-roles = Zakázané role

# Quests
config-btn-toggle-quest-summary = Přepnout souhrn questu
config-btn-toggle-player-experience = Přepnout zkušenosti hráčů
config-btn-toggle-display = Přepnout zobrazení
config-btn-purge-player-board = Vyčistit nástěnku hráčů
config-btn-add-modify-rewards = Přidat/Upravit odměny

# Currency
config-btn-add-denomination = Přidat nominální hodnotu
config-btn-add-new-currency = Přidat novou měnu
config-btn-remove-currency = Odebrat měnu

# Shops - creation
config-btn-add-shop-wizard = Přidat obchod (Průvodce)
config-btn-add-shop-json = Přidat obchod (JSON)
config-btn-edit-shop-wizard = Upravit obchod (Průvodce)
config-btn-edit-shop-json = Upravit obchod (JSON)
config-btn-remove-shop = Odebrat obchod
config-btn-add-item = Přidat předmět
config-btn-edit-shop-details = Upravit detaily obchodu
config-btn-download-json = Stáhnout JSON
config-btn-done-editing = Úpravy dokončeny
config-btn-scan-server-configs = Skenovat konfigurace serveru
config-btn-re-scan = Znovu skenovat

# New character shop
config-btn-upload-json = Nahrát JSON
config-btn-configure-new-character-wealth = Konfigurovat počáteční majetek
config-btn-configure-new-character-shop = Konfigurovat obchod pro nové postavy
config-btn-clear-shop = Vymazat obchod
config-btn-configure-static-kits = Konfigurovat statické sady
config-btn-new-character-settings = Nastavení nových postav
config-btn-disabled-no-currency = Vypnuto (Není nakonfigurována měna)
config-btn-disabled-no-wealth = Vypnuto (Není nakonfigurován počáteční majetek)

# Static kits
config-btn-create-new-kit = Vytvořit novou sadu
config-btn-delete-kit = Smazat sadu
config-btn-add-currency = Přidat měnu

# Roleplay
config-btn-toggle-rp-rewards = Přepnout RP odměny
config-btn-clear-channels = Vymazat kanály
config-btn-edit-settings = Upravit nastavení
config-btn-configure-rewards = Konfigurovat odměny

# Stock
config-btn-stock-limits = Limity zásob
config-btn-set-limit = Nastavit limit
config-btn-edit-limit = Upravit limit
config-btn-remove-limit = Odebrat limit
config-btn-configure-restock-schedule = Konfigurovat plán doplňování
config-btn-back-to-shop-editor = Zpět do editoru obchodu

# Forum shop
config-btn-create-new-thread = Vytvořit nové vlákno
config-btn-use-existing-thread = Použít existující vlákno

# Wizard
config-btn-quit = Ukončit
config-btn-configure-channels = Konfigurovat kanály
config-btn-configure-roles = Konfigurovat role
config-btn-configure-quests = Konfigurovat questy
config-btn-configure-players = Konfigurovat hráče
config-btn-configure-currency = Konfigurovat měnu
config-btn-configure-rp-rewards = Konfigurovat RP odměny
config-btn-configure-shops = Konfigurovat obchody
config-btn-new-char-setup = Nastavení nových postav

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = Potvrdit odebrání role
config-modal-title-confirm-removal = Potvrdit odebrání
config-modal-title-confirm-currency-removal = Potvrdit odebrání měny
config-modal-title-confirm-shop-removal = Potvrdit odebrání obchodu
config-modal-title-confirm-kit-deletion = Potvrdit smazání sady
config-modal-title-confirm-remove-stock-limit = Potvrdit odebrání limitu zásob
config-modal-title-clear-shop = Potvrdit vymazání obchodu

# Confirm modal prompt labels
config-modal-label-remove-role = Odebrat { $roleName }?
config-modal-label-remove-denomination = Odebrat { $denominationName }?
config-modal-label-remove-currency = Odebrat { $currencyName }?
config-modal-label-shop-removal-warning = VAROVÁNÍ: Tato akce je nevratná!
config-modal-label-kit-deletion-warning = VAROVÁNÍ: Nevratné!
config-modal-label-remove-stock-limit = Napište POTVRDIT pro odebrání limitu zásob
config-modal-label-clear-shop = Vymazat všechny předměty z tohoto obchodu?

# Error messages from buttons
config-error-shop-data-not-found = Chyba: Data tohoto obchodu nebyla nalezena.
config-msg-shop-json-download = Zde je JSON definice pro {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Zde je JSON definice pro obchod pro nové postavy.
config-error-select-forum-first = Nejprve prosím vyberte kanál fóra.
config-error-select-thread-first = Nejprve prosím vyberte vlákno.

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Přidat novou měnu
config-modal-label-currency-name = Název měny
config-error-currency-already-exists = Měna nebo nominální hodnota s názvem { $name } již existuje!

# RenameCurrencyModal
config-modal-title-rename-currency = Přejmenovat měnu
config-modal-label-new-currency-name = Nový název měny
config-error-currency-name-exists = Měna s názvem „{ $name }" již existuje.
config-error-denomination-name-exists = Nominální hodnota s názvem „{ $name }" již existuje.

# RenameDenominationModal
config-modal-title-rename-denomination = Přejmenovat nominální hodnotu
config-modal-label-new-denomination-name = Nový název nominální hodnoty

# AddCurrencyDenominationModal
config-modal-title-add-denomination = Přidat nominální hodnotu { $currencyName }
config-modal-label-denomination-name = Název
config-modal-placeholder-denomination-name = např. Stříbro
config-modal-label-denomination-value = Hodnota
config-modal-placeholder-denomination-value = např. 0.1
config-error-denomination-matches-currency = Nový název nominální hodnoty nemůže odpovídat existující měně na tomto serveru! Nalezena existující měna s názvem „{ $existingName }".
config-error-denomination-matches-denomination = Nový název nominální hodnoty nemůže odpovídat existující nominální hodnotě na tomto serveru! Nalezena existující nominální hodnota s názvem „{ $denominationName }" pod měnou „{ $currencyName }".
config-error-denomination-value-exists = Nominální hodnoty v rámci jedné měny musí mít unikátní hodnoty! { $denominationName } již má tuto hodnotu přiřazenu.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Zakázané názvy rolí
config-modal-label-names = Názvy
config-modal-placeholder-names = Zadejte názvy oddělené čárkami
config-msg-forbidden-roles-updated = Zakázané role aktualizovány!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Vyčistit nástěnku hráčů
config-modal-label-age = Stáří
config-modal-placeholder-age = Zadejte maximální stáří příspěvku (ve dnech) k ponechání
config-msg-posts-purged = Příspěvky starší než { $days } dní byly vyčištěny!

# GMRewardsModal
config-modal-title-gm-rewards = Přidat/Upravit odměny GM
config-modal-label-experience = Zkušenosti
config-modal-placeholder-enter-number = Zadejte číslo
config-modal-label-items = Předměty
config-modal-placeholder-items =
    Název: Množství
    Název2: Množství
    atd.
config-error-experience-invalid = Zkušenosti musí být platné celé číslo (např. 2000).
config-error-item-format-invalid = Neplatný formát předmětu: „{ $item }". Každý předmět musí být na novém řádku ve formátu „Název: Množství".

# ConfigShopDetailsModal
config-modal-title-shop-details = Přidat/Upravit detaily obchodu
config-modal-label-shop-channel = Vyberte kanál
config-modal-placeholder-shop-channel = Vyberte kanál pro tento obchod
config-modal-label-shop-name = Název obchodu
config-modal-placeholder-shop-name = Zadejte název obchodu
config-modal-label-shopkeeper-name = Jméno obchodníka
config-modal-placeholder-shopkeeper-name = Zadejte jméno obchodníka
config-modal-label-shop-description = Popis obchodu
config-modal-placeholder-shop-description = Zadejte popis obchodu
config-modal-label-shop-image-url = URL obrázku obchodu
config-modal-placeholder-shop-image-url = Zadejte URL obrázku obchodu
config-error-no-channel-selected = Nebyl vybrán žádný kanál pro obchod.
config-error-shop-already-in-channel = V tomto kanálu je již zaregistrován obchod. Vyberte prosím jiný kanál nebo upravte existující obchod.

# build_shop_header_view
config-label-shopkeeper = {"**"}Obchodník:{"**"} { $name }
config-msg-use-shop-command = Použijte příkaz `/shop` k procházení a nákupu předmětů.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Vytvořit obchod ve vlákně fóra
config-modal-label-thread-name = Název vlákna
config-modal-placeholder-thread-name = Zadejte název vlákna pro obchod
config-error-forum-not-found = Vybraný kanál fóra nebyl nalezen.
config-error-shop-already-in-thread = V tomto vlákně je již zaregistrován obchod. To by se u nového vlákna nemělo stát.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Přidat nový obchod pomocí JSON
config-modal-label-upload-json = Nahrajte soubor .json s daty obchodu
config-error-no-json-uploaded = Nebyl nahrán žádný JSON soubor pro obchod.
config-error-file-must-be-json = Nahraný soubor musí být JSON soubor (.json).
config-error-invalid-json = Neplatný formát JSON: { $error }
config-error-json-validation-failed = JSON neodpovídá schématu: { $error }

# ShopItemModal
config-modal-title-shop-item = Přidat/Upravit předmět obchodu
config-modal-label-item-name = Název předmětu
config-modal-placeholder-item-name = Zadejte název předmětu
config-modal-label-item-description = Popis předmětu
config-modal-placeholder-item-description = Zadejte popis předmětu
config-modal-label-item-quantity = Množství předmětu
config-modal-placeholder-item-quantity = Zadejte množství prodávané za nákup
config-modal-label-item-costs = Ceny předmětu
config-modal-placeholder-item-costs = Např.: 10 gold + 5 silver\nNEBO: 50 rep\n(Použijte + pro A, Nové řádky pro NEBO)
config-error-item-quantity-positive = Množství předmětu musí být kladné celé číslo.
config-error-cost-format-invalid = Neplatný formát ceny v možnosti: „{ $option }". Každá cena musí obsahovat částku a měnu oddělené mezerou, např. „10 gold".
config-error-cost-amount-invalid = Neplatná částka „{ $amount }" pro měnu: „{ $currency }". Částka musí být kladné číslo.
config-error-unknown-currency = Neznámá měna `{ $currency }`. Použijte prosím platnou měnu nakonfigurovanou pro tento server.
config-error-item-already-exists = Předmět s názvem { $itemName } již v tomto obchodě existuje.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Aktualizovat obchod pomocí JSON
config-modal-label-upload-new-json = Nahrajte novou JSON definici
config-error-no-file-uploaded = Nebyl nahrán žádný soubor.
config-error-file-must-be-json-ext = Soubor musí být ve formátu `.json`.
config-error-json-validation-message = Ověření JSON selhalo: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Přidat/Upravit vybavení nové postavy
config-modal-placeholder-item-quantity-selection = Zadejte množství obdržené za výběr
config-modal-label-item-cost = Cena předmětu
config-error-cost-format-short = Neplatný formát ceny: „{ $component }". Očekáváno „Částka Měna".
config-error-amount-invalid-short = Neplatná částka „{ $amount }" pro měnu „{ $currency }".
config-error-item-exists-new-char = Předmět s názvem { $itemName } již v obchodě pro nové postavy existuje.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Nahrát obchod pro nové postavy (JSON)
config-error-no-json-uploaded-short = Nebyl nahrán žádný JSON soubor.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Nastavit počáteční majetek
config-modal-label-amount = Částka
config-modal-placeholder-amount = Zadejte částku této měny.
config-modal-placeholder-currency-name = Zadejte název měny definované na tomto serveru
config-error-no-currencies-configured = Na tomto serveru nejsou nakonfigurovány žádné měny.
config-error-currency-not-found = Měna nebo nominální hodnota s názvem { $name } nebyla nalezena. Použijte prosím platnou měnu.

# CreateStaticKitModal
config-modal-title-create-kit = Vytvořit novou statickou sadu
config-modal-label-kit-name = Název sady
config-modal-placeholder-kit-name = např. Válečnická startovní sada
config-modal-label-description = Popis
config-modal-placeholder-kit-description = Volitelný popis této sady
config-error-kit-name-exists = Statická sada s názvem „{ $kitName }" již existuje. Zvolte prosím jiný název.

# StaticKitItemModal
config-modal-title-kit-item = Přidat/Upravit předmět sady
config-modal-placeholder-kit-item-quantity = Zadejte množství tohoto předmětu v sadě

# StaticKitCurrencyModal
config-modal-title-kit-currency = Přidat měnu do sady
config-modal-placeholder-currency-eg = např. Gold
config-modal-placeholder-amount-eg = např. 100
config-error-amount-must-be-number = Částka musí být číslo.
config-error-amount-exceeds-maximum = Částka nesmí překročit { $max }.
config-error-no-currencies-on-server = Na serveru nejsou nakonfigurovány žádné měny.
config-error-currency-not-found-short = Měna „{ $currency }" nebyla nalezena.
config-error-denomination-not-found = Nominální hodnota „{ $denomination }" nebyla nalezena v konfiguraci měny.

# RoleplaySettingsModal
config-modal-title-rp-settings = Nastavení roleplay
config-modal-label-min-message-length = Minimální délka zprávy (znaků)
config-modal-placeholder-min-message-length = Počet znaků vyžadovaných pro započítání zprávy. 0 = bez limitu
config-modal-label-cooldown = Prodleva (sekundy)
config-modal-placeholder-cooldown = Čekací doba v sekundách mezi započítáváním zpráv jako způsobilých pro odměny
config-modal-label-message-threshold = Práh zpráv
config-modal-placeholder-message-threshold = Počet zpráv potřebných ke spuštění odměny
config-modal-label-frequency = Frekvence (počet zpráv)
config-modal-placeholder-frequency = Počet způsobilých zpráv potřebných k získání odměn
config-error-min-length-invalid = Minimální délka zprávy musí být nezáporné celé číslo.
config-error-cooldown-invalid = Prodleva musí být nezáporné celé číslo.
config-error-threshold-invalid = Práh zpráv musí být kladné celé číslo.
config-error-frequency-invalid = Frekvence musí být kladné celé číslo.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Konfigurovat odměny za roleplay
config-modal-label-items-name-quantity = Předměty (Název: Množství)
config-modal-label-currency-name-amount = Měna (Název: Částka)
config-error-experience-non-negative = Zkušenosti musí být nezáporné celé číslo.
config-error-item-quantity-positive-named = Množství předmětu pro „{ $itemName }" musí být kladné celé číslo.
config-error-currency-amount-positive = Částka měny pro „{ $currencyName }" musí být kladné číslo.

# SetItemStockModal
config-modal-title-stock-limit = Limit zásob: { $itemName }
config-modal-label-max-stock = Maximální zásoby
config-modal-placeholder-max-stock = Zadejte max. zásoby (např. 10)
config-modal-label-current-stock = Aktuální zásoby
config-modal-placeholder-current-stock = Zadejte aktuálně dostupné zásoby
config-modal-label-restock-increment = Krok doplnění (za cyklus)
config-modal-placeholder-restock-increment = Množství přidané za cyklus doplnění (výchozí: 1)
config-error-max-stock-positive = Maximální zásoby musí být kladné celé číslo.
config-error-current-stock-non-negative = Aktuální zásoby musí být nezáporné celé číslo.
config-error-current-exceeds-max = Aktuální zásoby nemohou překročit maximální zásoby.
config-error-item-not-in-shop = Předmět „{ $itemName }" nebyl nalezen v obchodě.

# RestockScheduleModal
config-modal-title-restock-schedule = Konfigurovat plán doplňování
config-modal-restock-schedule-label = Plán
config-modal-restock-schedule-none = Žádný (Vypnuto)
config-modal-restock-schedule-hourly = Každou hodinu
config-modal-restock-schedule-daily = Denně
config-modal-restock-schedule-weekly = Týdně
config-modal-label-time = Čas (HH:MM v UTC)
config-modal-desc-current-time = Aktuální čas: { $utcTime }
config-modal-placeholder-time = např. 14:30 pro 14:30 UTC
config-modal-restock-day-label = Den v týdnu (pouze pro týdenní)
config-modal-restock-mode-label = Režim doplnění
config-modal-restock-mode-full = Úplné (reset na maximum)
config-modal-restock-mode-incremental = Postupné (přidat množství)
config-error-time-format-invalid = Čas musí být ve formátu HH:MM (např. 14:30).
config-error-increment-positive = Přírůstek musí být kladné celé číslo.

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Vyhledejte svůj kanál { $configName }

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Vyberte roli pro oznámení questů

# AddGMRoleSelect
config-select-placeholder-gm-roles = Vyberte roli(e) GM

# ConfigWaitListSelect
config-select-placeholder-wait-list = Vyberte velikost čekací listiny
config-select-option-disabled = 0 (Vypnuto)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Vyberte režim inventáře
config-select-option-disabled-label = Vypnuto
config-select-desc-disabled = Hráči začínají s prázdnými inventáři.
config-select-option-selection = Výběr
config-select-desc-selection = Hráči volně vybírají předměty z obchodu pro nové postavy.
config-select-option-purchase = Nákup
config-select-desc-purchase = Hráči nakupují předměty z obchodu pro nové postavy za danou měnu.
config-select-option-open = Otevřený
config-select-desc-open = Hráči ručně zadávají své inventáře.
config-select-option-static = Statický
config-select-desc-static = Hráči dostanou předem definovaný počáteční inventář.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Vyberte způsobilé kanály

# RoleplayModeSelect
config-select-placeholder-rp-mode = Vyberte režim
config-select-option-scheduled = Plánovaný
config-select-desc-scheduled = Odměny jsou uděleny jednou v rámci stanoveného období resetu.
config-select-option-accrued = Kumulativní
config-select-desc-accrued = Odměny jsou opakovaně udělovány na základě stanovené úrovně aktivity.

# RoleplayResetSelect
config-select-placeholder-reset-period = Vyberte období resetu
config-select-option-hourly = Každou hodinu
config-select-desc-hourly = Resetuje se každou hodinu.
config-select-option-daily = Denně
config-select-desc-daily = Resetuje se každých 24 hodin.
config-select-option-weekly = Týdně
config-select-desc-weekly = Resetuje se každých 7 dní.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Vyberte den resetu

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Vyberte čas resetu (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Vyberte kanál fóra

# ForumThreadSelect
config-select-placeholder-thread = Vyberte vlákno
config-select-option-no-threads = Nenalezena žádná aktivní vlákna
config-select-desc-no-threads = Vytvořte nové vlákno nebo zkontrolujte archivovaná vlákna
config-select-option-select-forum-first = Nejprve vyberte fórum
config-select-desc-select-forum-first = Nejprve prosím vyberte kanál fóra výše
config-select-desc-thread-id = ID vlákna: { $threadId }
config-error-select-valid-thread = Vyberte prosím platné vlákno nebo vytvořte nové.
config-error-thread-not-found = Vybrané vlákno nebylo nalezeno. Mohlo být smazáno nebo archivováno.

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = Konfigurace serveru - Hlavní menu
config-menu-config-wizard = Průvodce konfigurací
config-menu-desc-config-wizard = Ověřte, zda je váš server připraven k použití ReQuestu, rychlým skenováním.
config-menu-channels = Kanály
config-menu-desc-channels = Nastavte určené kanály pro příspěvky ReQuestu.
config-menu-currency = Měna
config-menu-desc-currency = Globální nastavení měny.
config-menu-players = Hráči
config-menu-desc-players = Globální nastavení hráčů, jako je sledování bodů zkušeností.
config-menu-quests = Questy
config-menu-desc-quests = Globální nastavení questů, jako jsou čekací listiny.
config-menu-rp-rewards = RP odměny
config-menu-desc-rp-rewards = Konfigurujte odměny za roleplay.
config-menu-roles = Role
config-menu-desc-roles = Možnosti konfigurace pro role s notifikacemi nebo privilegii.
config-menu-shops = Obchody
config-menu-desc-shops = Konfigurujte vlastní obchody.
config-menu-language = Jazyk
config-menu-desc-language = Nastavte výchozí jazyk pro tento server.

## Wizard View
config-title-wizard = {"**"}Konfigurace serveru - Průvodce{"**"}
config-wizard-intro =
    {"**"}Vítejte v Průvodci konfigurací ReQuestu!{"**"}

    Tento průvodce vám pomůže zajistit, že je váš server správně nakonfigurován pro použití funkcí ReQuestu. Prohledá vaše aktuální nastavení a poskytne doporučení pro případné úpravy.

    Použijte tlačítko „Spustit skenování" níže pro zahájení ověřovacího procesu. Po dokončení skenování obdržíte podrobnou zprávu o konfiguraci vašeho serveru spolu s doporučenými změnami.

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}Globální oprávnění bota{"**"}__
config-wizard-bot-permissions-desc = Tato sekce ověřuje, že ReQuest má správná oprávnění pro správné fungování.
config-wizard-bot-role = Role bota: { $roleMention }
config-wizard-status-warnings = {"**"}Stav: ⚠️ NALEZENA VAROVÁNÍ{"**"}
config-wizard-missing-perm = - ⚠️ Chybí: `{ $permissionName }`
config-wizard-ensure-permissions = Ujistěte se, že nejvyšší role bota má tato oprávnění udělena globálně.
config-wizard-status-ok = {"**"}Stav: ✅ OK{"**"}
config-wizard-bot-permissions-ok = Bot má všechna požadovaná globální oprávnění.
config-wizard-status-scan-failed = {"**"}Stav: ❌ SKENOVÁNÍ SELHALO{"**"}
config-wizard-scan-error = Při kontrole oprávnění bota došlo k neočekávané chybě.
config-wizard-error-type = Chyba: { $errorType }
config-wizard-required-permissions = {"**"}Požadovaná oprávnění pro roli bota:{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = Zobrazit kanály
config-wizard-perm-manage-roles = Spravovat role
config-wizard-perm-send-messages = Odesílat zprávy
config-wizard-perm-attach-files = Připojovat soubory
config-wizard-perm-add-reactions = Přidávat reakce
config-wizard-perm-use-external-emoji = Používat externí emotikony
config-wizard-perm-manage-messages = Spravovat zprávy
config-wizard-perm-read-message-history = Číst historii zpráv

# Wizard - Role Validation
config-wizard-role-header = __{"**"}Konfigurace rolí{"**"}__
config-wizard-role-desc =
    Tato sekce ověřuje následující:

    - Role GM (povinné) a role pro oznámení (volitelná) jsou nakonfigurovány.
    - Výchozí role (@everyone) má požadovaná oprávnění pro přístup uživatelů k funkcím bota.
    - Výchozí role (@everyone) nemá nebezpečná oprávnění.
    - Role GM a oznámení jsou kontrolovány na eskalaci oprávnění nad výchozí roli.

    Jakákoliv varování zde jsou pouze doporučení na základě výchozího nastavení. V závislosti na potřebách vašeho serveru můžete mít důvod některá z těchto doporučení ignorovat.

config-wizard-default-role-label = {"**"}Výchozí role:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Nalezena nebezpečná oprávnění:
config-wizard-default-role-ok = - ✅ @everyone: OK
config-wizard-missing-permission = - Chybějící oprávnění: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}Role GM:{"**"}
config-wizard-no-gm-roles = - ⚠️ Nejsou nakonfigurovány žádné role GM
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Nakonfigurovaná role nebyla nalezena / byla smazána ze serveru
config-wizard-role-ok = - ✅ { $roleMention }: OK
config-wizard-announcement-role-label = {"**"}Role pro oznámení:{"**"}
config-wizard-no-announcement-role = - ℹ️ Role pro oznámení není nakonfigurována
config-wizard-announcement-role-not-found = - ⚠️ Nakonfigurovaná role nebyla nalezena / byla smazána ze serveru
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Zjištěna eskalace oprávnění - { $escalations }
config-wizard-escalation-more = , a dalších { $count }...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = Odesílat zprávy ve vláknech
config-wizard-perm-use-application-commands = Používat příkazy aplikací

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = Spravovat kanály
config-wizard-perm-manage-webhooks = Spravovat webhooky
config-wizard-perm-manage-server = Spravovat server
config-wizard-perm-manage-nicknames = Spravovat přezdívky
config-wizard-perm-kick-members = Vykopávat členy
config-wizard-perm-ban-members = Zakazovat členy
config-wizard-perm-timeout-members = Ztlumit členy
config-wizard-perm-mention-everyone = Zmínit @everyone
config-wizard-perm-manage-threads = Spravovat vlákna
config-wizard-perm-administrator = Administrátor

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}Konfigurace kanálů{"**"}__
config-wizard-channel-desc =
    Tato sekce ověřuje následující:

    - Nakonfigurované kanály existují.
    - Bot má oprávnění zobrazit a odesílat zprávy v nakonfigurovaných kanálech.
    - Výchozí role (@everyone) nemá oprávnění „Odesílat zprávy".

config-wizard-channel-no-config-required = - ⚠️ Kanál není nakonfigurován
config-wizard-channel-not-configured = - ℹ️ Není nakonfigurován (volitelné)
config-wizard-channel-not-found = - ⚠️ Nakonfigurovaný kanál nebyl nalezen / byl smazán ze serveru
config-wizard-channel-ok = - ✅ OK
config-wizard-bot-cannot-view = - ⚠️ { $botMention } nemůže zobrazit tento kanál.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } nemůže odesílat zprávy v tomto kanálu.
config-wizard-everyone-can-send = - ⚠️ @everyone může odesílat zprávy v tomto kanálu.

# Wizard - Channel names
config-wizard-channel-quest-board = Nástěnka questů
config-wizard-channel-player-board = Nástěnka hráčů
config-wizard-channel-quest-archive = Archiv questů
config-wizard-channel-gm-transaction-log = Protokol transakcí GM
config-wizard-channel-player-transaction-log = Protokol transakcí hráčů
config-wizard-channel-shop-log = Protokol obchodu
config-wizard-channel-approval-queue = Fronta schvalování postav

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}Přehled nastavení{"**"}__
config-wizard-dashboard-desc = Tato sekce poskytuje přehled nepodstatných konfigurací pro rychlou orientaci.
config-wizard-quest-settings = {"**"}Nastavení questů{"**"}
config-wizard-quest-wait-list = - Velikost čekací listiny questů: { $size }
config-wizard-quest-summary = - Souhrn questu: { $status }
config-wizard-gm-rewards-per-quest = {"**"}Odměny GM (za quest){"**"}
config-wizard-player-settings = {"**"}Nastavení hráčů{"**"}
config-wizard-player-experience = - Zkušenosti hráčů: { $status }
config-wizard-currency-settings = {"**"}Nastavení měny{"**"}
config-wizard-rp-rewards = {"**"}Odměny za roleplay{"**"}
config-wizard-rp-status = - Stav: { $status }
config-wizard-rp-mode = - Režim: { $mode }
config-wizard-rp-channels = - Sledované kanály: { $count }
config-wizard-shops = {"**"}Obchody{"**"}
config-wizard-shops-count = - Nakonfigurované obchody: { $count }
config-wizard-shops-more = - ...a dalších { $count }
config-wizard-new-char-setup = {"**"}Nastavení nových postav{"**"}
config-wizard-inventory-type = - Typ inventáře: { $type }
config-wizard-new-char-shop-items = - Předměty obchodu pro nové postavy: { $count }
config-wizard-static-kits = - Statické sady: { $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ Nejsou nakonfigurovány žádné měny
config-wizard-configured-currencies = {"**"}Nakonfigurované měny:{"**"}
config-wizard-no-denominations = - Nejsou nakonfigurovány žádné nominální hodnoty
config-wizard-gm-rewards-disabled = {"**"}Stav:{"**"} Vypnuto
config-wizard-gm-rewards-enabled = {"**"}Stav:{"**"} Zapnuto
config-wizard-gm-rewards-experience = - Zkušenosti: { $xp }
config-wizard-gm-rewards-items = - Předměty:

# Wizard - Jazyk serveru (Strana 1)
config-wizard-server-language-desc =
    Toto je jazyk, který ReQuest použije pro všechny veřejné zprávy, jako jsou příspěvky o questech, zprávy o doplnění zásob obchodu a protokoly transakcí.
config-wizard-server-language = {"**"}Jazyk serveru:{"**"} { $language }
config-wizard-server-language-default = Výchozí (angličtina)

# Wizard - Informace o doplnění zásob obchodu
config-wizard-shop-restock-not-scheduled = ℹ️ Doplnění zásob není naplánováno

# Wizard - Nastavení questů (Strana 5)
config-wizard-quest-header = __{"**"}Nastavení questů{"**"}__
config-wizard-quest-header-desc =
    Tato sekce poskytuje přehled konfigurací souvisejících s questy.
config-wizard-quest-role-mode = - Režim rolí questů: { $mode }
config-wizard-quest-roles-label = {"**"}Role questů pro GM{"**"}
config-wizard-quest-roles-count = - Role přiřazené GM: { $count }
config-wizard-quest-roles-all-ok = - ✅ Všechny role v pořádku
config-wizard-quest-roles-assigned-to = {"    "}Přiřazeno k: { $gmNames }
config-wizard-quest-roles-not-found = - ⚠️ ID role { $roleId }: Nenalezena/Smazána ze serveru
config-wizard-quest-roles-no-assignments = - ℹ️ Žádné role questů nejsou přiřazeny

## Roles View
config-title-roles = {"**"}Konfigurace serveru - Role{"**"}
config-label-announcement-role = {"**"}Role pro oznámení:{"**"} { $status }
config-desc-announcement-role = Tato role je zmíněna, když je zveřejněn quest.
config-label-announcement-role-default = {"**"}Role pro oznámení:{"**"} Není nakonfigurována
config-label-gm-roles = {"**"}Role GM:{"**"} { $roles }
config-desc-gm-roles = Tyto role poskytují přístup k příkazům a funkcím Game Mastera.
config-label-gm-roles-default = {"**"}Role GM:{"**"} Nejsou nakonfigurovány
config-title-forbidden-roles = __{"**"}Zakázané role{"**"}__
config-desc-forbidden-roles =
    Konfiguruje seznam názvů rolí, které nemohou být použity Game Mastery pro jejich role skupiny.
    Ve výchozím nastavení nelze použít `everyone`, `administrator`, `gm` a `game master`. Tato konfigurace
    tento seznam rozšiřuje.

## GM Role Remove View
config-title-remove-gm-roles = {"**"}Konfigurace serveru - Odebrat role GM{"**"}
config-msg-no-gm-roles = Nejsou nakonfigurovány žádné role GM.

## Channels View
config-title-channels = {"**"}Konfigurace serveru - Kanály{"**"}

config-label-quest-board = {"**"}Nástěnka questů:{"**"} { $channel }
config-desc-quest-board = Kanál, kde budou zveřejňovány nové/aktivní questy.
config-label-quest-board-default = {"**"}Nástěnka questů:{"**"} Není nakonfigurována

config-label-player-board = {"**"}Nástěnka hráčů:{"**"} { $channel }
config-desc-player-board = Volitelná nástěnka pro oznámení/zprávy od hráčů.
config-label-player-board-default = {"**"}Nástěnka hráčů:{"**"} Není nakonfigurována

config-label-quest-archive = {"**"}Archiv questů:{"**"} { $channel }
config-desc-quest-archive = Volitelný kanál, kam se přesunou dokončené questy se souhrnnými informacemi.
config-label-quest-archive-default = {"**"}Archiv questů:{"**"} Není nakonfigurován

config-label-gm-transaction-log = {"**"}Protokol transakcí GM:{"**"} { $channel }
config-desc-gm-transaction-log = Volitelný kanál, kde se zaznamenávají transakce GM (tj. příkazy Upravit hráče).
config-label-gm-transaction-log-default = {"**"}Protokol transakcí GM:{"**"} Není nakonfigurován

config-label-player-transaction-log = {"**"}Protokol transakcí hráčů:{"**"} { $channel }
config-desc-player-transaction-log = Volitelný kanál, kde se zaznamenávají transakce hráčů jako obchody a spotřeba předmětů.
config-label-player-transaction-log-default = {"**"}Protokol transakcí hráčů:{"**"} Není nakonfigurován

config-label-shop-log = {"**"}Protokol obchodu:{"**"} { $channel }
config-desc-shop-log = Volitelný kanál, kde se zaznamenávají transakce obchodu.
config-label-shop-log-default = {"**"}Protokol obchodu:{"**"} Není nakonfigurován

## Quests View
config-title-quests = {"**"}Konfigurace serveru - Questy{"**"}

config-label-wait-list = {"**"}Velikost čekací listiny questů:{"**"} { $size }
config-desc-wait-list = Čekací listina umožňuje zadanému počtu hráčů zařadit se do fronty na quest, který je plný, pro případ, že některý hráč odejde.
config-label-wait-list-disabled = {"**"}Velikost čekací listiny questů:{"**"} Vypnuto

config-label-quest-summary = {"**"}Souhrn questu:{"**"} { $status }
config-desc-quest-summary = Tato možnost umožňuje GM poskytnout krátký souhrn při uzavírání questů.
config-label-quest-summary-disabled = {"**"}Souhrn questu:{"**"} Vypnuto

config-label-gm-rewards = Odměny GM
config-desc-gm-rewards = Konfigurujte odměny, které GM obdrží po dokončení questů.

## GM Rewards View
config-title-gm-rewards = {"**"}Konfigurace serveru - Odměny GM{"**"}
config-desc-gm-rewards-detail =
    {"**"}Přidat/Upravit odměny{"**"}
    Otevře vstupní formulář pro přidání, úpravu nebo odebrání odměn GM.

    > Nakonfigurované odměny jsou za quest. Pokaždé, když Game Master dokončí quest, obdrží
    nakonfigurované odměny níže na svou aktivní postavu.
config-msg-no-rewards = Nejsou nakonfigurovány žádné odměny.
config-label-gm-experience = {"**"}Zkušenosti:{"**"} { $xp }
config-label-gm-items = {"**"}Předměty:{"**"}

## Players View
config-title-players = {"**"}Konfigurace serveru - Hráči{"**"}

config-label-player-experience = {"**"}Zkušenosti hráčů:{"**"} { $status }
config-desc-player-experience = Zapíná/Vypíná použití bodů zkušeností (nebo podobné progrese postav založené na hodnotách).
config-label-player-experience-disabled = {"**"}Zkušenosti hráčů:{"**"} Vypnuto

config-label-new-char-settings = {"**"}Nastavení nových postav{"**"}
config-desc-new-char-settings = Konfigurujte nastavení týkající se nových postav a způsobu inicializace jejich inventářů.

config-label-player-board-purge = {"**"}Vyčištění nástěnky hráčů{"**"}
config-desc-player-board-purge = Vyčistí příspěvky z nástěnky hráčů (pokud je povolena).

## New Character Settings View
config-title-new-character = {"**"}Konfigurace serveru - Nastavení nových postav{"**"}

config-label-inventory-type = {"**"}Typ inventáře nových postav:{"**"} { $type }
config-desc-inventory-type = Určuje, jakým způsobem nově zaregistrované postavy inicializují své inventáře.
config-label-inventory-type-disabled = {"**"}Typ inventáře nových postav:{"**"} Vypnuto

config-label-new-char-wealth = {"**"}Počáteční majetek nových postav:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Počáteční majetek nových postav:{"**"} Vypnuto

config-label-approval-queue = {"**"}Fronta schválení:{"**"} { $channel }
config-desc-approval-queue = Pokud je nastavena, nové postavy musí být schváleny GM v tomto kanálu fóra, než budou aktivní.
config-label-approval-queue-disabled = {"**"}Fronta schválení:{"**"} Vypnuto
config-label-approval-queue-not-configured = {"**"}Fronta schválení:{"**"} Není nakonfigurována

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = Hráči začínají s prázdnými inventáři.
config-desc-inv-type-selection = Hráči volně vybírají předměty z obchodu pro nové postavy.
config-desc-inv-type-purchase = Hráči nakupují předměty z obchodu pro nové postavy za danou měnu.
config-desc-inv-type-open = Hráči ručně zadávají své předměty inventáře.
config-desc-inv-type-static = Hráči dostanou předem definovaný počáteční inventář.

## New Character Shop View
config-title-new-char-shop = {"**"}Konfigurace serveru - Obchod pro nové postavy{"**"}
config-label-inv-type-selection = {"**"}Typ inventáře:{"**"} Výběr
config-desc-inv-type-selection-shop = Hráči volně vybírají předměty z obchodu pro nové postavy.
config-label-inv-type-purchase = {"**"}Typ inventáře:{"**"} Nákup
config-desc-inv-type-purchase-shop = Hráči nakupují předměty z obchodu pro nové postavy za danou měnu.
config-label-inv-type-other = {"**"}Typ inventáře:{"**"} { $type }
config-desc-inv-type-not-in-use = Obchod pro nové postavy se nepoužívá.
config-msg-define-shop-items = Definujte předměty obchodu.
config-msg-no-items = Žádné předměty nejsou nakonfigurovány.

## Static Kits View
config-title-static-kits = {"**"}Konfigurace serveru - Statické sady{"**"}
config-desc-create-kit = Vytvořte novou definici sady.
config-msg-no-kits = Nejsou nakonfigurovány žádné sady.
config-label-kit-more-items = ...a dalších { $count } předmětů
config-label-empty-kit = {"*"}Prázdná sada{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}Úprava sady: { $kitName }{"**"}
config-msg-kit-empty = Tato sada je prázdná. Použijte tlačítka výše k přidání měny nebo předmětů.
config-label-kit-currency = {"**"}Měna:{"**"} { $display }
config-label-kit-item = {"**"}Předmět:{"**"} { $name }

## Currency View
config-title-currency = {"**"}Konfigurace serveru - Měna{"**"}
config-desc-create-currency = Vytvořte novou měnu.
config-msg-no-currencies = Nejsou nakonfigurovány žádné měny.
config-label-currency-display-type = Typ zobrazení: { $type } | Nominální hodnoty: { $count }
config-label-currency-type-double = Desetinné
config-label-currency-type-integer = Celé číslo

## Edit Currency View
config-title-manage-currency = {"**"}Správa měny: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Měna a nominální hodnoty{"**"}__
    - Daný název vaší měny je považován za základní měnu a má hodnotu 1.
    {"```"}Příklad: „gold" je nakonfigurováno jako měna.{"```"}
    - Přidání nominální hodnoty vyžaduje zadání názvu a hodnoty relativní k základní měně.
    {"```"}Příklad: Gold má dvě nominální hodnoty: silver (hodnota 0,1) a copper (hodnota 0,01).{"```"}
    - Jakékoliv transakce zahrnující základní měnu nebo její nominální hodnoty budou automaticky převedeny.
    {"```"}Příklad: Hráč má 10 gold a utratí 3 copper. Jeho nový zůstatek se automaticky zobrazí jako
    9 gold, 9 silver a 7 copper.{"```"}
    - Měny zobrazené jako celé číslo ukáží každou nominální hodnotu, zatímco měny zobrazené jako desetinné
    ukáží pouze základní měnu.
    {"```"}Příklad: Hráč výše se zapnutým desetinným zobrazením bude zobrazen jako 9,97 gold.{"```"}
config-btn-toggle-display-current = Přepnout zobrazení (Aktuální: { $type })
config-msg-no-denominations = Žádné nominální hodnoty nejsou nakonfigurovány.

## Shops View
config-title-shops = {"**"}Konfigurace serveru - Obchody{"**"}
config-desc-add-shop-wizard =
    {"**"}Přidat obchod (Průvodce){"**"}
    Vytvořte nový prázdný obchod pomocí formuláře.
config-desc-add-shop-json =
    {"**"}Přidat obchod (JSON){"**"}
    Vytvořte nový obchod poskytnutím úplné JSON definice. (Pokročilé)
config-btn-example-json = Ukázkový JSON
config-desc-example-json =
    {"**"}Ukázkový JSON{"**"}
    Stáhněte si ukázkový soubor JSON zobrazující očekávaný formát.
config-msg-example-json = Zde je ukázkový soubor JSON zobrazující očekávaný formát.
config-msg-no-shops = Žádné obchody nejsou nakonfigurovány.
config-label-shop-type-forum = (Forum)
config-label-shop-channel = Kanál: <#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}Přidat obchod - Zvolte typ umístění{"**"}
config-label-text-channel = {"**"}Textový kanál{"**"}
config-desc-text-channel = Vytvořte obchod ve standardním textovém kanálu.
config-label-forum-thread = {"**"}Vlákno fóra{"**"}
config-desc-forum-thread = Vytvořte obchod ve vlákně fóra (novém nebo existujícím).

## Forum Shop Setup View
config-title-forum-setup = {"**"}Přidat obchod - Nastavení vlákna fóra{"**"}
config-label-step1 = {"**"}Krok 1: Vyberte kanál fóra{"**"}
config-label-step2 = {"**"}Krok 2: Zvolte možnost vlákna{"**"}
config-label-step3 = {"**"}Krok 3: Vyberte existující vlákno{"**"}
config-desc-create-new-thread =
    {"**"}Vytvořit nové vlákno{"**"}
    Otevře formulář pro vytvoření nového vlákna a konfiguraci obchodu.
config-label-selected-thread = {"**"}Vybrané vlákno:{"**"} { $threadName }
config-desc-click-to-configure = Klikněte pro konfiguraci obchodu v tomto vlákně.

## Manage Shop View
config-title-manage-shop = {"**"}Správa obchodu: { $shopName }{"**"}
config-label-shop-type = {"**"}Typ:{"**"} { $type }
config-label-shop-type-text = Textový kanál
config-label-shop-type-forum-thread = Vlákno fóra
config-label-shopkeeper = {"**"}Obchodník:{"**"} { $name }
config-label-shop-description = {"**"}Popis:{"**"} { $description }
config-label-shop-channel-info = {"**"}Kanál:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Upravte detaily a předměty obchodu pomocí Průvodce.
config-desc-upload-json = Nahrajte novou JSON definici pro tento obchod.
config-desc-download-json = Stáhněte aktuální JSON definici.
config-desc-remove-shop = Trvale odeberte tento obchod.

## Edit Shop View
config-title-editing-shop = {"**"}Úprava obchodu: { $shopName }{"**"}
config-label-shop-shopkeeper = Obchodník: {"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}Konfigurace zásob: { $shopName }{"**"}
config-label-current-utc = Aktuální čas UTC: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Plán doplňování:{"**"} { $schedule }
config-label-restock-hourly = v minutě :{ $minute }
config-label-restock-daily = v { $time } UTC
config-label-restock-weekly = v { $day } v { $time } UTC
config-label-restock-mode = {"**"}Režim:{"**"} { $mode }
config-label-restock-full = Plné doplnění
config-label-restock-incremental = Postupné (množství dle položky)
config-label-restock-disabled = {"**"}Plán doplňování:{"**"} Vypnuto
config-label-item-stock-limits = {"**"}Limity zásob předmětů{"**"}
config-msg-no-items-in-shop = Žádné předměty v tomto obchodě.
config-label-stock-with-available = Max: { $max } | Dostupné: { $available }
config-label-stock-increment = Doplnění: +{ $increment }/cyklus
config-label-stock-reserved = Rezervováno: { $reserved }
config-label-stock-not-initialized = Max: { $max } | Dostupné: (neinicializováno)
config-label-stock-unlimited = Zásoby: Neomezené

## Roleplay View
config-title-roleplay = {"**"}Konfigurace serveru - Odměny za roleplay{"**"}
config-label-rp-status = {"**"}Stav:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Čas serveru:{"**"} `{ $time }`
config-label-rp-enabled = Zapnuto
config-label-rp-disabled = Vypnuto

config-desc-rp-mode-scheduled = {"```"}Odměny jsou uděleny jednou, po odeslání požadovaného počtu způsobilých zpráv v nastaveném časovém období (hodinově, denně nebo týdně).{"```"}
config-desc-rp-mode-accrued = {"```"}Odměny jsou udělovány opakovaně pokaždé, když je odesláno stanovené množství způsobilých zpráv.{"```"}

config-label-rp-config-details = {"**"}Podrobnosti konfigurace:{"**"}
config-label-rp-mode = {"**"}Režim:{"**"} { $mode }
config-label-rp-min-length = {"**"}Minimální délka zprávy:{"**"} { $length } znaků
config-label-rp-cooldown = {"**"}Prodleva:{"**"} { $seconds } sekund
config-label-rp-frequency-once = {"**"}Frekvence:{"**"} Jednou za { $period }
config-label-rp-reset-time = {"**"}Čas resetu:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Práh:{"**"} { $count } způsobilých zpráv
config-label-rp-frequency-every = {"**"}Frekvence:{"**"} Každých { $count } způsobilých zpráv

config-label-rp-channels = {"**"}Kanály pro roleplay:{"**"}
config-msg-rp-no-channels = Žádné nejsou nakonfigurovány.
config-label-rp-channels-more = ...a dalších { $count }.

config-label-rp-rewards = {"**"}Odměny:{"**"}
config-msg-rp-no-rewards = Žádné nejsou nakonfigurovány.
config-label-rp-experience = {"**"}Zkušenosti:{"**"} { $xp }
config-label-rp-items = {"**"}Předměty:{"**"}
config-label-rp-currency = {"**"}Měna:{"**"}

## Language View
config-title-language = {"**"}Konfigurace serveru - Jazyk{"**"}
config-server-language-help =
    Toto nastavení vám umožňuje určit výchozí jazyk pro {"**"}veřejné{"**"} odpovědi a zprávy ReQuestu na tomto serveru. Veřejné odpovědi zahrnují:
    - Příspěvky na nástěnkách questů a hráčů
    - Souhrny questů a zprávy v protokolových kanálech
    - Doplňování obchodu
    - Spotřeba předmětů hráči

    Toto nastavení ovlivňuje pouze statický text generovaný botem a nepřekládá dynamický obsah, jako jsou uživatelem zadané názvy předmětů nebo popisy questů.

    Osobní odpovědi a menu tímto nastavením nejsou ovlivněny.
config-label-server-language = {"**"}Jazyk serveru:{"**"} { $language }
config-label-server-language-default = {"**"}Jazyk serveru:{"**"} Výchozí (bez přepsání)
config-select-placeholder-server-language = Vyberte jazyk serveru
config-select-option-default = Výchozí (bez přepsání)
config-select-desc-default = Použít preference každého uživatele nebo jazyk Discord.

# Quest Roles
config-btn-quest-roles = Role questů
config-btn-manage-gm-quest-roles = Spravovat

config-modal-title-confirm-quest-role-removal = Potvrzení odebrání role
config-modal-label-remove-quest-role = Odebrat { $roleName } od { $gmName }?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Vyberte režim rolí questů
config-select-option-quest-role-disabled = Vypnuto
config-select-desc-quest-role-disabled = Žádné role se nevytvářejí ani nepřiřazují.
config-select-option-quest-role-temporary = Dočasné
config-select-desc-quest-role-temporary = GM mohou vytvářet dočasné role pro každý quest.
config-select-option-quest-role-static = Statické
config-select-desc-quest-role-static = GM vybírají z předem přiřazených serverových rolí.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Přiřadit serverovou roli(e) tomuto GM

## Quest Roles View
config-title-quest-roles = {"**"}Konfigurace serveru - Role questů{"**"}

config-label-quest-role-mode-disabled = {"**"}Režim rolí questů:{"**"} Vypnuto
    Během questů se nevytvářejí ani nepřiřazují žádné role.
config-label-quest-role-mode-temporary = {"**"}Režim rolí questů:{"**"} Dočasné
    GM mohou volitelně vytvořit dočasnou roli při vytváření questu.
    Role se smaže po dokončení nebo zrušení questu.
config-label-quest-role-mode-static = {"**"}Režim rolí questů:{"**"} Statické
    GM vybírají z předem přiřazených serverových rolí. Role se přiřazují
    členům skupiny během questů, ale nikdy se nemažou.

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}Konfigurace serveru - Přiřazení statických rolí questů{"**"}
config-label-manage-assignments = Správa přiřazení rolí
config-desc-manage-assignments =
    Přiřaďte existující serverové role GM pro použití během questů.
    Role musí být níže než nejvyšší role ReQuest v hierarchii serveru.
config-msg-no-gm-members = Na tomto serveru nebyli nalezeni žádní členové s rolí GM.
config-label-no-roles-assigned = Žádné přiřazené role questů
config-label-more-roles = (+{ $count } dalších)

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}Správa rolí questů — { $gmName }{"**"}
config-error-unmanageable-roles = Následující role nelze přiřadit, protože jsou spravovány integrací, jsou výchozí rolí nebo jsou nad nejvyšší rolí ReQuest: { $roles }
config-error-quest-role-limit = Tento GM dosáhl maximálního počtu { $limit } přiřazených rolí questů.
config-label-quest-role-count = Přiřazené role: { $count }/{ $limit }
