## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ Ups!
error-report-description =
    { $exception }

    Jika kesalahan ini tidak terduga, atau Anda menduga bot tidak berfungsi dengan benar, silakan kirim laporan bug di [Discord Dukungan Resmi ReQuest](https://discord.gg/Zq37gj4).

error-report-unexpected =
    Terjadi kesalahan yang tidak terduga. Silakan coba lagi.

    Jika ini terus terjadi, silakan kirim laporan bug di [Discord Dukungan Resmi ReQuest](https://discord.gg/Zq37gj4).

# Check failures
error-owner-only = Hanya pemilik bot yang dapat menggunakan perintah ini!
error-no-permission = Anda tidak memiliki izin untuk menjalankan perintah ini!
error-no-active-character = Anda tidak memiliki karakter aktif di server ini!
error-no-registered-characters = Anda tidak memiliki karakter yang terdaftar!
error-no-characters = Pemain yang dituju tidak memiliki karakter yang terdaftar.
error-no-active-character-target = Pemain yang dituju tidak memiliki karakter yang diaktifkan di server ini.
error-player-not-found = Data pemain tidak ditemukan.
error-character-not-found = Data karakter tidak ditemukan.

# Currency/transaction errors
error-transaction-cannot-complete = Transaksi tidak dapat diselesaikan:
    { $reason }
error-insufficient-item-trade = Anda memiliki { $owned }x { $itemName } tetapi mencoba memberikan { $quantity }.
error-currency-process-failed = Mata uang { $currencyName } tidak dapat diproses.
error-insufficient-funds-transaction = Dana tidak cukup untuk menutup transaksi ini.
error-insufficient-funds = Dana tidak cukup.
error-insufficient-items = Barang tidak cukup: { $itemName }
error-currency-not-configured = Mata uang '{ $currencyName }' tidak dikonfigurasi di server ini.
error-cost-currency-system-mismatch = Mata uang biaya '{ $currencyName }' bukan bagian dari sistem mata uangnya sendiri.
error-currency-config-error = Kesalahan konfigurasi mata uang: nilai denominasi 0 atau negatif.
error-currency-validation = Terjadi kesalahan saat validasi mata uang: { $error }
error-invalid-currency = { $itemName } bukan mata uang yang valid.
error-insufficient-funds-for-transaction = Dana tidak cukup untuk transaksi ini.

# Cart errors
error-cart-not-found = Keranjang tidak ditemukan.
error-item-not-in-cart = Barang tidak ada di keranjang.
error-not-enough-stock = Stok tidak cukup tersedia.

# Container errors
error-container-not-found = Wadah tidak ditemukan.
error-container-name-empty = Nama wadah tidak boleh kosong.
error-container-name-too-long = Nama wadah tidak boleh melebihi { $maxLength } karakter.
error-max-containers-reached = Anda tidak dapat membuat lebih dari { $maxContainers } wadah.
error-container-name-exists = Wadah bernama "{ $containerName }" sudah ada.
error-item-already-in-container = Barang sudah ada di wadah ini.
error-quantity-minimum = Jumlah harus minimal 1.
error-source-container-not-found = Wadah sumber tidak ditemukan.
error-item-not-in-source = Barang "{ $itemName }" tidak ditemukan di wadah sumber.
error-insufficient-quantity-in-container = Jumlah tidak cukup. Anda memiliki { $available } di wadah ini.
error-dest-container-not-found = Wadah tujuan tidak ditemukan.
error-item-not-in-container = Barang "{ $itemName }" tidak ditemukan di wadah ini.
error-insufficient-quantity-consume = Anda hanya memiliki { $available } barang ini di wadah ini.
