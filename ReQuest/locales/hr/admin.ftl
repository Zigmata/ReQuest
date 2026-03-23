## Admin module strings

# Admin cog
admin-embed-title-unauthorized = Neovlašteni poslužitelj
admin-embed-desc-unauthorized =
    Hvala na interesu za ReQuest! Vaš poslužitelj nije na popisu ovlaštenih testnih poslužitelja za ReQuest.
    Molimo pridružite se Discord poslužitelju za podršku u nastavku i kontaktirajte razvojni tim za pristup testiranju.

    [ReQuest Development Discord](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Sljedeće naredbe su sinkronizirane na { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Sljedeće naredbe su sinkronizirane globalno
admin-error-missing-scope = ReQuest nema ispravan opseg na ciljanom poslužitelju. Dodajte dozvolu `applications.commands` i pokušajte ponovo.
admin-error-sync-failed = Došlo je do greške pri sinkronizaciji naredbi: { $error }
admin-msg-commands-cleared = Naredbe obrisane.

# Admin buttons
admin-btn-shutdown = Isključi
admin-modal-title-confirm-shutdown = Potvrdi isključivanje
admin-modal-label-shutdown-warning = Upozorenje! Ovo će isključiti bota. Upišite CONFIRM za nastavak.
admin-msg-shutting-down = Isključujem!
admin-btn-add-server = Dodaj novi poslužitelj
admin-btn-load-cog = Učitaj Cog
admin-msg-extension-loaded = Proširenje uspješno učitano: `{ $module }`
admin-btn-reload-cog = Ponovno učitaj Cog
admin-msg-extension-reloaded = Proširenje uspješno ponovno učitano: `{ $module }`
admin-btn-output-guilds = Ispiši popis poslužitelja
admin-msg-connected-guilds = Povezano na { $count } poslužitelja:

# Admin modals
admin-modal-title-add-server = Dodaj ID poslužitelja na popis dopuštenih
admin-modal-label-server-name = Naziv poslužitelja
admin-modal-placeholder-server-name = Upišite kratki naziv za Discord poslužitelj
admin-modal-label-server-id = ID poslužitelja
admin-modal-placeholder-server-id = Upišite ID Discord poslužitelja
admin-select-placeholder-server = Odaberite poslužitelj za uklanjanje
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = Naziv
admin-modal-placeholder-cog-name = Unesite naziv Coga za { $action }

# Admin views
admin-title-main-menu = Administracija - Glavni izbornik
admin-desc-allowlist = Konfigurirajte popis dopuštenih poslužitelja za ograničenja pozivnica.
admin-desc-cogs = Učitajte ili ponovno učitajte cogove.
admin-desc-guild-list = Vraća popis svih poslužitelja čiji je bot član.
admin-desc-shutdown = Isključuje bota
admin-title-allowlist = Administracija - Popis dopuštenih poslužitelja
admin-desc-allowlist-warning =
    Dodajte novi ID Discord poslužitelja na popis dopuštenih.
    {"**"}UPOZORENJE: Ne postoji način za provjeru valjanosti danog ID-a poslužitelja bez da je bot član tog poslužitelja. Dvaput provjerite svoje unose!{"**"}
admin-msg-no-servers = Nema poslužitelja na popisu dopuštenih.

# Admin confirm modals
admin-modal-title-confirm-server-removal = Potvrdi uklanjanje poslužitelja
admin-modal-label-server-removal = Ukloniti poslužitelj s popisa dopuštenih?

# Admin cog view
admin-title-cogs = Administracija - Cogovi
admin-desc-load-cog = Učitajte cog bota po imenu. Datoteka mora biti nazvana `<ime>.py` i pohranjena u ReQuest/cogs/.
admin-desc-reload-cog = Ponovno učitajte učitani cog po imenu. Ista ograničenja naziva i putanje datoteke se primjenjuju.
