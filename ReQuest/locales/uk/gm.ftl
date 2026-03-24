## Рядки модуля Ведучого Гри

# Кнопки GM
gm-btn-create = Створити
gm-btn-edit-details = Редагувати деталі
gm-btn-toggle-ready = Перемкнути готовність
gm-btn-configure-rewards = Налаштувати нагороди
gm-btn-remove-player = Видалити гравця
gm-btn-cancel-quest = Скасувати квест
gm-btn-manage-party-rewards = Керувати груповими нагородами
gm-btn-manage-individual-rewards = Керувати індивідуальними нагородами
gm-btn-join = Приєднатися
gm-btn-leave = Покинути
gm-btn-complete-quest = Завершити квест
gm-btn-review-submission = Переглянути заявку
gm-btn-approve = Схвалити
gm-btn-deny = Відхилити

# Модальні вікна GM
gm-modal-title-create-quest = Створити новий квест
gm-modal-label-quest-title = Назва квесту
gm-modal-placeholder-quest-title = Назва вашого квесту
gm-modal-label-restrictions = Обмеження
gm-modal-placeholder-restrictions = Обмеження, якщо є, наприклад рівні гравців
gm-modal-label-max-party = Максимальний розмір групи
gm-modal-placeholder-max-party = Максимальний розмір групи для цього квесту
gm-modal-label-party-role = Роль групи
gm-modal-placeholder-party-role = Створити роль для цього квесту (Необов'язково)
gm-modal-label-description = Опис
gm-modal-placeholder-description = Напишіть деталі вашого квесту тут
gm-modal-title-editing-quest = Редагування { $questTitle }
gm-modal-label-title = Назва
gm-modal-label-max-party-size = Максимальний розмір групи
gm-modal-title-add-reward = Додати нагороду
gm-modal-label-experience = Очки досвіду
gm-modal-placeholder-experience = Введіть число
gm-modal-label-items = Предмети
gm-modal-placeholder-items =
    предмет: кількість
    предмет2: кількість
    тощо.
gm-modal-title-add-summary = Додати підсумок квесту
gm-modal-label-summary = Підсумок
gm-modal-placeholder-summary = Додайте сюжетний підсумок квесту
gm-modal-title-modifying-player = Зміна { $playerName }
gm-modal-placeholder-xp-add-remove = Введіть додатне або від'ємне число.
gm-modal-label-inventory = Інвентар
gm-modal-placeholder-inventory-modify =
    предмет: кількість
    предмет2: кількість
    тощо.
gm-modal-title-review-submission = Переглянути заявку
gm-modal-label-submission-id = ID заявки
gm-modal-placeholder-submission-id = Введіть 8-символьний ID

# Помилки GM
gm-error-forbidden-role-name = Надана назва для ролі групи є забороненою.
gm-error-role-already-exists = Роль з такою назвою вже існує на цьому сервері.
gm-error-no-quest-channel = Канал для публікацій квестів ще не призначено. Зверніться до адміністратора сервера для налаштування каналу квестів.
gm-error-cannot-ping-announce = Не вдалося згадати роль оголошень { $role } у каналі { $channel }. Перевірте дозволи каналу та ролі ReQuest з адміністратором(ами) сервера.
gm-error-invalid-item-format = Недійсний формат предмета: "{ $item }". Кожен предмет має бути на новому рядку у форматі "Назва: Кількість".
gm-error-submission-not-found = Заявку не знайдено.
gm-error-already-on-quest = Ви вже на цьому квесті як { $characterName }.
gm-error-no-active-character-long = У вас немає активного персонажа на цьому сервері. Використовуйте `/player`, щоб зареєструвати або активувати персонажа.
gm-error-quest-locked = Помилка приєднання до квесту {"**"}{ $questTitle }{"**"}: Квест заблоковано GM.
gm-error-quest-full = Помилка приєднання до квесту {"**"}{ $questTitle }{"**"}: Список учасників квесту заповнений!
gm-error-not-signed-up = Ви не зареєстровані на цей квест.
gm-error-quest-channel-not-set = Канал квестів не встановлено!
gm-error-empty-roster = Ви не можете завершити квест з порожнім списком учасників. Спробуйте скасувати натомість.
gm-error-invalid-xp-value = Значення XP має бути додатнім цілим числом!

# Модальні вікна підтвердження GM
gm-modal-title-cancel-quest = Скасувати квест
gm-modal-label-cancel-quest = Введіть ПІДТВЕРДИТИ для скасування квесту.
gm-modal-title-remove-from-quest = Видалити персонажа з квесту
gm-modal-label-remove-from-quest = Підтвердити видалення персонажа?

# Особисті повідомлення GM
gm-dm-quest-cancelled = Квест {"**"}{ $questTitle }{"**"} було скасовано GM.
gm-dm-quest-ready = Квест {"**"}{ $questTitle }{"**"} тепер готовий!
gm-dm-quest-unlocked = Квест {"**"}{ $questTitle }{"**"} більше не заблокований.
gm-dm-quest-locked = Квест {"**"}{ $questTitle }{"**"} тепер заблоковано GM.
gm-dm-player-removed = Вас було видалено з квесту {"**"}{ $questTitle }{"**"}.
gm-dm-player-removed-waitlist = Вас було видалено зі списку очікування на {"**"}{ $questTitle }{"**"}.
gm-dm-party-promotion = Вас додано до групи квесту {"**"}{ $questTitle }{"**"}, оскільки один з гравців покинув!
gm-dm-roster-locked = Список учасників квесту заблоковано та групу повідомлено!
gm-dm-roster-unlocked = Список учасників квесту розблоковано.
gm-dm-rewards-no-characters =
    Адміністратор вашого сервера налаштував нагороди для Ведучих Гри за завершення
    квестів. Однак, оскільки у вас немає зареєстрованих персонажів, ваші нагороди
    не могли бути автоматично видані на цей момент.
gm-dm-rewards-no-active-character =
    Адміністратор вашого сервера налаштував нагороди для Ведучих Гри за завершення
    квестів. Однак, оскільки у вас немає активного персонажа на цьому сервері, ваші
    нагороди не могли бути автоматично видані на цей момент.
gm-dm-rewards-issued = Наступне було нараховано вашому активному персонажу, { $characterName }

# Меню вибору GM
gm-select-placeholder-party-member = Оберіть учасника групи

# Вбудовані повідомлення GM
gm-embed-title-mod-report = Звіт про зміну гравця GM
gm-embed-field-experience = Досвід
gm-embed-title-quest-complete = Квест завершено: { $questTitle }
gm-embed-title-quest-completed = КВЕСТ ЗАВЕРШЕНО: { $questTitle }
gm-embed-field-rewards = Нагороди
gm-embed-field-party = __Група__
gm-embed-field-summary = Підсумок
gm-embed-title-gm-rewards = Нагороди GM видано
gm-embed-field-items = Предмети
gm-msg-player-removed = Гравця видалено та список учасників квесту оновлено!

# Подання GM
gm-title-main-menu = Ведучий Гри - Головне меню
gm-menu-quests = Квести
gm-menu-desc-quests = Створювати, редагувати та керувати квестами.
gm-menu-players = Гравці
gm-menu-desc-players = Керувати інвентарями гравців та змінювати персонажів.
gm-menu-approvals = Схвалення персонажів
gm-menu-desc-approvals = Переглядати та схвалювати/відхиляти заявки персонажів.

gm-title-quest-management = Ведучий Гри - Керування квестами
gm-desc-create-quest = Створити новий квест.
gm-msg-no-quests = Квестів не знайдено.
gm-label-quest-locked = (Заблоковано)
gm-title-manage-quest = Керування квестом - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Редагувати деталі квесту, такі як назва, опис та розмір групи.
gm-desc-toggle-ready = Перемкнути стан готовності (Поточний: {"**"}{ $status }{"**"})
    - Блокує список учасників квесту та повідомляє членів групи про швидкий початок квесту. Якщо налаштовано роль, вона буде призначена членам групи при блокуванні.
    - Розблоковує список учасників при встановленні на Відкрито.
gm-label-ready-locked = Заблоковано/Готово
gm-label-ready-open = Відкрито
gm-desc-configure-rewards = Налаштувати нагороди для обраного квесту.
gm-desc-complete-quest = Завершити квест. Видає нагороди, якщо є, членам групи.
gm-desc-remove-player = Видалити гравця зі списку учасників квесту та повідомити його.
gm-desc-cancel-quest = Скасувати квест та видалити його з дошки квестів.
gm-title-player-management = Ведучий Гри - Керування гравцями
gm-desc-player-management =
    Ці команди перенесено до контекстних меню. Клацніть правою кнопкою миші (десктоп) або утримуйте (мобільний) профіль гравця для наступних пунктів меню:

    - {"**"}Змінити Гравця{"**"}: Додати або видалити предмети та досвід у гравця.
    - {"**"}Переглянути Гравця{"**"}: Переглянути деталі активного персонажа гравця.
gm-title-remove-player = Видалити гравця з квесту - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Примітки щодо видалення гравця{"**"}__

    - Оберіть гравця з випадаючого списку нижче, щоб видалити його зі списку учасників квесту.
    - Якщо хтось є у списку очікування, перший гравець зі списку буде переведений до групи.
    - Індивідуальні нагороди для видаленого гравця будуть видалені з квесту.
    - Якщо ви бажаєте нагородити гравця за попередній внесок, використовуйте контекстне меню `Змінити Гравця`, щоб видати нагороди безпосередньо.
gm-label-no-players-in-roster = Немає гравців у списку учасників квесту
gm-title-character-sheet = Аркуш персонажа { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Очки досвіду:{"**"}__
gm-label-possessions = __{"**"}Майно{"**"}__
gm-label-currency-heading = {"**"}Валюта{"**"}
gm-msg-inventory-empty = Інвентар порожній.

# Схвалення GM
gm-title-approvals = Ведучий Гри - Схвалення інвентарю
gm-desc-review-submission = Введіть ID заявки для перегляду та схвалення/відхилення.
gm-title-reviewing = Перегляд: { $characterName }
gm-label-items = {"**"}Предмети:{"**"}
gm-label-currency = {"**"}Валюта:{"**"}
gm-embed-title-approved = Оновлення інвентарю схвалено
gm-embed-desc-approved = Інвентар для {"**"}{ $characterName }{"**"} було схвалено { $approver }.
gm-embed-title-denied = Оновлення інвентарю відхилено
gm-embed-desc-denied = Інвентар для {"**"}{ $characterName }{"**"} було відхилено { $denier }.

gm-modal-label-select-party-role = Роль групи
gm-modal-desc-select-party-role = Оберіть роль для призначення групі квесту.
gm-select-option-no-role = Немає (без ролі групи)

gm-error-role-hierarchy = ReQuest не може керувати роллю "{ $roleName }" (ID: { $roleId }), оскільки вона розташована вище найвищої ролі ReQuest в ієрархії сервера. Будь ласка, зверніться до адміністратора сервера, щоб перемістити роль нижче ролі ReQuest або призначити ReQuest вищу роль, а потім повторіть операцію.
gm-dm-role-removal-failed =
    ⚠️ Не вдалося видалити роль {"**"}{ $roleName }{"**"} у наступних учасників: { $members }.
    Будь ласка, повідомте адміністратора сервера для ручного видалення ролі.

gm-dm-role-not-found =
    ⚠️ Роль квесту (ID: { $roleId }) для квесту {"**"}{ $questTitle }{"**"} більше не існує на сервері.
    Операції з ролями були пропущені. Будь ласка, повідомте адміністратора сервера, якщо це несподівано.
