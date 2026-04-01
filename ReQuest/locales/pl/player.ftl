## Player module strings

# --- Cog ---

player-cmd-name = Wymiana
player-cmd-desc = Menu gracza

# --- Buttons ---

# Character management
player-btn-register-character = Zarejestruj nową postać
player-btn-activate = Aktywuj
player-btn-active = Aktywna

# Player board
player-btn-create-post = Utwórz post
player-btn-open-starting-shop = Otwórz sklep startowy
player-btn-select-kit = Wybierz zestaw
player-btn-input-inventory = Wprowadź ekwipunek

# Wizard / shop buttons
player-btn-add-to-cart = Dodaj do koszyka
player-btn-add-to-cart-cost = Dodaj do koszyka ({ $costString })
player-btn-view-purchase-options = Wyświetl opcje zakupu
player-btn-review-submit = Przeglądaj i wyślij ({ $count })
player-btn-submit-character = Wyślij postać
player-btn-keep-shopping = Kontynuuj zakupy
player-btn-edit-quantity = Edytuj ilość
player-btn-clear-cart = Wyczyść koszyk

# Kit buttons
player-btn-confirm-selection = Potwierdź wybór
player-btn-back-to-kits = Powrót do zestawów

# Inventory management
player-btn-spend-currency = Wydaj walutę
player-btn-print-inventory = Wydrukuj ekwipunek

# Container management
player-btn-manage-containers = Zarządzaj pojemnikami
player-btn-create-new = + Utwórz nowy
player-btn-consume-destroy = Zużyj/Zniszcz
player-btn-move = Przenieś
player-btn-move-all = Przenieś wszystko
player-btn-move-some = Przenieś część...
player-btn-back-to-overview = ← Powrót do przeglądu
player-btn-cancel-move = ← Anuluj
player-btn-up = ▲ W górę
player-btn-down = ▼ W dół

# --- Modals ---

# Trade modal
player-modal-title-trade = Handel z { $targetName }
player-modal-label-trade-name = Nazwa
player-modal-placeholder-trade-name = Wpisz nazwę przedmiotu, który handlujesz
player-modal-label-trade-quantity = Ilość
player-modal-placeholder-trade-quantity = Wpisz ilość, którą handlujesz

# Character register modal
player-modal-title-register = Zarejestruj nową postać
player-modal-label-char-name = Imię
player-modal-placeholder-char-name = Wpisz imię swojej postaci.
player-modal-label-char-note = Notatka
player-modal-placeholder-char-note = Wpisz notatkę identyfikującą Twoją postać

# Open inventory input modal
player-modal-title-starting-inventory = Wprowadzanie ekwipunku startowego
player-modal-label-inventory = Ekwipunek
player-modal-placeholder-inventory-input =
    Jeden na linię w formacie <nazwa>: <ilość>, np.:
    Miecz: 1
    gold: 30

# Spend currency modal
player-modal-title-spend-currency = Wydaj walutę
player-modal-label-currency-name = Nazwa waluty
player-modal-placeholder-currency-name = Wpisz nazwę waluty, którą chcesz wydać
player-modal-label-currency-amount = Kwota
player-modal-placeholder-currency-amount = Wpisz kwotę do wydania

# Create player post modal
player-modal-title-create-post = Utwórz post na tablicy graczy
player-modal-label-post-title = Tytuł
player-modal-placeholder-post-title = Wpisz tytuł swojego postu
player-modal-label-post-content = Treść postu
player-modal-placeholder-post-content = Wpisz treść swojego postu

# Edit player post modal
player-modal-title-edit-post = Edytuj post na tablicy graczy

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = Edytuj ilość w koszyku
player-modal-label-cart-qty = Ilość
player-modal-placeholder-cart-qty = Wpisz nową ilość (0 aby usunąć)

# Create container modal
player-modal-title-create-container = Utwórz nowy pojemnik
player-modal-label-container-name = Nazwa pojemnika
player-modal-placeholder-container-name = Wpisz nazwę pojemnika (np. Plecak)

# Rename container modal
player-modal-title-rename-container = Zmień nazwę pojemnika
player-modal-label-new-container-name = Nowa nazwa pojemnika
player-modal-placeholder-new-container-name = Wpisz nową nazwę

# Consume from container modal
player-modal-title-consume = Zużyj/Zniszcz przedmiot
player-modal-label-consume-qty = Ilość (maks.: { $maxQuantity })
player-modal-placeholder-consume-qty = Wpisz ilość do zużycia/zniszczenia

# Move item quantity modal
player-modal-title-move-item = Przenieś przedmiot
player-modal-label-move-qty = Ilość do przeniesienia (maks.: { $maxQuantity })
player-modal-placeholder-move-qty = Wpisz ilość do przeniesienia

# --- Selects ---

player-select-placeholder-no-characters = Nie masz zarejestrowanych postaci
player-select-placeholder-remove-character = Wybierz postać do usunięcia
player-select-placeholder-post = Wybierz post
player-select-placeholder-container-view = Wybierz pojemnik do wyświetlenia...
player-select-placeholder-item = Wybierz przedmiot...
player-select-placeholder-destination = Wybierz miejsce docelowe...
player-select-placeholder-container = Wybierz pojemnik...
player-select-option-no-containers = Brak pojemników
player-select-option-no-items = Brak przedmiotów
player-select-option-no-destinations = Brak miejsc docelowych

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}Komendy gracza - Menu główne{"**"}
player-menu-btn-characters = Postacie
player-menu-desc-characters = Rejestruj, przeglądaj i aktywuj postacie graczy.
player-menu-btn-inventory = Ekwipunek
player-menu-desc-inventory = Wyświetl ekwipunek aktywnej postaci i wydaj walutę.
player-menu-btn-player-board = Tablica graczy
player-menu-btn-player-board-disabled = Tablica graczy (nie skonfigurowano)
player-menu-desc-player-board = Utwórz post na tablicy graczy

# CharacterBaseView
player-title-characters = {"**"}Komendy gracza - Postacie{"**"}
player-desc-register-character = Zarejestruj nową postać.
player-msg-no-characters = Nie masz zarejestrowanych postaci.
player-label-active = (Aktywna)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Postać w toku: { $characterName }{"**"}
    Rejestracja twojej postaci oczekuje na konfigurację ekwipunku.
player-btn-resume = Wznów
player-btn-discard = Odrzuć
player-modal-title-discard-character = Odrzuć postać
player-modal-label-discard-confirm = Odrzucić { $characterName }?

# Confirm character removal
player-modal-title-confirm-char-removal = Potwierdź usunięcie postaci
player-modal-label-confirm-char-delete = Usunąć { $characterName }?

# Confirm post removal
player-modal-title-confirm-post-removal = Potwierdź usunięcie postu
player-modal-label-post-removal-warning = UWAGA: Ta operacja jest nieodwracalna!

# InventoryOverviewView
player-title-inventory = {"**"}Komendy gracza - Ekwipunek{"**"}
player-title-char-inventory = {"**"}Ekwipunek postaci { $characterName }{"**"}
player-msg-no-active-character = Brak aktywnej postaci: Aktywuj postać na tym serwerze, aby korzystać z tych menu.
player-msg-no-characters-registered = Brak postaci: Zarejestruj postać, aby korzystać z tych menu.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } przedmiotów
player-label-currency = {"**"}Waluta{"**"}
player-msg-inventory-empty = Ekwipunek jest pusty.

# Print inventory embed
player-embed-title-inventory = Ekwipunek postaci { $characterName }

# ContainerItemsView
player-msg-container-empty = Ten pojemnik jest pusty.
player-label-selected-item = Wybrano: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Przenieś "{ $itemName }"{"**"} ({ $available } dostępne)
player-msg-no-other-containers = Brak innych dostępnych pojemników.
player-msg-select-destination = Wybierz pojemnik docelowy:
player-label-destination = Cel: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Zarządzanie pojemnikami{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } przedmiotów){ $suffix }
player-label-default-suffix = { " " }(domyślny)
player-msg-no-containers = Brak pojemników.
player-label-selected-container = Wybrano: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = Potwierdź usunięcie pojemnika
player-modal-label-container-has-items = Zawiera { $itemCount } przedmiotów. Zostaną przeniesione do Luźnych Przedmiotów.
player-modal-label-confirm-container-delete = Usunąć "{ $containerName }"?

# Container errors
player-error-cannot-rename-loose = Nie można zmienić nazwy Luźnych Przedmiotów.
player-error-cannot-delete-loose = Nie można usunąć Luźnych Przedmiotów.

# PlayerBoardView
player-title-player-board = {"**"}Komendy gracza - Tablica graczy{"**"}
player-desc-create-post = Utwórz nowy post na tablicy graczy.
player-msg-no-posts = Nie masz żadnych bieżących postów.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Autor
player-embed-footer-post-id = ID postu: { $postId }
player-error-board-channel-not-found = Nie znaleziono kanału tablicy graczy.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Konfiguracja ekwipunku dla { $characterName }{"**"}
player-desc-browse-shop = Przeglądaj Sklep Startowy, aby wyposażyć swoją postać.
player-desc-select-kit = Wybierz Zestaw Startowy.
player-desc-input-inventory = Ręcznie wprowadź swój ekwipunek startowy.

# StaticKitSelectView
player-title-select-kit = {"**"}Wybierz zestaw dla { $characterName }{"**"}
player-msg-no-kits = Brak dostępnych zestawów startowych.
player-label-and-more-items = ...i jeszcze { $count } przedmiotów
player-label-empty-kit = {"*"}Pusty zestaw{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Potwierdź wybór: { $kitName }{"**"}
player-label-items-heading = {"**"}Przedmioty:{"**"}
player-label-currency-heading = {"**"}Waluta:{"**"}
player-msg-kit-empty = Ten zestaw jest pusty.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Opcje zakupu: { $itemName }{"**"}
player-msg-no-cost-options = Ten przedmiot nie ma dostępnych opcji kosztowych.
player-label-cost-option = {"**"}Opcja { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Sklep startowy ({ $inventoryType }){"**"}
player-label-starting-wealth = Majątek startowy: { $formattedCurrency }
player-label-in-cart = {"**"}(W koszyku: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Przegląd koszyka{"**"}
player-msg-cart-empty = Twój koszyk jest pusty.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Łącznie: { $totalQuantity })
player-label-insufficient-currency = Niewystarczające środki { $currencyName }
player-label-total-cost = {"**"}Łączny koszt:{"**"}
player-label-total-cost-free = {"**"}Łączny koszt:{"**"} Bezpłatnie
player-label-cart-page = Strona { $current } z { $total }

# Trade embed
player-embed-title-trade = Raport handlu
player-embed-desc-trade-sender = Nadawca: { $senderMention } jako `{ $senderCharacter }`
player-embed-desc-trade-recipient = Odbiorca: { $recipientMention } jako `{ $recipientCharacter }`
player-embed-field-currency = Waluta
player-embed-field-amount = Kwota
player-embed-field-balance = Saldo { $characterName }
player-embed-field-item = Przedmiot
player-embed-field-quantity = Ilość
player-embed-footer-transaction-id = ID transakcji: { $transactionId }

# Trade errors
player-error-trade-no-characters = Gracz, z którym próbujesz handlować, nie ma postaci!
player-error-trade-no-active = Gracz, z którym próbujesz handlować, nie ma aktywnej postaci na tym serwerze!

# Spend currency embed
player-embed-title-spend = Raport transakcji gracza
player-embed-desc-spend-player = Gracz: { $playerMention } jako `{ $characterName }`
player-embed-desc-spend-transaction = Transakcja: {"**"}{ $characterName }{"**"} wydał(-a) {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Kanał
player-embed-field-receipt = Paragon

# Spend currency errors
player-error-amount-not-number = Kwota musi być liczbą.
player-error-amount-positive = Musisz wydać kwotę dodatnią.
player-error-amount-exceeds-maximum = Kwota nie może przekraczać { $max }.
player-error-no-active-character-server = Nie masz aktywnej postaci na tym serwerze.
player-error-no-currency-config = Nie znaleziono konfiguracji waluty dla tego serwera.

# Consume item embed
player-embed-title-consume = Raport zużycia przedmiotu
player-embed-desc-consume = Gracz: { $playerMention } jako `{ $characterName }`
player-embed-desc-consume-removed = Usunięto: {"**"}{ $quantity }x { $itemName }{"**"} z {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = Ilość musi być dodatnią liczbą całkowitą.
player-error-qty-at-least-one = Ilość musi wynosić co najmniej 1.
player-error-qty-only-have = Posiadasz tylko { $maxQuantity } tego przedmiotu.

# Inventory input errors
player-error-invalid-format = Nieprawidłowy format: "{ $line }". Użyj <nazwa>: <ilość>.
player-error-empty-name = Nazwa przedmiotu nie może być pusta w linii: "{ $line }".
player-error-invalid-quantity = Nieprawidłowa ilość dla "{ $name }": "{ $quantity }". Musi być dodatnią liczbą całkowitą.
player-error-input-errors-header = Błędy w danych ekwipunku:
player-msg-no-valid-items = Nie podano prawidłowych przedmiotów. Inicjalizacja z pustym ekwipunkiem.

# Cart quantity validation
player-error-enter-valid-number = Proszę wpisać prawidłową liczbę dodatnią.

# Submission embeds (approval queue)
player-embed-title-approval = Zatwierdzanie ekwipunku: { $characterName }
player-embed-desc-submitted-by = Przesłane przez { $userMention }
player-embed-field-items = Przedmioty
player-embed-field-currency-received = Waluta
player-embed-footer-submission-id = ID zgłoszenia: { $submissionId }
player-label-approval-thread = Zatwierdzanie: { $characterName }
player-embed-title-submission-sent = Zgłoszenie ekwipunku wysłane
player-embed-desc-submission-sent =
    Twoje zgłoszenie dla {"**"}{ $characterName }{"**"} zostało wysłane do zespołu GM do zatwierdzenia!
    Otrzymasz powiadomienie, gdy zostanie przejrzane.
    [Zobacz wątek zgłoszenia]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = Ekwipunek startowy zastosowany
player-embed-desc-starting-inventory = Gracz: { $playerMention } jako `{ $characterName }`
player-embed-field-items-received = Otrzymane przedmioty
player-embed-field-currency-received-label = Otrzymana waluta
player-label-untitled = Bez tytułu

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventory Submission: { $characterName }{"**"}
    Submitted by { $userMention }
player-approval-post-items = Przedmioty
player-approval-post-currency = Waluta
player-approval-resolved = To zgłoszenie zostało rozpatrzone.
player-approval-btn-approve = Zatwierdź
player-approval-btn-deny = Odrzuć
player-approval-btn-edit = Edytuj
player-approval-error-no-permission = Nie masz uprawnień do tej czynności.
player-approval-error-not-submitter = Tylko oryginalny nadawca może edytować to zgłoszenie.
player-approval-thread-instructions =
    This thread was created for the approval of a character's starting inventory.
    A Game Master will review the submission and approve or deny it.
    The submitting player may use the Edit button to modify and re-submit.
    Once approved or denied, this thread will be locked.
player-msg-submission-updated = Twoje zgłoszenie zostało zaktualizowane.

# Approval DM notifications
player-dm-title-approved = Postać zatwierdzona
player-dm-desc-approved =
    Your character {"**"}{ $characterName }{"**"} has been approved
    by { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Postać odrzucona
player-dm-desc-denied =
    Your character {"**"}{ $characterName }{"**"} has been denied
    by { $denier } in {"**"}{ $guildName }{"**"}. You may re-submit.
