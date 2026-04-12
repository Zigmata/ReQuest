## Cadenas del módulo de Game Master

# Botones de GM
gm-btn-create = Crear
gm-btn-edit-details = Editar quest
gm-btn-toggle-ready = Alternar preparado
gm-btn-configure-rewards = Configurar recompensas
gm-btn-remove-player = Eliminar jugador
gm-btn-cancel-quest = Cancelar quest
gm-btn-manage-party-rewards = Gestionar recompensas del grupo
gm-btn-manage-individual-rewards = Gestionar recompensas individuales
gm-btn-join = Unirse
gm-btn-leave = Abandonar
gm-btn-complete-quest = Completar quest
gm-btn-edit-details-modal = Editar detalles
gm-btn-edit-images = Editar imágenes
gm-btn-publish = Publicar
gm-btn-update-post = Actualizar publicación
gm-select-placeholder-party-role = Seleccionad un rol de grupo...
gm-modal-title-edit-details = Editar detalles de la quest
gm-modal-title-edit-images = Editar imágenes de la quest

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
gm-modal-label-image-url = URL de miniatura
gm-modal-label-large-image-url = URL de imagen grande
gm-modal-placeholder-image-url = Introducid una URL de imagen (o dejad en blanco para eliminar)
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

# Errores de GM
gm-error-no-quest-channel = Aún no se ha designado un canal para las publicaciones de quests. Contactad con un administrador del servidor para configurar el canal de quests.
gm-error-invalid-item-format = Formato de objeto inválido: "{ $item }". Cada objeto debe estar en una línea nueva, con el formato "Nombre: Cantidad".
gm-error-already-on-quest = Ya estáis en esta quest como { $characterName }.
gm-error-no-active-character-long = No tenéis un personaje activo en este servidor. Usad `/player` para registrar o activar un personaje.
gm-error-quest-locked = Error al unirse a la quest {"**"}{ $questTitle }{"**"}: La quest está bloqueada por el GM.
gm-error-quest-full = Error al unirse a la quest {"**"}{ $questTitle }{"**"}: ¡La lista del grupo está llena!
gm-error-not-signed-up = No estáis inscritos en esta quest.
gm-error-quest-not-found = La misión ya no existe.
gm-error-quest-channel-not-set = ¡No se ha establecido el canal de quests!
gm-error-empty-roster = No podéis completar una quest con una lista vacía. Intentad cancelarla en su lugar.
gm-error-invalid-xp-value = ¡El valor de XP debe ser un número entero positivo!
gm-error-party-size-positive = El tamaño del grupo debe ser un número positivo.
gm-error-party-size-too-small = El tamaño del grupo no puede ser menor que el grupo actual ({ $currentSize } miembros).
gm-error-role-name-forbidden = El nombre del rol "{ $roleName }" está prohibido en este servidor.
gm-error-role-name-exists = Ya existe un rol llamado "{ $roleName }" en este servidor.

# Modales de confirmación de GM
gm-modal-title-cancel-quest = Cancelar quest
gm-modal-label-cancel-quest = Escribid CONFIRMAR para cancelar la quest.
gm-modal-title-remove-from-quest = Eliminar personaje de la quest
gm-modal-label-remove-from-quest = ¿Confirmar eliminación del personaje?

# GM DM embeds
gm-dm-title-quest-cancelled = Quest cancelada
gm-dm-desc-quest-cancelled = La quest {"**"}{ $questTitle }{"**"} ha sido cancelada por el GM.
gm-dm-title-quest-ready = Quest lista
gm-dm-desc-quest-ready = ¡La quest {"**"}{ $questTitle }{"**"} está lista! Vuestro GM comenzará la quest pronto.
gm-dm-title-player-removed = Eliminado de la quest
gm-dm-desc-player-removed = Habéis sido eliminados de la quest {"**"}{ $questTitle }{"**"} por el GM.
gm-dm-desc-player-removed-waitlist = Habéis sido eliminados de la lista de espera de {"**"}{ $questTitle }{"**"}.
gm-dm-title-party-promotion = Promoción al grupo
gm-dm-desc-party-promotion =
    Habéis sido promovidos al grupo principal de {"**"}{ $questTitle }{"**"}
    porque un jugador abandonó la quest.
gm-dm-title-roster-locked = Lista bloqueada
gm-dm-desc-roster-locked =
    La lista del grupo de {"**"}{ $questTitle }{"**"} ha sido bloqueada
    y todos los miembros del grupo han sido notificados.
gm-dm-title-roster-unlocked = Lista desbloqueada
gm-dm-desc-roster-unlocked = La lista del grupo de {"**"}{ $questTitle }{"**"} ha sido desbloqueada.
gm-dm-title-player-removed-confirm = Jugador eliminado
gm-dm-desc-player-removed-confirm =
    El jugador ha sido eliminado de {"**"}{ $questTitle }{"**"}
    y la lista de la quest ha sido actualizada.
gm-dm-footer-quest = ID de la quest: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    Vuestro administrador del servidor ha configurado recompensas para los Game Masters al completar
    quests. Sin embargo, como no tenéis personajes registrados, vuestras recompensas
    no se han podido emitir automáticamente en este momento.
gm-dm-rewards-no-active-character =
    Vuestro administrador del servidor ha configurado recompensas para los Game Masters al completar
    quests. Sin embargo, como no tenéis un personaje activo en este servidor, vuestras recompensas
    no se han podido emitir automáticamente en este momento.
gm-dm-rewards-issued = Lo siguiente ha sido otorgado a vuestro personaje activo, { $characterName }
gm-dm-role-removal-failed =
    ⚠️ No se ha podido eliminar el rol {"**"}{ $roleName }{"**"} de los siguientes miembros: { $members }.
    Notificad a un administrador del servidor para eliminar el rol manualmente.
gm-dm-role-not-found =
    ⚠️ El rol de quest (ID: { $roleId }) para la quest {"**"}{ $questTitle }{"**"} ya no existe en el servidor.
    Las operaciones de rol se han omitido. Notificad a un administrador del servidor si esto es inesperado.

# Menús de selección de GM
gm-select-placeholder-party-member = Seleccionad un miembro del grupo
gm-select-option-no-role = Ninguno (Sin rol de grupo)

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

# Vistas de GM
gm-title-main-menu = Game Master - Menú principal
gm-menu-quests = Misiones
gm-menu-desc-quests = Crear, editar y gestionar quests.
gm-menu-players = Jugadores
gm-menu-desc-players = Gestionar inventarios de jugadores y modificar personajes.

gm-title-quest-management = Game Master - Gestión de quests
gm-desc-create-quest = Crear una nueva quest.
gm-msg-no-quests = No se han encontrado quests.
gm-label-quest-locked = (Bloqueada)
gm-label-quest-draft = (Borrador)
gm-title-manage-quest = Gestionar quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Editar detalles de la quest como título, descripción y tamaño del grupo.
gm-label-field-not-set = No establecido
gm-label-description-not-set = Descripción no establecida
gm-label-current-party-size = {"**"}Tamaño máx. del grupo:{"**"} { $value }
gm-label-current-party-role = {"**"}Rol del grupo:{"**"} { $value }
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

    - {"**"}Modificar Jugador{"**"}: Añadir o eliminar objetos y experiencia de un jugador.
    - {"**"}Ver Jugador{"**"}: Ver los detalles del personaje activo de un jugador.
gm-title-remove-player = Eliminar jugador de la quest - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Notas sobre la eliminación de jugadores{"**"}__

    - Elegid un jugador del menú desplegable de abajo para eliminarlo de la lista de la quest.
    - Si hay jugadores en lista de espera, el primero de la lista será ascendido al grupo.
    - Las recompensas individuales del jugador eliminado serán borradas de la quest.
    - Si deseáis recompensar al jugador por contribuciones previas, usad el menú contextual `Modificar Jugador` para emitirle recompensas directamente.
gm-label-no-players-in-roster = No hay jugadores en la lista de la quest
gm-title-character-sheet = Ficha de personaje de { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Puntos de experiencia:{"**"}__
gm-label-possessions = __{"**"}Posesiones{"**"}__

# Aprobaciones de GM

gm-error-role-hierarchy = ReQuest no puede gestionar el rol "{ $roleName }" (ID: { $roleId }) porque está posicionado por encima del rol más alto de ReQuest en la jerarquía del servidor. Contactad con un administrador del servidor para mover el rol por debajo del rol de ReQuest, o asignad a ReQuest un rol más alto, y luego reintentad la operación.
