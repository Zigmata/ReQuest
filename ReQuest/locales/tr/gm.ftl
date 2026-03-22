## Game Master module strings

# GM buttons
gm-btn-create = Oluştur
gm-btn-edit-details = Detayları Düzenle
gm-btn-toggle-ready = Hazır Durumunu Aç/Kapat
gm-btn-configure-rewards = Ödülleri Yapılandır
gm-btn-remove-player = Oyuncuyu Kaldır
gm-btn-cancel-quest = Quest'i İptal Et
gm-btn-manage-party-rewards = Grup Ödüllerini Yönet
gm-btn-manage-individual-rewards = Bireysel Ödülleri Yönet
gm-btn-join = Katıl
gm-btn-leave = Ayrıl
gm-btn-complete-quest = Quest'i Tamamla
gm-btn-review-submission = Başvuruyu İncele
gm-btn-approve = Onayla
gm-btn-deny = Reddet

# GM modals
gm-modal-title-create-quest = Yeni Quest Oluştur
gm-modal-label-quest-title = Quest Başlığı
gm-modal-placeholder-quest-title = Quest'inizin başlığı
gm-modal-label-restrictions = Kısıtlamalar
gm-modal-placeholder-restrictions = Varsa kısıtlamalar, örneğin oyuncu seviyeleri
gm-modal-label-max-party = Maksimum Grup Boyutu
gm-modal-placeholder-max-party = Bu quest için grubun maksimum boyutu
gm-modal-label-party-role = Grup Rolü
gm-modal-placeholder-party-role = Bu quest için bir rol oluşturun (İsteğe bağlı)
gm-modal-label-description = Açıklama
gm-modal-placeholder-description = Quest'inizin detaylarını buraya yazın
gm-modal-title-editing-quest = { $questTitle } Düzenleniyor
gm-modal-label-title = Başlık
gm-modal-label-max-party-size = Maks. Grup Boyutu
gm-modal-title-add-reward = Ödül Ekle
gm-modal-label-experience = Deneyim Puanları
gm-modal-placeholder-experience = Bir sayı girin
gm-modal-label-items = Eşyalar
gm-modal-placeholder-items =
    eşya: miktar
    eşya2: miktar
    vb.
gm-modal-title-add-summary = Quest Özeti Ekle
gm-modal-label-summary = Özet
gm-modal-placeholder-summary = Quest'in hikaye özetini ekleyin
gm-modal-title-modifying-player = { $playerName } Düzenleniyor
gm-modal-placeholder-xp-add-remove = Pozitif veya negatif bir sayı girin.
gm-modal-label-inventory = Envanter
gm-modal-placeholder-inventory-modify =
    eşya: miktar
    eşya2: miktar
    vb.
gm-modal-title-review-submission = Başvuruyu İncele
gm-modal-label-submission-id = Başvuru ID
gm-modal-placeholder-submission-id = 8 karakterli ID'yi girin

# GM errors
gm-error-forbidden-role-name = Grup rolü için girilen ad yasaklanmış.
gm-error-role-already-exists = Bu sunucuda bu adda bir rol zaten mevcut.
gm-error-no-quest-channel = Quest gönderileri için henüz bir kanal belirlenemedi. Quest Kanalını yapılandırmak için bir sunucu yöneticisiyle iletişime geçin.
gm-error-cannot-ping-announce = { $channel } kanalında { $role } duyuru rolü etiketlenemedi. Kanal ve ReQuest rol izinlerini sunucu yöneticiniz/yöneticilerinizle kontrol edin.
gm-error-invalid-item-format = Geçersiz eşya biçimi: "{ $item }". Her eşya yeni bir satırda ve "Ad: Miktar" biçiminde olmalıdır.
gm-error-submission-not-found = Başvuru bulunamadı.
gm-error-already-on-quest = Bu quest'te zaten { $characterName } olarak bulunuyorsunuz.
gm-error-no-active-character-long = Bu sunucuda aktif bir karakteriniz yok. Bir karakter kaydetmek veya etkinleştirmek için `/player` komutunu kullanın.
gm-error-quest-locked = {"**"}{ $questTitle }{"**"} quest'ine katılma hatası: Quest GM tarafından kilitlenmiş.
gm-error-quest-full = {"**"}{ $questTitle }{"**"} quest'ine katılma hatası: Quest kadrosu dolu!
gm-error-not-signed-up = Bu quest'e kayıtlı değilsiniz.
gm-error-quest-channel-not-set = Quest kanalı ayarlanmamış!
gm-error-empty-roster = Boş bir kadroyla quest tamamlayamazsınız. Bunun yerine iptal etmeyi deneyin.
gm-error-invalid-xp-value = XP değeri pozitif bir tam sayı olmalıdır!

# GM confirm modals
gm-modal-title-cancel-quest = Quest'i İptal Et
gm-modal-label-cancel-quest = Quest'i iptal etmek için CONFIRM yazın.
gm-modal-placeholder-cancel-quest = Devam etmek için "CONFIRM" yazın.
gm-modal-title-remove-from-quest = Karakteri quest'ten kaldır
gm-modal-label-remove-from-quest = Karakter kaldırma onaylansın mı?
gm-modal-placeholder-remove-from-quest = Devam etmek için "CONFIRM" yazın.

# GM DM messages
gm-dm-quest-cancelled = {"**"}{ $questTitle }{"**"} quest'i GM tarafından iptal edildi.
gm-dm-quest-ready = {"**"}{ $questTitle }{"**"} quest'i artık hazır!
gm-dm-quest-unlocked = {"**"}{ $questTitle }{"**"} quest'inin kilidi artık açık.
gm-dm-quest-locked = {"**"}{ $questTitle }{"**"} quest'i artık GM tarafından kilitlendi.
gm-dm-player-removed = {"**"}{ $questTitle }{"**"} quest'inden kaldırıldınız.
gm-dm-player-removed-waitlist = {"**"}{ $questTitle }{"**"} bekleme listesinden kaldırıldınız.
gm-dm-party-promotion = Bir oyuncunun ayrılması nedeniyle {"**"}{ $questTitle }{"**"} grubuna eklendiniz!
gm-dm-roster-locked = Quest kadrosu kilitlendi ve grup bilgilendirildi!
gm-dm-roster-unlocked = Quest kadrosunun kilidi açıldı.
gm-dm-rewards-no-characters =
    Sunucu yöneticiniz, GM'lerin quest tamamladığında ödül alacağı şekilde
    yapılandırmış. Ancak, kayıtlı hiç karakteriniz olmadığı için ödülleriniz
    şu anda otomatik olarak verilemedi.
gm-dm-rewards-no-active-character =
    Sunucu yöneticiniz, GM'lerin quest tamamladığında ödül alacağı şekilde
    yapılandırmış. Ancak, bu sunucuda aktif bir karakteriniz olmadığı için
    ödülleriniz şu anda otomatik olarak verilemedi.
gm-dm-rewards-issued = Aktif karakteriniz { $characterName } için şunlar verildi

# GM select menus
gm-select-placeholder-party-member = Bir grup üyesi seçin

# GM embeds
gm-embed-title-mod-report = GM Oyuncu Değişiklik Raporu
gm-embed-field-experience = Deneyim
gm-embed-title-quest-complete = Quest Tamamlandı: { $questTitle }
gm-embed-title-quest-completed = QUEST TAMAMLANDI: { $questTitle }
gm-embed-field-rewards = Ödüller
gm-embed-field-party = __Grup__
gm-embed-field-summary = Özet
gm-embed-title-gm-rewards = GM Ödülleri Verildi
gm-embed-field-items = Eşyalar
gm-msg-player-removed = Oyuncu kaldırıldı ve quest kadrosu güncellendi!

# GM views
gm-title-main-menu = GM - Ana Menü
gm-menu-quests = Quest'ler
gm-menu-desc-quests = Quest oluşturun, düzenleyin ve yönetin.
gm-menu-players = Oyuncular
gm-menu-desc-players = Oyuncu envanterlerini yönetin ve karakterleri değiştirin.
gm-menu-approvals = Karakter Onayları
gm-menu-desc-approvals = Karakter başvurularını inceleyin, onaylayın veya reddedin.

gm-title-quest-management = GM - Quest Yönetimi
gm-desc-create-quest = Yeni bir quest oluşturun.
gm-msg-no-quests = Quest bulunamadı.
gm-label-quest-locked = (Kilitli)
gm-title-manage-quest = Quest Yönet - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Başlık, açıklama ve grup boyutu gibi quest detaylarını düzenleyin.
gm-desc-toggle-ready = Hazır durumunu aç/kapat (Mevcut: {"**"}{ $status }{"**"})
    - Quest kadrosunu kilitler ve grup üyelerini quest'in yakında başlayacağı konusunda bilgilendirir. Bir rol yapılandırılmışsa, kilitlendiğinde grup üyelerine atanır.
    - Açık olarak ayarlandığında kadronun kilidini açar.
gm-label-ready-locked = Kilitli/Hazır
gm-label-ready-open = Açık
gm-desc-configure-rewards = Seçilen quest için ödülleri yapılandırın.
gm-desc-complete-quest = Quest'i tamamlayın. Varsa ödülleri grup üyelerine verir.
gm-desc-remove-player = Bir oyuncuyu quest kadrosundan kaldırın ve bilgilendirin.
gm-desc-cancel-quest = Quest'i iptal edin ve quest panosundan silin.
gm-title-player-management = GM - Oyuncu Yönetimi
gm-desc-player-management =
    Bu komutlar bağlam menülerine taşınmıştır. Aşağıdaki menü seçenekleri için bir oyuncunun profiline sağ tıklayın (masaüstü) veya uzun basın (mobil):

    - {"**"}Modify Player{"**"}: Bir oyuncuya eşya ve deneyim ekleyin veya kaldırın.
    - {"**"}View Player{"**"}: Bir oyuncunun aktif karakter detaylarını görüntüleyin.
gm-title-remove-player = Oyuncuyu Quest'ten Kaldır - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Oyuncu Kaldırma Notları{"**"}__

    - Quest kadrosundan kaldırmak için aşağıdaki açılır menüden bir oyuncu seçin.
    - Bekleme listesinde oyuncu varsa, listedeki ilk oyuncu gruba yükseltilir.
    - Kaldırılan oyuncunun bireysel ödülleri quest'ten silinir.
    - Oyuncuyu önceki katkıları için ödüllendirmek isterseniz, doğrudan ödül vermek için `Modify Player` bağlam menüsünü kullanın.
gm-label-no-players-in-roster = Quest kadrosunda oyuncu yok
gm-title-character-sheet = { $characterName } için Karakter Sayfası (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Deneyim Puanları:{"**"}__
gm-label-possessions = __{"**"}Eşyalar{"**"}__
gm-label-currency-heading = {"**"}Para Birimi{"**"}
gm-msg-inventory-empty = Envanter boş.

# GM approvals
gm-title-approvals = GM - Envanter Onayları
gm-desc-review-submission = İncelemek ve onaylamak/reddetmek için bir Başvuru ID'si girin.
gm-title-reviewing = İnceleniyor: { $characterName }
gm-label-items = {"**"}Eşyalar:{"**"}
gm-label-currency = {"**"}Para Birimi:{"**"}
gm-embed-title-approved = Envanter Güncellemesi Onaylandı
gm-embed-desc-approved = {"**"}{ $characterName }{"**"} için envanter { $approver } tarafından onaylandı.
gm-embed-title-denied = Envanter Güncellemesi Reddedildi
gm-embed-desc-denied = {"**"}{ $characterName }{"**"} için envanter { $denier } tarafından reddedildi.

gm-modal-label-select-party-role = Grup Rolü
gm-modal-desc-select-party-role = Quest grubuna atanacak bir rol seçin.
gm-select-option-no-role = Yok (Grup Rolü Yok)

gm-error-role-hierarchy = ReQuest, "{ $roleName }" (ID: { $roleId }) rolünü yönetemiyor çünkü sunucu hiyerarşisinde ReQuest'in en yüksek rolünün üzerinde konumlandırılmış. Lütfen rolü ReQuest'in rolünün altına taşımak veya ReQuest'e daha yüksek bir rol atamak için bir sunucu yöneticisiyle iletişime geçin, ardından işlemi yeniden deneyin.
gm-dm-role-removal-failed =
    ⚠️ {"**"}{ $roleName }{"**"} rolü şu üyelerden kaldırılamadı: { $members }.
    Lütfen rolü manuel olarak kaldırması için bir sunucu yöneticisini bilgilendirin.

gm-dm-role-not-found =
    ⚠️ {"**"}{ $questTitle }{"**"} quest'i için quest rolü (ID: { $roleId }) artık sunucuda mevcut değil.
    Rol işlemleri atlandı. Bu beklenmeyen bir durum ise lütfen bir sunucu yöneticisini bilgilendirin.
