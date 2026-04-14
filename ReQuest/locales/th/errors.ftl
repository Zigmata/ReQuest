## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ อุ๊ปส์!
error-report-description =
    { $exception }

    หากข้อผิดพลาดนี้ไม่คาดคิด หรือคุณสงสัยว่าบอทไม่ทำงานอย่างถูกต้อง กรุณาส่งรายงานบั๊กใน [Discord สนับสนุนอย่างเป็นทางการของ ReQuest](https://discord.gg/Zq37gj4)

error-report-unexpected =
    เกิดข้อผิดพลาดที่ไม่คาดคิด กรุณาลองอีกครั้ง

    หากปัญหานี้ยังคงเกิดขึ้น กรุณาส่งรายงานบั๊กใน [Discord สนับสนุนอย่างเป็นทางการของ ReQuest](https://discord.gg/Zq37gj4)

error-invalid-image-url =
    URL รูปภาพอย่างน้อยหนึ่งรายการไม่ถูกต้อง Discord ต้องการลิงก์แบบเต็มที่ขึ้นต้นด้วย `http://` หรือ `https://` และชี้ไปยังรูปภาพโดยตรง (ตัวอย่างเช่น `https://example.com/banner.png`)

    กรุณาแก้ไขเควสและระบุ URL รูปภาพที่ถูกต้อง หรือเว้นช่องว่างไว้
error-invalid-image-url-field = URL ของ { $fieldName } ไม่ถูกต้อง กรุณาระบุลิงก์แบบเต็มที่ขึ้นต้นด้วย `http://` หรือ `https://` หรือเว้นว่างไว้
error-field-thumbnail = ภาพขนาดย่อ
error-field-large-image = ภาพขนาดใหญ่

# Check failures
error-owner-only = เฉพาะเจ้าของบอทเท่านั้นที่สามารถใช้คำสั่งนี้ได้!
error-no-permission = คุณไม่มีสิทธิ์ใช้คำสั่งนี้!
error-no-active-character = คุณไม่มีตัวละครที่ใช้งานอยู่บนเซิร์ฟเวอร์นี้!
error-no-registered-characters = คุณไม่มีตัวละครที่ลงทะเบียนไว้!
error-no-characters = ผู้เล่นเป้าหมายไม่มีตัวละครที่ลงทะเบียนไว้
error-no-active-character-target = ผู้เล่นเป้าหมายไม่มีตัวละครที่ใช้งานอยู่บนเซิร์ฟเวอร์นี้
error-player-not-found = ไม่พบข้อมูลผู้เล่น
error-character-not-found = ไม่พบข้อมูลตัวละคร

# Currency/transaction errors
error-transaction-cannot-complete = ไม่สามารถดำเนินการธุรกรรมได้:
    { $reason }
error-insufficient-item-trade = คุณมี { $itemName } จำนวน { $owned } ชิ้น แต่พยายามให้ { $quantity } ชิ้น
error-currency-process-failed = ไม่สามารถประมวลผลสกุลเงิน { $currencyName } ได้
error-insufficient-funds-transaction = เงินไม่เพียงพอสำหรับธุรกรรมนี้
error-insufficient-funds = เงินไม่เพียงพอ
error-insufficient-items = ไอเทมไม่เพียงพอ: { $itemName }
error-currency-not-configured = สกุลเงิน '{ $currencyName }' ไม่ได้ถูกตั้งค่าบนเซิร์ฟเวอร์นี้
error-cost-currency-system-mismatch = สกุลเงินต้นทุน '{ $currencyName }' ไม่ได้เป็นส่วนหนึ่งของระบบสกุลเงินของตัวเอง
error-currency-config-error = ข้อผิดพลาดการตั้งค่าสกุลเงิน: ค่าหน่วยย่อยเป็น 0 หรือติดลบ
error-currency-validation = เกิดข้อผิดพลาดระหว่างการตรวจสอบสกุลเงิน: { $error }
error-invalid-currency = { $itemName } ไม่ใช่สกุลเงินที่ถูกต้อง
error-insufficient-funds-for-transaction = เงินไม่เพียงพอสำหรับธุรกรรมนี้

# Cart errors
error-cart-not-found = ไม่พบตะกร้าสินค้า
error-item-not-in-cart = ไม่มีไอเทมนี้ในตะกร้า
error-not-enough-stock = สินค้าคงเหลือไม่เพียงพอ

# Container errors
error-container-not-found = ไม่พบกล่องเก็บไอเทม
error-container-name-empty = ชื่อกล่องเก็บไอเทมต้องไม่ว่างเปล่า
error-container-name-too-long = ชื่อกล่องเก็บไอเทมต้องไม่เกิน { $maxLength } ตัวอักษร
error-max-containers-reached = คุณไม่สามารถสร้างกล่องเก็บไอเทมเกิน { $maxContainers } กล่อง
error-container-name-exists = กล่องเก็บไอเทมชื่อ "{ $containerName }" มีอยู่แล้ว
error-item-already-in-container = ไอเทมนี้อยู่ในกล่องเก็บไอเทมนี้แล้ว
error-quantity-minimum = จำนวนต้องอย่างน้อย 1
error-source-container-not-found = ไม่พบกล่องเก็บไอเทมต้นทาง
error-item-not-in-source = ไม่พบไอเทม "{ $itemName }" ในกล่องเก็บไอเทมต้นทาง
error-insufficient-quantity-in-container = จำนวนไม่เพียงพอ คุณมี { $available } ชิ้นในกล่องเก็บไอเทมนี้
error-dest-container-not-found = ไม่พบกล่องเก็บไอเทมปลายทาง
error-item-not-in-container = ไม่พบไอเทม "{ $itemName }" ในกล่องเก็บไอเทมนี้
error-insufficient-quantity-consume = คุณมีไอเทมนี้เพียง { $available } ชิ้นในกล่องเก็บไอเทมนี้
