## Строки ошибок и неудачных проверок

# Обёртка встраиваемого сообщения об ошибке
error-oops-title = ⚠️ Ой!
error-report-description =
    { $exception }

    Если эта ошибка неожиданная или вы подозреваете, что бот работает некорректно, отправьте отчёт об ошибке в [Официальный Discord поддержки ReQuest](https://discord.gg/Zq37gj4).

error-report-unexpected =
    Произошла непредвиденная ошибка. Пожалуйста, попробуйте ещё раз.

    Если это повторяется, отправьте отчёт об ошибке в [Официальный Discord поддержки ReQuest](https://discord.gg/Zq37gj4).

error-invalid-image-url =
    Один или несколько URL изображений недействительны. Discord требует полную ссылку, начинающуюся с `http://` или `https://`, которая ведёт напрямую на изображение (например, `https://example.com/banner.png`).

    Пожалуйста, отредактируйте квест и укажите действительные URL изображений или оставьте поля пустыми.
error-invalid-image-url-field = URL поля { $fieldName } недействителен. Укажите полную ссылку, начинающуюся с `http://` или `https://`, или оставьте поле пустым.
error-field-thumbnail = миниатюра
error-field-large-image = большое изображение

# Ошибки проверок
error-owner-only = Только владелец бота может использовать эту команду!
error-no-permission = У вас нет прав для выполнения этой команды!
error-no-active-character = У вас нет активного персонажа на этом сервере!
error-no-registered-characters = У вас нет зарегистрированных персонажей!
error-no-characters = У указанного игрока нет зарегистрированных персонажей.
error-no-active-character-target = У указанного игрока нет активного персонажа на этом сервере.
error-player-not-found = Данные игрока не найдены.
error-character-not-found = Данные персонажа не найдены.

# Ошибки валюты/транзакций
error-transaction-cannot-complete = Транзакция не может быть завершена:
    { $reason }
error-insufficient-item-trade = У вас { $owned }x { $itemName }, но вы пытаетесь отдать { $quantity }.
error-currency-process-failed = Не удалось обработать валюту { $currencyName }.
error-insufficient-funds-transaction = Недостаточно средств для этой транзакции.
error-insufficient-funds = Недостаточно средств.
error-insufficient-items = Недостаточно предмета(ов): { $itemName }
error-currency-not-configured = Валюта '{ $currencyName }' не настроена на этом сервере.
error-cost-currency-system-mismatch = Валюта стоимости '{ $currencyName }' не является частью своей валютной системы.
error-currency-config-error = Ошибка конфигурации валюты: нулевое или отрицательное значение номинала.
error-currency-validation = Произошла ошибка при проверке валюты: { $error }
error-invalid-currency = { $itemName } не является допустимой валютой.
error-insufficient-funds-for-transaction = Недостаточно средств для этой транзакции.

# Ошибки корзины
error-cart-not-found = Корзина не найдена.
error-item-not-in-cart = Предмет не в корзине.
error-not-enough-stock = Недостаточно товара на складе.

# Ошибки контейнеров
error-container-not-found = Контейнер не найден.
error-container-name-empty = Имя контейнера не может быть пустым.
error-container-name-too-long = Имя контейнера не может превышать { $maxLength } символов.
error-max-containers-reached = Вы не можете создать более { $maxContainers } контейнеров.
error-container-name-exists = Контейнер с именем "{ $containerName }" уже существует.
error-item-already-in-container = Предмет уже находится в этом контейнере.
error-quantity-minimum = Количество должно быть не менее 1.
error-source-container-not-found = Контейнер-источник не найден.
error-item-not-in-source = Предмет "{ $itemName }" не найден в контейнере-источнике.
error-insufficient-quantity-in-container = Недостаточное количество. У вас { $available } в этом контейнере.
error-dest-container-not-found = Контейнер-назначение не найден.
error-item-not-in-container = Предмет "{ $itemName }" не найден в этом контейнере.
error-insufficient-quantity-consume = У вас только { $available } этого предмета в этом контейнере.
