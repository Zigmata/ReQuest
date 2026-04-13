## Admin module strings

# Admin cog
admin-embed-title-unauthorized = Неоторизиран сървър
admin-embed-desc-unauthorized =
    Благодарим ви за интереса към ReQuest! Вашият сървър не е в списъка с оторизирани тестови сървъри на ReQuest.
    Моля, присъединете се към Discord за поддръжка по-долу и се свържете с екипа по разработка, за да заявите тестов достъп.

    [Discord за разработка на ReQuest](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Следните команди бяха синхронизирани с { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Следните команди бяха синхронизирани глобално
admin-error-missing-scope = ReQuest няма правилния обхват в целевия сървър. Добавете правото `applications.commands` и опитайте отново.
admin-error-sync-failed = Възникна грешка при синхронизиране на командите: { $error }
admin-msg-commands-cleared = Командите са изчистени.

# Admin buttons
admin-btn-shutdown = Изключване
admin-modal-title-confirm-shutdown = Потвърждение за изключване
admin-modal-label-shutdown-warning = Внимание! Това ще изключи бота. Напишете ПОТВЪРДИ, за да продължите.
admin-msg-shutting-down = Изключване!
admin-btn-add-server = Добавяне на нов сървър
admin-btn-load-cog = Зареждане на Cog
admin-msg-extension-loaded = Разширението е успешно заредено: `{ $module }`
admin-btn-reload-cog = Презареждане на Cog
admin-msg-extension-reloaded = Разширението е успешно презаредено: `{ $module }`
admin-btn-output-guilds = Списък на сървърите
admin-msg-connected-guilds = Свързан с { $count } сървъра:

# Admin modals
admin-modal-title-add-server = Добавяне на ID на сървър в белия списък
admin-modal-label-server-name = Име на сървъра
admin-modal-placeholder-server-name = Въведете кратко име за Discord сървъра
admin-modal-label-server-id = ID на сървъра
admin-modal-placeholder-server-id = Въведете ID на Discord сървъра
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = Име
admin-modal-placeholder-cog-name = Въведете името на Cog за { $action }

# Admin views
admin-title-main-menu = Администрация - Главно меню
admin-desc-allowlist = Конфигуриране на белия списък за ограничения на поканите.
admin-desc-cogs = Зареждане или презареждане на разширения.
admin-desc-guild-list = Връща списък на всички сървъри, в които е ботът.
admin-desc-shutdown = Изключва бота
admin-title-allowlist = Администрация - Бял списък на сървъри
admin-desc-allowlist-warning =
    Добавяне на нов ID на Discord сървър в белия списък.
    {"**"}ВНИМАНИЕ: Няма начин да се провери дали предоставеният ID на сървъра е валиден, без ботът да е член на сървъра. Проверете внимателно въведеното!{"**"}
admin-msg-no-servers = Няма сървъри в белия списък.

# Admin confirm modals
admin-modal-title-confirm-server-removal = Потвърждение за премахване на сървър
admin-modal-label-server-removal = Премахване на сървъра от белия списък?

# Admin cog view
admin-title-cogs = Администрация - Разширения
admin-desc-load-cog = Зареждане на разширение по име. Файлът трябва да е с име `<name>.py` и да се намира в ReQuest/cogs/.
admin-desc-reload-cog = Презареждане на заредено разширение по име. Същите ограничения за име и пътека се прилагат.
