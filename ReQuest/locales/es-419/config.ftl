## Cadenas del módulo de configuración

# ==========================================
# BOTONES
# ==========================================

# Roles
config-btn-clear = Limpiar
config-btn-remove-gm-roles = Eliminar Roles de GM
config-btn-forbidden-roles = Roles Prohibidos

# Quests
config-btn-toggle-quest-summary = Alternar Resumen de Quest
config-btn-toggle-player-experience = Alternar Experiencia de Jugador
config-btn-toggle-display = Alternar Visualización
config-btn-purge-player-board = Purgar Tablero de Jugadores
config-btn-add-modify-rewards = Agregar/Modificar Recompensas

# Moneda
config-btn-add-denomination = Agregar Denominación
config-btn-add-new-currency = Agregar Nueva Moneda
config-btn-remove-currency = Eliminar Moneda

# Tiendas - creación
config-btn-add-shop-wizard = Agregar Tienda (Asistente)
config-btn-add-shop-json = Agregar Tienda (JSON)
config-btn-edit-shop-wizard = Editar Tienda (Asistente)
config-btn-edit-shop-json = Editar Tienda (JSON)
config-btn-remove-shop = Eliminar Tienda
config-btn-add-item = Agregar Objeto
config-btn-edit-shop-details = Editar Detalles de Tienda
config-btn-download-json = Descargar JSON
config-btn-done-editing = Terminar Edición
config-btn-scan-server-configs = Escanear Configuraciones del Servidor
config-btn-re-scan = Re-Escanear

# Tienda de nuevo personaje
config-btn-upload-json = Subir JSON
config-btn-configure-new-character-wealth = Configurar Riqueza de Nuevo Personaje
config-btn-configure-new-character-shop = Configurar Tienda de Nuevo Personaje
config-btn-clear-shop = Vaciar Tienda
config-btn-configure-static-kits = Configurar Kits Estáticos
config-btn-new-character-settings = Configuración de Nuevo Personaje
config-btn-disabled-no-currency = Desactivado (Sin Moneda Configurada)
config-btn-disabled-no-wealth = Desactivado (Sin Riqueza Inicial Configurada)

# Kits estáticos
config-btn-create-new-kit = Crear Nuevo Kit
config-btn-delete-kit = Eliminar Kit
config-btn-add-currency = Agregar Moneda

# Roleplay
config-btn-toggle-rp-rewards = Alternar Recompensas de RP
config-btn-clear-channels = Limpiar Canales
config-btn-edit-settings = Editar Configuración
config-btn-configure-rewards = Configurar Recompensas

# Inventario
config-btn-stock-limits = Límites de Inventario
config-btn-set-limit = Establecer Límite
config-btn-edit-limit = Editar Límite
config-btn-remove-limit = Eliminar Límite
config-btn-configure-restock-schedule = Configurar Horario de Reabastecimiento
config-btn-back-to-shop-editor = Volver al Editor de Tienda

# Tienda en foro
config-btn-create-new-thread = Crear Nuevo Hilo
config-btn-use-existing-thread = Usar Hilo Existente

# Asistente
config-btn-quit = Salir
config-btn-configure-channels = Configurar Canales
config-btn-configure-roles = Configurar Roles
config-btn-configure-quests = Configurar Quests
config-btn-configure-players = Configurar Jugadores
config-btn-configure-currency = Configurar Moneda
config-btn-configure-rp-rewards = Configurar Recompensas de RP
config-btn-configure-shops = Configurar Tiendas
config-btn-new-char-setup = Config. Nuevo Personaje

# Títulos de modales de confirmación (pasados al ConfirmModal común)
config-modal-title-confirm-role-removal = Confirmar Eliminación de Rol
config-modal-title-confirm-removal = Confirmar Eliminación
config-modal-title-confirm-currency-removal = Confirmar Eliminación de Moneda
config-modal-title-confirm-shop-removal = Confirmar Eliminación de Tienda
config-modal-title-confirm-kit-deletion = Confirmar Eliminación de Kit
config-modal-title-confirm-remove-stock-limit = Confirmar Eliminación de Límite de Inventario
config-modal-title-clear-shop = Confirmar Vaciado de Tienda

# Etiquetas de modales de confirmación
config-modal-label-remove-role = ¿Eliminar { $roleName }?
config-modal-label-remove-denomination = ¿Eliminar { $denominationName }?
config-modal-label-remove-currency = ¿Eliminar { $currencyName }?
config-modal-label-shop-removal-warning = ¡ADVERTENCIA: Esta acción es irreversible!
config-modal-label-kit-deletion-warning = ¡ADVERTENCIA: Irreversible!
config-modal-placeholder-type-confirm = Escribe CONFIRM
config-modal-label-remove-stock-limit = Escribe CONFIRM para eliminar el límite de inventario
config-modal-label-clear-shop = ¿Vaciar todos los artículos de esta tienda?

# Mensajes de error de botones
config-error-shop-data-not-found = Error: No se pudieron encontrar los datos de esa tienda.
config-msg-shop-json-download = Aquí está la definición JSON para {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Aquí está la definición JSON para la Tienda de Nuevo Personaje.
config-error-select-forum-first = Por favor selecciona un canal de foro primero.
config-error-select-thread-first = Por favor selecciona un hilo primero.

# ==========================================
# MODALES
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Agregar Nueva Moneda
config-modal-label-currency-name = Nombre de la Moneda
config-error-currency-already-exists = ¡Ya existe una moneda o denominación llamada { $name }!

# RenameCurrencyModal
config-modal-title-rename-currency = Renombrar Moneda
config-modal-label-new-currency-name = Nuevo Nombre de Moneda
config-error-currency-name-exists = Ya existe una moneda llamada "{ $name }".
config-error-denomination-name-exists = Ya existe una denominación llamada "{ $name }".

# RenameDenominationModal
config-modal-title-rename-denomination = Renombrar Denominación
config-modal-label-new-denomination-name = Nuevo Nombre de Denominación

# AddCurrencyDenominationModal
config-modal-title-add-denomination = Agregar Denominación de { $currencyName }
config-modal-label-denomination-name = Nombre
config-modal-placeholder-denomination-name = ej., Plata
config-modal-label-denomination-value = Valor
config-modal-placeholder-denomination-value = ej., 0.1
config-error-denomination-matches-currency = ¡El nombre de la nueva denominación no puede coincidir con una moneda existente en este servidor! Se encontró una moneda existente llamada "{ $existingName }".
config-error-denomination-matches-denomination = ¡El nombre de la nueva denominación no puede coincidir con una denominación existente en este servidor! Se encontró una denominación existente llamada "{ $denominationName }" bajo la moneda llamada "{ $currencyName }".
config-error-denomination-value-exists = ¡Las denominaciones bajo una misma moneda deben tener valores únicos! { $denominationName } ya tiene este valor asignado.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Nombres de Roles Prohibidos
config-modal-label-names = Nombres
config-modal-placeholder-names = Ingresa los nombres separados por comas
config-msg-forbidden-roles-updated = ¡Roles prohibidos actualizados!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Purgar Tablero de Jugadores
config-modal-label-age = Antigüedad
config-modal-placeholder-age = Ingresa la antigüedad máxima de publicaciones (en días) a conservar
config-msg-posts-purged = ¡Las publicaciones con más de { $days } días de antigüedad han sido purgadas!

# GMRewardsModal
config-modal-title-gm-rewards = Agregar/Modificar Recompensas de GM
config-modal-label-experience = Experiencia
config-modal-placeholder-enter-number = Ingresa un número
config-modal-label-items = Objetos
config-modal-placeholder-items =
    Nombre: Cantidad
    Nombre2: Cantidad
    etc.
config-error-experience-invalid = La experiencia debe ser un número entero válido (ej. 2000).
config-error-item-format-invalid = Formato de objeto inválido: "{ $item }". Cada objeto debe estar en una nueva línea, con el formato "Nombre: Cantidad".

# ConfigShopDetailsModal
config-modal-title-shop-details = Agregar/Editar Detalles de Tienda
config-modal-label-shop-channel = Selecciona un canal
config-modal-placeholder-shop-channel = Selecciona el canal para esta tienda
config-modal-label-shop-name = Nombre de la Tienda
config-modal-placeholder-shop-name = Ingresa el nombre de la tienda
config-modal-label-shopkeeper-name = Nombre del Tendero
config-modal-placeholder-shopkeeper-name = Ingresa el nombre del tendero
config-modal-label-shop-description = Descripción de la Tienda
config-modal-placeholder-shop-description = Ingresa una descripción para la tienda
config-modal-label-shop-image-url = URL de Imagen de la Tienda
config-modal-placeholder-shop-image-url = Ingresa una URL para la imagen de la tienda
config-error-no-channel-selected = No se seleccionó ningún canal para la tienda.
config-error-shop-already-in-channel = Ya hay una tienda registrada en el canal seleccionado. Por favor elige un canal diferente o edita la tienda existente.

# build_shop_header_view
config-label-shopkeeper = {"**"}Tendero:{"**"} { $name }
config-msg-use-shop-command = Usa el comando `/shop` para explorar y comprar objetos.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Crear Tienda en Hilo de Foro
config-modal-label-thread-name = Nombre del Hilo
config-modal-placeholder-thread-name = Ingresa el nombre para el hilo de la tienda
config-error-forum-not-found = No se pudo encontrar el canal de foro seleccionado.
config-error-shop-already-in-thread = Ya hay una tienda registrada en este hilo. Esto no debería ocurrir para un hilo nuevo.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Agregar Nueva Tienda vía JSON
config-modal-label-upload-json = Sube un archivo .json con los datos de la tienda
config-error-no-json-uploaded = No se subió ningún archivo JSON para la tienda.
config-error-file-must-be-json = El archivo subido debe ser un archivo JSON (.json).
config-error-invalid-json = Formato JSON inválido: { $error }
config-error-json-validation-failed = El JSON no cumple con el esquema: { $error }

# ShopItemModal
config-modal-title-shop-item = Agregar/Editar Objeto de Tienda
config-modal-label-item-name = Nombre del Objeto
config-modal-placeholder-item-name = Ingresa el nombre del objeto
config-modal-label-item-description = Descripción del Objeto
config-modal-placeholder-item-description = Ingresa una descripción para el objeto
config-modal-label-item-quantity = Cantidad del Objeto
config-modal-placeholder-item-quantity = Ingresa la cantidad vendida por compra
config-modal-label-item-costs = Costos del Objeto
config-modal-placeholder-item-costs = Ej.: 10 oro + 5 plata\nO: 50 rep\n(Usa + para Y, Nuevas Líneas para O)
config-error-item-quantity-positive = La cantidad del objeto debe ser un número entero positivo.
config-error-cost-format-invalid = Formato de costo inválido en la opción: "{ $option }". Cada costo debe tener una cantidad y una moneda separadas por un espacio, ej. "10 oro".
config-error-cost-amount-invalid = Cantidad inválida "{ $amount }" para la moneda: "{ $currency }". La cantidad debe ser un número positivo.
config-error-unknown-currency = Moneda desconocida `{ $currency }`. Por favor usa una moneda válida configurada para este servidor.
config-error-item-already-exists = Ya existe un objeto llamado { $itemName } en esta tienda.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Actualizar Tienda vía JSON
config-modal-label-upload-new-json = Subir nueva definición JSON
config-error-no-file-uploaded = No se subió ningún archivo.
config-error-file-must-be-json-ext = El archivo debe ser un `.json`.
config-error-json-validation-message = La validación JSON falló: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Agregar/Editar Equipo de Nuevo Personaje
config-modal-placeholder-item-quantity-selection = Ingresa la cantidad recibida por selección
config-modal-label-item-cost = Costo del Objeto
config-error-cost-format-short = Formato de costo inválido: '{ $component }'. Se esperaba 'Cantidad Moneda'.
config-error-amount-invalid-short = Cantidad inválida '{ $amount }' para la moneda '{ $currency }'.
config-error-item-exists-new-char = Ya existe un objeto llamado { $itemName } en la tienda de Nuevo Personaje.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Subir Tienda de Nuevo Personaje (JSON)
config-error-no-json-uploaded-short = No se subió ningún archivo JSON.
config-error-json-must-have-shopstock = El JSON debe contener un arreglo 'shopStock'.
config-error-items-must-have-name-price = Todos los objetos deben tener 'name' y 'price'.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Establecer Riqueza de Nuevo Personaje
config-modal-label-amount = Cantidad
config-modal-placeholder-amount = Ingresa la cantidad de esta moneda.
config-modal-placeholder-currency-name = Ingresa el nombre de una moneda definida en este servidor
config-error-no-currencies-configured = No hay monedas configuradas en este servidor.
config-error-currency-not-found = No se encontró moneda o denominación llamada { $name }. Por favor usa una moneda válida.

# CreateStaticKitModal
config-modal-title-create-kit = Crear Nuevo Kit Estático
config-modal-label-kit-name = Nombre del Kit
config-modal-placeholder-kit-name = ej., Kit Inicial de Guerrero
config-modal-label-description = Descripción
config-modal-placeholder-kit-description = Descripción opcional para este kit
config-error-kit-name-exists = Ya existe un kit estático llamado "{ $kitName }". Por favor elige un nombre diferente.

# StaticKitItemModal
config-modal-title-kit-item = Agregar/Editar Objeto del Kit
config-modal-placeholder-kit-item-quantity = Ingresa la cantidad de este objeto a incluir en el kit

# StaticKitCurrencyModal
config-modal-title-kit-currency = Agregar Moneda al Kit
config-modal-placeholder-currency-eg = ej., Oro
config-modal-placeholder-amount-eg = ej., 100
config-error-amount-must-be-number = La cantidad debe ser un número.
config-error-no-currencies-on-server = No hay monedas configuradas en el servidor.
config-error-currency-not-found-short = Moneda "{ $currency }" no encontrada.
config-error-denomination-not-found = Denominación "{ $denomination }" no encontrada en la configuración de monedas.

# RoleplaySettingsModal
config-modal-title-rp-settings = Configuración de Roleplay
config-modal-label-min-message-length = Longitud Mínima de Mensaje (caracteres)
config-modal-placeholder-min-message-length = # de caracteres requeridos para que un mensaje sea elegible. 0 para sin límite
config-modal-label-cooldown = Enfriamiento (segundos)
config-modal-placeholder-cooldown = Tiempo de espera, en segundos, entre contar mensajes como elegibles para recompensas
config-modal-label-message-threshold = Umbral de Mensajes
config-modal-placeholder-message-threshold = Número de mensajes requeridos para activar la recompensa
config-modal-label-frequency = Frecuencia (# de mensajes)
config-modal-placeholder-frequency = Número de mensajes elegibles requeridos para ganar recompensas
config-error-min-length-invalid = La longitud mínima del mensaje debe ser un número entero no negativo.
config-error-cooldown-invalid = El enfriamiento debe ser un número entero no negativo.
config-error-threshold-invalid = El umbral de mensajes debe ser un número entero positivo.
config-error-frequency-invalid = La frecuencia debe ser un número entero positivo.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Configurar Recompensas de Roleplay
config-modal-label-items-name-quantity = Objetos (Nombre: Cantidad)
config-modal-label-currency-name-amount = Moneda (Nombre: Cantidad)
config-error-experience-non-negative = La experiencia debe ser un número entero no negativo.
config-error-item-quantity-positive-named = La cantidad del objeto para "{ $itemName }" debe ser un número entero positivo.
config-error-currency-amount-positive = La cantidad de moneda para "{ $currencyName }" debe ser un número positivo.

# SetItemStockModal
config-modal-title-stock-limit = Límite de Inventario: { $itemName }
config-modal-label-max-stock = Inventario Máximo
config-modal-placeholder-max-stock = Ingresa el inventario máximo (ej., 10)
config-modal-label-current-stock = Inventario Actual
config-modal-placeholder-current-stock = Ingresa el inventario disponible actual
config-error-max-stock-positive = El inventario máximo debe ser un número entero positivo.
config-error-current-stock-non-negative = El inventario actual debe ser un número entero no negativo.
config-error-current-exceeds-max = El inventario actual no puede exceder el inventario máximo.
config-error-item-not-in-shop = Objeto "{ $itemName }" no encontrado en la tienda.

# RestockScheduleModal
config-modal-title-restock-schedule = Configurar Horario de Reabastecimiento
config-modal-label-schedule = Horario (hourly/daily/weekly/none)
config-modal-placeholder-schedule = Ingresa: hourly, daily, weekly, o none
config-modal-label-time = Hora (HH:MM en UTC)
config-modal-desc-current-time = Hora actual: { $utcTime }
config-modal-placeholder-time = ej., 14:30 para 2:30 PM UTC
config-modal-label-day-of-week = Día de la Semana (0=Lun, 6=Dom) - Solo semanal
config-modal-placeholder-day-of-week = Ingresa 0-6 (Lunes=0, Domingo=6)
config-modal-label-mode = Modo (full/incremental)
config-modal-placeholder-mode = full = restablecer al máximo, incremental = agregar cantidad
config-modal-label-increment = Cantidad Incremental (para modo incremental)
config-modal-placeholder-increment = Cantidad a agregar por ciclo de reabastecimiento
config-error-schedule-invalid = El horario debe ser uno de: hourly, daily, weekly, o none.
config-error-time-format-invalid = La hora debe estar en formato HH:MM (ej., 14:30).
config-error-day-of-week-invalid = El día de la semana debe ser 0-6 (Lunes=0, Domingo=6).
config-error-mode-invalid = El modo debe ser "full" o "incremental".
config-error-increment-positive = La cantidad incremental debe ser un número entero positivo.

# ==========================================
# SELECTORES
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Busca tu canal de { $configName }

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Elige tu Rol de Anuncio de Quest

# AddGMRoleSelect
config-select-placeholder-gm-roles = Elige tu(s) Rol(es) de GM

# ConfigWaitListSelect
config-select-placeholder-wait-list = Selecciona el tamaño de la Lista de Espera
config-select-option-disabled = 0 (Desactivado)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Selecciona el Modo de Inventario
config-select-option-disabled-label = Desactivado
config-select-desc-disabled = Los jugadores comienzan con inventarios vacíos.
config-select-option-selection = Selección
config-select-desc-selection = Los jugadores eligen objetos libremente de la Tienda de Nuevo Personaje.
config-select-option-purchase = Compra
config-select-desc-purchase = Los jugadores compran objetos de la Tienda de Nuevo Personaje con una cantidad dada de moneda.
config-select-option-open = Abierto
config-select-desc-open = Los jugadores ingresan manualmente sus propios inventarios.
config-select-option-static = Estático
config-select-desc-static = Los jugadores reciben un inventario inicial predefinido.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Selecciona los Canales Elegibles

# RoleplayModeSelect
config-select-placeholder-rp-mode = Selecciona el Modo
config-select-option-scheduled = Programado
config-select-desc-scheduled = Las recompensas se otorgan una vez dentro de un período de reinicio especificado.
config-select-option-accrued = Acumulado
config-select-desc-accrued = Las recompensas se otorgan repetidamente según los niveles de actividad especificados.

# RoleplayResetSelect
config-select-placeholder-reset-period = Selecciona el Período de Reinicio
config-select-option-hourly = Cada Hora
config-select-desc-hourly = Se reinicia cada hora.
config-select-option-daily = Diario
config-select-desc-daily = Se reinicia cada 24 horas.
config-select-option-weekly = Semanal
config-select-desc-weekly = Se reinicia cada 7 días.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Selecciona el Día de Reinicio

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Selecciona la Hora de Reinicio (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Selecciona un canal de foro

# ForumThreadSelect
config-select-placeholder-thread = Selecciona un hilo
config-select-option-no-threads = No se encontraron hilos activos
config-select-desc-no-threads = Crea un nuevo hilo o revisa los hilos archivados
config-select-option-select-forum-first = Selecciona un foro primero
config-select-desc-select-forum-first = Por favor selecciona un canal de foro arriba
config-select-desc-thread-id = ID del Hilo: { $threadId }
config-error-select-valid-thread = Por favor selecciona un hilo válido o crea uno nuevo.
config-error-thread-not-found = No se pudo encontrar el hilo seleccionado. Puede haber sido eliminado o archivado.

# ==========================================
# VISTAS
# ==========================================

## Menú Principal
config-title-main-menu = Configuración del Servidor - Menú Principal
config-menu-config-wizard = Asistente de Configuración
config-menu-desc-config-wizard = Valida que tu servidor esté listo para usar ReQuest con un escaneo rápido.
config-menu-channels = Canales
config-menu-desc-channels = Establece los canales designados para las publicaciones de ReQuest.
config-menu-currency = Moneda
config-menu-desc-currency = Configuración global de monedas.
config-menu-players = Jugadores
config-menu-desc-players = Configuración global de jugadores, como el seguimiento de puntos de experiencia.
config-menu-quests = Quests
config-menu-desc-quests = Configuración global de quests, como listas de espera.
config-menu-rp-rewards = Recompensas de RP
config-menu-desc-rp-rewards = Configura las recompensas de roleplay.
config-menu-roles = Roles
config-menu-desc-roles = Opciones de configuración para roles con mención o privilegios.
config-menu-shops = Tiendas
config-menu-desc-shops = Configura tiendas personalizadas.
config-menu-language = Idioma
config-menu-desc-language = Establece el idioma predeterminado para este servidor.

## Vista del Asistente
config-title-wizard = {"**"}Configuración del Servidor - Asistente{"**"}
config-wizard-intro =
    {"**"}¡Bienvenido al Asistente de Configuración de ReQuest!{"**"}

    Este asistente te ayudará a asegurarte de que tu servidor esté correctamente configurado para usar las funciones de ReQuest.
    Escaneará tu configuración actual y proporcionará recomendaciones para los ajustes necesarios.

    Usa el botón "Iniciar Escaneo" a continuación para comenzar el proceso de validación. Una vez completado el escaneo,
    recibirás un informe detallado de la configuración de tu servidor junto con los cambios recomendados.

# Asistente - Validación de Permisos del Bot
config-wizard-bot-permissions-header = __{"**"}Permisos Globales del Bot{"**"}__
config-wizard-bot-permissions-desc = Esta sección verifica que ReQuest tenga los permisos correctos para funcionar correctamente.
config-wizard-bot-role = Rol del Bot: { $roleMention }
config-wizard-status-warnings = {"**"}Estado: ⚠️ ADVERTENCIAS ENCONTRADAS{"**"}
config-wizard-missing-perm = - ⚠️ Falta: `{ $permissionName }`
config-wizard-ensure-permissions = Por favor asegúrate de que el rol más alto del bot tenga estos permisos otorgados globalmente.
config-wizard-status-ok = {"**"}Estado: ✅ OK{"**"}
config-wizard-bot-permissions-ok = El bot tiene todos los permisos globales requeridos.
config-wizard-status-scan-failed = {"**"}Estado: ❌ ESCANEO FALLIDO{"**"}
config-wizard-scan-error = Ocurrió un error inesperado al verificar los permisos del bot.
config-wizard-error-type = Error: { $errorType }
config-wizard-required-permissions = {"**"}Permisos Requeridos para el Rol del Bot:{"**"}

# Asistente - Nombres de permisos
config-wizard-perm-view-channels = Ver Canales
config-wizard-perm-manage-roles = Administrar Roles
config-wizard-perm-send-messages = Enviar Mensajes
config-wizard-perm-attach-files = Adjuntar Archivos
config-wizard-perm-add-reactions = Agregar Reacciones
config-wizard-perm-use-external-emoji = Usar Emojis Externos
config-wizard-perm-manage-messages = Administrar Mensajes
config-wizard-perm-read-message-history = Leer Historial de Mensajes

# Asistente - Validación de Roles
config-wizard-role-header = __{"**"}Configuraciones de Roles{"**"}__
config-wizard-role-desc =
    Esta sección verifica lo siguiente:

    - Los roles de GM (requeridos) y el rol de Anuncio (opcional) están configurados.
    - El rol predeterminado (@everyone) tiene los permisos requeridos para que los usuarios accedan a las funciones del bot.
    - El rol predeterminado (@everyone) no tiene permisos peligrosos.
    - Los roles de GM y Anuncio se verifican para ver si tienen escalaciones de permisos más allá del rol predeterminado.

    Las advertencias aquí son únicamente recomendaciones basadas en una configuración predeterminada. Dependiendo de las necesidades de tu servidor, puedes tener razones para ignorar algunas de estas recomendaciones.

config-wizard-default-role-label = {"**"}Rol Predeterminado:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Permisos Peligrosos Encontrados:
config-wizard-default-role-ok = - ✅ @everyone: OK
config-wizard-missing-permission = - Permiso Faltante: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}Roles de GM:{"**"}
config-wizard-no-gm-roles = - ⚠️ No Hay Roles de GM Configurados
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Rol Configurado No Encontrado/Eliminado del Servidor
config-wizard-role-ok = - ✅ { $roleMention }: OK
config-wizard-announcement-role-label = {"**"}Rol de Anuncio:{"**"}
config-wizard-no-announcement-role = - ℹ️ No Hay Rol de Anuncio Configurado
config-wizard-announcement-role-not-found = - ⚠️ Rol Configurado No Encontrado/Eliminado del Servidor
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Escalaciones de Permisos Detectadas - { $escalations }
config-wizard-escalation-more = , y { $count } más...

# Asistente - Permisos Predeterminados Requeridos
config-wizard-perm-send-messages-in-threads = Enviar Mensajes en Hilos
config-wizard-perm-use-application-commands = Usar Comandos de Aplicación

# Asistente - Permisos Peligrosos
config-wizard-perm-manage-channels = Administrar Canales
config-wizard-perm-manage-webhooks = Administrar Webhooks
config-wizard-perm-manage-server = Administrar Servidor
config-wizard-perm-manage-nicknames = Administrar Apodos
config-wizard-perm-kick-members = Expulsar Miembros
config-wizard-perm-ban-members = Banear Miembros
config-wizard-perm-timeout-members = Silenciar Miembros
config-wizard-perm-mention-everyone = Mencionar a @everyone
config-wizard-perm-manage-threads = Administrar Hilos
config-wizard-perm-administrator = Administrador

# Asistente - Validación de Canales
config-wizard-channel-header = __{"**"}Configuraciones de Canales{"**"}__
config-wizard-channel-desc =
    Esta sección verifica lo siguiente:

    - Los canales configurados existen.
    - El bot tiene permiso para ver y enviar mensajes en los canales configurados.
    - El rol predeterminado (@everyone) no tiene permisos de `Enviar Mensajes`.

config-wizard-channel-no-config-required = - ⚠️ Sin Canal Configurado
config-wizard-channel-not-configured = - ℹ️ No Configurado (Opcional)
config-wizard-channel-not-found = - ⚠️ Canal Configurado No Encontrado/Eliminado del Servidor
config-wizard-channel-ok = - ✅ OK
config-wizard-bot-cannot-view = - ⚠️ { $botMention } no puede ver este canal.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } no puede enviar mensajes en este canal.
config-wizard-everyone-can-send = - ⚠️ @everyone puede enviar mensajes en este canal.

# Asistente - Nombres de canales
config-wizard-channel-quest-board = Tablero de Quests
config-wizard-channel-player-board = Tablero de Jugadores
config-wizard-channel-quest-archive = Archivo de Quests
config-wizard-channel-gm-transaction-log = Registro de Transacciones de GM
config-wizard-channel-player-transaction-log = Registro de Transacciones de Jugadores
config-wizard-channel-shop-log = Registro de Tienda
config-wizard-channel-approval-queue = Cola de Aprobación de Personajes

# Asistente - Panel de Control
config-wizard-dashboard-header = __{"**"}Panel de Configuración{"**"}__
config-wizard-dashboard-desc = Esta sección proporciona una vista general de las configuraciones no esenciales como referencia rápida.
config-wizard-quest-settings = {"**"}Configuración de Quests{"**"}
config-wizard-quest-wait-list = - Tamaño de Lista de Espera de Quest: { $size }
config-wizard-quest-summary = - Resumen de Quest: { $status }
config-wizard-gm-rewards-per-quest = {"**"}Recompensas de GM (Por Quest){"**"}
config-wizard-player-settings = {"**"}Configuración de Jugadores{"**"}
config-wizard-player-experience = - Experiencia de Jugador: { $status }
config-wizard-currency-settings = {"**"}Configuración de Moneda{"**"}
config-wizard-rp-rewards = {"**"}Recompensas de Roleplay{"**"}
config-wizard-rp-status = - Estado: { $status }
config-wizard-rp-mode = - Modo: { $mode }
config-wizard-rp-channels = - Canales Monitoreados: { $count }
config-wizard-shops = {"**"}Tiendas{"**"}
config-wizard-shops-count = - Tiendas Configuradas: { $count }
config-wizard-shops-more = - ...y { $count } más
config-wizard-new-char-setup = {"**"}Configuración de Nuevo Personaje{"**"}
config-wizard-inventory-type = - Tipo de Inventario: { $type }
config-wizard-new-char-shop-items = - Objetos de la Tienda de Nuevo Personaje: { $count }
config-wizard-static-kits = - Kits Estáticos: { $count }

# Asistente - Informe de Recompensas de GM
config-wizard-no-currencies = - ℹ️ No Hay Monedas Configuradas
config-wizard-configured-currencies = {"**"}Monedas Configuradas:{"**"}
config-wizard-no-denominations = - Sin Denominaciones Configuradas
config-wizard-gm-rewards-disabled = {"**"}Estado:{"**"} Desactivado
config-wizard-gm-rewards-enabled = {"**"}Estado:{"**"} Activado
config-wizard-gm-rewards-experience = - Experiencia: { $xp }
config-wizard-gm-rewards-items = - Objetos:
config-wizard-unnamed-shop = Tienda Sin Nombre

## Vista de Roles
config-title-roles = {"**"}Configuración del Servidor - Roles{"**"}
config-label-announcement-role = {"**"}Rol de Anuncio:{"**"} { $status }
config-desc-announcement-role = Este rol se menciona cuando se publica un quest.
config-label-announcement-role-default = {"**"}Rol de Anuncio:{"**"} No Configurado
config-label-gm-roles = {"**"}Rol(es) de GM:{"**"} { $roles }
config-desc-gm-roles = Estos roles otorgarán acceso a los comandos y funciones de Game Master.
config-label-gm-roles-default = {"**"}Rol(es) de GM:{"**"} No Configurado
config-title-forbidden-roles = __{"**"}Roles Prohibidos{"**"}__
config-desc-forbidden-roles =
    Configura una lista de nombres de roles que no pueden ser usados por los Game Masters para sus roles de grupo.
    Por defecto, `everyone`, `administrator`, `gm`, y `game master` no pueden ser usados. Esta configuración
    extiende esa lista.

## Vista de Eliminación de Rol de GM
config-title-remove-gm-roles = {"**"}Configuración del Servidor - Eliminar Rol(es) de GM{"**"}
config-msg-no-gm-roles = No hay roles de GM configurados.

## Vista de Canales
config-title-channels = {"**"}Configuración del Servidor - Canales{"**"}

config-label-quest-board = {"**"}Tablero de Quests:{"**"} { $channel }
config-desc-quest-board = El canal donde se publicarán los quests nuevos/activos.
config-label-quest-board-default = {"**"}Tablero de Quests:{"**"} No Configurado

config-label-player-board = {"**"}Tablero de Jugadores:{"**"} { $channel }
config-desc-player-board = Un canal opcional de anuncios/mensajes para uso de los jugadores.
config-label-player-board-default = {"**"}Tablero de Jugadores:{"**"} No Configurado

config-label-quest-archive = {"**"}Archivo de Quests:{"**"} { $channel }
config-desc-quest-archive = Un canal opcional donde los quests completados se moverán, con información de resumen.
config-label-quest-archive-default = {"**"}Archivo de Quests:{"**"} No Configurado

config-label-gm-transaction-log = {"**"}Registro de Transacciones de GM:{"**"} { $channel }
config-desc-gm-transaction-log = Un canal opcional donde se registran las transacciones de GM (es decir, comandos de Modificar Jugador).
config-label-gm-transaction-log-default = {"**"}Registro de Transacciones de GM:{"**"} No Configurado

config-label-player-transaction-log = {"**"}Registro de Transacciones de Jugadores:{"**"} { $channel }
config-desc-player-transaction-log = Un canal opcional donde se registran las transacciones de jugadores como intercambios y consumo de objetos.
config-label-player-transaction-log-default = {"**"}Registro de Transacciones de Jugadores:{"**"} No Configurado

config-label-shop-log = {"**"}Registro de Tienda:{"**"} { $channel }
config-desc-shop-log = Un canal opcional donde se registran las transacciones de tienda.
config-label-shop-log-default = {"**"}Registro de Tienda:{"**"} No Configurado

## Vista de Quests
config-title-quests = {"**"}Configuración del Servidor - Quests{"**"}

config-label-wait-list = {"**"}Tamaño de Lista de Espera de Quest:{"**"} { $size }
config-desc-wait-list = Una lista de espera permite que el número especificado de jugadores se pongan en cola para un quest que está lleno, en caso de que un jugador se retire.
config-label-wait-list-disabled = {"**"}Tamaño de Lista de Espera de Quest:{"**"} Desactivado

config-label-quest-summary = {"**"}Resumen de Quest:{"**"} { $status }
config-desc-quest-summary = Esta opción permite a los GMs proporcionar un breve resumen al cerrar quests.
config-label-quest-summary-disabled = {"**"}Resumen de Quest:{"**"} Desactivado

config-label-gm-rewards = Recompensas de GM
config-desc-gm-rewards = Configura las recompensas que los GMs recibirán al completar quests.

## Vista de Recompensas de GM
config-title-gm-rewards = {"**"}Configuración del Servidor - Recompensas de GM{"**"}
config-desc-gm-rewards-detail =
    {"**"}Agregar/Modificar Recompensas{"**"}
    Abre un modal de entrada para agregar, modificar o eliminar recompensas de GM.

    > Las recompensas configuradas son por quest. Cada vez que un Game Master complete un quest, recibirá
    las recompensas configuradas a continuación en su personaje activo.
config-msg-no-rewards = No hay recompensas configuradas.
config-label-gm-experience = {"**"}Experiencia:{"**"} { $xp }
config-label-gm-items = {"**"}Objetos:{"**"}

## Vista de Jugadores
config-title-players = {"**"}Configuración del Servidor - Jugadores{"**"}

config-label-player-experience = {"**"}Experiencia de Jugador:{"**"} { $status }
config-desc-player-experience = Activa/Desactiva el uso de puntos de experiencia (o progresión de personaje basada en valores similares).
config-label-player-experience-disabled = {"**"}Experiencia de Jugador:{"**"} Desactivado

config-label-new-char-settings = {"**"}Configuración de Nuevo Personaje{"**"}
config-desc-new-char-settings = Configura los ajustes relacionados con nuevos personajes de jugador y cómo se configuran sus inventarios iniciales.

config-label-player-board-purge = {"**"}Purga del Tablero de Jugadores{"**"}
config-desc-player-board-purge = Purga publicaciones del tablero de jugadores (si está habilitado).

## Vista de Configuración de Nuevo Personaje
config-title-new-character = {"**"}Configuración del Servidor - Configuración de Nuevo Personaje{"**"}

config-label-inventory-type = {"**"}Tipo de Inventario de Nuevo Personaje:{"**"} { $type }
config-desc-inventory-type = Determina cómo los personajes recién registrados inicializan sus inventarios.
config-label-inventory-type-disabled = {"**"}Tipo de Inventario de Nuevo Personaje:{"**"} Desactivado

config-label-new-char-wealth = {"**"}Riqueza de Nuevo Personaje:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Riqueza de Nuevo Personaje:{"**"} Desactivado

config-label-approval-queue = {"**"}Cola de Aprobación:{"**"} { $channel }
config-desc-approval-queue = Si se establece, los nuevos personajes deben ser aprobados por un GM en este canal de Foro antes de estar activos.
config-label-approval-queue-disabled = {"**"}Cola de Aprobación:{"**"} Desactivado
config-label-approval-queue-not-configured = {"**"}Cola de Aprobación:{"**"} No Configurado

# Descripciones de tipo de inventario (usadas en la configuración)
config-desc-inv-type-disabled = Los jugadores comienzan con inventarios vacíos.
config-desc-inv-type-selection = Los jugadores eligen objetos libremente de la Tienda de Nuevo Personaje.
config-desc-inv-type-purchase = Los jugadores compran objetos de la Tienda de Nuevo Personaje con una cantidad dada de moneda.
config-desc-inv-type-open = Los jugadores ingresan manualmente los objetos de su inventario.
config-desc-inv-type-static = Los jugadores reciben un inventario inicial predefinido.

## Vista de Tienda de Nuevo Personaje
config-title-new-char-shop = {"**"}Configuración del Servidor - Tienda de Nuevo Personaje{"**"}
config-label-inv-type-selection = {"**"}Tipo de Inventario:{"**"} Selección
config-desc-inv-type-selection-shop = Los jugadores eligen objetos libremente de la Tienda de Nuevo Personaje.
config-label-inv-type-purchase = {"**"}Tipo de Inventario:{"**"} Compra
config-desc-inv-type-purchase-shop = Los jugadores compran objetos de la Tienda de Nuevo Personaje con una cantidad dada de moneda.
config-label-inv-type-other = {"**"}Tipo de Inventario:{"**"} { $type }
config-desc-inv-type-not-in-use = La Tienda de Nuevo Personaje no está en uso.
config-msg-define-shop-items = Define los objetos de la tienda.
config-msg-no-items = No hay objetos configurados.

## Vista de Kits Estáticos
config-title-static-kits = {"**"}Configuración del Servidor - Kits Estáticos{"**"}
config-desc-create-kit = Crear una nueva definición de kit.
config-msg-no-kits = No hay kits configurados.
config-label-kit-more-items = ...y { $count } objetos más
config-label-empty-kit = {"*"}Kit Vacío{"*"}

## Vista de Edición de Kit Estático
config-title-editing-kit = {"**"}Editando Kit: { $kitName }{"**"}
config-msg-kit-empty = Este kit está vacío. Usa los botones de arriba para agregar moneda u objetos.
config-label-kit-currency = {"**"}Moneda:{"**"} { $display }
config-label-kit-item = {"**"}Objeto:{"**"} { $name }

## Vista de Moneda
config-title-currency = {"**"}Configuración del Servidor - Moneda{"**"}
config-desc-create-currency = Crear una nueva moneda.
config-msg-no-currencies = No hay monedas configuradas.
config-label-currency-display-type = Tipo de Visualización: { $type } | Denominaciones: { $count }
config-label-currency-type-double = Doble
config-label-currency-type-integer = Entero

## Vista de Edición de Moneda
config-title-manage-currency = {"**"}Administrar Moneda: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Moneda y Denominaciones{"**"}__
    - El nombre dado a tu moneda se considera la moneda base y tiene un valor de 1.
    {"```"}Ejemplo: "oro" está configurado como moneda.{"```"}
    - Agregar una denominación requiere especificar un nombre y un valor relativo a la moneda base.
    {"```"}Ejemplo: Al oro se le dan dos denominaciones: plata (valor de 0.1), y cobre (valor de 0.01).{"```"}
    - Cualquier transacción que involucre una moneda base o sus denominaciones las convertirá automáticamente.
    {"```"}Ejemplo: Un jugador tiene 10 de oro y gasta 3 de cobre. Su nuevo saldo se mostrará automáticamente como
    9 de oro, 9 de plata y 7 de cobre.{"```"}
    - Las monedas mostradas como entero mostrarán cada denominación, mientras que las monedas mostradas como doble
    se mostrarán solo como la moneda base.
    {"```"}Ejemplo: El jugador de arriba con visualización doble activada se mostrará como 9.97 de oro.{"```"}
config-btn-toggle-display-current = Alternar Visualización (Actual: { $type })
config-msg-no-denominations = No hay denominaciones configuradas.

## Vista de Tiendas
config-title-shops = {"**"}Configuración del Servidor - Tiendas{"**"}
config-desc-add-shop-wizard =
    {"**"}Agregar Tienda (Asistente){"**"}
    Crear una nueva tienda vacía desde un formulario.
config-desc-add-shop-json =
    {"**"}Agregar Tienda (JSON){"**"}
    Crear una nueva tienda proporcionando una definición JSON completa. (Avanzado)
config-btn-example-json = JSON de Ejemplo
config-desc-example-json =
    {"**"}JSON de Ejemplo{"**"}
    Descarga un archivo JSON de ejemplo que muestra el formato esperado.
config-msg-example-json = Aquí tienes un archivo JSON de ejemplo que muestra el formato esperado.
config-msg-no-shops = No hay tiendas configuradas.
config-label-shop-type-forum = (Foro)
config-label-shop-channel = Canal: <#{ $channelId }>

## Vista de Selección de Tipo de Canal de Tienda
config-title-choose-location = {"**"}Agregar Tienda - Elegir Tipo de Ubicación{"**"}
config-label-text-channel = {"**"}Canal de Texto{"**"}
config-desc-text-channel = Crear una tienda en un canal de texto estándar.
config-label-forum-thread = {"**"}Hilo de Foro{"**"}
config-desc-forum-thread = Crear una tienda en un hilo de foro (nuevo o existente).

## Vista de Configuración de Tienda en Foro
config-title-forum-setup = {"**"}Agregar Tienda - Configuración de Hilo de Foro{"**"}
config-label-step1 = {"**"}Paso 1: Selecciona un Canal de Foro{"**"}
config-label-step2 = {"**"}Paso 2: Elige una Opción de Hilo{"**"}
config-label-step3 = {"**"}Paso 3: Selecciona un Hilo Existente{"**"}
config-desc-create-new-thread =
    {"**"}Crear Nuevo Hilo{"**"}
    Abre un formulario para crear un nuevo hilo y configurar la tienda.
config-label-selected-thread = {"**"}Hilo Seleccionado:{"**"} { $threadName }
config-desc-click-to-configure = Haz clic para configurar la tienda en este hilo.

## Vista de Administración de Tienda
config-title-manage-shop = {"**"}Administrar Tienda: { $shopName }{"**"}
config-label-shop-type = {"**"}Tipo:{"**"} { $type }
config-label-shop-type-text = Canal de Texto
config-label-shop-type-forum-thread = Hilo de Foro
config-label-shopkeeper = {"**"}Tendero:{"**"} { $name }
config-label-shop-description = {"**"}Descripción:{"**"} { $description }
config-label-shop-channel-info = {"**"}Canal:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Editar detalles y objetos de la tienda vía Asistente.
config-desc-upload-json = Subir una nueva definición JSON para esta tienda.
config-desc-download-json = Descargar la definición JSON actual.
config-desc-remove-shop = Eliminar esta tienda permanentemente.

## Vista de Edición de Tienda
config-title-editing-shop = {"**"}Editando Tienda: { $shopName }{"**"}
config-label-shop-shopkeeper = Tendero: {"**"}{ $name }{"**"}

## Vista de Límites de Inventario
config-title-stock-config = {"**"}Configuración de Inventario: { $shopName }{"**"}
config-label-current-utc = Hora UTC Actual: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Horario de Reabastecimiento:{"**"} { $schedule }
config-label-restock-hourly = en el minuto :{ $minute }
config-label-restock-daily = a las { $time } UTC
config-label-restock-weekly = el { $day } a las { $time } UTC
config-label-restock-mode = {"**"}Modo:{"**"} { $mode }
config-label-restock-full = Reabastecimiento completo
config-label-restock-incremental = Agregar { $amount } por ciclo (hasta el máximo)
config-label-restock-disabled = {"**"}Horario de Reabastecimiento:{"**"} Desactivado
config-label-item-stock-limits = {"**"}Límites de Inventario por Objeto{"**"}
config-msg-no-items-in-shop = No hay objetos en esta tienda.
config-label-stock-with-available = Máx: { $max } | Disponible: { $available }
config-label-stock-reserved = | Reservado: { $reserved }
config-label-stock-not-initialized = Máx: { $max } | Disponible: (no inicializado)
config-label-stock-unlimited = Inventario: Ilimitado

## Vista de Roleplay
config-title-roleplay = {"**"}Configuración del Servidor - Recompensas de Roleplay{"**"}
config-label-rp-status = {"**"}Estado:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Hora del Servidor:{"**"} `{ $time }`
config-label-rp-enabled = Activado
config-label-rp-disabled = Desactivado

config-desc-rp-mode-scheduled = {"```"}Las recompensas se distribuyen una vez, al enviar el umbral requerido de mensajes elegibles dentro del período de tiempo establecido (cada hora, diario o semanal).{"```"}
config-desc-rp-mode-accrued = {"```"}Las recompensas se distribuyen de forma recurrente cada vez que se envía un número determinado de mensajes elegibles.{"```"}

config-label-rp-config-details = {"**"}Detalles de Configuración:{"**"}
config-label-rp-mode = {"**"}Modo:{"**"} { $mode }
config-label-rp-min-length = {"**"}Longitud Mínima de Mensaje:{"**"} { $length } caracteres
config-label-rp-cooldown = {"**"}Enfriamiento:{"**"} { $seconds } segundos
config-label-rp-frequency-once = {"**"}Frecuencia:{"**"} Una vez por { $period }
config-label-rp-reset-time = {"**"}Hora de Reinicio:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Umbral:{"**"} { $count } mensajes elegibles
config-label-rp-frequency-every = {"**"}Frecuencia:{"**"} Cada { $count } mensajes elegibles

config-label-rp-channels = {"**"}Canales de Roleplay:{"**"}
config-msg-rp-no-channels = Ninguno configurado.
config-label-rp-channels-more = ...y { $count } más.

config-label-rp-rewards = {"**"}Recompensas:{"**"}
config-msg-rp-no-rewards = Ninguna configurada.
config-label-rp-experience = {"**"}Experiencia:{"**"} { $xp }
config-label-rp-items = {"**"}Objetos:{"**"}
config-label-rp-currency = {"**"}Moneda:{"**"}

## Vista de Idioma
config-title-language = {"**"}Configuración del Servidor - Idioma{"**"}
config-server-language-help =
    Esta configuración te permite especificar el idioma predeterminado para las respuestas y mensajes {"**"}públicos{"**"} de ReQuest en este servidor. Las respuestas públicas incluyen:
    - Publicaciones del Tablero de Quests y del Tablero de Jugadores
    - Mensajes de Resumen de Quest y del Canal de Registro
    - Reabastecimiento de tiendas
    - Consumo de objetos por jugadores

    Esta configuración solo afecta el texto estático generado por el bot, y no traduce contenido dinámico como nombres de objetos ingresados por usuarios o descripciones de quests.

    Las respuestas y menús personales no se ven afectados por esta configuración.
config-label-server-language = {"**"}Idioma del Servidor:{"**"} { $language }
config-label-server-language-default = {"**"}Idioma del Servidor:{"**"} Predeterminado (sin anulación)
config-select-placeholder-server-language = Selecciona el idioma del servidor
config-select-option-default = Predeterminado (sin anulación)
config-select-desc-default = Usa la preferencia de cada usuario o la configuración regional de Discord.

# Quest Roles
config-btn-quest-roles = Quest Roles
config-btn-manage-gm-quest-roles = Manage

config-modal-title-confirm-quest-role-removal = Confirm Role Removal
config-modal-label-remove-quest-role = Remove { $roleName } from { $gmName }?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Select Quest Role Mode
config-select-option-quest-role-disabled = Disabled
config-select-desc-quest-role-disabled = No roles are created or assigned.
config-select-option-quest-role-temporary = Temporary
config-select-desc-quest-role-temporary = GMs can create temporary roles per quest.
config-select-option-quest-role-static = Static
config-select-desc-quest-role-static = GMs pick from pre-assigned server roles.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Assign server role(s) to this GM

## Quest Roles View
config-title-quest-roles = {"**"}Server Configuration - Quest Roles{"**"}
config-label-quest-roles = Quest Roles
config-desc-quest-roles =
    Configure how party roles are handled during quests.

config-label-quest-role-mode-disabled = {"**"}Quest Role Mode:{"**"} Disabled
    No roles are created or assigned during quests.
config-label-quest-role-mode-temporary = {"**"}Quest Role Mode:{"**"} Temporary
    GMs can optionally create a temporary role during quest creation.
    The role is deleted when the quest completes or is cancelled.
config-label-quest-role-mode-static = {"**"}Quest Role Mode:{"**"} Static
    GMs pick from pre-assigned server roles. Roles are assigned to
    party members during quests but are never deleted.

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}Server Configuration - Static Quest Role Assignments{"**"}
config-label-manage-assignments = Manage Role Assignments
config-desc-manage-assignments =
    Assign existing server roles to GMs for use during quests.
    Roles must be lower than ReQuest's highest role in the server hierarchy.
config-msg-no-gm-members = No members with a GM role were found on this server.
config-label-no-roles-assigned = No quest roles assigned

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}Manage Quest Roles — { $gmName }{"**"}
config-error-unmanageable-roles = The following roles cannot be assigned because they are managed by an integration, are the default role, or are above ReQuest's highest role: { $roles }
