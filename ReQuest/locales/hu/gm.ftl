## Game Master module strings

# GM buttons
gm-btn-create = Létrehozás
gm-btn-edit-details = Részletek szerkesztése
gm-btn-toggle-ready = Készenlét váltása
gm-btn-configure-rewards = Jutalmak beállítása
gm-btn-remove-player = Játékos eltávolítása
gm-btn-cancel-quest = Quest törlése
gm-btn-manage-party-rewards = Csapat jutalmak kezelése
gm-btn-manage-individual-rewards = Egyéni jutalmak kezelése
gm-btn-join = Csatlakozás
gm-btn-leave = Kilépés
gm-btn-complete-quest = Quest befejezése
gm-btn-review-submission = Beküldés felülvizsgálata
gm-btn-approve = Jóváhagyás
gm-btn-deny = Elutasítás

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
gm-modal-title-editing-quest = { $questTitle } szerkesztése
gm-modal-label-title = Cím
gm-modal-label-max-party-size = Max csapatméret
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
gm-modal-title-review-submission = Beküldés felülvizsgálata
gm-modal-label-submission-id = Beküldés ID
gm-modal-placeholder-submission-id = Add meg a 8 karakteres ID-t

# GM errors
gm-error-forbidden-role-name = A csapatszerephez megadott név tiltott.
gm-error-role-already-exists = Ilyen nevű szerep már létezik ezen a szerveren.
gm-error-no-quest-channel = Még nincs kijelölt csatorna a quest bejegyzésekhez. Kérd meg a szerver adminisztrátort a Quest csatorna konfigurálására.
gm-error-cannot-ping-announce = Nem sikerült a bejelentési szerep ({ $role }) pingelése a(z) { $channel } csatornában. Ellenőrizd a csatorna és a ReQuest szerep jogosultságait a szerver adminisztrátoroddal.
gm-error-invalid-item-format = Érvénytelen tárgyformátum: „{ $item }". Minden tárgyat új sorba kell írni, „Név: Mennyiség" formátumban.
gm-error-submission-not-found = A beküldés nem található.
gm-error-already-on-quest = Már részt veszel ezen a questen mint { $characterName }.
gm-error-no-active-character-long = Nincs aktív karaktered ezen a szerveren. Használd a `/player` parancsot karakter regisztrálásához vagy aktiválásához.
gm-error-quest-locked = Hiba a(z) {"**"}{ $questTitle }{"**"} questhez való csatlakozásnál: A quest zárolva van a GM által.
gm-error-quest-full = Hiba a(z) {"**"}{ $questTitle }{"**"} questhez való csatlakozásnál: A quest létszáma betelt!
gm-error-not-signed-up = Nem vagy feliratkozva erre a questre.
gm-error-quest-channel-not-set = A quest csatorna nincs beállítva!
gm-error-empty-roster = Nem fejezhetsz be egy questet üres névsorral. Próbáld meg inkább törölni.
gm-error-invalid-xp-value = A tapasztalatpont értéknek pozitív egész számnak kell lennie!

# GM confirm modals
gm-modal-title-cancel-quest = Quest törlése
gm-modal-label-cancel-quest = Írd be: CONFIRM a quest törléséhez.
gm-modal-placeholder-cancel-quest = Írd be: „CONFIRM" a folytatáshoz.
gm-modal-title-remove-from-quest = Karakter eltávolítása a questből
gm-modal-label-remove-from-quest = Megerősíted a karakter eltávolítását?
gm-modal-placeholder-remove-from-quest = Írd be: „CONFIRM" a folytatáshoz.

# GM DM messages
gm-dm-quest-cancelled = A(z) {"**"}{ $questTitle }{"**"} quest törölve lett a GM által.
gm-dm-quest-ready = A(z) {"**"}{ $questTitle }{"**"} quest készen áll!
gm-dm-quest-unlocked = A(z) {"**"}{ $questTitle }{"**"} quest már nincs zárolva.
gm-dm-quest-locked = A(z) {"**"}{ $questTitle }{"**"} quest zárolva lett a GM által.
gm-dm-player-removed = Eltávolítottak a(z) {"**"}{ $questTitle }{"**"} questből.
gm-dm-player-removed-waitlist = Eltávolítottak a(z) {"**"}{ $questTitle }{"**"} várólistájáról.
gm-dm-party-promotion = Hozzáadtak a(z) {"**"}{ $questTitle }{"**"} quest csapatához, mert egy játékos kiesett!
gm-dm-roster-locked = Quest névsor zárolva és a csapat értesítve!
gm-dm-roster-unlocked = A quest névsor feloldásra került.
gm-dm-rewards-no-characters =
    A szerver adminisztrátora jutalmakat állított be a GM-eknek questek befejezésekor.
    Azonban mivel nincsenek regisztrált karaktereid, a jutalmaid jelenleg
    nem kerülhettek automatikus kiosztásra.
gm-dm-rewards-no-active-character =
    A szerver adminisztrátora jutalmakat állított be a GM-eknek questek befejezésekor.
    Azonban mivel nincs aktív karaktered ezen a szerveren, a jutalmaid jelenleg
    nem kerülhettek automatikus kiosztásra.
gm-dm-rewards-issued = A következők lettek kiosztva az aktív karakterednek, { $characterName }

# GM select menus
gm-select-placeholder-party-member = Válassz csapattagot

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
gm-msg-player-removed = Játékos eltávolítva és a quest névsor frissítve!

# GM views
gm-title-main-menu = GM - Főmenü
gm-menu-quests = Questek
gm-menu-desc-quests = Questek létrehozása, szerkesztése és kezelése.
gm-menu-players = Játékosok
gm-menu-desc-players = Játékos leltárak kezelése és karakterek módosítása.
gm-menu-approvals = Karakter jóváhagyások
gm-menu-desc-approvals = Karakter beküldések felülvizsgálata és jóváhagyása/elutasítása.

gm-title-quest-management = GM - Quest kezelés
gm-desc-create-quest = Új quest létrehozása.
gm-msg-no-quests = Nem található quest.
gm-label-quest-locked = (Zárolva)
gm-title-manage-quest = Quest kezelése - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Quest részleteinek szerkesztése, például cím, leírás és csapatméret.
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
gm-title-approvals = GM - Leltár jóváhagyások
gm-desc-review-submission = Adj meg egy Beküldés ID-t a felülvizsgálathoz és jóváhagyáshoz/elutasításhoz.
gm-title-reviewing = Felülvizsgálat: { $characterName }
gm-label-items = {"**"}Tárgyak:{"**"}
gm-label-currency = {"**"}Valuta:{"**"}
gm-embed-title-approved = Leltár frissítés jóváhagyva
gm-embed-desc-approved = A(z) {"**"}{ $characterName }{"**"} leltára jóváhagyva { $approver } által.
gm-embed-title-denied = Leltár frissítés elutasítva
gm-embed-desc-denied = A(z) {"**"}{ $characterName }{"**"} leltára elutasítva { $denier } által.

gm-modal-label-select-party-role = Party Role
gm-modal-desc-select-party-role = Select a role to assign to the quest party.
gm-select-option-no-role = None (No Party Role)

gm-error-role-hierarchy = ReQuest cannot manage the role "{ $roleName }" (ID: { $roleId }) because it is positioned higher than ReQuest's highest role in the server hierarchy. Please contact a server administrator to move the role below ReQuest's role, or assign ReQuest a higher role, then retry the operation.
gm-dm-role-removal-failed =
    ⚠️ Failed to remove the role {"**"}{ $roleName }{"**"} from the following members: { $members }.
    Please notify a server administrator to remove the role manually.

gm-dm-role-not-found =
    ⚠️ The quest role (ID: { $roleId }) for quest {"**"}{ $questTitle }{"**"} no longer exists on the server.
    Role operations were skipped. Please notify a server administrator if this is unexpected.
