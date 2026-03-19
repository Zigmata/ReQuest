## Admin module strings

# Admin cog
admin-embed-title-unauthorized = Yetkisiz Sunucu
admin-embed-desc-unauthorized =
    ReQuest'e gösterdiğiniz ilgi için teşekkür ederiz! Sunucunuz, ReQuest'in yetkili test sunucuları listesinde bulunmuyor.
    Lütfen aşağıdaki destek Discord'una katılın ve test erişimi istemek için geliştirme ekibiyle iletişime geçin.

    [ReQuest Geliştirme Discord'u](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Aşağıdaki komutlar { $guildName } sunucusuna, ID { $guildId } ile eşitlendi
admin-embed-title-sync-global = Aşağıdaki komutlar global olarak eşitlendi
admin-error-missing-scope = ReQuest hedef sunucuda doğru kapsama sahip değil. `applications.commands` iznini ekleyip tekrar deneyin.
admin-error-sync-failed = Komutlar eşitlenirken bir hata oluştu: { $error }
admin-msg-commands-cleared = Komutlar temizlendi.

# Admin buttons
admin-btn-shutdown = Kapat
admin-modal-title-confirm-shutdown = Kapatmayı Onayla
admin-modal-label-shutdown-warning = Uyarı! Bu işlem botu kapatacaktır. Devam etmek için CONFIRM yazın.
admin-msg-shutting-down = Kapatılıyor!
admin-btn-add-server = Yeni Sunucu Ekle
admin-btn-load-cog = Cog Yükle
admin-msg-extension-loaded = Eklenti başarıyla yüklendi: `{ $module }`
admin-btn-reload-cog = Cog Yeniden Yükle
admin-msg-extension-reloaded = Eklenti başarıyla yeniden yüklendi: `{ $module }`
admin-btn-output-guilds = Sunucu Listesini Göster
admin-msg-connected-guilds = { $count } sunucuya bağlı:

# Admin modals
admin-modal-title-add-server = İzin Listesine Sunucu ID Ekle
admin-modal-label-server-name = Sunucu Adı
admin-modal-placeholder-server-name = Discord Sunucusu için kısa bir ad yazın
admin-modal-label-server-id = Sunucu ID
admin-modal-placeholder-server-id = Discord Sunucusunun ID'sini yazın
admin-select-placeholder-server = Kaldırılacak bir sunucu seçin
admin-modal-title-cog-action = Cog { $action }
admin-modal-label-cog-name = Ad
admin-modal-placeholder-cog-name = { $action } yapılacak Cog adını girin

# Admin views
admin-title-main-menu = Yönetim - Ana Menü
admin-desc-allowlist = Davet kısıtlamaları için sunucu izin listesini yapılandırın.
admin-desc-cogs = Cog yükle veya yeniden yükle.
admin-desc-guild-list = Botun üye olduğu tüm sunucuların listesini döndürür.
admin-desc-shutdown = Botu kapatır
admin-title-allowlist = Yönetim - Sunucu İzin Listesi
admin-desc-allowlist-warning =
    İzin listesine yeni bir Discord Sunucu ID'si ekleyin.
    {"**"}UYARI: Bot sunucu üyesi olmadan sağlanan sunucu ID'sinin geçerli olup olmadığını doğrulamanın bir yolu yoktur. Girişlerinizi iki kez kontrol edin!{"**"}
admin-msg-no-servers = İzin listesinde sunucu yok.

# Admin confirm modals
admin-modal-title-confirm-server-removal = Sunucu Kaldırmayı Onayla
admin-modal-label-server-removal = Sunucu izin listesinden kaldırılsın mı?

# Admin cog view
admin-title-cogs = Yönetim - Cog'lar
admin-desc-load-cog = Bir bot cog'unu ada göre yükleyin. Dosya `<ad>.py` olarak adlandırılmalı ve ReQuest\cogs\ dizininde bulunmalıdır.
admin-desc-reload-cog = Yüklü bir cog'u ada göre yeniden yükleyin. Aynı adlandırma ve dosya yolu kısıtlamaları geçerlidir.
