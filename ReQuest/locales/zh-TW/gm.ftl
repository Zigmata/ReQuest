## Game Master module strings

# GM buttons
gm-btn-create = 建立
gm-btn-edit-details = 編輯 Quest
gm-btn-toggle-ready = 切換就緒狀態
gm-btn-configure-rewards = 設定獎勵
gm-btn-remove-player = 移除玩家
gm-btn-cancel-quest = 取消 Quest
gm-btn-manage-party-rewards = 管理隊伍獎勵
gm-btn-manage-individual-rewards = 管理個人獎勵
gm-btn-join = 加入
gm-btn-leave = 離開
gm-btn-complete-quest = 完成 Quest
gm-btn-edit-details-modal = 編輯詳情
gm-btn-edit-images = 編輯圖片
gm-select-placeholder-party-role = 選擇隊伍身分組...
gm-modal-title-edit-details = 編輯 Quest 詳情
gm-modal-title-edit-images = 編輯 Quest 圖片
gm-btn-publish = 發布
gm-btn-update-post = 更新貼文

# GM modals
gm-modal-title-create-quest = 建立新 Quest
gm-modal-label-quest-title = Quest 標題
gm-modal-placeholder-quest-title = 您的 Quest 標題
gm-modal-label-restrictions = 限制
gm-modal-placeholder-restrictions = 限制條件（如有），例如玩家等級
gm-modal-label-max-party = 隊伍人數上限
gm-modal-placeholder-max-party = 此 Quest 的隊伍人數上限
gm-modal-label-party-role = 隊伍身分組
gm-modal-placeholder-party-role = 為此 Quest 建立身分組（選用）
gm-modal-label-description = 描述
gm-modal-placeholder-description = 在此撰寫您 Quest 的詳情
gm-modal-label-image-url = 縮圖 URL
gm-modal-label-large-image-url = 大圖 URL
gm-modal-placeholder-image-url = 輸入圖片 URL（或留空以移除）
gm-modal-title-add-reward = 新增獎勵
gm-modal-label-experience = 經驗值
gm-modal-placeholder-experience = 輸入數字
gm-modal-label-items = 物品
gm-modal-placeholder-items =
    物品名稱：數量
    物品名稱2：數量
    以此類推。
gm-modal-title-add-summary = 新增 Quest 摘要
gm-modal-label-summary = 摘要
gm-modal-placeholder-summary = 為 Quest 新增劇情摘要
gm-modal-title-modifying-player = 正在修改 { $playerName }
gm-modal-placeholder-xp-add-remove = 輸入正數或負數。
gm-modal-label-inventory = 背包
gm-modal-placeholder-inventory-modify =
    物品名稱：數量
    物品名稱2：數量
    以此類推。

# GM errors
gm-error-forbidden-role-name = 所提供的隊伍身分組名稱已被禁用。
gm-error-role-already-exists = 此伺服器中已存在同名的身分組。
gm-error-no-quest-channel = 尚未為 Quest 發文指定頻道。請聯繫伺服器管理員設定 Quest 頻道。
gm-error-cannot-ping-announce = 無法在頻道 { $channel } 中提及公告身分組 { $role }。請與伺服器管理員確認頻道和 ReQuest 身分組的權限。
gm-error-invalid-item-format = 無效的物品格式：「{ $item }」。每個物品必須獨立一行，格式為「名稱：數量」。
gm-error-already-on-quest = 您已經以 { $characterName } 身分參加了此 Quest。
gm-error-no-active-character-long = 您在此伺服器上沒有啟用的角色。請使用 `/player` 來註冊或啟用角色。
gm-error-quest-locked = 加入 Quest {"**"}{ $questTitle }{"**"} 時發生錯誤：Quest 已被 GM 鎖定。
gm-error-quest-full = 加入 Quest {"**"}{ $questTitle }{"**"} 時發生錯誤：Quest 名單已滿！
gm-error-not-signed-up = 您尚未報名此 Quest。
gm-error-quest-not-found = 任務不再存在。
gm-error-quest-channel-not-set = Quest 頻道尚未設定！
gm-error-empty-roster = 您無法在名單為空的情況下完成 Quest。請嘗試取消。
gm-error-invalid-xp-value = 經驗值必須為正整數！
gm-error-role-hierarchy = ReQuest 無法管理身分組「{ $roleName }」（ID：{ $roleId }），因為該身分組在伺服器階層中高於 ReQuest 的最高身分組。請聯繫伺服器管理員將該身分組移至 ReQuest 身分組下方，或為 ReQuest 指派更高的身分組，然後重試操作。
gm-error-party-size-positive = 隊伍人數必須為正數。
gm-error-party-size-too-small = 隊伍人數不能小於目前隊伍（{ $currentSize } 名成員）。
gm-error-role-name-forbidden = 身分組名稱「{ $roleName }」在此伺服器中被禁用。
gm-error-role-name-exists = 名為「{ $roleName }」的身分組在此伺服器中已存在。

# GM confirm modals
gm-modal-title-cancel-quest = 取消 Quest
gm-modal-label-cancel-quest = 輸入 確認 以取消此 Quest。
gm-modal-title-remove-from-quest = 從 Quest 中移除角色
gm-modal-label-remove-from-quest = 確認移除角色？

# GM DM embeds
gm-dm-title-quest-cancelled = Quest 已取消
gm-dm-desc-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} 已被 GM 取消。
gm-dm-title-quest-ready = Quest 已就緒
gm-dm-desc-quest-ready = Quest {"**"}{ $questTitle }{"**"} 現已準備就緒！您的 GM 將很快開始 Quest。
gm-dm-title-player-removed = 已從 Quest 移除
gm-dm-desc-player-removed = 您已被 GM 從 Quest {"**"}{ $questTitle }{"**"} 中移除。
gm-dm-desc-player-removed-waitlist = 您已被從 {"**"}{ $questTitle }{"**"} 的候補名單中移除。
gm-dm-title-party-promotion = 隊伍晉升
gm-dm-desc-party-promotion =
    由於有玩家退出 Quest，
    您已被晉升至 {"**"}{ $questTitle }{"**"} 的主隊伍。
gm-dm-title-roster-locked = 名單已鎖定
gm-dm-desc-roster-locked =
    {"**"}{ $questTitle }{"**"} 的名單已鎖定，
    所有隊伍成員已收到通知。
gm-dm-title-roster-unlocked = 名單已解鎖
gm-dm-desc-roster-unlocked = {"**"}{ $questTitle }{"**"} 的名單已解除鎖定。
gm-dm-title-player-removed-confirm = 玩家已移除
gm-dm-desc-player-removed-confirm =
    該玩家已從 {"**"}{ $questTitle }{"**"} 中移除，
    Quest 名單已更新。
gm-dm-footer-quest = Quest ID：{ $questId } • { $guildName }
gm-dm-rewards-no-characters =
    您的伺服器管理員已為 GM 完成 Quest 時設定了獎勵。但由於您沒有已註冊的角色，
    目前無法自動發放獎勵。
gm-dm-rewards-no-active-character =
    您的伺服器管理員已為 GM 完成 Quest 時設定了獎勵。但由於您在此伺服器上沒有
    啟用的角色，目前無法自動發放獎勵。
gm-dm-rewards-issued = 以下獎勵已發放給您的啟用角色 { $characterName }
gm-dm-role-removal-failed =
    ⚠️ 無法從以下成員移除身分組 {"**"}{ $roleName }{"**"}：{ $members }。
    請通知伺服器管理員手動移除該身分組。
gm-dm-role-not-found =
    ⚠️ Quest {"**"}{ $questTitle }{"**"} 的 Quest 身分組（ID：{ $roleId }）在伺服器上已不存在。
    身分組操作已跳過。如果這不在預期之內，請通知伺服器管理員。

# GM select menus
gm-select-placeholder-party-member = 選擇一位隊伍成員
gm-modal-label-select-party-role = 隊伍身分組
gm-modal-desc-select-party-role = 選擇要指派給 Quest 隊伍的身分組。
gm-select-option-no-role = 無（不設隊伍身分組）

# GM embeds
gm-embed-title-mod-report = GM 玩家修改報告
gm-embed-field-experience = 經驗值
gm-embed-title-quest-complete = Quest 完成：{ $questTitle }
gm-embed-title-quest-completed = QUEST 已完成：{ $questTitle }
gm-embed-field-rewards = 獎勵
gm-embed-field-party = __隊伍__
gm-embed-field-summary = 摘要
gm-embed-title-gm-rewards = GM 獎勵已發放
gm-embed-field-items = 物品

# GM views
gm-title-main-menu = GM - 主選單
gm-menu-quests = Quest
gm-menu-desc-quests = 建立、編輯和管理 Quest。
gm-menu-players = 玩家
gm-menu-desc-players = 管理玩家背包和修改角色。

gm-title-quest-management = GM - Quest 管理
gm-desc-create-quest = 建立新 Quest。
gm-msg-no-quests = 找不到 Quest。
gm-label-quest-locked = （已鎖定）
gm-label-quest-draft = （草稿）
gm-title-manage-quest = 管理 Quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = 編輯 Quest 詳情，如標題、描述和隊伍人數。
gm-title-edit-quest = 編輯 Quest - { $questTitle }
gm-label-field-not-set = 未設定
gm-label-description-not-set = 未設定描述
gm-label-current-title = {"**"}標題：{"**"} { $value }
gm-label-current-description = {"**"}描述{"**"}
gm-label-current-restrictions = {"**"}限制：{"**"} { $value }
gm-label-current-party-size = {"**"}隊伍人數上限：{"**"} { $value }
gm-label-current-party-role = {"**"}隊伍身分組：{"**"} { $value }
gm-label-current-image = {"**"}縮圖{"**"}
gm-label-current-large-image = {"**"}圖片{"**"}
gm-desc-publish-quest = 將此 Quest 發布到 Quest 公告板。
gm-desc-update-quest-post = 更新 Quest 公告板上的 Quest 貼文。
gm-desc-toggle-ready = 切換就緒狀態（目前：{"**"}{ $status }{"**"}）
    - 鎖定 Quest 名單並通知隊伍成員 Quest 即將開始。如果已設定身分組，鎖定時會指派給隊伍成員。
    - 設為開放時解除名單鎖定。
gm-label-ready-locked = 已鎖定/就緒
gm-label-ready-open = 開放
gm-desc-configure-rewards = 為所選 Quest 設定獎勵。
gm-desc-complete-quest = 完成 Quest。向隊伍成員發放獎勵（如有設定）。
gm-desc-remove-player = 從 Quest 名單中移除玩家並通知他們。
gm-desc-cancel-quest = 取消 Quest 並從 Quest 公告板中刪除。
gm-title-player-management = GM - 玩家管理
gm-desc-player-management =
    這些指令已遷移至右鍵選單。右鍵點擊（桌面版）或長按（行動版）玩家的個人檔案以使用以下選單選項：

    - {"**"}修改玩家{"**"}：為玩家新增或移除物品和經驗值。
    - {"**"}檢視玩家{"**"}：檢視玩家的啟用角色詳情。
gm-title-remove-player = 從 Quest 中移除玩家 - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}玩家移除注意事項{"**"}__

    - 從下方的下拉選單中選擇一位玩家，將其從 Quest 名單中移除。
    - 如果有玩家在候補名單中，候補名單上的第一位玩家將被提升至隊伍。
    - 被移除玩家的個人獎勵將從 Quest 中刪除。
    - 如果您希望獎勵該玩家先前的貢獻，請使用「修改玩家」右鍵選單直接發放獎勵。
gm-label-no-players-in-roster = Quest 名單中沒有玩家
gm-title-character-sheet = { $characterName } 的角色卡（<@{ $memberId }>）
gm-label-experience-points = __{"**"}經驗值：{"**"}__
gm-label-possessions = __{"**"}持有物{"**"}__
gm-label-currency-heading = {"**"}貨幣{"**"}
gm-msg-inventory-empty = 背包是空的。

# GM approvals
