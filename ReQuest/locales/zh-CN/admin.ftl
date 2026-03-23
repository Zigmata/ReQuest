## Admin module strings

# Admin cog
admin-embed-title-unauthorized = 未授权的服务器
admin-embed-desc-unauthorized =
    感谢您对 ReQuest 的关注！您的服务器不在 ReQuest 的授权测试服务器列表中。
    请加入下方的支持 Discord，并联系开发团队申请测试权限。

    [ReQuest 开发 Discord](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = 以下命令已同步到 { $guildName }，ID { $guildId }
admin-embed-title-sync-global = 以下命令已全局同步
admin-error-missing-scope = ReQuest 在目标服务器中没有正确的权限范围。请添加 `applications.commands` 权限后重试。
admin-error-sync-failed = 同步命令时出错：{ $error }
admin-msg-commands-cleared = 命令已清除。

# Admin buttons
admin-btn-shutdown = 关机
admin-modal-title-confirm-shutdown = 确认关机
admin-modal-label-shutdown-warning = 警告！这将关闭机器人。输入 CONFIRM 以继续。
admin-msg-shutting-down = 正在关闭！
admin-btn-add-server = 添加新服务器
admin-btn-load-cog = 加载 Cog
admin-msg-extension-loaded = 扩展加载成功：`{ $module }`
admin-btn-reload-cog = 重新加载 Cog
admin-msg-extension-reloaded = 扩展重新加载成功：`{ $module }`
admin-btn-output-guilds = 输出服务器列表
admin-msg-connected-guilds = 已连接到 { $count } 个服务器：

# Admin modals
admin-modal-title-add-server = 将服务器 ID 添加到白名单
admin-modal-label-server-name = 服务器名称
admin-modal-placeholder-server-name = 输入 Discord 服务器的简称
admin-modal-label-server-id = 服务器 ID
admin-modal-placeholder-server-id = 输入 Discord 服务器的 ID
admin-select-placeholder-server = 选择要移除的服务器
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = 名称
admin-modal-placeholder-cog-name = 输入要 { $action } 的 Cog 名称

# Admin views
admin-title-main-menu = 管理 - 主菜单
admin-desc-allowlist = 配置服务器白名单以限制邀请。
admin-desc-cogs = 加载或重新加载 Cog。
admin-desc-guild-list = 返回机器人所在的所有服务器列表。
admin-desc-shutdown = 关闭机器人
admin-title-allowlist = 管理 - 服务器白名单
admin-desc-allowlist-warning =
    将新的 Discord 服务器 ID 添加到白名单。
    {"**"}警告：在机器人加入服务器之前，无法验证提供的服务器 ID 是否有效。请仔细检查您的输入！{"**"}
admin-msg-no-servers = 白名单中没有服务器。

# Admin confirm modals
admin-modal-title-confirm-server-removal = 确认移除服务器
admin-modal-label-server-removal = 从白名单中移除服务器？

# Admin cog view
admin-title-cogs = 管理 - Cog
admin-desc-load-cog = 按名称加载机器人 Cog。文件必须命名为 `<name>.py` 并存放在 ReQuest/cogs/ 目录下。
admin-desc-reload-cog = 按名称重新加载已加载的 Cog。相同的命名和文件路径限制适用。
