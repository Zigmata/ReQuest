## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ Oops!
error-report-description =
    Det oppstod en feil:

    ```{ $exception }```

    Hvis denne feilen er uventet, eller du mistenker at boten ikke fungerer riktig, vennligst send en feilrapport i den [offisielle ReQuest Support Discord](https://discord.gg/Zq37gj4).

# Check failures
error-owner-only = Bare boteieren kan bruke denne kommandoen!
error-no-permission = Du har ikke tillatelse til å kjøre denne kommandoen!
error-no-active-character = Du har ingen aktiv karakter på denne serveren!
error-no-registered-characters = Du har ingen registrerte karakterer!
error-no-characters = Målspilleren har ingen registrerte karakterer.
error-no-active-character-target = Målspilleren har ingen aktivert karakter på denne serveren.
error-player-not-found = Spillerdata ikke funnet.
error-character-not-found = Karakterdata ikke funnet.

# Currency/transaction errors
error-transaction-cannot-complete = Transaksjonen kan ikke fullføres:
    { $reason }
error-insufficient-item-trade = Du har { $owned }x { $itemName }, men prøver å gi { $quantity }.
error-currency-process-failed = Valutaen { $currencyName } kunne ikke behandles.
error-insufficient-funds-transaction = Ikke nok midler til å dekke denne transaksjonen.
error-insufficient-funds = Ikke nok midler.
error-insufficient-items = Ikke nok gjenstand(er): { $itemName }
error-currency-not-configured = Valutaen '{ $currencyName }' er ikke konfigurert på denne serveren.
error-cost-currency-system-mismatch = Kostvalutaen '{ $currencyName }' er ikke en del av sitt eget valutasystem.
error-currency-config-error = Valutakonfigurasjonsfeil: 0 eller negativ verdi for valør.
error-currency-validation = Det oppstod en feil under valutavalidering: { $error }
error-invalid-currency = { $itemName } er ikke en gyldig valuta.
error-insufficient-funds-for-transaction = Ikke nok midler for denne transaksjonen.

# Cart errors
error-cart-not-found = Handlekurv ikke funnet.
error-item-not-in-cart = Gjenstanden er ikke i handlekurven.
error-not-enough-stock = Ikke nok lager tilgjengelig.

# Container errors
error-container-not-found = Beholder ikke funnet.
error-container-name-empty = Beholdernavn kan ikke være tomt.
error-container-name-too-long = Beholdernavn kan ikke overstige { $maxLength } tegn.
error-max-containers-reached = Du kan ikke opprette mer enn { $maxContainers } beholdere.
error-container-name-exists = En beholder med navnet "{ $containerName }" eksisterer allerede.
error-item-already-in-container = Gjenstanden er allerede i denne beholderen.
error-quantity-minimum = Antall må være minst 1.
error-source-container-not-found = Kildebeholder ikke funnet.
error-item-not-in-source = Gjenstanden "{ $itemName }" ble ikke funnet i kildebeholderen.
error-insufficient-quantity-in-container = Ikke nok antall. Du har { $available } i denne beholderen.
error-dest-container-not-found = Målbeholder ikke funnet.
error-item-not-in-container = Gjenstanden "{ $itemName }" ble ikke funnet i denne beholderen.
error-insufficient-quantity-consume = Du har bare { $available } av denne gjenstanden i denne beholderen.
