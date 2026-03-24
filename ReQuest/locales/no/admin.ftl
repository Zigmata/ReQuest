## Admin module strings

# Admin cog
admin-embed-title-unauthorized = Uautorisert server
admin-embed-desc-unauthorized =
    Takk for din interesse for ReQuest! Serveren din er ikke på ReQuests liste over autoriserte testservere.
    Vennligst bli med i support-Discorden nedenfor, og kontakt utviklerteamet for å be om testtilgang.

    [ReQuest Development Discord](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Følgende kommandoer ble synkronisert til { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Følgende kommandoer ble synkronisert globalt
admin-error-missing-scope = ReQuest har ikke riktig scope i målserveren. Legg til `applications.commands`-tillatelsen og prøv igjen.
admin-error-sync-failed = Det oppstod en feil ved synkronisering av kommandoer: { $error }
admin-msg-commands-cleared = Kommandoer slettet.

# Admin buttons
admin-btn-shutdown = Slå av
admin-modal-title-confirm-shutdown = Bekreft avslutning
admin-modal-label-shutdown-warning = Advarsel! Dette vil slå av boten. Skriv BEKREFT for å fortsette.
admin-msg-shutting-down = Slår av!
admin-btn-add-server = Legg til ny server
admin-btn-load-cog = Last inn Cog
admin-msg-extension-loaded = Utvidelse lastet inn: `{ $module }`
admin-btn-reload-cog = Last inn Cog på nytt
admin-msg-extension-reloaded = Utvidelse lastet inn på nytt: `{ $module }`
admin-btn-output-guilds = Vis serverliste
admin-msg-connected-guilds = Koblet til { $count } servere:

# Admin modals
admin-modal-title-add-server = Legg til server-ID i godkjenningslisten
admin-modal-label-server-name = Servernavn
admin-modal-placeholder-server-name = Skriv inn et kort navn for Discord-serveren
admin-modal-label-server-id = Server-ID
admin-modal-placeholder-server-id = Skriv inn IDen til Discord-serveren
admin-select-placeholder-server = Velg en server å fjerne
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = Navn
admin-modal-placeholder-cog-name = Skriv inn navnet på Cogen som skal { $action }

# Admin views
admin-title-main-menu = Administrasjon - Hovedmeny
admin-desc-allowlist = Konfigurer serverens godkjenningsliste for invitasjonsrestriksjoner.
admin-desc-cogs = Last inn eller last inn coger på nytt.
admin-desc-guild-list = Returnerer en liste over alle servere boten er medlem av.
admin-desc-shutdown = Slår av boten
admin-title-allowlist = Administrasjon - Godkjenningsliste
admin-desc-allowlist-warning =
    Legg til en ny Discord-server-ID i godkjenningslisten.
    {"**"}ADVARSEL: Det finnes ingen måte å verifisere at den oppgitte server-IDen er gyldig uten at boten er servermedlem. Dobbeltsjekk inndataene dine!{"**"}
admin-msg-no-servers = Ingen servere i godkjenningslisten.

# Admin confirm modals
admin-modal-title-confirm-server-removal = Bekreft fjerning av server
admin-modal-label-server-removal = Fjerne server fra godkjenningslisten?

# Admin cog view
admin-title-cogs = Administrasjon - Coger
admin-desc-load-cog = Last inn en bot-cog etter navn. Filen må hete `<navn>.py` og lagres i ReQuest/cogs/.
admin-desc-reload-cog = Last inn en lastet cog på nytt etter navn. Samme navngivnings- og filstibegrensninger gjelder.
