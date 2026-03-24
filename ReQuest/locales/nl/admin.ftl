## Admin module strings

# Admin cog
admin-embed-title-unauthorized = Ongeautoriseerde server
admin-embed-desc-unauthorized =
    Bedankt voor je interesse in ReQuest! Je server staat niet op de lijst met geautoriseerde testservers.
    Sluit je aan bij de support Discord hieronder en neem contact op met het ontwikkelteam om testtoegang aan te vragen.

    [ReQuest Development Discord](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = De volgende commando's zijn gesynchroniseerd met { $guildName }, ID { $guildId }
admin-embed-title-sync-global = De volgende commando's zijn globaal gesynchroniseerd
admin-error-missing-scope = ReQuest heeft niet het juiste bereik in de doelserver. Voeg de machtiging `applications.commands` toe en probeer het opnieuw.
admin-error-sync-failed = Er is een fout opgetreden bij het synchroniseren van commando's: { $error }
admin-msg-commands-cleared = Commando's gewist.

# Admin buttons
admin-btn-shutdown = Afsluiten
admin-modal-title-confirm-shutdown = Bevestig afsluiting
admin-modal-label-shutdown-warning = Waarschuwing! Dit zal de bot afsluiten. Typ BEVESTIG om door te gaan.
admin-msg-shutting-down = Wordt afgesloten!
admin-btn-add-server = Nieuwe server toevoegen
admin-btn-load-cog = Cog laden
admin-msg-extension-loaded = Extensie succesvol geladen: `{ $module }`
admin-btn-reload-cog = Cog herladen
admin-msg-extension-reloaded = Extensie succesvol herladen: `{ $module }`
admin-btn-output-guilds = Serverlijst weergeven
admin-msg-connected-guilds = Verbonden met { $count } servers:

# Admin modals
admin-modal-title-add-server = Server-ID toevoegen aan de toelatingslijst
admin-modal-label-server-name = Servernaam
admin-modal-placeholder-server-name = Typ een korte naam voor de Discord-server
admin-modal-label-server-id = Server-ID
admin-modal-placeholder-server-id = Typ het ID van de Discord-server
admin-select-placeholder-server = Selecteer een server om te verwijderen
admin-modal-title-cog-action = Cog { $action }
admin-modal-label-cog-name = Naam
admin-modal-placeholder-cog-name = Voer de naam van de Cog in om te { $action }

# Admin views
admin-title-main-menu = Beheer - Hoofdmenu
admin-desc-allowlist = Configureer de server-toelatingslijst voor uitnodigingsbeperkingen.
admin-desc-cogs = Cogs laden of herladen.
admin-desc-guild-list = Geeft een lijst van alle servers waarvan de bot lid is.
admin-desc-shutdown = Sluit de bot af
admin-title-allowlist = Beheer - Server-toelatingslijst
admin-desc-allowlist-warning =
    Voeg een nieuw Discord Server-ID toe aan de toelatingslijst.
    {"**"}WAARSCHUWING: Er is geen manier om te verifiëren of het opgegeven server-ID geldig is zonder dat de bot lid is van de server. Controleer je invoer!{"**"}
admin-msg-no-servers = Geen servers op de toelatingslijst.

# Admin confirm modals
admin-modal-title-confirm-server-removal = Bevestig serververwijdering
admin-modal-label-server-removal = Server van de toelatingslijst verwijderen?

# Admin cog view
admin-title-cogs = Beheer - Cogs
admin-desc-load-cog = Laad een bot-cog op naam. Bestand moet `<naam>.py` heten en opgeslagen zijn in ReQuest/cogs/.
admin-desc-reload-cog = Herlaad een geladen cog op naam. Dezelfde naamgevings- en bestandspadbeperkingen gelden.
