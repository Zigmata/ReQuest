## Game Master module strings

# GM buttons
gm-btn-create = สร้าง
gm-btn-edit-details = แก้ไขรายละเอียด
gm-btn-toggle-ready = สลับสถานะพร้อม
gm-btn-configure-rewards = ตั้งค่ารางวัล
gm-btn-remove-player = ลบผู้เล่น
gm-btn-cancel-quest = ยกเลิก Quest
gm-btn-manage-party-rewards = จัดการรางวัลปาร์ตี้
gm-btn-manage-individual-rewards = จัดการรางวัลรายบุคคล
gm-btn-join = เข้าร่วม
gm-btn-leave = ออก
gm-btn-complete-quest = จบ Quest
gm-btn-review-submission = ตรวจสอบการส่ง
gm-btn-approve = อนุมัติ
gm-btn-deny = ปฏิเสธ

# GM modals
gm-modal-title-create-quest = สร้าง Quest ใหม่
gm-modal-label-quest-title = ชื่อ Quest
gm-modal-placeholder-quest-title = ชื่อของ quest ของคุณ
gm-modal-label-restrictions = ข้อจำกัด
gm-modal-placeholder-restrictions = ข้อจำกัด (ถ้ามี) เช่น ระดับของผู้เล่น
gm-modal-label-max-party = ขนาดปาร์ตี้สูงสุด
gm-modal-placeholder-max-party = ขนาดสูงสุดของปาร์ตี้สำหรับ quest นี้
gm-modal-label-party-role = บทบาทปาร์ตี้
gm-modal-placeholder-party-role = สร้างบทบาทสำหรับ quest นี้ (ไม่บังคับ)
gm-modal-label-description = รายละเอียด
gm-modal-placeholder-description = เขียนรายละเอียดของ quest ที่นี่
gm-modal-title-editing-quest = กำลังแก้ไข { $questTitle }
gm-modal-label-title = ชื่อ
gm-modal-label-max-party-size = ขนาดปาร์ตี้สูงสุด
gm-modal-title-add-reward = เพิ่มรางวัล
gm-modal-label-experience = แต้มประสบการณ์
gm-modal-placeholder-experience = กรอกตัวเลข
gm-modal-label-items = ไอเทม
gm-modal-placeholder-items =
    ไอเทม: จำนวน
    ไอเทม2: จำนวน
    ฯลฯ
gm-modal-title-add-summary = เพิ่มสรุป Quest
gm-modal-label-summary = สรุป
gm-modal-placeholder-summary = เพิ่มสรุปเรื่องราวของ quest
gm-modal-title-modifying-player = กำลังแก้ไข { $playerName }
gm-modal-placeholder-xp-add-remove = กรอกตัวเลขบวกหรือลบ
gm-modal-label-inventory = คลังไอเทม
gm-modal-placeholder-inventory-modify =
    ไอเทม: จำนวน
    ไอเทม2: จำนวน
    ฯลฯ
gm-modal-title-review-submission = ตรวจสอบการส่ง
gm-modal-label-submission-id = ID การส่ง
gm-modal-placeholder-submission-id = กรอก ID 8 ตัวอักษร

# GM errors
gm-error-forbidden-role-name = ชื่อที่ใช้สำหรับบทบาทปาร์ตี้ไม่ได้รับอนุญาต
gm-error-role-already-exists = มีบทบาทที่ใช้ชื่อนี้อยู่แล้วในเซิร์ฟเวอร์นี้
gm-error-no-quest-channel = ยังไม่ได้กำหนดช่องสำหรับโพสต์ quest ติดต่อผู้ดูแลเซิร์ฟเวอร์เพื่อตั้งค่าช่อง Quest
gm-error-cannot-ping-announce = ไม่สามารถ ping บทบาทประกาศ { $role } ในช่อง { $channel } ได้ ตรวจสอบสิทธิ์ของช่องและบทบาท ReQuest กับผู้ดูแลเซิร์ฟเวอร์
gm-error-invalid-item-format = รูปแบบไอเทมไม่ถูกต้อง: "{ $item }" แต่ละไอเทมต้องอยู่คนละบรรทัด ในรูปแบบ "ชื่อ: จำนวน"
gm-error-submission-not-found = ไม่พบการส่ง
gm-error-already-on-quest = คุณอยู่ใน quest นี้แล้วในฐานะ { $characterName }
gm-error-no-active-character-long = คุณไม่มีตัวละครที่ใช้งานอยู่บนเซิร์ฟเวอร์นี้ ใช้ `/player` เพื่อลงทะเบียนหรือเปิดใช้งานตัวละคร
gm-error-quest-locked = เกิดข้อผิดพลาดในการเข้าร่วม quest {"**"}{ $questTitle }{"**"}: Quest ถูกล็อกโดย GM
gm-error-quest-full = เกิดข้อผิดพลาดในการเข้าร่วม quest {"**"}{ $questTitle }{"**"}: รายชื่อ quest เต็มแล้ว!
gm-error-not-signed-up = คุณไม่ได้ลงชื่อเข้าร่วม quest นี้
gm-error-quest-channel-not-set = ยังไม่ได้ตั้งค่าช่อง quest!
gm-error-empty-roster = คุณไม่สามารถจบ quest ที่ไม่มีผู้เล่นได้ ลองยกเลิกแทน
gm-error-invalid-xp-value = ค่า XP ต้องเป็นจำนวนเต็มบวก!

# GM confirm modals
gm-modal-title-cancel-quest = ยกเลิก Quest
gm-modal-label-cancel-quest = พิมพ์ CONFIRM เพื่อยกเลิก quest
gm-modal-title-remove-from-quest = ลบตัวละครออกจาก quest
gm-modal-label-remove-from-quest = ยืนยันการลบตัวละคร?

# GM DM messages
gm-dm-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} ถูกยกเลิกโดย GM
gm-dm-quest-ready = Quest {"**"}{ $questTitle }{"**"} พร้อมแล้ว!
gm-dm-quest-unlocked = Quest {"**"}{ $questTitle }{"**"} ไม่ถูกล็อกแล้ว
gm-dm-quest-locked = Quest {"**"}{ $questTitle }{"**"} ถูกล็อกโดย GM แล้ว
gm-dm-player-removed = คุณถูกลบออกจาก quest {"**"}{ $questTitle }{"**"}
gm-dm-player-removed-waitlist = คุณถูกลบออกจากรายชื่อรอของ {"**"}{ $questTitle }{"**"}
gm-dm-party-promotion = คุณได้รับการเลื่อนเข้าปาร์ตี้สำหรับ {"**"}{ $questTitle }{"**"} เนื่องจากมีผู้เล่นออก!
gm-dm-roster-locked = รายชื่อ quest ถูกล็อกและแจ้งปาร์ตี้แล้ว!
gm-dm-roster-unlocked = รายชื่อ quest ถูกปลดล็อกแล้ว
gm-dm-rewards-no-characters =
    ผู้ดูแลเซิร์ฟเวอร์ของคุณได้ตั้งค่ารางวัลสำหรับ GM เมื่อจบ quest
    อย่างไรก็ตาม เนื่องจากคุณไม่มีตัวละครที่ลงทะเบียนไว้ จึงไม่สามารถ
    มอบรางวัลให้อัตโนมัติได้ในขณะนี้
gm-dm-rewards-no-active-character =
    ผู้ดูแลเซิร์ฟเวอร์ของคุณได้ตั้งค่ารางวัลสำหรับ GM เมื่อจบ quest
    อย่างไรก็ตาม เนื่องจากคุณไม่มีตัวละครที่ใช้งานอยู่บนเซิร์ฟเวอร์นี้
    จึงไม่สามารถมอบรางวัลให้อัตโนมัติได้ในขณะนี้
gm-dm-rewards-issued = สิ่งต่อไปนี้ได้ถูกมอบให้ตัวละครที่ใช้งานอยู่ของคุณ { $characterName }

# GM select menus
gm-select-placeholder-party-member = เลือกสมาชิกปาร์ตี้

# GM embeds
gm-embed-title-mod-report = รายงานการแก้ไขผู้เล่นโดย GM
gm-embed-field-experience = ประสบการณ์
gm-embed-title-quest-complete = Quest เสร็จสมบูรณ์: { $questTitle }
gm-embed-title-quest-completed = QUEST เสร็จสมบูรณ์: { $questTitle }
gm-embed-field-rewards = รางวัล
gm-embed-field-party = __ปาร์ตี้__
gm-embed-field-summary = สรุป
gm-embed-title-gm-rewards = รางวัล GM ที่มอบให้
gm-embed-field-items = ไอเทม
gm-msg-player-removed = ลบผู้เล่นและอัปเดตรายชื่อ quest แล้ว!

# GM views
gm-title-main-menu = GM - เมนูหลัก
gm-menu-quests = Quest
gm-menu-desc-quests = สร้าง แก้ไข และจัดการ quest
gm-menu-players = ผู้เล่น
gm-menu-desc-players = จัดการคลังไอเทมและแก้ไขตัวละครของผู้เล่น
gm-menu-approvals = การอนุมัติตัวละคร
gm-menu-desc-approvals = ตรวจสอบและอนุมัติ/ปฏิเสธการส่งตัวละคร

gm-title-quest-management = GM - จัดการ Quest
gm-desc-create-quest = สร้าง quest ใหม่
gm-msg-no-quests = ไม่พบ quest
gm-label-quest-locked = (ล็อก)
gm-title-manage-quest = จัดการ Quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = แก้ไขรายละเอียด quest เช่น ชื่อ รายละเอียด และขนาดปาร์ตี้
gm-desc-toggle-ready = สลับสถานะพร้อม (ปัจจุบัน: {"**"}{ $status }{"**"})
    - ล็อกรายชื่อ quest และแจ้งสมาชิกปาร์ตี้ว่า quest จะเริ่มเร็วๆ นี้ หากตั้งค่าบทบาทไว้ จะถูกกำหนดให้สมาชิกปาร์ตี้เมื่อล็อก
    - ปลดล็อกรายชื่อเมื่อตั้งเป็นเปิด
gm-label-ready-locked = ล็อก/พร้อม
gm-label-ready-open = เปิด
gm-desc-configure-rewards = ตั้งค่ารางวัลสำหรับ quest ที่เลือก
gm-desc-complete-quest = จบ quest มอบรางวัล (ถ้ามี) ให้สมาชิกปาร์ตี้
gm-desc-remove-player = ลบผู้เล่นออกจากรายชื่อ quest และแจ้งเตือน
gm-desc-cancel-quest = ยกเลิก quest และลบออกจากกระดาน quest
gm-title-player-management = GM - จัดการผู้เล่น
gm-desc-player-management =
    คำสั่งเหล่านี้ได้ย้ายไปที่เมนูบริบทแล้ว คลิกขวา (เดสก์ท็อป) หรือกดค้าง (มือถือ) ที่โปรไฟล์ผู้เล่นเพื่อดูตัวเลือกเมนูต่อไปนี้:

    - {"**"}แก้ไขผู้เล่น{"**"}: เพิ่มหรือลบไอเทมและประสบการณ์ของผู้เล่น
    - {"**"}ดูผู้เล่น{"**"}: ดูรายละเอียดตัวละครที่ใช้งานอยู่ของผู้เล่น
gm-title-remove-player = ลบผู้เล่นจาก Quest - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}หมายเหตุการลบผู้เล่น{"**"}__

    - เลือกผู้เล่นจากเมนูดรอปดาวน์ด้านล่างเพื่อลบออกจากรายชื่อ quest
    - หากมีผู้เล่นอยู่ในรายชื่อรอ ผู้เล่นคนแรกในรายชื่อจะถูกเลื่อนขึ้นเข้าปาร์ตี้
    - รางวัลรายบุคคลของผู้เล่นที่ถูกลบจะถูกลบออกจาก quest
    - หากต้องการให้รางวัลผู้เล่นสำหรับการมีส่วนร่วมก่อนหน้า ใช้เมนูบริบท `แก้ไขผู้เล่น` เพื่อมอบรางวัลโดยตรง
gm-label-no-players-in-roster = ไม่มีผู้เล่นในรายชื่อ quest
gm-title-character-sheet = แผ่นตัวละครของ { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}แต้มประสบการณ์:{"**"}__
gm-label-possessions = __{"**"}สิ่งของ{"**"}__
gm-label-currency-heading = {"**"}สกุลเงิน{"**"}
gm-msg-inventory-empty = คลังไอเทมว่างเปล่า

# GM approvals
gm-title-approvals = GM - อนุมัติคลังไอเทม
gm-desc-review-submission = กรอก ID การส่งเพื่อตรวจสอบและอนุมัติ/ปฏิเสธ
gm-title-reviewing = กำลังตรวจสอบ: { $characterName }
gm-label-items = {"**"}ไอเทม:{"**"}
gm-label-currency = {"**"}สกุลเงิน:{"**"}
gm-embed-title-approved = อนุมัติการอัปเดตคลังไอเทม
gm-embed-desc-approved = คลังไอเทมของ {"**"}{ $characterName }{"**"} ได้รับการอนุมัติโดย { $approver }
gm-embed-title-denied = ปฏิเสธการอัปเดตคลังไอเทม
gm-embed-desc-denied = คลังไอเทมของ {"**"}{ $characterName }{"**"} ถูกปฏิเสธโดย { $denier }

gm-modal-label-select-party-role = บทบาทปาร์ตี้
gm-modal-desc-select-party-role = เลือกบทบาทที่จะกำหนดให้ปาร์ตี้ของ quest
gm-select-option-no-role = ไม่มี (ไม่มีบทบาทปาร์ตี้)

gm-error-role-hierarchy = ReQuest ไม่สามารถจัดการบทบาท "{ $roleName }" (ID: { $roleId }) ได้เนื่องจากอยู่ในตำแหน่งสูงกว่าบทบาทสูงสุดของ ReQuest ในลำดับชั้นของเซิร์ฟเวอร์ กรุณาติดต่อผู้ดูแลเซิร์ฟเวอร์เพื่อย้ายบทบาทให้อยู่ต่ำกว่าบทบาทของ ReQuest หรือกำหนดบทบาทที่สูงกว่าให้ ReQuest แล้วลองอีกครั้ง
gm-dm-role-removal-failed =
    ⚠️ ไม่สามารถลบบทบาท {"**"}{ $roleName }{"**"} จากสมาชิกต่อไปนี้: { $members }
    กรุณาแจ้งผู้ดูแลเซิร์ฟเวอร์เพื่อลบบทบาทด้วยตนเอง

gm-dm-role-not-found =
    ⚠️ บทบาท quest (ID: { $roleId }) สำหรับ quest {"**"}{ $questTitle }{"**"} ไม่มีอยู่บนเซิร์ฟเวอร์อีกต่อไป
    การดำเนินการบทบาทถูกข้ามไป กรุณาแจ้งผู้ดูแลเซิร์ฟเวอร์หากนี่เป็นสิ่งที่ไม่คาดคิด
