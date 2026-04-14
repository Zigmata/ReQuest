## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ Ups!
error-report-description =
    { $exception }

    Jeśli ten błąd jest nieoczekiwany lub podejrzewasz, że bot nie działa prawidłowo, zgłoś błąd na [Oficjalnym Serwerze Discord ReQuest](https://discord.gg/Zq37gj4).

error-report-unexpected =
    Wystąpił nieoczekiwany błąd. Spróbuj ponownie.

    Jeśli to się powtarza, zgłoś błąd na [Oficjalnym Serwerze Discord ReQuest](https://discord.gg/Zq37gj4).

error-invalid-image-url =
    Co najmniej jeden adres URL obrazu jest nieprawidłowy. Discord wymaga pełnego linku zaczynającego się od `http://` lub `https://`, który wskazuje bezpośrednio na obraz (na przykład `https://example.com/banner.png`).

    Edytuj zadanie i podaj prawidłowe adresy URL obrazów lub pozostaw pola puste.
error-invalid-image-url-field = Adres URL pola { $fieldName } jest nieprawidłowy. Podaj pełny link zaczynający się od `http://` lub `https://`, albo pozostaw puste.
error-field-thumbnail = miniatura obrazu
error-field-large-image = duży obraz

# Check failures
error-owner-only = Tylko właściciel bota może używać tej komendy!
error-no-permission = Nie masz uprawnień do uruchomienia tej komendy!
error-no-active-character = Nie masz aktywnej postaci na tym serwerze!
error-no-registered-characters = Nie masz żadnych zarejestrowanych postaci!
error-no-characters = Docelowy gracz nie posiada żadnych zarejestrowanych postaci.
error-no-active-character-target = Docelowy gracz nie ma aktywowanej postaci na tym serwerze.
error-player-not-found = Nie znaleziono danych gracza.
error-character-not-found = Nie znaleziono danych postaci.

# Currency/transaction errors
error-transaction-cannot-complete = Nie można zrealizować transakcji:
    { $reason }
error-insufficient-item-trade = Posiadasz { $owned }x { $itemName }, ale próbujesz przekazać { $quantity }.
error-currency-process-failed = Waluta { $currencyName } nie mogła zostać przetworzona.
error-insufficient-funds-transaction = Niewystarczające środki na pokrycie tej transakcji.
error-insufficient-funds = Niewystarczające środki.
error-insufficient-items = Niewystarczająca ilość przedmiotu(-ów): { $itemName }
error-currency-not-configured = Waluta '{ $currencyName }' nie jest skonfigurowana na tym serwerze.
error-cost-currency-system-mismatch = Waluta kosztu '{ $currencyName }' nie należy do własnego systemu walutowego.
error-currency-config-error = Błąd konfiguracji waluty: wartość nominału wynosi 0 lub jest ujemna.
error-currency-validation = Wystąpił błąd podczas walidacji waluty: { $error }
error-invalid-currency = { $itemName } nie jest prawidłową walutą.
error-insufficient-funds-for-transaction = Niewystarczające środki na tę transakcję.

# Cart errors
error-cart-not-found = Nie znaleziono koszyka.
error-item-not-in-cart = Przedmiot nie znajduje się w koszyku.
error-not-enough-stock = Niewystarczający zapas.

# Container errors
error-container-not-found = Nie znaleziono pojemnika.
error-container-name-empty = Nazwa pojemnika nie może być pusta.
error-container-name-too-long = Nazwa pojemnika nie może przekraczać { $maxLength } znaków.
error-max-containers-reached = Nie możesz utworzyć więcej niż { $maxContainers } pojemników.
error-container-name-exists = Pojemnik o nazwie "{ $containerName }" już istnieje.
error-item-already-in-container = Przedmiot jest już w tym pojemniku.
error-quantity-minimum = Ilość musi wynosić co najmniej 1.
error-source-container-not-found = Nie znaleziono pojemnika źródłowego.
error-item-not-in-source = Przedmiot "{ $itemName }" nie został znaleziony w pojemniku źródłowym.
error-insufficient-quantity-in-container = Niewystarczająca ilość. Posiadasz { $available } w tym pojemniku.
error-dest-container-not-found = Nie znaleziono pojemnika docelowego.
error-item-not-in-container = Przedmiot "{ $itemName }" nie został znaleziony w tym pojemniku.
error-insufficient-quantity-consume = Posiadasz tylko { $available } tego przedmiotu w tym pojemniku.
