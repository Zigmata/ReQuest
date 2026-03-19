## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = 清除
config-btn-remove-gm-roles = 移除 GM 身分組
config-btn-forbidden-roles = 禁用身分組

# Quests
config-btn-toggle-quest-summary = 切換 Quest 摘要
config-btn-toggle-player-experience = 切換玩家經驗值
config-btn-toggle-display = 切換顯示方式
config-btn-purge-player-board = 清理玩家公告板
config-btn-add-modify-rewards = 新增/修改獎勵

# Currency
config-btn-add-denomination = 新增面額
config-btn-add-new-currency = 新增貨幣
config-btn-remove-currency = 移除貨幣

# Shops - creation
config-btn-add-shop-wizard = 新增商店（精靈）
config-btn-add-shop-json = 新增商店（JSON）
config-btn-edit-shop-wizard = 編輯商店（精靈）
config-btn-edit-shop-json = 編輯商店（JSON）
config-btn-remove-shop = 移除商店
config-btn-add-item = 新增物品
config-btn-edit-shop-details = 編輯商店詳情
config-btn-download-json = 下載 JSON
config-btn-done-editing = 完成編輯
config-btn-scan-server-configs = 掃描伺服器設定
config-btn-re-scan = 重新掃描

# New character shop
config-btn-upload-json = 上傳 JSON
config-btn-configure-new-character-wealth = 設定新角色財富
config-btn-configure-new-character-shop = 設定新角色商店
config-btn-configure-static-kits = 設定固定套組
config-btn-new-character-settings = 新角色設定
config-btn-disabled-no-currency = 已停用（未設定貨幣）
config-btn-disabled-no-wealth = 已停用（未設定起始財富）

# Static kits
config-btn-create-new-kit = 建立新套組
config-btn-delete-kit = 刪除套組
config-btn-add-currency = 新增貨幣

# Roleplay
config-btn-toggle-rp-rewards = 切換角色扮演獎勵
config-btn-clear-channels = 清除頻道
config-btn-edit-settings = 編輯設定
config-btn-configure-rewards = 設定獎勵

# Stock
config-btn-stock-limits = 庫存限制
config-btn-set-limit = 設定限制
config-btn-edit-limit = 編輯限制
config-btn-remove-limit = 移除限制
config-btn-configure-restock-schedule = 設定補貨排程
config-btn-back-to-shop-editor = 返回商店編輯器

# Forum shop
config-btn-create-new-thread = 建立新討論串
config-btn-use-existing-thread = 使用現有討論串

# Wizard
config-btn-quit = 離開
config-btn-configure-channels = 設定頻道
config-btn-configure-roles = 設定身分組
config-btn-configure-quests = 設定 Quest
config-btn-configure-players = 設定玩家
config-btn-configure-currency = 設定貨幣
config-btn-configure-rp-rewards = 設定角色扮演獎勵
config-btn-configure-shops = 設定商店
config-btn-new-char-setup = 新角色設定

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = 確認移除身分組
config-modal-title-confirm-removal = 確認移除
config-modal-title-confirm-currency-removal = 確認移除貨幣
config-modal-title-confirm-shop-removal = 確認移除商店
config-modal-title-confirm-kit-deletion = 確認刪除套組
config-modal-title-confirm-remove-stock-limit = 確認移除庫存限制

# Confirm modal prompt labels
config-modal-label-remove-role = 移除 { $roleName }？
config-modal-label-remove-denomination = 移除 { $denominationName }？
config-modal-label-remove-currency = 移除 { $currencyName }？
config-modal-label-shop-removal-warning = 警告：此操作無法復原！
config-modal-label-kit-deletion-warning = 警告：無法復原！
config-modal-label-remove-stock-limit = 輸入 CONFIRM 以移除庫存限制
config-modal-placeholder-type-confirm = 輸入 CONFIRM

# Error messages from buttons
config-error-shop-data-not-found = 錯誤：找不到該商店的資料。
config-msg-shop-json-download = 以下是 {"**"}{ $shopName }{"**"} 的 JSON 定義。
config-msg-new-char-shop-json-download = 以下是新角色商店的 JSON 定義。
config-error-select-forum-first = 請先選擇一個 Forum 頻道。
config-error-select-thread-first = 請先選擇一個討論串。

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = 新增貨幣
config-modal-label-currency-name = 貨幣名稱
config-error-currency-already-exists = 名為 { $name } 的貨幣或面額已存在！

# RenameCurrencyModal
config-modal-title-rename-currency = 重新命名貨幣
config-modal-label-new-currency-name = 新貨幣名稱
config-error-currency-name-exists = 名為「{ $name }」的貨幣已存在。
config-error-denomination-name-exists = 名為「{ $name }」的面額已存在。

# RenameDenominationModal
config-modal-title-rename-denomination = 重新命名面額
config-modal-label-new-denomination-name = 新面額名稱

# AddCurrencyDenominationModal
config-modal-title-add-denomination = 新增 { $currencyName } 面額
config-modal-label-denomination-name = 名稱
config-modal-placeholder-denomination-name = 例如：銀幣
config-modal-label-denomination-value = 數值
config-modal-placeholder-denomination-value = 例如：0.1
config-error-denomination-matches-currency = 新面額名稱不能與此伺服器上的現有貨幣相同！發現現有貨幣名稱「{ $existingName }」。
config-error-denomination-matches-denomination = 新面額名稱不能與此伺服器上的現有面額相同！在貨幣「{ $currencyName }」下發現現有面額名稱「{ $denominationName }」。
config-error-denomination-value-exists = 同一貨幣下的面額必須有唯一的數值！{ $denominationName } 已被指派此數值。

# ForbiddenRolesModal
config-modal-title-forbidden-roles = 禁用身分組名稱
config-modal-label-names = 名稱
config-modal-placeholder-names = 輸入名稱，以逗號分隔
config-msg-forbidden-roles-updated = 禁用身分組已更新！

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = 清理玩家公告板
config-modal-label-age = 天數
config-modal-placeholder-age = 輸入要保留的最大發文天數
config-msg-posts-purged = 超過 { $days } 天的發文已被清除！

# GMRewardsModal
config-modal-title-gm-rewards = 新增/修改 GM 獎勵
config-modal-label-experience = 經驗值
config-modal-placeholder-enter-number = 輸入數字
config-modal-label-items = 物品
config-modal-placeholder-items =
    名稱：數量
    名稱2：數量
    以此類推。
config-error-experience-invalid = 經驗值必須為有效的整數（例如 2000）。
config-error-item-format-invalid = 無效的物品格式：「{ $item }」。每個物品必須獨立一行，格式為「名稱：數量」。

# ConfigShopDetailsModal
config-modal-title-shop-details = 新增/編輯商店詳情
config-modal-label-shop-channel = 選擇頻道
config-modal-placeholder-shop-channel = 選擇此商店的頻道
config-modal-label-shop-name = 商店名稱
config-modal-placeholder-shop-name = 輸入商店名稱
config-modal-label-shopkeeper-name = 店主名稱
config-modal-placeholder-shopkeeper-name = 輸入店主名稱
config-modal-label-shop-description = 商店描述
config-modal-placeholder-shop-description = 輸入商店描述
config-modal-label-shop-image-url = 商店圖片 URL
config-modal-placeholder-shop-image-url = 輸入商店圖片的 URL
config-error-no-channel-selected = 尚未為商店選擇頻道。
config-error-shop-already-in-channel = 所選頻道已註冊了一間商店。請選擇其他頻道或編輯現有商店。

# build_shop_header_view
config-label-shopkeeper = {"**"}店主：{"**"} { $name }
config-msg-use-shop-command = 使用 `/shop` 指令瀏覽及購買物品。

# ForumThreadShopModal
config-modal-title-forum-thread-shop = 建立 Forum 討論串商店
config-modal-label-thread-name = 討論串名稱
config-modal-placeholder-thread-name = 輸入商店討論串的名稱
config-error-forum-not-found = 找不到所選的 Forum 頻道。
config-error-shop-already-in-thread = 此討論串已註冊了一間商店。新討論串不應發生此情況。

# ConfigShopJSONModal
config-modal-title-add-shop-json = 透過 JSON 新增商店
config-modal-label-upload-json = 上傳包含商店資料的 .json 檔案
config-error-no-json-uploaded = 未上傳商店的 JSON 檔案。
config-error-file-must-be-json = 上傳的檔案必須是 JSON 檔案（.json）。
config-error-invalid-json = 無效的 JSON 格式：{ $error }
config-error-json-validation-failed = JSON 不符合結構定義：{ $error }

# ShopItemModal
config-modal-title-shop-item = 新增/編輯商店物品
config-modal-label-item-name = 物品名稱
config-modal-placeholder-item-name = 輸入物品名稱
config-modal-label-item-description = 物品描述
config-modal-placeholder-item-description = 輸入物品描述
config-modal-label-item-quantity = 物品數量
config-modal-placeholder-item-quantity = 輸入每次購買的售出數量
config-modal-label-item-costs = 物品費用
config-modal-placeholder-item-costs = 例如：10 gold + 5 silver\n或：50 rep\n（使用 + 表示「和」，換行表示「或」）
config-error-item-quantity-positive = 物品數量必須為正整數。
config-error-cost-format-invalid = 選項中的費用格式無效：「{ $option }」。每項費用必須包含金額和貨幣，以空格分隔，例如「10 gold」。
config-error-cost-amount-invalid = 貨幣「{ $currency }」的金額「{ $amount }」無效。金額必須為正數。
config-error-unknown-currency = 未知貨幣 `{ $currency }`。請使用此伺服器上已設定的有效貨幣。
config-error-item-already-exists = 此商店中已存在名為 { $itemName } 的物品。

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = 透過 JSON 更新商店
config-modal-label-upload-new-json = 上傳新的 JSON 定義
config-error-no-file-uploaded = 未上傳檔案。
config-error-file-must-be-json-ext = 檔案必須是 `.json` 檔案。
config-error-json-validation-message = JSON 驗證失敗：{ $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = 新增/編輯新角色裝備
config-modal-placeholder-item-quantity-selection = 輸入每次選擇時獲得的數量
config-modal-label-item-cost = 物品費用
config-error-cost-format-short = 無效的費用格式：「{ $component }」。預期格式為「金額 貨幣」。
config-error-amount-invalid-short = 貨幣「{ $currency }」的金額「{ $amount }」無效。
config-error-item-exists-new-char = 新角色商店中已存在名為 { $itemName } 的物品。

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = 上傳新角色商店（JSON）
config-error-no-json-uploaded-short = 未上傳 JSON 檔案。
config-error-json-must-have-shopstock = JSON 必須包含 'shopStock' 陣列。
config-error-items-must-have-name-price = 所有物品必須包含 'name' 和 'price'。

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = 設定新角色財富
config-modal-label-amount = 金額
config-modal-placeholder-amount = 輸入此貨幣的金額。
config-modal-placeholder-currency-name = 輸入此伺服器上已定義的貨幣名稱
config-error-no-currencies-configured = 此伺服器尚未設定任何貨幣。
config-error-currency-not-found = 找不到名為 { $name } 的貨幣或面額。請使用有效的貨幣。

# CreateStaticKitModal
config-modal-title-create-kit = 建立新固定套組
config-modal-label-kit-name = 套組名稱
config-modal-placeholder-kit-name = 例如：戰士入門套組
config-modal-label-description = 描述
config-modal-placeholder-kit-description = 此套組的選填描述
config-error-kit-name-exists = 名為「{ $kitName }」的固定套組已存在。請選擇其他名稱。

# StaticKitItemModal
config-modal-title-kit-item = 新增/編輯套組物品
config-modal-placeholder-kit-item-quantity = 輸入此物品在套組中的數量

# StaticKitCurrencyModal
config-modal-title-kit-currency = 新增套組貨幣
config-modal-placeholder-currency-eg = 例如：Gold
config-modal-placeholder-amount-eg = 例如：100
config-error-amount-must-be-number = 金額必須為數字。
config-error-no-currencies-on-server = 伺服器上未設定任何貨幣。
config-error-currency-not-found-short = 找不到貨幣「{ $currency }」。
config-error-denomination-not-found = 在貨幣設定中找不到面額「{ $denomination }」。

# RoleplaySettingsModal
config-modal-title-rp-settings = 角色扮演設定
config-modal-label-min-message-length = 最低訊息長度（字元數）
config-modal-placeholder-min-message-length = 訊息符合條件所需的字元數。0 表示不限制
config-modal-label-cooldown = 冷卻時間（秒）
config-modal-placeholder-cooldown = 計算符合獎勵條件的訊息之間的等待秒數
config-modal-label-message-threshold = 訊息門檻
config-modal-placeholder-message-threshold = 觸發獎勵所需的訊息數量
config-modal-label-frequency = 頻率（訊息數）
config-modal-placeholder-frequency = 獲得獎勵所需的符合條件訊息數量
config-error-min-length-invalid = 最低訊息長度必須為非負整數。
config-error-cooldown-invalid = 冷卻時間必須為非負整數。
config-error-threshold-invalid = 訊息門檻必須為正整數。
config-error-frequency-invalid = 頻率必須為正整數。

# RoleplayRewardsModal
config-modal-title-rp-rewards = 設定角色扮演獎勵
config-modal-label-items-name-quantity = 物品（名稱：數量）
config-modal-label-currency-name-amount = 貨幣（名稱：金額）
config-error-experience-non-negative = 經驗值必須為非負整數。
config-error-item-quantity-positive-named = 「{ $itemName }」的物品數量必須為正整數。
config-error-currency-amount-positive = 「{ $currencyName }」的貨幣金額必須為正數。

# SetItemStockModal
config-modal-title-stock-limit = 庫存限制：{ $itemName }
config-modal-label-max-stock = 最大庫存量
config-modal-placeholder-max-stock = 輸入最大庫存量（例如 10）
config-modal-label-current-stock = 目前庫存
config-modal-placeholder-current-stock = 輸入目前可用庫存
config-error-max-stock-positive = 最大庫存量必須為正整數。
config-error-current-stock-non-negative = 目前庫存必須為非負整數。
config-error-current-exceeds-max = 目前庫存不可超過最大庫存量。
config-error-item-not-in-shop = 商店中找不到物品「{ $itemName }」。

# RestockScheduleModal
config-modal-title-restock-schedule = 設定補貨排程
config-modal-label-schedule = 排程（hourly/daily/weekly/none）
config-modal-placeholder-schedule = 輸入：hourly、daily、weekly 或 none
config-modal-label-time = 時間（UTC 的 HH:MM）
config-modal-desc-current-time = 目前時間：{ $utcTime }
config-modal-placeholder-time = 例如：14:30 代表 UTC 下午 2:30
config-modal-label-day-of-week = 星期幾（0=週一，6=週日）- 僅限 weekly
config-modal-placeholder-day-of-week = 輸入 0-6（週一=0，週日=6）
config-modal-label-mode = 模式（full/incremental）
config-modal-placeholder-mode = full = 重設為最大值，incremental = 增加數量
config-modal-label-increment = 增量（用於 incremental 模式）
config-modal-placeholder-increment = 每次補貨週期增加的數量
config-error-schedule-invalid = 排程必須為以下之一：hourly、daily、weekly 或 none。
config-error-time-format-invalid = 時間格式必須為 HH:MM（例如 14:30）。
config-error-day-of-week-invalid = 星期幾必須為 0-6（週一=0，週日=6）。
config-error-mode-invalid = 模式必須為「full」或「incremental」。
config-error-increment-positive = 增量必須為正整數。

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = 搜尋您的{ $configName }頻道

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = 選擇您的 Quest 公告身分組

# AddGMRoleSelect
config-select-placeholder-gm-roles = 選擇您的 GM 身分組

# ConfigWaitListSelect
config-select-placeholder-wait-list = 選擇候補名單大小
config-select-option-disabled = 0（已停用）

# InventoryTypeSelect
config-select-placeholder-inventory-mode = 選擇背包模式
config-select-option-disabled-label = 已停用
config-select-desc-disabled = 玩家以空背包開始。
config-select-option-selection = 自選
config-select-desc-selection = 玩家可從新角色商店自由選擇物品。
config-select-option-purchase = 購買
config-select-desc-purchase = 玩家使用指定的貨幣從新角色商店購買物品。
config-select-option-open = 開放
config-select-desc-open = 玩家手動輸入自己的背包物品。
config-select-option-static = 固定
config-select-desc-static = 玩家獲得預設的起始背包。

# RoleplayChannelSelect
config-select-placeholder-rp-channels = 選擇符合條件的頻道

# RoleplayModeSelect
config-select-placeholder-rp-mode = 選擇模式
config-select-option-scheduled = 排程
config-select-desc-scheduled = 在指定的重設週期內，獎勵僅發放一次。
config-select-option-accrued = 累計
config-select-desc-accrued = 獎勵根據指定的活躍程度重複發放。

# RoleplayResetSelect
config-select-placeholder-reset-period = 選擇重設週期
config-select-option-hourly = 每小時
config-select-desc-hourly = 每小時重設。
config-select-option-daily = 每天
config-select-desc-daily = 每 24 小時重設。
config-select-option-weekly = 每週
config-select-desc-weekly = 每 7 天重設。

# RoleplayResetDaySelect
config-select-placeholder-reset-day = 選擇重設日

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = 選擇重設時間（UTC）
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = 選擇 Forum 頻道

# ForumThreadSelect
config-select-placeholder-thread = 選擇討論串
config-select-option-no-threads = 找不到使用中的討論串
config-select-desc-no-threads = 建立新討論串或查看已封存的討論串
config-select-option-select-forum-first = 請先選擇 Forum
config-select-desc-select-forum-first = 請先在上方選擇 Forum 頻道
config-select-desc-thread-id = Thread ID：{ $threadId }
config-error-select-valid-thread = 請選擇有效的討論串或建立新的。
config-error-thread-not-found = 找不到所選的討論串。可能已被刪除或封存。

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = 伺服器設定 - 主選單
config-menu-config-wizard = 設定精靈
config-menu-desc-config-wizard = 透過快速掃描驗證您的伺服器是否已準備好使用 ReQuest。
config-menu-channels = 頻道
config-menu-desc-channels = 設定 ReQuest 發文的指定頻道。
config-menu-currency = 貨幣
config-menu-desc-currency = 全域貨幣設定。
config-menu-players = 玩家
config-menu-desc-players = 全域玩家設定，例如經驗值追蹤。
config-menu-quests = Quest
config-menu-desc-quests = 全域 Quest 設定，例如候補名單。
config-menu-rp-rewards = 角色扮演獎勵
config-menu-desc-rp-rewards = 設定角色扮演獎勵。
config-menu-roles = 身分組
config-menu-desc-roles = 可提及或特權身分組的設定選項。
config-menu-shops = 商店
config-menu-desc-shops = 設定自訂商店。
config-menu-language = 語言
config-menu-desc-language = 設定此伺服器的預設語言。

## Wizard View
config-title-wizard = {"**"}伺服器設定 - 精靈{"**"}
config-wizard-intro =
    {"**"}歡迎使用 ReQuest 設定精靈！{"**"}

    此精靈將協助您確認伺服器是否已正確設定以使用 ReQuest 的功能。
    它將掃描您目前的設定並提供任何需要調整的建議。

    使用下方的「啟動掃描」按鈕開始驗證流程。掃描完成後，
    您將收到伺服器設定的詳細報告以及建議的變更。

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}機器人全域權限{"**"}__
config-wizard-bot-permissions-desc = 此部分驗證 ReQuest 是否擁有正確運作所需的權限。
config-wizard-bot-role = 機器人身分組：{ $roleMention }
config-wizard-status-warnings = {"**"}狀態：⚠️ 發現警告{"**"}
config-wizard-missing-perm = - ⚠️ 缺少：`{ $permissionName }`
config-wizard-ensure-permissions = 請確保機器人的最高身分組已在全域授予這些權限。
config-wizard-status-ok = {"**"}狀態：✅ 正常{"**"}
config-wizard-bot-permissions-ok = 機器人擁有所有必要的全域權限。
config-wizard-status-scan-failed = {"**"}狀態：❌ 掃描失敗{"**"}
config-wizard-scan-error = 檢查機器人權限時發生意外錯誤。
config-wizard-error-type = 錯誤：{ $errorType }
config-wizard-required-permissions = {"**"}機器人身分組所需權限：{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = 檢視頻道
config-wizard-perm-manage-roles = 管理身分組
config-wizard-perm-send-messages = 傳送訊息
config-wizard-perm-attach-files = 附加檔案
config-wizard-perm-add-reactions = 新增反應
config-wizard-perm-use-external-emoji = 使用外部表情符號
config-wizard-perm-manage-messages = 管理訊息
config-wizard-perm-read-message-history = 讀取訊息歷史

# Wizard - Role Validation
config-wizard-role-header = __{"**"}身分組設定{"**"}__
config-wizard-role-desc =
    此部分驗證以下內容：

    - GM 身分組（必要）和公告身分組（選用）已設定。
    - 預設（@everyone）身分組擁有使用者存取機器人功能所需的權限。
    - 預設（@everyone）身分組沒有危險權限。
    - 檢查 GM 和公告身分組是否有超出預設身分組的權限提升。

    此處的任何警告僅為基於預設設定的建議。根據您伺服器的需求，您可能有理由忽略某些建議。

config-wizard-default-role-label = {"**"}預設身分組：{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone：發現危險權限：
config-wizard-default-role-ok = - ✅ @everyone：正常
config-wizard-missing-permission = - 缺少權限：`{ $permissionName }`
config-wizard-gm-roles-label = {"**"}GM 身分組：{"**"}
config-wizard-no-gm-roles = - ⚠️ 未設定 GM 身分組
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }：{"**"} 已設定的身分組在伺服器中找不到/已刪除
config-wizard-role-ok = - ✅ { $roleMention }：正常
config-wizard-announcement-role-label = {"**"}公告身分組：{"**"}
config-wizard-no-announcement-role = - ℹ️ 未設定公告身分組
config-wizard-announcement-role-not-found = - ⚠️ 已設定的身分組在伺服器中找不到/已刪除
config-wizard-escalation-detected = - ⚠️ { $roleMention }：偵測到權限提升 - { $escalations }
config-wizard-escalation-more = ，以及其他 { $count } 項...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = 在討論串中傳送訊息
config-wizard-perm-use-application-commands = 使用應用程式指令

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = 管理頻道
config-wizard-perm-manage-webhooks = 管理 Webhook
config-wizard-perm-manage-server = 管理伺服器
config-wizard-perm-manage-nicknames = 管理暱稱
config-wizard-perm-kick-members = 踢出成員
config-wizard-perm-ban-members = 封鎖成員
config-wizard-perm-timeout-members = 禁言成員
config-wizard-perm-mention-everyone = 提及 @everyone
config-wizard-perm-manage-threads = 管理討論串
config-wizard-perm-administrator = 管理員

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}頻道設定{"**"}__
config-wizard-channel-desc =
    此部分驗證以下內容：

    - 已設定的頻道存在。
    - 機器人有權檢視已設定的頻道並在其中傳送訊息。
    - 預設（@everyone）身分組沒有「傳送訊息」權限。

config-wizard-channel-no-config-required = - ⚠️ 未設定頻道
config-wizard-channel-not-configured = - ℹ️ 未設定（選用）
config-wizard-channel-not-found = - ⚠️ 已設定的頻道在伺服器中找不到/已刪除
config-wizard-channel-ok = - ✅ 正常
config-wizard-bot-cannot-view = - ⚠️ { $botMention } 無法檢視此頻道。
config-wizard-bot-cannot-send = - ⚠️ { $botMention } 無法在此頻道傳送訊息。
config-wizard-everyone-can-send = - ⚠️ @everyone 可以在此頻道傳送訊息。

# Wizard - Channel names
config-wizard-channel-quest-board = Quest 公告板
config-wizard-channel-player-board = 玩家公告板
config-wizard-channel-quest-archive = Quest 封存
config-wizard-channel-gm-transaction-log = GM 交易紀錄
config-wizard-channel-player-transaction-log = 玩家交易紀錄
config-wizard-channel-shop-log = 商店紀錄
config-wizard-channel-approval-queue = 角色審核佇列

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}設定儀表板{"**"}__
config-wizard-dashboard-desc = 此部分提供非必要設定的快速參考概覽。
config-wizard-quest-settings = {"**"}Quest 設定{"**"}
config-wizard-quest-wait-list = - Quest 候補名單大小：{ $size }
config-wizard-quest-summary = - Quest 摘要：{ $status }
config-wizard-gm-rewards-per-quest = {"**"}GM 獎勵（每次 Quest）{"**"}
config-wizard-player-settings = {"**"}玩家設定{"**"}
config-wizard-player-experience = - 玩家經驗值：{ $status }
config-wizard-currency-settings = {"**"}貨幣設定{"**"}
config-wizard-rp-rewards = {"**"}角色扮演獎勵{"**"}
config-wizard-rp-status = - 狀態：{ $status }
config-wizard-rp-mode = - 模式：{ $mode }
config-wizard-rp-channels = - 監控頻道：{ $count }
config-wizard-shops = {"**"}商店{"**"}
config-wizard-shops-count = - 已設定商店：{ $count }
config-wizard-shops-more = - ⋯以及其他 { $count } 間
config-wizard-new-char-setup = {"**"}新角色設定{"**"}
config-wizard-inventory-type = - 背包類型：{ $type }
config-wizard-new-char-shop-items = - 新角色商店物品：{ $count }
config-wizard-static-kits = - 固定套組：{ $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ 未設定貨幣
config-wizard-configured-currencies = {"**"}已設定的貨幣：{"**"}
config-wizard-no-denominations = - 未設定面額
config-wizard-gm-rewards-disabled = {"**"}狀態：{"**"} 已停用
config-wizard-gm-rewards-enabled = {"**"}狀態：{"**"} 已啟用
config-wizard-gm-rewards-experience = - 經驗值：{ $xp }
config-wizard-gm-rewards-items = - 物品：
config-wizard-unnamed-shop = 未命名商店

## Roles View
config-title-roles = {"**"}伺服器設定 - 身分組{"**"}
config-label-announcement-role = {"**"}公告身分組：{"**"} { $status }
config-desc-announcement-role = 此身分組在發布 Quest 時會被提及。
config-label-announcement-role-default = {"**"}公告身分組：{"**"} 未設定
config-label-gm-roles = {"**"}GM 身分組：{"**"} { $roles }
config-desc-gm-roles = 這些身分組將授予存取 GM 指令和功能的權限。
config-label-gm-roles-default = {"**"}GM 身分組：{"**"} 未設定
config-title-forbidden-roles = __{"**"}禁用身分組{"**"}__
config-desc-forbidden-roles =
    設定 GM 無法用於隊伍身分組的身分組名稱列表。
    預設情況下，`everyone`、`administrator`、`gm` 和 `game master` 不可使用。此設定
    可擴充該列表。

## GM Role Remove View
config-title-remove-gm-roles = {"**"}伺服器設定 - 移除 GM 身分組{"**"}
config-msg-no-gm-roles = 未設定 GM 身分組。

## Channels View
config-title-channels = {"**"}伺服器設定 - 頻道{"**"}

config-label-quest-board = {"**"}Quest 公告板：{"**"} { $channel }
config-desc-quest-board = 新的/進行中的 Quest 將發布至此頻道。
config-label-quest-board-default = {"**"}Quest 公告板：{"**"} 未設定

config-label-player-board = {"**"}玩家公告板：{"**"} { $channel }
config-desc-player-board = 供玩家使用的選用公告/訊息板。
config-label-player-board-default = {"**"}玩家公告板：{"**"} 未設定

config-label-quest-archive = {"**"}Quest 封存：{"**"} { $channel }
config-desc-quest-archive = 已完成的 Quest 將移至此選用頻道，附帶摘要資訊。
config-label-quest-archive-default = {"**"}Quest 封存：{"**"} 未設定

config-label-gm-transaction-log = {"**"}GM 交易紀錄：{"**"} { $channel }
config-desc-gm-transaction-log = GM 交易（即修改玩家指令）記錄至此選用頻道。
config-label-gm-transaction-log-default = {"**"}GM 交易紀錄：{"**"} 未設定

config-label-player-transaction-log = {"**"}玩家交易紀錄：{"**"} { $channel }
config-desc-player-transaction-log = 玩家交易（如交換和消耗物品）記錄至此選用頻道。
config-label-player-transaction-log-default = {"**"}玩家交易紀錄：{"**"} 未設定

config-label-shop-log = {"**"}商店紀錄：{"**"} { $channel }
config-desc-shop-log = 商店交易記錄至此選用頻道。
config-label-shop-log-default = {"**"}商店紀錄：{"**"} 未設定

## Quests View
config-title-quests = {"**"}伺服器設定 - Quest{"**"}

config-label-wait-list = {"**"}Quest 候補名單大小：{"**"} { $size }
config-desc-wait-list = 候補名單允許指定數量的玩家在 Quest 已滿時排隊等候，以防有玩家退出。
config-label-wait-list-disabled = {"**"}Quest 候補名單大小：{"**"} 已停用

config-label-quest-summary = {"**"}Quest 摘要：{"**"} { $status }
config-desc-quest-summary = 此選項可讓 GM 在結束 Quest 時提供簡短摘要。
config-label-quest-summary-disabled = {"**"}Quest 摘要：{"**"} 已停用

config-label-gm-rewards = GM 獎勵
config-desc-gm-rewards = 設定 GM 完成 Quest 時獲得的獎勵。

## GM Rewards View
config-title-gm-rewards = {"**"}伺服器設定 - GM 獎勵{"**"}
config-desc-gm-rewards-detail =
    {"**"}新增/修改獎勵{"**"}
    開啟輸入視窗以新增、修改或移除 GM 獎勵。

    > 設定的獎勵是以每次 Quest 為單位。每當 GM 完成一次 Quest，
    將在其啟用角色上獲得以下設定的獎勵。
config-msg-no-rewards = 未設定獎勵。
config-label-gm-experience = {"**"}經驗值：{"**"} { $xp }
config-label-gm-items = {"**"}物品：{"**"}

## Players View
config-title-players = {"**"}伺服器設定 - 玩家{"**"}

config-label-player-experience = {"**"}玩家經驗值：{"**"} { $status }
config-desc-player-experience = 啟用/停用經驗值（或類似的數值型角色成長系統）的使用。
config-label-player-experience-disabled = {"**"}玩家經驗值：{"**"} 已停用

config-label-new-char-settings = {"**"}新角色設定{"**"}
config-desc-new-char-settings = 設定與新玩家角色及其初始背包設定相關的選項。

config-label-player-board-purge = {"**"}玩家公告板清理{"**"}
config-desc-player-board-purge = 清理玩家公告板上的發文（如果已啟用）。

## New Character Settings View
config-title-new-character = {"**"}伺服器設定 - 新角色設定{"**"}

config-label-inventory-type = {"**"}新角色背包類型：{"**"} { $type }
config-desc-inventory-type = 決定新註冊角色如何初始化其背包。
config-label-inventory-type-disabled = {"**"}新角色背包類型：{"**"} 已停用

config-label-new-char-wealth = {"**"}新角色財富：{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}新角色財富：{"**"} 已停用

config-label-approval-queue = {"**"}審核佇列：{"**"} { $channel }
config-desc-approval-queue = 如果設定，新角色必須在此 Forum 頻道中由 GM 審核通過後才能啟用。
config-label-approval-queue-disabled = {"**"}審核佇列：{"**"} 已停用
config-label-approval-queue-not-configured = {"**"}審核佇列：{"**"} 未設定

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = 玩家以空背包開始。
config-desc-inv-type-selection = 玩家可從新角色商店自由選擇物品。
config-desc-inv-type-purchase = 玩家使用指定的貨幣從新角色商店購買物品。
config-desc-inv-type-open = 玩家手動輸入其背包物品。
config-desc-inv-type-static = 玩家獲得預設的起始背包。

## New Character Shop View
config-title-new-char-shop = {"**"}伺服器設定 - 新角色商店{"**"}
config-label-inv-type-selection = {"**"}背包類型：{"**"} 自選
config-desc-inv-type-selection-shop = 玩家可從新角色商店自由選擇物品。
config-label-inv-type-purchase = {"**"}背包類型：{"**"} 購買
config-desc-inv-type-purchase-shop = 玩家使用指定的貨幣從新角色商店購買物品。
config-label-inv-type-other = {"**"}背包類型：{"**"} { $type }
config-desc-inv-type-not-in-use = 新角色商店未使用中。
config-msg-define-shop-items = 定義商店物品。
config-msg-no-items = 未設定物品。

## Static Kits View
config-title-static-kits = {"**"}伺服器設定 - 固定套組{"**"}
config-desc-create-kit = 建立新的套組定義。
config-msg-no-kits = 未設定套組。
config-label-kit-more-items = ⋯以及其他 { $count } 個物品
config-label-empty-kit = {"*"}空套組{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}正在編輯套組：{ $kitName }{"**"}
config-msg-kit-empty = 此套組是空的。使用上方按鈕新增貨幣或物品。
config-label-kit-currency = {"**"}貨幣：{"**"} { $display }
config-label-kit-item = {"**"}物品：{"**"} { $name }

## Currency View
config-title-currency = {"**"}伺服器設定 - 貨幣{"**"}
config-desc-create-currency = 建立新貨幣。
config-msg-no-currencies = 未設定貨幣。
config-label-currency-display-type = 顯示類型：{ $type } | 面額：{ $count }
config-label-currency-type-double = 小數
config-label-currency-type-integer = 整數

## Edit Currency View
config-title-manage-currency = {"**"}管理貨幣：{ $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}貨幣與面額{"**"}__
    - 您指定的貨幣名稱視為基礎貨幣，數值為 1。
    {"```"}範例：「gold」被設定為一種貨幣。{"```"}
    - 新增面額時需要指定名稱及相對於基礎貨幣的數值。
    {"```"}範例：Gold 被賦予兩個面額：silver（數值 0.1）和 copper（數值 0.01）。{"```"}
    - 任何涉及基礎貨幣或其面額的交易將自動進行轉換。
    {"```"}範例：一位玩家擁有 10 gold 並花費 3 copper。其新餘額將自動顯示為
    9 gold、9 silver 和 7 copper。{"```"}
    - 以整數顯示的貨幣會顯示每個面額，而以小數顯示的貨幣
    僅顯示基礎貨幣。
    {"```"}範例：上述玩家啟用小數顯示後，將顯示為 9.97 gold。{"```"}
config-btn-toggle-display-current = 切換顯示方式（目前：{ $type }）
config-msg-no-denominations = 未設定面額。

## Shops View
config-title-shops = {"**"}伺服器設定 - 商店{"**"}
config-desc-add-shop-wizard =
    {"**"}新增商店（精靈）{"**"}
    透過表單建立新的空白商店。
config-desc-add-shop-json =
    {"**"}新增商店（JSON）{"**"}
    透過提供完整的 JSON 定義建立新商店。（進階）
config-msg-no-shops = 未設定商店。
config-label-shop-type-forum = （Forum）
config-label-shop-channel = 頻道：<#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}新增商店 - 選擇位置類型{"**"}
config-label-text-channel = {"**"}文字頻道{"**"}
config-desc-text-channel = 在標準文字頻道中建立商店。
config-label-forum-thread = {"**"}Forum 討論串{"**"}
config-desc-forum-thread = 在 Forum 討論串中建立商店（新建或現有）。

## Forum Shop Setup View
config-title-forum-setup = {"**"}新增商店 - Forum 討論串設定{"**"}
config-label-step1 = {"**"}步驟 1：選擇 Forum 頻道{"**"}
config-label-step2 = {"**"}步驟 2：選擇討論串選項{"**"}
config-label-step3 = {"**"}步驟 3：選擇現有討論串{"**"}
config-desc-create-new-thread =
    {"**"}建立新討論串{"**"}
    開啟表單以建立新討論串並設定商店。
config-label-selected-thread = {"**"}已選擇的討論串：{"**"} { $threadName }
config-desc-click-to-configure = 點擊以在此討論串中設定商店。

## Manage Shop View
config-title-manage-shop = {"**"}管理商店：{ $shopName }{"**"}
config-label-shop-type = {"**"}類型：{"**"} { $type }
config-label-shop-type-text = 文字頻道
config-label-shop-type-forum-thread = Forum 討論串
config-label-shopkeeper = {"**"}店主：{"**"} { $name }
config-label-shop-description = {"**"}描述：{"**"} { $description }
config-label-shop-channel-info = {"**"}頻道：{"**"} <#{ $channelId }>
config-desc-edit-wizard = 透過精靈編輯商店詳情和物品。
config-desc-upload-json = 為此商店上傳新的 JSON 定義。
config-desc-download-json = 下載目前的 JSON 定義。
config-desc-remove-shop = 永久移除此商店。

## Edit Shop View
config-title-editing-shop = {"**"}正在編輯商店：{ $shopName }{"**"}
config-label-shop-shopkeeper = 店主：{"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}庫存設定：{ $shopName }{"**"}
config-label-current-utc = 目前 UTC 時間：{"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}補貨排程：{"**"} { $schedule }
config-label-restock-hourly = 於第 :{ $minute } 分
config-label-restock-daily = 於 { $time } UTC
config-label-restock-weekly = 於{ $day } { $time } UTC
config-label-restock-mode = {"**"}模式：{"**"} { $mode }
config-label-restock-full = 完整補貨
config-label-restock-incremental = 每週期增加 { $amount }（上限為最大值）
config-label-restock-disabled = {"**"}補貨排程：{"**"} 已停用
config-label-item-stock-limits = {"**"}物品庫存限制{"**"}
config-msg-no-items-in-shop = 此商店中沒有物品。
config-label-stock-with-available = 最大值：{ $max } | 可用：{ $available }
config-label-stock-reserved = | 已預留：{ $reserved }
config-label-stock-not-initialized = 最大值：{ $max } | 可用：（尚未初始化）
config-label-stock-unlimited = 庫存：無限制

## Roleplay View
config-title-roleplay = {"**"}伺服器設定 - 角色扮演獎勵{"**"}
config-label-rp-status = {"**"}狀態：{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}伺服器時間：{"**"} `{ $time }`
config-label-rp-enabled = 已啟用
config-label-rp-disabled = 已停用

config-desc-rp-mode-scheduled = {"```"}獎勵在設定的時間週期（每小時、每天或每週）內，於發送所需門檻數量的符合條件訊息後發放一次。{"```"}
config-desc-rp-mode-accrued = {"```"}獎勵在每次發送指定數量的符合條件訊息後重複發放。{"```"}

config-label-rp-config-details = {"**"}設定詳情：{"**"}
config-label-rp-mode = {"**"}模式：{"**"} { $mode }
config-label-rp-min-length = {"**"}最低訊息長度：{"**"} { $length } 個字元
config-label-rp-cooldown = {"**"}冷卻時間：{"**"} { $seconds } 秒
config-label-rp-frequency-once = {"**"}頻率：{"**"} 每{ $period }一次
config-label-rp-reset-time = {"**"}重設時間：{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}門檻：{"**"} { $count } 則符合條件的訊息
config-label-rp-frequency-every = {"**"}頻率：{"**"} 每 { $count } 則符合條件的訊息

config-label-rp-channels = {"**"}角色扮演頻道：{"**"}
config-msg-rp-no-channels = 未設定。
config-label-rp-channels-more = ⋯以及其他 { $count } 個。

config-label-rp-rewards = {"**"}獎勵：{"**"}
config-msg-rp-no-rewards = 未設定。
config-label-rp-experience = {"**"}經驗值：{"**"} { $xp }
config-label-rp-items = {"**"}物品：{"**"}
config-label-rp-currency = {"**"}貨幣：{"**"}

## Language View
config-title-language = {"**"}伺服器設定 - 語言{"**"}
config-server-language-help =
    此設定允許您為此伺服器中 ReQuest 的{"**"}公開{"**"}回應和訊息指定預設語言。公開回應包括：
    - Quest 和玩家公告板發文
    - Quest 摘要和紀錄頻道訊息
    - 商店補貨
    - 玩家物品消耗

    此設定僅影響機器人產生的靜態文字，不會翻譯使用者輸入的動態內容，如物品名稱或 Quest 描述。

    個人回應和選單不受此設定影響。
config-label-server-language = {"**"}伺服器語言：{"**"} { $language }
config-label-server-language-default = {"**"}伺服器語言：{"**"} 預設（無覆蓋）
config-select-placeholder-server-language = 選擇伺服器語言
config-select-option-default = 預設（無覆蓋）
config-select-desc-default = 使用每位使用者的偏好設定或 Discord 語系。
