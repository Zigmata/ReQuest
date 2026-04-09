## Game Master module strings

# GM buttons
gm-btn-create = Vytvořit
gm-btn-edit-details = Upravit Quest
gm-btn-toggle-ready = Přepnout připravenost
gm-btn-configure-rewards = Konfigurovat odměny
gm-btn-remove-player = Odebrat hráče
gm-btn-cancel-quest = Zrušit quest
gm-btn-manage-party-rewards = Spravovat odměny skupiny
gm-btn-manage-individual-rewards = Spravovat individuální odměny
gm-btn-join = Připojit se
gm-btn-leave = Odejít
gm-btn-complete-quest = Dokončit quest
gm-btn-edit-details-modal = Upravit detaily
gm-btn-edit-images = Upravit obrázky
gm-select-placeholder-party-role = Vyberte roli skupiny...
gm-modal-title-edit-details = Upravit detaily Questu
gm-modal-title-edit-images = Upravit obrázky Questu
gm-btn-publish = Publikovat
gm-btn-update-post = Aktualizovat příspěvek

# GM modals
gm-modal-title-create-quest = Vytvořit nový quest
gm-modal-label-quest-title = Název questu
gm-modal-placeholder-quest-title = Název vašeho questu
gm-modal-label-restrictions = Omezení
gm-modal-placeholder-restrictions = Omezení, pokud existují, jako je úroveň hráčů
gm-modal-label-max-party = Maximální velikost skupiny
gm-modal-placeholder-max-party = Maximální velikost skupiny pro tento quest
gm-modal-label-party-role = Role skupiny
gm-modal-placeholder-party-role = Vytvořit roli pro tento quest (volitelné)
gm-modal-label-description = Popis
gm-modal-placeholder-description = Zde napište podrobnosti vašeho questu
gm-modal-label-image-url = URL miniatury
gm-modal-label-large-image-url = URL velkého obrázku
gm-modal-placeholder-image-url = Zadejte URL obrázku (nebo ponechte prázdné pro odstranění)
gm-modal-title-add-reward = Přidat odměnu
gm-modal-label-experience = Body zkušeností
gm-modal-placeholder-experience = Zadejte číslo
gm-modal-label-items = Předměty
gm-modal-placeholder-items =
    předmět: množství
    předmět2: množství
    atd.
gm-modal-title-add-summary = Přidat souhrn questu
gm-modal-label-summary = Souhrn
gm-modal-placeholder-summary = Přidejte příběhový souhrn questu
gm-modal-title-modifying-player = Úprava { $playerName }
gm-modal-placeholder-xp-add-remove = Zadejte kladné nebo záporné číslo.
gm-modal-label-inventory = Inventář
gm-modal-placeholder-inventory-modify =
    předmět: množství
    předmět2: množství
    atd.

# GM errors
gm-error-forbidden-role-name = Zadaný název role skupiny je zakázaný.
gm-error-role-already-exists = Role s tímto názvem na tomto serveru již existuje.
gm-error-no-quest-channel = Pro příspěvky questů nebyl dosud určen kanál. Kontaktujte administrátora serveru pro konfiguraci kanálu questů.
gm-error-cannot-ping-announce = Nepodařilo se pingnout roli pro oznámení { $role } v kanálu { $channel }. Zkontrolujte oprávnění kanálu a role ReQuest s administrátory serveru.
gm-error-invalid-item-format = Neplatný formát předmětu: „{ $item }". Každý předmět musí být na novém řádku ve formátu „Název: Množství".
gm-error-already-on-quest = Tohoto questu se již účastníte jako { $characterName }.
gm-error-no-active-character-long = Na tomto serveru nemáte aktivní postavu. Použijte `/player` k registraci nebo aktivaci postavy.
gm-error-quest-locked = Chyba při připojování ke questu {"**"}{ $questTitle }{"**"}: Quest je zamčen GM.
gm-error-quest-full = Chyba při připojování ke questu {"**"}{ $questTitle }{"**"}: Soupiska questu je plná!
gm-error-not-signed-up = Nejste přihlášeni k tomuto questu.
gm-error-quest-channel-not-set = Kanál questů nebyl nastaven!
gm-error-empty-roster = Nelze dokončit quest s prázdnou soupiskou. Zkuste quest místo toho zrušit.
gm-error-invalid-xp-value = Hodnota XP musí být kladné celé číslo!
gm-error-party-size-positive = Velikost skupiny musí být kladné číslo.
gm-error-party-size-too-small = Velikost skupiny nemůže být menší než aktuální skupina ({ $currentSize } členů).
gm-error-role-name-forbidden = Název role "{ $roleName }" je na tomto serveru zakázán.
gm-error-role-name-exists = Role s názvem "{ $roleName }" již na tomto serveru existuje.

# GM confirm modals
gm-modal-title-cancel-quest = Zrušit quest
gm-modal-label-cancel-quest = Napište POTVRDIT pro zrušení questu.
gm-modal-title-remove-from-quest = Odebrat postavu z questu
gm-modal-label-remove-from-quest = Potvrdit odebrání postavy?

# GM DM embeds
gm-dm-title-quest-cancelled = Quest zrušen
gm-dm-desc-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} byl zrušen GM.
gm-dm-title-quest-ready = Quest připraven
gm-dm-desc-quest-ready = Quest {"**"}{ $questTitle }{"**"} je nyní připraven! Váš GM brzy zahájí quest.
gm-dm-title-player-removed = Odebrán z Questu
gm-dm-desc-player-removed = Byli jste odebráni z questu {"**"}{ $questTitle }{"**"} GM.
gm-dm-desc-player-removed-waitlist = Byli jste odebráni z čekací listiny questu {"**"}{ $questTitle }{"**"}.
gm-dm-title-party-promotion = Povýšení do skupiny
gm-dm-desc-party-promotion =
    Byli jste povýšeni do hlavní skupiny pro {"**"}{ $questTitle }{"**"}
    protože hráč opustil quest.
gm-dm-title-roster-locked = Seznam uzamčen
gm-dm-desc-roster-locked =
    Seznam pro {"**"}{ $questTitle }{"**"} byl uzamčen
    a všichni členové skupiny byli upozorněni.
gm-dm-title-roster-unlocked = Seznam odemčen
gm-dm-desc-roster-unlocked = Seznam pro {"**"}{ $questTitle }{"**"} byl odemčen.
gm-dm-title-player-removed-confirm = Hráč odebrán
gm-dm-desc-player-removed-confirm =
    Hráč byl odebrán z {"**"}{ $questTitle }{"**"}
    a seznam questu byl aktualizován.
gm-dm-footer-quest = Quest ID: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    Administrátor vašeho serveru nakonfiguroval odměny pro Game Mastery po dokončení
    questů. Jelikož však nemáte žádné zaregistrované postavy, vaše odměny nemohly
    být v tuto chvíli automaticky vydány.
gm-dm-rewards-no-active-character =
    Administrátor vašeho serveru nakonfiguroval odměny pro Game Mastery po dokončení
    questů. Jelikož však nemáte na tomto serveru aktivní postavu, vaše odměny nemohly
    být v tuto chvíli automaticky vydány.
gm-dm-rewards-issued = Následující bylo uděleno vaší aktivní postavě, { $characterName }
gm-dm-role-removal-failed =
    ⚠️ Nepodařilo se odebrat roli {"**"}{ $roleName }{"**"} následujícím členům: { $members }.
    Upozorněte administrátora serveru, aby roli odebral ručně.

gm-dm-role-not-found =
    ⚠️ Role questu (ID: { $roleId }) pro quest {"**"}{ $questTitle }{"**"} na serveru již neexistuje.
    Operace s rolemi byly přeskočeny. Upozorněte administrátora serveru, pokud je to neočekávané.

# GM select menus
gm-select-placeholder-party-member = Vyberte člena skupiny
gm-modal-label-select-party-role = Role skupiny
gm-modal-desc-select-party-role = Vyberte roli k přiřazení skupině questu.
gm-select-option-no-role = Žádná (Bez role skupiny)

# GM embeds
gm-embed-title-mod-report = Zpráva o úpravě hráče GM
gm-embed-field-experience = Zkušenosti
gm-embed-title-quest-complete = Quest dokončen: { $questTitle }
gm-embed-title-quest-completed = QUEST DOKONČEN: { $questTitle }
gm-embed-field-rewards = Odměny
gm-embed-field-party = __Skupina__
gm-embed-field-summary = Souhrn
gm-embed-title-gm-rewards = Odměny GM vydány
gm-embed-field-items = Předměty

# GM views
gm-title-main-menu = Game Master - Hlavní menu
gm-menu-quests = Questy
gm-menu-desc-quests = Vytvářejte, upravujte a spravujte questy.
gm-menu-players = Hráči
gm-menu-desc-players = Spravujte inventáře hráčů a upravujte postavy.

gm-title-quest-management = Game Master - Správa questů
gm-desc-create-quest = Vytvořte nový quest.
gm-msg-no-quests = Žádné questy nebyly nalezeny.
gm-label-quest-locked = (Zamčeno)
gm-label-quest-draft = (Koncept)
gm-title-manage-quest = Správa questu - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Upravte detaily questu, jako je název, popis a velikost skupiny.
gm-title-edit-quest = Upravit Quest - { $questTitle }
gm-label-field-not-set = Nenastaveno
gm-label-description-not-set = Popis není nastaven
gm-label-current-title = {"**"}Název:{"**"} { $value }
gm-label-current-description = {"**"}Popis{"**"}
gm-label-current-restrictions = {"**"}Omezení:{"**"} { $value }
gm-label-current-party-size = {"**"}Maximální velikost skupiny:{"**"} { $value }
gm-label-current-party-role = {"**"}Role skupiny:{"**"} { $value }
gm-label-current-image = {"**"}Miniatura{"**"}
gm-label-current-large-image = {"**"}Obrázek{"**"}
gm-desc-toggle-ready = Přepnout stav připravenosti (Aktuální: {"**"}{ $status }{"**"})
    - Zamkne soupisku questu a upozorní členy skupiny, že quest brzy začne. Pokud je nakonfigurována role, bude přiřazena členům skupiny při zamčení.
    - Odemkne soupisku, když je nastaven na Otevřený.
gm-label-ready-locked = Zamčeno/Připraveno
gm-label-ready-open = Otevřeno
gm-desc-configure-rewards = Konfigurujte odměny pro vybraný quest.
gm-desc-complete-quest = Dokončte quest. Vydá odměny, pokud existují, členům skupiny.
gm-desc-remove-player = Odeberte hráče ze soupisky questu a upozorněte jej.
gm-desc-cancel-quest = Zrušte quest a smažte jej z nástěnky questů.
gm-desc-publish-quest = Publikovat tento quest na nástěnku questů.
gm-desc-update-quest-post = Aktualizovat příspěvek questu na nástěnce questů.
gm-error-role-hierarchy = ReQuest nemůže spravovat roli "{ $roleName }" (ID: { $roleId }), protože je umístěna výše než nejvyšší role ReQuest v hierarchii serveru. Kontaktujte administrátora serveru, aby přesunul roli pod roli ReQuest, nebo přidělil ReQuest vyšší roli, a poté operaci zopakujte.
gm-title-player-management = Game Master - Správa hráčů
gm-desc-player-management =
    Tyto příkazy byly přesunuty do kontextových menu. Klikněte pravým tlačítkem (desktop) nebo dlouze stiskněte (mobilní) profil hráče pro následující možnosti menu:

    - {"**"}Upravit hráče{"**"}: Přidejte nebo odeberte předměty a zkušenosti hráči.
    - {"**"}Zobrazit hráče{"**"}: Zobrazte detaily aktivní postavy hráče.
gm-title-remove-player = Odebrat hráče z questu - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Poznámky k odebrání hráče{"**"}__

    - Z rozbalovacího seznamu níže vyberte hráče, kterého chcete odebrat ze soupisky questu.
    - Pokud jsou na čekací listině nějací hráči, první hráč na seznamu bude povýšen do skupiny.
    - Individuální odměny pro odebraného hráče budou z questu smazány.
    - Pokud chcete hráče odměnit za předchozí příspěvky, použijte kontextové menu `Upravit hráče` k přímému vydání odměn.
gm-label-no-players-in-roster = Žádní hráči na soupisce questu
gm-title-character-sheet = List postavy pro { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Body zkušeností:{"**"}__
gm-label-possessions = __{"**"}Vlastnictví{"**"}__
gm-label-currency-heading = {"**"}Měna{"**"}
gm-msg-inventory-empty = Inventář je prázdný.

# GM approvals
