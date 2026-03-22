## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = クリア
config-btn-remove-gm-roles = GM ロールを削除
config-btn-forbidden-roles = 禁止ロール

# Quests
config-btn-toggle-quest-summary = Quest サマリーの切替
config-btn-toggle-player-experience = プレイヤー経験値の切替
config-btn-toggle-display = 表示の切替
config-btn-purge-player-board = プレイヤーボードの削除
config-btn-add-modify-rewards = 報酬の追加/変更

# Currency
config-btn-add-denomination = 額面を追加
config-btn-add-new-currency = 新しい通貨を追加
config-btn-remove-currency = 通貨を削除

# Shops - creation
config-btn-add-shop-wizard = ショップを追加（ウィザード）
config-btn-add-shop-json = ショップを追加（JSON）
config-btn-edit-shop-wizard = ショップを編集（ウィザード）
config-btn-edit-shop-json = ショップを編集（JSON）
config-btn-remove-shop = ショップを削除
config-btn-add-item = アイテムを追加
config-btn-edit-shop-details = ショップ詳細を編集
config-btn-download-json = JSON をダウンロード
config-btn-done-editing = 編集完了
config-btn-scan-server-configs = サーバー設定をスキャン
config-btn-re-scan = 再スキャン

# New character shop
config-btn-upload-json = JSON をアップロード
config-btn-configure-new-character-wealth = 新キャラクターの所持金を設定
config-btn-configure-new-character-shop = 新キャラクターショップを設定
config-btn-clear-shop = ショップをクリア
config-btn-configure-static-kits = スタティックキットを設定
config-btn-new-character-settings = 新キャラクター設定
config-btn-disabled-no-currency = 無効（通貨が未設定です）
config-btn-disabled-no-wealth = 無効（初期所持金が未設定です）

# Static kits
config-btn-create-new-kit = 新しいキットを作成
config-btn-delete-kit = キットを削除
config-btn-add-currency = 通貨を追加

# Roleplay
config-btn-toggle-rp-rewards = RP 報酬の切替
config-btn-clear-channels = チャンネルをクリア
config-btn-edit-settings = 設定を編集
config-btn-configure-rewards = 報酬を設定

# Stock
config-btn-stock-limits = 在庫制限
config-btn-set-limit = 制限を設定
config-btn-edit-limit = 制限を編集
config-btn-remove-limit = 制限を削除
config-btn-configure-restock-schedule = 補充スケジュールを設定
config-btn-back-to-shop-editor = ショップエディターに戻る

# Forum shop
config-btn-create-new-thread = 新しいスレッドを作成
config-btn-use-existing-thread = 既存のスレッドを使用

# Wizard
config-btn-quit = 終了
config-btn-configure-channels = チャンネルを設定
config-btn-configure-roles = ロールを設定
config-btn-configure-quests = Quest を設定
config-btn-configure-players = プレイヤーを設定
config-btn-configure-currency = 通貨を設定
config-btn-configure-rp-rewards = RP 報酬を設定
config-btn-configure-shops = ショップを設定
config-btn-new-char-setup = 新キャラ設定

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = ロール削除の確認
config-modal-title-confirm-removal = 削除の確認
config-modal-title-confirm-currency-removal = 通貨削除の確認
config-modal-title-confirm-shop-removal = ショップ削除の確認
config-modal-title-confirm-kit-deletion = キット削除の確認
config-modal-title-confirm-remove-stock-limit = 在庫制限削除の確認
config-modal-title-clear-shop = ショップクリアの確認

# Confirm modal prompt labels
config-modal-label-remove-role = { $roleName } を削除しますか？
config-modal-label-remove-denomination = { $denominationName } を削除しますか？
config-modal-label-remove-currency = { $currencyName } を削除しますか？
config-modal-label-shop-removal-warning = 警告：この操作は元に戻せません！
config-modal-label-kit-deletion-warning = 警告：元に戻せません！
config-modal-label-remove-stock-limit = 在庫制限を削除するには CONFIRM と入力してください
config-modal-label-clear-shop = このショップのすべてのアイテムをクリアしますか？
config-modal-placeholder-type-confirm = CONFIRM と入力

# Error messages from buttons
config-error-shop-data-not-found = エラー：そのショップのデータが見つかりません。
config-msg-shop-json-download = {"**"}{ $shopName }{"**"} の JSON 定義です。
config-msg-new-char-shop-json-download = 新キャラクターショップの JSON 定義です。
config-error-select-forum-first = まず Forum チャンネルを選択してください。
config-error-select-thread-first = まずスレッドを選択してください。

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = 新しい通貨を追加
config-modal-label-currency-name = 通貨名
config-error-currency-already-exists = { $name } という名前の通貨または額面は既に存在します！

# RenameCurrencyModal
config-modal-title-rename-currency = 通貨の名前変更
config-modal-label-new-currency-name = 新しい通貨名
config-error-currency-name-exists = 「{ $name }」という名前の通貨は既に存在します。
config-error-denomination-name-exists = 「{ $name }」という名前の額面は既に存在します。

# RenameDenominationModal
config-modal-title-rename-denomination = 額面の名前変更
config-modal-label-new-denomination-name = 新しい額面名

# AddCurrencyDenominationModal
config-modal-title-add-denomination = { $currencyName } の額面を追加
config-modal-label-denomination-name = 名前
config-modal-placeholder-denomination-name = 例: 銀貨
config-modal-label-denomination-value = 値
config-modal-placeholder-denomination-value = 例: 0.1
config-error-denomination-matches-currency = 新しい額面名はこのサーバーの既存の通貨名と一致できません！「{ $existingName }」という既存の通貨が見つかりました。
config-error-denomination-matches-denomination = 新しい額面名はこのサーバーの既存の額面名と一致できません！「{ $currencyName }」通貨の「{ $denominationName }」という既存の額面が見つかりました。
config-error-denomination-value-exists = 同じ通貨の額面にはそれぞれ固有の値が必要です！{ $denominationName } には既にこの値が割り当てられています。

# ForbiddenRolesModal
config-modal-title-forbidden-roles = 禁止ロール名
config-modal-label-names = 名前
config-modal-placeholder-names = カンマ区切りで名前を入力してください
config-msg-forbidden-roles-updated = 禁止ロールが更新されました！

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = プレイヤーボードの削除
config-modal-label-age = 経過日数
config-modal-placeholder-age = 保持する最大投稿経過日数（日単位）を入力してください
config-msg-posts-purged = { $days } 日以上前の投稿が削除されました！

# GMRewardsModal
config-modal-title-gm-rewards = GM 報酬の追加/変更
config-modal-label-experience = 経験値
config-modal-placeholder-enter-number = 数値を入力してください
config-modal-label-items = アイテム
config-modal-placeholder-items =
    名前: 数量
    名前2: 数量
    など
config-error-experience-invalid = 経験値は有効な整数でなければなりません（例: 2000）。
config-error-item-format-invalid = 無効なアイテム形式：「{ $item }」。各アイテムは新しい行に「名前: 数量」の形式で入力してください。

# ConfigShopDetailsModal
config-modal-title-shop-details = ショップ詳細の追加/編集
config-modal-label-shop-channel = チャンネルを選択
config-modal-placeholder-shop-channel = このショップのチャンネルを選択してください
config-modal-label-shop-name = ショップ名
config-modal-placeholder-shop-name = ショップの名前を入力してください
config-modal-label-shopkeeper-name = 店主名
config-modal-placeholder-shopkeeper-name = 店主の名前を入力してください
config-modal-label-shop-description = ショップの説明
config-modal-placeholder-shop-description = ショップの説明を入力してください
config-modal-label-shop-image-url = ショップ画像 URL
config-modal-placeholder-shop-image-url = ショップ画像の URL を入力してください
config-error-no-channel-selected = ショップのチャンネルが選択されていません。
config-error-shop-already-in-channel = 選択されたチャンネルには既にショップが登録されています。別のチャンネルを選択するか、既存のショップを編集してください。

# build_shop_header_view
config-label-shopkeeper = {"**"}店主:{"**"} { $name }
config-msg-use-shop-command = `/shop` コマンドを使用してアイテムを閲覧・購入できます。

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Forum スレッドショップを作成
config-modal-label-thread-name = スレッド名
config-modal-placeholder-thread-name = ショップスレッドの名前を入力してください
config-error-forum-not-found = 選択された Forum チャンネルが見つかりません。
config-error-shop-already-in-thread = このスレッドには既にショップが登録されています。新しいスレッドでは発生しないはずです。

# ConfigShopJSONModal
config-modal-title-add-shop-json = JSON で新しいショップを追加
config-modal-label-upload-json = ショップデータを含む .json ファイルをアップロードしてください
config-error-no-json-uploaded = ショップ用の JSON ファイルがアップロードされていません。
config-error-file-must-be-json = アップロードするファイルは JSON ファイル（.json）である必要があります。
config-error-invalid-json = 無効な JSON 形式: { $error }
config-error-json-validation-failed = JSON がスキーマに準拠していません: { $error }

# ShopItemModal
config-modal-title-shop-item = ショップアイテムの追加/編集
config-modal-label-item-name = アイテム名
config-modal-placeholder-item-name = アイテムの名前を入力してください
config-modal-label-item-description = アイテムの説明
config-modal-placeholder-item-description = アイテムの説明を入力してください
config-modal-label-item-quantity = アイテム数量
config-modal-placeholder-item-quantity = 1回の購入で販売される数量を入力してください
config-modal-label-item-costs = アイテムコスト
config-modal-placeholder-item-costs = 例: 10 gold + 5 silver\nまたは: 50 rep\n(+ でAND、改行でOR)
config-error-item-quantity-positive = アイテム数量は正の整数でなければなりません。
config-error-cost-format-invalid = オプション「{ $option }」のコスト形式が無効です。各コストには金額と通貨をスペースで区切って指定してください（例: 「10 gold」）。
config-error-cost-amount-invalid = 通貨「{ $currency }」の金額「{ $amount }」が無効です。金額は正の数値でなければなりません。
config-error-unknown-currency = 不明な通貨 `{ $currency }`。このサーバーで設定されている有効な通貨を使用してください。
config-error-item-already-exists = { $itemName } という名前のアイテムはこのショップに既に存在します。

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = JSON でショップを更新
config-modal-label-upload-new-json = 新しい JSON 定義をアップロード
config-error-no-file-uploaded = ファイルがアップロードされていません。
config-error-file-must-be-json-ext = ファイルは `.json` ファイルでなければなりません。
config-error-json-validation-message = JSON の検証に失敗しました: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = 新キャラクター装備の追加/編集
config-modal-placeholder-item-quantity-selection = 1回の選択で受け取る数量を入力してください
config-modal-label-item-cost = アイテムコスト
config-error-cost-format-short = 無効なコスト形式：「{ $component }」。「金額 通貨名」の形式で入力してください。
config-error-amount-invalid-short = 通貨「{ $currency }」の金額「{ $amount }」が無効です。
config-error-item-exists-new-char = { $itemName } という名前のアイテムは新キャラクターショップに既に存在します。

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = 新キャラクターショップをアップロード（JSON）
config-error-no-json-uploaded-short = JSON ファイルがアップロードされていません。
config-error-json-must-have-shopstock = JSON には「shopStock」配列が含まれている必要があります。
config-error-items-must-have-name-price = すべてのアイテムには「name」と「price」が必要です。

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = 新キャラクターの所持金を設定
config-modal-label-amount = 金額
config-modal-placeholder-amount = この通貨の金額を入力してください。
config-modal-placeholder-currency-name = このサーバーで定義されている通貨名を入力してください
config-error-no-currencies-configured = このサーバーには通貨が設定されていません。
config-error-currency-not-found = { $name } という名前の通貨または額面が見つかりません。有効な通貨を使用してください。

# CreateStaticKitModal
config-modal-title-create-kit = 新しいスタティックキットを作成
config-modal-label-kit-name = キット名
config-modal-placeholder-kit-name = 例: 戦士スターターキット
config-modal-label-description = 説明
config-modal-placeholder-kit-description = キットの説明（任意）
config-error-kit-name-exists = 「{ $kitName }」という名前のスタティックキットは既に存在します。別の名前を選択してください。

# StaticKitItemModal
config-modal-title-kit-item = キットアイテムの追加/編集
config-modal-placeholder-kit-item-quantity = キットに含めるこのアイテムの数量を入力してください

# StaticKitCurrencyModal
config-modal-title-kit-currency = キット通貨を追加
config-modal-placeholder-currency-eg = 例: ゴールド
config-modal-placeholder-amount-eg = 例: 100
config-error-amount-must-be-number = 金額は数値でなければなりません。
config-error-no-currencies-on-server = サーバーに通貨が設定されていません。
config-error-currency-not-found-short = 通貨「{ $currency }」が見つかりません。
config-error-denomination-not-found = 額面「{ $denomination }」が通貨設定に見つかりません。

# RoleplaySettingsModal
config-modal-title-rp-settings = ロールプレイ設定
config-modal-label-min-message-length = 最小メッセージ長（文字数）
config-modal-placeholder-min-message-length = メッセージが対象となるために必要な文字数。制限なしの場合は0
config-modal-label-cooldown = クールダウン（秒）
config-modal-placeholder-cooldown = メッセージを報酬対象としてカウントするまでの待機時間（秒）
config-modal-label-message-threshold = メッセージ閾値
config-modal-placeholder-message-threshold = 報酬をトリガーするために必要なメッセージ数
config-modal-label-frequency = 頻度（メッセージ数）
config-modal-placeholder-frequency = 報酬を獲得するために必要な対象メッセージ数
config-error-min-length-invalid = 最小メッセージ長は0以上の整数でなければなりません。
config-error-cooldown-invalid = クールダウンは0以上の整数でなければなりません。
config-error-threshold-invalid = メッセージ閾値は正の整数でなければなりません。
config-error-frequency-invalid = 頻度は正の整数でなければなりません。

# RoleplayRewardsModal
config-modal-title-rp-rewards = ロールプレイ報酬の設定
config-modal-label-items-name-quantity = アイテム（名前: 数量）
config-modal-label-currency-name-amount = 通貨（名前: 金額）
config-error-experience-non-negative = 経験値は0以上の整数でなければなりません。
config-error-item-quantity-positive-named = アイテム「{ $itemName }」の数量は正の整数でなければなりません。
config-error-currency-amount-positive = 通貨「{ $currencyName }」の金額は正の数値でなければなりません。

# SetItemStockModal
config-modal-title-stock-limit = 在庫制限: { $itemName }
config-modal-label-max-stock = 最大在庫数
config-modal-placeholder-max-stock = 最大在庫数を入力してください（例: 10）
config-modal-label-current-stock = 現在の在庫数
config-modal-placeholder-current-stock = 現在の利用可能な在庫数を入力してください
config-error-max-stock-positive = 最大在庫数は正の整数でなければなりません。
config-error-current-stock-non-negative = 現在の在庫数は0以上の整数でなければなりません。
config-error-current-exceeds-max = 現在の在庫数は最大在庫数を超えることはできません。
config-error-item-not-in-shop = アイテム「{ $itemName }」がショップに見つかりません。

# RestockScheduleModal
config-modal-title-restock-schedule = 補充スケジュールの設定
config-modal-label-schedule = スケジュール（hourly/daily/weekly/none）
config-modal-placeholder-schedule = hourly、daily、weekly、またはnoneを入力してください
config-modal-label-time = 時間（UTC で HH:MM）
config-modal-desc-current-time = 現在の時間: { $utcTime }
config-modal-placeholder-time = 例: 14:30（UTC 午後2時30分）
config-modal-label-day-of-week = 曜日（0=月、6=日）- weeklyのみ
config-modal-placeholder-day-of-week = 0-6を入力してください（月曜日=0、日曜日=6）
config-modal-label-mode = モード（full/incremental）
config-modal-placeholder-mode = full = 最大まで補充、incremental = 数量を加算
config-modal-label-increment = 追加数量（incrementalモード用）
config-modal-placeholder-increment = 補充サイクルごとに追加する数量
config-error-schedule-invalid = スケジュールは hourly、daily、weekly、または none のいずれかでなければなりません。
config-error-time-format-invalid = 時間は HH:MM 形式で入力してください（例: 14:30）。
config-error-day-of-week-invalid = 曜日は0-6でなければなりません（月曜日=0、日曜日=6）。
config-error-mode-invalid = モードは「full」または「incremental」でなければなりません。
config-error-increment-positive = 追加数量は正の整数でなければなりません。

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = { $configName } チャンネルを検索

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Quest 告知ロールを選択

# AddGMRoleSelect
config-select-placeholder-gm-roles = GM ロールを選択

# ConfigWaitListSelect
config-select-placeholder-wait-list = ウェイトリストのサイズを選択
config-select-option-disabled = 0（無効）

# InventoryTypeSelect
config-select-placeholder-inventory-mode = インベントリモードを選択
config-select-option-disabled-label = 無効
config-select-desc-disabled = プレイヤーは空のインベントリで開始します。
config-select-option-selection = セレクション
config-select-desc-selection = プレイヤーは新キャラクターショップから自由にアイテムを選択します。
config-select-option-purchase = パーチェス
config-select-desc-purchase = プレイヤーは所定の通貨で新キャラクターショップからアイテムを購入します。
config-select-option-open = オープン
config-select-desc-open = プレイヤーが自分のインベントリを手動で入力します。
config-select-option-static = スタティック
config-select-desc-static = プレイヤーに事前定義された初期インベントリが付与されます。

# RoleplayChannelSelect
config-select-placeholder-rp-channels = 対象チャンネルを選択

# RoleplayModeSelect
config-select-placeholder-rp-mode = モードを選択
config-select-option-scheduled = スケジュール
config-select-desc-scheduled = 指定されたリセット期間内に報酬が1回付与されます。
config-select-option-accrued = アキュムレーション
config-select-desc-accrued = 指定された活動レベルに基づいて報酬が繰り返し付与されます。

# RoleplayResetSelect
config-select-placeholder-reset-period = リセット期間を選択
config-select-option-hourly = 毎時
config-select-desc-hourly = 毎時間リセットされます。
config-select-option-daily = 毎日
config-select-desc-daily = 24時間ごとにリセットされます。
config-select-option-weekly = 毎週
config-select-desc-weekly = 7日ごとにリセットされます。

# RoleplayResetDaySelect
config-select-placeholder-reset-day = リセット曜日を選択

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = リセット時間を選択（UTC）
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Forum チャンネルを選択

# ForumThreadSelect
config-select-placeholder-thread = スレッドを選択
config-select-option-no-threads = アクティブなスレッドが見つかりません
config-select-desc-no-threads = 新しいスレッドを作成するか、アーカイブされたスレッドを確認してください
config-select-option-select-forum-first = まず Forum を選択してください
config-select-desc-select-forum-first = 上の Forum チャンネルを選択してください
config-select-desc-thread-id = スレッド ID: { $threadId }
config-error-select-valid-thread = 有効なスレッドを選択するか、新しいスレッドを作成してください。
config-error-thread-not-found = 選択されたスレッドが見つかりません。削除またはアーカイブされた可能性があります。

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = サーバー設定 - メインメニュー
config-menu-config-wizard = 設定ウィザード
config-menu-desc-config-wizard = クイックスキャンでサーバーが ReQuest を使用する準備ができているか検証します。
config-menu-channels = チャンネル
config-menu-desc-channels = ReQuest の投稿用チャンネルを設定します。
config-menu-currency = 通貨
config-menu-desc-currency = グローバル通貨設定です。
config-menu-players = プレイヤー
config-menu-desc-players = 経験値追跡などのグローバルプレイヤー設定です。
config-menu-quests = Quest
config-menu-desc-quests = ウェイトリストなどのグローバル Quest 設定です。
config-menu-rp-rewards = RP 報酬
config-menu-desc-rp-rewards = ロールプレイ報酬を設定します。
config-menu-roles = ロール
config-menu-desc-roles = メンション可能ロールや特権ロールの設定オプションです。
config-menu-shops = ショップ
config-menu-desc-shops = カスタムショップを設定します。
config-menu-language = 言語
config-menu-desc-language = このサーバーのデフォルト言語を設定します。

## Wizard View
config-title-wizard = {"**"}サーバー設定 - ウィザード{"**"}
config-wizard-intro =
    {"**"}ReQuest 設定ウィザードへようこそ！{"**"}

    このウィザードは、サーバーが ReQuest の機能を使用するために正しく設定されていることを確認するお手伝いをします。
    現在の設定をスキャンし、必要な調整についての推奨事項を提供します。

    以下の「スキャン開始」ボタンを使用して検証プロセスを開始してください。スキャンが完了すると、
    サーバー設定の詳細レポートと推奨される変更が表示されます。

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}ボットのグローバル権限{"**"}__
config-wizard-bot-permissions-desc = このセクションでは、ReQuest が正しく機能するために必要な権限を持っているか確認します。
config-wizard-bot-role = ボットロール: { $roleMention }
config-wizard-status-warnings = {"**"}ステータス: ⚠️ 警告あり{"**"}
config-wizard-missing-perm = - ⚠️ 不足: `{ $permissionName }`
config-wizard-ensure-permissions = ボットの最上位ロールにこれらの権限がグローバルに付与されていることを確認してください。
config-wizard-status-ok = {"**"}ステータス: ✅ OK{"**"}
config-wizard-bot-permissions-ok = ボットに必要なグローバル権限がすべて付与されています。
config-wizard-status-scan-failed = {"**"}ステータス: ❌ スキャン失敗{"**"}
config-wizard-scan-error = ボット権限の確認中に予期しないエラーが発生しました。
config-wizard-error-type = エラー: { $errorType }
config-wizard-required-permissions = {"**"}ボットロールに必要な権限:{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = チャンネルを見る
config-wizard-perm-manage-roles = ロールの管理
config-wizard-perm-send-messages = メッセージを送信
config-wizard-perm-attach-files = ファイルを添付
config-wizard-perm-add-reactions = リアクションの追加
config-wizard-perm-use-external-emoji = 外部の絵文字を使用
config-wizard-perm-manage-messages = メッセージの管理
config-wizard-perm-read-message-history = メッセージ履歴を読む

# Wizard - Role Validation
config-wizard-role-header = __{"**"}ロール設定{"**"}__
config-wizard-role-desc =
    このセクションでは以下を確認します：

    - GM ロール（必須）と告知ロール（任意）が設定されているか。
    - デフォルト（@everyone）ロールに、ユーザーがボット機能にアクセスするために必要な権限があるか。
    - デフォルト（@everyone）ロールに危険な権限が付与されていないか。
    - GM ロールと告知ロールに、デフォルトロールを超える権限エスカレーションがないか。

    ここでの警告はデフォルト設定に基づく推奨事項です。サーバーのニーズに応じて、一部の推奨事項を無視する理由がある場合もあります。

config-wizard-default-role-label = {"**"}デフォルトロール:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: 危険な権限が検出されました:
config-wizard-default-role-ok = - ✅ @everyone: OK
config-wizard-missing-permission = - 不足している権限: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}GM ロール:{"**"}
config-wizard-no-gm-roles = - ⚠️ GM ロールが設定されていません
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} 設定されたロールがサーバーで見つからない/削除されています
config-wizard-role-ok = - ✅ { $roleMention }: OK
config-wizard-announcement-role-label = {"**"}告知ロール:{"**"}
config-wizard-no-announcement-role = - ℹ️ 告知ロールが設定されていません
config-wizard-announcement-role-not-found = - ⚠️ 設定されたロールがサーバーで見つからない/削除されています
config-wizard-escalation-detected = - ⚠️ { $roleMention }: 権限エスカレーションが検出されました - { $escalations }
config-wizard-escalation-more = 、他 { $count } 件...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = スレッドでメッセージを送信
config-wizard-perm-use-application-commands = アプリケーションコマンドを使用

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = チャンネルの管理
config-wizard-perm-manage-webhooks = ウェブフックの管理
config-wizard-perm-manage-server = サーバーの管理
config-wizard-perm-manage-nicknames = ニックネームの管理
config-wizard-perm-kick-members = メンバーをキック
config-wizard-perm-ban-members = メンバーをBAN
config-wizard-perm-timeout-members = メンバーをタイムアウト
config-wizard-perm-mention-everyone = @everyoneにメンション
config-wizard-perm-manage-threads = スレッドの管理
config-wizard-perm-administrator = 管理者

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}チャンネル設定{"**"}__
config-wizard-channel-desc =
    このセクションでは以下を確認します：

    - 設定されたチャンネルが存在するか。
    - ボットが設定されたチャンネルを閲覧し、メッセージを送信する権限を持っているか。
    - デフォルト（@everyone）ロールに「メッセージを送信」権限が付与されていないか。

config-wizard-channel-no-config-required = - ⚠️ チャンネルが設定されていません
config-wizard-channel-not-configured = - ℹ️ 未設定（任意）
config-wizard-channel-not-found = - ⚠️ 設定されたチャンネルがサーバーで見つからない/削除されています
config-wizard-channel-ok = - ✅ OK
config-wizard-bot-cannot-view = - ⚠️ { $botMention } はこのチャンネルを閲覧できません。
config-wizard-bot-cannot-send = - ⚠️ { $botMention } はこのチャンネルでメッセージを送信できません。
config-wizard-everyone-can-send = - ⚠️ @everyone がこのチャンネルでメッセージを送信できます。

# Wizard - Channel names
config-wizard-channel-quest-board = Quest ボード
config-wizard-channel-player-board = プレイヤーボード
config-wizard-channel-quest-archive = Quest アーカイブ
config-wizard-channel-gm-transaction-log = GM 取引ログ
config-wizard-channel-player-transaction-log = プレイヤー取引ログ
config-wizard-channel-shop-log = ショップログ
config-wizard-channel-approval-queue = キャラクター承認キュー

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}設定ダッシュボード{"**"}__
config-wizard-dashboard-desc = このセクションでは、必須ではない設定の概要をクイックリファレンスとして提供します。
config-wizard-quest-settings = {"**"}Quest 設定{"**"}
config-wizard-quest-wait-list = - Quest ウェイトリストサイズ: { $size }
config-wizard-quest-summary = - Quest サマリー: { $status }
config-wizard-gm-rewards-per-quest = {"**"}GM 報酬（Quest あたり）{"**"}
config-wizard-player-settings = {"**"}プレイヤー設定{"**"}
config-wizard-player-experience = - プレイヤー経験値: { $status }
config-wizard-currency-settings = {"**"}通貨設定{"**"}
config-wizard-rp-rewards = {"**"}ロールプレイ報酬{"**"}
config-wizard-rp-status = - ステータス: { $status }
config-wizard-rp-mode = - モード: { $mode }
config-wizard-rp-channels = - 監視チャンネル数: { $count }
config-wizard-shops = {"**"}ショップ{"**"}
config-wizard-shops-count = - 設定済みショップ数: { $count }
config-wizard-shops-more = - ...他 { $count } 件
config-wizard-new-char-setup = {"**"}新キャラクター設定{"**"}
config-wizard-inventory-type = - インベントリタイプ: { $type }
config-wizard-new-char-shop-items = - 新キャラクターショップアイテム数: { $count }
config-wizard-static-kits = - スタティックキット数: { $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ 通貨が設定されていません
config-wizard-configured-currencies = {"**"}設定済み通貨:{"**"}
config-wizard-no-denominations = - 額面が設定されていません
config-wizard-gm-rewards-disabled = {"**"}ステータス:{"**"} 無効
config-wizard-gm-rewards-enabled = {"**"}ステータス:{"**"} 有効
config-wizard-gm-rewards-experience = - 経験値: { $xp }
config-wizard-gm-rewards-items = - アイテム:
config-wizard-unnamed-shop = 名前なしショップ

## Roles View
config-title-roles = {"**"}サーバー設定 - ロール{"**"}
config-label-announcement-role = {"**"}告知ロール:{"**"} { $status }
config-desc-announcement-role = Quest が投稿されたときにこのロールがメンションされます。
config-label-announcement-role-default = {"**"}告知ロール:{"**"} 未設定
config-label-gm-roles = {"**"}GM ロール:{"**"} { $roles }
config-desc-gm-roles = これらのロールは GM コマンドと機能へのアクセスを許可します。
config-label-gm-roles-default = {"**"}GM ロール:{"**"} 未設定
config-title-forbidden-roles = __{"**"}禁止ロール{"**"}__
config-desc-forbidden-roles =
    GM がパーティーロールに使用できないロール名のリストを設定します。
    デフォルトでは、`everyone`、`administrator`、`gm`、および `game master` は使用できません。この設定は
    そのリストを拡張します。

## GM Role Remove View
config-title-remove-gm-roles = {"**"}サーバー設定 - GM ロールの削除{"**"}
config-msg-no-gm-roles = GM ロールが設定されていません。

## Channels View
config-title-channels = {"**"}サーバー設定 - チャンネル{"**"}

config-label-quest-board = {"**"}Quest ボード:{"**"} { $channel }
config-desc-quest-board = 新しい/アクティブな Quest が投稿されるチャンネルです。
config-label-quest-board-default = {"**"}Quest ボード:{"**"} 未設定

config-label-player-board = {"**"}プレイヤーボード:{"**"} { $channel }
config-desc-player-board = プレイヤーが使用するオプションのお知らせ/メッセージボードです。
config-label-player-board-default = {"**"}プレイヤーボード:{"**"} 未設定

config-label-quest-archive = {"**"}Quest アーカイブ:{"**"} { $channel }
config-desc-quest-archive = 完了した Quest がサマリー情報とともに移動するオプションのチャンネルです。
config-label-quest-archive-default = {"**"}Quest アーカイブ:{"**"} 未設定

config-label-gm-transaction-log = {"**"}GM 取引ログ:{"**"} { $channel }
config-desc-gm-transaction-log = GM の取引（Modify Player コマンドなど）が記録されるオプションのチャンネルです。
config-label-gm-transaction-log-default = {"**"}GM 取引ログ:{"**"} 未設定

config-label-player-transaction-log = {"**"}プレイヤー取引ログ:{"**"} { $channel }
config-desc-player-transaction-log = トレードやアイテム消費などのプレイヤー取引が記録されるオプションのチャンネルです。
config-label-player-transaction-log-default = {"**"}プレイヤー取引ログ:{"**"} 未設定

config-label-shop-log = {"**"}ショップログ:{"**"} { $channel }
config-desc-shop-log = ショップ取引が記録されるオプションのチャンネルです。
config-label-shop-log-default = {"**"}ショップログ:{"**"} 未設定

## Quests View
config-title-quests = {"**"}サーバー設定 - Quest{"**"}

config-label-wait-list = {"**"}Quest ウェイトリストサイズ:{"**"} { $size }
config-desc-wait-list = ウェイトリストを設定すると、Quest が満員の場合に指定された人数のプレイヤーがキューに並ぶことができます。
config-label-wait-list-disabled = {"**"}Quest ウェイトリストサイズ:{"**"} 無効

config-label-quest-summary = {"**"}Quest サマリー:{"**"} { $status }
config-desc-quest-summary = このオプションを有効にすると、GM が Quest 完了時に短いサマリーを記入できます。
config-label-quest-summary-disabled = {"**"}Quest サマリー:{"**"} 無効

config-label-gm-rewards = GM 報酬
config-desc-gm-rewards = Quest 完了時に GM が受け取る報酬を設定します。

## GM Rewards View
config-title-gm-rewards = {"**"}サーバー設定 - GM 報酬{"**"}
config-desc-gm-rewards-detail =
    {"**"}報酬の追加/変更{"**"}
    入力モーダルを開いて GM 報酬を追加、変更、または削除します。

    > 設定された報酬は Quest ごとに適用されます。GM が Quest を完了するたびに、
    有効なキャラクターに以下の報酬が付与されます。
config-msg-no-rewards = 報酬が設定されていません。
config-label-gm-experience = {"**"}経験値:{"**"} { $xp }
config-label-gm-items = {"**"}アイテム:{"**"}

## Players View
config-title-players = {"**"}サーバー設定 - プレイヤー{"**"}

config-label-player-experience = {"**"}プレイヤー経験値:{"**"} { $status }
config-desc-player-experience = 経験値（または同様の数値ベースのキャラクター成長）の使用を有効/無効にします。
config-label-player-experience-disabled = {"**"}プレイヤー経験値:{"**"} 無効

config-label-new-char-settings = {"**"}新キャラクター設定{"**"}
config-desc-new-char-settings = 新規プレイヤーキャラクターと初期インベントリの設定に関する設定です。

config-label-player-board-purge = {"**"}プレイヤーボードの削除{"**"}
config-desc-player-board-purge = プレイヤーボード（有効な場合）から投稿を削除します。

## New Character Settings View
config-title-new-character = {"**"}サーバー設定 - 新キャラクター設定{"**"}

config-label-inventory-type = {"**"}新キャラクターインベントリタイプ:{"**"} { $type }
config-desc-inventory-type = 新しく登録されたキャラクターのインベントリの初期化方法を決定します。
config-label-inventory-type-disabled = {"**"}新キャラクターインベントリタイプ:{"**"} 無効

config-label-new-char-wealth = {"**"}新キャラクターの所持金:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}新キャラクターの所持金:{"**"} 無効

config-label-approval-queue = {"**"}承認キュー:{"**"} { $channel }
config-desc-approval-queue = 設定されている場合、新しいキャラクターはこの Forum チャンネルで GM の承認を受けてから有効になります。
config-label-approval-queue-disabled = {"**"}承認キュー:{"**"} 無効
config-label-approval-queue-not-configured = {"**"}承認キュー:{"**"} 未設定

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = プレイヤーは空のインベントリで開始します。
config-desc-inv-type-selection = プレイヤーは新キャラクターショップから自由にアイテムを選択します。
config-desc-inv-type-purchase = プレイヤーは所定の通貨で新キャラクターショップからアイテムを購入します。
config-desc-inv-type-open = プレイヤーがインベントリアイテムを手動で入力します。
config-desc-inv-type-static = プレイヤーに事前定義された初期インベントリが付与されます。

## New Character Shop View
config-title-new-char-shop = {"**"}サーバー設定 - 新キャラクターショップ{"**"}
config-label-inv-type-selection = {"**"}インベントリタイプ:{"**"} セレクション
config-desc-inv-type-selection-shop = プレイヤーは新キャラクターショップから自由にアイテムを選択します。
config-label-inv-type-purchase = {"**"}インベントリタイプ:{"**"} パーチェス
config-desc-inv-type-purchase-shop = プレイヤーは所定の通貨で新キャラクターショップからアイテムを購入します。
config-label-inv-type-other = {"**"}インベントリタイプ:{"**"} { $type }
config-desc-inv-type-not-in-use = 新キャラクターショップは使用されていません。
config-msg-define-shop-items = ショップアイテムを定義してください。
config-msg-no-items = アイテムが設定されていません。

## Static Kits View
config-title-static-kits = {"**"}サーバー設定 - スタティックキット{"**"}
config-desc-create-kit = 新しいキット定義を作成します。
config-msg-no-kits = キットが設定されていません。
config-label-kit-more-items = ...他 { $count } 個のアイテム
config-label-empty-kit = {"*"}空のキット{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}キット編集中: { $kitName }{"**"}
config-msg-kit-empty = このキットは空です。上のボタンを使用して通貨やアイテムを追加してください。
config-label-kit-currency = {"**"}通貨:{"**"} { $display }
config-label-kit-item = {"**"}アイテム:{"**"} { $name }

## Currency View
config-title-currency = {"**"}サーバー設定 - 通貨{"**"}
config-desc-create-currency = 新しい通貨を作成します。
config-msg-no-currencies = 通貨が設定されていません。
config-label-currency-display-type = 表示タイプ: { $type } | 額面数: { $count }
config-label-currency-type-double = 小数
config-label-currency-type-integer = 整数

## Edit Currency View
config-title-manage-currency = {"**"}通貨管理: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}通貨と額面{"**"}__
    - 通貨に付けた名前が基本通貨となり、値は1です。
    {"```"}例: 「ゴールド」を通貨として設定します。{"```"}
    - 額面を追加するには、名前と基本通貨に対する相対的な値を指定する必要があります。
    {"```"}例: ゴールドに2つの額面を設定: シルバー（値: 0.1）、コッパー（値: 0.01）。{"```"}
    - 基本通貨またはその額面を含む取引は自動的に変換されます。
    {"```"}例: プレイヤーが10ゴールドを持ち、3コッパーを使うと、残高は自動的に9ゴールド、9シルバー、7コッパーと表示されます。{"```"}
    - 整数表示の通貨は各額面を表示し、小数表示の通貨は基本通貨のみで表示されます。
    {"```"}例: 上記のプレイヤーの小数表示は 9.97 ゴールドとなります。{"```"}
config-btn-toggle-display-current = 表示切替（現在: { $type }）
config-msg-no-denominations = 額面が設定されていません。

## Shops View
config-title-shops = {"**"}サーバー設定 - ショップ{"**"}
config-desc-add-shop-wizard =
    {"**"}ショップを追加（ウィザード）{"**"}
    フォームから新しい空のショップを作成します。
config-desc-add-shop-json =
    {"**"}ショップを追加（JSON）{"**"}
    完全な JSON 定義を提供して新しいショップを作成します。（上級者向け）
config-btn-example-json = JSON サンプル
config-desc-example-json =
    {"**"}JSON サンプル{"**"}
    期待されるフォーマットを示すサンプルJSONファイルをダウンロードします。
config-msg-example-json = 期待されるフォーマットを示すサンプルJSONファイルです。
config-msg-no-shops = ショップが設定されていません。
config-label-shop-type-forum = （Forum）
config-label-shop-channel = チャンネル: <#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}ショップを追加 - 場所タイプを選択{"**"}
config-label-text-channel = {"**"}テキストチャンネル{"**"}
config-desc-text-channel = 通常のテキストチャンネルにショップを作成します。
config-label-forum-thread = {"**"}Forum スレッド{"**"}
config-desc-forum-thread = Forum スレッド（新規または既存）にショップを作成します。

## Forum Shop Setup View
config-title-forum-setup = {"**"}ショップを追加 - Forum スレッド設定{"**"}
config-label-step1 = {"**"}ステップ 1: Forum チャンネルを選択{"**"}
config-label-step2 = {"**"}ステップ 2: スレッドオプションを選択{"**"}
config-label-step3 = {"**"}ステップ 3: 既存のスレッドを選択{"**"}
config-desc-create-new-thread =
    {"**"}新しいスレッドを作成{"**"}
    フォームを開いて新しいスレッドを作成し、ショップを設定します。
config-label-selected-thread = {"**"}選択されたスレッド:{"**"} { $threadName }
config-desc-click-to-configure = クリックしてこのスレッドにショップを設定します。

## Manage Shop View
config-title-manage-shop = {"**"}ショップ管理: { $shopName }{"**"}
config-label-shop-type = {"**"}タイプ:{"**"} { $type }
config-label-shop-type-text = テキストチャンネル
config-label-shop-type-forum-thread = Forum スレッド
config-label-shopkeeper = {"**"}店主:{"**"} { $name }
config-label-shop-description = {"**"}説明:{"**"} { $description }
config-label-shop-channel-info = {"**"}チャンネル:{"**"} <#{ $channelId }>
config-desc-edit-wizard = ウィザードでショップの詳細とアイテムを編集します。
config-desc-upload-json = このショップの新しい JSON 定義をアップロードします。
config-desc-download-json = 現在の JSON 定義をダウンロードします。
config-desc-remove-shop = このショップを完全に削除します。

## Edit Shop View
config-title-editing-shop = {"**"}ショップ編集中: { $shopName }{"**"}
config-label-shop-shopkeeper = 店主: {"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}在庫設定: { $shopName }{"**"}
config-label-current-utc = 現在の UTC 時間: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}補充スケジュール:{"**"} { $schedule }
config-label-restock-hourly = 毎時 :{ $minute } 分
config-label-restock-daily = 毎日 { $time } UTC
config-label-restock-weekly = 毎週 { $day } { $time } UTC
config-label-restock-mode = {"**"}モード:{"**"} { $mode }
config-label-restock-full = 全補充
config-label-restock-incremental = サイクルごとに { $amount } 追加（最大まで）
config-label-restock-disabled = {"**"}補充スケジュール:{"**"} 無効
config-label-item-stock-limits = {"**"}アイテム在庫制限{"**"}
config-msg-no-items-in-shop = このショップにはアイテムがありません。
config-label-stock-with-available = 最大: { $max } | 在庫: { $available }
config-label-stock-reserved = | 予約済み: { $reserved }
config-label-stock-not-initialized = 最大: { $max } | 在庫:（未初期化）
config-label-stock-unlimited = 在庫: 無制限

## Roleplay View
config-title-roleplay = {"**"}サーバー設定 - ロールプレイ報酬{"**"}
config-label-rp-status = {"**"}ステータス:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}サーバー時間:{"**"} `{ $time }`
config-label-rp-enabled = 有効
config-label-rp-disabled = 無効

config-desc-rp-mode-scheduled = {"```"}指定された期間（毎時、毎日、または毎週）内に必要な閾値の対象メッセージを送信すると、報酬が1回配布されます。{"```"}
config-desc-rp-mode-accrued = {"```"}設定された数の対象メッセージを送信するたびに、報酬が繰り返し配布されます。{"```"}

config-label-rp-config-details = {"**"}設定の詳細:{"**"}
config-label-rp-mode = {"**"}モード:{"**"} { $mode }
config-label-rp-min-length = {"**"}最小メッセージ長:{"**"} { $length } 文字
config-label-rp-cooldown = {"**"}クールダウン:{"**"} { $seconds } 秒
config-label-rp-frequency-once = {"**"}頻度:{"**"} { $period }に1回
config-label-rp-reset-time = {"**"}リセット時間:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}閾値:{"**"} 対象メッセージ { $count } 件
config-label-rp-frequency-every = {"**"}頻度:{"**"} 対象メッセージ { $count } 件ごと

config-label-rp-channels = {"**"}ロールプレイチャンネル:{"**"}
config-msg-rp-no-channels = 設定されていません。
config-label-rp-channels-more = ...他 { $count } 件

config-label-rp-rewards = {"**"}報酬:{"**"}
config-msg-rp-no-rewards = 設定されていません。
config-label-rp-experience = {"**"}経験値:{"**"} { $xp }
config-label-rp-items = {"**"}アイテム:{"**"}
config-label-rp-currency = {"**"}通貨:{"**"}

## Language View
config-title-language = {"**"}サーバー設定 - 言語{"**"}
config-server-language-help =
    この設定では、このサーバーにおける ReQuest の{"**"}公開{"**"}応答やメッセージのデフォルト言語を指定できます。公開応答には以下が含まれます:
    - Quest およびプレイヤーボードの投稿
    - Quest サマリーとログチャンネルメッセージ
    - ショップの補充
    - プレイヤーのアイテム消費

    この設定はボットが生成する固定テキストにのみ影響し、ユーザーが入力したアイテム名や Quest の説明などの動的コンテンツは翻訳されません。

    個人的な応答やメニューはこの設定の影響を受けません。
config-label-server-language = {"**"}サーバー言語:{"**"} { $language }
config-label-server-language-default = {"**"}サーバー言語:{"**"} デフォルト（上書きなし）
config-select-placeholder-server-language = サーバー言語を選択
config-select-option-default = デフォルト（上書きなし）
config-select-desc-default = 各ユーザーの設定または Discord のロケールを使用します。

# Quest Roles
config-btn-quest-roles = Quest ロール
config-btn-manage-gm-quest-roles = 管理

config-modal-title-confirm-quest-role-removal = ロール削除の確認
config-modal-label-remove-quest-role = { $gmName } から { $roleName } を削除しますか？

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Quest ロールモードを選択
config-select-option-quest-role-disabled = 無効
config-select-desc-quest-role-disabled = ロールの作成や割り当ては行われません。
config-select-option-quest-role-temporary = 一時的
config-select-desc-quest-role-temporary = GM が Quest ごとに一時的なロールを作成できます。
config-select-option-quest-role-static = スタティック
config-select-desc-quest-role-static = GM が事前に割り当てられたサーバーロールから選択します。

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = この GM にサーバーロールを割り当て

## Quest Roles View
config-title-quest-roles = {"**"}サーバー設定 - Quest ロール{"**"}
config-label-quest-roles = Quest ロール
config-desc-quest-roles =
    Quest 中のパーティーロールの扱い方を設定します。

config-label-quest-role-mode-disabled = {"**"}Quest ロールモード:{"**"} 無効
    Quest 中にロールの作成や割り当ては行われません。
config-label-quest-role-mode-temporary = {"**"}Quest ロールモード:{"**"} 一時的
    GM が Quest 作成時に一時的なロールを任意で作成できます。
    Quest が完了またはキャンセルされるとロールは削除されます。
config-label-quest-role-mode-static = {"**"}Quest ロールモード:{"**"} スタティック
    GM が事前に割り当てられたサーバーロールから選択します。ロールは Quest 中に
    パーティーメンバーに割り当てられますが、削除されることはありません。

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}サーバー設定 - スタティック Quest ロールの割り当て{"**"}
config-label-manage-assignments = ロール割り当ての管理
config-desc-manage-assignments =
    Quest 中に使用するために既存のサーバーロールを GM に割り当てます。
    ロールはサーバー階層で ReQuest の最上位ロールより下位である必要があります。
config-msg-no-gm-members = このサーバーに GM ロールを持つメンバーが見つかりません。
config-label-no-roles-assigned = Quest ロールが割り当てられていません

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}Quest ロールの管理 — { $gmName }{"**"}
config-error-unmanageable-roles = 以下のロールは、インテグレーションによって管理されている、デフォルトロールである、または ReQuest の最上位ロールより上位にあるため割り当てできません: { $roles }
config-error-quest-role-limit = この GM は Quest ロールの最大割り当て数 { $limit } に達しています。
config-label-quest-role-count = 割り当て済みロール: { $count }/{ $limit }
