## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ 出错了！
error-report-description =
    发生了一个异常：

    ```{ $exception }```

    如果此错误出乎意料，或者您怀疑机器人运行不正常，请在 [ReQuest 官方支持 Discord](https://discord.gg/Zq37gj4) 中提交错误报告。

# Check failures
error-owner-only = 只有机器人所有者才能使用此命令！
error-no-permission = 您没有权限运行此命令！
error-no-active-character = 您在此服务器上没有已激活的角色！
error-no-registered-characters = 您没有任何已注册的角色！
error-no-characters = 目标玩家没有任何已注册的角色。
error-no-active-character-target = 目标玩家在此服务器上没有已激活的角色。
error-player-not-found = 未找到玩家数据。
error-character-not-found = 未找到角色数据。

# Currency/transaction errors
error-transaction-cannot-complete = 交易无法完成：
    { $reason }
error-insufficient-item-trade = 您拥有 { $owned }x { $itemName }，但尝试赠送 { $quantity } 个。
error-currency-process-failed = 货币 { $currencyName } 无法处理。
error-insufficient-funds-transaction = 资金不足，无法完成此交易。
error-insufficient-funds = 资金不足。
error-insufficient-items = 物品不足：{ $itemName }
error-currency-not-configured = 货币 '{ $currencyName }' 未在此服务器上配置。
error-cost-currency-system-mismatch = 花费货币 '{ $currencyName }' 不属于其自身的货币体系。
error-currency-config-error = 货币配置错误：面额值为 0 或负数。
error-currency-validation = 货币验证时发生错误：{ $error }
error-invalid-currency = { $itemName } 不是有效的货币。
error-insufficient-funds-for-transaction = 此交易资金不足。

# Cart errors
error-cart-not-found = 未找到购物车。
error-item-not-in-cart = 物品不在购物车中。
error-not-enough-stock = 库存不足。

# Container errors
error-container-not-found = 未找到容器。
error-container-name-empty = 容器名称不能为空。
error-container-name-too-long = 容器名称不能超过 { $maxLength } 个字符。
error-max-containers-reached = 您最多只能创建 { $maxContainers } 个容器。
error-container-name-exists = 名为"{ $containerName }"的容器已存在。
error-item-already-in-container = 物品已在此容器中。
error-quantity-minimum = 数量至少为 1。
error-source-container-not-found = 未找到来源容器。
error-item-not-in-source = 在来源容器中未找到物品"{ $itemName }"。
error-insufficient-quantity-in-container = 数量不足。此容器中只有 { $available } 个。
error-dest-container-not-found = 未找到目标容器。
error-item-not-in-container = 在此容器中未找到物品"{ $itemName }"。
error-insufficient-quantity-consume = 此容器中此物品只有 { $available } 个。
