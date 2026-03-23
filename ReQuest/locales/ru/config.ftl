## Строки модуля настройки

# ==========================================
# КНОПКИ
# ==========================================

# Роли
config-btn-clear = Очистить
config-btn-remove-gm-roles = Удалить роли GM
config-btn-forbidden-roles = Запрещённые роли

# Квесты
config-btn-toggle-quest-summary = Переключить итог квеста
config-btn-toggle-player-experience = Переключить опыт игроков
config-btn-toggle-display = Переключить отображение
config-btn-purge-player-board = Очистить доску игроков
config-btn-add-modify-rewards = Добавить/Изменить награды

# Валюта
config-btn-add-denomination = Добавить номинал
config-btn-add-new-currency = Добавить новую валюту
config-btn-remove-currency = Удалить валюту

# Магазины - создание
config-btn-add-shop-wizard = Добавить магазин (Мастер)
config-btn-add-shop-json = Добавить магазин (JSON)
config-btn-edit-shop-wizard = Редактировать магазин (Мастер)
config-btn-edit-shop-json = Редактировать магазин (JSON)
config-btn-remove-shop = Удалить магазин
config-btn-add-item = Добавить предмет
config-btn-edit-shop-details = Редактировать данные магазина
config-btn-download-json = Скачать JSON
config-btn-done-editing = Готово
config-btn-scan-server-configs = Сканировать настройки сервера
config-btn-re-scan = Повторное сканирование

# Магазин нового персонажа
config-btn-upload-json = Загрузить JSON
config-btn-configure-new-character-wealth = Настроить начальное богатство
config-btn-configure-new-character-shop = Настроить магазин нового персонажа
config-btn-clear-shop = Очистить магазин
config-btn-configure-static-kits = Настроить стартовые наборы
config-btn-new-character-settings = Настройки нового персонажа
config-btn-disabled-no-currency = Отключено (Валюта не настроена)
config-btn-disabled-no-wealth = Отключено (Начальное богатство не настроено)

# Стартовые наборы
config-btn-create-new-kit = Создать новый набор
config-btn-delete-kit = Удалить набор
config-btn-add-currency = Добавить валюту

# Ролевая игра
config-btn-toggle-rp-rewards = Переключить награды за RP
config-btn-clear-channels = Очистить каналы
config-btn-edit-settings = Изменить настройки
config-btn-configure-rewards = Настроить награды

# Запасы
config-btn-stock-limits = Лимиты запасов
config-btn-set-limit = Установить лимит
config-btn-edit-limit = Изменить лимит
config-btn-remove-limit = Удалить лимит
config-btn-configure-restock-schedule = Настроить расписание пополнения
config-btn-back-to-shop-editor = Назад к редактору магазина

# Форумный магазин
config-btn-create-new-thread = Создать новую тему
config-btn-use-existing-thread = Использовать существующую тему

# Мастер настройки
config-btn-quit = Выход
config-btn-configure-channels = Настроить каналы
config-btn-configure-roles = Настроить роли
config-btn-configure-quests = Настроить квесты
config-btn-configure-players = Настроить игроков
config-btn-configure-currency = Настроить валюту
config-btn-configure-rp-rewards = Настроить награды за RP
config-btn-configure-shops = Настроить магазины
config-btn-new-char-setup = Настройка нового персонажа

# Заголовки модальных окон подтверждения (передаются в общее ConfirmModal)
config-modal-title-confirm-role-removal = Подтверждение удаления роли
config-modal-title-confirm-removal = Подтверждение удаления
config-modal-title-confirm-currency-removal = Подтверждение удаления валюты
config-modal-title-confirm-shop-removal = Подтверждение удаления магазина
config-modal-title-confirm-kit-deletion = Подтверждение удаления набора
config-modal-title-confirm-remove-stock-limit = Подтверждение удаления лимита запасов
config-modal-title-clear-shop = Подтвердите очистку магазина

# Метки модальных окон подтверждения
config-modal-label-remove-role = Удалить { $roleName }?
config-modal-label-remove-denomination = Удалить { $denominationName }?
config-modal-label-remove-currency = Удалить { $currencyName }?
config-modal-label-shop-removal-warning = ВНИМАНИЕ: Это действие необратимо!
config-modal-label-kit-deletion-warning = ВНИМАНИЕ: Необратимо!
config-modal-label-remove-stock-limit = Введите CONFIRM для удаления лимита запасов
config-modal-label-clear-shop = Очистить все предметы из этого магазина?

# Сообщения об ошибках кнопок
config-error-shop-data-not-found = Ошибка: Не удалось найти данные этого магазина.
config-msg-shop-json-download = Вот JSON-определение для {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Вот JSON-определение для магазина нового персонажа.
config-error-select-forum-first = Сначала выберите форумный канал.
config-error-select-thread-first = Сначала выберите тему.

# ==========================================
# МОДАЛЬНЫЕ ОКНА
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Добавить новую валюту
config-modal-label-currency-name = Название валюты
config-error-currency-already-exists = Валюта или номинал с именем { $name } уже существует!

# RenameCurrencyModal
config-modal-title-rename-currency = Переименовать валюту
config-modal-label-new-currency-name = Новое название валюты
config-error-currency-name-exists = Валюта с именем "{ $name }" уже существует.
config-error-denomination-name-exists = Номинал с именем "{ $name }" уже существует.

# RenameDenominationModal
config-modal-title-rename-denomination = Переименовать номинал
config-modal-label-new-denomination-name = Новое название номинала

# AddCurrencyDenominationModal
config-modal-title-add-denomination = Добавить номинал { $currencyName }
config-modal-label-denomination-name = Название
config-modal-placeholder-denomination-name = Например: Серебро
config-modal-label-denomination-value = Значение
config-modal-placeholder-denomination-value = Например: 0.1
config-error-denomination-matches-currency = Название нового номинала не может совпадать с существующей валютой на этом сервере! Найдена существующая валюта с именем "{ $existingName }".
config-error-denomination-matches-denomination = Название нового номинала не может совпадать с существующим номиналом на этом сервере! Найден существующий номинал "{ $denominationName }" в валюте "{ $currencyName }".
config-error-denomination-value-exists = Номиналы одной валюты должны иметь уникальные значения! { $denominationName } уже имеет это значение.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Запрещённые названия ролей
config-modal-label-names = Названия
config-modal-placeholder-names = Введите названия через запятую
config-msg-forbidden-roles-updated = Запрещённые роли обновлены!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Очистка доски игроков
config-modal-label-age = Возраст
config-modal-placeholder-age = Введите максимальный возраст постов (в днях) для сохранения
config-msg-posts-purged = Посты старше { $days } дней были удалены!

# GMRewardsModal
config-modal-title-gm-rewards = Добавить/Изменить награды GM
config-modal-label-experience = Опыт
config-modal-placeholder-enter-number = Введите число
config-modal-label-items = Предметы
config-modal-placeholder-items =
    Название: Количество
    Название2: Количество
    и т.д.
config-error-experience-invalid = Опыт должен быть целым числом (например, 2000).
config-error-item-format-invalid = Неверный формат предмета: "{ $item }". Каждый предмет должен быть на отдельной строке в формате "Название: Количество".

# ConfigShopDetailsModal
config-modal-title-shop-details = Добавить/Редактировать данные магазина
config-modal-label-shop-channel = Выберите канал
config-modal-placeholder-shop-channel = Выберите канал для этого магазина
config-modal-label-shop-name = Название магазина
config-modal-placeholder-shop-name = Введите название магазина
config-modal-label-shopkeeper-name = Имя торговца
config-modal-placeholder-shopkeeper-name = Введите имя торговца
config-modal-label-shop-description = Описание магазина
config-modal-placeholder-shop-description = Введите описание магазина
config-modal-label-shop-image-url = URL изображения магазина
config-modal-placeholder-shop-image-url = Введите URL изображения магазина
config-error-no-channel-selected = Канал для магазина не выбран.
config-error-shop-already-in-channel = В выбранном канале уже зарегистрирован магазин. Выберите другой канал или отредактируйте существующий магазин.

# build_shop_header_view
config-label-shopkeeper = {"**"}Торговец:{"**"} { $name }
config-msg-use-shop-command = Используйте команду `/shop` для просмотра и покупки предметов.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Создание магазина в теме форума
config-modal-label-thread-name = Название темы
config-modal-placeholder-thread-name = Введите название темы для магазина
config-error-forum-not-found = Не удалось найти выбранный форумный канал.
config-error-shop-already-in-thread = В этой теме уже зарегистрирован магазин. Это не должно происходить для новой темы.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Добавить магазин через JSON
config-modal-label-upload-json = Загрузите файл .json с данными магазина
config-error-no-json-uploaded = JSON-файл для магазина не загружен.
config-error-file-must-be-json = Загруженный файл должен быть JSON-файлом (.json).
config-error-invalid-json = Неверный формат JSON: { $error }
config-error-json-validation-failed = JSON не соответствует схеме: { $error }

# ShopItemModal
config-modal-title-shop-item = Добавить/Редактировать предмет магазина
config-modal-label-item-name = Название предмета
config-modal-placeholder-item-name = Введите название предмета
config-modal-label-item-description = Описание предмета
config-modal-placeholder-item-description = Введите описание предмета
config-modal-label-item-quantity = Количество предмета
config-modal-placeholder-item-quantity = Введите количество, продаваемое за покупку
config-modal-label-item-costs = Стоимость предмета
config-modal-placeholder-item-costs = Напр.: 10 gold + 5 silver\nИЛИ: 50 rep\n(Используйте + для И, Новые строки для ИЛИ)
config-error-item-quantity-positive = Количество предмета должно быть положительным целым числом.
config-error-cost-format-invalid = Неверный формат стоимости в варианте: "{ $option }". Каждая стоимость должна содержать сумму и валюту, разделённые пробелом, например "10 gold".
config-error-cost-amount-invalid = Неверная сумма "{ $amount }" для валюты: "{ $currency }". Сумма должна быть положительным числом.
config-error-unknown-currency = Неизвестная валюта `{ $currency }`. Используйте валюту, настроенную для этого сервера.
config-error-item-already-exists = Предмет с именем { $itemName } уже существует в этом магазине.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Обновить магазин через JSON
config-modal-label-upload-new-json = Загрузите новое JSON-определение
config-error-no-file-uploaded = Файл не был загружен.
config-error-file-must-be-json-ext = Файл должен быть в формате `.json`.
config-error-json-validation-message = Ошибка валидации JSON: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Добавить/Редактировать снаряжение нового персонажа
config-modal-placeholder-item-quantity-selection = Введите количество, получаемое за выбор
config-modal-label-item-cost = Стоимость предмета
config-error-cost-format-short = Неверный формат стоимости: '{ $component }'. Ожидается 'Сумма Валюта'.
config-error-amount-invalid-short = Неверная сумма '{ $amount }' для валюты '{ $currency }'.
config-error-item-exists-new-char = Предмет с именем { $itemName } уже существует в магазине нового персонажа.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Загрузить магазин нового персонажа (JSON)
config-error-no-json-uploaded-short = JSON-файл не загружен.
config-error-json-must-have-shopstock = JSON должен содержать массив 'shopStock'.
config-error-items-must-have-name-price = Все предметы должны иметь 'name' и 'price'.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Установить начальное богатство
config-modal-label-amount = Сумма
config-modal-placeholder-amount = Введите количество этой валюты.
config-modal-placeholder-currency-name = Введите название валюты, настроенной на этом сервере
config-error-no-currencies-configured = На этом сервере не настроены валюты.
config-error-currency-not-found = Валюта или номинал с именем { $name } не найдены. Используйте допустимую валюту.

# CreateStaticKitModal
config-modal-title-create-kit = Создать новый стартовый набор
config-modal-label-kit-name = Название набора
config-modal-placeholder-kit-name = Напр.: Стартовый набор воина
config-modal-label-description = Описание
config-modal-placeholder-kit-description = Необязательное описание набора
config-error-kit-name-exists = Стартовый набор с именем "{ $kitName }" уже существует. Выберите другое название.

# StaticKitItemModal
config-modal-title-kit-item = Добавить/Редактировать предмет набора
config-modal-placeholder-kit-item-quantity = Введите количество этого предмета в наборе

# StaticKitCurrencyModal
config-modal-title-kit-currency = Добавить валюту в набор
config-modal-placeholder-currency-eg = Напр.: Золото
config-modal-placeholder-amount-eg = Напр.: 100
config-error-amount-must-be-number = Сумма должна быть числом.
config-error-no-currencies-on-server = На сервере не настроены валюты.
config-error-currency-not-found-short = Валюта "{ $currency }" не найдена.
config-error-denomination-not-found = Номинал "{ $denomination }" не найден в конфигурации валюты.

# RoleplaySettingsModal
config-modal-title-rp-settings = Настройки ролевой игры
config-modal-label-min-message-length = Минимальная длина сообщения (символы)
config-modal-placeholder-min-message-length = Количество символов для учёта сообщения. 0 — без ограничения
config-modal-label-cooldown = Перезарядка (секунды)
config-modal-placeholder-cooldown = Время ожидания в секундах между учитываемыми сообщениями
config-modal-label-message-threshold = Порог сообщений
config-modal-placeholder-message-threshold = Количество сообщений для получения награды
config-modal-label-frequency = Частота (кол-во сообщений)
config-modal-placeholder-frequency = Количество подходящих сообщений для получения награды
config-error-min-length-invalid = Минимальная длина сообщения должна быть неотрицательным целым числом.
config-error-cooldown-invalid = Перезарядка должна быть неотрицательным целым числом.
config-error-threshold-invalid = Порог сообщений должен быть положительным целым числом.
config-error-frequency-invalid = Частота должна быть положительным целым числом.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Настройка наград за ролевую игру
config-modal-label-items-name-quantity = Предметы (Название: Количество)
config-modal-label-currency-name-amount = Валюта (Название: Сумма)
config-error-experience-non-negative = Опыт должен быть неотрицательным целым числом.
config-error-item-quantity-positive-named = Количество предмета "{ $itemName }" должно быть положительным целым числом.
config-error-currency-amount-positive = Сумма валюты "{ $currencyName }" должна быть положительным числом.

# SetItemStockModal
config-modal-title-stock-limit = Лимит запасов: { $itemName }
config-modal-label-max-stock = Максимальный запас
config-modal-placeholder-max-stock = Введите максимальный запас (напр., 10)
config-modal-label-current-stock = Текущий запас
config-modal-placeholder-current-stock = Введите текущий доступный запас
config-modal-label-restock-increment = Количество пополнения (за цикл)
config-modal-placeholder-restock-increment = Количество за цикл пополнения (по умолчанию: 1)
config-error-max-stock-positive = Максимальный запас должен быть положительным целым числом.
config-error-current-stock-non-negative = Текущий запас должен быть неотрицательным целым числом.
config-error-current-exceeds-max = Текущий запас не может превышать максимальный.
config-error-item-not-in-shop = Предмет "{ $itemName }" не найден в магазине.

# RestockScheduleModal
config-modal-title-restock-schedule = Настройка расписания пополнения
config-modal-restock-schedule-label = Расписание
config-modal-restock-schedule-none = Нет (Отключено)
config-modal-restock-schedule-hourly = Ежечасно
config-modal-restock-schedule-daily = Ежедневно
config-modal-restock-schedule-weekly = Еженедельно
config-modal-label-time = Время (ЧЧ:ММ в UTC)
config-modal-desc-current-time = Текущее время: { $utcTime }
config-modal-placeholder-time = Напр.: 14:30 для 14:30 UTC
config-modal-restock-day-label = День недели (только еженедельно)
config-modal-restock-mode-label = Режим пополнения
config-modal-restock-mode-full = Полный (сброс до максимума)
config-modal-restock-mode-incremental = Постепенный (добавить количество)
config-error-time-format-invalid = Время должно быть в формате ЧЧ:ММ (напр., 14:30).
config-error-increment-positive = Количество пополнения должно быть положительным целым числом.

# ==========================================
# ВЫПАДАЮЩИЕ СПИСКИ
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Найдите ваш канал { $configName }

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Выберите роль для анонсов квестов

# AddGMRoleSelect
config-select-placeholder-gm-roles = Выберите роль(и) GM

# ConfigWaitListSelect
config-select-placeholder-wait-list = Выберите размер листа ожидания
config-select-option-disabled = 0 (Отключено)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Выберите режим инвентаря
config-select-option-disabled-label = Отключено
config-select-desc-disabled = Игроки начинают с пустым инвентарём.
config-select-option-selection = Выбор
config-select-desc-selection = Игроки свободно выбирают предметы из магазина нового персонажа.
config-select-option-purchase = Покупка
config-select-desc-purchase = Игроки покупают предметы из магазина нового персонажа за заданную валюту.
config-select-option-open = Открытый
config-select-desc-open = Игроки вводят свой инвентарь вручную.
config-select-option-static = Статический
config-select-desc-static = Игроки получают заранее определённый стартовый инвентарь.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Выберите подходящие каналы

# RoleplayModeSelect
config-select-placeholder-rp-mode = Выберите режим
config-select-option-scheduled = По расписанию
config-select-desc-scheduled = Награды выдаются один раз в указанный период сброса.
config-select-option-accrued = Накопительный
config-select-desc-accrued = Награды выдаются многократно на основе уровня активности.

# RoleplayResetSelect
config-select-placeholder-reset-period = Выберите период сброса
config-select-option-hourly = Ежечасно
config-select-desc-hourly = Сброс каждый час.
config-select-option-daily = Ежедневно
config-select-desc-daily = Сброс каждые 24 часа.
config-select-option-weekly = Еженедельно
config-select-desc-weekly = Сброс каждые 7 дней.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Выберите день сброса

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Выберите время сброса (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Выберите форумный канал

# ForumThreadSelect
config-select-placeholder-thread = Выберите тему
config-select-option-no-threads = Активные темы не найдены
config-select-desc-no-threads = Создайте новую тему или проверьте архив
config-select-option-select-forum-first = Сначала выберите форум
config-select-desc-select-forum-first = Выберите форумный канал выше
config-select-desc-thread-id = ID темы: { $threadId }
config-error-select-valid-thread = Выберите существующую тему или создайте новую.
config-error-thread-not-found = Не удалось найти выбранную тему. Возможно, она была удалена или архивирована.

# ==========================================
# ПРЕДСТАВЛЕНИЯ
# ==========================================

## Главное меню
config-title-main-menu = Настройка сервера - Главное меню
config-menu-config-wizard = Мастер настройки
config-menu-desc-config-wizard = Проверьте готовность вашего сервера к использованию ReQuest.
config-menu-channels = Каналы
config-menu-desc-channels = Назначьте каналы для постов ReQuest.
config-menu-currency = Валюта
config-menu-desc-currency = Глобальные настройки валюты.
config-menu-players = Игроки
config-menu-desc-players = Глобальные настройки игроков, такие как отслеживание очков опыта.
config-menu-quests = Квесты
config-menu-desc-quests = Глобальные настройки квестов, такие как листы ожидания.
config-menu-rp-rewards = Награды за RP
config-menu-desc-rp-rewards = Настройка наград за ролевую игру.
config-menu-roles = Роли
config-menu-desc-roles = Настройка пингуемых или привилегированных ролей.
config-menu-shops = Магазины
config-menu-desc-shops = Настройка пользовательских магазинов.
config-menu-language = Язык
config-menu-desc-language = Установить язык по умолчанию для этого сервера.

## Представление мастера настройки
config-title-wizard = {"**"}Настройка сервера - Мастер{"**"}
config-wizard-intro =
    {"**"}Добро пожаловать в Мастер настройки ReQuest!{"**"}

    Этот мастер поможет убедиться, что ваш сервер правильно настроен для использования функций ReQuest.
    Он просканирует текущие настройки и предоставит рекомендации по необходимым изменениям.

    Нажмите кнопку «Запустить сканирование» ниже, чтобы начать проверку. После завершения сканирования
    вы получите подробный отчёт о конфигурации сервера вместе с рекомендуемыми изменениями.

# Мастер - Проверка прав бота
config-wizard-bot-permissions-header = __{"**"}Глобальные права бота{"**"}__
config-wizard-bot-permissions-desc = Этот раздел проверяет, что у ReQuest есть необходимые права для корректной работы.
config-wizard-bot-role = Роль бота: { $roleMention }
config-wizard-status-warnings = {"**"}Статус: ⚠️ ОБНАРУЖЕНЫ ПРЕДУПРЕЖДЕНИЯ{"**"}
config-wizard-missing-perm = - ⚠️ Отсутствует: `{ $permissionName }`
config-wizard-ensure-permissions = Убедитесь, что высшая роль бота имеет эти права на глобальном уровне.
config-wizard-status-ok = {"**"}Статус: ✅ OK{"**"}
config-wizard-bot-permissions-ok = У бота есть все необходимые глобальные права.
config-wizard-status-scan-failed = {"**"}Статус: ❌ СКАНИРОВАНИЕ НЕ УДАЛОСЬ{"**"}
config-wizard-scan-error = Произошла непредвиденная ошибка при проверке прав бота.
config-wizard-error-type = Ошибка: { $errorType }
config-wizard-required-permissions = {"**"}Необходимые права для роли бота:{"**"}

# Мастер - Названия прав
config-wizard-perm-view-channels = Просмотр каналов
config-wizard-perm-manage-roles = Управление ролями
config-wizard-perm-send-messages = Отправка сообщений
config-wizard-perm-attach-files = Прикрепление файлов
config-wizard-perm-add-reactions = Добавление реакций
config-wizard-perm-use-external-emoji = Использование внешних эмодзи
config-wizard-perm-manage-messages = Управление сообщениями
config-wizard-perm-read-message-history = Чтение истории сообщений

# Мастер - Проверка ролей
config-wizard-role-header = __{"**"}Конфигурация ролей{"**"}__
config-wizard-role-desc =
    Этот раздел проверяет следующее:

    - Настроены ли роли GM (обязательно) и роль для анонсов (опционально).
    - Имеет ли роль по умолчанию (@everyone) необходимые права для доступа к функциям бота.
    - Не имеет ли роль по умолчанию (@everyone) опасных прав.
    - Проверяются ли роли GM и анонсов на наличие повышенных прав относительно роли по умолчанию.

    Все предупреждения являются рекомендациями, основанными на стандартной конфигурации. В зависимости от потребностей вашего сервера, некоторые рекомендации могут быть неактуальны.

config-wizard-default-role-label = {"**"}Роль по умолчанию:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Обнаружены опасные права:
config-wizard-default-role-ok = - ✅ @everyone: OK
config-wizard-missing-permission = - Отсутствует право: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}Роли GM:{"**"}
config-wizard-no-gm-roles = - ⚠️ Роли GM не настроены
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Настроенная роль не найдена/удалена с сервера
config-wizard-role-ok = - ✅ { $roleMention }: OK
config-wizard-announcement-role-label = {"**"}Роль для анонсов:{"**"}
config-wizard-no-announcement-role = - ℹ️ Роль для анонсов не настроена
config-wizard-announcement-role-not-found = - ⚠️ Настроенная роль не найдена/удалена с сервера
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Обнаружено повышение прав - { $escalations }
config-wizard-escalation-more = , и ещё { $count }...

# Мастер - Необходимые права по умолчанию
config-wizard-perm-send-messages-in-threads = Отправка сообщений в темах
config-wizard-perm-use-application-commands = Использование команд приложений

# Мастер - Опасные права
config-wizard-perm-manage-channels = Управление каналами
config-wizard-perm-manage-webhooks = Управление вебхуками
config-wizard-perm-manage-server = Управление сервером
config-wizard-perm-manage-nicknames = Управление никнеймами
config-wizard-perm-kick-members = Кик участников
config-wizard-perm-ban-members = Бан участников
config-wizard-perm-timeout-members = Тайм-аут участников
config-wizard-perm-mention-everyone = Упоминание @everyone
config-wizard-perm-manage-threads = Управление темами
config-wizard-perm-administrator = Администратор

# Мастер - Проверка каналов
config-wizard-channel-header = __{"**"}Конфигурация каналов{"**"}__
config-wizard-channel-desc =
    Этот раздел проверяет следующее:

    - Существуют ли настроенные каналы.
    - Может ли бот просматривать и отправлять сообщения в настроенных каналах.
    - Не имеет ли роль по умолчанию (@everyone) права `Отправка сообщений`.

config-wizard-channel-no-config-required = - ⚠️ Канал не настроен
config-wizard-channel-not-configured = - ℹ️ Не настроен (Опционально)
config-wizard-channel-not-found = - ⚠️ Настроенный канал не найден/удалён с сервера
config-wizard-channel-ok = - ✅ OK
config-wizard-bot-cannot-view = - ⚠️ { $botMention } не может просматривать этот канал.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } не может отправлять сообщения в этот канал.
config-wizard-everyone-can-send = - ⚠️ @everyone может отправлять сообщения в этот канал.

# Мастер - Названия каналов
config-wizard-channel-quest-board = Доска квестов
config-wizard-channel-player-board = Доска игроков
config-wizard-channel-quest-archive = Архив квестов
config-wizard-channel-gm-transaction-log = Журнал транзакций GM
config-wizard-channel-player-transaction-log = Журнал транзакций игроков
config-wizard-channel-shop-log = Журнал магазина
config-wizard-channel-approval-queue = Очередь одобрения персонажей

# Мастер - Панель управления
config-wizard-dashboard-header = __{"**"}Панель настроек{"**"}__
config-wizard-dashboard-desc = Этот раздел предоставляет обзор дополнительных настроек для быстрой справки.
config-wizard-quest-settings = {"**"}Настройки квестов{"**"}
config-wizard-quest-wait-list = - Размер листа ожидания квестов: { $size }
config-wizard-quest-summary = - Итог квеста: { $status }
config-wizard-gm-rewards-per-quest = {"**"}Награды GM (за квест){"**"}
config-wizard-player-settings = {"**"}Настройки игроков{"**"}
config-wizard-player-experience = - Опыт игроков: { $status }
config-wizard-currency-settings = {"**"}Настройки валюты{"**"}
config-wizard-rp-rewards = {"**"}Награды за ролевую игру{"**"}
config-wizard-rp-status = - Статус: { $status }
config-wizard-rp-mode = - Режим: { $mode }
config-wizard-rp-channels = - Отслеживаемые каналы: { $count }
config-wizard-shops = {"**"}Магазины{"**"}
config-wizard-shops-count = - Настроенные магазины: { $count }
config-wizard-shops-more = - ...и ещё { $count }
config-wizard-new-char-setup = {"**"}Настройка нового персонажа{"**"}
config-wizard-inventory-type = - Тип инвентаря: { $type }
config-wizard-new-char-shop-items = - Предметы магазина нового персонажа: { $count }
config-wizard-static-kits = - Стартовые наборы: { $count }

# Мастер - Отчёт о наградах GM
config-wizard-no-currencies = - ℹ️ Валюты не настроены
config-wizard-configured-currencies = {"**"}Настроенные валюты:{"**"}
config-wizard-no-denominations = - Номиналы не настроены
config-wizard-gm-rewards-disabled = {"**"}Статус:{"**"} Отключено
config-wizard-gm-rewards-enabled = {"**"}Статус:{"**"} Включено
config-wizard-gm-rewards-experience = - Опыт: { $xp }
config-wizard-gm-rewards-items = - Предметы:
config-wizard-unnamed-shop = Безымянный магазин

## Представление ролей
config-title-roles = {"**"}Настройка сервера - Роли{"**"}
config-label-announcement-role = {"**"}Роль для анонсов:{"**"} { $status }
config-desc-announcement-role = Эта роль упоминается при публикации квеста.
config-label-announcement-role-default = {"**"}Роль для анонсов:{"**"} Не настроена
config-label-gm-roles = {"**"}Роль(и) GM:{"**"} { $roles }
config-desc-gm-roles = Эти роли предоставляют доступ к командам и функциям Мастера Игры.
config-label-gm-roles-default = {"**"}Роль(и) GM:{"**"} Не настроены
config-title-forbidden-roles = __{"**"}Запрещённые роли{"**"}__
config-desc-forbidden-roles =
    Настраивает список названий ролей, которые не могут быть использованы Мастерами Игры для ролей отрядов.
    По умолчанию `everyone`, `administrator`, `gm` и `game master` не могут быть использованы. Эта настройка
    расширяет этот список.

## Представление удаления ролей GM
config-title-remove-gm-roles = {"**"}Настройка сервера - Удаление ролей GM{"**"}
config-msg-no-gm-roles = Роли GM не настроены.

## Представление каналов
config-title-channels = {"**"}Настройка сервера - Каналы{"**"}

config-label-quest-board = {"**"}Доска квестов:{"**"} { $channel }
config-desc-quest-board = Канал, в котором будут публиковаться новые/активные квесты.
config-label-quest-board-default = {"**"}Доска квестов:{"**"} Не настроена

config-label-player-board = {"**"}Доска игроков:{"**"} { $channel }
config-desc-player-board = Опциональный канал объявлений/сообщений для игроков.
config-label-player-board-default = {"**"}Доска игроков:{"**"} Не настроена

config-label-quest-archive = {"**"}Архив квестов:{"**"} { $channel }
config-desc-quest-archive = Опциональный канал, куда перемещаются завершённые квесты с итоговой информацией.
config-label-quest-archive-default = {"**"}Архив квестов:{"**"} Не настроен

config-label-gm-transaction-log = {"**"}Журнал транзакций GM:{"**"} { $channel }
config-desc-gm-transaction-log = Опциональный канал для записи транзакций GM (например, команд изменения игрока).
config-label-gm-transaction-log-default = {"**"}Журнал транзакций GM:{"**"} Не настроен

config-label-player-transaction-log = {"**"}Журнал транзакций игроков:{"**"} { $channel }
config-desc-player-transaction-log = Опциональный канал для записи транзакций игроков, таких как обмен и потребление предметов.
config-label-player-transaction-log-default = {"**"}Журнал транзакций игроков:{"**"} Не настроен

config-label-shop-log = {"**"}Журнал магазина:{"**"} { $channel }
config-desc-shop-log = Опциональный канал для записи транзакций магазина.
config-label-shop-log-default = {"**"}Журнал магазина:{"**"} Не настроен

## Представление квестов
config-title-quests = {"**"}Настройка сервера - Квесты{"**"}

config-label-wait-list = {"**"}Размер листа ожидания:{"**"} { $size }
config-desc-wait-list = Лист ожидания позволяет указанному количеству игроков встать в очередь на заполненный квест на случай, если кто-то выйдет.
config-label-wait-list-disabled = {"**"}Размер листа ожидания:{"**"} Отключено

config-label-quest-summary = {"**"}Итог квеста:{"**"} { $status }
config-desc-quest-summary = Эта опция позволяет GM предоставлять краткий итог при завершении квестов.
config-label-quest-summary-disabled = {"**"}Итог квеста:{"**"} Отключено

config-label-gm-rewards = Награды GM
config-desc-gm-rewards = Настройка наград, которые GM получают при завершении квестов.

## Представление наград GM
config-title-gm-rewards = {"**"}Настройка сервера - Награды GM{"**"}
config-desc-gm-rewards-detail =
    {"**"}Добавить/Изменить награды{"**"}
    Открывает модальное окно ввода для добавления, изменения или удаления наград GM.

    > Награды настраиваются на уровне квеста. Каждый раз, когда Мастер Игры завершает квест, он
    получает настроенные ниже награды на своего активного персонажа.
config-msg-no-rewards = Награды не настроены.
config-label-gm-experience = {"**"}Опыт:{"**"} { $xp }
config-label-gm-items = {"**"}Предметы:{"**"}

## Представление игроков
config-title-players = {"**"}Настройка сервера - Игроки{"**"}

config-label-player-experience = {"**"}Опыт игроков:{"**"} { $status }
config-desc-player-experience = Включает/Отключает использование очков опыта (или аналогичной системы прогресса персонажа).
config-label-player-experience-disabled = {"**"}Опыт игроков:{"**"} Отключено

config-label-new-char-settings = {"**"}Настройки нового персонажа{"**"}
config-desc-new-char-settings = Настройка параметров новых персонажей и способа инициализации их стартового инвентаря.

config-label-player-board-purge = {"**"}Очистка доски игроков{"**"}
config-desc-player-board-purge = Удаляет посты с доски игроков (если включена).

## Представление настроек нового персонажа
config-title-new-character = {"**"}Настройка сервера - Настройки нового персонажа{"**"}

config-label-inventory-type = {"**"}Тип инвентаря нового персонажа:{"**"} { $type }
config-desc-inventory-type = Определяет, как зарегистрированные персонажи инициализируют свой инвентарь.
config-label-inventory-type-disabled = {"**"}Тип инвентаря нового персонажа:{"**"} Отключено

config-label-new-char-wealth = {"**"}Начальное богатство:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Начальное богатство:{"**"} Отключено

config-label-approval-queue = {"**"}Очередь одобрения:{"**"} { $channel }
config-desc-approval-queue = Если установлено, новые персонажи должны быть одобрены GM в этом форумном канале, прежде чем станут активны.
config-label-approval-queue-disabled = {"**"}Очередь одобрения:{"**"} Отключено
config-label-approval-queue-not-configured = {"**"}Очередь одобрения:{"**"} Не настроена

# Описания типов инвентаря (используются при настройке)
config-desc-inv-type-disabled = Игроки начинают с пустым инвентарём.
config-desc-inv-type-selection = Игроки свободно выбирают предметы из магазина нового персонажа.
config-desc-inv-type-purchase = Игроки покупают предметы из магазина нового персонажа за заданную валюту.
config-desc-inv-type-open = Игроки вводят предметы инвентаря вручную.
config-desc-inv-type-static = Игроки получают заранее определённый стартовый инвентарь.

## Представление магазина нового персонажа
config-title-new-char-shop = {"**"}Настройка сервера - Магазин нового персонажа{"**"}
config-label-inv-type-selection = {"**"}Тип инвентаря:{"**"} Выбор
config-desc-inv-type-selection-shop = Игроки свободно выбирают предметы из магазина нового персонажа.
config-label-inv-type-purchase = {"**"}Тип инвентаря:{"**"} Покупка
config-desc-inv-type-purchase-shop = Игроки покупают предметы из магазина нового персонажа за заданную валюту.
config-label-inv-type-other = {"**"}Тип инвентаря:{"**"} { $type }
config-desc-inv-type-not-in-use = Магазин нового персонажа не используется.
config-msg-define-shop-items = Определите товары магазина.
config-msg-no-items = Предметы не настроены.

## Представление стартовых наборов
config-title-static-kits = {"**"}Настройка сервера - Стартовые наборы{"**"}
config-desc-create-kit = Создать новый набор.
config-msg-no-kits = Наборы не настроены.
config-label-kit-more-items = ...и ещё { $count } предметов
config-label-empty-kit = {"*"}Пустой набор{"*"}

## Представление редактирования стартового набора
config-title-editing-kit = {"**"}Редактирование набора: { $kitName }{"**"}
config-msg-kit-empty = Этот набор пуст. Используйте кнопки выше для добавления валюты или предметов.
config-label-kit-currency = {"**"}Валюта:{"**"} { $display }
config-label-kit-item = {"**"}Предмет:{"**"} { $name }

## Представление валюты
config-title-currency = {"**"}Настройка сервера - Валюта{"**"}
config-desc-create-currency = Создать новую валюту.
config-msg-no-currencies = Валюты не настроены.
config-label-currency-display-type = Тип отображения: { $type } | Номиналы: { $count }
config-label-currency-type-double = Дробный
config-label-currency-type-integer = Целый

## Представление редактирования валюты
config-title-manage-currency = {"**"}Управление валютой: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Валюта и номиналы{"**"}__
    - Данное название вашей валюты считается базовой валютой со значением 1.
    {"```"}Пример: "золото" настроено как валюта.{"```"}
    - Добавление номинала требует указания названия и значения относительно базовой валюты.
    {"```"}Пример: Золоту добавлены два номинала: серебро (значение 0.1) и медь (значение 0.01).{"```"}
    - Любые транзакции с базовой валютой или её номиналами будут автоматически конвертироваться.
    {"```"}Пример: У игрока 10 золота, и он тратит 3 меди. Его новый баланс автоматически отобразится
    как 9 золота, 9 серебра и 7 меди.{"```"}
    - Валюты с целым отображением показывают каждый номинал, а валюты с дробным отображением
    показываются только как базовая валюта.
    {"```"}Пример: Игрок выше с дробным отображением будет показан как 9.97 золота.{"```"}
config-btn-toggle-display-current = Переключить отображение (Текущее: { $type })
config-msg-no-denominations = Номиналы не настроены.

## Представление магазинов
config-title-shops = {"**"}Настройка сервера - Магазины{"**"}
config-desc-add-shop-wizard =
    {"**"}Добавить магазин (Мастер){"**"}
    Создать новый пустой магазин через форму.
config-desc-add-shop-json =
    {"**"}Добавить магазин (JSON){"**"}
    Создать новый магазин, предоставив полное JSON-определение. (Для продвинутых)
config-btn-example-json = Пример JSON
config-desc-example-json =
    {"**"}Пример JSON{"**"}
    Скачайте пример файла JSON, показывающий ожидаемый формат.
config-msg-example-json = Вот пример файла JSON, показывающий ожидаемый формат.
config-msg-no-shops = Магазины не настроены.
config-label-shop-type-forum = (Форум)
config-label-shop-channel = Канал: <#{ $channelId }>

## Представление выбора типа канала магазина
config-title-choose-location = {"**"}Добавить магазин - Выбор типа расположения{"**"}
config-label-text-channel = {"**"}Текстовый канал{"**"}
config-desc-text-channel = Создать магазин в обычном текстовом канале.
config-label-forum-thread = {"**"}Тема форума{"**"}
config-desc-forum-thread = Создать магазин в теме форума (новой или существующей).

## Представление настройки форумного магазина
config-title-forum-setup = {"**"}Добавить магазин - Настройка темы форума{"**"}
config-label-step1 = {"**"}Шаг 1: Выберите форумный канал{"**"}
config-label-step2 = {"**"}Шаг 2: Выберите вариант темы{"**"}
config-label-step3 = {"**"}Шаг 3: Выберите существующую тему{"**"}
config-desc-create-new-thread =
    {"**"}Создать новую тему{"**"}
    Открывает форму для создания новой темы и настройки магазина.
config-label-selected-thread = {"**"}Выбранная тема:{"**"} { $threadName }
config-desc-click-to-configure = Нажмите, чтобы настроить магазин в этой теме.

## Представление управления магазином
config-title-manage-shop = {"**"}Управление магазином: { $shopName }{"**"}
config-label-shop-type = {"**"}Тип:{"**"} { $type }
config-label-shop-type-text = Текстовый канал
config-label-shop-type-forum-thread = Тема форума
config-label-shopkeeper = {"**"}Торговец:{"**"} { $name }
config-label-shop-description = {"**"}Описание:{"**"} { $description }
config-label-shop-channel-info = {"**"}Канал:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Редактировать данные и товары магазина через Мастер.
config-desc-upload-json = Загрузить новое JSON-определение для этого магазина.
config-desc-download-json = Скачать текущее JSON-определение.
config-desc-remove-shop = Безвозвратно удалить этот магазин.

## Представление редактирования магазина
config-title-editing-shop = {"**"}Редактирование магазина: { $shopName }{"**"}
config-label-shop-shopkeeper = Торговец: {"**"}{ $name }{"**"}

## Представление лимитов запасов
config-title-stock-config = {"**"}Конфигурация запасов: { $shopName }{"**"}
config-label-current-utc = Текущее время UTC: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Расписание пополнения:{"**"} { $schedule }
config-label-restock-hourly = в :{ $minute } минут
config-label-restock-daily = в { $time } UTC
config-label-restock-weekly = в { $day } в { $time } UTC
config-label-restock-mode = {"**"}Режим:{"**"} { $mode }
config-label-restock-full = Полное пополнение
config-label-restock-incremental = Постепенный (количество по предмету)
config-label-restock-disabled = {"**"}Расписание пополнения:{"**"} Отключено
config-label-item-stock-limits = {"**"}Лимиты запасов предметов{"**"}
config-msg-no-items-in-shop = В этом магазине нет предметов.
config-label-stock-with-available = Макс: { $max } | Доступно: { $available }
config-label-stock-increment = Пополнение: +{ $increment }/цикл
config-label-stock-reserved =  | Зарезервировано: { $reserved }
config-label-stock-not-initialized = Макс: { $max } | Доступно: (не инициализировано)
config-label-stock-unlimited = Запас: Без ограничений

## Представление ролевой игры
config-title-roleplay = {"**"}Настройка сервера - Награды за ролевую игру{"**"}
config-label-rp-status = {"**"}Статус:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Время сервера:{"**"} `{ $time }`
config-label-rp-enabled = Включено
config-label-rp-disabled = Отключено

config-desc-rp-mode-scheduled = {"```"}Награды выдаются один раз при отправке необходимого количества подходящих сообщений в установленный период (ежечасно, ежедневно или еженедельно).{"```"}
config-desc-rp-mode-accrued = {"```"}Награды выдаются повторно каждый раз, когда отправлено заданное количество подходящих сообщений.{"```"}

config-label-rp-config-details = {"**"}Детали конфигурации:{"**"}
config-label-rp-mode = {"**"}Режим:{"**"} { $mode }
config-label-rp-min-length = {"**"}Минимальная длина сообщения:{"**"} { $length } символов
config-label-rp-cooldown = {"**"}Перезарядка:{"**"} { $seconds } секунд
config-label-rp-frequency-once = {"**"}Частота:{"**"} Раз в { $period }
config-label-rp-reset-time = {"**"}Время сброса:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Порог:{"**"} { $count } подходящих сообщений
config-label-rp-frequency-every = {"**"}Частота:{"**"} Каждые { $count } подходящих сообщений

config-label-rp-channels = {"**"}Каналы ролевой игры:{"**"}
config-msg-rp-no-channels = Не настроены.
config-label-rp-channels-more = ...и ещё { $count }.

config-label-rp-rewards = {"**"}Награды:{"**"}
config-msg-rp-no-rewards = Не настроены.
config-label-rp-experience = {"**"}Опыт:{"**"} { $xp }
config-label-rp-items = {"**"}Предметы:{"**"}
config-label-rp-currency = {"**"}Валюта:{"**"}

## Представление языка
config-title-language = {"**"}Настройка сервера - Язык{"**"}
config-server-language-help =
    Эта настройка позволяет указать язык по умолчанию для {"**"}публичных{"**"} ответов и сообщений ReQuest на этом сервере. К публичным ответам относятся:
    - Посты на доске квестов и доске игроков
    - Итоги квестов и сообщения в журнальных каналах
    - Пополнение магазина
    - Потребление предметов игроками

    Эта настройка влияет только на статический текст, генерируемый ботом, и не переводит динамический контент, такой как введённые пользователем названия предметов или описания квестов.

    Личные ответы и меню не затрагиваются этой настройкой.
config-label-server-language = {"**"}Язык сервера:{"**"} { $language }
config-label-server-language-default = {"**"}Язык сервера:{"**"} По умолчанию (без переопределения)
config-select-placeholder-server-language = Выберите язык сервера
config-select-option-default = По умолчанию (без переопределения)
config-select-desc-default = Использовать предпочтения каждого пользователя или язык Discord.

# Quest Roles
config-btn-quest-roles = Роли квестов
config-btn-manage-gm-quest-roles = Управление

config-modal-title-confirm-quest-role-removal = Подтверждение удаления роли
config-modal-label-remove-quest-role = Удалить { $roleName } у { $gmName }?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Выберите режим ролей квестов
config-select-option-quest-role-disabled = Отключено
config-select-desc-quest-role-disabled = Роли не создаются и не назначаются.
config-select-option-quest-role-temporary = Временные
config-select-desc-quest-role-temporary = GM могут создавать временные роли для каждого квеста.
config-select-option-quest-role-static = Статические
config-select-desc-quest-role-static = GM выбирают из заранее назначенных ролей сервера.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Назначить роль(и) сервера этому GM

## Quest Roles View
config-title-quest-roles = {"**"}Настройка сервера - Роли квестов{"**"}
config-label-quest-roles = Роли квестов
config-desc-quest-roles =
    Настройте управление ролями отряда во время квестов.

config-label-quest-role-mode-disabled = {"**"}Режим ролей квестов:{"**"} Отключено
    Роли не создаются и не назначаются во время квестов.
config-label-quest-role-mode-temporary = {"**"}Режим ролей квестов:{"**"} Временные
    GM могут по желанию создать временную роль при создании квеста.
    Роль удаляется при завершении или отмене квеста.
config-label-quest-role-mode-static = {"**"}Режим ролей квестов:{"**"} Статические
    GM выбирают из заранее назначенных ролей сервера. Роли назначаются
    участникам отряда во время квестов, но никогда не удаляются.

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}Настройка сервера - Назначения статических ролей квестов{"**"}
config-label-manage-assignments = Управление назначениями ролей
config-desc-manage-assignments =
    Назначайте существующие роли сервера GM для использования во время квестов.
    Роли должны быть ниже наивысшей роли ReQuest в иерархии сервера.
config-msg-no-gm-members = На этом сервере не найдены участники с ролью GM.
config-label-no-roles-assigned = Роли квестов не назначены

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}Управление ролями квестов — { $gmName }{"**"}
config-error-unmanageable-roles = Следующие роли не могут быть назначены, так как они управляются интеграцией, являются ролью по умолчанию или находятся выше наивысшей роли ReQuest: { $roles }
config-error-quest-role-limit = Этот GM достиг максимума в { $limit } назначенных ролей квестов.
config-label-quest-role-count = Назначенные роли: { $count }/{ $limit }
