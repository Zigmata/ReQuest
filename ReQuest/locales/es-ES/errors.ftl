## Cadenas de errores y fallos de comprobación
# Envoltura de embed de error
error-oops-title = ⚠️ ¡Vaya!
error-report-description =
    Se ha producido una excepción:

    ```{ $exception }```

    Si este error es inesperado, o sospecháis que el bot no funciona correctamente, enviad un informe de error en el [Discord oficial de soporte de ReQuest](https://discord.gg/Zq37gj4).
# Fallos de comprobación
error-owner-only = ¡Solo el propietario del bot puede usar este comando!
error-no-permission = ¡No tenéis permisos para ejecutar este comando!
error-no-active-character = ¡No tenéis un personaje activo en este servidor!
error-no-registered-characters = ¡No tenéis personajes registrados!
error-no-characters = El jugador objetivo no tiene personajes registrados.
error-no-active-character-target = El jugador objetivo no tiene un personaje activado en este servidor.
error-player-not-found = Datos del jugador no encontrados.
error-character-not-found = Datos del personaje no encontrados.
# Errores de moneda/transacción
error-transaction-cannot-complete = La transacción no puede completarse:
    { $reason }
error-insufficient-item-trade = Tenéis { $owned }x { $itemName } pero estáis intentando dar { $quantity }.
error-currency-process-failed = No se pudo procesar la moneda { $currencyName }.
error-insufficient-funds-transaction = Fondos insuficientes para cubrir esta transacción.
error-insufficient-funds = Fondos insuficientes.
error-insufficient-items = Objeto(s) insuficiente(s): { $itemName }
error-currency-not-configured = La moneda '{ $currencyName }' no está configurada en este servidor.
error-cost-currency-system-mismatch = La moneda de coste '{ $currencyName }' no forma parte de su propio sistema de monedas.
error-currency-config-error = Error de configuración de moneda: valor de denominación 0 o negativo.
error-currency-validation = Se ha producido un error durante la validación de moneda: { $error }
error-invalid-currency = { $itemName } no es una moneda válida.
error-insufficient-funds-for-transaction = Fondos insuficientes para esta transacción.
# Errores del carrito
error-cart-not-found = Carrito no encontrado.
error-item-not-in-cart = El objeto no está en el carrito.
error-not-enough-stock = No hay suficientes existencias disponibles.
# Errores de contenedor
error-container-not-found = Contenedor no encontrado.
error-container-name-empty = El nombre del contenedor no puede estar vacío.
error-container-name-too-long = El nombre del contenedor no puede superar los { $maxLength } caracteres.
error-max-containers-reached = No podéis crear más de { $maxContainers } contenedores.
error-container-name-exists = Ya existe un contenedor llamado "{ $containerName }".
error-item-already-in-container = El objeto ya está en este contenedor.
error-quantity-minimum = La cantidad debe ser al menos 1.
error-source-container-not-found = Contenedor de origen no encontrado.
error-item-not-in-source = El objeto "{ $itemName }" no se encuentra en el contenedor de origen.
error-insufficient-quantity-in-container = Cantidad insuficiente. Tenéis { $available } en este contenedor.
error-dest-container-not-found = Contenedor de destino no encontrado.
error-item-not-in-container = El objeto "{ $itemName }" no se encuentra en este contenedor.
error-insufficient-quantity-consume = Solo tenéis { $available } de este objeto en este contenedor.
