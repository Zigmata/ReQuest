## Stringhe del modulo giocatore

# --- Cog ---

player-cmd-name = Scambio
player-cmd-desc = Menu giocatore

# --- Pulsanti ---

# Gestione personaggi
player-btn-register-character = Registra nuovo personaggio
player-btn-activate = Attiva
player-btn-active = Attivo

# Bacheca giocatori
player-btn-create-post = Crea post
player-btn-open-starting-shop = Apri negozio iniziale
player-btn-select-kit = Seleziona kit
player-btn-input-inventory = Inserisci inventario

# Pulsanti procedura guidata / negozio
player-btn-add-to-cart = Aggiungi al carrello
player-btn-add-to-cart-cost = Aggiungi al carrello ({ $costString })
player-btn-view-purchase-options = Visualizza opzioni di acquisto
player-btn-review-submit = Rivedi e invia ({ $count })
player-btn-submit-character = Invia personaggio
player-btn-keep-shopping = Continua lo shopping
player-btn-edit-quantity = Modifica quantità
player-btn-clear-cart = Svuota carrello

# Pulsanti kit
player-btn-confirm-selection = Conferma selezione
player-btn-back-to-kits = Torna ai kit

# Gestione inventario
player-btn-spend-currency = Spendi valuta
player-btn-print-inventory = Stampa inventario

# Gestione contenitori
player-btn-manage-containers = Gestisci contenitori
player-btn-create-new = + Crea nuovo
player-btn-consume-destroy = Consuma/Distruggi
player-btn-move = Sposta
player-btn-move-all = Sposta tutto
player-btn-move-some = Sposta alcuni...
player-btn-back-to-overview = ← Torna alla panoramica
player-btn-cancel-move = ← Annulla
player-btn-up = ▲ Su
player-btn-down = ▼ Giù

# --- Modali ---

# Modale scambio
player-modal-title-trade = Scambio con { $targetName }
player-modal-label-trade-name = Nome
player-modal-placeholder-trade-name = Inserisci il nome dell'oggetto che stai scambiando
player-modal-label-trade-quantity = Quantità
player-modal-placeholder-trade-quantity = Inserisci la quantità che stai scambiando

# Modale registrazione personaggio
player-modal-title-register = Registra nuovo personaggio
player-modal-label-char-name = Nome
player-modal-placeholder-char-name = Inserisci il nome del tuo personaggio.
player-modal-label-char-note = Nota
player-modal-placeholder-char-note = Inserisci una nota per identificare il tuo personaggio

# Modale input inventario aperto
player-modal-title-starting-inventory = Inserimento inventario iniziale
player-modal-label-inventory = Inventario
player-modal-placeholder-inventory-input =
    Uno per riga nel formato <nome>: <quantità>, es.:
    Spada: 1
    oro: 30

# Modale spesa valuta
player-modal-title-spend-currency = Spendi valuta
player-modal-label-currency-name = Nome valuta
player-modal-placeholder-currency-name = Inserisci il nome della valuta che stai spendendo
player-modal-label-currency-amount = Importo
player-modal-placeholder-currency-amount = Inserisci l'importo da spendere

# Modale creazione post giocatore
player-modal-title-create-post = Crea post nella bacheca giocatori
player-modal-label-post-title = Titolo
player-modal-placeholder-post-title = Inserisci un titolo per il tuo post
player-modal-label-post-content = Contenuto del post
player-modal-placeholder-post-content = Inserisci il corpo del tuo post

# Modale modifica post giocatore
player-modal-title-edit-post = Modifica post nella bacheca giocatori

# Modale modifica quantità carrello nella procedura guidata
player-modal-title-edit-cart-qty = Modifica quantità nel carrello
player-modal-label-cart-qty = Quantità
player-modal-placeholder-cart-qty = Inserisci la nuova quantità (0 per rimuovere)

# Modale creazione contenitore
player-modal-title-create-container = Crea nuovo contenitore
player-modal-label-container-name = Nome contenitore
player-modal-placeholder-container-name = Inserisci un nome per il tuo contenitore (es., Zaino)

# Modale rinomina contenitore
player-modal-title-rename-container = Rinomina contenitore
player-modal-label-new-container-name = Nuovo nome contenitore
player-modal-placeholder-new-container-name = Inserisci il nuovo nome

# Modale consumo da contenitore
player-modal-title-consume = Consuma/Distruggi oggetto
player-modal-label-consume-qty = Quantità (max: { $maxQuantity })
player-modal-placeholder-consume-qty = Inserisci la quantità da consumare/distruggere

# Modale quantità spostamento oggetto
player-modal-title-move-item = Sposta oggetto
player-modal-label-move-qty = Quantità da spostare (max: { $maxQuantity })
player-modal-placeholder-move-qty = Inserisci la quantità da spostare

# --- Selettori ---

player-select-placeholder-no-characters = Non hai personaggi registrati
player-select-placeholder-remove-character = Seleziona un personaggio da rimuovere
player-select-placeholder-post = Seleziona un post
player-select-placeholder-container-view = Seleziona un contenitore da visualizzare...
player-select-placeholder-item = Seleziona un oggetto...
player-select-placeholder-destination = Seleziona destinazione...
player-select-placeholder-container = Seleziona un contenitore...
player-select-option-no-containers = Nessun contenitore
player-select-option-no-items = Nessun oggetto
player-select-option-no-destinations = Nessuna destinazione

# --- Viste ---

# PlayerBaseView - Menu principale
player-title-main-menu = {"**"}Comandi giocatore - Menu principale{"**"}
player-menu-btn-characters = Personaggi
player-menu-desc-characters = Registra, visualizza e attiva personaggi giocante.
player-menu-btn-inventory = Inventario
player-menu-desc-inventory = Visualizza l'inventario del tuo personaggio attivo e spendi valuta.
player-menu-btn-player-board = Bacheca giocatori
player-menu-btn-player-board-disabled = Bacheca giocatori (non configurata)
player-menu-desc-player-board = Crea un post per la bacheca giocatori

# CharacterBaseView
player-title-characters = {"**"}Comandi giocatore - Personaggi{"**"}
player-desc-register-character = Registra un nuovo personaggio.
player-msg-no-characters = Non hai personaggi registrati.
player-label-active = (Attivo)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Personaggio in corso: { $characterName }{"**"}
    La registrazione del tuo personaggio è in attesa della configurazione dell'inventario.
player-btn-resume = Riprendi
player-btn-discard = Scarta
player-modal-title-discard-character = Scarta personaggio
player-modal-label-discard-confirm = Scartare { $characterName }?

# Conferma rimozione personaggio
player-modal-title-confirm-char-removal = Conferma rimozione personaggio
player-modal-label-confirm-char-delete = Eliminare { $characterName }?

# Conferma rimozione post
player-modal-title-confirm-post-removal = Conferma rimozione post
player-modal-label-post-removal-warning = ATTENZIONE: Questa azione è irreversibile!

# InventoryOverviewView
player-title-inventory = {"**"}Comandi giocatore - Inventario{"**"}
player-title-char-inventory = {"**"}Inventario di { $characterName }{"**"}
player-msg-no-active-character = Nessun personaggio attivo: attiva un personaggio per questo server per usare questi menu.
player-msg-no-characters-registered = Nessun personaggio: registra un personaggio per usare questi menu.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } oggetti
player-label-currency = {"**"}Valuta{"**"}
player-msg-inventory-empty = L'inventario è vuoto.

# Embed stampa inventario
player-embed-title-inventory = Inventario di { $characterName }

# ContainerItemsView
player-msg-container-empty = Questo contenitore è vuoto.
player-label-selected-item = Selezionato: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Sposta "{ $itemName }"{"**"} ({ $available } disponibili)
player-msg-no-other-containers = Nessun altro contenitore disponibile.
player-msg-select-destination = Seleziona il contenitore di destinazione:
player-label-destination = Destinazione: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Gestisci contenitori{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } oggetti){ $suffix }
player-label-default-suffix = { " " }(predefinito)
player-msg-no-containers = Nessun contenitore.
player-label-selected-container = Selezionato: {"**"}{ $containerName }{"**"}

# Conferma eliminazione contenitore
player-modal-title-confirm-container-delete = Conferma eliminazione contenitore
player-modal-label-container-has-items = Contiene { $itemCount } oggetti. Verranno spostati in Oggetti sparsi.
player-modal-label-confirm-container-delete = Eliminare "{ $containerName }"?

# Errori contenitore
player-error-cannot-rename-loose = Impossibile rinominare Oggetti sparsi.
player-error-cannot-delete-loose = Impossibile eliminare Oggetti sparsi.

# PlayerBoardView
player-title-player-board = {"**"}Comandi giocatore - Bacheca giocatori{"**"}
player-desc-create-post = Crea un nuovo post per la bacheca giocatori.
player-msg-no-posts = Non hai post attivi.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Autore
player-embed-footer-post-id = ID Post: { $postId }
player-error-board-channel-not-found = Canale della bacheca giocatori non trovato.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Configura inventario per { $characterName }{"**"}
player-desc-browse-shop = Sfoglia il negozio iniziale per equipaggiare il tuo personaggio.
player-desc-select-kit = Seleziona un kit iniziale.
player-desc-input-inventory = Inserisci manualmente il tuo inventario iniziale.

# StaticKitSelectView
player-title-select-kit = {"**"}Seleziona un kit per { $characterName }{"**"}
player-msg-no-kits = Nessun kit iniziale disponibile.
player-label-and-more-items = ...e altri { $count } oggetti
player-label-empty-kit = {"*"}Kit vuoto{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Conferma selezione: { $kitName }{"**"}
player-label-items-heading = {"**"}Oggetti:{"**"}
player-label-currency-heading = {"**"}Valuta:{"**"}
player-msg-kit-empty = Questo kit è vuoto.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Opzioni di acquisto: { $itemName }{"**"}
player-msg-no-cost-options = Questo oggetto non ha opzioni di costo disponibili.
player-label-cost-option = {"**"}Opzione { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Negozio iniziale ({ $inventoryType }){"**"}
player-label-starting-wealth = Ricchezza iniziale: { $formattedCurrency }
player-label-in-cart = {"**"}(Nel carrello: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Rivedi carrello{"**"}
player-msg-cart-empty = Il tuo carrello è vuoto.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Totale: { $totalQuantity })
player-label-insufficient-currency = { $currencyName } insufficiente
player-label-total-cost = {"**"}Costo totale:{"**"}
player-label-total-cost-free = {"**"}Costo totale:{"**"} Gratis
player-label-cart-page = Pagina { $current } di { $total }

# Embed scambio
player-embed-title-trade = Report scambio
player-embed-desc-trade-sender = Mittente: { $senderMention } come `{ $senderCharacter }`
player-embed-desc-trade-recipient = Destinatario: { $recipientMention } come `{ $recipientCharacter }`
player-embed-field-currency = Valuta
player-embed-field-amount = Importo
player-embed-field-balance = Saldo di { $characterName }
player-embed-field-item = Oggetto
player-embed-field-quantity = Quantità
player-embed-footer-transaction-id = ID Transazione: { $transactionId }

# Errori scambio
player-error-trade-no-characters = Il giocatore con cui stai cercando di scambiare non ha personaggi!
player-error-trade-no-active = Il giocatore con cui stai cercando di scambiare non ha un personaggio attivo su questo server!

# Embed spesa valuta
player-embed-title-spend = Report transazione giocatore
player-embed-desc-spend-player = Giocatore: { $playerMention } come `{ $characterName }`
player-embed-desc-spend-transaction = Transazione: {"**"}{ $characterName }{"**"} ha speso {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Canale
player-embed-field-receipt = Ricevuta

# Errori spesa valuta
player-error-amount-not-number = L'importo deve essere un numero.
player-error-amount-positive = Devi spendere un importo positivo.
player-error-amount-exceeds-maximum = L'importo non può superare { $max }.
player-error-no-active-character-server = Non hai un personaggio attivo su questo server.
player-error-no-currency-config = Nessuna configurazione valutaria trovata per questo server.

# Embed consumo oggetto
player-embed-title-consume = Report consumo oggetto
player-embed-desc-consume = Giocatore: { $playerMention } come `{ $characterName }`
player-embed-desc-consume-removed = Rimosso: {"**"}{ $quantity }x { $itemName }{"**"} da {"**"}{ $containerName }{"**"}

# Errori consumo oggetto
player-error-qty-positive-integer = La quantità deve essere un intero positivo.
player-error-qty-at-least-one = La quantità deve essere almeno 1.
player-error-qty-only-have = Hai solo { $maxQuantity } di questo oggetto.

# Errori input inventario
player-error-invalid-format = Formato non valido: "{ $line }". Usa <nome>: <quantità>.
player-error-empty-name = Il nome dell'oggetto non può essere vuoto nella riga: "{ $line }".
player-error-invalid-quantity = Quantità non valida per "{ $name }": "{ $quantity }". Deve essere un intero positivo.
player-error-input-errors-header = Errori nell'input dell'inventario:
player-msg-no-valid-items = Nessun oggetto valido fornito. Inizializzazione con inventario vuoto.

# Validation error view
player-validation-error-title = Errori di input
player-validation-btn-retry = Riprova

# Validazione quantità carrello
player-error-enter-valid-number = Inserisci un numero positivo valido.

# Embed di invio (coda approvazione)
player-embed-title-approval = Approvazione inventario: { $characterName }
player-embed-desc-submitted-by = Inviato da { $userMention }
player-embed-field-items = Oggetti
player-embed-field-currency-received = Valuta
player-embed-footer-submission-id = ID Richiesta: { $submissionId }
player-label-approval-thread = Approvazione: { $characterName }
player-embed-title-submission-sent = Richiesta inventario inviata
player-embed-desc-submission-sent =
    La tua richiesta per {"**"}{ $characterName }{"**"} è stata inviata al team GM per l'approvazione!
    Riceverai una notifica quando sarà stata esaminata.
    [Visualizza thread della richiesta]({ $threadUrl })

# Embed applicazione diretta (senza coda approvazione)
player-embed-title-starting-inventory = Inventario iniziale applicato
player-embed-desc-starting-inventory = Giocatore: { $playerMention } come `{ $characterName }`
player-embed-field-items-received = Oggetti ricevuti
player-embed-field-currency-received-label = Valuta ricevuta
player-label-untitled = Senza titolo

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventory Submission: { $characterName }{"**"}
    Submitted by { $userMention }
player-approval-post-items = Oggetti
player-approval-post-currency = Valuta
player-approval-resolved = Questa richiesta è stata risolta.
player-approval-btn-approve = Approva
player-approval-btn-deny = Rifiuta
player-approval-btn-edit = Modifica
player-approval-error-no-permission = Non hai il permesso per eseguire questa azione.
player-approval-error-not-submitter = Solo il mittente originale può modificare questa richiesta.
player-approval-thread-instructions =
    This thread was created for the approval of {"**"}{ $characterName }{"**"}.
    A Game Master will review the submission and approve or deny it.
    Once approved or denied, this thread will be locked.

    {"**"}Game Masters:{"**"} Discuss any required changes with your
    player until the inventory is in an acceptable state. Only use
    the `Deny` button for irreconcilable submissions.

    { $playerMention }: Use the `Edit` button to make any changes
    requested here by a Game Master.
player-approval-approved-by = Questa richiesta è stata approvata da { $approver }.
player-approval-denied-by = Questa richiesta è stata rifiutata da { $denier }.
player-approval-deny-reason = Motivo: { $reason }
player-msg-submission-updated = La tua richiesta è stata aggiornata.


# Denial modal
player-modal-title-deny-reason = Rifiuta richiesta
player-modal-label-deny-reason = Motivo del rifiuto
player-modal-placeholder-deny-reason = Opzionale: spiega il motivo del rifiuto
# Approval DM notifications
player-dm-title-approved = Personaggio approvato
player-dm-desc-approved =
    Your character {"**"}{ $characterName }{"**"} has been approved
    by { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Personaggio rifiutato
player-dm-desc-denied =
    Your character {"**"}{ $characterName }{"**"} has been denied
    by { $denier } in {"**"}{ $guildName }{"**"}.
