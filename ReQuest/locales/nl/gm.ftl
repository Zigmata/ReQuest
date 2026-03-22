## Game Master module strings

# GM buttons
gm-btn-create = Aanmaken
gm-btn-edit-details = Details bewerken
gm-btn-toggle-ready = Gereedheid wisselen
gm-btn-configure-rewards = Beloningen configureren
gm-btn-remove-player = Speler verwijderen
gm-btn-cancel-quest = Quest annuleren
gm-btn-manage-party-rewards = Groepsbeloningen beheren
gm-btn-manage-individual-rewards = Individuele beloningen beheren
gm-btn-join = Deelnemen
gm-btn-leave = Verlaten
gm-btn-complete-quest = Quest voltooien
gm-btn-review-submission = Inzending beoordelen
gm-btn-approve = Goedkeuren
gm-btn-deny = Afwijzen

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
gm-modal-title-editing-quest = { $questTitle } bewerken
gm-modal-label-title = Titel
gm-modal-label-max-party-size = Maximale groepsgrootte
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
gm-modal-title-review-submission = Inzending beoordelen
gm-modal-label-submission-id = Inzending-ID
gm-modal-placeholder-submission-id = Voer het 8-teken-ID in

# GM errors
gm-error-forbidden-role-name = De opgegeven naam voor de groepsrol is verboden.
gm-error-role-already-exists = Een rol met die naam bestaat al op deze server.
gm-error-no-quest-channel = Er is nog geen kanaal aangewezen voor questberichten. Neem contact op met een serverbeheerder om het quest-kanaal te configureren.
gm-error-cannot-ping-announce = Kon aankondigingsrol { $role } niet pingen in kanaal { $channel }. Controleer kanaal- en ReQuest-rolmachtigingen bij je serverbeheerder(s).
gm-error-invalid-item-format = Ongeldig voorwerpformaat: "{ $item }". Elk voorwerp moet op een nieuwe regel staan, in het formaat "Naam: Hoeveelheid".
gm-error-submission-not-found = Inzending niet gevonden.
gm-error-already-on-quest = Je doet al mee aan deze quest als { $characterName }.
gm-error-no-active-character-long = Je hebt geen actief personage op deze server. Gebruik `/player` om een personage te registreren of te activeren.
gm-error-quest-locked = Fout bij deelname aan quest {"**"}{ $questTitle }{"**"}: De quest is vergrendeld door de GM.
gm-error-quest-full = Fout bij deelname aan quest {"**"}{ $questTitle }{"**"}: De questgroep is vol!
gm-error-not-signed-up = Je bent niet aangemeld voor deze quest.
gm-error-quest-channel-not-set = Quest-kanaal is niet ingesteld!
gm-error-empty-roster = Je kunt een quest niet voltooien met een lege groep. Probeer in plaats daarvan te annuleren.
gm-error-invalid-xp-value = XP-waarde moet een positief geheel getal zijn!

# GM confirm modals
gm-modal-title-cancel-quest = Quest annuleren
gm-modal-label-cancel-quest = Typ CONFIRM om de quest te annuleren.
gm-modal-placeholder-cancel-quest = Typ "CONFIRM" om door te gaan.
gm-modal-title-remove-from-quest = Personage verwijderen uit quest
gm-modal-label-remove-from-quest = Personageverwijdering bevestigen?
gm-modal-placeholder-remove-from-quest = Typ "CONFIRM" om door te gaan.

# GM DM messages
gm-dm-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} is geannuleerd door de GM.
gm-dm-quest-ready = Quest {"**"}{ $questTitle }{"**"} is nu gereed!
gm-dm-quest-unlocked = Quest {"**"}{ $questTitle }{"**"} is niet langer vergrendeld.
gm-dm-quest-locked = Quest {"**"}{ $questTitle }{"**"} is nu vergrendeld door de GM.
gm-dm-player-removed = Je bent verwijderd uit quest {"**"}{ $questTitle }{"**"}.
gm-dm-player-removed-waitlist = Je bent verwijderd van de wachtlijst voor {"**"}{ $questTitle }{"**"}.
gm-dm-party-promotion = Je bent toegevoegd aan de groep voor {"**"}{ $questTitle }{"**"}, omdat een speler is afgehaakt!
gm-dm-roster-locked = Questgroep vergrendeld en groepsleden op de hoogte gesteld!
gm-dm-roster-unlocked = Questgroep is ontgrendeld.
gm-dm-rewards-no-characters =
    Je serverbeheerder heeft beloningen geconfigureerd voor Game Masters wanneer zij
    quests voltooien. Omdat je echter geen geregistreerde personages hebt, konden je
    beloningen op dit moment niet automatisch worden uitgedeeld.
gm-dm-rewards-no-active-character =
    Je serverbeheerder heeft beloningen geconfigureerd voor Game Masters wanneer zij
    quests voltooien. Omdat je echter geen actief personage op deze server hebt, konden
    je beloningen op dit moment niet automatisch worden uitgedeeld.
gm-dm-rewards-issued = Het volgende is toegekend aan je actieve personage, { $characterName }

# GM select menus
gm-select-placeholder-party-member = Selecteer een groepslid

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
gm-msg-player-removed = Speler verwijderd en questgroep bijgewerkt!

# GM views
gm-title-main-menu = Game Master - Hoofdmenu
gm-menu-quests = Quests
gm-menu-desc-quests = Quests aanmaken, bewerken en beheren.
gm-menu-players = Spelers
gm-menu-desc-players = Spelerinventarissen beheren en personages aanpassen.
gm-menu-approvals = Personagegoedkeuringen
gm-menu-desc-approvals = Personageinzendingen beoordelen en goedkeuren/afwijzen.

gm-title-quest-management = Game Master - Questbeheer
gm-desc-create-quest = Maak een nieuwe quest aan.
gm-msg-no-quests = Geen quests gevonden.
gm-label-quest-locked = (Vergrendeld)
gm-title-manage-quest = Quest beheren - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Bewerk questdetails zoals titel, beschrijving en groepsgrootte.
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
gm-label-currency-heading = {"**"}Valuta{"**"}
gm-msg-inventory-empty = Inventaris is leeg.

# GM approvals
gm-title-approvals = Game Master - Inventarisgoedkeuringen
gm-desc-review-submission = Voer een inzending-ID in om deze te beoordelen en goed te keuren/af te wijzen.
gm-title-reviewing = Beoordelen: { $characterName }
gm-label-items = {"**"}Voorwerpen:{"**"}
gm-label-currency = {"**"}Valuta:{"**"}
gm-embed-title-approved = Inventarisupdate goedgekeurd
gm-embed-desc-approved = De inventaris voor {"**"}{ $characterName }{"**"} is goedgekeurd door { $approver }.
gm-embed-title-denied = Inventarisupdate afgewezen
gm-embed-desc-denied = De inventaris voor {"**"}{ $characterName }{"**"} is afgewezen door { $denier }.

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
