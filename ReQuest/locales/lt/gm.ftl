## Game Master module strings

# GM buttons
gm-btn-create = Sukurti
gm-btn-edit-details = Redaguoti informaciją
gm-btn-toggle-ready = Perjungti parengtį
gm-btn-configure-rewards = Konfigūruoti atlygius
gm-btn-remove-player = Pašalinti žaidėją
gm-btn-cancel-quest = Atšaukti quest'ą
gm-btn-manage-party-rewards = Valdyti grupės atlygius
gm-btn-manage-individual-rewards = Valdyti individualius atlygius
gm-btn-join = Prisijungti
gm-btn-leave = Palikti
gm-btn-complete-quest = Užbaigti quest'ą
gm-btn-review-submission = Peržiūrėti pateiktį
gm-btn-approve = Patvirtinti
gm-btn-deny = Atmesti

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
gm-modal-title-editing-quest = Redaguojama { $questTitle }
gm-modal-label-title = Pavadinimas
gm-modal-label-max-party-size = Maks. grupės dydis
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
gm-modal-title-review-submission = Peržiūrėti pateiktį
gm-modal-label-submission-id = Pateikties ID
gm-modal-placeholder-submission-id = Įveskite 8 simbolių ID

# GM errors
gm-error-forbidden-role-name = Nurodytas grupės rolės pavadinimas yra draudžiamas.
gm-error-role-already-exists = Rolė tokiu pavadinimu jau egzistuoja šiame serveryje.
gm-error-no-quest-channel = Kanalas quest'ų skelbimams dar nenustatytas. Kreipkitės į serverio administratorių, kad sukonfigūruotų Quest kanalą.
gm-error-cannot-ping-announce = Nepavyko paminėti pranešimų rolės { $role } kanale { $channel }. Patikrinkite kanalo ir ReQuest rolės leidimus su serverio administratoriais.
gm-error-invalid-item-format = Neteisingas daikto formatas: „{ $item }". Kiekvienas daiktas turi būti naujoje eilutėje formatu „Pavadinimas: Kiekis".
gm-error-submission-not-found = Pateiktis nerasta.
gm-error-already-on-quest = Jūs jau dalyvaujate šiame quest'e kaip { $characterName }.
gm-error-no-active-character-long = Jūs neturite aktyvaus personažo šiame serveryje. Naudokite `/player`, kad užregistruotumėte arba aktyvuotumėte personažą.
gm-error-quest-locked = Klaida prisijungiant prie quest'o {"**"}{ $questTitle }{"**"}: Quest'as užrakintas GM.
gm-error-quest-full = Klaida prisijungiant prie quest'o {"**"}{ $questTitle }{"**"}: Quest'o sąrašas pilnas!
gm-error-not-signed-up = Jūs nesate užsiregistravę šiam quest'ui.
gm-error-quest-channel-not-set = Quest kanalas nenustatytas!
gm-error-empty-roster = Negalite užbaigti quest'o su tuščiu sąrašu. Pabandykite atšaukti.
gm-error-invalid-xp-value = XP reikšmė turi būti teigiamas sveikasis skaičius!

# GM confirm modals
gm-modal-title-cancel-quest = Atšaukti quest'ą
gm-modal-label-cancel-quest = Įveskite CONFIRM, kad atšauktumėte quest'ą.
gm-modal-placeholder-cancel-quest = Įveskite „CONFIRM", kad tęstumėte.
gm-modal-title-remove-from-quest = Pašalinti personažą iš quest'o
gm-modal-label-remove-from-quest = Patvirtinti personažo pašalinimą?
gm-modal-placeholder-remove-from-quest = Įveskite „CONFIRM", kad tęstumėte.

# GM DM messages
gm-dm-quest-cancelled = Quest'as {"**"}{ $questTitle }{"**"} buvo atšauktas GM.
gm-dm-quest-ready = Quest'as {"**"}{ $questTitle }{"**"} dabar paruoštas!
gm-dm-quest-unlocked = Quest'as {"**"}{ $questTitle }{"**"} nebėra užrakintas.
gm-dm-quest-locked = Quest'as {"**"}{ $questTitle }{"**"} dabar užrakintas GM.
gm-dm-player-removed = Jūs buvote pašalintas iš quest'o {"**"}{ $questTitle }{"**"}.
gm-dm-player-removed-waitlist = Jūs buvote pašalintas iš laukimo sąrašo quest'ui {"**"}{ $questTitle }{"**"}.
gm-dm-party-promotion = Jūs buvote pridėtas į grupę quest'ui {"**"}{ $questTitle }{"**"}, nes žaidėjas pasitraukė!
gm-dm-roster-locked = Quest'o sąrašas užrakintas ir grupė informuota!
gm-dm-roster-unlocked = Quest'o sąrašas buvo atrakintas.
gm-dm-rewards-no-characters =
    Jūsų serverio administratorius sukonfigūravo atlygius GM, kai jie užbaigia
    quest'us. Tačiau, kadangi neturite užregistruotų personažų, jūsų atlygiai
    negalėjo būti automatiškai skirti šiuo metu.
gm-dm-rewards-no-active-character =
    Jūsų serverio administratorius sukonfigūravo atlygius GM, kai jie užbaigia
    quest'us. Tačiau, kadangi neturite aktyvaus personažo šiame serveryje, jūsų atlygiai
    negalėjo būti automatiškai skirti šiuo metu.
gm-dm-rewards-issued = Jūsų aktyviam personažui { $characterName } buvo skirta:

# GM select menus
gm-select-placeholder-party-member = Pasirinkite grupės narį

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
gm-msg-player-removed = Žaidėjas pašalintas ir quest'o sąrašas atnaujintas!

# GM views
gm-title-main-menu = GM - Pagrindinis meniu
gm-menu-quests = Quest'ai
gm-menu-desc-quests = Kurti, redaguoti ir valdyti quest'us.
gm-menu-players = Žaidėjai
gm-menu-desc-players = Valdyti žaidėjų inventorius ir modifikuoti personažus.
gm-menu-approvals = Personažų patvirtinimai
gm-menu-desc-approvals = Peržiūrėti ir patvirtinti/atmesti personažų pateiktis.

gm-title-quest-management = GM - Quest'ų valdymas
gm-desc-create-quest = Sukurti naują quest'ą.
gm-msg-no-quests = Quest'ų nerasta.
gm-label-quest-locked = (Užrakinta)
gm-title-manage-quest = Valdyti quest'ą - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Redaguoti quest'o informaciją, pvz., pavadinimą, aprašymą ir grupės dydį.
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

    - {"**"}Modify Player{"**"}: Pridėti arba pašalinti daiktus ir patirtį žaidėjui.
    - {"**"}View Player{"**"}: Peržiūrėti žaidėjo aktyvaus personažo informaciją.
gm-title-remove-player = Pašalinti žaidėją iš quest'o - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Žaidėjo pašalinimo pastabos{"**"}__

    - Pasirinkite žaidėją iš žemiau esančio sąrašo, kad pašalintumėte jį iš quest'o sąrašo.
    - Jei yra žaidėjų laukimo sąraše, pirmas žaidėjas sąraše bus pakeltas į grupę.
    - Individualūs pašalinto žaidėjo atlygiai bus ištrinti iš quest'o.
    - Jei norite apdovanoti žaidėją už ankstesnį indėlį, naudokite kontekstinį meniu `Modify Player`, kad tiesiogiai skirtumėte atlygius.
gm-label-no-players-in-roster = Quest'o sąraše nėra žaidėjų
gm-title-character-sheet = Personažo lapas: { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Patirties taškai:{"**"}__
gm-label-possessions = __{"**"}Turtas{"**"}__
gm-label-currency-heading = {"**"}Valiuta{"**"}
gm-msg-inventory-empty = Inventorius tuščias.

# GM approvals
gm-title-approvals = GM - Inventoriaus patvirtinimai
gm-desc-review-submission = Įveskite pateikties ID, kad peržiūrėtumėte ir patvirtintumėte/atmestumėte ją.
gm-title-reviewing = Peržiūrima: { $characterName }
gm-label-items = {"**"}Daiktai:{"**"}
gm-label-currency = {"**"}Valiuta:{"**"}
gm-embed-title-approved = Inventoriaus atnaujinimas patvirtintas
gm-embed-desc-approved = Personažo {"**"}{ $characterName }{"**"} inventorius buvo patvirtintas { $approver }.
gm-embed-title-denied = Inventoriaus atnaujinimas atmestas
gm-embed-desc-denied = Personažo {"**"}{ $characterName }{"**"} inventorius buvo atmestas { $denier }.

gm-modal-label-select-party-role = Party Role
gm-modal-desc-select-party-role = Select a role to assign to the quest party.
gm-select-option-no-role = None (No Party Role)

gm-error-role-hierarchy = ReQuest cannot manage the role "{ $roleName }" (ID: { $roleId }) because it is positioned higher than ReQuest's highest role in the server hierarchy. Please contact a server administrator to move the role below ReQuest's role, or assign ReQuest a higher role.
