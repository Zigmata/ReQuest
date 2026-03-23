## Admin module strings

# Admin cog
admin-embed-title-unauthorized = Obehörig server
admin-embed-desc-unauthorized =
    Tack för ditt intresse för ReQuest! Din server finns inte i ReQuests lista över godkända testservrar.
    Gå med i support-Discord nedan och kontakta utvecklingsteamet för att begära teståtkomst.

    [ReQuest Development Discord](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Följande kommandon synkroniserades till { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Följande kommandon synkroniserades globalt
admin-error-missing-scope = ReQuest har inte rätt behörigheter i målservern. Lägg till behörigheten `applications.commands` och försök igen.
admin-error-sync-failed = Det uppstod ett fel vid synkronisering av kommandon: { $error }
admin-msg-commands-cleared = Kommandon rensade.

# Admin buttons
admin-btn-shutdown = Stäng av
admin-modal-title-confirm-shutdown = Bekräfta avstängning
admin-modal-label-shutdown-warning = Varning! Detta stänger av boten. Skriv CONFIRM för att fortsätta.
admin-msg-shutting-down = Stänger av!
admin-btn-add-server = Lägg till ny server
admin-btn-load-cog = Ladda Cog
admin-msg-extension-loaded = Tillägg har laddats: `{ $module }`
admin-btn-reload-cog = Ladda om Cog
admin-msg-extension-reloaded = Tillägg har laddats om: `{ $module }`
admin-btn-output-guilds = Visa serverlista
admin-msg-connected-guilds = Ansluten till { $count } servrar:

# Admin modals
admin-modal-title-add-server = Lägg till server-ID i godkännandelistan
admin-modal-label-server-name = Servernamn
admin-modal-placeholder-server-name = Ange ett kort namn för Discord-servern
admin-modal-label-server-id = Server-ID
admin-modal-placeholder-server-id = Ange ID för Discord-servern
admin-select-placeholder-server = Välj en server att ta bort
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = Namn
admin-modal-placeholder-cog-name = Ange namnet på den Cog som ska { $action }

# Admin views
admin-title-main-menu = Administration - Huvudmeny
admin-desc-allowlist = Konfigurera serverns godkännandelista för inbjudningsbegränsningar.
admin-desc-cogs = Ladda eller ladda om cogs.
admin-desc-guild-list = Returnerar en lista över alla servrar boten är medlem i.
admin-desc-shutdown = Stänger av boten
admin-title-allowlist = Administration - Serverns godkännandelista
admin-desc-allowlist-warning =
    Lägg till ett nytt Discord-server-ID i godkännandelistan.
    {"**"}VARNING: Det finns inget sätt att verifiera att det angivna server-ID:t är giltigt utan att boten är servermedlem. Dubbelkolla dina uppgifter!{"**"}
admin-msg-no-servers = Inga servrar i godkännandelistan.

# Admin confirm modals
admin-modal-title-confirm-server-removal = Bekräfta borttagning av server
admin-modal-label-server-removal = Ta bort server från godkännandelistan?

# Admin cog view
admin-title-cogs = Administration - Cogs
admin-desc-load-cog = Ladda en bot-cog med namn. Filen måste heta `<namn>.py` och lagras i ReQuest/cogs/.
admin-desc-reload-cog = Ladda om en laddad cog med namn. Samma namngivning och filsökväg gäller.
