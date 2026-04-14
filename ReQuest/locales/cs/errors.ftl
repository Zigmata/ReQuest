## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ Jejda!
error-report-description =
    { $exception }

    Pokud je tato chyba neočekávaná nebo máte podezření, že bot nefunguje správně, odešlete hlášení o chybě v [Oficiálním Discord serveru podpory ReQuest](https://discord.gg/Zq37gj4).

error-report-unexpected =
    Došlo k neočekávané chybě. Zkuste to prosím znovu.

    Pokud se to opakuje, odešlete hlášení o chybě v [Oficiálním Discord serveru podpory ReQuest](https://discord.gg/Zq37gj4).

error-invalid-image-url =
    Jedna nebo více URL adres obrázků je neplatná. Discord vyžaduje úplný odkaz začínající na `http://` nebo `https://`, který směřuje přímo na obrázek (například `https://example.com/banner.png`).

    Upravte prosím questu a zadejte platné URL adresy obrázků, nebo pole ponechte prázdná.
error-invalid-image-url-field = URL adresa pole { $fieldName } je neplatná. Zadejte prosím úplný odkaz začínající na `http://` nebo `https://`, nebo jej ponechte prázdný.
error-field-thumbnail = náhled obrázku
error-field-large-image = velký obrázek

# Check failures
error-owner-only = Tento příkaz může použít pouze vlastník bota!
error-no-permission = Nemáte oprávnění ke spuštění tohoto příkazu!
error-no-active-character = Na tomto serveru nemáte aktivní postavu!
error-no-registered-characters = Nemáte žádné zaregistrované postavy!
error-no-characters = Cílový hráč nemá žádné zaregistrované postavy.
error-no-active-character-target = Cílový hráč nemá na tomto serveru aktivovanou postavu.
error-player-not-found = Data hráče nebyla nalezena.
error-character-not-found = Data postavy nebyla nalezena.

# Currency/transaction errors
error-transaction-cannot-complete = Transakci nelze dokončit:
    { $reason }
error-insufficient-item-trade = Máte { $owned }x { $itemName }, ale pokoušíte se dát { $quantity }.
error-currency-process-failed = Měnu { $currencyName } nebylo možné zpracovat.
error-insufficient-funds-transaction = Nedostatečné prostředky k pokrytí této transakce.
error-insufficient-funds = Nedostatečné prostředky.
error-insufficient-items = Nedostatečné množství předmětu(ů): { $itemName }
error-currency-not-configured = Měna „{ $currencyName }" není na tomto serveru nakonfigurována.
error-cost-currency-system-mismatch = Měna nákladů „{ $currencyName }" není součástí svého vlastního měnového systému.
error-currency-config-error = Chyba konfigurace měny: 0 nebo záporná hodnota nominální hodnoty.
error-currency-validation = Při ověřování měny došlo k chybě: { $error }
error-invalid-currency = { $itemName } není platná měna.
error-insufficient-funds-for-transaction = Nedostatečné prostředky pro tuto transakci.

# Cart errors
error-cart-not-found = Košík nebyl nalezen.
error-item-not-in-cart = Předmět není v košíku.
error-not-enough-stock = Nedostatečné zásoby.

# Container errors
error-container-not-found = Kontejner nebyl nalezen.
error-container-name-empty = Název kontejneru nemůže být prázdný.
error-container-name-too-long = Název kontejneru nesmí přesáhnout { $maxLength } znaků.
error-max-containers-reached = Nemůžete vytvořit více než { $maxContainers } kontejnerů.
error-container-name-exists = Kontejner s názvem „{ $containerName }" již existuje.
error-item-already-in-container = Předmět je již v tomto kontejneru.
error-quantity-minimum = Množství musí být alespoň 1.
error-source-container-not-found = Zdrojový kontejner nebyl nalezen.
error-item-not-in-source = Předmět „{ $itemName }" nebyl nalezen ve zdrojovém kontejneru.
error-insufficient-quantity-in-container = Nedostatečné množství. V tomto kontejneru máte { $available }.
error-dest-container-not-found = Cílový kontejner nebyl nalezen.
error-item-not-in-container = Předmět „{ $itemName }" nebyl nalezen v tomto kontejneru.
error-insufficient-quantity-consume = V tomto kontejneru máte pouze { $available } tohoto předmětu.
