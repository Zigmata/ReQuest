## Admin module strings

# Admin cog
admin-embed-title-unauthorized = Máy chủ chưa được ủy quyền
admin-embed-desc-unauthorized =
    Cảm ơn bạn đã quan tâm đến ReQuest! Máy chủ của bạn không nằm trong danh sách máy chủ thử nghiệm được ủy quyền của ReQuest.
    Vui lòng tham gia Discord hỗ trợ bên dưới và liên hệ đội ngũ phát triển để yêu cầu quyền truy cập thử nghiệm.

    [Discord phát triển ReQuest](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Các lệnh sau đã được đồng bộ với { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Các lệnh sau đã được đồng bộ toàn cầu
admin-error-missing-scope = ReQuest không có phạm vi quyền chính xác trong máy chủ mục tiêu. Thêm quyền `applications.commands` và thử lại.
admin-error-sync-failed = Đã xảy ra lỗi khi đồng bộ lệnh: { $error }
admin-msg-commands-cleared = Đã xóa lệnh.

# Admin buttons
admin-btn-shutdown = Tắt máy
admin-modal-title-confirm-shutdown = Xác nhận tắt máy
admin-modal-label-shutdown-warning = Cảnh báo! Thao tác này sẽ tắt bot. Nhập XÁC NHẬN để tiếp tục.
admin-msg-shutting-down = Đang tắt máy!
admin-btn-add-server = Thêm máy chủ mới
admin-btn-load-cog = Tải Cog
admin-msg-extension-loaded = Đã tải extension thành công: `{ $module }`
admin-btn-reload-cog = Tải lại Cog
admin-msg-extension-reloaded = Đã tải lại extension thành công: `{ $module }`
admin-btn-output-guilds = Xuất danh sách máy chủ
admin-msg-connected-guilds = Đang kết nối với { $count } máy chủ:

# Admin modals
admin-modal-title-add-server = Thêm ID máy chủ vào danh sách cho phép
admin-modal-label-server-name = Tên máy chủ
admin-modal-placeholder-server-name = Nhập tên ngắn gọn cho máy chủ Discord
admin-modal-label-server-id = ID máy chủ
admin-modal-placeholder-server-id = Nhập ID của máy chủ Discord
admin-select-placeholder-server = Chọn máy chủ để xóa
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = Tên
admin-modal-placeholder-cog-name = Nhập tên Cog để { $action }

# Admin views
admin-title-main-menu = Quản trị - Menu chính
admin-desc-allowlist = Cấu hình danh sách cho phép máy chủ cho các hạn chế mời.
admin-desc-cogs = Tải hoặc tải lại cog.
admin-desc-guild-list = Trả về danh sách tất cả máy chủ mà bot đang tham gia.
admin-desc-shutdown = Tắt bot
admin-title-allowlist = Quản trị - Danh sách cho phép máy chủ
admin-desc-allowlist-warning =
    Thêm ID máy chủ Discord mới vào danh sách cho phép.
    {"**"}CẢNH BÁO: Không có cách nào xác minh ID máy chủ cung cấp là hợp lệ nếu bot không phải thành viên máy chủ. Hãy kiểm tra kỹ thông tin nhập!{"**"}
admin-msg-no-servers = Không có máy chủ trong danh sách cho phép.

# Admin confirm modals
admin-modal-title-confirm-server-removal = Xác nhận xóa máy chủ
admin-modal-label-server-removal = Xóa máy chủ khỏi danh sách cho phép?

# Admin cog view
admin-title-cogs = Quản trị - Cog
admin-desc-load-cog = Tải cog bot theo tên. Tệp phải có tên `<name>.py` và được lưu trong ReQuest/cogs/.
admin-desc-reload-cog = Tải lại cog đã tải theo tên. Áp dụng cùng quy tắc tên và đường dẫn tệp.
