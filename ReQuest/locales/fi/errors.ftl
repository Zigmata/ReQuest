## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ Hups!
error-report-description =
    Tapahtui poikkeus:

    ```{ $exception }```

    Jos tämä virhe on odottamaton tai epäilet, ettei botti toimi oikein, lähetä vikailmoitus [virallisessa ReQuest-tuki-Discordissa](https://discord.gg/Zq37gj4).

# Check failures
error-owner-only = Vain botin omistaja voi käyttää tätä komentoa!
error-no-permission = Sinulla ei ole oikeuksia suorittaa tätä komentoa!
error-no-active-character = Sinulla ei ole aktiivista hahmoa tällä palvelimella!
error-no-registered-characters = Sinulla ei ole rekisteröityjä hahmoja!
error-no-characters = Kohdepelaajalla ei ole rekisteröityjä hahmoja.
error-no-active-character-target = Kohdepelaajalla ei ole aktivoitua hahmoa tällä palvelimella.
error-player-not-found = Pelaajatietoja ei löytynyt.
error-character-not-found = Hahmotietoja ei löytynyt.

# Currency/transaction errors
error-transaction-cannot-complete = Tapahtumaa ei voida suorittaa:
    { $reason }
error-insufficient-item-trade = Sinulla on { $owned }x { $itemName }, mutta yrität antaa { $quantity }.
error-currency-process-failed = Valuuttaa { $currencyName } ei voitu käsitellä.
error-insufficient-funds-transaction = Varat eivät riitä tähän tapahtumaan.
error-insufficient-funds = Varat eivät riitä.
error-insufficient-items = Esineitä ei ole riittävästi: { $itemName }
error-currency-not-configured = Valuuttaa '{ $currencyName }' ei ole määritetty tälle palvelimelle.
error-cost-currency-system-mismatch = Hintavaluutta '{ $currencyName }' ei kuulu omaan valuuttajärjestelmäänsä.
error-currency-config-error = Valuuttamääritysvirhe: 0 tai negatiivinen nimellisarvo.
error-currency-validation = Valuutan validoinnissa tapahtui virhe: { $error }
error-invalid-currency = { $itemName } ei ole kelvollinen valuutta.
error-insufficient-funds-for-transaction = Varat eivät riitä tähän tapahtumaan.

# Cart errors
error-cart-not-found = Ostoskoria ei löytynyt.
error-item-not-in-cart = Esine ei ole ostoskorissa.
error-not-enough-stock = Varastoa ei ole riittävästi.

# Container errors
error-container-not-found = Säiliötä ei löytynyt.
error-container-name-empty = Säiliön nimi ei voi olla tyhjä.
error-container-name-too-long = Säiliön nimi ei voi ylittää { $maxLength } merkkiä.
error-max-containers-reached = Et voi luoda enempää kuin { $maxContainers } säiliötä.
error-container-name-exists = Säiliö nimeltä "{ $containerName }" on jo olemassa.
error-item-already-in-container = Esine on jo tässä säiliössä.
error-quantity-minimum = Määrän on oltava vähintään 1.
error-source-container-not-found = Lähdesäiliötä ei löytynyt.
error-item-not-in-source = Esinettä "{ $itemName }" ei löytynyt lähdesäiliöstä.
error-insufficient-quantity-in-container = Määrä ei riitä. Sinulla on { $available } tässä säiliössä.
error-dest-container-not-found = Kohdesäiliötä ei löytynyt.
error-item-not-in-container = Esinettä "{ $itemName }" ei löytynyt tästä säiliöstä.
error-insufficient-quantity-consume = Sinulla on vain { $available } tätä esinettä tässä säiliössä.
