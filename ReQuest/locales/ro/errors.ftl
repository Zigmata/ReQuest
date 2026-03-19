## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ Ups!
error-report-description =
    A apărut o excepție:

    ```{ $exception }```

    Dacă această eroare este neașteptată sau suspectați că botul nu funcționează corect, vă rugăm să trimiteți un raport de eroare în [Discordul Oficial de Suport ReQuest](https://discord.gg/Zq37gj4).

# Check failures
error-owner-only = Doar proprietarul botului poate folosi această comandă!
error-no-permission = Nu aveți permisiunea de a rula această comandă!
error-no-active-character = Nu aveți un personaj activ pe acest server!
error-no-registered-characters = Nu aveți niciun personaj înregistrat!
error-no-characters = Jucătorul vizat nu are niciun personaj înregistrat.
error-no-active-character-target = Jucătorul vizat nu are un personaj activat pe acest server.
error-player-not-found = Datele jucătorului nu au fost găsite.
error-character-not-found = Datele personajului nu au fost găsite.

# Currency/transaction errors
error-transaction-cannot-complete = Tranzacția nu poate fi finalizată:
    { $reason }
error-insufficient-item-trade = Aveți { $owned }x { $itemName } dar încercați să dați { $quantity }.
error-currency-process-failed = Moneda { $currencyName } nu a putut fi procesată.
error-insufficient-funds-transaction = Fonduri insuficiente pentru a acoperi această tranzacție.
error-insufficient-funds = Fonduri insuficiente.
error-insufficient-items = Obiect(e) insuficient(e): { $itemName }
error-currency-not-configured = Moneda „{ $currencyName }" nu este configurată pe acest server.
error-cost-currency-system-mismatch = Moneda de cost „{ $currencyName }" nu face parte din propriul sistem monetar.
error-currency-config-error = Eroare de configurare a monedei: valoare de denominație 0 sau negativă.
error-currency-validation = A apărut o eroare la validarea monedei: { $error }
error-invalid-currency = { $itemName } nu este o monedă validă.
error-insufficient-funds-for-transaction = Fonduri insuficiente pentru această tranzacție.

# Cart errors
error-cart-not-found = Coșul nu a fost găsit.
error-item-not-in-cart = Obiectul nu este în coș.
error-not-enough-stock = Stoc insuficient disponibil.

# Container errors
error-container-not-found = Containerul nu a fost găsit.
error-container-name-empty = Numele containerului nu poate fi gol.
error-container-name-too-long = Numele containerului nu poate depăși { $maxLength } caractere.
error-max-containers-reached = Nu puteți crea mai mult de { $maxContainers } containere.
error-container-name-exists = Un container cu numele „{ $containerName }" există deja.
error-item-already-in-container = Obiectul se află deja în acest container.
error-quantity-minimum = Cantitatea trebuie să fie cel puțin 1.
error-source-container-not-found = Containerul sursă nu a fost găsit.
error-item-not-in-source = Obiectul „{ $itemName }" nu a fost găsit în containerul sursă.
error-insufficient-quantity-in-container = Cantitate insuficientă. Aveți { $available } în acest container.
error-dest-container-not-found = Containerul destinație nu a fost găsit.
error-item-not-in-container = Obiectul „{ $itemName }" nu a fost găsit în acest container.
error-insufficient-quantity-consume = Aveți doar { $available } din acest obiect în acest container.
