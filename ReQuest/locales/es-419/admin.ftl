## Cadenas del módulo de administración

# Cog de administración
admin-embed-title-unauthorized = Servidor No Autorizado
admin-embed-desc-unauthorized =
    ¡Gracias por tu interés en ReQuest! Tu servidor no está en la lista de servidores de prueba autorizados de ReQuest.
    Por favor únete al Discord de soporte a continuación y contacta al equipo de desarrollo para solicitar acceso de prueba.

    [Discord de Desarrollo de ReQuest](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Los siguientes comandos fueron sincronizados a { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Los siguientes comandos fueron sincronizados globalmente
admin-error-missing-scope = ReQuest no tiene el alcance correcto en el servidor objetivo. Agrega el permiso `applications.commands` e intenta de nuevo.
admin-error-sync-failed = Hubo un error al sincronizar los comandos: { $error }
admin-msg-commands-cleared = Comandos eliminados.

# Botones de administración
admin-btn-shutdown = Apagar
admin-modal-title-confirm-shutdown = Confirmar Apagado
admin-modal-label-shutdown-warning = ¡Advertencia! Esto apagará el bot. Escribe CONFIRMAR para continuar.
admin-msg-shutting-down = ¡Apagando!
admin-btn-add-server = Agregar Nuevo Servidor
admin-btn-load-cog = Cargar Cog
admin-msg-extension-loaded = Extensión cargada exitosamente: `{ $module }`
admin-btn-reload-cog = Recargar Cog
admin-msg-extension-reloaded = Extensión recargada exitosamente: `{ $module }`
admin-btn-output-guilds = Listar Servidores
admin-msg-connected-guilds = Conectado a { $count } servidores:

# Modales de administración
admin-modal-title-add-server = Agregar ID de Servidor a la Lista Permitida
admin-modal-label-server-name = Nombre del Servidor
admin-modal-placeholder-server-name = Escribe un nombre corto para el servidor de Discord
admin-modal-label-server-id = ID del Servidor
admin-modal-placeholder-server-id = Escribe el ID del servidor de Discord
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = Nombre
admin-modal-placeholder-cog-name = Ingresa el nombre del Cog para { $action }

# Vistas de administración
admin-title-main-menu = Administración - Menú Principal
admin-desc-allowlist = Configurar la lista de servidores permitidos para restricciones de invitación.
admin-desc-cogs = Cargar o recargar cogs.
admin-desc-guild-list = Devuelve una lista de todos los servidores de los que el bot es miembro.
admin-desc-shutdown = Apaga el bot
admin-title-allowlist = Administración - Lista de Servidores Permitidos
admin-desc-allowlist-warning =
    Agregar un nuevo ID de servidor de Discord a la lista de permitidos.
    {"**"}ADVERTENCIA: No hay forma de verificar que el ID del servidor proporcionado sea válido sin que el bot sea miembro del servidor. ¡Verifica bien tus datos!{"**"}
admin-msg-no-servers = No hay servidores en la lista de permitidos.

# Modales de confirmación de administración
admin-modal-title-confirm-server-removal = Confirmar Eliminación de Servidor
admin-modal-label-server-removal = ¿Eliminar servidor de la lista de permitidos?

# Vista de cogs de administración
admin-title-cogs = Administración - Cogs
admin-desc-load-cog = Cargar un cog del bot por nombre. El archivo debe llamarse `<nombre>.py` y estar almacenado en ReQuest/cogs/.
admin-desc-reload-cog = Recargar un cog cargado por nombre. Las mismas restricciones de nombre y ruta de archivo aplican.
