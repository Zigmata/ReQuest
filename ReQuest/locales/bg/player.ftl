## Player module strings

# --- Cog ---

player-cmd-name = Търговия
player-cmd-desc = Менюта за играчи

# --- Buttons ---

# Character management
player-btn-register-character = Регистриране на нов персонаж
player-btn-activate = Активиране
player-btn-active = Активен

# Player board
player-btn-create-post = Създаване на публикация
player-btn-open-starting-shop = Отваряне на началния магазин
player-btn-select-kit = Избор на комплект
player-btn-input-inventory = Въвеждане на инвентар

# Wizard / shop buttons
player-btn-add-to-cart = Добавяне в кошницата
player-btn-add-to-cart-cost = Добавяне в кошницата ({ $costString })
player-btn-view-purchase-options = Преглед на опции за покупка
player-btn-review-submit = Преглед и изпращане ({ $count })
player-btn-submit-character = Изпращане на персонаж
player-btn-keep-shopping = Продължи пазаруването
player-btn-edit-quantity = Редакция на количество
player-btn-clear-cart = Изчистване на кошницата

# Kit buttons
player-btn-confirm-selection = Потвърждаване на избора
player-btn-back-to-kits = Обратно към комплектите

# Inventory management
player-btn-spend-currency = Харчене на валута
player-btn-print-inventory = Отпечатване на инвентар

# Container management
player-btn-manage-containers = Управление на контейнери
player-btn-create-new = + Създай нов
player-btn-consume-destroy = Консумиране/Унищожаване
player-btn-move = Преместване
player-btn-move-all = Премести всичко
player-btn-move-some = Премести част...
player-btn-back-to-overview = ← Обратно към преглед
player-btn-cancel-move = ← Отказ
player-btn-up = ▲ Нагоре
player-btn-down = ▼ Надолу

# --- Modals ---

# Trade modal
player-modal-title-trade = Търговия с { $targetName }
player-modal-label-trade-name = Име
player-modal-placeholder-trade-name = Въведете името на предмета, с който търгувате
player-modal-label-trade-quantity = Количество
player-modal-placeholder-trade-quantity = Въведете количеството, което търгувате

# Character register modal
player-modal-title-register = Регистриране на нов персонаж
player-modal-label-char-name = Име
player-modal-placeholder-char-name = Въведете името на вашия персонаж.
player-modal-label-char-note = Бележка
player-modal-placeholder-char-note = Въведете бележка за идентифициране на вашия персонаж

# Open inventory input modal
player-modal-title-starting-inventory = Въвеждане на начален инвентар
player-modal-label-inventory = Инвентар
player-modal-placeholder-inventory-input =
    По един на ред във формат <име>: <количество>, напр.:
    Меч: 1
    злато: 30

# Spend currency modal
player-modal-title-spend-currency = Харчене на валута
player-modal-label-currency-name = Име на валутата
player-modal-placeholder-currency-name = Въведете името на валутата, която харчите
player-modal-label-currency-amount = Сума
player-modal-placeholder-currency-amount = Въведете сумата за харчене

# Create player post modal
player-modal-title-create-post = Създаване на публикация за дъската
player-modal-label-post-title = Заглавие
player-modal-placeholder-post-title = Въведете заглавие за вашата публикация
player-modal-label-post-content = Съдържание на публикацията
player-modal-placeholder-post-content = Въведете текста на вашата публикация

# Edit player post modal
player-modal-title-edit-post = Редакция на публикация

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = Редакция на количество в кошницата
player-modal-label-cart-qty = Количество
player-modal-placeholder-cart-qty = Въведете ново количество (0 за премахване)

# Create container modal
player-modal-title-create-container = Създаване на нов контейнер
player-modal-label-container-name = Име на контейнера
player-modal-placeholder-container-name = Въведете име за вашия контейнер (напр. Раница)

# Rename container modal
player-modal-title-rename-container = Преименуване на контейнер
player-modal-label-new-container-name = Ново име на контейнера
player-modal-placeholder-new-container-name = Въведете новото име

# Consume from container modal
player-modal-title-consume = Консумиране/Унищожаване на предмет
player-modal-label-consume-qty = Количество (макс: { $maxQuantity })
player-modal-placeholder-consume-qty = Въведете количеството за консумиране/унищожаване

# Move item quantity modal
player-modal-title-move-item = Преместване на предмет
player-modal-label-move-qty = Количество за преместване (макс: { $maxQuantity })
player-modal-placeholder-move-qty = Въведете количеството за преместване

# --- Selects ---

player-select-placeholder-no-characters = Нямате регистрирани персонажи
player-select-placeholder-remove-character = Изберете персонаж за премахване
player-select-placeholder-post = Изберете публикация
player-select-placeholder-container-view = Изберете контейнер за преглед...
player-select-placeholder-item = Изберете предмет...
player-select-placeholder-destination = Изберете дестинация...
player-select-placeholder-container = Изберете контейнер...
player-select-option-no-containers = Няма контейнери
player-select-option-no-items = Няма предмети
player-select-option-no-destinations = Няма дестинации

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}Команди за играча - Главно меню{"**"}
player-menu-btn-characters = Персонажи
player-menu-desc-characters = Регистриране, преглед и активиране на персонажи.
player-menu-btn-inventory = Инвентар
player-menu-desc-inventory = Преглед на инвентара на активния ви персонаж и харчене на валута.
player-menu-btn-player-board = Дъска за играчи
player-menu-btn-player-board-disabled = Дъска за играчи (Не е конфигурирана)
player-menu-desc-player-board = Създаване на публикация за дъската за играчи

# CharacterBaseView
player-title-characters = {"**"}Команди за играча - Персонажи{"**"}
player-desc-register-character = Регистриране на нов персонаж.
player-msg-no-characters = Нямате регистрирани персонажи.
player-label-active = (Активен)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Персонаж в процес: { $characterName }{"**"}
    Регистрацията на вашия персонаж очаква настройка на инвентара.
player-btn-resume = Продължи
player-btn-discard = Отхвърли
player-modal-title-discard-character = Отхвърляне на персонаж
player-modal-label-discard-confirm = Отхвърляне на { $characterName }?

# Confirm character removal
player-modal-title-confirm-char-removal = Потвърждение за премахване на персонаж
player-modal-label-confirm-char-delete = Изтриване на { $characterName }?

# Confirm post removal
player-modal-title-confirm-post-removal = Потвърждение за премахване на публикация
player-modal-label-post-removal-warning = ВНИМАНИЕ: Това действие е необратимо!

# InventoryOverviewView
player-title-inventory = {"**"}Команди за играча - Инвентар{"**"}
player-title-char-inventory = {"**"}Инвентар на { $characterName }{"**"}
player-msg-no-active-character = Няма активен персонаж: Активирайте персонаж за този сървър, за да използвате тези менюта.
player-msg-no-characters-registered = Няма персонажи: Регистрирайте персонаж, за да използвате тези менюта.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } предмета
player-label-currency = {"**"}Валута{"**"}
player-msg-inventory-empty = Инвентарът е празен.

# Print inventory embed
player-embed-title-inventory = Инвентар на { $characterName }

# ContainerItemsView
player-msg-container-empty = Този контейнер е празен.
player-label-selected-item = Избрано: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Преместване на "{ $itemName }"{"**"} ({ $available } налични)
player-msg-no-other-containers = Няма други налични контейнери.
player-msg-select-destination = Изберете контейнер-дестинация:
player-label-destination = Дестинация: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Управление на контейнери{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } предмета){ $suffix }
player-label-default-suffix = { " " }(по подразбиране)
player-msg-no-containers = Няма контейнери.
player-label-selected-container = Избрано: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = Потвърждение за изтриване на контейнер
player-modal-label-container-has-items = Съдържа { $itemCount } предмета. Ще бъдат преместени в Разпилени предмети.
player-modal-label-confirm-container-delete = Изтриване на "{ $containerName }"?

# Container errors
player-error-cannot-rename-loose = Не може да се преименуват Разпилени предмети.
player-error-cannot-delete-loose = Не може да се изтрият Разпилени предмети.

# PlayerBoardView
player-title-player-board = {"**"}Команди за играча - Дъска за играчи{"**"}
player-desc-create-post = Създаване на нова публикация за дъската за играчи.
player-msg-no-posts = Нямате текущи публикации.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Автор
player-embed-footer-post-id = ID на публикация: { $postId }
player-error-board-channel-not-found = Каналът на дъската за играчи не е намерен.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Настройка на инвентар за { $characterName }{"**"}
player-desc-browse-shop = Разгледайте началния магазин, за да екипирате вашия персонаж.
player-desc-select-kit = Изберете начален комплект.
player-desc-input-inventory = Ръчно въведете началния си инвентар.

# StaticKitSelectView
player-title-select-kit = {"**"}Избор на комплект за { $characterName }{"**"}
player-msg-no-kits = Няма налични начални комплекти.
player-label-and-more-items = ...и още { $count } предмета
player-label-empty-kit = {"*"}Празен комплект{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Потвърждение на избора: { $kitName }{"**"}
player-label-items-heading = {"**"}Предмети:{"**"}
player-label-currency-heading = {"**"}Валута:{"**"}
player-msg-kit-empty = Този комплект е празен.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Опции за покупка: { $itemName }{"**"}
player-msg-no-cost-options = Този предмет няма налични опции за цена.
player-label-cost-option = {"**"}Опция { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Начален магазин ({ $inventoryType }){"**"}
player-label-starting-wealth = Начално богатство: { $formattedCurrency }
player-label-in-cart = {"**"}(В кошницата: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Преглед на кошницата{"**"}
player-msg-cart-empty = Кошницата ви е празна.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Общо: { $totalQuantity })
player-label-insufficient-currency = Недостатъчно { $currencyName }
player-label-total-cost = {"**"}Обща цена:{"**"}
player-label-total-cost-free = {"**"}Обща цена:{"**"} Безплатно
player-label-cart-page = Страница { $current } от { $total }

# Trade embed
player-embed-title-trade = Доклад за търговия
player-embed-desc-trade-sender = Изпращач: { $senderMention } като `{ $senderCharacter }`
player-embed-desc-trade-recipient = Получател: { $recipientMention } като `{ $recipientCharacter }`
player-embed-field-currency = Валута
player-embed-field-amount = Сума
player-embed-field-balance = Баланс на { $characterName }
player-embed-field-item = Предмет
player-embed-field-quantity = Количество
player-embed-footer-transaction-id = ID на транзакция: { $transactionId }

# Trade errors
player-error-trade-no-characters = Играчът, с когото се опитвате да търгувате, няма персонажи!
player-error-trade-no-active = Играчът, с когото се опитвате да търгувате, няма активен персонаж на този сървър!

# Spend currency embed
player-embed-title-spend = Доклад за транзакция на играча
player-embed-desc-spend-player = Играч: { $playerMention } като `{ $characterName }`
player-embed-desc-spend-transaction = Транзакция: {"**"}{ $characterName }{"**"} похарчи {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Канал
player-embed-field-receipt = Разписка

# Spend currency errors
player-error-amount-not-number = Сумата трябва да е число.
player-error-amount-positive = Трябва да похарчите положителна сума.
player-error-amount-exceeds-maximum = Сумата не може да надвишава { $max }.
player-error-no-active-character-server = Нямате активен персонаж на този сървър.
player-error-no-currency-config = Конфигурация на валута не е намерена за този сървър.

# Consume item embed
player-embed-title-consume = Доклад за консумиране на предмет
player-embed-desc-consume = Играч: { $playerMention } като `{ $characterName }`
player-embed-desc-consume-removed = Премахнато: {"**"}{ $quantity }x { $itemName }{"**"} от {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = Количеството трябва да е положително цяло число.
player-error-qty-at-least-one = Количеството трябва да е поне 1.
player-error-qty-only-have = Имате само { $maxQuantity } от този предмет.

# Inventory input errors
player-error-invalid-format = Невалиден формат: "{ $line }". Използвайте <име>: <количество>.
player-error-empty-name = Името на предмета не може да бъде празно в ред: "{ $line }".
player-error-invalid-quantity = Невалидно количество за "{ $name }": "{ $quantity }". Трябва да е положително цяло число.
player-error-input-errors-header = Грешки при въвеждане на инвентар:
player-msg-no-valid-items = Няма предоставени валидни предмети. Инициализиране с празен инвентар.

# Cart quantity validation
player-error-enter-valid-number = Моля, въведете валидно положително число.

# Submission embeds (approval queue)
player-embed-title-approval = Одобрение на инвентар: { $characterName }
player-embed-desc-submitted-by = Изпратено от { $userMention }
player-embed-field-items = Предмети
player-embed-field-currency-received = Валута
player-embed-footer-submission-id = ID на заявка: { $submissionId }
player-label-approval-thread = Одобрение: { $characterName }
player-embed-title-submission-sent = Заявката за инвентар е изпратена
player-embed-desc-submission-sent =
    Вашата заявка за {"**"}{ $characterName }{"**"} беше изпратена на екипа на GM за одобрение!
    Ще бъдете уведомени, след като бъде прегледана.
    [Преглед на темата на заявката]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = Приложен начален инвентар
player-embed-desc-starting-inventory = Играч: { $playerMention } като `{ $characterName }`
player-embed-field-items-received = Получени предмети
player-embed-field-currency-received-label = Получена валута
player-label-untitled = Без заглавие

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventory Submission: { $characterName }{"**"}
    Submitted by { $userMention }
player-approval-post-items = Предмети
player-approval-post-currency = Валута
player-approval-resolved = Тази заявка е приключена.
player-approval-btn-approve = Одобри
player-approval-btn-deny = Откажи
player-approval-btn-edit = Редактирай
player-approval-error-no-permission = Нямате разрешение за това действие.
player-approval-error-not-submitter = Само оригиналният подател може да редактира тази заявка.
player-approval-thread-instructions =
    This thread was created for the approval of {"**"}{ $characterName }{"**"}.
    A Game Master will review the submission and approve or deny it.
    Once approved or denied, this thread will be locked.

    {"**"}Game Masters:{"**"} Discuss any required changes with your
    player until the inventory is in an acceptable state. Only use
    the `Deny` button for irreconcilable submissions.

    { $playerMention }: Use the `Edit` button to make any changes
    requested here by a Game Master.
player-approval-approved-by = Тази заявка беше одобрена от { $approver }.
player-approval-denied-by = Тази заявка беше отхвърлена от { $denier }.
player-approval-deny-reason = Причина: { $reason }
player-msg-submission-updated = Вашата заявка е актуализирана.


# Denial modal
player-modal-title-deny-reason = Отхвърляне на заявка
player-modal-label-deny-reason = Причина за отхвърляне
player-modal-placeholder-deny-reason = По избор: обяснете защо заявката е отхвърлена
# Approval DM notifications
player-dm-title-approved = Персонаж одобрен
player-dm-desc-approved =
    Your character {"**"}{ $characterName }{"**"} has been approved
    by { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Персонаж отхвърлен
player-dm-desc-denied =
    Your character {"**"}{ $characterName }{"**"} has been denied
    by { $denier } in {"**"}{ $guildName }{"**"}.
