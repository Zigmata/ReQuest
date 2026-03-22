## Game Master module strings

# GM buttons
gm-btn-create = Създай
gm-btn-edit-details = Редакция на детайли
gm-btn-toggle-ready = Превключване на готовност
gm-btn-configure-rewards = Конфигуриране на награди
gm-btn-remove-player = Премахване на играч
gm-btn-cancel-quest = Отмяна на quest
gm-btn-manage-party-rewards = Управление на награди за групата
gm-btn-manage-individual-rewards = Управление на индивидуални награди
gm-btn-join = Присъединяване
gm-btn-leave = Напускане
gm-btn-complete-quest = Завършване на quest
gm-btn-review-submission = Преглед на заявка
gm-btn-approve = Одобри
gm-btn-deny = Отхвърли

# GM modals
gm-modal-title-create-quest = Създаване на нов quest
gm-modal-label-quest-title = Заглавие на quest
gm-modal-placeholder-quest-title = Заглавие на вашия quest
gm-modal-label-restrictions = Ограничения
gm-modal-placeholder-restrictions = Ограничения, ако има такива, като нива на играчите
gm-modal-label-max-party = Максимален размер на групата
gm-modal-placeholder-max-party = Максимален размер на групата за този quest
gm-modal-label-party-role = Роля за групата
gm-modal-placeholder-party-role = Създаване на роля за този quest (Незадължително)
gm-modal-label-description = Описание
gm-modal-placeholder-description = Напишете детайлите на вашия quest тук
gm-modal-title-editing-quest = Редактиране на { $questTitle }
gm-modal-label-title = Заглавие
gm-modal-label-max-party-size = Максимален размер на групата
gm-modal-title-add-reward = Добавяне на награда
gm-modal-label-experience = Точки опит
gm-modal-placeholder-experience = Въведете число
gm-modal-label-items = Предмети
gm-modal-placeholder-items =
    предмет: количество
    предмет2: количество
    и т.н.
gm-modal-title-add-summary = Добавяне на резюме на quest
gm-modal-label-summary = Резюме
gm-modal-placeholder-summary = Добавете кратко описание на историята на quest
gm-modal-title-modifying-player = Промяна на { $playerName }
gm-modal-placeholder-xp-add-remove = Въведете положително или отрицателно число.
gm-modal-label-inventory = Инвентар
gm-modal-placeholder-inventory-modify =
    предмет: количество
    предмет2: количество
    и т.н.
gm-modal-title-review-submission = Преглед на заявка
gm-modal-label-submission-id = ID на заявка
gm-modal-placeholder-submission-id = Въведете 8-символния ID

# GM errors
gm-error-forbidden-role-name = Предоставеното име за ролята на групата е забранено.
gm-error-role-already-exists = Роля с това име вече съществува на този сървър.
gm-error-no-quest-channel = Все още не е определен канал за публикуване на куестове. Свържете се с администратор на сървъра, за да конфигурира канала за куестове.
gm-error-cannot-ping-announce = Не може да се спомене ролята за обявления { $role } в канал { $channel }. Проверете правата на канала и ролята на ReQuest с вашия администратор(и).
gm-error-invalid-item-format = Невалиден формат на предмет: "{ $item }". Всеки предмет трябва да е на нов ред във формат "Име: Количество".
gm-error-submission-not-found = Заявката не е намерена.
gm-error-already-on-quest = Вече сте в този quest като { $characterName }.
gm-error-no-active-character-long = Нямате активен персонаж на този сървър. Използвайте `/player`, за да регистрирате или активирате персонаж.
gm-error-quest-locked = Грешка при присъединяване към quest {"**"}{ $questTitle }{"**"}: Куестът е заключен от GM.
gm-error-quest-full = Грешка при присъединяване към quest {"**"}{ $questTitle }{"**"}: Групата е пълна!
gm-error-not-signed-up = Не сте записани за този quest.
gm-error-quest-channel-not-set = Каналът за куестове не е зададен!
gm-error-empty-roster = Не можете да завършите quest с празен списък. Опитайте да отмените вместо това.
gm-error-invalid-xp-value = Стойността на XP трябва да е положително цяло число!

# GM confirm modals
gm-modal-title-cancel-quest = Отмяна на quest
gm-modal-label-cancel-quest = Напишете CONFIRM, за да отмените quest.
gm-modal-placeholder-cancel-quest = Напишете "CONFIRM", за да продължите.
gm-modal-title-remove-from-quest = Премахване на персонаж от quest
gm-modal-label-remove-from-quest = Потвърдете премахването на персонажа?
gm-modal-placeholder-remove-from-quest = Напишете "CONFIRM", за да продължите.

# GM DM messages
gm-dm-quest-cancelled = Куестът {"**"}{ $questTitle }{"**"} беше отменен от GM.
gm-dm-quest-ready = Куестът {"**"}{ $questTitle }{"**"} вече е готов!
gm-dm-quest-unlocked = Куестът {"**"}{ $questTitle }{"**"} вече не е заключен.
gm-dm-quest-locked = Куестът {"**"}{ $questTitle }{"**"} вече е заключен от GM.
gm-dm-player-removed = Бяхте премахнат/а от quest {"**"}{ $questTitle }{"**"}.
gm-dm-player-removed-waitlist = Бяхте премахнат/а от списъка на чакащите за {"**"}{ $questTitle }{"**"}.
gm-dm-party-promotion = Бяхте добавен/а в групата за {"**"}{ $questTitle }{"**"}, поради напускане на друг играч!
gm-dm-roster-locked = Списъкът на групата е заключен и групата е уведомена!
gm-dm-roster-unlocked = Списъкът на групата е отключен.
gm-dm-rewards-no-characters =
    Администраторът на вашия сървър е конфигурирал награди за GM при завършване
    на куестове. Тъй като обаче нямате регистрирани персонажи, наградите ви не могат
    да бъдат автоматично раздадени в момента.
gm-dm-rewards-no-active-character =
    Администраторът на вашия сървър е конфигурирал награди за GM при завършване
    на куестове. Тъй като обаче нямате активен персонаж на този сървър, наградите ви
    не могат да бъдат автоматично раздадени в момента.
gm-dm-rewards-issued = Следното беше присъдено на вашия активен персонаж, { $characterName }

# GM select menus
gm-select-placeholder-party-member = Изберете член на групата

# GM embeds
gm-embed-title-mod-report = Доклад за промяна на играч от GM
gm-embed-field-experience = Опит
gm-embed-title-quest-complete = Quest завършен: { $questTitle }
gm-embed-title-quest-completed = QUEST ЗАВЪРШЕН: { $questTitle }
gm-embed-field-rewards = Награди
gm-embed-field-party = __Група__
gm-embed-field-summary = Резюме
gm-embed-title-gm-rewards = Раздадени GM награди
gm-embed-field-items = Предмети
gm-msg-player-removed = Играчът е премахнат и списъкът на групата е обновен!

# GM views
gm-title-main-menu = GM - Главно меню
gm-menu-quests = Куестове
gm-menu-desc-quests = Създаване, редактиране и управление на куестове.
gm-menu-players = Играчи
gm-menu-desc-players = Управление на инвентарите на играчите и промяна на персонажи.
gm-menu-approvals = Одобрения на персонажи
gm-menu-desc-approvals = Преглед и одобрение/отхвърляне на заявки за персонажи.

gm-title-quest-management = GM - Управление на куестове
gm-desc-create-quest = Създаване на нов quest.
gm-msg-no-quests = Няма намерени куестове.
gm-label-quest-locked = (Заключен)
gm-title-manage-quest = Управление на quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Редакция на детайлите на quest, като заглавие, описание и размер на групата.
gm-desc-toggle-ready = Превключване на състояние на готовност (Текущо: {"**"}{ $status }{"**"})
    - Заключва списъка на групата и уведомява членовете, че quest ще започне скоро. Ако е конфигурирана роля, тя ще бъде присвоена на членовете при заключване.
    - Отключва списъка, когато е зададено на Отворен.
gm-label-ready-locked = Заключен/Готов
gm-label-ready-open = Отворен
gm-desc-configure-rewards = Конфигуриране на награди за избрания quest.
gm-desc-complete-quest = Завършване на quest. Раздава награди, ако има такива, на членовете на групата.
gm-desc-remove-player = Премахване на играч от списъка на групата и уведомяването му.
gm-desc-cancel-quest = Отмяна на quest и изтриването му от дъската за куестове.
gm-title-player-management = GM - Управление на играчите
gm-desc-player-management =
    Тези команди са мигрирани в контекстни менюта. Щракнете с десен бутон (десктоп) или натиснете и задръжте (мобилно) профила на играча за следните опции:

    - {"**"}Modify Player{"**"}: Добавяне или премахване на предмети и опит от играч.
    - {"**"}View Player{"**"}: Преглед на детайлите на активния персонаж на играч.
gm-title-remove-player = Премахване на играч от quest - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Бележки за премахване на играч{"**"}__

    - Изберете играч от падащото меню по-долу, за да го премахнете от списъка на групата.
    - Ако има играчи в списъка на чакащите, първият играч ще бъде повишен в групата.
    - Индивидуалните награди за премахнатия играч ще бъдат изтрити от quest.
    - Ако искате да наградите играча за предишния му принос, използвайте контекстното меню `Modify Player`, за да му раздадете награди директно.
gm-label-no-players-in-roster = Няма играчи в списъка на групата
gm-title-character-sheet = Лист на персонажа за { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Точки опит:{"**"}__
gm-label-possessions = __{"**"}Притежания{"**"}__
gm-label-currency-heading = {"**"}Валута{"**"}
gm-msg-inventory-empty = Инвентарът е празен.

# GM approvals
gm-title-approvals = GM - Одобрения на инвентар
gm-desc-review-submission = Въведете ID на заявка, за да я прегледате и одобрите/отхвърлите.
gm-title-reviewing = Преглед: { $characterName }
gm-label-items = {"**"}Предмети:{"**"}
gm-label-currency = {"**"}Валута:{"**"}
gm-embed-title-approved = Обновяването на инвентара е одобрено
gm-embed-desc-approved = Инвентарът за {"**"}{ $characterName }{"**"} беше одобрен от { $approver }.
gm-embed-title-denied = Обновяването на инвентара е отхвърлено
gm-embed-desc-denied = Инвентарът за {"**"}{ $characterName }{"**"} беше отхвърлен от { $denier }.

gm-modal-label-select-party-role = Роля за групата
gm-modal-desc-select-party-role = Изберете роля за присвояване на групата на куеста.
gm-select-option-no-role = Без (Без роля за групата)

gm-error-role-hierarchy = ReQuest не може да управлява ролята "{ $roleName }" (ID: { $roleId }), защото е позиционирана по-високо от най-високата роля на ReQuest в йерархията на сървъра. Моля, свържете се с администратор на сървъра, за да премести ролята под ролята на ReQuest, или да присвои на ReQuest по-висока роля, след което опитайте отново.
gm-dm-role-removal-failed =
    ⚠️ Неуспешно премахване на ролята {"**"}{ $roleName }{"**"} от следните членове: { $members }.
    Моля, уведомете администратор на сървъра да премахне ролята ръчно.

gm-dm-role-not-found =
    ⚠️ Ролята за куест (ID: { $roleId }) за куест {"**"}{ $questTitle }{"**"} вече не съществува на сървъра.
    Операциите с роли бяха пропуснати. Моля, уведомете администратор на сървъра, ако това е неочаквано.
