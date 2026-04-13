## Рядки помилок та невдалих перевірок

# Обгортка вбудованого повідомлення помилки
error-oops-title = ⚠️ Ой!
error-report-description =
    { $exception }

    Якщо ця помилка несподівана або ви підозрюєте, що бот працює некоректно, будь ласка, повідомте про помилку в [Офіційному Discord підтримки ReQuest](https://discord.gg/Zq37gj4).

error-report-unexpected =
    Виникла непередбачена помилка. Будь ласка, спробуйте ще раз.

    Якщо це повторюється, будь ласка, повідомте про помилку в [Офіційному Discord підтримки ReQuest](https://discord.gg/Zq37gj4).

# Невдалі перевірки
error-owner-only = Тільки власник бота може використовувати цю команду!
error-no-permission = У вас немає прав для виконання цієї команди!
error-no-active-character = У вас немає активного персонажа на цьому сервері!
error-no-registered-characters = У вас немає зареєстрованих персонажів!
error-no-characters = У цільового гравця немає зареєстрованих персонажів.
error-no-active-character-target = У цільового гравця немає активованого персонажа на цьому сервері.
error-player-not-found = Дані гравця не знайдено.
error-character-not-found = Дані персонажа не знайдено.

# Помилки валюти/транзакцій
error-transaction-cannot-complete = Транзакцію неможливо завершити:
    { $reason }
error-insufficient-item-trade = У вас є { $owned }x { $itemName }, але ви намагаєтесь віддати { $quantity }.
error-currency-process-failed = Валюту { $currencyName } не вдалося обробити.
error-insufficient-funds-transaction = Недостатньо коштів для покриття цієї транзакції.
error-insufficient-funds = Недостатньо коштів.
error-insufficient-items = Недостатньо предметів: { $itemName }
error-currency-not-configured = Валюта '{ $currencyName }' не налаштована на цьому сервері.
error-cost-currency-system-mismatch = Валюта вартості '{ $currencyName }' не є частиною власної валютної системи.
error-currency-config-error = Помилка конфігурації валюти: нульове або від'ємне значення номіналу.
error-currency-validation = Виникла помилка під час перевірки валюти: { $error }
error-invalid-currency = { $itemName } не є дійсною валютою.
error-insufficient-funds-for-transaction = Недостатньо коштів для цієї транзакції.

# Помилки кошика
error-cart-not-found = Кошик не знайдено.
error-item-not-in-cart = Предмет не в кошику.
error-not-enough-stock = Недостатньо товару на складі.

# Помилки контейнерів
error-container-not-found = Контейнер не знайдено.
error-container-name-empty = Назва контейнера не може бути порожньою.
error-container-name-too-long = Назва контейнера не може перевищувати { $maxLength } символів.
error-max-containers-reached = Ви не можете створити більше ніж { $maxContainers } контейнерів.
error-container-name-exists = Контейнер з назвою "{ $containerName }" вже існує.
error-item-already-in-container = Предмет вже знаходиться в цьому контейнері.
error-quantity-minimum = Кількість має бути не менше 1.
error-source-container-not-found = Контейнер-джерело не знайдено.
error-item-not-in-source = Предмет "{ $itemName }" не знайдено у контейнері-джерелі.
error-insufficient-quantity-in-container = Недостатня кількість. У цьому контейнері у вас { $available }.
error-dest-container-not-found = Контейнер призначення не знайдено.
error-item-not-in-container = Предмет "{ $itemName }" не знайдено в цьому контейнері.
error-insufficient-quantity-consume = У вас лише { $available } цього предмета в цьому контейнері.
