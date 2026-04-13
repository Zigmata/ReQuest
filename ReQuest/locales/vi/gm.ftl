## Game Master module strings

# GM buttons
gm-btn-create = Tạo
gm-btn-edit-details = Sửa Quest
gm-btn-toggle-ready = Bật/Tắt sẵn sàng
gm-btn-configure-rewards = Cấu hình phần thưởng
gm-btn-remove-player = Xóa người chơi
gm-btn-cancel-quest = Hủy Quest
gm-btn-manage-party-rewards = Quản lý phần thưởng đội hình
gm-btn-manage-individual-rewards = Quản lý phần thưởng cá nhân
gm-btn-join = Tham gia
gm-btn-leave = Rời đi
gm-btn-complete-quest = Hoàn thành Quest
gm-btn-edit-details-modal = Sửa chi tiết
gm-btn-edit-images = Sửa hình ảnh
gm-select-placeholder-party-role = Chọn vai trò đội hình...
gm-modal-title-edit-details = Sửa chi tiết Quest
gm-modal-title-edit-images = Sửa hình ảnh Quest
gm-btn-publish = Đăng
gm-btn-update-post = Cập nhật bài đăng

# GM modals
gm-modal-title-create-quest = Tạo Quest mới
gm-modal-label-quest-title = Tiêu đề Quest
gm-modal-placeholder-quest-title = Tiêu đề quest của bạn
gm-modal-label-restrictions = Giới hạn
gm-modal-placeholder-restrictions = Giới hạn, nếu có, như cấp độ người chơi
gm-modal-label-max-party = Số lượng đội hình tối đa
gm-modal-placeholder-max-party = Số lượng tối đa đội hình cho quest này
gm-modal-label-party-role = Vai trò đội hình
gm-modal-placeholder-party-role = Tạo vai trò cho quest này (Tùy chọn)
gm-modal-label-description = Mô tả
gm-modal-placeholder-description = Viết chi tiết quest của bạn tại đây
gm-modal-label-image-url = URL hình thu nhỏ
gm-modal-label-large-image-url = URL hình ảnh lớn
gm-modal-placeholder-image-url = Nhập URL hình ảnh (hoặc để trống để xóa)
gm-modal-title-add-reward = Thêm phần thưởng
gm-modal-label-experience = Điểm kinh nghiệm
gm-modal-placeholder-experience = Nhập một số
gm-modal-label-items = Vật phẩm
gm-modal-placeholder-items =
    vật phẩm: số lượng
    vật phẩm2: số lượng
    v.v.
gm-modal-title-add-summary = Thêm tóm tắt Quest
gm-modal-label-summary = Tóm tắt
gm-modal-placeholder-summary = Thêm tóm tắt câu chuyện của quest
gm-modal-title-modifying-player = Đang chỉnh sửa { $playerName }
gm-modal-placeholder-xp-add-remove = Nhập số dương hoặc âm.
gm-modal-label-inventory = Kho đồ
gm-modal-placeholder-inventory-modify =
    vật phẩm: số lượng
    vật phẩm2: số lượng
    v.v.

# GM errors
gm-error-no-quest-channel = Chưa chỉ định kênh cho bài đăng quest. Liên hệ quản trị viên máy chủ để cấu hình kênh Quest.
gm-error-invalid-item-format = Định dạng vật phẩm không hợp lệ: "{ $item }". Mỗi vật phẩm phải nằm trên một dòng riêng, theo định dạng "Tên: Số lượng".
gm-error-already-on-quest = Bạn đã tham gia quest này với nhân vật { $characterName }.
gm-error-no-active-character-long = Bạn không có nhân vật đang hoạt động trên máy chủ này. Sử dụng `/player` để đăng ký hoặc kích hoạt nhân vật.
gm-error-quest-locked = Lỗi tham gia quest {"**"}{ $questTitle }{"**"}: Quest đã bị GM khóa.
gm-error-quest-full = Lỗi tham gia quest {"**"}{ $questTitle }{"**"}: Đội hình quest đã đầy!
gm-error-not-signed-up = Bạn chưa đăng ký cho quest này.
gm-error-quest-not-found = Nhiệm vụ không còn tồn tại.
gm-error-quest-channel-not-set = Chưa đặt kênh quest!
gm-error-empty-roster = Bạn không thể hoàn thành quest với đội hình trống. Hãy thử hủy thay thế.
gm-error-invalid-xp-value = Giá trị XP phải là số nguyên dương!
gm-error-role-hierarchy = ReQuest không thể quản lý vai trò "{ $roleName }" (ID: { $roleId }) vì nó được đặt cao hơn vai trò cao nhất của ReQuest trong hệ thống phân cấp máy chủ. Vui lòng liên hệ quản trị viên máy chủ để di chuyển vai trò xuống dưới vai trò của ReQuest hoặc gán cho ReQuest vai trò cao hơn, sau đó thử lại thao tác.
gm-error-party-size-positive = Số lượng đội hình phải là số dương.
gm-error-party-size-too-small = Số lượng đội hình không thể nhỏ hơn đội hình hiện tại ({ $currentSize } thành viên).
gm-error-role-name-forbidden = Tên vai trò "{ $roleName }" bị cấm trên máy chủ này.
gm-error-role-name-exists = Vai trò có tên "{ $roleName }" đã tồn tại trên máy chủ này.

# GM confirm modals
gm-modal-title-cancel-quest = Hủy Quest
gm-modal-label-cancel-quest = Nhập XÁC NHẬN để hủy quest.
gm-modal-title-remove-from-quest = Xóa nhân vật khỏi quest
gm-modal-label-remove-from-quest = Xác nhận xóa nhân vật?

# GM DM embeds
gm-dm-title-quest-cancelled = Quest đã bị hủy
gm-dm-desc-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} đã bị GM hủy.
gm-dm-title-quest-ready = Quest đã sẵn sàng
gm-dm-desc-quest-ready = Quest {"**"}{ $questTitle }{"**"} đã sẵn sàng! GM của bạn sẽ bắt đầu quest sớm.
gm-dm-title-player-removed = Đã bị xóa khỏi Quest
gm-dm-desc-player-removed = Bạn đã bị GM xóa khỏi quest {"**"}{ $questTitle }{"**"}.
gm-dm-desc-player-removed-waitlist = Bạn đã bị xóa khỏi danh sách chờ của quest {"**"}{ $questTitle }{"**"}.
gm-dm-title-party-promotion = Thăng cấp vào đội hình
gm-dm-desc-party-promotion =
    Bạn đã được thăng cấp vào đội hình chính của {"**"}{ $questTitle }{"**"}
    do có người chơi rời khỏi quest.
gm-dm-title-roster-locked = Đội hình đã khóa
gm-dm-desc-roster-locked =
    Đội hình cho {"**"}{ $questTitle }{"**"} đã được khóa
    và tất cả thành viên đội hình đã được thông báo.
gm-dm-title-roster-unlocked = Đội hình đã mở khóa
gm-dm-desc-roster-unlocked = Đội hình cho {"**"}{ $questTitle }{"**"} đã được mở khóa.
gm-dm-title-player-removed-confirm = Đã xóa người chơi
gm-dm-desc-player-removed-confirm =
    Người chơi đã bị xóa khỏi {"**"}{ $questTitle }{"**"}
    và đội hình quest đã được cập nhật.
gm-dm-footer-quest = ID nhiệm vụ: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    Quản trị viên máy chủ đã cấu hình phần thưởng cho GM khi hoàn thành
    quest. Tuy nhiên, vì bạn không có nhân vật đã đăng ký, phần thưởng không thể
    được cấp tự động vào lúc này.
gm-dm-rewards-no-active-character =
    Quản trị viên máy chủ đã cấu hình phần thưởng cho GM khi hoàn thành
    quest. Tuy nhiên, vì bạn không có nhân vật đang hoạt động trên máy chủ này, phần thưởng
    không thể được cấp tự động vào lúc này.
gm-dm-rewards-issued = Phần thưởng sau đã được cấp cho nhân vật đang hoạt động của bạn, { $characterName }
gm-dm-role-removal-failed =
    ⚠️ Không thể xóa vai trò {"**"}{ $roleName }{"**"} khỏi các thành viên sau: { $members }.
    Vui lòng thông báo cho quản trị viên máy chủ để xóa vai trò thủ công.
gm-dm-role-not-found =
    ⚠️ Vai trò quest (ID: { $roleId }) cho quest {"**"}{ $questTitle }{"**"} không còn tồn tại trên máy chủ.
    Các thao tác vai trò đã bị bỏ qua. Vui lòng thông báo cho quản trị viên máy chủ nếu đây là điều bất ngờ.

# GM select menus
gm-select-placeholder-party-member = Chọn thành viên đội hình
gm-select-option-no-role = Không (Không có vai trò đội hình)

# GM embeds
gm-embed-title-mod-report = Báo cáo chỉnh sửa người chơi bởi GM
gm-embed-field-experience = Kinh nghiệm
gm-embed-title-quest-complete = Quest hoàn thành: { $questTitle }
gm-embed-title-quest-completed = QUEST ĐÃ HOÀN THÀNH: { $questTitle }
gm-embed-field-rewards = Phần thưởng
gm-embed-field-party = __Đội hình__
gm-embed-field-summary = Tóm tắt
gm-embed-title-gm-rewards = Phần thưởng GM đã cấp
gm-embed-field-items = Vật phẩm

# GM views
gm-title-main-menu = GM - Menu chính
gm-menu-quests = Quest
gm-menu-desc-quests = Tạo, sửa và quản lý quest.
gm-menu-players = Người chơi
gm-menu-desc-players = Quản lý kho đồ và chỉnh sửa nhân vật người chơi.

gm-title-quest-management = GM - Quản lý Quest
gm-desc-create-quest = Tạo quest mới.
gm-msg-no-quests = Không tìm thấy quest.
gm-label-quest-locked = (Đã khóa)
gm-label-quest-draft = (Bản nháp)
gm-title-manage-quest = Quản lý Quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Sửa chi tiết quest như tiêu đề, mô tả và số lượng đội hình.
gm-label-field-not-set = Chưa đặt
gm-label-description-not-set = Chưa đặt mô tả
gm-label-current-party-size = {"**"}Đội hình tối đa:{"**"} { $value }
gm-label-current-party-role = {"**"}Vai trò đội hình:{"**"} { $value }
gm-desc-toggle-ready = Bật/tắt trạng thái sẵn sàng (Hiện tại: {"**"}{ $status }{"**"})
    - Khóa đội hình quest và thông báo cho thành viên đội hình rằng quest sắp bắt đầu. Nếu đã cấu hình vai trò, vai trò sẽ được gán cho thành viên đội hình khi khóa.
    - Mở khóa đội hình khi đặt thành Mở.
gm-label-ready-locked = Đã khóa/Sẵn sàng
gm-label-ready-open = Mở
gm-desc-configure-rewards = Cấu hình phần thưởng cho quest đã chọn.
gm-desc-complete-quest = Hoàn thành quest. Cấp phần thưởng, nếu có, cho thành viên đội hình.
gm-desc-remove-player = Xóa người chơi khỏi đội hình quest và thông báo cho họ.
gm-desc-cancel-quest = Hủy quest và xóa khỏi bảng quest.
gm-title-player-management = GM - Quản lý người chơi
gm-desc-player-management =
    Các lệnh này đã được chuyển sang menu ngữ cảnh. Nhấp chuột phải (máy tính) hoặc nhấn giữ (di động) hồ sơ người chơi để truy cập các tùy chọn menu sau:

    - {"**"}Chỉnh sửa người chơi{"**"}: Thêm hoặc xóa vật phẩm và kinh nghiệm từ người chơi.
    - {"**"}Xem người chơi{"**"}: Xem chi tiết nhân vật đang hoạt động của người chơi.
gm-title-remove-player = Xóa người chơi khỏi Quest - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Lưu ý xóa người chơi{"**"}__

    - Chọn người chơi từ danh sách bên dưới để xóa khỏi đội hình quest.
    - Nếu có người chơi trong danh sách chờ, người đầu tiên trong danh sách sẽ được thăng cấp vào đội hình.
    - Phần thưởng cá nhân của người chơi bị xóa sẽ bị xóa khỏi quest.
    - Nếu bạn muốn thưởng cho người chơi vì đóng góp trước đó, sử dụng menu ngữ cảnh `Chỉnh sửa người chơi` để cấp phần thưởng trực tiếp.
gm-label-no-players-in-roster = Không có người chơi trong đội hình quest
gm-title-character-sheet = Bảng nhân vật của { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Điểm kinh nghiệm:{"**"}__
gm-label-possessions = __{"**"}Tài sản{"**"}__

# GM approvals
