## Player module strings

# --- Cog ---

player-cmd-name = Giao dịch
player-cmd-desc = Menu Người chơi

# --- Buttons ---

# Character management
player-btn-register-character = Đăng ký Nhân vật Mới
player-btn-activate = Kích hoạt
player-btn-active = Đang hoạt động

# Player board
player-btn-create-post = Tạo Bài viết
player-btn-open-starting-shop = Mở Cửa hàng Khởi đầu
player-btn-select-kit = Chọn Bộ trang bị
player-btn-input-inventory = Nhập Kho đồ

# Wizard / shop buttons
player-btn-add-to-cart = Thêm vào Giỏ
player-btn-add-to-cart-cost = Thêm vào Giỏ ({ $costString })
player-btn-view-purchase-options = Xem Tùy chọn Mua
player-btn-review-submit = Xem lại & Gửi ({ $count })
player-btn-submit-character = Gửi Nhân vật
player-btn-keep-shopping = Tiếp tục Mua sắm
player-btn-edit-quantity = Sửa Số lượng
player-btn-clear-cart = Xóa Giỏ hàng

# Kit buttons
player-btn-confirm-selection = Xác nhận Lựa chọn
player-btn-back-to-kits = Quay lại Bộ trang bị

# Inventory management
player-btn-spend-currency = Chi Tiền tệ
player-btn-print-inventory = In Kho đồ

# Container management
player-btn-manage-containers = Quản lý Túi chứa
player-btn-create-new = + Tạo Mới
player-btn-consume-destroy = Tiêu thụ/Hủy
player-btn-move = Di chuyển
player-btn-move-all = Di chuyển Tất cả
player-btn-move-some = Di chuyển Một số...
player-btn-back-to-overview = ← Quay lại Tổng quan
player-btn-cancel-move = ← Hủy
player-btn-up = ▲ Lên
player-btn-down = ▼ Xuống

# --- Modals ---

# Trade modal
player-modal-title-trade = Giao dịch với { $targetName }
player-modal-label-trade-name = Tên
player-modal-placeholder-trade-name = Nhập tên vật phẩm bạn muốn giao dịch
player-modal-label-trade-quantity = Số lượng
player-modal-placeholder-trade-quantity = Nhập số lượng bạn muốn giao dịch

# Character register modal
player-modal-title-register = Đăng ký Nhân vật Mới
player-modal-label-char-name = Tên
player-modal-placeholder-char-name = Nhập tên nhân vật của bạn.
player-modal-label-char-note = Ghi chú
player-modal-placeholder-char-note = Nhập ghi chú để nhận diện nhân vật của bạn

# Open inventory input modal
player-modal-title-starting-inventory = Nhập Kho đồ Khởi đầu
player-modal-label-inventory = Kho đồ
player-modal-placeholder-inventory-input =
    Mỗi dòng một vật phẩm theo định dạng <tên>: <số lượng>, ví dụ:
    Kiếm: 1
    vàng: 30

# Spend currency modal
player-modal-title-spend-currency = Chi Tiền tệ
player-modal-label-currency-name = Tên Tiền tệ
player-modal-placeholder-currency-name = Nhập tên tiền tệ bạn muốn chi
player-modal-label-currency-amount = Số lượng
player-modal-placeholder-currency-amount = Nhập số lượng muốn chi

# Create player post modal
player-modal-title-create-post = Tạo Bài viết Bảng Người chơi
player-modal-label-post-title = Tiêu đề
player-modal-placeholder-post-title = Nhập tiêu đề cho bài viết của bạn
player-modal-label-post-content = Nội dung Bài viết
player-modal-placeholder-post-content = Nhập nội dung bài viết của bạn

# Edit player post modal
player-modal-title-edit-post = Sửa Bài viết Bảng Người chơi

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = Sửa Số lượng Giỏ hàng
player-modal-label-cart-qty = Số lượng
player-modal-placeholder-cart-qty = Nhập số lượng mới (0 để xóa)

# Create container modal
player-modal-title-create-container = Tạo Túi chứa Mới
player-modal-label-container-name = Tên Túi chứa
player-modal-placeholder-container-name = Nhập tên cho túi chứa (ví dụ: Ba lô)

# Rename container modal
player-modal-title-rename-container = Đổi tên Túi chứa
player-modal-label-new-container-name = Tên Túi chứa Mới
player-modal-placeholder-new-container-name = Nhập tên mới

# Consume from container modal
player-modal-title-consume = Tiêu thụ/Hủy Vật phẩm
player-modal-label-consume-qty = Số lượng (tối đa: { $maxQuantity })
player-modal-placeholder-consume-qty = Nhập số lượng muốn tiêu thụ/hủy

# Move item quantity modal
player-modal-title-move-item = Di chuyển Vật phẩm
player-modal-label-move-qty = Số lượng di chuyển (tối đa: { $maxQuantity })
player-modal-placeholder-move-qty = Nhập số lượng muốn di chuyển

# --- Selects ---

player-select-placeholder-no-characters = Bạn không có nhân vật đã đăng ký
player-select-placeholder-remove-character = Chọn nhân vật để xóa
player-select-placeholder-post = Chọn một bài viết
player-select-placeholder-container-view = Chọn túi chứa để xem...
player-select-placeholder-item = Chọn một vật phẩm...
player-select-placeholder-destination = Chọn đích đến...
player-select-placeholder-container = Chọn một túi chứa...
player-select-option-no-containers = Không có túi chứa
player-select-option-no-items = Không có vật phẩm
player-select-option-no-destinations = Không có đích đến

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}Lệnh Người chơi - Menu Chính{"**"}
player-menu-btn-characters = Nhân vật
player-menu-desc-characters = Đăng ký, xem và kích hoạt nhân vật của bạn.
player-menu-btn-inventory = Kho đồ
player-menu-desc-inventory = Xem kho đồ của nhân vật đang hoạt động và chi tiền tệ.
player-menu-btn-player-board = Bảng Người chơi
player-menu-btn-player-board-disabled = Bảng Người chơi (Chưa Cấu hình)
player-menu-desc-player-board = Tạo bài viết cho Bảng Người chơi

# CharacterBaseView
player-title-characters = {"**"}Lệnh Người chơi - Nhân vật{"**"}
player-desc-register-character = Đăng ký một nhân vật mới.
player-msg-no-characters = Bạn chưa đăng ký nhân vật nào.
player-label-active = (Đang hoạt động)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Nhân vật đang xử lý: { $characterName }{"**"}
    Đăng ký nhân vật của bạn đang chờ thiết lập trang bị.
player-btn-resume = Tiếp tục
player-btn-discard = Hủy bỏ
player-modal-title-discard-character = Hủy nhân vật
player-modal-label-discard-confirm = Hủy { $characterName }?

# Confirm character removal
player-modal-title-confirm-char-removal = Xác nhận Xóa Nhân vật
player-modal-label-confirm-char-delete = Xóa { $characterName }?

# Confirm post removal
player-modal-title-confirm-post-removal = Xác nhận Xóa Bài viết
player-modal-label-post-removal-warning = CẢNH BÁO: Hành động này không thể hoàn tác!

# InventoryOverviewView
player-title-inventory = {"**"}Lệnh Người chơi - Kho đồ{"**"}
player-title-char-inventory = {"**"}Kho đồ của { $characterName }{"**"}
player-msg-no-active-character = Không có Nhân vật Hoạt động: Kích hoạt một nhân vật cho máy chủ này để sử dụng các menu này.
player-msg-no-characters-registered = Không có Nhân vật: Đăng ký một nhân vật để sử dụng các menu này.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } vật phẩm
player-label-currency = {"**"}Tiền tệ{"**"}
player-msg-inventory-empty = Kho đồ trống.

# Print inventory embed
player-embed-title-inventory = Kho đồ của { $characterName }

# ContainerItemsView
player-msg-container-empty = Túi chứa này trống.
player-label-selected-item = Đã chọn: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Di chuyển "{ $itemName }"{"**"} (còn { $available })
player-msg-no-other-containers = Không có túi chứa khác.
player-msg-select-destination = Chọn túi chứa đích:
player-label-destination = Đích đến: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Quản lý Túi chứa{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } vật phẩm){ $suffix }
player-label-default-suffix = { " " }(mặc định)
player-msg-no-containers = Không có túi chứa.
player-label-selected-container = Đã chọn: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = Xác nhận Xóa Túi chứa
player-modal-label-container-has-items = Có { $itemCount } vật phẩm. Sẽ chuyển sang Vật phẩm Rời.
player-modal-label-confirm-container-delete = Xóa "{ $containerName }"?

# Container errors
player-error-cannot-rename-loose = Không thể đổi tên Vật phẩm Rời.
player-error-cannot-delete-loose = Không thể xóa Vật phẩm Rời.

# PlayerBoardView
player-title-player-board = {"**"}Lệnh Người chơi - Bảng Người chơi{"**"}
player-desc-create-post = Tạo bài viết mới cho Bảng Người chơi.
player-msg-no-posts = Bạn chưa có bài viết nào.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Tác giả
player-embed-footer-post-id = ID Bài viết: { $postId }
player-error-board-channel-not-found = Không tìm thấy kênh Bảng Người chơi.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Thiết lập Kho đồ cho { $characterName }{"**"}
player-desc-browse-shop = Duyệt Cửa hàng Khởi đầu để trang bị cho nhân vật của bạn.
player-desc-select-kit = Chọn một Bộ trang bị Khởi đầu.
player-desc-input-inventory = Nhập kho đồ khởi đầu thủ công.

# StaticKitSelectView
player-title-select-kit = {"**"}Chọn Bộ trang bị cho { $characterName }{"**"}
player-msg-no-kits = Không có bộ trang bị khởi đầu nào.
player-label-and-more-items = ...và { $count } vật phẩm nữa
player-label-empty-kit = {"*"}Bộ trang bị Trống{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Xác nhận Lựa chọn: { $kitName }{"**"}
player-label-items-heading = {"**"}Vật phẩm:{"**"}
player-label-currency-heading = {"**"}Tiền tệ:{"**"}
player-msg-kit-empty = Bộ trang bị này trống.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Tùy chọn Mua: { $itemName }{"**"}
player-msg-no-cost-options = Vật phẩm này không có tùy chọn giá.
player-label-cost-option = {"**"}Tùy chọn { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Cửa hàng Khởi đầu ({ $inventoryType }){"**"}
player-label-starting-wealth = Tài sản Khởi đầu: { $formattedCurrency }
player-label-in-cart = {"**"}(Trong Giỏ: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Xem lại Giỏ hàng{"**"}
player-msg-cart-empty = Giỏ hàng của bạn trống.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Tổng: { $totalQuantity })
player-label-insufficient-currency = Không đủ { $currencyName }
player-label-total-cost = {"**"}Tổng Chi phí:{"**"}
player-label-total-cost-free = {"**"}Tổng Chi phí:{"**"} Miễn phí
player-label-cart-page = Trang { $current } / { $total }

# Trade embed
player-embed-title-trade = Báo cáo Giao dịch
player-embed-desc-trade-sender = Người gửi: { $senderMention } với tư cách `{ $senderCharacter }`
player-embed-desc-trade-recipient = Người nhận: { $recipientMention } với tư cách `{ $recipientCharacter }`
player-embed-field-currency = Tiền tệ
player-embed-field-amount = Số lượng
player-embed-field-balance = Số dư của { $characterName }
player-embed-field-item = Vật phẩm
player-embed-field-quantity = Số lượng
player-embed-footer-transaction-id = ID Giao dịch: { $transactionId }

# Trade errors
player-error-trade-no-characters = Người chơi bạn muốn giao dịch không có nhân vật nào!
player-error-trade-no-active = Người chơi bạn muốn giao dịch không có nhân vật đang hoạt động trên máy chủ này!

# Spend currency embed
player-embed-title-spend = Báo cáo Giao dịch Người chơi
player-embed-desc-spend-player = Người chơi: { $playerMention } với tư cách `{ $characterName }`
player-embed-desc-spend-transaction = Giao dịch: {"**"}{ $characterName }{"**"} đã chi {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Kênh
player-embed-field-receipt = Biên lai

# Spend currency errors
player-error-amount-not-number = Số lượng phải là một con số.
player-error-amount-positive = Bạn phải chi một số lượng dương.
player-error-amount-exceeds-maximum = Số tiền không được vượt quá { $max }.
player-error-no-active-character-server = Bạn không có nhân vật đang hoạt động trên máy chủ này.
player-error-no-currency-config = Không tìm thấy cấu hình tiền tệ cho máy chủ này.

# Consume item embed
player-embed-title-consume = Báo cáo Tiêu thụ Vật phẩm
player-embed-desc-consume = Người chơi: { $playerMention } với tư cách `{ $characterName }`
player-embed-desc-consume-removed = Đã xóa: {"**"}{ $quantity }x { $itemName }{"**"} khỏi {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = Số lượng phải là một số nguyên dương.
player-error-qty-at-least-one = Số lượng phải ít nhất là 1.
player-error-qty-only-have = Bạn chỉ có { $maxQuantity } vật phẩm này.

# Inventory input errors
player-error-invalid-format = Định dạng không hợp lệ: "{ $line }". Sử dụng <tên>: <số lượng>.
player-error-empty-name = Tên vật phẩm không được để trống ở dòng: "{ $line }".
player-error-invalid-quantity = Số lượng không hợp lệ cho "{ $name }": "{ $quantity }". Phải là số nguyên dương.
player-error-input-errors-header = Lỗi trong dữ liệu kho đồ nhập vào:
player-msg-no-valid-items = Không có vật phẩm hợp lệ. Khởi tạo với kho đồ trống.

# Cart quantity validation
player-error-enter-valid-number = Vui lòng nhập một số dương hợp lệ.

# Submission embeds (approval queue)
player-embed-title-approval = Phê duyệt Kho đồ: { $characterName }
player-embed-desc-submitted-by = Gửi bởi { $userMention }
player-embed-field-items = Vật phẩm
player-embed-field-currency-received = Tiền tệ
player-embed-footer-submission-id = ID Đệ trình: { $submissionId }
player-label-approval-thread = Phê duyệt: { $characterName }
player-embed-title-submission-sent = Đã Gửi Đệ trình Kho đồ
player-embed-desc-submission-sent =
    Đệ trình của bạn cho {"**"}{ $characterName }{"**"} đã được gửi đến đội GM để phê duyệt!
    Bạn sẽ được thông báo khi đã được xem xét.
    [Xem Luồng Đệ trình]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = Đã Áp dụng Kho đồ Khởi đầu
player-embed-desc-starting-inventory = Người chơi: { $playerMention } với tư cách `{ $characterName }`
player-embed-field-items-received = Vật phẩm Nhận được
player-embed-field-currency-received-label = Tiền tệ Nhận được
player-label-untitled = Không có tiêu đề

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventory Submission: { $characterName }{"**"}
    Submitted by { $userMention }
player-approval-post-items = Vật phẩm
player-approval-post-currency = Tiền tệ
player-approval-resolved = Yêu cầu này đã được xử lý.
player-approval-btn-approve = Phê duyệt
player-approval-btn-deny = Từ chối
player-approval-btn-edit = Chỉnh sửa
player-approval-error-no-permission = Bạn không có quyền thực hiện hành động này.
player-approval-error-not-submitter = Chỉ người gửi ban đầu mới có thể chỉnh sửa yêu cầu này.
player-approval-thread-instructions =
    This thread was created for the approval of a character's starting inventory.
    A Game Master will review the submission and approve or deny it.
    The submitting player may use the Edit button to modify and re-submit.
    Once approved or denied, this thread will be locked.
player-msg-submission-updated = Yêu cầu của bạn đã được cập nhật.

# Approval DM notifications
player-dm-title-approved = Nhân vật đã được phê duyệt
player-dm-desc-approved =
    Your character {"**"}{ $characterName }{"**"} has been approved
    by { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Nhân vật đã bị từ chối
player-dm-desc-denied =
    Your character {"**"}{ $characterName }{"**"} has been denied
    by { $denier } in {"**"}{ $guildName }{"**"}. You may re-submit.
