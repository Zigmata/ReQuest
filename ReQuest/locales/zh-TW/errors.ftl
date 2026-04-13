## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ 糟糕！
error-report-description =
    { $exception }

    如果此錯誤出乎意料，或您懷疑機器人運作不正常，請在 [ReQuest 官方支援 Discord](https://discord.gg/Zq37gj4) 中提交錯誤報告。

error-report-unexpected =
    發生了意外錯誤。請重試。

    如果此問題持續出現，請在 [ReQuest 官方支援 Discord](https://discord.gg/Zq37gj4) 中提交錯誤報告。

# Check failures
error-owner-only = 只有機器人擁有者可以使用此指令！
error-no-permission = 您沒有權限執行此指令！
error-no-active-character = 您在此伺服器上沒有啟用的角色！
error-no-registered-characters = 您沒有任何已註冊的角色！
error-no-characters = 目標玩家沒有任何已註冊的角色。
error-no-active-character-target = 目標玩家在此伺服器上沒有啟用的角色。
error-player-not-found = 找不到玩家資料。
error-character-not-found = 找不到角色資料。

# Currency/transaction errors
error-transaction-cannot-complete = 交易無法完成：
    { $reason }
error-insufficient-item-trade = 您擁有 { $owned }個 { $itemName }，但嘗試給予 { $quantity } 個。
error-currency-process-failed = 貨幣 { $currencyName } 無法處理。
error-insufficient-funds-transaction = 餘額不足，無法完成此交易。
error-insufficient-funds = 餘額不足。
error-insufficient-items = 物品不足：{ $itemName }
error-currency-not-configured = 貨幣「{ $currencyName }」尚未在此伺服器上設定。
error-cost-currency-system-mismatch = 費用貨幣「{ $currencyName }」不屬於其自身的貨幣系統。
error-currency-config-error = 貨幣設定錯誤：面額值為 0 或負數。
error-currency-validation = 貨幣驗證時發生錯誤：{ $error }
error-invalid-currency = { $itemName } 不是有效的貨幣。
error-insufficient-funds-for-transaction = 餘額不足，無法完成此交易。

# Cart errors
error-cart-not-found = 找不到購物車。
error-item-not-in-cart = 物品不在購物車中。
error-not-enough-stock = 庫存不足。

# Container errors
error-container-not-found = 找不到容器。
error-container-name-empty = 容器名稱不可為空。
error-container-name-too-long = 容器名稱不可超過 { $maxLength } 個字元。
error-max-containers-reached = 您最多只能建立 { $maxContainers } 個容器。
error-container-name-exists = 名為「{ $containerName }」的容器已存在。
error-item-already-in-container = 物品已在此容器中。
error-quantity-minimum = 數量至少為 1。
error-source-container-not-found = 找不到來源容器。
error-item-not-in-source = 在來源容器中找不到物品「{ $itemName }」。
error-insufficient-quantity-in-container = 數量不足。此容器中有 { $available } 個。
error-dest-container-not-found = 找不到目標容器。
error-item-not-in-container = 在此容器中找不到物品「{ $itemName }」。
error-insufficient-quantity-consume = 此容器中您只有 { $available } 個此物品。
