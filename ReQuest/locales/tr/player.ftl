## Player module strings

# --- Cog ---

player-cmd-name = Takas
player-cmd-desc = Oyuncu Menüleri

# --- Buttons ---

# Character management
player-btn-register-character = Yeni Karakter Kaydet
player-btn-activate = Etkinleştir
player-btn-active = Aktif

# Player board
player-btn-create-post = Gönderi Oluştur
player-btn-open-starting-shop = Başlangıç Mağazasını Aç
player-btn-select-kit = Kit Seç
player-btn-input-inventory = Envanteri Gir

# Wizard / shop buttons
player-btn-add-to-cart = Sepete Ekle
player-btn-add-to-cart-cost = Sepete Ekle ({ $costString })
player-btn-view-purchase-options = Satın Alma Seçeneklerini Görüntüle
player-btn-review-submit = İncele ve Gönder ({ $count })
player-btn-submit-character = Karakteri Gönder
player-btn-keep-shopping = Alışverişe Devam Et
player-btn-edit-quantity = Miktarı Düzenle
player-btn-clear-cart = Sepeti Temizle

# Kit buttons
player-btn-confirm-selection = Seçimi Onayla
player-btn-back-to-kits = Kitlere Dön

# Inventory management
player-btn-spend-currency = Para Birimi Harca
player-btn-print-inventory = Envanteri Yazdır

# Container management
player-btn-manage-containers = Kapları Yönet
player-btn-create-new = + Yeni Oluştur
player-btn-consume-destroy = Tüket/Yok Et
player-btn-move = Taşı
player-btn-move-all = Tümünü Taşı
player-btn-move-some = Bir Kısmını Taşı...
player-btn-back-to-overview = ← Genel Bakışa Dön
player-btn-cancel-move = ← İptal
player-btn-up = ▲ Yukarı
player-btn-down = ▼ Aşağı

# --- Modals ---

# Trade modal
player-modal-title-trade = { $targetName } ile Takas
player-modal-label-trade-name = Ad
player-modal-placeholder-trade-name = Takas ettiğiniz eşyanın adını girin
player-modal-label-trade-quantity = Miktar
player-modal-placeholder-trade-quantity = Takas ettiğiniz miktarı girin

# Character register modal
player-modal-title-register = Yeni Karakter Kaydet
player-modal-label-char-name = Ad
player-modal-placeholder-char-name = Karakterinizin adını girin.
player-modal-label-char-note = Not
player-modal-placeholder-char-note = Karakterinizi tanımlamak için bir not girin

# Open inventory input modal
player-modal-title-starting-inventory = Başlangıç Envanteri Girişi
player-modal-label-inventory = Envanter
player-modal-placeholder-inventory-input =
    Her satıra bir tane, <ad>: <miktar> biçiminde, ör.:
    Kılıç: 1
    altın: 30

# Spend currency modal
player-modal-title-spend-currency = Para Birimi Harca
player-modal-label-currency-name = Para Birimi Adı
player-modal-placeholder-currency-name = Harcadığınız para biriminin adını girin
player-modal-label-currency-amount = Miktar
player-modal-placeholder-currency-amount = Harcanacak miktarı girin

# Create player post modal
player-modal-title-create-post = Oyuncu Panosu Gönderisi Oluştur
player-modal-label-post-title = Başlık
player-modal-placeholder-post-title = Gönderiniz için bir başlık girin
player-modal-label-post-content = Gönderi İçeriği
player-modal-placeholder-post-content = Gönderinizin içeriğini girin

# Edit player post modal
player-modal-title-edit-post = Oyuncu Panosu Gönderisini Düzenle

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = Sepet Miktarını Düzenle
player-modal-label-cart-qty = Miktar
player-modal-placeholder-cart-qty = Yeni miktarı girin (kaldırmak için 0)

# Create container modal
player-modal-title-create-container = Yeni Kap Oluştur
player-modal-label-container-name = Kap Adı
player-modal-placeholder-container-name = Kabınız için bir ad girin (ör. Sırt Çantası)

# Rename container modal
player-modal-title-rename-container = Kabı Yeniden Adlandır
player-modal-label-new-container-name = Yeni Kap Adı
player-modal-placeholder-new-container-name = Yeni adı girin

# Consume from container modal
player-modal-title-consume = Eşya Tüket/Yok Et
player-modal-label-consume-qty = Miktar (maks: { $maxQuantity })
player-modal-placeholder-consume-qty = Tüketilecek/yok edilecek miktarı girin

# Move item quantity modal
player-modal-title-move-item = Eşya Taşı
player-modal-label-move-qty = Taşınacak miktar (maks: { $maxQuantity })
player-modal-placeholder-move-qty = Taşınacak miktarı girin

# --- Selects ---

player-select-placeholder-no-characters = Kayıtlı karakteriniz yok
player-select-placeholder-remove-character = Kaldırılacak bir karakter seçin
player-select-placeholder-post = Bir gönderi seçin
player-select-placeholder-container-view = Görüntülenecek bir kap seçin...
player-select-placeholder-item = Bir eşya seçin...
player-select-placeholder-destination = Hedefi seçin...
player-select-placeholder-container = Bir kap seçin...
player-select-option-no-containers = Kap yok
player-select-option-no-items = Eşya yok
player-select-option-no-destinations = Hedef yok

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}Oyuncu Komutları - Ana Menü{"**"}
player-menu-btn-characters = Karakterler
player-menu-desc-characters = Oyuncu karakterlerini kaydedin, görüntüleyin ve etkinleştirin.
player-menu-btn-inventory = Envanter
player-menu-desc-inventory = Aktif karakterinizin envanterini görüntüleyin ve para birimi harcayın.
player-menu-btn-player-board = Oyuncu Panosu
player-menu-btn-player-board-disabled = Oyuncu Panosu (Yapılandırılmamış)
player-menu-desc-player-board = Oyuncu Panosu için bir gönderi oluşturun

# CharacterBaseView
player-title-characters = {"**"}Oyuncu Komutları - Karakterler{"**"}
player-desc-register-character = Yeni bir karakter kaydedin.
player-msg-no-characters = Kayıtlı karakteriniz yok.
player-label-active = (Aktif)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Devam eden karakter: { $characterName }{"**"}
    Karakter kaydınız envanter ayarını bekliyor.
player-btn-resume = Devam et
player-btn-discard = İptal et
player-modal-title-discard-character = Karakteri iptal et
player-modal-label-discard-confirm = { $characterName } iptal edilsin mi?

# Confirm character removal
player-modal-title-confirm-char-removal = Karakter Kaldırmayı Onayla
player-modal-label-confirm-char-delete = { $characterName } silinsin mi?

# Confirm post removal
player-modal-title-confirm-post-removal = Gönderi Kaldırmayı Onayla
player-modal-label-post-removal-warning = UYARI: Bu işlem geri alınamaz!

# InventoryOverviewView
player-title-inventory = {"**"}Oyuncu Komutları - Envanter{"**"}
player-title-char-inventory = {"**"}{ $characterName } Envanteri{"**"}
player-msg-no-active-character = Aktif Karakter Yok: Bu menüleri kullanmak için bu sunucuda bir karakter etkinleştirin.
player-msg-no-characters-registered = Karakter Yok: Bu menüleri kullanmak için bir karakter kaydedin.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } eşya
player-label-currency = {"**"}Para Birimi{"**"}
player-msg-inventory-empty = Envanter boş.

# Print inventory embed
player-embed-title-inventory = { $characterName } Envanteri

# ContainerItemsView
player-msg-container-empty = Bu kap boş.
player-label-selected-item = Seçili: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}"{ $itemName }" Taşı{"**"} ({ $available } mevcut)
player-msg-no-other-containers = Başka kap mevcut değil.
player-msg-select-destination = Hedef kabı seçin:
player-label-destination = Hedef: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Kapları Yönet{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } eşya){ $suffix }
player-label-default-suffix = { " " }(varsayılan)
player-msg-no-containers = Kap yok.
player-label-selected-container = Seçili: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = Kap Silmeyi Onayla
player-modal-label-container-has-items = { $itemCount } eşya içeriyor. Serbest Eşyalara taşınacak.
player-modal-label-confirm-container-delete = "{ $containerName }" silinsin mi?

# Container errors
player-error-cannot-rename-loose = Serbest Eşyalar yeniden adlandırılamaz.
player-error-cannot-delete-loose = Serbest Eşyalar silinemez.

# PlayerBoardView
player-title-player-board = {"**"}Oyuncu Komutları - Oyuncu Panosu{"**"}
player-desc-create-post = Oyuncu Panosu için yeni bir gönderi oluşturun.
player-msg-no-posts = Mevcut gönderiniz yok.
player-label-post-info = {"**"}{ $title }{"**"} (Kimlik: `{ $postId }`)
player-embed-field-author = Yazar
player-embed-footer-post-id = Gönderi ID: { $postId }
player-error-board-channel-not-found = Oyuncu Panosu kanalı bulunamadı.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}{ $characterName } için Envanter Kurulumu{"**"}
player-desc-browse-shop = Karakterinizi donatmak için Başlangıç Mağazasına göz atın.
player-desc-select-kit = Bir Başlangıç Kiti seçin.
player-desc-input-inventory = Başlangıç envanterinizi elle girin.

# StaticKitSelectView
player-title-select-kit = {"**"}{ $characterName } için Kit Seçin{"**"}
player-msg-no-kits = Başlangıç kiti mevcut değil.
player-label-and-more-items = ...ve { $count } eşya daha
player-label-empty-kit = {"*"}Boş Kit{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Seçimi Onayla: { $kitName }{"**"}
player-label-items-heading = {"**"}Eşyalar:{"**"}
player-label-currency-heading = {"**"}Para Birimi:{"**"}
player-msg-kit-empty = Bu kit boş.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Satın Alma Seçenekleri: { $itemName }{"**"}
player-msg-no-cost-options = Bu eşya için satın alma seçeneği mevcut değil.
player-label-cost-option = {"**"}Seçenek { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Başlangıç Mağazası ({ $inventoryType }){"**"}
player-label-starting-wealth = Başlangıç Serveti: { $formattedCurrency }
player-label-in-cart = {"**"}(Sepette: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Sepeti İncele{"**"}
player-msg-cart-empty = Sepetiniz boş.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Toplam: { $totalQuantity })
player-label-insufficient-currency = Yetersiz { $currencyName }
player-label-total-cost = {"**"}Toplam Maliyet:{"**"}
player-label-total-cost-free = {"**"}Toplam Maliyet:{"**"} Ücretsiz
player-label-cart-page = Sayfa { $current } / { $total }

# Trade embed
player-embed-title-trade = Takas Raporu
player-embed-desc-trade-sender = Gönderen: { $senderMention } (`{ $senderCharacter }` olarak)
player-embed-desc-trade-recipient = Alıcı: { $recipientMention } (`{ $recipientCharacter }` olarak)
player-embed-field-currency = Para Birimi
player-embed-field-amount = Miktar
player-embed-field-balance = { $characterName } Bakiyesi
player-embed-field-item = Eşya
player-embed-field-quantity = Miktar
player-embed-footer-transaction-id = İşlem ID: { $transactionId }

# Trade errors
player-error-trade-no-characters = Takas yapmaya çalıştığınız oyuncunun hiç karakteri yok!
player-error-trade-no-active = Takas yapmaya çalıştığınız oyuncunun bu sunucuda aktif bir karakteri yok!

# Spend currency embed
player-embed-title-spend = Oyuncu İşlem Raporu
player-embed-desc-spend-player = Oyuncu: { $playerMention } (`{ $characterName }` olarak)
player-embed-desc-spend-transaction = İşlem: {"**"}{ $characterName }{"**"} {"**"}{ $formattedAmount }{"**"} harcadı.
player-embed-field-channel = Kanal
player-embed-field-receipt = Makbuz

# Spend currency errors
player-error-amount-not-number = Miktar bir sayı olmalıdır.
player-error-amount-positive = Pozitif bir miktar harcamalısınız.
player-error-amount-exceeds-maximum = Miktar { $max } değerini aşamaz.
player-error-no-active-character-server = Bu sunucuda aktif bir karakteriniz yok.
player-error-no-currency-config = Bu sunucu için para birimi yapılandırması bulunamadı.

# Consume item embed
player-embed-title-consume = Eşya Tüketim Raporu
player-embed-desc-consume = Oyuncu: { $playerMention } (`{ $characterName }` olarak)
player-embed-desc-consume-removed = Kaldırılan: {"**"}{ $quantity }x { $itemName }{"**"} {"**"}{ $containerName }{"**"} kabından

# Consume item errors
player-error-qty-positive-integer = Miktar pozitif bir tam sayı olmalıdır.
player-error-qty-at-least-one = Miktar en az 1 olmalıdır.
player-error-qty-only-have = Bu eşyadan yalnızca { $maxQuantity } adet var.

# Inventory input errors
player-error-invalid-format = Geçersiz biçim: "{ $line }". <ad>: <miktar> biçimini kullanın.
player-error-empty-name = "{ $line }" satırında eşya adı boş olamaz.
player-error-invalid-quantity = "{ $name }" için geçersiz miktar: "{ $quantity }". Pozitif bir tam sayı olmalıdır.
player-error-input-errors-header = Envanter girişinde hatalar:
player-msg-no-valid-items = Geçerli eşya sağlanmadı. Boş envanter ile başlatılıyor.

# Validation error view
player-validation-error-title = Giriş hataları
player-validation-btn-retry = Tekrar dene

# Cart quantity validation
player-error-enter-valid-number = Lütfen geçerli bir pozitif sayı girin.

# Submission embeds (approval queue)
player-embed-title-approval = Envanter Onayı: { $characterName }
player-embed-desc-submitted-by = { $userMention } tarafından gönderildi
player-embed-field-items = Eşyalar
player-embed-field-currency-received = Para Birimi
player-embed-footer-submission-id = Başvuru ID: { $submissionId }
player-label-approval-thread = Onay: { $characterName }
player-embed-title-submission-sent = Envanter Başvurusu Gönderildi
player-embed-desc-submission-sent =
    {"**"}{ $characterName }{"**"} için başvurunuz GM ekibine onay için gönderildi!
    İncelendikten sonra bilgilendirileceksiniz.
    [Başvuru Konusunu Görüntüle]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = Başlangıç Envanteri Uygulandı
player-embed-desc-starting-inventory = Oyuncu: { $playerMention } (`{ $characterName }` olarak)
player-embed-field-items-received = Alınan Eşyalar
player-embed-field-currency-received-label = Alınan Para Birimi
player-label-untitled = Başlıksız

# ApprovalPostView
player-approval-post-header =
    {"**"}Envanter Başvurusu: { $characterName }{"**"}
    Gönderen: { $userMention }
player-approval-post-items = Eşyalar
player-approval-post-currency = Para Birimi
player-approval-resolved = Bu başvuru işlendi.
player-approval-btn-approve = Onayla
player-approval-btn-deny = Reddet
player-approval-btn-edit = Düzenle
player-approval-error-no-permission = Bu işlemi gerçekleştirme yetkiniz yok.
player-approval-error-not-submitter = Yalnızca orijinal gönderen bu başvuruyu düzenleyebilir.
player-approval-thread-instructions =
    Bu konu {"**"}{ $characterName }{"**"} adlı karakterin onayı için oluşturuldu.
    Bir Oyun Yöneticisi başvuruyu inceleyip onaylayacak veya reddedecektir.
    Onaylandıktan veya reddedildikten sonra bu konu kilitlenecektir.

    {"**"}Oyun Yöneticileri:{"**"} Envanter kabul edilebilir bir duruma
    gelene kadar gerekli değişiklikleri oyuncunuzla tartışın. `Reddet`
    düğmesini yalnızca uzlaşılamaz başvurular için kullanın.

    { $playerMention }: Bir Oyun Yöneticisi tarafından burada istenen
    değişiklikleri yapmak için `Düzenle` düğmesini kullanın.
player-approval-approved-by = Bu başvuru { $approver } tarafından onaylandı.
player-approval-denied-by = Bu başvuru { $denier } tarafından reddedildi.
player-approval-deny-reason = Sebep: { $reason }
player-msg-submission-updated = Başvurunuz güncellendi.


# Denial modal
player-modal-title-deny-reason = Başvuruyu reddet
player-modal-label-deny-reason = Red sebebi
player-modal-placeholder-deny-reason = İsteğe bağlı: red sebebini açıklayın
# Approval DM notifications
player-dm-title-approved = Karakter onaylandı
player-dm-desc-approved =
    {"**"}{ $characterName }{"**"} adlı karakteriniz {"**"}{ $guildName }{"**"}
    sunucusunda { $approver } tarafından onaylandı!
player-dm-title-denied = Karakter reddedildi
player-dm-desc-denied =
    {"**"}{ $characterName }{"**"} adlı karakteriniz {"**"}{ $guildName }{"**"}
    sunucusunda { $denier } tarafından reddedildi.
