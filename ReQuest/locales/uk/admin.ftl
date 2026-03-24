## Рядки модуля адміністрування

# Ког адміністрування
admin-embed-title-unauthorized = Неавторизований сервер
admin-embed-desc-unauthorized =
    Дякуємо за інтерес до ReQuest! Вашого сервера немає у списку авторизованих тестових серверів ReQuest.
    Будь ласка, приєднайтесь до Discord підтримки нижче та зверніться до команди розробників, щоб запросити тестовий доступ.

    [Discord розробки ReQuest](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Наступні команди були синхронізовані з { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Наступні команди були синхронізовані глобально
admin-error-missing-scope = ReQuest не має правильного обсягу прав у цільовому сервері. Додайте дозвіл `applications.commands` і спробуйте знову.
admin-error-sync-failed = Виникла помилка при синхронізації команд: { $error }
admin-msg-commands-cleared = Команди очищено.

# Кнопки адміністрування
admin-btn-shutdown = Вимкнути
admin-modal-title-confirm-shutdown = Підтвердження вимкнення
admin-modal-label-shutdown-warning = Увага! Це вимкне бота. Введіть ПІДТВЕРДИТИ для продовження.
admin-msg-shutting-down = Вимикаюсь!
admin-btn-add-server = Додати новий сервер
admin-btn-load-cog = Завантажити ког
admin-msg-extension-loaded = Розширення успішно завантажено: `{ $module }`
admin-btn-reload-cog = Перезавантажити ког
admin-msg-extension-reloaded = Розширення успішно перезавантажено: `{ $module }`
admin-btn-output-guilds = Вивести список серверів
admin-msg-connected-guilds = Підключено до { $count } серверів:

# Модальні вікна адміністрування
admin-modal-title-add-server = Додати ID сервера до списку дозволених
admin-modal-label-server-name = Назва сервера
admin-modal-placeholder-server-name = Введіть коротку назву для Discord-сервера
admin-modal-label-server-id = ID сервера
admin-modal-placeholder-server-id = Введіть ID Discord-сервера
admin-select-placeholder-server = Оберіть сервер для видалення
admin-modal-title-cog-action = { $action } ког
admin-modal-label-cog-name = Назва
admin-modal-placeholder-cog-name = Введіть назву кога для { $action }

# Подання адміністрування
admin-title-main-menu = Адміністрування - Головне меню
admin-desc-allowlist = Налаштувати список дозволених серверів для обмежень запрошень.
admin-desc-cogs = Завантажити або перезавантажити коги.
admin-desc-guild-list = Повертає список усіх серверів, учасником яких є бот.
admin-desc-shutdown = Вимикає бота
admin-title-allowlist = Адміністрування - Список дозволених серверів
admin-desc-allowlist-warning =
    Додати новий ID Discord-сервера до списку дозволених.
    {"**"}УВАГА: Немає способу перевірити, чи є наданий ID сервера дійсним, без того, щоб бот був учасником сервера. Перевірте свої дані!{"**"}
admin-msg-no-servers = Немає серверів у списку дозволених.

# Модальні вікна підтвердження адміністрування
admin-modal-title-confirm-server-removal = Підтвердження видалення сервера
admin-modal-label-server-removal = Видалити сервер зі списку дозволених?

# Подання когів адміністрування
admin-title-cogs = Адміністрування - Коги
admin-desc-load-cog = Завантажити ког бота за назвою. Файл повинен називатися `<name>.py` і зберігатися в ReQuest/cogs/.
admin-desc-reload-cog = Перезавантажити завантажений ког за назвою. Застосовуються ті самі обмеження щодо назви та шляху файлу.
