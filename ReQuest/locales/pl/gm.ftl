## Game Master module strings

# GM buttons
gm-btn-create = Utwórz
gm-btn-edit-details = Edytuj quest
gm-btn-toggle-ready = Przełącz gotowość
gm-btn-configure-rewards = Konfiguruj nagrody
gm-btn-remove-player = Usuń gracza
gm-btn-cancel-quest = Anuluj quest
gm-btn-manage-party-rewards = Zarządzaj nagrodami drużyny
gm-btn-manage-individual-rewards = Zarządzaj indywidualnymi nagrodami
gm-btn-join = Dołącz
gm-btn-leave = Opuść
gm-btn-complete-quest = Ukończ quest
gm-btn-edit-details-modal = Edytuj szczegóły
gm-btn-edit-images = Edytuj obrazy
gm-btn-publish = Opublikuj
gm-btn-update-post = Aktualizuj post
gm-select-placeholder-party-role = Wybierz rolę drużyny...
gm-modal-title-edit-details = Edytuj szczegóły questu
gm-modal-title-edit-images = Edytuj obrazy questu

# GM modals
gm-modal-title-create-quest = Utwórz nowy quest
gm-modal-label-quest-title = Tytuł questu
gm-modal-placeholder-quest-title = Tytuł Twojego questu
gm-modal-label-restrictions = Ograniczenia
gm-modal-placeholder-restrictions = Ograniczenia, jeśli istnieją, np. poziomy graczy
gm-modal-label-max-party = Maksymalny rozmiar drużyny
gm-modal-placeholder-max-party = Maksymalny rozmiar drużyny dla tego questu
gm-modal-label-party-role = Rola drużyny
gm-modal-placeholder-party-role = Utwórz rolę dla tego questu (opcjonalne)
gm-modal-label-description = Opis
gm-modal-placeholder-description = Opisz szczegóły swojego questu tutaj
gm-modal-label-image-url = URL miniaturki
gm-modal-label-large-image-url = URL dużego obrazu
gm-modal-placeholder-image-url = Wpisz URL obrazu (lub pozostaw puste, aby usunąć)
gm-modal-title-add-reward = Dodaj nagrodę
gm-modal-label-experience = Punkty doświadczenia
gm-modal-placeholder-experience = Wpisz liczbę
gm-modal-label-items = Przedmioty
gm-modal-placeholder-items =
    przedmiot: ilość
    przedmiot2: ilość
    itd.
gm-modal-title-add-summary = Dodaj podsumowanie questu
gm-modal-label-summary = Podsumowanie
gm-modal-placeholder-summary = Dodaj podsumowanie fabularne questu
gm-modal-title-modifying-player = Modyfikowanie { $playerName }
gm-modal-placeholder-xp-add-remove = Wpisz liczbę dodatnią lub ujemną.
gm-modal-label-inventory = Ekwipunek
gm-modal-placeholder-inventory-modify =
    przedmiot: ilość
    przedmiot2: ilość
    itd.

# GM errors
gm-error-no-quest-channel = Nie wyznaczono jeszcze kanału dla postów questowych. Skontaktuj się z administratorem serwera, aby skonfigurować kanał questów.
gm-error-invalid-item-format = Nieprawidłowy format przedmiotu: "{ $item }". Każdy przedmiot musi być w osobnej linii, w formacie "Nazwa: Ilość".
gm-error-already-on-quest = Już jesteś w tym queście jako { $characterName }.
gm-error-no-active-character-long = Nie masz aktywnej postaci na tym serwerze. Użyj `/player`, aby zarejestrować lub aktywować postać.
gm-error-quest-locked = Błąd dołączania do questu {"**"}{ $questTitle }{"**"}: Quest jest zablokowany przez GM.
gm-error-quest-full = Błąd dołączania do questu {"**"}{ $questTitle }{"**"}: Lista uczestników jest pełna!
gm-error-not-signed-up = Nie jesteś zapisany(-a) na ten quest.
gm-error-quest-not-found = Zadanie już nie istnieje.
gm-error-quest-channel-not-set = Kanał questów nie został ustawiony!
gm-error-empty-roster = Nie możesz ukończyć questu z pustą listą uczestników. Spróbuj anulować quest.
gm-error-invalid-xp-value = Wartość XP musi być dodatnią liczbą całkowitą!
gm-error-party-size-positive = Rozmiar drużyny musi być liczbą dodatnią.
gm-error-party-size-too-small = Rozmiar drużyny nie może być mniejszy niż obecna drużyna ({ $currentSize } członków).
gm-error-role-name-forbidden = Nazwa roli "{ $roleName }" jest zabroniona na tym serwerze.
gm-error-role-name-exists = Rola o nazwie "{ $roleName }" już istnieje na tym serwerze.
gm-error-role-hierarchy = ReQuest nie może zarządzać rolą "{ $roleName }" (ID: { $roleId }), ponieważ znajduje się ona wyżej niż najwyższa rola ReQuest w hierarchii serwera. Skontaktuj się z administratorem serwera, aby przenieść rolę poniżej roli ReQuest lub przypisać ReQuest wyższą rolę, a następnie spróbuj ponownie.

# GM confirm modals
gm-modal-title-cancel-quest = Anuluj quest
gm-modal-label-cancel-quest = Wpisz POTWIERDŹ, aby anulować quest.
gm-modal-title-remove-from-quest = Usuń postać z questu
gm-modal-label-remove-from-quest = Potwierdzić usunięcie postaci?

# GM DM embeds
gm-dm-title-quest-cancelled = Quest anulowany
gm-dm-desc-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} został anulowany przez GM.
gm-dm-title-quest-ready = Quest gotowy
gm-dm-desc-quest-ready = Quest {"**"}{ $questTitle }{"**"} jest teraz gotowy! Twój GM wkrótce rozpocznie quest.
gm-dm-title-player-removed = Usunięto z questu
gm-dm-desc-player-removed = Zostałeś(-aś) usunięty(-a) z questu {"**"}{ $questTitle }{"**"} przez GM.
gm-dm-desc-player-removed-waitlist = Zostałeś(-aś) usunięty(-a) z listy oczekujących na quest {"**"}{ $questTitle }{"**"}.
gm-dm-title-party-promotion = Awans do drużyny
gm-dm-desc-party-promotion =
    Zostałeś(-aś) awansowany(-a) do głównej drużyny questu {"**"}{ $questTitle }{"**"},
    ponieważ gracz opuścił quest.
gm-dm-title-roster-locked = Lista zablokowana
gm-dm-desc-roster-locked =
    Lista uczestników questu {"**"}{ $questTitle }{"**"} została zablokowana
    i wszyscy członkowie drużyny zostali powiadomieni.
gm-dm-title-roster-unlocked = Lista odblokowana
gm-dm-desc-roster-unlocked = Lista uczestników questu {"**"}{ $questTitle }{"**"} została odblokowana.
gm-dm-title-player-removed-confirm = Gracz usunięty
gm-dm-desc-player-removed-confirm =
    Gracz został usunięty z questu {"**"}{ $questTitle }{"**"}
    i lista uczestników została zaktualizowana.
gm-dm-footer-quest = ID zadania: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    Administrator serwera skonfigurował nagrody dla Mistrzów Gry za ukończenie
    questów. Jednak ponieważ nie masz zarejestrowanych postaci, Twoje nagrody nie mogły
    zostać automatycznie przyznane w tym momencie.
gm-dm-rewards-no-active-character =
    Administrator serwera skonfigurował nagrody dla Mistrzów Gry za ukończenie
    questów. Jednak ponieważ nie masz aktywnej postaci na tym serwerze, Twoje nagrody
    nie mogły zostać automatycznie przyznane w tym momencie.
gm-dm-rewards-issued = Następujące nagrody zostały przyznane Twojej aktywnej postaci, { $characterName }
gm-dm-role-removal-failed =
    ⚠️ Nie udało się usunąć roli {"**"}{ $roleName }{"**"} od następujących członków: { $members }.
    Powiadom administratora serwera, aby ręcznie usunął rolę.
gm-dm-role-not-found =
    ⚠️ Rola questowa (ID: { $roleId }) dla questu {"**"}{ $questTitle }{"**"} nie istnieje już na serwerze.
    Operacje na rolach zostały pominięte. Powiadom administratora serwera, jeśli jest to nieoczekiwane.

# GM select menus
gm-select-placeholder-party-member = Wybierz członka drużyny
gm-select-option-no-role = Brak (bez roli drużyny)

# GM embeds
gm-embed-title-mod-report = Raport modyfikacji gracza przez GM
gm-embed-field-experience = Doświadczenie
gm-embed-title-quest-complete = Quest ukończony: { $questTitle }
gm-embed-title-quest-completed = QUEST UKOŃCZONY: { $questTitle }
gm-embed-field-rewards = Nagrody
gm-embed-field-party = __Drużyna__
gm-embed-field-summary = Podsumowanie
gm-embed-title-gm-rewards = Nagrody GM przyznane
gm-embed-field-items = Przedmioty

# GM views
gm-title-main-menu = Mistrz Gry - Menu główne
gm-menu-quests = Questy
gm-menu-desc-quests = Twórz, edytuj i zarządzaj questami.
gm-menu-players = Gracze
gm-menu-desc-players = Zarządzaj ekwipunkami graczy i modyfikuj postacie.

gm-title-quest-management = Mistrz Gry - Zarządzanie questami
gm-desc-create-quest = Utwórz nowy quest.
gm-msg-no-quests = Nie znaleziono questów.
gm-label-quest-locked = (Zablokowany)
gm-label-quest-draft = (Szkic)
gm-title-manage-quest = Zarządzaj questem - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Edytuj szczegóły questu, takie jak tytuł, opis i rozmiar drużyny.
gm-label-field-not-set = Nie ustawiono
gm-label-description-not-set = Opis nie ustawiony
gm-label-current-party-size = {"**"}Maks. rozmiar drużyny:{"**"} { $value }
gm-label-current-party-role = {"**"}Rola drużyny:{"**"} { $value }
gm-desc-toggle-ready = Przełącz stan gotowości (Aktualnie: {"**"}{ $status }{"**"})
    - Blokuje listę uczestników i powiadamia członków drużyny, że quest wkrótce się rozpocznie. Jeśli skonfigurowano rolę, zostanie ona przypisana członkom drużyny po zablokowaniu.
    - Odblokowuje listę uczestników po ustawieniu na Otwarty.
gm-label-ready-locked = Zablokowany/Gotowy
gm-label-ready-open = Otwarty
gm-desc-configure-rewards = Konfiguruj nagrody dla wybranego questu.
gm-desc-complete-quest = Ukończ quest. Przyznaje nagrody, jeśli istnieją, członkom drużyny.
gm-desc-remove-player = Usuń gracza z listy uczestników questu i powiadom go.
gm-desc-cancel-quest = Anuluj quest i usuń go z tablicy questów.
gm-title-player-management = Mistrz Gry - Zarządzanie graczami
gm-desc-player-management =
    Te komendy zostały przeniesione do menu kontekstowych. Kliknij prawym przyciskiem myszy (komputer) lub przytrzymaj (telefon) profil gracza, aby uzyskać dostęp do następujących opcji:

    - {"**"}Modyfikuj Gracza{"**"}: Dodaj lub usuń przedmioty i doświadczenie gracza.
    - {"**"}Podgląd Gracza{"**"}: Wyświetl szczegóły aktywnej postaci gracza.
gm-title-remove-player = Usuń gracza z questu - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Uwagi dotyczące usuwania gracza{"**"}__

    - Wybierz gracza z listy rozwijanej poniżej, aby usunąć go z listy uczestników questu.
    - Jeśli jacyś gracze są na liście oczekujących, pierwszy gracz z listy zostanie awansowany do drużyny.
    - Indywidualne nagrody dla usuniętego gracza zostaną usunięte z questu.
    - Jeśli chcesz nagrodzić gracza za wcześniejszy wkład, użyj menu kontekstowego `Modyfikuj Gracza`, aby przyznać mu nagrody bezpośrednio.
gm-label-no-players-in-roster = Brak graczy na liście uczestników questu
gm-title-character-sheet = Karta postaci: { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Punkty doświadczenia:{"**"}__
gm-label-possessions = __{"**"}Posiadane przedmioty{"**"}__

# GM approvals
