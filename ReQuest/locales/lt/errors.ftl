## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ Oi!
error-report-description =
    Įvyko klaida:

    ```{ $exception }```

    Jei ši klaida netikėta arba įtariate, kad botas veikia netinkamai, pateikite pranešimą apie klaidą [Oficialiame ReQuest palaikymo Discord](https://discord.gg/Zq37gj4).

# Check failures
error-owner-only = Tik boto savininkas gali naudoti šią komandą!
error-no-permission = Jūs neturite leidimų vykdyti šios komandos!
error-no-active-character = Jūs neturite aktyvaus personažo šiame serveryje!
error-no-registered-characters = Jūs neturite jokių užregistruotų personažų!
error-no-characters = Paskirtas žaidėjas neturi jokių užregistruotų personažų.
error-no-active-character-target = Paskirtas žaidėjas neturi aktyvuoto personažo šiame serveryje.
error-player-not-found = Žaidėjo duomenys nerasti.
error-character-not-found = Personažo duomenys nerasti.

# Currency/transaction errors
error-transaction-cannot-complete = Sandorio negalima užbaigti:
    { $reason }
error-insufficient-item-trade = Turite { $owned }x { $itemName }, bet bandote atiduoti { $quantity }.
error-currency-process-failed = Valiutos { $currencyName } apdoroti nepavyko.
error-insufficient-funds-transaction = Nepakanka lėšų šiam sandoriui padengti.
error-insufficient-funds = Nepakanka lėšų.
error-insufficient-items = Nepakanka daikto (-ų): { $itemName }
error-currency-not-configured = Valiuta „{ $currencyName }" šiame serveryje nėra sukonfigūruota.
error-cost-currency-system-mismatch = Kainos valiuta „{ $currencyName }" nepriklauso savo pačios valiutų sistemai.
error-currency-config-error = Valiutos konfigūracijos klaida: 0 arba neigiama nominalo reikšmė.
error-currency-validation = Įvyko klaida tikrinant valiutą: { $error }
error-invalid-currency = { $itemName } nėra galiojanti valiuta.
error-insufficient-funds-for-transaction = Nepakanka lėšų šiam sandoriui.

# Cart errors
error-cart-not-found = Krepšelis nerastas.
error-item-not-in-cart = Daikto nėra krepšelyje.
error-not-enough-stock = Nepakankamas atsargų kiekis.

# Container errors
error-container-not-found = Konteineris nerastas.
error-container-name-empty = Konteinerio pavadinimas negali būti tuščias.
error-container-name-too-long = Konteinerio pavadinimas negali viršyti { $maxLength } simbolių.
error-max-containers-reached = Negalite sukurti daugiau nei { $maxContainers } konteinerių.
error-container-name-exists = Konteineris pavadinimu „{ $containerName }" jau egzistuoja.
error-item-already-in-container = Daiktas jau yra šiame konteineryje.
error-quantity-minimum = Kiekis turi būti bent 1.
error-source-container-not-found = Šaltinio konteineris nerastas.
error-item-not-in-source = Daiktas „{ $itemName }" nerastas šaltinio konteineryje.
error-insufficient-quantity-in-container = Nepakankamas kiekis. Šiame konteineryje turite { $available }.
error-dest-container-not-found = Paskirties konteineris nerastas.
error-item-not-in-container = Daiktas „{ $itemName }" nerastas šiame konteineryje.
error-insufficient-quantity-consume = Šiame konteineryje turite tik { $available } šio daikto.
