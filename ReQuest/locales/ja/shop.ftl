## Shop module strings

# Shop cog
shop-error-no-shops = このサーバーにはショップが設定されていません。
shop-error-not-shop-channel =
    このチャンネルはショップチャンネルとして登録されていません。
    ここにショップがあるはずだと思う場合は、サーバー管理者にお知らせください。

# Shop buttons
shop-btn-out-of-stock = 在庫切れ
shop-btn-view-options = 購入オプションを表示
shop-btn-add-to-cart = カートに追加（{ $cost }）
shop-btn-view-cart = カートを表示
shop-btn-view-cart-count = カートを表示（{ $count }）
shop-btn-back-to-shop = ショップに戻る
shop-btn-clear-cart = カートをクリア
shop-btn-checkout = 会計
shop-btn-edit-quantity = 数量を変更

# Shop modals
shop-modal-title-edit-cart-qty = カート数量を変更
shop-modal-label-quantity = 数量
shop-modal-placeholder-quantity = このアイテムの新しい数量を入力してください
shop-error-invalid-number = 有効な数値を入力してください。

# Shop views
shop-label-shopkeeper = 店主: {"**"}{ $name }{"**"}
shop-label-unknown-item = 不明なアイテム
shop-label-out-of-stock = 在庫切れ
shop-label-stock-available = 在庫: { $available }
shop-label-in-cart = （カート内: { $quantity }）
shop-title-cart = 🛒 {"**"}ショッピングカート{"**"}
shop-msg-cart-empty = カートは空です。
shop-warning-no-active-character = ⚠️ 有効なキャラクターが見つかりません。資金を確認できません。
shop-warning-insufficient-funds = ⚠️ { $currency } の資金が不足しています
shop-label-invalid-cost = 無効なコスト
shop-label-total-cost = {"**"}合計コスト:{"**"}
shop-label-warning = {"**"}警告:{"**"}
shop-error-no-active-character = このサーバーで有効なキャラクターがいません。
shop-error-checkout-insufficient = 会計失敗: { $currency } が不足しています。
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} は在庫切れです。

# Shop report embed
shop-embed-title-report = ショッピングレポート
shop-embed-field-purchased = 購入済み
shop-label-no-items = アイテムなし
shop-embed-field-total-paid = 支払合計

# Purchase options
shop-title-purchase-options = 購入オプション: { $itemName }
shop-msg-no-options = このアイテムには利用可能な購入オプションがありません。

# Shop messages
shop-msg-item-removed = カートからアイテムが削除されました。
shop-msg-cart-updated = カートが更新されました。

# Restock notifications
shop-restock-more-items = . . . 他 { $remaining } 件
shop-embed-title-restocked = ショップが補充されました！
shop-embed-footer-restocked = { $count ->
   *[other] { $count } 個のアイテムが補充されました
}
