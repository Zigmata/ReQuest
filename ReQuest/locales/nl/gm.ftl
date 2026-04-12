## Game Master module strings

# GM buttons
gm-btn-create = Aanmaken
gm-btn-edit-details = Quest bewerken
gm-btn-toggle-ready = Gereedheid wisselen
gm-btn-configure-rewards = Beloningen configureren
gm-btn-remove-player = Speler verwijderen
gm-btn-cancel-quest = Quest annuleren
gm-btn-manage-party-rewards = Groepsbeloningen beheren
gm-btn-manage-individual-rewards = Individuele beloningen beheren
gm-btn-join = Deelnemen
gm-btn-leave = Verlaten
gm-btn-complete-quest = Quest voltooien
gm-btn-edit-details-modal = Details bewerken
gm-btn-edit-images = Afbeeldingen bewerken
gm-btn-publish = Publiceren
gm-btn-update-post = Bericht bijwerken
gm-select-placeholder-party-role = Selecteer een groepsrol...
gm-modal-title-edit-details = Questdetails bewerken
gm-modal-title-edit-images = Questafbeeldingen bewerken

# GM modals
gm-modal-title-create-quest = Nieuwe quest aanmaken
gm-modal-label-quest-title = Quest-titel
gm-modal-placeholder-quest-title = Titel van je quest
gm-modal-label-restrictions = Beperkingen
gm-modal-placeholder-restrictions = Beperkingen, indien van toepassing, zoals spelerniveaus
gm-modal-label-max-party = Maximale groepsgrootte
gm-modal-placeholder-max-party = Maximale groepsgrootte voor deze quest
gm-modal-label-party-role = Groepsrol
gm-modal-placeholder-party-role = Maak een rol aan voor deze quest (optioneel)
gm-modal-label-description = Beschrijving
gm-modal-placeholder-description = Schrijf hier de details van je quest
gm-modal-label-image-url = Miniatuur-URL
gm-modal-label-large-image-url = Grote afbeelding-URL
gm-modal-placeholder-image-url = Voer een afbeeldings-URL in (of laat leeg om te verwijderen)
gm-modal-title-add-reward = Beloning toevoegen
gm-modal-label-experience = Ervaringspunten
gm-modal-placeholder-experience = Voer een nummer in
gm-modal-label-items = Voorwerpen
gm-modal-placeholder-items =
    voorwerp: hoeveelheid
    voorwerp2: hoeveelheid
    enz.
gm-modal-title-add-summary = Quest-samenvatting toevoegen
gm-modal-label-summary = Samenvatting
gm-modal-placeholder-summary = Voeg een verhaalsamenvatting van de quest toe
gm-modal-title-modifying-player = { $playerName } aanpassen
gm-modal-placeholder-xp-add-remove = Voer een positief of negatief getal in.
gm-modal-label-inventory = Inventaris
gm-modal-placeholder-inventory-modify =
    voorwerp: hoeveelheid
    voorwerp2: hoeveelheid
    enz.

# GM errors
gm-error-no-quest-channel = Er is nog geen kanaal aangewezen voor questberichten. Neem contact op met een serverbeheerder om het quest-kanaal te configureren.
gm-error-invalid-item-format = Ongeldig voorwerpformaat: "{ $item }". Elk voorwerp moet op een nieuwe regel staan, in het formaat "Naam: Hoeveelheid".
gm-error-already-on-quest = Je doet al mee aan deze quest als { $characterName }.
gm-error-no-active-character-long = Je hebt geen actief personage op deze server. Gebruik `/player` om een personage te registreren of te activeren.
gm-error-quest-locked = Fout bij deelname aan quest {"**"}{ $questTitle }{"**"}: De quest is vergrendeld door de GM.
gm-error-quest-full = Fout bij deelname aan quest {"**"}{ $questTitle }{"**"}: De questgroep is vol!
gm-error-not-signed-up = Je bent niet aangemeld voor deze quest.
gm-error-quest-not-found = De quest bestaat niet meer.
gm-error-quest-channel-not-set = Quest-kanaal is niet ingesteld!
gm-error-empty-roster = Je kunt een quest niet voltooien met een lege groep. Probeer in plaats daarvan te annuleren.
gm-error-invalid-xp-value = XP-waarde moet een positief geheel getal zijn!
gm-error-party-size-positive = Groepsgrootte moet een positief getal zijn.
gm-error-party-size-too-small = Groepsgrootte kan niet kleiner zijn dan de huidige groep ({ $currentSize } leden).
gm-error-role-name-forbidden = De rolnaam "{ $roleName }" is verboden op deze server.
gm-error-role-name-exists = Een rol met de naam "{ $roleName }" bestaat al op deze server.
gm-error-role-hierarchy = ReQuest kan de rol "{ $roleName }" (ID: { $roleId }) niet beheren omdat deze hoger staat dan de hoogste rol van ReQuest in de serverhiërarchie. Neem contact op met een serverbeheerder om de rol onder de rol van ReQuest te plaatsen, of wijs ReQuest een hogere rol toe, en probeer het opnieuw.

# GM confirm modals
gm-modal-title-cancel-quest = Quest annuleren
gm-modal-label-cancel-quest = Typ BEVESTIG om de quest te annuleren.
gm-modal-title-remove-from-quest = Personage verwijderen uit quest
gm-modal-label-remove-from-quest = Personageverwijdering bevestigen?

# GM DM embeds
gm-dm-title-quest-cancelled = Quest geannuleerd
gm-dm-desc-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} is geannuleerd door de GM.
gm-dm-title-quest-ready = Quest gereed
gm-dm-desc-quest-ready = Quest {"**"}{ $questTitle }{"**"} is nu gereed! Je GM zal de quest binnenkort starten.
gm-dm-title-player-removed = Verwijderd uit quest
gm-dm-desc-player-removed = Je bent verwijderd uit quest {"**"}{ $questTitle }{"**"} door de GM.
gm-dm-desc-player-removed-waitlist = Je bent verwijderd van de wachtlijst voor quest {"**"}{ $questTitle }{"**"}.
gm-dm-title-party-promotion = Groepspromotie
gm-dm-desc-party-promotion =
    Je bent gepromoveerd naar de hoofdgroep voor {"**"}{ $questTitle }{"**"}
    omdat een speler de quest heeft verlaten.
gm-dm-title-roster-locked = Groep vergrendeld
gm-dm-desc-roster-locked =
    De groep voor {"**"}{ $questTitle }{"**"} is vergrendeld
    en alle groepsleden zijn op de hoogte gesteld.
gm-dm-title-roster-unlocked = Groep ontgrendeld
gm-dm-desc-roster-unlocked = De groep voor {"**"}{ $questTitle }{"**"} is ontgrendeld.
gm-dm-title-player-removed-confirm = Speler verwijderd
gm-dm-desc-player-removed-confirm =
    De speler is verwijderd uit {"**"}{ $questTitle }{"**"}
    en de questgroep is bijgewerkt.
gm-dm-footer-quest = Quest-ID: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    Je serverbeheerder heeft beloningen geconfigureerd voor Game Masters wanneer zij
    quests voltooien. Omdat je echter geen geregistreerde personages hebt, konden je
    beloningen op dit moment niet automatisch worden uitgedeeld.
gm-dm-rewards-no-active-character =
    Je serverbeheerder heeft beloningen geconfigureerd voor Game Masters wanneer zij
    quests voltooien. Omdat je echter geen actief personage op deze server hebt, konden
    je beloningen op dit moment niet automatisch worden uitgedeeld.
gm-dm-rewards-issued = Het volgende is toegekend aan je actieve personage, { $characterName }
gm-dm-role-removal-failed =
    ⚠️ Het verwijderen van de rol {"**"}{ $roleName }{"**"} van de volgende leden is mislukt: { $members }.
    Breng een serverbeheerder op de hoogte om de rol handmatig te verwijderen.
gm-dm-role-not-found =
    ⚠️ De questrol (ID: { $roleId }) voor quest {"**"}{ $questTitle }{"**"} bestaat niet meer op de server.
    Rolbewerkingen zijn overgeslagen. Breng een serverbeheerder op de hoogte als dit onverwacht is.

# GM select menus
gm-select-placeholder-party-member = Selecteer een groepslid
gm-select-option-no-role = Geen (geen groepsrol)

# GM embeds
gm-embed-title-mod-report = GM-speleraanpassingsrapport
gm-embed-field-experience = Ervaring
gm-embed-title-quest-complete = Quest voltooid: { $questTitle }
gm-embed-title-quest-completed = QUEST VOLTOOID: { $questTitle }
gm-embed-field-rewards = Beloningen
gm-embed-field-party = __Groep__
gm-embed-field-summary = Samenvatting
gm-embed-title-gm-rewards = GM-beloningen uitgereikt
gm-embed-field-items = Voorwerpen

# GM views
gm-title-main-menu = Game Master - Hoofdmenu
gm-menu-quests = Quests
gm-menu-desc-quests = Quests aanmaken, bewerken en beheren.
gm-menu-players = Spelers
gm-menu-desc-players = Spelerinventarissen beheren en personages aanpassen.

gm-title-quest-management = Game Master - Questbeheer
gm-desc-create-quest = Maak een nieuwe quest aan.
gm-msg-no-quests = Geen quests gevonden.
gm-label-quest-locked = (Vergrendeld)
gm-label-quest-draft = (Concept)
gm-title-manage-quest = Quest beheren - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Bewerk questdetails zoals titel, beschrijving en groepsgrootte.
gm-label-field-not-set = Niet ingesteld
gm-label-description-not-set = Beschrijving niet ingesteld
gm-label-current-party-size = {"**"}Maximale groepsgrootte:{"**"} { $value }
gm-label-current-party-role = {"**"}Groepsrol:{"**"} { $value }
gm-desc-toggle-ready = Gereedheid wisselen (Huidig: {"**"}{ $status }{"**"})
    - Vergrendelt de questgroep en stelt groepsleden op de hoogte dat de quest binnenkort begint. Als er een rol is geconfigureerd, wordt deze toegewezen aan groepsleden bij vergrendeling.
    - Ontgrendelt de groep wanneer ingesteld op Open.
gm-label-ready-locked = Vergrendeld/Gereed
gm-label-ready-open = Open
gm-desc-configure-rewards = Configureer beloningen voor de geselecteerde quest.
gm-desc-complete-quest = Voltooi een quest. Reikt beloningen uit, indien aanwezig, aan groepsleden.
gm-desc-remove-player = Verwijder een speler uit de questgroep en stel deze op de hoogte.
gm-desc-cancel-quest = Annuleer de quest en verwijder deze van het quest-bord.
gm-title-player-management = Game Master - Spelerbeheer
gm-desc-player-management =
    Deze commando's zijn verplaatst naar contextmenu's. Klik met de rechtermuisknop (desktop) of houd ingedrukt (mobiel) op het profiel van een speler voor de volgende menuopties:

    - {"**"}Speler aanpassen{"**"}: Voeg voorwerpen en ervaring toe aan of verwijder ze van een speler.
    - {"**"}Speler bekijken{"**"}: Bekijk de actieve personagedetails van een speler.
gm-title-remove-player = Speler verwijderen uit quest - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Opmerkingen bij spelerverwijdering{"**"}__

    - Kies een speler uit het dropdownmenu hieronder om deze uit de questgroep te verwijderen.
    - Als er spelers op een wachtlijst staan, wordt de eerste speler op de lijst gepromoveerd naar de groep.
    - Individuele beloningen voor de verwijderde speler worden verwijderd uit de quest.
    - Als je de speler wilt belonen voor eerdere bijdragen, gebruik dan het contextmenu `Speler aanpassen` om direct beloningen uit te reiken.
gm-label-no-players-in-roster = Geen spelers in de questgroep
gm-title-character-sheet = Personageblad voor { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Ervaringspunten:{"**"}__
gm-label-possessions = __{"**"}Bezittingen{"**"}__

# GM approvals
