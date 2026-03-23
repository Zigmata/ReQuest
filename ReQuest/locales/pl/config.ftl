## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = Wyczyść
config-btn-remove-gm-roles = Usuń role GM
config-btn-forbidden-roles = Zabronione role

# Quests
config-btn-toggle-quest-summary = Przełącz podsumowanie questów
config-btn-toggle-player-experience = Przełącz doświadczenie graczy
config-btn-toggle-display = Przełącz wyświetlanie
config-btn-purge-player-board = Wyczyść tablicę graczy
config-btn-add-modify-rewards = Dodaj/Zmień nagrody

# Currency
config-btn-add-denomination = Dodaj nominał
config-btn-add-new-currency = Dodaj nową walutę
config-btn-remove-currency = Usuń walutę

# Shops - creation
config-btn-add-shop-wizard = Dodaj sklep (Kreator)
config-btn-add-shop-json = Dodaj sklep (JSON)
config-btn-edit-shop-wizard = Edytuj sklep (Kreator)
config-btn-edit-shop-json = Edytuj sklep (JSON)
config-btn-remove-shop = Usuń sklep
config-btn-add-item = Dodaj przedmiot
config-btn-edit-shop-details = Edytuj szczegóły sklepu
config-btn-download-json = Pobierz JSON
config-btn-done-editing = Zakończ edycję
config-btn-scan-server-configs = Skanuj konfigurację serwera
config-btn-re-scan = Skanuj ponownie

# New character shop
config-btn-upload-json = Prześlij JSON
config-btn-configure-new-character-wealth = Konfiguruj majątek nowej postaci
config-btn-configure-new-character-shop = Konfiguruj sklep nowej postaci
config-btn-clear-shop = Wyczyść sklep
config-btn-configure-static-kits = Konfiguruj zestawy startowe
config-btn-new-character-settings = Ustawienia nowej postaci
config-btn-disabled-no-currency = Wyłączone (brak skonfigurowanej waluty)
config-btn-disabled-no-wealth = Wyłączone (brak skonfigurowanego majątku startowego)

# Static kits
config-btn-create-new-kit = Utwórz nowy zestaw
config-btn-delete-kit = Usuń zestaw
config-btn-add-currency = Dodaj walutę

# Roleplay
config-btn-toggle-rp-rewards = Przełącz nagrody za RP
config-btn-clear-channels = Wyczyść kanały
config-btn-edit-settings = Edytuj ustawienia
config-btn-configure-rewards = Konfiguruj nagrody

# Stock
config-btn-stock-limits = Limity zapasów
config-btn-set-limit = Ustaw limit
config-btn-edit-limit = Edytuj limit
config-btn-remove-limit = Usuń limit
config-btn-configure-restock-schedule = Konfiguruj harmonogram uzupełniania
config-btn-back-to-shop-editor = Powrót do edytora sklepu

# Forum shop
config-btn-create-new-thread = Utwórz nowy wątek
config-btn-use-existing-thread = Użyj istniejącego wątku

# Wizard
config-btn-quit = Zakończ
config-btn-configure-channels = Konfiguruj kanały
config-btn-configure-roles = Konfiguruj role
config-btn-configure-quests = Konfiguruj questy
config-btn-configure-players = Konfiguruj graczy
config-btn-configure-currency = Konfiguruj walutę
config-btn-configure-rp-rewards = Konfiguruj nagrody za RP
config-btn-configure-shops = Konfiguruj sklepy
config-btn-new-char-setup = Ustawienia nowej postaci

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = Potwierdź usunięcie roli
config-modal-title-confirm-removal = Potwierdź usunięcie
config-modal-title-confirm-currency-removal = Potwierdź usunięcie waluty
config-modal-title-confirm-shop-removal = Potwierdź usunięcie sklepu
config-modal-title-confirm-kit-deletion = Potwierdź usunięcie zestawu
config-modal-title-confirm-remove-stock-limit = Potwierdź usunięcie limitu zapasów
config-modal-title-clear-shop = Potwierdź wyczyszczenie sklepu

# Confirm modal prompt labels
config-modal-label-remove-role = Usunąć { $roleName }?
config-modal-label-remove-denomination = Usunąć { $denominationName }?
config-modal-label-remove-currency = Usunąć { $currencyName }?
config-modal-label-shop-removal-warning = UWAGA: Ta operacja jest nieodwracalna!
config-modal-label-kit-deletion-warning = UWAGA: Nieodwracalne!
config-modal-label-remove-stock-limit = Wpisz CONFIRM, aby usunąć limit zapasów
config-modal-label-clear-shop = Wyczyścić wszystkie przedmioty z tego sklepu?

# Error messages from buttons
config-error-shop-data-not-found = Błąd: Nie znaleziono danych tego sklepu.
config-msg-shop-json-download = Oto definicja JSON dla {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Oto definicja JSON dla Sklepu Nowej Postaci.
config-error-select-forum-first = Najpierw wybierz kanał Forum.
config-error-select-thread-first = Najpierw wybierz wątek.

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Dodaj nową walutę
config-modal-label-currency-name = Nazwa waluty
config-error-currency-already-exists = Waluta lub nominał o nazwie { $name } już istnieje!

# RenameCurrencyModal
config-modal-title-rename-currency = Zmień nazwę waluty
config-modal-label-new-currency-name = Nowa nazwa waluty
config-error-currency-name-exists = Waluta o nazwie "{ $name }" już istnieje.
config-error-denomination-name-exists = Nominał o nazwie "{ $name }" już istnieje.

# RenameDenominationModal
config-modal-title-rename-denomination = Zmień nazwę nominału
config-modal-label-new-denomination-name = Nowa nazwa nominału

# AddCurrencyDenominationModal
config-modal-title-add-denomination = Dodaj nominał { $currencyName }
config-modal-label-denomination-name = Nazwa
config-modal-placeholder-denomination-name = np. Srebrny
config-modal-label-denomination-value = Wartość
config-modal-placeholder-denomination-value = np. 0.1
config-error-denomination-matches-currency = Nowa nazwa nominału nie może pokrywać się z istniejącą walutą na tym serwerze! Znaleziono istniejącą walutę o nazwie "{ $existingName }".
config-error-denomination-matches-denomination = Nowa nazwa nominału nie może pokrywać się z istniejącym nominałem na tym serwerze! Znaleziono istniejący nominał o nazwie "{ $denominationName }" w walucie "{ $currencyName }".
config-error-denomination-value-exists = Nominały w ramach jednej waluty muszą mieć unikalne wartości! { $denominationName } ma już przypisaną tę wartość.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Zabronione nazwy ról
config-modal-label-names = Nazwy
config-modal-placeholder-names = Wpisz nazwy oddzielone przecinkami
config-msg-forbidden-roles-updated = Zabronione role zaktualizowane!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Wyczyść tablicę graczy
config-modal-label-age = Wiek
config-modal-placeholder-age = Wpisz maksymalny wiek postów (w dniach) do zachowania
config-msg-posts-purged = Posty starsze niż { $days } dni zostały usunięte!

# GMRewardsModal
config-modal-title-gm-rewards = Dodaj/Zmień nagrody GM
config-modal-label-experience = Doświadczenie
config-modal-placeholder-enter-number = Wpisz liczbę
config-modal-label-items = Przedmioty
config-modal-placeholder-items =
    Nazwa: Ilość
    Nazwa2: Ilość
    itd.
config-error-experience-invalid = Doświadczenie musi być poprawną liczbą całkowitą (np. 2000).
config-error-item-format-invalid = Nieprawidłowy format przedmiotu: "{ $item }". Każdy przedmiot musi być w osobnej linii, w formacie "Nazwa: Ilość".

# ConfigShopDetailsModal
config-modal-title-shop-details = Dodaj/Edytuj szczegóły sklepu
config-modal-label-shop-channel = Wybierz kanał
config-modal-placeholder-shop-channel = Wybierz kanał dla tego sklepu
config-modal-label-shop-name = Nazwa sklepu
config-modal-placeholder-shop-name = Wpisz nazwę sklepu
config-modal-label-shopkeeper-name = Imię sklepikarza
config-modal-placeholder-shopkeeper-name = Wpisz imię sklepikarza
config-modal-label-shop-description = Opis sklepu
config-modal-placeholder-shop-description = Wpisz opis sklepu
config-modal-label-shop-image-url = URL obrazu sklepu
config-modal-placeholder-shop-image-url = Wpisz URL obrazu sklepu
config-error-no-channel-selected = Nie wybrano kanału dla sklepu.
config-error-shop-already-in-channel = W wybranym kanale jest już zarejestrowany sklep. Wybierz inny kanał lub edytuj istniejący sklep.

# build_shop_header_view
config-label-shopkeeper = {"**"}Sklepikarz:{"**"} { $name }
config-msg-use-shop-command = Użyj komendy `/shop`, aby przeglądać i kupować przedmioty.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Utwórz sklep w wątku Forum
config-modal-label-thread-name = Nazwa wątku
config-modal-placeholder-thread-name = Wpisz nazwę wątku sklepu
config-error-forum-not-found = Nie znaleziono wybranego kanału Forum.
config-error-shop-already-in-thread = W tym wątku jest już zarejestrowany sklep. Nie powinno to się zdarzyć dla nowego wątku.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Dodaj nowy sklep przez JSON
config-modal-label-upload-json = Prześlij plik .json z danymi sklepu
config-error-no-json-uploaded = Nie przesłano pliku JSON dla sklepu.
config-error-file-must-be-json = Przesłany plik musi być plikiem JSON (.json).
config-error-invalid-json = Nieprawidłowy format JSON: { $error }
config-error-json-validation-failed = JSON nie jest zgodny ze schematem: { $error }

# ShopItemModal
config-modal-title-shop-item = Dodaj/Edytuj przedmiot sklepu
config-modal-label-item-name = Nazwa przedmiotu
config-modal-placeholder-item-name = Wpisz nazwę przedmiotu
config-modal-label-item-description = Opis przedmiotu
config-modal-placeholder-item-description = Wpisz opis przedmiotu
config-modal-label-item-quantity = Ilość przedmiotu
config-modal-placeholder-item-quantity = Wpisz ilość sprzedawaną za zakup
config-modal-label-item-costs = Koszt przedmiotu
config-modal-placeholder-item-costs = Np.: 10 gold + 5 silver\nLUB: 50 rep\n(Użyj + dla ORAZ, nowe linie dla LUB)
config-error-item-quantity-positive = Ilość przedmiotu musi być dodatnią liczbą całkowitą.
config-error-cost-format-invalid = Nieprawidłowy format kosztu w opcji: "{ $option }". Każdy koszt musi zawierać kwotę i walutę oddzielone spacją, np. "10 gold".
config-error-cost-amount-invalid = Nieprawidłowa kwota "{ $amount }" dla waluty: "{ $currency }". Kwota musi być liczbą dodatnią.
config-error-unknown-currency = Nieznana waluta `{ $currency }`. Użyj prawidłowej waluty skonfigurowanej dla tego serwera.
config-error-item-already-exists = Przedmiot o nazwie { $itemName } już istnieje w tym sklepie.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Zaktualizuj sklep przez JSON
config-modal-label-upload-new-json = Prześlij nową definicję JSON
config-error-no-file-uploaded = Nie przesłano pliku.
config-error-file-must-be-json-ext = Plik musi mieć rozszerzenie `.json`.
config-error-json-validation-message = Walidacja JSON nie powiodła się: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Dodaj/Edytuj wyposażenie nowej postaci
config-modal-placeholder-item-quantity-selection = Wpisz ilość otrzymywaną za wybór
config-modal-label-item-cost = Koszt przedmiotu
config-error-cost-format-short = Nieprawidłowy format kosztu: '{ $component }'. Oczekiwano 'Kwota Waluta'.
config-error-amount-invalid-short = Nieprawidłowa kwota '{ $amount }' dla waluty '{ $currency }'.
config-error-item-exists-new-char = Przedmiot o nazwie { $itemName } już istnieje w Sklepie Nowej Postaci.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Prześlij Sklep Nowej Postaci (JSON)
config-error-no-json-uploaded-short = Nie przesłano pliku JSON.
config-error-json-must-have-shopstock = JSON musi zawierać tablicę 'shopStock'.
config-error-items-must-have-name-price = Wszystkie przedmioty muszą mieć 'name' i 'price'.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Ustaw majątek nowej postaci
config-modal-label-amount = Kwota
config-modal-placeholder-amount = Wpisz kwotę tej waluty.
config-modal-placeholder-currency-name = Wpisz nazwę waluty zdefiniowanej na tym serwerze
config-error-no-currencies-configured = Na tym serwerze nie skonfigurowano żadnych walut.
config-error-currency-not-found = Waluta lub nominał o nazwie { $name } nie został znaleziony. Użyj prawidłowej waluty.

# CreateStaticKitModal
config-modal-title-create-kit = Utwórz nowy zestaw startowy
config-modal-label-kit-name = Nazwa zestawu
config-modal-placeholder-kit-name = np. Zestaw startowy wojownika
config-modal-label-description = Opis
config-modal-placeholder-kit-description = Opcjonalny opis tego zestawu
config-error-kit-name-exists = Zestaw startowy o nazwie "{ $kitName }" już istnieje. Wybierz inną nazwę.

# StaticKitItemModal
config-modal-title-kit-item = Dodaj/Edytuj przedmiot zestawu
config-modal-placeholder-kit-item-quantity = Wpisz ilość tego przedmiotu w zestawie

# StaticKitCurrencyModal
config-modal-title-kit-currency = Dodaj walutę do zestawu
config-modal-placeholder-currency-eg = np. Gold
config-modal-placeholder-amount-eg = np. 100
config-error-amount-must-be-number = Kwota musi być liczbą.
config-error-no-currencies-on-server = Na serwerze nie skonfigurowano walut.
config-error-currency-not-found-short = Waluta "{ $currency }" nie została znaleziona.
config-error-denomination-not-found = Nominał "{ $denomination }" nie został znaleziony w konfiguracji waluty.

# RoleplaySettingsModal
config-modal-title-rp-settings = Ustawienia odgrywania ról
config-modal-label-min-message-length = Minimalna długość wiadomości (znaki)
config-modal-placeholder-min-message-length = Liczba znaków wymagana, aby wiadomość się kwalifikowała. 0 = bez limitu
config-modal-label-cooldown = Czas odnowienia (sekundy)
config-modal-placeholder-cooldown = Czas oczekiwania w sekundach między zliczaniem wiadomości kwalifikujących się do nagród
config-modal-label-message-threshold = Próg wiadomości
config-modal-placeholder-message-threshold = Liczba wiadomości wymagana do uruchomienia nagrody
config-modal-label-frequency = Częstotliwość (liczba wiadomości)
config-modal-placeholder-frequency = Liczba kwalifikujących się wiadomości wymagana do zdobycia nagród
config-error-min-length-invalid = Minimalna długość wiadomości musi być nieujemną liczbą całkowitą.
config-error-cooldown-invalid = Czas odnowienia musi być nieujemną liczbą całkowitą.
config-error-threshold-invalid = Próg wiadomości musi być dodatnią liczbą całkowitą.
config-error-frequency-invalid = Częstotliwość musi być dodatnią liczbą całkowitą.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Konfiguruj nagrody za odgrywanie ról
config-modal-label-items-name-quantity = Przedmioty (Nazwa: Ilość)
config-modal-label-currency-name-amount = Waluta (Nazwa: Kwota)
config-error-experience-non-negative = Doświadczenie musi być nieujemną liczbą całkowitą.
config-error-item-quantity-positive-named = Ilość przedmiotu "{ $itemName }" musi być dodatnią liczbą całkowitą.
config-error-currency-amount-positive = Kwota waluty "{ $currencyName }" musi być liczbą dodatnią.

# SetItemStockModal
config-modal-title-stock-limit = Limit zapasów: { $itemName }
config-modal-label-max-stock = Maksymalny zapas
config-modal-placeholder-max-stock = Wpisz maksymalny zapas (np. 10)
config-modal-label-current-stock = Aktualny zapas
config-modal-placeholder-current-stock = Wpisz aktualnie dostępny zapas
config-error-max-stock-positive = Maksymalny zapas musi być dodatnią liczbą całkowitą.
config-error-current-stock-non-negative = Aktualny zapas musi być nieujemną liczbą całkowitą.
config-error-current-exceeds-max = Aktualny zapas nie może przekraczać maksymalnego zapasu.
config-error-item-not-in-shop = Przedmiot "{ $itemName }" nie został znaleziony w sklepie.

# RestockScheduleModal
config-modal-title-restock-schedule = Konfiguruj harmonogram uzupełniania
config-modal-restock-schedule-label = Harmonogram
config-modal-restock-schedule-none = Brak (Wyłączony)
config-modal-restock-schedule-hourly = Co godzinę
config-modal-restock-schedule-daily = Codziennie
config-modal-restock-schedule-weekly = Co tydzień
config-modal-label-time = Czas (GG:MM w UTC)
config-modal-desc-current-time = Aktualny czas: { $utcTime }
config-modal-placeholder-time = np. 14:30 dla 14:30 UTC
config-modal-restock-day-label = Dzień tygodnia (tylko co tydzień)
config-modal-restock-mode-label = Tryb uzupełniania
config-modal-restock-mode-full = Pełne (resetuj do maks.)
config-modal-restock-mode-incremental = Stopniowe (dodaj ilość)
config-modal-label-increment = Ilość do dodania (dla trybu incremental)
config-modal-placeholder-increment = Ilość dodawana w każdym cyklu uzupełniania
config-error-time-format-invalid = Czas musi być w formacie GG:MM (np. 14:30).
config-error-increment-positive = Ilość do dodania musi być dodatnią liczbą całkowitą.

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Wyszukaj swój kanał { $configName }

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Wybierz swoją rolę ogłoszeń questów

# AddGMRoleSelect
config-select-placeholder-gm-roles = Wybierz swoją rolę(-e) GM

# ConfigWaitListSelect
config-select-placeholder-wait-list = Wybierz rozmiar listy oczekujących
config-select-option-disabled = 0 (Wyłączone)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Wybierz tryb ekwipunku
config-select-option-disabled-label = Wyłączony
config-select-desc-disabled = Gracze zaczynają z pustym ekwipunkiem.
config-select-option-selection = Wybór
config-select-desc-selection = Gracze swobodnie wybierają przedmioty ze Sklepu Nowej Postaci.
config-select-option-purchase = Zakup
config-select-desc-purchase = Gracze kupują przedmioty ze Sklepu Nowej Postaci za daną ilość waluty.
config-select-option-open = Otwarty
config-select-desc-open = Gracze ręcznie wprowadzają swój ekwipunek.
config-select-option-static = Statyczny
config-select-desc-static = Gracze otrzymują predefiniowany ekwipunek startowy.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Wybierz kwalifikujące się kanały

# RoleplayModeSelect
config-select-placeholder-rp-mode = Wybierz tryb
config-select-option-scheduled = Zaplanowany
config-select-desc-scheduled = Nagrody są przyznawane raz w określonym okresie resetowania.
config-select-option-accrued = Kumulacyjny
config-select-desc-accrued = Nagrody są przyznawane wielokrotnie na podstawie określonego poziomu aktywności.

# RoleplayResetSelect
config-select-placeholder-reset-period = Wybierz okres resetowania
config-select-option-hourly = Co godzinę
config-select-desc-hourly = Resetuje się co godzinę.
config-select-option-daily = Codziennie
config-select-desc-daily = Resetuje się co 24 godziny.
config-select-option-weekly = Co tydzień
config-select-desc-weekly = Resetuje się co 7 dni.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Wybierz dzień resetowania

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Wybierz czas resetowania (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Wybierz kanał Forum

# ForumThreadSelect
config-select-placeholder-thread = Wybierz wątek
config-select-option-no-threads = Nie znaleziono aktywnych wątków
config-select-desc-no-threads = Utwórz nowy wątek lub sprawdź zarchiwizowane wątki
config-select-option-select-forum-first = Najpierw wybierz Forum
config-select-desc-select-forum-first = Proszę wybrać kanał Forum powyżej
config-select-desc-thread-id = ID wątku: { $threadId }
config-error-select-valid-thread = Wybierz prawidłowy wątek lub utwórz nowy.
config-error-thread-not-found = Nie znaleziono wybranego wątku. Mógł zostać usunięty lub zarchiwizowany.

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = Konfiguracja serwera - Menu główne
config-menu-config-wizard = Kreator konfiguracji
config-menu-desc-config-wizard = Sprawdź, czy Twój serwer jest gotowy do korzystania z ReQuesta za pomocą szybkiego skanowania.
config-menu-channels = Kanały
config-menu-desc-channels = Ustaw wyznaczone kanały dla postów ReQuesta.
config-menu-currency = Waluta
config-menu-desc-currency = Globalne ustawienia waluty.
config-menu-players = Gracze
config-menu-desc-players = Globalne ustawienia graczy, takie jak śledzenie punktów doświadczenia.
config-menu-quests = Questy
config-menu-desc-quests = Globalne ustawienia questów, takie jak listy oczekujących.
config-menu-rp-rewards = Nagrody za RP
config-menu-desc-rp-rewards = Konfiguruj nagrody za odgrywanie ról.
config-menu-roles = Role
config-menu-desc-roles = Opcje konfiguracji ról do pingowania lub z uprawnieniami.
config-menu-shops = Sklepy
config-menu-desc-shops = Konfiguruj niestandardowe sklepy.
config-menu-language = Język
config-menu-desc-language = Ustaw domyślny język dla tego serwera.

## Wizard View
config-title-wizard = {"**"}Konfiguracja serwera - Kreator{"**"}
config-wizard-intro =
    {"**"}Witaj w Kreatorze Konfiguracji ReQuest!{"**"}

    Ten kreator pomoże Ci upewnić się, że Twój serwer jest prawidłowo skonfigurowany do korzystania z funkcji ReQuesta.
    Przeskanuje bieżące ustawienia i zaproponuje zalecenia dotyczące wymaganych zmian.

    Użyj przycisku "Uruchom skanowanie" poniżej, aby rozpocząć proces walidacji. Po zakończeniu skanowania
    otrzymasz szczegółowy raport konfiguracji serwera wraz z zalecanymi zmianami.

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}Uprawnienia globalne bota{"**"}__
config-wizard-bot-permissions-desc = Ta sekcja weryfikuje, czy ReQuest posiada wymagane uprawnienia do prawidłowego działania.
config-wizard-bot-role = Rola bota: { $roleMention }
config-wizard-status-warnings = {"**"}Status: ⚠️ ZNALEZIONO OSTRZEŻENIA{"**"}
config-wizard-missing-perm = - ⚠️ Brakuje: `{ $permissionName }`
config-wizard-ensure-permissions = Upewnij się, że najwyższa rola bota ma te uprawnienia przyznane globalnie.
config-wizard-status-ok = {"**"}Status: ✅ OK{"**"}
config-wizard-bot-permissions-ok = Bot posiada wszystkie wymagane uprawnienia globalne.
config-wizard-status-scan-failed = {"**"}Status: ❌ SKANOWANIE NIEUDANE{"**"}
config-wizard-scan-error = Wystąpił nieoczekiwany błąd podczas sprawdzania uprawnień bota.
config-wizard-error-type = Błąd: { $errorType }
config-wizard-required-permissions = {"**"}Wymagane uprawnienia dla roli bota:{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = Wyświetl kanały
config-wizard-perm-manage-roles = Zarządzaj rolami
config-wizard-perm-send-messages = Wysyłaj wiadomości
config-wizard-perm-attach-files = Załączaj pliki
config-wizard-perm-add-reactions = Dodawaj reakcje
config-wizard-perm-use-external-emoji = Używaj zewnętrznych emoji
config-wizard-perm-manage-messages = Zarządzaj wiadomościami
config-wizard-perm-read-message-history = Czytaj historię wiadomości

# Wizard - Role Validation
config-wizard-role-header = __{"**"}Konfiguracja ról{"**"}__
config-wizard-role-desc =
    Ta sekcja weryfikuje następujące elementy:

    - Role GM (wymagane) i rola ogłoszeń (opcjonalna) są skonfigurowane.
    - Domyślna rola (@everyone) posiada wymagane uprawnienia, aby użytkownicy mogli korzystać z funkcji bota.
    - Domyślna rola (@everyone) nie posiada niebezpiecznych uprawnień.
    - Role GM i ogłoszeń są sprawdzane pod kątem eskalacji uprawnień ponad domyślną rolę.

    Ostrzeżenia tutaj są wyłącznie zaleceniami opartymi na domyślnej konfiguracji. W zależności od potrzeb Twojego serwera możesz mieć powody, aby zignorować niektóre z tych zaleceń.

config-wizard-default-role-label = {"**"}Rola domyślna:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Znaleziono niebezpieczne uprawnienia:
config-wizard-default-role-ok = - ✅ @everyone: OK
config-wizard-missing-permission = - Brakujące uprawnienie: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}Role GM:{"**"}
config-wizard-no-gm-roles = - ⚠️ Nie skonfigurowano ról GM
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Skonfigurowana rola nie znaleziona/usunięta z serwera
config-wizard-role-ok = - ✅ { $roleMention }: OK
config-wizard-announcement-role-label = {"**"}Rola ogłoszeń:{"**"}
config-wizard-no-announcement-role = - ℹ️ Nie skonfigurowano roli ogłoszeń
config-wizard-announcement-role-not-found = - ⚠️ Skonfigurowana rola nie znaleziona/usunięta z serwera
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Wykryto eskalację uprawnień - { $escalations }
config-wizard-escalation-more = , i jeszcze { $count }...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = Wysyłaj wiadomości w wątkach
config-wizard-perm-use-application-commands = Używaj komend aplikacji

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = Zarządzaj kanałami
config-wizard-perm-manage-webhooks = Zarządzaj webhookami
config-wizard-perm-manage-server = Zarządzaj serwerem
config-wizard-perm-manage-nicknames = Zarządzaj pseudonimami
config-wizard-perm-kick-members = Wyrzucaj członków
config-wizard-perm-ban-members = Banuj członków
config-wizard-perm-timeout-members = Wyciszaj członków
config-wizard-perm-mention-everyone = Wspominaj @everyone
config-wizard-perm-manage-threads = Zarządzaj wątkami
config-wizard-perm-administrator = Administrator

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}Konfiguracja kanałów{"**"}__
config-wizard-channel-desc =
    Ta sekcja weryfikuje następujące elementy:

    - Skonfigurowane kanały istnieją.
    - Bot ma uprawnienia do wyświetlania i wysyłania wiadomości na skonfigurowanych kanałach.
    - Domyślna rola (@everyone) nie posiada uprawnień `Wysyłaj wiadomości`.

config-wizard-channel-no-config-required = - ⚠️ Nie skonfigurowano kanału
config-wizard-channel-not-configured = - ℹ️ Nie skonfigurowano (opcjonalne)
config-wizard-channel-not-found = - ⚠️ Skonfigurowany kanał nie znaleziony/usunięty z serwera
config-wizard-channel-ok = - ✅ OK
config-wizard-bot-cannot-view = - ⚠️ { $botMention } nie może wyświetlić tego kanału.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } nie może wysyłać wiadomości na tym kanale.
config-wizard-everyone-can-send = - ⚠️ @everyone może wysyłać wiadomości na tym kanale.

# Wizard - Channel names
config-wizard-channel-quest-board = Tablica questów
config-wizard-channel-player-board = Tablica graczy
config-wizard-channel-quest-archive = Archiwum questów
config-wizard-channel-gm-transaction-log = Dziennik transakcji GM
config-wizard-channel-player-transaction-log = Dziennik transakcji graczy
config-wizard-channel-shop-log = Dziennik sklepu
config-wizard-channel-approval-queue = Kolejka zatwierdzania postaci

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}Panel ustawień{"**"}__
config-wizard-dashboard-desc = Ta sekcja zawiera przegląd opcjonalnych konfiguracji w celach informacyjnych.
config-wizard-quest-settings = {"**"}Ustawienia questów{"**"}
config-wizard-quest-wait-list = - Rozmiar listy oczekujących: { $size }
config-wizard-quest-summary = - Podsumowanie questów: { $status }
config-wizard-gm-rewards-per-quest = {"**"}Nagrody GM (za quest){"**"}
config-wizard-player-settings = {"**"}Ustawienia graczy{"**"}
config-wizard-player-experience = - Doświadczenie gracza: { $status }
config-wizard-currency-settings = {"**"}Ustawienia waluty{"**"}
config-wizard-rp-rewards = {"**"}Nagrody za odgrywanie ról{"**"}
config-wizard-rp-status = - Status: { $status }
config-wizard-rp-mode = - Tryb: { $mode }
config-wizard-rp-channels = - Monitorowane kanały: { $count }
config-wizard-shops = {"**"}Sklepy{"**"}
config-wizard-shops-count = - Skonfigurowane sklepy: { $count }
config-wizard-shops-more = - ...i jeszcze { $count }
config-wizard-new-char-setup = {"**"}Ustawienia nowej postaci{"**"}
config-wizard-inventory-type = - Typ ekwipunku: { $type }
config-wizard-new-char-shop-items = - Przedmioty w Sklepie Nowej Postaci: { $count }
config-wizard-static-kits = - Zestawy startowe: { $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ Nie skonfigurowano walut
config-wizard-configured-currencies = {"**"}Skonfigurowane waluty:{"**"}
config-wizard-no-denominations = - Nie skonfigurowano nominałów
config-wizard-gm-rewards-disabled = {"**"}Status:{"**"} Wyłączone
config-wizard-gm-rewards-enabled = {"**"}Status:{"**"} Włączone
config-wizard-gm-rewards-experience = - Doświadczenie: { $xp }
config-wizard-gm-rewards-items = - Przedmioty:
config-wizard-unnamed-shop = Sklep bez nazwy

## Roles View
config-title-roles = {"**"}Konfiguracja serwera - Role{"**"}
config-label-announcement-role = {"**"}Rola ogłoszeń:{"**"} { $status }
config-desc-announcement-role = Ta rola jest wspomniana, gdy quest jest publikowany.
config-label-announcement-role-default = {"**"}Rola ogłoszeń:{"**"} Nie skonfigurowano
config-label-gm-roles = {"**"}Rola(-e) GM:{"**"} { $roles }
config-desc-gm-roles = Te role zapewniają dostęp do komend i funkcji Mistrza Gry.
config-label-gm-roles-default = {"**"}Rola(-e) GM:{"**"} Nie skonfigurowano
config-title-forbidden-roles = __{"**"}Zabronione role{"**"}__
config-desc-forbidden-roles =
    Konfiguruje listę nazw ról, których Mistrzowie Gry nie mogą używać dla swoich ról drużynowych.
    Domyślnie nazwy `everyone`, `administrator`, `gm` i `game master` nie mogą być używane. Ta konfiguracja
    rozszerza tę listę.

## GM Role Remove View
config-title-remove-gm-roles = {"**"}Konfiguracja serwera - Usuń rolę(-e) GM{"**"}
config-msg-no-gm-roles = Nie skonfigurowano ról GM.

## Channels View
config-title-channels = {"**"}Konfiguracja serwera - Kanały{"**"}

config-label-quest-board = {"**"}Tablica questów:{"**"} { $channel }
config-desc-quest-board = Kanał, na którym będą publikowane nowe/aktywne questy.
config-label-quest-board-default = {"**"}Tablica questów:{"**"} Nie skonfigurowano

config-label-player-board = {"**"}Tablica graczy:{"**"} { $channel }
config-desc-player-board = Opcjonalna tablica ogłoszeń/wiadomości do użytku przez graczy.
config-label-player-board-default = {"**"}Tablica graczy:{"**"} Nie skonfigurowano

config-label-quest-archive = {"**"}Archiwum questów:{"**"} { $channel }
config-desc-quest-archive = Opcjonalny kanał, do którego ukończone questy zostaną przeniesione z podsumowaniem.
config-label-quest-archive-default = {"**"}Archiwum questów:{"**"} Nie skonfigurowano

config-label-gm-transaction-log = {"**"}Dziennik transakcji GM:{"**"} { $channel }
config-desc-gm-transaction-log = Opcjonalny kanał, w którym rejestrowane są transakcje GM (np. komendy Modify Player).
config-label-gm-transaction-log-default = {"**"}Dziennik transakcji GM:{"**"} Nie skonfigurowano

config-label-player-transaction-log = {"**"}Dziennik transakcji graczy:{"**"} { $channel }
config-desc-player-transaction-log = Opcjonalny kanał, w którym rejestrowane są transakcje graczy, takie jak handel i zużywanie przedmiotów.
config-label-player-transaction-log-default = {"**"}Dziennik transakcji graczy:{"**"} Nie skonfigurowano

config-label-shop-log = {"**"}Dziennik sklepu:{"**"} { $channel }
config-desc-shop-log = Opcjonalny kanał, w którym rejestrowane są transakcje sklepowe.
config-label-shop-log-default = {"**"}Dziennik sklepu:{"**"} Nie skonfigurowano

## Quests View
config-title-quests = {"**"}Konfiguracja serwera - Questy{"**"}

config-label-wait-list = {"**"}Rozmiar listy oczekujących:{"**"} { $size }
config-desc-wait-list = Lista oczekujących pozwala określonej liczbie graczy ustawić się w kolejce do pełnego questu, na wypadek gdyby gracz zrezygnował.
config-label-wait-list-disabled = {"**"}Rozmiar listy oczekujących:{"**"} Wyłączony

config-label-quest-summary = {"**"}Podsumowanie questów:{"**"} { $status }
config-desc-quest-summary = Ta opcja umożliwia Mistrzom Gry dodanie krótkiego podsumowania przy zamykaniu questów.
config-label-quest-summary-disabled = {"**"}Podsumowanie questów:{"**"} Wyłączone

config-label-gm-rewards = Nagrody GM
config-desc-gm-rewards = Konfiguruj nagrody dla GM za ukończenie questów.

## GM Rewards View
config-title-gm-rewards = {"**"}Konfiguracja serwera - Nagrody GM{"**"}
config-desc-gm-rewards-detail =
    {"**"}Dodaj/Zmień nagrody{"**"}
    Otwiera formularz do dodawania, modyfikowania lub usuwania nagród GM.

    > Skonfigurowane nagrody obowiązują na quest. Za każdym razem, gdy Mistrz Gry ukończy quest,
    otrzyma skonfigurowane poniżej nagrody na swoją aktywną postać.
config-msg-no-rewards = Nie skonfigurowano nagród.
config-label-gm-experience = {"**"}Doświadczenie:{"**"} { $xp }
config-label-gm-items = {"**"}Przedmioty:{"**"}

## Players View
config-title-players = {"**"}Konfiguracja serwera - Gracze{"**"}

config-label-player-experience = {"**"}Doświadczenie graczy:{"**"} { $status }
config-desc-player-experience = Włącza/Wyłącza punkty doświadczenia (lub podobny system progresji postaci oparty na wartościach).
config-label-player-experience-disabled = {"**"}Doświadczenie graczy:{"**"} Wyłączone

config-label-new-char-settings = {"**"}Ustawienia nowej postaci{"**"}
config-desc-new-char-settings = Konfiguruj ustawienia nowych postaci graczy i sposób inicjalizacji ich ekwipunku.

config-label-player-board-purge = {"**"}Czyszczenie tablicy graczy{"**"}
config-desc-player-board-purge = Czyści posty z tablicy graczy (jeśli jest włączona).

## New Character Settings View
config-title-new-character = {"**"}Konfiguracja serwera - Ustawienia nowej postaci{"**"}

config-label-inventory-type = {"**"}Typ ekwipunku nowej postaci:{"**"} { $type }
config-desc-inventory-type = Określa, w jaki sposób nowo zarejestrowane postacie inicjalizują swój ekwipunek.
config-label-inventory-type-disabled = {"**"}Typ ekwipunku nowej postaci:{"**"} Wyłączony

config-label-new-char-wealth = {"**"}Majątek nowej postaci:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Majątek nowej postaci:{"**"} Wyłączony

config-label-approval-queue = {"**"}Kolejka zatwierdzania:{"**"} { $channel }
config-desc-approval-queue = Jeśli ustawiono, nowe postacie muszą zostać zatwierdzone przez GM na tym kanale Forum, zanim będą aktywne.
config-label-approval-queue-disabled = {"**"}Kolejka zatwierdzania:{"**"} Wyłączona
config-label-approval-queue-not-configured = {"**"}Kolejka zatwierdzania:{"**"} Nie skonfigurowano

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = Gracze zaczynają z pustym ekwipunkiem.
config-desc-inv-type-selection = Gracze swobodnie wybierają przedmioty ze Sklepu Nowej Postaci.
config-desc-inv-type-purchase = Gracze kupują przedmioty ze Sklepu Nowej Postaci za daną ilość waluty.
config-desc-inv-type-open = Gracze ręcznie wprowadzają przedmioty ekwipunku.
config-desc-inv-type-static = Gracze otrzymują predefiniowany ekwipunek startowy.

## New Character Shop View
config-title-new-char-shop = {"**"}Konfiguracja serwera - Sklep Nowej Postaci{"**"}
config-label-inv-type-selection = {"**"}Typ ekwipunku:{"**"} Wybór
config-desc-inv-type-selection-shop = Gracze swobodnie wybierają przedmioty ze Sklepu Nowej Postaci.
config-label-inv-type-purchase = {"**"}Typ ekwipunku:{"**"} Zakup
config-desc-inv-type-purchase-shop = Gracze kupują przedmioty ze Sklepu Nowej Postaci za daną ilość waluty.
config-label-inv-type-other = {"**"}Typ ekwipunku:{"**"} { $type }
config-desc-inv-type-not-in-use = Sklep Nowej Postaci nie jest używany.
config-msg-define-shop-items = Zdefiniuj przedmioty sklepu.
config-msg-no-items = Nie skonfigurowano przedmiotów.

## Static Kits View
config-title-static-kits = {"**"}Konfiguracja serwera - Zestawy startowe{"**"}
config-desc-create-kit = Utwórz nową definicję zestawu.
config-msg-no-kits = Nie skonfigurowano zestawów.
config-label-kit-more-items = ...i jeszcze { $count } przedmiotów
config-label-empty-kit = {"*"}Pusty zestaw{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}Edytowanie zestawu: { $kitName }{"**"}
config-msg-kit-empty = Ten zestaw jest pusty. Użyj przycisków powyżej, aby dodać walutę lub przedmioty.
config-label-kit-currency = {"**"}Waluta:{"**"} { $display }
config-label-kit-item = {"**"}Przedmiot:{"**"} { $name }

## Currency View
config-title-currency = {"**"}Konfiguracja serwera - Waluta{"**"}
config-desc-create-currency = Utwórz nową walutę.
config-msg-no-currencies = Nie skonfigurowano walut.
config-label-currency-display-type = Typ wyświetlania: { $type } | Nominały: { $count }
config-label-currency-type-double = Ułamkowy
config-label-currency-type-integer = Całkowity

## Edit Currency View
config-title-manage-currency = {"**"}Zarządzaj walutą: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Waluta i nominały{"**"}__
    - Podana nazwa waluty jest traktowana jako waluta bazowa i ma wartość 1.
    {"```"}Przykład: "złoto" jest skonfigurowane jako waluta.{"```"}
    - Dodanie nominału wymaga podania nazwy i wartości względem waluty bazowej.
    {"```"}Przykład: Złoto ma dwa nominały: srebro (wartość 0.1) i miedź (wartość 0.01).{"```"}
    - Wszelkie transakcje z udziałem waluty bazowej lub jej nominałów będą automatycznie przeliczane.
    {"```"}Przykład: Gracz posiada 10 złota i wydaje 3 miedzi. Jego nowe saldo automatycznie wyświetli się jako 9 złota, 9 srebra i 7 miedzi.{"```"}
    - Waluty wyświetlane jako liczba całkowita pokażą każdy nominał, natomiast waluty wyświetlane jako ułamek pokażą się tylko jako waluta bazowa.
    {"```"}Przykład: Powyższy gracz z włączonym wyświetlaniem ułamkowym pokaże się jako 9.97 złota.{"```"}
config-btn-toggle-display-current = Przełącz wyświetlanie (Aktualnie: { $type })
config-msg-no-denominations = Nie skonfigurowano nominałów.

## Shops View
config-title-shops = {"**"}Konfiguracja serwera - Sklepy{"**"}
config-desc-add-shop-wizard =
    {"**"}Dodaj sklep (Kreator){"**"}
    Utwórz nowy, pusty sklep za pomocą formularza.
config-desc-add-shop-json =
    {"**"}Dodaj sklep (JSON){"**"}
    Utwórz nowy sklep, dostarczając pełną definicję JSON. (Zaawansowane)
config-btn-example-json = Przykład JSON
config-desc-example-json =
    {"**"}Przykład JSON{"**"}
    Pobierz przykładowy plik JSON pokazujący oczekiwany format.
config-msg-example-json = Oto przykładowy plik JSON pokazujący oczekiwany format.
config-msg-no-shops = Nie skonfigurowano sklepów.
config-label-shop-type-forum = (Forum)
config-label-shop-channel = Kanał: <#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}Dodaj sklep - Wybierz typ lokalizacji{"**"}
config-label-text-channel = {"**"}Kanał tekstowy{"**"}
config-desc-text-channel = Utwórz sklep na standardowym kanale tekstowym.
config-label-forum-thread = {"**"}Wątek Forum{"**"}
config-desc-forum-thread = Utwórz sklep w wątku Forum (nowym lub istniejącym).

## Forum Shop Setup View
config-title-forum-setup = {"**"}Dodaj sklep - Konfiguracja wątku Forum{"**"}
config-label-step1 = {"**"}Krok 1: Wybierz kanał Forum{"**"}
config-label-step2 = {"**"}Krok 2: Wybierz opcję wątku{"**"}
config-label-step3 = {"**"}Krok 3: Wybierz istniejący wątek{"**"}
config-desc-create-new-thread =
    {"**"}Utwórz nowy wątek{"**"}
    Otwiera formularz do utworzenia nowego wątku i konfiguracji sklepu.
config-label-selected-thread = {"**"}Wybrany wątek:{"**"} { $threadName }
config-desc-click-to-configure = Kliknij, aby skonfigurować sklep w tym wątku.

## Manage Shop View
config-title-manage-shop = {"**"}Zarządzaj sklepem: { $shopName }{"**"}
config-label-shop-type = {"**"}Typ:{"**"} { $type }
config-label-shop-type-text = Kanał tekstowy
config-label-shop-type-forum-thread = Wątek Forum
config-label-shopkeeper = {"**"}Sklepikarz:{"**"} { $name }
config-label-shop-description = {"**"}Opis:{"**"} { $description }
config-label-shop-channel-info = {"**"}Kanał:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Edytuj szczegóły i przedmioty sklepu za pomocą Kreatora.
config-desc-upload-json = Prześlij nową definicję JSON dla tego sklepu.
config-desc-download-json = Pobierz aktualną definicję JSON.
config-desc-remove-shop = Trwale usuń ten sklep.

## Edit Shop View
config-title-editing-shop = {"**"}Edytowanie sklepu: { $shopName }{"**"}
config-label-shop-shopkeeper = Sklepikarz: {"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}Konfiguracja zapasów: { $shopName }{"**"}
config-label-current-utc = Aktualny czas UTC: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Harmonogram uzupełniania:{"**"} { $schedule }
config-label-restock-hourly = w minucie :{ $minute }
config-label-restock-daily = o { $time } UTC
config-label-restock-weekly = w { $day } o { $time } UTC
config-label-restock-mode = {"**"}Tryb:{"**"} { $mode }
config-label-restock-full = Pełne uzupełnienie
config-label-restock-incremental = Dodaj { $amount } na cykl (do maks.)
config-label-restock-disabled = {"**"}Harmonogram uzupełniania:{"**"} Wyłączony
config-label-item-stock-limits = {"**"}Limity zapasów przedmiotów{"**"}
config-msg-no-items-in-shop = Brak przedmiotów w tym sklepie.
config-label-stock-with-available = Maks.: { $max } | Dostępne: { $available }
config-label-stock-reserved = | Zarezerwowane: { $reserved }
config-label-stock-not-initialized = Maks.: { $max } | Dostępne: (niezainicjowane)
config-label-stock-unlimited = Zapas: Nieograniczony

## Roleplay View
config-title-roleplay = {"**"}Konfiguracja serwera - Nagrody za odgrywanie ról{"**"}
config-label-rp-status = {"**"}Status:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Czas serwera:{"**"} `{ $time }`
config-label-rp-enabled = Włączone
config-label-rp-disabled = Wyłączone

config-desc-rp-mode-scheduled = {"```"}Nagrody są rozdzielane jednorazowo po wysłaniu wymaganej liczby kwalifikujących się wiadomości w ustawionym okresie (co godzinę, codziennie lub co tydzień).{"```"}
config-desc-rp-mode-accrued = {"```"}Nagrody są rozdzielane cyklicznie za każdym razem, gdy wysłana zostanie określona liczba kwalifikujących się wiadomości.{"```"}

config-label-rp-config-details = {"**"}Szczegóły konfiguracji:{"**"}
config-label-rp-mode = {"**"}Tryb:{"**"} { $mode }
config-label-rp-min-length = {"**"}Minimalna długość wiadomości:{"**"} { $length } znaków
config-label-rp-cooldown = {"**"}Czas odnowienia:{"**"} { $seconds } sekund
config-label-rp-frequency-once = {"**"}Częstotliwość:{"**"} Raz na { $period }
config-label-rp-reset-time = {"**"}Czas resetowania:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Próg:{"**"} { $count } kwalifikujących się wiadomości
config-label-rp-frequency-every = {"**"}Częstotliwość:{"**"} Co { $count } kwalifikujących się wiadomości

config-label-rp-channels = {"**"}Kanały odgrywania ról:{"**"}
config-msg-rp-no-channels = Nie skonfigurowano.
config-label-rp-channels-more = ...i jeszcze { $count }.

config-label-rp-rewards = {"**"}Nagrody:{"**"}
config-msg-rp-no-rewards = Nie skonfigurowano.
config-label-rp-experience = {"**"}Doświadczenie:{"**"} { $xp }
config-label-rp-items = {"**"}Przedmioty:{"**"}
config-label-rp-currency = {"**"}Waluta:{"**"}

## Language View
config-title-language = {"**"}Konfiguracja serwera - Język{"**"}
config-server-language-help =
    To ustawienie pozwala określić domyślny język dla {"**"}publicznych{"**"} odpowiedzi i wiadomości ReQuesta na tym serwerze. Publiczne odpowiedzi obejmują:
    - Posty na tablicy questów i tablicy graczy
    - Podsumowania questów i wiadomości w kanałach dzienników
    - Uzupełnianie zapasów sklepu
    - Zużywanie przedmiotów przez graczy

    To ustawienie dotyczy tylko statycznego tekstu generowanego przez bota i nie tłumaczy dynamicznej zawartości, takiej jak nazwy przedmiotów lub opisy questów wprowadzone przez użytkowników.

    Osobiste odpowiedzi i menu nie są objęte tym ustawieniem.
config-label-server-language = {"**"}Język serwera:{"**"} { $language }
config-label-server-language-default = {"**"}Język serwera:{"**"} Domyślny (bez nadpisania)
config-select-placeholder-server-language = Wybierz język serwera
config-select-option-default = Domyślny (bez nadpisania)
config-select-desc-default = Używaj preferencji użytkownika lub ustawień regionalnych Discord.

# Role questowe
config-btn-quest-roles = Role questowe
config-btn-manage-gm-quest-roles = Zarządzaj

config-modal-title-confirm-quest-role-removal = Potwierdź usunięcie roli
config-modal-label-remove-quest-role = Usunąć { $roleName } od { $gmName }?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Wybierz tryb ról questowych
config-select-option-quest-role-disabled = Wyłączony
config-select-desc-quest-role-disabled = Role nie są tworzone ani przypisywane.
config-select-option-quest-role-temporary = Tymczasowy
config-select-desc-quest-role-temporary = MG mogą tworzyć tymczasowe role dla każdego questu.
config-select-option-quest-role-static = Statyczny
config-select-desc-quest-role-static = MG wybierają z wcześniej przypisanych ról serwera.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Przypisz rolę(-e) serwera do tego MG

## Widok ról questowych
config-title-quest-roles = {"**"}Konfiguracja serwera - Role questowe{"**"}
config-label-quest-roles = Role questowe
config-desc-quest-roles =
    Skonfiguruj sposób obsługi ról drużyny podczas questów.

config-label-quest-role-mode-disabled = {"**"}Tryb ról questowych:{"**"} Wyłączony
    Podczas questów nie są tworzone ani przypisywane żadne role.
config-label-quest-role-mode-temporary = {"**"}Tryb ról questowych:{"**"} Tymczasowy
    MG mogą opcjonalnie utworzyć tymczasową rolę podczas tworzenia questu.
    Rola jest usuwana po ukończeniu lub anulowaniu questu.
config-label-quest-role-mode-static = {"**"}Tryb ról questowych:{"**"} Statyczny
    MG wybierają z wcześniej przypisanych ról serwera. Role są przypisywane
    członkom drużyny podczas questów, ale nigdy nie są usuwane.

## Widok przypisań statycznych ról questowych
config-title-static-quest-roles = {"**"}Konfiguracja serwera - Przypisania statycznych ról questowych{"**"}
config-label-manage-assignments = Zarządzaj przypisaniami ról
config-desc-manage-assignments =
    Przypisz istniejące role serwera do MG do użycia podczas questów.
    Role muszą być niżej niż najwyższa rola ReQuest w hierarchii serwera.
config-msg-no-gm-members = Nie znaleziono członków z rolą MG na tym serwerze.
config-label-no-roles-assigned = Brak przypisanych ról questowych

## Widok przypisania ról questowych MG
config-title-gm-quest-role-assign = {"**"}Zarządzaj rolami questowymi — { $gmName }{"**"}
config-error-unmanageable-roles = Następujące role nie mogą zostać przypisane, ponieważ są zarządzane przez integrację, są rolą domyślną lub znajdują się powyżej najwyższej roli ReQuest: { $roles }
config-error-quest-role-limit = Ten MG osiągnął maksymalną liczbę { $limit } przypisanych ról questowych.
config-label-quest-role-count = Przypisane role: { $count }/{ $limit }
