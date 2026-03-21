## Cadenas del módulo de Game Master

# Botones de GM
gm-btn-create = Crear
gm-btn-edit-details = Editar detalles
gm-btn-toggle-ready = Alternar preparado
gm-btn-configure-rewards = Configurar recompensas
gm-btn-remove-player = Eliminar jugador
gm-btn-cancel-quest = Cancelar quest
gm-btn-manage-party-rewards = Gestionar recompensas del grupo
gm-btn-manage-individual-rewards = Gestionar recompensas individuales
gm-btn-join = Unirse
gm-btn-leave = Abandonar
gm-btn-complete-quest = Completar quest
gm-btn-review-submission = Revisar solicitud
gm-btn-approve = Aprobar
gm-btn-deny = Rechazar

# Modales de GM
gm-modal-title-create-quest = Crear nueva quest
gm-modal-label-quest-title = Título de la quest
gm-modal-placeholder-quest-title = Título de vuestra quest
gm-modal-label-restrictions = Restricciones
gm-modal-placeholder-restrictions = Restricciones, si las hay, como niveles de jugador
gm-modal-label-max-party = Tamaño máximo del grupo
gm-modal-placeholder-max-party = Tamaño máximo del grupo para esta quest
gm-modal-label-party-role = Rol del grupo
gm-modal-placeholder-party-role = Crear un rol para esta quest (Opcional)
gm-modal-label-description = Descripción
gm-modal-placeholder-description = Escribid los detalles de vuestra quest aquí
gm-modal-title-editing-quest = Editando { $questTitle }
gm-modal-label-title = Título
gm-modal-label-max-party-size = Tamaño máx. del grupo
gm-modal-title-add-reward = Añadir recompensa
gm-modal-label-experience = Puntos de experiencia
gm-modal-placeholder-experience = Introducid un número
gm-modal-label-items = Objetos
gm-modal-placeholder-items =
    objeto: cantidad
    objeto2: cantidad
    etc.
gm-modal-title-add-summary = Añadir resumen de quest
gm-modal-label-summary = Resumen
gm-modal-placeholder-summary = Añadid un resumen narrativo de la quest
gm-modal-title-modifying-player = Modificando a { $playerName }
gm-modal-placeholder-xp-add-remove = Introducid un número positivo o negativo.
gm-modal-label-inventory = Inventario
gm-modal-placeholder-inventory-modify =
    objeto: cantidad
    objeto2: cantidad
    etc.
gm-modal-title-review-submission = Revisar solicitud
gm-modal-label-submission-id = ID de solicitud
gm-modal-placeholder-submission-id = Introducid el ID de 8 caracteres

# Errores de GM
gm-error-forbidden-role-name = El nombre proporcionado para el rol del grupo está prohibido.
gm-error-role-already-exists = Ya existe un rol con ese nombre en este servidor.
gm-error-no-quest-channel = Aún no se ha designado un canal para las publicaciones de quests. Contactad con un administrador del servidor para configurar el canal de quests.
gm-error-cannot-ping-announce = No se ha podido mencionar el rol de anuncio { $role } en el canal { $channel }. Comprobad los permisos del canal y del rol de ReQuest con vuestros administradores.
gm-error-invalid-item-format = Formato de objeto inválido: "{ $item }". Cada objeto debe estar en una línea nueva, con el formato "Nombre: Cantidad".
gm-error-submission-not-found = Solicitud no encontrada.
gm-error-already-on-quest = Ya estáis en esta quest como { $characterName }.
gm-error-no-active-character-long = No tenéis un personaje activo en este servidor. Usad `/player` para registrar o activar un personaje.
gm-error-quest-locked = Error al unirse a la quest {"**"}{ $questTitle }{"**"}: La quest está bloqueada por el GM.
gm-error-quest-full = Error al unirse a la quest {"**"}{ $questTitle }{"**"}: ¡La lista del grupo está llena!
gm-error-not-signed-up = No estáis inscritos en esta quest.
gm-error-quest-channel-not-set = ¡No se ha establecido el canal de quests!
gm-error-empty-roster = No podéis completar una quest con una lista vacía. Intentad cancelarla en su lugar.
gm-error-invalid-xp-value = ¡El valor de XP debe ser un número entero positivo!

# Modales de confirmación de GM
gm-modal-title-cancel-quest = Cancelar quest
gm-modal-label-cancel-quest = Escribid CONFIRM para cancelar la quest.
gm-modal-placeholder-cancel-quest = Escribid "CONFIRM" para continuar.
gm-modal-title-remove-from-quest = Eliminar personaje de la quest
gm-modal-label-remove-from-quest = ¿Confirmar eliminación del personaje?
gm-modal-placeholder-remove-from-quest = Escribid "CONFIRM" para continuar.

# Mensajes directos de GM
gm-dm-quest-cancelled = La quest {"**"}{ $questTitle }{"**"} ha sido cancelada por el GM.
gm-dm-quest-ready = ¡La quest {"**"}{ $questTitle }{"**"} está lista!
gm-dm-quest-unlocked = La quest {"**"}{ $questTitle }{"**"} ya no está bloqueada.
gm-dm-quest-locked = La quest {"**"}{ $questTitle }{"**"} ha sido bloqueada por el GM.
gm-dm-player-removed = Habéis sido eliminados de la quest {"**"}{ $questTitle }{"**"}.
gm-dm-player-removed-waitlist = Habéis sido eliminados de la lista de espera de {"**"}{ $questTitle }{"**"}.
gm-dm-party-promotion = ¡Habéis sido añadidos al grupo de {"**"}{ $questTitle }{"**"} porque un jugador se ha retirado!
gm-dm-roster-locked = ¡Lista del grupo bloqueada y miembros del grupo notificados!
gm-dm-roster-unlocked = La lista del grupo ha sido desbloqueada.
gm-dm-rewards-no-characters =
    Vuestro administrador del servidor ha configurado recompensas para los Game Masters al completar
    quests. Sin embargo, como no tenéis personajes registrados, vuestras recompensas
    no se han podido emitir automáticamente en este momento.
gm-dm-rewards-no-active-character =
    Vuestro administrador del servidor ha configurado recompensas para los Game Masters al completar
    quests. Sin embargo, como no tenéis un personaje activo en este servidor, vuestras recompensas
    no se han podido emitir automáticamente en este momento.
gm-dm-rewards-issued = Lo siguiente ha sido otorgado a vuestro personaje activo, { $characterName }

# Menús de selección de GM
gm-select-placeholder-party-member = Seleccionad un miembro del grupo

# Embeds de GM
gm-embed-title-mod-report = Informe de modificación de jugador por GM
gm-embed-field-experience = Experiencia
gm-embed-title-quest-complete = Quest completada: { $questTitle }
gm-embed-title-quest-completed = QUEST COMPLETADA: { $questTitle }
gm-embed-field-rewards = Recompensas
gm-embed-field-party = __Grupo__
gm-embed-field-summary = Resumen
gm-embed-title-gm-rewards = Recompensas de GM emitidas
gm-embed-field-items = Objetos
gm-msg-player-removed = ¡Jugador eliminado y lista de la quest actualizada!

# Vistas de GM
gm-title-main-menu = Game Master - Menú principal
gm-menu-quests = Quests
gm-menu-desc-quests = Crear, editar y gestionar quests.
gm-menu-players = Jugadores
gm-menu-desc-players = Gestionar inventarios de jugadores y modificar personajes.
gm-menu-approvals = Aprobaciones de personajes
gm-menu-desc-approvals = Revisar y aprobar/rechazar solicitudes de personajes.

gm-title-quest-management = Game Master - Gestión de quests
gm-desc-create-quest = Crear una nueva quest.
gm-msg-no-quests = No se han encontrado quests.
gm-label-quest-locked = (Bloqueada)
gm-title-manage-quest = Gestionar quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Editar detalles de la quest como título, descripción y tamaño del grupo.
gm-desc-toggle-ready = Alternar estado de preparación (Actual: {"**"}{ $status }{"**"})
    - Bloquea la lista del grupo y notifica a los miembros que la quest comenzará pronto. Si se ha configurado un rol, se asignará a los miembros del grupo al bloquear.
    - Desbloquea la lista cuando se establece como Abierto.
gm-label-ready-locked = Bloqueado/Listo
gm-label-ready-open = Abierto
gm-desc-configure-rewards = Configurar recompensas para la quest seleccionada.
gm-desc-complete-quest = Completar una quest. Emite las recompensas, si las hay, a los miembros del grupo.
gm-desc-remove-player = Eliminar un jugador de la lista de la quest y notificarle.
gm-desc-cancel-quest = Cancelar la quest y eliminarla del tablón de quests.
gm-title-player-management = Game Master - Gestión de jugadores
gm-desc-player-management =
    Estos comandos se han migrado a menús contextuales. Haced clic derecho (escritorio) o pulsación larga (móvil) en el perfil de un jugador para las siguientes opciones:

    - {"**"}Modify Player{"**"}: Añadir o eliminar objetos y experiencia de un jugador.
    - {"**"}View Player{"**"}: Ver los detalles del personaje activo de un jugador.
gm-title-remove-player = Eliminar jugador de la quest - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Notas sobre la eliminación de jugadores{"**"}__

    - Elegid un jugador del menú desplegable de abajo para eliminarlo de la lista de la quest.
    - Si hay jugadores en lista de espera, el primero de la lista será ascendido al grupo.
    - Las recompensas individuales del jugador eliminado serán borradas de la quest.
    - Si deseáis recompensar al jugador por contribuciones previas, usad el menú contextual `Modify Player` para emitirle recompensas directamente.
gm-label-no-players-in-roster = No hay jugadores en la lista de la quest
gm-title-character-sheet = Ficha de personaje de { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Puntos de experiencia:{"**"}__
gm-label-possessions = __{"**"}Posesiones{"**"}__
gm-label-currency-heading = {"**"}Moneda{"**"}
gm-msg-inventory-empty = El inventario está vacío.

# Aprobaciones de GM
gm-title-approvals = Game Master - Aprobaciones de inventario
gm-desc-review-submission = Introducid un ID de solicitud para revisarla y aprobarla/rechazarla.
gm-title-reviewing = Revisando: { $characterName }
gm-label-items = {"**"}Objetos:{"**"}
gm-label-currency = {"**"}Moneda:{"**"}
gm-embed-title-approved = Actualización de inventario aprobada
gm-embed-desc-approved = El inventario de {"**"}{ $characterName }{"**"} ha sido aprobado por { $approver }.
gm-embed-title-denied = Actualización de inventario rechazada
gm-embed-desc-denied = El inventario de {"**"}{ $characterName }{"**"} ha sido rechazado por { $denier }.

gm-modal-label-select-party-role = Party Role
gm-modal-desc-select-party-role = Select a role to assign to the quest party.
gm-select-option-no-role = None (No Party Role)

gm-error-role-hierarchy = ReQuest cannot manage the role "{ $roleName }" (ID: { $roleId }) because it is positioned higher than ReQuest's highest role in the server hierarchy. Please contact a server administrator to move the role below ReQuest's role, or assign ReQuest a higher role, then retry the operation.
gm-dm-role-removal-failed =
    ⚠️ Failed to remove the role {"**"}{ $roleName }{"**"} from the following members: { $members }.
    Please notify a server administrator to remove the role manually.
