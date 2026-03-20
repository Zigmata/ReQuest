## Game Master module strings

# GM buttons
gm-btn-create = Luo
gm-btn-edit-details = Muokkaa tietoja
gm-btn-toggle-ready = Vaihda valmiustila
gm-btn-configure-rewards = Määritä palkinnot
gm-btn-remove-player = Poista pelaaja
gm-btn-cancel-quest = Peruuta quest
gm-btn-manage-party-rewards = Hallinnoi ryhmäpalkintoja
gm-btn-manage-individual-rewards = Hallinnoi yksilöpalkintoja
gm-btn-join = Liity
gm-btn-leave = Poistu
gm-btn-complete-quest = Suorita quest
gm-btn-review-submission = Tarkista hakemus
gm-btn-approve = Hyväksy
gm-btn-deny = Hylkää

# GM modals
gm-modal-title-create-quest = Luo uusi quest
gm-modal-label-quest-title = Questin otsikko
gm-modal-placeholder-quest-title = Questisi otsikko
gm-modal-label-restrictions = Rajoitukset
gm-modal-placeholder-restrictions = Rajoitukset, jos on, kuten pelaajatasot
gm-modal-label-max-party = Ryhmän enimmäiskoko
gm-modal-placeholder-max-party = Questin ryhmän enimmäiskoko
gm-modal-label-party-role = Ryhmärooli
gm-modal-placeholder-party-role = Luo rooli tälle questille (valinnainen)
gm-modal-label-description = Kuvaus
gm-modal-placeholder-description = Kirjoita questisi yksityiskohdat tähän
gm-modal-title-editing-quest = Muokataan: { $questTitle }
gm-modal-label-title = Otsikko
gm-modal-label-max-party-size = Ryhmän enimmäiskoko
gm-modal-title-add-reward = Lisää palkinto
gm-modal-label-experience = Kokemuspisteet
gm-modal-placeholder-experience = Syötä numero
gm-modal-label-items = Esineet
gm-modal-placeholder-items =
    esine: määrä
    esine2: määrä
    jne.
gm-modal-title-add-summary = Lisää quest-yhteenveto
gm-modal-label-summary = Yhteenveto
gm-modal-placeholder-summary = Lisää questin tarinalyhennelmä
gm-modal-title-modifying-player = Muokataan: { $playerName }
gm-modal-placeholder-xp-add-remove = Syötä positiivinen tai negatiivinen luku.
gm-modal-label-inventory = Inventaario
gm-modal-placeholder-inventory-modify =
    esine: määrä
    esine2: määrä
    jne.
gm-modal-title-review-submission = Tarkista hakemus
gm-modal-label-submission-id = Hakemustunnus
gm-modal-placeholder-submission-id = Syötä 8 merkin tunnus

# GM errors
gm-error-forbidden-role-name = Ryhmäroolille annettu nimi on kielletty.
gm-error-role-already-exists = Samanniminen rooli on jo olemassa tällä palvelimella.
gm-error-no-quest-channel = Quest-julkaisuja varten ei ole vielä määritetty kanavaa. Ota yhteyttä palvelimen ylläpitäjään quest-kanavan määrittämiseksi.
gm-error-cannot-ping-announce = Ilmoitusroolia { $role } ei voitu pingata kanavassa { $channel }. Tarkista kanavan ja ReQuest-roolin oikeudet palvelimen ylläpitäjän kanssa.
gm-error-invalid-item-format = Virheellinen esinemuoto: "{ $item }". Jokainen esine on oltava omalla rivillään muodossa "Nimi: Määrä".
gm-error-submission-not-found = Hakemusta ei löytynyt.
gm-error-already-on-quest = Olet jo tässä questissä hahmona { $characterName }.
gm-error-no-active-character-long = Sinulla ei ole aktiivista hahmoa tällä palvelimella. Käytä `/player`-komentoa rekisteröidäksesi tai aktivoidaksesi hahmon.
gm-error-quest-locked = Virhe liittyessä questiin {"**"}{ $questTitle }{"**"}: Quest on GM:n lukitsema.
gm-error-quest-full = Virhe liittyessä questiin {"**"}{ $questTitle }{"**"}: Questin ryhmä on täynnä!
gm-error-not-signed-up = Et ole ilmoittautunut tähän questiin.
gm-error-quest-channel-not-set = Quest-kanavaa ei ole asetettu!
gm-error-empty-roster = Questia ei voi suorittaa tyhjällä ryhmällä. Kokeile peruuttamista sen sijaan.
gm-error-invalid-xp-value = XP-arvon on oltava positiivinen kokonaisluku!

# GM confirm modals
gm-modal-title-cancel-quest = Peruuta quest
gm-modal-label-cancel-quest = Kirjoita CONFIRM peruuttaaksesi questin.
gm-modal-placeholder-cancel-quest = Kirjoita "CONFIRM" jatkaaksesi.
gm-modal-title-remove-from-quest = Poista hahmo questistä
gm-modal-label-remove-from-quest = Vahvista hahmon poisto?
gm-modal-placeholder-remove-from-quest = Kirjoita "CONFIRM" jatkaaksesi.

# GM DM messages
gm-dm-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} peruutettiin GM:n toimesta.
gm-dm-quest-ready = Quest {"**"}{ $questTitle }{"**"} on nyt valmis!
gm-dm-quest-unlocked = Quest {"**"}{ $questTitle }{"**"} ei ole enää lukittu.
gm-dm-quest-locked = Quest {"**"}{ $questTitle }{"**"} on nyt GM:n lukitsema.
gm-dm-player-removed = Sinut poistettiin questistä {"**"}{ $questTitle }{"**"}.
gm-dm-player-removed-waitlist = Sinut poistettiin questin {"**"}{ $questTitle }{"**"} jonotuslistalta.
gm-dm-party-promotion = Sinut on lisätty questin {"**"}{ $questTitle }{"**"} ryhmään, koska toinen pelaaja poistui!
gm-dm-roster-locked = Questin ryhmä lukittu ja jäsenille ilmoitettu!
gm-dm-roster-unlocked = Questin ryhmän lukitus on avattu.
gm-dm-rewards-no-characters =
    Palvelimesi ylläpitäjä on määrittänyt palkintoja pelinjohtajille questien suorittamisesta.
    Koska sinulla ei kuitenkaan ole rekisteröityjä hahmoja, palkkioitasi ei voitu
    myöntää automaattisesti tällä hetkellä.
gm-dm-rewards-no-active-character =
    Palvelimesi ylläpitäjä on määrittänyt palkintoja pelinjohtajille questien suorittamisesta.
    Koska sinulla ei kuitenkaan ole aktiivista hahmoa tällä palvelimella, palkkioitasi
    ei voitu myöntää automaattisesti tällä hetkellä.
gm-dm-rewards-issued = Seuraavat on myönnetty aktiiviselle hahmollesi, { $characterName }

# GM select menus
gm-select-placeholder-party-member = Valitse ryhmän jäsen

# GM embeds
gm-embed-title-mod-report = GM:n pelaajan muokkausraportti
gm-embed-field-experience = Kokemus
gm-embed-title-quest-complete = Quest valmis: { $questTitle }
gm-embed-title-quest-completed = QUEST SUORITETTU: { $questTitle }
gm-embed-field-rewards = Palkinnot
gm-embed-field-party = __Ryhmä__
gm-embed-field-summary = Yhteenveto
gm-embed-title-gm-rewards = GM-palkinnot myönnetty
gm-embed-field-items = Esineet
gm-msg-player-removed = Pelaaja poistettu ja questin ryhmä päivitetty!

# GM views
gm-title-main-menu = Pelinjohtaja - Päävalikko
gm-menu-quests = Questit
gm-menu-desc-quests = Luo, muokkaa ja hallinnoi questejä.
gm-menu-players = Pelaajat
gm-menu-desc-players = Hallinnoi pelaajien inventaarioita ja muokkaa hahmoja.
gm-menu-approvals = Hahmojen hyväksynnät
gm-menu-desc-approvals = Tarkista ja hyväksy/hylkää hahmohakemukset.

gm-title-quest-management = Pelinjohtaja - Questien hallinta
gm-desc-create-quest = Luo uusi quest.
gm-msg-no-quests = Questejä ei löytynyt.
gm-label-quest-locked = (Lukittu)
gm-title-manage-quest = Hallinnoi questiä - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Muokkaa questin tietoja, kuten otsikkoa, kuvausta ja ryhmän kokoa.
gm-desc-toggle-ready = Vaihda valmiustila (Nykyinen: {"**"}{ $status }{"**"})
    - Lukitsee questin ryhmän ja ilmoittaa jäsenille, että quest alkaa pian. Jos rooli on määritetty, se annetaan ryhmän jäsenille lukittaessa.
    - Avaa ryhmän lukituksen, kun asetetaan Avoimeksi.
gm-label-ready-locked = Lukittu/Valmis
gm-label-ready-open = Avoin
gm-desc-configure-rewards = Määritä valitun questin palkinnot.
gm-desc-complete-quest = Suorita quest. Myöntää palkinnot, jos niitä on, ryhmän jäsenille.
gm-desc-remove-player = Poista pelaaja questin ryhmästä ja ilmoita hänelle.
gm-desc-cancel-quest = Peruuta quest ja poista se quest-taululta.
gm-title-player-management = Pelinjohtaja - Pelaajien hallinta
gm-desc-player-management =
    Nämä komennot ovat siirtyneet kontekstivalikkoihin. Napsauta hiiren oikealla painikkeella (työpöytä) tai paina pitkään (mobiili) pelaajan profiilia seuraavien valikkovaihtoehtojen saamiseksi:

    - {"**"}Muokkaa pelaajaa{"**"}: Lisää tai poista esineitä ja kokemusta pelaajalta.
    - {"**"}Näytä pelaaja{"**"}: Näytä pelaajan aktiivisen hahmon tiedot.
gm-title-remove-player = Poista pelaaja questistä - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Pelaajan poiston huomiot{"**"}__

    - Valitse pelaaja alla olevasta pudotusvalikosta poistaaksesi hänet questin ryhmästä.
    - Jos jonotuslistalla on pelaajia, listan ensimmäinen pelaaja ylennetään ryhmään.
    - Poistetun pelaajan yksilöpalkinnot poistetaan questistä.
    - Jos haluat palkita pelaajan aikaisemmasta panoksesta, käytä `Muokkaa pelaajaa` -kontekstivalikkoa myöntääksesi hänelle palkinnot suoraan.
gm-label-no-players-in-roster = Questin ryhmässä ei ole pelaajia
gm-title-character-sheet = Hahmoarkki: { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Kokemuspisteet:{"**"}__
gm-label-possessions = __{"**"}Omaisuus{"**"}__
gm-label-currency-heading = {"**"}Valuutta{"**"}
gm-msg-inventory-empty = Inventaario on tyhjä.

# GM approvals
gm-title-approvals = Pelinjohtaja - Inventaarion hyväksynnät
gm-desc-review-submission = Syötä hakemustunnus tarkistaaksesi ja hyväksyäksesi/hylätäksesi sen.
gm-title-reviewing = Tarkistetaan: { $characterName }
gm-label-items = {"**"}Esineet:{"**"}
gm-label-currency = {"**"}Valuutta:{"**"}
gm-embed-title-approved = Inventaarion päivitys hyväksytty
gm-embed-desc-approved = Hahmon {"**"}{ $characterName }{"**"} inventaario on hyväksytty, hyväksyjä: { $approver }.
gm-embed-title-denied = Inventaarion päivitys hylätty
gm-embed-desc-denied = Hahmon {"**"}{ $characterName }{"**"} inventaario on hylätty, hylkääjä: { $denier }.

gm-modal-label-select-party-role = Party Role
gm-modal-desc-select-party-role = Select a role to assign to the quest party.
gm-select-option-no-role = None (No Party Role)

gm-error-role-hierarchy = ReQuest cannot manage the role "{ $roleName }" (ID: { $roleId }) because it is positioned higher than ReQuest's highest role in the server hierarchy. Please contact a server administrator to move the role below ReQuest's role, or assign ReQuest a higher role.
gm-dm-role-removal-failed =
    ⚠️ Failed to remove the role {"**"}{ $roleName }{"**"} from the following members: { $members }.
    Please notify a server administrator to remove the role manually.
