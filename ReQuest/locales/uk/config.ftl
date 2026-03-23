## Рядки модуля конфігурації

# ==========================================
# КНОПКИ
# ==========================================

# Ролі
config-btn-clear = Очистити
config-btn-remove-gm-roles = Видалити ролі GM
config-btn-forbidden-roles = Заборонені ролі

# Квести
config-btn-toggle-quest-summary = Перемкнути підсумок квесту
config-btn-toggle-player-experience = Перемкнути досвід гравця
config-btn-toggle-display = Перемкнути відображення
config-btn-purge-player-board = Очистити дошку гравців
config-btn-add-modify-rewards = Додати/Змінити нагороди

# Валюта
config-btn-add-denomination = Додати номінал
config-btn-add-new-currency = Додати нову валюту
config-btn-remove-currency = Видалити валюту

# Магазини - створення
config-btn-add-shop-wizard = Додати магазин (Майстер)
config-btn-add-shop-json = Додати магазин (JSON)
config-btn-edit-shop-wizard = Редагувати магазин (Майстер)
config-btn-edit-shop-json = Редагувати магазин (JSON)
config-btn-remove-shop = Видалити магазин
config-btn-add-item = Додати предмет
config-btn-edit-shop-details = Редагувати деталі магазину
config-btn-download-json = Завантажити JSON
config-btn-done-editing = Завершити редагування
config-btn-scan-server-configs = Сканувати конфігурації сервера
config-btn-re-scan = Повторне сканування

# Магазин нового персонажа
config-btn-upload-json = Завантажити JSON
config-btn-configure-new-character-wealth = Налаштувати стартове багатство
config-btn-configure-new-character-shop = Налаштувати магазин нового персонажа
config-btn-clear-shop = Очистити магазин
config-btn-configure-static-kits = Налаштувати статичні набори
config-btn-new-character-settings = Налаштування нового персонажа
config-btn-disabled-no-currency = Вимкнено (Валюта не налаштована)
config-btn-disabled-no-wealth = Вимкнено (Стартове багатство не налаштовано)

# Статичні набори
config-btn-create-new-kit = Створити новий набір
config-btn-delete-kit = Видалити набір
config-btn-add-currency = Додати валюту

# Рольова гра
config-btn-toggle-rp-rewards = Перемкнути нагороди за РП
config-btn-clear-channels = Очистити канали
config-btn-edit-settings = Редагувати налаштування
config-btn-configure-rewards = Налаштувати нагороди

# Запаси
config-btn-stock-limits = Обмеження запасів
config-btn-set-limit = Встановити обмеження
config-btn-edit-limit = Редагувати обмеження
config-btn-remove-limit = Видалити обмеження
config-btn-configure-restock-schedule = Налаштувати розклад поповнення
config-btn-back-to-shop-editor = Назад до редактора магазину

# Магазин на форумі
config-btn-create-new-thread = Створити нову тему
config-btn-use-existing-thread = Використати існуючу тему

# Майстер налаштування
config-btn-quit = Вийти
config-btn-configure-channels = Налаштувати канали
config-btn-configure-roles = Налаштувати ролі
config-btn-configure-quests = Налаштувати квести
config-btn-configure-players = Налаштувати гравців
config-btn-configure-currency = Налаштувати валюту
config-btn-configure-rp-rewards = Налаштувати нагороди за РП
config-btn-configure-shops = Налаштувати магазини
config-btn-new-char-setup = Налашт. нов. персонажа

# Заголовки модальних вікон підтвердження (передаються до загального ConfirmModal)
config-modal-title-confirm-role-removal = Підтвердження видалення ролі
config-modal-title-confirm-removal = Підтвердження видалення
config-modal-title-confirm-currency-removal = Підтвердження видалення валюти
config-modal-title-confirm-shop-removal = Підтвердження видалення магазину
config-modal-title-confirm-kit-deletion = Підтвердження видалення набору
config-modal-title-confirm-remove-stock-limit = Підтвердження видалення обмеження запасів
config-modal-title-clear-shop = Підтвердити очищення магазину

# Мітки підказок модальних вікон підтвердження
config-modal-label-remove-role = Видалити { $roleName }?
config-modal-label-remove-denomination = Видалити { $denominationName }?
config-modal-label-remove-currency = Видалити { $currencyName }?
config-modal-label-shop-removal-warning = УВАГА: Ця дія незворотна!
config-modal-label-kit-deletion-warning = УВАГА: Незворотно!
config-modal-label-remove-stock-limit = Введіть CONFIRM для видалення обмеження запасів
config-modal-label-clear-shop = Очистити всі предмети з цього магазину?

# Повідомлення про помилки з кнопок
config-error-shop-data-not-found = Помилка: Не вдалося знайти дані цього магазину.
config-msg-shop-json-download = Ось JSON-визначення для {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Ось JSON-визначення для магазину нового персонажа.
config-error-select-forum-first = Спочатку оберіть форумний канал.
config-error-select-thread-first = Спочатку оберіть тему.

# ==========================================
# МОДАЛЬНІ ВІКНА
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Додати нову валюту
config-modal-label-currency-name = Назва валюти
config-error-currency-already-exists = Валюта або номінал з назвою { $name } вже існує!

# RenameCurrencyModal
config-modal-title-rename-currency = Перейменувати валюту
config-modal-label-new-currency-name = Нова назва валюти
config-error-currency-name-exists = Валюта з назвою "{ $name }" вже існує.
config-error-denomination-name-exists = Номінал з назвою "{ $name }" вже існує.

# RenameDenominationModal
config-modal-title-rename-denomination = Перейменувати номінал
config-modal-label-new-denomination-name = Нова назва номіналу

# AddCurrencyDenominationModal
config-modal-title-add-denomination = Додати номінал { $currencyName }
config-modal-label-denomination-name = Назва
config-modal-placeholder-denomination-name = напр., Срібло
config-modal-label-denomination-value = Значення
config-modal-placeholder-denomination-value = напр., 0.1
config-error-denomination-matches-currency = Назва нового номіналу не може збігатися з існуючою валютою на цьому сервері! Знайдено існуючу валюту з назвою "{ $existingName }".
config-error-denomination-matches-denomination = Назва нового номіналу не може збігатися з існуючим номіналом на цьому сервері! Знайдено існуючий номінал з назвою "{ $denominationName }" під валютою "{ $currencyName }".
config-error-denomination-value-exists = Номінали однієї валюти повинні мати унікальні значення! { $denominationName } вже має це призначене значення.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Заборонені назви ролей
config-modal-label-names = Назви
config-modal-placeholder-names = Введіть назви, розділені комами
config-msg-forbidden-roles-updated = Заборонені ролі оновлено!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Очистити дошку гравців
config-modal-label-age = Вік
config-modal-placeholder-age = Введіть максимальний вік публікацій (у днях) для збереження
config-msg-posts-purged = Публікації старші за { $days } днів було очищено!

# GMRewardsModal
config-modal-title-gm-rewards = Додати/Змінити нагороди GM
config-modal-label-experience = Досвід
config-modal-placeholder-enter-number = Введіть число
config-modal-label-items = Предмети
config-modal-placeholder-items =
    Назва: Кількість
    Назва2: Кількість
    тощо.
config-error-experience-invalid = Досвід має бути цілим числом (напр. 2000).
config-error-item-format-invalid = Недійсний формат предмета: "{ $item }". Кожен предмет має бути на новому рядку у форматі "Назва: Кількість".

# ConfigShopDetailsModal
config-modal-title-shop-details = Додати/Редагувати деталі магазину
config-modal-label-shop-channel = Оберіть канал
config-modal-placeholder-shop-channel = Оберіть канал для цього магазину
config-modal-label-shop-name = Назва магазину
config-modal-placeholder-shop-name = Введіть назву магазину
config-modal-label-shopkeeper-name = Ім'я торговця
config-modal-placeholder-shopkeeper-name = Введіть ім'я торговця
config-modal-label-shop-description = Опис магазину
config-modal-placeholder-shop-description = Введіть опис магазину
config-modal-label-shop-image-url = URL зображення магазину
config-modal-placeholder-shop-image-url = Введіть URL зображення магазину
config-error-no-channel-selected = Канал для магазину не обрано.
config-error-shop-already-in-channel = У вибраному каналі вже зареєстровано магазин. Будь ласка, оберіть інший канал або відредагуйте існуючий магазин.

# build_shop_header_view
config-label-shopkeeper = {"**"}Торговець:{"**"} { $name }
config-msg-use-shop-command = Використовуйте команду `/shop` для перегляду та купівлі предметів.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Створити магазин у темі форуму
config-modal-label-thread-name = Назва теми
config-modal-placeholder-thread-name = Введіть назву теми для магазину
config-error-forum-not-found = Не вдалося знайти обраний форумний канал.
config-error-shop-already-in-thread = У цій темі вже зареєстровано магазин. Це не повинно відбуватися для нової теми.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Додати новий магазин через JSON
config-modal-label-upload-json = Завантажте файл .json з даними магазину
config-error-no-json-uploaded = JSON-файл для магазину не завантажено.
config-error-file-must-be-json = Завантажений файл має бути JSON-файлом (.json).
config-error-invalid-json = Недійсний формат JSON: { $error }
config-error-json-validation-failed = JSON не відповідає схемі: { $error }

# ShopItemModal
config-modal-title-shop-item = Додати/Редагувати предмет магазину
config-modal-label-item-name = Назва предмета
config-modal-placeholder-item-name = Введіть назву предмета
config-modal-label-item-description = Опис предмета
config-modal-placeholder-item-description = Введіть опис предмета
config-modal-label-item-quantity = Кількість предмета
config-modal-placeholder-item-quantity = Введіть кількість, що продається за покупку
config-modal-label-item-costs = Вартість предмета
config-modal-placeholder-item-costs = Напр.: 10 gold + 5 silver\nАБО: 50 rep\n(+ для ТА, Нові рядки для АБО)
config-error-item-quantity-positive = Кількість предмета має бути додатнім цілим числом.
config-error-cost-format-invalid = Недійсний формат вартості в опції: "{ $option }". Кожна вартість має містити суму та валюту, розділені пробілом, напр. "10 gold".
config-error-cost-amount-invalid = Недійсна сума "{ $amount }" для валюти: "{ $currency }". Сума має бути додатнім числом.
config-error-unknown-currency = Невідома валюта `{ $currency }`. Будь ласка, використовуйте дійсну валюту, налаштовану для цього сервера.
config-error-item-already-exists = Предмет з назвою { $itemName } вже існує в цьому магазині.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Оновити магазин через JSON
config-modal-label-upload-new-json = Завантажити нове JSON-визначення
config-error-no-file-uploaded = Файл не завантажено.
config-error-file-must-be-json-ext = Файл має бути `.json`.
config-error-json-validation-message = Перевірка JSON не вдалася: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Додати/Редагувати спорядження нового персонажа
config-modal-placeholder-item-quantity-selection = Введіть кількість, отриману за вибір
config-modal-label-item-cost = Вартість предмета
config-error-cost-format-short = Недійсний формат вартості: '{ $component }'. Очікується 'Сума Валюта'.
config-error-amount-invalid-short = Недійсна сума '{ $amount }' для валюти '{ $currency }'.
config-error-item-exists-new-char = Предмет з назвою { $itemName } вже існує в магазині нового персонажа.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Завантажити магазин нового персонажа (JSON)
config-error-no-json-uploaded-short = JSON-файл не завантажено.
config-error-json-must-have-shopstock = JSON повинен містити масив 'shopStock'.
config-error-items-must-have-name-price = Усі предмети повинні мати 'name' та 'price'.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Встановити багатство нового персонажа
config-modal-label-amount = Сума
config-modal-placeholder-amount = Введіть суму цієї валюти.
config-modal-placeholder-currency-name = Введіть назву валюти, визначеної на цьому сервері
config-error-no-currencies-configured = На цьому сервері валюти не налаштовано.
config-error-currency-not-found = Валюту або номінал з назвою { $name } не знайдено. Будь ласка, використовуйте дійсну валюту.

# CreateStaticKitModal
config-modal-title-create-kit = Створити новий статичний набір
config-modal-label-kit-name = Назва набору
config-modal-placeholder-kit-name = напр., Стартовий набір воїна
config-modal-label-description = Опис
config-modal-placeholder-kit-description = Необов'язковий опис для цього набору
config-error-kit-name-exists = Статичний набір з назвою "{ $kitName }" вже існує. Будь ласка, оберіть іншу назву.

# StaticKitItemModal
config-modal-title-kit-item = Додати/Редагувати предмет набору
config-modal-placeholder-kit-item-quantity = Введіть кількість цього предмета для включення в набір

# StaticKitCurrencyModal
config-modal-title-kit-currency = Додати валюту набору
config-modal-placeholder-currency-eg = напр., Золото
config-modal-placeholder-amount-eg = напр., 100
config-error-amount-must-be-number = Сума має бути числом.
config-error-no-currencies-on-server = На сервері валюти не налаштовано.
config-error-currency-not-found-short = Валюту "{ $currency }" не знайдено.
config-error-denomination-not-found = Номінал "{ $denomination }" не знайдено в конфігурації валюти.

# RoleplaySettingsModal
config-modal-title-rp-settings = Налаштування рольової гри
config-modal-label-min-message-length = Мінімальна довжина повідомлення (символів)
config-modal-placeholder-min-message-length = Кількість символів, необхідних для визнання повідомлення. 0 для без обмежень
config-modal-label-cooldown = Перезарядка (секунд)
config-modal-placeholder-cooldown = Час очікування в секундах між зарахуванням повідомлень як придатних для нагород
config-modal-label-message-threshold = Поріг повідомлень
config-modal-placeholder-message-threshold = Кількість повідомлень, необхідних для активації нагороди
config-modal-label-frequency = Частота (кількість повідомлень)
config-modal-placeholder-frequency = Кількість придатних повідомлень, необхідних для отримання нагород
config-error-min-length-invalid = Мінімальна довжина повідомлення має бути невід'ємним цілим числом.
config-error-cooldown-invalid = Перезарядка має бути невід'ємним цілим числом.
config-error-threshold-invalid = Поріг повідомлень має бути додатнім цілим числом.
config-error-frequency-invalid = Частота має бути додатнім цілим числом.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Налаштувати нагороди за рольову гру
config-modal-label-items-name-quantity = Предмети (Назва: Кількість)
config-modal-label-currency-name-amount = Валюта (Назва: Сума)
config-error-experience-non-negative = Досвід має бути невід'ємним цілим числом.
config-error-item-quantity-positive-named = Кількість предмета "{ $itemName }" має бути додатнім цілим числом.
config-error-currency-amount-positive = Сума валюти "{ $currencyName }" має бути додатнім числом.

# SetItemStockModal
config-modal-title-stock-limit = Обмеження запасів: { $itemName }
config-modal-label-max-stock = Максимальний запас
config-modal-placeholder-max-stock = Введіть максимальний запас (напр., 10)
config-modal-label-current-stock = Поточний запас
config-modal-placeholder-current-stock = Введіть поточний доступний запас
config-modal-label-restock-increment = Крок поповнення (за цикл)
config-modal-placeholder-restock-increment = Кількість за цикл поповнення (за замовчуванням: 1)
config-error-max-stock-positive = Максимальний запас має бути додатнім цілим числом.
config-error-current-stock-non-negative = Поточний запас має бути невід'ємним цілим числом.
config-error-current-exceeds-max = Поточний запас не може перевищувати максимальний.
config-error-item-not-in-shop = Предмет "{ $itemName }" не знайдено в магазині.

# RestockScheduleModal
config-modal-title-restock-schedule = Налаштувати розклад поповнення
config-modal-restock-schedule-label = Розклад
config-modal-restock-schedule-none = Немає (Вимкнено)
config-modal-restock-schedule-hourly = Щогодини
config-modal-restock-schedule-daily = Щоденно
config-modal-restock-schedule-weekly = Щотижня
config-modal-label-time = Час (ГГ:ХХ у UTC)
config-modal-desc-current-time = Поточний час: { $utcTime }
config-modal-placeholder-time = напр., 14:30 для 14:30 UTC
config-modal-restock-day-label = День тижня (лише щотижня)
config-modal-restock-mode-label = Режим поповнення
config-modal-restock-mode-full = Повне (скидання до максимуму)
config-modal-restock-mode-incremental = Поступове (додати кількість)
config-error-time-format-invalid = Час має бути у форматі ГГ:ХХ (напр., 14:30).
config-error-increment-positive = Кількість поповнення має бути додатнім цілим числом.

# ==========================================
# ВИБІРКИ
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Знайдіть ваш канал { $configName }

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Оберіть роль для оголошення квестів

# AddGMRoleSelect
config-select-placeholder-gm-roles = Оберіть роль(і) GM

# ConfigWaitListSelect
config-select-placeholder-wait-list = Оберіть розмір списку очікування
config-select-option-disabled = 0 (Вимкнено)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Оберіть режим інвентарю
config-select-option-disabled-label = Вимкнено
config-select-desc-disabled = Гравці починають з порожніми інвентарями.
config-select-option-selection = Вибір
config-select-desc-selection = Гравці вільно обирають предмети з магазину нового персонажа.
config-select-option-purchase = Покупка
config-select-desc-purchase = Гравці купують предмети з магазину нового персонажа за задану суму валюти.
config-select-option-open = Відкритий
config-select-desc-open = Гравці вручну вводять свої інвентарі.
config-select-option-static = Статичний
config-select-desc-static = Гравці отримують заздалегідь визначений стартовий інвентар.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Оберіть придатні канали

# RoleplayModeSelect
config-select-placeholder-rp-mode = Оберіть режим
config-select-option-scheduled = За розкладом
config-select-desc-scheduled = Нагороди надаються один раз протягом вказаного періоду скидання.
config-select-option-accrued = Накопичувальний
config-select-desc-accrued = Нагороди надаються повторно на основі вказаних рівнів активності.

# RoleplayResetSelect
config-select-placeholder-reset-period = Оберіть період скидання
config-select-option-hourly = Щогодини
config-select-desc-hourly = Скидається щогодини.
config-select-option-daily = Щоденно
config-select-desc-daily = Скидається кожні 24 години.
config-select-option-weekly = Щотижня
config-select-desc-weekly = Скидається кожні 7 днів.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Оберіть день скидання

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Оберіть час скидання (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Оберіть форумний канал

# ForumThreadSelect
config-select-placeholder-thread = Оберіть тему
config-select-option-no-threads = Активних тем не знайдено
config-select-desc-no-threads = Створіть нову тему або перевірте архівовані теми
config-select-option-select-forum-first = Спочатку оберіть форум
config-select-desc-select-forum-first = Будь ласка, оберіть форумний канал вище
config-select-desc-thread-id = ID теми: { $threadId }
config-error-select-valid-thread = Будь ласка, оберіть дійсну тему або створіть нову.
config-error-thread-not-found = Не вдалося знайти обрану тему. Можливо, вона була видалена або архівована.

# ==========================================
# ПОДАННЯ
# ==========================================

## Головне меню
config-title-main-menu = Конфігурація сервера - Головне меню
config-menu-config-wizard = Майстер налаштування
config-menu-desc-config-wizard = Перевірте готовність сервера до використання ReQuest за допомогою швидкого сканування.
config-menu-channels = Канали
config-menu-desc-channels = Встановити призначені канали для публікацій ReQuest.
config-menu-currency = Валюта
config-menu-desc-currency = Глобальні налаштування валюти.
config-menu-players = Гравці
config-menu-desc-players = Глобальні налаштування гравців, такі як відстеження очок досвіду.
config-menu-quests = Квести
config-menu-desc-quests = Глобальні налаштування квестів, такі як списки очікування.
config-menu-rp-rewards = Нагороди за РП
config-menu-desc-rp-rewards = Налаштувати нагороди за рольову гру.
config-menu-roles = Ролі
config-menu-desc-roles = Параметри конфігурації для згадуваних або привілейованих ролей.
config-menu-shops = Магазини
config-menu-desc-shops = Налаштувати користувацькі магазини.
config-menu-language = Мова
config-menu-desc-language = Встановити мову за замовчуванням для цього сервера.

## Подання майстра
config-title-wizard = {"**"}Конфігурація сервера - Майстер{"**"}
config-wizard-intro =
    {"**"}Ласкаво просимо до Майстра конфігурації ReQuest!{"**"}

    Цей майстер допоможе вам переконатися, що ваш сервер правильно налаштовано для використання функцій ReQuest.
    Він просканує ваші поточні налаштування та надасть рекомендації щодо необхідних змін.

    Натисніть кнопку "Запустити сканування" нижче, щоб розпочати процес перевірки. Після завершення сканування
    ви отримаєте детальний звіт про конфігурацію вашого сервера разом з рекомендованими змінами.

# Майстер - Перевірка дозволів бота
config-wizard-bot-permissions-header = __{"**"}Глобальні дозволи бота{"**"}__
config-wizard-bot-permissions-desc = Цей розділ перевіряє, чи має ReQuest правильні дозволи для коректної роботи.
config-wizard-bot-role = Роль бота: { $roleMention }
config-wizard-status-warnings = {"**"}Статус: ⚠️ ЗНАЙДЕНО ПОПЕРЕДЖЕННЯ{"**"}
config-wizard-missing-perm = - ⚠️ Відсутній: `{ $permissionName }`
config-wizard-ensure-permissions = Будь ласка, переконайтесь, що найвища роль бота має ці дозволи надані глобально.
config-wizard-status-ok = {"**"}Статус: ✅ ОК{"**"}
config-wizard-bot-permissions-ok = Бот має всі необхідні глобальні дозволи.
config-wizard-status-scan-failed = {"**"}Статус: ❌ СКАНУВАННЯ НЕ ВДАЛОСЯ{"**"}
config-wizard-scan-error = Виникла неочікувана помилка під час перевірки дозволів бота.
config-wizard-error-type = Помилка: { $errorType }
config-wizard-required-permissions = {"**"}Необхідні дозволи для ролі бота:{"**"}

# Майстер - Назви дозволів
config-wizard-perm-view-channels = Переглядати канали
config-wizard-perm-manage-roles = Керувати ролями
config-wizard-perm-send-messages = Надсилати повідомлення
config-wizard-perm-attach-files = Прикріплювати файли
config-wizard-perm-add-reactions = Додавати реакції
config-wizard-perm-use-external-emoji = Використовувати зовнішні емодзі
config-wizard-perm-manage-messages = Керувати повідомленнями
config-wizard-perm-read-message-history = Читати історію повідомлень

# Майстер - Перевірка ролей
config-wizard-role-header = __{"**"}Конфігурації ролей{"**"}__
config-wizard-role-desc =
    Цей розділ перевіряє наступне:

    - Ролі GM (обов'язкові) та роль оголошень (необов'язкова) налаштовано.
    - Роль за замовчуванням (@everyone) має необхідні дозволи для доступу користувачів до функцій бота.
    - Роль за замовчуванням (@everyone) не має небезпечних дозволів.
    - Ролі GM та оголошень перевіряються на наявність ескалації дозволів понад роль за замовчуванням.

    Будь-які попередження тут є виключно рекомендаціями на основі стандартного налаштування. Залежно від потреб вашого сервера, у вас можуть бути підстави ігнорувати деякі з цих рекомендацій.

config-wizard-default-role-label = {"**"}Роль за замовчуванням:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Знайдено небезпечні дозволи:
config-wizard-default-role-ok = - ✅ @everyone: ОК
config-wizard-missing-permission = - Відсутній дозвіл: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}Ролі GM:{"**"}
config-wizard-no-gm-roles = - ⚠️ Ролі GM не налаштовано
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Налаштовану роль не знайдено/видалено з сервера
config-wizard-role-ok = - ✅ { $roleMention }: ОК
config-wizard-announcement-role-label = {"**"}Роль оголошень:{"**"}
config-wizard-no-announcement-role = - ℹ️ Роль оголошень не налаштовано
config-wizard-announcement-role-not-found = - ⚠️ Налаштовану роль не знайдено/видалено з сервера
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Виявлено ескалацію дозволів - { $escalations }
config-wizard-escalation-more = , та ще { $count }...

# Майстер - Необхідні дозволи за замовчуванням
config-wizard-perm-send-messages-in-threads = Надсилати повідомлення в темах
config-wizard-perm-use-application-commands = Використовувати команди додатків

# Майстер - Небезпечні дозволи
config-wizard-perm-manage-channels = Керувати каналами
config-wizard-perm-manage-webhooks = Керувати вебхуками
config-wizard-perm-manage-server = Керувати сервером
config-wizard-perm-manage-nicknames = Керувати псевдонімами
config-wizard-perm-kick-members = Виключати учасників
config-wizard-perm-ban-members = Банити учасників
config-wizard-perm-timeout-members = Тайм-аут учасників
config-wizard-perm-mention-everyone = Згадувати @everyone
config-wizard-perm-manage-threads = Керувати темами
config-wizard-perm-administrator = Адміністратор

# Майстер - Перевірка каналів
config-wizard-channel-header = __{"**"}Конфігурації каналів{"**"}__
config-wizard-channel-desc =
    Цей розділ перевіряє наступне:

    - Налаштовані канали існують.
    - Бот має дозвіл переглядати та надсилати повідомлення в налаштованих каналах.
    - Роль за замовчуванням (@everyone) не має дозволу `Надсилати повідомлення`.

config-wizard-channel-no-config-required = - ⚠️ Канал не налаштовано
config-wizard-channel-not-configured = - ℹ️ Не налаштовано (Необов'язково)
config-wizard-channel-not-found = - ⚠️ Налаштований канал не знайдено/видалено з сервера
config-wizard-channel-ok = - ✅ ОК
config-wizard-bot-cannot-view = - ⚠️ { $botMention } не може переглядати цей канал.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } не може надсилати повідомлення в цей канал.
config-wizard-everyone-can-send = - ⚠️ @everyone може надсилати повідомлення в цей канал.

# Майстер - Назви каналів
config-wizard-channel-quest-board = Дошка квестів
config-wizard-channel-player-board = Дошка гравців
config-wizard-channel-quest-archive = Архів квестів
config-wizard-channel-gm-transaction-log = Журнал транзакцій GM
config-wizard-channel-player-transaction-log = Журнал транзакцій гравців
config-wizard-channel-shop-log = Журнал магазину
config-wizard-channel-approval-queue = Черга схвалення персонажів

# Майстер - Інформаційна панель
config-wizard-dashboard-header = __{"**"}Інформаційна панель налаштувань{"**"}__
config-wizard-dashboard-desc = Цей розділ надає огляд неосновних конфігурацій для швидкого ознайомлення.
config-wizard-quest-settings = {"**"}Налаштування квестів{"**"}
config-wizard-quest-wait-list = - Розмір списку очікування квестів: { $size }
config-wizard-quest-summary = - Підсумок квесту: { $status }
config-wizard-gm-rewards-per-quest = {"**"}Нагороди GM (за квест){"**"}
config-wizard-player-settings = {"**"}Налаштування гравців{"**"}
config-wizard-player-experience = - Досвід гравця: { $status }
config-wizard-currency-settings = {"**"}Налаштування валюти{"**"}
config-wizard-rp-rewards = {"**"}Нагороди за рольову гру{"**"}
config-wizard-rp-status = - Статус: { $status }
config-wizard-rp-mode = - Режим: { $mode }
config-wizard-rp-channels = - Відстежувані канали: { $count }
config-wizard-shops = {"**"}Магазини{"**"}
config-wizard-shops-count = - Налаштовані магазини: { $count }
config-wizard-shops-more = - ...та ще { $count }
config-wizard-new-char-setup = {"**"}Налаштування нового персонажа{"**"}
config-wizard-inventory-type = - Тип інвентарю: { $type }
config-wizard-new-char-shop-items = - Предмети магазину нового персонажа: { $count }
config-wizard-static-kits = - Статичні набори: { $count }

# Майстер - Звіт про нагороди GM
config-wizard-no-currencies = - ℹ️ Валюти не налаштовано
config-wizard-configured-currencies = {"**"}Налаштовані валюти:{"**"}
config-wizard-no-denominations = - Номінали не налаштовано
config-wizard-gm-rewards-disabled = {"**"}Статус:{"**"} Вимкнено
config-wizard-gm-rewards-enabled = {"**"}Статус:{"**"} Увімкнено
config-wizard-gm-rewards-experience = - Досвід: { $xp }
config-wizard-gm-rewards-items = - Предмети:
config-wizard-unnamed-shop = Безіменний магазин

## Подання ролей
config-title-roles = {"**"}Конфігурація сервера - Ролі{"**"}
config-label-announcement-role = {"**"}Роль оголошень:{"**"} { $status }
config-desc-announcement-role = Ця роль згадується при публікації квесту.
config-label-announcement-role-default = {"**"}Роль оголошень:{"**"} Не налаштовано
config-label-gm-roles = {"**"}Роль(і) GM:{"**"} { $roles }
config-desc-gm-roles = Ці ролі надають доступ до команд та функцій Ведучого Гри.
config-label-gm-roles-default = {"**"}Роль(і) GM:{"**"} Не налаштовано
config-title-forbidden-roles = __{"**"}Заборонені ролі{"**"}__
config-desc-forbidden-roles =
    Налаштовує список назв ролей, які не можуть використовуватися Ведучими Гри для їхніх групових ролей.
    За замовчуванням `everyone`, `administrator`, `gm` та `game master` не можуть використовуватися. Ця конфігурація
    розширює цей список.

## Подання видалення ролей GM
config-title-remove-gm-roles = {"**"}Конфігурація сервера - Видалити роль(і) GM{"**"}
config-msg-no-gm-roles = Ролі GM не налаштовано.

## Подання каналів
config-title-channels = {"**"}Конфігурація сервера - Канали{"**"}

config-label-quest-board = {"**"}Дошка квестів:{"**"} { $channel }
config-desc-quest-board = Канал, де будуть публікуватися нові/активні квести.
config-label-quest-board-default = {"**"}Дошка квестів:{"**"} Не налаштовано

config-label-player-board = {"**"}Дошка гравців:{"**"} { $channel }
config-desc-player-board = Необов'язковий канал оголошень/повідомлень для використання гравцями.
config-label-player-board-default = {"**"}Дошка гравців:{"**"} Не налаштовано

config-label-quest-archive = {"**"}Архів квестів:{"**"} { $channel }
config-desc-quest-archive = Необов'язковий канал, куди переміщуються завершені квести з підсумковою інформацією.
config-label-quest-archive-default = {"**"}Архів квестів:{"**"} Не налаштовано

config-label-gm-transaction-log = {"**"}Журнал транзакцій GM:{"**"} { $channel }
config-desc-gm-transaction-log = Необов'язковий канал, де записуються транзакції GM (тобто команди "Modify Player").
config-label-gm-transaction-log-default = {"**"}Журнал транзакцій GM:{"**"} Не налаштовано

config-label-player-transaction-log = {"**"}Журнал транзакцій гравців:{"**"} { $channel }
config-desc-player-transaction-log = Необов'язковий канал, де записуються транзакції гравців, такі як обмін та використання предметів.
config-label-player-transaction-log-default = {"**"}Журнал транзакцій гравців:{"**"} Не налаштовано

config-label-shop-log = {"**"}Журнал магазину:{"**"} { $channel }
config-desc-shop-log = Необов'язковий канал, де записуються транзакції магазину.
config-label-shop-log-default = {"**"}Журнал магазину:{"**"} Не налаштовано

## Подання квестів
config-title-quests = {"**"}Конфігурація сервера - Квести{"**"}

config-label-wait-list = {"**"}Розмір списку очікування квестів:{"**"} { $size }
config-desc-wait-list = Список очікування дозволяє вказаній кількості гравців стати в чергу на квест, який заповнений, на випадок, якщо хтось покине.
config-label-wait-list-disabled = {"**"}Розмір списку очікування квестів:{"**"} Вимкнено

config-label-quest-summary = {"**"}Підсумок квесту:{"**"} { $status }
config-desc-quest-summary = Цей параметр дозволяє GM надавати короткий підсумок при завершенні квестів.
config-label-quest-summary-disabled = {"**"}Підсумок квесту:{"**"} Вимкнено

config-label-gm-rewards = Нагороди GM
config-desc-gm-rewards = Налаштувати нагороди для GM за завершення квестів.

## Подання нагород GM
config-title-gm-rewards = {"**"}Конфігурація сервера - Нагороди GM{"**"}
config-desc-gm-rewards-detail =
    {"**"}Додати/Змінити нагороди{"**"}
    Відкриває модальне вікно для додавання, зміни або видалення нагород GM.

    > Нагороди налаштовуються для кожного квесту. Кожного разу, коли Ведучий Гри завершує квест, він
    отримає налаштовані нижче нагороди на свого активного персонажа.
config-msg-no-rewards = Нагороди не налаштовано.
config-label-gm-experience = {"**"}Досвід:{"**"} { $xp }
config-label-gm-items = {"**"}Предмети:{"**"}

## Подання гравців
config-title-players = {"**"}Конфігурація сервера - Гравці{"**"}

config-label-player-experience = {"**"}Досвід гравця:{"**"} { $status }
config-desc-player-experience = Увімкнує/Вимкнує використання очок досвіду (або аналогічної системи прогресу персонажа на основі значень).
config-label-player-experience-disabled = {"**"}Досвід гравця:{"**"} Вимкнено

config-label-new-char-settings = {"**"}Налаштування нового персонажа{"**"}
config-desc-new-char-settings = Налаштувати параметри, пов'язані з новими персонажами гравців та їхніми початковими інвентарями.

config-label-player-board-purge = {"**"}Очищення дошки гравців{"**"}
config-desc-player-board-purge = Очищує публікації з дошки гравців (якщо увімкнено).

## Подання налаштувань нового персонажа
config-title-new-character = {"**"}Конфігурація сервера - Налаштування нового персонажа{"**"}

config-label-inventory-type = {"**"}Тип інвентарю нового персонажа:{"**"} { $type }
config-desc-inventory-type = Визначає, як новозареєстровані персонажі ініціалізують свої інвентарі.
config-label-inventory-type-disabled = {"**"}Тип інвентарю нового персонажа:{"**"} Вимкнено

config-label-new-char-wealth = {"**"}Стартове багатство нового персонажа:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Стартове багатство нового персонажа:{"**"} Вимкнено

config-label-approval-queue = {"**"}Черга схвалення:{"**"} { $channel }
config-desc-approval-queue = Якщо встановлено, нові персонажі повинні бути схвалені GM у цьому форумному каналі перед активацією.
config-label-approval-queue-disabled = {"**"}Черга схвалення:{"**"} Вимкнено
config-label-approval-queue-not-configured = {"**"}Черга схвалення:{"**"} Не налаштовано

# Описи типів інвентарю (використовуються при налаштуванні)
config-desc-inv-type-disabled = Гравці починають з порожніми інвентарями.
config-desc-inv-type-selection = Гравці вільно обирають предмети з магазину нового персонажа.
config-desc-inv-type-purchase = Гравці купують предмети з магазину нового персонажа за задану суму валюти.
config-desc-inv-type-open = Гравці вручну вводять свої предмети інвентарю.
config-desc-inv-type-static = Гравці отримують заздалегідь визначений стартовий інвентар.

## Подання магазину нового персонажа
config-title-new-char-shop = {"**"}Конфігурація сервера - Магазин нового персонажа{"**"}
config-label-inv-type-selection = {"**"}Тип інвентарю:{"**"} Вибір
config-desc-inv-type-selection-shop = Гравці вільно обирають предмети з магазину нового персонажа.
config-label-inv-type-purchase = {"**"}Тип інвентарю:{"**"} Покупка
config-desc-inv-type-purchase-shop = Гравці купують предмети з магазину нового персонажа за задану суму валюти.
config-label-inv-type-other = {"**"}Тип інвентарю:{"**"} { $type }
config-desc-inv-type-not-in-use = Магазин нового персонажа не використовується.
config-msg-define-shop-items = Визначте предмети магазину.
config-msg-no-items = Предмети не налаштовано.

## Подання статичних наборів
config-title-static-kits = {"**"}Конфігурація сервера - Статичні набори{"**"}
config-desc-create-kit = Створити нове визначення набору.
config-msg-no-kits = Набори не налаштовано.
config-label-kit-more-items = ...та ще { $count } предметів
config-label-empty-kit = {"*"}Порожній набір{"*"}

## Подання редагування статичного набору
config-title-editing-kit = {"**"}Редагування набору: { $kitName }{"**"}
config-msg-kit-empty = Цей набір порожній. Використовуйте кнопки вище для додавання валюти або предметів.
config-label-kit-currency = {"**"}Валюта:{"**"} { $display }
config-label-kit-item = {"**"}Предмет:{"**"} { $name }

## Подання валюти
config-title-currency = {"**"}Конфігурація сервера - Валюта{"**"}
config-desc-create-currency = Створити нову валюту.
config-msg-no-currencies = Валюти не налаштовано.
config-label-currency-display-type = Тип відображення: { $type } | Номінали: { $count }
config-label-currency-type-double = Дробовий
config-label-currency-type-integer = Цілочисловий

## Подання редагування валюти
config-title-manage-currency = {"**"}Керування валютою: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Валюта та номінали{"**"}__
    - Задана назва вашої валюти вважається базовою валютою зі значенням 1.
    {"```"}Приклад: "золото" налаштовано як валюта.{"```"}
    - Додавання номіналу вимагає вказання назви та значення відносно базової валюти.
    {"```"}Приклад: Золоту додано два номінали: срібло (значення 0.1) та мідь (значення 0.01).{"```"}
    - Будь-які транзакції з базовою валютою або її номіналами автоматично конвертуються.
    {"```"}Приклад: Гравець має 10 золота і витрачає 3 міді. Його новий баланс автоматично відобразиться як
    9 золота, 9 срібла та 7 міді.{"```"}
    - Валюти, що відображаються як цілочислові, показують кожен номінал, а валюти, що відображаються як дробові,
    показують лише базову валюту.
    {"```"}Приклад: Гравець вище з дробовим відображенням покаже 9.97 золота.{"```"}
config-btn-toggle-display-current = Перемкнути відображення (Поточне: { $type })
config-msg-no-denominations = Номінали не налаштовано.

## Подання магазинів
config-title-shops = {"**"}Конфігурація сервера - Магазини{"**"}
config-desc-add-shop-wizard =
    {"**"}Додати магазин (Майстер){"**"}
    Створити новий порожній магазин через форму.
config-desc-add-shop-json =
    {"**"}Додати магазин (JSON){"**"}
    Створити новий магазин, надавши повне JSON-визначення. (Розширено)
config-btn-example-json = Приклад JSON
config-desc-example-json =
    {"**"}Приклад JSON{"**"}
    Завантажте приклад файлу JSON, що показує очікуваний формат.
config-msg-example-json = Ось приклад файлу JSON, що показує очікуваний формат.
config-msg-no-shops = Магазини не налаштовано.
config-label-shop-type-forum = (Форум)
config-label-shop-channel = Канал: <#{ $channelId }>

## Подання вибору типу каналу магазину
config-title-choose-location = {"**"}Додати магазин - Оберіть тип розташування{"**"}
config-label-text-channel = {"**"}Текстовий канал{"**"}
config-desc-text-channel = Створити магазин у стандартному текстовому каналі.
config-label-forum-thread = {"**"}Тема форуму{"**"}
config-desc-forum-thread = Створити магазин у темі форуму (новій або існуючій).

## Подання налаштування магазину на форумі
config-title-forum-setup = {"**"}Додати магазин - Налаштування теми форуму{"**"}
config-label-step1 = {"**"}Крок 1: Оберіть форумний канал{"**"}
config-label-step2 = {"**"}Крок 2: Оберіть варіант теми{"**"}
config-label-step3 = {"**"}Крок 3: Оберіть існуючу тему{"**"}
config-desc-create-new-thread =
    {"**"}Створити нову тему{"**"}
    Відкриває форму для створення нової теми та налаштування магазину.
config-label-selected-thread = {"**"}Обрана тема:{"**"} { $threadName }
config-desc-click-to-configure = Натисніть для налаштування магазину в цій темі.

## Подання керування магазином
config-title-manage-shop = {"**"}Керування магазином: { $shopName }{"**"}
config-label-shop-type = {"**"}Тип:{"**"} { $type }
config-label-shop-type-text = Текстовий канал
config-label-shop-type-forum-thread = Тема форуму
config-label-shopkeeper = {"**"}Торговець:{"**"} { $name }
config-label-shop-description = {"**"}Опис:{"**"} { $description }
config-label-shop-channel-info = {"**"}Канал:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Редагувати деталі та предмети магазину через Майстер.
config-desc-upload-json = Завантажити нове JSON-визначення для цього магазину.
config-desc-download-json = Завантажити поточне JSON-визначення.
config-desc-remove-shop = Назавжди видалити цей магазин.

## Подання редагування магазину
config-title-editing-shop = {"**"}Редагування магазину: { $shopName }{"**"}
config-label-shop-shopkeeper = Торговець: {"**"}{ $name }{"**"}

## Подання обмежень запасів
config-title-stock-config = {"**"}Конфігурація запасів: { $shopName }{"**"}
config-label-current-utc = Поточний час UTC: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Розклад поповнення:{"**"} { $schedule }
config-label-restock-hourly = о хвилині :{ $minute }
config-label-restock-daily = о { $time } UTC
config-label-restock-weekly = у { $day } о { $time } UTC
config-label-restock-mode = {"**"}Режим:{"**"} { $mode }
config-label-restock-full = Повне поповнення
config-label-restock-incremental = Поступове (кількість за предметом)
config-label-restock-disabled = {"**"}Розклад поповнення:{"**"} Вимкнено
config-label-item-stock-limits = {"**"}Обмеження запасів предметів{"**"}
config-msg-no-items-in-shop = У цьому магазині немає предметів.
config-label-stock-with-available = Макс.: { $max } | Доступно: { $available }
config-label-stock-increment = Поповнення: +{ $increment }/цикл
config-label-stock-reserved =  | Зарезервовано: { $reserved }
config-label-stock-not-initialized = Макс.: { $max } | Доступно: (не ініціалізовано)
config-label-stock-unlimited = Запас: Необмежений

## Подання рольової гри
config-title-roleplay = {"**"}Конфігурація сервера - Нагороди за рольову гру{"**"}
config-label-rp-status = {"**"}Статус:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Час сервера:{"**"} `{ $time }`
config-label-rp-enabled = Увімкнено
config-label-rp-disabled = Вимкнено

config-desc-rp-mode-scheduled = {"```"}Нагороди розподіляються один раз після надсилання необхідної кількості придатних повідомлень протягом встановленого періоду часу (щогодини, щоденно або щотижня).{"```"}
config-desc-rp-mode-accrued = {"```"}Нагороди розподіляються на постійній основі щоразу, коли надсилається встановлена кількість придатних повідомлень.{"```"}

config-label-rp-config-details = {"**"}Деталі конфігурації:{"**"}
config-label-rp-mode = {"**"}Режим:{"**"} { $mode }
config-label-rp-min-length = {"**"}Мінімальна довжина повідомлення:{"**"} { $length } символів
config-label-rp-cooldown = {"**"}Перезарядка:{"**"} { $seconds } секунд
config-label-rp-frequency-once = {"**"}Частота:{"**"} Раз на { $period }
config-label-rp-reset-time = {"**"}Час скидання:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Поріг:{"**"} { $count } придатних повідомлень
config-label-rp-frequency-every = {"**"}Частота:{"**"} Кожні { $count } придатних повідомлень

config-label-rp-channels = {"**"}Канали рольової гри:{"**"}
config-msg-rp-no-channels = Не налаштовано.
config-label-rp-channels-more = ...та ще { $count }.

config-label-rp-rewards = {"**"}Нагороди:{"**"}
config-msg-rp-no-rewards = Не налаштовано.
config-label-rp-experience = {"**"}Досвід:{"**"} { $xp }
config-label-rp-items = {"**"}Предмети:{"**"}
config-label-rp-currency = {"**"}Валюта:{"**"}

## Подання мови
config-title-language = {"**"}Конфігурація сервера - Мова{"**"}
config-server-language-help =
    Цей параметр дозволяє вказати мову за замовчуванням для {"**"}публічних{"**"} відповідей та повідомлень ReQuest на цьому сервері. Публічні відповіді включають:
    - Публікації на дошці квестів та дошці гравців
    - Підсумки квестів та повідомлення в журнальних каналах
    - Поповнення магазину
    - Використання предметів гравцями

    Цей параметр впливає лише на статичний текст, створений ботом, і не перекладає динамічний вміст, такий як введені користувачем назви предметів або описи квестів.

    Персональні відповіді та меню не залежать від цього параметра.
config-label-server-language = {"**"}Мова сервера:{"**"} { $language }
config-label-server-language-default = {"**"}Мова сервера:{"**"} За замовчуванням (без перевизначення)
config-select-placeholder-server-language = Оберіть мову сервера
config-select-option-default = За замовчуванням (без перевизначення)
config-select-desc-default = Використовувати налаштування кожного користувача або мову Discord.

# Quest Roles
config-btn-quest-roles = Ролі квестів
config-btn-manage-gm-quest-roles = Керувати

config-modal-title-confirm-quest-role-removal = Підтвердити видалення ролі
config-modal-label-remove-quest-role = Видалити { $roleName } у { $gmName }?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Оберіть режим ролей квестів
config-select-option-quest-role-disabled = Вимкнено
config-select-desc-quest-role-disabled = Ролі не створюються та не призначаються.
config-select-option-quest-role-temporary = Тимчасовий
config-select-desc-quest-role-temporary = Ведучі Гри можуть створювати тимчасові ролі для кожного квесту.
config-select-option-quest-role-static = Статичний
config-select-desc-quest-role-static = Ведучі Гри обирають з попередньо призначених ролей сервера.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Призначити роль(ролі) сервера цьому Ведучому Гри

## Quest Roles View
config-title-quest-roles = {"**"}Конфігурація сервера - Ролі квестів{"**"}
config-label-quest-roles = Ролі квестів
config-desc-quest-roles =
    Налаштуйте, як ролі групи обробляються під час квестів.

config-label-quest-role-mode-disabled = {"**"}Режим ролей квестів:{"**"} Вимкнено
    Під час квестів ролі не створюються та не призначаються.
config-label-quest-role-mode-temporary = {"**"}Режим ролей квестів:{"**"} Тимчасовий
    Ведучі Гри можуть за бажанням створити тимчасову роль під час створення квесту.
    Роль видаляється після завершення або скасування квесту.
config-label-quest-role-mode-static = {"**"}Режим ролей квестів:{"**"} Статичний
    Ведучі Гри обирають з попередньо призначених ролей сервера. Ролі
    призначаються членам групи під час квестів, але ніколи не видаляються.

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}Конфігурація сервера - Призначення статичних ролей квестів{"**"}
config-label-manage-assignments = Керування призначенням ролей
config-desc-manage-assignments =
    Призначте існуючі ролі сервера Ведучим Гри для використання під час квестів.
    Ролі мають бути нижче найвищої ролі ReQuest в ієрархії сервера.
config-msg-no-gm-members = На цьому сервері не знайдено учасників з роллю Ведучого Гри.
config-label-no-roles-assigned = Ролі квестів не призначені

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}Керування ролями квестів — { $gmName }{"**"}
config-error-unmanageable-roles = Наступні ролі не можуть бути призначені, оскільки вони керуються інтеграцією, є роллю за замовчуванням або розташовані вище найвищої ролі ReQuest: { $roles }
config-error-quest-role-limit = Цей Ведучий Гри досяг максимуму в { $limit } призначених ролей квестів.
config-label-quest-role-count = Призначені ролі: { $count }/{ $limit }
