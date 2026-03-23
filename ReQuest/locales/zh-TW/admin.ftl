## Admin module strings

# Admin cog
admin-embed-title-unauthorized = 未授權的伺服器
admin-embed-desc-unauthorized =
    感謝您對 ReQuest 的關注！您的伺服器不在 ReQuest 的授權測試伺服器列表中。
    請加入下方的支援 Discord，並聯繫開發團隊申請測試存取權限。

    [ReQuest 開發 Discord](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = 以下指令已同步至 { $guildName }，ID { $guildId }
admin-embed-title-sync-global = 以下指令已全域同步
admin-error-missing-scope = ReQuest 在目標伺服器中沒有正確的權限範圍。請新增 `applications.commands` 權限後重試。
admin-error-sync-failed = 同步指令時發生錯誤：{ $error }
admin-msg-commands-cleared = 指令已清除。

# Admin buttons
admin-btn-shutdown = 關閉
admin-modal-title-confirm-shutdown = 確認關閉
admin-modal-label-shutdown-warning = 警告！這將關閉機器人。輸入 CONFIRM 以繼續。
admin-msg-shutting-down = 正在關閉！
admin-btn-add-server = 新增伺服器
admin-btn-load-cog = 載入 Cog
admin-msg-extension-loaded = 擴充功能已成功載入：`{ $module }`
admin-btn-reload-cog = 重新載入 Cog
admin-msg-extension-reloaded = 擴充功能已成功重新載入：`{ $module }`
admin-btn-output-guilds = 輸出伺服器列表
admin-msg-connected-guilds = 已連線至 { $count } 個伺服器：

# Admin modals
admin-modal-title-add-server = 新增伺服器 ID 至允許列表
admin-modal-label-server-name = 伺服器名稱
admin-modal-placeholder-server-name = 輸入 Discord 伺服器的簡短名稱
admin-modal-label-server-id = 伺服器 ID
admin-modal-placeholder-server-id = 輸入 Discord 伺服器的 ID
admin-select-placeholder-server = 選擇要移除的伺服器
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = 名稱
admin-modal-placeholder-cog-name = 輸入要{ $action }的 Cog 名稱

# Admin views
admin-title-main-menu = 管理 - 主選單
admin-desc-allowlist = 設定伺服器允許列表以限制邀請。
admin-desc-cogs = 載入或重新載入 Cog。
admin-desc-guild-list = 返回機器人所在的所有伺服器列表。
admin-desc-shutdown = 關閉機器人
admin-title-allowlist = 管理 - 伺服器允許列表
admin-desc-allowlist-warning =
    新增 Discord 伺服器 ID 至允許列表。
    {"**"}警告：無法驗證所提供的伺服器 ID 是否有效，除非機器人已加入該伺服器。請仔細檢查您的輸入！{"**"}
admin-msg-no-servers = 允許列表中沒有伺服器。

# Admin confirm modals
admin-modal-title-confirm-server-removal = 確認移除伺服器
admin-modal-label-server-removal = 從允許列表中移除伺服器？

# Admin cog view
admin-title-cogs = 管理 - Cog
admin-desc-load-cog = 依名稱載入機器人 Cog。檔案名稱必須為 `<name>.py`，並儲存於 ReQuest/cogs/ 目錄下。
admin-desc-reload-cog = 依名稱重新載入已載入的 Cog。檔案命名及路徑限制相同。
