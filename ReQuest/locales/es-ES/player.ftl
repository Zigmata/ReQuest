## Cadenas del módulo de jugador

# --- Cog ---

player-cmd-name = Intercambiar
player-cmd-desc = Menús de jugador

# --- Botones ---

# Gestión de personajes
player-btn-register-character = Registrar nuevo personaje
player-btn-activate = Activar
player-btn-active = Activo

# Tablón de jugadores
player-btn-create-post = Crear publicación
player-btn-open-starting-shop = Abrir tienda inicial
player-btn-select-kit = Seleccionar kit
player-btn-input-inventory = Introducir inventario

# Botones de asistente / tienda
player-btn-add-to-cart = Añadir al carrito
player-btn-add-to-cart-cost = Añadir al carrito ({ $costString })
player-btn-view-purchase-options = Ver opciones de compra
player-btn-review-submit = Revisar y enviar ({ $count })
player-btn-submit-character = Enviar personaje
player-btn-keep-shopping = Seguir comprando
player-btn-edit-quantity = Editar cantidad
player-btn-clear-cart = Vaciar carrito

# Botones de kit
player-btn-confirm-selection = Confirmar selección
player-btn-back-to-kits = Volver a los kits

# Gestión de inventario
player-btn-spend-currency = Gastar moneda
player-btn-print-inventory = Imprimir inventario

# Gestión de contenedores
player-btn-manage-containers = Gestionar contenedores
player-btn-create-new = + Crear nuevo
player-btn-consume-destroy = Consumir/Destruir
player-btn-move = Mover
player-btn-move-all = Mover todo
player-btn-move-some = Mover algo...
player-btn-back-to-overview = ← Volver al resumen
player-btn-cancel-move = ← Cancelar
player-btn-up = ▲ Arriba
player-btn-down = ▼ Abajo

# --- Modales ---

# Modal de intercambio
player-modal-title-trade = Intercambiando con { $targetName }
player-modal-label-trade-name = Nombre
player-modal-placeholder-trade-name = Introducid el nombre del objeto que vais a intercambiar
player-modal-label-trade-quantity = Cantidad
player-modal-placeholder-trade-quantity = Introducid la cantidad que vais a intercambiar

# Modal de registro de personaje
player-modal-title-register = Registrar nuevo personaje
player-modal-label-char-name = Nombre
player-modal-placeholder-char-name = Introducid el nombre de vuestro personaje.
player-modal-label-char-note = Nota
player-modal-placeholder-char-note = Introducid una nota para identificar a vuestro personaje

# Modal de entrada de inventario abierto
player-modal-title-starting-inventory = Entrada de inventario inicial
player-modal-label-inventory = Inventario
player-modal-placeholder-inventory-input =
    Uno por línea en formato <nombre>: <cantidad>, p. ej.:
    Espada: 1
    oro: 30

# Modal de gastar moneda
player-modal-title-spend-currency = Gastar moneda
player-modal-label-currency-name = Nombre de la moneda
player-modal-placeholder-currency-name = Introducid el nombre de la moneda que vais a gastar
player-modal-label-currency-amount = Cantidad
player-modal-placeholder-currency-amount = Introducid la cantidad a gastar

# Modal de crear publicación de jugador
player-modal-title-create-post = Crear publicación en el tablón de jugadores
player-modal-label-post-title = Título
player-modal-placeholder-post-title = Introducid un título para vuestra publicación
player-modal-label-post-content = Contenido de la publicación
player-modal-placeholder-post-content = Introducid el cuerpo de vuestra publicación

# Modal de editar publicación de jugador
player-modal-title-edit-post = Editar publicación del tablón de jugadores

# Modal de editar cantidad en carrito del asistente
player-modal-title-edit-cart-qty = Editar cantidad del carrito
player-modal-label-cart-qty = Cantidad
player-modal-placeholder-cart-qty = Introducid la nueva cantidad (0 para eliminar)

# Modal de crear contenedor
player-modal-title-create-container = Crear nuevo contenedor
player-modal-label-container-name = Nombre del contenedor
player-modal-placeholder-container-name = Introducid un nombre para vuestro contenedor (p. ej., Mochila)

# Modal de renombrar contenedor
player-modal-title-rename-container = Renombrar contenedor
player-modal-label-new-container-name = Nuevo nombre del contenedor
player-modal-placeholder-new-container-name = Introducid el nuevo nombre

# Modal de consumir desde contenedor
player-modal-title-consume = Consumir/Destruir objeto
player-modal-label-consume-qty = Cantidad (máx: { $maxQuantity })
player-modal-placeholder-consume-qty = Introducid la cantidad a consumir/destruir

# Modal de mover cantidad de objeto
player-modal-title-move-item = Mover objeto
player-modal-label-move-qty = Cantidad a mover (máx: { $maxQuantity })
player-modal-placeholder-move-qty = Introducid la cantidad a mover

# --- Selectores ---

player-select-placeholder-no-characters = No tenéis personajes registrados
player-select-placeholder-remove-character = Seleccionad un personaje para eliminar
player-select-placeholder-post = Seleccionad una publicación
player-select-placeholder-container-view = Seleccionad un contenedor para ver...
player-select-placeholder-item = Seleccionad un objeto...
player-select-placeholder-destination = Seleccionad destino...
player-select-placeholder-container = Seleccionad un contenedor...
player-select-option-no-containers = Sin contenedores
player-select-option-no-items = Sin objetos
player-select-option-no-destinations = Sin destinos

# --- Vistas ---

# PlayerBaseView - Menú principal
player-title-main-menu = {"**"}Comandos de jugador - Menú principal{"**"}
player-menu-btn-characters = Personajes
player-menu-desc-characters = Registrar, ver y activar personajes de jugador.
player-menu-btn-inventory = Inventario
player-menu-desc-inventory = Ver el inventario de vuestro personaje activo y gastar moneda.
player-menu-btn-player-board = Tablón de jugadores
player-menu-btn-player-board-disabled = Tablón de jugadores (No configurado)
player-menu-desc-player-board = Crear una publicación para el tablón de jugadores

# CharacterBaseView
player-title-characters = {"**"}Comandos de jugador - Personajes{"**"}
player-desc-register-character = Registrar un nuevo personaje.
player-msg-no-characters = No tenéis personajes registrados.
player-label-active = (Activo)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Personaje en progreso: { $characterName }{"**"}
    El registro de tu personaje está esperando la configuración del inventario.
player-btn-resume = Reanudar
player-btn-discard = Descartar
player-modal-title-discard-character = Descartar personaje
player-modal-label-discard-confirm = ¿Descartar { $characterName }?

# Confirmar eliminación de personaje
player-modal-title-confirm-char-removal = Confirmar eliminación de personaje
player-modal-label-confirm-char-delete = ¿Eliminar a { $characterName }?

# Confirmar eliminación de publicación
player-modal-title-confirm-post-removal = Confirmar eliminación de publicación
player-modal-label-post-removal-warning = ¡AVISO: Esta acción es irreversible!

# InventoryOverviewView
player-title-inventory = {"**"}Comandos de jugador - Inventario{"**"}
player-title-char-inventory = {"**"}Inventario de { $characterName }{"**"}
player-msg-no-active-character = Sin personaje activo: Activad un personaje para este servidor para usar estos menús.
player-msg-no-characters-registered = Sin personajes: Registrad un personaje para usar estos menús.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } objetos
player-label-currency = {"**"}Moneda{"**"}
player-msg-inventory-empty = El inventario está vacío.

# Embed de imprimir inventario
player-embed-title-inventory = Inventario de { $characterName }

# ContainerItemsView
player-msg-container-empty = Este contenedor está vacío.
player-label-selected-item = Seleccionado: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Mover "{ $itemName }"{"**"} ({ $available } disponibles)
player-msg-no-other-containers = No hay otros contenedores disponibles.
player-msg-select-destination = Seleccionad el contenedor de destino:
player-label-destination = Destino: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Gestionar contenedores{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } objetos){ $suffix }
player-label-default-suffix = { " " }(por defecto)
player-msg-no-containers = Sin contenedores.
player-label-selected-container = Seleccionado: {"**"}{ $containerName }{"**"}

# Confirmar eliminación de contenedor
player-modal-title-confirm-container-delete = Confirmar eliminación de contenedor
player-modal-label-container-has-items = Tiene { $itemCount } objetos. Se moverán a Objetos sueltos.
player-modal-label-confirm-container-delete = ¿Eliminar "{ $containerName }"?

# Errores de contenedor
player-error-cannot-rename-loose = No se puede renombrar Objetos sueltos.
player-error-cannot-delete-loose = No se puede eliminar Objetos sueltos.

# PlayerBoardView
player-title-player-board = {"**"}Comandos de jugador - Tablón de jugadores{"**"}
player-desc-create-post = Crear una nueva publicación para el tablón de jugadores.
player-msg-no-posts = No tenéis publicaciones activas.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Autor
player-embed-footer-post-id = ID de publicación: { $postId }
player-error-board-channel-not-found = Canal del tablón de jugadores no encontrado.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Configurar inventario para { $characterName }{"**"}
player-desc-browse-shop = Explorad la tienda inicial para equipar a vuestro personaje.
player-desc-select-kit = Seleccionad un kit inicial.
player-desc-input-inventory = Introducid manualmente vuestro inventario inicial.

# StaticKitSelectView
player-title-select-kit = {"**"}Seleccionar un kit para { $characterName }{"**"}
player-msg-no-kits = No hay kits iniciales disponibles.
player-label-and-more-items = ...y { $count } objetos más
player-label-empty-kit = {"*"}Kit vacío{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Confirmar selección: { $kitName }{"**"}
player-label-items-heading = {"**"}Objetos:{"**"}
player-label-currency-heading = {"**"}Moneda:{"**"}
player-msg-kit-empty = Este kit está vacío.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Opciones de compra: { $itemName }{"**"}
player-msg-no-cost-options = Este objeto no tiene opciones de coste disponibles.
player-label-cost-option = {"**"}Opción { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Tienda inicial ({ $inventoryType }){"**"}
player-label-starting-wealth = Riqueza inicial: { $formattedCurrency }
player-label-in-cart = {"**"}(En carrito: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Revisar carrito{"**"}
player-msg-cart-empty = Vuestro carrito está vacío.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Total: { $totalQuantity })
player-label-insufficient-currency = { $currencyName } insuficiente
player-label-total-cost = {"**"}Coste total:{"**"}
player-label-total-cost-free = {"**"}Coste total:{"**"} Gratis
player-label-cart-page = Página { $current } de { $total }

# Embed de intercambio
player-embed-title-trade = Informe de intercambio
player-embed-desc-trade-sender = Emisor: { $senderMention } como `{ $senderCharacter }`
player-embed-desc-trade-recipient = Receptor: { $recipientMention } como `{ $recipientCharacter }`
player-embed-field-currency = Moneda
player-embed-field-amount = Cantidad
player-embed-field-balance = Saldo de { $characterName }
player-embed-field-item = Objeto
player-embed-field-quantity = Cantidad
player-embed-footer-transaction-id = ID de transacción: { $transactionId }

# Errores de intercambio
player-error-trade-no-characters = ¡El jugador con el que intentáis comerciar no tiene personajes!
player-error-trade-no-active = ¡El jugador con el que intentáis comerciar no tiene un personaje activo en este servidor!

# Embed de gastar moneda
player-embed-title-spend = Informe de transacción del jugador
player-embed-desc-spend-player = Jugador: { $playerMention } como `{ $characterName }`
player-embed-desc-spend-transaction = Transacción: {"**"}{ $characterName }{"**"} gastó {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Canal
player-embed-field-receipt = Recibo

# Errores de gastar moneda
player-error-amount-not-number = La cantidad debe ser un número.
player-error-amount-positive = Debéis gastar una cantidad positiva.
player-error-amount-exceeds-maximum = La cantidad no puede superar { $max }.
player-error-no-active-character-server = No tenéis un personaje activo en este servidor.
player-error-no-currency-config = No se ha encontrado una configuración de moneda para este servidor.

# Embed de consumir objeto
player-embed-title-consume = Informe de consumo de objetos
player-embed-desc-consume = Jugador: { $playerMention } como `{ $characterName }`
player-embed-desc-consume-removed = Eliminado: {"**"}{ $quantity }x { $itemName }{"**"} de {"**"}{ $containerName }{"**"}

# Errores de consumir objeto
player-error-qty-positive-integer = La cantidad debe ser un número entero positivo.
player-error-qty-at-least-one = La cantidad debe ser al menos 1.
player-error-qty-only-have = Solo tenéis { $maxQuantity } de este objeto.

# Errores de entrada de inventario
player-error-invalid-format = Formato inválido: "{ $line }". Usad <nombre>: <cantidad>.
player-error-empty-name = El nombre del objeto no puede estar vacío en la línea: "{ $line }".
player-error-invalid-quantity = Cantidad inválida para "{ $name }": "{ $quantity }". Debe ser un número entero positivo.
player-error-input-errors-header = Errores en la entrada de inventario:
player-msg-no-valid-items = No se han proporcionado objetos válidos. Inicializando con inventario vacío.

# Validation error view
player-validation-error-title = Errores de entrada
player-validation-btn-retry = Intentar de nuevo

# Validación de cantidad del carrito
player-error-enter-valid-number = Introducid un número positivo válido.

# Embeds de solicitud (cola de aprobación)
player-embed-title-approval = Aprobación de inventario: { $characterName }
player-embed-desc-submitted-by = Enviado por { $userMention }
player-embed-field-items = Objetos
player-embed-field-currency-received = Moneda
player-embed-footer-submission-id = ID de solicitud: { $submissionId }
player-label-approval-thread = Aprobación: { $characterName }
player-embed-title-submission-sent = Solicitud de inventario enviada
player-embed-desc-submission-sent =
    ¡Vuestra solicitud para {"**"}{ $characterName }{"**"} ha sido enviada al equipo de GM para su aprobación!
    Seréis notificados cuando haya sido revisada.
    [Ver hilo de solicitud]({ $threadUrl })

# Embeds de aplicación directa (sin cola de aprobación)
player-embed-title-starting-inventory = Inventario inicial aplicado
player-embed-desc-starting-inventory = Jugador: { $playerMention } como `{ $characterName }`
player-embed-field-items-received = Objetos recibidos
player-embed-field-currency-received-label = Moneda recibida
player-label-untitled = Sin título

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventory Submission: { $characterName }{"**"}
    Submitted by { $userMention }
player-approval-post-items = Objetos
player-approval-post-currency = Moneda
player-approval-resolved = Esta solicitud ha sido resuelta.
player-approval-btn-approve = Aprobar
player-approval-btn-deny = Rechazar
player-approval-btn-edit = Editar
player-approval-error-no-permission = No tienes permiso para realizar esta acción.
player-approval-error-not-submitter = Solo el remitente original puede editar esta solicitud.
player-approval-thread-instructions =
    This thread was created for the approval of {"**"}{ $characterName }{"**"}.
    A Game Master will review the submission and approve or deny it.
    Once approved or denied, this thread will be locked.

    {"**"}Game Masters:{"**"} Discuss any required changes with your
    player until the inventory is in an acceptable state. Only use
    the `Deny` button for irreconcilable submissions.

    { $playerMention }: Use the `Edit` button to make any changes
    requested here by a Game Master.
player-approval-approved-by = Esta solicitud fue aprobada por { $approver }.
player-approval-denied-by = Esta solicitud fue rechazada por { $denier }.
player-approval-deny-reason = Razón: { $reason }
player-msg-submission-updated = Tu solicitud ha sido actualizada.


# Denial modal
player-modal-title-deny-reason = Rechazar solicitud
player-modal-label-deny-reason = Razón del rechazo
player-modal-placeholder-deny-reason = Opcional: explica por qué fue rechazada
# Approval DM notifications
player-dm-title-approved = Personaje aprobado
player-dm-desc-approved =
    Your character {"**"}{ $characterName }{"**"} has been approved
    by { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Personaje rechazado
player-dm-desc-denied =
    Your character {"**"}{ $characterName }{"**"} has been denied
    by { $denier } in {"**"}{ $guildName }{"**"}.
