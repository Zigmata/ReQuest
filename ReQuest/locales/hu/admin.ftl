## Admin module strings

# Admin cog
admin-embed-title-unauthorized = Nem engedélyezett szerver
admin-embed-desc-unauthorized =
    Köszönjük az érdeklődésedet a ReQuest iránt! A szervered nem szerepel a ReQuest engedélyezett tesztszervereinek listáján.
    Kérjük, csatlakozz az alábbi Discord szerverhez, és kérd a fejlesztőcsapatot a teszthozzáférésért.

    [ReQuest Fejlesztői Discord](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = A következő parancsok szinkronizálva lettek a(z) { $guildName } szerverre, ID: { $guildId }
admin-embed-title-sync-global = A következő parancsok globálisan szinkronizálva lettek
admin-error-missing-scope = A ReQuest nem rendelkezik a megfelelő hatókörrel a célszerveren. Add hozzá az `applications.commands` jogosultságot, és próbáld újra.
admin-error-sync-failed = Hiba történt a parancsok szinkronizálása során: { $error }
admin-msg-commands-cleared = Parancsok törölve.

# Admin buttons
admin-btn-shutdown = Leállítás
admin-modal-title-confirm-shutdown = Leállítás megerősítése
admin-modal-label-shutdown-warning = Figyelem! Ez leállítja a botot. Írd be: MEGERŐSÍT a folytatáshoz.
admin-msg-shutting-down = Leállítás folyamatban!
admin-btn-add-server = Új szerver hozzáadása
admin-btn-load-cog = Cog betöltése
admin-msg-extension-loaded = Bővítmény sikeresen betöltve: `{ $module }`
admin-btn-reload-cog = Cog újratöltése
admin-msg-extension-reloaded = Bővítmény sikeresen újratöltve: `{ $module }`
admin-btn-output-guilds = Szerverlista kiírása
admin-msg-connected-guilds = Csatlakozva { $count } szerverhez:

# Admin modals
admin-modal-title-add-server = Szerver ID hozzáadása az engedélyezési listához
admin-modal-label-server-name = Szerver neve
admin-modal-placeholder-server-name = Írj be egy rövid nevet a Discord szervernek
admin-modal-label-server-id = Szerver ID
admin-modal-placeholder-server-id = Írd be a Discord szerver ID-ját
admin-modal-title-cog-action = Cog { $action }
admin-modal-label-cog-name = Név
admin-modal-placeholder-cog-name = Add meg a Cog nevét a(z) { $action } művelethez

# Admin views
admin-title-main-menu = Adminisztráció - Főmenü
admin-desc-allowlist = Az engedélyezési lista konfigurálása meghívási korlátozásokhoz.
admin-desc-cogs = Cogok betöltése vagy újratöltése.
admin-desc-guild-list = A bot által tagolt összes szerver listáját adja vissza.
admin-desc-shutdown = Leállítja a botot
admin-title-allowlist = Adminisztráció - Szerver engedélyezési lista
admin-desc-allowlist-warning =
    Új Discord szerver ID hozzáadása az engedélyezési listához.
    {"**"}FIGYELEM: A megadott szerver ID érvényességét nem lehet ellenőrizni, amíg a bot nem tagja a szervernek. Ellenőrizd kétszer a bevitt adatokat!{"**"}
admin-msg-no-servers = Nincsenek szerverek az engedélyezési listán.

# Admin confirm modals
admin-modal-title-confirm-server-removal = Szerver eltávolításának megerősítése
admin-modal-label-server-removal = Eltávolítod a szervert az engedélyezési listáról?

# Admin cog view
admin-title-cogs = Adminisztráció - Cogok
admin-desc-load-cog = Bot cog betöltése név alapján. A fájlnak `<név>.py` nevűnek kell lennie, és a ReQuest/cogs/ mappában kell lennie.
admin-desc-reload-cog = Betöltött cog újratöltése név alapján. Ugyanazok az elnevezési és fájlútvonal-korlátozások érvényesek.
