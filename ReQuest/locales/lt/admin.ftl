## Admin module strings

# Admin cog
admin-embed-title-unauthorized = Neautorizuotas serveris
admin-embed-desc-unauthorized =
    Dėkojame už susidomėjimą ReQuest! Jūsų serveris nėra ReQuest autorizuotų testavimo serverių sąraše.
    Prisijunkite prie palaikymo Discord ir susisiekite su kūrėjų komanda, kad paprašytumėte prieigos testavimui.

    [ReQuest kūrėjų Discord](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Šios komandos buvo sinchronizuotos su { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Šios komandos buvo sinchronizuotos globaliai
admin-error-missing-scope = ReQuest neturi teisingų teisių tiksliniame serveryje. Pridėkite `applications.commands` leidimą ir bandykite dar kartą.
admin-error-sync-failed = Įvyko klaida sinchronizuojant komandas: { $error }
admin-msg-commands-cleared = Komandos išvalytos.

# Admin buttons
admin-btn-shutdown = Išjungti
admin-modal-title-confirm-shutdown = Patvirtinti išjungimą
admin-modal-label-shutdown-warning = Dėmesio! Tai išjungs botą. Įveskite PATVIRTINTI, kad tęstumėte.
admin-msg-shutting-down = Išsijungiama!
admin-btn-add-server = Pridėti naują serverį
admin-btn-load-cog = Įkelti Cog
admin-msg-extension-loaded = Plėtinys sėkmingai įkeltas: `{ $module }`
admin-btn-reload-cog = Perkrauti Cog
admin-msg-extension-reloaded = Plėtinys sėkmingai perkrautas: `{ $module }`
admin-btn-output-guilds = Išvesti serverių sąrašą
admin-msg-connected-guilds = Prisijungta prie { $count } serverių:

# Admin modals
admin-modal-title-add-server = Pridėti serverio ID į leidžiamų sąrašą
admin-modal-label-server-name = Serverio pavadinimas
admin-modal-placeholder-server-name = Įveskite trumpą Discord serverio pavadinimą
admin-modal-label-server-id = Serverio ID
admin-modal-placeholder-server-id = Įveskite Discord serverio ID
admin-select-placeholder-server = Pasirinkite serverį, kurį norite pašalinti
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = Pavadinimas
admin-modal-placeholder-cog-name = Įveskite Cog pavadinimą, kurį norite { $action }

# Admin views
admin-title-main-menu = Administravimas - Pagrindinis meniu
admin-desc-allowlist = Konfigūruoti serverių leidžiamų sąrašą kvietimų apribojimams.
admin-desc-cogs = Įkelti arba perkrauti cog modulius.
admin-desc-guild-list = Grąžina visų serverių, kuriuose botas yra narys, sąrašą.
admin-desc-shutdown = Išjungia botą
admin-title-allowlist = Administravimas - Serverių leidžiamų sąrašas
admin-desc-allowlist-warning =
    Pridėti naują Discord serverio ID į leidžiamų sąrašą.
    {"**"}DĖMESIO: Nėra būdo patikrinti, ar pateiktas serverio ID yra galiojantis, kol botas nėra serverio narys. Dar kartą patikrinkite savo įvestį!{"**"}
admin-msg-no-servers = Leidžiamų sąraše nėra serverių.

# Admin confirm modals
admin-modal-title-confirm-server-removal = Patvirtinti serverio pašalinimą
admin-modal-label-server-removal = Pašalinti serverį iš leidžiamų sąrašo?

# Admin cog view
admin-title-cogs = Administravimas - Cog moduliai
admin-desc-load-cog = Įkelti boto cog modulį pagal pavadinimą. Failas turi būti pavadintas `<pavadinimas>.py` ir saugomas ReQuest/cogs/.
admin-desc-reload-cog = Perkrauti įkeltą cog modulį pagal pavadinimą. Tie patys pavadinimo ir failo kelio apribojimai taikomi.
