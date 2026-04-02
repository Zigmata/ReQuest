## Строки модуля игрока

# --- Когда ---

player-cmd-name = Обмен
player-cmd-desc = Меню игрока

# --- Кнопки ---

# Управление персонажами
player-btn-register-character = Зарегистрировать нового персонажа
player-btn-activate = Активировать
player-btn-active = Активен

# Доска игроков
player-btn-create-post = Создать пост
player-btn-open-starting-shop = Открыть стартовый магазин
player-btn-select-kit = Выбрать набор
player-btn-input-inventory = Ввести инвентарь

# Кнопки мастера / магазина
player-btn-add-to-cart = В корзину
player-btn-add-to-cart-cost = В корзину ({ $costString })
player-btn-view-purchase-options = Варианты покупки
player-btn-review-submit = Проверить и отправить ({ $count })
player-btn-submit-character = Отправить персонажа
player-btn-keep-shopping = Продолжить покупки
player-btn-edit-quantity = Изменить количество
player-btn-clear-cart = Очистить корзину

# Кнопки набора
player-btn-confirm-selection = Подтвердить выбор
player-btn-back-to-kits = Назад к наборам

# Управление инвентарём
player-btn-spend-currency = Потратить валюту
player-btn-print-inventory = Напечатать инвентарь

# Управление контейнерами
player-btn-manage-containers = Управление контейнерами
player-btn-create-new = + Создать новый
player-btn-consume-destroy = Использовать/Уничтожить
player-btn-move = Переместить
player-btn-move-all = Переместить всё
player-btn-move-some = Переместить часть...
player-btn-back-to-overview = ← Назад к обзору
player-btn-cancel-move = ← Отмена
player-btn-up = ▲ Вверх
player-btn-down = ▼ Вниз

# --- Модальные окна ---

# Модальное окно обмена
player-modal-title-trade = Обмен с { $targetName }
player-modal-label-trade-name = Название
player-modal-placeholder-trade-name = Введите название предмета для обмена
player-modal-label-trade-quantity = Количество
player-modal-placeholder-trade-quantity = Введите количество для обмена

# Модальное окно регистрации персонажа
player-modal-title-register = Регистрация нового персонажа
player-modal-label-char-name = Имя
player-modal-placeholder-char-name = Введите имя вашего персонажа.
player-modal-label-char-note = Заметка
player-modal-placeholder-char-note = Введите заметку для идентификации персонажа

# Модальное окно открытого ввода инвентаря
player-modal-title-starting-inventory = Ввод стартового инвентаря
player-modal-label-inventory = Инвентарь
player-modal-placeholder-inventory-input =
    По одному на строку в формате <название>: <количество>, напр.:
    Меч: 1
    gold: 30

# Модальное окно траты валюты
player-modal-title-spend-currency = Потратить валюту
player-modal-label-currency-name = Название валюты
player-modal-placeholder-currency-name = Введите название валюты, которую тратите
player-modal-label-currency-amount = Сумма
player-modal-placeholder-currency-amount = Введите сумму для траты

# Модальное окно создания поста на доске игроков
player-modal-title-create-post = Создание поста на доске игроков
player-modal-label-post-title = Заголовок
player-modal-placeholder-post-title = Введите заголовок для вашего поста
player-modal-label-post-content = Содержание поста
player-modal-placeholder-post-content = Введите текст вашего поста

# Модальное окно редактирования поста на доске игроков
player-modal-title-edit-post = Редактирование поста на доске игроков

# Модальное окно редактирования количества в корзине
player-modal-title-edit-cart-qty = Изменение количества в корзине
player-modal-label-cart-qty = Количество
player-modal-placeholder-cart-qty = Введите новое количество (0 для удаления)

# Модальное окно создания контейнера
player-modal-title-create-container = Создание нового контейнера
player-modal-label-container-name = Название контейнера
player-modal-placeholder-container-name = Введите название контейнера (напр., Рюкзак)

# Модальное окно переименования контейнера
player-modal-title-rename-container = Переименование контейнера
player-modal-label-new-container-name = Новое название контейнера
player-modal-placeholder-new-container-name = Введите новое название

# Модальное окно использования предмета из контейнера
player-modal-title-consume = Использовать/Уничтожить предмет
player-modal-label-consume-qty = Количество (макс: { $maxQuantity })
player-modal-placeholder-consume-qty = Введите количество для использования/уничтожения

# Модальное окно перемещения предмета
player-modal-title-move-item = Переместить предмет
player-modal-label-move-qty = Количество для перемещения (макс: { $maxQuantity })
player-modal-placeholder-move-qty = Введите количество для перемещения

# --- Выпадающие списки ---

player-select-placeholder-no-characters = У вас нет зарегистрированных персонажей
player-select-placeholder-remove-character = Выберите персонажа для удаления
player-select-placeholder-post = Выберите пост
player-select-placeholder-container-view = Выберите контейнер для просмотра...
player-select-placeholder-item = Выберите предмет...
player-select-placeholder-destination = Выберите назначение...
player-select-placeholder-container = Выберите контейнер...
player-select-option-no-containers = Нет контейнеров
player-select-option-no-items = Нет предметов
player-select-option-no-destinations = Нет доступных назначений

# --- Представления ---

# PlayerBaseView - Главное меню
player-title-main-menu = {"**"}Команды игрока - Главное меню{"**"}
player-menu-btn-characters = Персонажи
player-menu-desc-characters = Регистрация, просмотр и активация персонажей.
player-menu-btn-inventory = Инвентарь
player-menu-desc-inventory = Просмотр инвентаря активного персонажа и трата валюты.
player-menu-btn-player-board = Доска игроков
player-menu-btn-player-board-disabled = Доска игроков (Не настроена)
player-menu-desc-player-board = Создать пост на доске игроков

# CharacterBaseView
player-title-characters = {"**"}Команды игрока - Персонажи{"**"}
player-desc-register-character = Зарегистрировать нового персонажа.
player-msg-no-characters = У вас нет зарегистрированных персонажей.
player-label-active = (Активен)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Персонаж в процессе: { $characterName }{"**"}
    Регистрация вашего персонажа ожидает настройки инвентаря.
player-btn-resume = Продолжить
player-btn-discard = Отменить
player-modal-title-discard-character = Отменить персонажа
player-modal-label-discard-confirm = Отменить { $characterName }?

# Подтверждение удаления персонажа
player-modal-title-confirm-char-removal = Подтверждение удаления персонажа
player-modal-label-confirm-char-delete = Удалить { $characterName }?

# Подтверждение удаления поста
player-modal-title-confirm-post-removal = Подтверждение удаления поста
player-modal-label-post-removal-warning = ВНИМАНИЕ: Это действие необратимо!

# InventoryOverviewView
player-title-inventory = {"**"}Команды игрока - Инвентарь{"**"}
player-title-char-inventory = {"**"}Инвентарь { $characterName }{"**"}
player-msg-no-active-character = Нет активного персонажа: активируйте персонажа на этом сервере для использования этих меню.
player-msg-no-characters-registered = Нет персонажей: зарегистрируйте персонажа для использования этих меню.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } предметов
player-label-currency = {"**"}Валюта{"**"}
player-msg-inventory-empty = Инвентарь пуст.

# Встраиваемое сообщение печати инвентаря
player-embed-title-inventory = Инвентарь { $characterName }

# ContainerItemsView
player-msg-container-empty = Этот контейнер пуст.
player-label-selected-item = Выбрано: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Переместить "{ $itemName }"{"**"} ({ $available } доступно)
player-msg-no-other-containers = Нет других доступных контейнеров.
player-msg-select-destination = Выберите контейнер назначения:
player-label-destination = Назначение: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Управление контейнерами{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } предметов){ $suffix }
player-label-default-suffix = { " " }(по умолчанию)
player-msg-no-containers = Нет контейнеров.
player-label-selected-container = Выбран: {"**"}{ $containerName }{"**"}

# Подтверждение удаления контейнера
player-modal-title-confirm-container-delete = Подтверждение удаления контейнера
player-modal-label-container-has-items = Содержит { $itemCount } предметов. Они будут перемещены в неразложенные предметы.
player-modal-label-confirm-container-delete = Удалить "{ $containerName }"?

# Ошибки контейнеров
player-error-cannot-rename-loose = Нельзя переименовать неразложенные предметы.
player-error-cannot-delete-loose = Нельзя удалить неразложенные предметы.

# PlayerBoardView
player-title-player-board = {"**"}Команды игрока - Доска игроков{"**"}
player-desc-create-post = Создать новый пост на доске игроков.
player-msg-no-posts = У вас нет текущих постов.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Автор
player-embed-footer-post-id = ID поста: { $postId }
player-error-board-channel-not-found = Канал доски игроков не найден.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Настройка инвентаря для { $characterName }{"**"}
player-desc-browse-shop = Просмотрите стартовый магазин для экипировки персонажа.
player-desc-select-kit = Выберите стартовый набор.
player-desc-input-inventory = Введите стартовый инвентарь вручную.

# StaticKitSelectView
player-title-select-kit = {"**"}Выберите набор для { $characterName }{"**"}
player-msg-no-kits = Стартовые наборы недоступны.
player-label-and-more-items = ...и ещё { $count } предметов
player-label-empty-kit = {"*"}Пустой набор{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Подтверждение выбора: { $kitName }{"**"}
player-label-items-heading = {"**"}Предметы:{"**"}
player-label-currency-heading = {"**"}Валюта:{"**"}
player-msg-kit-empty = Этот набор пуст.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Варианты покупки: { $itemName }{"**"}
player-msg-no-cost-options = Для этого предмета нет доступных вариантов покупки.
player-label-cost-option = {"**"}Вариант { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Стартовый магазин ({ $inventoryType }){"**"}
player-label-starting-wealth = Начальное богатство: { $formattedCurrency }
player-label-in-cart = {"**"}(В корзине: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Проверка корзины{"**"}
player-msg-cart-empty = Ваша корзина пуста.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Итого: { $totalQuantity })
player-label-insufficient-currency = Недостаточно { $currencyName }
player-label-total-cost = {"**"}Итого:{"**"}
player-label-total-cost-free = {"**"}Итого:{"**"} Бесплатно
player-label-cart-page = Страница { $current } из { $total }

# Встраиваемое сообщение обмена
player-embed-title-trade = Отчёт об обмене
player-embed-desc-trade-sender = Отправитель: { $senderMention } как `{ $senderCharacter }`
player-embed-desc-trade-recipient = Получатель: { $recipientMention } как `{ $recipientCharacter }`
player-embed-field-currency = Валюта
player-embed-field-amount = Сумма
player-embed-field-balance = Баланс { $characterName }
player-embed-field-item = Предмет
player-embed-field-quantity = Количество
player-embed-footer-transaction-id = ID транзакции: { $transactionId }

# Ошибки обмена
player-error-trade-no-characters = У игрока, с которым вы пытаетесь обменяться, нет персонажей!
player-error-trade-no-active = У игрока, с которым вы пытаетесь обменяться, нет активного персонажа на этом сервере!

# Встраиваемое сообщение траты валюты
player-embed-title-spend = Отчёт о транзакции игрока
player-embed-desc-spend-player = Игрок: { $playerMention } как `{ $characterName }`
player-embed-desc-spend-transaction = Транзакция: {"**"}{ $characterName }{"**"} потратил(а) {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Канал
player-embed-field-receipt = Квитанция

# Ошибки траты валюты
player-error-amount-not-number = Сумма должна быть числом.
player-error-amount-positive = Сумма должна быть положительной.
player-error-amount-exceeds-maximum = Сумма не может превышать { $max }.
player-error-no-active-character-server = У вас нет активного персонажа на этом сервере.
player-error-no-currency-config = Конфигурация валюты для этого сервера не найдена.

# Встраиваемое сообщение потребления предмета
player-embed-title-consume = Отчёт о потреблении предмета
player-embed-desc-consume = Игрок: { $playerMention } как `{ $characterName }`
player-embed-desc-consume-removed = Удалено: {"**"}{ $quantity }x { $itemName }{"**"} из {"**"}{ $containerName }{"**"}

# Ошибки потребления предмета
player-error-qty-positive-integer = Количество должно быть положительным целым числом.
player-error-qty-at-least-one = Количество должно быть не менее 1.
player-error-qty-only-have = У вас только { $maxQuantity } этого предмета.

# Ошибки ввода инвентаря
player-error-invalid-format = Неверный формат: "{ $line }". Используйте <название>: <количество>.
player-error-empty-name = Название предмета не может быть пустым в строке: "{ $line }".
player-error-invalid-quantity = Неверное количество для "{ $name }": "{ $quantity }". Должно быть положительным целым числом.
player-error-input-errors-header = Ошибки во вводе инвентаря:
player-msg-no-valid-items = Допустимые предметы не указаны. Инвентарь инициализирован пустым.

# Validation error view
player-validation-error-title = Ошибки ввода
player-validation-btn-retry = Попробовать снова

# Проверка количества в корзине
player-error-enter-valid-number = Введите допустимое положительное число.

# Встраиваемые сообщения заявок (очередь одобрения)
player-embed-title-approval = Одобрение инвентаря: { $characterName }
player-embed-desc-submitted-by = Отправлено { $userMention }
player-embed-field-items = Предметы
player-embed-field-currency-received = Валюта
player-embed-footer-submission-id = ID заявки: { $submissionId }
player-label-approval-thread = Одобрение: { $characterName }
player-embed-title-submission-sent = Заявка на инвентарь отправлена
player-embed-desc-submission-sent =
    Ваша заявка на персонажа {"**"}{ $characterName }{"**"} отправлена команде GM на рассмотрение!
    Вы получите уведомление, когда она будет рассмотрена.
    [Просмотреть тему заявки]({ $threadUrl })

# Встраиваемые сообщения прямого применения (без очереди одобрения)
player-embed-title-starting-inventory = Стартовый инвентарь применён
player-embed-desc-starting-inventory = Игрок: { $playerMention } как `{ $characterName }`
player-embed-field-items-received = Полученные предметы
player-embed-field-currency-received-label = Полученная валюта
player-label-untitled = Без названия

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventory Submission: { $characterName }{"**"}
    Submitted by { $userMention }
player-approval-post-items = Предметы
player-approval-post-currency = Валюта
player-approval-resolved = Эта заявка была обработана.
player-approval-btn-approve = Одобрить
player-approval-btn-deny = Отклонить
player-approval-btn-edit = Редактировать
player-approval-error-no-permission = У вас нет разрешения на это действие.
player-approval-error-not-submitter = Только первоначальный отправитель может редактировать эту заявку.
player-approval-thread-instructions =
    This thread was created for the approval of {"**"}{ $characterName }{"**"}.
    A Game Master will review the submission and approve or deny it.
    Once approved or denied, this thread will be locked.

    {"**"}Game Masters:{"**"} Discuss any required changes with your
    player until the inventory is in an acceptable state. Only use
    the `Deny` button for irreconcilable submissions.

    { $playerMention }: Use the `Edit` button to make any changes
    requested here by a Game Master.
player-approval-approved-by = Эта заявка была одобрена { $approver }.
player-approval-denied-by = Эта заявка была отклонена { $denier }.
player-approval-deny-reason = Причина: { $reason }
player-msg-submission-updated = Ваша заявка обновлена.


# Denial modal
player-modal-title-deny-reason = Отклонить заявку
player-modal-label-deny-reason = Причина отклонения
player-modal-placeholder-deny-reason = Необязательно: объясните причину отклонения
# Approval DM notifications
player-dm-title-approved = Персонаж одобрен
player-dm-desc-approved =
    Your character {"**"}{ $characterName }{"**"} has been approved
    by { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Персонаж отклонён
player-dm-desc-denied =
    Your character {"**"}{ $characterName }{"**"} has been denied
    by { $denier } in {"**"}{ $guildName }{"**"}.
