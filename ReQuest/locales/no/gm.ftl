## Game Master module strings

# GM buttons
gm-btn-create = Opprett
gm-btn-edit-details = Rediger quest
gm-btn-toggle-ready = Veksle klar
gm-btn-configure-rewards = Konfigurer belønninger
gm-btn-remove-player = Fjern spiller
gm-btn-cancel-quest = Avbryt quest
gm-btn-manage-party-rewards = Administrer gruppebelønninger
gm-btn-manage-individual-rewards = Administrer individuelle belønninger
gm-btn-join = Bli med
gm-btn-leave = Forlat
gm-btn-complete-quest = Fullfør quest
gm-btn-edit-details-modal = Rediger detaljer
gm-btn-edit-images = Rediger bilder
gm-btn-publish = Publiser
gm-btn-update-post = Oppdater innlegg
gm-select-placeholder-party-role = Velg en grupperolle...
gm-modal-title-edit-details = Rediger quest-detaljer
gm-modal-title-edit-images = Rediger quest-bilder

# GM modals
gm-modal-title-create-quest = Opprett ny quest
gm-modal-label-quest-title = Quest-tittel
gm-modal-placeholder-quest-title = Tittelen på questen din
gm-modal-label-restrictions = Begrensninger
gm-modal-placeholder-restrictions = Begrensninger, om noen, som spillernivåer
gm-modal-label-max-party = Maksimal gruppestørrelse
gm-modal-placeholder-max-party = Maks størrelse på gruppen for denne questen
gm-modal-label-party-role = Grupperolle
gm-modal-placeholder-party-role = Opprett en rolle for denne questen (valgfritt)
gm-modal-label-description = Beskrivelse
gm-modal-placeholder-description = Skriv detaljene for questen din her
gm-modal-label-image-url = Miniatyrbilde-URL
gm-modal-label-large-image-url = Stort bilde-URL
gm-modal-placeholder-image-url = Skriv inn en bilde-URL (eller la stå tom for å fjerne)
gm-modal-title-add-reward = Legg til belønning
gm-modal-label-experience = Erfaringspoeng
gm-modal-placeholder-experience = Skriv inn et tall
gm-modal-label-items = Gjenstander
gm-modal-placeholder-items =
    gjenstand: antall
    gjenstand2: antall
    osv.
gm-modal-title-add-summary = Legg til quest-sammendrag
gm-modal-label-summary = Sammendrag
gm-modal-placeholder-summary = Legg til et historiesammendrag av questen
gm-modal-title-modifying-player = Endrer { $playerName }
gm-modal-placeholder-xp-add-remove = Skriv inn et positivt eller negativt tall.
gm-modal-label-inventory = Inventar
gm-modal-placeholder-inventory-modify =
    gjenstand: antall
    gjenstand2: antall
    osv.

# GM errors
gm-error-forbidden-role-name = Navnet gitt for grupperollen er forbudt.
gm-error-role-already-exists = En rolle med det navnet eksisterer allerede på denne serveren.
gm-error-no-quest-channel = En kanal er ennå ikke utpekt for quest-innlegg. Kontakt en serveradministrator for å konfigurere quest-kanalen.
gm-error-cannot-ping-announce = Kunne ikke pinge kunngjøringsrollen { $role } i kanalen { $channel }. Sjekk kanal- og ReQuest-rolletillatelser med serveradministratoren(e).
gm-error-invalid-item-format = Ugyldig gjenstandsformat: "{ $item }". Hver gjenstand må være på en ny linje, i formatet "Navn: Antall".
gm-error-already-on-quest = Du er allerede på denne questen som { $characterName }.
gm-error-no-active-character-long = Du har ingen aktiv karakter på denne serveren. Bruk `/player` for å registrere eller aktivere en karakter.
gm-error-quest-locked = Feil ved deltakelse i quest {"**"}{ $questTitle }{"**"}: Questen er låst av GM.
gm-error-quest-full = Feil ved deltakelse i quest {"**"}{ $questTitle }{"**"}: Quest-oppsettet er fullt!
gm-error-not-signed-up = Du er ikke påmeldt denne questen.
gm-error-quest-channel-not-set = Quest-kanal er ikke angitt!
gm-error-empty-roster = Du kan ikke fullføre en quest med en tom deltagerliste. Prøv å avbryte i stedet.
gm-error-invalid-xp-value = XP-verdi må være et positivt heltall!
gm-error-party-size-positive = Gruppestørrelse må være et positivt tall.
gm-error-party-size-too-small = Gruppestørrelse kan ikke være mindre enn den nåværende gruppen ({ $currentSize } medlemmer).
gm-error-role-name-forbidden = Rollenavnet "{ $roleName }" er forbudt på denne serveren.
gm-error-role-name-exists = En rolle med navnet "{ $roleName }" eksisterer allerede på denne serveren.
gm-error-role-hierarchy = ReQuest kan ikke administrere rollen "{ $roleName }" (ID: { $roleId }) fordi den er plassert høyere enn ReQuests høyeste rolle i serverhierarkiet. Kontakt en serveradministrator for å flytte rollen under ReQuests rolle, eller tildel ReQuest en høyere rolle, og prøv igjen.

# GM confirm modals
gm-modal-title-cancel-quest = Avbryt quest
gm-modal-label-cancel-quest = Skriv BEKREFT for å avbryte questen.
gm-modal-title-remove-from-quest = Fjern karakter fra quest
gm-modal-label-remove-from-quest = Bekreft fjerning av karakter?

# GM DM embeds
gm-dm-title-quest-cancelled = Quest avbrutt
gm-dm-desc-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} ble avbrutt av GM.
gm-dm-title-quest-ready = Quest klar
gm-dm-desc-quest-ready = Quest {"**"}{ $questTitle }{"**"} er nå klar! GM-en din vil starte questen snart.
gm-dm-title-player-removed = Fjernet fra quest
gm-dm-desc-player-removed = Du ble fjernet fra quest {"**"}{ $questTitle }{"**"} av GM.
gm-dm-desc-player-removed-waitlist = Du ble fjernet fra ventelisten for quest {"**"}{ $questTitle }{"**"}.
gm-dm-title-party-promotion = Gruppeforfremmelse
gm-dm-desc-party-promotion =
    Du har blitt forfremmet til hovedgruppen for {"**"}{ $questTitle }{"**"}
    fordi en spiller forlot questen.
gm-dm-title-roster-locked = Deltagerliste låst
gm-dm-desc-roster-locked =
    Deltagerlisten for {"**"}{ $questTitle }{"**"} er låst
    og alle gruppemedlemmer er varslet.
gm-dm-title-roster-unlocked = Deltagerliste åpnet
gm-dm-desc-roster-unlocked = Deltagerlisten for {"**"}{ $questTitle }{"**"} er nå åpen.
gm-dm-title-player-removed-confirm = Spiller fjernet
gm-dm-desc-player-removed-confirm =
    Spilleren er fjernet fra {"**"}{ $questTitle }{"**"}
    og quest-oppsettet er oppdatert.
gm-dm-footer-quest = Quest ID: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    Serveradministratoren din har konfigurert belønninger for spillledere når de fullfører
    quester. Siden du ikke har noen registrerte karakterer, kunne belønningene dine
    ikke deles ut automatisk på dette tidspunktet.
gm-dm-rewards-no-active-character =
    Serveradministratoren din har konfigurert belønninger for spillledere når de fullfører
    quester. Siden du ikke har noen aktiv karakter på denne serveren, kunne belønningene dine
    ikke deles ut automatisk på dette tidspunktet.
gm-dm-rewards-issued = Følgende har blitt tildelt din aktive karakter, { $characterName }
gm-dm-role-removal-failed =
    ⚠️ Kunne ikke fjerne rollen {"**"}{ $roleName }{"**"} fra følgende medlemmer: { $members }.
    Varsle en serveradministrator om å fjerne rollen manuelt.
gm-dm-role-not-found =
    ⚠️ Quest-rollen (ID: { $roleId }) for quest {"**"}{ $questTitle }{"**"} eksisterer ikke lenger på serveren.
    Rolleoperasjoner ble hoppet over. Varsle en serveradministrator hvis dette er uventet.

# GM select menus
gm-select-placeholder-party-member = Velg et gruppemedlem
gm-modal-label-select-party-role = Grupperolle
gm-modal-desc-select-party-role = Velg en rolle å tildele quest-gruppen.
gm-select-option-no-role = Ingen (ingen grupperolle)

# GM embeds
gm-embed-title-mod-report = GM-spillerendringsrapport
gm-embed-field-experience = Erfaring
gm-embed-title-quest-complete = Quest fullført: { $questTitle }
gm-embed-title-quest-completed = QUEST FULLFØRT: { $questTitle }
gm-embed-field-rewards = Belønninger
gm-embed-field-party = __Gruppe__
gm-embed-field-summary = Sammendrag
gm-embed-title-gm-rewards = GM-belønninger utdelt
gm-embed-field-items = Gjenstander

# GM views
gm-title-main-menu = Spillleder - Hovedmeny
gm-menu-quests = Quester
gm-menu-desc-quests = Opprett, rediger og administrer quester.
gm-menu-players = Spillere
gm-menu-desc-players = Administrer spillerinventarer og endre karakterer.

gm-title-quest-management = Spillleder - Quest-administrasjon
gm-desc-create-quest = Opprett en ny quest.
gm-msg-no-quests = Ingen quester funnet.
gm-label-quest-locked = (Låst)
gm-label-quest-draft = (Utkast)
gm-title-manage-quest = Administrer quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Rediger quest-detaljer som tittel, beskrivelse og gruppestørrelse.
gm-title-edit-quest = Rediger quest - { $questTitle }
gm-label-field-not-set = Ikke angitt
gm-label-description-not-set = Beskrivelse ikke angitt
gm-label-current-title = {"**"}Tittel:{"**"} { $value }
gm-label-current-description = {"**"}Beskrivelse{"**"}
gm-label-current-restrictions = {"**"}Begrensninger:{"**"} { $value }
gm-label-current-party-size = {"**"}Maks gruppestørrelse:{"**"} { $value }
gm-label-current-party-role = {"**"}Grupperolle:{"**"} { $value }
gm-label-current-image = {"**"}Miniatyrbilde{"**"}
gm-label-current-large-image = {"**"}Bilde{"**"}
gm-desc-publish-quest = Publiser denne questen til quest-tavlen.
gm-desc-update-quest-post = Oppdater quest-innlegget på quest-tavlen.
gm-desc-toggle-ready = Veksle klar-status (nåværende: {"**"}{ $status }{"**"})
    - Låser quest-oppsettet og varsler gruppemedlemmene om at questen snart begynner. Hvis en rolle er konfigurert, tildeles den til gruppemedlemmer når den låses.
    - Åpner oppsettet når den settes til Åpen.
gm-label-ready-locked = Låst/Klar
gm-label-ready-open = Åpen
gm-desc-configure-rewards = Konfigurer belønninger for den valgte questen.
gm-desc-complete-quest = Fullfør en quest. Deler ut belønninger, om noen, til gruppemedlemmer.
gm-desc-remove-player = Fjern en spiller fra quest-oppsettet og varsle dem.
gm-desc-cancel-quest = Avbryt questen og slett den fra quest-tavlen.
gm-title-player-management = Spillleder - Spilleradministrasjon
gm-desc-player-management =
    Disse kommandoene har blitt flyttet til kontekstmenyer. Høyreklikk (PC) eller trykk og hold (mobil) på en spillers profil for følgende menyvalg:

    - {"**"}Endre spiller{"**"}: Legg til eller fjern gjenstander og erfaring fra en spiller.
    - {"**"}Vis spiller{"**"}: Se en spillers aktive karakterdetaljer.
gm-title-remove-player = Fjern spiller fra quest - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Merknader om spillerfjerning{"**"}__

    - Velg en spiller fra rullegardinmenyen nedenfor for å fjerne dem fra quest-oppsettet.
    - Hvis noen spillere er på ventelisten, vil den første spilleren på listen bli forfremmet til gruppen.
    - Individuelle belønninger for den fjernede spilleren vil bli slettet fra questen.
    - Hvis du ønsker å belønne spilleren for tidligere bidrag, bruk kontekstmenyen `Endre spiller` for å tildele dem belønninger direkte.
gm-label-no-players-in-roster = Ingen spillere i quest-oppsettet
gm-title-character-sheet = Karakterark for { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Erfaringspoeng:{"**"}__
gm-label-possessions = __{"**"}Eiendeler{"**"}__
gm-label-currency-heading = {"**"}Valuta{"**"}
gm-msg-inventory-empty = Inventaret er tomt.

# GM approvals
