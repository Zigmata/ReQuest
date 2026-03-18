## Cadenas del módulo de jugador

# --- Cog ---

player-cmd-name = Trade
player-cmd-desc = Menús de Jugador

# --- Botones ---

# Administración de personajes
player-btn-register-character = Registrar Nuevo Personaje
player-btn-activate = Activar
player-btn-active = Activo

# Tablero de jugadores
player-btn-create-post = Crear Publicación
player-btn-open-starting-shop = Abrir Tienda Inicial
player-btn-select-kit = Seleccionar Kit
player-btn-input-inventory = Ingresar Inventario

# Botones de asistente / tienda
player-btn-add-to-cart = Agregar al Carrito
player-btn-add-to-cart-cost = Agregar al Carrito ({ $costString })
player-btn-view-purchase-options = Ver Opciones de Compra
player-btn-review-submit = Revisar y Enviar ({ $count })
player-btn-submit-character = Enviar Personaje
player-btn-keep-shopping = Seguir Comprando
player-btn-edit-quantity = Editar Cantidad
player-btn-clear-cart = Vaciar Carrito

# Botones de kit
player-btn-confirm-selection = Confirmar Selección
player-btn-back-to-kits = Volver a Kits

# Administración de inventario
player-btn-spend-currency = Gastar Moneda
player-btn-print-inventory = Imprimir Inventario

# Administración de contenedores
player-btn-manage-containers = Administrar Contenedores
player-btn-create-new = + Crear Nuevo
player-btn-consume-destroy = Consumir/Destruir
player-btn-move = Mover
player-btn-move-all = Mover Todo
player-btn-move-some = Mover Algunos...
player-btn-back-to-overview = ← Volver al Resumen
player-btn-cancel-move = ← Cancelar
player-btn-up = ▲ Arriba
player-btn-down = ▼ Abajo

# --- Modales ---

# Modal de intercambio
player-modal-title-trade = Intercambiando con { $targetName }
player-modal-label-trade-name = Nombre
player-modal-placeholder-trade-name = Ingresa el nombre del objeto que estás intercambiando
player-modal-label-trade-quantity = Cantidad
player-modal-placeholder-trade-quantity = Ingresa la cantidad que estás intercambiando

# Modal de registro de personaje
player-modal-title-register = Registrar Nuevo Personaje
player-modal-label-char-name = Nombre
player-modal-placeholder-char-name = Ingresa el nombre de tu personaje.
player-modal-label-char-note = Nota
player-modal-placeholder-char-note = Ingresa una nota para identificar a tu personaje

# Modal de ingreso de inventario abierto
player-modal-title-starting-inventory = Ingreso de Inventario Inicial
player-modal-label-inventory = Inventario
player-modal-placeholder-inventory-input =
    Uno por línea en formato <nombre>: <cantidad>, ej.:
    Espada: 1
    oro: 30

# Modal de gastar moneda
player-modal-title-spend-currency = Gastar Moneda
player-modal-label-currency-name = Nombre de la Moneda
player-modal-placeholder-currency-name = Ingresa el nombre de la moneda que vas a gastar
player-modal-label-currency-amount = Cantidad
player-modal-placeholder-currency-amount = Ingresa la cantidad a gastar

# Modal de crear publicación de jugador
player-modal-title-create-post = Crear Publicación en el Tablero de Jugadores
player-modal-label-post-title = Título
player-modal-placeholder-post-title = Ingresa un título para tu publicación
player-modal-label-post-content = Contenido de la Publicación
player-modal-placeholder-post-content = Ingresa el cuerpo de tu publicación

# Modal de editar publicación de jugador
player-modal-title-edit-post = Editar Publicación en el Tablero de Jugadores

# Modal de editar cantidad en el carrito del asistente
player-modal-title-edit-cart-qty = Editar Cantidad del Carrito
player-modal-label-cart-qty = Cantidad
player-modal-placeholder-cart-qty = Ingresa la nueva cantidad (0 para eliminar)

# Modal de crear contenedor
player-modal-title-create-container = Crear Nuevo Contenedor
player-modal-label-container-name = Nombre del Contenedor
player-modal-placeholder-container-name = Ingresa un nombre para tu contenedor (ej., Mochila)

# Modal de renombrar contenedor
player-modal-title-rename-container = Renombrar Contenedor
player-modal-label-new-container-name = Nuevo Nombre del Contenedor
player-modal-placeholder-new-container-name = Ingresa el nuevo nombre

# Modal de consumir desde contenedor
player-modal-title-consume = Consumir/Destruir Objeto
player-modal-label-consume-qty = Cantidad (máx: { $maxQuantity })
player-modal-placeholder-consume-qty = Ingresa la cantidad a consumir/destruir

# Modal de mover cantidad de objeto
player-modal-title-move-item = Mover Objeto
player-modal-label-move-qty = Cantidad a mover (máx: { $maxQuantity })
player-modal-placeholder-move-qty = Ingresa la cantidad a mover

# --- Selectores ---

player-select-placeholder-no-characters = No tienes personajes registrados
player-select-placeholder-remove-character = Selecciona un personaje para eliminar
player-select-placeholder-post = Selecciona una publicación
player-select-placeholder-container-view = Selecciona un contenedor para ver...
player-select-placeholder-item = Selecciona un objeto...
player-select-placeholder-destination = Selecciona destino...
player-select-placeholder-container = Selecciona un contenedor...
player-select-option-no-containers = Sin contenedores
player-select-option-no-items = Sin objetos
player-select-option-no-destinations = Sin destinos

# --- Vistas ---

# PlayerBaseView - Menú principal
player-title-main-menu = {"**"}Comandos de Jugador - Menú Principal{"**"}
player-menu-btn-characters = Personajes
player-menu-desc-characters = Registrar, ver y activar personajes de jugador.
player-menu-btn-inventory = Inventario
player-menu-desc-inventory = Ver el inventario de tu personaje activo y gastar moneda.
player-menu-btn-player-board = Tablero de Jugadores
player-menu-btn-player-board-disabled = Tablero de Jugadores (No Configurado)
player-menu-desc-player-board = Crear una publicación para el Tablero de Jugadores

# CharacterBaseView
player-title-characters = {"**"}Comandos de Jugador - Personajes{"**"}
player-desc-register-character = Registrar un nuevo personaje.
player-msg-no-characters = No tienes personajes registrados.
player-label-active = (Activo)
player-label-xp = { $xp } XP

# Confirmar eliminación de personaje
player-modal-title-confirm-char-removal = Confirmar Eliminación de Personaje
player-modal-label-confirm-char-delete = ¿Eliminar a { $characterName }?

# Confirmar eliminación de publicación
player-modal-title-confirm-post-removal = Confirmar Eliminación de Publicación
player-modal-label-post-removal-warning = ¡ADVERTENCIA: Esta acción es irreversible!

# InventoryOverviewView
player-title-inventory = {"**"}Comandos de Jugador - Inventario{"**"}
player-title-char-inventory = {"**"}Inventario de { $characterName }{"**"}
player-msg-no-active-character = Sin Personaje Activo: Activa un personaje para este servidor para usar estos menús.
player-msg-no-characters-registered = Sin Personajes: Registra un personaje para usar estos menús.
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
player-msg-select-destination = Selecciona el contenedor de destino:
player-label-destination = Destino: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Administrar Contenedores{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } objetos){ $suffix }
player-label-default-suffix = { " " }(predeterminado)
player-msg-no-containers = Sin contenedores.
player-label-selected-container = Seleccionado: {"**"}{ $containerName }{"**"}

# Confirmar eliminación de contenedor
player-modal-title-confirm-container-delete = Confirmar Eliminación de Contenedor
player-modal-label-container-has-items = Tiene { $itemCount } objetos. Se moverán a Objetos Sueltos.
player-modal-label-confirm-container-delete = ¿Eliminar "{ $containerName }"?

# Errores de contenedor
player-error-cannot-rename-loose = No se puede renombrar Objetos Sueltos.
player-error-cannot-delete-loose = No se puede eliminar Objetos Sueltos.

# PlayerBoardView
player-title-player-board = {"**"}Comandos de Jugador - Tablero de Jugadores{"**"}
player-desc-create-post = Crear una nueva publicación para el Tablero de Jugadores.
player-msg-no-posts = No tienes publicaciones activas.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Autor
player-embed-footer-post-id = ID de Publicación: { $postId }
player-error-board-channel-not-found = Canal del Tablero de Jugadores no encontrado.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Configurar Inventario para { $characterName }{"**"}
player-desc-browse-shop = Explorar la Tienda Inicial para equipar a tu personaje.
player-desc-select-kit = Seleccionar un Kit Inicial.
player-desc-input-inventory = Ingresar manualmente tu inventario inicial.

# StaticKitSelectView
player-title-select-kit = {"**"}Seleccionar un Kit para { $characterName }{"**"}
player-msg-no-kits = No hay kits iniciales disponibles.
player-label-and-more-items = ...y { $count } objetos más
player-label-empty-kit = {"*"}Kit Vacío{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Confirmar Selección: { $kitName }{"**"}
player-label-items-heading = {"**"}Objetos:{"**"}
player-label-currency-heading = {"**"}Moneda:{"**"}
player-msg-kit-empty = Este kit está vacío.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Opciones de Compra: { $itemName }{"**"}
player-msg-no-cost-options = Este objeto no tiene opciones de costo disponibles.
player-label-cost-option = {"**"}Opción { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Tienda Inicial ({ $inventoryType }){"**"}
player-label-starting-wealth = Riqueza Inicial: { $formattedCurrency }
player-label-in-cart = {"**"}(En Carrito: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Revisar Carrito{"**"}
player-msg-cart-empty = Tu carrito está vacío.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Total: { $totalQuantity })
player-label-insufficient-currency = { $currencyName } insuficiente
player-label-total-cost = {"**"}Costo Total:{"**"}
player-label-total-cost-free = {"**"}Costo Total:{"**"} Gratis
player-label-cart-page = Página { $current } de { $total }

# Embed de intercambio
player-embed-title-trade = Informe de Intercambio
player-embed-desc-trade-sender = Remitente: { $senderMention } como `{ $senderCharacter }`
player-embed-desc-trade-recipient = Destinatario: { $recipientMention } como `{ $recipientCharacter }`
player-embed-field-currency = Moneda
player-embed-field-amount = Cantidad
player-embed-field-balance = Saldo de { $characterName }
player-embed-field-item = Objeto
player-embed-field-quantity = Cantidad
player-embed-footer-transaction-id = ID de Transacción: { $transactionId }

# Errores de intercambio
player-error-trade-no-characters = ¡El jugador con el que intentas intercambiar no tiene personajes!
player-error-trade-no-active = ¡El jugador con el que intentas intercambiar no tiene un personaje activo en este servidor!

# Embed de gastar moneda
player-embed-title-spend = Informe de Transacción de Jugador
player-embed-desc-spend-player = Jugador: { $playerMention } como `{ $characterName }`
player-embed-desc-spend-transaction = Transacción: {"**"}{ $characterName }{"**"} gastó {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Canal
player-embed-field-receipt = Recibo

# Errores de gastar moneda
player-error-amount-not-number = La cantidad debe ser un número.
player-error-amount-positive = Debes gastar una cantidad positiva.
player-error-no-active-character-server = No tienes un personaje activo en este servidor.
player-error-no-currency-config = No se encontró una configuración de moneda para este servidor.

# Embed de consumir objeto
player-embed-title-consume = Informe de Consumo de Objeto
player-embed-desc-consume = Jugador: { $playerMention } como `{ $characterName }`
player-embed-desc-consume-removed = Eliminado: {"**"}{ $quantity }x { $itemName }{"**"} de {"**"}{ $containerName }{"**"}

# Errores de consumir objeto
player-error-qty-positive-integer = La cantidad debe ser un número entero positivo.
player-error-qty-at-least-one = La cantidad debe ser al menos 1.
player-error-qty-only-have = Solo tienes { $maxQuantity } de este objeto.

# Errores de ingreso de inventario
player-error-invalid-format = Formato inválido: "{ $line }". Usa <nombre>: <cantidad>.
player-error-empty-name = El nombre del objeto no puede estar vacío en la línea: "{ $line }".
player-error-invalid-quantity = Cantidad inválida para "{ $name }": "{ $quantity }". Debe ser un número entero positivo.
player-error-input-errors-header = Errores en el ingreso de inventario:
player-msg-no-valid-items = No se proporcionaron objetos válidos. Inicializando con inventario vacío.

# Validación de cantidad en el carrito
player-error-enter-valid-number = Por favor ingresa un número positivo válido.

# Embeds de solicitud (cola de aprobación)
player-embed-title-approval = Aprobación de Inventario: { $characterName }
player-embed-desc-submitted-by = Enviado por { $userMention }
player-embed-field-items = Objetos
player-embed-field-currency-received = Moneda
player-embed-footer-submission-id = ID de Solicitud: { $submissionId }
player-label-approval-thread = Aprobación: { $characterName }
player-embed-title-submission-sent = Solicitud de Inventario Enviada
player-embed-desc-submission-sent =
    ¡Tu solicitud para {"**"}{ $characterName }{"**"} ha sido enviada al equipo de GMs para su aprobación!
    Se te notificará una vez que haya sido revisada.
    [Ver Hilo de Solicitud]({ $threadUrl })

# Embeds de aplicación directa (sin cola de aprobación)
player-embed-title-starting-inventory = Inventario Inicial Aplicado
player-embed-desc-starting-inventory = Jugador: { $playerMention } como `{ $characterName }`
player-embed-field-items-received = Objetos Recibidos
player-embed-field-currency-received-label = Moneda Recibida
player-label-untitled = Sin Título
