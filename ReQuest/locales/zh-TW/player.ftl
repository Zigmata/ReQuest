## Player module strings

# --- Cog ---

player-cmd-name = 交易
player-cmd-desc = 玩家選單

# --- Buttons ---

# Character management
player-btn-register-character = 註冊新角色
player-btn-activate = 啟用
player-btn-active = 已啟用

# Player board
player-btn-create-post = 建立發文
player-btn-open-starting-shop = 開啟起始商店
player-btn-select-kit = 選擇套組
player-btn-input-inventory = 輸入背包

# Wizard / shop buttons
player-btn-add-to-cart = 加入購物車
player-btn-add-to-cart-cost = 加入購物車（{ $costString }）
player-btn-view-purchase-options = 檢視購買選項
player-btn-review-submit = 檢查並提交（{ $count }）
player-btn-submit-character = 提交角色
player-btn-keep-shopping = 繼續購物
player-btn-edit-quantity = 編輯數量
player-btn-clear-cart = 清空購物車

# Kit buttons
player-btn-confirm-selection = 確認選擇
player-btn-back-to-kits = 返回套組

# Inventory management
player-btn-spend-currency = 花費貨幣
player-btn-print-inventory = 列印背包

# Container management
player-btn-manage-containers = 管理容器
player-btn-create-new = + 新建
player-btn-consume-destroy = 消耗/銷毀
player-btn-move = 移動
player-btn-move-all = 全部移動
player-btn-move-some = 移動部分...
player-btn-back-to-overview = ← 返回概覽
player-btn-cancel-move = ← 取消
player-btn-up = ▲ 上移
player-btn-down = ▼ 下移

# --- Modals ---

# Trade modal
player-modal-title-trade = 正在與 { $targetName } 交易
player-modal-label-trade-name = 名稱
player-modal-placeholder-trade-name = 輸入您交易的物品名稱
player-modal-label-trade-quantity = 數量
player-modal-placeholder-trade-quantity = 輸入您交易的數量

# Character register modal
player-modal-title-register = 註冊新角色
player-modal-label-char-name = 名稱
player-modal-placeholder-char-name = 輸入您的角色名稱。
player-modal-label-char-note = 備註
player-modal-placeholder-char-note = 輸入用於識別角色的備註

# Open inventory input modal
player-modal-title-starting-inventory = 起始背包輸入
player-modal-label-inventory = 背包
player-modal-placeholder-inventory-input =
    每行一項，格式為 <名稱>: <數量>，例如：
    Sword: 1
    gold: 30

# Spend currency modal
player-modal-title-spend-currency = 花費貨幣
player-modal-label-currency-name = 貨幣名稱
player-modal-placeholder-currency-name = 輸入您要花費的貨幣名稱
player-modal-label-currency-amount = 金額
player-modal-placeholder-currency-amount = 輸入要花費的金額

# Create player post modal
player-modal-title-create-post = 建立玩家公告板發文
player-modal-label-post-title = 標題
player-modal-placeholder-post-title = 輸入您發文的標題
player-modal-label-post-content = 發文內容
player-modal-placeholder-post-content = 輸入您發文的內容

# Edit player post modal
player-modal-title-edit-post = 編輯玩家公告板發文

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = 編輯購物車數量
player-modal-label-cart-qty = 數量
player-modal-placeholder-cart-qty = 輸入新數量（0 表示移除）

# Create container modal
player-modal-title-create-container = 新建容器
player-modal-label-container-name = 容器名稱
player-modal-placeholder-container-name = 輸入容器名稱（例如：背包）

# Rename container modal
player-modal-title-rename-container = 重新命名容器
player-modal-label-new-container-name = 新容器名稱
player-modal-placeholder-new-container-name = 輸入新名稱

# Consume from container modal
player-modal-title-consume = 消耗/銷毀物品
player-modal-label-consume-qty = 數量（最多：{ $maxQuantity }）
player-modal-placeholder-consume-qty = 輸入要消耗/銷毀的數量

# Move item quantity modal
player-modal-title-move-item = 移動物品
player-modal-label-move-qty = 要移動的數量（最多：{ $maxQuantity }）
player-modal-placeholder-move-qty = 輸入要移動的數量

# --- Selects ---

player-select-placeholder-no-characters = 您沒有已註冊的角色
player-select-placeholder-remove-character = 選擇要移除的角色
player-select-placeholder-post = 選擇一篇發文
player-select-placeholder-container-view = 選擇要檢視的容器...
player-select-placeholder-item = 選擇物品...
player-select-placeholder-destination = 選擇目的地...
player-select-placeholder-container = 選擇容器...
player-select-option-no-containers = 沒有容器
player-select-option-no-items = 沒有物品
player-select-option-no-destinations = 沒有目的地

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}玩家指令 - 主選單{"**"}
player-menu-btn-characters = 角色
player-menu-desc-characters = 註冊、檢視和啟用玩家角色。
player-menu-btn-inventory = 背包
player-menu-desc-inventory = 檢視您啟用角色的背包並花費貨幣。
player-menu-btn-player-board = 玩家公告板
player-menu-btn-player-board-disabled = 玩家公告板（未設定）
player-menu-desc-player-board = 為玩家公告板建立發文

# CharacterBaseView
player-title-characters = {"**"}玩家指令 - 角色{"**"}
player-desc-register-character = 註冊新角色。
player-msg-no-characters = 您沒有已註冊的角色。
player-label-active = （已啟用）
player-label-xp = { $xp } XP

# Confirm character removal
player-modal-title-confirm-char-removal = 確認移除角色
player-modal-label-confirm-char-delete = 刪除 { $characterName }？

# Confirm post removal
player-modal-title-confirm-post-removal = 確認移除發文
player-modal-label-post-removal-warning = 警告：此操作無法復原！

# InventoryOverviewView
player-title-inventory = {"**"}玩家指令 - 背包{"**"}
player-title-char-inventory = {"**"}{ $characterName } 的背包{"**"}
player-msg-no-active-character = 無啟用角色：請在此伺服器上啟用一個角色以使用這些選單。
player-msg-no-characters-registered = 無角色：請註冊一個角色以使用這些選單。
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } 個物品
player-label-currency = {"**"}貨幣{"**"}
player-msg-inventory-empty = 背包是空的。

# Print inventory embed
player-embed-title-inventory = { $characterName } 的背包

# ContainerItemsView
player-msg-container-empty = 此容器是空的。
player-label-selected-item = 已選擇：{"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}移動「{ $itemName }」{"**"}（可用 { $available } 個）
player-msg-no-other-containers = 沒有其他可用的容器。
player-msg-select-destination = 選擇目標容器：
player-label-destination = 目的地：{"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}管理容器{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"}（{ $count } 個物品）{ $suffix }
player-label-default-suffix = { " " }（預設）
player-msg-no-containers = 沒有容器。
player-label-selected-container = 已選擇：{"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = 確認刪除容器
player-modal-label-container-has-items = 包含 { $itemCount } 個物品。將移至散落物品。
player-modal-label-confirm-container-delete = 刪除「{ $containerName }」？

# Container errors
player-error-cannot-rename-loose = 無法重新命名散落物品。
player-error-cannot-delete-loose = 無法刪除散落物品。

# PlayerBoardView
player-title-player-board = {"**"}玩家指令 - 玩家公告板{"**"}
player-desc-create-post = 為玩家公告板建立新發文。
player-msg-no-posts = 您目前沒有任何發文。
player-label-post-info = {"**"}{ $title }{"**"}（ID：`{ $postId }`）
player-embed-field-author = 作者
player-embed-footer-post-id = 發文 ID：{ $postId }
player-error-board-channel-not-found = 找不到玩家公告板頻道。

# NewCharacterWizardView
player-title-setup-inventory = {"**"}為 { $characterName } 設定背包{"**"}
player-desc-browse-shop = 瀏覽起始商店以裝備您的角色。
player-desc-select-kit = 選擇起始套組。
player-desc-input-inventory = 手動輸入您的起始背包。

# StaticKitSelectView
player-title-select-kit = {"**"}為 { $characterName } 選擇套組{"**"}
player-msg-no-kits = 沒有可用的起始套組。
player-label-and-more-items = ⋯以及其他 { $count } 個物品
player-label-empty-kit = {"*"}空套組{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}確認選擇：{ $kitName }{"**"}
player-label-items-heading = {"**"}物品：{"**"}
player-label-currency-heading = {"**"}貨幣：{"**"}
player-msg-kit-empty = 此套組是空的。

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}購買選項：{ $itemName }{"**"}
player-msg-no-cost-options = 此物品沒有可用的購買選項。
player-label-cost-option = {"**"}選項 { $index }：{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}起始商店（{ $inventoryType }）{"**"}
player-label-starting-wealth = 起始財富：{ $formattedCurrency }
player-label-in-cart = {"**"}（購物車中：{ $quantity }）{"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}檢查購物車{"**"}
player-msg-cart-empty = 您的購物車是空的。
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = （總計：{ $totalQuantity }）
player-label-insufficient-currency = { $currencyName } 不足
player-label-total-cost = {"**"}總費用：{"**"}
player-label-total-cost-free = {"**"}總費用：{"**"} 免費
player-label-cart-page = 第 { $current } 頁，共 { $total } 頁

# Trade embed
player-embed-title-trade = 交易報告
player-embed-desc-trade-sender = 發送者：{ $senderMention }，角色 `{ $senderCharacter }`
player-embed-desc-trade-recipient = 接收者：{ $recipientMention }，角色 `{ $recipientCharacter }`
player-embed-field-currency = 貨幣
player-embed-field-amount = 金額
player-embed-field-balance = { $characterName } 的餘額
player-embed-field-item = 物品
player-embed-field-quantity = 數量
player-embed-footer-transaction-id = 交易 ID：{ $transactionId }

# Trade errors
player-error-trade-no-characters = 您嘗試交易的對象沒有任何角色！
player-error-trade-no-active = 您嘗試交易的對象在此伺服器上沒有啟用的角色！

# Spend currency embed
player-embed-title-spend = 玩家交易報告
player-embed-desc-spend-player = 玩家：{ $playerMention }，角色 `{ $characterName }`
player-embed-desc-spend-transaction = 交易：{"**"}{ $characterName }{"**"} 花費了 {"**"}{ $formattedAmount }{"**"}。
player-embed-field-channel = 頻道
player-embed-field-receipt = 收據

# Spend currency errors
player-error-amount-not-number = 金額必須為數字。
player-error-amount-positive = 您必須花費正數金額。
player-error-no-active-character-server = 您在此伺服器上沒有啟用的角色。
player-error-no-currency-config = 在此伺服器上找不到貨幣設定。

# Consume item embed
player-embed-title-consume = 物品消耗報告
player-embed-desc-consume = 玩家：{ $playerMention }，角色 `{ $characterName }`
player-embed-desc-consume-removed = 已移除：{"**"}{ $quantity }x { $itemName }{"**"}，來自 {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = 數量必須為正整數。
player-error-qty-at-least-one = 數量至少為 1。
player-error-qty-only-have = 您只有 { $maxQuantity } 個此物品。

# Inventory input errors
player-error-invalid-format = 無效的格式：「{ $line }」。請使用 <名稱>: <數量>。
player-error-empty-name = 在行「{ $line }」中，物品名稱不可為空。
player-error-invalid-quantity = 「{ $name }」的數量無效：「{ $quantity }」。必須為正整數。
player-error-input-errors-header = 背包輸入中的錯誤：
player-msg-no-valid-items = 未提供有效的物品。以空背包初始化。

# Cart quantity validation
player-error-enter-valid-number = 請輸入有效的正數。

# Submission embeds (approval queue)
player-embed-title-approval = 背包審核：{ $characterName }
player-embed-desc-submitted-by = 由 { $userMention } 提交
player-embed-field-items = 物品
player-embed-field-currency-received = 貨幣
player-embed-footer-submission-id = 提交 ID：{ $submissionId }
player-label-approval-thread = 審核：{ $characterName }
player-embed-title-submission-sent = 背包提交已發送
player-embed-desc-submission-sent =
    您為 {"**"}{ $characterName }{"**"} 的提交已發送至 GM 團隊進行審核！
    審查完成後您將會收到通知。
    [檢視提交討論串]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = 已套用起始背包
player-embed-desc-starting-inventory = 玩家：{ $playerMention }，角色 `{ $characterName }`
player-embed-field-items-received = 已獲得物品
player-embed-field-currency-received-label = 已獲得貨幣
player-label-untitled = 無標題
