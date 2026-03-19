## Cadenas del módulo de tienda

# Cog de tienda
shop-error-no-shops = No hay tiendas configuradas para este servidor.
shop-error-not-shop-channel =
    Este canal no está registrado como canal de tienda.
    Si crees que debería haber una tienda aquí, avisa al administrador de tu servidor.

# Botones de tienda
shop-btn-out-of-stock = Agotado
shop-btn-view-options = Ver Opciones de Compra
shop-btn-add-to-cart = Agregar al Carrito ({ $cost })
shop-btn-view-cart = Ver Carrito
shop-btn-view-cart-count = Ver Carrito ({ $count })
shop-btn-back-to-shop = Volver a la Tienda
shop-btn-clear-cart = Vaciar Carrito
shop-btn-checkout = Pagar
shop-btn-edit-quantity = Editar Cantidad

# Modales de tienda
shop-modal-title-edit-cart-qty = Editar Cantidad del Carrito
shop-modal-label-quantity = Cantidad
shop-modal-placeholder-quantity = Ingresa la nueva cantidad para este objeto
shop-error-invalid-number = Por favor ingresa un número válido.

# Vistas de tienda
shop-label-shopkeeper = Tendero: {"**"}{ $name }{"**"}
shop-label-unknown-item = Objeto Desconocido
shop-label-out-of-stock = AGOTADO
shop-label-stock-available = Inventario: { $available }
shop-label-in-cart = (En Carrito: { $quantity })
shop-title-cart = 🛒 {"**"}Carrito de Compras{"**"}
shop-msg-cart-empty = Tu carrito está vacío.
shop-warning-no-active-character = ⚠️ No se encontró personaje activo. No se pueden verificar los fondos.
shop-warning-insufficient-funds = ⚠️ Fondos insuficientes para { $currency }
shop-label-invalid-cost = Costo Inválido
shop-label-total-cost = {"**"}Costo Total:{"**"}
shop-label-warning = {"**"}Advertencia:{"**"}
shop-error-no-active-character = No tienes un personaje activo en este servidor.
shop-error-checkout-insufficient = Error en el pago: { $currency } insuficiente.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} está agotado.

# Embed de informe de tienda
shop-embed-title-report = Informe de Compras
shop-embed-field-purchased = Comprado
shop-label-no-items = Sin Objetos
shop-embed-field-total-paid = Total Pagado

# Opciones de compra
shop-title-purchase-options = Opciones de Compra: { $itemName }
shop-msg-no-options = No hay opciones de compra disponibles para este objeto.

# Mensajes de tienda
shop-msg-item-removed = Objeto eliminado del carrito.
shop-msg-cart-updated = Carrito actualizado.

# Notificaciones de reabastecimiento
shop-restock-more-items = . . . y { $remaining } más.
shop-embed-title-restocked = ¡Tienda Reabastecida!
shop-embed-footer-restocked = { $count } { $count ->
    [one] artículo reabastecido
   *[other] artículos reabastecidos
}
