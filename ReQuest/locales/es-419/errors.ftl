## Cadenas de errores y fallos de verificación

# Embed de error
error-oops-title = ⚠️ ¡Ups!
error-report-description =
    { $exception }

    Si este error es inesperado, o sospechas que el bot no está funcionando correctamente, por favor envía un reporte de error en el [Discord Oficial de Soporte de ReQuest](https://discord.gg/Zq37gj4).

error-report-unexpected =
    Ocurrió un error inesperado. Por favor, inténtalo de nuevo.

    Si esto sigue ocurriendo, por favor envía un reporte de error en el [Discord Oficial de Soporte de ReQuest](https://discord.gg/Zq37gj4).

# Fallos de verificación
error-owner-only = ¡Solo el dueño del bot puede usar este comando!
error-no-permission = ¡No tienes permisos para ejecutar este comando!
error-no-active-character = ¡No tienes un personaje activo en este servidor!
error-no-registered-characters = ¡No tienes ningún personaje registrado!
error-no-characters = El jugador objetivo no tiene ningún personaje registrado.
error-no-active-character-target = El jugador objetivo no tiene un personaje activado en este servidor.
error-player-not-found = Datos del jugador no encontrados.
error-character-not-found = Datos del personaje no encontrados.

# Errores de moneda/transacción
error-transaction-cannot-complete = La transacción no puede completarse:
    { $reason }
error-insufficient-item-trade = Tienes { $owned }x { $itemName } pero estás intentando dar { $quantity }.
error-currency-process-failed = La moneda { $currencyName } no pudo ser procesada.
error-insufficient-funds-transaction = Fondos insuficientes para cubrir esta transacción.
error-insufficient-funds = Fondos insuficientes.
error-insufficient-items = Objeto(s) insuficiente(s): { $itemName }
error-currency-not-configured = La moneda '{ $currencyName }' no está configurada en este servidor.
error-cost-currency-system-mismatch = La moneda de costo '{ $currencyName }' no es parte de su propio sistema de monedas.
error-currency-config-error = Error de configuración de moneda: valor de denominación 0 o negativo.
error-currency-validation = Ocurrió un error durante la validación de moneda: { $error }
error-invalid-currency = { $itemName } no es una moneda válida.
error-insufficient-funds-for-transaction = Fondos insuficientes para esta transacción.

# Errores de carrito
error-cart-not-found = Carrito no encontrado.
error-item-not-in-cart = El objeto no está en el carrito.
error-not-enough-stock = No hay suficiente inventario disponible.

# Errores de contenedor
error-container-not-found = Contenedor no encontrado.
error-container-name-empty = El nombre del contenedor no puede estar vacío.
error-container-name-too-long = El nombre del contenedor no puede exceder { $maxLength } caracteres.
error-max-containers-reached = No puedes crear más de { $maxContainers } contenedores.
error-container-name-exists = Ya existe un contenedor llamado "{ $containerName }".
error-item-already-in-container = El objeto ya está en este contenedor.
error-quantity-minimum = La cantidad debe ser al menos 1.
error-source-container-not-found = Contenedor de origen no encontrado.
error-item-not-in-source = El objeto "{ $itemName }" no se encontró en el contenedor de origen.
error-insufficient-quantity-in-container = Cantidad insuficiente. Tienes { $available } en este contenedor.
error-dest-container-not-found = Contenedor de destino no encontrado.
error-item-not-in-container = El objeto "{ $itemName }" no se encontró en este contenedor.
error-insufficient-quantity-consume = Solo tienes { $available } de este objeto en este contenedor.
