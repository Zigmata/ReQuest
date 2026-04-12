## Game Master module strings

# GM buttons
gm-btn-create = Opret
gm-btn-edit-details = Rediger Quest
gm-btn-toggle-ready = Skift klar-status
gm-btn-configure-rewards = Konfigurer belønninger
gm-btn-remove-player = Fjern spiller
gm-btn-cancel-quest = Annuller quest
gm-btn-manage-party-rewards = Administrer gruppebelønninger
gm-btn-manage-individual-rewards = Administrer individuelle belønninger
gm-btn-join = Tilmeld
gm-btn-leave = Forlad
gm-btn-complete-quest = Afslut quest
gm-btn-edit-details-modal = Rediger detaljer
gm-btn-edit-images = Rediger billeder
gm-select-placeholder-party-role = Vælg en grupperolle...
gm-modal-title-edit-details = Rediger Quest-detaljer
gm-modal-title-edit-images = Rediger Quest-billeder
gm-btn-publish = Publicer
gm-btn-update-post = Opdater opslag

# GM modals
gm-modal-title-create-quest = Opret ny quest
gm-modal-label-quest-title = Quest-titel
gm-modal-placeholder-quest-title = Titlen på din quest
gm-modal-label-restrictions = Begrænsninger
gm-modal-placeholder-restrictions = Begrænsninger, hvis nogen, såsom spillerniveauer
gm-modal-label-max-party = Maksimal gruppestørrelse
gm-modal-placeholder-max-party = Maksimal gruppestørrelse for denne quest
gm-modal-label-party-role = Grupperolle
gm-modal-placeholder-party-role = Opret en rolle til denne quest (valgfri)
gm-modal-label-description = Beskrivelse
gm-modal-placeholder-description = Skriv detaljerne for din quest her
gm-modal-label-image-url = Miniature-URL
gm-modal-label-large-image-url = Stort billede-URL
gm-modal-placeholder-image-url = Indtast en billed-URL (eller lad stå tom for at fjerne)
gm-modal-title-add-reward = Tilføj belønning
gm-modal-label-experience = Erfaringspoint
gm-modal-placeholder-experience = Indtast et tal
gm-modal-label-items = Genstande
gm-modal-placeholder-items =
    genstand: antal
    genstand2: antal
    osv.
gm-modal-title-add-summary = Tilføj quest-resumé
gm-modal-label-summary = Resumé
gm-modal-placeholder-summary = Tilføj et historieresumé af denne quest
gm-modal-title-modifying-player = Redigerer { $playerName }
gm-modal-placeholder-xp-add-remove = Indtast et positivt eller negativt tal.
gm-modal-label-inventory = Inventar
gm-modal-placeholder-inventory-modify =
    genstand: antal
    genstand2: antal
    osv.

# GM errors
gm-error-no-quest-channel = Der er endnu ikke udpeget en kanal til quest-opslag. Kontakt en serveradministrator for at konfigurere quest-kanalen.
gm-error-invalid-item-format = Ugyldigt genstandsformat: "{ $item }". Hver genstand skal være på en ny linje i formatet "Navn: Antal".
gm-error-already-on-quest = Du er allerede på denne quest som { $characterName }.
gm-error-no-active-character-long = Du har ikke en aktiv karakter på denne server. Brug `/player` til at registrere eller aktivere en karakter.
gm-error-quest-locked = Fejl ved tilmelding til quest {"**"}{ $questTitle }{"**"}: Questen er låst af GM'en.
gm-error-quest-full = Fejl ved tilmelding til quest {"**"}{ $questTitle }{"**"}: Quest-holdet er fuldt!
gm-error-not-signed-up = Du er ikke tilmeldt denne quest.
gm-error-quest-not-found = Questen findes ikke længere.
gm-error-quest-channel-not-set = Quest-kanal er ikke indstillet!
gm-error-empty-roster = Du kan ikke afslutte en quest med en tom deltagerliste. Prøv at annullere i stedet.
gm-error-invalid-xp-value = XP-værdi skal være et positivt heltal!
gm-error-party-size-positive = Gruppestørrelse skal være et positivt tal.
gm-error-party-size-too-small = Gruppestørrelse kan ikke være mindre end den nuværende gruppe ({ $currentSize } medlemmer).
gm-error-role-name-forbidden = Rollenavnet "{ $roleName }" er forbudt på denne server.
gm-error-role-name-exists = En rolle med navnet "{ $roleName }" findes allerede på denne server.

# GM confirm modals
gm-modal-title-cancel-quest = Annuller quest
gm-modal-label-cancel-quest = Skriv BEKRÆFT for at annullere questen.
gm-modal-title-remove-from-quest = Fjern karakter fra quest
gm-modal-label-remove-from-quest = Bekræft fjernelse af karakter?

# GM DM embeds
gm-dm-title-quest-cancelled = Quest annulleret
gm-dm-desc-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} blev annulleret af GM.
gm-dm-title-quest-ready = Quest klar
gm-dm-desc-quest-ready = Quest {"**"}{ $questTitle }{"**"} er nu klar! Din GM vil snart starte quest.
gm-dm-title-player-removed = Fjernet fra Quest
gm-dm-desc-player-removed = Du blev fjernet fra quest {"**"}{ $questTitle }{"**"} af GM.
gm-dm-desc-player-removed-waitlist = Du blev fjernet fra ventelisten for quest {"**"}{ $questTitle }{"**"}.
gm-dm-title-party-promotion = Gruppeforfremning
gm-dm-desc-party-promotion =
    Du er blevet forfremmet til hovedgruppen for {"**"}{ $questTitle }{"**"}
    fordi en spiller forlod quest.
gm-dm-title-roster-locked = Liste låst
gm-dm-desc-roster-locked =
    Listen for {"**"}{ $questTitle }{"**"} er blevet låst
    og alle gruppemedlemmer er blevet notificeret.
gm-dm-title-roster-unlocked = Liste låst op
gm-dm-desc-roster-unlocked = Listen for {"**"}{ $questTitle }{"**"} er blevet låst op.
gm-dm-title-player-removed-confirm = Spiller fjernet
gm-dm-desc-player-removed-confirm =
    Spilleren er blevet fjernet fra {"**"}{ $questTitle }{"**"}
    og quest-listen er blevet opdateret.
gm-dm-footer-quest = Quest-ID: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    Din serveradministrator har konfigureret belønninger til GM'er, når de afslutter
    quests. Da du dog ikke har nogen registrerede karakterer, kunne dine belønninger
    ikke automatisk udstedes på nuværende tidspunkt.
gm-dm-rewards-no-active-character =
    Din serveradministrator har konfigureret belønninger til GM'er, når de afslutter
    quests. Da du dog ikke har en aktiv karakter på denne server, kunne dine belønninger
    ikke automatisk udstedes på nuværende tidspunkt.
gm-dm-rewards-issued = Følgende er blevet tildelt din aktive karakter, { $characterName }
gm-dm-role-removal-failed =
    ⚠️ Kunne ikke fjerne rollen {"**"}{ $roleName }{"**"} fra følgende medlemmer: { $members }.
    Underret venligst en serveradministrator om at fjerne rollen manuelt.

gm-dm-role-not-found =
    ⚠️ Quest-rollen (ID: { $roleId }) for quest {"**"}{ $questTitle }{"**"} eksisterer ikke længere på serveren.
    Rolleoperationer blev sprunget over. Underret venligst en serveradministrator, hvis dette er uventet.

# GM select menus
gm-select-placeholder-party-member = Vælg et gruppemedlem
gm-select-option-no-role = Ingen (Ingen grupperolle)

# GM embeds
gm-embed-title-mod-report = GM spillermodifikationsrapport
gm-embed-field-experience = Erfaring
gm-embed-title-quest-complete = Quest afsluttet: { $questTitle }
gm-embed-title-quest-completed = QUEST AFSLUTTET: { $questTitle }
gm-embed-field-rewards = Belønninger
gm-embed-field-party = __Gruppe__
gm-embed-field-summary = Resumé
gm-embed-title-gm-rewards = GM-belønninger udstedt
gm-embed-field-items = Genstande

# GM views
gm-title-main-menu = GM - Hovedmenu
gm-menu-quests = Opgaver
gm-menu-desc-quests = Opret, rediger og administrer quests.
gm-menu-players = Spillere
gm-menu-desc-players = Administrer spillerinventarer og rediger karakterer.

gm-title-quest-management = GM - Quest-administration
gm-desc-create-quest = Opret en ny quest.
gm-msg-no-quests = Ingen quests fundet.
gm-label-quest-locked = (Låst)
gm-label-quest-draft = (Kladde)
gm-title-manage-quest = Administrer quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Rediger quest-detaljer som titel, beskrivelse og gruppestørrelse.
gm-label-field-not-set = Ikke angivet
gm-label-description-not-set = Beskrivelse ikke angivet
gm-label-current-party-size = {"**"}Maks. gruppestørrelse:{"**"} { $value }
gm-label-current-party-role = {"**"}Grupperolle:{"**"} { $value }
gm-desc-toggle-ready = Skift klar-status (nuværende: {"**"}{ $status }{"**"})
    - Låser quest-holdet og underretter gruppemedlemmer om, at questen snart begynder. Hvis en rolle er konfigureret, tildeles den til gruppemedlemmer ved låsning.
    - Låser holdet op, når det sættes til Åben.
gm-label-ready-locked = Låst/Klar
gm-label-ready-open = Åben
gm-desc-configure-rewards = Konfigurer belønninger for den valgte quest.
gm-desc-complete-quest = Afslut en quest. Udsteder belønninger, hvis nogen, til gruppemedlemmer.
gm-desc-remove-player = Fjern en spiller fra quest-holdet og underret dem.
gm-desc-cancel-quest = Annuller questen og slet den fra quest-tavlen.
gm-error-role-hierarchy = ReQuest kan ikke administrere rollen "{ $roleName }" (ID: { $roleId }), fordi den er placeret højere end ReQuests højeste rolle i serverhierarkiet. Kontakt venligst en serveradministrator for at flytte rollen under ReQuests rolle, eller tildel ReQuest en højere rolle, og prøv derefter igen.
gm-title-player-management = GM - Spilleradministration
gm-desc-player-management =
    Disse kommandoer er flyttet til kontekstmenuer. Højreklik (desktop) eller langt tryk (mobil) på en spillers profil for følgende menumuligheder:

    - {"**"}Rediger spiller{"**"}: Tilføj eller fjern genstande og erfaring fra en spiller.
    - {"**"}Vis spiller{"**"}: Se en spillers aktive karakterdetaljer.
gm-title-remove-player = Fjern spiller fra quest - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Bemærkninger om spillerfjernelse{"**"}__

    - Vælg en spiller fra rullemenuen nedenfor for at fjerne dem fra quest-holdet.
    - Hvis der er spillere på ventelisten, rykker den første spiller på listen op til gruppen.
    - Individuelle belønninger for den fjernede spiller slettes fra questen.
    - Hvis du ønsker at belønne spilleren for tidligere bidrag, brug kontekstmenuen `Rediger spiller` til at udstede belønninger direkte.
gm-label-no-players-in-roster = Ingen spillere i quest-holdet
gm-title-character-sheet = Karakterark for { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Erfaringspoint:{"**"}__
gm-label-possessions = __{"**"}Ejendele{"**"}__

# GM approvals
