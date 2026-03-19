## Строки модуля Мастера Игры

# Кнопки GM
gm-btn-create = Создать
gm-btn-edit-details = Редактировать детали
gm-btn-toggle-ready = Переключить готовность
gm-btn-configure-rewards = Настроить награды
gm-btn-remove-player = Удалить игрока
gm-btn-cancel-quest = Отменить квест
gm-btn-manage-party-rewards = Управление наградами отряда
gm-btn-manage-individual-rewards = Управление индивидуальными наградами
gm-btn-join = Вступить
gm-btn-leave = Покинуть
gm-btn-complete-quest = Завершить квест
gm-btn-review-submission = Проверить заявку
gm-btn-approve = Одобрить
gm-btn-deny = Отклонить

# Модальные окна GM
gm-modal-title-create-quest = Создание нового квеста
gm-modal-label-quest-title = Название квеста
gm-modal-placeholder-quest-title = Название вашего квеста
gm-modal-label-restrictions = Ограничения
gm-modal-placeholder-restrictions = Ограничения, если есть, например уровень игроков
gm-modal-label-max-party = Максимальный размер отряда
gm-modal-placeholder-max-party = Максимальный размер отряда для этого квеста
gm-modal-label-party-role = Роль отряда
gm-modal-placeholder-party-role = Создать роль для этого квеста (Опционально)
gm-modal-label-description = Описание
gm-modal-placeholder-description = Опишите детали вашего квеста здесь
gm-modal-title-editing-quest = Редактирование { $questTitle }
gm-modal-label-title = Название
gm-modal-label-max-party-size = Максимальный размер отряда
gm-modal-title-add-reward = Добавить награду
gm-modal-label-experience = Очки опыта
gm-modal-placeholder-experience = Введите число
gm-modal-label-items = Предметы
gm-modal-placeholder-items =
    предмет: количество
    предмет2: количество
    и т.д.
gm-modal-title-add-summary = Добавить итог квеста
gm-modal-label-summary = Итог
gm-modal-placeholder-summary = Добавьте краткий сюжетный итог квеста
gm-modal-title-modifying-player = Изменение { $playerName }
gm-modal-placeholder-xp-add-remove = Введите положительное или отрицательное число.
gm-modal-label-inventory = Инвентарь
gm-modal-placeholder-inventory-modify =
    предмет: количество
    предмет2: количество
    и т.д.
gm-modal-title-review-submission = Проверка заявки
gm-modal-label-submission-id = ID заявки
gm-modal-placeholder-submission-id = Введите 8-символьный ID

# Ошибки GM
gm-error-forbidden-role-name = Указанное название роли отряда является запрещённым.
gm-error-role-already-exists = Роль с таким названием уже существует на этом сервере.
gm-error-no-quest-channel = Канал для публикации квестов ещё не назначен. Обратитесь к администратору сервера для настройки канала квестов.
gm-error-cannot-ping-announce = Не удалось упомянуть роль для анонсов { $role } в канале { $channel }. Проверьте права канала и роли ReQuest с администратором(ами) сервера.
gm-error-invalid-item-format = Неверный формат предмета: "{ $item }". Каждый предмет должен быть на отдельной строке в формате "Название: Количество".
gm-error-submission-not-found = Заявка не найдена.
gm-error-already-on-quest = Вы уже участвуете в этом квесте как { $characterName }.
gm-error-no-active-character-long = У вас нет активного персонажа на этом сервере. Используйте `/player` для регистрации или активации персонажа.
gm-error-quest-locked = Ошибка при вступлении в квест {"**"}{ $questTitle }{"**"}: Квест заблокирован GM.
gm-error-quest-full = Ошибка при вступлении в квест {"**"}{ $questTitle }{"**"}: Отряд укомплектован!
gm-error-not-signed-up = Вы не записаны на этот квест.
gm-error-quest-channel-not-set = Канал квестов не установлен!
gm-error-empty-roster = Нельзя завершить квест с пустым составом. Попробуйте отменить вместо этого.
gm-error-invalid-xp-value = Значение XP должно быть положительным целым числом!

# Модальные окна подтверждения GM
gm-modal-title-cancel-quest = Отмена квеста
gm-modal-label-cancel-quest = Введите CONFIRM для отмены квеста.
gm-modal-placeholder-cancel-quest = Введите "CONFIRM" для продолжения.
gm-modal-title-remove-from-quest = Удаление персонажа из квеста
gm-modal-label-remove-from-quest = Подтвердить удаление персонажа?
gm-modal-placeholder-remove-from-quest = Введите "CONFIRM" для продолжения.

# Личные сообщения GM
gm-dm-quest-cancelled = Квест {"**"}{ $questTitle }{"**"} был отменён GM.
gm-dm-quest-ready = Квест {"**"}{ $questTitle }{"**"} готов!
gm-dm-quest-unlocked = Квест {"**"}{ $questTitle }{"**"} больше не заблокирован.
gm-dm-quest-locked = Квест {"**"}{ $questTitle }{"**"} заблокирован GM.
gm-dm-player-removed = Вы были удалены из квеста {"**"}{ $questTitle }{"**"}.
gm-dm-player-removed-waitlist = Вы были удалены из листа ожидания квеста {"**"}{ $questTitle }{"**"}.
gm-dm-party-promotion = Вы были добавлены в отряд квеста {"**"}{ $questTitle }{"**"}, так как один из игроков вышел!
gm-dm-roster-locked = Состав квеста заблокирован, отряд уведомлён!
gm-dm-roster-unlocked = Состав квеста разблокирован.
gm-dm-rewards-no-characters =
    Администратор вашего сервера настроил награды для Мастеров Игры при завершении
    квестов. Однако, поскольку у вас нет зарегистрированных персонажей, ваши награды не могли
    быть автоматически выданы в данный момент.
gm-dm-rewards-no-active-character =
    Администратор вашего сервера настроил награды для Мастеров Игры при завершении
    квестов. Однако, поскольку у вас нет активного персонажа на этом сервере, ваши награды не могли
    быть автоматически выданы в данный момент.
gm-dm-rewards-issued = Следующее было выдано вашему активному персонажу, { $characterName }

# Выпадающие списки GM
gm-select-placeholder-party-member = Выберите участника отряда

# Встраиваемые сообщения GM
gm-embed-title-mod-report = Отчёт GM об изменении игрока
gm-embed-field-experience = Опыт
gm-embed-title-quest-complete = Квест завершён: { $questTitle }
gm-embed-title-quest-completed = КВЕСТ ЗАВЕРШЁН: { $questTitle }
gm-embed-field-rewards = Награды
gm-embed-field-party = __Отряд__
gm-embed-field-summary = Итог
gm-embed-title-gm-rewards = Награды GM выданы
gm-embed-field-items = Предметы
gm-msg-player-removed = Игрок удалён, состав квеста обновлён!

# Представления GM
gm-title-main-menu = Мастер Игры - Главное меню
gm-menu-quests = Квесты
gm-menu-desc-quests = Создание, редактирование и управление квестами.
gm-menu-players = Игроки
gm-menu-desc-players = Управление инвентарями игроков и изменение персонажей.
gm-menu-approvals = Одобрение персонажей
gm-menu-desc-approvals = Проверка и одобрение/отклонение заявок на персонажей.

gm-title-quest-management = Мастер Игры - Управление квестами
gm-desc-create-quest = Создать новый квест.
gm-msg-no-quests = Квесты не найдены.
gm-label-quest-locked = (Заблокирован)
gm-title-manage-quest = Управление квестом - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Редактировать детали квеста: название, описание и размер отряда.
gm-desc-toggle-ready = Переключить состояние готовности (Текущее: {"**"}{ $status }{"**"})
    - Блокирует состав квеста и уведомляет участников отряда о скором начале квеста. Если настроена роль, она будет назначена участникам отряда при блокировке.
    - Разблокирует состав при установке на «Открыт».
gm-label-ready-locked = Заблокирован/Готов
gm-label-ready-open = Открыт
gm-desc-configure-rewards = Настроить награды для выбранного квеста.
gm-desc-complete-quest = Завершить квест. Выдаёт награды, если есть, участникам отряда.
gm-desc-remove-player = Удалить игрока из состава квеста и уведомить его.
gm-desc-cancel-quest = Отменить квест и удалить его с доски квестов.
gm-title-player-management = Мастер Игры - Управление игроками
gm-desc-player-management =
    Эти команды перенесены в контекстные меню. Щёлкните правой кнопкой мыши (ПК) или удерживайте (мобильный) профиль игрока для доступа к следующим пунктам:

    - {"**"}Modify Player{"**"}: Добавить или удалить предметы и опыт у игрока.
    - {"**"}View Player{"**"}: Просмотреть данные активного персонажа игрока.
gm-title-remove-player = Удаление игрока из квеста - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Примечания по удалению игрока{"**"}__

    - Выберите игрока из выпадающего списка ниже, чтобы удалить его из состава квеста.
    - Если есть игроки в листе ожидания, первый из них будет переведён в отряд.
    - Индивидуальные награды удалённого игрока будут удалены из квеста.
    - Если вы хотите наградить игрока за предыдущий вклад, используйте контекстное меню `Modify Player` для прямой выдачи наград.
gm-label-no-players-in-roster = Нет игроков в составе квеста
gm-title-character-sheet = Лист персонажа { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Очки опыта:{"**"}__
gm-label-possessions = __{"**"}Имущество{"**"}__
gm-label-currency-heading = {"**"}Валюта{"**"}
gm-msg-inventory-empty = Инвентарь пуст.

# Одобрение заявок GM
gm-title-approvals = Мастер Игры - Одобрение инвентарей
gm-desc-review-submission = Введите ID заявки для проверки и одобрения/отклонения.
gm-title-reviewing = Проверка: { $characterName }
gm-label-items = {"**"}Предметы:{"**"}
gm-label-currency = {"**"}Валюта:{"**"}
gm-embed-title-approved = Обновление инвентаря одобрено
gm-embed-desc-approved = Инвентарь персонажа {"**"}{ $characterName }{"**"} одобрен { $approver }.
gm-embed-title-denied = Обновление инвентаря отклонено
gm-embed-desc-denied = Инвентарь персонажа {"**"}{ $characterName }{"**"} отклонён { $denier }.
