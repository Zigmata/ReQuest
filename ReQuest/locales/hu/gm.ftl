## Game Master module strings

# GM buttons
gm-btn-create = Létrehozás
gm-btn-edit-details = Quest szerkesztése
gm-btn-toggle-ready = Készenlét váltása
gm-btn-configure-rewards = Jutalmak beállítása
gm-btn-remove-player = Játékos eltávolítása
gm-btn-cancel-quest = Quest törlése
gm-btn-manage-party-rewards = Csapat jutalmak kezelése
gm-btn-manage-individual-rewards = Egyéni jutalmak kezelése
gm-btn-join = Csatlakozás
gm-btn-leave = Kilépés
gm-btn-complete-quest = Quest befejezése
gm-btn-edit-details-modal = Részletek szerkesztése
gm-btn-edit-images = Képek szerkesztése
gm-btn-publish = Közzététel
gm-btn-update-post = Bejegyzés frissítése
gm-select-placeholder-party-role = Válassz csapatszerepet...
gm-modal-title-edit-details = Quest részleteinek szerkesztése
gm-modal-title-edit-images = Quest képeinek szerkesztése

# GM modals
gm-modal-title-create-quest = Új quest létrehozása
gm-modal-label-quest-title = Quest címe
gm-modal-placeholder-quest-title = A quest címe
gm-modal-label-restrictions = Korlátozások
gm-modal-placeholder-restrictions = Korlátozások, ha vannak, például játékos szintek
gm-modal-label-max-party = Maximális csapatméret
gm-modal-placeholder-max-party = A quest csapatának maximális mérete
gm-modal-label-party-role = Csapat szerep
gm-modal-placeholder-party-role = Szerep létrehozása ehhez a questhez (opcionális)
gm-modal-label-description = Leírás
gm-modal-placeholder-description = Írd le a quest részleteit
gm-modal-label-image-url = Bélyegkép URL
gm-modal-label-large-image-url = Nagykép URL
gm-modal-placeholder-image-url = Adj meg egy kép URL-t (vagy hagyd üresen az eltávolításhoz)
gm-modal-title-add-reward = Jutalom hozzáadása
gm-modal-label-experience = Tapasztalatpontok
gm-modal-placeholder-experience = Adj meg egy számot
gm-modal-label-items = Tárgyak
gm-modal-placeholder-items =
    tárgy: mennyiség
    tárgy2: mennyiség
    stb.
gm-modal-title-add-summary = Quest összefoglaló hozzáadása
gm-modal-label-summary = Összefoglaló
gm-modal-placeholder-summary = Adj hozzá egy történet összefoglalót a questhez
gm-modal-title-modifying-player = { $playerName } módosítása
gm-modal-placeholder-xp-add-remove = Adj meg egy pozitív vagy negatív számot.
gm-modal-label-inventory = Leltár
gm-modal-placeholder-inventory-modify =
    tárgy: mennyiség
    tárgy2: mennyiség
    stb.

# GM errors
gm-error-forbidden-role-name = A csapatszerephez megadott név tiltott.
gm-error-role-already-exists = Ilyen nevű szerep már létezik ezen a szerveren.
gm-error-no-quest-channel = Még nincs kijelölt csatorna a quest bejegyzésekhez. Kérd meg a szerver adminisztrátort a Quest csatorna konfigurálására.
gm-error-cannot-ping-announce = Nem sikerült a bejelentési szerep ({ $role }) pingelése a(z) { $channel } csatornában. Ellenőrizd a csatorna és a ReQuest szerep jogosultságait a szerver adminisztrátoroddal.
gm-error-invalid-item-format = Érvénytelen tárgyformátum: „{ $item }". Minden tárgyat új sorba kell írni, „Név: Mennyiség" formátumban.
gm-error-already-on-quest = Már részt veszel ezen a questen mint { $characterName }.
gm-error-no-active-character-long = Nincs aktív karaktered ezen a szerveren. Használd a `/player` parancsot karakter regisztrálásához vagy aktiválásához.
gm-error-quest-locked = Hiba a(z) {"**"}{ $questTitle }{"**"} questhez való csatlakozásnál: A quest zárolva van a GM által.
gm-error-quest-full = Hiba a(z) {"**"}{ $questTitle }{"**"} questhez való csatlakozásnál: A quest létszáma betelt!
gm-error-not-signed-up = Nem vagy feliratkozva erre a questre.
gm-error-quest-not-found = A küldetés már nem létezik.
gm-error-quest-channel-not-set = A quest csatorna nincs beállítva!
gm-error-empty-roster = Nem fejezhetsz be egy questet üres névsorral. Próbáld meg inkább törölni.
gm-error-invalid-xp-value = A tapasztalatpont értéknek pozitív egész számnak kell lennie!
gm-error-party-size-positive = A csapatméretnek pozitív számnak kell lennie.
gm-error-party-size-too-small = A csapatméret nem lehet kisebb a jelenlegi csapatnál ({ $currentSize } tag).
gm-error-role-name-forbidden = A(z) „{ $roleName }" szerepnév tiltott ezen a szerveren.
gm-error-role-name-exists = A(z) „{ $roleName }" nevű szerep már létezik ezen a szerveren.

# GM confirm modals
gm-modal-title-cancel-quest = Quest törlése
gm-modal-label-cancel-quest = Írd be: MEGERŐSÍT a quest törléséhez.
gm-modal-title-remove-from-quest = Karakter eltávolítása a questből
gm-modal-label-remove-from-quest = Megerősíted a karakter eltávolítását?

# GM DM embeds
gm-dm-title-quest-cancelled = Quest törölve
gm-dm-desc-quest-cancelled = A(z) {"**"}{ $questTitle }{"**"} quest törölve lett a GM által.
gm-dm-title-quest-ready = Quest kész
gm-dm-desc-quest-ready = A(z) {"**"}{ $questTitle }{"**"} quest készen áll! A GM hamarosan elindítja a questet.
gm-dm-title-player-removed = Eltávolítva a questből
gm-dm-desc-player-removed = Eltávolítottak a(z) {"**"}{ $questTitle }{"**"} questből a GM által.
gm-dm-desc-player-removed-waitlist = Eltávolítottak a(z) {"**"}{ $questTitle }{"**"} várólistájáról.
gm-dm-title-party-promotion = Csapat előléptetés
gm-dm-desc-party-promotion =
    Előléptettek a(z) {"**"}{ $questTitle }{"**"} fő csapatába,
    mert egy játékos elhagyta a questet.
gm-dm-title-roster-locked = Névsor zárolva
gm-dm-desc-roster-locked =
    A(z) {"**"}{ $questTitle }{"**"} névsora zárolva lett
    és az összes csapattag értesítve lett.
gm-dm-title-roster-unlocked = Névsor feloldva
gm-dm-desc-roster-unlocked = A(z) {"**"}{ $questTitle }{"**"} névsora feloldásra került.
gm-dm-title-player-removed-confirm = Játékos eltávolítva
gm-dm-desc-player-removed-confirm =
    A játékos eltávolításra került a(z) {"**"}{ $questTitle }{"**"} questből
    és a quest névsor frissítve lett.
gm-dm-footer-quest = Quest ID: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    A szerver adminisztrátora jutalmakat állított be a GM-eknek questek befejezésekor.
    Azonban mivel nincsenek regisztrált karaktereid, a jutalmaid jelenleg
    nem kerülhettek automatikus kiosztásra.
gm-dm-rewards-no-active-character =
    A szerver adminisztrátora jutalmakat állított be a GM-eknek questek befejezésekor.
    Azonban mivel nincs aktív karaktered ezen a szerveren, a jutalmaid jelenleg
    nem kerülhettek automatikus kiosztásra.
gm-dm-rewards-issued = A következők lettek kiosztva az aktív karakterednek, { $characterName }
gm-dm-role-removal-failed =
    ⚠️ Nem sikerült eltávolítani a(z) {"**"}{ $roleName }{"**"} szerepet a következő tagoktól: { $members }.
    Értesítsd a szerver adminisztrátort a szerep kézi eltávolításához.
gm-dm-role-not-found =
    ⚠️ A(z) {"**"}{ $questTitle }{"**"} questhez tartozó quest szerep (ID: { $roleId }) már nem létezik a szerveren.
    A szerep műveletek kihagyásra kerültek. Értesítsd a szerver adminisztrátort, ha ez nem várt esemény.

# GM select menus
gm-select-placeholder-party-member = Válassz csapattagot
gm-modal-label-select-party-role = Csapat szerep
gm-modal-desc-select-party-role = Válassz egy szerepet a quest csapatához való hozzárendeléshez.
gm-select-option-no-role = Nincs (csapat szerep nélkül)

# GM embeds
gm-embed-title-mod-report = GM játékosmódosítási jelentés
gm-embed-field-experience = Tapasztalat
gm-embed-title-quest-complete = Quest befejezve: { $questTitle }
gm-embed-title-quest-completed = QUEST BEFEJEZVE: { $questTitle }
gm-embed-field-rewards = Jutalmak
gm-embed-field-party = __Csapat__
gm-embed-field-summary = Összefoglaló
gm-embed-title-gm-rewards = GM jutalmak kiosztva
gm-embed-field-items = Tárgyak

# GM views
gm-title-main-menu = GM - Főmenü
gm-menu-quests = Questek
gm-menu-desc-quests = Questek létrehozása, szerkesztése és kezelése.
gm-menu-players = Játékosok
gm-menu-desc-players = Játékos leltárak kezelése és karakterek módosítása.

gm-title-quest-management = GM - Quest kezelés
gm-desc-create-quest = Új quest létrehozása.
gm-msg-no-quests = Nem található quest.
gm-label-quest-locked = (Zárolva)
gm-label-quest-draft = (Piszkozat)
gm-title-manage-quest = Quest kezelése - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Quest részleteinek szerkesztése, például cím, leírás és csapatméret.
gm-title-edit-quest = Quest szerkesztése - { $questTitle }
gm-label-field-not-set = Nincs beállítva
gm-label-description-not-set = Leírás nincs beállítva
gm-label-current-title = {"**"}Cím:{"**"} { $value }
gm-label-current-description = {"**"}Leírás{"**"}
gm-label-current-restrictions = {"**"}Korlátozások:{"**"} { $value }
gm-label-current-party-size = {"**"}Max csapatméret:{"**"} { $value }
gm-label-current-party-role = {"**"}Csapat szerep:{"**"} { $value }
gm-label-current-image = {"**"}Bélyegkép{"**"}
gm-label-current-large-image = {"**"}Kép{"**"}
gm-desc-publish-quest = Quest közzététele a quest hirdetőtáblán.
gm-desc-update-quest-post = A quest bejegyzés frissítése a quest hirdetőtáblán.
gm-desc-toggle-ready = Készenléti állapot váltása (Jelenlegi: {"**"}{ $status }{"**"})
    - Zárolja a quest névsort és értesíti a csapattagokat, hogy a quest hamarosan elkezdődik. Ha szerep van konfigurálva, az zároláskor hozzárendelésre kerül a csapattagokhoz.
    - Feloldja a névsort, ha Nyitottra van állítva.
gm-label-ready-locked = Zárolva/Kész
gm-label-ready-open = Nyitott
gm-desc-configure-rewards = A kiválasztott quest jutalmainak beállítása.
gm-desc-complete-quest = Quest befejezése. Jutalmak kiosztása, ha vannak, a csapattagoknak.
gm-desc-remove-player = Játékos eltávolítása a quest névsorból és értesítése.
gm-desc-cancel-quest = Quest törlése és eltávolítása a quest hirdetőtábláról.
gm-title-player-management = GM - Játékos kezelés
gm-desc-player-management =
    Ezek a parancsok kontextusmenükbe kerültek. Kattints jobb egérgombbal (asztalon) vagy nyomd meg hosszan (mobilon) egy játékos profilját a következő menüopciókhoz:

    - {"**"}Játékos módosítása{"**"}: Tárgyak és tapasztalat hozzáadása vagy eltávolítása egy játékostól.
    - {"**"}Játékos megtekintése{"**"}: Egy játékos aktív karakterének részleteinek megtekintése.
gm-title-remove-player = Játékos eltávolítása a questből - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Játékos eltávolítási megjegyzések{"**"}__

    - Válassz egy játékost az alábbi legördülő menüből a quest névsorból való eltávolításához.
    - Ha vannak játékosok a várólistán, az első játékos előlép a csapatba.
    - Az eltávolított játékos egyéni jutalmai törlésre kerülnek a questből.
    - Ha az eltávolított játékost korábbi hozzájárulásáért szeretnéd jutalmazni, használd a `Játékos módosítása` kontextusmenüt a jutalmak közvetlen kiosztásához.
gm-label-no-players-in-roster = Nincsenek játékosok a quest névsorban
gm-title-character-sheet = Karakterlap: { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Tapasztalatpontok:{"**"}__
gm-label-possessions = __{"**"}Tulajdon{"**"}__
gm-label-currency-heading = {"**"}Valuta{"**"}
gm-msg-inventory-empty = A leltár üres.

# GM approvals

gm-error-role-hierarchy = A ReQuest nem tudja kezelni a(z) "{ $roleName }" (ID: { $roleId }) szerepet, mert a szerver hierarchiában a ReQuest legmagasabb szerepe felett helyezkedik el. Kérd meg a szerver adminisztrátort, hogy helyezze a szerepet a ReQuest szerepe alá, vagy rendeljen magasabb szerepet a ReQuesthez, majd próbáld újra a műveletet.
