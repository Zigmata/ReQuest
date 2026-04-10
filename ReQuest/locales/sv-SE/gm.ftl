## Game Master module strings

# GM buttons
gm-btn-create = Skapa
gm-btn-edit-details = Redigera quest
gm-btn-toggle-ready = Växla redo
gm-btn-configure-rewards = Konfigurera belöningar
gm-btn-remove-player = Ta bort spelare
gm-btn-cancel-quest = Avbryt quest
gm-btn-manage-party-rewards = Hantera gruppbelöningar
gm-btn-manage-individual-rewards = Hantera individuella belöningar
gm-btn-join = Gå med
gm-btn-leave = Lämna
gm-btn-complete-quest = Avsluta quest
gm-btn-edit-details-modal = Redigera detaljer
gm-btn-edit-images = Redigera bilder
gm-select-placeholder-party-role = Välj en grupproll...
gm-modal-title-edit-details = Redigera quest-detaljer
gm-modal-title-edit-images = Redigera quest-bilder
gm-btn-publish = Publicera
gm-btn-update-post = Uppdatera inlägg

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
gm-modal-label-image-url = Miniatyr-URL
gm-modal-label-large-image-url = Stor bild-URL
gm-modal-placeholder-image-url = Ange en bild-URL (eller lämna tomt för att ta bort)
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

# GM errors
gm-error-forbidden-role-name = Namnet som angetts för grupprollen är förbjudet.
gm-error-role-already-exists = En roll med det namnet finns redan på denna server.
gm-error-no-quest-channel = Ingen kanal har ännu angetts för quest-inlägg. Kontakta en serveradministratör för att konfigurera quest-kanalen.
gm-error-cannot-ping-announce = Kunde inte pinga aviseringsrollen { $role } i kanalen { $channel }. Kontrollera kanal- och ReQuest-rollbehörigheter med din serveradministratör.
gm-error-invalid-item-format = Ogiltigt föremålsformat: "{ $item }". Varje föremål måste vara på en ny rad, i formatet "Namn: Antal".
gm-error-already-on-quest = Du är redan med i denna quest som { $characterName }.
gm-error-no-active-character-long = Du har ingen aktiv karaktär på denna server. Använd `/player` för att registrera eller aktivera en karaktär.
gm-error-quest-locked = Fel vid anslutning till quest {"**"}{ $questTitle }{"**"}: Questen är låst av GM.
gm-error-quest-full = Fel vid anslutning till quest {"**"}{ $questTitle }{"**"}: Quest-gruppen är full!
gm-error-not-signed-up = Du är inte anmäld till denna quest.
gm-error-quest-not-found = Uppdraget finns inte längre.
gm-error-quest-channel-not-set = Quest-kanalen har inte ställts in!
gm-error-empty-roster = Du kan inte avsluta en quest med en tom lista. Prova att avbryta istället.
gm-error-invalid-xp-value = XP-värdet måste vara ett positivt heltal!
gm-error-role-hierarchy = ReQuest kan inte hantera rollen "{ $roleName }" (ID: { $roleId }) eftersom den är placerad högre än ReQuests högsta roll i serverhierarkin. Kontakta en serveradministratör för att flytta rollen under ReQuests roll, eller tilldela ReQuest en högre roll, och försök sedan igen.
gm-error-party-size-positive = Gruppstorleken måste vara ett positivt tal.
gm-error-party-size-too-small = Gruppstorleken kan inte vara mindre än den nuvarande gruppen ({ $currentSize } medlemmar).
gm-error-role-name-forbidden = Rollnamnet "{ $roleName }" är förbjudet på denna server.
gm-error-role-name-exists = En roll med namnet "{ $roleName }" finns redan på denna server.

# GM confirm modals
gm-modal-title-cancel-quest = Avbryt quest
gm-modal-label-cancel-quest = Skriv BEKRÄFTA för att avbryta questen.
gm-modal-title-remove-from-quest = Ta bort karaktär från quest
gm-modal-label-remove-from-quest = Bekräfta borttagning av karaktär?

# GM DM embeds
gm-dm-title-quest-cancelled = Quest avbruten
gm-dm-desc-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} avbröts av GM.
gm-dm-title-quest-ready = Quest redo
gm-dm-desc-quest-ready = Quest {"**"}{ $questTitle }{"**"} är nu redo! Din GM kommer att starta questen snart.
gm-dm-title-player-removed = Borttagen från quest
gm-dm-desc-player-removed = Du togs bort från quest {"**"}{ $questTitle }{"**"} av GM.
gm-dm-desc-player-removed-waitlist = Du togs bort från väntelistan för quest {"**"}{ $questTitle }{"**"}.
gm-dm-title-party-promotion = Befordran till grupp
gm-dm-desc-party-promotion =
    Du har befordrats till huvudgruppen för {"**"}{ $questTitle }{"**"}
    eftersom en spelare lämnade questen.
gm-dm-title-roster-locked = Lista låst
gm-dm-desc-roster-locked =
    Listan för {"**"}{ $questTitle }{"**"} har låsts
    och alla gruppmedlemmar har meddelats.
gm-dm-title-roster-unlocked = Lista upplåst
gm-dm-desc-roster-unlocked = Listan för {"**"}{ $questTitle }{"**"} har låsts upp.
gm-dm-title-player-removed-confirm = Spelare borttagen
gm-dm-desc-player-removed-confirm =
    Spelaren har tagits bort från {"**"}{ $questTitle }{"**"}
    och quest-listan har uppdaterats.
gm-dm-footer-quest = Quest-ID: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    Din serveradministratör har konfigurerat belöningar för GM:ar när de avslutar
    quests. Eftersom du inte har några registrerade karaktärer kunde dock dina belöningar
    inte delas ut automatiskt vid denna tidpunkt.
gm-dm-rewards-no-active-character =
    Din serveradministratör har konfigurerat belöningar för GM:ar när de avslutar
    quests. Eftersom du inte har någon aktiv karaktär på denna server kunde dock dina belöningar
    inte delas ut automatiskt vid denna tidpunkt.
gm-dm-rewards-issued = Följande har tilldelats din aktiva karaktär, { $characterName }
gm-dm-role-removal-failed =
    ⚠️ Det gick inte att ta bort rollen {"**"}{ $roleName }{"**"} från följande medlemmar: { $members }.
    Meddela en serveradministratör för att ta bort rollen manuellt.
gm-dm-role-not-found =
    ⚠️ Quest-rollen (ID: { $roleId }) för quest {"**"}{ $questTitle }{"**"} finns inte längre på servern.
    Rolloperationer hoppades över. Meddela en serveradministratör om detta är oväntat.

# GM select menus
gm-select-placeholder-party-member = Välj en gruppmedlem
gm-modal-label-select-party-role = Grupproll
gm-modal-desc-select-party-role = Välj en roll att tilldela quest-gruppen.
gm-select-option-no-role = Ingen (Ingen grupproll)

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

# GM views
gm-title-main-menu = GM - Huvudmeny
gm-menu-quests = Quests
gm-menu-desc-quests = Skapa, redigera och hantera quests.
gm-menu-players = Spelare
gm-menu-desc-players = Hantera spelarinventarier och ändra karaktärer.

gm-title-quest-management = GM - Quest-hantering
gm-desc-create-quest = Skapa en ny quest.
gm-msg-no-quests = Inga quests hittades.
gm-label-quest-locked = (Låst)
gm-label-quest-draft = (Utkast)
gm-title-manage-quest = Hantera quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Redigera quest-detaljer som titel, beskrivning och gruppstorlek.
gm-title-edit-quest = Redigera quest - { $questTitle }
gm-label-field-not-set = Inte angiven
gm-label-description-not-set = Beskrivning ej angiven
gm-label-current-title = {"**"}Titel:{"**"} { $value }
gm-label-current-description = {"**"}Beskrivning{"**"}
gm-label-current-restrictions = {"**"}Begränsningar:{"**"} { $value }
gm-label-current-party-size = {"**"}Max gruppstorlek:{"**"} { $value }
gm-label-current-party-role = {"**"}Grupproll:{"**"} { $value }
gm-label-current-image = {"**"}Miniatyr{"**"}
gm-label-current-large-image = {"**"}Bild{"**"}
gm-desc-publish-quest = Publicera denna quest till quest-tavlan.
gm-desc-update-quest-post = Uppdatera quest-inlägget på quest-tavlan.
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
