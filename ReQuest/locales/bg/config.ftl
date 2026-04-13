## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = Изчисти
config-btn-remove-gm-roles = Премахване на GM роли
config-btn-forbidden-roles = Забранени роли

# Quests
config-btn-toggle-quest-summary = Превключване на резюме на quest
config-btn-toggle-player-experience = Превключване на опит на играча
config-btn-toggle-display = Превключване на показване
config-btn-purge-player-board = Изчистване на дъската за играчи
config-btn-add-modify-rewards = Добавяне/Промяна на награди

# Currency
config-btn-add-denomination = Добавяне на деноминация
config-btn-add-new-currency = Добавяне на нова валута
config-btn-remove-currency = Премахване на валута

# Shops - creation
config-btn-add-shop-wizard = Добавяне на магазин (Съветник)
config-btn-add-shop-json = Добавяне на магазин (JSON)
config-btn-edit-shop-wizard = Редакция на магазин (Съветник)
config-btn-edit-shop-json = Редакция на магазин (JSON)
config-btn-remove-shop = Премахване на магазин
config-btn-add-item = Добавяне на предмет
config-btn-edit-shop-details = Редакция на детайли
config-btn-download-json = Изтегляне на JSON
config-btn-done-editing = Приключване на редакцията
config-btn-scan-server-configs = Сканиране на конфигурациите
config-btn-re-scan = Повторно сканиране

# New character shop
config-btn-upload-json = Качване на JSON
config-btn-configure-new-character-wealth = Конфигуриране на начално богатство
config-btn-configure-new-character-shop = Конфигуриране на магазин за нови персонажи
config-btn-clear-shop = Изчисти магазина
config-btn-configure-static-kits = Конфигуриране на статични комплекти
config-btn-new-character-settings = Настройки за нов персонаж
config-btn-disabled-no-currency = Изключено (Няма конфигурирана валута)
config-btn-disabled-no-wealth = Изключено (Няма конфигурирано начално богатство)

# Static kits
config-btn-create-new-kit = Създаване на нов комплект
config-btn-delete-kit = Изтриване на комплект
config-btn-add-currency = Добавяне на валута

# Roleplay
config-btn-toggle-rp-rewards = Превключване на RP награди
config-btn-clear-channels = Изчистване на каналите
config-btn-edit-settings = Редакция на настройки
config-btn-configure-rewards = Конфигуриране на награди

# Stock
config-btn-stock-limits = Лимити на наличност
config-btn-set-limit = Задаване на лимит
config-btn-edit-limit = Редакция на лимит
config-btn-remove-limit = Премахване на лимит
config-btn-configure-restock-schedule = Конфигуриране на график за презареждане
config-btn-back-to-shop-editor = Обратно към редактора на магазина

# Forum shop
config-btn-create-new-thread = Създаване на нова тема
config-btn-use-existing-thread = Използване на съществуваща тема

# Wizard
config-btn-quit = Изход
config-btn-configure-channels = Конфигуриране на канали
config-btn-configure-roles = Конфигуриране на роли
config-btn-configure-quests = Конфигуриране на куестове
config-btn-configure-players = Конфигуриране на играчи
config-btn-configure-currency = Конфигуриране на валута
config-btn-configure-rp-rewards = Конфигуриране на RP награди
config-btn-configure-shops = Конфигуриране на магазини
config-btn-new-char-setup = Настройка на нов персонаж

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = Потвърждение за премахване на роля
config-modal-title-confirm-removal = Потвърждение за премахване
config-modal-title-confirm-currency-removal = Потвърждение за премахване на валута
config-modal-title-confirm-shop-removal = Потвърждение за премахване на магазин
config-modal-title-confirm-kit-deletion = Потвърждение за изтриване на комплект
config-modal-title-confirm-remove-stock-limit = Потвърждение за премахване на лимит на наличност
config-modal-title-clear-shop = Потвърдете изчистването

# Confirm modal prompt labels
config-modal-label-remove-role = Премахване на { $roleName }?
config-modal-label-remove-denomination = Премахване на { $denominationName }?
config-modal-label-remove-currency = Премахване на { $currencyName }?
config-modal-label-shop-removal-warning = ВНИМАНИЕ: Това действие е необратимо!
config-modal-label-kit-deletion-warning = ВНИМАНИЕ: Необратимо!
config-modal-label-remove-stock-limit = Напишете ПОТВЪРДИ, за да премахнете лимита на наличност
config-modal-label-clear-shop = Изчистване на всички предмети от този магазин?

# Error messages from buttons
config-error-shop-data-not-found = Грешка: Данните за този магазин не са намерени.
config-msg-shop-json-download = Ето JSON дефиницията за {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Ето JSON дефиницията за магазина за нови персонажи.
config-error-select-forum-first = Моля, първо изберете форумен канал.
config-error-select-thread-first = Моля, първо изберете тема.

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Добавяне на нова валута
config-modal-label-currency-name = Име на валутата
config-error-currency-already-exists = Валута или деноминация с име { $name } вече съществува!

# RenameCurrencyModal
config-modal-title-rename-currency = Преименуване на валута
config-modal-label-new-currency-name = Ново име на валутата
config-error-currency-name-exists = Валута с име "{ $name }" вече съществува.
config-error-denomination-name-exists = Деноминация с име "{ $name }" вече съществува.

# RenameDenominationModal
config-modal-title-rename-denomination = Преименуване на деноминация
config-modal-label-new-denomination-name = Ново име на деноминацията

# AddCurrencyDenominationModal
config-modal-title-add-denomination = Добавяне на деноминация за { $currencyName }
config-modal-label-denomination-name = Име
config-modal-placeholder-denomination-name = напр. Сребро
config-modal-label-denomination-value = Стойност
config-modal-placeholder-denomination-value = напр. 0.1
config-error-denomination-matches-currency = Името на новата деноминация не може да съвпада с вече съществуваща валута на този сървър! Намерена е валута с име "{ $existingName }".
config-error-denomination-matches-denomination = Името на новата деноминация не може да съвпада с вече съществуваща деноминация на този сървър! Намерена е деноминация с име "{ $denominationName }" под валутата "{ $currencyName }".
config-error-denomination-value-exists = Деноминациите в една валута трябва да имат уникални стойности! { $denominationName } вече има зададена тази стойност.
config-label-denomination-info = **{ $name }** (Стойност: { $value })

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Имена на забранени роли
config-modal-label-names = Имена
config-modal-placeholder-names = Въведете имена, разделени със запетаи
config-msg-forbidden-roles-updated = Забранените роли са обновени!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Изчистване на дъската за играчи
config-modal-label-age = Възраст
config-modal-placeholder-age = Въведете максималната възраст на публикациите (в дни), които да бъдат запазени
config-msg-posts-purged = Публикациите по-стари от { $days } дни бяха изчистени!

# GMRewardsModal
config-modal-title-gm-rewards = Добавяне/Промяна на GM награди
config-modal-label-experience = Опит
config-modal-placeholder-enter-number = Въведете число
config-modal-label-items = Предмети
config-modal-placeholder-items =
    Име: Количество
    Име2: Количество
    и т.н.
config-error-experience-invalid = Опитът трябва да е валидно цяло число (напр. 2000).
config-error-item-format-invalid = Невалиден формат на предмет: "{ $item }". Всеки предмет трябва да е на нов ред във формат "Име: Количество".

# ConfigShopDetailsModal
config-modal-title-shop-details = Добавяне/Редакция на детайли на магазин
config-modal-label-shop-channel = Изберете канал
config-modal-placeholder-shop-channel = Изберете канала за този магазин
config-modal-label-shop-name = Име на магазина
config-modal-placeholder-shop-name = Въведете името на магазина
config-modal-label-shopkeeper-name = Име на търговеца
config-modal-placeholder-shopkeeper-name = Въведете името на търговеца
config-modal-label-shop-description = Описание на магазина
config-modal-placeholder-shop-description = Въведете описание за магазина
config-modal-label-shop-image-url = URL на изображение на магазина
config-modal-placeholder-shop-image-url = Въведете URL за изображението на магазина
config-error-no-channel-selected = Не е избран канал за магазина.
config-error-shop-already-in-channel = В избрания канал вече има регистриран магазин. Моля, изберете друг канал или редактирайте съществуващия магазин.

# build_shop_header_view
config-label-shopkeeper = {"**"}Търговец:{"**"} { $name }
config-msg-use-shop-command = Използвайте командата `/shop`, за да разглеждате и купувате предмети.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Създаване на магазин във форумна тема
config-modal-label-thread-name = Име на темата
config-modal-placeholder-thread-name = Въведете името за темата на магазина
config-error-forum-not-found = Избраният форумен канал не може да бъде намерен.
config-error-shop-already-in-thread = В тази тема вече има регистриран магазин. Това не би трябвало да се случи за нова тема.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Добавяне на нов магазин чрез JSON
config-modal-label-upload-json = Качете .json файл с данните на магазина
config-error-no-json-uploaded = Не е качен JSON файл за магазина.
config-error-file-must-be-json = Каченият файл трябва да е JSON файл (.json).
config-error-invalid-json = Невалиден JSON формат: { $error }
config-error-json-validation-failed = JSON не отговаря на схемата: { $error }

# ShopItemModal
config-modal-title-shop-item = Добавяне/Редакция на предмет в магазина
config-modal-label-item-name = Име на предмета
config-modal-placeholder-item-name = Въведете името на предмета
config-modal-label-item-description = Описание на предмета
config-modal-placeholder-item-description = Въведете описание за предмета
config-modal-label-item-quantity = Количество на предмета
config-modal-placeholder-item-quantity = Въведете количеството, продавано при покупка
config-modal-label-item-costs = Цена на предмета
config-modal-placeholder-item-costs = Напр.: 10 gold + 5 silver\nИЛИ: 50 rep\n(Използвайте + за И, Нов ред за ИЛИ)
config-error-item-quantity-positive = Количеството на предмета трябва да е положително цяло число.
config-error-cost-format-invalid = Невалиден формат на цена в опция: "{ $option }". Всяка цена трябва да има сума и валута, разделени с интервал, напр. "10 gold".
config-error-cost-amount-invalid = Невалидна сума "{ $amount }" за валута: "{ $currency }". Сумата трябва да е положително число.
config-error-unknown-currency = Неизвестна валута `{ $currency }`. Моля, използвайте валидна валута, конфигурирана за този сървър.
config-error-item-already-exists = Предмет с име { $itemName } вече съществува в този магазин.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Обновяване на магазин чрез JSON
config-modal-label-upload-new-json = Качете нова JSON дефиниция
config-error-no-file-uploaded = Не е качен файл.
config-error-file-must-be-json-ext = Файлът трябва да е `.json` файл.
config-error-json-validation-message = Валидацията на JSON е неуспешна: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Добавяне/Редакция на екипировка за нов персонаж
config-modal-placeholder-item-quantity-selection = Въведете количеството, получавано при избор
config-modal-label-item-cost = Цена на предмета
config-error-cost-format-short = Невалиден формат на цена: '{ $component }'. Очаква се 'Сума Валута'.
config-error-amount-invalid-short = Невалидна сума '{ $amount }' за валута '{ $currency }'.
config-error-item-exists-new-char = Предмет с име { $itemName } вече съществува в магазина за нови персонажи.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Качване на магазин за нови персонажи (JSON)
config-error-no-json-uploaded-short = Не е качен JSON файл.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Задаване на начално богатство
config-modal-label-amount = Сума
config-modal-placeholder-amount = Въведете сумата за тази валута.
config-modal-placeholder-currency-name = Въведете името на валута, дефинирана на този сървър
config-error-no-currencies-configured = На този сървър няма конфигурирани валути.
config-error-currency-not-found = Валута или деноминация с име { $name } не е намерена. Моля, използвайте валидна валута.

# CreateStaticKitModal
config-modal-title-create-kit = Създаване на нов статичен комплект
config-modal-label-kit-name = Име на комплекта
config-modal-placeholder-kit-name = напр. Начален комплект за воин
config-modal-label-description = Описание
config-modal-placeholder-kit-description = Незадължително описание за този комплект
config-error-kit-name-exists = Статичен комплект с име "{ $kitName }" вече съществува. Моля, изберете друго име.

# StaticKitItemModal
config-modal-title-kit-item = Добавяне/Редакция на предмет в комплект
config-modal-placeholder-kit-item-quantity = Въведете количеството на предмета за включване в комплекта

# StaticKitCurrencyModal
config-modal-title-kit-currency = Добавяне на валута в комплект
config-modal-placeholder-currency-eg = напр. Злато
config-modal-placeholder-amount-eg = напр. 100
config-error-amount-must-be-number = Сумата трябва да е число.
config-error-amount-exceeds-maximum = Сумата не може да надвишава { $max }.
config-error-no-currencies-on-server = На сървъра няма конфигурирани валути.
config-error-currency-not-found-short = Валутата "{ $currency }" не е намерена.
config-error-denomination-not-found = Деноминацията "{ $denomination }" не е намерена в конфигурацията на валутата.

# RoleplaySettingsModal
config-modal-title-rp-settings = Настройки за ролева игра
config-modal-label-min-message-length = Минимална дължина на съобщението (символи)
config-modal-placeholder-min-message-length = Брой символи, необходими за допустимост на съобщението. 0 за без ограничение
config-modal-label-cooldown = Време на изчакване (секунди)
config-modal-placeholder-cooldown = Време на изчакване в секунди между допустимите съобщения за награди
config-modal-label-message-threshold = Праг на съобщенията
config-modal-placeholder-message-threshold = Брой съобщения, необходими за задействане на наградата
config-modal-label-frequency = Честота (брой съобщения)
config-modal-placeholder-frequency = Брой допустими съобщения, необходими за получаване на награди
config-error-min-length-invalid = Минималната дължина на съобщението трябва да е неотрицателно цяло число.
config-error-cooldown-invalid = Времето на изчакване трябва да е неотрицателно цяло число.
config-error-threshold-invalid = Прагът на съобщенията трябва да е положително цяло число.
config-error-frequency-invalid = Честотата трябва да е положително цяло число.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Конфигуриране на награди за ролева игра
config-modal-label-items-name-quantity = Предмети (Име: Количество)
config-modal-label-currency-name-amount = Валута (Име: Сума)
config-error-experience-non-negative = Опитът трябва да е неотрицателно цяло число.
config-error-item-quantity-positive-named = Количеството на предмет "{ $itemName }" трябва да е положително цяло число.
config-error-currency-amount-positive = Сумата на валута "{ $currencyName }" трябва да е положително число.

# SetItemStockModal
config-modal-title-stock-limit = Лимит на наличност: { $itemName }
config-modal-label-max-stock = Максимална наличност
config-modal-placeholder-max-stock = Въведете максимална наличност (напр. 10)
config-modal-label-current-stock = Текуща наличност
config-modal-placeholder-current-stock = Въведете текущата налична наличност
config-modal-label-restock-increment = Стъпка на зареждане (на цикъл)
config-modal-placeholder-restock-increment = Количество за зареждане на цикъл (по подразбиране: 1)
config-error-max-stock-positive = Максималната наличност трябва да е положително цяло число.
config-error-current-stock-non-negative = Текущата наличност трябва да е неотрицателно цяло число.
config-error-current-exceeds-max = Текущата наличност не може да надвишава максималната.
config-error-item-not-in-shop = Предметът "{ $itemName }" не е намерен в магазина.

# RestockScheduleModal
config-modal-title-restock-schedule = Конфигуриране на график за презареждане
config-modal-restock-schedule-label = Разписание
config-modal-restock-schedule-none = Няма (Деактивирано)
config-modal-restock-schedule-hourly = На всеки час
config-modal-restock-schedule-daily = Ежедневно
config-modal-restock-schedule-weekly = Ежеседмично
config-modal-label-time = Час (ЧЧ:ММ в UTC)
config-modal-desc-current-time = Текущо време: { $utcTime }
config-modal-placeholder-time = напр. 14:30 за 14:30 UTC
config-modal-restock-day-label = Ден от седмицата (само за ежеседмично)
config-modal-restock-mode-label = Режим на зареждане
config-modal-restock-mode-full = Пълно (нулиране до максимум)
config-modal-restock-mode-incremental = Постепенно (добавяне на количество)
config-error-time-format-invalid = Часът трябва да е във формат ЧЧ:ММ (напр. 14:30).
config-error-increment-positive = Количеството за добавяне трябва да е положително цяло число.

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Потърсете вашия канал за { $configName }

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Изберете ролята за обявяване на quest

# AddGMRoleSelect
config-select-placeholder-gm-roles = Изберете вашата GM роля/роли

# ConfigWaitListSelect
config-select-placeholder-wait-list = Изберете размер на списъка на чакащите
config-select-option-disabled = 0 (Изключено)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Изберете режим на инвентар
config-select-option-disabled-label = Изключено
config-select-desc-disabled = Играчите започват с празен инвентар.
config-select-option-selection = Избор
config-select-desc-selection = Играчите избират свободно предмети от магазина за нови персонажи.
config-select-option-purchase = Покупка
config-select-desc-purchase = Играчите купуват предмети от магазина за нови персонажи с определена сума валута.
config-select-option-open = Свободен
config-select-desc-open = Играчите въвеждат ръчно собствения си инвентар.
config-select-option-static = Статичен
config-select-desc-static = Играчите получават предварително определен начален инвентар.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Изберете допустими канали

# RoleplayModeSelect
config-select-placeholder-rp-mode = Изберете режим
config-select-option-scheduled = По график
config-select-desc-scheduled = Наградите се раздават еднократно в рамките на определен период.
config-select-option-accrued = Натрупващ
config-select-desc-accrued = Наградите се раздават многократно въз основа на определени нива на активност.

# RoleplayResetSelect
config-select-placeholder-reset-period = Изберете период на нулиране
config-select-option-hourly = Ежечасно
config-select-desc-hourly = Нулира се всеки час.
config-select-option-daily = Ежедневно
config-select-desc-daily = Нулира се на всеки 24 часа.
config-select-option-weekly = Ежеседмично
config-select-desc-weekly = Нулира се на всеки 7 дни.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Изберете ден за нулиране

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Изберете час за нулиране (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Изберете форумен канал

# ForumThreadSelect
config-select-placeholder-thread = Изберете тема
config-select-option-no-threads = Няма намерени активни теми
config-select-desc-no-threads = Създайте нова тема или проверете архивираните теми
config-select-option-select-forum-first = Първо изберете форум
config-select-desc-select-forum-first = Моля, изберете форумен канал по-горе
config-select-desc-thread-id = ID на тема: { $threadId }
config-error-select-valid-thread = Моля, изберете валидна тема или създайте нова.
config-error-thread-not-found = Избраната тема не може да бъде намерена. Може да е била изтрита или архивирана.

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = Конфигурация на сървъра - Главно меню
config-menu-config-wizard = Съветник за конфигурация
config-menu-desc-config-wizard = Проверете дали вашият сървър е готов за ReQuest с бързо сканиране.
config-menu-channels = Канали
config-menu-desc-channels = Задаване на определени канали за публикации на ReQuest.
config-menu-currency = Валута
config-menu-desc-currency = Глобални настройки на валутата.
config-menu-players = Играчи
config-menu-desc-players = Глобални настройки за играчите, като проследяване на точки опит.
config-menu-quests = Куестове
config-menu-desc-quests = Глобални настройки за куестове, като списъци на чакащите.
config-menu-rp-rewards = RP награди
config-menu-desc-rp-rewards = Конфигуриране на награди за ролева игра.
config-menu-roles = Роли
config-menu-desc-roles = Опции за конфигуриране на роли за известия или привилегии.
config-menu-shops = Магазини
config-menu-desc-shops = Конфигуриране на персонализирани магазини.
config-menu-language = Език
config-menu-desc-language = Задаване на езика по подразбиране за този сървър.

## Wizard View
config-title-wizard = {"**"}Конфигурация на сървъра - Съветник{"**"}
config-wizard-intro =
    {"**"}Добре дошли в съветника за конфигурация на ReQuest!{"**"}

    Този съветник ще ви помогне да се уверите, че вашият сървър е правилно конфигуриран за използване на функциите на ReQuest. Той ще сканира текущите ви настройки и ще предостави препоръки за необходимите корекции.

    Използвайте бутона „Стартиране на сканиране" по-долу, за да започнете процеса на валидация. След като сканирането приключи, ще получите подробен доклад за конфигурацията на вашия сървър, заедно с препоръчани промени.

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}Глобални права на бота{"**"}__
config-wizard-bot-permissions-desc = Този раздел проверява дали ReQuest има правилните права за правилно функциониране.
config-wizard-bot-role = Роля на бота: { $roleMention }
config-wizard-status-warnings = {"**"}Статус: ⚠️ ОТКРИТИ ПРЕДУПРЕЖДЕНИЯ{"**"}
config-wizard-missing-perm = - ⚠️ Липсващо: `{ $permissionName }`
config-wizard-ensure-permissions = Моля, уверете се, че най-високата роля на бота има тези права, зададени глобално.
config-wizard-status-ok = {"**"}Статус: ✅ ОК{"**"}
config-wizard-bot-permissions-ok = Ботът има всички необходими глобални права.
config-wizard-status-scan-failed = {"**"}Статус: ❌ СКАНИРАНЕТО Е НЕУСПЕШНО{"**"}
config-wizard-scan-error = Възникна неочаквана грешка при проверка на правата на бота.
config-wizard-error-type = Грешка: { $errorType }
config-wizard-required-permissions = {"**"}Необходими права за ролята на бота:{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = Преглед на канали
config-wizard-perm-manage-roles = Управление на роли
config-wizard-perm-send-messages = Изпращане на съобщения
config-wizard-perm-attach-files = Прикачване на файлове
config-wizard-perm-add-reactions = Добавяне на реакции
config-wizard-perm-use-external-emoji = Използване на външен емоджи
config-wizard-perm-manage-messages = Управление на съобщения
config-wizard-perm-read-message-history = Четене на хронология на съобщенията

# Wizard - Role Validation
config-wizard-role-header = __{"**"}Конфигурации на ролите{"**"}__
config-wizard-role-desc =
    Този раздел проверява следното:

    - Дали GM ролите (задължителни) и ролята за обявления (незадължителна) са конфигурирани.
    - Дали ролята по подразбиране (@everyone) има необходимите права за достъп до функциите на бота.
    - Дали ролята по подразбиране (@everyone) няма опасни права.
    - Дали GM и ролите за обявления имат ескалации на права извън ролята по подразбиране.

    Всички предупреждения тук са единствено препоръки, базирани на конфигурация по подразбиране. В зависимост от нуждите на вашия сървър, може да имате основание да пренебрегнете някои от тях.

config-wizard-default-role-label = {"**"}Роля по подразбиране:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Открити опасни права:
config-wizard-default-role-ok = - ✅ @everyone: ОК
config-wizard-missing-permission = - Липсващо право: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}GM роли:{"**"}
config-wizard-no-gm-roles = - ⚠️ Няма конфигурирани GM роли
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Конфигурираната роля не е намерена/изтрита от сървъра
config-wizard-role-ok = - ✅ { $roleMention }: ОК
config-wizard-announcement-role-label = {"**"}Роля за обявления:{"**"}
config-wizard-no-announcement-role = - ℹ️ Няма конфигурирана роля за обявления
config-wizard-announcement-role-not-found = - ⚠️ Конфигурираната роля не е намерена/изтрита от сървъра
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Открити ескалации на права - { $escalations }
config-wizard-escalation-more = , и още { $count }...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = Изпращане на съобщения в теми
config-wizard-perm-use-application-commands = Използване на командите на приложения

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = Управление на канали
config-wizard-perm-manage-webhooks = Управление на уебхукове
config-wizard-perm-manage-server = Управление на сървъра
config-wizard-perm-manage-nicknames = Управление на прякори
config-wizard-perm-kick-members = Изгонване на членове
config-wizard-perm-ban-members = Забрана на членове
config-wizard-perm-timeout-members = Тайм-аут на членове
config-wizard-perm-mention-everyone = Споменаване на @everyone
config-wizard-perm-manage-threads = Управление на теми
config-wizard-perm-administrator = Администратор

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}Конфигурации на каналите{"**"}__
config-wizard-channel-desc =
    Този раздел проверява следното:

    - Дали конфигурираните канали съществуват.
    - Дали ботът има права да вижда и изпраща съобщения в конфигурираните канали.
    - Дали ролята по подразбиране (@everyone) няма права за `Изпращане на съобщения`.

config-wizard-channel-no-config-required = - ⚠️ Няма конфигуриран канал
config-wizard-channel-not-configured = - ℹ️ Не е конфигуриран (Незадължително)
config-wizard-channel-not-found = - ⚠️ Конфигурираният канал не е намерен/изтрит от сървъра
config-wizard-channel-ok = - ✅ ОК
config-wizard-bot-cannot-view = - ⚠️ { $botMention } не може да види този канал.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } не може да изпраща съобщения в този канал.
config-wizard-everyone-can-send = - ⚠️ @everyone може да изпраща съобщения в този канал.

# Wizard - Channel names
config-wizard-channel-quest-board = Дъска за куестове
config-wizard-channel-player-board = Дъска за играчи
config-wizard-channel-quest-archive = Архив на куестове
config-wizard-channel-gm-transaction-log = Дневник на GM транзакции
config-wizard-channel-player-transaction-log = Дневник на транзакции на играчите
config-wizard-channel-shop-log = Дневник на магазина
config-wizard-channel-approval-queue = Опашка за одобрение на персонажи

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}Табло за управление{"**"}__
config-wizard-dashboard-desc = Този раздел предоставя преглед на незадължителни конфигурации за бърза справка.
config-wizard-quest-settings = {"**"}Настройки за куестове{"**"}
config-wizard-quest-wait-list = - Размер на списъка на чакащите: { $size }
config-wizard-quest-summary = - Резюме на quest: { $status }
config-wizard-gm-rewards-per-quest = {"**"}GM награди (за quest){"**"}
config-wizard-player-settings = {"**"}Настройки за играчите{"**"}
config-wizard-player-experience = - Опит на играча: { $status }
config-wizard-currency-settings = {"**"}Настройки на валутата{"**"}
config-wizard-rp-rewards = {"**"}Награди за ролева игра{"**"}
config-wizard-rp-status = - Статус: { $status }
config-wizard-rp-mode = - Режим: { $mode }
config-wizard-rp-channels = - Наблюдавани канали: { $count }
config-wizard-shops = {"**"}Магазини{"**"}
config-wizard-shops-count = - Конфигурирани магазини: { $count }
config-wizard-shops-more = - ...и още { $count }
config-wizard-new-char-setup = {"**"}Настройка на нов персонаж{"**"}
config-wizard-inventory-type = - Тип инвентар: { $type }
config-wizard-new-char-shop-items = - Предмети в магазина за нови персонажи: { $count }
config-wizard-static-kits = - Статични комплекти: { $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ Няма конфигурирани валути
config-wizard-configured-currencies = {"**"}Конфигурирани валути:{"**"}
config-wizard-no-denominations = - Няма конфигурирани деноминации
config-wizard-gm-rewards-disabled = {"**"}Статус:{"**"} Изключено
config-wizard-gm-rewards-enabled = {"**"}Статус:{"**"} Включено
config-wizard-gm-rewards-experience = - Опит: { $xp }
config-wizard-gm-rewards-items = - Предмети:

# Wizard - Език на сървъра (Страница 1)
config-wizard-server-language-desc =
    Това е езикът, който ReQuest ще използва за всички публични съобщения, като публикации на куестове, съобщения за зареждане на магазина и журнали за транзакции.
config-wizard-server-language = {"**"}Език на сървъра:{"**"} { $language }
config-wizard-server-language-default = По подразбиране (английски)

# Wizard - Информация за зареждане на магазина
config-wizard-shop-restock-not-scheduled = ℹ️ Зареждането не е планирано

# Wizard - Настройки на куестове (Страница 5)
config-wizard-quest-header = __{"**"}Настройки на куестове{"**"}__
config-wizard-quest-header-desc =
    Този раздел предоставя преглед на конфигурациите, свързани с куестове.
config-wizard-quest-role-mode = - Режим на роли за куестове: { $mode }
config-wizard-quest-roles-label = {"**"}Роли за куестове на GM{"**"}
config-wizard-quest-roles-count = - Роли, назначени на GM-и: { $count }
config-wizard-quest-roles-all-ok = - ✅ Всички роли са наред
config-wizard-quest-roles-assigned-to = {"    "}Назначена на: { $gmNames }
config-wizard-quest-roles-not-found = - ⚠️ ID на роля { $roleId }: Не е намерена/Изтрита от сървъра
config-wizard-quest-roles-no-assignments = - ℹ️ Няма назначени роли за куестове

## Roles View
config-title-roles = {"**"}Конфигурация на сървъра - Роли{"**"}
config-label-announcement-role = {"**"}Роля за обявления:{"**"} { $status }
config-desc-announcement-role = Тази роля се споменава при публикуване на quest.
config-label-announcement-role-default = {"**"}Роля за обявления:{"**"} Не е конфигурирана
config-label-gm-roles = {"**"}GM роля/роли:{"**"} { $roles }
config-desc-gm-roles = Тези роли предоставят достъп до командите и функциите на GM.
config-label-gm-roles-default = {"**"}GM роля/роли:{"**"} Не е конфигурирана
config-title-forbidden-roles = __{"**"}Забранени роли{"**"}__
config-desc-forbidden-roles =
    Конфигурира списък с имена на роли, които не могат да бъдат използвани от GM за техните роли за група.
    По подразбиране `everyone`, `administrator`, `gm` и `game master` не могат да бъдат използвани. Тази конфигурация
    разширява този списък.

## GM Role Remove View
config-title-remove-gm-roles = {"**"}Конфигурация на сървъра - Премахване на GM роля/роли{"**"}
config-msg-no-gm-roles = Няма конфигурирани GM роли.

## Channels View
config-title-channels = {"**"}Конфигурация на сървъра - Канали{"**"}

config-label-quest-board = {"**"}Дъска за куестове:{"**"} { $channel }
config-desc-quest-board = Каналът, в който ще се публикуват новите/активните куестове.
config-label-quest-board-default = {"**"}Дъска за куестове:{"**"} Не е конфигуриран

config-label-player-board = {"**"}Дъска за играчи:{"**"} { $channel }
config-desc-player-board = Незадължителна дъска за обявления/съобщения, използвана от играчите.
config-label-player-board-default = {"**"}Дъска за играчи:{"**"} Не е конфигуриран

config-label-quest-archive = {"**"}Архив на куестове:{"**"} { $channel }
config-desc-quest-archive = Незадължителен канал, в който завършените куестове ще бъдат преместени с обобщена информация.
config-label-quest-archive-default = {"**"}Архив на куестове:{"**"} Не е конфигуриран

config-label-gm-transaction-log = {"**"}Дневник на GM транзакции:{"**"} { $channel }
config-desc-gm-transaction-log = Незадължителен канал, в който се регистрират GM транзакции (напр. команди за промяна на играч).
config-label-gm-transaction-log-default = {"**"}Дневник на GM транзакции:{"**"} Не е конфигуриран

config-label-player-transaction-log = {"**"}Дневник на транзакции на играчите:{"**"} { $channel }
config-desc-player-transaction-log = Незадължителен канал, в който се регистрират транзакции на играчите, като търговия и консумиране на предмети.
config-label-player-transaction-log-default = {"**"}Дневник на транзакции на играчите:{"**"} Не е конфигуриран

config-label-shop-log = {"**"}Дневник на магазина:{"**"} { $channel }
config-desc-shop-log = Незадължителен канал, в който се регистрират транзакциите в магазина.
config-label-shop-log-default = {"**"}Дневник на магазина:{"**"} Не е конфигуриран

## Quests View
config-title-quests = {"**"}Конфигурация на сървъра - Куестове{"**"}

config-label-wait-list = {"**"}Размер на списъка на чакащите:{"**"} { $size }
config-desc-wait-list = Списъкът на чакащите позволява на определен брой играчи да се наредят за quest, който е пълен, в случай че играч се откаже.
config-label-wait-list-disabled = {"**"}Размер на списъка на чакащите:{"**"} Изключен

config-label-quest-summary = {"**"}Резюме на quest:{"**"} { $status }
config-desc-quest-summary = Тази опция позволява на GM да предоставят кратко резюме при приключване на куестове.
config-label-quest-summary-disabled = {"**"}Резюме на quest:{"**"} Изключено

config-label-gm-rewards = GM награди
config-desc-gm-rewards = Конфигуриране на награди за GM при завършване на куестове.

## GM Rewards View
config-title-gm-rewards = {"**"}Конфигурация на сървъра - GM награди{"**"}
config-desc-gm-rewards-detail =
    {"**"}Добавяне/Промяна на награди{"**"}
    Отваря формуляр за добавяне, промяна или премахване на GM награди.

    > Конфигурираните награди са за всеки quest. Всеки път, когато GM завърши quest, ще получи
    наградите, конфигурирани по-долу, на активния си персонаж.
config-msg-no-rewards = Няма конфигурирани награди.
config-label-gm-experience = {"**"}Опит:{"**"} { $xp }
config-label-gm-items = {"**"}Предмети:{"**"}

## Players View
config-title-players = {"**"}Конфигурация на сървъра - Играчи{"**"}

config-label-player-experience = {"**"}Опит на играча:{"**"} { $status }
config-desc-player-experience = Включва/Изключва използването на точки опит (или подобна стойностна прогресия на персонажа).
config-label-player-experience-disabled = {"**"}Опит на играча:{"**"} Изключен

config-label-new-char-settings = {"**"}Настройки за нов персонаж{"**"}
config-desc-new-char-settings = Конфигуриране на настройки, свързани с нови персонажи и начина на инициализиране на техните инвентари.

config-label-player-board-purge = {"**"}Изчистване на дъската за играчи{"**"}
config-desc-player-board-purge = Изчиства публикации от дъската за играчи (ако е включена).

## New Character Settings View
config-title-new-character = {"**"}Конфигурация на сървъра - Настройки за нов персонаж{"**"}

config-label-inventory-type = {"**"}Тип инвентар за нов персонаж:{"**"} { $type }
config-desc-inventory-type = Определя как новорегистрираните персонажи инициализират своите инвентари.
config-label-inventory-type-disabled = {"**"}Тип инвентар за нов персонаж:{"**"} Изключен

config-label-new-char-wealth = {"**"}Начално богатство:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Начално богатство:{"**"} Изключено

config-label-approval-queue = {"**"}Опашка за одобрение:{"**"} { $channel }
config-desc-approval-queue = Ако е зададена, новите персонажи трябва да бъдат одобрени от GM в този Forum канал, преди да бъдат активирани.
config-label-approval-queue-disabled = {"**"}Опашка за одобрение:{"**"} Изключена
config-label-approval-queue-not-configured = {"**"}Опашка за одобрение:{"**"} Не е конфигурирана

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = Играчите започват с празен инвентар.
config-desc-inv-type-selection = Играчите избират свободно предмети от магазина за нови персонажи.
config-desc-inv-type-purchase = Играчите купуват предмети от магазина за нови персонажи с определена сума валута.
config-desc-inv-type-open = Играчите въвеждат ръчно своите предмети за инвентар.
config-desc-inv-type-static = Играчите получават предварително определен начален инвентар.

## New Character Shop View
config-title-new-char-shop = {"**"}Конфигурация на сървъра - Магазин за нови персонажи{"**"}
config-label-inv-type-selection = {"**"}Тип инвентар:{"**"} Избор
config-desc-inv-type-selection-shop = Играчите избират свободно предмети от магазина за нови персонажи.
config-label-inv-type-purchase = {"**"}Тип инвентар:{"**"} Покупка
config-desc-inv-type-purchase-shop = Играчите купуват предмети от магазина за нови персонажи с определена сума валута.
config-label-inv-type-other = {"**"}Тип инвентар:{"**"} { $type }
config-desc-inv-type-not-in-use = Магазинът за нови персонажи не се използва.
config-msg-define-shop-items = Определете предметите в магазина.
config-msg-no-items = Няма конфигурирани предмети.

## Static Kits View
config-title-static-kits = {"**"}Конфигурация на сървъра - Статични комплекти{"**"}
config-desc-create-kit = Създаване на нова дефиниция на комплект.
config-msg-no-kits = Няма конфигурирани комплекти.
config-label-kit-more-items = ...и още { $count } предмета
config-label-empty-kit = {"*"}Празен комплект{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}Редактиране на комплект: { $kitName }{"**"}
config-msg-kit-empty = Този комплект е празен. Използвайте бутоните по-горе, за да добавите валута или предмети.
config-label-kit-currency = {"**"}Валута:{"**"} { $display }
config-label-kit-item = {"**"}Предмет:{"**"} { $name }

## Currency View
config-title-currency = {"**"}Конфигурация на сървъра - Валута{"**"}
config-desc-create-currency = Създаване на нова валута.
config-msg-no-currencies = Няма конфигурирани валути.
config-label-currency-display-type = Тип показване: { $type } | Деноминации: { $count }
config-label-currency-type-double = Десетично
config-label-currency-type-integer = Цяло число

## Edit Currency View
config-title-manage-currency = {"**"}Управление на валута: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Валута и деноминации{"**"}__
    - Даденото име на вашата валута се счита за базова валута и има стойност 1.
    {"```"}Пример: "злато" е конфигурирано като валута.{"```"}
    - Добавянето на деноминация изисква посочване на име и стойност спрямо базовата валута.
    {"```"}Пример: На златото са дадени две деноминации: сребро (стойност 0.1) и мед (стойност 0.01).{"```"}
    - Всички транзакции, включващи базова валута или нейните деноминации, ще бъдат автоматично конвертирани.
    {"```"}Пример: Играч има 10 злато и харчи 3 мед. Новият му баланс автоматично ще се покаже като
    9 злато, 9 сребро и 7 мед.{"```"}
    - Валутите, показани като цяло число, ще показват всяка деноминация, докато валутите, показани като десетично число,
    ще показват само базовата валута.
    {"```"}Пример: Горният играч с включено десетично показване ще се покаже като 9.97 злато.{"```"}
config-btn-toggle-display-current = Превключване на показване (Текущо: { $type })
config-msg-no-denominations = Няма конфигурирани деноминации.

## Shops View
config-title-shops = {"**"}Конфигурация на сървъра - Магазини{"**"}
config-desc-add-shop-wizard =
    {"**"}Добавяне на магазин (Съветник){"**"}
    Създаване на нов празен магазин от формуляр.
config-desc-add-shop-json =
    {"**"}Добавяне на магазин (JSON){"**"}
    Създаване на нов магазин чрез пълна JSON дефиниция. (Разширено)
config-btn-example-json = Примерен JSON
config-desc-example-json =
    {"**"}Примерен JSON{"**"}
    Изтеглете примерен JSON файл, показващ очаквания формат.
config-msg-example-json = Ето примерен JSON файл, показващ очаквания формат.
config-msg-no-shops = Няма конфигурирани магазини.
config-label-shop-type-forum = (Форум)
config-label-shop-channel = Канал: <#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}Добавяне на магазин - Избор на тип местоположение{"**"}
config-label-text-channel = {"**"}Текстов канал{"**"}
config-desc-text-channel = Създаване на магазин в стандартен текстов канал.
config-label-forum-thread = {"**"}Тема във форум{"**"}
config-desc-forum-thread = Създаване на магазин във форумна тема (нова или съществуваща).

## Forum Shop Setup View
config-title-forum-setup = {"**"}Добавяне на магазин - Настройка на форумна тема{"**"}
config-label-step1 = {"**"}Стъпка 1: Изберете форумен канал{"**"}
config-label-step2 = {"**"}Стъпка 2: Изберете опция за тема{"**"}
config-label-step3 = {"**"}Стъпка 3: Изберете съществуваща тема{"**"}
config-desc-create-new-thread =
    {"**"}Създаване на нова тема{"**"}
    Отваря формуляр за създаване на нова тема и конфигуриране на магазина.
config-label-selected-thread = {"**"}Избрана тема:{"**"} { $threadName }
config-desc-click-to-configure = Натиснете, за да конфигурирате магазина в тази тема.

## Manage Shop View
config-title-manage-shop = {"**"}Управление на магазин: { $shopName }{"**"}
config-label-shop-type = {"**"}Тип:{"**"} { $type }
config-label-shop-type-text = Текстов канал
config-label-shop-type-forum-thread = Тема във форум
config-label-shopkeeper = {"**"}Търговец:{"**"} { $name }
config-label-shop-description = {"**"}Описание:{"**"} { $description }
config-label-shop-channel-info = {"**"}Канал:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Редакция на детайли и предмети на магазина чрез съветника.
config-desc-upload-json = Качване на нова JSON дефиниция за този магазин.
config-desc-download-json = Изтегляне на текущата JSON дефиниция.
config-desc-remove-shop = Окончателно премахване на този магазин.

## Edit Shop View
config-title-editing-shop = {"**"}Редактиране на магазин: { $shopName }{"**"}
config-label-shop-shopkeeper = Търговец: {"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}Конфигурация на наличност: { $shopName }{"**"}
config-label-current-utc = Текущо UTC време: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}График за презареждане:{"**"} { $schedule }
config-label-restock-hourly = в минута :{ $minute }
config-label-restock-daily = в { $time } UTC
config-label-restock-weekly = в { $day } в { $time } UTC
config-label-restock-mode = {"**"}Режим:{"**"} { $mode }
config-label-restock-full = Пълно презареждане
config-label-restock-incremental = Постепенно (количества по артикул)
config-label-restock-disabled = {"**"}График за презареждане:{"**"} Изключен
config-label-item-stock-limits = {"**"}Лимити на наличност на предмети{"**"}
config-msg-no-items-in-shop = Няма предмети в този магазин.
config-label-stock-with-available = Макс: { $max } | Налични: { $available }
config-label-stock-increment = Зареждане: +{ $increment }/цикъл
config-label-stock-reserved = Запазени: { $reserved }
config-label-stock-not-initialized = Макс: { $max } | Налични: (не е инициализирано)
config-label-stock-unlimited = Наличност: Неограничена

## Roleplay View
config-title-roleplay = {"**"}Конфигурация на сървъра - Награди за ролева игра{"**"}
config-label-rp-status = {"**"}Статус:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Сървърно време:{"**"} `{ $time }`
config-label-rp-enabled = Включено
config-label-rp-disabled = Изключено

config-desc-rp-mode-scheduled = {"```"}Наградите се раздават еднократно при изпращане на необходимия брой допустими съобщения в рамките на зададения период от време (ежечасно, ежедневно или ежеседмично).{"```"}
config-desc-rp-mode-accrued = {"```"}Наградите се раздават многократно при всяко изпращане на определен брой допустими съобщения.{"```"}

config-label-rp-config-details = {"**"}Детайли на конфигурацията:{"**"}
config-label-rp-mode = {"**"}Режим:{"**"} { $mode }
config-label-rp-min-length = {"**"}Минимална дължина на съобщението:{"**"} { $length } символа
config-label-rp-cooldown = {"**"}Време на изчакване:{"**"} { $seconds } секунди
config-label-rp-frequency-once = {"**"}Честота:{"**"} Веднъж на { $period }
config-label-rp-reset-time = {"**"}Час на нулиране:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Праг:{"**"} { $count } допустими съобщения
config-label-rp-frequency-every = {"**"}Честота:{"**"} На всеки { $count } допустими съобщения

config-label-rp-channels = {"**"}Канали за ролева игра:{"**"}
config-msg-rp-no-channels = Няма конфигурирани.
config-label-rp-channels-more = ...и още { $count }.

config-label-rp-rewards = {"**"}Награди:{"**"}
config-msg-rp-no-rewards = Няма конфигурирани.
config-label-rp-experience = {"**"}Опит:{"**"} { $xp }
config-label-rp-items = {"**"}Предмети:{"**"}
config-label-rp-currency = {"**"}Валута:{"**"}

## Language View
config-title-language = {"**"}Конфигурация на сървъра - Език{"**"}
config-server-language-help =
    Тази настройка ви позволява да зададете езика по подразбиране за {"**"}публичните{"**"} отговори и съобщения на ReQuest на този сървър. Публичните отговори включват:
    - Публикации за куестове и на дъската за играчи
    - Резюме на quest и съобщения в канали за дневници
    - Презареждане на магазин
    - Консумиране на предмети от играчи

    Тази настройка засяга само статичния текст, генериран от бота, и не превежда динамично съдържание, като въведени от потребителя имена на предмети или описания на куестове.

    Личните отговори и менюта не се влияят от тази настройка.
config-label-server-language = {"**"}Език на сървъра:{"**"} { $language }
config-label-server-language-default = {"**"}Език на сървъра:{"**"} По подразбиране (без промяна)
config-select-placeholder-server-language = Изберете език на сървъра
config-select-option-default = По подразбиране (без промяна)
config-select-desc-default = Използване на предпочитанието на всеки потребител или езика на Discord.

# Quest Roles
config-btn-quest-roles = Роли за куестове
config-btn-manage-gm-quest-roles = Управление

config-modal-title-confirm-quest-role-removal = Потвърждение за премахване на роля
config-modal-label-remove-quest-role = Премахване на { $roleName } от { $gmName }?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Изберете режим на роли за куестове
config-select-option-quest-role-disabled = Изключено
config-select-desc-quest-role-disabled = Не се създават и не се присвояват роли.
config-select-option-quest-role-temporary = Временни
config-select-desc-quest-role-temporary = GM-ите могат да създават временни роли за всеки куест.
config-select-option-quest-role-static = Статични
config-select-desc-quest-role-static = GM-ите избират от предварително зададени сървърни роли.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Присвояване на сървърна роля(и) на този GM

## Quest Roles View
config-title-quest-roles = {"**"}Конфигурация на сървъра - Роли за куестове{"**"}

config-label-quest-role-mode-disabled = {"**"}Режим на роли за куестове:{"**"} Изключено
    Не се създават и не се присвояват роли по време на куестове.
config-label-quest-role-mode-temporary = {"**"}Режим на роли за куестове:{"**"} Временни
    GM-ите могат по желание да създадат временна роля при създаване на куест.
    Ролята се изтрива, когато куестът завърши или бъде отменен.
config-label-quest-role-mode-static = {"**"}Режим на роли за куестове:{"**"} Статични
    GM-ите избират от предварително зададени сървърни роли. Ролите се присвояват
    на членовете на групата по време на куестове, но никога не се изтриват.

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}Конфигурация на сървъра - Присвояване на статични роли за куестове{"**"}
config-label-manage-assignments = Управление на присвояването на роли
config-desc-manage-assignments =
    Присвояване на съществуващи сървърни роли на GM-ите за използване по време на куестове.
    Ролите трябва да са по-ниско от най-високата роля на ReQuest в йерархията на сървъра.
config-msg-no-gm-members = Не са намерени членове с GM роля на този сървър.
config-label-no-roles-assigned = Няма присвоени роли за куестове
config-label-more-roles = (+{ $count } още)

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}Управление на роли за куестове — { $gmName }{"**"}
config-error-unmanageable-roles = Следните роли не могат да бъдат присвоени, защото се управляват от интеграция, са ролята по подразбиране или са над най-високата роля на ReQuest: { $roles }
config-error-quest-role-limit = Този GM е достигнал максимума от { $limit } присвоени роли за куестове.
config-label-quest-role-count = Присвоени роли: { $count }/{ $limit }
