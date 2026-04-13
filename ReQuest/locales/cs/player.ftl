## Player module strings

# --- Cog ---


# --- Buttons ---

# Character management
player-btn-register-character = Zaregistrovat novou postavu
player-btn-activate = Aktivovat
player-btn-active = Aktivní

# Player board
player-btn-create-post = Vytvořit příspěvek
player-btn-open-starting-shop = Otevřít startovní obchod
player-btn-select-kit = Vybrat sadu
player-btn-input-inventory = Zadat inventář

# Wizard / shop buttons
player-btn-add-to-cart = Přidat do košíku
player-btn-add-to-cart-cost = Přidat do košíku ({ $costString })
player-btn-view-purchase-options = Zobrazit možnosti nákupu
player-btn-review-submit = Zkontrolovat a odeslat ({ $count })
player-btn-submit-character = Odeslat postavu
player-btn-keep-shopping = Pokračovat v nákupu
player-btn-edit-quantity = Upravit množství
player-btn-clear-cart = Vyprázdnit košík

# Kit buttons
player-btn-confirm-selection = Potvrdit výběr
player-btn-back-to-kits = Zpět na sady

# Inventory management
player-btn-spend-currency = Utratit měnu
player-btn-print-inventory = Vytisknout inventář

# Container management
player-btn-manage-containers = Spravovat kontejnery
player-btn-create-new = + Vytvořit nový
player-btn-consume-destroy = Spotřebovat/Zničit
player-btn-move = Přesunout
player-btn-move-all = Přesunout vše
player-btn-move-some = Přesunout část...
player-btn-back-to-overview = ← Zpět na přehled
player-btn-cancel-move = ← Zrušit
player-btn-up = ▲ Nahoru
player-btn-down = ▼ Dolů

# --- Modals ---

# Trade modal
player-modal-title-trade = Obchodování s { $targetName }
player-modal-label-trade-name = Název
player-modal-placeholder-trade-name = Zadejte název předmětu, se kterým obchodujete
player-modal-label-trade-quantity = Množství
player-modal-placeholder-trade-quantity = Zadejte množství, které obchodujete

# Character register modal
player-modal-title-register = Zaregistrovat novou postavu
player-modal-label-char-name = Jméno
player-modal-placeholder-char-name = Zadejte jméno vaší postavy.
player-modal-label-char-note = Poznámka
player-modal-placeholder-char-note = Zadejte poznámku k identifikaci vaší postavy

# Open inventory input modal
player-modal-title-starting-inventory = Zadání počátečního inventáře
player-modal-label-inventory = Inventář
player-modal-placeholder-inventory-input =
    Jeden na řádek ve formátu <název>: <množství>, např.:
    Meč: 1
    gold: 30

# Spend currency modal
player-modal-title-spend-currency = Utratit měnu
player-modal-label-currency-name = Název měny
player-modal-placeholder-currency-name = Zadejte název měny, kterou utrácíte
player-modal-label-currency-amount = Částka
player-modal-placeholder-currency-amount = Zadejte částku k utracení

# Create player post modal
player-modal-title-create-post = Vytvořit příspěvek na nástěnku hráčů
player-modal-label-post-title = Název
player-modal-placeholder-post-title = Zadejte název příspěvku
player-modal-label-post-content = Obsah příspěvku
player-modal-placeholder-post-content = Zadejte tělo příspěvku

# Edit player post modal
player-modal-title-edit-post = Upravit příspěvek na nástěnce hráčů

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = Upravit množství v košíku
player-modal-label-cart-qty = Množství
player-modal-placeholder-cart-qty = Zadejte nové množství (0 pro odebrání)

# Create container modal
player-modal-title-create-container = Vytvořit nový kontejner
player-modal-label-container-name = Název kontejneru
player-modal-placeholder-container-name = Zadejte název kontejneru (např. Batoh)

# Rename container modal
player-modal-title-rename-container = Přejmenovat kontejner
player-modal-label-new-container-name = Nový název kontejneru
player-modal-placeholder-new-container-name = Zadejte nový název

# Consume from container modal
player-modal-title-consume = Spotřebovat/Zničit předmět
player-modal-label-consume-qty = Množství (max: { $maxQuantity })
player-modal-placeholder-consume-qty = Zadejte množství ke spotřebování/zničení

# Move item quantity modal
player-modal-title-move-item = Přesunout předmět
player-modal-label-move-qty = Množství k přesunu (max: { $maxQuantity })
player-modal-placeholder-move-qty = Zadejte množství k přesunu

# --- Selects ---

player-select-placeholder-no-characters = Nemáte žádné zaregistrované postavy
player-select-placeholder-remove-character = Vyberte postavu k odebrání
player-select-placeholder-post = Vyberte příspěvek
player-select-placeholder-container-view = Vyberte kontejner k zobrazení...
player-select-placeholder-item = Vyberte předmět...
player-select-placeholder-destination = Vyberte cíl...
player-select-placeholder-container = Vyberte kontejner...
player-select-option-no-containers = Žádné kontejnery
player-select-option-no-items = Žádné předměty
player-select-option-no-destinations = Žádné cíle

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}Příkazy hráče - Hlavní menu{"**"}
player-menu-btn-characters = Postavy
player-menu-desc-characters = Zaregistrujte, zobrazte a aktivujte herní postavy.
player-menu-btn-inventory = Inventář
player-menu-desc-inventory = Zobrazte inventář aktivní postavy a utraťte měnu.
player-menu-btn-player-board = Nástěnka hráčů
player-menu-btn-player-board-disabled = Nástěnka hráčů (Není nakonfigurována)
player-menu-desc-player-board = Vytvořte příspěvek na nástěnku hráčů

# CharacterBaseView
player-title-characters = {"**"}Příkazy hráče - Postavy{"**"}
player-desc-register-character = Zaregistrujte novou postavu.
player-msg-no-characters = Nemáte žádné zaregistrované postavy.
player-label-active = (Aktivní)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Rozpracovaná postava: { $characterName }{"**"}
    Registrace vaší postavy čeká na nastavení inventáře.
player-btn-resume = Pokračovat
player-btn-discard = Zahodit
player-modal-title-discard-character = Zahodit postavu
player-modal-label-discard-confirm = Zahodit { $characterName }?

# Confirm character removal
player-modal-title-confirm-char-removal = Potvrdit odebrání postavy
player-modal-label-confirm-char-delete = Smazat { $characterName }?

# Confirm post removal
player-modal-title-confirm-post-removal = Potvrdit odebrání příspěvku
player-modal-label-post-removal-warning = VAROVÁNÍ: Tato akce je nevratná!

# InventoryOverviewView
player-title-inventory = {"**"}Příkazy hráče - Inventář{"**"}
player-title-char-inventory = {"**"}Inventář postavy { $characterName }{"**"}
player-msg-no-active-character = Žádná aktivní postava: Aktivujte postavu pro tento server, abyste mohli používat tato menu.
player-msg-no-characters-registered = Žádné postavy: Zaregistrujte postavu pro použití těchto menu.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } předmětů
player-label-currency = {"**"}Měna{"**"}
player-msg-inventory-empty = Inventář je prázdný.

# Print inventory embed
player-embed-title-inventory = Inventář postavy { $characterName }

# ContainerItemsView
player-msg-container-empty = Tento kontejner je prázdný.
player-label-selected-item = Vybráno: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Přesunout „{ $itemName }"{"**"} ({ $available } dostupných)
player-msg-no-other-containers = Žádné další kontejnery nejsou k dispozici.
player-msg-select-destination = Vyberte cílový kontejner:
player-label-destination = Cíl: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Správa kontejnerů{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } předmětů){ $suffix }
player-label-default-suffix = { " " }(výchozí)
player-msg-no-containers = Žádné kontejnery.
player-label-selected-container = Vybráno: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = Potvrdit smazání kontejneru
player-modal-label-container-has-items = Obsahuje { $itemCount } předmětů. Budou přesunuty do Volných předmětů.
player-modal-label-confirm-container-delete = Smazat „{ $containerName }"?

# Container errors
player-error-cannot-rename-loose = Volné předměty nelze přejmenovat.
player-error-cannot-delete-loose = Volné předměty nelze smazat.

# PlayerBoardView
player-title-player-board = {"**"}Příkazy hráče - Nástěnka hráčů{"**"}
player-desc-create-post = Vytvořte nový příspěvek na nástěnku hráčů.
player-msg-no-posts = Nemáte žádné aktuální příspěvky.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Autor
player-embed-footer-post-id = ID příspěvku: { $postId }
player-error-board-channel-not-found = Kanál nástěnky hráčů nebyl nalezen.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Nastavení inventáře pro { $characterName }{"**"}
player-desc-browse-shop = Procházejte startovní obchod a vybavte svou postavu.
player-desc-select-kit = Vyberte startovní sadu.
player-desc-input-inventory = Ručně zadejte svůj počáteční inventář.

# StaticKitSelectView
player-title-select-kit = {"**"}Vyberte sadu pro { $characterName }{"**"}
player-msg-no-kits = Žádné startovní sady nejsou k dispozici.
player-label-and-more-items = ...a dalších { $count } předmětů
player-label-empty-kit = {"*"}Prázdná sada{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Potvrdit výběr: { $kitName }{"**"}
player-msg-kit-empty = Tato sada je prázdná.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Možnosti nákupu: { $itemName }{"**"}
player-msg-no-cost-options = Pro tento předmět nejsou k dispozici žádné možnosti ceny.
player-label-cost-option = {"**"}Možnost { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Startovní obchod ({ $inventoryType }){"**"}
player-label-starting-wealth = Počáteční majetek: { $formattedCurrency }
player-label-in-cart = {"**"}(V košíku: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Kontrola košíku{"**"}
player-msg-cart-empty = Váš košík je prázdný.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Celkem: { $totalQuantity })
player-label-insufficient-currency = Nedostatečné { $currencyName }
player-label-total-cost = {"**"}Celková cena:{"**"}
player-label-total-cost-free = {"**"}Celková cena:{"**"} Zdarma
player-label-cart-page = Stránka { $current } z { $total }

# Trade embed
player-embed-title-trade = Zpráva o obchodu
player-embed-desc-trade-sender = Odesílatel: { $senderMention } jako `{ $senderCharacter }`
player-embed-desc-trade-recipient = Příjemce: { $recipientMention } jako `{ $recipientCharacter }`
player-embed-field-currency = Měna
player-embed-field-amount = Částka
player-embed-field-balance = Zůstatek postavy { $characterName }
player-embed-field-item = Předmět
player-embed-field-quantity = Množství
player-embed-footer-transaction-id = ID transakce: { $transactionId }

# Trade errors
player-error-trade-no-characters = Hráč, se kterým se pokoušíte obchodovat, nemá žádné postavy!
player-error-trade-no-active = Hráč, se kterým se pokoušíte obchodovat, nemá na tomto serveru aktivní postavu!

# Spend currency embed
player-embed-title-spend = Zpráva o transakci hráče
player-embed-desc-spend-player = Hráč: { $playerMention } jako `{ $characterName }`
player-embed-desc-spend-transaction = Transakce: {"**"}{ $characterName }{"**"} utratil(a) {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Kanál
player-embed-field-receipt = Účtenka

# Spend currency errors
player-error-amount-not-number = Částka musí být číslo.
player-error-amount-positive = Musíte utratit kladnou částku.
player-error-amount-exceeds-maximum = Částka nesmí překročit { $max }.
player-error-no-active-character-server = Na tomto serveru nemáte aktivní postavu.
player-error-no-currency-config = Konfigurace měny pro tento server nebyla nalezena.

# Consume item embed
player-embed-title-consume = Zpráva o spotřebě předmětu
player-embed-desc-consume = Hráč: { $playerMention } jako `{ $characterName }`
player-embed-desc-consume-removed = Odebráno: {"**"}{ $quantity }x { $itemName }{"**"} z {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = Množství musí být kladné celé číslo.
player-error-qty-at-least-one = Množství musí být alespoň 1.
player-error-qty-only-have = Máte pouze { $maxQuantity } tohoto předmětu.

# Inventory input errors
player-error-invalid-format = Neplatný formát: „{ $line }". Použijte <název>: <množství>.
player-error-empty-name = Název předmětu nemůže být prázdný v řádku: „{ $line }".
player-error-invalid-quantity = Neplatné množství pro „{ $name }": „{ $quantity }". Musí to být kladné celé číslo.

# Validation error view
player-validation-error-title = Chyby vstupu
player-validation-btn-retry = Zkusit znovu

# Cart quantity validation
player-error-enter-valid-number = Zadejte prosím platné kladné číslo.

# Submission embeds (approval queue)
player-embed-field-items = Předměty
player-embed-field-currency-received = Měna
player-label-approval-thread = Schválení: { $characterName }
player-embed-title-submission-sent = Podání inventáře odesláno
player-embed-desc-submission-sent =
    Vaše podání pro {"**"}{ $characterName }{"**"} bylo odesláno týmu GM ke schválení!
    Budete upozorněni, jakmile bude přezkoumáno.
    [Zobrazit vlákno podání]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = Počáteční inventář aplikován
player-embed-desc-starting-inventory = Hráč: { $playerMention } jako `{ $characterName }`
player-embed-field-items-received = Obdržené předměty
player-embed-field-currency-received-label = Obdržená měna
player-label-untitled = Bez názvu

# ApprovalPostView
player-approval-post-header =
    {"**"}Podání inventáře: { $characterName }{"**"}
    Podáno uživatelem { $userMention }
player-approval-post-items = Předměty
player-approval-post-currency = Měna
player-approval-resolved = Tento požadavek byl vyřešen.
player-approval-btn-approve = Schválit
player-approval-btn-deny = Zamítnout
player-approval-btn-edit = Upravit
player-approval-error-no-permission = Nemáte oprávnění k provedení této akce.
player-approval-error-not-submitter = Pouze původní odesílatel může tuto žádost upravit.
player-approval-thread-instructions =
    Toto vlákno bylo vytvořeno pro schválení {"**"}{ $characterName }{"**"}.
    Game Master podání přezkoumá a schválí nebo zamítne.
    Po schválení nebo zamítnutí bude toto vlákno uzamčeno.

    {"**"}Game Masters:{"**"} Diskutujte s hráčem o všech
    požadovaných změnách, dokud inventář nebude v přijatelném stavu.
    Tlačítko `Zamítnout` použijte pouze pro neslučitelná podání.

    { $playerMention }: Použijte tlačítko `Upravit` k provedení změn
    požadovaných zde Game Masterem.
player-approval-approved-by = Tento požadavek byl schválen uživatelem { $approver }.
player-approval-denied-by = Tento požadavek byl zamítnut uživatelem { $denier }.
player-approval-deny-reason = Důvod: { $reason }
player-msg-submission-updated = Vaše žádost byla aktualizována.


# Denial modal
player-modal-title-deny-reason = Zamítnout požadavek
player-modal-label-deny-reason = Důvod zamítnutí
player-modal-placeholder-deny-reason = Volitelné: vysvětlete důvod zamítnutí
# Approval DM notifications
player-dm-title-approved = Postava schválena
player-dm-desc-approved =
    Vaše postava {"**"}{ $characterName }{"**"} byla schválena
    uživatelem { $approver } na serveru {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Postava zamítnuta
player-dm-desc-denied =
    Vaše postava {"**"}{ $characterName }{"**"} byla zamítnuta
    uživatelem { $denier } na serveru {"**"}{ $guildName }{"**"}.
