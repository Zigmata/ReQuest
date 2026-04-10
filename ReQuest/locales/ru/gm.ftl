## Строки модуля Мастера Игры

# Кнопки GM
gm-btn-create = Создать
gm-btn-edit-details = Редактировать квест
gm-btn-toggle-ready = Переключить готовность
gm-btn-configure-rewards = Настроить награды
gm-btn-remove-player = Удалить игрока
gm-btn-cancel-quest = Отменить квест
gm-btn-manage-party-rewards = Управление наградами отряда
gm-btn-manage-individual-rewards = Управление индивидуальными наградами
gm-btn-join = Вступить
gm-btn-leave = Покинуть
gm-btn-complete-quest = Завершить квест
gm-btn-edit-details-modal = Редактировать детали
gm-btn-edit-images = Редактировать изображения
gm-select-placeholder-party-role = Выберите роль отряда...
gm-modal-title-edit-details = Редактирование деталей квеста
gm-modal-title-edit-images = Редактирование изображений квеста
gm-btn-publish = Опубликовать
gm-btn-update-post = Обновить публикацию

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
gm-modal-label-image-url = URL миниатюры
gm-modal-label-large-image-url = URL большого изображения
gm-modal-placeholder-image-url = Введите URL изображения (или оставьте пустым для удаления)
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

# Ошибки GM
gm-error-forbidden-role-name = Указанное название роли отряда является запрещённым.
gm-error-role-already-exists = Роль с таким названием уже существует на этом сервере.
gm-error-no-quest-channel = Канал для публикации квестов ещё не назначен. Обратитесь к администратору сервера для настройки канала квестов.
gm-error-cannot-ping-announce = Не удалось упомянуть роль для анонсов { $role } в канале { $channel }. Проверьте права канала и роли ReQuest с администратором(ами) сервера.
gm-error-invalid-item-format = Неверный формат предмета: "{ $item }". Каждый предмет должен быть на отдельной строке в формате "Название: Количество".
gm-error-already-on-quest = Вы уже участвуете в этом квесте как { $characterName }.
gm-error-no-active-character-long = У вас нет активного персонажа на этом сервере. Используйте `/player` для регистрации или активации персонажа.
gm-error-quest-locked = Ошибка при вступлении в квест {"**"}{ $questTitle }{"**"}: Квест заблокирован GM.
gm-error-quest-full = Ошибка при вступлении в квест {"**"}{ $questTitle }{"**"}: Отряд укомплектован!
gm-error-not-signed-up = Вы не записаны на этот квест.
gm-error-quest-not-found = Квест больше не существует.
gm-error-quest-channel-not-set = Канал квестов не установлен!
gm-error-empty-roster = Нельзя завершить квест с пустым составом. Попробуйте отменить вместо этого.
gm-error-invalid-xp-value = Значение XP должно быть положительным целым числом!
gm-error-role-hierarchy = ReQuest не может управлять ролью "{ $roleName }" (ID: { $roleId }), так как она расположена выше наивысшей роли ReQuest в иерархии сервера. Обратитесь к администратору сервера, чтобы переместить роль ниже роли ReQuest или назначить ReQuest более высокую роль, затем повторите операцию.
gm-error-party-size-positive = Размер отряда должен быть положительным числом.
gm-error-party-size-too-small = Размер отряда не может быть меньше текущего состава ({ $currentSize } участников).
gm-error-role-name-forbidden = Название роли "{ $roleName }" запрещено на этом сервере.
gm-error-role-name-exists = Роль с названием "{ $roleName }" уже существует на этом сервере.

# Модальные окна подтверждения GM
gm-modal-title-cancel-quest = Отмена квеста
gm-modal-label-cancel-quest = Введите ПОДТВЕРДИТЬ для отмены квеста.
gm-modal-title-remove-from-quest = Удаление персонажа из квеста
gm-modal-label-remove-from-quest = Подтвердить удаление персонажа?

# GM DM embeds
gm-dm-title-quest-cancelled = Квест отменён
gm-dm-desc-quest-cancelled = Квест {"**"}{ $questTitle }{"**"} был отменён GM.
gm-dm-title-quest-ready = Квест готов
gm-dm-desc-quest-ready = Квест {"**"}{ $questTitle }{"**"} теперь готов! Ваш GM скоро начнёт квест.
gm-dm-title-player-removed = Удалён из квеста
gm-dm-desc-player-removed = Вы были удалены из квеста {"**"}{ $questTitle }{"**"} GM.
gm-dm-desc-player-removed-waitlist = Вы были удалены из листа ожидания квеста {"**"}{ $questTitle }{"**"}.
gm-dm-title-party-promotion = Повышение в отряд
gm-dm-desc-party-promotion =
    Вы были повышены в основной отряд квеста {"**"}{ $questTitle }{"**"},
    так как один из игроков покинул квест.
gm-dm-title-roster-locked = Состав заблокирован
gm-dm-desc-roster-locked =
    Состав квеста {"**"}{ $questTitle }{"**"} был заблокирован,
    и все участники отряда были уведомлены.
gm-dm-title-roster-unlocked = Состав разблокирован
gm-dm-desc-roster-unlocked = Состав квеста {"**"}{ $questTitle }{"**"} был разблокирован.
gm-dm-title-player-removed-confirm = Игрок удалён
gm-dm-desc-player-removed-confirm =
    Игрок был удалён из квеста {"**"}{ $questTitle }{"**"},
    и состав квеста был обновлён.
gm-dm-footer-quest = ID квеста: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    Администратор вашего сервера настроил награды для Мастеров Игры при завершении
    квестов. Однако, поскольку у вас нет зарегистрированных персонажей, ваши награды не могли
    быть автоматически выданы в данный момент.
gm-dm-rewards-no-active-character =
    Администратор вашего сервера настроил награды для Мастеров Игры при завершении
    квестов. Однако, поскольку у вас нет активного персонажа на этом сервере, ваши награды не могли
    быть автоматически выданы в данный момент.
gm-dm-rewards-issued = Следующее было выдано вашему активному персонажу, { $characterName }
gm-dm-role-removal-failed =
    ⚠️ Не удалось удалить роль {"**"}{ $roleName }{"**"} у следующих участников: { $members }.
    Уведомите администратора сервера для ручного удаления роли.
gm-dm-role-not-found =
    ⚠️ Роль квеста (ID: { $roleId }) для квеста {"**"}{ $questTitle }{"**"} больше не существует на сервере.
    Операции с ролями были пропущены. Уведомите администратора сервера, если это неожиданно.

# Выпадающие списки GM
gm-select-placeholder-party-member = Выберите участника отряда
gm-modal-label-select-party-role = Роль отряда
gm-modal-desc-select-party-role = Выберите роль для назначения отряду квеста.
gm-select-option-no-role = Нет (Без роли отряда)

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

# Представления GM
gm-title-main-menu = Мастер Игры - Главное меню
gm-menu-quests = Квесты
gm-menu-desc-quests = Создание, редактирование и управление квестами.
gm-menu-players = Игроки
gm-menu-desc-players = Управление инвентарями игроков и изменение персонажей.

gm-title-quest-management = Мастер Игры - Управление квестами
gm-desc-create-quest = Создать новый квест.
gm-msg-no-quests = Квесты не найдены.
gm-label-quest-locked = (Заблокирован)
gm-label-quest-draft = (Черновик)
gm-title-manage-quest = Управление квестом - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Редактировать детали квеста: название, описание и размер отряда.
gm-title-edit-quest = Редактирование квеста - { $questTitle }
gm-label-field-not-set = Не задано
gm-label-description-not-set = Описание не задано
gm-label-current-title = {"**"}Название:{"**"} { $value }
gm-label-current-description = {"**"}Описание{"**"}
gm-label-current-restrictions = {"**"}Ограничения:{"**"} { $value }
gm-label-current-party-size = {"**"}Максимальный размер отряда:{"**"} { $value }
gm-label-current-party-role = {"**"}Роль отряда:{"**"} { $value }
gm-label-current-image = {"**"}Миниатюра{"**"}
gm-label-current-large-image = {"**"}Изображение{"**"}
gm-desc-publish-quest = Опубликовать этот квест на доске квестов.
gm-desc-update-quest-post = Обновить публикацию квеста на доске квестов.
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

    - {"**"}Изменить Игрока{"**"}: Добавить или удалить предметы и опыт у игрока.
    - {"**"}Просмотр Игрока{"**"}: Просмотреть данные активного персонажа игрока.
gm-title-remove-player = Удаление игрока из квеста - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Примечания по удалению игрока{"**"}__

    - Выберите игрока из выпадающего списка ниже, чтобы удалить его из состава квеста.
    - Если есть игроки в листе ожидания, первый из них будет переведён в отряд.
    - Индивидуальные награды удалённого игрока будут удалены из квеста.
    - Если вы хотите наградить игрока за предыдущий вклад, используйте контекстное меню `Изменить Игрока` для прямой выдачи наград.
gm-label-no-players-in-roster = Нет игроков в составе квеста
gm-title-character-sheet = Лист персонажа { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Очки опыта:{"**"}__
gm-label-possessions = __{"**"}Имущество{"**"}__
gm-label-currency-heading = {"**"}Валюта{"**"}
gm-msg-inventory-empty = Инвентарь пуст.

# Одобрение заявок GM
