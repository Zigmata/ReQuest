## Cadenas del módulo de Game Master

# Botones de GM
gm-btn-create = Crear
gm-btn-edit-details = Editar Detalles
gm-btn-toggle-ready = Alternar Listo
gm-btn-configure-rewards = Configurar Recompensas
gm-btn-remove-player = Eliminar Jugador
gm-btn-cancel-quest = Cancelar Quest
gm-btn-manage-party-rewards = Administrar Recompensas del Grupo
gm-btn-manage-individual-rewards = Administrar Recompensas Individuales
gm-btn-join = Unirse
gm-btn-leave = Salir
gm-btn-complete-quest = Completar Quest
gm-btn-review-submission = Revisar Solicitud
gm-btn-approve = Aprobar
gm-btn-deny = Rechazar

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
gm-modal-title-editing-quest = Editando { $questTitle }
gm-modal-label-title = Título
gm-modal-label-max-party-size = Tamaño Máximo del Grupo
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
gm-modal-title-review-submission = Revisar Solicitud
gm-modal-label-submission-id = ID de Solicitud
gm-modal-placeholder-submission-id = Ingresa el ID de 8 caracteres

# Errores de GM
gm-error-forbidden-role-name = El nombre proporcionado para el rol del grupo está prohibido.
gm-error-role-already-exists = Ya existe un rol con ese nombre en este servidor.
gm-error-no-quest-channel = Aún no se ha designado un canal para publicaciones de quests. Contacta a un administrador del servidor para configurar el Canal de Quests.
gm-error-cannot-ping-announce = No se pudo mencionar el rol de anuncio { $role } en el canal { $channel }. Verifica los permisos del canal y del rol de ReQuest con los administradores de tu servidor.
gm-error-invalid-item-format = Formato de objeto inválido: "{ $item }". Cada objeto debe estar en una nueva línea, con el formato "Nombre: Cantidad".
gm-error-submission-not-found = Solicitud no encontrada.
gm-error-already-on-quest = Ya estás en este quest como { $characterName }.
gm-error-no-active-character-long = No tienes un personaje activo en este servidor. Usa `/player` para registrar o activar un personaje.
gm-error-quest-locked = Error al unirse al quest {"**"}{ $questTitle }{"**"}: El quest está bloqueado por el GM.
gm-error-quest-full = Error al unirse al quest {"**"}{ $questTitle }{"**"}: ¡La lista del grupo está llena!
gm-error-not-signed-up = No estás inscrito en este quest.
gm-error-quest-channel-not-set = ¡El canal de quests no ha sido configurado!
gm-error-empty-roster = No puedes completar un quest con una lista vacía. Intenta cancelarlo en su lugar.
gm-error-invalid-xp-value = ¡El valor de XP debe ser un número entero positivo!

# Modales de confirmación de GM
gm-modal-title-cancel-quest = Cancelar Quest
gm-modal-label-cancel-quest = Escribe CONFIRM para cancelar el quest.
gm-modal-placeholder-cancel-quest = Escribe "CONFIRM" para continuar.
gm-modal-title-remove-from-quest = Eliminar personaje del quest
gm-modal-label-remove-from-quest = ¿Confirmar eliminación del personaje?
gm-modal-placeholder-remove-from-quest = Escribe "CONFIRM" para continuar.

# Mensajes directos de GM
gm-dm-quest-cancelled = El quest {"**"}{ $questTitle }{"**"} fue cancelado por el GM.
gm-dm-quest-ready = ¡El quest {"**"}{ $questTitle }{"**"} ya está listo!
gm-dm-quest-unlocked = El quest {"**"}{ $questTitle }{"**"} ya no está bloqueado.
gm-dm-quest-locked = El quest {"**"}{ $questTitle }{"**"} ahora está bloqueado por el GM.
gm-dm-player-removed = Fuiste eliminado del quest {"**"}{ $questTitle }{"**"}.
gm-dm-player-removed-waitlist = Fuiste eliminado de la lista de espera para {"**"}{ $questTitle }{"**"}.
gm-dm-party-promotion = ¡Has sido agregado al grupo para {"**"}{ $questTitle }{"**"}, debido a la salida de un jugador!
gm-dm-roster-locked = ¡Lista del grupo bloqueada y miembros notificados!
gm-dm-roster-unlocked = La lista del grupo ha sido desbloqueada.
gm-dm-rewards-no-characters =
    El administrador de tu servidor ha configurado recompensas para los Game Masters al completar
    quests. Sin embargo, como no tienes personajes registrados, tus recompensas no pudieron
    ser emitidas automáticamente en este momento.
gm-dm-rewards-no-active-character =
    El administrador de tu servidor ha configurado recompensas para los Game Masters al completar
    quests. Sin embargo, como no tienes un personaje activo en este servidor, tus recompensas no pudieron
    ser emitidas automáticamente en este momento.
gm-dm-rewards-issued = Lo siguiente ha sido otorgado a tu personaje activo, { $characterName }

# Menús de selección de GM
gm-select-placeholder-party-member = Selecciona un miembro del grupo

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
gm-msg-player-removed = ¡Jugador eliminado y lista del quest actualizada!

# Vistas de GM
gm-title-main-menu = Game Master - Menú Principal
gm-menu-quests = Quests
gm-menu-desc-quests = Crear, editar y administrar quests.
gm-menu-players = Jugadores
gm-menu-desc-players = Administrar inventarios de jugadores y modificar personajes.
gm-menu-approvals = Aprobaciones de Personajes
gm-menu-desc-approvals = Revisar y aprobar/rechazar solicitudes de personajes.

gm-title-quest-management = Game Master - Administración de Quests
gm-desc-create-quest = Crear un nuevo quest.
gm-msg-no-quests = No se encontraron quests.
gm-label-quest-locked = (Bloqueado)
gm-title-manage-quest = Administrar Quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Editar detalles del quest como título, descripción y tamaño del grupo.
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

    - {"**"}Modify Player{"**"}: Agregar o eliminar objetos y experiencia de un jugador.
    - {"**"}View Player{"**"}: Ver los detalles del personaje activo de un jugador.
gm-title-remove-player = Eliminar Jugador del Quest - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Notas sobre la Eliminación de Jugadores{"**"}__

    - Elige un jugador del menú desplegable a continuación para eliminarlo de la lista del quest.
    - Si hay jugadores en la lista de espera, el primer jugador de la lista será promovido al grupo.
    - Las recompensas individuales del jugador eliminado serán borradas del quest.
    - Si deseas recompensar al jugador por contribuciones previas, usa el menú contextual `Modify Player` para emitirle recompensas directamente.
gm-label-no-players-in-roster = No hay jugadores en la lista del quest
gm-title-character-sheet = Hoja de Personaje de { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Puntos de Experiencia:{"**"}__
gm-label-possessions = __{"**"}Posesiones{"**"}__
gm-label-currency-heading = {"**"}Moneda{"**"}
gm-msg-inventory-empty = El inventario está vacío.

# Aprobaciones de GM
gm-title-approvals = Game Master - Aprobaciones de Inventario
gm-desc-review-submission = Ingresa un ID de Solicitud para revisarla y aprobarla/rechazarla.
gm-title-reviewing = Revisando: { $characterName }
gm-label-items = {"**"}Objetos:{"**"}
gm-label-currency = {"**"}Moneda:{"**"}
gm-embed-title-approved = Actualización de Inventario Aprobada
gm-embed-desc-approved = El inventario de {"**"}{ $characterName }{"**"} ha sido aprobado por { $approver }.
gm-embed-title-denied = Actualización de Inventario Rechazada
gm-embed-desc-denied = El inventario de {"**"}{ $characterName }{"**"} ha sido rechazado por { $denier }.

gm-modal-label-select-party-role = Party Role
gm-modal-desc-select-party-role = Select a role to assign to the quest party.
gm-select-option-no-role = None (No Party Role)

gm-error-role-hierarchy = ReQuest cannot manage the role "{ $roleName }" (ID: { $roleId }) because it is positioned higher than ReQuest's highest role in the server hierarchy. Please contact a server administrator to move the role below ReQuest's role, or assign ReQuest a higher role, then retry the operation.
gm-dm-role-removal-failed =
    ⚠️ Failed to remove the role {"**"}{ $roleName }{"**"} from the following members: { $members }.
    Please notify a server administrator to remove the role manually.
