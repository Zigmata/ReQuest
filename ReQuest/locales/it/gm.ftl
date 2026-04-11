## Stringhe del modulo Game Master

# Pulsanti GM
gm-btn-create = Crea
gm-btn-edit-details = Modifica quest
gm-btn-toggle-ready = Attiva/Disattiva pronto
gm-btn-configure-rewards = Configura ricompense
gm-btn-remove-player = Rimuovi giocatore
gm-btn-cancel-quest = Annulla quest
gm-btn-manage-party-rewards = Gestisci ricompense gruppo
gm-btn-manage-individual-rewards = Gestisci ricompense individuali
gm-btn-join = Unisciti
gm-btn-leave = Abbandona
gm-btn-complete-quest = Completa quest
gm-btn-edit-details-modal = Modifica dettagli
gm-btn-edit-images = Modifica immagini
gm-btn-publish = Pubblica
gm-btn-update-post = Aggiorna pubblicazione
gm-select-placeholder-party-role = Seleziona un ruolo del gruppo...
gm-modal-title-edit-details = Modifica dettagli quest
gm-modal-title-edit-images = Modifica immagini quest

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
gm-modal-label-image-url = URL miniatura
gm-modal-label-large-image-url = URL immagine grande
gm-modal-placeholder-image-url = Inserisci un URL immagine (o lascia vuoto per rimuovere)
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

# Errori GM
gm-error-forbidden-role-name = Il nome fornito per il ruolo del gruppo è vietato.
gm-error-role-already-exists = Un ruolo con quel nome esiste già in questo server.
gm-error-no-quest-channel = Non è stato ancora designato un canale per i post delle quest. Contatta un amministratore del server per configurare il canale quest.
gm-error-cannot-ping-announce = Impossibile menzionare il ruolo di annuncio { $role } nel canale { $channel }. Verifica i permessi del canale e del ruolo ReQuest con gli amministratori del server.
gm-error-invalid-item-format = Formato oggetto non valido: "{ $item }". Ogni oggetto deve essere su una nuova riga, nel formato "Nome: Quantità".
gm-error-already-on-quest = Sei già in questa quest come { $characterName }.
gm-error-no-active-character-long = Non hai un personaggio attivo su questo server. Usa `/player` per registrare o attivare un personaggio.
gm-error-quest-locked = Errore nell'unirsi alla quest {"**"}{ $questTitle }{"**"}: La quest è bloccata dal GM.
gm-error-quest-full = Errore nell'unirsi alla quest {"**"}{ $questTitle }{"**"}: Il roster della quest è pieno!
gm-error-not-signed-up = Non sei iscritto a questa quest.
gm-error-quest-not-found = La missione non esiste più.
gm-error-quest-channel-not-set = Il canale quest non è stato impostato!
gm-error-empty-roster = Non puoi completare una quest con un roster vuoto. Prova ad annullarla.
gm-error-invalid-xp-value = Il valore XP deve essere un intero positivo!
gm-error-party-size-positive = La dimensione del gruppo deve essere un numero positivo.
gm-error-party-size-too-small = La dimensione del gruppo non può essere inferiore al gruppo attuale ({ $currentSize } membri).
gm-error-role-name-forbidden = Il nome del ruolo "{ $roleName }" è vietato su questo server.
gm-error-role-name-exists = Un ruolo chiamato "{ $roleName }" esiste già su questo server.

# Modali di conferma GM
gm-modal-title-cancel-quest = Annulla quest
gm-modal-label-cancel-quest = Digita CONFERMA per annullare la quest.
gm-modal-title-remove-from-quest = Rimuovi personaggio dalla quest
gm-modal-label-remove-from-quest = Confermare la rimozione del personaggio?

# GM DM embeds
gm-dm-title-quest-cancelled = Quest annullata
gm-dm-desc-quest-cancelled = La quest {"**"}{ $questTitle }{"**"} è stata annullata dal GM.
gm-dm-title-quest-ready = Quest pronta
gm-dm-desc-quest-ready = La quest {"**"}{ $questTitle }{"**"} è ora pronta! Il tuo GM inizierà la quest a breve.
gm-dm-title-player-removed = Rimosso dalla quest
gm-dm-desc-player-removed = Sei stato rimosso dalla quest {"**"}{ $questTitle }{"**"} dal GM.
gm-dm-desc-player-removed-waitlist = Sei stato rimosso dalla lista d'attesa per {"**"}{ $questTitle }{"**"}.
gm-dm-title-party-promotion = Promozione nel gruppo
gm-dm-desc-party-promotion =
    Sei stato promosso nel gruppo principale di {"**"}{ $questTitle }{"**"}
    perché un giocatore ha lasciato la quest.
gm-dm-title-roster-locked = Roster bloccato
gm-dm-desc-roster-locked =
    Il roster di {"**"}{ $questTitle }{"**"} è stato bloccato
    e tutti i membri del gruppo sono stati notificati.
gm-dm-title-roster-unlocked = Roster sbloccato
gm-dm-desc-roster-unlocked = Il roster di {"**"}{ $questTitle }{"**"} è stato sbloccato.
gm-dm-title-player-removed-confirm = Giocatore rimosso
gm-dm-desc-player-removed-confirm =
    Il giocatore è stato rimosso da {"**"}{ $questTitle }{"**"}
    e il roster della quest è stato aggiornato.
gm-dm-footer-quest = ID Quest: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    L'amministratore del server ha configurato ricompense per i Game Master al completamento
    delle quest. Tuttavia, poiché non hai personaggi registrati, le tue ricompense non hanno
    potuto essere assegnate automaticamente in questo momento.
gm-dm-rewards-no-active-character =
    L'amministratore del server ha configurato ricompense per i Game Master al completamento
    delle quest. Tuttavia, poiché non hai un personaggio attivo su questo server, le tue ricompense
    non hanno potuto essere assegnate automaticamente in questo momento.
gm-dm-rewards-issued = Le seguenti ricompense sono state assegnate al tuo personaggio attivo, { $characterName }
gm-dm-role-removal-failed =
    ⚠️ Impossibile rimuovere il ruolo {"**"}{ $roleName }{"**"} dai seguenti membri: { $members }.
    Avvisa un amministratore del server per rimuovere il ruolo manualmente.
gm-dm-role-not-found =
    ⚠️ Il ruolo quest (ID: { $roleId }) per la quest {"**"}{ $questTitle }{"**"} non esiste più sul server.
    Le operazioni sui ruoli sono state saltate. Avvisa un amministratore del server se questo è inaspettato.

# Menu di selezione GM
gm-select-placeholder-party-member = Seleziona un membro del gruppo
gm-modal-label-select-party-role = Ruolo del gruppo
gm-modal-desc-select-party-role = Seleziona un ruolo da assegnare al gruppo della quest.
gm-select-option-no-role = Nessuno (senza ruolo del gruppo)

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

# Viste GM
gm-title-main-menu = Game Master - Menu principale
gm-menu-quests = Quest
gm-menu-desc-quests = Crea, modifica e gestisci le quest.
gm-menu-players = Giocatori
gm-menu-desc-players = Gestisci gli inventari dei giocatori e modifica i personaggi.

gm-title-quest-management = Game Master - Gestione quest
gm-desc-create-quest = Crea una nuova quest.
gm-msg-no-quests = Nessuna quest trovata.
gm-label-quest-locked = (Bloccata)
gm-label-quest-draft = (Bozza)
gm-title-manage-quest = Gestisci quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Modifica i dettagli della quest come titolo, descrizione e dimensione del gruppo.
gm-title-edit-quest = Modifica quest - { $questTitle }
gm-label-field-not-set = Non impostato
gm-label-description-not-set = Descrizione non impostata
gm-label-current-title = {"**"}Titolo:{"**"} { $value }
gm-label-current-description = {"**"}Descrizione{"**"}
gm-label-current-restrictions = {"**"}Restrizioni:{"**"} { $value }
gm-label-current-party-size = {"**"}Dimensione max gruppo:{"**"} { $value }
gm-label-current-party-role = {"**"}Ruolo del gruppo:{"**"} { $value }
gm-label-current-image = {"**"}Miniatura{"**"}
gm-label-current-large-image = {"**"}Immagine{"**"}
gm-desc-publish-quest = Pubblica questa quest nella bacheca quest.
gm-desc-update-quest-post = Aggiorna la pubblicazione della quest nella bacheca quest.
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

gm-error-role-hierarchy = ReQuest non può gestire il ruolo "{ $roleName }" (ID: { $roleId }) perché è posizionato più in alto del ruolo più alto di ReQuest nella gerarchia del server. Contatta un amministratore del server per spostare il ruolo sotto il ruolo di ReQuest, oppure assegna a ReQuest un ruolo superiore, quindi riprova l'operazione.
