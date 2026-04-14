## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ Hoppá!
error-report-description =
    { $exception }

    Ha ez a hiba váratlan, vagy úgy gondolod, hogy a bot nem működik megfelelően, kérjük, küldj hibajelentést a [Hivatalos ReQuest Discord szerveren](https://discord.gg/Zq37gj4).

error-report-unexpected =
    Váratlan hiba történt. Kérjük, próbáld újra.

    Ha ez továbbra is előfordul, kérjük, küldj hibajelentést a [Hivatalos ReQuest Discord szerveren](https://discord.gg/Zq37gj4).

error-invalid-image-url =
    Egy vagy több kép-URL érvénytelen. A Discord olyan teljes hivatkozást igényel, amely `http://` vagy `https://` előtaggal kezdődik, és közvetlenül egy képre mutat (például: `https://example.com/banner.png`).

    Kérjük, szerkeszd a küldetést és adj meg érvényes kép-URL-eket, vagy hagyd üresen a mezőket.
error-invalid-image-url-field = A { $fieldName } URL érvénytelen. Kérjük, adj meg egy teljes hivatkozást, amely `http://` vagy `https://` előtaggal kezdődik, vagy hagyd üresen.
error-field-thumbnail = bélyegkép
error-field-large-image = nagy kép

# Check failures
error-owner-only = Csak a bot tulajdonosa használhatja ezt a parancsot!
error-no-permission = Nincs jogosultságod ennek a parancsnak a futtatásához!
error-no-active-character = Nincs aktív karaktered ezen a szerveren!
error-no-registered-characters = Nincs regisztrált karaktered!
error-no-characters = A célzott játékosnak nincsenek regisztrált karakterei.
error-no-active-character-target = A célzott játékosnak nincs aktivált karaktere ezen a szerveren.
error-player-not-found = A játékos adatai nem találhatók.
error-character-not-found = A karakter adatai nem találhatók.

# Currency/transaction errors
error-transaction-cannot-complete = A tranzakció nem teljesíthető:
    { $reason }
error-insufficient-item-trade = { $owned }x { $itemName } van nálad, de { $quantity } darabot próbálsz adni.
error-currency-process-failed = A(z) { $currencyName } valutát nem sikerült feldolgozni.
error-insufficient-funds-transaction = Nincs elegendő fedezet a tranzakció fedezésére.
error-insufficient-funds = Nincs elegendő fedezet.
error-insufficient-items = Nincs elegendő tárgy: { $itemName }
error-currency-not-configured = A(z) '{ $currencyName }' valuta nincs konfigurálva ezen a szerveren.
error-cost-currency-system-mismatch = A(z) '{ $currencyName }' költségvaluta nem része a saját valutarendszerének.
error-currency-config-error = Valutakonfigurációs hiba: 0 vagy negatív címletérték.
error-currency-validation = Hiba történt a valuta ellenőrzése során: { $error }
error-invalid-currency = A(z) { $itemName } nem érvényes valuta.
error-insufficient-funds-for-transaction = Nincs elegendő fedezet ehhez a tranzakcióhoz.

# Cart errors
error-cart-not-found = Kosár nem található.
error-item-not-in-cart = A tárgy nincs a kosárban.
error-not-enough-stock = Nincs elegendő készlet.

# Container errors
error-container-not-found = Tároló nem található.
error-container-name-empty = A tároló neve nem lehet üres.
error-container-name-too-long = A tároló neve nem haladhatja meg a(z) { $maxLength } karaktert.
error-max-containers-reached = Nem hozhatsz létre { $maxContainers }-nál/nél több tárolót.
error-container-name-exists = Már létezik egy „{ $containerName }" nevű tároló.
error-item-already-in-container = A tárgy már ebben a tárolóban van.
error-quantity-minimum = A mennyiségnek legalább 1-nek kell lennie.
error-source-container-not-found = Forrástároló nem található.
error-item-not-in-source = A(z) „{ $itemName }" tárgy nem található a forrástárolóban.
error-insufficient-quantity-in-container = Nem elegendő mennyiség. { $available } darab van ebben a tárolóban.
error-dest-container-not-found = Céltároló nem található.
error-item-not-in-container = A(z) „{ $itemName }" tárgy nem található ebben a tárolóban.
error-insufficient-quantity-consume = Csak { $available } darab van ebből a tárgyból ebben a tárolóban.
