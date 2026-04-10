## Game Master module strings

# GM buttons
gm-btn-create = Sukurti
gm-btn-edit-details = Redaguoti quest'ą
gm-btn-toggle-ready = Perjungti parengtį
gm-btn-configure-rewards = Konfigūruoti atlygius
gm-btn-remove-player = Pašalinti žaidėją
gm-btn-cancel-quest = Atšaukti quest'ą
gm-btn-manage-party-rewards = Valdyti grupės atlygius
gm-btn-manage-individual-rewards = Valdyti individualius atlygius
gm-btn-join = Prisijungti
gm-btn-leave = Palikti
gm-btn-complete-quest = Užbaigti quest'ą
gm-btn-edit-details-modal = Redaguoti informaciją
gm-btn-edit-images = Redaguoti paveikslėlius
gm-btn-publish = Paskelbti
gm-btn-update-post = Atnaujinti įrašą
gm-select-placeholder-party-role = Pasirinkite grupės rolę...
gm-modal-title-edit-details = Redaguoti quest'o informaciją
gm-modal-title-edit-images = Redaguoti quest'o paveikslėlius

# GM modals
gm-modal-title-create-quest = Sukurti naują quest'ą
gm-modal-label-quest-title = Quest pavadinimas
gm-modal-placeholder-quest-title = Jūsų quest'o pavadinimas
gm-modal-label-restrictions = Apribojimai
gm-modal-placeholder-restrictions = Apribojimai, jei yra, pvz., žaidėjų lygiai
gm-modal-label-max-party = Didžiausias grupės dydis
gm-modal-placeholder-max-party = Maks. grupės dydis šiam quest'ui
gm-modal-label-party-role = Grupės rolė
gm-modal-placeholder-party-role = Sukurti rolę šiam quest'ui (neprivaloma)
gm-modal-label-description = Aprašymas
gm-modal-placeholder-description = Čia parašykite savo quest'o detales
gm-modal-label-image-url = Miniatiūros URL
gm-modal-label-large-image-url = Didelio paveikslėlio URL
gm-modal-placeholder-image-url = Įveskite paveikslėlio URL (arba palikite tuščią, kad pašalintumėte)
gm-modal-title-add-reward = Pridėti atlygį
gm-modal-label-experience = Patirties taškai
gm-modal-placeholder-experience = Įveskite skaičių
gm-modal-label-items = Daiktai
gm-modal-placeholder-items =
    daiktas: kiekis
    daiktas2: kiekis
    ir t.t.
gm-modal-title-add-summary = Pridėti quest santrauką
gm-modal-label-summary = Santrauka
gm-modal-placeholder-summary = Pridėkite quest'o istorijos santrauką
gm-modal-title-modifying-player = Modifikuojamas { $playerName }
gm-modal-placeholder-xp-add-remove = Įveskite teigiamą arba neigiamą skaičių.
gm-modal-label-inventory = Inventorius
gm-modal-placeholder-inventory-modify =
    daiktas: kiekis
    daiktas2: kiekis
    ir t.t.

# GM errors
gm-error-forbidden-role-name = Nurodytas grupės rolės pavadinimas yra draudžiamas.
gm-error-role-already-exists = Rolė tokiu pavadinimu jau egzistuoja šiame serveryje.
gm-error-no-quest-channel = Kanalas quest'ų skelbimams dar nenustatytas. Kreipkitės į serverio administratorių, kad sukonfigūruotų Quest kanalą.
gm-error-cannot-ping-announce = Nepavyko paminėti pranešimų rolės { $role } kanale { $channel }. Patikrinkite kanalo ir ReQuest rolės leidimus su serverio administratoriais.
gm-error-invalid-item-format = Neteisingas daikto formatas: „{ $item }". Kiekvienas daiktas turi būti naujoje eilutėje formatu „Pavadinimas: Kiekis".
gm-error-already-on-quest = Jūs jau dalyvaujate šiame quest'e kaip { $characterName }.
gm-error-no-active-character-long = Jūs neturite aktyvaus personažo šiame serveryje. Naudokite `/player`, kad užregistruotumėte arba aktyvuotumėte personažą.
gm-error-quest-locked = Klaida prisijungiant prie quest'o {"**"}{ $questTitle }{"**"}: Quest'as užrakintas GM.
gm-error-quest-full = Klaida prisijungiant prie quest'o {"**"}{ $questTitle }{"**"}: Quest'o sąrašas pilnas!
gm-error-not-signed-up = Jūs nesate užsiregistravę šiam quest'ui.
gm-error-quest-not-found = Užduoties nebėra.
gm-error-quest-channel-not-set = Quest kanalas nenustatytas!
gm-error-empty-roster = Negalite užbaigti quest'o su tuščiu sąrašu. Pabandykite atšaukti.
gm-error-invalid-xp-value = XP reikšmė turi būti teigiamas sveikasis skaičius!
gm-error-party-size-positive = Grupės dydis turi būti teigiamas skaičius.
gm-error-party-size-too-small = Grupės dydis negali būti mažesnis nei dabartinė grupė ({ $currentSize } narių).
gm-error-role-name-forbidden = Rolės pavadinimas „{ $roleName }" yra draudžiamas šiame serveryje.
gm-error-role-name-exists = Rolė pavadinimu „{ $roleName }" jau egzistuoja šiame serveryje.
gm-error-role-hierarchy = ReQuest negali valdyti rolės „{ $roleName }" (ID: { $roleId }), nes ji yra aukščiau nei aukščiausia ReQuest rolė serverio hierarchijoje. Susisiekite su serverio administratoriumi, kad perkeltų rolę žemiau ReQuest rolės arba priskirtų ReQuest aukštesnę rolę, ir bandykite dar kartą.

# GM confirm modals
gm-modal-title-cancel-quest = Atšaukti quest'ą
gm-modal-label-cancel-quest = Įveskite PATVIRTINTI, kad atšauktumėte quest'ą.
gm-modal-title-remove-from-quest = Pašalinti personažą iš quest'o
gm-modal-label-remove-from-quest = Patvirtinti personažo pašalinimą?

# GM DM embeds
gm-dm-title-quest-cancelled = Quest'as atšauktas
gm-dm-desc-quest-cancelled = Quest'as {"**"}{ $questTitle }{"**"} buvo atšauktas GM.
gm-dm-title-quest-ready = Quest'as paruoštas
gm-dm-desc-quest-ready = Quest'as {"**"}{ $questTitle }{"**"} dabar paruoštas! Jūsų GM netrukus pradės quest'ą.
gm-dm-title-player-removed = Pašalintas iš quest'o
gm-dm-desc-player-removed = Jūs buvote pašalintas iš quest'o {"**"}{ $questTitle }{"**"} GM.
gm-dm-desc-player-removed-waitlist = Jūs buvote pašalintas iš laukimo sąrašo quest'ui {"**"}{ $questTitle }{"**"}.
gm-dm-title-party-promotion = Paaukštinimas į grupę
gm-dm-desc-party-promotion =
    Jūs buvote paaukštintas į pagrindinę grupę quest'ui {"**"}{ $questTitle }{"**"},
    nes žaidėjas pasitraukė.
gm-dm-title-roster-locked = Sąrašas užrakintas
gm-dm-desc-roster-locked =
    {"**"}{ $questTitle }{"**"} sąrašas užrakintas
    ir visi grupės nariai informuoti.
gm-dm-title-roster-unlocked = Sąrašas atrakintas
gm-dm-desc-roster-unlocked = {"**"}{ $questTitle }{"**"} sąrašas buvo atrakintas.
gm-dm-title-player-removed-confirm = Žaidėjas pašalintas
gm-dm-desc-player-removed-confirm =
    Žaidėjas buvo pašalintas iš {"**"}{ $questTitle }{"**"}
    ir quest'o sąrašas buvo atnaujintas.
gm-dm-footer-quest = Quest ID: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    Jūsų serverio administratorius sukonfigūravo atlygius GM, kai jie užbaigia
    quest'us. Tačiau, kadangi neturite užregistruotų personažų, jūsų atlygiai
    negalėjo būti automatiškai skirti šiuo metu.
gm-dm-rewards-no-active-character =
    Jūsų serverio administratorius sukonfigūravo atlygius GM, kai jie užbaigia
    quest'us. Tačiau, kadangi neturite aktyvaus personažo šiame serveryje, jūsų atlygiai
    negalėjo būti automatiškai skirti šiuo metu.
gm-dm-rewards-issued = Jūsų aktyviam personažui { $characterName } buvo skirta:
gm-dm-role-removal-failed =
    ⚠️ Nepavyko pašalinti rolės {"**"}{ $roleName }{"**"} iš šių narių: { $members }.
    Praneškite serverio administratoriui, kad rolę pašalintų rankiniu būdu.
gm-dm-role-not-found =
    ⚠️ Quest rolė (ID: { $roleId }) quest'ui {"**"}{ $questTitle }{"**"} nebeegzistuoja serveryje.
    Rolės operacijos buvo praleistos. Praneškite serverio administratoriui, jei tai netikėta.

# GM select menus
gm-select-placeholder-party-member = Pasirinkite grupės narį
gm-modal-label-select-party-role = Grupės rolė
gm-modal-desc-select-party-role = Pasirinkite rolę, kurią priskirti quest grupei.
gm-select-option-no-role = Nėra (be grupės rolės)

# GM embeds
gm-embed-title-mod-report = GM žaidėjo modifikavimo ataskaita
gm-embed-field-experience = Patirtis
gm-embed-title-quest-complete = Quest'as užbaigtas: { $questTitle }
gm-embed-title-quest-completed = QUEST'AS UŽBAIGTAS: { $questTitle }
gm-embed-field-rewards = Atlygiai
gm-embed-field-party = __Grupė__
gm-embed-field-summary = Santrauka
gm-embed-title-gm-rewards = GM atlygiai skirti
gm-embed-field-items = Daiktai

# GM views
gm-title-main-menu = GM - Pagrindinis meniu
gm-menu-quests = Quest'ai
gm-menu-desc-quests = Kurti, redaguoti ir valdyti quest'us.
gm-menu-players = Žaidėjai
gm-menu-desc-players = Valdyti žaidėjų inventorius ir modifikuoti personažus.

gm-title-quest-management = GM - Quest'ų valdymas
gm-desc-create-quest = Sukurti naują quest'ą.
gm-msg-no-quests = Quest'ų nerasta.
gm-label-quest-locked = (Užrakinta)
gm-label-quest-draft = (Juodraštis)
gm-title-manage-quest = Valdyti quest'ą - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Redaguoti quest'o informaciją, pvz., pavadinimą, aprašymą ir grupės dydį.
gm-title-edit-quest = Redaguoti quest'ą - { $questTitle }
gm-label-field-not-set = Nenustatyta
gm-label-description-not-set = Aprašymas nenustatytas
gm-label-current-title = {"**"}Pavadinimas:{"**"} { $value }
gm-label-current-description = {"**"}Aprašymas{"**"}
gm-label-current-restrictions = {"**"}Apribojimai:{"**"} { $value }
gm-label-current-party-size = {"**"}Maks. grupės dydis:{"**"} { $value }
gm-label-current-party-role = {"**"}Grupės rolė:{"**"} { $value }
gm-label-current-image = {"**"}Miniatiūra{"**"}
gm-label-current-large-image = {"**"}Paveikslėlis{"**"}
gm-desc-publish-quest = Paskelbti šį quest'ą quest'ų lentoje.
gm-desc-update-quest-post = Atnaujinti quest'o įrašą quest'ų lentoje.
gm-desc-toggle-ready = Perjungti parengties būseną (Dabartinė: {"**"}{ $status }{"**"})
    - Užrakina quest'o sąrašą ir informuoja grupės narius, kad quest'as netrukus prasidės. Jei sukonfigūruota rolė, ji bus priskirta grupės nariams užrakinus.
    - Atrakina sąrašą, kai nustatoma į „Atvira".
gm-label-ready-locked = Užrakinta/Paruošta
gm-label-ready-open = Atvira
gm-desc-configure-rewards = Konfigūruoti atlygius pasirinktam quest'ui.
gm-desc-complete-quest = Užbaigti quest'ą. Skiria atlygius, jei tokių yra, grupės nariams.
gm-desc-remove-player = Pašalinti žaidėją iš quest'o sąrašo ir jį informuoti.
gm-desc-cancel-quest = Atšaukti quest'ą ir ištrinti jį iš quest'ų lentos.
gm-title-player-management = GM - Žaidėjų valdymas
gm-desc-player-management =
    Šios komandos perkeltos į kontekstinius meniu. Dešiniuoju pelės mygtuku spustelėkite (kompiuteryje) arba ilgai paspauskite (mobiliajame) žaidėjo profilį, kad gautumėte šias meniu parinktis:

    - {"**"}Modifikuoti Žaidėją{"**"}: Pridėti arba pašalinti daiktus ir patirtį žaidėjui.
    - {"**"}Peržiūrėti Žaidėją{"**"}: Peržiūrėti žaidėjo aktyvaus personažo informaciją.
gm-title-remove-player = Pašalinti žaidėją iš quest'o - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Žaidėjo pašalinimo pastabos{"**"}__

    - Pasirinkite žaidėją iš žemiau esančio sąrašo, kad pašalintumėte jį iš quest'o sąrašo.
    - Jei yra žaidėjų laukimo sąraše, pirmas žaidėjas sąraše bus pakeltas į grupę.
    - Individualūs pašalinto žaidėjo atlygiai bus ištrinti iš quest'o.
    - Jei norite apdovanoti žaidėją už ankstesnį indėlį, naudokite kontekstinį meniu `Modifikuoti Žaidėją`, kad tiesiogiai skirtumėte atlygius.
gm-label-no-players-in-roster = Quest'o sąraše nėra žaidėjų
gm-title-character-sheet = Personažo lapas: { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Patirties taškai:{"**"}__
gm-label-possessions = __{"**"}Turtas{"**"}__
gm-label-currency-heading = {"**"}Valiuta{"**"}
gm-msg-inventory-empty = Inventorius tuščias.

# GM approvals
