## Admin module strings

# Admin cog
admin-embed-title-unauthorized = Uautoriseret server
admin-embed-desc-unauthorized =
    Tak for din interesse i ReQuest! Din server er ikke på ReQuests liste over autoriserede testservere.
    Tilslut dig venligst support-Discorden nedenfor, og kontakt udviklingsteamet for at anmode om testadgang.

    [ReQuest Development Discord](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Følgende kommandoer blev synkroniseret til { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Følgende kommandoer blev synkroniseret globalt
admin-error-missing-scope = ReQuest har ikke det korrekte scope i målserveren. Tilføj tilladelsen `applications.commands` og prøv igen.
admin-error-sync-failed = Der opstod en fejl under synkronisering af kommandoer: { $error }
admin-msg-commands-cleared = Kommandoer ryddet.

# Admin buttons
admin-btn-shutdown = Luk ned
admin-modal-title-confirm-shutdown = Bekræft nedlukning
admin-modal-label-shutdown-warning = Advarsel! Dette vil lukke botten ned. Skriv CONFIRM for at fortsætte.
admin-msg-shutting-down = Lukker ned!
admin-btn-add-server = Tilføj ny server
admin-btn-load-cog = Indlæs Cog
admin-msg-extension-loaded = Udvidelse indlæst: `{ $module }`
admin-btn-reload-cog = Genindlæs Cog
admin-msg-extension-reloaded = Udvidelse genindlæst: `{ $module }`
admin-btn-output-guilds = Vis serverliste
admin-msg-connected-guilds = Forbundet til { $count } servere:

# Admin modals
admin-modal-title-add-server = Tilføj server-ID til tilladelsesliste
admin-modal-label-server-name = Servernavn
admin-modal-placeholder-server-name = Skriv et kort navn til Discord-serveren
admin-modal-label-server-id = Server-ID
admin-modal-placeholder-server-id = Skriv Discord-serverens ID
admin-select-placeholder-server = Vælg en server at fjerne
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = Navn
admin-modal-placeholder-cog-name = Indtast navnet på den Cog der skal { $action }

# Admin views
admin-title-main-menu = Administration - Hovedmenu
admin-desc-allowlist = Konfigurer serverens tilladelsesliste for invitationsbegrænsninger.
admin-desc-cogs = Indlæs eller genindlæs cogs.
admin-desc-guild-list = Returnerer en liste over alle servere, som botten er medlem af.
admin-desc-shutdown = Lukker botten ned
admin-title-allowlist = Administration - Servertilladelsesliste
admin-desc-allowlist-warning =
    Tilføj et nyt Discord-server-ID til tilladelseslisten.
    {"**"}ADVARSEL: Der er ingen måde at verificere, at det angivne server-ID er gyldigt, uden at botten er medlem af serveren. Dobbelttjek dine indtastninger!{"**"}
admin-msg-no-servers = Ingen servere på tilladelseslisten.

# Admin confirm modals
admin-modal-title-confirm-server-removal = Bekræft serverfjernelse
admin-modal-label-server-removal = Fjern server fra tilladelseslisten?

# Admin cog view
admin-title-cogs = Administration - Cogs
admin-desc-load-cog = Indlæs en bot-cog efter navn. Filen skal hedde `<navn>.py` og ligge i ReQuest\cogs\.
admin-desc-reload-cog = Genindlæs en indlæst cog efter navn. Samme navngivnings- og filstibegrænsninger gælder.
