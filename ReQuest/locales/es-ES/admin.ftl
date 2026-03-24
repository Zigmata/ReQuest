## Cadenas del módulo de administración
# Cog de administración
admin-embed-title-unauthorized = Servidor no autorizado
admin-embed-desc-unauthorized =
    ¡Gracias por vuestro interés en ReQuest! Vuestro servidor no está en la lista de servidores de prueba autorizados de ReQuest.
    Uniros al Discord de soporte a continuación y contactad con el equipo de desarrollo para solicitar acceso de prueba.

    [Discord de desarrollo de ReQuest](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Los siguientes comandos se han sincronizado con { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Los siguientes comandos se han sincronizado globalmente
admin-error-missing-scope = ReQuest no tiene el ámbito correcto en el servidor objetivo. Añadid el permiso `applications.commands` e intentadlo de nuevo.
admin-error-sync-failed = Se ha producido un error al sincronizar los comandos: { $error }
admin-msg-commands-cleared = Comandos borrados.
# Botones de administración
admin-btn-shutdown = Apagar
admin-modal-title-confirm-shutdown = Confirmar apagado
admin-modal-label-shutdown-warning = ¡Aviso! Esto apagará el bot. Escribid CONFIRMAR para continuar.
admin-msg-shutting-down = ¡Apagando!
admin-btn-add-server = Añadir nuevo servidor
admin-btn-load-cog = Cargar Cog
admin-msg-extension-loaded = Extensión cargada correctamente: `{ $module }`
admin-btn-reload-cog = Recargar Cog
admin-msg-extension-reloaded = Extensión recargada correctamente: `{ $module }`
admin-btn-output-guilds = Listar servidores
admin-msg-connected-guilds = Conectado a { $count } servidores:
# Modales de administración
admin-modal-title-add-server = Añadir ID de servidor a la lista de permitidos
admin-modal-label-server-name = Nombre del servidor
admin-modal-placeholder-server-name = Escribid un nombre corto para el servidor de Discord
admin-modal-label-server-id = ID del servidor
admin-modal-placeholder-server-id = Escribid el ID del servidor de Discord
admin-select-placeholder-server = Seleccionad un servidor para eliminar
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = Nombre
admin-modal-placeholder-cog-name = Introducid el nombre del Cog para { $action }
# Vistas de administración
admin-title-main-menu = Administración - Menú principal
admin-desc-allowlist = Configurar la lista de servidores permitidos para restricciones de invitación.
admin-desc-cogs = Cargar o recargar cogs.
admin-desc-guild-list = Devuelve una lista de todos los servidores en los que se encuentra el bot.
admin-desc-shutdown = Apaga el bot
admin-title-allowlist = Administración - Lista de servidores permitidos
admin-desc-allowlist-warning =
    Añadir un nuevo ID de servidor de Discord a la lista de permitidos.
    {"**"}AVISO: No hay forma de verificar que el ID de servidor proporcionado sea válido sin que el bot sea miembro del servidor. ¡Comprobad bien vuestras entradas!{"**"}
admin-msg-no-servers = No hay servidores en la lista de permitidos.
# Modales de confirmación de administración
admin-modal-title-confirm-server-removal = Confirmar eliminación de servidor
admin-modal-label-server-removal = ¿Eliminar servidor de la lista de permitidos?
# Vista de cogs de administración
admin-title-cogs = Administración - Cogs
admin-desc-load-cog = Cargar un cog del bot por nombre. El archivo debe llamarse `<nombre>.py` y estar en ReQuest/cogs/.
admin-desc-reload-cog = Recargar un cog cargado por nombre. Se aplican las mismas restricciones de nombre y ruta.
