## Cadenas del módulo de configuración

# ==========================================
# BOTONES
# ==========================================

# Roles
config-btn-clear = Limpiar
config-btn-remove-gm-roles = Eliminar roles de GM
config-btn-forbidden-roles = Roles prohibidos

# Quests
config-btn-toggle-quest-summary = Alternar resumen de quest
config-btn-toggle-player-experience = Alternar experiencia del jugador
config-btn-toggle-display = Alternar visualización
config-btn-purge-player-board = Purgar tablón de jugadores
config-btn-add-modify-rewards = Añadir/Modificar recompensas

# Moneda
config-btn-add-denomination = Añadir denominación
config-btn-add-new-currency = Añadir nueva moneda
config-btn-remove-currency = Eliminar moneda

# Tiendas - creación
config-btn-add-shop-wizard = Añadir tienda (Asistente)
config-btn-add-shop-json = Añadir tienda (JSON)
config-btn-edit-shop-wizard = Editar tienda (Asistente)
config-btn-edit-shop-json = Editar tienda (JSON)
config-btn-remove-shop = Eliminar tienda
config-btn-add-item = Añadir objeto
config-btn-edit-shop-details = Editar detalles de tienda
config-btn-download-json = Descargar JSON
config-btn-done-editing = Edición finalizada
config-btn-scan-server-configs = Escanear configuración del servidor
config-btn-re-scan = Re-escanear

# Tienda de nuevo personaje
config-btn-upload-json = Subir JSON
config-btn-configure-new-character-wealth = Configurar riqueza inicial
config-btn-configure-new-character-shop = Configurar tienda de nuevo personaje
config-btn-clear-shop = Vaciar Tienda
config-btn-configure-static-kits = Configurar kits estáticos
config-btn-new-character-settings = Ajustes de nuevo personaje
config-btn-disabled-no-currency = Desactivado (Sin moneda configurada)
config-btn-disabled-no-wealth = Desactivado (Sin riqueza inicial configurada)

# Kits estáticos
config-btn-create-new-kit = Crear nuevo kit
config-btn-delete-kit = Eliminar kit
config-btn-add-currency = Añadir moneda

# Juego de rol
config-btn-toggle-rp-rewards = Alternar recompensas de RP
config-btn-clear-channels = Limpiar canales
config-btn-edit-settings = Editar ajustes
config-btn-configure-rewards = Configurar recompensas

# Existencias
config-btn-stock-limits = Límites de existencias
config-btn-set-limit = Establecer límite
config-btn-edit-limit = Editar límite
config-btn-remove-limit = Eliminar límite
config-btn-configure-restock-schedule = Configurar programa de reposición
config-btn-back-to-shop-editor = Volver al editor de tienda

# Tienda en foro
config-btn-create-new-thread = Crear nuevo hilo
config-btn-use-existing-thread = Usar hilo existente

# Asistente
config-btn-quit = Salir
config-btn-configure-channels = Configurar canales
config-btn-configure-roles = Configurar roles
config-btn-configure-quests = Configurar quests
config-btn-configure-players = Configurar jugadores
config-btn-configure-currency = Configurar moneda
config-btn-configure-rp-rewards = Configurar recompensas de RP
config-btn-configure-shops = Configurar tiendas
config-btn-new-char-setup = Config. nuevo personaje

# Títulos de modales de confirmación
config-modal-title-confirm-role-removal = Confirmar eliminación de rol
config-modal-title-confirm-removal = Confirmar eliminación
config-modal-title-confirm-currency-removal = Confirmar eliminación de moneda
config-modal-title-confirm-shop-removal = Confirmar eliminación de tienda
config-modal-title-confirm-kit-deletion = Confirmar eliminación de kit
config-modal-title-confirm-remove-stock-limit = Confirmar eliminación de límite de existencias
config-modal-title-clear-shop = Confirmar Vaciado de Tienda

# Etiquetas de modales de confirmación
config-modal-label-remove-role = ¿Eliminar { $roleName }?
config-modal-label-remove-denomination = ¿Eliminar { $denominationName }?
config-modal-label-remove-currency = ¿Eliminar { $currencyName }?
config-modal-label-shop-removal-warning = ¡AVISO: Esta acción es irreversible!
config-modal-label-kit-deletion-warning = ¡AVISO: Irreversible!
config-modal-placeholder-type-confirm = Escribid CONFIRM
config-modal-label-remove-stock-limit = Escribid CONFIRM para eliminar el límite de existencias
config-modal-label-clear-shop = ¿Vaciar todos los artículos de esta tienda?

# Mensajes de error de botones
config-error-shop-data-not-found = Error: No se han encontrado los datos de esa tienda.
config-msg-shop-json-download = Aquí tenéis la definición JSON de {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Aquí tenéis la definición JSON de la tienda de nuevo personaje.
config-error-select-forum-first = Seleccionad primero un canal de foro.
config-error-select-thread-first = Seleccionad primero un hilo.

# ==========================================
# MODALES
# ==========================================

config-modal-title-add-currency = Añadir nueva moneda
config-modal-label-currency-name = Nombre de la moneda
config-error-currency-already-exists = ¡Ya existe una moneda o denominación llamada { $name }!
config-modal-title-rename-currency = Renombrar moneda
config-modal-label-new-currency-name = Nuevo nombre de moneda
config-error-currency-name-exists = Ya existe una moneda llamada "{ $name }".
config-error-denomination-name-exists = Ya existe una denominación llamada "{ $name }".
config-modal-title-rename-denomination = Renombrar denominación
config-modal-label-new-denomination-name = Nuevo nombre de denominación
config-modal-title-add-denomination = Añadir denominación de { $currencyName }
config-modal-label-denomination-name = Nombre
config-modal-placeholder-denomination-name = p. ej., Plata
config-modal-label-denomination-value = Valor
config-modal-placeholder-denomination-value = p. ej., 0.1
config-error-denomination-matches-currency = ¡El nombre de la nueva denominación no puede coincidir con una moneda existente en este servidor! Se ha encontrado una moneda existente llamada "{ $existingName }".
config-error-denomination-matches-denomination = ¡El nombre de la nueva denominación no puede coincidir con una denominación existente en este servidor! Se ha encontrado una denominación existente llamada "{ $denominationName }" bajo la moneda llamada "{ $currencyName }".
config-error-denomination-value-exists = ¡Las denominaciones de una misma moneda deben tener valores únicos! { $denominationName } ya tiene este valor asignado.
config-modal-title-forbidden-roles = Nombres de roles prohibidos
config-modal-label-names = Nombres
config-modal-placeholder-names = Introducid nombres separados por comas
config-msg-forbidden-roles-updated = ¡Roles prohibidos actualizados!
config-modal-title-purge-player-board = Purgar tablón de jugadores
config-modal-label-age = Antigüedad
config-modal-placeholder-age = Introducid la antigüedad máxima de las publicaciones (en días) a conservar
config-msg-posts-purged = ¡Se han purgado las publicaciones con más de { $days } días de antigüedad!
config-modal-title-gm-rewards = Añadir/Modificar recompensas de GM
config-modal-label-experience = Experiencia
config-modal-placeholder-enter-number = Introducid un número
config-modal-label-items = Objetos
config-modal-placeholder-items =
    Nombre: Cantidad
    Nombre2: Cantidad
    etc.
config-error-experience-invalid = La experiencia debe ser un número entero válido (p. ej., 2000).
config-error-item-format-invalid = Formato de objeto inválido: "{ $item }". Cada objeto debe estar en una línea nueva, con el formato "Nombre: Cantidad".
config-modal-title-shop-details = Añadir/Editar detalles de tienda
config-modal-label-shop-channel = Seleccionad un canal
config-modal-placeholder-shop-channel = Seleccionad el canal para esta tienda
config-modal-label-shop-name = Nombre de la tienda
config-modal-placeholder-shop-name = Introducid el nombre de la tienda
config-modal-label-shopkeeper-name = Nombre del tendero
config-modal-placeholder-shopkeeper-name = Introducid el nombre del tendero
config-modal-label-shop-description = Descripción de la tienda
config-modal-placeholder-shop-description = Introducid una descripción para la tienda
config-modal-label-shop-image-url = URL de imagen de la tienda
config-modal-placeholder-shop-image-url = Introducid una URL para la imagen de la tienda
config-error-no-channel-selected = No se ha seleccionado ningún canal para la tienda.
config-error-shop-already-in-channel = Ya hay una tienda registrada en el canal seleccionado. Elegid un canal diferente o editad la tienda existente.
config-label-shopkeeper = {"**"}Tendero:{"**"} { $name }
config-msg-use-shop-command = Usad el comando `/shop` para buscar y comprar objetos.
config-modal-title-forum-thread-shop = Crear tienda en hilo de foro
config-modal-label-thread-name = Nombre del hilo
config-modal-placeholder-thread-name = Introducid el nombre para el hilo de la tienda
config-error-forum-not-found = No se ha encontrado el canal de foro seleccionado.
config-error-shop-already-in-thread = Ya hay una tienda registrada en este hilo. Esto no debería ocurrir en un hilo nuevo.
config-modal-title-add-shop-json = Añadir nueva tienda vía JSON
config-modal-label-upload-json = Subid un archivo .json con los datos de la tienda
config-error-no-json-uploaded = No se ha subido ningún archivo JSON para la tienda.
config-error-file-must-be-json = El archivo subido debe ser un archivo JSON (.json).
config-error-invalid-json = Formato JSON inválido: { $error }
config-error-json-validation-failed = El JSON no cumple con el esquema: { $error }
config-modal-title-shop-item = Añadir/Editar objeto de tienda
config-modal-label-item-name = Nombre del objeto
config-modal-placeholder-item-name = Introducid el nombre del objeto
config-modal-label-item-description = Descripción del objeto
config-modal-placeholder-item-description = Introducid una descripción para el objeto
config-modal-label-item-quantity = Cantidad del objeto
config-modal-placeholder-item-quantity = Introducid la cantidad vendida por compra
config-modal-label-item-costs = Costes del objeto
config-modal-placeholder-item-costs = P. ej.: 10 oro + 5 plata\nO: 50 rep\n(Usad + para Y, líneas nuevas para O)
config-error-item-quantity-positive = La cantidad del objeto debe ser un número entero positivo.
config-error-cost-format-invalid = Formato de coste inválido en la opción: "{ $option }". Cada coste debe tener una cantidad y una moneda separadas por un espacio, p. ej., "10 oro".
config-error-cost-amount-invalid = Cantidad inválida "{ $amount }" para la moneda: "{ $currency }". La cantidad debe ser un número positivo.
config-error-unknown-currency = Moneda desconocida `{ $currency }`. Usad una moneda válida configurada para este servidor.
config-error-item-already-exists = Ya existe un objeto llamado { $itemName } en esta tienda.
config-modal-title-update-shop-json = Actualizar tienda vía JSON
config-modal-label-upload-new-json = Subid nueva definición JSON
config-error-no-file-uploaded = No se ha subido ningún archivo.
config-error-file-must-be-json-ext = El archivo debe ser un archivo `.json`.
config-error-json-validation-message = La validación del JSON ha fallado: { $error }
config-modal-title-new-char-item = Añadir/Editar equipamiento de nuevo personaje
config-modal-placeholder-item-quantity-selection = Introducid la cantidad recibida por selección
config-modal-label-item-cost = Coste del objeto
config-error-cost-format-short = Formato de coste inválido: '{ $component }'. Se esperaba 'Cantidad Moneda'.
config-error-amount-invalid-short = Cantidad inválida '{ $amount }' para la moneda '{ $currency }'.
config-error-item-exists-new-char = Ya existe un objeto llamado { $itemName } en la tienda de nuevo personaje.
config-modal-title-upload-new-char-json = Subir tienda de nuevo personaje (JSON)
config-error-no-json-uploaded-short = No se ha subido ningún archivo JSON.
config-error-json-must-have-shopstock = El JSON debe contener un array 'shopStock'.
config-error-items-must-have-name-price = Todos los objetos deben tener 'name' y 'price'.
config-modal-title-set-wealth = Establecer riqueza de nuevo personaje
config-modal-label-amount = Cantidad
config-modal-placeholder-amount = Introducid la cantidad de esta moneda.
config-modal-placeholder-currency-name = Introducid el nombre de una moneda definida en este servidor
config-error-no-currencies-configured = No hay monedas configuradas en este servidor.
config-error-currency-not-found = Moneda o denominación llamada { $name } no encontrada. Usad una moneda válida.
config-modal-title-create-kit = Crear nuevo kit estático
config-modal-label-kit-name = Nombre del kit
config-modal-placeholder-kit-name = p. ej., Kit de guerrero inicial
config-modal-label-description = Descripción
config-modal-placeholder-kit-description = Descripción opcional para este kit
config-error-kit-name-exists = Ya existe un kit estático llamado "{ $kitName }". Elegid un nombre diferente.
config-modal-title-kit-item = Añadir/Editar objeto de kit
config-modal-placeholder-kit-item-quantity = Introducid la cantidad de este objeto a incluir en el kit
config-modal-title-kit-currency = Añadir moneda al kit
config-modal-placeholder-currency-eg = p. ej., Oro
config-modal-placeholder-amount-eg = p. ej., 100
config-error-amount-must-be-number = La cantidad debe ser un número.
config-error-no-currencies-on-server = No hay monedas configuradas en el servidor.
config-error-currency-not-found-short = Moneda "{ $currency }" no encontrada.
config-error-denomination-not-found = Denominación "{ $denomination }" no encontrada en la configuración de monedas.
config-modal-title-rp-settings = Ajustes de juego de rol
config-modal-label-min-message-length = Longitud mínima de mensaje (caracteres)
config-modal-placeholder-min-message-length = Nº de caracteres requeridos para que un mensaje sea elegible. 0 para sin límite
config-modal-label-cooldown = Tiempo de espera (segundos)
config-modal-placeholder-cooldown = Tiempo de espera, en segundos, entre contar mensajes como elegibles para recompensas
config-modal-label-message-threshold = Umbral de mensajes
config-modal-placeholder-message-threshold = Número de mensajes requeridos para activar la recompensa
config-modal-label-frequency = Frecuencia (nº de mensajes)
config-modal-placeholder-frequency = Número de mensajes elegibles requeridos para obtener recompensas
config-error-min-length-invalid = La longitud mínima de mensaje debe ser un número entero no negativo.
config-error-cooldown-invalid = El tiempo de espera debe ser un número entero no negativo.
config-error-threshold-invalid = El umbral de mensajes debe ser un número entero positivo.
config-error-frequency-invalid = La frecuencia debe ser un número entero positivo.
config-modal-title-rp-rewards = Configurar recompensas de juego de rol
config-modal-label-items-name-quantity = Objetos (Nombre: Cantidad)
config-modal-label-currency-name-amount = Moneda (Nombre: Cantidad)
config-error-experience-non-negative = La experiencia debe ser un número entero no negativo.
config-error-item-quantity-positive-named = La cantidad del objeto "{ $itemName }" debe ser un número entero positivo.
config-error-currency-amount-positive = La cantidad de moneda "{ $currencyName }" debe ser un número positivo.
config-modal-title-stock-limit = Límite de existencias: { $itemName }
config-modal-label-max-stock = Existencias máximas
config-modal-placeholder-max-stock = Introducid las existencias máximas (p. ej., 10)
config-modal-label-current-stock = Existencias actuales
config-modal-placeholder-current-stock = Introducid las existencias disponibles actualmente
config-error-max-stock-positive = Las existencias máximas deben ser un número entero positivo.
config-error-current-stock-non-negative = Las existencias actuales deben ser un número entero no negativo.
config-error-current-exceeds-max = Las existencias actuales no pueden superar las existencias máximas.
config-error-item-not-in-shop = El objeto "{ $itemName }" no se ha encontrado en la tienda.
config-modal-title-restock-schedule = Configurar programa de reposición
config-modal-label-schedule = Programa (hourly/daily/weekly/none)
config-modal-placeholder-schedule = Introducid: hourly, daily, weekly, o none
config-modal-label-time = Hora (HH:MM en UTC)
config-modal-desc-current-time = Hora actual: { $utcTime }
config-modal-placeholder-time = p. ej., 14:30 para las 14:30 UTC
config-modal-label-day-of-week = Día de la semana (0=Lun, 6=Dom) - Solo semanal
config-modal-placeholder-day-of-week = Introducid 0-6 (Lunes=0, Domingo=6)
config-modal-label-mode = Modo (full/incremental)
config-modal-placeholder-mode = full = restablecer al máximo, incremental = añadir cantidad
config-modal-label-increment = Cantidad de incremento (para modo incremental)
config-modal-placeholder-increment = Cantidad a añadir por ciclo de reposición
config-error-schedule-invalid = El programa debe ser uno de: hourly, daily, weekly, o none.
config-error-time-format-invalid = La hora debe estar en formato HH:MM (p. ej., 14:30).
config-error-day-of-week-invalid = El día de la semana debe ser 0-6 (Lunes=0, Domingo=6).
config-error-mode-invalid = El modo debe ser "full" o "incremental".
config-error-increment-positive = La cantidad de incremento debe ser un número entero positivo.

# ==========================================
# SELECTORES
# ==========================================
config-select-placeholder-channel = Buscad vuestro canal de { $configName }
config-select-placeholder-announce-role = Elegid vuestro rol de anuncio de quests
config-select-placeholder-gm-roles = Elegid vuestro(s) rol(es) de GM
config-select-placeholder-wait-list = Seleccionad tamaño de lista de espera
config-select-option-disabled = 0 (Desactivado)
config-select-placeholder-inventory-mode = Seleccionad modo de inventario
config-select-option-disabled-label = Desactivado
config-select-desc-disabled = Los jugadores empiezan con inventarios vacíos.
config-select-option-selection = Selección
config-select-desc-selection = Los jugadores eligen objetos libremente de la tienda de nuevo personaje.
config-select-option-purchase = Compra
config-select-desc-purchase = Los jugadores compran objetos de la tienda de nuevo personaje con una cantidad de moneda dada.
config-select-option-open = Abierto
config-select-desc-open = Los jugadores introducen manualmente sus propios inventarios.
config-select-option-static = Estático
config-select-desc-static = Los jugadores reciben un inventario inicial predefinido.
config-select-placeholder-rp-channels = Seleccionad canales elegibles
config-select-placeholder-rp-mode = Seleccionad modo
config-select-option-scheduled = Programado
config-select-desc-scheduled = Las recompensas se otorgan una vez dentro de un período de reinicio especificado.
config-select-option-accrued = Acumulado
config-select-desc-accrued = Las recompensas se otorgan repetidamente según los niveles de actividad especificados.
config-select-placeholder-reset-period = Seleccionad período de reinicio
config-select-option-hourly = Cada hora
config-select-desc-hourly = Se reinicia cada hora.
config-select-option-daily = Diario
config-select-desc-daily = Se reinicia cada 24 horas.
config-select-option-weekly = Semanal
config-select-desc-weekly = Se reinicia cada 7 días.
config-select-placeholder-reset-day = Seleccionad día de reinicio
config-select-placeholder-reset-time = Seleccionad hora de reinicio (UTC)
config-select-option-utc-time = { $hour }:00 UTC
config-select-placeholder-forum-channel = Seleccionad un canal de foro
config-select-placeholder-thread = Seleccionad un hilo
config-select-option-no-threads = No se han encontrado hilos activos
config-select-desc-no-threads = Cread un nuevo hilo o comprobad los hilos archivados
config-select-option-select-forum-first = Seleccionad un foro primero
config-select-desc-select-forum-first = Seleccionad un canal de foro arriba
config-select-desc-thread-id = ID del hilo: { $threadId }
config-error-select-valid-thread = Seleccionad un hilo válido o cread uno nuevo.
config-error-thread-not-found = No se ha encontrado el hilo seleccionado. Puede haber sido eliminado o archivado.

# ==========================================
# VISTAS
# ==========================================
config-title-main-menu = Configuración del servidor - Menú principal
config-menu-config-wizard = Asistente de configuración
config-menu-desc-config-wizard = Verificad que vuestro servidor está listo para usar ReQuest con un escaneo rápido.
config-menu-channels = Canales
config-menu-desc-channels = Estableced canales designados para las publicaciones de ReQuest.
config-menu-currency = Moneda
config-menu-desc-currency = Ajustes globales de moneda.
config-menu-players = Jugadores
config-menu-desc-players = Ajustes globales de jugadores, como el seguimiento de puntos de experiencia.
config-menu-quests = Quests
config-menu-desc-quests = Ajustes globales de quests, como listas de espera.
config-menu-rp-rewards = Recompensas de RP
config-menu-desc-rp-rewards = Configurar recompensas de juego de rol.
config-menu-roles = Roles
config-menu-desc-roles = Opciones de configuración para roles mencionables o con privilegios.
config-menu-shops = Tiendas
config-menu-desc-shops = Configurar tiendas personalizadas.
config-menu-language = Idioma
config-menu-desc-language = Establecer el idioma predeterminado para este servidor.
config-title-wizard = {"**"}Configuración del servidor - Asistente{"**"}
config-wizard-intro =
    {"**"}¡Bienvenidos al asistente de configuración de ReQuest!{"**"}

    Este asistente os ayudará a aseguraros de que vuestro servidor esté correctamente configurado para usar las funciones de ReQuest.
    Escaneará vuestros ajustes actuales y proporcionará recomendaciones para cualquier ajuste necesario.

    Usad el botón "Iniciar escaneo" a continuación para comenzar el proceso de validación. Una vez completado el escaneo,
    recibiréis un informe detallado de la configuración de vuestro servidor junto con los cambios recomendados.
config-wizard-bot-permissions-header = __{"**"}Permisos globales del bot{"**"}__
config-wizard-bot-permissions-desc = Esta sección verifica que ReQuest tiene los permisos correctos para funcionar correctamente.
config-wizard-bot-role = Rol del bot: { $roleMention }
config-wizard-status-warnings = {"**"}Estado: ⚠️ SE HAN ENCONTRADO AVISOS{"**"}
config-wizard-missing-perm = - ⚠️ Falta: `{ $permissionName }`
config-wizard-ensure-permissions = Aseguraos de que el rol más alto del bot tenga estos permisos concedidos globalmente.
config-wizard-status-ok = {"**"}Estado: ✅ CORRECTO{"**"}
config-wizard-bot-permissions-ok = El bot tiene todos los permisos globales requeridos.
config-wizard-status-scan-failed = {"**"}Estado: ❌ ESCANEO FALLIDO{"**"}
config-wizard-scan-error = Se ha producido un error inesperado al comprobar los permisos del bot.
config-wizard-error-type = Error: { $errorType }
config-wizard-required-permissions = {"**"}Permisos requeridos para el rol del bot:{"**"}
config-wizard-perm-view-channels = Ver canales
config-wizard-perm-manage-roles = Gestionar roles
config-wizard-perm-send-messages = Enviar mensajes
config-wizard-perm-attach-files = Adjuntar archivos
config-wizard-perm-add-reactions = Añadir reacciones
config-wizard-perm-use-external-emoji = Usar emojis externos
config-wizard-perm-manage-messages = Gestionar mensajes
config-wizard-perm-read-message-history = Leer historial de mensajes
config-wizard-role-header = __{"**"}Configuración de roles{"**"}__
config-wizard-role-desc =
    Esta sección verifica lo siguiente:

    - Los roles de GM (obligatorios) y el rol de anuncio (opcional) están configurados.
    - El rol predeterminado (@everyone) tiene los permisos necesarios para que los usuarios accedan a las funciones del bot.
    - El rol predeterminado (@everyone) no tiene permisos peligrosos.
    - Los roles de GM y de anuncio se comprueban para ver si tienen escalaciones de permisos más allá del rol predeterminado.

    Los avisos aquí son solo recomendaciones basadas en una configuración por defecto. Dependiendo de las necesidades de vuestro servidor, podéis tener razones para ignorar algunas de estas recomendaciones.
config-wizard-default-role-label = {"**"}Rol predeterminado:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Permisos peligrosos encontrados:
config-wizard-default-role-ok = - ✅ @everyone: Correcto
config-wizard-missing-permission = - Permiso faltante: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}Roles de GM:{"**"}
config-wizard-no-gm-roles = - ⚠️ No hay roles de GM configurados
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Rol configurado no encontrado/eliminado del servidor
config-wizard-role-ok = - ✅ { $roleMention }: Correcto
config-wizard-announcement-role-label = {"**"}Rol de anuncio:{"**"}
config-wizard-no-announcement-role = - ℹ️ No hay rol de anuncio configurado
config-wizard-announcement-role-not-found = - ⚠️ Rol configurado no encontrado/eliminado del servidor
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Escalaciones de permisos detectadas - { $escalations }
config-wizard-escalation-more = , y { $count } más...
config-wizard-perm-send-messages-in-threads = Enviar mensajes en hilos
config-wizard-perm-use-application-commands = Usar comandos de aplicación
config-wizard-perm-manage-channels = Gestionar canales
config-wizard-perm-manage-webhooks = Gestionar webhooks
config-wizard-perm-manage-server = Gestionar servidor
config-wizard-perm-manage-nicknames = Gestionar apodos
config-wizard-perm-kick-members = Expulsar miembros
config-wizard-perm-ban-members = Banear miembros
config-wizard-perm-timeout-members = Aislar miembros
config-wizard-perm-mention-everyone = Mencionar a @everyone
config-wizard-perm-manage-threads = Gestionar hilos
config-wizard-perm-administrator = Administrador
config-wizard-channel-header = __{"**"}Configuración de canales{"**"}__
config-wizard-channel-desc =
    Esta sección verifica lo siguiente:

    - Los canales configurados existen.
    - El bot tiene permiso para ver y enviar mensajes en los canales configurados.
    - El rol predeterminado (@everyone) no tiene permisos de `Enviar mensajes`.
config-wizard-channel-no-config-required = - ⚠️ No hay canal configurado
config-wizard-channel-not-configured = - ℹ️ No configurado (Opcional)
config-wizard-channel-not-found = - ⚠️ Canal configurado no encontrado/eliminado del servidor
config-wizard-channel-ok = - ✅ Correcto
config-wizard-bot-cannot-view = - ⚠️ { $botMention } no puede ver este canal.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } no puede enviar mensajes en este canal.
config-wizard-everyone-can-send = - ⚠️ @everyone puede enviar mensajes en este canal.
config-wizard-channel-quest-board = Tablón de quests
config-wizard-channel-player-board = Tablón de jugadores
config-wizard-channel-quest-archive = Archivo de quests
config-wizard-channel-gm-transaction-log = Registro de transacciones de GM
config-wizard-channel-player-transaction-log = Registro de transacciones de jugadores
config-wizard-channel-shop-log = Registro de tienda
config-wizard-channel-approval-queue = Cola de aprobación de personajes
config-wizard-dashboard-header = __{"**"}Panel de ajustes{"**"}__
config-wizard-dashboard-desc = Esta sección proporciona una vista general de configuraciones no esenciales para referencia rápida.
config-wizard-quest-settings = {"**"}Ajustes de quests{"**"}
config-wizard-quest-wait-list = - Tamaño de lista de espera de quests: { $size }
config-wizard-quest-summary = - Resumen de quest: { $status }
config-wizard-gm-rewards-per-quest = {"**"}Recompensas de GM (por quest){"**"}
config-wizard-player-settings = {"**"}Ajustes de jugadores{"**"}
config-wizard-player-experience = - Experiencia del jugador: { $status }
config-wizard-currency-settings = {"**"}Ajustes de moneda{"**"}
config-wizard-rp-rewards = {"**"}Recompensas de juego de rol{"**"}
config-wizard-rp-status = - Estado: { $status }
config-wizard-rp-mode = - Modo: { $mode }
config-wizard-rp-channels = - Canales monitorizados: { $count }
config-wizard-shops = {"**"}Tiendas{"**"}
config-wizard-shops-count = - Tiendas configuradas: { $count }
config-wizard-shops-more = - ...y { $count } más
config-wizard-new-char-setup = {"**"}Configuración de nuevo personaje{"**"}
config-wizard-inventory-type = - Tipo de inventario: { $type }
config-wizard-new-char-shop-items = - Objetos de tienda de nuevo personaje: { $count }
config-wizard-static-kits = - Kits estáticos: { $count }
config-wizard-no-currencies = - ℹ️ No hay monedas configuradas
config-wizard-configured-currencies = {"**"}Monedas configuradas:{"**"}
config-wizard-no-denominations = - No hay denominaciones configuradas
config-wizard-gm-rewards-disabled = {"**"}Estado:{"**"} Desactivado
config-wizard-gm-rewards-enabled = {"**"}Estado:{"**"} Activado
config-wizard-gm-rewards-experience = - Experiencia: { $xp }
config-wizard-gm-rewards-items = - Objetos:
config-wizard-unnamed-shop = Tienda sin nombre
config-title-roles = {"**"}Configuración del servidor - Roles{"**"}
config-label-announcement-role = {"**"}Rol de anuncio:{"**"} { $status }
config-desc-announcement-role = Este rol se menciona cuando se publica una quest.
config-label-announcement-role-default = {"**"}Rol de anuncio:{"**"} No configurado
config-label-gm-roles = {"**"}Rol(es) de GM:{"**"} { $roles }
config-desc-gm-roles = Estos roles concederán acceso a comandos y funciones de Game Master.
config-label-gm-roles-default = {"**"}Rol(es) de GM:{"**"} No configurado
config-title-forbidden-roles = __{"**"}Roles prohibidos{"**"}__
config-desc-forbidden-roles =
    Configura una lista de nombres de roles que no pueden ser usados por los Game Masters para sus roles de grupo.
    Por defecto, `everyone`, `administrator`, `gm` y `game master` no pueden usarse. Esta configuración
    amplía esa lista.
config-title-remove-gm-roles = {"**"}Configuración del servidor - Eliminar rol(es) de GM{"**"}
config-msg-no-gm-roles = No hay roles de GM configurados.
config-title-channels = {"**"}Configuración del servidor - Canales{"**"}
config-label-quest-board = {"**"}Tablón de quests:{"**"} { $channel }
config-desc-quest-board = El canal donde se publicarán las quests nuevas/activas.
config-label-quest-board-default = {"**"}Tablón de quests:{"**"} No configurado
config-label-player-board = {"**"}Tablón de jugadores:{"**"} { $channel }
config-desc-player-board = Un canal opcional de anuncios/mensajes para uso de los jugadores.
config-label-player-board-default = {"**"}Tablón de jugadores:{"**"} No configurado
config-label-quest-archive = {"**"}Archivo de quests:{"**"} { $channel }
config-desc-quest-archive = Un canal opcional donde se moverán las quests completadas, con información resumida.
config-label-quest-archive-default = {"**"}Archivo de quests:{"**"} No configurado
config-label-gm-transaction-log = {"**"}Registro de transacciones de GM:{"**"} { $channel }
config-desc-gm-transaction-log = Un canal opcional donde se registran las transacciones de GM (es decir, comandos de Modificar jugador).
config-label-gm-transaction-log-default = {"**"}Registro de transacciones de GM:{"**"} No configurado
config-label-player-transaction-log = {"**"}Registro de transacciones de jugadores:{"**"} { $channel }
config-desc-player-transaction-log = Un canal opcional donde se registran las transacciones de jugadores como intercambios y consumo de objetos.
config-label-player-transaction-log-default = {"**"}Registro de transacciones de jugadores:{"**"} No configurado
config-label-shop-log = {"**"}Registro de tienda:{"**"} { $channel }
config-desc-shop-log = Un canal opcional donde se registran las transacciones de tienda.
config-label-shop-log-default = {"**"}Registro de tienda:{"**"} No configurado
config-title-quests = {"**"}Configuración del servidor - Quests{"**"}
config-label-wait-list = {"**"}Tamaño de lista de espera de quests:{"**"} { $size }
config-desc-wait-list = Una lista de espera permite al número especificado de jugadores hacer cola para una quest que está llena, en caso de que un jugador se retire.
config-label-wait-list-disabled = {"**"}Tamaño de lista de espera de quests:{"**"} Desactivado
config-label-quest-summary = {"**"}Resumen de quest:{"**"} { $status }
config-desc-quest-summary = Esta opción permite a los GM proporcionar un breve resumen al cerrar las quests.
config-label-quest-summary-disabled = {"**"}Resumen de quest:{"**"} Desactivado
config-label-gm-rewards = Recompensas de GM
config-desc-gm-rewards = Configurar recompensas que reciben los GM al completar quests.
config-title-gm-rewards = {"**"}Configuración del servidor - Recompensas de GM{"**"}
config-desc-gm-rewards-detail =
    {"**"}Añadir/Modificar recompensas{"**"}
    Abre un modal de entrada para añadir, modificar o eliminar recompensas de GM.

    > Las recompensas configuradas son por quest. Cada vez que un Game Master completa una quest, recibirá
    las recompensas configuradas a continuación en su personaje activo.
config-msg-no-rewards = No hay recompensas configuradas.
config-label-gm-experience = {"**"}Experiencia:{"**"} { $xp }
config-label-gm-items = {"**"}Objetos:{"**"}
config-title-players = {"**"}Configuración del servidor - Jugadores{"**"}
config-label-player-experience = {"**"}Experiencia del jugador:{"**"} { $status }
config-desc-player-experience = Activa/Desactiva el uso de puntos de experiencia (o progresión de personaje basada en valores similares).
config-label-player-experience-disabled = {"**"}Experiencia del jugador:{"**"} Desactivado
config-label-new-char-settings = {"**"}Ajustes de nuevo personaje{"**"}
config-desc-new-char-settings = Configurar ajustes relacionados con nuevos personajes y cómo se configuran sus inventarios iniciales.
config-label-player-board-purge = {"**"}Purga del tablón de jugadores{"**"}
config-desc-player-board-purge = Purga publicaciones del tablón de jugadores (si está activado).
config-title-new-character = {"**"}Configuración del servidor - Ajustes de nuevo personaje{"**"}
config-label-inventory-type = {"**"}Tipo de inventario de nuevo personaje:{"**"} { $type }
config-desc-inventory-type = Determina cómo los personajes recién registrados inicializan sus inventarios.
config-label-inventory-type-disabled = {"**"}Tipo de inventario de nuevo personaje:{"**"} Desactivado
config-label-new-char-wealth = {"**"}Riqueza de nuevo personaje:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Riqueza de nuevo personaje:{"**"} Desactivado
config-label-approval-queue = {"**"}Cola de aprobación:{"**"} { $channel }
config-desc-approval-queue = Si se establece, los nuevos personajes deben ser aprobados por un GM en este canal de foro antes de estar activos.
config-label-approval-queue-disabled = {"**"}Cola de aprobación:{"**"} Desactivado
config-label-approval-queue-not-configured = {"**"}Cola de aprobación:{"**"} No configurado
config-desc-inv-type-disabled = Los jugadores empiezan con inventarios vacíos.
config-desc-inv-type-selection = Los jugadores eligen objetos libremente de la tienda de nuevo personaje.
config-desc-inv-type-purchase = Los jugadores compran objetos de la tienda de nuevo personaje con una cantidad de moneda dada.
config-desc-inv-type-open = Los jugadores introducen manualmente sus objetos de inventario.
config-desc-inv-type-static = Los jugadores reciben un inventario inicial predefinido.
config-title-new-char-shop = {"**"}Configuración del servidor - Tienda de nuevo personaje{"**"}
config-label-inv-type-selection = {"**"}Tipo de inventario:{"**"} Selección
config-desc-inv-type-selection-shop = Los jugadores eligen objetos libremente de la tienda de nuevo personaje.
config-label-inv-type-purchase = {"**"}Tipo de inventario:{"**"} Compra
config-desc-inv-type-purchase-shop = Los jugadores compran objetos de la tienda de nuevo personaje con una cantidad de moneda dada.
config-label-inv-type-other = {"**"}Tipo de inventario:{"**"} { $type }
config-desc-inv-type-not-in-use = La tienda de nuevo personaje no está en uso.
config-msg-define-shop-items = Definid los objetos de la tienda.
config-msg-no-items = No hay objetos configurados.
config-title-static-kits = {"**"}Configuración del servidor - Kits estáticos{"**"}
config-desc-create-kit = Crear una nueva definición de kit.
config-msg-no-kits = No hay kits configurados.
config-label-kit-more-items = ...y { $count } objetos más
config-label-empty-kit = {"*"}Kit vacío{"*"}
config-title-editing-kit = {"**"}Editando kit: { $kitName }{"**"}
config-msg-kit-empty = Este kit está vacío. Usad los botones de arriba para añadir moneda u objetos.
config-label-kit-currency = {"**"}Moneda:{"**"} { $display }
config-label-kit-item = {"**"}Objeto:{"**"} { $name }
config-title-currency = {"**"}Configuración del servidor - Moneda{"**"}
config-desc-create-currency = Crear una nueva moneda.
config-msg-no-currencies = No hay monedas configuradas.
config-label-currency-display-type = Tipo de visualización: { $type } | Denominaciones: { $count }
config-label-currency-type-double = Doble
config-label-currency-type-integer = Entero
config-title-manage-currency = {"**"}Gestionar moneda: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Moneda y denominaciones{"**"}__
    - El nombre dado a vuestra moneda se considera la moneda base y tiene un valor de 1.
    {"```"}Ejemplo: "oro" se configura como moneda.{"```"}
    - Añadir una denominación requiere especificar un nombre y un valor relativo a la moneda base.
    {"```"}Ejemplo: Al oro se le dan dos denominaciones: plata (valor de 0.1) y cobre (valor de 0.01).{"```"}
    - Cualquier transacción que involucre una moneda base o sus denominaciones las convertirá automáticamente.
    {"```"}Ejemplo: Un jugador tiene 10 de oro y gasta 3 de cobre. Su nuevo saldo mostrará automáticamente
    9 de oro, 9 de plata y 7 de cobre.{"```"}
    - Las monedas mostradas como entero mostrarán cada denominación, mientras que las mostradas como doble
    mostrarán solo la moneda base.
    {"```"}Ejemplo: El jugador anterior con visualización doble activada mostrará 9.97 de oro.{"```"}
config-btn-toggle-display-current = Alternar visualización (Actual: { $type })
config-msg-no-denominations = No hay denominaciones configuradas.
config-title-shops = {"**"}Configuración del servidor - Tiendas{"**"}
config-desc-add-shop-wizard =
    {"**"}Añadir tienda (Asistente){"**"}
    Crear una nueva tienda vacía desde un formulario.
config-desc-add-shop-json =
    {"**"}Añadir tienda (JSON){"**"}
    Crear una nueva tienda proporcionando una definición JSON completa. (Avanzado)
config-btn-example-json = JSON de Ejemplo
config-desc-example-json =
    {"**"}JSON de Ejemplo{"**"}
    Descarga un archivo JSON de ejemplo que muestra el formato esperado.
config-msg-example-json = Aquí tienes un archivo JSON de ejemplo que muestra el formato esperado.
config-msg-no-shops = No hay tiendas configuradas.
config-label-shop-type-forum = (Foro)
config-label-shop-channel = Canal: <#{ $channelId }>
config-title-choose-location = {"**"}Añadir tienda - Elegir tipo de ubicación{"**"}
config-label-text-channel = {"**"}Canal de texto{"**"}
config-desc-text-channel = Crear una tienda en un canal de texto estándar.
config-label-forum-thread = {"**"}Hilo de foro{"**"}
config-desc-forum-thread = Crear una tienda en un hilo de foro (nuevo o existente).
config-title-forum-setup = {"**"}Añadir tienda - Configuración de hilo de foro{"**"}
config-label-step1 = {"**"}Paso 1: Seleccionad un canal de foro{"**"}
config-label-step2 = {"**"}Paso 2: Elegid opción de hilo{"**"}
config-label-step3 = {"**"}Paso 3: Seleccionad un hilo existente{"**"}
config-desc-create-new-thread =
    {"**"}Crear nuevo hilo{"**"}
    Abre un formulario para crear un nuevo hilo y configurar la tienda.
config-label-selected-thread = {"**"}Hilo seleccionado:{"**"} { $threadName }
config-desc-click-to-configure = Haced clic para configurar la tienda en este hilo.
config-title-manage-shop = {"**"}Gestionar tienda: { $shopName }{"**"}
config-label-shop-type = {"**"}Tipo:{"**"} { $type }
config-label-shop-type-text = Canal de texto
config-label-shop-type-forum-thread = Hilo de foro
config-label-shopkeeper = {"**"}Tendero:{"**"} { $name }
config-label-shop-description = {"**"}Descripción:{"**"} { $description }
config-label-shop-channel-info = {"**"}Canal:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Editar detalles y objetos de la tienda mediante el asistente.
config-desc-upload-json = Subir una nueva definición JSON para esta tienda.
config-desc-download-json = Descargar la definición JSON actual.
config-desc-remove-shop = Eliminar esta tienda permanentemente.
config-title-editing-shop = {"**"}Editando tienda: { $shopName }{"**"}
config-label-shop-shopkeeper = Tendero: {"**"}{ $name }{"**"}
config-title-stock-config = {"**"}Configuración de existencias: { $shopName }{"**"}
config-label-current-utc = Hora UTC actual: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Programa de reposición:{"**"} { $schedule }
config-label-restock-hourly = en el minuto :{ $minute }
config-label-restock-daily = a las { $time } UTC
config-label-restock-weekly = el { $day } a las { $time } UTC
config-label-restock-mode = {"**"}Modo:{"**"} { $mode }
config-label-restock-full = Reposición completa
config-label-restock-incremental = Añadir { $amount } por ciclo (hasta el máximo)
config-label-restock-disabled = {"**"}Programa de reposición:{"**"} Desactivado
config-label-item-stock-limits = {"**"}Límites de existencias de objetos{"**"}
config-msg-no-items-in-shop = No hay objetos en esta tienda.
config-label-stock-with-available = Máx: { $max } | Disponible: { $available }
config-label-stock-reserved = | Reservado: { $reserved }
config-label-stock-not-initialized = Máx: { $max } | Disponible: (no inicializado)
config-label-stock-unlimited = Existencias: Ilimitadas
config-title-roleplay = {"**"}Configuración del servidor - Recompensas de juego de rol{"**"}
config-label-rp-status = {"**"}Estado:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Hora del servidor:{"**"} `{ $time }`
config-label-rp-enabled = Activado
config-label-rp-disabled = Desactivado
config-desc-rp-mode-scheduled = {"```"}Las recompensas se distribuyen una vez, al enviar el umbral requerido de mensajes elegibles dentro del período de tiempo establecido (cada hora, diario o semanal).{"```"}
config-desc-rp-mode-accrued = {"```"}Las recompensas se distribuyen de forma recurrente cada vez que se envía un número determinado de mensajes elegibles.{"```"}
config-label-rp-config-details = {"**"}Detalles de configuración:{"**"}
config-label-rp-mode = {"**"}Modo:{"**"} { $mode }
config-label-rp-min-length = {"**"}Longitud mínima de mensaje:{"**"} { $length } caracteres
config-label-rp-cooldown = {"**"}Tiempo de espera:{"**"} { $seconds } segundos
config-label-rp-frequency-once = {"**"}Frecuencia:{"**"} Una vez por { $period }
config-label-rp-reset-time = {"**"}Hora de reinicio:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Umbral:{"**"} { $count } mensajes elegibles
config-label-rp-frequency-every = {"**"}Frecuencia:{"**"} Cada { $count } mensajes elegibles
config-label-rp-channels = {"**"}Canales de juego de rol:{"**"}
config-msg-rp-no-channels = Ninguno configurado.
config-label-rp-channels-more = ...y { $count } más.
config-label-rp-rewards = {"**"}Recompensas:{"**"}
config-msg-rp-no-rewards = Ninguna configurada.
config-label-rp-experience = {"**"}Experiencia:{"**"} { $xp }
config-label-rp-items = {"**"}Objetos:{"**"}
config-label-rp-currency = {"**"}Moneda:{"**"}
config-title-language = {"**"}Configuración del servidor - Idioma{"**"}
config-server-language-help =
    Este ajuste os permite especificar el idioma predeterminado para las respuestas y mensajes {"**"}públicos{"**"} de ReQuest en este servidor. Las respuestas públicas incluyen:
    - Publicaciones en el tablón de quests y jugadores
    - Resúmenes de quests y mensajes en canales de registro
    - Reposición de tiendas
    - Consumo de objetos por jugadores

    Este ajuste solo afecta al texto estático generado por el bot, y no traduce contenido dinámico como nombres de objetos introducidos por usuarios o descripciones de quests.

    Las respuestas personales y los menús no se ven afectados por este ajuste.
config-label-server-language = {"**"}Idioma del servidor:{"**"} { $language }
config-label-server-language-default = {"**"}Idioma del servidor:{"**"} Por defecto (sin anulación)
config-select-placeholder-server-language = Seleccionad el idioma del servidor
config-select-option-default = Por defecto (sin anulación)
config-select-desc-default = Usar la preferencia de cada usuario o el idioma de Discord.
