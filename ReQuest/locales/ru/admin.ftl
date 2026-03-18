## Строки модуля администрирования

# Когда администрирования
admin-embed-title-unauthorized = Неавторизованный сервер
admin-embed-desc-unauthorized =
    Спасибо за интерес к ReQuest! Ваш сервер не входит в список авторизованных тестовых серверов ReQuest.
    Присоединяйтесь к Discord поддержки и свяжитесь с командой разработки для запроса тестового доступа.

    [Discord разработки ReQuest](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Следующие команды были синхронизированы с { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Следующие команды были синхронизированы глобально
admin-error-missing-scope = У ReQuest нет необходимых прав в целевом сервере. Добавьте разрешение `applications.commands` и попробуйте снова.
admin-error-sync-failed = Произошла ошибка при синхронизации команд: { $error }
admin-msg-commands-cleared = Команды очищены.

# Кнопки администрирования
admin-btn-shutdown = Выключить
admin-modal-title-confirm-shutdown = Подтверждение выключения
admin-modal-label-shutdown-warning = Внимание! Бот будет выключен. Введите CONFIRM для продолжения.
admin-msg-shutting-down = Выключаюсь!
admin-btn-add-server = Добавить сервер
admin-btn-load-cog = Загрузить модуль
admin-msg-extension-loaded = Расширение успешно загружено: `{ $module }`
admin-btn-reload-cog = Перезагрузить модуль
admin-msg-extension-reloaded = Расширение успешно перезагружено: `{ $module }`
admin-btn-output-guilds = Список серверов
admin-msg-connected-guilds = Подключено к { $count } серверам:

# Модальные окна администрирования
admin-modal-title-add-server = Добавить ID сервера в белый список
admin-modal-label-server-name = Название сервера
admin-modal-placeholder-server-name = Введите короткое название Discord сервера
admin-modal-label-server-id = ID сервера
admin-modal-placeholder-server-id = Введите ID Discord сервера
admin-select-placeholder-server = Выберите сервер для удаления
admin-modal-title-cog-action = { $action } модуль
admin-modal-label-cog-name = Название
admin-modal-placeholder-cog-name = Введите название модуля для { $action }

# Представления администрирования
admin-title-main-menu = Администрирование - Главное меню
admin-desc-allowlist = Настройка белого списка серверов для ограничения приглашений.
admin-desc-cogs = Загрузка или перезагрузка модулей.
admin-desc-guild-list = Возвращает список всех серверов, на которых состоит бот.
admin-desc-shutdown = Выключает бота
admin-title-allowlist = Администрирование - Белый список серверов
admin-desc-allowlist-warning =
    Добавьте новый ID Discord сервера в белый список.
    {"**"}ВНИМАНИЕ: Нет возможности проверить правильность введённого ID сервера без присутствия бота на сервере. Перепроверьте свои данные!{"**"}
admin-msg-no-servers = В белом списке нет серверов.

# Модальные окна подтверждения администрирования
admin-modal-title-confirm-server-removal = Подтверждение удаления сервера
admin-modal-label-server-removal = Удалить сервер из белого списка?

# Представление модулей администрирования
admin-title-cogs = Администрирование - Модули
admin-desc-load-cog = Загрузить модуль бота по имени. Файл должен называться `<name>.py` и находиться в ReQuest\cogs\.
admin-desc-reload-cog = Перезагрузить загруженный модуль по имени. Те же ограничения на имя и путь файла.
