## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ Опа!
error-report-description =
    Възникна изключение:

    ```{ $exception }```

    Ако тази грешка е неочаквана или подозирате, че ботът не функционира правилно, моля подайте доклад за бъг в [Официалния Discord за поддръжка на ReQuest](https://discord.gg/Zq37gj4).

# Check failures
error-owner-only = Само собственикът на бота може да използва тази команда!
error-no-permission = Нямате права да изпълните тази команда!
error-no-active-character = Нямате активен персонаж на този сървър!
error-no-registered-characters = Нямате регистрирани персонажи!
error-no-characters = Целевият играч няма регистрирани персонажи.
error-no-active-character-target = Целевият играч няма активиран персонаж на този сървър.
error-player-not-found = Данните за играча не са намерени.
error-character-not-found = Данните за персонажа не са намерени.

# Currency/transaction errors
error-transaction-cannot-complete = Транзакцията не може да бъде завършена:
    { $reason }
error-insufficient-item-trade = Имате { $owned }x { $itemName }, но се опитвате да дадете { $quantity }.
error-currency-process-failed = Валутата { $currencyName } не може да бъде обработена.
error-insufficient-funds-transaction = Недостатъчни средства за покриване на тази транзакция.
error-insufficient-funds = Недостатъчни средства.
error-insufficient-items = Недостатъчно предмет(и): { $itemName }
error-currency-not-configured = Валутата '{ $currencyName }' не е конфигурирана на този сървър.
error-cost-currency-system-mismatch = Валутата за цена '{ $currencyName }' не е част от собствената си валутна система.
error-currency-config-error = Грешка в конфигурацията на валутата: стойност на деноминацията е 0 или отрицателна.
error-currency-validation = Възникна грешка при валидация на валутата: { $error }
error-invalid-currency = { $itemName } не е валидна валута.
error-insufficient-funds-for-transaction = Недостатъчни средства за тази транзакция.

# Cart errors
error-cart-not-found = Кошницата не е намерена.
error-item-not-in-cart = Предметът не е в кошницата.
error-not-enough-stock = Няма достатъчна наличност.

# Container errors
error-container-not-found = Контейнерът не е намерен.
error-container-name-empty = Името на контейнера не може да бъде празно.
error-container-name-too-long = Името на контейнера не може да надвишава { $maxLength } символа.
error-max-containers-reached = Не можете да създадете повече от { $maxContainers } контейнера.
error-container-name-exists = Контейнер с име "{ $containerName }" вече съществува.
error-item-already-in-container = Предметът вече е в този контейнер.
error-quantity-minimum = Количеството трябва да е поне 1.
error-source-container-not-found = Контейнерът-източник не е намерен.
error-item-not-in-source = Предметът "{ $itemName }" не е намерен в контейнера-източник.
error-insufficient-quantity-in-container = Недостатъчно количество. Имате { $available } в този контейнер.
error-dest-container-not-found = Контейнерът-получател не е намерен.
error-item-not-in-container = Предметът "{ $itemName }" не е намерен в този контейнер.
error-insufficient-quantity-consume = Имате само { $available } от този предмет в този контейнер.
