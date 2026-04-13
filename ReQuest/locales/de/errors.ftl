## Fehler- und Prüfungsmeldungen

# Fehler-Einbettung
error-oops-title = ⚠️ Hoppla!
error-report-description =
    { $exception }

    Wenn dieser Fehler unerwartet ist oder Sie vermuten, dass der Bot nicht korrekt funktioniert, reichen Sie bitte einen Fehlerbericht im [Offiziellen ReQuest Support Discord](https://discord.gg/Zq37gj4) ein.

error-report-unexpected =
    Ein unerwarteter Fehler ist aufgetreten. Bitte versuche es erneut.

    Wenn dies weiterhin passiert, reiche bitte einen Fehlerbericht im [Offiziellen ReQuest Support Discord](https://discord.gg/Zq37gj4) ein.

# Prüfungsfehler
error-owner-only = Nur der Bot-Eigentümer kann diesen Befehl verwenden!
error-no-permission = Sie haben keine Berechtigung, diesen Befehl auszuführen!
error-no-active-character = Sie haben keinen aktiven Charakter auf diesem Server!
error-no-registered-characters = Sie haben keine registrierten Charaktere!
error-no-characters = Der Zielspieler hat keine registrierten Charaktere.
error-no-active-character-target = Der Zielspieler hat keinen aktiven Charakter auf diesem Server.
error-player-not-found = Spielerdaten nicht gefunden.
error-character-not-found = Charakterdaten nicht gefunden.

# Währungs-/Transaktionsfehler
error-transaction-cannot-complete = Die Transaktion kann nicht abgeschlossen werden:
    { $reason }
error-insufficient-item-trade = Sie besitzen { $owned }x { $itemName }, versuchen aber { $quantity } zu geben.
error-currency-process-failed = Währung { $currencyName } konnte nicht verarbeitet werden.
error-insufficient-funds-transaction = Unzureichendes Guthaben für diese Transaktion.
error-insufficient-funds = Unzureichendes Guthaben.
error-insufficient-items = Unzureichende(r) Gegenstand/Gegenstände: { $itemName }
error-currency-not-configured = Währung '{ $currencyName }' ist auf diesem Server nicht konfiguriert.
error-cost-currency-system-mismatch = Kostenwährung '{ $currencyName }' gehört nicht zum eigenen Währungssystem.
error-currency-config-error = Währungskonfigurationsfehler: 0 oder negativer Nennwert.
error-currency-validation = Bei der Währungsvalidierung ist ein Fehler aufgetreten: { $error }
error-invalid-currency = { $itemName } ist keine gültige Währung.
error-insufficient-funds-for-transaction = Unzureichendes Guthaben für diese Transaktion.

# Warenkorbfehler
error-cart-not-found = Warenkorb nicht gefunden.
error-item-not-in-cart = Gegenstand nicht im Warenkorb.
error-not-enough-stock = Nicht genügend Bestand verfügbar.

# Behälterfehler
error-container-not-found = Behälter nicht gefunden.
error-container-name-empty = Der Behältername darf nicht leer sein.
error-container-name-too-long = Der Behältername darf { $maxLength } Zeichen nicht überschreiten.
error-max-containers-reached = Sie können nicht mehr als { $maxContainers } Behälter erstellen.
error-container-name-exists = Ein Behälter mit dem Namen "{ $containerName }" existiert bereits.
error-item-already-in-container = Der Gegenstand befindet sich bereits in diesem Behälter.
error-quantity-minimum = Die Menge muss mindestens 1 betragen.
error-source-container-not-found = Quellbehälter nicht gefunden.
error-item-not-in-source = Gegenstand "{ $itemName }" im Quellbehälter nicht gefunden.
error-insufficient-quantity-in-container = Unzureichende Menge. Sie haben { $available } in diesem Behälter.
error-dest-container-not-found = Zielbehälter nicht gefunden.
error-item-not-in-container = Gegenstand "{ $itemName }" in diesem Behälter nicht gefunden.
error-insufficient-quantity-consume = Sie haben nur { $available } von diesem Gegenstand in diesem Behälter.
