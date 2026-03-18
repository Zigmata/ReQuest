## Строки модуля магазина

# Когда магазина
shop-error-no-shops = На этом сервере не настроены магазины.
shop-error-not-shop-channel =
    Этот канал не зарегистрирован как канал магазина.
    Если здесь должен быть магазин, сообщите об этом администратору сервера.

# Кнопки магазина
shop-btn-out-of-stock = Нет в наличии
shop-btn-view-options = Варианты покупки
shop-btn-add-to-cart = В корзину ({ $cost })
shop-btn-view-cart = Корзина
shop-btn-view-cart-count = Корзина ({ $count })
shop-btn-back-to-shop = Назад в магазин
shop-btn-clear-cart = Очистить корзину
shop-btn-checkout = Оформить заказ
shop-btn-edit-quantity = Изменить количество

# Модальные окна магазина
shop-modal-title-edit-cart-qty = Изменение количества в корзине
shop-modal-label-quantity = Количество
shop-modal-placeholder-quantity = Введите новое количество для этого предмета
shop-error-invalid-number = Введите допустимое число.

# Представления магазина
shop-label-shopkeeper = Торговец: {"**"}{ $name }{"**"}
shop-label-unknown-item = Неизвестный предмет
shop-label-out-of-stock = НЕТ В НАЛИЧИИ
shop-label-stock-available = Запас: { $available }
shop-label-in-cart = (В корзине: { $quantity })
shop-title-cart = 🛒 {"**"}Корзина{"**"}
shop-msg-cart-empty = Ваша корзина пуста.
shop-warning-no-active-character = ⚠️ Активный персонаж не найден. Невозможно проверить средства.
shop-warning-insufficient-funds = ⚠️ Недостаточно средств для { $currency }
shop-label-invalid-cost = Неверная стоимость
shop-label-total-cost = {"**"}Итого:{"**"}
shop-label-warning = {"**"}Внимание:{"**"}
shop-error-no-active-character = У вас нет активного персонажа на этом сервере.
shop-error-checkout-insufficient = Ошибка оформления: Недостаточно { $currency }.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} нет в наличии.

# Встраиваемое сообщение отчёта магазина
shop-embed-title-report = Отчёт о покупках
shop-embed-field-purchased = Куплено
shop-label-no-items = Нет предметов
shop-embed-field-total-paid = Всего оплачено

# Варианты покупки
shop-title-purchase-options = Варианты покупки: { $itemName }
shop-msg-no-options = Для этого предмета нет доступных вариантов покупки.

# Сообщения магазина
shop-msg-item-removed = Предмет удалён из корзины.
shop-msg-cart-updated = Корзина обновлена.

# Уведомления о пополнении
shop-restock-more-items = . . . и ещё { $remaining }.
shop-embed-title-restocked = Магазин пополнен!
shop-embed-footer-restocked = { $count } { $count ->
    [one] товар пополнен
    [few] товара пополнено
   *[other] товаров пополнено
}
