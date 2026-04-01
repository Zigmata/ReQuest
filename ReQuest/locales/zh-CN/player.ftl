## Player module strings

# --- Cog ---

player-cmd-name = 交易
player-cmd-desc = 玩家菜单

# --- Buttons ---

# Character management
player-btn-register-character = 注册新角色
player-btn-activate = 激活
player-btn-active = 已激活

# Player board
player-btn-create-post = 创建帖子
player-btn-open-starting-shop = 打开初始商店
player-btn-select-kit = 选择套装
player-btn-input-inventory = 输入物品栏

# Wizard / shop buttons
player-btn-add-to-cart = 加入购物车
player-btn-add-to-cart-cost = 加入购物车（{ $costString }）
player-btn-view-purchase-options = 查看购买选项
player-btn-review-submit = 审核并提交（{ $count }）
player-btn-submit-character = 提交角色
player-btn-keep-shopping = 继续购物
player-btn-edit-quantity = 编辑数量
player-btn-clear-cart = 清空购物车

# Kit buttons
player-btn-confirm-selection = 确认选择
player-btn-back-to-kits = 返回套装列表

# Inventory management
player-btn-spend-currency = 花费货币
player-btn-print-inventory = 打印物品栏

# Container management
player-btn-manage-containers = 管理容器
player-btn-create-new = + 新建
player-btn-consume-destroy = 消耗/销毁
player-btn-move = 移动
player-btn-move-all = 全部移动
player-btn-move-some = 移动部分...
player-btn-back-to-overview = ← 返回概览
player-btn-cancel-move = ← 取消
player-btn-up = ▲ 上移
player-btn-down = ▼ 下移

# --- Modals ---

# Trade modal
player-modal-title-trade = 与 { $targetName } 交易
player-modal-label-trade-name = 名称
player-modal-placeholder-trade-name = 输入您交易的物品名称
player-modal-label-trade-quantity = 数量
player-modal-placeholder-trade-quantity = 输入您交易的数量

# Character register modal
player-modal-title-register = 注册新角色
player-modal-label-char-name = 名称
player-modal-placeholder-char-name = 输入您的角色名称。
player-modal-label-char-note = 备注
player-modal-placeholder-char-note = 输入备注以识别您的角色

# Open inventory input modal
player-modal-title-starting-inventory = 初始物品栏输入
player-modal-label-inventory = 物品栏
player-modal-placeholder-inventory-input =
    每行一个，格式为 <名称>: <数量>，例如：
    Sword: 1
    gold: 30

# Spend currency modal
player-modal-title-spend-currency = 花费货币
player-modal-label-currency-name = 货币名称
player-modal-placeholder-currency-name = 输入您要花费的货币名称
player-modal-label-currency-amount = 金额
player-modal-placeholder-currency-amount = 输入要花费的金额

# Create player post modal
player-modal-title-create-post = 创建玩家公告板帖子
player-modal-label-post-title = 标题
player-modal-placeholder-post-title = 输入帖子标题
player-modal-label-post-content = 帖子内容
player-modal-placeholder-post-content = 输入帖子正文

# Edit player post modal
player-modal-title-edit-post = 编辑玩家公告板帖子

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = 编辑购物车数量
player-modal-label-cart-qty = 数量
player-modal-placeholder-cart-qty = 输入新数量（0 表示移除）

# Create container modal
player-modal-title-create-container = 创建新容器
player-modal-label-container-name = 容器名称
player-modal-placeholder-container-name = 输入容器名称（例如：背包）

# Rename container modal
player-modal-title-rename-container = 重命名容器
player-modal-label-new-container-name = 新容器名称
player-modal-placeholder-new-container-name = 输入新名称

# Consume from container modal
player-modal-title-consume = 消耗/销毁物品
player-modal-label-consume-qty = 数量（最多：{ $maxQuantity }）
player-modal-placeholder-consume-qty = 输入要消耗/销毁的数量

# Move item quantity modal
player-modal-title-move-item = 移动物品
player-modal-label-move-qty = 移动数量（最多：{ $maxQuantity }）
player-modal-placeholder-move-qty = 输入要移动的数量

# --- Selects ---

player-select-placeholder-no-characters = 您没有已注册的角色
player-select-placeholder-remove-character = 选择要移除的角色
player-select-placeholder-post = 选择帖子
player-select-placeholder-container-view = 选择要查看的容器...
player-select-placeholder-item = 选择物品...
player-select-placeholder-destination = 选择目标...
player-select-placeholder-container = 选择容器...
player-select-option-no-containers = 没有容器
player-select-option-no-items = 没有物品
player-select-option-no-destinations = 没有目标

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}玩家命令 - 主菜单{"**"}
player-menu-btn-characters = 角色
player-menu-desc-characters = 注册、查看和激活玩家角色。
player-menu-btn-inventory = 物品栏
player-menu-desc-inventory = 查看您活跃角色的物品栏并花费货币。
player-menu-btn-player-board = 玩家公告板
player-menu-btn-player-board-disabled = 玩家公告板（未配置）
player-menu-desc-player-board = 为玩家公告板创建帖子

# CharacterBaseView
player-title-characters = {"**"}玩家命令 - 角色{"**"}
player-desc-register-character = 注册新角色。
player-msg-no-characters = 您没有已注册的角色。
player-label-active = （已激活）
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}角色创建中: { $characterName }{"**"}
    您的角色注册正在等待物品栏设置。
player-btn-resume = 继续
player-btn-discard = 放弃
player-modal-title-discard-character = 放弃角色
player-modal-label-discard-confirm = 放弃 { $characterName }？

# Confirm character removal
player-modal-title-confirm-char-removal = 确认移除角色
player-modal-label-confirm-char-delete = 删除 { $characterName }？

# Confirm post removal
player-modal-title-confirm-post-removal = 确认移除帖子
player-modal-label-post-removal-warning = 警告：此操作不可逆！

# InventoryOverviewView
player-title-inventory = {"**"}玩家命令 - 物品栏{"**"}
player-title-char-inventory = {"**"}{ $characterName } 的物品栏{"**"}
player-msg-no-active-character = 无活跃角色：请为此服务器激活一个角色以使用这些菜单。
player-msg-no-characters-registered = 无角色：请注册一个角色以使用这些菜单。
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } 个物品
player-label-currency = {"**"}货币{"**"}
player-msg-inventory-empty = 物品栏为空。

# Print inventory embed
player-embed-title-inventory = { $characterName } 的物品栏

# ContainerItemsView
player-msg-container-empty = 此容器为空。
player-label-selected-item = 已选择：{"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}移动"{ $itemName }"{"**"}（可用 { $available } 个）
player-msg-no-other-containers = 没有其他可用容器。
player-msg-select-destination = 选择目标容器：
player-label-destination = 目标：{"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}管理容器{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"}（{ $count } 个物品）{ $suffix }
player-label-default-suffix = { " " }（默认）
player-msg-no-containers = 没有容器。
player-label-selected-container = 已选择：{"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = 确认删除容器
player-modal-label-container-has-items = 包含 { $itemCount } 个物品。将移至散落物品。
player-modal-label-confirm-container-delete = 删除"{ $containerName }"？

# Container errors
player-error-cannot-rename-loose = 无法重命名散落物品。
player-error-cannot-delete-loose = 无法删除散落物品。

# PlayerBoardView
player-title-player-board = {"**"}玩家命令 - 玩家公告板{"**"}
player-desc-create-post = 为玩家公告板创建新帖子。
player-msg-no-posts = 您当前没有帖子。
player-label-post-info = {"**"}{ $title }{"**"}（ID: `{ $postId }`）
player-embed-field-author = 作者
player-embed-footer-post-id = 帖子 ID: { $postId }
player-error-board-channel-not-found = 未找到玩家公告板频道。

# NewCharacterWizardView
player-title-setup-inventory = {"**"}为 { $characterName } 设置物品栏{"**"}
player-desc-browse-shop = 浏览初始商店为您的角色装备。
player-desc-select-kit = 选择初始套装。
player-desc-input-inventory = 手动输入您的初始物品栏。

# StaticKitSelectView
player-title-select-kit = {"**"}为 { $characterName } 选择套装{"**"}
player-msg-no-kits = 没有可用的初始套装。
player-label-and-more-items = ...以及其他 { $count } 个物品
player-label-empty-kit = {"*"}空套装{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}确认选择：{ $kitName }{"**"}
player-label-items-heading = {"**"}物品：{"**"}
player-label-currency-heading = {"**"}货币：{"**"}
player-msg-kit-empty = 此套装为空。

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}购买选项：{ $itemName }{"**"}
player-msg-no-cost-options = 此物品没有可用的费用选项。
player-label-cost-option = {"**"}选项 { $index }：{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}初始商店（{ $inventoryType }）{"**"}
player-label-starting-wealth = 初始财富：{ $formattedCurrency }
player-label-in-cart = {"**"}（购物车中：{ $quantity }）{"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}查看购物车{"**"}
player-msg-cart-empty = 您的购物车为空。
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = （合计：{ $totalQuantity }）
player-label-insufficient-currency = { $currencyName } 不足
player-label-total-cost = {"**"}总费用：{"**"}
player-label-total-cost-free = {"**"}总费用：{"**"} 免费
player-label-cart-page = 第 { $current } 页，共 { $total } 页

# Trade embed
player-embed-title-trade = 交易报告
player-embed-desc-trade-sender = 发送方：{ $senderMention }，角色为 `{ $senderCharacter }`
player-embed-desc-trade-recipient = 接收方：{ $recipientMention }，角色为 `{ $recipientCharacter }`
player-embed-field-currency = 货币
player-embed-field-amount = 金额
player-embed-field-balance = { $characterName } 的余额
player-embed-field-item = 物品
player-embed-field-quantity = 数量
player-embed-footer-transaction-id = 交易 ID: { $transactionId }

# Trade errors
player-error-trade-no-characters = 您尝试交易的玩家没有角色！
player-error-trade-no-active = 您尝试交易的玩家在此服务器上没有活跃角色！

# Spend currency embed
player-embed-title-spend = 玩家交易报告
player-embed-desc-spend-player = 玩家：{ $playerMention }，角色为 `{ $characterName }`
player-embed-desc-spend-transaction = 交易：{"**"}{ $characterName }{"**"} 花费了 {"**"}{ $formattedAmount }{"**"}。
player-embed-field-channel = 频道
player-embed-field-receipt = 收据

# Spend currency errors
player-error-amount-not-number = 金额必须是数字。
player-error-amount-positive = 您必须花费正数金额。
player-error-amount-exceeds-maximum = 金额不能超过 { $max }。
player-error-no-active-character-server = 您在此服务器上没有活跃角色。
player-error-no-currency-config = 未找到此服务器的货币配置。

# Consume item embed
player-embed-title-consume = 物品消耗报告
player-embed-desc-consume = 玩家：{ $playerMention }，角色为 `{ $characterName }`
player-embed-desc-consume-removed = 移除：{"**"}{ $quantity }x { $itemName }{"**"}，来自 {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = 数量必须是正整数。
player-error-qty-at-least-one = 数量至少为 1。
player-error-qty-only-have = 您只有 { $maxQuantity } 个此物品。

# Inventory input errors
player-error-invalid-format = 无效的格式："{ $line }"。请使用 <名称>: <数量>。
player-error-empty-name = 物品名称不能为空，位于行："{ $line }"。
player-error-invalid-quantity = "{ $name }"的数量无效："{ $quantity }"。必须是正整数。
player-error-input-errors-header = 物品栏输入中的错误：
player-msg-no-valid-items = 未提供有效物品。将以空物品栏初始化。

# Cart quantity validation
player-error-enter-valid-number = 请输入有效的正数。

# Submission embeds (approval queue)
player-embed-title-approval = 物品栏审批：{ $characterName }
player-embed-desc-submitted-by = 由 { $userMention } 提交
player-embed-field-items = 物品
player-embed-field-currency-received = 货币
player-embed-footer-submission-id = 提交 ID: { $submissionId }
player-label-approval-thread = 审批：{ $characterName }
player-embed-title-submission-sent = 物品栏提交已发送
player-embed-desc-submission-sent =
    您为 {"**"}{ $characterName }{"**"} 的提交已发送至 GM 团队审批！
    审核完成后将通知您。
    [查看提交 Thread]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = 已应用初始物品栏
player-embed-desc-starting-inventory = 玩家：{ $playerMention }，角色为 `{ $characterName }`
player-embed-field-items-received = 获得的物品
player-embed-field-currency-received-label = 获得的货币
player-label-untitled = 无标题

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventory Submission: { $characterName }{"**"}
    Submitted by { $userMention }
player-approval-post-items = 物品
player-approval-post-currency = 货币
player-approval-resolved = 此提交已处理。
player-approval-btn-approve = 批准
player-approval-btn-deny = 拒绝
player-approval-btn-edit = 编辑
player-approval-error-no-permission = 您没有执行此操作的权限。
player-approval-error-not-submitter = 只有原始提交者才能编辑此提交。
player-approval-thread-instructions =
    This thread was created for the approval of a character's starting inventory.
    A Game Master will review the submission and approve or deny it.
    The submitting player may use the Edit button to modify and re-submit.
    Once approved or denied, this thread will be locked.
player-msg-submission-updated = 您的提交已更新。

# Approval DM notifications
player-dm-title-approved = 角色已批准
player-dm-desc-approved =
    Your character {"**"}{ $characterName }{"**"} has been approved
    by { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = 角色已拒绝
player-dm-desc-denied =
    Your character {"**"}{ $characterName }{"**"} has been denied
    by { $denier } in {"**"}{ $guildName }{"**"}. You may re-submit.
