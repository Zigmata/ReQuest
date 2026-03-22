## Game Master module strings

# GM buttons
gm-btn-create = Creează
gm-btn-edit-details = Editează detalii
gm-btn-toggle-ready = Comută pregătirea
gm-btn-configure-rewards = Configurează recompense
gm-btn-remove-player = Elimină jucător
gm-btn-cancel-quest = Anulează quest
gm-btn-manage-party-rewards = Gestionează recompense echipă
gm-btn-manage-individual-rewards = Gestionează recompense individuale
gm-btn-join = Alătură-te
gm-btn-leave = Părăsește
gm-btn-complete-quest = Finalizează quest
gm-btn-review-submission = Revizuiește trimiterea
gm-btn-approve = Aprobă
gm-btn-deny = Respinge

# GM modals
gm-modal-title-create-quest = Creează quest nou
gm-modal-label-quest-title = Titlul quest-ului
gm-modal-placeholder-quest-title = Titlul quest-ului tău
gm-modal-label-restrictions = Restricții
gm-modal-placeholder-restrictions = Restricții, dacă există, cum ar fi nivelurile jucătorilor
gm-modal-label-max-party = Dimensiune maximă echipă
gm-modal-placeholder-max-party = Dimensiunea maximă a echipei pentru acest quest
gm-modal-label-party-role = Rol echipă
gm-modal-placeholder-party-role = Creați un rol pentru acest quest (Opțional)
gm-modal-label-description = Descriere
gm-modal-placeholder-description = Scrieți detaliile quest-ului aici
gm-modal-title-editing-quest = Editare { $questTitle }
gm-modal-label-title = Titlu
gm-modal-label-max-party-size = Dimensiune maximă echipă
gm-modal-title-add-reward = Adaugă recompensă
gm-modal-label-experience = Puncte de experiență
gm-modal-placeholder-experience = Introduceți un număr
gm-modal-label-items = Obiecte
gm-modal-placeholder-items =
    obiect: cantitate
    obiect2: cantitate
    etc.
gm-modal-title-add-summary = Adaugă rezumat quest
gm-modal-label-summary = Rezumat
gm-modal-placeholder-summary = Adăugați un rezumat al poveștii quest-ului
gm-modal-title-modifying-player = Modificare { $playerName }
gm-modal-placeholder-xp-add-remove = Introduceți un număr pozitiv sau negativ.
gm-modal-label-inventory = Inventar
gm-modal-placeholder-inventory-modify =
    obiect: cantitate
    obiect2: cantitate
    etc.
gm-modal-title-review-submission = Revizuiește trimiterea
gm-modal-label-submission-id = ID trimitere
gm-modal-placeholder-submission-id = Introduceți ID-ul de 8 caractere

# GM errors
gm-error-forbidden-role-name = Numele furnizat pentru rolul echipei este interzis.
gm-error-role-already-exists = Un rol cu acel nume există deja pe acest server.
gm-error-no-quest-channel = Un canal nu a fost încă desemnat pentru postările de quest. Contactați un administrator de server pentru a configura canalul de quest-uri.
gm-error-cannot-ping-announce = Nu s-a putut notifica rolul de anunțare { $role } în canalul { $channel }. Verificați permisiunile canalului și ale rolului ReQuest cu administratorii serverului.
gm-error-invalid-item-format = Format de obiect invalid: „{ $item }". Fiecare obiect trebuie să fie pe o linie nouă, în formatul „Nume: Cantitate".
gm-error-submission-not-found = Trimiterea nu a fost găsită.
gm-error-already-on-quest = Sunteți deja pe acest quest ca { $characterName }.
gm-error-no-active-character-long = Nu aveți un personaj activ pe acest server. Folosiți `/player` pentru a înregistra sau activa un personaj.
gm-error-quest-locked = Eroare la alăturarea la quest-ul {"**"}{ $questTitle }{"**"}: Quest-ul este blocat de GM.
gm-error-quest-full = Eroare la alăturarea la quest-ul {"**"}{ $questTitle }{"**"}: Lista echipei este plină!
gm-error-not-signed-up = Nu sunteți înscris pe acest quest.
gm-error-quest-channel-not-set = Canalul de quest-uri nu a fost setat!
gm-error-empty-roster = Nu puteți finaliza un quest cu o listă goală. Încercați să anulați în schimb.
gm-error-invalid-xp-value = Valoarea XP trebuie să fie un număr întreg pozitiv!

# GM confirm modals
gm-modal-title-cancel-quest = Anulează quest
gm-modal-label-cancel-quest = Tastați CONFIRM pentru a anula quest-ul.
gm-modal-placeholder-cancel-quest = Tastați „CONFIRM" pentru a continua.
gm-modal-title-remove-from-quest = Elimină personajul din quest
gm-modal-label-remove-from-quest = Confirmați eliminarea personajului?
gm-modal-placeholder-remove-from-quest = Tastați „CONFIRM" pentru a continua.

# GM DM messages
gm-dm-quest-cancelled = Quest-ul {"**"}{ $questTitle }{"**"} a fost anulat de GM.
gm-dm-quest-ready = Quest-ul {"**"}{ $questTitle }{"**"} este acum pregătit!
gm-dm-quest-unlocked = Quest-ul {"**"}{ $questTitle }{"**"} nu mai este blocat.
gm-dm-quest-locked = Quest-ul {"**"}{ $questTitle }{"**"} este acum blocat de GM.
gm-dm-player-removed = Ați fost eliminat din quest-ul {"**"}{ $questTitle }{"**"}.
gm-dm-player-removed-waitlist = Ați fost eliminat de pe lista de așteptare pentru {"**"}{ $questTitle }{"**"}.
gm-dm-party-promotion = Ați fost adăugat în echipa pentru {"**"}{ $questTitle }{"**"}, datorită retragerii unui jucător!
gm-dm-roster-locked = Lista quest-ului a fost blocată și echipa a fost notificată!
gm-dm-roster-unlocked = Lista quest-ului a fost deblocată.
gm-dm-rewards-no-characters =
    Administratorul serverului a configurat recompense pentru Game Masteri la finalizarea
    quest-urilor. Cu toate acestea, deoarece nu aveți personaje înregistrate, recompensele
    nu au putut fi acordate automat de data aceasta.
gm-dm-rewards-no-active-character =
    Administratorul serverului a configurat recompense pentru Game Masteri la finalizarea
    quest-urilor. Cu toate acestea, deoarece nu aveți un personaj activ pe acest server,
    recompensele nu au putut fi acordate automat de data aceasta.
gm-dm-rewards-issued = Următoarele au fost acordate personajului dumneavoastră activ, { $characterName }

# GM select menus
gm-select-placeholder-party-member = Selectați un membru al echipei

# GM embeds
gm-embed-title-mod-report = Raport modificare jucător de către GM
gm-embed-field-experience = Experiență
gm-embed-title-quest-complete = Quest finalizat: { $questTitle }
gm-embed-title-quest-completed = QUEST FINALIZAT: { $questTitle }
gm-embed-field-rewards = Recompense
gm-embed-field-party = __Echipă__
gm-embed-field-summary = Rezumat
gm-embed-title-gm-rewards = Recompense GM acordate
gm-embed-field-items = Obiecte
gm-msg-player-removed = Jucătorul a fost eliminat și lista quest-ului a fost actualizată!

# GM views
gm-title-main-menu = Game Master - Meniu principal
gm-menu-quests = Quest-uri
gm-menu-desc-quests = Creați, editați și gestionați quest-uri.
gm-menu-players = Jucători
gm-menu-desc-players = Gestionați inventarele jucătorilor și modificați personajele.
gm-menu-approvals = Aprobări personaje
gm-menu-desc-approvals = Revizuiți și aprobați/respingeți trimiterile de personaje.

gm-title-quest-management = Game Master - Gestionare quest-uri
gm-desc-create-quest = Creați un quest nou.
gm-msg-no-quests = Nu s-au găsit quest-uri.
gm-label-quest-locked = (Blocat)
gm-title-manage-quest = Gestionare quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Editați detaliile quest-ului, cum ar fi titlul, descrierea și dimensiunea echipei.
gm-desc-toggle-ready = Comutați starea de pregătire (Curent: {"**"}{ $status }{"**"})
    - Blochează lista quest-ului și notifică membrii echipei că quest-ul va începe curând. Dacă un rol este configurat, acesta va fi atribuit membrilor echipei la blocare.
    - Deblochează lista când este setat pe Deschis.
gm-label-ready-locked = Blocat/Pregătit
gm-label-ready-open = Deschis
gm-desc-configure-rewards = Configurați recompensele pentru quest-ul selectat.
gm-desc-complete-quest = Finalizați un quest. Acordă recompensele, dacă există, membrilor echipei.
gm-desc-remove-player = Eliminați un jucător de pe lista quest-ului și notificați-l.
gm-desc-cancel-quest = Anulați quest-ul și ștergeți-l de pe panoul de quest-uri.
gm-title-player-management = Game Master - Gestionare jucători
gm-desc-player-management =
    Aceste comenzi au fost mutate în meniurile contextuale. Faceți clic dreapta (desktop) sau apăsați lung (mobil) pe profilul unui jucător pentru următoarele opțiuni de meniu:

    - {"**"}Modify Player{"**"}: Adăugați sau eliminați obiecte și experiență de la un jucător.
    - {"**"}View Player{"**"}: Vizualizați detaliile personajului activ al unui jucător.
gm-title-remove-player = Eliminare jucător din quest - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Note privind eliminarea jucătorului{"**"}__

    - Alegeți un jucător din meniul derulant de mai jos pentru a-l elimina de pe lista quest-ului.
    - Dacă sunt jucători pe lista de așteptare, primul jucător din listă va fi promovat în echipă.
    - Recompensele individuale pentru jucătorul eliminat vor fi șterse din quest.
    - Dacă doriți să recompensați jucătorul pentru contribuțiile anterioare, folosiți meniul contextual `Modify Player` pentru a-i acorda recompensele direct.
gm-label-no-players-in-roster = Niciun jucător pe lista quest-ului
gm-title-character-sheet = Fișa personajului pentru { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Puncte de experiență:{"**"}__
gm-label-possessions = __{"**"}Posesiuni{"**"}__
gm-label-currency-heading = {"**"}Monedă{"**"}
gm-msg-inventory-empty = Inventarul este gol.

# GM approvals
gm-title-approvals = Game Master - Aprobări inventar
gm-desc-review-submission = Introduceți un ID de trimitere pentru a-l revizui și aproba/respinge.
gm-title-reviewing = Revizuire: { $characterName }
gm-label-items = {"**"}Obiecte:{"**"}
gm-label-currency = {"**"}Monedă:{"**"}
gm-embed-title-approved = Actualizare inventar aprobată
gm-embed-desc-approved = Inventarul pentru {"**"}{ $characterName }{"**"} a fost aprobat de { $approver }.
gm-embed-title-denied = Actualizare inventar respinsă
gm-embed-desc-denied = Inventarul pentru {"**"}{ $characterName }{"**"} a fost respins de { $denier }.

gm-modal-label-select-party-role = Rol echipă
gm-modal-desc-select-party-role = Selectați un rol de atribuit echipei quest-ului.
gm-select-option-no-role = Niciunul (Fără rol de echipă)

gm-error-role-hierarchy = ReQuest nu poate gestiona rolul "{ $roleName }" (ID: { $roleId }) deoarece este poziționat mai sus decât cel mai înalt rol al ReQuest în ierarhia serverului. Contactați un administrator de server pentru a muta rolul sub rolul ReQuest sau pentru a atribui ReQuest un rol mai înalt, apoi reîncercați operațiunea.
gm-dm-role-removal-failed =
    ⚠️ Nu s-a putut elimina rolul {"**"}{ $roleName }{"**"} de la următorii membri: { $members }.
    Notificați un administrator de server pentru a elimina rolul manual.

gm-dm-role-not-found =
    ⚠️ Rolul de quest (ID: { $roleId }) pentru quest-ul {"**"}{ $questTitle }{"**"} nu mai există pe server.
    Operațiunile de rol au fost omise. Notificați un administrator de server dacă acest lucru este neașteptat.
