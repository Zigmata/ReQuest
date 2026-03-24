## Admin module strings

# Admin cog
admin-embed-title-unauthorized = Nieautoryzowany serwer
admin-embed-desc-unauthorized =
    Dziękujemy za zainteresowanie ReQuestem! Twój serwer nie znajduje się na liście autoryzowanych serwerów testowych.
    Dołącz do serwera Discord poniżej i skontaktuj się z zespołem deweloperskim, aby poprosić o dostęp testowy.

    [Discord Deweloperski ReQuest](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Następujące komendy zostały zsynchronizowane z { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Następujące komendy zostały zsynchronizowane globalnie
admin-error-missing-scope = ReQuest nie ma odpowiedniego zakresu uprawnień w docelowym serwerze. Dodaj uprawnienie `applications.commands` i spróbuj ponownie.
admin-error-sync-failed = Wystąpił błąd podczas synchronizacji komend: { $error }
admin-msg-commands-cleared = Komendy wyczyszczone.

# Admin buttons
admin-btn-shutdown = Wyłącz
admin-modal-title-confirm-shutdown = Potwierdź wyłączenie
admin-modal-label-shutdown-warning = Uwaga! To wyłączy bota. Wpisz POTWIERDŹ, aby kontynuować.
admin-msg-shutting-down = Wyłączam!
admin-btn-add-server = Dodaj nowy serwer
admin-btn-load-cog = Załaduj moduł
admin-msg-extension-loaded = Rozszerzenie pomyślnie załadowane: `{ $module }`
admin-btn-reload-cog = Przeładuj moduł
admin-msg-extension-reloaded = Rozszerzenie pomyślnie przeładowane: `{ $module }`
admin-btn-output-guilds = Wyświetl listę serwerów
admin-msg-connected-guilds = Połączono z { $count } serwerami:

# Admin modals
admin-modal-title-add-server = Dodaj ID serwera do listy dozwolonych
admin-modal-label-server-name = Nazwa serwera
admin-modal-placeholder-server-name = Wpisz krótką nazwę serwera Discord
admin-modal-label-server-id = ID serwera
admin-modal-placeholder-server-id = Wpisz ID serwera Discord
admin-select-placeholder-server = Wybierz serwer do usunięcia
admin-modal-title-cog-action = { $action } moduł
admin-modal-label-cog-name = Nazwa
admin-modal-placeholder-cog-name = Wpisz nazwę modułu do { $action }

# Admin views
admin-title-main-menu = Administracja - Menu główne
admin-desc-allowlist = Skonfiguruj listę dozwolonych serwerów dla ograniczeń zaproszeń.
admin-desc-cogs = Załaduj lub przeładuj moduły.
admin-desc-guild-list = Zwraca listę wszystkich serwerów, których bot jest członkiem.
admin-desc-shutdown = Wyłącza bota
admin-title-allowlist = Administracja - Lista dozwolonych serwerów
admin-desc-allowlist-warning =
    Dodaj nowe ID serwera Discord do listy dozwolonych.
    {"**"}UWAGA: Nie ma możliwości weryfikacji, czy podane ID serwera jest prawidłowe, bez przynależności bota do tego serwera. Sprawdź dokładnie swoje dane!{"**"}
admin-msg-no-servers = Brak serwerów na liście dozwolonych.

# Admin confirm modals
admin-modal-title-confirm-server-removal = Potwierdź usunięcie serwera
admin-modal-label-server-removal = Usunąć serwer z listy dozwolonych?

# Admin cog view
admin-title-cogs = Administracja - Moduły
admin-desc-load-cog = Załaduj moduł bota po nazwie. Plik musi mieć nazwę `<nazwa>.py` i znajdować się w ReQuest/cogs/.
admin-desc-reload-cog = Przeładuj załadowany moduł po nazwie. Obowiązują te same ograniczenia nazwy i ścieżki pliku.
