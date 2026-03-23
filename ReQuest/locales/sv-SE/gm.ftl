## Game Master module strings

# GM buttons
gm-btn-create = Skapa
gm-btn-edit-details = Redigera detaljer
gm-btn-toggle-ready = Växla redo
gm-btn-configure-rewards = Konfigurera belöningar
gm-btn-remove-player = Ta bort spelare
gm-btn-cancel-quest = Avbryt quest
gm-btn-manage-party-rewards = Hantera gruppbelöningar
gm-btn-manage-individual-rewards = Hantera individuella belöningar
gm-btn-join = Gå med
gm-btn-leave = Lämna
gm-btn-complete-quest = Avsluta quest
gm-btn-review-submission = Granska inlämning
gm-btn-approve = Godkänn
gm-btn-deny = Neka

# GM modals
gm-modal-title-create-quest = Skapa ny quest
gm-modal-label-quest-title = Quest-titel
gm-modal-placeholder-quest-title = Titel på din quest
gm-modal-label-restrictions = Begränsningar
gm-modal-placeholder-restrictions = Begränsningar, om några, såsom spelarnivåer
gm-modal-label-max-party = Maximal gruppstorlek
gm-modal-placeholder-max-party = Max storlek på gruppen för denna quest
gm-modal-label-party-role = Grupproll
gm-modal-placeholder-party-role = Skapa en roll för denna quest (valfritt)
gm-modal-label-description = Beskrivning
gm-modal-placeholder-description = Skriv detaljerna för din quest här
gm-modal-title-editing-quest = Redigerar { $questTitle }
gm-modal-label-title = Titel
gm-modal-label-max-party-size = Max gruppstorlek
gm-modal-title-add-reward = Lägg till belöning
gm-modal-label-experience = Erfarenhetspoäng
gm-modal-placeholder-experience = Ange ett nummer
gm-modal-label-items = Föremål
gm-modal-placeholder-items =
    föremål: antal
    föremål2: antal
    osv.
gm-modal-title-add-summary = Lägg till quest-sammanfattning
gm-modal-label-summary = Sammanfattning
gm-modal-placeholder-summary = Lägg till en berättande sammanfattning av questen
gm-modal-title-modifying-player = Ändrar { $playerName }
gm-modal-placeholder-xp-add-remove = Ange ett positivt eller negativt nummer.
gm-modal-label-inventory = Inventarie
gm-modal-placeholder-inventory-modify =
    föremål: antal
    föremål2: antal
    osv.
gm-modal-title-review-submission = Granska inlämning
gm-modal-label-submission-id = Inlämnings-ID
gm-modal-placeholder-submission-id = Ange det 8-teckens ID

# GM errors
gm-error-forbidden-role-name = Namnet som angetts för grupprollen är förbjudet.
gm-error-role-already-exists = En roll med det namnet finns redan på denna server.
gm-error-no-quest-channel = Ingen kanal har ännu angetts för quest-inlägg. Kontakta en serveradministratör för att konfigurera quest-kanalen.
gm-error-cannot-ping-announce = Kunde inte pinga aviseringsrollen { $role } i kanalen { $channel }. Kontrollera kanal- och ReQuest-rollbehörigheter med din serveradministratör.
gm-error-invalid-item-format = Ogiltigt föremålsformat: "{ $item }". Varje föremål måste vara på en ny rad, i formatet "Namn: Antal".
gm-error-submission-not-found = Inlämningen hittades inte.
gm-error-already-on-quest = Du är redan med i denna quest som { $characterName }.
gm-error-no-active-character-long = Du har ingen aktiv karaktär på denna server. Använd `/player` för att registrera eller aktivera en karaktär.
gm-error-quest-locked = Fel vid anslutning till quest {"**"}{ $questTitle }{"**"}: Questen är låst av GM.
gm-error-quest-full = Fel vid anslutning till quest {"**"}{ $questTitle }{"**"}: Quest-gruppen är full!
gm-error-not-signed-up = Du är inte anmäld till denna quest.
gm-error-quest-channel-not-set = Quest-kanalen har inte ställts in!
gm-error-empty-roster = Du kan inte avsluta en quest med en tom lista. Prova att avbryta istället.
gm-error-invalid-xp-value = XP-värdet måste vara ett positivt heltal!

# GM confirm modals
gm-modal-title-cancel-quest = Avbryt quest
gm-modal-label-cancel-quest = Skriv CONFIRM för att avbryta questen.
gm-modal-title-remove-from-quest = Ta bort karaktär från quest
gm-modal-label-remove-from-quest = Bekräfta borttagning av karaktär?

# GM DM messages
gm-dm-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} avbröts av GM.
gm-dm-quest-ready = Quest {"**"}{ $questTitle }{"**"} är nu redo!
gm-dm-quest-unlocked = Quest {"**"}{ $questTitle }{"**"} är inte längre låst.
gm-dm-quest-locked = Quest {"**"}{ $questTitle }{"**"} är nu låst av GM.
gm-dm-player-removed = Du togs bort från quest {"**"}{ $questTitle }{"**"}.
gm-dm-player-removed-waitlist = Du togs bort från väntelistan för {"**"}{ $questTitle }{"**"}.
gm-dm-party-promotion = Du har lagts till i gruppen för {"**"}{ $questTitle }{"**"}, på grund av att en spelare hoppade av!
gm-dm-roster-locked = Quest-lista låst och gruppen meddelad!
gm-dm-roster-unlocked = Quest-listan har låsts upp.
gm-dm-rewards-no-characters =
    Din serveradministratör har konfigurerat belöningar för GM:ar när de avslutar
    quests. Eftersom du inte har några registrerade karaktärer kunde dock dina belöningar
    inte delas ut automatiskt vid denna tidpunkt.
gm-dm-rewards-no-active-character =
    Din serveradministratör har konfigurerat belöningar för GM:ar när de avslutar
    quests. Eftersom du inte har någon aktiv karaktär på denna server kunde dock dina belöningar
    inte delas ut automatiskt vid denna tidpunkt.
gm-dm-rewards-issued = Följande har tilldelats din aktiva karaktär, { $characterName }

# GM select menus
gm-select-placeholder-party-member = Välj en gruppmedlem

# GM embeds
gm-embed-title-mod-report = GM-spelarändringsrapport
gm-embed-field-experience = Erfarenhet
gm-embed-title-quest-complete = Quest avslutad: { $questTitle }
gm-embed-title-quest-completed = QUEST AVSLUTAD: { $questTitle }
gm-embed-field-rewards = Belöningar
gm-embed-field-party = __Grupp__
gm-embed-field-summary = Sammanfattning
gm-embed-title-gm-rewards = GM-belöningar utdelade
gm-embed-field-items = Föremål
gm-msg-player-removed = Spelare borttagen och quest-lista uppdaterad!

# GM views
gm-title-main-menu = GM - Huvudmeny
gm-menu-quests = Quests
gm-menu-desc-quests = Skapa, redigera och hantera quests.
gm-menu-players = Spelare
gm-menu-desc-players = Hantera spelarinventarier och ändra karaktärer.
gm-menu-approvals = Karaktärsgodkännanden
gm-menu-desc-approvals = Granska och godkänn/neka karaktärsinlämningar.

gm-title-quest-management = GM - Quest-hantering
gm-desc-create-quest = Skapa en ny quest.
gm-msg-no-quests = Inga quests hittades.
gm-label-quest-locked = (Låst)
gm-title-manage-quest = Hantera quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Redigera quest-detaljer som titel, beskrivning och gruppstorlek.
gm-desc-toggle-ready = Växla redo-status (Nuvarande: {"**"}{ $status }{"**"})
    - Låser quest-listan och meddelar gruppmedlemmar att questen börjar snart. Om en roll är konfigurerad tilldelas den till gruppmedlemmar vid låsning.
    - Låser upp listan när den sätts till Öppen.
gm-label-ready-locked = Låst/Redo
gm-label-ready-open = Öppen
gm-desc-configure-rewards = Konfigurera belöningar för den valda questen.
gm-desc-complete-quest = Avsluta en quest. Delar ut belöningar, om några, till gruppmedlemmar.
gm-desc-remove-player = Ta bort en spelare från quest-listan och meddela dem.
gm-desc-cancel-quest = Avbryt questen och radera den från quest-tavlan.
gm-title-player-management = GM - Spelarhantering
gm-desc-player-management =
    Dessa kommandon har migrerats till kontextmenyer. Högerklicka (dator) eller tryck länge (mobil) på en spelares profil för följande menyalternativ:

    - {"**"}Ändra spelare{"**"}: Lägg till eller ta bort föremål och erfarenhet från en spelare.
    - {"**"}Visa spelare{"**"}: Visa en spelares aktiva karaktärsdetaljer.
gm-title-remove-player = Ta bort spelare från quest - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Anteckningar om spelarborttagning{"**"}__

    - Välj en spelare från rullgardinsmenyn nedan för att ta bort dem från quest-listan.
    - Om några spelare finns på en väntelista kommer den första spelaren på listan att befordras till gruppen.
    - Individuella belöningar för den borttagna spelaren raderas från questen.
    - Om du vill belöna spelaren för tidigare bidrag, använd kontextmenyn `Ändra spelare` för att ge dem belöningar direkt.
gm-label-no-players-in-roster = Inga spelare i quest-listan
gm-title-character-sheet = Karaktärsblad för { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Erfarenhetspoäng:{"**"}__
gm-label-possessions = __{"**"}Ägodelar{"**"}__
gm-label-currency-heading = {"**"}Valuta{"**"}
gm-msg-inventory-empty = Inventariet är tomt.

# GM approvals
gm-title-approvals = GM - Inventariegodkännanden
gm-desc-review-submission = Ange ett inlämnings-ID för att granska och godkänna/neka det.
gm-title-reviewing = Granskar: { $characterName }
gm-label-items = {"**"}Föremål:{"**"}
gm-label-currency = {"**"}Valuta:{"**"}
gm-embed-title-approved = Inventarieuppdatering godkänd
gm-embed-desc-approved = Inventariet för {"**"}{ $characterName }{"**"} har godkänts av { $approver }.
gm-embed-title-denied = Inventarieuppdatering nekad
gm-embed-desc-denied = Inventariet för {"**"}{ $characterName }{"**"} har nekats av { $denier }.

gm-modal-label-select-party-role = Grupproll
gm-modal-desc-select-party-role = Välj en roll att tilldela quest-gruppen.
gm-select-option-no-role = Ingen (Ingen grupproll)

gm-error-role-hierarchy = ReQuest kan inte hantera rollen "{ $roleName }" (ID: { $roleId }) eftersom den är placerad högre än ReQuests högsta roll i serverhierarkin. Kontakta en serveradministratör för att flytta rollen under ReQuests roll, eller tilldela ReQuest en högre roll, och försök sedan igen.
gm-dm-role-removal-failed =
    ⚠️ Det gick inte att ta bort rollen {"**"}{ $roleName }{"**"} från följande medlemmar: { $members }.
    Meddela en serveradministratör för att ta bort rollen manuellt.

gm-dm-role-not-found =
    ⚠️ Quest-rollen (ID: { $roleId }) för quest {"**"}{ $questTitle }{"**"} finns inte längre på servern.
    Rolloperationer hoppades över. Meddela en serveradministratör om detta är oväntat.
