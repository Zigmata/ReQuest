## Shop module strings

# Shop cog
shop-error-no-shops = Bu sunucu için yapılandırılmış mağaza yok.
shop-error-not-shop-channel =
    Bu kanal bir mağaza kanalı olarak kayıtlı değil.
    Burada bir mağaza olması gerektiğini düşünüyorsanız, sunucu yöneticinize bildirin.

# Shop buttons
shop-btn-out-of-stock = Stokta Yok
shop-btn-view-options = Satın Alma Seçeneklerini Görüntüle
shop-btn-add-to-cart = Sepete Ekle ({ $cost })
shop-btn-view-cart = Sepeti Görüntüle
shop-btn-view-cart-count = Sepeti Görüntüle ({ $count })
shop-btn-back-to-shop = Mağazaya Dön
shop-btn-clear-cart = Sepeti Temizle
shop-btn-checkout = Ödeme Yap
shop-btn-edit-quantity = Miktarı Düzenle

# Shop modals
shop-modal-title-edit-cart-qty = Sepet Miktarını Düzenle
shop-modal-label-quantity = Miktar
shop-modal-placeholder-quantity = Bu ürün için yeni miktarı girin
shop-error-invalid-number = Lütfen geçerli bir sayı girin.

# Shop views
shop-label-shopkeeper = Dükkâncı: {"**"}{ $name }{"**"}
shop-label-unknown-item = Bilinmeyen Ürün
shop-label-out-of-stock = STOKTA YOK
shop-label-stock-available = Stok: { $available }
shop-label-in-cart = (Sepette: { $quantity })
shop-title-cart = 🛒 {"**"}Alışveriş Sepeti{"**"}
shop-msg-cart-empty = Sepetiniz boş.
shop-warning-no-active-character = ⚠️ Aktif karakter bulunamadı. Bakiye doğrulanamıyor.
shop-warning-insufficient-funds = ⚠️ { $currency } için yetersiz bakiye
shop-label-invalid-cost = Geçersiz Fiyat
shop-label-total-cost = {"**"}Toplam Tutar:{"**"}
shop-label-warning = {"**"}Uyarı:{"**"}
shop-error-no-active-character = Bu sunucuda aktif bir karakteriniz yok.
shop-error-checkout-insufficient = Ödeme başarısız: Yetersiz { $currency }.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} stokta yok.

# Shop report embed
shop-embed-title-report = Alışveriş Raporu
shop-embed-field-purchased = Satın Alınanlar
shop-label-no-items = Ürün Yok
shop-embed-field-total-paid = Toplam Ödenen

# Purchase options
shop-title-purchase-options = Satın Alma Seçenekleri: { $itemName }
shop-msg-no-options = Bu ürün için satın alma seçeneği bulunmuyor.

# Shop messages
shop-msg-item-removed = Ürün sepetten kaldırıldı.
shop-msg-cart-updated = Sepet güncellendi.

# Restock notifications
shop-restock-more-items = . . . ve { $remaining } ürün daha.
shop-embed-title-restocked = Mağaza Yeniden Stoklandı!
shop-embed-footer-restocked = { $count } { $count ->
    [one] ürün
   *[other] ürün
} yeniden stoklandı
