## Admin module strings

# Admin cog
admin-embed-title-unauthorized = เซิร์ฟเวอร์ที่ไม่ได้รับอนุญาต
admin-embed-desc-unauthorized =
    ขอบคุณที่สนใจ ReQuest! เซิร์ฟเวอร์ของคุณไม่ได้อยู่ในรายชื่อเซิร์ฟเวอร์ทดสอบที่ได้รับอนุญาตของ ReQuest
    กรุณาเข้าร่วม Discord สนับสนุนด้านล่าง และติดต่อทีมพัฒนาเพื่อขอสิทธิ์การทดสอบ

    [Discord พัฒนา ReQuest](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = คำสั่งต่อไปนี้ถูกซิงค์ไปยัง { $guildName }, ID { $guildId }
admin-embed-title-sync-global = คำสั่งต่อไปนี้ถูกซิงค์ทั่วโลก
admin-error-missing-scope = ReQuest ไม่มีขอบเขตที่ถูกต้องในกิลด์เป้าหมาย เพิ่มสิทธิ์ `applications.commands` แล้วลองอีกครั้ง
admin-error-sync-failed = เกิดข้อผิดพลาดในการซิงค์คำสั่ง: { $error }
admin-msg-commands-cleared = ล้างคำสั่งแล้ว

# Admin buttons
admin-btn-shutdown = ปิดระบบ
admin-modal-title-confirm-shutdown = ยืนยันการปิดระบบ
admin-modal-label-shutdown-warning = คำเตือน! การดำเนินการนี้จะปิดบอท พิมพ์ ยืนยัน เพื่อดำเนินการ
admin-msg-shutting-down = กำลังปิดระบบ!
admin-btn-add-server = เพิ่มเซิร์ฟเวอร์ใหม่
admin-btn-load-cog = โหลด Cog
admin-msg-extension-loaded = โหลดส่วนขยายสำเร็จ: `{ $module }`
admin-btn-reload-cog = โหลด Cog ใหม่
admin-msg-extension-reloaded = โหลดส่วนขยายใหม่สำเร็จ: `{ $module }`
admin-btn-output-guilds = แสดงรายชื่อกิลด์
admin-msg-connected-guilds = เชื่อมต่อกับ { $count } กิลด์:

# Admin modals
admin-modal-title-add-server = เพิ่ม ID เซิร์ฟเวอร์ในรายชื่ออนุญาต
admin-modal-label-server-name = ชื่อเซิร์ฟเวอร์
admin-modal-placeholder-server-name = พิมพ์ชื่อย่อของเซิร์ฟเวอร์ Discord
admin-modal-label-server-id = ID เซิร์ฟเวอร์
admin-modal-placeholder-server-id = พิมพ์ ID ของเซิร์ฟเวอร์ Discord
admin-select-placeholder-server = เลือกเซิร์ฟเวอร์ที่จะลบ
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = ชื่อ
admin-modal-placeholder-cog-name = ป้อนชื่อ Cog ที่จะ { $action }

# Admin views
admin-title-main-menu = การดูแลระบบ - เมนูหลัก
admin-desc-allowlist = ตั้งค่ารายชื่อเซิร์ฟเวอร์ที่อนุญาตสำหรับการจำกัดการเชิญ
admin-desc-cogs = โหลดหรือโหลด Cog ใหม่
admin-desc-guild-list = แสดงรายชื่อกิลด์ทั้งหมดที่บอทเป็นสมาชิกอยู่
admin-desc-shutdown = ปิดบอท
admin-title-allowlist = การดูแลระบบ - รายชื่อเซิร์ฟเวอร์ที่อนุญาต
admin-desc-allowlist-warning =
    เพิ่ม ID เซิร์ฟเวอร์ Discord ใหม่ในรายชื่อที่อนุญาต
    {"**"}คำเตือน: ไม่มีวิธีตรวจสอบว่า ID เซิร์ฟเวอร์ที่ให้มาถูกต้องหรือไม่โดยที่บอทไม่ได้เป็นสมาชิกของเซิร์ฟเวอร์ ตรวจสอบข้อมูลที่ป้อนให้ดี!{"**"}
admin-msg-no-servers = ไม่มีเซิร์ฟเวอร์ในรายชื่อที่อนุญาต

# Admin confirm modals
admin-modal-title-confirm-server-removal = ยืนยันการลบเซิร์ฟเวอร์
admin-modal-label-server-removal = ลบเซิร์ฟเวอร์ออกจากรายชื่อที่อนุญาต?

# Admin cog view
admin-title-cogs = การดูแลระบบ - Cog
admin-desc-load-cog = โหลด Cog ของบอทตามชื่อ ไฟล์ต้องมีชื่อเป็น `<name>.py` และเก็บอยู่ใน ReQuest/cogs/
admin-desc-reload-cog = โหลด Cog ที่โหลดแล้วใหม่ตามชื่อ ข้อจำกัดชื่อและตำแหน่งไฟล์เหมือนกัน
