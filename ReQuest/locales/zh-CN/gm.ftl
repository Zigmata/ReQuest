## Game Master module strings

# GM buttons
gm-btn-create = 创建
gm-btn-edit-details = 编辑详情
gm-btn-toggle-ready = 切换就绪状态
gm-btn-configure-rewards = 配置奖励
gm-btn-remove-player = 移除玩家
gm-btn-cancel-quest = 取消 Quest
gm-btn-manage-party-rewards = 管理队伍奖励
gm-btn-manage-individual-rewards = 管理个人奖励
gm-btn-join = 加入
gm-btn-leave = 离开
gm-btn-complete-quest = 完成 Quest
gm-btn-review-submission = 审核提交
gm-btn-approve = 批准
gm-btn-deny = 拒绝

# GM modals
gm-modal-title-create-quest = 创建新 Quest
gm-modal-label-quest-title = Quest 标题
gm-modal-placeholder-quest-title = 您的 Quest 标题
gm-modal-label-restrictions = 限制条件
gm-modal-placeholder-restrictions = 限制条件（如有），例如玩家等级
gm-modal-label-max-party = 最大队伍人数
gm-modal-placeholder-max-party = 此 Quest 的最大队伍人数
gm-modal-label-party-role = 队伍角色
gm-modal-placeholder-party-role = 为此 Quest 创建一个角色（可选）
gm-modal-label-description = 描述
gm-modal-placeholder-description = 在此撰写您的 Quest 详情
gm-modal-title-editing-quest = 编辑 { $questTitle }
gm-modal-label-title = 标题
gm-modal-label-max-party-size = 最大队伍人数
gm-modal-title-add-reward = 添加奖励
gm-modal-label-experience = 经验值
gm-modal-placeholder-experience = 输入一个数字
gm-modal-label-items = 物品
gm-modal-placeholder-items =
    物品: 数量
    物品2: 数量
    以此类推。
gm-modal-title-add-summary = 添加 Quest 摘要
gm-modal-label-summary = 摘要
gm-modal-placeholder-summary = 添加 Quest 的故事摘要
gm-modal-title-modifying-player = 修改 { $playerName }
gm-modal-placeholder-xp-add-remove = 输入正数或负数。
gm-modal-label-inventory = 物品栏
gm-modal-placeholder-inventory-modify =
    物品: 数量
    物品2: 数量
    以此类推。
gm-modal-title-review-submission = 审核提交
gm-modal-label-submission-id = 提交 ID
gm-modal-placeholder-submission-id = 输入 8 位 ID

# GM errors
gm-error-forbidden-role-name = 为队伍角色提供的名称被禁止使用。
gm-error-role-already-exists = 此服务器中已存在同名角色。
gm-error-no-quest-channel = 尚未指定 Quest 发布频道。请联系服务器管理员配置 Quest 频道。
gm-error-cannot-ping-announce = 无法在频道 { $channel } 中提及公告角色 { $role }。请与服务器管理员检查频道和 ReQuest 角色权限。
gm-error-invalid-item-format = 无效的物品格式："{ $item }"。每个物品必须在新行上，格式为"名称: 数量"。
gm-error-submission-not-found = 未找到提交内容。
gm-error-already-on-quest = 您已经以 { $characterName } 的身份参加了此 Quest。
gm-error-no-active-character-long = 您在此服务器上没有活跃角色。请使用 `/player` 注册或激活角色。
gm-error-quest-locked = 加入 Quest {"**"}{ $questTitle }{"**"} 时出错：Quest 已被 GM 锁定。
gm-error-quest-full = 加入 Quest {"**"}{ $questTitle }{"**"} 时出错：Quest 名额已满！
gm-error-not-signed-up = 您未报名参加此 Quest。
gm-error-quest-channel-not-set = Quest 频道尚未设置！
gm-error-empty-roster = 不能在名单为空的情况下完成 Quest。请尝试取消。
gm-error-invalid-xp-value = 经验值必须是正整数！

# GM confirm modals
gm-modal-title-cancel-quest = 取消 Quest
gm-modal-label-cancel-quest = 输入 CONFIRM 以取消 Quest。
gm-modal-title-remove-from-quest = 从 Quest 中移除角色
gm-modal-label-remove-from-quest = 确认移除角色？

# GM DM messages
gm-dm-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} 已被 GM 取消。
gm-dm-quest-ready = Quest {"**"}{ $questTitle }{"**"} 现已就绪！
gm-dm-quest-unlocked = Quest {"**"}{ $questTitle }{"**"} 已解除锁定。
gm-dm-quest-locked = Quest {"**"}{ $questTitle }{"**"} 已被 GM 锁定。
gm-dm-player-removed = 您已被从 Quest {"**"}{ $questTitle }{"**"} 中移除。
gm-dm-player-removed-waitlist = 您已被从 {"**"}{ $questTitle }{"**"} 的等待列表中移除。
gm-dm-party-promotion = 由于有玩家退出，您已被加入 {"**"}{ $questTitle }{"**"} 的队伍！
gm-dm-roster-locked = Quest 名单已锁定并已通知队伍成员！
gm-dm-roster-unlocked = Quest 名单已解除锁定。
gm-dm-rewards-no-characters =
    您的服务器管理员已为 GM 完成 Quest 配置了奖励。但由于您没有已注册的角色，
    您的奖励目前无法自动发放。
gm-dm-rewards-no-active-character =
    您的服务器管理员已为 GM 完成 Quest 配置了奖励。但由于您在此服务器上没有活跃角色，
    您的奖励目前无法自动发放。
gm-dm-rewards-issued = 以下奖励已发放到您的活跃角色 { $characterName }

# GM select menus
gm-select-placeholder-party-member = 选择一名队伍成员

# GM embeds
gm-embed-title-mod-report = GM 玩家修改报告
gm-embed-field-experience = 经验值
gm-embed-title-quest-complete = Quest 完成：{ $questTitle }
gm-embed-title-quest-completed = QUEST 已完成：{ $questTitle }
gm-embed-field-rewards = 奖励
gm-embed-field-party = __队伍__
gm-embed-field-summary = 摘要
gm-embed-title-gm-rewards = GM 奖励已发放
gm-embed-field-items = 物品
gm-msg-player-removed = 玩家已移除，Quest 名单已更新！

# GM views
gm-title-main-menu = GM - 主菜单
gm-menu-quests = Quest
gm-menu-desc-quests = 创建、编辑和管理 Quest。
gm-menu-players = 玩家
gm-menu-desc-players = 管理玩家物品栏和修改角色。
gm-menu-approvals = 角色审批
gm-menu-desc-approvals = 审核并批准/拒绝角色提交。

gm-title-quest-management = GM - Quest 管理
gm-desc-create-quest = 创建新的 Quest。
gm-msg-no-quests = 未找到 Quest。
gm-label-quest-locked = （已锁定）
gm-title-manage-quest = 管理 Quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = 编辑 Quest 详情，如标题、描述和队伍人数。
gm-desc-toggle-ready = 切换就绪状态（当前：{"**"}{ $status }{"**"}）
    - 锁定 Quest 名单并通知队伍成员 Quest 即将开始。如果配置了角色，将在锁定时分配给队伍成员。
    - 设为开放时解锁名单。
gm-label-ready-locked = 已锁定/就绪
gm-label-ready-open = 开放
gm-desc-configure-rewards = 配置所选 Quest 的奖励。
gm-desc-complete-quest = 完成 Quest。向队伍成员发放奖励（如有）。
gm-desc-remove-player = 从 Quest 名单中移除玩家并通知他们。
gm-desc-cancel-quest = 取消 Quest 并从 Quest 公告板中删除。
gm-title-player-management = GM - 玩家管理
gm-desc-player-management =
    这些命令已迁移至右键菜单。在电脑上右键点击（桌面端）或长按（移动端）玩家资料以获取以下菜单选项：

    - {"**"}Modify Player{"**"}：添加或移除玩家的物品和经验值。
    - {"**"}View Player{"**"}：查看玩家的活跃角色详情。
gm-title-remove-player = 从 Quest 中移除玩家 - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}玩家移除说明{"**"}__

    - 从下方下拉菜单中选择要从 Quest 名单中移除的玩家。
    - 如果有玩家在等待列表中，列表中的第一位玩家将被提升到队伍中。
    - 被移除玩家的个人奖励将从 Quest 中删除。
    - 如果您想奖励该玩家之前的贡献，请使用 `Modify Player` 右键菜单直接向他们发放奖励。
gm-label-no-players-in-roster = Quest 名单中没有玩家
gm-title-character-sheet = { $characterName } 的角色信息（<@{ $memberId }>）
gm-label-experience-points = __{"**"}经验值：{"**"}__
gm-label-possessions = __{"**"}持有物{"**"}__
gm-label-currency-heading = {"**"}货币{"**"}
gm-msg-inventory-empty = 物品栏为空。

# GM approvals
gm-title-approvals = GM - 物品栏审批
gm-desc-review-submission = 输入提交 ID 以审核并批准/拒绝。
gm-title-reviewing = 审核中：{ $characterName }
gm-label-items = {"**"}物品：{"**"}
gm-label-currency = {"**"}货币：{"**"}
gm-embed-title-approved = 物品栏更新已批准
gm-embed-desc-approved = {"**"}{ $characterName }{"**"} 的物品栏已由 { $approver } 批准。
gm-embed-title-denied = 物品栏更新已拒绝
gm-embed-desc-denied = {"**"}{ $characterName }{"**"} 的物品栏已由 { $denier } 拒绝。

gm-modal-label-select-party-role = 队伍角色
gm-modal-desc-select-party-role = 选择要分配给 Quest 队伍的角色。
gm-select-option-no-role = 无（不设队伍角色）

gm-error-role-hierarchy = ReQuest 无法管理角色"{ $roleName }"（ID：{ $roleId }），因为该角色在服务器层级中高于 ReQuest 的最高角色。请联系服务器管理员将该角色移至 ReQuest 角色下方，或为 ReQuest 分配更高的角色，然后重试操作。
gm-dm-role-removal-failed =
    ⚠️ 无法从以下成员移除角色 {"**"}{ $roleName }{"**"}：{ $members }。
    请通知服务器管理员手动移除该角色。

gm-dm-role-not-found =
    ⚠️ Quest {"**"}{ $questTitle }{"**"} 的 Quest 角色（ID：{ $roleId }）在服务器上已不存在。
    角色操作已跳过。如果这不在预期之内，请通知服务器管理员。
