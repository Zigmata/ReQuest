## Game Master module strings

# GM buttons
gm-btn-create = Stvori
gm-btn-edit-details = Uredi quest
gm-btn-toggle-ready = Promijeni spremnost
gm-btn-configure-rewards = Konfiguriraj nagrade
gm-btn-remove-player = Ukloni igrača
gm-btn-cancel-quest = Otkaži quest
gm-btn-manage-party-rewards = Upravljaj nagradama družine
gm-btn-manage-individual-rewards = Upravljaj individualnim nagradama
gm-btn-join = Pridruži se
gm-btn-leave = Napusti
gm-btn-complete-quest = Dovrši quest
gm-btn-edit-details-modal = Uredi detalje
gm-btn-edit-images = Uredi slike
gm-btn-publish = Objavi
gm-btn-update-post = Ažuriraj objavu
gm-select-placeholder-party-role = Odaberite ulogu družine...
gm-modal-title-edit-details = Uredi detalje questa
gm-modal-title-edit-images = Uredi slike questa

# GM modals
gm-modal-title-create-quest = Stvori novi quest
gm-modal-label-quest-title = Naslov questa
gm-modal-placeholder-quest-title = Naslov vašeg questa
gm-modal-label-restrictions = Ograničenja
gm-modal-placeholder-restrictions = Ograničenja, ako postoje, poput razine igrača
gm-modal-label-max-party = Maksimalna veličina družine
gm-modal-placeholder-max-party = Maks. veličina družine za ovaj quest
gm-modal-label-party-role = Uloga družine
gm-modal-placeholder-party-role = Stvorite ulogu za ovaj quest (neobavezno)
gm-modal-label-description = Opis
gm-modal-placeholder-description = Ovdje napišite detalje svog questa
gm-modal-label-image-url = URL minijature
gm-modal-label-large-image-url = URL velike slike
gm-modal-placeholder-image-url = Unesite URL slike (ili ostavite prazno za uklanjanje)
gm-modal-title-add-reward = Dodaj nagradu
gm-modal-label-experience = Bodovi iskustva
gm-modal-placeholder-experience = Unesite broj
gm-modal-label-items = Predmeti
gm-modal-placeholder-items =
    predmet: količina
    predmet2: količina
    itd.
gm-modal-title-add-summary = Dodaj sažetak questa
gm-modal-label-summary = Sažetak
gm-modal-placeholder-summary = Dodajte sažetak priče questa
gm-modal-title-modifying-player = Izmjena { $playerName }
gm-modal-placeholder-xp-add-remove = Unesite pozitivan ili negativan broj.
gm-modal-label-inventory = Inventar
gm-modal-placeholder-inventory-modify =
    predmet: količina
    predmet2: količina
    itd.

# GM errors
gm-error-no-quest-channel = Kanal za objave questova još nije određen. Kontaktirajte administratora poslužitelja za konfiguraciju kanala za questove.
gm-error-invalid-item-format = Neispravan format predmeta: "{ $item }". Svaki predmet mora biti u novom retku, u formatu "Naziv: Količina".
gm-error-already-on-quest = Već ste na ovom questu kao { $characterName }.
gm-error-no-active-character-long = Nemate aktivnog lika na ovom poslužitelju. Koristite `/player` za registraciju ili aktivaciju lika.
gm-error-quest-locked = Greška pri pridruživanju questu {"**"}{ $questTitle }{"**"}: Quest je zaključan od strane GM-a.
gm-error-quest-full = Greška pri pridruživanju questu {"**"}{ $questTitle }{"**"}: Sastav questa je pun!
gm-error-not-signed-up = Niste prijavljeni za ovaj quest.
gm-error-quest-not-found = Zadatak više ne postoji.
gm-error-quest-channel-not-set = Kanal za questove nije postavljen!
gm-error-empty-roster = Ne možete dovršiti quest s praznim sastavom. Pokušajte otkazati umjesto toga.
gm-error-invalid-xp-value = Vrijednost XP-a mora biti pozitivan cijeli broj!
gm-error-party-size-positive = Veličina družine mora biti pozitivan broj.
gm-error-party-size-too-small = Veličina družine ne može biti manja od trenutne družine ({ $currentSize } članova).
gm-error-role-name-forbidden = Naziv uloge "{ $roleName }" je zabranjen na ovom poslužitelju.
gm-error-role-name-exists = Uloga s nazivom "{ $roleName }" već postoji na ovom poslužitelju.

# GM confirm modals
gm-modal-title-cancel-quest = Otkaži quest
gm-modal-label-cancel-quest = Upišite POTVRDI za otkazivanje questa.
gm-modal-title-remove-from-quest = Ukloni lika iz questa
gm-modal-label-remove-from-quest = Potvrditi uklanjanje lika?

# GM DM embeds
gm-dm-title-quest-cancelled = Quest otkazan
gm-dm-desc-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} je otkazan od strane GM-a.
gm-dm-title-quest-ready = Quest spreman
gm-dm-desc-quest-ready = Quest {"**"}{ $questTitle }{"**"} je sada spreman! Vaš GM će uskoro započeti quest.
gm-dm-title-player-removed = Uklonjeni iz questa
gm-dm-desc-player-removed = Uklonjeni ste iz questa {"**"}{ $questTitle }{"**"} od strane GM-a.
gm-dm-desc-player-removed-waitlist = Uklonjeni ste s liste čekanja za {"**"}{ $questTitle }{"**"}.
gm-dm-title-party-promotion = Promaknuće u družinu
gm-dm-desc-party-promotion =
    Promaknuti ste u glavnu družinu za {"**"}{ $questTitle }{"**"}
    jer je igrač napustio quest.
gm-dm-title-roster-locked = Sastav zaključan
gm-dm-desc-roster-locked =
    Sastav za {"**"}{ $questTitle }{"**"} je zaključan
    i svi članovi družine su obaviješteni.
gm-dm-title-roster-unlocked = Sastav otključan
gm-dm-desc-roster-unlocked = Sastav za {"**"}{ $questTitle }{"**"} je otključan.
gm-dm-title-player-removed-confirm = Igrač uklonjen
gm-dm-desc-player-removed-confirm =
    Igrač je uklonjen iz {"**"}{ $questTitle }{"**"}
    i sastav questa je ažuriran.
gm-dm-footer-quest = ID questa: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    Administrator vašeg poslužitelja je konfigurirao nagrade za Voditelje igre pri dovršetku
    questova. Međutim, budući da nemate registriranih likova, vaše nagrade
    nisu mogle biti automatski izdane u ovom trenutku.
gm-dm-rewards-no-active-character =
    Administrator vašeg poslužitelja je konfigurirao nagrade za Voditelje igre pri dovršetku
    questova. Međutim, budući da nemate aktivnog lika na ovom poslužitelju, vaše nagrade
    nisu mogle biti automatski izdane u ovom trenutku.
gm-dm-rewards-issued = Sljedeće je dodijeljeno vašem aktivnom liku, { $characterName }
gm-dm-role-removal-failed =
    ⚠️ Uklanjanje uloge {"**"}{ $roleName }{"**"} nije uspjelo za sljedeće članove: { $members }.
    Obavijestite administratora poslužitelja da ručno ukloni ulogu.
gm-dm-role-not-found =
    ⚠️ Uloga questa (ID: { $roleId }) za quest {"**"}{ $questTitle }{"**"} više ne postoji na poslužitelju.
    Operacije s ulogama su preskočene. Obavijestite administratora poslužitelja ako je ovo neočekivano.

# GM select menus
gm-select-placeholder-party-member = Odaberite člana družine
gm-select-option-no-role = Ništa (bez uloge družine)

# GM embeds
gm-embed-title-mod-report = Izvješće o GM izmjeni igrača
gm-embed-field-experience = Iskustvo
gm-embed-title-quest-complete = Quest dovršen: { $questTitle }
gm-embed-title-quest-completed = QUEST DOVRŠEN: { $questTitle }
gm-embed-field-rewards = Nagrade
gm-embed-field-party = __Družina__
gm-embed-field-summary = Sažetak
gm-embed-title-gm-rewards = GM nagrade izdane
gm-embed-field-items = Predmeti

# GM views
gm-title-main-menu = Voditelj igre - Glavni izbornik
gm-menu-quests = Questovi
gm-menu-desc-quests = Stvorite, uredite i upravljajte questovima.
gm-menu-players = Igrači
gm-menu-desc-players = Upravljajte inventarima igrača i mijenjajte likove.

gm-title-quest-management = Voditelj igre - Upravljanje questovima
gm-desc-create-quest = Stvorite novi quest.
gm-msg-no-quests = Questovi nisu pronađeni.
gm-label-quest-locked = (Zaključano)
gm-label-quest-draft = (Skica)
gm-title-manage-quest = Upravljanje questom - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Uredite detalje questa poput naslova, opisa i veličine družine.
gm-label-field-not-set = Nije postavljeno
gm-label-description-not-set = Opis nije postavljen
gm-label-current-party-size = {"**"}Maks. veličina družine:{"**"} { $value }
gm-label-current-party-role = {"**"}Uloga družine:{"**"} { $value }
gm-desc-toggle-ready = Promijeni stanje spremnosti (Trenutno: {"**"}{ $status }{"**"})
    - Zaključava sastav questa i obavještava članove družine da će quest uskoro započeti. Ako je uloga konfigurirana, bit će dodijeljena članovima družine pri zaključavanju.
    - Otključava sastav kada se postavi na Otvoreno.
gm-label-ready-locked = Zaključano/Spremno
gm-label-ready-open = Otvoreno
gm-desc-configure-rewards = Konfigurirajte nagrade za odabrani quest.
gm-desc-complete-quest = Dovršite quest. Izdaje nagrade, ako postoje, članovima družine.
gm-desc-remove-player = Uklonite igrača sa sastava questa i obavijestite ga.
gm-desc-cancel-quest = Otkažite quest i obrišite ga s ploče questova.
gm-title-player-management = Voditelj igre - Upravljanje igračima
gm-desc-player-management =
    Ove naredbe su premještene u kontekstualne izbornike. Desnom tipkom miša kliknite (desktop) ili dugo pritisnite (mobilni) na profil igrača za sljedeće opcije izbornika:

    - {"**"}Izmijeni Igrača{"**"}: Dodajte ili uklonite predmete i iskustvo od igrača.
    - {"**"}Pregledaj Igrača{"**"}: Pregledajte detalje aktivnog lika igrača.
gm-title-remove-player = Ukloni igrača iz questa - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Napomene o uklanjanju igrača{"**"}__

    - Odaberite igrača iz padajućeg izbornika ispod kako biste ga uklonili sa sastava questa.
    - Ako su igrači na listi čekanja, prvi igrač na listi bit će promaknut u družinu.
    - Individualne nagrade za uklonjenog igrača bit će obrisane iz questa.
    - Ako želite nagraditi igrača za prethodne doprinose, koristite kontekstualni izbornik `Izmijeni Igrača` za izravno izdavanje nagrada.
gm-label-no-players-in-roster = Nema igrača u sastavu questa
gm-title-character-sheet = List lika za { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Bodovi iskustva:{"**"}__
gm-label-possessions = __{"**"}Posjedi{"**"}__

# GM approvals

gm-error-role-hierarchy = ReQuest ne može upravljati ulogom "{ $roleName }" (ID: { $roleId }) jer je pozicionirana iznad najviše uloge ReQuesta u hijerarhiji poslužitelja. Kontaktirajte administratora poslužitelja da premjesti ulogu ispod uloge ReQuesta ili dodijeli ReQuestu višu ulogu, zatim ponovite operaciju.
