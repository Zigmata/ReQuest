## Game Master module strings

# GM buttons
gm-btn-create = Oluştur
gm-btn-edit-details = Quest'i Düzenle
gm-btn-toggle-ready = Hazır Durumunu Aç/Kapat
gm-btn-configure-rewards = Ödülleri Yapılandır
gm-btn-remove-player = Oyuncuyu Kaldır
gm-btn-cancel-quest = Quest'i İptal Et
gm-btn-manage-party-rewards = Grup Ödüllerini Yönet
gm-btn-manage-individual-rewards = Bireysel Ödülleri Yönet
gm-btn-join = Katıl
gm-btn-leave = Ayrıl
gm-btn-complete-quest = Quest'i Tamamla
gm-btn-edit-details-modal = Detayları Düzenle
gm-btn-edit-images = Görselleri Düzenle
gm-select-placeholder-party-role = Bir grup rolü seçin...
gm-modal-title-edit-details = Quest Detaylarını Düzenle
gm-modal-title-edit-images = Quest Görsellerini Düzenle
gm-btn-publish = Yayınla
gm-btn-update-post = Gönderiyi Güncelle

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
gm-modal-label-image-url = Küçük Resim URL'si
gm-modal-label-large-image-url = Büyük Görsel URL'si
gm-modal-placeholder-image-url = Bir görsel URL'si girin (veya kaldırmak için boş bırakın)
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

# GM errors
gm-error-forbidden-role-name = Grup rolü için girilen ad yasaklanmış.
gm-error-role-already-exists = Bu sunucuda bu adda bir rol zaten mevcut.
gm-error-no-quest-channel = Quest gönderileri için henüz bir kanal belirlenemedi. Quest Kanalını yapılandırmak için bir sunucu yöneticisiyle iletişime geçin.
gm-error-cannot-ping-announce = { $channel } kanalında { $role } duyuru rolü etiketlenemedi. Kanal ve ReQuest rol izinlerini sunucu yöneticiniz/yöneticilerinizle kontrol edin.
gm-error-invalid-item-format = Geçersiz eşya biçimi: "{ $item }". Her eşya yeni bir satırda ve "Ad: Miktar" biçiminde olmalıdır.
gm-error-already-on-quest = Bu quest'te zaten { $characterName } olarak bulunuyorsunuz.
gm-error-no-active-character-long = Bu sunucuda aktif bir karakteriniz yok. Bir karakter kaydetmek veya etkinleştirmek için `/player` komutunu kullanın.
gm-error-quest-locked = {"**"}{ $questTitle }{"**"} quest'ine katılma hatası: Quest GM tarafından kilitlenmiş.
gm-error-quest-full = {"**"}{ $questTitle }{"**"} quest'ine katılma hatası: Quest kadrosu dolu!
gm-error-not-signed-up = Bu quest'e kayıtlı değilsiniz.
gm-error-quest-not-found = Görev artık mevcut değil.
gm-error-quest-channel-not-set = Quest kanalı ayarlanmamış!
gm-error-empty-roster = Boş bir kadroyla quest tamamlayamazsınız. Bunun yerine iptal etmeyi deneyin.
gm-error-invalid-xp-value = XP değeri pozitif bir tam sayı olmalıdır!
gm-error-role-hierarchy = ReQuest, "{ $roleName }" (ID: { $roleId }) rolünü yönetemiyor çünkü sunucu hiyerarşisinde ReQuest'in en yüksek rolünün üzerinde konumlandırılmış. Lütfen rolü ReQuest'in rolünün altına taşımak veya ReQuest'e daha yüksek bir rol atamak için bir sunucu yöneticisiyle iletişime geçin, ardından işlemi yeniden deneyin.
gm-error-party-size-positive = Grup boyutu pozitif bir sayı olmalıdır.
gm-error-party-size-too-small = Grup boyutu mevcut gruptan ({ $currentSize } üye) daha küçük olamaz.
gm-error-role-name-forbidden = "{ $roleName }" rol adı bu sunucuda yasaklanmış.
gm-error-role-name-exists = "{ $roleName }" adında bir rol bu sunucuda zaten mevcut.

# GM confirm modals
gm-modal-title-cancel-quest = Quest'i İptal Et
gm-modal-label-cancel-quest = Quest'i iptal etmek için ONAYLA yazın.
gm-modal-title-remove-from-quest = Karakteri quest'ten kaldır
gm-modal-label-remove-from-quest = Karakter kaldırma onaylansın mı?

# GM DM embeds
gm-dm-title-quest-cancelled = Quest İptal Edildi
gm-dm-desc-quest-cancelled = {"**"}{ $questTitle }{"**"} quest'i GM tarafından iptal edildi.
gm-dm-title-quest-ready = Quest Hazır
gm-dm-desc-quest-ready = {"**"}{ $questTitle }{"**"} quest'i artık hazır! GM'iniz quest'i yakında başlatacak.
gm-dm-title-player-removed = Quest'ten Kaldırıldı
gm-dm-desc-player-removed = GM tarafından {"**"}{ $questTitle }{"**"} quest'inden kaldırıldınız.
gm-dm-desc-player-removed-waitlist = {"**"}{ $questTitle }{"**"} quest'inin bekleme listesinden kaldırıldınız.
gm-dm-title-party-promotion = Gruba Terfi
gm-dm-desc-party-promotion =
    Bir oyuncunun quest'ten ayrılması nedeniyle
    {"**"}{ $questTitle }{"**"} ana grubuna terfi ettiniz.
gm-dm-title-roster-locked = Kadro Kilitlendi
gm-dm-desc-roster-locked =
    {"**"}{ $questTitle }{"**"} kadrosu kilitlendi
    ve tüm grup üyeleri bilgilendirildi.
gm-dm-title-roster-unlocked = Kadro Kilidi Açıldı
gm-dm-desc-roster-unlocked = {"**"}{ $questTitle }{"**"} kadrosunun kilidi açıldı.
gm-dm-title-player-removed-confirm = Oyuncu Kaldırıldı
gm-dm-desc-player-removed-confirm =
    Oyuncu {"**"}{ $questTitle }{"**"} quest'inden kaldırıldı
    ve quest kadrosu güncellendi.
gm-dm-footer-quest = Görev Kimliği: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    Sunucu yöneticiniz, GM'lerin quest tamamladığında ödül alacağı şekilde
    yapılandırmış. Ancak, kayıtlı hiç karakteriniz olmadığı için ödülleriniz
    şu anda otomatik olarak verilemedi.
gm-dm-rewards-no-active-character =
    Sunucu yöneticiniz, GM'lerin quest tamamladığında ödül alacağı şekilde
    yapılandırmış. Ancak, bu sunucuda aktif bir karakteriniz olmadığı için
    ödülleriniz şu anda otomatik olarak verilemedi.
gm-dm-rewards-issued = Aktif karakteriniz { $characterName } için şunlar verildi
gm-dm-role-removal-failed =
    ⚠️ {"**"}{ $roleName }{"**"} rolü şu üyelerden kaldırılamadı: { $members }.
    Lütfen rolü manuel olarak kaldırması için bir sunucu yöneticisini bilgilendirin.
gm-dm-role-not-found =
    ⚠️ {"**"}{ $questTitle }{"**"} quest'i için quest rolü (ID: { $roleId }) artık sunucuda mevcut değil.
    Rol işlemleri atlandı. Bu beklenmeyen bir durum ise lütfen bir sunucu yöneticisini bilgilendirin.

# GM select menus
gm-select-placeholder-party-member = Bir grup üyesi seçin
gm-modal-label-select-party-role = Grup Rolü
gm-modal-desc-select-party-role = Quest grubuna atanacak bir rol seçin.
gm-select-option-no-role = Yok (Grup Rolü Yok)

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

# GM views
gm-title-main-menu = GM - Ana Menü
gm-menu-quests = Quest'ler
gm-menu-desc-quests = Quest oluşturun, düzenleyin ve yönetin.
gm-menu-players = Oyuncular
gm-menu-desc-players = Oyuncu envanterlerini yönetin ve karakterleri değiştirin.

gm-title-quest-management = GM - Quest Yönetimi
gm-desc-create-quest = Yeni bir quest oluşturun.
gm-msg-no-quests = Quest bulunamadı.
gm-label-quest-locked = (Kilitli)
gm-label-quest-draft = (Taslak)
gm-title-manage-quest = Quest Yönet - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Başlık, açıklama ve grup boyutu gibi quest detaylarını düzenleyin.
gm-title-edit-quest = Quest'i Düzenle - { $questTitle }
gm-label-field-not-set = Ayarlanmadı
gm-label-description-not-set = Açıklama ayarlanmadı
gm-label-current-title = {"**"}Başlık:{"**"} { $value }
gm-label-current-description = {"**"}Açıklama{"**"}
gm-label-current-restrictions = {"**"}Kısıtlamalar:{"**"} { $value }
gm-label-current-party-size = {"**"}Maks Grup Boyutu:{"**"} { $value }
gm-label-current-party-role = {"**"}Grup Rolü:{"**"} { $value }
gm-label-current-image = {"**"}Küçük Resim{"**"}
gm-label-current-large-image = {"**"}Görsel{"**"}
gm-desc-publish-quest = Bu quest'i quest panosuna yayınlayın.
gm-desc-update-quest-post = Quest panosundaki quest gönderisini güncelleyin.
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

    - {"**"}Oyuncuyu Düzenle{"**"}: Bir oyuncuya eşya ve deneyim ekleyin veya kaldırın.
    - {"**"}Oyuncuyu Görüntüle{"**"}: Bir oyuncunun aktif karakter detaylarını görüntüleyin.
gm-title-remove-player = Oyuncuyu Quest'ten Kaldır - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Oyuncu Kaldırma Notları{"**"}__

    - Quest kadrosundan kaldırmak için aşağıdaki açılır menüden bir oyuncu seçin.
    - Bekleme listesinde oyuncu varsa, listedeki ilk oyuncu gruba yükseltilir.
    - Kaldırılan oyuncunun bireysel ödülleri quest'ten silinir.
    - Oyuncuyu önceki katkıları için ödüllendirmek isterseniz, doğrudan ödül vermek için `Oyuncuyu Düzenle` bağlam menüsünü kullanın.
gm-label-no-players-in-roster = Quest kadrosunda oyuncu yok
gm-title-character-sheet = { $characterName } için Karakter Sayfası (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Deneyim Puanları:{"**"}__
gm-label-possessions = __{"**"}Eşyalar{"**"}__
gm-label-currency-heading = {"**"}Para Birimi{"**"}
gm-msg-inventory-empty = Envanter boş.

# GM approvals
