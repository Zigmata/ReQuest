## Stringhe del modulo Config

# ==========================================
# PULSANTI
# ==========================================

# Ruoli
config-btn-clear = Cancella
config-btn-remove-gm-roles = Rimuovi ruoli GM
config-btn-forbidden-roles = Ruoli vietati

# Quest
config-btn-toggle-quest-summary = Attiva/Disattiva riepilogo quest
config-btn-toggle-player-experience = Attiva/Disattiva esperienza giocatore
config-btn-toggle-display = Attiva/Disattiva visualizzazione
config-btn-purge-player-board = Svuota bacheca giocatori
config-btn-add-modify-rewards = Aggiungi/Modifica ricompense

# Valuta
config-btn-add-denomination = Aggiungi denominazione
config-btn-add-new-currency = Aggiungi nuova valuta
config-btn-remove-currency = Rimuovi valuta

# Negozi - creazione
config-btn-add-shop-wizard = Aggiungi negozio (procedura guidata)
config-btn-add-shop-json = Aggiungi negozio (JSON)
config-btn-edit-shop-wizard = Modifica negozio (procedura guidata)
config-btn-edit-shop-json = Modifica negozio (JSON)
config-btn-remove-shop = Rimuovi negozio
config-btn-add-item = Aggiungi oggetto
config-btn-edit-shop-details = Modifica dettagli negozio
config-btn-download-json = Scarica JSON
config-btn-done-editing = Modifica completata
config-btn-scan-server-configs = Scansiona configurazioni server
config-btn-re-scan = Nuova scansione

# Negozio nuovo personaggio
config-btn-upload-json = Carica JSON
config-btn-configure-new-character-wealth = Configura ricchezza nuovo personaggio
config-btn-configure-new-character-shop = Configura negozio nuovo personaggio
config-btn-clear-shop = Svuota negozio
config-btn-configure-static-kits = Configura kit statici
config-btn-new-character-settings = Impostazioni nuovo personaggio
config-btn-disabled-no-currency = Disabilitato (nessuna valuta configurata)
config-btn-disabled-no-wealth = Disabilitato (nessuna ricchezza iniziale configurata)

# Kit statici
config-btn-create-new-kit = Crea nuovo kit
config-btn-delete-kit = Elimina kit
config-btn-add-currency = Aggiungi valuta

# Gioco di ruolo
config-btn-toggle-rp-rewards = Attiva/Disattiva ricompense GdR
config-btn-clear-channels = Cancella canali
config-btn-edit-settings = Modifica impostazioni
config-btn-configure-rewards = Configura ricompense

# Scorte
config-btn-stock-limits = Limiti scorte
config-btn-set-limit = Imposta limite
config-btn-edit-limit = Modifica limite
config-btn-remove-limit = Rimuovi limite
config-btn-configure-restock-schedule = Configura programma rifornimento
config-btn-back-to-shop-editor = Torna all'editor del negozio

# Negozio forum
config-btn-create-new-thread = Crea nuovo thread
config-btn-use-existing-thread = Usa thread esistente

# Procedura guidata
config-btn-quit = Esci
config-btn-configure-channels = Configura canali
config-btn-configure-roles = Configura ruoli
config-btn-configure-quests = Configura quest
config-btn-configure-players = Configura giocatori
config-btn-configure-currency = Configura valuta
config-btn-configure-rp-rewards = Configura ricompense GdR
config-btn-configure-shops = Configura negozi
config-btn-new-char-setup = Setup nuovo pers.

# Titoli modali di conferma (passati alla ConfirmModal comune)
config-modal-title-confirm-role-removal = Conferma rimozione ruolo
config-modal-title-confirm-removal = Conferma rimozione
config-modal-title-confirm-currency-removal = Conferma rimozione valuta
config-modal-title-confirm-shop-removal = Conferma rimozione negozio
config-modal-title-confirm-kit-deletion = Conferma eliminazione kit
config-modal-title-confirm-remove-stock-limit = Conferma rimozione limite scorte
config-modal-title-clear-shop = Conferma svuotamento negozio

# Etichette delle modali di conferma
config-modal-label-remove-role = Rimuovere { $roleName }?
config-modal-label-remove-denomination = Rimuovere { $denominationName }?
config-modal-label-remove-currency = Rimuovere { $currencyName }?
config-modal-label-shop-removal-warning = ATTENZIONE: Questa azione è irreversibile!
config-modal-label-kit-deletion-warning = ATTENZIONE: Irreversibile!
config-modal-label-remove-stock-limit = Digita CONFERMA per rimuovere il limite scorte
config-modal-label-clear-shop = Svuotare tutti gli articoli da questo negozio?

# Messaggi di errore dai pulsanti
config-error-shop-data-not-found = Errore: impossibile trovare i dati di quel negozio.
config-msg-shop-json-download = Ecco la definizione JSON per {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Ecco la definizione JSON per il negozio nuovo personaggio.
config-error-select-forum-first = Seleziona prima un canale forum.
config-error-select-thread-first = Seleziona prima un thread.

# ==========================================
# MODALI
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Aggiungi nuova valuta
config-modal-label-currency-name = Nome valuta
config-error-currency-already-exists = Una valuta o denominazione chiamata { $name } esiste già!

# RenameCurrencyModal
config-modal-title-rename-currency = Rinomina valuta
config-modal-label-new-currency-name = Nuovo nome valuta
config-error-currency-name-exists = Una valuta chiamata "{ $name }" esiste già.
config-error-denomination-name-exists = Una denominazione chiamata "{ $name }" esiste già.

# RenameDenominationModal
config-modal-title-rename-denomination = Rinomina denominazione
config-modal-label-new-denomination-name = Nuovo nome denominazione

# AddCurrencyDenominationModal
config-modal-title-add-denomination = Aggiungi denominazione { $currencyName }
config-modal-label-denomination-name = Nome
config-modal-placeholder-denomination-name = es., Argento
config-modal-label-denomination-value = Valore
config-modal-placeholder-denomination-value = es., 0.1
config-error-denomination-matches-currency = Il nome della nuova denominazione non può corrispondere a una valuta esistente su questo server! Trovata valuta esistente chiamata "{ $existingName }".
config-error-denomination-matches-denomination = Il nome della nuova denominazione non può corrispondere a una denominazione esistente su questo server! Trovata denominazione esistente chiamata "{ $denominationName }" sotto la valuta chiamata "{ $currencyName }".
config-error-denomination-value-exists = Le denominazioni sotto una singola valuta devono avere valori unici! { $denominationName } ha già questo valore assegnato.
config-label-denomination-info = **{ $name }** (Valore: { $value })

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Nomi dei ruoli vietati
config-modal-label-names = Nomi
config-modal-placeholder-names = Inserisci i nomi separati da virgole
config-msg-forbidden-roles-updated = Ruoli vietati aggiornati!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Svuota bacheca giocatori
config-modal-label-age = Età
config-modal-placeholder-age = Inserisci l'età massima dei post (in giorni) da mantenere
config-msg-posts-purged = I post più vecchi di { $days } giorni sono stati eliminati!

# GMRewardsModal
config-modal-title-gm-rewards = Aggiungi/Modifica ricompense GM
config-modal-label-experience = Esperienza
config-modal-placeholder-enter-number = Inserisci un numero
config-modal-label-items = Oggetti
config-modal-placeholder-items =
    Nome: Quantità
    Nome2: Quantità
    ecc.
config-error-experience-invalid = L'esperienza deve essere un intero valido (es. 2000).
config-error-item-format-invalid = Formato oggetto non valido: "{ $item }". Ogni oggetto deve essere su una nuova riga, nel formato "Nome: Quantità".

# ConfigShopDetailsModal
config-modal-title-shop-details = Aggiungi/Modifica dettagli negozio
config-modal-label-shop-channel = Seleziona un canale
config-modal-placeholder-shop-channel = Seleziona il canale per questo negozio
config-modal-label-shop-name = Nome negozio
config-modal-placeholder-shop-name = Inserisci il nome del negozio
config-modal-label-shopkeeper-name = Nome negoziante
config-modal-placeholder-shopkeeper-name = Inserisci il nome del negoziante
config-modal-label-shop-description = Descrizione negozio
config-modal-placeholder-shop-description = Inserisci una descrizione per il negozio
config-modal-label-shop-image-url = URL immagine negozio
config-modal-placeholder-shop-image-url = Inserisci un URL per l'immagine del negozio
config-error-no-channel-selected = Nessun canale selezionato per il negozio.
config-error-shop-already-in-channel = Un negozio è già registrato nel canale selezionato. Scegli un canale diverso o modifica il negozio esistente.

# build_shop_header_view
config-label-shopkeeper = {"**"}Negoziante:{"**"} { $name }
config-msg-use-shop-command = Usa il comando `/shop` per sfogliare e acquistare oggetti.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Crea negozio in thread del forum
config-modal-label-thread-name = Nome thread
config-modal-placeholder-thread-name = Inserisci il nome del thread del negozio
config-error-forum-not-found = Impossibile trovare il canale forum selezionato.
config-error-shop-already-in-thread = Un negozio è già registrato in questo thread. Questo non dovrebbe accadere per un nuovo thread.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Aggiungi nuovo negozio tramite JSON
config-modal-label-upload-json = Carica un file .json contenente i dati del negozio
config-error-no-json-uploaded = Nessun file JSON caricato per il negozio.
config-error-file-must-be-json = Il file caricato deve essere un file JSON (.json).
config-error-invalid-json = Formato JSON non valido: { $error }
config-error-json-validation-failed = Il JSON non è conforme allo schema: { $error }

# ShopItemModal
config-modal-title-shop-item = Aggiungi/Modifica oggetto del negozio
config-modal-label-item-name = Nome oggetto
config-modal-placeholder-item-name = Inserisci il nome dell'oggetto
config-modal-label-item-description = Descrizione oggetto
config-modal-placeholder-item-description = Inserisci una descrizione per l'oggetto
config-modal-label-item-quantity = Quantità oggetto
config-modal-placeholder-item-quantity = Inserisci la quantità venduta per acquisto
config-modal-label-item-costs = Costi dell'oggetto
config-modal-placeholder-item-costs = Es.: 10 gold + 5 silver\nOPPURE: 50 rep\n(Usa + per E, Nuova riga per O)
config-error-item-quantity-positive = La quantità dell'oggetto deve essere un intero positivo.
config-error-cost-format-invalid = Formato costo non valido nell'opzione: "{ $option }". Ogni costo deve avere un importo e una valuta separati da uno spazio, es. "10 gold".
config-error-cost-amount-invalid = Importo non valido "{ $amount }" per la valuta: "{ $currency }". L'importo deve essere un numero positivo.
config-error-unknown-currency = Valuta sconosciuta `{ $currency }`. Usa una valuta valida configurata per questo server.
config-error-item-already-exists = Un oggetto chiamato { $itemName } esiste già in questo negozio.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Aggiorna negozio tramite JSON
config-modal-label-upload-new-json = Carica nuova definizione JSON
config-error-no-file-uploaded = Nessun file caricato.
config-error-file-must-be-json-ext = Il file deve essere un file `.json`.
config-error-json-validation-message = Validazione JSON fallita: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Aggiungi/Modifica equipaggiamento nuovo personaggio
config-modal-placeholder-item-quantity-selection = Inserisci la quantità ricevuta per selezione
config-modal-label-item-cost = Costo oggetto
config-error-cost-format-short = Formato costo non valido: '{ $component }'. Atteso 'Importo Valuta'.
config-error-amount-invalid-short = Importo non valido '{ $amount }' per la valuta '{ $currency }'.
config-error-item-exists-new-char = Un oggetto chiamato { $itemName } esiste già nel negozio nuovo personaggio.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Carica negozio nuovo personaggio (JSON)
config-error-no-json-uploaded-short = Nessun file JSON caricato.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Imposta ricchezza nuovo personaggio
config-modal-label-amount = Importo
config-modal-placeholder-amount = Inserisci l'importo di questa valuta.
config-modal-placeholder-currency-name = Inserisci il nome di una valuta definita su questo server
config-error-no-currencies-configured = Nessuna valuta è configurata su questo server.
config-error-currency-not-found = Valuta o denominazione chiamata { $name } non trovata. Usa una valuta valida.

# CreateStaticKitModal
config-modal-title-create-kit = Crea nuovo kit statico
config-modal-label-kit-name = Nome kit
config-modal-placeholder-kit-name = es., Kit iniziale guerriero
config-modal-label-description = Descrizione
config-modal-placeholder-kit-description = Descrizione opzionale per questo kit
config-error-kit-name-exists = Un kit statico chiamato "{ $kitName }" esiste già. Scegli un nome diverso.

# StaticKitItemModal
config-modal-title-kit-item = Aggiungi/Modifica oggetto del kit
config-modal-placeholder-kit-item-quantity = Inserisci la quantità di questo oggetto da includere nel kit

# StaticKitCurrencyModal
config-modal-title-kit-currency = Aggiungi valuta al kit
config-modal-placeholder-currency-eg = es., Oro
config-modal-placeholder-amount-eg = es., 100
config-error-amount-must-be-number = L'importo deve essere un numero.
config-error-amount-exceeds-maximum = L'importo non può superare { $max }.
config-error-no-currencies-on-server = Nessuna valuta configurata sul server.
config-error-currency-not-found-short = Valuta "{ $currency }" non trovata.
config-error-denomination-not-found = Denominazione "{ $denomination }" non trovata nella configurazione della valuta.

# RoleplaySettingsModal
config-modal-title-rp-settings = Impostazioni gioco di ruolo
config-modal-label-min-message-length = Lunghezza minima messaggio (caratteri)
config-modal-placeholder-min-message-length = Numero di caratteri richiesti perché un messaggio sia idoneo. 0 per nessun limite
config-modal-label-cooldown = Tempo di attesa (secondi)
config-modal-placeholder-cooldown = Tempo di attesa, in secondi, tra un messaggio e l'altro per l'idoneità alle ricompense
config-modal-label-message-threshold = Soglia messaggi
config-modal-placeholder-message-threshold = Numero di messaggi richiesti per attivare la ricompensa
config-modal-label-frequency = Frequenza (n. di messaggi)
config-modal-placeholder-frequency = Numero di messaggi idonei richiesti per ottenere le ricompense
config-error-min-length-invalid = La lunghezza minima del messaggio deve essere un intero non negativo.
config-error-cooldown-invalid = Il tempo di attesa deve essere un intero non negativo.
config-error-threshold-invalid = La soglia messaggi deve essere un intero positivo.
config-error-frequency-invalid = La frequenza deve essere un intero positivo.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Configura ricompense gioco di ruolo
config-modal-label-items-name-quantity = Oggetti (Nome: Quantità)
config-modal-label-currency-name-amount = Valuta (Nome: Importo)
config-error-experience-non-negative = L'esperienza deve essere un intero non negativo.
config-error-item-quantity-positive-named = La quantità dell'oggetto per "{ $itemName }" deve essere un intero positivo.
config-error-currency-amount-positive = L'importo della valuta per "{ $currencyName }" deve essere un numero positivo.

# SetItemStockModal
config-modal-title-stock-limit = Limite scorte: { $itemName }
config-modal-label-max-stock = Scorte massime
config-modal-placeholder-max-stock = Inserisci le scorte massime (es., 10)
config-modal-label-current-stock = Scorte attuali
config-modal-placeholder-current-stock = Inserisci le scorte attualmente disponibili
config-modal-label-restock-increment = Incremento rifornimento (per ciclo)
config-modal-placeholder-restock-increment = Quantità aggiunta per ciclo (predefinito: 1)
config-error-max-stock-positive = Le scorte massime devono essere un intero positivo.
config-error-current-stock-non-negative = Le scorte attuali devono essere un intero non negativo.
config-error-current-exceeds-max = Le scorte attuali non possono superare le scorte massime.
config-error-item-not-in-shop = Oggetto "{ $itemName }" non trovato nel negozio.

# RestockScheduleModal
config-modal-title-restock-schedule = Configura programma rifornimento
config-modal-restock-schedule-label = Programmazione
config-modal-restock-schedule-none = Nessuno (Disattivato)
config-modal-restock-schedule-hourly = Ogni ora
config-modal-restock-schedule-daily = Giornaliero
config-modal-restock-schedule-weekly = Settimanale
config-modal-label-time = Orario (HH:MM in UTC)
config-modal-desc-current-time = Ora corrente: { $utcTime }
config-modal-placeholder-time = es., 14:30 per le 14:30 UTC
config-modal-restock-day-label = Giorno della settimana (solo settimanale)
config-modal-restock-mode-label = Modalità di rifornimento
config-modal-restock-mode-full = Completo (ripristina al massimo)
config-modal-restock-mode-incremental = Incrementale (aggiungi quantità)
config-error-time-format-invalid = L'orario deve essere nel formato HH:MM (es., 14:30).
config-error-increment-positive = La quantità di incremento deve essere un intero positivo.

# ==========================================
# SELETTORI
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Cerca il tuo canale { $configName }

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Scegli il tuo ruolo di annuncio quest

# AddGMRoleSelect
config-select-placeholder-gm-roles = Scegli il/i tuo/i ruolo/i GM

# ConfigWaitListSelect
config-select-placeholder-wait-list = Seleziona dimensione lista d'attesa
config-select-option-disabled = 0 (Disabilitato)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Seleziona modalità inventario
config-select-option-disabled-label = Disabilitato
config-select-desc-disabled = I giocatori iniziano con inventari vuoti.
config-select-option-selection = Selezione
config-select-desc-selection = I giocatori scelgono liberamente gli oggetti dal negozio nuovo personaggio.
config-select-option-purchase = Acquisto
config-select-desc-purchase = I giocatori acquistano oggetti dal negozio nuovo personaggio con una quantità di valuta data.
config-select-option-open = Aperto
config-select-desc-open = I giocatori inseriscono manualmente i propri inventari.
config-select-option-static = Statico
config-select-desc-static = Ai giocatori viene assegnato un inventario iniziale predefinito.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Seleziona canali idonei

# RoleplayModeSelect
config-select-placeholder-rp-mode = Seleziona modalità
config-select-option-scheduled = Programmato
config-select-desc-scheduled = Le ricompense vengono assegnate una volta entro un periodo di reset specificato.
config-select-option-accrued = Cumulativo
config-select-desc-accrued = Le ricompense vengono assegnate ripetutamente in base ai livelli di attività specificati.

# RoleplayResetSelect
config-select-placeholder-reset-period = Seleziona periodo di reset
config-select-option-hourly = Ogni ora
config-select-desc-hourly = Si resetta ogni ora.
config-select-option-daily = Giornaliero
config-select-desc-daily = Si resetta ogni 24 ore.
config-select-option-weekly = Settimanale
config-select-desc-weekly = Si resetta ogni 7 giorni.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Seleziona giorno di reset

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Seleziona ora di reset (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Seleziona un canale forum

# ForumThreadSelect
config-select-placeholder-thread = Seleziona un thread
config-select-option-no-threads = Nessun thread attivo trovato
config-select-desc-no-threads = Crea un nuovo thread o controlla i thread archiviati
config-select-option-select-forum-first = Seleziona prima un forum
config-select-desc-select-forum-first = Seleziona un canale forum qui sopra
config-select-desc-thread-id = ID Thread: { $threadId }
config-error-select-valid-thread = Seleziona un thread valido o creane uno nuovo.
config-error-thread-not-found = Impossibile trovare il thread selezionato. Potrebbe essere stato eliminato o archiviato.

# ==========================================
# VISTE
# ==========================================

## Menu principale
config-title-main-menu = Configurazione server - Menu principale
config-menu-config-wizard = Procedura guidata
config-menu-desc-config-wizard = Verifica che il tuo server sia pronto a usare ReQuest con una scansione rapida.
config-menu-channels = Canali
config-menu-desc-channels = Imposta i canali designati per i post di ReQuest.
config-menu-currency = Valuta
config-menu-desc-currency = Impostazioni globali della valuta.
config-menu-players = Giocatori
config-menu-desc-players = Impostazioni globali dei giocatori, come il tracciamento dei punti esperienza.
config-menu-quests = Quest
config-menu-desc-quests = Impostazioni globali delle quest, come le liste d'attesa.
config-menu-rp-rewards = Ricompense GdR
config-menu-desc-rp-rewards = Configura le ricompense per il gioco di ruolo.
config-menu-roles = Ruoli
config-menu-desc-roles = Opzioni di configurazione per i ruoli con menzione o privilegiati.
config-menu-shops = Negozi
config-menu-desc-shops = Configura negozi personalizzati.
config-menu-language = Lingua
config-menu-desc-language = Imposta la lingua predefinita per questo server.

## Vista procedura guidata
config-title-wizard = {"**"}Configurazione server - Procedura guidata{"**"}
config-wizard-intro =
    {"**"}Benvenuto nella procedura guidata di configurazione di ReQuest!{"**"}

    Questa procedura ti aiuterà ad assicurarti che il tuo server sia configurato correttamente per usare le funzionalità di ReQuest. Eseguirà una scansione delle impostazioni attuali e fornirà raccomandazioni per eventuali modifiche necessarie.

    Usa il pulsante "Avvia scansione" qui sotto per iniziare il processo di validazione. Una volta completata la scansione, riceverai un report dettagliato della configurazione del tuo server insieme alle modifiche consigliate.

# Procedura guidata - Validazione permessi bot
config-wizard-bot-permissions-header = __{"**"}Permessi globali del bot{"**"}__
config-wizard-bot-permissions-desc = Questa sezione verifica che ReQuest abbia i permessi corretti per funzionare correttamente.
config-wizard-bot-role = Ruolo bot: { $roleMention }
config-wizard-status-warnings = {"**"}Stato: ⚠️ AVVISI TROVATI{"**"}
config-wizard-missing-perm = - ⚠️ Mancante: `{ $permissionName }`
config-wizard-ensure-permissions = Assicurati che il ruolo più alto del bot abbia questi permessi concessi globalmente.
config-wizard-status-ok = {"**"}Stato: ✅ OK{"**"}
config-wizard-bot-permissions-ok = Il bot ha tutti i permessi globali richiesti.
config-wizard-status-scan-failed = {"**"}Stato: ❌ SCANSIONE FALLITA{"**"}
config-wizard-scan-error = Si è verificato un errore imprevisto durante il controllo dei permessi del bot.
config-wizard-error-type = Errore: { $errorType }
config-wizard-required-permissions = {"**"}Permessi richiesti per il ruolo del bot:{"**"}

# Procedura guidata - Nomi dei permessi
config-wizard-perm-view-channels = Visualizza canali
config-wizard-perm-manage-roles = Gestisci ruoli
config-wizard-perm-send-messages = Invia messaggi
config-wizard-perm-attach-files = Allega file
config-wizard-perm-add-reactions = Aggiungi reazioni
config-wizard-perm-use-external-emoji = Usa emoji esterne
config-wizard-perm-manage-messages = Gestisci messaggi
config-wizard-perm-read-message-history = Leggi cronologia messaggi

# Procedura guidata - Validazione ruoli
config-wizard-role-header = __{"**"}Configurazioni dei ruoli{"**"}__
config-wizard-role-desc =
    Questa sezione verifica quanto segue:

    - I ruoli GM (obbligatori) e il ruolo di annuncio (opzionale) sono configurati.
    - Il ruolo predefinito (@everyone) ha i permessi richiesti per accedere alle funzionalità del bot.
    - Il ruolo predefinito (@everyone) non ha permessi pericolosi.
    - I ruoli GM e di annuncio vengono controllati per verificare se hanno escalation di permessi oltre il ruolo predefinito.

    Gli avvisi qui sono solo raccomandazioni basate su una configurazione predefinita. A seconda delle esigenze del tuo server, potresti avere motivo di ignorare alcune di queste raccomandazioni.

config-wizard-default-role-label = {"**"}Ruolo predefinito:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Permessi pericolosi trovati:
config-wizard-default-role-ok = - ✅ @everyone: OK
config-wizard-missing-permission = - Permesso mancante: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}Ruoli GM:{"**"}
config-wizard-no-gm-roles = - ⚠️ Nessun ruolo GM configurato
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Ruolo configurato non trovato/eliminato dal server
config-wizard-role-ok = - ✅ { $roleMention }: OK
config-wizard-announcement-role-label = {"**"}Ruolo di annuncio:{"**"}
config-wizard-no-announcement-role = - ℹ️ Nessun ruolo di annuncio configurato
config-wizard-announcement-role-not-found = - ⚠️ Ruolo configurato non trovato/eliminato dal server
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Escalation di permessi rilevate - { $escalations }
config-wizard-escalation-more = , e altri { $count }...

# Procedura guidata - Permessi predefiniti richiesti
config-wizard-perm-send-messages-in-threads = Invia messaggi nei thread
config-wizard-perm-use-application-commands = Usa comandi applicazione

# Procedura guidata - Permessi pericolosi
config-wizard-perm-manage-channels = Gestisci canali
config-wizard-perm-manage-webhooks = Gestisci webhook
config-wizard-perm-manage-server = Gestisci server
config-wizard-perm-manage-nicknames = Gestisci nickname
config-wizard-perm-kick-members = Espelli membri
config-wizard-perm-ban-members = Banna membri
config-wizard-perm-timeout-members = Silenzia membri
config-wizard-perm-mention-everyone = Menziona @everyone
config-wizard-perm-manage-threads = Gestisci thread
config-wizard-perm-administrator = Amministratore

# Procedura guidata - Validazione canali
config-wizard-channel-header = __{"**"}Configurazioni dei canali{"**"}__
config-wizard-channel-desc =
    Questa sezione verifica quanto segue:

    - I canali configurati esistono.
    - Il bot ha il permesso di visualizzare e inviare messaggi nei canali configurati.
    - Il ruolo predefinito (@everyone) non ha i permessi `Invia messaggi`.

config-wizard-channel-no-config-required = - ⚠️ Nessun canale configurato
config-wizard-channel-not-configured = - ℹ️ Non configurato (opzionale)
config-wizard-channel-not-found = - ⚠️ Canale configurato non trovato/eliminato dal server
config-wizard-channel-ok = - ✅ OK
config-wizard-bot-cannot-view = - ⚠️ { $botMention } non può visualizzare questo canale.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } non può inviare messaggi in questo canale.
config-wizard-everyone-can-send = - ⚠️ @everyone può inviare messaggi in questo canale.

# Procedura guidata - Nomi dei canali
config-wizard-channel-quest-board = Bacheca quest
config-wizard-channel-player-board = Bacheca giocatori
config-wizard-channel-quest-archive = Archivio quest
config-wizard-channel-gm-transaction-log = Log transazioni GM
config-wizard-channel-player-transaction-log = Log transazioni giocatori
config-wizard-channel-shop-log = Log negozio
config-wizard-channel-approval-queue = Coda approvazione personaggi

# Procedura guidata - Dashboard
config-wizard-dashboard-header = __{"**"}Riepilogo impostazioni{"**"}__
config-wizard-dashboard-desc = Questa sezione fornisce una panoramica delle configurazioni non essenziali per un riferimento rapido.
config-wizard-quest-settings = {"**"}Impostazioni quest{"**"}
config-wizard-quest-wait-list = - Dimensione lista d'attesa quest: { $size }
config-wizard-quest-summary = - Riepilogo quest: { $status }
config-wizard-gm-rewards-per-quest = {"**"}Ricompense GM (per quest){"**"}
config-wizard-player-settings = {"**"}Impostazioni giocatore{"**"}
config-wizard-player-experience = - Esperienza giocatore: { $status }
config-wizard-currency-settings = {"**"}Impostazioni valuta{"**"}
config-wizard-rp-rewards = {"**"}Ricompense gioco di ruolo{"**"}
config-wizard-rp-status = - Stato: { $status }
config-wizard-rp-mode = - Modalità: { $mode }
config-wizard-rp-channels = - Canali monitorati: { $count }
config-wizard-shops = {"**"}Negozi{"**"}
config-wizard-shops-count = - Negozi configurati: { $count }
config-wizard-shops-more = - ...e altri { $count }
config-wizard-new-char-setup = {"**"}Setup nuovo personaggio{"**"}
config-wizard-inventory-type = - Tipo inventario: { $type }
config-wizard-new-char-shop-items = - Oggetti negozio nuovo personaggio: { $count }
config-wizard-static-kits = - Kit statici: { $count }

# Procedura guidata - Report ricompense GM
config-wizard-no-currencies = - ℹ️ Nessuna valuta configurata
config-wizard-configured-currencies = {"**"}Valute configurate:{"**"}
config-wizard-no-denominations = - Nessuna denominazione configurata
config-wizard-gm-rewards-disabled = {"**"}Stato:{"**"} Disabilitato
config-wizard-gm-rewards-enabled = {"**"}Stato:{"**"} Abilitato
config-wizard-gm-rewards-experience = - Esperienza: { $xp }
config-wizard-gm-rewards-items = - Oggetti:

# Procedura guidata - Lingua del server (Pagina 1)
config-wizard-server-language-desc =
    Questa è la lingua che ReQuest utilizzerà per tutti i messaggi pubblici, come pubblicazioni di quest, messaggi di riassortimento del negozio e registri delle transazioni.
config-wizard-server-language = {"**"}Lingua del server:{"**"} { $language }
config-wizard-server-language-default = Predefinito (inglese)

# Procedura guidata - Info riassortimento negozio
config-wizard-shop-restock-not-scheduled = ℹ️ Riassortimento non programmato

# Procedura guidata - Impostazioni quest (Pagina 5)
config-wizard-quest-header = __{"**"}Impostazioni quest{"**"}__
config-wizard-quest-header-desc =
    Questa sezione fornisce una panoramica delle configurazioni relative alle quest.
config-wizard-quest-role-mode = - Modalità ruoli quest: { $mode }
config-wizard-quest-roles-label = {"**"}Ruoli quest GM{"**"}
config-wizard-quest-roles-count = - Ruoli assegnati ai GM: { $count }
config-wizard-quest-roles-all-ok = - ✅ Tutti i ruoli OK
config-wizard-quest-roles-assigned-to = {"    "}Assegnato a: { $gmNames }
config-wizard-quest-roles-not-found = - ⚠️ ID ruolo { $roleId }: Non trovato/Eliminato dal server
config-wizard-quest-roles-no-assignments = - ℹ️ Nessun ruolo quest assegnato

## Vista ruoli
config-title-roles = {"**"}Configurazione server - Ruoli{"**"}
config-label-announcement-role = {"**"}Ruolo di annuncio:{"**"} { $status }
config-desc-announcement-role = Questo ruolo viene menzionato quando una quest viene pubblicata.
config-label-announcement-role-default = {"**"}Ruolo di annuncio:{"**"} Non configurato
config-label-gm-roles = {"**"}Ruolo/i GM:{"**"} { $roles }
config-desc-gm-roles = Questi ruoli concedono l'accesso ai comandi e alle funzionalità del Game Master.
config-label-gm-roles-default = {"**"}Ruolo/i GM:{"**"} Non configurato
config-title-forbidden-roles = __{"**"}Ruoli vietati{"**"}__
config-desc-forbidden-roles =
    Configura una lista di nomi di ruoli che non possono essere usati dai Game Master per i loro ruoli di gruppo.
    Per impostazione predefinita, `everyone`, `administrator`, `gm` e `game master` non possono essere usati. Questa configurazione
    estende quella lista.

## Vista rimozione ruoli GM
config-title-remove-gm-roles = {"**"}Configurazione server - Rimuovi ruolo/i GM{"**"}
config-msg-no-gm-roles = Nessun ruolo GM configurato.

## Vista canali
config-title-channels = {"**"}Configurazione server - Canali{"**"}

config-label-quest-board = {"**"}Bacheca quest:{"**"} { $channel }
config-desc-quest-board = Il canale dove verranno pubblicati le quest nuove/attive.
config-label-quest-board-default = {"**"}Bacheca quest:{"**"} Non configurato

config-label-player-board = {"**"}Bacheca giocatori:{"**"} { $channel }
config-desc-player-board = Una bacheca opzionale per annunci/messaggi ad uso dei giocatori.
config-label-player-board-default = {"**"}Bacheca giocatori:{"**"} Non configurato

config-label-quest-archive = {"**"}Archivio quest:{"**"} { $channel }
config-desc-quest-archive = Un canale opzionale dove le quest completate vengono spostate, con informazioni di riepilogo.
config-label-quest-archive-default = {"**"}Archivio quest:{"**"} Non configurato

config-label-gm-transaction-log = {"**"}Log transazioni GM:{"**"} { $channel }
config-desc-gm-transaction-log = Un canale opzionale dove vengono registrate le transazioni GM (es. comandi Modifica giocatore).
config-label-gm-transaction-log-default = {"**"}Log transazioni GM:{"**"} Non configurato

config-label-player-transaction-log = {"**"}Log transazioni giocatori:{"**"} { $channel }
config-desc-player-transaction-log = Un canale opzionale dove vengono registrate le transazioni dei giocatori come scambi e consumo di oggetti.
config-label-player-transaction-log-default = {"**"}Log transazioni giocatori:{"**"} Non configurato

config-label-shop-log = {"**"}Log negozio:{"**"} { $channel }
config-desc-shop-log = Un canale opzionale dove vengono registrate le transazioni del negozio.
config-label-shop-log-default = {"**"}Log negozio:{"**"} Non configurato

## Vista quest
config-title-quests = {"**"}Configurazione server - Quest{"**"}

config-label-wait-list = {"**"}Dimensione lista d'attesa quest:{"**"} { $size }
config-desc-wait-list = Una lista d'attesa permette al numero specificato di giocatori di mettersi in coda per una quest piena, nel caso un giocatore si ritiri.
config-label-wait-list-disabled = {"**"}Dimensione lista d'attesa quest:{"**"} Disabilitata

config-label-quest-summary = {"**"}Riepilogo quest:{"**"} { $status }
config-desc-quest-summary = Questa opzione permette ai GM di fornire un breve riepilogo alla chiusura delle quest.
config-label-quest-summary-disabled = {"**"}Riepilogo quest:{"**"} Disabilitato

config-label-gm-rewards = Ricompense GM
config-desc-gm-rewards = Configura le ricompense che i GM ricevono al completamento delle quest.

## Vista ricompense GM
config-title-gm-rewards = {"**"}Configurazione server - Ricompense GM{"**"}
config-desc-gm-rewards-detail =
    {"**"}Aggiungi/Modifica ricompense{"**"}
    Apre una modale di input per aggiungere, modificare o rimuovere le ricompense GM.

    > Le ricompense configurate sono su base per-quest. Ogni volta che un Game Master completa una quest, riceverà
    le ricompense configurate qui sotto sul proprio personaggio attivo.
config-msg-no-rewards = Nessuna ricompensa configurata.
config-label-gm-experience = {"**"}Esperienza:{"**"} { $xp }
config-label-gm-items = {"**"}Oggetti:{"**"}

## Vista giocatori
config-title-players = {"**"}Configurazione server - Giocatori{"**"}

config-label-player-experience = {"**"}Esperienza giocatore:{"**"} { $status }
config-desc-player-experience = Abilita/Disabilita l'uso dei punti esperienza (o progressione del personaggio basata su valori simili).
config-label-player-experience-disabled = {"**"}Esperienza giocatore:{"**"} Disabilitata

config-label-new-char-settings = {"**"}Impostazioni nuovo personaggio{"**"}
config-desc-new-char-settings = Configura le impostazioni relative ai nuovi personaggi giocante e alla configurazione dei loro inventari iniziali.

config-label-player-board-purge = {"**"}Pulizia bacheca giocatori{"**"}
config-desc-player-board-purge = Elimina i post dalla bacheca giocatori (se abilitata).

## Vista impostazioni nuovo personaggio
config-title-new-character = {"**"}Configurazione server - Impostazioni nuovo personaggio{"**"}

config-label-inventory-type = {"**"}Tipo inventario nuovo personaggio:{"**"} { $type }
config-desc-inventory-type = Determina come i personaggi appena registrati inizializzano i loro inventari.
config-label-inventory-type-disabled = {"**"}Tipo inventario nuovo personaggio:{"**"} Disabilitato

config-label-new-char-wealth = {"**"}Ricchezza nuovo personaggio:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Ricchezza nuovo personaggio:{"**"} Disabilitata

config-label-approval-queue = {"**"}Coda approvazione:{"**"} { $channel }
config-desc-approval-queue = Se impostata, i nuovi personaggi devono essere approvati da un GM in questo canale forum prima di essere attivi.
config-label-approval-queue-disabled = {"**"}Coda approvazione:{"**"} Disabilitata
config-label-approval-queue-not-configured = {"**"}Coda approvazione:{"**"} Non configurata

# Descrizioni tipo inventario (usate nella configurazione)
config-desc-inv-type-disabled = I giocatori iniziano con inventari vuoti.
config-desc-inv-type-selection = I giocatori scelgono liberamente gli oggetti dal negozio nuovo personaggio.
config-desc-inv-type-purchase = I giocatori acquistano oggetti dal negozio nuovo personaggio con una quantità di valuta data.
config-desc-inv-type-open = I giocatori inseriscono manualmente i propri oggetti dell'inventario.
config-desc-inv-type-static = Ai giocatori viene assegnato un inventario iniziale predefinito.

## Vista negozio nuovo personaggio
config-title-new-char-shop = {"**"}Configurazione server - Negozio nuovo personaggio{"**"}
config-label-inv-type-selection = {"**"}Tipo inventario:{"**"} Selezione
config-desc-inv-type-selection-shop = I giocatori scelgono liberamente gli oggetti dal negozio nuovo personaggio.
config-label-inv-type-purchase = {"**"}Tipo inventario:{"**"} Acquisto
config-desc-inv-type-purchase-shop = I giocatori acquistano oggetti dal negozio nuovo personaggio con una quantità di valuta data.
config-label-inv-type-other = {"**"}Tipo inventario:{"**"} { $type }
config-desc-inv-type-not-in-use = Il negozio nuovo personaggio non è in uso.
config-msg-define-shop-items = Definisci gli oggetti del negozio.
config-msg-no-items = Nessun oggetto configurato.

## Vista kit statici
config-title-static-kits = {"**"}Configurazione server - Kit statici{"**"}
config-desc-create-kit = Crea una nuova definizione di kit.
config-msg-no-kits = Nessun kit configurato.
config-label-kit-more-items = ...e altri { $count } oggetti
config-label-empty-kit = {"*"}Kit vuoto{"*"}

## Vista modifica kit statico
config-title-editing-kit = {"**"}Modifica kit: { $kitName }{"**"}
config-msg-kit-empty = Questo kit è vuoto. Usa i pulsanti sopra per aggiungere valuta o oggetti.
config-label-kit-currency = {"**"}Valuta:{"**"} { $display }
config-label-kit-item = {"**"}Oggetto:{"**"} { $name }

## Vista valuta
config-title-currency = {"**"}Configurazione server - Valuta{"**"}
config-desc-create-currency = Crea una nuova valuta.
config-msg-no-currencies = Nessuna valuta configurata.
config-label-currency-display-type = Tipo visualizzazione: { $type } | Denominazioni: { $count }
config-label-currency-type-double = Decimale
config-label-currency-type-integer = Intero

## Vista modifica valuta
config-title-manage-currency = {"**"}Gestisci valuta: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Valuta e denominazioni{"**"}__
    - Il nome assegnato alla tua valuta è considerato la valuta base e ha un valore di 1.
    {"```"}Esempio: "oro" è configurato come valuta.{"```"}
    - Aggiungere una denominazione richiede di specificare un nome e un valore relativo alla valuta base.
    {"```"}Esempio: All'oro vengono assegnate due denominazioni: argento (valore 0.1) e rame (valore 0.01).{"```"}
    - Qualsiasi transazione che coinvolga una valuta base o le sue denominazioni le convertirà automaticamente.
    {"```"}Esempio: Un giocatore ha 10 oro e spende 3 rame. Il suo nuovo saldo mostrerà automaticamente
    9 oro, 9 argento e 7 rame.{"```"}
    - Le valute visualizzate come intero mostreranno ogni denominazione, mentre le valute visualizzate come decimale
    mostreranno solo la valuta base.
    {"```"}Esempio: Il giocatore sopra con visualizzazione decimale attiva mostrerà 9.97 oro.{"```"}
config-btn-toggle-display-current = Cambia visualizzazione (Attuale: { $type })
config-msg-no-denominations = Nessuna denominazione configurata.

## Vista negozi
config-title-shops = {"**"}Configurazione server - Negozi{"**"}
config-desc-add-shop-wizard =
    {"**"}Aggiungi negozio (procedura guidata){"**"}
    Crea un nuovo negozio vuoto da un modulo.
config-desc-add-shop-json =
    {"**"}Aggiungi negozio (JSON){"**"}
    Crea un nuovo negozio fornendo una definizione JSON completa. (Avanzato)
config-btn-example-json = JSON di Esempio
config-desc-example-json =
    {"**"}JSON di Esempio{"**"}
    Scarica un file JSON di esempio che mostra il formato previsto.
config-msg-example-json = Ecco un file JSON di esempio che mostra il formato previsto.
config-msg-no-shops = Nessun negozio configurato.
config-label-shop-type-forum = (Forum)
config-label-shop-channel = Canale: <#{ $channelId }>

## Vista selezione tipo canale negozio
config-title-choose-location = {"**"}Aggiungi negozio - Scegli tipo posizione{"**"}
config-label-text-channel = {"**"}Canale di testo{"**"}
config-desc-text-channel = Crea un negozio in un canale di testo standard.
config-label-forum-thread = {"**"}Thread del forum{"**"}
config-desc-forum-thread = Crea un negozio in un thread del forum (nuovo o esistente).

## Vista configurazione negozio forum
config-title-forum-setup = {"**"}Aggiungi negozio - Configurazione thread del forum{"**"}
config-label-step1 = {"**"}Passo 1: Seleziona un canale forum{"**"}
config-label-step2 = {"**"}Passo 2: Scegli opzione thread{"**"}
config-label-step3 = {"**"}Passo 3: Seleziona un thread esistente{"**"}
config-desc-create-new-thread =
    {"**"}Crea nuovo thread{"**"}
    Apre un modulo per creare un nuovo thread e configurare il negozio.
config-label-selected-thread = {"**"}Thread selezionato:{"**"} { $threadName }
config-desc-click-to-configure = Clicca per configurare il negozio in questo thread.

## Vista gestione negozio
config-title-manage-shop = {"**"}Gestisci negozio: { $shopName }{"**"}
config-label-shop-type = {"**"}Tipo:{"**"} { $type }
config-label-shop-type-text = Canale di testo
config-label-shop-type-forum-thread = Thread del forum
config-label-shopkeeper = {"**"}Negoziante:{"**"} { $name }
config-label-shop-description = {"**"}Descrizione:{"**"} { $description }
config-label-shop-channel-info = {"**"}Canale:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Modifica dettagli e oggetti del negozio tramite procedura guidata.
config-desc-upload-json = Carica una nuova definizione JSON per questo negozio.
config-desc-download-json = Scarica la definizione JSON corrente.
config-desc-remove-shop = Rimuovi permanentemente questo negozio.

## Vista modifica negozio
config-title-editing-shop = {"**"}Modifica negozio: { $shopName }{"**"}
config-label-shop-shopkeeper = Negoziante: {"**"}{ $name }{"**"}

## Vista limiti scorte
config-title-stock-config = {"**"}Configurazione scorte: { $shopName }{"**"}
config-label-current-utc = Ora UTC corrente: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Programma rifornimento:{"**"} { $schedule }
config-label-restock-hourly = al minuto :{ $minute }
config-label-restock-daily = alle { $time } UTC
config-label-restock-weekly = il { $day } alle { $time } UTC
config-label-restock-mode = {"**"}Modalità:{"**"} { $mode }
config-label-restock-full = Rifornimento completo
config-label-restock-incremental = Incrementale (quantità per articolo)
config-label-restock-disabled = {"**"}Programma rifornimento:{"**"} Disabilitato
config-label-item-stock-limits = {"**"}Limiti scorte oggetti{"**"}
config-msg-no-items-in-shop = Nessun oggetto in questo negozio.
config-label-stock-with-available = Max: { $max } | Disponibili: { $available }
config-label-stock-increment = Rifornimento: +{ $increment }/ciclo
config-label-stock-reserved = Riservati: { $reserved }
config-label-stock-not-initialized = Max: { $max } | Disponibili: (non inizializzato)
config-label-stock-unlimited = Scorte: Illimitate

## Vista gioco di ruolo
config-title-roleplay = {"**"}Configurazione server - Ricompense gioco di ruolo{"**"}
config-label-rp-status = {"**"}Stato:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Ora server:{"**"} `{ $time }`
config-label-rp-enabled = Abilitato
config-label-rp-disabled = Disabilitato

config-desc-rp-mode-scheduled = {"```"}Le ricompense vengono distribuite una volta, al raggiungimento della soglia di messaggi idonei richiesti entro il periodo di tempo impostato (ogni ora, giornaliero o settimanale).{"```"}
config-desc-rp-mode-accrued = {"```"}Le ricompense vengono distribuite su base ricorrente ogni volta che viene raggiunto un determinato numero di messaggi idonei.{"```"}

config-label-rp-config-details = {"**"}Dettagli configurazione:{"**"}
config-label-rp-mode = {"**"}Modalità:{"**"} { $mode }
config-label-rp-min-length = {"**"}Lunghezza minima messaggio:{"**"} { $length } caratteri
config-label-rp-cooldown = {"**"}Tempo di attesa:{"**"} { $seconds } secondi
config-label-rp-frequency-once = {"**"}Frequenza:{"**"} Una volta per { $period }
config-label-rp-reset-time = {"**"}Ora di reset:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Soglia:{"**"} { $count } messaggi idonei
config-label-rp-frequency-every = {"**"}Frequenza:{"**"} Ogni { $count } messaggi idonei

config-label-rp-channels = {"**"}Canali gioco di ruolo:{"**"}
config-msg-rp-no-channels = Nessuno configurato.
config-label-rp-channels-more = ...e altri { $count }.

config-label-rp-rewards = {"**"}Ricompense:{"**"}
config-msg-rp-no-rewards = Nessuna configurata.
config-label-rp-experience = {"**"}Esperienza:{"**"} { $xp }
config-label-rp-items = {"**"}Oggetti:{"**"}
config-label-rp-currency = {"**"}Valuta:{"**"}

## Vista lingua
config-title-language = {"**"}Configurazione server - Lingua{"**"}
config-server-language-help =
    Questa impostazione ti permette di specificare la lingua predefinita per le risposte e i messaggi {"**"}pubblici{"**"} di ReQuest in questo server. Le risposte pubbliche includono:
    - Post della bacheca quest e giocatori
    - Riepilogo quest e messaggi nei canali di log
    - Rifornimento negozio
    - Consumo oggetti dei giocatori

    Questa impostazione riguarda solo il testo statico generato dal bot e non traduce contenuti dinamici come nomi di oggetti o descrizioni delle quest inseriti dagli utenti.

    Le risposte personali e i menu non sono influenzati da questa impostazione.
config-label-server-language = {"**"}Lingua del server:{"**"} { $language }
config-label-server-language-default = {"**"}Lingua del server:{"**"} Predefinita (nessuna sostituzione)
config-select-placeholder-server-language = Seleziona lingua del server
config-select-option-default = Predefinita (nessuna sostituzione)
config-select-desc-default = Usa la preferenza di ogni utente o la lingua di Discord.

# Quest Roles
config-btn-quest-roles = Ruoli quest
config-btn-manage-gm-quest-roles = Gestisci

config-modal-title-confirm-quest-role-removal = Conferma rimozione ruolo
config-modal-label-remove-quest-role = Rimuovere { $roleName } da { $gmName }?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Seleziona modalità ruoli quest
config-select-option-quest-role-disabled = Disabilitato
config-select-desc-quest-role-disabled = Nessun ruolo viene creato o assegnato.
config-select-option-quest-role-temporary = Temporaneo
config-select-desc-quest-role-temporary = I GM possono creare ruoli temporanei per quest.
config-select-option-quest-role-static = Statico
config-select-desc-quest-role-static = I GM scelgono tra ruoli del server pre-assegnati.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Assegna ruolo/i del server a questo GM

## Quest Roles View
config-title-quest-roles = {"**"}Configurazione server - Ruoli quest{"**"}

config-label-quest-role-mode-disabled = {"**"}Modalità ruoli quest:{"**"} Disabilitato
    Nessun ruolo viene creato o assegnato durante le quest.
config-label-quest-role-mode-temporary = {"**"}Modalità ruoli quest:{"**"} Temporaneo
    I GM possono opzionalmente creare un ruolo temporaneo durante la creazione della quest.
    Il ruolo viene eliminato quando la quest viene completata o annullata.
config-label-quest-role-mode-static = {"**"}Modalità ruoli quest:{"**"} Statico
    I GM scelgono tra ruoli del server pre-assegnati. I ruoli vengono assegnati
    ai membri del gruppo durante le quest ma non vengono mai eliminati.

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}Configurazione server - Assegnazioni ruoli quest statici{"**"}
config-label-manage-assignments = Gestisci assegnazioni ruoli
config-desc-manage-assignments =
    Assegna ruoli del server esistenti ai GM per l'uso durante le quest.
    I ruoli devono essere inferiori al ruolo più alto di ReQuest nella gerarchia del server.
config-msg-no-gm-members = Nessun membro con ruolo GM trovato su questo server.
config-label-no-roles-assigned = Nessun ruolo quest assegnato
config-label-more-roles = (+{ $count } altri)

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}Gestisci ruoli quest — { $gmName }{"**"}
config-error-unmanageable-roles = I seguenti ruoli non possono essere assegnati perché gestiti da un'integrazione, sono il ruolo predefinito o sono superiori al ruolo più alto di ReQuest: { $roles }
config-error-quest-role-limit = Questo GM ha raggiunto il massimo di { $limit } ruoli quest assegnati.
config-label-quest-role-count = Ruoli assegnati: { $count }/{ $limit }
