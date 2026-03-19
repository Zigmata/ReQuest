## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ Hoppsan!
error-report-description =
    Ett undantag inträffade:

    ```{ $exception }```

    Om detta fel är oväntat, eller om du misstänker att boten inte fungerar korrekt, skicka gärna en felrapport i [Officiella ReQuest Support Discord](https://discord.gg/Zq37gj4).

# Check failures
error-owner-only = Bara botägaren kan använda detta kommando!
error-no-permission = Du har inte behörighet att köra detta kommando!
error-no-active-character = Du har ingen aktiv karaktär på denna server!
error-no-registered-characters = Du har inga registrerade karaktärer!
error-no-characters = Målspelaren har inga registrerade karaktärer.
error-no-active-character-target = Målspelaren har ingen aktiverad karaktär på denna server.
error-player-not-found = Spelardata hittades inte.
error-character-not-found = Karaktärsdata hittades inte.

# Currency/transaction errors
error-transaction-cannot-complete = Transaktionen kan inte genomföras:
    { $reason }
error-insufficient-item-trade = Du har { $owned }x { $itemName } men försöker ge { $quantity }.
error-currency-process-failed = Valutan { $currencyName } kunde inte bearbetas.
error-insufficient-funds-transaction = Otillräckliga medel för att täcka denna transaktion.
error-insufficient-funds = Otillräckliga medel.
error-insufficient-items = Otillräckligt antal föremål: { $itemName }
error-currency-not-configured = Valutan '{ $currencyName }' är inte konfigurerad på denna server.
error-cost-currency-system-mismatch = Kostnadsvalutan '{ $currencyName }' är inte en del av sitt eget valutasystem.
error-currency-config-error = Valutakonfigurationsfel: 0 eller negativt valörvärde.
error-currency-validation = Ett fel uppstod vid valutavalidering: { $error }
error-invalid-currency = { $itemName } är inte en giltig valuta.
error-insufficient-funds-for-transaction = Otillräckliga medel för denna transaktion.

# Cart errors
error-cart-not-found = Kundvagnen hittades inte.
error-item-not-in-cart = Föremålet finns inte i kundvagnen.
error-not-enough-stock = Inte tillräckligt med lager tillgängligt.

# Container errors
error-container-not-found = Behållaren hittades inte.
error-container-name-empty = Behållarnamnet kan inte vara tomt.
error-container-name-too-long = Behållarnamnet kan inte överstiga { $maxLength } tecken.
error-max-containers-reached = Du kan inte skapa fler än { $maxContainers } behållare.
error-container-name-exists = En behållare med namnet "{ $containerName }" finns redan.
error-item-already-in-container = Föremålet finns redan i denna behållare.
error-quantity-minimum = Antal måste vara minst 1.
error-source-container-not-found = Källbehållaren hittades inte.
error-item-not-in-source = Föremålet "{ $itemName }" hittades inte i källbehållaren.
error-insufficient-quantity-in-container = Otillräckligt antal. Du har { $available } i denna behållare.
error-dest-container-not-found = Målbehållaren hittades inte.
error-item-not-in-container = Föremålet "{ $itemName }" hittades inte i denna behållare.
error-insufficient-quantity-consume = Du har bara { $available } av detta föremål i denna behållare.
