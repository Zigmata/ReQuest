## Stringhe del modulo Admin

# Cog admin
admin-embed-title-unauthorized = Server non autorizzato
admin-embed-desc-unauthorized =
    Grazie per il tuo interesse in ReQuest! Il tuo server non è nella lista dei server di test autorizzati di ReQuest.
    Unisciti al Discord di supporto qui sotto e contatta il team di sviluppo per richiedere l'accesso al test.

    [Discord di sviluppo di ReQuest](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = I seguenti comandi sono stati sincronizzati con { $guildName }, ID { $guildId }
admin-embed-title-sync-global = I seguenti comandi sono stati sincronizzati globalmente
admin-error-missing-scope = ReQuest non ha lo scope corretto nel server di destinazione. Aggiungi il permesso `applications.commands` e riprova.
admin-error-sync-failed = Si è verificato un errore durante la sincronizzazione dei comandi: { $error }
admin-msg-commands-cleared = Comandi cancellati.

# Pulsanti admin
admin-btn-shutdown = Spegni
admin-modal-title-confirm-shutdown = Conferma spegnimento
admin-modal-label-shutdown-warning = Attenzione! Questo spegnerà il bot. Digita CONFIRM per procedere.
admin-msg-shutting-down = Spegnimento in corso!
admin-btn-add-server = Aggiungi nuovo server
admin-btn-load-cog = Carica Cog
admin-msg-extension-loaded = Estensione caricata con successo: `{ $module }`
admin-btn-reload-cog = Ricarica Cog
admin-msg-extension-reloaded = Estensione ricaricata con successo: `{ $module }`
admin-btn-output-guilds = Esporta lista server
admin-msg-connected-guilds = Connesso a { $count } server:

# Modali admin
admin-modal-title-add-server = Aggiungi ID server alla lista consentiti
admin-modal-label-server-name = Nome del server
admin-modal-placeholder-server-name = Inserisci un nome breve per il server Discord
admin-modal-label-server-id = ID del server
admin-modal-placeholder-server-id = Inserisci l'ID del server Discord
admin-select-placeholder-server = Seleziona un server da rimuovere
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = Nome
admin-modal-placeholder-cog-name = Inserisci il nome del Cog da { $action }

# Viste admin
admin-title-main-menu = Amministrazione - Menu principale
admin-desc-allowlist = Configura la lista consentiti dei server per le restrizioni sugli inviti.
admin-desc-cogs = Carica o ricarica i cog.
admin-desc-guild-list = Restituisce una lista di tutti i server di cui il bot è membro.
admin-desc-shutdown = Spegne il bot
admin-title-allowlist = Amministrazione - Lista server consentiti
admin-desc-allowlist-warning =
    Aggiungi un nuovo ID server Discord alla lista consentiti.
    {"**"}ATTENZIONE: Non c'è modo di verificare che l'ID server fornito sia valido senza che il bot sia membro del server. Controlla bene i tuoi input!{"**"}
admin-msg-no-servers = Nessun server nella lista consentiti.

# Modali di conferma admin
admin-modal-title-confirm-server-removal = Conferma rimozione server
admin-modal-label-server-removal = Rimuovere il server dalla lista consentiti?

# Vista cog admin
admin-title-cogs = Amministrazione - Cog
admin-desc-load-cog = Carica un cog del bot per nome. Il file deve chiamarsi `<nome>.py` e trovarsi in ReQuest\cogs\.
admin-desc-reload-cog = Ricarica un cog caricato per nome. Stesse restrizioni di nome e percorso file.
