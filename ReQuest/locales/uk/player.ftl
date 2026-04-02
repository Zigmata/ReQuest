## Рядки модуля гравця

# --- Ког ---

player-cmd-name = Обмін
player-cmd-desc = Меню гравця

# --- Кнопки ---

# Керування персонажем
player-btn-register-character = Зареєструвати нового персонажа
player-btn-activate = Активувати
player-btn-active = Активний

# Дошка гравців
player-btn-create-post = Створити публікацію
player-btn-open-starting-shop = Відкрити стартовий магазин
player-btn-select-kit = Обрати набір
player-btn-input-inventory = Ввести інвентар

# Кнопки майстра / магазину
player-btn-add-to-cart = Додати до кошика
player-btn-add-to-cart-cost = Додати до кошика ({ $costString })
player-btn-view-purchase-options = Переглянути варіанти покупки
player-btn-review-submit = Переглянути й надіслати ({ $count })
player-btn-submit-character = Надіслати персонажа
player-btn-keep-shopping = Продовжити покупки
player-btn-edit-quantity = Змінити кількість
player-btn-clear-cart = Очистити кошик

# Кнопки наборів
player-btn-confirm-selection = Підтвердити вибір
player-btn-back-to-kits = Назад до наборів

# Керування інвентарем
player-btn-spend-currency = Витратити валюту
player-btn-print-inventory = Друкувати інвентар

# Керування контейнерами
player-btn-manage-containers = Керувати контейнерами
player-btn-create-new = + Створити новий
player-btn-consume-destroy = Використати/Знищити
player-btn-move = Перемістити
player-btn-move-all = Перемістити все
player-btn-move-some = Перемістити частину...
player-btn-back-to-overview = ← Назад до огляду
player-btn-cancel-move = ← Скасувати
player-btn-up = ▲ Вгору
player-btn-down = ▼ Вниз

# --- Модальні вікна ---

# Модальне вікно обміну
player-modal-title-trade = Обмін з { $targetName }
player-modal-label-trade-name = Назва
player-modal-placeholder-trade-name = Введіть назву предмета, яким ви обмінюєтесь
player-modal-label-trade-quantity = Кількість
player-modal-placeholder-trade-quantity = Введіть кількість для обміну

# Модальне вікно реєстрації персонажа
player-modal-title-register = Зареєструвати нового персонажа
player-modal-label-char-name = Ім'я
player-modal-placeholder-char-name = Введіть ім'я вашого персонажа.
player-modal-label-char-note = Примітка
player-modal-placeholder-char-note = Введіть примітку для ідентифікації вашого персонажа

# Модальне вікно введення відкритого інвентарю
player-modal-title-starting-inventory = Введення стартового інвентарю
player-modal-label-inventory = Інвентар
player-modal-placeholder-inventory-input =
    По одному на рядок у форматі <назва>: <кількість>, напр.:
    Меч: 1
    gold: 30

# Модальне вікно витрати валюти
player-modal-title-spend-currency = Витратити валюту
player-modal-label-currency-name = Назва валюти
player-modal-placeholder-currency-name = Введіть назву валюти, яку ви витрачаєте
player-modal-label-currency-amount = Сума
player-modal-placeholder-currency-amount = Введіть суму для витрати

# Модальне вікно створення публікації гравця
player-modal-title-create-post = Створити публікацію на дошці гравців
player-modal-label-post-title = Заголовок
player-modal-placeholder-post-title = Введіть заголовок для вашої публікації
player-modal-label-post-content = Зміст публікації
player-modal-placeholder-post-content = Введіть текст вашої публікації

# Модальне вікно редагування публікації гравця
player-modal-title-edit-post = Редагувати публікацію на дошці гравців

# Модальне вікно редагування кількості в кошику
player-modal-title-edit-cart-qty = Змінити кількість у кошику
player-modal-label-cart-qty = Кількість
player-modal-placeholder-cart-qty = Введіть нову кількість (0 для видалення)

# Модальне вікно створення контейнера
player-modal-title-create-container = Створити новий контейнер
player-modal-label-container-name = Назва контейнера
player-modal-placeholder-container-name = Введіть назву контейнера (напр., Рюкзак)

# Модальне вікно перейменування контейнера
player-modal-title-rename-container = Перейменувати контейнер
player-modal-label-new-container-name = Нова назва контейнера
player-modal-placeholder-new-container-name = Введіть нову назву

# Модальне вікно використання з контейнера
player-modal-title-consume = Використати/Знищити предмет
player-modal-label-consume-qty = Кількість (макс.: { $maxQuantity })
player-modal-placeholder-consume-qty = Введіть кількість для використання/знищення

# Модальне вікно переміщення предмета
player-modal-title-move-item = Перемістити предмет
player-modal-label-move-qty = Кількість для переміщення (макс.: { $maxQuantity })
player-modal-placeholder-move-qty = Введіть кількість для переміщення

# --- Вибірки ---

player-select-placeholder-no-characters = У вас немає зареєстрованих персонажів
player-select-placeholder-remove-character = Оберіть персонажа для видалення
player-select-placeholder-post = Оберіть публікацію
player-select-placeholder-container-view = Оберіть контейнер для перегляду...
player-select-placeholder-item = Оберіть предмет...
player-select-placeholder-destination = Оберіть місце призначення...
player-select-placeholder-container = Оберіть контейнер...
player-select-option-no-containers = Немає контейнерів
player-select-option-no-items = Немає предметів
player-select-option-no-destinations = Немає місць призначення

# --- Подання ---

# PlayerBaseView - Головне меню
player-title-main-menu = {"**"}Команди гравця - Головне меню{"**"}
player-menu-btn-characters = Персонажі
player-menu-desc-characters = Реєструвати, переглядати та активувати персонажів гравця.
player-menu-btn-inventory = Інвентар
player-menu-desc-inventory = Переглядати інвентар активного персонажа та витрачати валюту.
player-menu-btn-player-board = Дошка гравців
player-menu-btn-player-board-disabled = Дошка гравців (Не налаштовано)
player-menu-desc-player-board = Створити публікацію для дошки гравців

# CharacterBaseView
player-title-characters = {"**"}Команди гравця - Персонажі{"**"}
player-desc-register-character = Зареєструвати нового персонажа.
player-msg-no-characters = У вас немає зареєстрованих персонажів.
player-label-active = (Активний)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Персонаж у процесі: { $characterName }{"**"}
    Реєстрація вашого персонажа очікує на налаштування інвентарю.
player-btn-resume = Продовжити
player-btn-discard = Скасувати
player-modal-title-discard-character = Скасувати персонажа
player-modal-label-discard-confirm = Скасувати { $characterName }?

# Підтвердження видалення персонажа
player-modal-title-confirm-char-removal = Підтвердження видалення персонажа
player-modal-label-confirm-char-delete = Видалити { $characterName }?

# Підтвердження видалення публікації
player-modal-title-confirm-post-removal = Підтвердження видалення публікації
player-modal-label-post-removal-warning = УВАГА: Ця дія незворотна!

# InventoryOverviewView
player-title-inventory = {"**"}Команди гравця - Інвентар{"**"}
player-title-char-inventory = {"**"}Інвентар { $characterName }{"**"}
player-msg-no-active-character = Немає активного персонажа: Активуйте персонажа для цього сервера, щоб використовувати ці меню.
player-msg-no-characters-registered = Немає персонажів: Зареєструйте персонажа, щоб використовувати ці меню.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } предметів
player-label-currency = {"**"}Валюта{"**"}
player-msg-inventory-empty = Інвентар порожній.

# Вбудоване повідомлення друку інвентарю
player-embed-title-inventory = Інвентар { $characterName }

# ContainerItemsView
player-msg-container-empty = Цей контейнер порожній.
player-label-selected-item = Обрано: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Перемістити "{ $itemName }"{"**"} ({ $available } доступно)
player-msg-no-other-containers = Немає інших доступних контейнерів.
player-msg-select-destination = Оберіть контейнер призначення:
player-label-destination = Призначення: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Керування контейнерами{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } предметів){ $suffix }
player-label-default-suffix = { " " }(за замовчуванням)
player-msg-no-containers = Немає контейнерів.
player-label-selected-container = Обрано: {"**"}{ $containerName }{"**"}

# Підтвердження видалення контейнера
player-modal-title-confirm-container-delete = Підтвердження видалення контейнера
player-modal-label-container-has-items = Містить { $itemCount } предметів. Буде переміщено до Вільних предметів.
player-modal-label-confirm-container-delete = Видалити "{ $containerName }"?

# Помилки контейнерів
player-error-cannot-rename-loose = Неможливо перейменувати Вільні предмети.
player-error-cannot-delete-loose = Неможливо видалити Вільні предмети.

# PlayerBoardView
player-title-player-board = {"**"}Команди гравця - Дошка гравців{"**"}
player-desc-create-post = Створити нову публікацію для дошки гравців.
player-msg-no-posts = У вас немає поточних публікацій.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Автор
player-embed-footer-post-id = ID публікації: { $postId }
player-error-board-channel-not-found = Канал дошки гравців не знайдено.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Налаштування інвентарю для { $characterName }{"**"}
player-desc-browse-shop = Перегляньте стартовий магазин для спорядження вашого персонажа.
player-desc-select-kit = Оберіть стартовий набір.
player-desc-input-inventory = Вручну введіть ваш стартовий інвентар.

# StaticKitSelectView
player-title-select-kit = {"**"}Оберіть набір для { $characterName }{"**"}
player-msg-no-kits = Стартові набори недоступні.
player-label-and-more-items = ...та ще { $count } предметів
player-label-empty-kit = {"*"}Порожній набір{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Підтвердити вибір: { $kitName }{"**"}
player-label-items-heading = {"**"}Предмети:{"**"}
player-label-currency-heading = {"**"}Валюта:{"**"}
player-msg-kit-empty = Цей набір порожній.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Варіанти покупки: { $itemName }{"**"}
player-msg-no-cost-options = Для цього предмета немає доступних варіантів вартості.
player-label-cost-option = {"**"}Варіант { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Стартовий магазин ({ $inventoryType }){"**"}
player-label-starting-wealth = Стартове багатство: { $formattedCurrency }
player-label-in-cart = {"**"}(У кошику: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Перегляд кошика{"**"}
player-msg-cart-empty = Ваш кошик порожній.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Всього: { $totalQuantity })
player-label-insufficient-currency = Недостатньо { $currencyName }
player-label-total-cost = {"**"}Загальна вартість:{"**"}
player-label-total-cost-free = {"**"}Загальна вартість:{"**"} Безкоштовно
player-label-cart-page = Сторінка { $current } з { $total }

# Вбудоване повідомлення обміну
player-embed-title-trade = Звіт обміну
player-embed-desc-trade-sender = Відправник: { $senderMention } як `{ $senderCharacter }`
player-embed-desc-trade-recipient = Одержувач: { $recipientMention } як `{ $recipientCharacter }`
player-embed-field-currency = Валюта
player-embed-field-amount = Сума
player-embed-field-balance = Баланс { $characterName }
player-embed-field-item = Предмет
player-embed-field-quantity = Кількість
player-embed-footer-transaction-id = ID транзакції: { $transactionId }

# Помилки обміну
player-error-trade-no-characters = Гравець, з яким ви намагаєтесь обмінюватись, не має персонажів!
player-error-trade-no-active = Гравець, з яким ви намагаєтесь обмінюватись, не має активного персонажа на цьому сервері!

# Вбудоване повідомлення витрати валюти
player-embed-title-spend = Звіт транзакції гравця
player-embed-desc-spend-player = Гравець: { $playerMention } як `{ $characterName }`
player-embed-desc-spend-transaction = Транзакція: {"**"}{ $characterName }{"**"} витратив {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Канал
player-embed-field-receipt = Квитанція

# Помилки витрати валюти
player-error-amount-not-number = Сума має бути числом.
player-error-amount-positive = Ви повинні витратити додатну суму.
player-error-amount-exceeds-maximum = Сума не може перевищувати { $max }.
player-error-no-active-character-server = У вас немає активного персонажа на цьому сервері.
player-error-no-currency-config = Конфігурацію валюти для цього сервера не знайдено.

# Вбудоване повідомлення використання предмета
player-embed-title-consume = Звіт використання предмета
player-embed-desc-consume = Гравець: { $playerMention } як `{ $characterName }`
player-embed-desc-consume-removed = Видалено: {"**"}{ $quantity }x { $itemName }{"**"} з {"**"}{ $containerName }{"**"}

# Помилки використання предмета
player-error-qty-positive-integer = Кількість має бути додатнім цілим числом.
player-error-qty-at-least-one = Кількість має бути не менше 1.
player-error-qty-only-have = У вас лише { $maxQuantity } цього предмета.

# Помилки введення інвентарю
player-error-invalid-format = Недійсний формат: "{ $line }". Використовуйте <назва>: <кількість>.
player-error-empty-name = Назва предмета не може бути порожньою в рядку: "{ $line }".
player-error-invalid-quantity = Недійсна кількість для "{ $name }": "{ $quantity }". Має бути додатнім цілим числом.
player-error-input-errors-header = Помилки у введенні інвентарю:
player-msg-no-valid-items = Дійсних предметів не надано. Ініціалізація з порожнім інвентарем.

# Перевірка кількості в кошику
player-error-enter-valid-number = Будь ласка, введіть дійсне додатне число.

# Вбудовані повідомлення заявок (черга схвалення)
player-embed-title-approval = Схвалення інвентарю: { $characterName }
player-embed-desc-submitted-by = Надіслано { $userMention }
player-embed-field-items = Предмети
player-embed-field-currency-received = Валюта
player-embed-footer-submission-id = ID заявки: { $submissionId }
player-label-approval-thread = Схвалення: { $characterName }
player-embed-title-submission-sent = Заявку на інвентар надіслано
player-embed-desc-submission-sent =
    Вашу заявку для {"**"}{ $characterName }{"**"} надіслано команді GM на розгляд!
    Вас повідомлять, коли її буде переглянуто.
    [Переглянути тему заявки]({ $threadUrl })

# Вбудовані повідомлення прямого застосування (без черги схвалення)
player-embed-title-starting-inventory = Стартовий інвентар застосовано
player-embed-desc-starting-inventory = Гравець: { $playerMention } як `{ $characterName }`
player-embed-field-items-received = Отримані предмети
player-embed-field-currency-received-label = Отримана валюта
player-label-untitled = Без назви

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventory Submission: { $characterName }{"**"}
    Submitted by { $userMention }
player-approval-post-items = Предмети
player-approval-post-currency = Валюта
player-approval-resolved = Цю заявку було оброблено.
player-approval-btn-approve = Схвалити
player-approval-btn-deny = Відхилити
player-approval-btn-edit = Редагувати
player-approval-error-no-permission = У вас немає дозволу на цю дію.
player-approval-error-not-submitter = Тільки первісний відправник може редагувати цю заявку.
player-approval-thread-instructions =
    This thread was created for the approval of {"**"}{ $characterName }{"**"}.
    A Game Master will review the submission and approve or deny it.
    Once approved or denied, this thread will be locked.

    {"**"}Game Masters:{"**"} Discuss any required changes with your
    player until the inventory is in an acceptable state. Only use
    the `Deny` button for irreconcilable submissions.

    { $playerMention }: Use the `Edit` button to make any changes
    requested here by a Game Master.
player-approval-approved-by = Цю заявку було схвалено { $approver }.
player-approval-denied-by = Цю заявку було відхилено { $denier }.
player-approval-deny-reason = Причина: { $reason }
player-msg-submission-updated = Вашу заявку оновлено.


# Denial modal
player-modal-title-deny-reason = Відхилити заявку
player-modal-label-deny-reason = Причина відхилення
player-modal-placeholder-deny-reason = Необов'язково: поясніть причину відхилення
# Approval DM notifications
player-dm-title-approved = Персонаж схвалений
player-dm-desc-approved =
    Your character {"**"}{ $characterName }{"**"} has been approved
    by { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Персонаж відхилений
player-dm-desc-denied =
    Your character {"**"}{ $characterName }{"**"} has been denied
    by { $denier } in {"**"}{ $guildName }{"**"}.
