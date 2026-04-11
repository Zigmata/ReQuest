## Stringhe di errore e fallimenti dei controlli

# Wrapper embed errore
error-oops-title = ⚠️ Ops!
error-report-description =
    Si è verificata un'eccezione:

    ```{ $exception }```

    Se questo errore è inaspettato, o sospetti che il bot non funzioni correttamente, invia una segnalazione nel [Discord ufficiale di supporto di ReQuest](https://discord.gg/Zq37gj4).

# Fallimenti dei controlli
error-owner-only = Solo il proprietario del bot può usare questo comando!
error-no-permission = Non hai i permessi per eseguire questo comando!
error-no-active-character = Non hai un personaggio attivo su questo server!
error-no-registered-characters = Non hai personaggi registrati!
error-no-characters = Il giocatore indicato non ha personaggi registrati.
error-no-active-character-target = Il giocatore indicato non ha un personaggio attivato su questo server.
error-player-not-found = Dati del giocatore non trovati.
error-character-not-found = Dati del personaggio non trovati.

# Errori di valuta/transazione
error-transaction-cannot-complete = La transazione non può essere completata:
    { $reason }
error-insufficient-item-trade = Possiedi { $owned }x { $itemName } ma stai cercando di cederne { $quantity }.
error-currency-process-failed = La valuta { $currencyName } non è stata elaborata correttamente.
error-insufficient-funds-transaction = Fondi insufficienti per coprire questa transazione.
error-insufficient-funds = Fondi insufficienti.
error-insufficient-items = Oggetto/i insufficiente/i: { $itemName }
error-currency-not-configured = La valuta '{ $currencyName }' non è configurata su questo server.
error-cost-currency-system-mismatch = La valuta di costo '{ $currencyName }' non fa parte del proprio sistema valutario.
error-currency-config-error = Errore di configurazione della valuta: valore di denominazione 0 o negativo.
error-currency-validation = Si è verificato un errore durante la validazione della valuta: { $error }
error-invalid-currency = { $itemName } non è una valuta valida.
error-insufficient-funds-for-transaction = Fondi insufficienti per questa transazione.

# Errori del carrello
error-cart-not-found = Carrello non trovato.
error-item-not-in-cart = Oggetto non presente nel carrello.
error-not-enough-stock = Scorte insufficienti.

# Errori dei contenitori
error-container-not-found = Contenitore non trovato.
error-container-name-empty = Il nome del contenitore non può essere vuoto.
error-container-name-too-long = Il nome del contenitore non può superare { $maxLength } caratteri.
error-max-containers-reached = Non puoi creare più di { $maxContainers } contenitori.
error-container-name-exists = Un contenitore chiamato "{ $containerName }" esiste già.
error-item-already-in-container = L'oggetto è già in questo contenitore.
error-quantity-minimum = La quantità deve essere almeno 1.
error-source-container-not-found = Contenitore di origine non trovato.
error-item-not-in-source = Oggetto "{ $itemName }" non trovato nel contenitore di origine.
error-insufficient-quantity-in-container = Quantità insufficiente. Ne hai { $available } in questo contenitore.
error-dest-container-not-found = Contenitore di destinazione non trovato.
error-item-not-in-container = Oggetto "{ $itemName }" non trovato in questo contenitore.
error-insufficient-quantity-consume = Hai solo { $available } di questo oggetto in questo contenitore.
