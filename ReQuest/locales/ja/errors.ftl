## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ エラー！
error-report-description =
    { $exception }

    このエラーが予期しないものである場合、またはボットが正しく動作していないと思われる場合は、[公式 ReQuest サポート Discord](https://discord.gg/Zq37gj4) でバグレポートを送信してください。

error-report-unexpected =
    予期しないエラーが発生しました。もう一度お試しください。

    この問題が続く場合は、[公式 ReQuest サポート Discord](https://discord.gg/Zq37gj4) でバグレポートを送信してください。

error-invalid-image-url =
    1つ以上の画像URLが無効です。Discordでは、`http://` または `https://` で始まり、画像を直接指す完全なリンクが必要です（例: `https://example.com/banner.png`）。

    クエストを編集して有効な画像URLを入力するか、フィールドを空欄のままにしてください。
error-invalid-image-url-field = { $fieldName } のURLが無効です。`http://` または `https://` で始まる完全なリンクを入力するか、空欄のままにしてください。
error-field-thumbnail = サムネイル画像
error-field-large-image = 大きな画像

# Check failures
error-owner-only = このコマンドはボットオーナーのみが使用できます！
error-no-permission = このコマンドを実行する権限がありません！
error-no-active-character = このサーバーで有効なキャラクターがいません！
error-no-registered-characters = 登録されたキャラクターがいません！
error-no-characters = 対象プレイヤーには登録されたキャラクターがいません。
error-no-active-character-target = 対象プレイヤーにはこのサーバーで有効なキャラクターがいません。
error-player-not-found = プレイヤーデータが見つかりません。
error-character-not-found = キャラクターデータが見つかりません。

# Currency/transaction errors
error-transaction-cannot-complete = 取引を完了できません：
    { $reason }
error-insufficient-item-trade = { $itemName } を { $owned } 個所持していますが、{ $quantity } 個渡そうとしています。
error-currency-process-failed = 通貨 { $currencyName } を処理できませんでした。
error-insufficient-funds-transaction = この取引に必要な資金が不足しています。
error-insufficient-funds = 資金が不足しています。
error-insufficient-items = アイテムが不足しています: { $itemName }
error-currency-not-configured = 通貨「{ $currencyName }」はこのサーバーで設定されていません。
error-cost-currency-system-mismatch = コスト通貨「{ $currencyName }」はその通貨システムに含まれていません。
error-currency-config-error = 通貨設定エラー：0または負の額面値です。
error-currency-validation = 通貨の検証中にエラーが発生しました: { $error }
error-invalid-currency = { $itemName } は有効な通貨ではありません。
error-insufficient-funds-for-transaction = この取引に必要な資金が不足しています。

# Cart errors
error-cart-not-found = カートが見つかりません。
error-item-not-in-cart = カートにそのアイテムがありません。
error-not-enough-stock = 在庫が不足しています。

# Container errors
error-container-not-found = コンテナが見つかりません。
error-container-name-empty = コンテナ名を空にすることはできません。
error-container-name-too-long = コンテナ名は { $maxLength } 文字以内にしてください。
error-max-containers-reached = コンテナは { $maxContainers } 個まで作成できます。
error-container-name-exists = 「{ $containerName }」という名前のコンテナは既に存在します。
error-item-already-in-container = アイテムは既にこのコンテナにあります。
error-quantity-minimum = 数量は1以上にしてください。
error-source-container-not-found = 移動元のコンテナが見つかりません。
error-item-not-in-source = アイテム「{ $itemName }」が移動元のコンテナに見つかりません。
error-insufficient-quantity-in-container = 数量が不足しています。このコンテナには { $available } 個あります。
error-dest-container-not-found = 移動先のコンテナが見つかりません。
error-item-not-in-container = アイテム「{ $itemName }」がこのコンテナに見つかりません。
error-insufficient-quantity-consume = このコンテナにはこのアイテムが { $available } 個しかありません。
