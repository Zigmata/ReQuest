## Game Master module strings

# GM buttons
gm-btn-create = Luo
gm-btn-edit-details = Muokkaa questiä
gm-btn-toggle-ready = Vaihda valmiustila
gm-btn-configure-rewards = Määritä palkinnot
gm-btn-remove-player = Poista pelaaja
gm-btn-cancel-quest = Peruuta quest
gm-btn-manage-party-rewards = Hallinnoi ryhmäpalkintoja
gm-btn-manage-individual-rewards = Hallinnoi yksilöpalkintoja
gm-btn-join = Liity
gm-btn-leave = Poistu
gm-btn-complete-quest = Suorita quest
gm-btn-edit-details-modal = Muokkaa tietoja
gm-btn-edit-images = Muokkaa kuvia
gm-btn-publish = Julkaise
gm-btn-update-post = Päivitä julkaisu
gm-select-placeholder-party-role = Valitse ryhmärooli...
gm-modal-title-edit-details = Muokkaa questin tietoja
gm-modal-title-edit-images = Muokkaa questin kuvia

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
gm-modal-label-image-url = Pikkukuvan URL
gm-modal-label-large-image-url = Suuren kuvan URL
gm-modal-placeholder-image-url = Syötä kuvan URL (tai jätä tyhjäksi poistaaksesi)
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

# GM errors
gm-error-no-quest-channel = Quest-julkaisuja varten ei ole vielä määritetty kanavaa. Ota yhteyttä palvelimen ylläpitäjään quest-kanavan määrittämiseksi.
gm-error-invalid-item-format = Virheellinen esinemuoto: "{ $item }". Jokainen esine on oltava omalla rivillään muodossa "Nimi: Määrä".
gm-error-already-on-quest = Olet jo tässä questissä hahmona { $characterName }.
gm-error-no-active-character-long = Sinulla ei ole aktiivista hahmoa tällä palvelimella. Käytä `/player`-komentoa rekisteröidäksesi tai aktivoidaksesi hahmon.
gm-error-quest-locked = Virhe liittyessä questiin {"**"}{ $questTitle }{"**"}: Quest on GM:n lukitsema.
gm-error-quest-full = Virhe liittyessä questiin {"**"}{ $questTitle }{"**"}: Questin ryhmä on täynnä!
gm-error-not-signed-up = Et ole ilmoittautunut tähän questiin.
gm-error-quest-not-found = Tehtävää ei enää ole olemassa.
gm-error-quest-channel-not-set = Quest-kanavaa ei ole asetettu!
gm-error-empty-roster = Questia ei voi suorittaa tyhjällä ryhmällä. Kokeile peruuttamista sen sijaan.
gm-error-invalid-xp-value = XP-arvon on oltava positiivinen kokonaisluku!
gm-error-party-size-positive = Ryhmän koon on oltava positiivinen luku.
gm-error-party-size-too-small = Ryhmän koko ei voi olla pienempi kuin nykyinen ryhmä ({ $currentSize } jäsentä).
gm-error-role-name-forbidden = Roolin nimi "{ $roleName }" on kielletty tällä palvelimella.
gm-error-role-name-exists = Rooli nimeltä "{ $roleName }" on jo olemassa tällä palvelimella.

# GM confirm modals
gm-modal-title-cancel-quest = Peruuta quest
gm-modal-label-cancel-quest = Kirjoita VAHVISTA peruuttaaksesi questin.
gm-modal-title-remove-from-quest = Poista hahmo questistä
gm-modal-label-remove-from-quest = Vahvista hahmon poisto?

# GM DM embeds
gm-dm-title-quest-cancelled = Quest peruutettu
gm-dm-desc-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} peruutettiin GM:n toimesta.
gm-dm-title-quest-ready = Quest valmis
gm-dm-desc-quest-ready = Quest {"**"}{ $questTitle }{"**"} on nyt valmis! GM aloittaa questin pian.
gm-dm-title-player-removed = Poistettu questistä
gm-dm-desc-player-removed = Sinut poistettiin questistä {"**"}{ $questTitle }{"**"} GM:n toimesta.
gm-dm-desc-player-removed-waitlist = Sinut poistettiin questin {"**"}{ $questTitle }{"**"} jonotuslistalta.
gm-dm-title-party-promotion = Ylennys ryhmään
gm-dm-desc-party-promotion =
    Sinut on ylennetty pääryhmään questissa {"**"}{ $questTitle }{"**"}
    koska pelaaja poistui questistä.
gm-dm-title-roster-locked = Ryhmä lukittu
gm-dm-desc-roster-locked =
    Questin {"**"}{ $questTitle }{"**"} ryhmä on lukittu
    ja kaikille ryhmän jäsenille on ilmoitettu.
gm-dm-title-roster-unlocked = Ryhmä avattu
gm-dm-desc-roster-unlocked = Questin {"**"}{ $questTitle }{"**"} ryhmän lukitus on avattu.
gm-dm-title-player-removed-confirm = Pelaaja poistettu
gm-dm-desc-player-removed-confirm =
    Pelaaja on poistettu questistä {"**"}{ $questTitle }{"**"}
    ja questin ryhmä on päivitetty.
gm-dm-footer-quest = Quest-ID: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    Palvelimesi ylläpitäjä on määrittänyt palkintoja pelinjohtajille questien suorittamisesta.
    Koska sinulla ei kuitenkaan ole rekisteröityjä hahmoja, palkkioitasi ei voitu
    myöntää automaattisesti tällä hetkellä.
gm-dm-rewards-no-active-character =
    Palvelimesi ylläpitäjä on määrittänyt palkintoja pelinjohtajille questien suorittamisesta.
    Koska sinulla ei kuitenkaan ole aktiivista hahmoa tällä palvelimella, palkkioitasi
    ei voitu myöntää automaattisesti tällä hetkellä.
gm-dm-rewards-issued = Seuraavat on myönnetty aktiiviselle hahmollesi, { $characterName }
gm-dm-role-removal-failed =
    ⚠️ Roolia {"**"}{ $roleName }{"**"} ei voitu poistaa seuraavilta jäseniltä: { $members }.
    Ilmoita palvelimen ylläpitäjälle roolin manuaalista poistoa varten.
gm-dm-role-not-found =
    ⚠️ Questin {"**"}{ $questTitle }{"**"} quest-roolia (ID: { $roleId }) ei enää löydy palvelimelta.
    Roolitoiminnot ohitettiin. Ilmoita palvelimen ylläpitäjälle, jos tämä on odottamatonta.

# GM select menus
gm-select-placeholder-party-member = Valitse ryhmän jäsen
gm-select-option-no-role = Ei mitään (Ei ryhmäroolia)

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

# GM views
gm-title-main-menu = Pelinjohtaja - Päävalikko
gm-menu-quests = Questit
gm-menu-desc-quests = Luo, muokkaa ja hallinnoi questejä.
gm-menu-players = Pelaajat
gm-menu-desc-players = Hallinnoi pelaajien inventaarioita ja muokkaa hahmoja.

gm-title-quest-management = Pelinjohtaja - Questien hallinta
gm-desc-create-quest = Luo uusi quest.
gm-msg-no-quests = Questejä ei löytynyt.
gm-label-quest-locked = (Lukittu)
gm-label-quest-draft = (Luonnos)
gm-title-manage-quest = Hallinnoi questiä - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Muokkaa questin tietoja, kuten otsikkoa, kuvausta ja ryhmän kokoa.
gm-label-field-not-set = Ei asetettu
gm-label-description-not-set = Kuvausta ei ole asetettu
gm-label-current-party-size = {"**"}Ryhmän enimmäiskoko:{"**"} { $value }
gm-label-current-party-role = {"**"}Ryhmärooli:{"**"} { $value }
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

# GM approvals

gm-error-role-hierarchy = ReQuest ei voi hallita roolia "{ $roleName }" (ID: { $roleId }), koska se on palvelinhierarkiassa ReQuestin korkeimman roolin yläpuolella. Ota yhteyttä palvelimen ylläpitäjään siirtääksesi roolin ReQuestin roolin alapuolelle tai antaaksesi ReQuestille korkeamman roolin, ja yritä sitten uudelleen.
