## Game Master module strings

# GM buttons
gm-btn-create = Stvori
gm-btn-edit-details = Uredi detalje
gm-btn-toggle-ready = Promijeni spremnost
gm-btn-configure-rewards = Konfiguriraj nagrade
gm-btn-remove-player = Ukloni igrača
gm-btn-cancel-quest = Otkaži quest
gm-btn-manage-party-rewards = Upravljaj nagradama družine
gm-btn-manage-individual-rewards = Upravljaj individualnim nagradama
gm-btn-join = Pridruži se
gm-btn-leave = Napusti
gm-btn-complete-quest = Dovrši quest
gm-btn-review-submission = Pregledaj prijavu
gm-btn-approve = Odobri
gm-btn-deny = Odbij

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
gm-modal-title-editing-quest = Uređivanje { $questTitle }
gm-modal-label-title = Naslov
gm-modal-label-max-party-size = Maks. veličina družine
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
gm-modal-title-review-submission = Pregledaj prijavu
gm-modal-label-submission-id = ID prijave
gm-modal-placeholder-submission-id = Unesite 8-znakovni ID

# GM errors
gm-error-forbidden-role-name = Navedeni naziv za ulogu družine je zabranjen.
gm-error-role-already-exists = Uloga s tim nazivom već postoji na ovom poslužitelju.
gm-error-no-quest-channel = Kanal za objave questova još nije određen. Kontaktirajte administratora poslužitelja za konfiguraciju kanala za questove.
gm-error-cannot-ping-announce = Nije moguće pingovati ulogu za objave { $role } u kanalu { $channel }. Provjerite dozvole kanala i uloge ReQuesta s administratorima poslužitelja.
gm-error-invalid-item-format = Neispravan format predmeta: "{ $item }". Svaki predmet mora biti u novom retku, u formatu "Naziv: Količina".
gm-error-submission-not-found = Prijava nije pronađena.
gm-error-already-on-quest = Već ste na ovom questu kao { $characterName }.
gm-error-no-active-character-long = Nemate aktivnog lika na ovom poslužitelju. Koristite `/player` za registraciju ili aktivaciju lika.
gm-error-quest-locked = Greška pri pridruživanju questu {"**"}{ $questTitle }{"**"}: Quest je zaključan od strane GM-a.
gm-error-quest-full = Greška pri pridruživanju questu {"**"}{ $questTitle }{"**"}: Sastav questa je pun!
gm-error-not-signed-up = Niste prijavljeni za ovaj quest.
gm-error-quest-channel-not-set = Kanal za questove nije postavljen!
gm-error-empty-roster = Ne možete dovršiti quest s praznim sastavom. Pokušajte otkazati umjesto toga.
gm-error-invalid-xp-value = Vrijednost XP-a mora biti pozitivan cijeli broj!

# GM confirm modals
gm-modal-title-cancel-quest = Otkaži quest
gm-modal-label-cancel-quest = Upišite CONFIRM za otkazivanje questa.
gm-modal-placeholder-cancel-quest = Upišite "CONFIRM" za nastavak.
gm-modal-title-remove-from-quest = Ukloni lika iz questa
gm-modal-label-remove-from-quest = Potvrditi uklanjanje lika?
gm-modal-placeholder-remove-from-quest = Upišite "CONFIRM" za nastavak.

# GM DM messages
gm-dm-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} je otkazan od strane GM-a.
gm-dm-quest-ready = Quest {"**"}{ $questTitle }{"**"} je sada spreman!
gm-dm-quest-unlocked = Quest {"**"}{ $questTitle }{"**"} više nije zaključan.
gm-dm-quest-locked = Quest {"**"}{ $questTitle }{"**"} je sada zaključan od strane GM-a.
gm-dm-player-removed = Uklonjeni ste iz questa {"**"}{ $questTitle }{"**"}.
gm-dm-player-removed-waitlist = Uklonjeni ste s liste čekanja za {"**"}{ $questTitle }{"**"}.
gm-dm-party-promotion = Dodani ste u družinu za {"**"}{ $questTitle }{"**"}, jer je igrač odustao!
gm-dm-roster-locked = Sastav questa zaključan i družina obaviještena!
gm-dm-roster-unlocked = Sastav questa je otključan.
gm-dm-rewards-no-characters =
    Administrator vašeg poslužitelja je konfigurirao nagrade za Voditelje igre pri dovršetku
    questova. Međutim, budući da nemate registriranih likova, vaše nagrade
    nisu mogle biti automatski izdane u ovom trenutku.
gm-dm-rewards-no-active-character =
    Administrator vašeg poslužitelja je konfigurirao nagrade za Voditelje igre pri dovršetku
    questova. Međutim, budući da nemate aktivnog lika na ovom poslužitelju, vaše nagrade
    nisu mogle biti automatski izdane u ovom trenutku.
gm-dm-rewards-issued = Sljedeće je dodijeljeno vašem aktivnom liku, { $characterName }

# GM select menus
gm-select-placeholder-party-member = Odaberite člana družine

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
gm-msg-player-removed = Igrač uklonjen i sastav questa ažuriran!

# GM views
gm-title-main-menu = Voditelj igre - Glavni izbornik
gm-menu-quests = Questovi
gm-menu-desc-quests = Stvorite, uredite i upravljajte questovima.
gm-menu-players = Igrači
gm-menu-desc-players = Upravljajte inventarima igrača i mijenjajte likove.
gm-menu-approvals = Odobrenja likova
gm-menu-desc-approvals = Pregledajte i odobrite/odbijte prijave likova.

gm-title-quest-management = Voditelj igre - Upravljanje questovima
gm-desc-create-quest = Stvorite novi quest.
gm-msg-no-quests = Questovi nisu pronađeni.
gm-label-quest-locked = (Zaključano)
gm-title-manage-quest = Upravljanje questom - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Uredite detalje questa poput naslova, opisa i veličine družine.
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

    - {"**"}Modify Player{"**"}: Dodajte ili uklonite predmete i iskustvo od igrača.
    - {"**"}View Player{"**"}: Pregledajte detalje aktivnog lika igrača.
gm-title-remove-player = Ukloni igrača iz questa - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Napomene o uklanjanju igrača{"**"}__

    - Odaberite igrača iz padajućeg izbornika ispod kako biste ga uklonili sa sastava questa.
    - Ako su igrači na listi čekanja, prvi igrač na listi bit će promaknut u družinu.
    - Individualne nagrade za uklonjenog igrača bit će obrisane iz questa.
    - Ako želite nagraditi igrača za prethodne doprinose, koristite kontekstualni izbornik `Modify Player` za izravno izdavanje nagrada.
gm-label-no-players-in-roster = Nema igrača u sastavu questa
gm-title-character-sheet = List lika za { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Bodovi iskustva:{"**"}__
gm-label-possessions = __{"**"}Posjedi{"**"}__
gm-label-currency-heading = {"**"}Valuta{"**"}
gm-msg-inventory-empty = Inventar je prazan.

# GM approvals
gm-title-approvals = Voditelj igre - Odobrenja inventara
gm-desc-review-submission = Unesite ID prijave za pregled i odobrenje/odbijanje.
gm-title-reviewing = Pregled: { $characterName }
gm-label-items = {"**"}Predmeti:{"**"}
gm-label-currency = {"**"}Valuta:{"**"}
gm-embed-title-approved = Ažuriranje inventara odobreno
gm-embed-desc-approved = Inventar za {"**"}{ $characterName }{"**"} je odobren od strane { $approver }.
gm-embed-title-denied = Ažuriranje inventara odbijeno
gm-embed-desc-denied = Inventar za {"**"}{ $characterName }{"**"} je odbijen od strane { $denier }.

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
