## Admin module strings

# Admin cog
admin-embed-title-unauthorized = 未認可サーバー
admin-embed-desc-unauthorized =
    ReQuest にご興味をお持ちいただきありがとうございます！お使いのサーバーは ReQuest の認可テストサーバーリストに含まれていません。
    以下のサポート Discord にご参加いただき、開発チームにテストアクセスをリクエストしてください。

    [ReQuest 開発 Discord](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = 以下のコマンドが { $guildName }（ID: { $guildId }）に同期されました
admin-embed-title-sync-global = 以下のコマンドがグローバルに同期されました
admin-error-missing-scope = 対象ギルドで ReQuest に正しいスコープが設定されていません。`applications.commands` 権限を追加して再試行してください。
admin-error-sync-failed = コマンドの同期中にエラーが発生しました: { $error }
admin-msg-commands-cleared = コマンドがクリアされました。

# Admin buttons
admin-btn-shutdown = シャットダウン
admin-modal-title-confirm-shutdown = シャットダウンの確認
admin-modal-label-shutdown-warning = 警告！ボットがシャットダウンします。続行するには 確認 と入力してください。
admin-msg-shutting-down = シャットダウン中です！
admin-btn-add-server = 新しいサーバーを追加
admin-btn-load-cog = Cogを読み込む
admin-msg-extension-loaded = 拡張機能が正常に読み込まれました: `{ $module }`
admin-btn-reload-cog = Cogを再読み込み
admin-msg-extension-reloaded = 拡張機能が正常に再読み込みされました: `{ $module }`
admin-btn-output-guilds = ギルドリストを出力
admin-msg-connected-guilds = { $count } 個のギルドに接続中:

# Admin modals
admin-modal-title-add-server = 許可リストにサーバー ID を追加
admin-modal-label-server-name = サーバー名
admin-modal-placeholder-server-name = Discord サーバーの短い名前を入力してください
admin-modal-label-server-id = サーバー ID
admin-modal-placeholder-server-id = Discord サーバーの ID を入力してください
admin-select-placeholder-server = 削除するサーバーを選択
admin-modal-title-cog-action = Cogを{ $action }
admin-modal-label-cog-name = 名前
admin-modal-placeholder-cog-name = { $action }する Cog の名前を入力してください

# Admin views
admin-title-main-menu = 管理 - メインメニュー
admin-desc-allowlist = 招待制限用のサーバー許可リストを設定します。
admin-desc-cogs = Cog の読み込みまたは再読み込みを行います。
admin-desc-guild-list = ボットが参加しているすべてのギルドのリストを返します。
admin-desc-shutdown = ボットをシャットダウンします
admin-title-allowlist = 管理 - サーバー許可リスト
admin-desc-allowlist-warning =
    新しい Discord サーバー ID を許可リストに追加します。
    {"**"}警告：ボットがサーバーメンバーでない限り、入力されたサーバー ID が有効かどうかを確認する方法はありません。入力内容を再確認してください！{"**"}
admin-msg-no-servers = 許可リストにサーバーがありません。

# Admin confirm modals
admin-modal-title-confirm-server-removal = サーバー削除の確認
admin-modal-label-server-removal = サーバーを許可リストから削除しますか？

# Admin cog view
admin-title-cogs = 管理 - Cog
admin-desc-load-cog = 名前で Cog を読み込みます。ファイルは `<name>.py` という名前で ReQuest/cogs/ に配置されている必要があります。
admin-desc-reload-cog = 名前で読み込み済みの Cog を再読み込みします。同じ命名規則とファイルパスの制限が適用されます。
