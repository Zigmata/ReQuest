## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = 清除
config-btn-remove-gm-roles = 移除 GM 角色
config-btn-forbidden-roles = 禁止角色

# Quests
config-btn-toggle-quest-summary = 切换 Quest 摘要
config-btn-toggle-player-experience = 切换玩家经验
config-btn-toggle-display = 切换显示方式
config-btn-purge-player-board = 清理玩家公告板
config-btn-add-modify-rewards = 添加/修改奖励

# Currency
config-btn-add-denomination = 添加面额
config-btn-add-new-currency = 添加新货币
config-btn-remove-currency = 移除货币

# Shops - creation
config-btn-add-shop-wizard = 添加商店（向导）
config-btn-add-shop-json = 添加商店（JSON）
config-btn-edit-shop-wizard = 编辑商店（向导）
config-btn-edit-shop-json = 编辑商店（JSON）
config-btn-remove-shop = 移除商店
config-btn-add-item = 添加物品
config-btn-edit-shop-details = 编辑商店详情
config-btn-download-json = 下载 JSON
config-btn-done-editing = 完成编辑
config-btn-scan-server-configs = 扫描服务器配置
config-btn-re-scan = 重新扫描

# New character shop
config-btn-upload-json = 上传 JSON
config-btn-configure-new-character-wealth = 配置新角色财富
config-btn-configure-new-character-shop = 配置新角色商店
config-btn-clear-shop = 清空商店
config-btn-configure-static-kits = 配置固定套装
config-btn-new-character-settings = 新角色设置
config-btn-disabled-no-currency = 已禁用（未配置货币）
config-btn-disabled-no-wealth = 已禁用（未配置初始财富）

# Static kits
config-btn-create-new-kit = 创建新套装
config-btn-delete-kit = 删除套装
config-btn-add-currency = 添加货币

# Roleplay
config-btn-toggle-rp-rewards = 切换角色扮演奖励
config-btn-clear-channels = 清除频道
config-btn-edit-settings = 编辑设置
config-btn-configure-rewards = 配置奖励

# Stock
config-btn-stock-limits = 库存限制
config-btn-set-limit = 设置限制
config-btn-edit-limit = 编辑限制
config-btn-remove-limit = 移除限制
config-btn-configure-restock-schedule = 配置补货计划
config-btn-back-to-shop-editor = 返回商店编辑器

# Forum shop
config-btn-create-new-thread = 创建新 Thread
config-btn-use-existing-thread = 使用已有 Thread

# Wizard
config-btn-quit = 退出
config-btn-configure-channels = 配置频道
config-btn-configure-roles = 配置角色
config-btn-configure-quests = 配置 Quest
config-btn-configure-players = 配置玩家
config-btn-configure-currency = 配置货币
config-btn-configure-rp-rewards = 配置角色扮演奖励
config-btn-configure-shops = 配置商店
config-btn-new-char-setup = 新角色设置

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = 确认移除角色
config-modal-title-confirm-removal = 确认移除
config-modal-title-confirm-currency-removal = 确认移除货币
config-modal-title-confirm-shop-removal = 确认移除商店
config-modal-title-confirm-kit-deletion = 确认删除套装
config-modal-title-confirm-remove-stock-limit = 确认移除库存限制
config-modal-title-clear-shop = 确认清空商店

# Confirm modal prompt labels
config-modal-label-remove-role = 移除 { $roleName }？
config-modal-label-remove-denomination = 移除 { $denominationName }？
config-modal-label-remove-currency = 移除 { $currencyName }？
config-modal-label-shop-removal-warning = 警告：此操作不可逆！
config-modal-label-kit-deletion-warning = 警告：不可逆！
config-modal-label-remove-stock-limit = 输入 确认 以移除库存限制
config-modal-label-clear-shop = 清空此商店的所有物品？

# Error messages from buttons
config-error-shop-data-not-found = 错误：找不到该商店的数据。
config-msg-shop-json-download = 以下是 {"**"}{ $shopName }{"**"} 的 JSON 定义。
config-msg-new-char-shop-json-download = 以下是新角色商店的 JSON 定义。
config-error-select-forum-first = 请先选择一个 Forum 频道。
config-error-select-thread-first = 请先选择一个 Thread。

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = 添加新货币
config-modal-label-currency-name = 货币名称
config-error-currency-already-exists = 名为 { $name } 的货币或面额已存在！

# RenameCurrencyModal
config-modal-title-rename-currency = 重命名货币
config-modal-label-new-currency-name = 新货币名称
config-error-currency-name-exists = 名为"{ $name }"的货币已存在。
config-error-denomination-name-exists = 名为"{ $name }"的面额已存在。

# RenameDenominationModal
config-modal-title-rename-denomination = 重命名面额
config-modal-label-new-denomination-name = 新面额名称

# AddCurrencyDenominationModal
config-modal-title-add-denomination = 添加 { $currencyName } 面额
config-modal-label-denomination-name = 名称
config-modal-placeholder-denomination-name = 例如：银币
config-modal-label-denomination-value = 数值
config-modal-placeholder-denomination-value = 例如：0.1
config-error-denomination-matches-currency = 新面额名称不能与此服务器上已有的货币同名！发现已有货币名为"{ $existingName }"。
config-error-denomination-matches-denomination = 新面额名称不能与此服务器上已有的面额同名！发现已有面额名为"{ $denominationName }"，属于货币"{ $currencyName }"。
config-error-denomination-value-exists = 同一货币下的面额必须具有唯一数值！{ $denominationName } 已被分配此数值。

# ForbiddenRolesModal
config-modal-title-forbidden-roles = 禁止角色名称
config-modal-label-names = 名称
config-modal-placeholder-names = 输入名称，以逗号分隔
config-msg-forbidden-roles-updated = 禁止角色已更新！

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = 清理玩家公告板
config-modal-label-age = 时间
config-modal-placeholder-age = 输入要保留的最大帖子天数
config-msg-posts-purged = 超过 { $days } 天的帖子已被清理！

# GMRewardsModal
config-modal-title-gm-rewards = 添加/修改 GM 奖励
config-modal-label-experience = 经验值
config-modal-placeholder-enter-number = 输入一个数字
config-modal-label-items = 物品
config-modal-placeholder-items =
    名称: 数量
    名称2: 数量
    以此类推。
config-error-experience-invalid = 经验值必须是有效的整数（例如 2000）。
config-error-item-format-invalid = 无效的物品格式："{ $item }"。每个物品必须在新行上，格式为"名称: 数量"。

# ConfigShopDetailsModal
config-modal-title-shop-details = 添加/编辑商店详情
config-modal-label-shop-channel = 选择频道
config-modal-placeholder-shop-channel = 选择此商店的频道
config-modal-label-shop-name = 商店名称
config-modal-placeholder-shop-name = 输入商店名称
config-modal-label-shopkeeper-name = 店主名称
config-modal-placeholder-shopkeeper-name = 输入店主名称
config-modal-label-shop-description = 商店描述
config-modal-placeholder-shop-description = 输入商店描述
config-modal-label-shop-image-url = 商店图片 URL
config-modal-placeholder-shop-image-url = 输入商店图片的 URL
config-error-no-channel-selected = 未选择商店频道。
config-error-shop-already-in-channel = 所选频道中已注册了一个商店。请选择其他频道或编辑现有商店。

# build_shop_header_view
config-label-shopkeeper = {"**"}店主:{"**"} { $name }
config-msg-use-shop-command = 使用 `/shop` 命令浏览和购买物品。

# ForumThreadShopModal
config-modal-title-forum-thread-shop = 创建 Forum Thread 商店
config-modal-label-thread-name = Thread 名称
config-modal-placeholder-thread-name = 输入商店 Thread 的名称
config-error-forum-not-found = 找不到所选的 Forum 频道。
config-error-shop-already-in-thread = 此 Thread 中已注册了一个商店。新 Thread 不应出现此情况。

# ConfigShopJSONModal
config-modal-title-add-shop-json = 通过 JSON 添加新商店
config-modal-label-upload-json = 上传包含商店数据的 .json 文件
config-error-no-json-uploaded = 未上传商店的 JSON 文件。
config-error-file-must-be-json = 上传的文件必须是 JSON 文件（.json）。
config-error-invalid-json = 无效的 JSON 格式：{ $error }
config-error-json-validation-failed = JSON 不符合架构：{ $error }

# ShopItemModal
config-modal-title-shop-item = 添加/编辑商店物品
config-modal-label-item-name = 物品名称
config-modal-placeholder-item-name = 输入物品名称
config-modal-label-item-description = 物品描述
config-modal-placeholder-item-description = 输入物品描述
config-modal-label-item-quantity = 物品数量
config-modal-placeholder-item-quantity = 输入每次购买出售的数量
config-modal-label-item-costs = 物品费用
config-modal-placeholder-item-costs = 例如：10 gold + 5 silver\n或：50 rep\n（用 + 表示"且"，换行表示"或"）
config-error-item-quantity-positive = 物品数量必须是正整数。
config-error-cost-format-invalid = 无效的费用格式："{ $option }"。每项费用必须包含金额和货币名，用空格分隔，例如"10 gold"。
config-error-cost-amount-invalid = 货币"{ $currency }"的金额"{ $amount }"无效。金额必须是正数。
config-error-unknown-currency = 未知货币 `{ $currency }`。请使用此服务器上已配置的有效货币。
config-error-item-already-exists = 此商店中已存在名为 { $itemName } 的物品。

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = 通过 JSON 更新商店
config-modal-label-upload-new-json = 上传新的 JSON 定义
config-error-no-file-uploaded = 未上传文件。
config-error-file-must-be-json-ext = 文件必须是 `.json` 格式。
config-error-json-validation-message = JSON 验证失败：{ $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = 添加/编辑新角色装备
config-modal-placeholder-item-quantity-selection = 输入每次选择获得的数量
config-modal-label-item-cost = 物品费用
config-error-cost-format-short = 无效的费用格式：'{ $component }'。应为 '金额 货币名'。
config-error-amount-invalid-short = 货币 '{ $currency }' 的金额 '{ $amount }' 无效。
config-error-item-exists-new-char = 新角色商店中已存在名为 { $itemName } 的物品。

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = 上传新角色商店（JSON）
config-error-no-json-uploaded-short = 未上传 JSON 文件。
config-error-json-must-have-shopstock = JSON 必须包含 'shopStock' 数组。
config-error-items-must-have-name-price = 所有物品必须包含 'name' 和 'price' 字段。

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = 设置新角色财富
config-modal-label-amount = 金额
config-modal-placeholder-amount = 输入此货币的金额。
config-modal-placeholder-currency-name = 输入此服务器上已定义的货币名称
config-error-no-currencies-configured = 此服务器未配置任何货币。
config-error-currency-not-found = 未找到名为 { $name } 的货币或面额。请使用有效的货币。

# CreateStaticKitModal
config-modal-title-create-kit = 创建新固定套装
config-modal-label-kit-name = 套装名称
config-modal-placeholder-kit-name = 例如：战士入门套装
config-modal-label-description = 描述
config-modal-placeholder-kit-description = 此套装的可选描述
config-error-kit-name-exists = 名为"{ $kitName }"的固定套装已存在。请选择其他名称。

# StaticKitItemModal
config-modal-title-kit-item = 添加/编辑套装物品
config-modal-placeholder-kit-item-quantity = 输入此物品在套装中的数量

# StaticKitCurrencyModal
config-modal-title-kit-currency = 添加套装货币
config-modal-placeholder-currency-eg = 例如：Gold
config-modal-placeholder-amount-eg = 例如：100
config-error-amount-must-be-number = 金额必须是数字。
config-error-amount-exceeds-maximum = 金额不能超过 { $max }。
config-error-no-currencies-on-server = 服务器未配置任何货币。
config-error-currency-not-found-short = 未找到货币"{ $currency }"。
config-error-denomination-not-found = 在货币配置中未找到面额"{ $denomination }"。

# RoleplaySettingsModal
config-modal-title-rp-settings = 角色扮演设置
config-modal-label-min-message-length = 最短消息长度（字符数）
config-modal-placeholder-min-message-length = 消息符合条件所需的最少字符数。0 表示无限制
config-modal-label-cooldown = 冷却时间（秒）
config-modal-placeholder-cooldown = 两次计入奖励的消息之间的等待时间（秒）
config-modal-label-message-threshold = 消息阈值
config-modal-placeholder-message-threshold = 触发奖励所需的消息数量
config-modal-label-frequency = 频率（消息数）
config-modal-placeholder-frequency = 获得奖励所需的合格消息数量
config-error-min-length-invalid = 最短消息长度必须是非负整数。
config-error-cooldown-invalid = 冷却时间必须是非负整数。
config-error-threshold-invalid = 消息阈值必须是正整数。
config-error-frequency-invalid = 频率必须是正整数。

# RoleplayRewardsModal
config-modal-title-rp-rewards = 配置角色扮演奖励
config-modal-label-items-name-quantity = 物品（名称: 数量）
config-modal-label-currency-name-amount = 货币（名称: 金额）
config-error-experience-non-negative = 经验值必须是非负整数。
config-error-item-quantity-positive-named = 物品"{ $itemName }"的数量必须是正整数。
config-error-currency-amount-positive = 货币"{ $currencyName }"的金额必须是正数。

# SetItemStockModal
config-modal-title-stock-limit = 库存限制：{ $itemName }
config-modal-label-max-stock = 最大库存
config-modal-placeholder-max-stock = 输入最大库存（例如：10）
config-modal-label-current-stock = 当前库存
config-modal-placeholder-current-stock = 输入当前可用库存
config-modal-label-restock-increment = 补货数量（每周期）
config-modal-placeholder-restock-increment = 每周期补货数量（默认：1）
config-error-max-stock-positive = 最大库存必须是正整数。
config-error-current-stock-non-negative = 当前库存必须是非负整数。
config-error-current-exceeds-max = 当前库存不能超过最大库存。
config-error-item-not-in-shop = 商店中未找到物品"{ $itemName }"。

# RestockScheduleModal
config-modal-title-restock-schedule = 配置补货计划
config-modal-restock-schedule-label = 时间表
config-modal-restock-schedule-none = 无（已禁用）
config-modal-restock-schedule-hourly = 每小时
config-modal-restock-schedule-daily = 每天
config-modal-restock-schedule-weekly = 每周
config-modal-label-time = 时间（UTC 格式 HH:MM）
config-modal-desc-current-time = 当前时间：{ $utcTime }
config-modal-placeholder-time = 例如：14:30 表示 UTC 下午 2:30
config-modal-restock-day-label = 星期几（仅每周）
config-modal-restock-mode-label = 补货模式
config-modal-restock-mode-full = 完全（重置为最大值）
config-modal-restock-mode-incremental = 递增（添加数量）
config-error-time-format-invalid = 时间必须为 HH:MM 格式（例如：14:30）。
config-error-increment-positive = 增量必须是正整数。

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = 搜索您的 { $configName } 频道

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = 选择您的 Quest 公告角色

# AddGMRoleSelect
config-select-placeholder-gm-roles = 选择您的 GM 角色

# ConfigWaitListSelect
config-select-placeholder-wait-list = 选择等待列表大小
config-select-option-disabled = 0（已禁用）

# InventoryTypeSelect
config-select-placeholder-inventory-mode = 选择物品栏模式
config-select-option-disabled-label = 已禁用
config-select-desc-disabled = 玩家以空物品栏开始。
config-select-option-selection = 自选
config-select-desc-selection = 玩家从新角色商店自由选择物品。
config-select-option-purchase = 购买
config-select-desc-purchase = 玩家使用给定数量的货币从新角色商店购买物品。
config-select-option-open = 开放
config-select-desc-open = 玩家手动输入自己的物品栏。
config-select-option-static = 固定
config-select-desc-static = 玩家获得预定义的初始物品栏。

# RoleplayChannelSelect
config-select-placeholder-rp-channels = 选择合格频道

# RoleplayModeSelect
config-select-placeholder-rp-mode = 选择模式
config-select-option-scheduled = 定时
config-select-desc-scheduled = 在指定重置周期内发放一次奖励。
config-select-option-accrued = 累积
config-select-desc-accrued = 根据指定的活动水平重复发放奖励。

# RoleplayResetSelect
config-select-placeholder-reset-period = 选择重置周期
config-select-option-hourly = 每小时
config-select-desc-hourly = 每小时重置。
config-select-option-daily = 每天
config-select-desc-daily = 每 24 小时重置。
config-select-option-weekly = 每周
config-select-desc-weekly = 每 7 天重置。

# RoleplayResetDaySelect
config-select-placeholder-reset-day = 选择重置日

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = 选择重置时间（UTC）
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = 选择一个 Forum 频道

# ForumThreadSelect
config-select-placeholder-thread = 选择一个 Thread
config-select-option-no-threads = 没有找到活跃的 Thread
config-select-desc-no-threads = 创建新 Thread 或检查已归档的 Thread
config-select-option-select-forum-first = 请先选择一个 Forum
config-select-desc-select-forum-first = 请先选择上方的 Forum 频道
config-select-desc-thread-id = 话题ID: { $threadId }
config-error-select-valid-thread = 请选择有效的 Thread 或创建新的。
config-error-thread-not-found = 找不到所选的 Thread。它可能已被删除或归档。

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = 服务器配置 - 主菜单
config-menu-config-wizard = 配置向导
config-menu-desc-config-wizard = 通过快速扫描验证您的服务器是否已准备好使用 ReQuest。
config-menu-channels = 频道
config-menu-desc-channels = 设置 ReQuest 帖子的指定频道。
config-menu-currency = 货币
config-menu-desc-currency = 全局货币设置。
config-menu-players = 玩家
config-menu-desc-players = 全局玩家设置，例如经验值追踪。
config-menu-quests = Quest
config-menu-desc-quests = 全局 Quest 设置，例如等待列表。
config-menu-rp-rewards = 角色扮演奖励
config-menu-desc-rp-rewards = 配置角色扮演奖励。
config-menu-roles = 角色
config-menu-desc-roles = 可提及或具有特权的角色的配置选项。
config-menu-shops = 商店
config-menu-desc-shops = 配置自定义商店。
config-menu-language = 语言
config-menu-desc-language = 设置此服务器的默认语言。

## Wizard View
config-title-wizard = {"**"}服务器配置 - 向导{"**"}
config-wizard-intro =
    {"**"}欢迎使用 ReQuest 配置向导！{"**"}

    此向导将帮助您确保服务器已正确配置以使用 ReQuest 的功能。
    它将扫描您当前的设置并提供调整建议。

    使用下方的"启动扫描"按钮开始验证过程。扫描完成后，
    您将收到服务器配置的详细报告以及建议的更改。

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}机器人全局权限{"**"}__
config-wizard-bot-permissions-desc = 此部分验证 ReQuest 是否拥有正常运行所需的正确权限。
config-wizard-bot-role = 机器人角色：{ $roleMention }
config-wizard-status-warnings = {"**"}状态：⚠️ 发现警告{"**"}
config-wizard-missing-perm = - ⚠️ 缺少：`{ $permissionName }`
config-wizard-ensure-permissions = 请确保机器人的最高角色已全局授予这些权限。
config-wizard-status-ok = {"**"}状态：✅ 正常{"**"}
config-wizard-bot-permissions-ok = 机器人拥有所有必需的全局权限。
config-wizard-status-scan-failed = {"**"}状态：❌ 扫描失败{"**"}
config-wizard-scan-error = 检查机器人权限时发生意外错误。
config-wizard-error-type = 错误：{ $errorType }
config-wizard-required-permissions = {"**"}机器人角色所需的权限：{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = 查看频道
config-wizard-perm-manage-roles = 管理角色
config-wizard-perm-send-messages = 发送消息
config-wizard-perm-attach-files = 附加文件
config-wizard-perm-add-reactions = 添加反应
config-wizard-perm-use-external-emoji = 使用外部表情
config-wizard-perm-manage-messages = 管理消息
config-wizard-perm-read-message-history = 阅读消息历史

# Wizard - Role Validation
config-wizard-role-header = __{"**"}角色配置{"**"}__
config-wizard-role-desc =
    此部分验证以下内容：

    - GM 角色（必需）和公告角色（可选）已配置。
    - 默认（@everyone）角色拥有用户访问机器人功能所需的权限。
    - 默认（@everyone）角色没有危险权限。
    - GM 和公告角色是否存在超出默认角色的权限提升。

    此处的任何警告仅为基于默认设置的建议。根据您服务器的需要，您可能有理由忽略其中一些建议。

config-wizard-default-role-label = {"**"}默认角色：{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone：发现危险权限：
config-wizard-default-role-ok = - ✅ @everyone：正常
config-wizard-missing-permission = - 缺少权限：`{ $permissionName }`
config-wizard-gm-roles-label = {"**"}GM 角色：{"**"}
config-wizard-no-gm-roles = - ⚠️ 未配置 GM 角色
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }：{"**"} 已配置的角色未找到/已从服务器删除
config-wizard-role-ok = - ✅ { $roleMention }：正常
config-wizard-announcement-role-label = {"**"}公告角色：{"**"}
config-wizard-no-announcement-role = - ℹ️ 未配置公告角色
config-wizard-announcement-role-not-found = - ⚠️ 已配置的角色未找到/已从服务器删除
config-wizard-escalation-detected = - ⚠️ { $roleMention }：检测到权限提升 - { $escalations }
config-wizard-escalation-more = ，以及其他 { $count } 项...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = 在 Thread 中发送消息
config-wizard-perm-use-application-commands = 使用应用程序命令

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = 管理频道
config-wizard-perm-manage-webhooks = 管理 Webhook
config-wizard-perm-manage-server = 管理服务器
config-wizard-perm-manage-nicknames = 管理昵称
config-wizard-perm-kick-members = 踢出成员
config-wizard-perm-ban-members = 封禁成员
config-wizard-perm-timeout-members = 超时成员
config-wizard-perm-mention-everyone = 提及 @everyone
config-wizard-perm-manage-threads = 管理 Thread
config-wizard-perm-administrator = 管理员

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}频道配置{"**"}__
config-wizard-channel-desc =
    此部分验证以下内容：

    - 已配置的频道存在。
    - 机器人有权查看和发送消息到已配置的频道。
    - 默认（@everyone）角色没有 `发送消息` 权限。

config-wizard-channel-no-config-required = - ⚠️ 未配置频道
config-wizard-channel-not-configured = - ℹ️ 未配置（可选）
config-wizard-channel-not-found = - ⚠️ 已配置的频道未找到/已从服务器删除
config-wizard-channel-ok = - ✅ 正常
config-wizard-bot-cannot-view = - ⚠️ { $botMention } 无法查看此频道。
config-wizard-bot-cannot-send = - ⚠️ { $botMention } 无法在此频道发送消息。
config-wizard-everyone-can-send = - ⚠️ @everyone 可以在此频道发送消息。

# Wizard - Channel names
config-wizard-channel-quest-board = Quest 公告板
config-wizard-channel-player-board = 玩家公告板
config-wizard-channel-quest-archive = Quest 存档
config-wizard-channel-gm-transaction-log = GM 交易日志
config-wizard-channel-player-transaction-log = 玩家交易日志
config-wizard-channel-shop-log = 商店日志
config-wizard-channel-approval-queue = 角色审批队列

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}设置面板{"**"}__
config-wizard-dashboard-desc = 此部分提供非必要配置的快速参考概览。
config-wizard-quest-settings = {"**"}Quest 设置{"**"}
config-wizard-quest-wait-list = - Quest 等待列表大小：{ $size }
config-wizard-quest-summary = - Quest 摘要：{ $status }
config-wizard-gm-rewards-per-quest = {"**"}GM 奖励（每个 Quest）{"**"}
config-wizard-player-settings = {"**"}玩家设置{"**"}
config-wizard-player-experience = - 玩家经验：{ $status }
config-wizard-currency-settings = {"**"}货币设置{"**"}
config-wizard-rp-rewards = {"**"}角色扮演奖励{"**"}
config-wizard-rp-status = - 状态：{ $status }
config-wizard-rp-mode = - 模式：{ $mode }
config-wizard-rp-channels = - 监控频道：{ $count }
config-wizard-shops = {"**"}商店{"**"}
config-wizard-shops-count = - 已配置的商店：{ $count }
config-wizard-shops-more = - ...以及其他 { $count } 个
config-wizard-new-char-setup = {"**"}新角色设置{"**"}
config-wizard-inventory-type = - 物品栏类型：{ $type }
config-wizard-new-char-shop-items = - 新角色商店物品：{ $count }
config-wizard-static-kits = - 固定套装：{ $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ 未配置货币
config-wizard-configured-currencies = {"**"}已配置的货币：{"**"}
config-wizard-no-denominations = - 未配置面额
config-wizard-gm-rewards-disabled = {"**"}状态：{"**"} 已禁用
config-wizard-gm-rewards-enabled = {"**"}状态：{"**"} 已启用
config-wizard-gm-rewards-experience = - 经验值：{ $xp }
config-wizard-gm-rewards-items = - 物品：
config-wizard-unnamed-shop = 未命名商店

## Roles View
config-title-roles = {"**"}服务器配置 - 角色{"**"}
config-label-announcement-role = {"**"}公告角色：{"**"} { $status }
config-desc-announcement-role = 发布 Quest 时会提及此角色。
config-label-announcement-role-default = {"**"}公告角色：{"**"} 未配置
config-label-gm-roles = {"**"}GM 角色：{"**"} { $roles }
config-desc-gm-roles = 这些角色将获得 GM 命令和功能的访问权限。
config-label-gm-roles-default = {"**"}GM 角色：{"**"} 未配置
config-title-forbidden-roles = __{"**"}禁止角色{"**"}__
config-desc-forbidden-roles =
    配置 GM 不能用于队伍角色的角色名称列表。
    默认情况下，`everyone`、`administrator`、`gm` 和 `game master` 不能使用。此配置
    扩展了该列表。

## GM Role Remove View
config-title-remove-gm-roles = {"**"}服务器配置 - 移除 GM 角色{"**"}
config-msg-no-gm-roles = 未配置 GM 角色。

## Channels View
config-title-channels = {"**"}服务器配置 - 频道{"**"}

config-label-quest-board = {"**"}Quest 公告板：{"**"} { $channel }
config-desc-quest-board = 新建/进行中的 Quest 将发布到的频道。
config-label-quest-board-default = {"**"}Quest 公告板：{"**"} 未配置

config-label-player-board = {"**"}玩家公告板：{"**"} { $channel }
config-desc-player-board = 供玩家使用的可选公告/消息板。
config-label-player-board-default = {"**"}玩家公告板：{"**"} 未配置

config-label-quest-archive = {"**"}Quest 存档：{"**"} { $channel }
config-desc-quest-archive = 已完成的 Quest 将移至的可选频道，附带摘要信息。
config-label-quest-archive-default = {"**"}Quest 存档：{"**"} 未配置

config-label-gm-transaction-log = {"**"}GM 交易日志：{"**"} { $channel }
config-desc-gm-transaction-log = 记录 GM 交易（即修改玩家命令）的可选频道。
config-label-gm-transaction-log-default = {"**"}GM 交易日志：{"**"} 未配置

config-label-player-transaction-log = {"**"}玩家交易日志：{"**"} { $channel }
config-desc-player-transaction-log = 记录玩家交易（如交换和消耗物品）的可选频道。
config-label-player-transaction-log-default = {"**"}玩家交易日志：{"**"} 未配置

config-label-shop-log = {"**"}商店日志：{"**"} { $channel }
config-desc-shop-log = 记录商店交易的可选频道。
config-label-shop-log-default = {"**"}商店日志：{"**"} 未配置

## Quests View
config-title-quests = {"**"}服务器配置 - Quest{"**"}

config-label-wait-list = {"**"}Quest 等待列表大小：{"**"} { $size }
config-desc-wait-list = 等待列表允许指定数量的玩家在 Quest 满员时排队，以防有玩家退出。
config-label-wait-list-disabled = {"**"}Quest 等待列表大小：{"**"} 已禁用

config-label-quest-summary = {"**"}Quest 摘要：{"**"} { $status }
config-desc-quest-summary = 此选项允许 GM 在完结 Quest 时提供简短摘要。
config-label-quest-summary-disabled = {"**"}Quest 摘要：{"**"} 已禁用

config-label-gm-rewards = GM 奖励
config-desc-gm-rewards = 配置 GM 完成 Quest 时获得的奖励。

## GM Rewards View
config-title-gm-rewards = {"**"}服务器配置 - GM 奖励{"**"}
config-desc-gm-rewards-detail =
    {"**"}添加/修改奖励{"**"}
    打开输入窗口以添加、修改或移除 GM 奖励。

    > 配置的奖励以每个 Quest 为单位。每次 GM 完成一个 Quest 时，他们将在其活跃角色上
    获得下方配置的奖励。
config-msg-no-rewards = 未配置奖励。
config-label-gm-experience = {"**"}经验值：{"**"} { $xp }
config-label-gm-items = {"**"}物品：{"**"}

## Players View
config-title-players = {"**"}服务器配置 - 玩家{"**"}

config-label-player-experience = {"**"}玩家经验：{"**"} { $status }
config-desc-player-experience = 启用/禁用经验值（或类似的数值型角色成长系统）的使用。
config-label-player-experience-disabled = {"**"}玩家经验：{"**"} 已禁用

config-label-new-char-settings = {"**"}新角色设置{"**"}
config-desc-new-char-settings = 配置与新玩家角色及其初始物品栏设置相关的选项。

config-label-player-board-purge = {"**"}清理玩家公告板{"**"}
config-desc-player-board-purge = 清理玩家公告板上的帖子（如果已启用）。

## New Character Settings View
config-title-new-character = {"**"}服务器配置 - 新角色设置{"**"}

config-label-inventory-type = {"**"}新角色物品栏类型：{"**"} { $type }
config-desc-inventory-type = 决定新注册角色如何初始化其物品栏。
config-label-inventory-type-disabled = {"**"}新角色物品栏类型：{"**"} 已禁用

config-label-new-char-wealth = {"**"}新角色财富：{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}新角色财富：{"**"} 已禁用

config-label-approval-queue = {"**"}审批队列：{"**"} { $channel }
config-desc-approval-queue = 如果设置，新角色必须在此 Forum 频道中由 GM 审批后才能激活。
config-label-approval-queue-disabled = {"**"}审批队列：{"**"} 已禁用
config-label-approval-queue-not-configured = {"**"}审批队列：{"**"} 未配置

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = 玩家以空物品栏开始。
config-desc-inv-type-selection = 玩家从新角色商店自由选择物品。
config-desc-inv-type-purchase = 玩家使用给定数量的货币从新角色商店购买物品。
config-desc-inv-type-open = 玩家手动输入物品栏物品。
config-desc-inv-type-static = 玩家获得预定义的初始物品栏。

## New Character Shop View
config-title-new-char-shop = {"**"}服务器配置 - 新角色商店{"**"}
config-label-inv-type-selection = {"**"}物品栏类型：{"**"} 自选
config-desc-inv-type-selection-shop = 玩家从新角色商店自由选择物品。
config-label-inv-type-purchase = {"**"}物品栏类型：{"**"} 购买
config-desc-inv-type-purchase-shop = 玩家使用给定数量的货币从新角色商店购买物品。
config-label-inv-type-other = {"**"}物品栏类型：{"**"} { $type }
config-desc-inv-type-not-in-use = 新角色商店未在使用中。
config-msg-define-shop-items = 定义商店物品。
config-msg-no-items = 未配置物品。

## Static Kits View
config-title-static-kits = {"**"}服务器配置 - 固定套装{"**"}
config-desc-create-kit = 创建新的套装定义。
config-msg-no-kits = 未配置套装。
config-label-kit-more-items = ...以及其他 { $count } 个物品
config-label-empty-kit = {"*"}空套装{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}编辑套装：{ $kitName }{"**"}
config-msg-kit-empty = 此套装为空。使用上方按钮添加货币或物品。
config-label-kit-currency = {"**"}货币：{"**"} { $display }
config-label-kit-item = {"**"}物品：{"**"} { $name }

## Currency View
config-title-currency = {"**"}服务器配置 - 货币{"**"}
config-desc-create-currency = 创建新货币。
config-msg-no-currencies = 未配置货币。
config-label-currency-display-type = 显示类型：{ $type } | 面额数：{ $count }
config-label-currency-type-double = 小数
config-label-currency-type-integer = 整数

## Edit Currency View
config-title-manage-currency = {"**"}管理货币：{ $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}货币与面额{"**"}__
    - 您为货币命名的名称被视为基础货币，其数值为 1。
    {"```"}示例：将"gold"配置为一种货币。{"```"}
    - 添加面额需要指定名称和相对于基础货币的数值。
    {"```"}示例：给 Gold 添加两个面额：silver（数值 0.1）和 copper（数值 0.01）。{"```"}
    - 涉及基础货币或其面额的任何交易都会自动进行换算。
    {"```"}示例：一位玩家有 10 gold，花费了 3 copper。他的新余额将自动显示为
    9 gold、9 silver 和 7 copper。{"```"}
    - 显示为整数的货币将显示每个面额，而显示为小数的货币将仅显示基础货币。
    {"```"}示例：上述玩家启用小数显示后将显示为 9.97 gold。{"```"}
config-btn-toggle-display-current = 切换显示方式（当前：{ $type }）
config-msg-no-denominations = 未配置面额。

## Shops View
config-title-shops = {"**"}服务器配置 - 商店{"**"}
config-desc-add-shop-wizard =
    {"**"}添加商店（向导）{"**"}
    通过表单创建新的空商店。
config-desc-add-shop-json =
    {"**"}添加商店（JSON）{"**"}
    通过提供完整的 JSON 定义创建新商店。（高级）
config-btn-example-json = 示例 JSON
config-desc-example-json =
    {"**"}示例 JSON{"**"}
    下载一个示例 JSON 文件，展示预期格式。
config-msg-example-json = 这是一个示例 JSON 文件，展示预期格式。
config-msg-no-shops = 未配置商店。
config-label-shop-type-forum = （Forum）
config-label-shop-channel = 频道：<#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}添加商店 - 选择位置类型{"**"}
config-label-text-channel = {"**"}文字频道{"**"}
config-desc-text-channel = 在标准文字频道中创建商店。
config-label-forum-thread = {"**"}论坛帖子{"**"}
config-desc-forum-thread = 在 Forum Thread 中创建商店（新建或已有）。

## Forum Shop Setup View
config-title-forum-setup = {"**"}添加商店 - Forum Thread 设置{"**"}
config-label-step1 = {"**"}步骤 1：选择 Forum 频道{"**"}
config-label-step2 = {"**"}步骤 2：选择 Thread 选项{"**"}
config-label-step3 = {"**"}步骤 3：选择已有 Thread{"**"}
config-desc-create-new-thread =
    {"**"}创建新 Thread{"**"}
    打开表单以创建新 Thread 并配置商店。
config-label-selected-thread = {"**"}已选 Thread：{"**"} { $threadName }
config-desc-click-to-configure = 点击以在此 Thread 中配置商店。

## Manage Shop View
config-title-manage-shop = {"**"}管理商店：{ $shopName }{"**"}
config-label-shop-type = {"**"}类型：{"**"} { $type }
config-label-shop-type-text = 文字频道
config-label-shop-type-forum-thread = 论坛帖子
config-label-shopkeeper = {"**"}店主：{"**"} { $name }
config-label-shop-description = {"**"}描述：{"**"} { $description }
config-label-shop-channel-info = {"**"}频道：{"**"} <#{ $channelId }>
config-desc-edit-wizard = 通过向导编辑商店详情和物品。
config-desc-upload-json = 上传此商店的新 JSON 定义。
config-desc-download-json = 下载当前的 JSON 定义。
config-desc-remove-shop = 永久移除此商店。

## Edit Shop View
config-title-editing-shop = {"**"}编辑商店：{ $shopName }{"**"}
config-label-shop-shopkeeper = 店主：{"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}库存配置：{ $shopName }{"**"}
config-label-current-utc = 当前 UTC 时间：{"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}补货计划：{"**"} { $schedule }
config-label-restock-hourly = 在第 :{ $minute } 分
config-label-restock-daily = 在 { $time } UTC
config-label-restock-weekly = 在每{ $day } { $time } UTC
config-label-restock-mode = {"**"}模式：{"**"} { $mode }
config-label-restock-full = 完全补货
config-label-restock-incremental = 递增（每物品数量）
config-label-restock-disabled = {"**"}补货计划：{"**"} 已禁用
config-label-item-stock-limits = {"**"}物品库存限制{"**"}
config-msg-no-items-in-shop = 此商店无物品。
config-label-stock-with-available = 最大：{ $max } | 可用：{ $available }
config-label-stock-increment = 补货：+{ $increment }/周期
config-label-stock-reserved = 预留：{ $reserved }
config-label-stock-not-initialized = 最大：{ $max } | 可用：（未初始化）
config-label-stock-unlimited = 库存：无限

## Roleplay View
config-title-roleplay = {"**"}服务器配置 - 角色扮演奖励{"**"}
config-label-rp-status = {"**"}状态：{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}服务器时间：{"**"} `{ $time }`
config-label-rp-enabled = 已启用
config-label-rp-disabled = 已禁用

config-desc-rp-mode-scheduled = {"```"}在设定的时间周期内（每小时、每天或每周）发送达到要求的合格消息数量后，奖励发放一次。{"```"}
config-desc-rp-mode-accrued = {"```"}每次发送设定数量的合格消息后，重复发放奖励。{"```"}

config-label-rp-config-details = {"**"}配置详情：{"**"}
config-label-rp-mode = {"**"}模式：{"**"} { $mode }
config-label-rp-min-length = {"**"}最短消息长度：{"**"} { $length } 个字符
config-label-rp-cooldown = {"**"}冷却时间：{"**"} { $seconds } 秒
config-label-rp-frequency-once = {"**"}频率：{"**"} 每{ $period }一次
config-label-rp-reset-time = {"**"}重置时间：{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}阈值：{"**"} { $count } 条合格消息
config-label-rp-frequency-every = {"**"}频率：{"**"} 每 { $count } 条合格消息

config-label-rp-channels = {"**"}角色扮演频道：{"**"}
config-msg-rp-no-channels = 未配置。
config-label-rp-channels-more = ...以及其他 { $count } 个。

config-label-rp-rewards = {"**"}奖励：{"**"}
config-msg-rp-no-rewards = 未配置。
config-label-rp-experience = {"**"}经验值：{"**"} { $xp }
config-label-rp-items = {"**"}物品：{"**"}
config-label-rp-currency = {"**"}货币：{"**"}

## Language View
config-title-language = {"**"}服务器配置 - 语言{"**"}
config-server-language-help =
    此设置允许您指定 ReQuest 在此服务器中{"**"}公开{"**"}回复和消息的默认语言。公开回复包括：
    - Quest 和玩家公告板帖子
    - Quest 摘要和日志频道消息
    - 商店补货
    - 玩家物品消耗

    此设置仅影响机器人生成的静态文本，不翻译动态内容（如用户输入的物品名称或 Quest 描述）。

    个人回复和菜单不受此设置影响。
config-label-server-language = {"**"}服务器语言：{"**"} { $language }
config-label-server-language-default = {"**"}服务器语言：{"**"} 默认（不覆盖）
config-select-placeholder-server-language = 选择服务器语言
config-select-option-default = 默认（不覆盖）
config-select-desc-default = 使用每位用户的偏好设置或 Discord 语言。

# Quest Roles
config-btn-quest-roles = Quest 角色
config-btn-manage-gm-quest-roles = 管理

config-modal-title-confirm-quest-role-removal = 确认移除角色
config-modal-label-remove-quest-role = 从 { $gmName } 移除 { $roleName }？

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = 选择 Quest 角色模式
config-select-option-quest-role-disabled = 已禁用
config-select-desc-quest-role-disabled = 不创建或分配任何角色。
config-select-option-quest-role-temporary = 临时
config-select-desc-quest-role-temporary = GM 可以为每个 Quest 创建临时角色。
config-select-option-quest-role-static = 固定
config-select-desc-quest-role-static = GM 从预分配的服务器角色中选择。

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = 为此 GM 分配服务器角色

## Quest Roles View
config-title-quest-roles = {"**"}服务器配置 - Quest 角色{"**"}
config-label-quest-roles = Quest 角色
config-desc-quest-roles =
    配置 Quest 期间如何处理队伍角色。

config-label-quest-role-mode-disabled = {"**"}Quest 角色模式：{"**"} 已禁用
    Quest 期间不创建或分配任何角色。
config-label-quest-role-mode-temporary = {"**"}Quest 角色模式：{"**"} 临时
    GM 可以在创建 Quest 时选择创建临时角色。
    该角色在 Quest 完成或取消时删除。
config-label-quest-role-mode-static = {"**"}Quest 角色模式：{"**"} 固定
    GM 从预分配的服务器角色中选择。角色在 Quest
    期间分配给队伍成员，但永远不会被删除。

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}服务器配置 - 固定 Quest 角色分配{"**"}
config-label-manage-assignments = 管理角色分配
config-desc-manage-assignments =
    将现有的服务器角色分配给 GM，以便在 Quest 期间使用。
    角色必须低于 ReQuest 在服务器层级中的最高角色。
config-msg-no-gm-members = 在此服务器上未找到拥有 GM 角色的成员。
config-label-no-roles-assigned = 未分配 Quest 角色
config-label-more-roles = (+{ $count } 更多)

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}管理 Quest 角色 — { $gmName }{"**"}
config-error-unmanageable-roles = 以下角色无法分配，因为它们由集成管理、是默认角色或高于 ReQuest 的最高角色：{ $roles }
config-error-quest-role-limit = 此 GM 已达到最多 { $limit } 个已分配 Quest 角色的上限。
config-label-quest-role-count = 已分配角色：{ $count }/{ $limit }
