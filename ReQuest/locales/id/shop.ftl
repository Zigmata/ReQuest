## Shop module strings

# Shop cog
shop-error-no-shops = Tidak ada toko yang dikonfigurasi untuk server ini.
shop-error-not-shop-channel =
    Kanal ini tidak terdaftar sebagai kanal toko.
    Jika Anda merasa seharusnya ada toko di sini, beri tahu admin server Anda.

# Shop buttons
shop-btn-out-of-stock = Stok Habis
shop-btn-view-options = Lihat Opsi Pembelian
shop-btn-add-to-cart = Tambah ke Keranjang ({ $cost })
shop-btn-view-cart = Lihat Keranjang
shop-btn-view-cart-count = Lihat Keranjang ({ $count })
shop-btn-back-to-shop = Kembali ke Toko
shop-btn-clear-cart = Kosongkan Keranjang
shop-btn-checkout = Bayar
shop-btn-edit-quantity = Ubah Jumlah

# Shop modals
shop-modal-title-edit-cart-qty = Ubah Jumlah Keranjang
shop-modal-label-quantity = Jumlah
shop-modal-placeholder-quantity = Masukkan jumlah baru untuk barang ini
shop-error-invalid-number = Silakan masukkan angka yang valid.

# Shop views
shop-label-shopkeeper = Penjaga Toko: {"**"}{ $name }{"**"}
shop-label-unknown-item = Barang Tidak Dikenal
shop-label-out-of-stock = STOK HABIS
shop-label-stock-available = Stok: { $available }
shop-label-in-cart = (Di Keranjang: { $quantity })
shop-title-cart = 🛒 {"**"}Keranjang Belanja{"**"}
shop-msg-cart-empty = Keranjang Anda kosong.
shop-warning-no-active-character = ⚠️ Karakter aktif tidak ditemukan. Tidak dapat memverifikasi dana.
shop-warning-insufficient-funds = ⚠️ Dana tidak cukup untuk { $currency }
shop-label-invalid-cost = Harga Tidak Valid
shop-label-total-cost = {"**"}Total Biaya:{"**"}
shop-label-warning = {"**"}Peringatan:{"**"}
shop-error-no-active-character = Anda tidak memiliki karakter aktif di server ini.
shop-error-checkout-insufficient = Pembayaran gagal: { $currency } tidak cukup.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} stok habis.

# Shop report embed
shop-embed-title-report = Laporan Belanja
shop-embed-field-purchased = Dibeli
shop-label-no-items = Tidak Ada Barang
shop-embed-field-total-paid = Total Dibayar

# Purchase options
shop-title-purchase-options = Opsi Pembelian: { $itemName }
shop-msg-no-options = Tidak ada opsi pembelian yang tersedia untuk barang ini.

# Shop messages
shop-msg-item-removed = Barang dihapus dari keranjang.
shop-msg-cart-updated = Keranjang diperbarui.

# Restock notifications
shop-restock-more-items = . . . dan { $remaining } lagi.
shop-embed-title-restocked = Toko Telah Restock!
shop-embed-footer-restocked = { $count } { $count ->
   *[other] barang
} di-restock
