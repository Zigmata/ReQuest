## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ Oeps!
error-report-description =
    { $exception }

    Als deze fout onverwacht is, of als je vermoedt dat de bot niet correct werkt, dien dan een bugrapport in op de [Officiële ReQuest Support Discord](https://discord.gg/Zq37gj4).

error-report-unexpected =
    Er is een onverwachte fout opgetreden. Probeer het opnieuw.

    Als dit blijft gebeuren, dien dan een bugrapport in op de [Officiële ReQuest Support Discord](https://discord.gg/Zq37gj4).

# Check failures
error-owner-only = Alleen de bot-eigenaar kan dit commando gebruiken!
error-no-permission = Je hebt geen toestemming om dit commando uit te voeren!
error-no-active-character = Je hebt geen actief personage op deze server!
error-no-registered-characters = Je hebt geen geregistreerde personages!
error-no-characters = De doelspeler heeft geen geregistreerde personages.
error-no-active-character-target = De doelspeler heeft geen geactiveerd personage op deze server.
error-player-not-found = Spelergegevens niet gevonden.
error-character-not-found = Personagegegevens niet gevonden.

# Currency/transaction errors
error-transaction-cannot-complete = De transactie kan niet worden voltooid:
    { $reason }
error-insufficient-item-trade = Je hebt { $owned }x { $itemName } maar probeert { $quantity } te geven.
error-currency-process-failed = Valuta { $currencyName } kon niet worden verwerkt.
error-insufficient-funds-transaction = Onvoldoende saldo om deze transactie te dekken.
error-insufficient-funds = Onvoldoende saldo.
error-insufficient-items = Onvoldoende voorwerp(en): { $itemName }
error-currency-not-configured = Valuta '{ $currencyName }' is niet geconfigureerd op deze server.
error-cost-currency-system-mismatch = Kostenvaluta '{ $currencyName }' maakt geen deel uit van het eigen valutasysteem.
error-currency-config-error = Valutaconfiguratiefout: waarde van 0 of negatieve denominatie.
error-currency-validation = Er is een fout opgetreden tijdens valutavalidatie: { $error }
error-invalid-currency = { $itemName } is geen geldige valuta.
error-insufficient-funds-for-transaction = Onvoldoende saldo voor deze transactie.

# Cart errors
error-cart-not-found = Winkelwagen niet gevonden.
error-item-not-in-cart = Voorwerp zit niet in de winkelwagen.
error-not-enough-stock = Niet genoeg voorraad beschikbaar.

# Container errors
error-container-not-found = Container niet gevonden.
error-container-name-empty = Containernaam mag niet leeg zijn.
error-container-name-too-long = Containernaam mag niet langer zijn dan { $maxLength } tekens.
error-max-containers-reached = Je kunt niet meer dan { $maxContainers } containers aanmaken.
error-container-name-exists = Een container met de naam "{ $containerName }" bestaat al.
error-item-already-in-container = Voorwerp zit al in deze container.
error-quantity-minimum = Hoeveelheid moet minimaal 1 zijn.
error-source-container-not-found = Broncontainer niet gevonden.
error-item-not-in-source = Voorwerp "{ $itemName }" niet gevonden in de broncontainer.
error-insufficient-quantity-in-container = Onvoldoende hoeveelheid. Je hebt { $available } in deze container.
error-dest-container-not-found = Doelcontainer niet gevonden.
error-item-not-in-container = Voorwerp "{ $itemName }" niet gevonden in deze container.
error-insufficient-quantity-consume = Je hebt slechts { $available } van dit voorwerp in deze container.
