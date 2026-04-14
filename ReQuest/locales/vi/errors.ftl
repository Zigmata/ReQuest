## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ Ối!
error-report-description =
    { $exception }

    Nếu lỗi này không mong đợi, hoặc bạn nghi ngờ bot hoạt động không đúng, vui lòng gửi báo cáo lỗi tại [Discord hỗ trợ chính thức của ReQuest](https://discord.gg/Zq37gj4).

error-report-unexpected =
    Đã xảy ra lỗi không mong đợi. Vui lòng thử lại.

    Nếu lỗi này tiếp tục xảy ra, vui lòng gửi báo cáo lỗi tại [Discord hỗ trợ chính thức của ReQuest](https://discord.gg/Zq37gj4).

error-invalid-image-url =
    Một hoặc nhiều URL hình ảnh không hợp lệ. Discord yêu cầu một liên kết đầy đủ bắt đầu bằng `http://` hoặc `https://` và trỏ trực tiếp đến một hình ảnh (ví dụ: `https://example.com/banner.png`).

    Vui lòng chỉnh sửa nhiệm vụ và cung cấp URL hình ảnh hợp lệ, hoặc để trống các trường.
error-invalid-image-url-field = URL của { $fieldName } không hợp lệ. Vui lòng cung cấp một liên kết đầy đủ bắt đầu bằng `http://` hoặc `https://`, hoặc để trống.
error-field-thumbnail = hình ảnh thu nhỏ
error-field-large-image = hình ảnh lớn

# Check failures
error-owner-only = Chỉ chủ sở hữu bot mới có thể sử dụng lệnh này!
error-no-permission = Bạn không có quyền để chạy lệnh này!
error-no-active-character = Bạn không có nhân vật đang hoạt động trên máy chủ này!
error-no-registered-characters = Bạn chưa đăng ký nhân vật nào!
error-no-characters = Người chơi mục tiêu không có nhân vật nào đã đăng ký.
error-no-active-character-target = Người chơi mục tiêu không có nhân vật đang hoạt động trên máy chủ này.
error-player-not-found = Không tìm thấy dữ liệu người chơi.
error-character-not-found = Không tìm thấy dữ liệu nhân vật.

# Currency/transaction errors
error-transaction-cannot-complete = Không thể hoàn thành giao dịch:
    { $reason }
error-insufficient-item-trade = Bạn có { $owned }x { $itemName } nhưng đang cố đưa { $quantity }.
error-currency-process-failed = Không thể xử lý tiền tệ { $currencyName }.
error-insufficient-funds-transaction = Không đủ tiền để thanh toán giao dịch này.
error-insufficient-funds = Không đủ tiền.
error-insufficient-items = Không đủ vật phẩm: { $itemName }
error-currency-not-configured = Tiền tệ '{ $currencyName }' chưa được cấu hình trên máy chủ này.
error-cost-currency-system-mismatch = Tiền tệ chi phí '{ $currencyName }' không thuộc hệ thống tiền tệ của chính nó.
error-currency-config-error = Lỗi cấu hình tiền tệ: giá trị mệnh giá bằng 0 hoặc âm.
error-currency-validation = Đã xảy ra lỗi trong quá trình xác thực tiền tệ: { $error }
error-invalid-currency = { $itemName } không phải là tiền tệ hợp lệ.
error-insufficient-funds-for-transaction = Không đủ tiền cho giao dịch này.

# Cart errors
error-cart-not-found = Không tìm thấy giỏ hàng.
error-item-not-in-cart = Vật phẩm không có trong giỏ hàng.
error-not-enough-stock = Không đủ hàng tồn kho.

# Container errors
error-container-not-found = Không tìm thấy ngăn chứa.
error-container-name-empty = Tên ngăn chứa không được để trống.
error-container-name-too-long = Tên ngăn chứa không được vượt quá { $maxLength } ký tự.
error-max-containers-reached = Bạn không thể tạo quá { $maxContainers } ngăn chứa.
error-container-name-exists = Ngăn chứa có tên "{ $containerName }" đã tồn tại.
error-item-already-in-container = Vật phẩm đã có trong ngăn chứa này.
error-quantity-minimum = Số lượng phải ít nhất là 1.
error-source-container-not-found = Không tìm thấy ngăn chứa nguồn.
error-item-not-in-source = Không tìm thấy vật phẩm "{ $itemName }" trong ngăn chứa nguồn.
error-insufficient-quantity-in-container = Không đủ số lượng. Bạn có { $available } trong ngăn chứa này.
error-dest-container-not-found = Không tìm thấy ngăn chứa đích.
error-item-not-in-container = Không tìm thấy vật phẩm "{ $itemName }" trong ngăn chứa này.
error-insufficient-quantity-consume = Bạn chỉ có { $available } vật phẩm này trong ngăn chứa này.
