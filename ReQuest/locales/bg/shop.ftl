## Shop module strings

# Shop cog
shop-error-no-shops = Няма конфигурирани магазини за този сървър.
shop-error-not-shop-channel =
    Този канал не е регистриран като канал за магазин.
    Ако смятате, че тук трябва да има магазин, уведомете администратора на сървъра.

# Shop buttons
shop-btn-out-of-stock = Изчерпано
shop-btn-view-options = Преглед на опциите за покупка
shop-btn-add-to-cart = Добави в кошницата ({ $cost })
shop-btn-view-cart = Преглед на кошницата
shop-btn-view-cart-count = Преглед на кошницата ({ $count })
shop-btn-back-to-shop = Обратно към магазина
shop-btn-clear-cart = Изчисти кошницата
shop-btn-checkout = Плащане
shop-btn-edit-quantity = Промяна на количеството

# Shop modals
shop-modal-title-edit-cart-qty = Промяна на количеството в кошницата
shop-modal-label-quantity = Количество
shop-modal-placeholder-quantity = Въведете новото количество за този предмет
shop-error-invalid-number = Моля, въведете валидно число.

# Shop views
shop-label-shopkeeper = Търговец: {"**"}{ $name }{"**"}
shop-label-unknown-item = Неизвестен предмет
shop-label-out-of-stock = ИЗЧЕРПАНО
shop-label-stock-available = Наличност: { $available }
shop-label-in-cart = (В кошницата: { $quantity })
shop-title-cart = 🛒 {"**"}Кошница{"**"}
shop-msg-cart-empty = Кошницата ви е празна.
shop-warning-no-active-character = ⚠️ Не е намерен активен герой. Средствата не могат да бъдат проверени.
shop-warning-insufficient-funds = ⚠️ Недостатъчно средства за { $currency }
shop-label-invalid-cost = Невалидна цена
shop-label-total-cost = {"**"}Обща цена:{"**"}
shop-label-warning = {"**"}Внимание:{"**"}
shop-error-no-active-character = Нямате активен герой на този сървър.
shop-error-checkout-insufficient = Плащането е неуспешно: Недостатъчно { $currency }.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} е изчерпан.

# Shop report embed
shop-embed-title-report = Отчет за покупки
shop-embed-field-purchased = Закупени
shop-label-no-items = Няма предмети
shop-embed-field-total-paid = Общо платено

# Purchase options
shop-title-purchase-options = Опции за покупка: { $itemName }
shop-msg-no-options = Няма налични опции за покупка на този предмет.

# Shop messages
shop-msg-item-removed = Предметът е премахнат от кошницата.
shop-msg-cart-updated = Кошницата е обновена.

# Restock notifications
shop-restock-more-items = . . . и още { $remaining }.
shop-embed-title-restocked = Магазинът е зареден!
shop-embed-footer-restocked = { $count } { $count ->
    [one] предмет зареден
   *[other] предмета заредени
}
