## Game Master module strings

# GM buttons
gm-btn-create = 作成
gm-btn-edit-details = 詳細を編集
gm-btn-toggle-ready = 準備状態の切替
gm-btn-configure-rewards = 報酬を設定
gm-btn-remove-player = プレイヤーを削除
gm-btn-cancel-quest = Quest をキャンセル
gm-btn-manage-party-rewards = パーティー報酬を管理
gm-btn-manage-individual-rewards = 個別報酬を管理
gm-btn-join = 参加
gm-btn-leave = 離脱
gm-btn-complete-quest = Quest を完了
gm-btn-review-submission = 申請を確認
gm-btn-approve = 承認
gm-btn-deny = 却下

# GM modals
gm-modal-title-create-quest = 新しい Quest を作成
gm-modal-label-quest-title = Quest タイトル
gm-modal-placeholder-quest-title = Quest のタイトル
gm-modal-label-restrictions = 制限
gm-modal-placeholder-restrictions = プレイヤーレベルなどの制限がある場合
gm-modal-label-max-party = 最大パーティーサイズ
gm-modal-placeholder-max-party = この Quest のパーティー最大人数
gm-modal-label-party-role = パーティーロール
gm-modal-placeholder-party-role = この Quest 用のロールを作成（任意）
gm-modal-label-description = 説明
gm-modal-placeholder-description = Quest の詳細をここに記入してください
gm-modal-title-editing-quest = { $questTitle } を編集中
gm-modal-label-title = タイトル
gm-modal-label-max-party-size = 最大パーティーサイズ
gm-modal-title-add-reward = 報酬を追加
gm-modal-label-experience = 経験値
gm-modal-placeholder-experience = 数値を入力してください
gm-modal-label-items = アイテム
gm-modal-placeholder-items =
    アイテム名: 数量
    アイテム名2: 数量
    など
gm-modal-title-add-summary = Quest サマリーを追加
gm-modal-label-summary = サマリー
gm-modal-placeholder-summary = Quest のストーリーサマリーを追加してください
gm-modal-title-modifying-player = { $playerName } を変更中
gm-modal-placeholder-xp-add-remove = 正または負の数値を入力してください。
gm-modal-label-inventory = インベントリ
gm-modal-placeholder-inventory-modify =
    アイテム名: 数量
    アイテム名2: 数量
    など
gm-modal-title-review-submission = 申請の確認
gm-modal-label-submission-id = 申請 ID
gm-modal-placeholder-submission-id = 8文字の ID を入力してください

# GM errors
gm-error-forbidden-role-name = パーティーロールに指定された名前は禁止されています。
gm-error-role-already-exists = その名前のロールはこのサーバーに既に存在します。
gm-error-no-quest-channel = Quest 投稿用のチャンネルがまだ設定されていません。サーバー管理者に Quest チャンネルの設定を依頼してください。
gm-error-cannot-ping-announce = チャンネル { $channel } で告知ロール { $role } をメンションできませんでした。チャンネルと ReQuest ロールの権限をサーバー管理者に確認してください。
gm-error-invalid-item-format = 無効なアイテム形式：「{ $item }」。各アイテムは新しい行に「名前: 数量」の形式で入力してください。
gm-error-submission-not-found = 申請が見つかりません。
gm-error-already-on-quest = あなたは既に { $characterName } としてこの Quest に参加しています。
gm-error-no-active-character-long = このサーバーで有効なキャラクターがいません。`/player` を使用してキャラクターを登録または有効化してください。
gm-error-quest-locked = Quest {"**"}{ $questTitle }{"**"} への参加エラー：Quest は GM によってロックされています。
gm-error-quest-full = Quest {"**"}{ $questTitle }{"**"} への参加エラー：Quest の定員が満員です！
gm-error-not-signed-up = あなたはこの Quest に登録されていません。
gm-error-quest-channel-not-set = Quest チャンネルが設定されていません！
gm-error-empty-roster = 空の名簿で Quest を完了することはできません。代わりにキャンセルしてください。
gm-error-invalid-xp-value = 経験値は正の整数でなければなりません！

# GM confirm modals
gm-modal-title-cancel-quest = Quest のキャンセル
gm-modal-label-cancel-quest = Quest をキャンセルするには CONFIRM と入力してください。
gm-modal-placeholder-cancel-quest = 続行するには「CONFIRM」と入力してください。
gm-modal-title-remove-from-quest = Quest からキャラクターを削除
gm-modal-label-remove-from-quest = キャラクターの削除を確認しますか？
gm-modal-placeholder-remove-from-quest = 続行するには「CONFIRM」と入力してください。

# GM DM messages
gm-dm-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} が GM によってキャンセルされました。
gm-dm-quest-ready = Quest {"**"}{ $questTitle }{"**"} の準備が整いました！
gm-dm-quest-unlocked = Quest {"**"}{ $questTitle }{"**"} のロックが解除されました。
gm-dm-quest-locked = Quest {"**"}{ $questTitle }{"**"} が GM によってロックされました。
gm-dm-player-removed = あなたは Quest {"**"}{ $questTitle }{"**"} から削除されました。
gm-dm-player-removed-waitlist = あなたは {"**"}{ $questTitle }{"**"} のウェイトリストから削除されました。
gm-dm-party-promotion = プレイヤーの離脱により、Quest {"**"}{ $questTitle }{"**"} のパーティーに追加されました！
gm-dm-roster-locked = Quest の名簿がロックされ、パーティーに通知されました！
gm-dm-roster-unlocked = Quest の名簿のロックが解除されました。
gm-dm-rewards-no-characters =
    サーバー管理者が Quest 完了時の GM 報酬を設定しています。
    ただし、登録されたキャラクターがいないため、報酬を
    自動的に付与することができませんでした。
gm-dm-rewards-no-active-character =
    サーバー管理者が Quest 完了時の GM 報酬を設定しています。
    ただし、このサーバーで有効なキャラクターがいないため、報酬を
    自動的に付与することができませんでした。
gm-dm-rewards-issued = 有効なキャラクター { $characterName } に以下が付与されました

# GM select menus
gm-select-placeholder-party-member = パーティーメンバーを選択

# GM embeds
gm-embed-title-mod-report = GM プレイヤー変更レポート
gm-embed-field-experience = 経験値
gm-embed-title-quest-complete = Quest 完了: { $questTitle }
gm-embed-title-quest-completed = QUEST 完了: { $questTitle }
gm-embed-field-rewards = 報酬
gm-embed-field-party = __パーティー__
gm-embed-field-summary = サマリー
gm-embed-title-gm-rewards = GM 報酬付与
gm-embed-field-items = アイテム
gm-msg-player-removed = プレイヤーが削除され、Quest の名簿が更新されました！

# GM views
gm-title-main-menu = GM - メインメニュー
gm-menu-quests = Quest
gm-menu-desc-quests = Quest の作成、編集、管理を行います。
gm-menu-players = プレイヤー
gm-menu-desc-players = プレイヤーのインベントリ管理とキャラクター変更を行います。
gm-menu-approvals = キャラクター承認
gm-menu-desc-approvals = キャラクター申請の確認と承認/却下を行います。

gm-title-quest-management = GM - Quest 管理
gm-desc-create-quest = 新しい Quest を作成します。
gm-msg-no-quests = Quest が見つかりません。
gm-label-quest-locked = （ロック中）
gm-title-manage-quest = Quest 管理 - { $questTitle } `{ $questId }`
gm-desc-edit-quest = タイトル、説明、パーティーサイズなどの Quest 詳細を編集します。
gm-desc-toggle-ready = 準備状態を切り替えます（現在: {"**"}{ $status }{"**"}）
    - Quest の名簿をロックし、パーティーメンバーに Quest がまもなく開始されることを通知します。ロールが設定されている場合、ロック時にパーティーメンバーに割り当てられます。
    - オープンに設定すると名簿のロックが解除されます。
gm-label-ready-locked = ロック済み/準備完了
gm-label-ready-open = オープン
gm-desc-configure-rewards = 選択した Quest の報酬を設定します。
gm-desc-complete-quest = Quest を完了します。報酬がある場合、パーティーメンバーに付与されます。
gm-desc-remove-player = Quest の名簿からプレイヤーを削除し、通知します。
gm-desc-cancel-quest = Quest をキャンセルし、Quest ボードから削除します。
gm-title-player-management = GM - プレイヤー管理
gm-desc-player-management =
    これらのコマンドはコンテキストメニューに移行しました。プレイヤーのプロフィールを右クリック（デスクトップ）または長押し（モバイル）して、以下のメニューオプションにアクセスしてください：

    - {"**"}Modify Player{"**"}: プレイヤーのアイテムや経験値を追加・削除します。
    - {"**"}View Player{"**"}: プレイヤーの有効なキャラクターの詳細を表示します。
gm-title-remove-player = Quest からプレイヤーを削除 - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}プレイヤー削除に関する注意事項{"**"}__

    - 以下のドロップダウンからプレイヤーを選択して、Quest の名簿から削除します。
    - ウェイトリストにプレイヤーがいる場合、リストの最初のプレイヤーがパーティーに昇格します。
    - 削除されたプレイヤーの個別報酬は Quest から削除されます。
    - 以前の貢献に対してプレイヤーに報酬を付与する場合は、`Modify Player` コンテキストメニューを使用して直接報酬を付与してください。
gm-label-no-players-in-roster = Quest の名簿にプレイヤーがいません
gm-title-character-sheet = { $characterName } のキャラクターシート (<@{ $memberId }>)
gm-label-experience-points = __{"**"}経験値:{"**"}__
gm-label-possessions = __{"**"}所持品{"**"}__
gm-label-currency-heading = {"**"}通貨{"**"}
gm-msg-inventory-empty = インベントリは空です。

# GM approvals
gm-title-approvals = GM - インベントリ承認
gm-desc-review-submission = 申請 ID を入力して確認・承認/却下します。
gm-title-reviewing = 確認中: { $characterName }
gm-label-items = {"**"}アイテム:{"**"}
gm-label-currency = {"**"}通貨:{"**"}
gm-embed-title-approved = インベントリ更新承認済み
gm-embed-desc-approved = {"**"}{ $characterName }{"**"} のインベントリが { $approver } によって承認されました。
gm-embed-title-denied = インベントリ更新却下
gm-embed-desc-denied = {"**"}{ $characterName }{"**"} のインベントリが { $denier } によって却下されました。
