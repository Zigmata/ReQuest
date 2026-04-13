## Info cog strings

info-pong =
    {"**"}Pong!{"**"}
    { $latency }ms

info-invite-title = เชิญบอทเข้าเซิร์ฟเวอร์ของคุณ!

info-support =
    {"**"}ReQuest v{ $version }{"**"}

    พบบั๊ก? ต้องการเสนอฟีเจอร์? เข้าร่วมเซิร์ฟเวอร์พัฒนาได้ที่ https://discord.gg/Zq37gj4

info-help-title = ReQuest - รายการคำสั่ง

info-help-description =
    คำสั่งพื้นฐานที่ใช้ได้มีดังนี้:

    {"-"} `/help`: คำสั่งนี้
    {"-"} `/support`: แสดงลิงก์เชิญไปยัง Discord อย่างเป็นทางการของ ReQuest
    {"-"} `/invite`: แสดงลิงก์เชิญเพื่อเพิ่ม ReQuest ไปยัง Discord ของคุณ
    {"-"} `/ping`: ทดสอบการเชื่อมต่อเบื้องต้น

    คำสั่งเมนูขั้นสูงที่ใช้ได้มีดังนี้ ใช้คำสั่งเพื่อเรียนรู้เพิ่มเติมเกี่ยวกับฟังก์ชันย่อย:

    {"-"} `/config`: การตั้งค่าระดับเซิร์ฟเวอร์ ส่วนใหญ่เกี่ยวข้องกับการตั้งค่า ReQuest ครั้งแรกสำหรับ Discord ของคุณ ต้องมีสิทธิ์ "จัดการเซิร์ฟเวอร์" เพื่อเข้าถึง
    {"-"} `/player`: ฟังก์ชันสำหรับผู้เล่นในการจัดการและดูตัวละครของตน
    {"-"} `/gm`: ฟังก์ชัน GM ทั้งหมด ต้องมีการตั้งค่าบทบาท GM สำหรับเซิร์ฟเวอร์
    {"-"} `/shop`: ดูและซื้อไอเทมจากร้านค้าในช่องปัจจุบัน (ถ้าตั้งค่าไว้)

    คำสั่งต่อไปนี้เป็นเมนูบริบท เพื่อเข้าถึงบนเดสก์ท็อป ให้คลิกขวาที่ชื่อผู้ใช้แล้วเลือก "Apps" บนมือถือ ให้ดูโปรไฟล์ผู้ใช้แล้วเลือก "Apps" จากเมนูมุมขวาบน

    {"-"} แลกเปลี่ยน: ให้ไอเทมหรือสกุลเงินแก่ผู้เล่นคนอื่น
    {"-"} ดูผู้เล่น (เฉพาะ GM): ดูคลังไอเทมของตัวละครที่ใช้งานอยู่ของผู้เล่นคนอื่น
    {"-"} แก้ไขผู้เล่น (เฉพาะ GM): แก้ไขคลังไอเทมหรือประสบการณ์ของตัวละครที่ใช้งานอยู่ของผู้เล่นคนอื่น

## Language command strings

info-language-title = การตั้งค่าภาษา
info-language-current = ภาษาปัจจุบัน: **{ $language }**
info-language-select-placeholder = เลือกภาษา...
info-language-select-placeholder-paged = เลือกภาษา... (หน้า { $current }/{ $total })
info-language-label-en-us = English (US)
info-language-label-pt-br = Português (Brasil)
info-language-label-uk = Українська
info-language-label-es-419 = Español (Latinoamérica)
info-language-label-es-es = Español (España)
info-language-label-ru = Русский
info-language-label-ko = 한국어
info-language-label-fr = Français
info-language-label-de = Deutsch
info-language-label-it = Italiano
info-language-label-bg = Български
info-language-label-zh-cn = 简体中文
info-language-label-zh-tw = 繁體中文
info-language-label-hr = Hrvatski
info-language-label-cs = Čeština
info-language-label-da = Dansk
info-language-label-nl = Nederlands
info-language-label-fi = Suomi
info-language-label-el = Ελληνικά
info-language-label-hi = हिन्दी
info-language-label-hu = Magyar
info-language-label-id = Bahasa Indonesia
info-language-label-ja = 日本語
info-language-label-lt = Lietuvių
info-language-label-no = Norsk
info-language-label-pl = Polski
info-language-label-ro = Română
info-language-label-sv-se = Svenska
info-language-label-th = ไทย
info-language-label-tr = Türkçe
info-language-label-vi = Tiếng Việt
info-language-desc-en-us = ตั้งค่าภาษาเป็นภาษาอังกฤษ
info-language-desc-pt-br = ตั้งค่าภาษาเป็นภาษาโปรตุเกส (บราซิล)
info-language-desc-uk = ตั้งค่าภาษาเป็นภาษายูเครน
info-language-desc-es-419 = ตั้งค่าภาษาเป็นภาษาสเปน (ละตินอเมริกา)
info-language-desc-es-es = ตั้งค่าภาษาเป็นภาษาสเปน (สเปน)
info-language-desc-ru = ตั้งค่าภาษาเป็นภาษารัสเซีย
info-language-desc-ko = ตั้งค่าภาษาเป็นภาษาเกาหลี
info-language-desc-fr = ตั้งค่าภาษาเป็นภาษาฝรั่งเศส
info-language-desc-de = ตั้งค่าภาษาเป็นภาษาเยอรมัน
info-language-desc-it = ตั้งค่าภาษาเป็นภาษาอิตาลี
info-language-desc-bg = ตั้งค่าภาษาเป็นภาษาบัลแกเรีย
info-language-desc-zh-cn = ตั้งค่าภาษาเป็นภาษาจีน (ตัวย่อ)
info-language-desc-zh-tw = ตั้งค่าภาษาเป็นภาษาจีน (ตัวเต็ม)
info-language-desc-hr = ตั้งค่าภาษาเป็นภาษาโครเอเชีย
info-language-desc-cs = ตั้งค่าภาษาเป็นภาษาเช็ก
info-language-desc-da = ตั้งค่าภาษาเป็นภาษาเดนมาร์ก
info-language-desc-nl = ตั้งค่าภาษาเป็นภาษาดัตช์
info-language-desc-fi = ตั้งค่าภาษาเป็นภาษาฟินแลนด์
info-language-desc-el = ตั้งค่าภาษาเป็นภาษากรีก
info-language-desc-hi = ตั้งค่าภาษาเป็นภาษาฮินดี
info-language-desc-hu = ตั้งค่าภาษาเป็นภาษาฮังการี
info-language-desc-id = ตั้งค่าภาษาเป็นภาษาอินโดนีเซีย
info-language-desc-ja = ตั้งค่าภาษาเป็นภาษาญี่ปุ่น
info-language-desc-lt = ตั้งค่าภาษาเป็นภาษาลิทัวเนีย
info-language-desc-no = ตั้งค่าภาษาเป็นภาษานอร์เวย์
info-language-desc-pl = ตั้งค่าภาษาเป็นภาษาโปแลนด์
info-language-desc-ro = ตั้งค่าภาษาเป็นภาษาโรมาเนีย
info-language-desc-sv-se = ตั้งค่าภาษาเป็นภาษาสวีเดน
info-language-desc-th = ตั้งค่าภาษาเป็นภาษาไทย
info-language-desc-tr = ตั้งค่าภาษาเป็นภาษาตุรกี
info-language-desc-vi = ตั้งค่าภาษาเป็นภาษาเวียดนาม
