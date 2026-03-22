## Game Master module strings

# GM buttons
gm-btn-create = Opret
gm-btn-edit-details = Rediger detaljer
gm-btn-toggle-ready = Skift klar-status
gm-btn-configure-rewards = Konfigurer belønninger
gm-btn-remove-player = Fjern spiller
gm-btn-cancel-quest = Annuller quest
gm-btn-manage-party-rewards = Administrer gruppebelønninger
gm-btn-manage-individual-rewards = Administrer individuelle belønninger
gm-btn-join = Tilmeld
gm-btn-leave = Forlad
gm-btn-complete-quest = Afslut quest
gm-btn-review-submission = Gennemgå indsendelse
gm-btn-approve = Godkend
gm-btn-deny = Afvis

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
gm-modal-title-editing-quest = Redigerer { $questTitle }
gm-modal-label-title = Titel
gm-modal-label-max-party-size = Maks. gruppestørrelse
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
gm-modal-placeholder-summary = Tilføj et historieresuméaf denne quest
gm-modal-title-modifying-player = Redigerer { $playerName }
gm-modal-placeholder-xp-add-remove = Indtast et positivt eller negativt tal.
gm-modal-label-inventory = Inventar
gm-modal-placeholder-inventory-modify =
    genstand: antal
    genstand2: antal
    osv.
gm-modal-title-review-submission = Gennemgå indsendelse
gm-modal-label-submission-id = Indsendelses-ID
gm-modal-placeholder-submission-id = Indtast det 8-tegns ID

# GM errors
gm-error-forbidden-role-name = Det angivne navn til grupperollen er forbudt.
gm-error-role-already-exists = En rolle med det navn findes allerede på denne server.
gm-error-no-quest-channel = Der er endnu ikke udpeget en kanal til quest-opslag. Kontakt en serveradministrator for at konfigurere quest-kanalen.
gm-error-cannot-ping-announce = Kunne ikke pinge meddelelsesrollen { $role } i kanal { $channel }. Tjek kanal- og ReQuest-rolletilladelser med din/dine serveradministrator(er).
gm-error-invalid-item-format = Ugyldigt genstandsformat: "{ $item }". Hver genstand skal være på en ny linje i formatet "Navn: Antal".
gm-error-submission-not-found = Indsendelse ikke fundet.
gm-error-already-on-quest = Du er allerede på denne quest som { $characterName }.
gm-error-no-active-character-long = Du har ikke en aktiv karakter på denne server. Brug `/player` til at registrere eller aktivere en karakter.
gm-error-quest-locked = Fejl ved tilmelding til quest {"**"}{ $questTitle }{"**"}: Questen er låst af GM'en.
gm-error-quest-full = Fejl ved tilmelding til quest {"**"}{ $questTitle }{"**"}: Quest-holdet er fuldt!
gm-error-not-signed-up = Du er ikke tilmeldt denne quest.
gm-error-quest-channel-not-set = Quest-kanal er ikke indstillet!
gm-error-empty-roster = Du kan ikke afslutte en quest med en tom deltagerliste. Prøv at annullere i stedet.
gm-error-invalid-xp-value = XP-værdi skal være et positivt heltal!

# GM confirm modals
gm-modal-title-cancel-quest = Annuller quest
gm-modal-label-cancel-quest = Skriv CONFIRM for at annullere questen.
gm-modal-placeholder-cancel-quest = Skriv "CONFIRM" for at fortsætte.
gm-modal-title-remove-from-quest = Fjern karakter fra quest
gm-modal-label-remove-from-quest = Bekræft fjernelse af karakter?
gm-modal-placeholder-remove-from-quest = Skriv "CONFIRM" for at fortsætte.

# GM DM messages
gm-dm-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} blev annulleret af GM'en.
gm-dm-quest-ready = Quest {"**"}{ $questTitle }{"**"} er nu klar!
gm-dm-quest-unlocked = Quest {"**"}{ $questTitle }{"**"} er ikke længere låst.
gm-dm-quest-locked = Quest {"**"}{ $questTitle }{"**"} er nu låst af GM'en.
gm-dm-player-removed = Du blev fjernet fra quest {"**"}{ $questTitle }{"**"}.
gm-dm-player-removed-waitlist = Du blev fjernet fra ventelisten for {"**"}{ $questTitle }{"**"}.
gm-dm-party-promotion = Du er blevet tilføjet til gruppen for {"**"}{ $questTitle }{"**"}, fordi en spiller faldt fra!
gm-dm-roster-locked = Quest-holdet er låst, og gruppen er underrettet!
gm-dm-roster-unlocked = Quest-holdet er blevet låst op.
gm-dm-rewards-no-characters =
    Din serveradministrator har konfigureret belønninger til GM'er, når de afslutter
    quests. Da du dog ikke har nogen registrerede karakterer, kunne dine belønninger
    ikke automatisk udstedes på nuværende tidspunkt.
gm-dm-rewards-no-active-character =
    Din serveradministrator har konfigureret belønninger til GM'er, når de afslutter
    quests. Da du dog ikke har en aktiv karakter på denne server, kunne dine belønninger
    ikke automatisk udstedes på nuværende tidspunkt.
gm-dm-rewards-issued = Følgende er blevet tildelt din aktive karakter, { $characterName }

# GM select menus
gm-select-placeholder-party-member = Vælg et gruppemedlem

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
gm-msg-player-removed = Spiller fjernet, og quest-holdet er opdateret!

# GM views
gm-title-main-menu = GM - Hovedmenu
gm-menu-quests = Quests
gm-menu-desc-quests = Opret, rediger og administrer quests.
gm-menu-players = Spillere
gm-menu-desc-players = Administrer spillerinventarer og rediger karakterer.
gm-menu-approvals = Karaktergodkendelser
gm-menu-desc-approvals = Gennemgå og godkend/afvis karakterindsendelser.

gm-title-quest-management = GM - Quest-administration
gm-desc-create-quest = Opret en ny quest.
gm-msg-no-quests = Ingen quests fundet.
gm-label-quest-locked = (Låst)
gm-title-manage-quest = Administrer quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Rediger quest-detaljer som titel, beskrivelse og gruppestørrelse.
gm-desc-toggle-ready = Skift klar-status (nuværende: {"**"}{ $status }{"**"})
    - Låser quest-holdet og underretter gruppemedlemmer om, at questen snart begynder. Hvis en rolle er konfigureret, tildeles den til gruppemedlemmer ved låsning.
    - Låser holdet op, når det sættes til Åben.
gm-label-ready-locked = Låst/Klar
gm-label-ready-open = Åben
gm-desc-configure-rewards = Konfigurer belønninger for den valgte quest.
gm-desc-complete-quest = Afslut en quest. Udsteder belønninger, hvis nogen, til gruppemedlemmer.
gm-desc-remove-player = Fjern en spiller fra quest-holdet og underret dem.
gm-desc-cancel-quest = Annuller questen og slet den fra quest-tavlen.
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
gm-label-currency-heading = {"**"}Valuta{"**"}
gm-msg-inventory-empty = Inventaret er tomt.

# GM approvals
gm-title-approvals = GM - Inventargodkendelser
gm-desc-review-submission = Indtast et indsendelses-ID for at gennemgå og godkende/afvise det.
gm-title-reviewing = Gennemgår: { $characterName }
gm-label-items = {"**"}Genstande:{"**"}
gm-label-currency = {"**"}Valuta:{"**"}
gm-embed-title-approved = Inventaropdatering godkendt
gm-embed-desc-approved = Inventaret for {"**"}{ $characterName }{"**"} er blevet godkendt af { $approver }.
gm-embed-title-denied = Inventaropdatering afvist
gm-embed-desc-denied = Inventaret for {"**"}{ $characterName }{"**"} er blevet afvist af { $denier }.

gm-modal-label-select-party-role = Grupperolle
gm-modal-desc-select-party-role = Vælg en rolle at tildele quest-gruppen.
gm-select-option-no-role = Ingen (Ingen grupperolle)

gm-error-role-hierarchy = ReQuest kan ikke administrere rollen "{ $roleName }" (ID: { $roleId }), fordi den er placeret højere end ReQuests højeste rolle i serverhierarkiet. Kontakt venligst en serveradministrator for at flytte rollen under ReQuests rolle, eller tildel ReQuest en højere rolle, og prøv derefter igen.
gm-dm-role-removal-failed =
    ⚠️ Kunne ikke fjerne rollen {"**"}{ $roleName }{"**"} fra følgende medlemmer: { $members }.
    Underret venligst en serveradministrator om at fjerne rollen manuelt.

gm-dm-role-not-found =
    ⚠️ Quest-rollen (ID: { $roleId }) for quest {"**"}{ $questTitle }{"**"} eksisterer ikke længere på serveren.
    Rolleoperationer blev sprunget over. Underret venligst en serveradministrator, hvis dette er uventet.
