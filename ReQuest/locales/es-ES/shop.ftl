## Cadenas del módulo de tienda

# Cog de tienda
shop-error-no-shops = No hay tiendas configuradas para este servidor.
shop-error-not-shop-channel =
    Este canal no está registrado como canal de tienda.
    Si creéis que debería haber una tienda aquí, informad a vuestro administrador del servidor.

# Botones de tienda
shop-btn-out-of-stock = Agotado
shop-btn-view-options = Ver opciones de compra
shop-btn-add-to-cart = Añadir al carrito ({ $cost })
shop-btn-view-cart = Ver carrito
shop-btn-view-cart-count = Ver carrito ({ $count })
shop-btn-back-to-shop = Volver a la tienda
shop-btn-clear-cart = Vaciar carrito
shop-btn-checkout = Pagar
shop-btn-edit-quantity = Editar cantidad

# Modales de tienda
shop-modal-title-edit-cart-qty = Editar cantidad del carrito
shop-modal-label-quantity = Cantidad
shop-modal-placeholder-quantity = Introducid la nueva cantidad para este objeto
shop-error-invalid-number = Introducid un número válido.

# Vistas de tienda
shop-label-shopkeeper = Tendero: {"**"}{ $name }{"**"}
shop-label-unknown-item = Objeto desconocido
shop-label-out-of-stock = AGOTADO
shop-label-stock-available = Existencias: { $available }
shop-label-in-cart = (En carrito: { $quantity })
shop-title-cart = 🛒 {"**"}Carrito de la compra{"**"}
shop-msg-cart-empty = Vuestro carrito está vacío.
shop-warning-no-active-character = ⚠️ No se ha encontrado personaje activo. No se pueden verificar los fondos.
shop-warning-insufficient-funds = ⚠️ Fondos insuficientes para { $currency }
shop-label-invalid-cost = Coste inválido
shop-label-total-cost = {"**"}Coste total:{"**"}
shop-label-warning = {"**"}Aviso:{"**"}
shop-error-no-active-character = No tenéis un personaje activo en este servidor.
shop-error-checkout-insufficient = Error al pagar: { $currency } insuficiente.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} está agotado.

# Embed de informe de tienda
shop-embed-title-report = Informe de compras
shop-embed-field-purchased = Comprado
shop-label-no-items = Sin objetos
shop-embed-field-total-paid = Total pagado

# Opciones de compra
shop-title-purchase-options = Opciones de compra: { $itemName }
shop-msg-no-options = No hay opciones de compra disponibles para este objeto.

# Mensajes de tienda
shop-msg-item-removed = Objeto eliminado del carrito.
shop-msg-cart-updated = Carrito actualizado.

# Notificaciones de reposición
shop-restock-more-items = . . . y { $remaining } más.
shop-embed-title-restocked = ¡Tienda reabastecida!
shop-embed-footer-restocked = { $count } { $count ->
    [one] artículo reabastecido
   *[other] artículos reabastecidos
}
