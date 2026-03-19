## Admin module strings

# Admin cog
admin-embed-title-unauthorized = Neautorizovaný server
admin-embed-desc-unauthorized =
    Děkujeme za váš zájem o ReQuest! Váš server není v seznamu autorizovaných testovacích serverů ReQuestu.
    Připojte se prosím k Discord serveru podpory níže a kontaktujte vývojový tým pro žádost o testovací přístup.

    [Discord pro vývoj ReQuestu](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Následující příkazy byly synchronizovány na { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Následující příkazy byly synchronizovány globálně
admin-error-missing-scope = ReQuest nemá správný rozsah oprávnění v cílovém serveru. Přidejte oprávnění `applications.commands` a zkuste to znovu.
admin-error-sync-failed = Při synchronizaci příkazů došlo k chybě: { $error }
admin-msg-commands-cleared = Příkazy vymazány.

# Admin buttons
admin-btn-shutdown = Vypnout
admin-modal-title-confirm-shutdown = Potvrdit vypnutí
admin-modal-label-shutdown-warning = Varování! Tím se bot vypne. Napište CONFIRM pro pokračování.
admin-msg-shutting-down = Vypínám!
admin-btn-add-server = Přidat nový server
admin-btn-load-cog = Načíst Cog
admin-msg-extension-loaded = Rozšíření úspěšně načteno: `{ $module }`
admin-btn-reload-cog = Znovu načíst Cog
admin-msg-extension-reloaded = Rozšíření úspěšně znovu načteno: `{ $module }`
admin-btn-output-guilds = Vypsat seznam serverů
admin-msg-connected-guilds = Připojeno k { $count } serverům:

# Admin modals
admin-modal-title-add-server = Přidat ID serveru na seznam povolených
admin-modal-label-server-name = Název serveru
admin-modal-placeholder-server-name = Zadejte krátký název Discord serveru
admin-modal-label-server-id = ID serveru
admin-modal-placeholder-server-id = Zadejte ID Discord serveru
admin-select-placeholder-server = Vyberte server k odebrání
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = Název
admin-modal-placeholder-cog-name = Zadejte název Cogu pro { $action }

# Admin views
admin-title-main-menu = Administrace - Hlavní menu
admin-desc-allowlist = Nakonfigurujte seznam povolených serverů pro omezení pozvánek.
admin-desc-cogs = Načtěte nebo znovu načtěte cogy.
admin-desc-guild-list = Vrátí seznam všech serverů, na kterých je bot členem.
admin-desc-shutdown = Vypne bota
admin-title-allowlist = Administrace - Seznam povolených serverů
admin-desc-allowlist-warning =
    Přidejte nové ID Discord serveru na seznam povolených.
    {"**"}VAROVÁNÍ: Neexistuje způsob, jak ověřit, zda je zadané ID serveru platné, aniž by bot byl členem serveru. Zkontrolujte si své vstupy!{"**"}
admin-msg-no-servers = Žádné servery na seznamu povolených.

# Admin confirm modals
admin-modal-title-confirm-server-removal = Potvrdit odebrání serveru
admin-modal-label-server-removal = Odebrat server ze seznamu povolených?

# Admin cog view
admin-title-cogs = Administrace - Cogy
admin-desc-load-cog = Načtěte cog bota podle názvu. Soubor musí mít název `<název>.py` a být uložen v ReQuest\cogs\.
admin-desc-reload-cog = Znovu načtěte načtený cog podle názvu. Platí stejná omezení pro název a cestu k souboru.
