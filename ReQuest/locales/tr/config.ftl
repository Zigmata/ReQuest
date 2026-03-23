## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = Temizle
config-btn-remove-gm-roles = GM Rollerini Kaldır
config-btn-forbidden-roles = Yasaklı Roller

# Quests
config-btn-toggle-quest-summary = Quest Özetini Aç/Kapat
config-btn-toggle-player-experience = Oyuncu Deneyimini Aç/Kapat
config-btn-toggle-display = Görünümü Aç/Kapat
config-btn-purge-player-board = Oyuncu Panosunu Temizle
config-btn-add-modify-rewards = Ödül Ekle/Düzenle

# Currency
config-btn-add-denomination = Birim Ekle
config-btn-add-new-currency = Yeni Para Birimi Ekle
config-btn-remove-currency = Para Birimini Kaldır

# Shops - creation
config-btn-add-shop-wizard = Mağaza Ekle (Sihirbaz)
config-btn-add-shop-json = Mağaza Ekle (JSON)
config-btn-edit-shop-wizard = Mağazayı Düzenle (Sihirbaz)
config-btn-edit-shop-json = Mağazayı Düzenle (JSON)
config-btn-remove-shop = Mağazayı Kaldır
config-btn-add-item = Eşya Ekle
config-btn-edit-shop-details = Mağaza Detaylarını Düzenle
config-btn-download-json = JSON İndir
config-btn-done-editing = Düzenleme Tamam
config-btn-scan-server-configs = Sunucu Yapılandırmalarını Tara
config-btn-re-scan = Yeniden Tara

# New character shop
config-btn-upload-json = JSON Yükle
config-btn-configure-new-character-wealth = Yeni Karakter Servetini Yapılandır
config-btn-configure-new-character-shop = Yeni Karakter Mağazasını Yapılandır
config-btn-clear-shop = Mağazayı Temizle
config-btn-configure-static-kits = Sabit Kitleri Yapılandır
config-btn-new-character-settings = Yeni Karakter Ayarları
config-btn-disabled-no-currency = Devre Dışı (Para Birimi Yapılandırılmamış)
config-btn-disabled-no-wealth = Devre Dışı (Başlangıç Serveti Yapılandırılmamış)

# Static kits
config-btn-create-new-kit = Yeni Kit Oluştur
config-btn-delete-kit = Kiti Sil
config-btn-add-currency = Para Birimi Ekle

# Roleplay
config-btn-toggle-rp-rewards = RP Ödüllerini Aç/Kapat
config-btn-clear-channels = Kanalları Temizle
config-btn-edit-settings = Ayarları Düzenle
config-btn-configure-rewards = Ödülleri Yapılandır

# Stock
config-btn-stock-limits = Stok Limitleri
config-btn-set-limit = Limit Belirle
config-btn-edit-limit = Limiti Düzenle
config-btn-remove-limit = Limiti Kaldır
config-btn-configure-restock-schedule = Yeniden Stoklama Zamanlamasını Yapılandır
config-btn-back-to-shop-editor = Mağaza Düzenleyicisine Dön

# Forum shop
config-btn-create-new-thread = Yeni Konu Oluştur
config-btn-use-existing-thread = Mevcut Konuyu Kullan

# Wizard
config-btn-quit = Çık
config-btn-configure-channels = Kanalları Yapılandır
config-btn-configure-roles = Rolleri Yapılandır
config-btn-configure-quests = Quest'leri Yapılandır
config-btn-configure-players = Oyuncuları Yapılandır
config-btn-configure-currency = Para Birimini Yapılandır
config-btn-configure-rp-rewards = RP Ödüllerini Yapılandır
config-btn-configure-shops = Mağazaları Yapılandır
config-btn-new-char-setup = Yeni Karakter Kurulumu

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = Rol Kaldırmayı Onayla
config-modal-title-confirm-removal = Kaldırmayı Onayla
config-modal-title-confirm-currency-removal = Para Birimi Kaldırmayı Onayla
config-modal-title-confirm-shop-removal = Mağaza Kaldırmayı Onayla
config-modal-title-confirm-kit-deletion = Kit Silmeyi Onayla
config-modal-title-confirm-remove-stock-limit = Stok Limiti Kaldırmayı Onayla
config-modal-title-clear-shop = Mağaza Temizlemeyi Onayla

# Confirm modal prompt labels
config-modal-label-remove-role = { $roleName } kaldırılsın mı?
config-modal-label-remove-denomination = { $denominationName } kaldırılsın mı?
config-modal-label-remove-currency = { $currencyName } kaldırılsın mı?
config-modal-label-shop-removal-warning = UYARI: Bu işlem geri alınamaz!
config-modal-label-kit-deletion-warning = UYARI: Geri alınamaz!
config-modal-label-remove-stock-limit = Stok limitini kaldırmak için CONFIRM yazın
config-modal-label-clear-shop = Bu mağazadaki tüm öğeleri temizle?

# Error messages from buttons
config-error-shop-data-not-found = Hata: Bu mağazanın verileri bulunamadı.
config-msg-shop-json-download = İşte {"**"}{ $shopName }{"**"} mağazasının JSON tanımı.
config-msg-new-char-shop-json-download = İşte Yeni Karakter Mağazası'nın JSON tanımı.
config-error-select-forum-first = Lütfen önce bir forum kanalı seçin.
config-error-select-thread-first = Lütfen önce bir konu seçin.

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Yeni Para Birimi Ekle
config-modal-label-currency-name = Para Birimi Adı
config-error-currency-already-exists = { $name } adında bir para birimi veya birim zaten mevcut!

# RenameCurrencyModal
config-modal-title-rename-currency = Para Birimini Yeniden Adlandır
config-modal-label-new-currency-name = Yeni Para Birimi Adı
config-error-currency-name-exists = "{ $name }" adında bir para birimi zaten mevcut.
config-error-denomination-name-exists = "{ $name }" adında bir birim zaten mevcut.

# RenameDenominationModal
config-modal-title-rename-denomination = Birimi Yeniden Adlandır
config-modal-label-new-denomination-name = Yeni Birim Adı

# AddCurrencyDenominationModal
config-modal-title-add-denomination = { $currencyName } Birimi Ekle
config-modal-label-denomination-name = Ad
config-modal-placeholder-denomination-name = ör. Gümüş
config-modal-label-denomination-value = Değer
config-modal-placeholder-denomination-value = ör. 0.1
config-error-denomination-matches-currency = Yeni birim adı bu sunucudaki mevcut bir para birimiyle eşleşemez! "{ $existingName }" adında mevcut bir para birimi bulundu.
config-error-denomination-matches-denomination = Yeni birim adı bu sunucudaki mevcut bir birimle eşleşemez! "{ $currencyName }" para birimi altında "{ $denominationName }" adında mevcut bir birim bulundu.
config-error-denomination-value-exists = Tek bir para birimi altındaki birimlerin benzersiz değerleri olmalıdır! { $denominationName } zaten bu değere atanmış.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Yasaklı Rol Adları
config-modal-label-names = Adlar
config-modal-placeholder-names = Adları virgülle ayırarak girin
config-msg-forbidden-roles-updated = Yasaklı roller güncellendi!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Oyuncu Panosunu Temizle
config-modal-label-age = Yaş
config-modal-placeholder-age = Saklanacak maksimum gönderi yaşını (gün olarak) girin
config-msg-posts-purged = { $days } günden eski gönderiler temizlendi!

# GMRewardsModal
config-modal-title-gm-rewards = GM Ödüllerini Ekle/Düzenle
config-modal-label-experience = Deneyim
config-modal-placeholder-enter-number = Bir sayı girin
config-modal-label-items = Eşyalar
config-modal-placeholder-items =
    Ad: Miktar
    Ad2: Miktar
    vb.
config-error-experience-invalid = Deneyim geçerli bir tam sayı olmalıdır (ör. 2000).
config-error-item-format-invalid = Geçersiz eşya biçimi: "{ $item }". Her eşya yeni bir satırda ve "Ad: Miktar" biçiminde olmalıdır.

# ConfigShopDetailsModal
config-modal-title-shop-details = Mağaza Detaylarını Ekle/Düzenle
config-modal-label-shop-channel = Bir kanal seçin
config-modal-placeholder-shop-channel = Bu mağaza için kanalı seçin
config-modal-label-shop-name = Mağaza Adı
config-modal-placeholder-shop-name = Mağazanın adını girin
config-modal-label-shopkeeper-name = Mağazacı Adı
config-modal-placeholder-shopkeeper-name = Mağazacının adını girin
config-modal-label-shop-description = Mağaza Açıklaması
config-modal-placeholder-shop-description = Mağaza için bir açıklama girin
config-modal-label-shop-image-url = Mağaza Görsel URL
config-modal-placeholder-shop-image-url = Mağaza görseli için bir URL girin
config-error-no-channel-selected = Mağaza için kanal seçilmedi.
config-error-shop-already-in-channel = Seçilen kanalda zaten bir mağaza kayıtlı. Lütfen farklı bir kanal seçin veya mevcut mağazayı düzenleyin.

# build_shop_header_view
config-label-shopkeeper = {"**"}Mağazacı:{"**"} { $name }
config-msg-use-shop-command = Eşyaları görmek ve satın almak için `/shop` komutunu kullanın.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Forum Konu Mağazası Oluştur
config-modal-label-thread-name = Konu Adı
config-modal-placeholder-thread-name = Mağaza konusu için bir ad girin
config-error-forum-not-found = Seçilen forum kanalı bulunamadı.
config-error-shop-already-in-thread = Bu konuda zaten bir mağaza kayıtlı. Yeni bir konu için bu olmamalıydı.

# ConfigShopJSONModal
config-modal-title-add-shop-json = JSON ile Yeni Mağaza Ekle
config-modal-label-upload-json = Mağaza verileri içeren bir .json dosyası yükleyin
config-error-no-json-uploaded = Mağaza için JSON dosyası yüklenmedi.
config-error-file-must-be-json = Yüklenen dosya bir JSON dosyası (.json) olmalıdır.
config-error-invalid-json = Geçersiz JSON biçimi: { $error }
config-error-json-validation-failed = JSON şemaya uymuyor: { $error }

# ShopItemModal
config-modal-title-shop-item = Mağaza Eşyası Ekle/Düzenle
config-modal-label-item-name = Eşya Adı
config-modal-placeholder-item-name = Eşyanın adını girin
config-modal-label-item-description = Eşya Açıklaması
config-modal-placeholder-item-description = Eşya için bir açıklama girin
config-modal-label-item-quantity = Eşya Miktarı
config-modal-placeholder-item-quantity = Satın alma başına satılan miktarı girin
config-modal-label-item-costs = Eşya Maliyetleri
config-modal-placeholder-item-costs = Ör.: 10 altın + 5 gümüş\nVEYA: 50 itibar\n(VE için + kullanın, VEYA için Yeni Satır)
config-error-item-quantity-positive = Eşya miktarı pozitif bir tam sayı olmalıdır.
config-error-cost-format-invalid = Seçenekte geçersiz maliyet biçimi: "{ $option }". Her maliyet bir miktar ve bir para birimi içermeli, aralarında boşluk olmalıdır, ör. "10 altın".
config-error-cost-amount-invalid = "{ $currency }" para birimi için geçersiz miktar "{ $amount }". Miktar pozitif bir sayı olmalıdır.
config-error-unknown-currency = Bilinmeyen para birimi `{ $currency }`. Lütfen bu sunucu için yapılandırılmış geçerli bir para birimi kullanın.
config-error-item-already-exists = Bu mağazada { $itemName } adlı bir eşya zaten mevcut.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = JSON ile Mağazayı Güncelle
config-modal-label-upload-new-json = Yeni JSON tanımı yükleyin
config-error-no-file-uploaded = Dosya yüklenmedi.
config-error-file-must-be-json-ext = Dosya `.json` uzantılı olmalıdır.
config-error-json-validation-message = JSON doğrulaması başarısız: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Yeni Karakter Ekipmanı Ekle/Düzenle
config-modal-placeholder-item-quantity-selection = Seçim başına alınan miktarı girin
config-modal-label-item-cost = Eşya Maliyeti
config-error-cost-format-short = Geçersiz maliyet biçimi: '{ $component }'. Beklenen: 'Miktar ParaBirimi'.
config-error-amount-invalid-short = '{ $currency }' para birimi için geçersiz miktar '{ $amount }'.
config-error-item-exists-new-char = Yeni Karakter mağazasında { $itemName } adlı bir eşya zaten mevcut.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Yeni Karakter Mağazasını Yükle (JSON)
config-error-no-json-uploaded-short = JSON dosyası yüklenmedi.
config-error-json-must-have-shopstock = JSON bir 'shopStock' dizisi içermelidir.
config-error-items-must-have-name-price = Tüm eşyaların 'name' ve 'price' alanları olmalıdır.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Yeni Karakter Servetini Ayarla
config-modal-label-amount = Miktar
config-modal-placeholder-amount = Bu para biriminin miktarını girin.
config-modal-placeholder-currency-name = Bu sunucuda tanımlanmış bir para biriminin adını girin
config-error-no-currencies-configured = Bu sunucuda para birimi yapılandırılmamış.
config-error-currency-not-found = { $name } adında para birimi veya birim bulunamadı. Lütfen geçerli bir para birimi kullanın.

# CreateStaticKitModal
config-modal-title-create-kit = Yeni Sabit Kit Oluştur
config-modal-label-kit-name = Kit Adı
config-modal-placeholder-kit-name = ör. Savaşçı Başlangıç Kiti
config-modal-label-description = Açıklama
config-modal-placeholder-kit-description = Bu kit için isteğe bağlı açıklama
config-error-kit-name-exists = "{ $kitName }" adında bir sabit kit zaten mevcut. Lütfen farklı bir ad seçin.

# StaticKitItemModal
config-modal-title-kit-item = Kit Eşyası Ekle/Düzenle
config-modal-placeholder-kit-item-quantity = Kite dahil edilecek eşya miktarını girin

# StaticKitCurrencyModal
config-modal-title-kit-currency = Kit Para Birimi Ekle
config-modal-placeholder-currency-eg = ör. Altın
config-modal-placeholder-amount-eg = ör. 100
config-error-amount-must-be-number = Miktar bir sayı olmalıdır.
config-error-no-currencies-on-server = Sunucuda para birimi yapılandırılmamış.
config-error-currency-not-found-short = "{ $currency }" para birimi bulunamadı.
config-error-denomination-not-found = "{ $denomination }" birimi para birimi yapılandırmasında bulunamadı.

# RoleplaySettingsModal
config-modal-title-rp-settings = Rol Yapma Ayarları
config-modal-label-min-message-length = Minimum Mesaj Uzunluğu (karakter)
config-modal-placeholder-min-message-length = Bir mesajın uygun sayılması için gereken karakter sayısı. Limitsiz için 0
config-modal-label-cooldown = Bekleme Süresi (saniye)
config-modal-placeholder-cooldown = Mesajların ödül için uygun sayılması arasındaki bekleme süresi (saniye)
config-modal-label-message-threshold = Mesaj Eşiği
config-modal-placeholder-message-threshold = Ödülü tetiklemek için gereken mesaj sayısı
config-modal-label-frequency = Sıklık (mesaj sayısı)
config-modal-placeholder-frequency = Ödül kazanmak için gereken uygun mesaj sayısı
config-error-min-length-invalid = Minimum Mesaj Uzunluğu negatif olmayan bir tam sayı olmalıdır.
config-error-cooldown-invalid = Bekleme Süresi negatif olmayan bir tam sayı olmalıdır.
config-error-threshold-invalid = Mesaj Eşiği pozitif bir tam sayı olmalıdır.
config-error-frequency-invalid = Sıklık pozitif bir tam sayı olmalıdır.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Rol Yapma Ödüllerini Yapılandır
config-modal-label-items-name-quantity = Eşyalar (Ad: Miktar)
config-modal-label-currency-name-amount = Para Birimi (Ad: Miktar)
config-error-experience-non-negative = Deneyim negatif olmayan bir tam sayı olmalıdır.
config-error-item-quantity-positive-named = "{ $itemName }" için eşya miktarı pozitif bir tam sayı olmalıdır.
config-error-currency-amount-positive = "{ $currencyName }" için para birimi miktarı pozitif bir sayı olmalıdır.

# SetItemStockModal
config-modal-title-stock-limit = Stok Limiti: { $itemName }
config-modal-label-max-stock = Maksimum Stok
config-modal-placeholder-max-stock = Maks. stoku girin (ör. 10)
config-modal-label-current-stock = Mevcut Stok
config-modal-placeholder-current-stock = Mevcut stok miktarını girin
config-modal-label-restock-increment = Yenileme miktarı (döngü başına)
config-modal-placeholder-restock-increment = Döngü başına eklenen miktar (varsayılan: 1)
config-error-max-stock-positive = Maksimum stok pozitif bir tam sayı olmalıdır.
config-error-current-stock-non-negative = Mevcut stok negatif olmayan bir tam sayı olmalıdır.
config-error-current-exceeds-max = Mevcut stok maksimum stoku aşamaz.
config-error-item-not-in-shop = "{ $itemName }" eşyası mağazada bulunamadı.

# RestockScheduleModal
config-modal-title-restock-schedule = Yeniden Stoklama Zamanlamasını Yapılandır
config-modal-restock-schedule-label = Zamanlama
config-modal-restock-schedule-none = Yok (Devre dışı)
config-modal-restock-schedule-hourly = Saatlik
config-modal-restock-schedule-daily = Günlük
config-modal-restock-schedule-weekly = Haftalık
config-modal-label-time = Saat (UTC olarak SS:DD)
config-modal-desc-current-time = Mevcut saat: { $utcTime }
config-modal-placeholder-time = ör. 14:30 (UTC ile 14:30)
config-modal-restock-day-label = Haftanın günü (yalnızca haftalık)
config-modal-restock-mode-label = Yenileme modu
config-modal-restock-mode-full = Tam (maksimuma sıfırla)
config-modal-restock-mode-incremental = Kademeli (miktar ekle)
config-error-time-format-invalid = Saat SS:DD biçiminde olmalıdır (ör. 14:30).
config-error-increment-positive = Artış miktarı pozitif bir tam sayı olmalıdır.

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = { $configName } kanalınızı arayın

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Quest Duyuru Rolünüzü seçin

# AddGMRoleSelect
config-select-placeholder-gm-roles = GM Rolünüzü/Rollerinizi seçin

# ConfigWaitListSelect
config-select-placeholder-wait-list = Bekleme Listesi boyutunu seçin
config-select-option-disabled = 0 (Devre Dışı)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Envanter Modunu Seçin
config-select-option-disabled-label = Devre Dışı
config-select-desc-disabled = Oyuncular boş envanterle başlar.
config-select-option-selection = Seçim
config-select-desc-selection = Oyuncular Yeni Karakter Mağazası'ndan serbestçe eşya seçer.
config-select-option-purchase = Satın Alma
config-select-desc-purchase = Oyuncular Yeni Karakter Mağazası'ndan belirli bir para birimiyle eşya satın alır.
config-select-option-open = Açık
config-select-desc-open = Oyuncular kendi envanterlerini elle girer.
config-select-option-static = Sabit
config-select-desc-static = Oyunculara önceden tanımlanmış bir başlangıç envanteri verilir.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Uygun Kanalları Seçin

# RoleplayModeSelect
config-select-placeholder-rp-mode = Modu Seçin
config-select-option-scheduled = Zamanlanmış
config-select-desc-scheduled = Ödüller belirtilen sıfırlama periyodunda bir kez verilir.
config-select-option-accrued = Birikimli
config-select-desc-accrued = Ödüller belirtilen aktivite seviyelerine göre tekrar tekrar verilir.

# RoleplayResetSelect
config-select-placeholder-reset-period = Sıfırlama Periyodunu Seçin
config-select-option-hourly = Saatlik
config-select-desc-hourly = Her saat sıfırlanır.
config-select-option-daily = Günlük
config-select-desc-daily = Her 24 saatte sıfırlanır.
config-select-option-weekly = Haftalık
config-select-desc-weekly = Her 7 günde sıfırlanır.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Sıfırlama Gününü Seçin

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Sıfırlama Saatini Seçin (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Bir forum kanalı seçin

# ForumThreadSelect
config-select-placeholder-thread = Bir konu seçin
config-select-option-no-threads = Aktif konu bulunamadı
config-select-desc-no-threads = Yeni bir konu oluşturun veya arşivlenmiş konuları kontrol edin
config-select-option-select-forum-first = Önce bir forum seçin
config-select-desc-select-forum-first = Lütfen yukarıdan bir forum kanalı seçin
config-select-desc-thread-id = Konu ID: { $threadId }
config-error-select-valid-thread = Lütfen geçerli bir konu seçin veya yeni bir tane oluşturun.
config-error-thread-not-found = Seçilen konu bulunamadı. Silinmiş veya arşivlenmiş olabilir.

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = Sunucu Yapılandırması - Ana Menü
config-menu-config-wizard = Yapılandırma Sihirbazı
config-menu-desc-config-wizard = Sunucunuzun ReQuest kullanmaya hazır olduğunu hızlı bir taramayla doğrulayın.
config-menu-channels = Kanallar
config-menu-desc-channels = ReQuest gönderileri için belirlenmiş kanalları ayarlayın.
config-menu-currency = Para Birimi
config-menu-desc-currency = Genel para birimi ayarları.
config-menu-players = Oyuncular
config-menu-desc-players = Deneyim puanı takibi gibi genel oyuncu ayarları.
config-menu-quests = Quest'ler
config-menu-desc-quests = Bekleme listeleri gibi genel quest ayarları.
config-menu-rp-rewards = RP Ödülleri
config-menu-desc-rp-rewards = Rol yapma ödüllerini yapılandırın.
config-menu-roles = Roller
config-menu-desc-roles = Etiketlenebilir veya ayrıcalıklı roller için yapılandırma seçenekleri.
config-menu-shops = Mağazalar
config-menu-desc-shops = Özel mağazaları yapılandırın.
config-menu-language = Dil
config-menu-desc-language = Bu sunucu için varsayılan dili ayarlayın.

## Wizard View
config-title-wizard = {"**"}Sunucu Yapılandırması - Sihirbaz{"**"}
config-wizard-intro =
    {"**"}ReQuest Yapılandırma Sihirbazına Hoş Geldiniz!{"**"}

    Bu sihirbaz, sunucunuzun ReQuest özelliklerini kullanmak için düzgün yapılandırıldığından emin olmanıza yardımcı olacaktır.
    Mevcut ayarlarınızı tarayacak ve gerekli düzenlemeler için önerilerde bulunacaktır.

    Doğrulama sürecini başlatmak için aşağıdaki "Taramayı Başlat" düğmesini kullanın. Tarama tamamlandıktan sonra,
    sunucunuzun yapılandırmasının ayrıntılı bir raporunu ve önerilen değişiklikleri alacaksınız.

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}Bot Genel İzinleri{"**"}__
config-wizard-bot-permissions-desc = Bu bölüm, ReQuest'in düzgün çalışması için gerekli izinlere sahip olduğunu doğrular.
config-wizard-bot-role = Bot Rolü: { $roleMention }
config-wizard-status-warnings = {"**"}Durum: ⚠️ UYARILAR BULUNDU{"**"}
config-wizard-missing-perm = - ⚠️ Eksik: `{ $permissionName }`
config-wizard-ensure-permissions = Lütfen botun en yüksek rolünün bu izinlere global olarak sahip olduğundan emin olun.
config-wizard-status-ok = {"**"}Durum: ✅ TAMAM{"**"}
config-wizard-bot-permissions-ok = Bot gerekli tüm global izinlere sahip.
config-wizard-status-scan-failed = {"**"}Durum: ❌ TARAMA BAŞARISIZ{"**"}
config-wizard-scan-error = Bot izinleri kontrol edilirken beklenmeyen bir hata oluştu.
config-wizard-error-type = Hata: { $errorType }
config-wizard-required-permissions = {"**"}Bot Rolü için Gerekli İzinler:{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = Kanalları Görüntüle
config-wizard-perm-manage-roles = Rolleri Yönet
config-wizard-perm-send-messages = Mesaj Gönder
config-wizard-perm-attach-files = Dosya Ekle
config-wizard-perm-add-reactions = Tepki Ekle
config-wizard-perm-use-external-emoji = Harici Emoji Kullan
config-wizard-perm-manage-messages = Mesajları Yönet
config-wizard-perm-read-message-history = Mesaj Geçmişini Oku

# Wizard - Role Validation
config-wizard-role-header = __{"**"}Rol Yapılandırmaları{"**"}__
config-wizard-role-desc =
    Bu bölüm aşağıdakileri doğrular:

    - GM rolleri (zorunlu) ve Duyuru rolü (isteğe bağlı) yapılandırılmış.
    - Varsayılan (@everyone) rolü, kullanıcıların bot özelliklerine erişmesi için gerekli izinlere sahip.
    - Varsayılan (@everyone) rolü tehlikeli izinlere sahip değil.
    - GM ve Duyuru rolleri, varsayılan rolün ötesinde izin yükseltmeleri olup olmadığı kontrol ediliyor.

    Buradaki uyarılar yalnızca varsayılan bir kuruluma dayalı önerilerdir. Sunucunuzun ihtiyaçlarına bağlı olarak, bu önerilerden bazılarını göz ardı etmeniz için nedenleriniz olabilir.

config-wizard-default-role-label = {"**"}Varsayılan Rol:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Tehlikeli İzinler Bulundu:
config-wizard-default-role-ok = - ✅ @everyone: Tamam
config-wizard-missing-permission = - Eksik İzin: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}GM Rolleri:{"**"}
config-wizard-no-gm-roles = - ⚠️ GM Rolleri Yapılandırılmamış
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Yapılandırılmış Rol Bulunamadı/Sunucudan Silindi
config-wizard-role-ok = - ✅ { $roleMention }: Tamam
config-wizard-announcement-role-label = {"**"}Duyuru Rolü:{"**"}
config-wizard-no-announcement-role = - ℹ️ Duyuru Rolü Yapılandırılmamış
config-wizard-announcement-role-not-found = - ⚠️ Yapılandırılmış Rol Bulunamadı/Sunucudan Silindi
config-wizard-escalation-detected = - ⚠️ { $roleMention }: İzin Yükseltmeleri Tespit Edildi - { $escalations }
config-wizard-escalation-more = , ve { $count } tane daha...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = Konularda Mesaj Gönder
config-wizard-perm-use-application-commands = Uygulama Komutlarını Kullan

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = Kanalları Yönet
config-wizard-perm-manage-webhooks = Webhook'ları Yönet
config-wizard-perm-manage-server = Sunucuyu Yönet
config-wizard-perm-manage-nicknames = Takma Adları Yönet
config-wizard-perm-kick-members = Üyeleri At
config-wizard-perm-ban-members = Üyeleri Yasakla
config-wizard-perm-timeout-members = Üyeleri Sustur
config-wizard-perm-mention-everyone = @everyone Etiketle
config-wizard-perm-manage-threads = Konuları Yönet
config-wizard-perm-administrator = Yönetici

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}Kanal Yapılandırmaları{"**"}__
config-wizard-channel-desc =
    Bu bölüm aşağıdakileri doğrular:

    - Yapılandırılmış kanallar mevcut.
    - Bot yapılandırılmış kanallarda mesaj görüntüleme ve gönderme iznine sahip.
    - Varsayılan (@everyone) rolü `Mesaj Gönder` iznine sahip değil.

config-wizard-channel-no-config-required = - ⚠️ Kanal Yapılandırılmamış
config-wizard-channel-not-configured = - ℹ️ Yapılandırılmamış (İsteğe Bağlı)
config-wizard-channel-not-found = - ⚠️ Yapılandırılmış Kanal Bulunamadı/Sunucudan Silindi
config-wizard-channel-ok = - ✅ Tamam
config-wizard-bot-cannot-view = - ⚠️ { $botMention } bu kanalı görüntüleyemiyor.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } bu kanalda mesaj gönderemiyor.
config-wizard-everyone-can-send = - ⚠️ @everyone bu kanalda mesaj gönderebilir.

# Wizard - Channel names
config-wizard-channel-quest-board = Quest Panosu
config-wizard-channel-player-board = Oyuncu Panosu
config-wizard-channel-quest-archive = Quest Arşivi
config-wizard-channel-gm-transaction-log = GM İşlem Günlüğü
config-wizard-channel-player-transaction-log = Oyuncu İşlem Günlüğü
config-wizard-channel-shop-log = Mağaza Günlüğü
config-wizard-channel-approval-queue = Karakter Onay Kuyruğu

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}Ayarlar Kontrol Paneli{"**"}__
config-wizard-dashboard-desc = Bu bölüm, hızlı referans için zorunlu olmayan yapılandırmalara genel bir bakış sunar.
config-wizard-quest-settings = {"**"}Quest Ayarları{"**"}
config-wizard-quest-wait-list = - Quest Bekleme Listesi Boyutu: { $size }
config-wizard-quest-summary = - Quest Özeti: { $status }
config-wizard-gm-rewards-per-quest = {"**"}GM Ödülleri (Quest Başına){"**"}
config-wizard-player-settings = {"**"}Oyuncu Ayarları{"**"}
config-wizard-player-experience = - Oyuncu Deneyimi: { $status }
config-wizard-currency-settings = {"**"}Para Birimi Ayarları{"**"}
config-wizard-rp-rewards = {"**"}Rol Yapma Ödülleri{"**"}
config-wizard-rp-status = - Durum: { $status }
config-wizard-rp-mode = - Mod: { $mode }
config-wizard-rp-channels = - İzlenen Kanallar: { $count }
config-wizard-shops = {"**"}Mağazalar{"**"}
config-wizard-shops-count = - Yapılandırılmış Mağazalar: { $count }
config-wizard-shops-more = - ...ve { $count } tane daha
config-wizard-new-char-setup = {"**"}Yeni Karakter Kurulumu{"**"}
config-wizard-inventory-type = - Envanter Türü: { $type }
config-wizard-new-char-shop-items = - Yeni Karakter Mağazası Eşyaları: { $count }
config-wizard-static-kits = - Sabit Kitler: { $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ Para Birimi Yapılandırılmamış
config-wizard-configured-currencies = {"**"}Yapılandırılmış Para Birimleri:{"**"}
config-wizard-no-denominations = - Birim Yapılandırılmamış
config-wizard-gm-rewards-disabled = {"**"}Durum:{"**"} Devre Dışı
config-wizard-gm-rewards-enabled = {"**"}Durum:{"**"} Etkin
config-wizard-gm-rewards-experience = - Deneyim: { $xp }
config-wizard-gm-rewards-items = - Eşyalar:
config-wizard-unnamed-shop = İsimsiz Mağaza

## Roles View
config-title-roles = {"**"}Sunucu Yapılandırması - Roller{"**"}
config-label-announcement-role = {"**"}Duyuru Rolü:{"**"} { $status }
config-desc-announcement-role = Bu rol, bir quest yayınlandığında etiketlenir.
config-label-announcement-role-default = {"**"}Duyuru Rolü:{"**"} Yapılandırılmamış
config-label-gm-roles = {"**"}GM Rolleri:{"**"} { $roles }
config-desc-gm-roles = Bu roller GM komutlarına ve özelliklerine erişim sağlar.
config-label-gm-roles-default = {"**"}GM Rolleri:{"**"} Yapılandırılmamış
config-title-forbidden-roles = __{"**"}Yasaklı Roller{"**"}__
config-desc-forbidden-roles =
    GM'ler tarafından grup rolleri için kullanılamayacak rol adlarının listesini yapılandırır.
    Varsayılan olarak `everyone`, `administrator`, `gm` ve `game master` kullanılamaz. Bu yapılandırma
    bu listeyi genişletir.

## GM Role Remove View
config-title-remove-gm-roles = {"**"}Sunucu Yapılandırması - GM Rollerini Kaldır{"**"}
config-msg-no-gm-roles = GM rolleri yapılandırılmamış.

## Channels View
config-title-channels = {"**"}Sunucu Yapılandırması - Kanallar{"**"}

config-label-quest-board = {"**"}Quest Panosu:{"**"} { $channel }
config-desc-quest-board = Yeni/aktif quest'lerin yayınlanacağı kanal.
config-label-quest-board-default = {"**"}Quest Panosu:{"**"} Yapılandırılmamış

config-label-player-board = {"**"}Oyuncu Panosu:{"**"} { $channel }
config-desc-player-board = Oyuncuların kullanımı için isteğe bağlı bir duyuru/mesaj panosu.
config-label-player-board-default = {"**"}Oyuncu Panosu:{"**"} Yapılandırılmamış

config-label-quest-archive = {"**"}Quest Arşivi:{"**"} { $channel }
config-desc-quest-archive = Tamamlanmış quest'lerin özet bilgileriyle taşınacağı isteğe bağlı bir kanal.
config-label-quest-archive-default = {"**"}Quest Arşivi:{"**"} Yapılandırılmamış

config-label-gm-transaction-log = {"**"}GM İşlem Günlüğü:{"**"} { $channel }
config-desc-gm-transaction-log = GM işlemlerinin (Oyuncu Değiştirme komutları gibi) kaydedileceği isteğe bağlı bir kanal.
config-label-gm-transaction-log-default = {"**"}GM İşlem Günlüğü:{"**"} Yapılandırılmamış

config-label-player-transaction-log = {"**"}Oyuncu İşlem Günlüğü:{"**"} { $channel }
config-desc-player-transaction-log = Takas ve eşya tüketimi gibi oyuncu işlemlerinin kaydedileceği isteğe bağlı bir kanal.
config-label-player-transaction-log-default = {"**"}Oyuncu İşlem Günlüğü:{"**"} Yapılandırılmamış

config-label-shop-log = {"**"}Mağaza Günlüğü:{"**"} { $channel }
config-desc-shop-log = Mağaza işlemlerinin kaydedileceği isteğe bağlı bir kanal.
config-label-shop-log-default = {"**"}Mağaza Günlüğü:{"**"} Yapılandırılmamış

## Quests View
config-title-quests = {"**"}Sunucu Yapılandırması - Quest'ler{"**"}

config-label-wait-list = {"**"}Quest Bekleme Listesi Boyutu:{"**"} { $size }
config-desc-wait-list = Bekleme listesi, dolu olan bir quest için belirtilen sayıda oyuncunun, bir oyuncunun ayrılması durumunda sıraya girmesine olanak tanır.
config-label-wait-list-disabled = {"**"}Quest Bekleme Listesi Boyutu:{"**"} Devre Dışı

config-label-quest-summary = {"**"}Quest Özeti:{"**"} { $status }
config-desc-quest-summary = Bu seçenek, GM'lerin quest'leri kapatırken kısa bir özet sunmasını sağlar.
config-label-quest-summary-disabled = {"**"}Quest Özeti:{"**"} Devre Dışı

config-label-gm-rewards = GM Ödülleri
config-desc-gm-rewards = GM'lerin quest'leri tamamladıklarında alacakları ödülleri yapılandırın.

## GM Rewards View
config-title-gm-rewards = {"**"}Sunucu Yapılandırması - GM Ödülleri{"**"}
config-desc-gm-rewards-detail =
    {"**"}Ödül Ekle/Düzenle{"**"}
    Ödülleri eklemek, düzenlemek veya kaldırmak için giriş penceresi açar.

    > Yapılandırılan ödüller quest başınadır. Bir GM her quest tamamladığında,
    aşağıda yapılandırılan ödülleri aktif karakterinde alacaktır.
config-msg-no-rewards = Ödül yapılandırılmamış.
config-label-gm-experience = {"**"}Deneyim:{"**"} { $xp }
config-label-gm-items = {"**"}Eşyalar:{"**"}

## Players View
config-title-players = {"**"}Sunucu Yapılandırması - Oyuncular{"**"}

config-label-player-experience = {"**"}Oyuncu Deneyimi:{"**"} { $status }
config-desc-player-experience = Deneyim puanlarının (veya benzer değer tabanlı karakter gelişiminin) kullanımını etkinleştirir/devre dışı bırakır.
config-label-player-experience-disabled = {"**"}Oyuncu Deneyimi:{"**"} Devre Dışı

config-label-new-char-settings = {"**"}Yeni Karakter Ayarları{"**"}
config-desc-new-char-settings = Yeni oyuncu karakterleri ve başlangıç envanterlerinin nasıl oluşturulacağıyla ilgili ayarları yapılandırın.

config-label-player-board-purge = {"**"}Oyuncu Panosu Temizliği{"**"}
config-desc-player-board-purge = Oyuncu panosundaki gönderileri temizler (etkinse).

## New Character Settings View
config-title-new-character = {"**"}Sunucu Yapılandırması - Yeni Karakter Ayarları{"**"}

config-label-inventory-type = {"**"}Yeni Karakter Envanter Türü:{"**"} { $type }
config-desc-inventory-type = Yeni kaydedilen karakterlerin envanterlerinin nasıl başlatılacağını belirler.
config-label-inventory-type-disabled = {"**"}Yeni Karakter Envanter Türü:{"**"} Devre Dışı

config-label-new-char-wealth = {"**"}Yeni Karakter Serveti:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Yeni Karakter Serveti:{"**"} Devre Dışı

config-label-approval-queue = {"**"}Onay Kuyruğu:{"**"} { $channel }
config-desc-approval-queue = Ayarlanırsa, yeni karakterler aktif olmadan önce bu Forum Kanalında bir GM tarafından onaylanmalıdır.
config-label-approval-queue-disabled = {"**"}Onay Kuyruğu:{"**"} Devre Dışı
config-label-approval-queue-not-configured = {"**"}Onay Kuyruğu:{"**"} Yapılandırılmamış

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = Oyuncular boş envanterle başlar.
config-desc-inv-type-selection = Oyuncular Yeni Karakter Mağazası'ndan serbestçe eşya seçer.
config-desc-inv-type-purchase = Oyuncular Yeni Karakter Mağazası'ndan belirli bir para birimiyle eşya satın alır.
config-desc-inv-type-open = Oyuncular envanter eşyalarını elle girer.
config-desc-inv-type-static = Oyunculara önceden tanımlanmış bir başlangıç envanteri verilir.

## New Character Shop View
config-title-new-char-shop = {"**"}Sunucu Yapılandırması - Yeni Karakter Mağazası{"**"}
config-label-inv-type-selection = {"**"}Envanter Türü:{"**"} Seçim
config-desc-inv-type-selection-shop = Oyuncular Yeni Karakter Mağazası'ndan serbestçe eşya seçer.
config-label-inv-type-purchase = {"**"}Envanter Türü:{"**"} Satın Alma
config-desc-inv-type-purchase-shop = Oyuncular Yeni Karakter Mağazası'ndan belirli bir para birimiyle eşya satın alır.
config-label-inv-type-other = {"**"}Envanter Türü:{"**"} { $type }
config-desc-inv-type-not-in-use = Yeni Karakter Mağazası kullanımda değil.
config-msg-define-shop-items = Mağaza eşyalarını tanımlayın.
config-msg-no-items = Eşya yapılandırılmamış.

## Static Kits View
config-title-static-kits = {"**"}Sunucu Yapılandırması - Sabit Kitler{"**"}
config-desc-create-kit = Yeni bir kit tanımı oluşturun.
config-msg-no-kits = Kit yapılandırılmamış.
config-label-kit-more-items = ...ve { $count } eşya daha
config-label-empty-kit = {"*"}Boş Kit{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}Kit Düzenleniyor: { $kitName }{"**"}
config-msg-kit-empty = Bu kit boş. Para birimi veya eşya eklemek için yukarıdaki düğmeleri kullanın.
config-label-kit-currency = {"**"}Para Birimi:{"**"} { $display }
config-label-kit-item = {"**"}Eşya:{"**"} { $name }

## Currency View
config-title-currency = {"**"}Sunucu Yapılandırması - Para Birimi{"**"}
config-desc-create-currency = Yeni bir para birimi oluşturun.
config-msg-no-currencies = Para birimi yapılandırılmamış.
config-label-currency-display-type = Görüntüleme Türü: { $type } | Birimler: { $count }
config-label-currency-type-double = Ondalık
config-label-currency-type-integer = Tam Sayı

## Edit Currency View
config-title-manage-currency = {"**"}Para Birimi Yönet: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Para Birimi ve Birimler{"**"}__
    - Para biriminize verdiğiniz ad, temel para birimi olarak kabul edilir ve değeri 1'dir.
    {"```"}Örnek: "altın" para birimi olarak yapılandırılmış.{"```"}
    - Bir birim eklemek, bir ad ve temel para birimine göre bir değer belirtmeyi gerektirir.
    {"```"}Örnek: Altına iki birim eklenir: gümüş (değeri 0.1) ve bakır (değeri 0.01).{"```"}
    - Temel para birimi veya birimleriyle ilgili işlemler otomatik olarak dönüştürülür.
    {"```"}Örnek: 10 altını olan bir oyuncu 3 bakır harcar. Yeni bakiyesi otomatik olarak
    9 altın, 9 gümüş ve 7 bakır olarak görüntülenir.{"```"}
    - Tam sayı olarak görüntülenen para birimleri her birimi gösterirken, ondalık olarak görüntülenen
    para birimleri yalnızca temel para birimi olarak gösterilir.
    {"```"}Örnek: Yukarıdaki oyuncu ondalık görüntüleme etkinken 9.97 altın olarak gösterilir.{"```"}
config-btn-toggle-display-current = Görünümü Aç/Kapat (Mevcut: { $type })
config-msg-no-denominations = Birim yapılandırılmamış.

## Shops View
config-title-shops = {"**"}Sunucu Yapılandırması - Mağazalar{"**"}
config-desc-add-shop-wizard =
    {"**"}Mağaza Ekle (Sihirbaz){"**"}
    Bir formdan yeni, boş bir mağaza oluşturun.
config-desc-add-shop-json =
    {"**"}Mağaza Ekle (JSON){"**"}
    Tam bir JSON tanımı sağlayarak yeni bir mağaza oluşturun. (Gelişmiş)
config-btn-example-json = Örnek JSON
config-desc-example-json =
    {"**"}Örnek JSON{"**"}
    Beklenen formatı gösteren örnek bir JSON dosyası indirin.
config-msg-example-json = İşte beklenen formatı gösteren örnek bir JSON dosyası.
config-msg-no-shops = Mağaza yapılandırılmamış.
config-label-shop-type-forum = (Forum)
config-label-shop-channel = Kanal: <#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}Mağaza Ekle - Konum Türü Seçin{"**"}
config-label-text-channel = {"**"}Metin Kanalı{"**"}
config-desc-text-channel = Standart bir metin kanalında mağaza oluşturun.
config-label-forum-thread = {"**"}Forum Konusu{"**"}
config-desc-forum-thread = Bir forum konusunda (yeni veya mevcut) mağaza oluşturun.

## Forum Shop Setup View
config-title-forum-setup = {"**"}Mağaza Ekle - Forum Konu Kurulumu{"**"}
config-label-step1 = {"**"}Adım 1: Bir Forum Kanalı Seçin{"**"}
config-label-step2 = {"**"}Adım 2: Konu Seçeneğini Belirleyin{"**"}
config-label-step3 = {"**"}Adım 3: Mevcut Bir Konu Seçin{"**"}
config-desc-create-new-thread =
    {"**"}Yeni Konu Oluştur{"**"}
    Yeni bir konu oluşturmak ve mağazayı yapılandırmak için bir form açar.
config-label-selected-thread = {"**"}Seçilen Konu:{"**"} { $threadName }
config-desc-click-to-configure = Bu konuda mağazayı yapılandırmak için tıklayın.

## Manage Shop View
config-title-manage-shop = {"**"}Mağaza Yönet: { $shopName }{"**"}
config-label-shop-type = {"**"}Tür:{"**"} { $type }
config-label-shop-type-text = Metin Kanalı
config-label-shop-type-forum-thread = Forum Konusu
config-label-shopkeeper = {"**"}Mağazacı:{"**"} { $name }
config-label-shop-description = {"**"}Açıklama:{"**"} { $description }
config-label-shop-channel-info = {"**"}Kanal:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Mağaza detaylarını ve eşyalarını Sihirbaz ile düzenleyin.
config-desc-upload-json = Bu mağaza için yeni bir JSON tanımı yükleyin.
config-desc-download-json = Mevcut JSON tanımını indirin.
config-desc-remove-shop = Bu mağazayı kalıcı olarak kaldırın.

## Edit Shop View
config-title-editing-shop = {"**"}Mağaza Düzenleniyor: { $shopName }{"**"}
config-label-shop-shopkeeper = Mağazacı: {"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}Stok Yapılandırması: { $shopName }{"**"}
config-label-current-utc = Mevcut UTC Saati: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Yeniden Stoklama Zamanlaması:{"**"} { $schedule }
config-label-restock-hourly = :{ $minute } dakikasında
config-label-restock-daily = { $time } UTC'de
config-label-restock-weekly = { $day } günü { $time } UTC'de
config-label-restock-mode = {"**"}Mod:{"**"} { $mode }
config-label-restock-full = Tam yeniden stoklama
config-label-restock-incremental = Kademeli (öğe başına miktarlar)
config-label-restock-disabled = {"**"}Yeniden Stoklama Zamanlaması:{"**"} Devre Dışı
config-label-item-stock-limits = {"**"}Eşya Stok Limitleri{"**"}
config-msg-no-items-in-shop = Bu mağazada eşya yok.
config-label-stock-with-available = Maks: { $max } | Mevcut: { $available }
config-label-stock-increment = Yenileme: +{ $increment }/döngü
config-label-stock-reserved =  | Rezerve: { $reserved }
config-label-stock-not-initialized = Maks: { $max } | Mevcut: (başlatılmamış)
config-label-stock-unlimited = Stok: Sınırsız

## Roleplay View
config-title-roleplay = {"**"}Sunucu Yapılandırması - Rol Yapma Ödülleri{"**"}
config-label-rp-status = {"**"}Durum:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Sunucu Saati:{"**"} `{ $time }`
config-label-rp-enabled = Etkin
config-label-rp-disabled = Devre Dışı

config-desc-rp-mode-scheduled = {"```"}Ödüller, belirlenen zaman dilimi (saatlik, günlük veya haftalık) içinde gerekli eşik sayıda uygun mesaj gönderildikten sonra bir kez dağıtılır.{"```"}
config-desc-rp-mode-accrued = {"```"}Ödüller, belirli sayıda uygun mesaj gönderildiğinde tekrarlayan şekilde dağıtılır.{"```"}

config-label-rp-config-details = {"**"}Yapılandırma Ayrıntıları:{"**"}
config-label-rp-mode = {"**"}Mod:{"**"} { $mode }
config-label-rp-min-length = {"**"}Minimum Mesaj Uzunluğu:{"**"} { $length } karakter
config-label-rp-cooldown = {"**"}Bekleme Süresi:{"**"} { $seconds } saniye
config-label-rp-frequency-once = {"**"}Sıklık:{"**"} { $period } başına bir kez
config-label-rp-reset-time = {"**"}Sıfırlama Saati:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Eşik:{"**"} { $count } uygun mesaj
config-label-rp-frequency-every = {"**"}Sıklık:{"**"} Her { $count } uygun mesajda bir

config-label-rp-channels = {"**"}Rol Yapma Kanalları:{"**"}
config-msg-rp-no-channels = Yapılandırılmamış.
config-label-rp-channels-more = ...ve { $count } tane daha.

config-label-rp-rewards = {"**"}Ödüller:{"**"}
config-msg-rp-no-rewards = Yapılandırılmamış.
config-label-rp-experience = {"**"}Deneyim:{"**"} { $xp }
config-label-rp-items = {"**"}Eşyalar:{"**"}
config-label-rp-currency = {"**"}Para Birimi:{"**"}

## Language View
config-title-language = {"**"}Sunucu Yapılandırması - Dil{"**"}
config-server-language-help =
    Bu ayar, bu sunucudaki ReQuest'in {"**"}herkese açık{"**"} yanıtları ve mesajları için varsayılan dili belirlemenizi sağlar. Herkese açık yanıtlar şunları içerir:
    - Quest ve Oyuncu Panosu gönderileri
    - Quest Özeti ve Günlük Kanalı mesajları
    - Mağaza yeniden stoklaması
    - Oyuncu eşya tüketimi

    Bu ayar yalnızca bot tarafından oluşturulan sabit metinleri etkiler ve kullanıcı tarafından girilen eşya adları veya quest açıklamaları gibi dinamik içeriği çevirmez.

    Kişisel yanıtlar ve menüler bu ayardan etkilenmez.
config-label-server-language = {"**"}Sunucu Dili:{"**"} { $language }
config-label-server-language-default = {"**"}Sunucu Dili:{"**"} Varsayılan (geçersiz kılma yok)
config-select-placeholder-server-language = Sunucu dilini seçin
config-select-option-default = Varsayılan (geçersiz kılma yok)
config-select-desc-default = Her kullanıcının tercihini veya Discord yerel ayarını kullanın.

# Quest Roles
config-btn-quest-roles = Quest Rolleri
config-btn-manage-gm-quest-roles = Yönet

config-modal-title-confirm-quest-role-removal = Rol Kaldırmayı Onayla
config-modal-label-remove-quest-role = { $roleName } rolünü { $gmName } üzerinden kaldır?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Quest Rol Modunu Seçin
config-select-option-quest-role-disabled = Devre Dışı
config-select-desc-quest-role-disabled = Hiçbir rol oluşturulmaz veya atanmaz.
config-select-option-quest-role-temporary = Geçici
config-select-desc-quest-role-temporary = GM'ler quest başına geçici roller oluşturabilir.
config-select-option-quest-role-static = Sabit
config-select-desc-quest-role-static = GM'ler önceden atanmış sunucu rollerinden seçer.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Bu GM'ye sunucu rolü/rolleri atayın

## Quest Roles View
config-title-quest-roles = {"**"}Sunucu Yapılandırması - Quest Rolleri{"**"}
config-label-quest-roles = Quest Rolleri
config-desc-quest-roles =
    Quest'ler sırasında grup rollerinin nasıl yönetileceğini yapılandırın.

config-label-quest-role-mode-disabled = {"**"}Quest Rol Modu:{"**"} Devre Dışı
    Quest'ler sırasında hiçbir rol oluşturulmaz veya atanmaz.
config-label-quest-role-mode-temporary = {"**"}Quest Rol Modu:{"**"} Geçici
    GM'ler quest oluşturma sırasında isteğe bağlı olarak geçici bir rol oluşturabilir.
    Quest tamamlandığında veya iptal edildiğinde rol silinir.
config-label-quest-role-mode-static = {"**"}Quest Rol Modu:{"**"} Sabit
    GM'ler önceden atanmış sunucu rollerinden seçer. Roller quest
    sırasında grup üyelerine atanır ancak asla silinmez.

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}Sunucu Yapılandırması - Sabit Quest Rol Atamaları{"**"}
config-label-manage-assignments = Rol Atamalarını Yönet
config-desc-manage-assignments =
    Quest'ler sırasında kullanılmak üzere mevcut sunucu rollerini GM'lere atayın.
    Roller, sunucu hiyerarşisinde ReQuest'in en yüksek rolünün altında olmalıdır.
config-msg-no-gm-members = Bu sunucuda GM rolüne sahip üye bulunamadı.
config-label-no-roles-assigned = Atanmış quest rolü yok

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}Quest Rollerini Yönet — { $gmName }{"**"}
config-error-unmanageable-roles = Aşağıdaki roller bir entegrasyon tarafından yönetildiği, varsayılan rol olduğu veya ReQuest'in en yüksek rolünün üzerinde olduğu için atanamaz: { $roles }
config-error-quest-role-limit = Bu GM, atanabilecek maksimum { $limit } quest rol sayısına ulaştı.
config-label-quest-role-count = Atanan roller: { $count }/{ $limit }
