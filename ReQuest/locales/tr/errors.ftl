## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ Hay aksi!
error-report-description =
    { $exception }

    Bu hata beklenmedikse veya botun düzgün çalışmadığını düşünüyorsanız, lütfen [Resmi ReQuest Destek Discord'unda](https://discord.gg/Zq37gj4) bir hata raporu gönderin.

error-report-unexpected =
    Beklenmeyen bir hata oluştu. Lütfen tekrar deneyin.

    Bu durum devam ederse, lütfen [Resmi ReQuest Destek Discord'unda](https://discord.gg/Zq37gj4) bir hata raporu gönderin.

# Check failures
error-owner-only = Bu komutu yalnızca bot sahibi kullanabilir!
error-no-permission = Bu komutu çalıştırma yetkiniz yok!
error-no-active-character = Bu sunucuda aktif bir karakteriniz yok!
error-no-registered-characters = Kayıtlı hiç karakteriniz yok!
error-no-characters = Hedef oyuncunun kayıtlı hiç karakteri yok.
error-no-active-character-target = Hedef oyuncunun bu sunucuda aktif bir karakteri yok.
error-player-not-found = Oyuncu verisi bulunamadı.
error-character-not-found = Karakter verisi bulunamadı.

# Currency/transaction errors
error-transaction-cannot-complete = İşlem tamamlanamıyor:
    { $reason }
error-insufficient-item-trade = { $owned }x { $itemName } eşyanız var ancak { $quantity } tane vermeye çalışıyorsunuz.
error-currency-process-failed = { $currencyName } para birimi işlenemedi.
error-insufficient-funds-transaction = Bu işlemi karşılayacak yeterli bakiye yok.
error-insufficient-funds = Yetersiz bakiye.
error-insufficient-items = Yetersiz eşya: { $itemName }
error-currency-not-configured = '{ $currencyName }' para birimi bu sunucuda yapılandırılmamış.
error-cost-currency-system-mismatch = Maliyet para birimi '{ $currencyName }' kendi para birimi sisteminin bir parçası değil.
error-currency-config-error = Para birimi yapılandırma hatası: 0 veya negatif birim değeri.
error-currency-validation = Para birimi doğrulaması sırasında bir hata oluştu: { $error }
error-invalid-currency = { $itemName } geçerli bir para birimi değil.
error-insufficient-funds-for-transaction = Bu işlem için yeterli bakiye yok.

# Cart errors
error-cart-not-found = Sepet bulunamadı.
error-item-not-in-cart = Eşya sepette değil.
error-not-enough-stock = Yeterli stok mevcut değil.

# Container errors
error-container-not-found = Kap bulunamadı.
error-container-name-empty = Kap adı boş olamaz.
error-container-name-too-long = Kap adı { $maxLength } karakteri aşamaz.
error-max-containers-reached = { $maxContainers } adetten fazla kap oluşturamazsınız.
error-container-name-exists = "{ $containerName }" adlı bir kap zaten mevcut.
error-item-already-in-container = Eşya zaten bu kapta.
error-quantity-minimum = Miktar en az 1 olmalıdır.
error-source-container-not-found = Kaynak kap bulunamadı.
error-item-not-in-source = "{ $itemName }" eşyası kaynak kapta bulunamadı.
error-insufficient-quantity-in-container = Yetersiz miktar. Bu kapta { $available } adet var.
error-dest-container-not-found = Hedef kap bulunamadı.
error-item-not-in-container = "{ $itemName }" eşyası bu kapta bulunamadı.
error-insufficient-quantity-consume = Bu eşyadan bu kapta yalnızca { $available } adet var.
