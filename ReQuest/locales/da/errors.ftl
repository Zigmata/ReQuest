## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ Ups!
error-report-description =
    Der opstod en fejl:

    ```{ $exception }```

    Hvis denne fejl er uventet, eller du har mistanke om, at botten ikke fungerer korrekt, kan du indsende en fejlrapport i den [Officielle ReQuest Support Discord](https://discord.gg/Zq37gj4).

# Check failures
error-owner-only = Kun bottens ejer kan bruge denne kommando!
error-no-permission = Du har ikke tilladelse til at køre denne kommando!
error-no-active-character = Du har ikke en aktiv karakter på denne server!
error-no-registered-characters = Du har ingen registrerede karakterer!
error-no-characters = Målspilleren har ingen registrerede karakterer.
error-no-active-character-target = Målspilleren har ikke en aktiv karakter på denne server.
error-player-not-found = Spillerdata blev ikke fundet.
error-character-not-found = Karakterdata blev ikke fundet.

# Currency/transaction errors
error-transaction-cannot-complete = Transaktionen kan ikke gennemføres:
    { $reason }
error-insufficient-item-trade = Du har { $owned }x { $itemName }, men forsøger at give { $quantity }.
error-currency-process-failed = Valutaen { $currencyName } kunne ikke behandles.
error-insufficient-funds-transaction = Utilstrækkelige midler til at dække denne transaktion.
error-insufficient-funds = Utilstrækkelige midler.
error-insufficient-items = Utilstrækkelig(e) genstand(e): { $itemName }
error-currency-not-configured = Valutaen '{ $currencyName }' er ikke konfigureret på denne server.
error-cost-currency-system-mismatch = Omkostningsvalutaen '{ $currencyName }' er ikke en del af sit eget valutasystem.
error-currency-config-error = Valutakonfigurationsfejl: 0 eller negativ denominationsværdi.
error-currency-validation = Der opstod en fejl under valutavalidering: { $error }
error-invalid-currency = { $itemName } er ikke en gyldig valuta.
error-insufficient-funds-for-transaction = Utilstrækkelige midler til denne transaktion.

# Cart errors
error-cart-not-found = Indkøbskurv ikke fundet.
error-item-not-in-cart = Genstand ikke i indkøbskurven.
error-not-enough-stock = Ikke nok på lager.

# Container errors
error-container-not-found = Beholder ikke fundet.
error-container-name-empty = Beholdernavnet kan ikke være tomt.
error-container-name-too-long = Beholdernavnet kan ikke overstige { $maxLength } tegn.
error-max-containers-reached = Du kan ikke oprette mere end { $maxContainers } beholdere.
error-container-name-exists = En beholder med navnet "{ $containerName }" findes allerede.
error-item-already-in-container = Genstanden er allerede i denne beholder.
error-quantity-minimum = Antal skal være mindst 1.
error-source-container-not-found = Kildebeholder ikke fundet.
error-item-not-in-source = Genstand "{ $itemName }" blev ikke fundet i kildebeholderen.
error-insufficient-quantity-in-container = Utilstrækkeligt antal. Du har { $available } i denne beholder.
error-dest-container-not-found = Destinationsbeholder ikke fundet.
error-item-not-in-container = Genstand "{ $itemName }" blev ikke fundet i denne beholder.
error-insufficient-quantity-consume = Du har kun { $available } af denne genstand i denne beholder.
