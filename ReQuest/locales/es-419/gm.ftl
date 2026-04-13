## Cadenas del módulo de Game Master

# Botones de GM
gm-btn-create = Crear
gm-btn-edit-details = Editar Quest
gm-btn-toggle-ready = Alternar Listo
gm-btn-configure-rewards = Configurar Recompensas
gm-btn-remove-player = Eliminar Jugador
gm-btn-cancel-quest = Cancelar Quest
gm-btn-manage-party-rewards = Administrar Recompensas del Grupo
gm-btn-manage-individual-rewards = Administrar Recompensas Individuales
gm-btn-join = Unirse
gm-btn-leave = Salir
gm-btn-complete-quest = Completar Quest
gm-btn-edit-details-modal = Editar Detalles
gm-btn-edit-images = Editar Imágenes
gm-btn-publish = Publicar
gm-btn-update-post = Actualizar Publicación
gm-select-placeholder-party-role = Selecciona un rol de grupo...
gm-modal-title-edit-details = Editar Detalles del Quest
gm-modal-title-edit-images = Editar Imágenes del Quest

# Modales de GM
gm-modal-title-create-quest = Crear Nuevo Quest
gm-modal-label-quest-title = Título del Quest
gm-modal-placeholder-quest-title = Título de tu quest
gm-modal-label-restrictions = Restricciones
gm-modal-placeholder-restrictions = Restricciones, si las hay, como niveles de jugador
gm-modal-label-max-party = Tamaño Máximo del Grupo
gm-modal-placeholder-max-party = Tamaño máximo del grupo para este quest
gm-modal-label-party-role = Rol del Grupo
gm-modal-placeholder-party-role = Crear un rol para este quest (Opcional)
gm-modal-label-description = Descripción
gm-modal-placeholder-description = Escribe los detalles de tu quest aquí
gm-modal-label-image-url = URL de Miniatura
gm-modal-label-large-image-url = URL de Imagen Grande
gm-modal-placeholder-image-url = Ingresa una URL de imagen (o deja en blanco para eliminar)
gm-modal-title-add-reward = Agregar Recompensa
gm-modal-label-experience = Puntos de Experiencia
gm-modal-placeholder-experience = Ingresa un número
gm-modal-label-items = Objetos
gm-modal-placeholder-items =
    objeto: cantidad
    objeto2: cantidad
    etc.
gm-modal-title-add-summary = Agregar Resumen del Quest
gm-modal-label-summary = Resumen
gm-modal-placeholder-summary = Agrega un resumen narrativo del quest
gm-modal-title-modifying-player = Modificando a { $playerName }
gm-modal-placeholder-xp-add-remove = Ingresa un número positivo o negativo.
gm-modal-label-inventory = Inventario
gm-modal-placeholder-inventory-modify =
    objeto: cantidad
    objeto2: cantidad
    etc.

# Errores de GM
gm-error-no-quest-channel = Aún no se ha designado un canal para publicaciones de quests. Contacta a un administrador del servidor para configurar el Canal de Quests.
gm-error-invalid-item-format = Formato de objeto inválido: "{ $item }". Cada objeto debe estar en una nueva línea, con el formato "Nombre: Cantidad".
gm-error-already-on-quest = Ya estás en este quest como { $characterName }.
gm-error-no-active-character-long = No tienes un personaje activo en este servidor. Usa `/player` para registrar o activar un personaje.
gm-error-quest-locked = Error al unirse al quest {"**"}{ $questTitle }{"**"}: El quest está bloqueado por el GM.
gm-error-quest-full = Error al unirse al quest {"**"}{ $questTitle }{"**"}: ¡La lista del grupo está llena!
gm-error-not-signed-up = No estás inscrito en este quest.
gm-error-quest-not-found = La misión ya no existe.
gm-error-quest-channel-not-set = ¡El canal de quests no ha sido configurado!
gm-error-empty-roster = No puedes completar un quest con una lista vacía. Intenta cancelarlo en su lugar.
gm-error-invalid-xp-value = ¡El valor de XP debe ser un número entero positivo!
gm-error-party-size-positive = El tamaño del grupo debe ser un número positivo.
gm-error-party-size-too-small = El tamaño del grupo no puede ser menor que el grupo actual ({ $currentSize } miembros).
gm-error-role-name-forbidden = El nombre del rol "{ $roleName }" está prohibido en este servidor.
gm-error-role-name-exists = Ya existe un rol llamado "{ $roleName }" en este servidor.

# Modales de confirmación de GM
gm-modal-title-cancel-quest = Cancelar Quest
gm-modal-label-cancel-quest = Escribe CONFIRMAR para cancelar el quest.
gm-modal-title-remove-from-quest = Eliminar personaje del quest
gm-modal-label-remove-from-quest = ¿Confirmar eliminación del personaje?

# GM DM embeds
gm-dm-title-quest-cancelled = Quest Cancelado
gm-dm-desc-quest-cancelled = El quest {"**"}{ $questTitle }{"**"} fue cancelado por el GM.
gm-dm-title-quest-ready = Quest Listo
gm-dm-desc-quest-ready = ¡El quest {"**"}{ $questTitle }{"**"} ya está listo! Tu GM comenzará el quest pronto.
gm-dm-title-player-removed = Eliminado del Quest
gm-dm-desc-player-removed = Fuiste eliminado del quest {"**"}{ $questTitle }{"**"} por el GM.
gm-dm-desc-player-removed-waitlist = Fuiste eliminado de la lista de espera para {"**"}{ $questTitle }{"**"}.
gm-dm-title-party-promotion = Promoción al Grupo
gm-dm-desc-party-promotion =
    Has sido promovido al grupo principal de {"**"}{ $questTitle }{"**"}
    porque un jugador dejó el quest.
gm-dm-title-roster-locked = Lista Bloqueada
gm-dm-desc-roster-locked =
    La lista del grupo para {"**"}{ $questTitle }{"**"} ha sido bloqueada
    y todos los miembros del grupo han sido notificados.
gm-dm-title-roster-unlocked = Lista Desbloqueada
gm-dm-desc-roster-unlocked = La lista del grupo para {"**"}{ $questTitle }{"**"} ha sido desbloqueada.
gm-dm-title-player-removed-confirm = Jugador Eliminado
gm-dm-desc-player-removed-confirm =
    El jugador ha sido eliminado de {"**"}{ $questTitle }{"**"}
    y la lista del quest ha sido actualizada.
gm-dm-footer-quest = ID del Quest: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    El administrador de tu servidor ha configurado recompensas para los Game Masters al completar
    quests. Sin embargo, como no tienes personajes registrados, tus recompensas no pudieron
    ser emitidas automáticamente en este momento.
gm-dm-rewards-no-active-character =
    El administrador de tu servidor ha configurado recompensas para los Game Masters al completar
    quests. Sin embargo, como no tienes un personaje activo en este servidor, tus recompensas no pudieron
    ser emitidas automáticamente en este momento.
gm-dm-rewards-issued = Lo siguiente ha sido otorgado a tu personaje activo, { $characterName }
gm-dm-role-removal-failed =
    ⚠️ No se pudo eliminar el rol {"**"}{ $roleName }{"**"} de los siguientes miembros: { $members }.
    Notifica a un administrador del servidor para eliminar el rol manualmente.
gm-dm-role-not-found =
    ⚠️ El rol de quest (ID: { $roleId }) para el quest {"**"}{ $questTitle }{"**"} ya no existe en el servidor.
    Las operaciones de rol fueron omitidas. Notifica a un administrador del servidor si esto es inesperado.

# Menús de selección de GM
gm-select-placeholder-party-member = Selecciona un miembro del grupo
gm-select-option-no-role = Ninguno (Sin Rol de Grupo)

# Embeds de GM
gm-embed-title-mod-report = Informe de Modificación de Jugador por GM
gm-embed-field-experience = Experiencia
gm-embed-title-quest-complete = Quest Completado: { $questTitle }
gm-embed-title-quest-completed = QUEST COMPLETADO: { $questTitle }
gm-embed-field-rewards = Recompensas
gm-embed-field-party = __Grupo__
gm-embed-field-summary = Resumen
gm-embed-title-gm-rewards = Recompensas de GM Emitidas
gm-embed-field-items = Objetos

# Vistas de GM
gm-title-main-menu = Game Master - Menú Principal
gm-menu-quests = Misiones
gm-menu-desc-quests = Crear, editar y administrar quests.
gm-menu-players = Jugadores
gm-menu-desc-players = Administrar inventarios de jugadores y modificar personajes.

gm-title-quest-management = Game Master - Administración de Quests
gm-desc-create-quest = Crear un nuevo quest.
gm-msg-no-quests = No se encontraron quests.
gm-label-quest-locked = (Bloqueado)
gm-label-quest-draft = (Borrador)
gm-title-manage-quest = Administrar Quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Editar detalles del quest como título, descripción y tamaño del grupo.
gm-label-field-not-set = No establecido
gm-label-description-not-set = Descripción no establecida
gm-label-current-party-size = {"**"}Tamaño Máx. del Grupo:{"**"} { $value }
gm-label-current-party-role = {"**"}Rol del Grupo:{"**"} { $value }
gm-desc-toggle-ready = Alternar estado de preparación (Actual: {"**"}{ $status }{"**"})
    - Bloquea la lista del grupo y notifica a los miembros que el quest comenzará pronto. Si un rol está configurado, se asignará a los miembros del grupo al bloquearse.
    - Desbloquea la lista cuando se establece en Abierto.
gm-label-ready-locked = Bloqueado/Listo
gm-label-ready-open = Abierto
gm-desc-configure-rewards = Configurar recompensas para el quest seleccionado.
gm-desc-complete-quest = Completar un quest. Emite recompensas, si las hay, a los miembros del grupo.
gm-desc-remove-player = Eliminar un jugador de la lista del quest y notificarlo.
gm-desc-cancel-quest = Cancelar el quest y eliminarlo del tablero de quests.
gm-title-player-management = Game Master - Administración de Jugadores
gm-desc-player-management =
    Estos comandos se han migrado a menús contextuales. Haz clic derecho (escritorio) o mantén presionado (móvil) el perfil de un jugador para las siguientes opciones de menú:

    - {"**"}Modificar Jugador{"**"}: Agregar o eliminar objetos y experiencia de un jugador.
    - {"**"}Ver Jugador{"**"}: Ver los detalles del personaje activo de un jugador.
gm-title-remove-player = Eliminar Jugador del Quest - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Notas sobre la Eliminación de Jugadores{"**"}__

    - Elige un jugador del menú desplegable a continuación para eliminarlo de la lista del quest.
    - Si hay jugadores en la lista de espera, el primer jugador de la lista será promovido al grupo.
    - Las recompensas individuales del jugador eliminado serán borradas del quest.
    - Si deseas recompensar al jugador por contribuciones previas, usa el menú contextual `Modificar Jugador` para emitirle recompensas directamente.
gm-label-no-players-in-roster = No hay jugadores en la lista del quest
gm-title-character-sheet = Hoja de Personaje de { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Puntos de Experiencia:{"**"}__
gm-label-possessions = __{"**"}Posesiones{"**"}__

# Aprobaciones de GM

gm-error-role-hierarchy = ReQuest no puede administrar el rol "{ $roleName }" (ID: { $roleId }) porque está posicionado por encima del rol más alto de ReQuest en la jerarquía del servidor. Contacta a un administrador del servidor para mover el rol por debajo del rol de ReQuest, o asignar a ReQuest un rol más alto, y luego reintenta la operación.
