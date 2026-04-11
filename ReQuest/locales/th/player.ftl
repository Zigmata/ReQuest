## Player module strings

# --- Cog ---

player-cmd-name = แลกเปลี่ยน
player-cmd-desc = เมนูผู้เล่น

# --- Buttons ---

# Character management
player-btn-register-character = ลงทะเบียนตัวละครใหม่
player-btn-activate = เปิดใช้งาน
player-btn-active = ใช้งานอยู่

# Player board
player-btn-create-post = สร้างโพสต์
player-btn-open-starting-shop = เปิดร้านค้าเริ่มต้น
player-btn-select-kit = เลือกชุด
player-btn-input-inventory = กรอกคลังไอเทม

# Wizard / shop buttons
player-btn-add-to-cart = เพิ่มลงตะกร้า
player-btn-add-to-cart-cost = เพิ่มลงตะกร้า ({ $costString })
player-btn-view-purchase-options = ดูตัวเลือกการซื้อ
player-btn-review-submit = ตรวจสอบและส่ง ({ $count })
player-btn-submit-character = ส่งตัวละคร
player-btn-keep-shopping = เลือกซื้อต่อ
player-btn-edit-quantity = แก้ไขจำนวน
player-btn-clear-cart = ล้างตะกร้า

# Kit buttons
player-btn-confirm-selection = ยืนยันการเลือก
player-btn-back-to-kits = กลับไปที่ชุด

# Inventory management
player-btn-spend-currency = ใช้สกุลเงิน
player-btn-print-inventory = พิมพ์คลังไอเทม

# Container management
player-btn-manage-containers = จัดการภาชนะ
player-btn-create-new = + สร้างใหม่
player-btn-consume-destroy = ใช้/ทำลาย
player-btn-move = ย้าย
player-btn-move-all = ย้ายทั้งหมด
player-btn-move-some = ย้ายบางส่วน...
player-btn-back-to-overview = ← กลับไปภาพรวม
player-btn-cancel-move = ← ยกเลิก
player-btn-up = ▲ ขึ้น
player-btn-down = ▼ ลง

# --- Modals ---

# Trade modal
player-modal-title-trade = กำลังแลกเปลี่ยนกับ { $targetName }
player-modal-label-trade-name = ชื่อ
player-modal-placeholder-trade-name = กรอกชื่อไอเทมที่จะแลกเปลี่ยน
player-modal-label-trade-quantity = จำนวน
player-modal-placeholder-trade-quantity = กรอกจำนวนที่จะแลกเปลี่ยน

# Character register modal
player-modal-title-register = ลงทะเบียนตัวละครใหม่
player-modal-label-char-name = ชื่อ
player-modal-placeholder-char-name = กรอกชื่อตัวละครของคุณ
player-modal-label-char-note = หมายเหตุ
player-modal-placeholder-char-note = กรอกหมายเหตุเพื่อระบุตัวละครของคุณ

# Open inventory input modal
player-modal-title-starting-inventory = กรอกคลังไอเทมเริ่มต้น
player-modal-label-inventory = คลังไอเทม
player-modal-placeholder-inventory-input =
    บรรทัดละรายการ ในรูปแบบ <ชื่อ>: <จำนวน> เช่น:
    ดาบ: 1
    gold: 30

# Spend currency modal
player-modal-title-spend-currency = ใช้สกุลเงิน
player-modal-label-currency-name = ชื่อสกุลเงิน
player-modal-placeholder-currency-name = กรอกชื่อสกุลเงินที่จะใช้
player-modal-label-currency-amount = จำนวน
player-modal-placeholder-currency-amount = กรอกจำนวนที่จะใช้

# Create player post modal
player-modal-title-create-post = สร้างโพสต์กระดานผู้เล่น
player-modal-label-post-title = ชื่อเรื่อง
player-modal-placeholder-post-title = กรอกชื่อเรื่องสำหรับโพสต์ของคุณ
player-modal-label-post-content = เนื้อหาโพสต์
player-modal-placeholder-post-content = กรอกเนื้อหาของโพสต์ของคุณ

# Edit player post modal
player-modal-title-edit-post = แก้ไขโพสต์กระดานผู้เล่น

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = แก้ไขจำนวนในตะกร้า
player-modal-label-cart-qty = จำนวน
player-modal-placeholder-cart-qty = กรอกจำนวนใหม่ (0 เพื่อลบ)

# Create container modal
player-modal-title-create-container = สร้างภาชนะใหม่
player-modal-label-container-name = ชื่อภาชนะ
player-modal-placeholder-container-name = กรอกชื่อสำหรับภาชนะของคุณ (เช่น กระเป๋าเป้)

# Rename container modal
player-modal-title-rename-container = เปลี่ยนชื่อภาชนะ
player-modal-label-new-container-name = ชื่อภาชนะใหม่
player-modal-placeholder-new-container-name = กรอกชื่อใหม่

# Consume from container modal
player-modal-title-consume = ใช้/ทำลายไอเทม
player-modal-label-consume-qty = จำนวน (สูงสุด: { $maxQuantity })
player-modal-placeholder-consume-qty = กรอกจำนวนที่จะใช้/ทำลาย

# Move item quantity modal
player-modal-title-move-item = ย้ายไอเทม
player-modal-label-move-qty = จำนวนที่จะย้าย (สูงสุด: { $maxQuantity })
player-modal-placeholder-move-qty = กรอกจำนวนที่จะย้าย

# --- Selects ---

player-select-placeholder-no-characters = คุณไม่มีตัวละครที่ลงทะเบียนไว้
player-select-placeholder-remove-character = เลือกตัวละครที่จะลบ
player-select-placeholder-post = เลือกโพสต์
player-select-placeholder-container-view = เลือกภาชนะเพื่อดู...
player-select-placeholder-item = เลือกไอเทม...
player-select-placeholder-destination = เลือกปลายทาง...
player-select-placeholder-container = เลือกภาชนะ...
player-select-option-no-containers = ไม่มีภาชนะ
player-select-option-no-items = ไม่มีไอเทม
player-select-option-no-destinations = ไม่มีปลายทาง

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}คำสั่งผู้เล่น - เมนูหลัก{"**"}
player-menu-btn-characters = ตัวละคร
player-menu-desc-characters = ลงทะเบียน ดู และเปิดใช้งานตัวละครผู้เล่น
player-menu-btn-inventory = คลังไอเทม
player-menu-desc-inventory = ดูคลังไอเทมของตัวละครที่ใช้งานอยู่และใช้สกุลเงิน
player-menu-btn-player-board = กระดานผู้เล่น
player-menu-btn-player-board-disabled = กระดานผู้เล่น (ยังไม่ได้ตั้งค่า)
player-menu-desc-player-board = สร้างโพสต์สำหรับกระดานผู้เล่น

# CharacterBaseView
player-title-characters = {"**"}คำสั่งผู้เล่น - ตัวละคร{"**"}
player-desc-register-character = ลงทะเบียนตัวละครใหม่
player-msg-no-characters = คุณไม่มีตัวละครที่ลงทะเบียนไว้
player-label-active = (ใช้งานอยู่)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}ตัวละครที่กำลังดำเนินการ: { $characterName }{"**"}
    การลงทะเบียนตัวละครของคุณรอการตั้งค่าสิ่งของ
player-btn-resume = ดำเนินการต่อ
player-btn-discard = ยกเลิก
player-modal-title-discard-character = ยกเลิกตัวละคร
player-modal-label-discard-confirm = ยกเลิก { $characterName }?

# Confirm character removal
player-modal-title-confirm-char-removal = ยืนยันการลบตัวละคร
player-modal-label-confirm-char-delete = ลบ { $characterName }?

# Confirm post removal
player-modal-title-confirm-post-removal = ยืนยันการลบโพสต์
player-modal-label-post-removal-warning = คำเตือน: การกระทำนี้ไม่สามารถย้อนกลับได้!

# InventoryOverviewView
player-title-inventory = {"**"}คำสั่งผู้เล่น - คลังไอเทม{"**"}
player-title-char-inventory = {"**"}คลังไอเทมของ { $characterName }{"**"}
player-msg-no-active-character = ไม่มีตัวละครที่ใช้งาน: เปิดใช้งานตัวละครสำหรับเซิร์ฟเวอร์นี้เพื่อใช้เมนูเหล่านี้
player-msg-no-characters-registered = ไม่มีตัวละคร: ลงทะเบียนตัวละครเพื่อใช้เมนูเหล่านี้
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } ไอเทม
player-label-currency = {"**"}สกุลเงิน{"**"}
player-msg-inventory-empty = คลังไอเทมว่างเปล่า

# Print inventory embed
player-embed-title-inventory = คลังไอเทมของ { $characterName }

# ContainerItemsView
player-msg-container-empty = ภาชนะนี้ว่างเปล่า
player-label-selected-item = เลือก: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}ย้าย "{ $itemName }"{"**"} (มี { $available })
player-msg-no-other-containers = ไม่มีภาชนะอื่น
player-msg-select-destination = เลือกภาชนะปลายทาง:
player-label-destination = ปลายทาง: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}จัดการภาชนะ{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } ไอเทม){ $suffix }
player-label-default-suffix = { " " }(ค่าเริ่มต้น)
player-msg-no-containers = ไม่มีภาชนะ
player-label-selected-container = เลือก: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = ยืนยันการลบภาชนะ
player-modal-label-container-has-items = มี { $itemCount } ไอเทม จะย้ายไปยังไอเทมหลวม
player-modal-label-confirm-container-delete = ลบ "{ $containerName }"?

# Container errors
player-error-cannot-rename-loose = ไม่สามารถเปลี่ยนชื่อไอเทมหลวมได้
player-error-cannot-delete-loose = ไม่สามารถลบไอเทมหลวมได้

# PlayerBoardView
player-title-player-board = {"**"}คำสั่งผู้เล่น - กระดานผู้เล่น{"**"}
player-desc-create-post = สร้างโพสต์ใหม่สำหรับกระดานผู้เล่น
player-msg-no-posts = คุณไม่มีโพสต์ในขณะนี้
player-label-post-info = {"**"}{ $title }{"**"} (รหัส: `{ $postId }`)
player-embed-field-author = ผู้เขียน
player-embed-footer-post-id = ID โพสต์: { $postId }
player-error-board-channel-not-found = ไม่พบช่องกระดานผู้เล่น

# NewCharacterWizardView
player-title-setup-inventory = {"**"}ตั้งค่าคลังไอเทมสำหรับ { $characterName }{"**"}
player-desc-browse-shop = เรียกดูร้านค้าเริ่มต้นเพื่อจัดเตรียมตัวละครของคุณ
player-desc-select-kit = เลือกชุดเริ่มต้น
player-desc-input-inventory = กรอกคลังไอเทมเริ่มต้นด้วยตนเอง

# StaticKitSelectView
player-title-select-kit = {"**"}เลือกชุดสำหรับ { $characterName }{"**"}
player-msg-no-kits = ไม่มีชุดเริ่มต้น
player-label-and-more-items = ...และอีก { $count } ไอเทม
player-label-empty-kit = {"*"}ชุดว่างเปล่า{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}ยืนยันการเลือก: { $kitName }{"**"}
player-label-items-heading = {"**"}ไอเทม:{"**"}
player-label-currency-heading = {"**"}สกุลเงิน:{"**"}
player-msg-kit-empty = ชุดนี้ว่างเปล่า

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}ตัวเลือกการซื้อ: { $itemName }{"**"}
player-msg-no-cost-options = ไอเทมนี้ไม่มีตัวเลือกราคา
player-label-cost-option = {"**"}ตัวเลือก { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}ร้านค้าเริ่มต้น ({ $inventoryType }){"**"}
player-label-starting-wealth = ทรัพย์สินเริ่มต้น: { $formattedCurrency }
player-label-in-cart = {"**"}(ในตะกร้า: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}ตรวจสอบตะกร้า{"**"}
player-msg-cart-empty = ตะกร้าของคุณว่างเปล่า
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (รวม: { $totalQuantity })
player-label-insufficient-currency = { $currencyName } ไม่เพียงพอ
player-label-total-cost = {"**"}ราคารวม:{"**"}
player-label-total-cost-free = {"**"}ราคารวม:{"**"} ฟรี
player-label-cart-page = หน้า { $current } จาก { $total }

# Trade embed
player-embed-title-trade = รายงานการแลกเปลี่ยน
player-embed-desc-trade-sender = ผู้ส่ง: { $senderMention } ในฐานะ `{ $senderCharacter }`
player-embed-desc-trade-recipient = ผู้รับ: { $recipientMention } ในฐานะ `{ $recipientCharacter }`
player-embed-field-currency = สกุลเงิน
player-embed-field-amount = จำนวน
player-embed-field-balance = ยอดคงเหลือของ { $characterName }
player-embed-field-item = ไอเทม
player-embed-field-quantity = จำนวน
player-embed-footer-transaction-id = ID ธุรกรรม: { $transactionId }

# Trade errors
player-error-trade-no-characters = ผู้เล่นที่คุณพยายามแลกเปลี่ยนด้วยไม่มีตัวละคร!
player-error-trade-no-active = ผู้เล่นที่คุณพยายามแลกเปลี่ยนด้วยไม่มีตัวละครที่ใช้งานอยู่บนเซิร์ฟเวอร์นี้!

# Spend currency embed
player-embed-title-spend = รายงานธุรกรรมผู้เล่น
player-embed-desc-spend-player = ผู้เล่น: { $playerMention } ในฐานะ `{ $characterName }`
player-embed-desc-spend-transaction = ธุรกรรม: {"**"}{ $characterName }{"**"} ใช้ {"**"}{ $formattedAmount }{"**"}
player-embed-field-channel = ช่อง
player-embed-field-receipt = ใบเสร็จ

# Spend currency errors
player-error-amount-not-number = จำนวนต้องเป็นตัวเลข
player-error-amount-positive = คุณต้องใช้จำนวนที่เป็นบวก
player-error-amount-exceeds-maximum = จำนวนต้องไม่เกิน { $max }
player-error-no-active-character-server = คุณไม่มีตัวละครที่ใช้งานอยู่บนเซิร์ฟเวอร์นี้
player-error-no-currency-config = ไม่พบการตั้งค่าสกุลเงินสำหรับเซิร์ฟเวอร์นี้

# Consume item embed
player-embed-title-consume = รายงานการใช้ไอเทม
player-embed-desc-consume = ผู้เล่น: { $playerMention } ในฐานะ `{ $characterName }`
player-embed-desc-consume-removed = ลบแล้ว: {"**"}{ $quantity }x { $itemName }{"**"} จาก {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = จำนวนต้องเป็นจำนวนเต็มบวก
player-error-qty-at-least-one = จำนวนต้องอย่างน้อย 1
player-error-qty-only-have = คุณมีไอเทมนี้เพียง { $maxQuantity }

# Inventory input errors
player-error-invalid-format = รูปแบบไม่ถูกต้อง: "{ $line }" ใช้รูปแบบ <ชื่อ>: <จำนวน>
player-error-empty-name = ชื่อไอเทมต้องไม่ว่างเปล่าในบรรทัด: "{ $line }"
player-error-invalid-quantity = จำนวนไม่ถูกต้องสำหรับ "{ $name }": "{ $quantity }" ต้องเป็นจำนวนเต็มบวก
player-error-input-errors-header = ข้อผิดพลาดในการกรอกคลังไอเทม:
player-msg-no-valid-items = ไม่มีไอเทมที่ถูกต้อง เริ่มต้นด้วยคลังไอเทมว่าง

# Validation error view
player-validation-error-title = ข้อผิดพลาดในการป้อนข้อมูล
player-validation-btn-retry = ลองอีกครั้ง

# Cart quantity validation
player-error-enter-valid-number = กรุณากรอกตัวเลขบวกที่ถูกต้อง

# Submission embeds (approval queue)
player-embed-title-approval = การอนุมัติคลังไอเทม: { $characterName }
player-embed-desc-submitted-by = ส่งโดย { $userMention }
player-embed-field-items = ไอเทม
player-embed-field-currency-received = สกุลเงิน
player-embed-footer-submission-id = ID การส่ง: { $submissionId }
player-label-approval-thread = การอนุมัติ: { $characterName }
player-embed-title-submission-sent = ส่งคลังไอเทมแล้ว
player-embed-desc-submission-sent =
    การส่งของคุณสำหรับ {"**"}{ $characterName }{"**"} ถูกส่งไปยังทีม GM เพื่อรอการอนุมัติแล้ว!
    คุณจะได้รับแจ้งเมื่อมีการตรวจสอบ
    [ดูเธรดการส่ง]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = ใช้คลังไอเทมเริ่มต้นแล้ว
player-embed-desc-starting-inventory = ผู้เล่น: { $playerMention } ในฐานะ `{ $characterName }`
player-embed-field-items-received = ไอเทมที่ได้รับ
player-embed-field-currency-received-label = สกุลเงินที่ได้รับ
player-label-untitled = ไม่มีชื่อ

# ApprovalPostView
player-approval-post-header =
    {"**"}การส่งรายการไอเทม: { $characterName }{"**"}
    ส่งโดย { $userMention }
player-approval-post-items = สิ่งของ
player-approval-post-currency = สกุลเงิน
player-approval-resolved = คำขอนี้ได้รับการดำเนินการแล้ว
player-approval-btn-approve = อนุมัติ
player-approval-btn-deny = ปฏิเสธ
player-approval-btn-edit = แก้ไข
player-approval-error-no-permission = คุณไม่มีสิทธิ์ดำเนินการนี้
player-approval-error-not-submitter = เฉพาะผู้ส่งดั้งเดิมเท่านั้นที่สามารถแก้ไขคำขอนี้ได้
player-approval-thread-instructions =
    กระทู้นี้ถูกสร้างขึ้นเพื่อการอนุมัติ {"**"}{ $characterName }{"**"}
    Game Master จะตรวจสอบคำขอและอนุมัติหรือปฏิเสธ
    เมื่ออนุมัติหรือปฏิเสธแล้ว กระทู้นี้จะถูกล็อค

    {"**"}Game Masters:{"**"} พูดคุยเกี่ยวกับการเปลี่ยนแปลงที่จำเป็นกับ
    ผู้เล่นของคุณจนกว่ารายการไอเทมจะอยู่ในสถานะที่ยอมรับได้ ใช้ปุ่ม
    `ปฏิเสธ` สำหรับคำขอที่ไม่สามารถแก้ไขได้เท่านั้น

    { $playerMention }: ใช้ปุ่ม `แก้ไข` เพื่อทำการเปลี่ยนแปลง
    ที่ Game Master ร้องขอที่นี่
player-approval-approved-by = คำขอนี้ได้รับการอนุมัติจาก { $approver }
player-approval-denied-by = คำขอนี้ถูกปฏิเสธโดย { $denier }
player-approval-deny-reason = เหตุผล: { $reason }
player-msg-submission-updated = คำขอของคุณได้รับการอัปเดตแล้ว


# Denial modal
player-modal-title-deny-reason = ปฏิเสธคำขอ
player-modal-label-deny-reason = เหตุผลในการปฏิเสธ
player-modal-placeholder-deny-reason = ไม่บังคับ: อธิบายเหตุผลที่ปฏิเสธ
# Approval DM notifications
player-dm-title-approved = ตัวละครได้รับอนุมัติ
player-dm-desc-approved =
    ตัวละคร {"**"}{ $characterName }{"**"} ของคุณได้รับการอนุมัติ
    โดย { $approver } ใน {"**"}{ $guildName }{"**"}!
player-dm-title-denied = ตัวละครถูกปฏิเสธ
player-dm-desc-denied =
    ตัวละคร {"**"}{ $characterName }{"**"} ของคุณถูกปฏิเสธ
    โดย { $denier } ใน {"**"}{ $guildName }{"**"}
