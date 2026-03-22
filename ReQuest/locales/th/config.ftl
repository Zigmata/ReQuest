## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = ล้าง
config-btn-remove-gm-roles = ลบบทบาท GM
config-btn-forbidden-roles = บทบาทที่ห้ามใช้

# Quests
config-btn-toggle-quest-summary = สลับสรุป Quest
config-btn-toggle-player-experience = สลับประสบการณ์ผู้เล่น
config-btn-toggle-display = สลับการแสดงผล
config-btn-purge-player-board = ล้างกระดานผู้เล่น
config-btn-add-modify-rewards = เพิ่ม/แก้ไขรางวัล

# Currency
config-btn-add-denomination = เพิ่มหน่วยย่อย
config-btn-add-new-currency = เพิ่มสกุลเงินใหม่
config-btn-remove-currency = ลบสกุลเงิน

# Shops - creation
config-btn-add-shop-wizard = เพิ่มร้านค้า (วิซาร์ด)
config-btn-add-shop-json = เพิ่มร้านค้า (JSON)
config-btn-edit-shop-wizard = แก้ไขร้านค้า (วิซาร์ด)
config-btn-edit-shop-json = แก้ไขร้านค้า (JSON)
config-btn-remove-shop = ลบร้านค้า
config-btn-add-item = เพิ่มไอเทม
config-btn-edit-shop-details = แก้ไขรายละเอียดร้านค้า
config-btn-download-json = ดาวน์โหลด JSON
config-btn-done-editing = แก้ไขเสร็จ
config-btn-scan-server-configs = สแกนการตั้งค่าเซิร์ฟเวอร์
config-btn-re-scan = สแกนอีกครั้ง

# New character shop
config-btn-upload-json = อัปโหลด JSON
config-btn-configure-new-character-wealth = ตั้งค่าทรัพย์สินตัวละครใหม่
config-btn-configure-new-character-shop = ตั้งค่าร้านค้าตัวละครใหม่
config-btn-clear-shop = ล้างร้านค้า
config-btn-configure-static-kits = ตั้งค่าชุดสำเร็จรูป
config-btn-new-character-settings = การตั้งค่าตัวละครใหม่
config-btn-disabled-no-currency = ปิดใช้งาน (ไม่มีสกุลเงินที่ตั้งค่า)
config-btn-disabled-no-wealth = ปิดใช้งาน (ไม่มีทรัพย์สินเริ่มต้นที่ตั้งค่า)

# Static kits
config-btn-create-new-kit = สร้างชุดใหม่
config-btn-delete-kit = ลบชุด
config-btn-add-currency = เพิ่มสกุลเงิน

# Roleplay
config-btn-toggle-rp-rewards = สลับรางวัล RP
config-btn-clear-channels = ล้างช่อง
config-btn-edit-settings = แก้ไขการตั้งค่า
config-btn-configure-rewards = ตั้งค่ารางวัล

# Stock
config-btn-stock-limits = จำกัดสินค้าคงเหลือ
config-btn-set-limit = ตั้งค่าขีดจำกัด
config-btn-edit-limit = แก้ไขขีดจำกัด
config-btn-remove-limit = ลบขีดจำกัด
config-btn-configure-restock-schedule = ตั้งค่าตารางเติมสินค้า
config-btn-back-to-shop-editor = กลับไปตัวแก้ไขร้านค้า

# Forum shop
config-btn-create-new-thread = สร้างกระทู้ใหม่
config-btn-use-existing-thread = ใช้กระทู้ที่มีอยู่

# Wizard
config-btn-quit = ออก
config-btn-configure-channels = ตั้งค่าช่อง
config-btn-configure-roles = ตั้งค่าบทบาท
config-btn-configure-quests = ตั้งค่า Quest
config-btn-configure-players = ตั้งค่าผู้เล่น
config-btn-configure-currency = ตั้งค่าสกุลเงิน
config-btn-configure-rp-rewards = ตั้งค่ารางวัล RP
config-btn-configure-shops = ตั้งค่าร้านค้า
config-btn-new-char-setup = ตั้งค่าตัวละครใหม่

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = ยืนยันการลบบทบาท
config-modal-title-confirm-removal = ยืนยันการลบ
config-modal-title-confirm-currency-removal = ยืนยันการลบสกุลเงิน
config-modal-title-confirm-shop-removal = ยืนยันการลบร้านค้า
config-modal-title-confirm-kit-deletion = ยืนยันการลบชุด
config-modal-title-confirm-remove-stock-limit = ยืนยันการลบขีดจำกัดสินค้าคงเหลือ
config-modal-title-clear-shop = ยืนยันการล้างร้านค้า

# Confirm modal prompt labels
config-modal-label-remove-role = ลบ { $roleName }?
config-modal-label-remove-denomination = ลบ { $denominationName }?
config-modal-label-remove-currency = ลบ { $currencyName }?
config-modal-label-shop-removal-warning = คำเตือน: การดำเนินการนี้ไม่สามารถย้อนกลับได้!
config-modal-label-kit-deletion-warning = คำเตือน: ไม่สามารถย้อนกลับได้!
config-modal-label-remove-stock-limit = พิมพ์ CONFIRM เพื่อลบขีดจำกัดสินค้าคงเหลือ
config-modal-label-clear-shop = ล้างสินค้าทั้งหมดจากร้านค้านี้?
config-modal-placeholder-type-confirm = พิมพ์ CONFIRM

# Error messages from buttons
config-error-shop-data-not-found = ข้อผิดพลาด: ไม่พบข้อมูลร้านค้านั้น
config-msg-shop-json-download = นี่คือไฟล์ JSON สำหรับ {"**"}{ $shopName }{"**"}
config-msg-new-char-shop-json-download = นี่คือไฟล์ JSON สำหรับร้านค้าตัวละครใหม่
config-error-select-forum-first = กรุณาเลือกช่อง Forum ก่อน
config-error-select-thread-first = กรุณาเลือกกระทู้ก่อน

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = เพิ่มสกุลเงินใหม่
config-modal-label-currency-name = ชื่อสกุลเงิน
config-error-currency-already-exists = สกุลเงินหรือหน่วยย่อยชื่อ { $name } มีอยู่แล้ว!

# RenameCurrencyModal
config-modal-title-rename-currency = เปลี่ยนชื่อสกุลเงิน
config-modal-label-new-currency-name = ชื่อสกุลเงินใหม่
config-error-currency-name-exists = สกุลเงินชื่อ "{ $name }" มีอยู่แล้ว
config-error-denomination-name-exists = หน่วยย่อยชื่อ "{ $name }" มีอยู่แล้ว

# RenameDenominationModal
config-modal-title-rename-denomination = เปลี่ยนชื่อหน่วยย่อย
config-modal-label-new-denomination-name = ชื่อหน่วยย่อยใหม่

# AddCurrencyDenominationModal
config-modal-title-add-denomination = เพิ่มหน่วยย่อย { $currencyName }
config-modal-label-denomination-name = ชื่อ
config-modal-placeholder-denomination-name = เช่น เงิน
config-modal-label-denomination-value = มูลค่า
config-modal-placeholder-denomination-value = เช่น 0.1
config-error-denomination-matches-currency = ชื่อหน่วยย่อยใหม่ไม่สามารถตรงกับสกุลเงินที่มีอยู่บนเซิร์ฟเวอร์นี้ได้! พบสกุลเงินที่มีอยู่ชื่อ "{ $existingName }"
config-error-denomination-matches-denomination = ชื่อหน่วยย่อยใหม่ไม่สามารถตรงกับหน่วยย่อยที่มีอยู่บนเซิร์ฟเวอร์นี้ได้! พบหน่วยย่อยที่มีอยู่ชื่อ "{ $denominationName }" ภายใต้สกุลเงินชื่อ "{ $currencyName }"
config-error-denomination-value-exists = หน่วยย่อยภายใต้สกุลเงินเดียวกันต้องมีมูลค่าไม่ซ้ำกัน! { $denominationName } มีมูลค่านี้ถูกกำหนดไว้แล้ว

# ForbiddenRolesModal
config-modal-title-forbidden-roles = ชื่อบทบาทที่ห้ามใช้
config-modal-label-names = ชื่อ
config-modal-placeholder-names = ป้อนชื่อคั่นด้วยเครื่องหมายจุลภาค
config-msg-forbidden-roles-updated = อัปเดตบทบาทที่ห้ามใช้แล้ว!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = ล้างกระดานผู้เล่น
config-modal-label-age = อายุ
config-modal-placeholder-age = ป้อนอายุโพสต์สูงสุด (เป็นวัน) ที่จะเก็บไว้
config-msg-posts-purged = โพสต์ที่เก่ากว่า { $days } วันถูกล้างแล้ว!

# GMRewardsModal
config-modal-title-gm-rewards = เพิ่ม/แก้ไขรางวัล GM
config-modal-label-experience = ประสบการณ์
config-modal-placeholder-enter-number = ป้อนตัวเลข
config-modal-label-items = ไอเทม
config-modal-placeholder-items =
    ชื่อ: จำนวน
    ชื่อ2: จำนวน
    ฯลฯ
config-error-experience-invalid = ประสบการณ์ต้องเป็นจำนวนเต็ม (เช่น 2000)
config-error-item-format-invalid = รูปแบบไอเทมไม่ถูกต้อง: "{ $item }" แต่ละไอเทมต้องอยู่คนละบรรทัด ในรูปแบบ "ชื่อ: จำนวน"

# ConfigShopDetailsModal
config-modal-title-shop-details = เพิ่ม/แก้ไขรายละเอียดร้านค้า
config-modal-label-shop-channel = เลือกช่อง
config-modal-placeholder-shop-channel = เลือกช่องสำหรับร้านค้านี้
config-modal-label-shop-name = ชื่อร้านค้า
config-modal-placeholder-shop-name = ป้อนชื่อร้านค้า
config-modal-label-shopkeeper-name = ชื่อเจ้าของร้าน
config-modal-placeholder-shopkeeper-name = ป้อนชื่อเจ้าของร้าน
config-modal-label-shop-description = คำอธิบายร้านค้า
config-modal-placeholder-shop-description = ป้อนคำอธิบายสำหรับร้านค้า
config-modal-label-shop-image-url = URL รูปภาพร้านค้า
config-modal-placeholder-shop-image-url = ป้อน URL สำหรับรูปภาพร้านค้า
config-error-no-channel-selected = ไม่ได้เลือกช่องสำหรับร้านค้า
config-error-shop-already-in-channel = มีร้านค้าลงทะเบียนอยู่ในช่องที่เลือกแล้ว กรุณาเลือกช่องอื่นหรือแก้ไขร้านค้าที่มีอยู่

# build_shop_header_view
config-label-shopkeeper = {"**"}เจ้าของร้าน:{"**"} { $name }
config-msg-use-shop-command = ใช้คำสั่ง `/shop` เพื่อเรียกดูและซื้อไอเทม

# ForumThreadShopModal
config-modal-title-forum-thread-shop = สร้างร้านค้ากระทู้ Forum
config-modal-label-thread-name = ชื่อกระทู้
config-modal-placeholder-thread-name = ป้อนชื่อสำหรับกระทู้ร้านค้า
config-error-forum-not-found = ไม่พบช่อง Forum ที่เลือก
config-error-shop-already-in-thread = มีร้านค้าลงทะเบียนอยู่ในกระทู้นี้แล้ว ไม่ควรเกิดขึ้นกับกระทู้ใหม่

# ConfigShopJSONModal
config-modal-title-add-shop-json = เพิ่มร้านค้าใหม่ผ่าน JSON
config-modal-label-upload-json = อัปโหลดไฟล์ .json ที่มีข้อมูลร้านค้า
config-error-no-json-uploaded = ไม่มีไฟล์ JSON ที่อัปโหลดสำหรับร้านค้า
config-error-file-must-be-json = ไฟล์ที่อัปโหลดต้องเป็นไฟล์ JSON (.json)
config-error-invalid-json = รูปแบบ JSON ไม่ถูกต้อง: { $error }
config-error-json-validation-failed = JSON ไม่ตรงตามสคีมา: { $error }

# ShopItemModal
config-modal-title-shop-item = เพิ่ม/แก้ไขไอเทมร้านค้า
config-modal-label-item-name = ชื่อไอเทม
config-modal-placeholder-item-name = ป้อนชื่อไอเทม
config-modal-label-item-description = คำอธิบายไอเทม
config-modal-placeholder-item-description = ป้อนคำอธิบายสำหรับไอเทม
config-modal-label-item-quantity = จำนวนไอเทม
config-modal-placeholder-item-quantity = ป้อนจำนวนที่ขายต่อการซื้อ
config-modal-label-item-costs = ราคาไอเทม
config-modal-placeholder-item-costs = เช่น: 10 gold + 5 silver\nหรือ: 50 rep\n(ใช้ + สำหรับ AND, บรรทัดใหม่สำหรับ OR)
config-error-item-quantity-positive = จำนวนไอเทมต้องเป็นจำนวนเต็มบวก
config-error-cost-format-invalid = รูปแบบราคาไม่ถูกต้องในตัวเลือก: "{ $option }" แต่ละราคาต้องมีจำนวนและสกุลเงินคั่นด้วยเว้นวรรค เช่น "10 gold"
config-error-cost-amount-invalid = จำนวน "{ $amount }" ไม่ถูกต้องสำหรับสกุลเงิน: "{ $currency }" จำนวนต้องเป็นตัวเลขบวก
config-error-unknown-currency = ไม่รู้จักสกุลเงิน `{ $currency }` กรุณาใช้สกุลเงินที่ตั้งค่าไว้สำหรับเซิร์ฟเวอร์นี้
config-error-item-already-exists = ไอเทมชื่อ { $itemName } มีอยู่ในร้านค้านี้แล้ว

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = อัปเดตร้านค้าผ่าน JSON
config-modal-label-upload-new-json = อัปโหลดไฟล์ JSON ใหม่
config-error-no-file-uploaded = ไม่มีไฟล์ที่อัปโหลด
config-error-file-must-be-json-ext = ไฟล์ต้องเป็นไฟล์ `.json`
config-error-json-validation-message = การตรวจสอบ JSON ล้มเหลว: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = เพิ่ม/แก้ไขอุปกรณ์ตัวละครใหม่
config-modal-placeholder-item-quantity-selection = ป้อนจำนวนที่ได้รับต่อการเลือก
config-modal-label-item-cost = ราคาไอเทม
config-error-cost-format-short = รูปแบบราคาไม่ถูกต้อง: '{ $component }' คาดว่าเป็น 'จำนวน สกุลเงิน'
config-error-amount-invalid-short = จำนวน '{ $amount }' ไม่ถูกต้องสำหรับสกุลเงิน '{ $currency }'
config-error-item-exists-new-char = ไอเทมชื่อ { $itemName } มีอยู่ในร้านค้าตัวละครใหม่แล้ว

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = อัปโหลดร้านค้าตัวละครใหม่ (JSON)
config-error-no-json-uploaded-short = ไม่มีไฟล์ JSON ที่อัปโหลด
config-error-json-must-have-shopstock = JSON ต้องมีอาร์เรย์ 'shopStock'
config-error-items-must-have-name-price = ไอเทมทั้งหมดต้องมี 'name' และ 'price'

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = ตั้งค่าทรัพย์สินตัวละครใหม่
config-modal-label-amount = จำนวน
config-modal-placeholder-amount = ป้อนจำนวนของสกุลเงินนี้
config-modal-placeholder-currency-name = ป้อนชื่อสกุลเงินที่กำหนดไว้บนเซิร์ฟเวอร์นี้
config-error-no-currencies-configured = ไม่มีสกุลเงินที่ตั้งค่าบนเซิร์ฟเวอร์นี้
config-error-currency-not-found = ไม่พบสกุลเงินหรือหน่วยย่อยชื่อ { $name } กรุณาใช้สกุลเงินที่ถูกต้อง

# CreateStaticKitModal
config-modal-title-create-kit = สร้างชุดสำเร็จรูปใหม่
config-modal-label-kit-name = ชื่อชุด
config-modal-placeholder-kit-name = เช่น ชุดเริ่มต้นนักรบ
config-modal-label-description = คำอธิบาย
config-modal-placeholder-kit-description = คำอธิบายเพิ่มเติมสำหรับชุดนี้
config-error-kit-name-exists = ชุดสำเร็จรูปชื่อ "{ $kitName }" มีอยู่แล้ว กรุณาเลือกชื่ออื่น

# StaticKitItemModal
config-modal-title-kit-item = เพิ่ม/แก้ไขไอเทมในชุด
config-modal-placeholder-kit-item-quantity = ป้อนจำนวนไอเทมที่จะรวมในชุด

# StaticKitCurrencyModal
config-modal-title-kit-currency = เพิ่มสกุลเงินในชุด
config-modal-placeholder-currency-eg = เช่น Gold
config-modal-placeholder-amount-eg = เช่น 100
config-error-amount-must-be-number = จำนวนต้องเป็นตัวเลข
config-error-no-currencies-on-server = ไม่มีสกุลเงินที่ตั้งค่าบนเซิร์ฟเวอร์
config-error-currency-not-found-short = ไม่พบสกุลเงิน "{ $currency }"
config-error-denomination-not-found = ไม่พบหน่วยย่อย "{ $denomination }" ในการตั้งค่าสกุลเงิน

# RoleplaySettingsModal
config-modal-title-rp-settings = การตั้งค่าการเล่นสวมบทบาท
config-modal-label-min-message-length = ความยาวข้อความขั้นต่ำ (ตัวอักษร)
config-modal-placeholder-min-message-length = จำนวนตัวอักษรที่ข้อความต้องมีเพื่อมีสิทธิ์ 0 สำหรับไม่จำกัด
config-modal-label-cooldown = คูลดาวน์ (วินาที)
config-modal-placeholder-cooldown = เวลารอเป็นวินาทีระหว่างการนับข้อความที่มีสิทธิ์รับรางวัล
config-modal-label-message-threshold = เกณฑ์ข้อความ
config-modal-placeholder-message-threshold = จำนวนข้อความที่ต้องส่งเพื่อเรียกรางวัล
config-modal-label-frequency = ความถี่ (จำนวนข้อความ)
config-modal-placeholder-frequency = จำนวนข้อความที่มีสิทธิ์ที่ต้องส่งเพื่อรับรางวัล
config-error-min-length-invalid = ความยาวข้อความขั้นต่ำต้องเป็นจำนวนเต็มไม่ติดลบ
config-error-cooldown-invalid = คูลดาวน์ต้องเป็นจำนวนเต็มไม่ติดลบ
config-error-threshold-invalid = เกณฑ์ข้อความต้องเป็นจำนวนเต็มบวก
config-error-frequency-invalid = ความถี่ต้องเป็นจำนวนเต็มบวก

# RoleplayRewardsModal
config-modal-title-rp-rewards = ตั้งค่ารางวัลการเล่นสวมบทบาท
config-modal-label-items-name-quantity = ไอเทม (ชื่อ: จำนวน)
config-modal-label-currency-name-amount = สกุลเงิน (ชื่อ: จำนวน)
config-error-experience-non-negative = ประสบการณ์ต้องเป็นจำนวนเต็มไม่ติดลบ
config-error-item-quantity-positive-named = จำนวนไอเทมสำหรับ "{ $itemName }" ต้องเป็นจำนวนเต็มบวก
config-error-currency-amount-positive = จำนวนสกุลเงินสำหรับ "{ $currencyName }" ต้องเป็นตัวเลขบวก

# SetItemStockModal
config-modal-title-stock-limit = ขีดจำกัดสินค้าคงเหลือ: { $itemName }
config-modal-label-max-stock = สินค้าคงเหลือสูงสุด
config-modal-placeholder-max-stock = ป้อนจำนวนสูงสุด (เช่น 10)
config-modal-label-current-stock = สินค้าคงเหลือปัจจุบัน
config-modal-placeholder-current-stock = ป้อนจำนวนที่มีอยู่ปัจจุบัน
config-error-max-stock-positive = สินค้าคงเหลือสูงสุดต้องเป็นจำนวนเต็มบวก
config-error-current-stock-non-negative = สินค้าคงเหลือปัจจุบันต้องเป็นจำนวนเต็มไม่ติดลบ
config-error-current-exceeds-max = สินค้าคงเหลือปัจจุบันต้องไม่เกินสินค้าคงเหลือสูงสุด
config-error-item-not-in-shop = ไม่พบไอเทม "{ $itemName }" ในร้านค้า

# RestockScheduleModal
config-modal-title-restock-schedule = ตั้งค่าตารางเติมสินค้า
config-modal-label-schedule = ตาราง (hourly/daily/weekly/none)
config-modal-placeholder-schedule = ป้อน: hourly, daily, weekly หรือ none
config-modal-label-time = เวลา (HH:MM ในรูปแบบ UTC)
config-modal-desc-current-time = เวลาปัจจุบัน: { $utcTime }
config-modal-placeholder-time = เช่น 14:30 สำหรับ 14:30 น. UTC
config-modal-label-day-of-week = วันในสัปดาห์ (0=จันทร์, 6=อาทิตย์) - เฉพาะรายสัปดาห์
config-modal-placeholder-day-of-week = ป้อน 0-6 (จันทร์=0, อาทิตย์=6)
config-modal-label-mode = โหมด (full/incremental)
config-modal-placeholder-mode = full = รีเซ็ตเป็นค่าสูงสุด, incremental = เพิ่มตามจำนวน
config-modal-label-increment = จำนวนที่เพิ่ม (สำหรับโหมด incremental)
config-modal-placeholder-increment = จำนวนที่เพิ่มต่อรอบการเติมสินค้า
config-error-schedule-invalid = ตารางต้องเป็นหนึ่งใน: hourly, daily, weekly หรือ none
config-error-time-format-invalid = เวลาต้องอยู่ในรูปแบบ HH:MM (เช่น 14:30)
config-error-day-of-week-invalid = วันในสัปดาห์ต้องเป็น 0-6 (จันทร์=0, อาทิตย์=6)
config-error-mode-invalid = โหมดต้องเป็น "full" หรือ "incremental"
config-error-increment-positive = จำนวนที่เพิ่มต้องเป็นจำนวนเต็มบวก

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = ค้นหาช่อง { $configName } ของคุณ

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = เลือกบทบาทประกาศ Quest

# AddGMRoleSelect
config-select-placeholder-gm-roles = เลือกบทบาท GM ของคุณ

# ConfigWaitListSelect
config-select-placeholder-wait-list = เลือกขนาดรายชื่อรอ
config-select-option-disabled = 0 (ปิดใช้งาน)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = เลือกโหมดคลังไอเทม
config-select-option-disabled-label = ปิดใช้งาน
config-select-desc-disabled = ผู้เล่นเริ่มต้นด้วยคลังไอเทมว่างเปล่า
config-select-option-selection = เลือกเอง
config-select-desc-selection = ผู้เล่นเลือกไอเทมอิสระจากร้านค้าตัวละครใหม่
config-select-option-purchase = ซื้อ
config-select-desc-purchase = ผู้เล่นซื้อไอเทมจากร้านค้าตัวละครใหม่ด้วยสกุลเงินที่กำหนด
config-select-option-open = เปิด
config-select-desc-open = ผู้เล่นป้อนไอเทมในคลังของตนเอง
config-select-option-static = สำเร็จรูป
config-select-desc-static = ผู้เล่นได้รับคลังไอเทมเริ่มต้นที่กำหนดไว้ล่วงหน้า

# RoleplayChannelSelect
config-select-placeholder-rp-channels = เลือกช่องที่มีสิทธิ์

# RoleplayModeSelect
config-select-placeholder-rp-mode = เลือกโหมด
config-select-option-scheduled = ตามกำหนด
config-select-desc-scheduled = รางวัลจะมอบให้ครั้งเดียวภายในช่วงเวลารีเซ็ตที่กำหนด
config-select-option-accrued = สะสม
config-select-desc-accrued = รางวัลจะมอบให้ซ้ำตามระดับกิจกรรมที่กำหนด

# RoleplayResetSelect
config-select-placeholder-reset-period = เลือกช่วงเวลารีเซ็ต
config-select-option-hourly = ทุกชั่วโมง
config-select-desc-hourly = รีเซ็ตทุกชั่วโมง
config-select-option-daily = ทุกวัน
config-select-desc-daily = รีเซ็ตทุก 24 ชั่วโมง
config-select-option-weekly = ทุกสัปดาห์
config-select-desc-weekly = รีเซ็ตทุก 7 วัน

# RoleplayResetDaySelect
config-select-placeholder-reset-day = เลือกวันรีเซ็ต

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = เลือกเวลารีเซ็ต (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = เลือกช่อง Forum

# ForumThreadSelect
config-select-placeholder-thread = เลือกกระทู้
config-select-option-no-threads = ไม่พบกระทู้ที่ใช้งานอยู่
config-select-desc-no-threads = สร้างกระทู้ใหม่หรือตรวจสอบกระทู้ที่เก็บถาวร
config-select-option-select-forum-first = เลือก Forum ก่อน
config-select-desc-select-forum-first = กรุณาเลือกช่อง Forum ด้านบน
config-select-desc-thread-id = Thread ID: { $threadId }
config-error-select-valid-thread = กรุณาเลือกกระทู้ที่ถูกต้องหรือสร้างกระทู้ใหม่
config-error-thread-not-found = ไม่พบกระทู้ที่เลือก อาจถูกลบหรือเก็บถาวรไปแล้ว

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = การตั้งค่าเซิร์ฟเวอร์ - เมนูหลัก
config-menu-config-wizard = วิซาร์ดการตั้งค่า
config-menu-desc-config-wizard = ตรวจสอบว่าเซิร์ฟเวอร์ของคุณพร้อมใช้ ReQuest ด้วยการสแกนอย่างรวดเร็ว
config-menu-channels = ช่อง
config-menu-desc-channels = ตั้งค่าช่องที่กำหนดสำหรับโพสต์ของ ReQuest
config-menu-currency = สกุลเงิน
config-menu-desc-currency = การตั้งค่าสกุลเงินทั่วไป
config-menu-players = ผู้เล่น
config-menu-desc-players = การตั้งค่าผู้เล่นทั่วไป เช่น การติดตามค่าประสบการณ์
config-menu-quests = Quest
config-menu-desc-quests = การตั้งค่า Quest ทั่วไป เช่น รายชื่อรอ
config-menu-rp-rewards = รางวัล RP
config-menu-desc-rp-rewards = ตั้งค่ารางวัลการเล่นสวมบทบาท
config-menu-roles = บทบาท
config-menu-desc-roles = ตัวเลือกการตั้งค่าสำหรับบทบาทที่สามารถ ping ได้หรือบทบาทพิเศษ
config-menu-shops = ร้านค้า
config-menu-desc-shops = ตั้งค่าร้านค้าแบบกำหนดเอง
config-menu-language = ภาษา
config-menu-desc-language = ตั้งค่าภาษาเริ่มต้นสำหรับเซิร์ฟเวอร์นี้

## Wizard View
config-title-wizard = {"**"}การตั้งค่าเซิร์ฟเวอร์ - วิซาร์ด{"**"}
config-wizard-intro =
    {"**"}ยินดีต้อนรับสู่วิซาร์ดการตั้งค่า ReQuest!{"**"}

    วิซาร์ดนี้จะช่วยให้คุณมั่นใจว่าเซิร์ฟเวอร์ของคุณได้รับการตั้งค่าอย่างถูกต้องเพื่อใช้ฟีเจอร์ของ ReQuest
    วิซาร์ดจะสแกนการตั้งค่าปัจจุบันของคุณและให้คำแนะนำสำหรับการปรับเปลี่ยนที่จำเป็น

    ใช้ปุ่ม "เริ่มสแกน" ด้านล่างเพื่อเริ่มกระบวนการตรวจสอบ เมื่อสแกนเสร็จ
    คุณจะได้รับรายงานละเอียดเกี่ยวกับการตั้งค่าเซิร์ฟเวอร์พร้อมคำแนะนำในการเปลี่ยนแปลง

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}สิทธิ์ทั่วไปของบอท{"**"}__
config-wizard-bot-permissions-desc = ส่วนนี้ตรวจสอบว่า ReQuest มีสิทธิ์ที่ถูกต้องเพื่อให้ทำงานได้อย่างถูกต้อง
config-wizard-bot-role = บทบาทบอท: { $roleMention }
config-wizard-status-warnings = {"**"}สถานะ: ⚠️ พบคำเตือน{"**"}
config-wizard-missing-perm = - ⚠️ ขาด: `{ $permissionName }`
config-wizard-ensure-permissions = กรุณาตรวจสอบให้แน่ใจว่าบทบาทสูงสุดของบอทได้รับสิทธิ์เหล่านี้ในระดับทั่วไป
config-wizard-status-ok = {"**"}สถานะ: ✅ ตกลง{"**"}
config-wizard-bot-permissions-ok = บอทมีสิทธิ์ทั่วไปที่จำเป็นทั้งหมด
config-wizard-status-scan-failed = {"**"}สถานะ: ❌ การสแกนล้มเหลว{"**"}
config-wizard-scan-error = เกิดข้อผิดพลาดที่ไม่คาดคิดขณะตรวจสอบสิทธิ์ของบอท
config-wizard-error-type = ข้อผิดพลาด: { $errorType }
config-wizard-required-permissions = {"**"}สิทธิ์ที่จำเป็นสำหรับบทบาทของบอท:{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = ดูช่อง
config-wizard-perm-manage-roles = จัดการบทบาท
config-wizard-perm-send-messages = ส่งข้อความ
config-wizard-perm-attach-files = แนบไฟล์
config-wizard-perm-add-reactions = เพิ่มปฏิกิริยา
config-wizard-perm-use-external-emoji = ใช้อีโมจิภายนอก
config-wizard-perm-manage-messages = จัดการข้อความ
config-wizard-perm-read-message-history = อ่านประวัติข้อความ

# Wizard - Role Validation
config-wizard-role-header = __{"**"}การตั้งค่าบทบาท{"**"}__
config-wizard-role-desc =
    ส่วนนี้ตรวจสอบสิ่งต่อไปนี้:

    - บทบาท GM (จำเป็น) และบทบาทประกาศ (ไม่บังคับ) ได้รับการตั้งค่าแล้ว
    - บทบาทเริ่มต้น (@everyone) มีสิทธิ์ที่จำเป็นสำหรับผู้ใช้ในการเข้าถึงฟีเจอร์ของบอท
    - บทบาทเริ่มต้น (@everyone) ไม่มีสิทธิ์ที่อันตราย
    - บทบาท GM และประกาศถูกตรวจสอบว่ามีการยกระดับสิทธิ์เกินกว่าบทบาทเริ่มต้นหรือไม่

    คำเตือนที่นี่เป็นเพียงคำแนะนำตามการตั้งค่าเริ่มต้น ขึ้นอยู่กับความต้องการของเซิร์ฟเวอร์ คุณอาจมีเหตุผลในการเพิกเฉยคำแนะนำบางอย่าง

config-wizard-default-role-label = {"**"}บทบาทเริ่มต้น:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: พบสิทธิ์ที่อันตราย:
config-wizard-default-role-ok = - ✅ @everyone: ตกลง
config-wizard-missing-permission = - ขาดสิทธิ์: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}บทบาท GM:{"**"}
config-wizard-no-gm-roles = - ⚠️ ไม่มีบทบาท GM ที่ตั้งค่า
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} บทบาทที่ตั้งค่าไม่พบ/ถูกลบจากเซิร์ฟเวอร์
config-wizard-role-ok = - ✅ { $roleMention }: ตกลง
config-wizard-announcement-role-label = {"**"}บทบาทประกาศ:{"**"}
config-wizard-no-announcement-role = - ℹ️ ไม่มีบทบาทประกาศที่ตั้งค่า
config-wizard-announcement-role-not-found = - ⚠️ บทบาทที่ตั้งค่าไม่พบ/ถูกลบจากเซิร์ฟเวอร์
config-wizard-escalation-detected = - ⚠️ { $roleMention }: ตรวจพบการยกระดับสิทธิ์ - { $escalations }
config-wizard-escalation-more = , และอีก { $count } รายการ...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = ส่งข้อความในกระทู้
config-wizard-perm-use-application-commands = ใช้คำสั่งแอปพลิเคชัน

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = จัดการช่อง
config-wizard-perm-manage-webhooks = จัดการเว็บฮุก
config-wizard-perm-manage-server = จัดการเซิร์ฟเวอร์
config-wizard-perm-manage-nicknames = จัดการชื่อเล่น
config-wizard-perm-kick-members = เตะสมาชิก
config-wizard-perm-ban-members = แบนสมาชิก
config-wizard-perm-timeout-members = พักสมาชิก
config-wizard-perm-mention-everyone = กล่าวถึง @everyone
config-wizard-perm-manage-threads = จัดการกระทู้
config-wizard-perm-administrator = ผู้ดูแลระบบ

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}การตั้งค่าช่อง{"**"}__
config-wizard-channel-desc =
    ส่วนนี้ตรวจสอบสิ่งต่อไปนี้:

    - ช่องที่ตั้งค่ามีอยู่จริง
    - บอทมีสิทธิ์ดูและส่งข้อความในช่องที่ตั้งค่า
    - บทบาทเริ่มต้น (@everyone) ไม่มีสิทธิ์ `ส่งข้อความ`

config-wizard-channel-no-config-required = - ⚠️ ไม่มีช่องที่ตั้งค่า
config-wizard-channel-not-configured = - ℹ️ ไม่ได้ตั้งค่า (ไม่บังคับ)
config-wizard-channel-not-found = - ⚠️ ช่องที่ตั้งค่าไม่พบ/ถูกลบจากเซิร์ฟเวอร์
config-wizard-channel-ok = - ✅ ตกลง
config-wizard-bot-cannot-view = - ⚠️ { $botMention } ไม่สามารถดูช่องนี้ได้
config-wizard-bot-cannot-send = - ⚠️ { $botMention } ไม่สามารถส่งข้อความในช่องนี้ได้
config-wizard-everyone-can-send = - ⚠️ @everyone สามารถส่งข้อความในช่องนี้ได้

# Wizard - Channel names
config-wizard-channel-quest-board = กระดาน Quest
config-wizard-channel-player-board = กระดานผู้เล่น
config-wizard-channel-quest-archive = คลัง Quest
config-wizard-channel-gm-transaction-log = บันทึกธุรกรรม GM
config-wizard-channel-player-transaction-log = บันทึกธุรกรรมผู้เล่น
config-wizard-channel-shop-log = บันทึกร้านค้า
config-wizard-channel-approval-queue = คิวอนุมัติตัวละคร

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}แดชบอร์ดการตั้งค่า{"**"}__
config-wizard-dashboard-desc = ส่วนนี้แสดงภาพรวมของการตั้งค่าที่ไม่จำเป็นเพื่ออ้างอิงอย่างรวดเร็ว
config-wizard-quest-settings = {"**"}การตั้งค่า Quest{"**"}
config-wizard-quest-wait-list = - ขนาดรายชื่อรอ Quest: { $size }
config-wizard-quest-summary = - สรุป Quest: { $status }
config-wizard-gm-rewards-per-quest = {"**"}รางวัล GM (ต่อ Quest){"**"}
config-wizard-player-settings = {"**"}การตั้งค่าผู้เล่น{"**"}
config-wizard-player-experience = - ประสบการณ์ผู้เล่น: { $status }
config-wizard-currency-settings = {"**"}การตั้งค่าสกุลเงิน{"**"}
config-wizard-rp-rewards = {"**"}รางวัลการเล่นสวมบทบาท{"**"}
config-wizard-rp-status = - สถานะ: { $status }
config-wizard-rp-mode = - โหมด: { $mode }
config-wizard-rp-channels = - ช่องที่ติดตาม: { $count }
config-wizard-shops = {"**"}ร้านค้า{"**"}
config-wizard-shops-count = - ร้านค้าที่ตั้งค่า: { $count }
config-wizard-shops-more = - ...และอีก { $count } ร้าน
config-wizard-new-char-setup = {"**"}การตั้งค่าตัวละครใหม่{"**"}
config-wizard-inventory-type = - ประเภทคลังไอเทม: { $type }
config-wizard-new-char-shop-items = - ไอเทมร้านค้าตัวละครใหม่: { $count }
config-wizard-static-kits = - ชุดสำเร็จรูป: { $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ ไม่มีสกุลเงินที่ตั้งค่า
config-wizard-configured-currencies = {"**"}สกุลเงินที่ตั้งค่า:{"**"}
config-wizard-no-denominations = - ไม่มีหน่วยย่อยที่ตั้งค่า
config-wizard-gm-rewards-disabled = {"**"}สถานะ:{"**"} ปิดใช้งาน
config-wizard-gm-rewards-enabled = {"**"}สถานะ:{"**"} เปิดใช้งาน
config-wizard-gm-rewards-experience = - ประสบการณ์: { $xp }
config-wizard-gm-rewards-items = - ไอเทม:
config-wizard-unnamed-shop = ร้านค้าไม่มีชื่อ

## Roles View
config-title-roles = {"**"}การตั้งค่าเซิร์ฟเวอร์ - บทบาท{"**"}
config-label-announcement-role = {"**"}บทบาทประกาศ:{"**"} { $status }
config-desc-announcement-role = บทบาทนี้จะถูกกล่าวถึงเมื่อมีการโพสต์ Quest
config-label-announcement-role-default = {"**"}บทบาทประกาศ:{"**"} ไม่ได้ตั้งค่า
config-label-gm-roles = {"**"}บทบาท GM:{"**"} { $roles }
config-desc-gm-roles = บทบาทเหล่านี้จะให้สิทธิ์เข้าถึงคำสั่งและฟีเจอร์ GM
config-label-gm-roles-default = {"**"}บทบาท GM:{"**"} ไม่ได้ตั้งค่า
config-title-forbidden-roles = __{"**"}บทบาทที่ห้ามใช้{"**"}__
config-desc-forbidden-roles =
    ตั้งค่ารายชื่อชื่อบทบาทที่ GM ไม่สามารถใช้สำหรับบทบาทปาร์ตี้ได้
    ตามค่าเริ่มต้น `everyone`, `administrator`, `gm` และ `game master` ไม่สามารถใช้ได้ การตั้งค่านี้
    เป็นการขยายรายชื่อดังกล่าว

## GM Role Remove View
config-title-remove-gm-roles = {"**"}การตั้งค่าเซิร์ฟเวอร์ - ลบบทบาท GM{"**"}
config-msg-no-gm-roles = ไม่มีบทบาท GM ที่ตั้งค่า

## Channels View
config-title-channels = {"**"}การตั้งค่าเซิร์ฟเวอร์ - ช่อง{"**"}

config-label-quest-board = {"**"}กระดาน Quest:{"**"} { $channel }
config-desc-quest-board = ช่องที่จะโพสต์ Quest ใหม่/ที่ใช้งานอยู่
config-label-quest-board-default = {"**"}กระดาน Quest:{"**"} ไม่ได้ตั้งค่า

config-label-player-board = {"**"}กระดานผู้เล่น:{"**"} { $channel }
config-desc-player-board = ช่องประกาศ/กระดานข้อความสำหรับผู้เล่น (ไม่บังคับ)
config-label-player-board-default = {"**"}กระดานผู้เล่น:{"**"} ไม่ได้ตั้งค่า

config-label-quest-archive = {"**"}คลัง Quest:{"**"} { $channel }
config-desc-quest-archive = ช่องสำหรับย้าย Quest ที่เสร็จสิ้นพร้อมข้อมูลสรุป (ไม่บังคับ)
config-label-quest-archive-default = {"**"}คลัง Quest:{"**"} ไม่ได้ตั้งค่า

config-label-gm-transaction-log = {"**"}บันทึกธุรกรรม GM:{"**"} { $channel }
config-desc-gm-transaction-log = ช่องสำหรับบันทึกธุรกรรม GM (เช่น คำสั่ง Modify Player) (ไม่บังคับ)
config-label-gm-transaction-log-default = {"**"}บันทึกธุรกรรม GM:{"**"} ไม่ได้ตั้งค่า

config-label-player-transaction-log = {"**"}บันทึกธุรกรรมผู้เล่น:{"**"} { $channel }
config-desc-player-transaction-log = ช่องสำหรับบันทึกธุรกรรมผู้เล่น เช่น การแลกเปลี่ยนและการใช้ไอเทม (ไม่บังคับ)
config-label-player-transaction-log-default = {"**"}บันทึกธุรกรรมผู้เล่น:{"**"} ไม่ได้ตั้งค่า

config-label-shop-log = {"**"}บันทึกร้านค้า:{"**"} { $channel }
config-desc-shop-log = ช่องสำหรับบันทึกธุรกรรมร้านค้า (ไม่บังคับ)
config-label-shop-log-default = {"**"}บันทึกร้านค้า:{"**"} ไม่ได้ตั้งค่า

## Quests View
config-title-quests = {"**"}การตั้งค่าเซิร์ฟเวอร์ - Quest{"**"}

config-label-wait-list = {"**"}ขนาดรายชื่อรอ Quest:{"**"} { $size }
config-desc-wait-list = รายชื่อรอช่วยให้ผู้เล่นจำนวนที่กำหนดสามารถเข้าคิวสำหรับ Quest ที่เต็มแล้ว ในกรณีที่ผู้เล่นออก
config-label-wait-list-disabled = {"**"}ขนาดรายชื่อรอ Quest:{"**"} ปิดใช้งาน

config-label-quest-summary = {"**"}สรุป Quest:{"**"} { $status }
config-desc-quest-summary = ตัวเลือกนี้ช่วยให้ GM สามารถให้สรุปสั้นๆ เมื่อปิด Quest
config-label-quest-summary-disabled = {"**"}สรุป Quest:{"**"} ปิดใช้งาน

config-label-gm-rewards = รางวัล GM
config-desc-gm-rewards = ตั้งค่ารางวัลสำหรับ GM ที่จะได้รับเมื่อ Quest เสร็จสิ้น

## GM Rewards View
config-title-gm-rewards = {"**"}การตั้งค่าเซิร์ฟเวอร์ - รางวัล GM{"**"}
config-desc-gm-rewards-detail =
    {"**"}เพิ่ม/แก้ไขรางวัล{"**"}
    เปิดหน้าต่างป้อนข้อมูลเพื่อเพิ่ม แก้ไข หรือลบรางวัล GM

    > รางวัลที่ตั้งค่าเป็นแบบต่อ Quest ทุกครั้งที่ GM ทำ Quest เสร็จ จะได้รับ
    รางวัลที่ตั้งค่าด้านล่างบนตัวละครที่ใช้งานอยู่
config-msg-no-rewards = ไม่มีรางวัลที่ตั้งค่า
config-label-gm-experience = {"**"}ประสบการณ์:{"**"} { $xp }
config-label-gm-items = {"**"}ไอเทม:{"**"}

## Players View
config-title-players = {"**"}การตั้งค่าเซิร์ฟเวอร์ - ผู้เล่น{"**"}

config-label-player-experience = {"**"}ประสบการณ์ผู้เล่น:{"**"} { $status }
config-desc-player-experience = เปิด/ปิดการใช้ค่าประสบการณ์ (หรือระบบความก้าวหน้าตัวละครที่คล้ายกัน)
config-label-player-experience-disabled = {"**"}ประสบการณ์ผู้เล่น:{"**"} ปิดใช้งาน

config-label-new-char-settings = {"**"}การตั้งค่าตัวละครใหม่{"**"}
config-desc-new-char-settings = ตั้งค่าที่เกี่ยวข้องกับตัวละครใหม่และวิธีตั้งค่าคลังไอเทมเริ่มต้น

config-label-player-board-purge = {"**"}ล้างกระดานผู้เล่น{"**"}
config-desc-player-board-purge = ล้างโพสต์จากกระดานผู้เล่น (ถ้าเปิดใช้งาน)

## New Character Settings View
config-title-new-character = {"**"}การตั้งค่าเซิร์ฟเวอร์ - การตั้งค่าตัวละครใหม่{"**"}

config-label-inventory-type = {"**"}ประเภทคลังไอเทมตัวละครใหม่:{"**"} { $type }
config-desc-inventory-type = กำหนดวิธีที่ตัวละครที่ลงทะเบียนใหม่จะเริ่มต้นคลังไอเทม
config-label-inventory-type-disabled = {"**"}ประเภทคลังไอเทมตัวละครใหม่:{"**"} ปิดใช้งาน

config-label-new-char-wealth = {"**"}ทรัพย์สินตัวละครใหม่:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}ทรัพย์สินตัวละครใหม่:{"**"} ปิดใช้งาน

config-label-approval-queue = {"**"}คิวอนุมัติ:{"**"} { $channel }
config-desc-approval-queue = หากตั้งค่าไว้ ตัวละครใหม่ต้องได้รับการอนุมัติจาก GM ในช่อง Forum นี้ก่อนจึงจะใช้งานได้
config-label-approval-queue-disabled = {"**"}คิวอนุมัติ:{"**"} ปิดใช้งาน
config-label-approval-queue-not-configured = {"**"}คิวอนุมัติ:{"**"} ไม่ได้ตั้งค่า

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = ผู้เล่นเริ่มต้นด้วยคลังไอเทมว่างเปล่า
config-desc-inv-type-selection = ผู้เล่นเลือกไอเทมอิสระจากร้านค้าตัวละครใหม่
config-desc-inv-type-purchase = ผู้เล่นซื้อไอเทมจากร้านค้าตัวละครใหม่ด้วยสกุลเงินที่กำหนด
config-desc-inv-type-open = ผู้เล่นป้อนไอเทมในคลังของตนเอง
config-desc-inv-type-static = ผู้เล่นได้รับคลังไอเทมเริ่มต้นที่กำหนดไว้ล่วงหน้า

## New Character Shop View
config-title-new-char-shop = {"**"}การตั้งค่าเซิร์ฟเวอร์ - ร้านค้าตัวละครใหม่{"**"}
config-label-inv-type-selection = {"**"}ประเภทคลังไอเทม:{"**"} เลือกเอง
config-desc-inv-type-selection-shop = ผู้เล่นเลือกไอเทมอิสระจากร้านค้าตัวละครใหม่
config-label-inv-type-purchase = {"**"}ประเภทคลังไอเทม:{"**"} ซื้อ
config-desc-inv-type-purchase-shop = ผู้เล่นซื้อไอเทมจากร้านค้าตัวละครใหม่ด้วยสกุลเงินที่กำหนด
config-label-inv-type-other = {"**"}ประเภทคลังไอเทม:{"**"} { $type }
config-desc-inv-type-not-in-use = ร้านค้าตัวละครใหม่ไม่ได้ใช้งาน
config-msg-define-shop-items = กำหนดไอเทมร้านค้า
config-msg-no-items = ไม่มีไอเทมที่ตั้งค่า

## Static Kits View
config-title-static-kits = {"**"}การตั้งค่าเซิร์ฟเวอร์ - ชุดสำเร็จรูป{"**"}
config-desc-create-kit = สร้างชุดใหม่
config-msg-no-kits = ไม่มีชุดที่ตั้งค่า
config-label-kit-more-items = ...และอีก { $count } ไอเทม
config-label-empty-kit = {"*"}ชุดว่างเปล่า{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}กำลังแก้ไขชุด: { $kitName }{"**"}
config-msg-kit-empty = ชุดนี้ว่างเปล่า ใช้ปุ่มด้านบนเพื่อเพิ่มสกุลเงินหรือไอเทม
config-label-kit-currency = {"**"}สกุลเงิน:{"**"} { $display }
config-label-kit-item = {"**"}ไอเทม:{"**"} { $name }

## Currency View
config-title-currency = {"**"}การตั้งค่าเซิร์ฟเวอร์ - สกุลเงิน{"**"}
config-desc-create-currency = สร้างสกุลเงินใหม่
config-msg-no-currencies = ไม่มีสกุลเงินที่ตั้งค่า
config-label-currency-display-type = ประเภทการแสดงผล: { $type } | หน่วยย่อย: { $count }
config-label-currency-type-double = ทศนิยม
config-label-currency-type-integer = จำนวนเต็ม

## Edit Currency View
config-title-manage-currency = {"**"}จัดการสกุลเงิน: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}สกุลเงินและหน่วยย่อย{"**"}__
    - ชื่อที่กำหนดให้สกุลเงินของคุณจะถือเป็นสกุลเงินหลักและมีมูลค่า 1
    {"```"}ตัวอย่าง: "gold" ถูกตั้งค่าเป็นสกุลเงิน{"```"}
    - การเพิ่มหน่วยย่อยต้องระบุชื่อและมูลค่าเทียบกับสกุลเงินหลัก
    {"```"}ตัวอย่าง: Gold ได้รับสองหน่วยย่อย: silver (มูลค่า 0.1) และ copper (มูลค่า 0.01){"```"}
    - ธุรกรรมใดๆ ที่เกี่ยวข้องกับสกุลเงินหลักหรือหน่วยย่อยจะถูกแปลงโดยอัตโนมัติ
    {"```"}ตัวอย่าง: ผู้เล่นมี 10 gold และใช้ 3 copper ยอดคงเหลือใหม่จะแสดงเป็น
    9 gold, 9 silver และ 7 copper โดยอัตโนมัติ{"```"}
    - สกุลเงินที่แสดงเป็นจำนวนเต็มจะแสดงแต่ละหน่วยย่อย ในขณะที่สกุลเงินที่แสดงเป็นทศนิยม
    จะแสดงเฉพาะสกุลเงินหลัก
    {"```"}ตัวอย่าง: ผู้เล่นข้างต้นที่เปิดการแสดงผลทศนิยมจะแสดงเป็น 9.97 gold{"```"}
config-btn-toggle-display-current = สลับการแสดงผล (ปัจจุบัน: { $type })
config-msg-no-denominations = ไม่มีหน่วยย่อยที่ตั้งค่า

## Shops View
config-title-shops = {"**"}การตั้งค่าเซิร์ฟเวอร์ - ร้านค้า{"**"}
config-desc-add-shop-wizard =
    {"**"}เพิ่มร้านค้า (วิซาร์ด){"**"}
    สร้างร้านค้าใหม่ว่างเปล่าจากแบบฟอร์ม
config-desc-add-shop-json =
    {"**"}เพิ่มร้านค้า (JSON){"**"}
    สร้างร้านค้าใหม่โดยให้ไฟล์ JSON ทั้งหมด (ขั้นสูง)
config-btn-example-json = ตัวอย่าง JSON
config-desc-example-json =
    {"**"}ตัวอย่าง JSON{"**"}
    ดาวน์โหลดไฟล์ JSON ตัวอย่างที่แสดงรูปแบบที่คาดหวัง
config-msg-example-json = นี่คือไฟล์ JSON ตัวอย่างที่แสดงรูปแบบที่คาดหวัง
config-msg-no-shops = ไม่มีร้านค้าที่ตั้งค่า
config-label-shop-type-forum = (Forum)
config-label-shop-channel = ช่อง: <#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}เพิ่มร้านค้า - เลือกประเภทตำแหน่ง{"**"}
config-label-text-channel = {"**"}ช่องข้อความ{"**"}
config-desc-text-channel = สร้างร้านค้าในช่องข้อความปกติ
config-label-forum-thread = {"**"}กระทู้ Forum{"**"}
config-desc-forum-thread = สร้างร้านค้าในกระทู้ Forum (ใหม่หรือที่มีอยู่)

## Forum Shop Setup View
config-title-forum-setup = {"**"}เพิ่มร้านค้า - ตั้งค่ากระทู้ Forum{"**"}
config-label-step1 = {"**"}ขั้นตอนที่ 1: เลือกช่อง Forum{"**"}
config-label-step2 = {"**"}ขั้นตอนที่ 2: เลือกตัวเลือกกระทู้{"**"}
config-label-step3 = {"**"}ขั้นตอนที่ 3: เลือกกระทู้ที่มีอยู่{"**"}
config-desc-create-new-thread =
    {"**"}สร้างกระทู้ใหม่{"**"}
    เปิดแบบฟอร์มเพื่อสร้างกระทู้ใหม่และตั้งค่าร้านค้า
config-label-selected-thread = {"**"}กระทู้ที่เลือก:{"**"} { $threadName }
config-desc-click-to-configure = คลิกเพื่อตั้งค่าร้านค้าในกระทู้นี้

## Manage Shop View
config-title-manage-shop = {"**"}จัดการร้านค้า: { $shopName }{"**"}
config-label-shop-type = {"**"}ประเภท:{"**"} { $type }
config-label-shop-type-text = ช่องข้อความ
config-label-shop-type-forum-thread = กระทู้ Forum
config-label-shopkeeper = {"**"}เจ้าของร้าน:{"**"} { $name }
config-label-shop-description = {"**"}คำอธิบาย:{"**"} { $description }
config-label-shop-channel-info = {"**"}ช่อง:{"**"} <#{ $channelId }>
config-desc-edit-wizard = แก้ไขรายละเอียดร้านค้าและไอเทมผ่านวิซาร์ด
config-desc-upload-json = อัปโหลดไฟล์ JSON ใหม่สำหรับร้านค้านี้
config-desc-download-json = ดาวน์โหลดไฟล์ JSON ปัจจุบัน
config-desc-remove-shop = ลบร้านค้านี้อย่างถาวร

## Edit Shop View
config-title-editing-shop = {"**"}กำลังแก้ไขร้านค้า: { $shopName }{"**"}
config-label-shop-shopkeeper = เจ้าของร้าน: {"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}การตั้งค่าสินค้าคงเหลือ: { $shopName }{"**"}
config-label-current-utc = เวลา UTC ปัจจุบัน: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}ตารางเติมสินค้า:{"**"} { $schedule }
config-label-restock-hourly = ที่นาที :{ $minute }
config-label-restock-daily = เวลา { $time } UTC
config-label-restock-weekly = วัน{ $day } เวลา { $time } UTC
config-label-restock-mode = {"**"}โหมด:{"**"} { $mode }
config-label-restock-full = เติมสินค้าเต็ม
config-label-restock-incremental = เพิ่ม { $amount } ต่อรอบ (ไม่เกินค่าสูงสุด)
config-label-restock-disabled = {"**"}ตารางเติมสินค้า:{"**"} ปิดใช้งาน
config-label-item-stock-limits = {"**"}ขีดจำกัดสินค้าคงเหลือ{"**"}
config-msg-no-items-in-shop = ไม่มีไอเทมในร้านค้านี้
config-label-stock-with-available = สูงสุด: { $max } | มีอยู่: { $available }
config-label-stock-reserved = | จองแล้ว: { $reserved }
config-label-stock-not-initialized = สูงสุด: { $max } | มีอยู่: (ยังไม่เริ่มต้น)
config-label-stock-unlimited = สินค้าคงเหลือ: ไม่จำกัด

## Roleplay View
config-title-roleplay = {"**"}การตั้งค่าเซิร์ฟเวอร์ - รางวัลการเล่นสวมบทบาท{"**"}
config-label-rp-status = {"**"}สถานะ:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}เวลาเซิร์ฟเวอร์:{"**"} `{ $time }`
config-label-rp-enabled = เปิดใช้งาน
config-label-rp-disabled = ปิดใช้งาน

config-desc-rp-mode-scheduled = {"```"}รางวัลจะแจกจ่ายครั้งเดียว เมื่อส่งข้อความที่มีสิทธิ์ตามจำนวนเกณฑ์ที่กำหนดภายในช่วงเวลาที่ตั้งไว้ (ทุกชั่วโมง, ทุกวัน หรือทุกสัปดาห์){"```"}
config-desc-rp-mode-accrued = {"```"}รางวัลจะแจกจ่ายซ้ำทุกครั้งที่ส่งข้อความที่มีสิทธิ์ตามจำนวนที่กำหนด{"```"}

config-label-rp-config-details = {"**"}รายละเอียดการตั้งค่า:{"**"}
config-label-rp-mode = {"**"}โหมด:{"**"} { $mode }
config-label-rp-min-length = {"**"}ความยาวข้อความขั้นต่ำ:{"**"} { $length } ตัวอักษร
config-label-rp-cooldown = {"**"}คูลดาวน์:{"**"} { $seconds } วินาที
config-label-rp-frequency-once = {"**"}ความถี่:{"**"} ครั้งเดียวต่อ { $period }
config-label-rp-reset-time = {"**"}เวลารีเซ็ต:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}เกณฑ์:{"**"} { $count } ข้อความที่มีสิทธิ์
config-label-rp-frequency-every = {"**"}ความถี่:{"**"} ทุก { $count } ข้อความที่มีสิทธิ์

config-label-rp-channels = {"**"}ช่องการเล่นสวมบทบาท:{"**"}
config-msg-rp-no-channels = ไม่ได้ตั้งค่า
config-label-rp-channels-more = ...และอีก { $count } ช่อง

config-label-rp-rewards = {"**"}รางวัล:{"**"}
config-msg-rp-no-rewards = ไม่ได้ตั้งค่า
config-label-rp-experience = {"**"}ประสบการณ์:{"**"} { $xp }
config-label-rp-items = {"**"}ไอเทม:{"**"}
config-label-rp-currency = {"**"}สกุลเงิน:{"**"}

## Language View
config-title-language = {"**"}การตั้งค่าเซิร์ฟเวอร์ - ภาษา{"**"}
config-server-language-help =
    การตั้งค่านี้ช่วยให้คุณระบุภาษาเริ่มต้นสำหรับการตอบกลับและข้อความ{"**"}สาธารณะ{"**"}ของ ReQuest ในเซิร์ฟเวอร์นี้ การตอบกลับสาธารณะรวมถึง:
    - โพสต์กระดาน Quest และกระดานผู้เล่น
    - สรุป Quest และข้อความบันทึกช่อง
    - การเติมสินค้าร้านค้า
    - การใช้ไอเทมของผู้เล่น

    การตั้งค่านี้มีผลกับข้อความคงที่ที่สร้างโดยบอทเท่านั้น และไม่แปลเนื้อหาแบบไดนามิก เช่น ชื่อไอเทมหรือคำอธิบาย Quest ที่ผู้ใช้ป้อน

    การตอบกลับส่วนตัวและเมนูไม่ได้รับผลกระทบจากการตั้งค่านี้
config-label-server-language = {"**"}ภาษาเซิร์ฟเวอร์:{"**"} { $language }
config-label-server-language-default = {"**"}ภาษาเซิร์ฟเวอร์:{"**"} ค่าเริ่มต้น (ไม่มีการแทนที่)
config-select-placeholder-server-language = เลือกภาษาเซิร์ฟเวอร์
config-select-option-default = ค่าเริ่มต้น (ไม่มีการแทนที่)
config-select-desc-default = ใช้การตั้งค่าของผู้ใช้แต่ละคนหรือภาษาของ Discord

# Quest Roles
config-btn-quest-roles = บทบาท Quest
config-btn-manage-gm-quest-roles = จัดการ

config-modal-title-confirm-quest-role-removal = ยืนยันการลบบทบาท
config-modal-label-remove-quest-role = ลบ { $roleName } จาก { $gmName }?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = เลือกโหมดบทบาท Quest
config-select-option-quest-role-disabled = ปิดใช้งาน
config-select-desc-quest-role-disabled = ไม่มีการสร้างหรือกำหนดบทบาท
config-select-option-quest-role-temporary = ชั่วคราว
config-select-desc-quest-role-temporary = GM สามารถสร้างบทบาทชั่วคราวต่อ quest ได้
config-select-option-quest-role-static = คงที่
config-select-desc-quest-role-static = GM เลือกจากบทบาทเซิร์ฟเวอร์ที่กำหนดไว้ล่วงหน้า

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = กำหนดบทบาทเซิร์ฟเวอร์ให้ GM นี้

## Quest Roles View
config-title-quest-roles = {"**"}การตั้งค่าเซิร์ฟเวอร์ - บทบาท Quest{"**"}
config-label-quest-roles = บทบาท Quest
config-desc-quest-roles =
    ตั้งค่าวิธีจัดการบทบาทปาร์ตี้ระหว่าง quest

config-label-quest-role-mode-disabled = {"**"}โหมดบทบาท Quest:{"**"} ปิดใช้งาน
    ไม่มีการสร้างหรือกำหนดบทบาทระหว่าง quest
config-label-quest-role-mode-temporary = {"**"}โหมดบทบาท Quest:{"**"} ชั่วคราว
    GM สามารถสร้างบทบาทชั่วคราวเมื่อสร้าง quest ได้ตามต้องการ
    บทบาทจะถูกลบเมื่อ quest เสร็จสมบูรณ์หรือถูกยกเลิก
config-label-quest-role-mode-static = {"**"}โหมดบทบาท Quest:{"**"} คงที่
    GM เลือกจากบทบาทเซิร์ฟเวอร์ที่กำหนดไว้ล่วงหน้า บทบาทจะถูกกำหนดให้
    สมาชิกปาร์ตี้ระหว่าง quest แต่จะไม่ถูกลบ

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}การตั้งค่าเซิร์ฟเวอร์ - การกำหนดบทบาท Quest แบบคงที่{"**"}
config-label-manage-assignments = จัดการการกำหนดบทบาท
config-desc-manage-assignments =
    กำหนดบทบาทเซิร์ฟเวอร์ที่มีอยู่ให้ GM สำหรับใช้ระหว่าง quest
    บทบาทต้องอยู่ต่ำกว่าบทบาทสูงสุดของ ReQuest ในลำดับชั้นของเซิร์ฟเวอร์
config-msg-no-gm-members = ไม่พบสมาชิกที่มีบทบาท GM บนเซิร์ฟเวอร์นี้
config-label-no-roles-assigned = ไม่มีบทบาท quest ที่กำหนด

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}จัดการบทบาท Quest — { $gmName }{"**"}
config-error-unmanageable-roles = บทบาทต่อไปนี้ไม่สามารถกำหนดได้เนื่องจากถูกจัดการโดยการเชื่อมต่อ เป็นบทบาทเริ่มต้น หรืออยู่เหนือบทบาทสูงสุดของ ReQuest: { $roles }
config-error-quest-role-limit = GM นี้ถึงจำนวนสูงสุด { $limit } บทบาท quest ที่กำหนดแล้ว
config-label-quest-role-count = บทบาทที่กำหนด: { $count }/{ $limit }
