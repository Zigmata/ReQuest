## Shop module strings

# Shop cog
shop-error-no-shops = 此服务器未配置商店。
shop-error-not-shop-channel =
    此频道未注册为商店频道。
    如果您认为这里应该有商店，请联系服务器管理员。

# Shop buttons
shop-btn-out-of-stock = 缺货
shop-btn-view-options = 查看购买选项
shop-btn-add-to-cart = 加入购物车（{ $cost }）
shop-btn-view-cart = 查看购物车
shop-btn-view-cart-count = 查看购物车（{ $count }）
shop-btn-back-to-shop = 返回商店
shop-btn-clear-cart = 清空购物车
shop-btn-checkout = 结算
shop-btn-edit-quantity = 编辑数量

# Shop modals
shop-modal-title-edit-cart-qty = 编辑购物车数量
shop-modal-label-quantity = 数量
shop-modal-placeholder-quantity = 输入此物品的新数量
shop-error-invalid-number = 请输入有效的数字。

# Shop views
shop-label-shopkeeper = 店主：{"**"}{ $name }{"**"}
shop-label-unknown-item = 未知物品
shop-label-out-of-stock = 已售罄
shop-label-stock-available = 库存：{ $available }
shop-label-in-cart = （购物车中：{ $quantity }）
shop-title-cart = 🛒 {"**"}购物车{"**"}
shop-msg-cart-empty = 您的购物车为空。
shop-warning-no-active-character = ⚠️ 未找到活跃角色。无法验证资金。
shop-warning-insufficient-funds = ⚠️ { $currency } 资金不足
shop-label-invalid-cost = 无效费用
shop-label-total-cost = {"**"}总费用：{"**"}
shop-label-warning = {"**"}警告：{"**"}
shop-error-no-active-character = 您在此服务器上没有活跃角色。
shop-error-checkout-insufficient = 结算失败：{ $currency } 不足。
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} 已售罄。

# Shop report embed
shop-embed-title-report = 购物报告
shop-embed-field-purchased = 已购买
shop-label-no-items = 无物品
shop-embed-field-total-paid = 总支付

# Purchase options
shop-title-purchase-options = 购买选项：{ $itemName }
shop-msg-no-options = 此物品没有可用的购买选项。

# Shop messages
shop-msg-item-removed = 物品已从购物车中移除。
shop-msg-cart-updated = 购物车已更新。

# Restock notifications
shop-restock-more-items = . . . 以及其他 { $remaining } 项。
shop-embed-title-restocked = 商店已补货！
shop-embed-footer-restocked = { $count } { $count ->
   *[other] 件物品
} 已补货
