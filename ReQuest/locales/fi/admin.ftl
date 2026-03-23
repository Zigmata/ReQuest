## Admin module strings

# Admin cog
admin-embed-title-unauthorized = Valtuuttamaton palvelin
admin-embed-desc-unauthorized =
    Kiitos kiinnostuksestasi ReQuestia kohtaan! Palvelimesi ei ole ReQuestin valtuutettujen testipalvelimien listalla.
    Liity alla olevaan tuki-Discordiin ja ota yhteyttä kehitystiimiin pyytääksesi testipääsyä.

    [ReQuest-kehitys-Discord](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Seuraavat komennot synkronoitiin palvelimelle { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Seuraavat komennot synkronoitiin globaalisti
admin-error-missing-scope = ReQuestilla ei ole oikeaa laajuutta kohdepalvelimella. Lisää `applications.commands`-oikeus ja yritä uudelleen.
admin-error-sync-failed = Komentojen synkronoinnissa tapahtui virhe: { $error }
admin-msg-commands-cleared = Komennot tyhjennetty.

# Admin buttons
admin-btn-shutdown = Sammuta
admin-modal-title-confirm-shutdown = Vahvista sammutus
admin-modal-label-shutdown-warning = Varoitus! Tämä sammuttaa botin. Kirjoita CONFIRM jatkaaksesi.
admin-msg-shutting-down = Sammutetaan!
admin-btn-add-server = Lisää uusi palvelin
admin-btn-load-cog = Lataa Cog
admin-msg-extension-loaded = Laajennus ladattu onnistuneesti: `{ $module }`
admin-btn-reload-cog = Lataa Cog uudelleen
admin-msg-extension-reloaded = Laajennus ladattu uudelleen onnistuneesti: `{ $module }`
admin-btn-output-guilds = Tulosta palvelinlista
admin-msg-connected-guilds = Yhdistetty { $count } palvelimeen:

# Admin modals
admin-modal-title-add-server = Lisää palvelin-ID sallittujen listalle
admin-modal-label-server-name = Palvelimen nimi
admin-modal-placeholder-server-name = Kirjoita lyhyt nimi Discord-palvelimelle
admin-modal-label-server-id = Palvelimen ID
admin-modal-placeholder-server-id = Kirjoita Discord-palvelimen ID
admin-select-placeholder-server = Valitse poistettava palvelin
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = Nimi
admin-modal-placeholder-cog-name = Syötä Cogin nimi, joka { $action }

# Admin views
admin-title-main-menu = Hallinta - Päävalikko
admin-desc-allowlist = Määritä palvelimen sallittujen lista kutsurajoituksia varten.
admin-desc-cogs = Lataa tai lataa uudelleen cogeja.
admin-desc-guild-list = Palauttaa listan kaikista palvelimista, joiden jäsen botti on.
admin-desc-shutdown = Sammuttaa botin
admin-title-allowlist = Hallinta - Palvelimen sallittujen lista
admin-desc-allowlist-warning =
    Lisää uusi Discord-palvelimen ID sallittujen listalle.
    {"**"}VAROITUS: Palvelimen ID:n oikeellisuutta ei voi tarkistaa, ellei botti ole palvelimen jäsen. Tarkista syötteesi!{"**"}
admin-msg-no-servers = Sallittujen listalla ei ole palvelimia.

# Admin confirm modals
admin-modal-title-confirm-server-removal = Vahvista palvelimen poisto
admin-modal-label-server-removal = Poistetaanko palvelin sallittujen listalta?

# Admin cog view
admin-title-cogs = Hallinta - Cogit
admin-desc-load-cog = Lataa botin cog nimellä. Tiedoston nimi on oltava `<nimi>.py` ja se on tallennettava ReQuest/cogs/ -kansioon.
admin-desc-reload-cog = Lataa ladattu cog uudelleen nimellä. Samat nimeämis- ja tiedostopolkurajoitukset pätevät.
