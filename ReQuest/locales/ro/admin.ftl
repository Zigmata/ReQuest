## Admin module strings

# Admin cog
admin-embed-title-unauthorized = Server neautorizat
admin-embed-desc-unauthorized =
    Vă mulțumim pentru interesul față de ReQuest! Serverul dumneavoastră nu se află în lista de servere de testare autorizate pentru ReQuest.
    Vă rugăm să vă alăturați Discordului de suport de mai jos și să contactați echipa de dezvoltare pentru a solicita acces la testare.

    [Discord de Dezvoltare ReQuest](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Următoarele comenzi au fost sincronizate cu { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Următoarele comenzi au fost sincronizate global
admin-error-missing-scope = ReQuest nu are domeniul corect pe serverul vizat. Adăugați permisiunea `applications.commands` și încercați din nou.
admin-error-sync-failed = A apărut o eroare la sincronizarea comenzilor: { $error }
admin-msg-commands-cleared = Comenzile au fost șterse.

# Admin buttons
admin-btn-shutdown = Oprire
admin-modal-title-confirm-shutdown = Confirmă oprirea
admin-modal-label-shutdown-warning = Atenție! Acest lucru va opri botul. Tastați CONFIRM pentru a continua.
admin-msg-shutting-down = Se oprește!
admin-btn-add-server = Adaugă server nou
admin-btn-load-cog = Încarcă modul
admin-msg-extension-loaded = Extensia a fost încărcată cu succes: `{ $module }`
admin-btn-reload-cog = Reîncarcă modul
admin-msg-extension-reloaded = Extensia a fost reîncărcată cu succes: `{ $module }`
admin-btn-output-guilds = Afișează lista serverelor
admin-msg-connected-guilds = Conectat la { $count } servere:

# Admin modals
admin-modal-title-add-server = Adaugă ID server în lista permisă
admin-modal-label-server-name = Numele serverului
admin-modal-placeholder-server-name = Introduceți un nume scurt pentru serverul Discord
admin-modal-label-server-id = ID-ul serverului
admin-modal-placeholder-server-id = Introduceți ID-ul serverului Discord
admin-select-placeholder-server = Selectați un server de eliminat
admin-modal-title-cog-action = { $action } modul
admin-modal-label-cog-name = Nume
admin-modal-placeholder-cog-name = Introduceți numele modulului pentru { $action }

# Admin views
admin-title-main-menu = Administrare - Meniu principal
admin-desc-allowlist = Configurați lista de servere permise pentru restricțiile de invitare.
admin-desc-cogs = Încărcați sau reîncărcați module.
admin-desc-guild-list = Returnează o listă cu toate serverele de care botul este membru.
admin-desc-shutdown = Oprește botul
admin-title-allowlist = Administrare - Lista de servere permise
admin-desc-allowlist-warning =
    Adăugați un nou ID de server Discord în lista permisă.
    {"**"}ATENȚIE: Nu există nicio modalitate de a verifica dacă ID-ul serverului furnizat este valid fără ca botul să fie membru al serverului. Verificați-vă datele introduse!{"**"}
admin-msg-no-servers = Niciun server în lista permisă.

# Admin confirm modals
admin-modal-title-confirm-server-removal = Confirmă eliminarea serverului
admin-modal-label-server-removal = Eliminați serverul din lista permisă?

# Admin cog view
admin-title-cogs = Administrare - Module
admin-desc-load-cog = Încarcă un modul al botului după nume. Fișierul trebuie să se numească `<nume>.py` și să fie stocat în ReQuest\cogs\.
admin-desc-reload-cog = Reîncarcă un modul încărcat după nume. Aceleași restricții de denumire și cale se aplică.
