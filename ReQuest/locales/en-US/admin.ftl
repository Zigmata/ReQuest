## Admin module strings

# Admin cog
admin-embed-title-unauthorized = Unauthorized Server
admin-embed-desc-unauthorized =
    Thank you for your interest in ReQuest! Your server is not in ReQuest's list of authorized testing servers.
    Please join the support Discord below, and contact the development team to request test access.

    [ReQuest Development Discord](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = The following commands were synchronized to { $guildName }, ID { $guildId }
admin-embed-title-sync-global = The following commands were synchronized globally
admin-error-missing-scope = ReQuest does not have the correct scope in the target guild. Add `applications.commands` permission and try again.
admin-error-sync-failed = There was an error syncing commands: { $error }
admin-msg-commands-cleared = Commands cleared.

# Admin buttons
admin-btn-shutdown = Shutdown
admin-modal-title-confirm-shutdown = Confirm Shutdown
admin-modal-label-shutdown-warning = Warning! This will shut down the bot. Type CONFIRM to proceed.
admin-msg-shutting-down = Shutting down!
admin-btn-add-server = Add New Server
admin-btn-load-cog = Load Cog
admin-msg-extension-loaded = Extension successfully loaded: `{ $module }`
admin-btn-reload-cog = Reload Cog
admin-msg-extension-reloaded = Extension successfully reloaded: `{ $module }`
admin-btn-output-guilds = Output Guild List
admin-msg-connected-guilds = Connected to { $count } guilds:

# Admin modals
admin-modal-title-add-server = Add Server ID to Allowlist
admin-modal-label-server-name = Server Name
admin-modal-placeholder-server-name = Type a short name for the Discord Server
admin-modal-label-server-id = Server ID
admin-modal-placeholder-server-id = Type the ID of the Discord Server
admin-select-placeholder-server = Select a server to remove
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = Name
admin-modal-placeholder-cog-name = Enter the name of the Cog to { $action }

# Admin views
admin-title-main-menu = Administration - Main Menu
admin-desc-allowlist = Configure the server allowlist for invite restrictions.
admin-desc-cogs = Load or reload cogs.
admin-desc-guild-list = Returns a list of all guilds the bot is a member of.
admin-desc-shutdown = Shuts down the bot
admin-title-allowlist = Administration - Server Allowlist
admin-desc-allowlist-warning =
    Add a new Discord Server ID to the allowlist.
    {"**"}WARNING: There is no way to verify the server ID provided is valid without the bot being a server member. Double-check your inputs!{"**"}
admin-msg-no-servers = No servers in allowlist.

# Admin confirm modals
admin-modal-title-confirm-server-removal = Confirm Server Removal
admin-modal-label-server-removal = Remove server from allow list?

# Admin cog view
admin-title-cogs = Administration - Cogs
admin-desc-load-cog = Load a bot cog by name. File must be named `<name>.py` and stored in ReQuest\cogs\.
admin-desc-reload-cog = Reload a loaded cog by name. Same naming and file path restrictions apply.
