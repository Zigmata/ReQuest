## Stringhe del modulo Game Master

# Pulsanti GM
gm-btn-create = Crea
gm-btn-edit-details = Modifica dettagli
gm-btn-toggle-ready = Attiva/Disattiva pronto
gm-btn-configure-rewards = Configura ricompense
gm-btn-remove-player = Rimuovi giocatore
gm-btn-cancel-quest = Annulla quest
gm-btn-manage-party-rewards = Gestisci ricompense gruppo
gm-btn-manage-individual-rewards = Gestisci ricompense individuali
gm-btn-join = Unisciti
gm-btn-leave = Abbandona
gm-btn-complete-quest = Completa quest
gm-btn-review-submission = Esamina richiesta
gm-btn-approve = Approva
gm-btn-deny = Rifiuta

# Modali GM
gm-modal-title-create-quest = Crea nuova quest
gm-modal-label-quest-title = Titolo quest
gm-modal-placeholder-quest-title = Titolo della tua quest
gm-modal-label-restrictions = Restrizioni
gm-modal-placeholder-restrictions = Restrizioni, se presenti, come livelli dei giocatori
gm-modal-label-max-party = Dimensione massima gruppo
gm-modal-placeholder-max-party = Dimensione massima del gruppo per questa quest
gm-modal-label-party-role = Ruolo del gruppo
gm-modal-placeholder-party-role = Crea un ruolo per questa quest (Opzionale)
gm-modal-label-description = Descrizione
gm-modal-placeholder-description = Scrivi qui i dettagli della tua quest
gm-modal-title-editing-quest = Modifica { $questTitle }
gm-modal-label-title = Titolo
gm-modal-label-max-party-size = Dimensione max gruppo
gm-modal-title-add-reward = Aggiungi ricompensa
gm-modal-label-experience = Punti esperienza
gm-modal-placeholder-experience = Inserisci un numero
gm-modal-label-items = Oggetti
gm-modal-placeholder-items =
    oggetto: quantità
    oggetto2: quantità
    ecc.
gm-modal-title-add-summary = Aggiungi riepilogo quest
gm-modal-label-summary = Riepilogo
gm-modal-placeholder-summary = Aggiungi un riepilogo narrativo della quest
gm-modal-title-modifying-player = Modifica di { $playerName }
gm-modal-placeholder-xp-add-remove = Inserisci un numero positivo o negativo.
gm-modal-label-inventory = Inventario
gm-modal-placeholder-inventory-modify =
    oggetto: quantità
    oggetto2: quantità
    ecc.
gm-modal-title-review-submission = Esamina richiesta
gm-modal-label-submission-id = ID richiesta
gm-modal-placeholder-submission-id = Inserisci l'ID di 8 caratteri

# Errori GM
gm-error-forbidden-role-name = Il nome fornito per il ruolo del gruppo è vietato.
gm-error-role-already-exists = Un ruolo con quel nome esiste già in questo server.
gm-error-no-quest-channel = Non è stato ancora designato un canale per i post delle quest. Contatta un amministratore del server per configurare il canale quest.
gm-error-cannot-ping-announce = Impossibile menzionare il ruolo di annuncio { $role } nel canale { $channel }. Verifica i permessi del canale e del ruolo ReQuest con gli amministratori del server.
gm-error-invalid-item-format = Formato oggetto non valido: "{ $item }". Ogni oggetto deve essere su una nuova riga, nel formato "Nome: Quantità".
gm-error-submission-not-found = Richiesta non trovata.
gm-error-already-on-quest = Sei già in questa quest come { $characterName }.
gm-error-no-active-character-long = Non hai un personaggio attivo su questo server. Usa `/player` per registrare o attivare un personaggio.
gm-error-quest-locked = Errore nell'unirsi alla quest {"**"}{ $questTitle }{"**"}: La quest è bloccata dal GM.
gm-error-quest-full = Errore nell'unirsi alla quest {"**"}{ $questTitle }{"**"}: Il roster della quest è pieno!
gm-error-not-signed-up = Non sei iscritto a questa quest.
gm-error-quest-channel-not-set = Il canale quest non è stato impostato!
gm-error-empty-roster = Non puoi completare una quest con un roster vuoto. Prova ad annullarla.
gm-error-invalid-xp-value = Il valore XP deve essere un intero positivo!

# Modali di conferma GM
gm-modal-title-cancel-quest = Annulla quest
gm-modal-label-cancel-quest = Digita CONFIRM per annullare la quest.
gm-modal-placeholder-cancel-quest = Digita "CONFIRM" per procedere.
gm-modal-title-remove-from-quest = Rimuovi personaggio dalla quest
gm-modal-label-remove-from-quest = Confermare la rimozione del personaggio?
gm-modal-placeholder-remove-from-quest = Digita "CONFIRM" per procedere.

# Messaggi diretti GM
gm-dm-quest-cancelled = La quest {"**"}{ $questTitle }{"**"} è stata annullata dal GM.
gm-dm-quest-ready = La quest {"**"}{ $questTitle }{"**"} è ora pronta!
gm-dm-quest-unlocked = La quest {"**"}{ $questTitle }{"**"} non è più bloccata.
gm-dm-quest-locked = La quest {"**"}{ $questTitle }{"**"} è ora bloccata dal GM.
gm-dm-player-removed = Sei stato rimosso dalla quest {"**"}{ $questTitle }{"**"}.
gm-dm-player-removed-waitlist = Sei stato rimosso dalla lista d'attesa per {"**"}{ $questTitle }{"**"}.
gm-dm-party-promotion = Sei stato aggiunto al gruppo per {"**"}{ $questTitle }{"**"}, perché un giocatore si è ritirato!
gm-dm-roster-locked = Roster della quest bloccato e gruppo notificato!
gm-dm-roster-unlocked = Il roster della quest è stato sbloccato.
gm-dm-rewards-no-characters =
    L'amministratore del server ha configurato ricompense per i Game Master al completamento
    delle quest. Tuttavia, poiché non hai personaggi registrati, le tue ricompense non hanno
    potuto essere assegnate automaticamente in questo momento.
gm-dm-rewards-no-active-character =
    L'amministratore del server ha configurato ricompense per i Game Master al completamento
    delle quest. Tuttavia, poiché non hai un personaggio attivo su questo server, le tue ricompense
    non hanno potuto essere assegnate automaticamente in questo momento.
gm-dm-rewards-issued = Le seguenti ricompense sono state assegnate al tuo personaggio attivo, { $characterName }

# Menu di selezione GM
gm-select-placeholder-party-member = Seleziona un membro del gruppo

# Embed GM
gm-embed-title-mod-report = Report modifiche giocatore dal GM
gm-embed-field-experience = Esperienza
gm-embed-title-quest-complete = Quest completata: { $questTitle }
gm-embed-title-quest-completed = QUEST COMPLETATA: { $questTitle }
gm-embed-field-rewards = Ricompense
gm-embed-field-party = __Gruppo__
gm-embed-field-summary = Riepilogo
gm-embed-title-gm-rewards = Ricompense GM assegnate
gm-embed-field-items = Oggetti
gm-msg-player-removed = Giocatore rimosso e roster della quest aggiornato!

# Viste GM
gm-title-main-menu = Game Master - Menu principale
gm-menu-quests = Quest
gm-menu-desc-quests = Crea, modifica e gestisci le quest.
gm-menu-players = Giocatori
gm-menu-desc-players = Gestisci gli inventari dei giocatori e modifica i personaggi.
gm-menu-approvals = Approvazioni personaggi
gm-menu-desc-approvals = Esamina e approva/rifiuta le richieste dei personaggi.

gm-title-quest-management = Game Master - Gestione quest
gm-desc-create-quest = Crea una nuova quest.
gm-msg-no-quests = Nessuna quest trovata.
gm-label-quest-locked = (Bloccata)
gm-title-manage-quest = Gestisci quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Modifica i dettagli della quest come titolo, descrizione e dimensione del gruppo.
gm-desc-toggle-ready = Attiva/Disattiva stato pronto (Attuale: {"**"}{ $status }{"**"})
    - Blocca il roster della quest e notifica i membri del gruppo che la quest inizierà a breve. Se un ruolo è configurato, verrà assegnato ai membri del gruppo quando bloccato.
    - Sblocca il roster quando impostato su Aperto.
gm-label-ready-locked = Bloccato/Pronto
gm-label-ready-open = Aperto
gm-desc-configure-rewards = Configura le ricompense per la quest selezionata.
gm-desc-complete-quest = Completa una quest. Assegna le ricompense, se presenti, ai membri del gruppo.
gm-desc-remove-player = Rimuovi un giocatore dal roster della quest e notificalo.
gm-desc-cancel-quest = Annulla la quest e cancellala dalla bacheca quest.
gm-title-player-management = Game Master - Gestione giocatori
gm-desc-player-management =
    Questi comandi sono stati migrati ai menu contestuali. Fai clic destro (desktop) o tieni premuto (mobile) sul profilo di un giocatore per le seguenti opzioni del menu:

    - {"**"}Modifica giocatore{"**"}: Aggiungi o rimuovi oggetti ed esperienza da un giocatore.
    - {"**"}Visualizza giocatore{"**"}: Visualizza i dettagli del personaggio attivo di un giocatore.
gm-title-remove-player = Rimuovi giocatore dalla quest - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Note sulla rimozione del giocatore{"**"}__

    - Scegli un giocatore dal menu a tendina qui sotto per rimuoverlo dal roster della quest.
    - Se ci sono giocatori in lista d'attesa, il primo giocatore della lista verrà promosso nel gruppo.
    - Le ricompense individuali del giocatore rimosso verranno eliminate dalla quest.
    - Se desideri ricompensare il giocatore per contributi precedenti, usa il menu contestuale `Modifica giocatore` per assegnargli le ricompense direttamente.
gm-label-no-players-in-roster = Nessun giocatore nel roster della quest
gm-title-character-sheet = Scheda personaggio di { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Punti esperienza:{"**"}__
gm-label-possessions = __{"**"}Possedimenti{"**"}__
gm-label-currency-heading = {"**"}Valuta{"**"}
gm-msg-inventory-empty = L'inventario è vuoto.

# Approvazioni GM
gm-title-approvals = Game Master - Approvazioni inventario
gm-desc-review-submission = Inserisci un ID richiesta per esaminarla e approvarla/rifiutarla.
gm-title-reviewing = In esame: { $characterName }
gm-label-items = {"**"}Oggetti:{"**"}
gm-label-currency = {"**"}Valuta:{"**"}
gm-embed-title-approved = Aggiornamento inventario approvato
gm-embed-desc-approved = L'inventario di {"**"}{ $characterName }{"**"} è stato approvato da { $approver }.
gm-embed-title-denied = Aggiornamento inventario rifiutato
gm-embed-desc-denied = L'inventario di {"**"}{ $characterName }{"**"} è stato rifiutato da { $denier }.

gm-modal-label-select-party-role = Party Role
gm-modal-desc-select-party-role = Select a role to assign to the quest party.
gm-select-option-no-role = None (No Party Role)

gm-error-role-hierarchy = ReQuest cannot manage the role "{ $roleName }" (ID: { $roleId }) because it is positioned higher than ReQuest's highest role in the server hierarchy. Please contact a server administrator to move the role below ReQuest's role, or assign ReQuest a higher role.
