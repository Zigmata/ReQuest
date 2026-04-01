## Player module strings

# --- Cog ---

player-cmd-name = トレード
player-cmd-desc = プレイヤーメニュー

# --- Buttons ---

# Character management
player-btn-register-character = 新しいキャラクターを登録
player-btn-activate = 有効化
player-btn-active = 有効

# Player board
player-btn-create-post = 投稿を作成
player-btn-open-starting-shop = スターティングショップを開く
player-btn-select-kit = キットを選択
player-btn-input-inventory = インベントリを入力

# Wizard / shop buttons
player-btn-add-to-cart = カートに追加
player-btn-add-to-cart-cost = カートに追加（{ $costString }）
player-btn-view-purchase-options = 購入オプションを表示
player-btn-review-submit = 確認して送信（{ $count }）
player-btn-submit-character = キャラクターを送信
player-btn-keep-shopping = 買い物を続ける
player-btn-edit-quantity = 数量を変更
player-btn-clear-cart = カートをクリア

# Kit buttons
player-btn-confirm-selection = 選択を確定
player-btn-back-to-kits = キットに戻る

# Inventory management
player-btn-spend-currency = 通貨を使う
player-btn-print-inventory = インベントリを印刷

# Container management
player-btn-manage-containers = コンテナを管理
player-btn-create-new = ＋ 新規作成
player-btn-consume-destroy = 消費/破棄
player-btn-move = 移動
player-btn-move-all = すべて移動
player-btn-move-some = 一部を移動...
player-btn-back-to-overview = ← 概要に戻る
player-btn-cancel-move = ← キャンセル
player-btn-up = ▲ 上へ
player-btn-down = ▼ 下へ

# --- Modals ---

# Trade modal
player-modal-title-trade = { $targetName } とのトレード
player-modal-label-trade-name = 名前
player-modal-placeholder-trade-name = トレードするアイテムの名前を入力してください
player-modal-label-trade-quantity = 数量
player-modal-placeholder-trade-quantity = トレードする数量を入力してください

# Character register modal
player-modal-title-register = 新しいキャラクターを登録
player-modal-label-char-name = 名前
player-modal-placeholder-char-name = キャラクターの名前を入力してください。
player-modal-label-char-note = メモ
player-modal-placeholder-char-note = キャラクターを識別するためのメモを入力してください

# Open inventory input modal
player-modal-title-starting-inventory = 初期インベントリの入力
player-modal-label-inventory = インベントリ
player-modal-placeholder-inventory-input =
    1行に1つずつ <名前>: <数量> の形式で入力してください。例:
    剣: 1
    gold: 30

# Spend currency modal
player-modal-title-spend-currency = 通貨を使う
player-modal-label-currency-name = 通貨名
player-modal-placeholder-currency-name = 使用する通貨の名前を入力してください
player-modal-label-currency-amount = 金額
player-modal-placeholder-currency-amount = 使用する金額を入力してください

# Create player post modal
player-modal-title-create-post = プレイヤーボード投稿を作成
player-modal-label-post-title = タイトル
player-modal-placeholder-post-title = 投稿のタイトルを入力してください
player-modal-label-post-content = 投稿内容
player-modal-placeholder-post-content = 投稿の本文を入力してください

# Edit player post modal
player-modal-title-edit-post = プレイヤーボード投稿を編集

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = カート数量を変更
player-modal-label-cart-qty = 数量
player-modal-placeholder-cart-qty = 新しい数量を入力してください（0で削除）

# Create container modal
player-modal-title-create-container = 新しいコンテナを作成
player-modal-label-container-name = コンテナ名
player-modal-placeholder-container-name = コンテナの名前を入力してください（例: バックパック）

# Rename container modal
player-modal-title-rename-container = コンテナの名前変更
player-modal-label-new-container-name = 新しいコンテナ名
player-modal-placeholder-new-container-name = 新しい名前を入力してください

# Consume from container modal
player-modal-title-consume = アイテムの消費/破棄
player-modal-label-consume-qty = 数量（最大: { $maxQuantity }）
player-modal-placeholder-consume-qty = 消費/破棄する数量を入力してください

# Move item quantity modal
player-modal-title-move-item = アイテムを移動
player-modal-label-move-qty = 移動する数量（最大: { $maxQuantity }）
player-modal-placeholder-move-qty = 移動する数量を入力してください

# --- Selects ---

player-select-placeholder-no-characters = 登録されたキャラクターがいません
player-select-placeholder-remove-character = 削除するキャラクターを選択
player-select-placeholder-post = 投稿を選択
player-select-placeholder-container-view = 表示するコンテナを選択...
player-select-placeholder-item = アイテムを選択...
player-select-placeholder-destination = 移動先を選択...
player-select-placeholder-container = コンテナを選択...
player-select-option-no-containers = コンテナなし
player-select-option-no-items = アイテムなし
player-select-option-no-destinations = 移動先なし

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}プレイヤーコマンド - メインメニュー{"**"}
player-menu-btn-characters = キャラクター
player-menu-desc-characters = プレイヤーキャラクターの登録、閲覧、有効化を行います。
player-menu-btn-inventory = インベントリ
player-menu-desc-inventory = 有効なキャラクターのインベントリを閲覧し、通貨を使用します。
player-menu-btn-player-board = プレイヤーボード
player-menu-btn-player-board-disabled = プレイヤーボード（未設定）
player-menu-desc-player-board = プレイヤーボードに投稿を作成します

# CharacterBaseView
player-title-characters = {"**"}プレイヤーコマンド - キャラクター{"**"}
player-desc-register-character = 新しいキャラクターを登録します。
player-msg-no-characters = 登録されたキャラクターがいません。
player-label-active = （有効）
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}作成中のキャラクター: { $characterName }{"**"}
    キャラクター登録はインベントリの設定を待っています。
player-btn-resume = 再開
player-btn-discard = 破棄
player-modal-title-discard-character = キャラクター破棄
player-modal-label-discard-confirm = { $characterName } を破棄しますか？

# Confirm character removal
player-modal-title-confirm-char-removal = キャラクター削除の確認
player-modal-label-confirm-char-delete = { $characterName } を削除しますか？

# Confirm post removal
player-modal-title-confirm-post-removal = 投稿削除の確認
player-modal-label-post-removal-warning = 警告：この操作は元に戻せません！

# InventoryOverviewView
player-title-inventory = {"**"}プレイヤーコマンド - インベントリ{"**"}
player-title-char-inventory = {"**"}{ $characterName } のインベントリ{"**"}
player-msg-no-active-character = 有効なキャラクターなし：このサーバーでキャラクターを有効化してからこのメニューを使用してください。
player-msg-no-characters-registered = キャラクターなし：キャラクターを登録してからこのメニューを使用してください。
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } 個のアイテム
player-label-currency = {"**"}通貨{"**"}
player-msg-inventory-empty = インベントリは空です。

# Print inventory embed
player-embed-title-inventory = { $characterName } のインベントリ

# ContainerItemsView
player-msg-container-empty = このコンテナは空です。
player-label-selected-item = 選択中: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}「{ $itemName }」を移動{"**"}（{ $available } 個利用可能）
player-msg-no-other-containers = 他に利用可能なコンテナがありません。
player-msg-select-destination = 移動先のコンテナを選択してください:
player-label-destination = 移動先: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}コンテナ管理{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } 個のアイテム){ $suffix }
player-label-default-suffix = { " " }（デフォルト）
player-msg-no-containers = コンテナがありません。
player-label-selected-container = 選択中: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = コンテナ削除の確認
player-modal-label-container-has-items = { $itemCount } 個のアイテムがあります。未整理アイテムに移動されます。
player-modal-label-confirm-container-delete = 「{ $containerName }」を削除しますか？

# Container errors
player-error-cannot-rename-loose = 未整理アイテムの名前は変更できません。
player-error-cannot-delete-loose = 未整理アイテムは削除できません。

# PlayerBoardView
player-title-player-board = {"**"}プレイヤーコマンド - プレイヤーボード{"**"}
player-desc-create-post = プレイヤーボードに新しい投稿を作成します。
player-msg-no-posts = 現在の投稿がありません。
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = 作成者
player-embed-footer-post-id = 投稿 ID: { $postId }
player-error-board-channel-not-found = プレイヤーボードチャンネルが見つかりません。

# NewCharacterWizardView
player-title-setup-inventory = {"**"}{ $characterName } のインベントリ設定{"**"}
player-desc-browse-shop = スターティングショップを閲覧してキャラクターを装備します。
player-desc-select-kit = スターティングキットを選択します。
player-desc-input-inventory = 初期インベントリを手動で入力します。

# StaticKitSelectView
player-title-select-kit = {"**"}{ $characterName } のキットを選択{"**"}
player-msg-no-kits = 利用可能なスターティングキットがありません。
player-label-and-more-items = ...他 { $count } 個のアイテム
player-label-empty-kit = {"*"}空のキット{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}選択の確認: { $kitName }{"**"}
player-label-items-heading = {"**"}アイテム:{"**"}
player-label-currency-heading = {"**"}通貨:{"**"}
player-msg-kit-empty = このキットは空です。

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}購入オプション: { $itemName }{"**"}
player-msg-no-cost-options = このアイテムには利用可能な購入オプションがありません。
player-label-cost-option = {"**"}オプション { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}スターティングショップ（{ $inventoryType }）{"**"}
player-label-starting-wealth = 初期所持金: { $formattedCurrency }
player-label-in-cart = {"**"}(カート内: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}カートの確認{"**"}
player-msg-cart-empty = カートは空です。
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = （合計: { $totalQuantity }）
player-label-insufficient-currency = { $currencyName } が不足しています
player-label-total-cost = {"**"}合計コスト:{"**"}
player-label-total-cost-free = {"**"}合計コスト:{"**"} 無料
player-label-cart-page = ページ { $current } / { $total }

# Trade embed
player-embed-title-trade = トレードレポート
player-embed-desc-trade-sender = 送信者: { $senderMention }（{ $senderCharacter }）
player-embed-desc-trade-recipient = 受信者: { $recipientMention }（{ $recipientCharacter }）
player-embed-field-currency = 通貨
player-embed-field-amount = 金額
player-embed-field-balance = { $characterName } の残高
player-embed-field-item = アイテム
player-embed-field-quantity = 数量
player-embed-footer-transaction-id = 取引 ID: { $transactionId }

# Trade errors
player-error-trade-no-characters = トレード相手にはキャラクターがいません！
player-error-trade-no-active = トレード相手にはこのサーバーで有効なキャラクターがいません！

# Spend currency embed
player-embed-title-spend = プレイヤー取引レポート
player-embed-desc-spend-player = プレイヤー: { $playerMention }（{ $characterName }）
player-embed-desc-spend-transaction = 取引: {"**"}{ $characterName }{"**"} が {"**"}{ $formattedAmount }{"**"} を使用しました。
player-embed-field-channel = チャンネル
player-embed-field-receipt = レシート

# Spend currency errors
player-error-amount-not-number = 金額は数値でなければなりません。
player-error-amount-positive = 正の金額を使用してください。
player-error-amount-exceeds-maximum = 金額は { $max } を超えることはできません。
player-error-no-active-character-server = このサーバーで有効なキャラクターがいません。
player-error-no-currency-config = このサーバーの通貨設定が見つかりません。

# Consume item embed
player-embed-title-consume = アイテム消費レポート
player-embed-desc-consume = プレイヤー: { $playerMention }（{ $characterName }）
player-embed-desc-consume-removed = 削除: {"**"}{ $containerName }{"**"} から {"**"}{ $quantity }x { $itemName }{"**"}

# Consume item errors
player-error-qty-positive-integer = 数量は正の整数でなければなりません。
player-error-qty-at-least-one = 数量は1以上でなければなりません。
player-error-qty-only-have = このアイテムは { $maxQuantity } 個しか所持していません。

# Inventory input errors
player-error-invalid-format = 無効な形式：「{ $line }」。<名前>: <数量> の形式で入力してください。
player-error-empty-name = 行「{ $line }」でアイテム名が空です。
player-error-invalid-quantity = 「{ $name }」の数量「{ $quantity }」が無効です。正の整数でなければなりません。
player-error-input-errors-header = インベントリ入力のエラー:
player-msg-no-valid-items = 有効なアイテムが入力されていません。空のインベントリで初期化します。

# Cart quantity validation
player-error-enter-valid-number = 有効な正の数値を入力してください。

# Submission embeds (approval queue)
player-embed-title-approval = インベントリ承認: { $characterName }
player-embed-desc-submitted-by = 申請者: { $userMention }
player-embed-field-items = アイテム
player-embed-field-currency-received = 通貨
player-embed-footer-submission-id = 申請 ID: { $submissionId }
player-label-approval-thread = 承認: { $characterName }
player-embed-title-submission-sent = インベントリ申請送信済み
player-embed-desc-submission-sent =
    {"**"}{ $characterName }{"**"} の申請が GM チームに送信されました！
    確認が完了次第、通知されます。
    [申請スレッドを表示]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = 初期インベントリ適用済み
player-embed-desc-starting-inventory = プレイヤー: { $playerMention }（{ $characterName }）
player-embed-field-items-received = 受け取ったアイテム
player-embed-field-currency-received-label = 受け取った通貨
player-label-untitled = 無題

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventory Submission: { $characterName }{"**"}
    Submitted by { $userMention }
player-approval-post-items = アイテム
player-approval-post-currency = 通貨
player-approval-resolved = この申請は処理済みです。
player-approval-btn-approve = 承認
player-approval-btn-deny = 拒否
player-approval-btn-edit = 編集
player-approval-error-no-permission = この操作を行う権限がありません。
player-approval-error-not-submitter = 元の提出者のみがこの申請を編集できます。
player-approval-thread-instructions =
    This thread was created for the approval of a character's starting inventory.
    A Game Master will review the submission and approve or deny it.
    The submitting player may use the Edit button to modify and re-submit.
    Once approved or denied, this thread will be locked.
player-msg-submission-updated = 申請が更新されました。

# Approval DM notifications
player-dm-title-approved = キャラクター承認
player-dm-desc-approved =
    Your character {"**"}{ $characterName }{"**"} has been approved
    by { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = キャラクター拒否
player-dm-desc-denied =
    Your character {"**"}{ $characterName }{"**"} has been denied
    by { $denier } in {"**"}{ $guildName }{"**"}. You may re-submit.
