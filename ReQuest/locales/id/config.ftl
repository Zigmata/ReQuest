## Config module strings

# ==========================================
# BUTTONS
# ==========================================

# Roles
config-btn-clear = Hapus
config-btn-remove-gm-roles = Hapus Peran GM
config-btn-forbidden-roles = Peran Terlarang

# Quests
config-btn-toggle-quest-summary = Aktifkan/Nonaktifkan Ringkasan Quest
config-btn-toggle-player-experience = Aktifkan/Nonaktifkan Pengalaman Pemain
config-btn-toggle-display = Aktifkan/Nonaktifkan Tampilan
config-btn-purge-player-board = Bersihkan Papan Pemain
config-btn-add-modify-rewards = Tambah/Ubah Hadiah

# Currency
config-btn-add-denomination = Tambah Denominasi
config-btn-add-new-currency = Tambah Mata Uang Baru
config-btn-remove-currency = Hapus Mata Uang

# Shops - creation
config-btn-add-shop-wizard = Tambah Toko (Wizard)
config-btn-add-shop-json = Tambah Toko (JSON)
config-btn-edit-shop-wizard = Ubah Toko (Wizard)
config-btn-edit-shop-json = Ubah Toko (JSON)
config-btn-remove-shop = Hapus Toko
config-btn-add-item = Tambah Barang
config-btn-edit-shop-details = Ubah Detail Toko
config-btn-download-json = Unduh JSON
config-btn-done-editing = Selesai Mengedit
config-btn-scan-server-configs = Pindai Konfigurasi Server
config-btn-re-scan = Pindai Ulang

# New character shop
config-btn-upload-json = Unggah JSON
config-btn-configure-new-character-wealth = Konfigurasi Kekayaan Karakter Baru
config-btn-configure-new-character-shop = Konfigurasi Toko Karakter Baru
config-btn-clear-shop = Kosongkan Toko
config-btn-configure-static-kits = Konfigurasi Kit Statis
config-btn-new-character-settings = Pengaturan Karakter Baru
config-btn-disabled-no-currency = Nonaktif (Mata Uang Belum Dikonfigurasi)
config-btn-disabled-no-wealth = Nonaktif (Kekayaan Awal Belum Dikonfigurasi)

# Static kits
config-btn-create-new-kit = Buat Kit Baru
config-btn-delete-kit = Hapus Kit
config-btn-add-currency = Tambah Mata Uang

# Roleplay
config-btn-toggle-rp-rewards = Aktifkan/Nonaktifkan Hadiah RP
config-btn-clear-channels = Hapus Kanal
config-btn-edit-settings = Ubah Pengaturan
config-btn-configure-rewards = Konfigurasi Hadiah

# Stock
config-btn-stock-limits = Batas Stok
config-btn-set-limit = Tetapkan Batas
config-btn-edit-limit = Ubah Batas
config-btn-remove-limit = Hapus Batas
config-btn-configure-restock-schedule = Konfigurasi Jadwal Restock
config-btn-back-to-shop-editor = Kembali ke Editor Toko

# Forum shop
config-btn-create-new-thread = Buat Thread Baru
config-btn-use-existing-thread = Gunakan Thread yang Ada

# Wizard
config-btn-quit = Keluar
config-btn-configure-channels = Konfigurasi Kanal
config-btn-configure-roles = Konfigurasi Peran
config-btn-configure-quests = Konfigurasi Quest
config-btn-configure-players = Konfigurasi Pemain
config-btn-configure-currency = Konfigurasi Mata Uang
config-btn-configure-rp-rewards = Konfigurasi Hadiah RP
config-btn-configure-shops = Konfigurasi Toko
config-btn-new-char-setup = Pengaturan Karakter Baru

# Confirm modal titles (passed to common ConfirmModal)
config-modal-title-confirm-role-removal = Konfirmasi Penghapusan Peran
config-modal-title-confirm-removal = Konfirmasi Penghapusan
config-modal-title-confirm-currency-removal = Konfirmasi Penghapusan Mata Uang
config-modal-title-confirm-shop-removal = Konfirmasi Penghapusan Toko
config-modal-title-confirm-kit-deletion = Konfirmasi Penghapusan Kit
config-modal-title-confirm-remove-stock-limit = Konfirmasi Penghapusan Batas Stok
config-modal-title-clear-shop = Konfirmasi Pengosongan Toko

# Confirm modal prompt labels
config-modal-label-remove-role = Hapus { $roleName }?
config-modal-label-remove-denomination = Hapus { $denominationName }?
config-modal-label-remove-currency = Hapus { $currencyName }?
config-modal-label-shop-removal-warning = PERINGATAN: Tindakan ini tidak dapat dibatalkan!
config-modal-label-kit-deletion-warning = PERINGATAN: Tidak dapat dibatalkan!
config-modal-label-remove-stock-limit = Ketik CONFIRM untuk menghapus batas stok
config-modal-label-clear-shop = Kosongkan semua item dari toko ini?
config-modal-placeholder-type-confirm = Ketik CONFIRM

# Error messages from buttons
config-error-shop-data-not-found = Kesalahan: Tidak dapat menemukan data toko tersebut.
config-msg-shop-json-download = Berikut adalah definisi JSON untuk {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Berikut adalah definisi JSON untuk Toko Karakter Baru.
config-error-select-forum-first = Silakan pilih kanal forum terlebih dahulu.
config-error-select-thread-first = Silakan pilih thread terlebih dahulu.

# ==========================================
# MODALS
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Tambah Mata Uang Baru
config-modal-label-currency-name = Nama Mata Uang
config-error-currency-already-exists = Mata uang atau denominasi bernama { $name } sudah ada!

# RenameCurrencyModal
config-modal-title-rename-currency = Ganti Nama Mata Uang
config-modal-label-new-currency-name = Nama Mata Uang Baru
config-error-currency-name-exists = Mata uang bernama "{ $name }" sudah ada.
config-error-denomination-name-exists = Denominasi bernama "{ $name }" sudah ada.

# RenameDenominationModal
config-modal-title-rename-denomination = Ganti Nama Denominasi
config-modal-label-new-denomination-name = Nama Denominasi Baru

# AddCurrencyDenominationModal
config-modal-title-add-denomination = Tambah Denominasi { $currencyName }
config-modal-label-denomination-name = Nama
config-modal-placeholder-denomination-name = contoh: Silver
config-modal-label-denomination-value = Nilai
config-modal-placeholder-denomination-value = contoh: 0.1
config-error-denomination-matches-currency = Nama denominasi baru tidak boleh sama dengan mata uang yang sudah ada di server ini! Ditemukan mata uang bernama "{ $existingName }".
config-error-denomination-matches-denomination = Nama denominasi baru tidak boleh sama dengan denominasi yang sudah ada di server ini! Ditemukan denominasi bernama "{ $denominationName }" di bawah mata uang bernama "{ $currencyName }".
config-error-denomination-value-exists = Denominasi di bawah satu mata uang harus memiliki nilai unik! { $denominationName } sudah memiliki nilai ini.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Nama Peran Terlarang
config-modal-label-names = Nama
config-modal-placeholder-names = Masukkan nama dipisahkan dengan koma
config-msg-forbidden-roles-updated = Peran terlarang diperbarui!

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Bersihkan Papan Pemain
config-modal-label-age = Usia
config-modal-placeholder-age = Masukkan usia posting maksimum (dalam hari) yang akan disimpan
config-msg-posts-purged = Posting yang lebih lama dari { $days } hari telah dibersihkan!

# GMRewardsModal
config-modal-title-gm-rewards = Tambah/Ubah Hadiah GM
config-modal-label-experience = Pengalaman
config-modal-placeholder-enter-number = Masukkan angka
config-modal-label-items = Barang
config-modal-placeholder-items =
    Nama: Jumlah
    Nama2: Jumlah
    dst.
config-error-experience-invalid = Pengalaman harus berupa bilangan bulat yang valid (contoh: 2000).
config-error-item-format-invalid = Format barang tidak valid: "{ $item }". Setiap barang harus di baris baru, dengan format "Nama: Jumlah".

# ConfigShopDetailsModal
config-modal-title-shop-details = Tambah/Ubah Detail Toko
config-modal-label-shop-channel = Pilih kanal
config-modal-placeholder-shop-channel = Pilih kanal untuk toko ini
config-modal-label-shop-name = Nama Toko
config-modal-placeholder-shop-name = Masukkan nama toko
config-modal-label-shopkeeper-name = Nama Penjaga Toko
config-modal-placeholder-shopkeeper-name = Masukkan nama penjaga toko
config-modal-label-shop-description = Deskripsi Toko
config-modal-placeholder-shop-description = Masukkan deskripsi untuk toko
config-modal-label-shop-image-url = URL Gambar Toko
config-modal-placeholder-shop-image-url = Masukkan URL untuk gambar toko
config-error-no-channel-selected = Tidak ada kanal yang dipilih untuk toko.
config-error-shop-already-in-channel = Sudah ada toko yang terdaftar di kanal yang dipilih. Silakan pilih kanal lain atau ubah toko yang ada.

# build_shop_header_view
config-label-shopkeeper = {"**"}Penjaga Toko:{"**"} { $name }
config-msg-use-shop-command = Gunakan perintah `/shop` untuk menjelajahi dan membeli barang.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Buat Toko Thread Forum
config-modal-label-thread-name = Nama Thread
config-modal-placeholder-thread-name = Masukkan nama untuk thread toko
config-error-forum-not-found = Tidak dapat menemukan kanal forum yang dipilih.
config-error-shop-already-in-thread = Sudah ada toko yang terdaftar di thread ini. Hal ini seharusnya tidak terjadi untuk thread baru.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Tambah Toko Baru via JSON
config-modal-label-upload-json = Unggah file .json yang berisi data toko
config-error-no-json-uploaded = Tidak ada file JSON yang diunggah untuk toko.
config-error-file-must-be-json = File yang diunggah harus berupa file JSON (.json).
config-error-invalid-json = Format JSON tidak valid: { $error }
config-error-json-validation-failed = JSON tidak sesuai dengan skema: { $error }

# ShopItemModal
config-modal-title-shop-item = Tambah/Ubah Barang Toko
config-modal-label-item-name = Nama Barang
config-modal-placeholder-item-name = Masukkan nama barang
config-modal-label-item-description = Deskripsi Barang
config-modal-placeholder-item-description = Masukkan deskripsi untuk barang
config-modal-label-item-quantity = Jumlah Barang
config-modal-placeholder-item-quantity = Masukkan jumlah yang dijual per pembelian
config-modal-label-item-costs = Harga Barang
config-modal-placeholder-item-costs = Contoh: 10 gold + 5 silver\nATAU: 50 rep\n(Gunakan + untuk DAN, Baris Baru untuk ATAU)
config-error-item-quantity-positive = Jumlah barang harus berupa bilangan bulat positif.
config-error-cost-format-invalid = Format harga tidak valid pada opsi: "{ $option }". Setiap harga harus memiliki jumlah dan mata uang yang dipisahkan spasi, contoh "10 gold".
config-error-cost-amount-invalid = Jumlah tidak valid "{ $amount }" untuk mata uang: "{ $currency }". Jumlah harus berupa angka positif.
config-error-unknown-currency = Mata uang tidak dikenal `{ $currency }`. Silakan gunakan mata uang yang valid yang dikonfigurasi untuk server ini.
config-error-item-already-exists = Barang bernama { $itemName } sudah ada di toko ini.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Perbarui Toko via JSON
config-modal-label-upload-new-json = Unggah definisi JSON baru
config-error-no-file-uploaded = Tidak ada file yang diunggah.
config-error-file-must-be-json-ext = File harus berupa file `.json`.
config-error-json-validation-message = Validasi JSON gagal: { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Tambah/Ubah Perlengkapan Karakter Baru
config-modal-placeholder-item-quantity-selection = Masukkan jumlah yang diterima per pilihan
config-modal-label-item-cost = Harga Barang
config-error-cost-format-short = Format harga tidak valid: '{ $component }'. Yang diharapkan: 'Jumlah MataUang'.
config-error-amount-invalid-short = Jumlah tidak valid '{ $amount }' untuk mata uang '{ $currency }'.
config-error-item-exists-new-char = Barang bernama { $itemName } sudah ada di toko Karakter Baru.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Unggah Toko Karakter Baru (JSON)
config-error-no-json-uploaded-short = Tidak ada file JSON yang diunggah.
config-error-json-must-have-shopstock = JSON harus mengandung array 'shopStock'.
config-error-items-must-have-name-price = Semua barang harus memiliki 'name' dan 'price'.

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Tetapkan Kekayaan Karakter Baru
config-modal-label-amount = Jumlah
config-modal-placeholder-amount = Masukkan jumlah mata uang ini.
config-modal-placeholder-currency-name = Masukkan nama mata uang yang didefinisikan di server ini
config-error-no-currencies-configured = Tidak ada mata uang yang dikonfigurasi di server ini.
config-error-currency-not-found = Mata uang atau denominasi bernama { $name } tidak ditemukan. Silakan gunakan mata uang yang valid.

# CreateStaticKitModal
config-modal-title-create-kit = Buat Kit Statis Baru
config-modal-label-kit-name = Nama Kit
config-modal-placeholder-kit-name = contoh: Kit Starter Prajurit
config-modal-label-description = Deskripsi
config-modal-placeholder-kit-description = Deskripsi opsional untuk kit ini
config-error-kit-name-exists = Kit statis bernama "{ $kitName }" sudah ada. Silakan pilih nama yang berbeda.

# StaticKitItemModal
config-modal-title-kit-item = Tambah/Ubah Barang Kit
config-modal-placeholder-kit-item-quantity = Masukkan jumlah barang ini yang akan dimasukkan ke dalam kit

# StaticKitCurrencyModal
config-modal-title-kit-currency = Tambah Mata Uang Kit
config-modal-placeholder-currency-eg = contoh: Gold
config-modal-placeholder-amount-eg = contoh: 100
config-error-amount-must-be-number = Jumlah harus berupa angka.
config-error-no-currencies-on-server = Tidak ada mata uang yang dikonfigurasi di server.
config-error-currency-not-found-short = Mata uang "{ $currency }" tidak ditemukan.
config-error-denomination-not-found = Denominasi "{ $denomination }" tidak ditemukan dalam konfigurasi mata uang.

# RoleplaySettingsModal
config-modal-title-rp-settings = Pengaturan Roleplay
config-modal-label-min-message-length = Panjang Pesan Minimum (karakter)
config-modal-placeholder-min-message-length = Jumlah karakter yang diperlukan agar pesan layak. 0 untuk tanpa batas
config-modal-label-cooldown = Cooldown (detik)
config-modal-placeholder-cooldown = Waktu tunggu, dalam detik, antara menghitung pesan sebagai layak untuk hadiah
config-modal-label-message-threshold = Ambang Batas Pesan
config-modal-placeholder-message-threshold = Jumlah pesan yang diperlukan untuk memicu hadiah
config-modal-label-frequency = Frekuensi (jumlah pesan)
config-modal-placeholder-frequency = Jumlah pesan layak yang diperlukan untuk mendapatkan hadiah
config-error-min-length-invalid = Panjang Pesan Minimum harus berupa bilangan bulat non-negatif.
config-error-cooldown-invalid = Cooldown harus berupa bilangan bulat non-negatif.
config-error-threshold-invalid = Ambang Batas Pesan harus berupa bilangan bulat positif.
config-error-frequency-invalid = Frekuensi harus berupa bilangan bulat positif.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Konfigurasi Hadiah Roleplay
config-modal-label-items-name-quantity = Barang (Nama: Jumlah)
config-modal-label-currency-name-amount = Mata Uang (Nama: Jumlah)
config-error-experience-non-negative = Pengalaman harus berupa bilangan bulat non-negatif.
config-error-item-quantity-positive-named = Jumlah barang untuk "{ $itemName }" harus berupa bilangan bulat positif.
config-error-currency-amount-positive = Jumlah mata uang untuk "{ $currencyName }" harus berupa angka positif.

# SetItemStockModal
config-modal-title-stock-limit = Batas Stok: { $itemName }
config-modal-label-max-stock = Stok Maksimum
config-modal-placeholder-max-stock = Masukkan stok maks (contoh: 10)
config-modal-label-current-stock = Stok Saat Ini
config-modal-placeholder-current-stock = Masukkan stok tersedia saat ini
config-error-max-stock-positive = Stok maksimum harus berupa bilangan bulat positif.
config-error-current-stock-non-negative = Stok saat ini harus berupa bilangan bulat non-negatif.
config-error-current-exceeds-max = Stok saat ini tidak boleh melebihi stok maksimum.
config-error-item-not-in-shop = Barang "{ $itemName }" tidak ditemukan di toko.

# RestockScheduleModal
config-modal-title-restock-schedule = Konfigurasi Jadwal Restock
config-modal-label-schedule = Jadwal (hourly/daily/weekly/none)
config-modal-placeholder-schedule = Masukkan: hourly, daily, weekly, atau none
config-modal-label-time = Waktu (HH:MM dalam UTC)
config-modal-desc-current-time = Waktu saat ini: { $utcTime }
config-modal-placeholder-time = contoh: 14:30 untuk 14:30 UTC
config-modal-label-day-of-week = Hari dalam Seminggu (0=Sen, 6=Min) - Hanya untuk weekly
config-modal-placeholder-day-of-week = Masukkan 0-6 (Senin=0, Minggu=6)
config-modal-label-mode = Mode (full/incremental)
config-modal-placeholder-mode = full = reset ke maks, incremental = tambah jumlah
config-modal-label-increment = Jumlah Penambahan (untuk mode incremental)
config-modal-placeholder-increment = Jumlah yang ditambahkan per siklus restock
config-error-schedule-invalid = Jadwal harus salah satu dari: hourly, daily, weekly, atau none.
config-error-time-format-invalid = Waktu harus dalam format HH:MM (contoh: 14:30).
config-error-day-of-week-invalid = Hari dalam seminggu harus 0-6 (Senin=0, Minggu=6).
config-error-mode-invalid = Mode harus "full" atau "incremental".
config-error-increment-positive = Jumlah penambahan harus berupa bilangan bulat positif.

# ==========================================
# SELECTS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Cari Kanal { $configName } Anda

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Pilih Peran Pengumuman Quest Anda

# AddGMRoleSelect
config-select-placeholder-gm-roles = Pilih Peran GM Anda

# ConfigWaitListSelect
config-select-placeholder-wait-list = Pilih ukuran Daftar Tunggu
config-select-option-disabled = 0 (Nonaktif)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Pilih Mode Inventaris
config-select-option-disabled-label = Nonaktif
config-select-desc-disabled = Pemain memulai dengan inventaris kosong.
config-select-option-selection = Pilihan
config-select-desc-selection = Pemain memilih barang secara bebas dari Toko Karakter Baru.
config-select-option-purchase = Pembelian
config-select-desc-purchase = Pemain membeli barang dari Toko Karakter Baru dengan jumlah mata uang tertentu.
config-select-option-open = Terbuka
config-select-desc-open = Pemain memasukkan barang inventaris mereka sendiri secara manual.
config-select-option-static = Statis
config-select-desc-static = Pemain diberikan inventaris awal yang telah ditentukan.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Pilih Kanal yang Layak

# RoleplayModeSelect
config-select-placeholder-rp-mode = Pilih Mode
config-select-option-scheduled = Terjadwal
config-select-desc-scheduled = Hadiah diberikan satu kali dalam periode reset yang ditentukan.
config-select-option-accrued = Akumulasi
config-select-desc-accrued = Hadiah diberikan berulang kali berdasarkan tingkat aktivitas yang ditentukan.

# RoleplayResetSelect
config-select-placeholder-reset-period = Pilih Periode Reset
config-select-option-hourly = Per Jam
config-select-desc-hourly = Reset setiap jam.
config-select-option-daily = Harian
config-select-desc-daily = Reset setiap 24 jam.
config-select-option-weekly = Mingguan
config-select-desc-weekly = Reset setiap 7 hari.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Pilih Hari Reset

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Pilih Waktu Reset (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Pilih kanal forum

# ForumThreadSelect
config-select-placeholder-thread = Pilih thread
config-select-option-no-threads = Tidak ada thread aktif ditemukan
config-select-desc-no-threads = Buat thread baru atau periksa thread yang diarsipkan
config-select-option-select-forum-first = Pilih forum terlebih dahulu
config-select-desc-select-forum-first = Silakan pilih kanal forum di atas
config-select-desc-thread-id = ID Thread: { $threadId }
config-error-select-valid-thread = Silakan pilih thread yang valid atau buat yang baru.
config-error-thread-not-found = Tidak dapat menemukan thread yang dipilih. Thread mungkin telah dihapus atau diarsipkan.

# ==========================================
# VIEWS
# ==========================================

## Main Menu
config-title-main-menu = Konfigurasi Server - Menu Utama
config-menu-config-wizard = Wizard Konfigurasi
config-menu-desc-config-wizard = Validasi server Anda siap menggunakan ReQuest dengan pemindaian cepat.
config-menu-channels = Kanal
config-menu-desc-channels = Tetapkan kanal khusus untuk postingan ReQuest.
config-menu-currency = Mata Uang
config-menu-desc-currency = Pengaturan mata uang global.
config-menu-players = Pemain
config-menu-desc-players = Pengaturan pemain global, seperti pelacakan poin pengalaman.
config-menu-quests = Quest
config-menu-desc-quests = Pengaturan quest global, seperti daftar tunggu.
config-menu-rp-rewards = Hadiah RP
config-menu-desc-rp-rewards = Konfigurasi hadiah roleplay.
config-menu-roles = Peran
config-menu-desc-roles = Opsi konfigurasi untuk peran yang dapat di-ping atau memiliki hak istimewa.
config-menu-shops = Toko
config-menu-desc-shops = Konfigurasi toko kustom.
config-menu-language = Bahasa
config-menu-desc-language = Tetapkan bahasa default untuk server ini.

## Wizard View
config-title-wizard = {"**"}Konfigurasi Server - Wizard{"**"}
config-wizard-intro =
    {"**"}Selamat datang di Wizard Konfigurasi ReQuest!{"**"}

    Wizard ini akan membantu Anda memastikan bahwa server Anda dikonfigurasi dengan benar untuk menggunakan fitur-fitur ReQuest.
    Wizard akan memindai pengaturan Anda saat ini dan memberikan rekomendasi untuk penyesuaian yang diperlukan.

    Gunakan tombol "Mulai Pemindaian" di bawah untuk memulai proses validasi. Setelah pemindaian selesai,
    Anda akan menerima laporan terperinci tentang konfigurasi server Anda beserta perubahan yang direkomendasikan.

# Wizard - Bot Permission Validation
config-wizard-bot-permissions-header = __{"**"}Izin Global Bot{"**"}__
config-wizard-bot-permissions-desc = Bagian ini memverifikasi bahwa ReQuest memiliki izin yang benar untuk berfungsi dengan baik.
config-wizard-bot-role = Peran Bot: { $roleMention }
config-wizard-status-warnings = {"**"}Status: ⚠️ DITEMUKAN PERINGATAN{"**"}
config-wizard-missing-perm = - ⚠️ Tidak ada: `{ $permissionName }`
config-wizard-ensure-permissions = Pastikan peran tertinggi bot memiliki izin ini yang diberikan secara global.
config-wizard-status-ok = {"**"}Status: ✅ OK{"**"}
config-wizard-bot-permissions-ok = Bot memiliki semua izin global yang diperlukan.
config-wizard-status-scan-failed = {"**"}Status: ❌ PEMINDAIAN GAGAL{"**"}
config-wizard-scan-error = Terjadi kesalahan tak terduga saat memeriksa izin bot.
config-wizard-error-type = Kesalahan: { $errorType }
config-wizard-required-permissions = {"**"}Izin yang Diperlukan untuk Peran Bot:{"**"}

# Wizard - Permission names
config-wizard-perm-view-channels = Lihat Kanal
config-wizard-perm-manage-roles = Kelola Peran
config-wizard-perm-send-messages = Kirim Pesan
config-wizard-perm-attach-files = Lampirkan File
config-wizard-perm-add-reactions = Tambahkan Reaksi
config-wizard-perm-use-external-emoji = Gunakan Emoji Eksternal
config-wizard-perm-manage-messages = Kelola Pesan
config-wizard-perm-read-message-history = Baca Riwayat Pesan

# Wizard - Role Validation
config-wizard-role-header = __{"**"}Konfigurasi Peran{"**"}__
config-wizard-role-desc =
    Bagian ini memverifikasi hal-hal berikut:

    - Peran GM (wajib) dan peran Pengumuman (opsional) telah dikonfigurasi.
    - Peran default (@everyone) memiliki izin yang diperlukan agar pengguna dapat mengakses fitur bot.
    - Peran default (@everyone) tidak memiliki izin berbahaya.
    - Peran GM dan Pengumuman diperiksa untuk melihat apakah memiliki eskalasi izin di luar peran default.

    Peringatan di sini semata-mata merupakan rekomendasi berdasarkan pengaturan default. Tergantung kebutuhan server Anda, Anda mungkin memiliki alasan untuk mengabaikan beberapa rekomendasi ini.

config-wizard-default-role-label = {"**"}Peran Default:{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone: Ditemukan Izin Berbahaya:
config-wizard-default-role-ok = - ✅ @everyone: OK
config-wizard-missing-permission = - Izin Tidak Ada: `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}Peran GM:{"**"}
config-wizard-no-gm-roles = - ⚠️ Peran GM Belum Dikonfigurasi
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName }:{"**"} Peran yang Dikonfigurasi Tidak Ditemukan/Dihapus dari Server
config-wizard-role-ok = - ✅ { $roleMention }: OK
config-wizard-announcement-role-label = {"**"}Peran Pengumuman:{"**"}
config-wizard-no-announcement-role = - ℹ️ Peran Pengumuman Belum Dikonfigurasi
config-wizard-announcement-role-not-found = - ⚠️ Peran yang Dikonfigurasi Tidak Ditemukan/Dihapus dari Server
config-wizard-escalation-detected = - ⚠️ { $roleMention }: Eskalasi Izin Terdeteksi - { $escalations }
config-wizard-escalation-more = , dan { $count } lagi...

# Wizard - Required Default Permissions
config-wizard-perm-send-messages-in-threads = Kirim Pesan di Thread
config-wizard-perm-use-application-commands = Gunakan Perintah Aplikasi

# Wizard - Dangerous Permissions
config-wizard-perm-manage-channels = Kelola Kanal
config-wizard-perm-manage-webhooks = Kelola Webhook
config-wizard-perm-manage-server = Kelola Server
config-wizard-perm-manage-nicknames = Kelola Nama Panggilan
config-wizard-perm-kick-members = Tendang Anggota
config-wizard-perm-ban-members = Cekal Anggota
config-wizard-perm-timeout-members = Timeout Anggota
config-wizard-perm-mention-everyone = Sebut @everyone
config-wizard-perm-manage-threads = Kelola Thread
config-wizard-perm-administrator = Administrator

# Wizard - Channel Validation
config-wizard-channel-header = __{"**"}Konfigurasi Kanal{"**"}__
config-wizard-channel-desc =
    Bagian ini memverifikasi hal-hal berikut:

    - Kanal yang dikonfigurasi ada.
    - Bot memiliki izin untuk melihat dan mengirim pesan di kanal yang dikonfigurasi.
    - Peran default (@everyone) tidak memiliki izin `Kirim Pesan`.

config-wizard-channel-no-config-required = - ⚠️ Kanal Belum Dikonfigurasi
config-wizard-channel-not-configured = - ℹ️ Belum Dikonfigurasi (Opsional)
config-wizard-channel-not-found = - ⚠️ Kanal yang Dikonfigurasi Tidak Ditemukan/Dihapus dari Server
config-wizard-channel-ok = - ✅ OK
config-wizard-bot-cannot-view = - ⚠️ { $botMention } tidak dapat melihat kanal ini.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } tidak dapat mengirim pesan di kanal ini.
config-wizard-everyone-can-send = - ⚠️ @everyone dapat mengirim pesan di kanal ini.

# Wizard - Channel names
config-wizard-channel-quest-board = Papan Quest
config-wizard-channel-player-board = Papan Pemain
config-wizard-channel-quest-archive = Arsip Quest
config-wizard-channel-gm-transaction-log = Log Transaksi GM
config-wizard-channel-player-transaction-log = Log Transaksi Pemain
config-wizard-channel-shop-log = Log Toko
config-wizard-channel-approval-queue = Antrean Persetujuan Karakter

# Wizard - Dashboard
config-wizard-dashboard-header = __{"**"}Dasbor Pengaturan{"**"}__
config-wizard-dashboard-desc = Bagian ini memberikan gambaran umum konfigurasi non-esensial untuk referensi cepat.
config-wizard-quest-settings = {"**"}Pengaturan Quest{"**"}
config-wizard-quest-wait-list = - Ukuran Daftar Tunggu Quest: { $size }
config-wizard-quest-summary = - Ringkasan Quest: { $status }
config-wizard-gm-rewards-per-quest = {"**"}Hadiah GM (Per Quest){"**"}
config-wizard-player-settings = {"**"}Pengaturan Pemain{"**"}
config-wizard-player-experience = - Pengalaman Pemain: { $status }
config-wizard-currency-settings = {"**"}Pengaturan Mata Uang{"**"}
config-wizard-rp-rewards = {"**"}Hadiah Roleplay{"**"}
config-wizard-rp-status = - Status: { $status }
config-wizard-rp-mode = - Mode: { $mode }
config-wizard-rp-channels = - Kanal yang Dipantau: { $count }
config-wizard-shops = {"**"}Toko{"**"}
config-wizard-shops-count = - Toko yang Dikonfigurasi: { $count }
config-wizard-shops-more = - ...dan { $count } lagi
config-wizard-new-char-setup = {"**"}Pengaturan Karakter Baru{"**"}
config-wizard-inventory-type = - Tipe Inventaris: { $type }
config-wizard-new-char-shop-items = - Barang Toko Karakter Baru: { $count }
config-wizard-static-kits = - Kit Statis: { $count }

# Wizard - GM Rewards Report
config-wizard-no-currencies = - ℹ️ Mata Uang Belum Dikonfigurasi
config-wizard-configured-currencies = {"**"}Mata Uang yang Dikonfigurasi:{"**"}
config-wizard-no-denominations = - Denominasi Belum Dikonfigurasi
config-wizard-gm-rewards-disabled = {"**"}Status:{"**"} Nonaktif
config-wizard-gm-rewards-enabled = {"**"}Status:{"**"} Aktif
config-wizard-gm-rewards-experience = - Pengalaman: { $xp }
config-wizard-gm-rewards-items = - Barang:
config-wizard-unnamed-shop = Toko Tanpa Nama

## Roles View
config-title-roles = {"**"}Konfigurasi Server - Peran{"**"}
config-label-announcement-role = {"**"}Peran Pengumuman:{"**"} { $status }
config-desc-announcement-role = Peran ini akan disebut ketika quest diposting.
config-label-announcement-role-default = {"**"}Peran Pengumuman:{"**"} Belum Dikonfigurasi
config-label-gm-roles = {"**"}Peran GM:{"**"} { $roles }
config-desc-gm-roles = Peran ini akan memberikan akses ke perintah dan fitur GM.
config-label-gm-roles-default = {"**"}Peran GM:{"**"} Belum Dikonfigurasi
config-title-forbidden-roles = __{"**"}Peran Terlarang{"**"}__
config-desc-forbidden-roles =
    Mengonfigurasi daftar nama peran yang tidak dapat digunakan oleh GM untuk peran rombongan mereka.
    Secara default, `everyone`, `administrator`, `gm`, dan `game master` tidak dapat digunakan. Konfigurasi ini
    memperluas daftar tersebut.

## GM Role Remove View
config-title-remove-gm-roles = {"**"}Konfigurasi Server - Hapus Peran GM{"**"}
config-msg-no-gm-roles = Peran GM belum dikonfigurasi.

## Channels View
config-title-channels = {"**"}Konfigurasi Server - Kanal{"**"}

config-label-quest-board = {"**"}Papan Quest:{"**"} { $channel }
config-desc-quest-board = Kanal tempat quest baru/aktif akan diposting.
config-label-quest-board-default = {"**"}Papan Quest:{"**"} Belum Dikonfigurasi

config-label-player-board = {"**"}Papan Pemain:{"**"} { $channel }
config-desc-player-board = Kanal pengumuman/papan pesan opsional untuk digunakan oleh pemain.
config-label-player-board-default = {"**"}Papan Pemain:{"**"} Belum Dikonfigurasi

config-label-quest-archive = {"**"}Arsip Quest:{"**"} { $channel }
config-desc-quest-archive = Kanal opsional tempat quest yang selesai akan dipindahkan, dengan informasi ringkasan.
config-label-quest-archive-default = {"**"}Arsip Quest:{"**"} Belum Dikonfigurasi

config-label-gm-transaction-log = {"**"}Log Transaksi GM:{"**"} { $channel }
config-desc-gm-transaction-log = Kanal opsional tempat transaksi GM (misalnya perintah Modify Player) dicatat.
config-label-gm-transaction-log-default = {"**"}Log Transaksi GM:{"**"} Belum Dikonfigurasi

config-label-player-transaction-log = {"**"}Log Transaksi Pemain:{"**"} { $channel }
config-desc-player-transaction-log = Kanal opsional tempat transaksi pemain seperti perdagangan dan penggunaan barang dicatat.
config-label-player-transaction-log-default = {"**"}Log Transaksi Pemain:{"**"} Belum Dikonfigurasi

config-label-shop-log = {"**"}Log Toko:{"**"} { $channel }
config-desc-shop-log = Kanal opsional tempat transaksi toko dicatat.
config-label-shop-log-default = {"**"}Log Toko:{"**"} Belum Dikonfigurasi

## Quests View
config-title-quests = {"**"}Konfigurasi Server - Quest{"**"}

config-label-wait-list = {"**"}Ukuran Daftar Tunggu Quest:{"**"} { $size }
config-desc-wait-list = Daftar tunggu memungkinkan sejumlah pemain tertentu untuk mengantre pada quest yang penuh, jika ada pemain yang keluar.
config-label-wait-list-disabled = {"**"}Ukuran Daftar Tunggu Quest:{"**"} Nonaktif

config-label-quest-summary = {"**"}Ringkasan Quest:{"**"} { $status }
config-desc-quest-summary = Opsi ini memungkinkan GM untuk memberikan ringkasan singkat saat menyelesaikan quest.
config-label-quest-summary-disabled = {"**"}Ringkasan Quest:{"**"} Nonaktif

config-label-gm-rewards = Hadiah GM
config-desc-gm-rewards = Konfigurasi hadiah untuk GM yang diterima saat menyelesaikan quest.

## GM Rewards View
config-title-gm-rewards = {"**"}Konfigurasi Server - Hadiah GM{"**"}
config-desc-gm-rewards-detail =
    {"**"}Tambah/Ubah Hadiah{"**"}
    Membuka modal input untuk menambah, mengubah, atau menghapus hadiah GM.

    > Hadiah yang dikonfigurasi berlaku per quest. Setiap kali GM menyelesaikan quest, mereka akan
    menerima hadiah yang dikonfigurasi di bawah ini pada karakter aktif mereka.
config-msg-no-rewards = Tidak ada hadiah yang dikonfigurasi.
config-label-gm-experience = {"**"}Pengalaman:{"**"} { $xp }
config-label-gm-items = {"**"}Barang:{"**"}

## Players View
config-title-players = {"**"}Konfigurasi Server - Pemain{"**"}

config-label-player-experience = {"**"}Pengalaman Pemain:{"**"} { $status }
config-desc-player-experience = Mengaktifkan/Menonaktifkan penggunaan poin pengalaman (atau progresi karakter berbasis nilai serupa).
config-label-player-experience-disabled = {"**"}Pengalaman Pemain:{"**"} Nonaktif

config-label-new-char-settings = {"**"}Pengaturan Karakter Baru{"**"}
config-desc-new-char-settings = Konfigurasi pengaturan terkait karakter pemain baru dan cara inventaris awal mereka diatur.

config-label-player-board-purge = {"**"}Pembersihan Papan Pemain{"**"}
config-desc-player-board-purge = Membersihkan postingan dari papan pemain (jika diaktifkan).

## New Character Settings View
config-title-new-character = {"**"}Konfigurasi Server - Pengaturan Karakter Baru{"**"}

config-label-inventory-type = {"**"}Tipe Inventaris Karakter Baru:{"**"} { $type }
config-desc-inventory-type = Menentukan cara karakter yang baru terdaftar menginisialisasi inventaris mereka.
config-label-inventory-type-disabled = {"**"}Tipe Inventaris Karakter Baru:{"**"} Nonaktif

config-label-new-char-wealth = {"**"}Kekayaan Karakter Baru:{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Kekayaan Karakter Baru:{"**"} Nonaktif

config-label-approval-queue = {"**"}Antrean Persetujuan:{"**"} { $channel }
config-desc-approval-queue = Jika diatur, karakter baru harus disetujui oleh GM di Kanal Forum ini sebelum aktif.
config-label-approval-queue-disabled = {"**"}Antrean Persetujuan:{"**"} Nonaktif
config-label-approval-queue-not-configured = {"**"}Antrean Persetujuan:{"**"} Belum Dikonfigurasi

# Inventory type descriptions (used in setup)
config-desc-inv-type-disabled = Pemain memulai dengan inventaris kosong.
config-desc-inv-type-selection = Pemain memilih barang secara bebas dari Toko Karakter Baru.
config-desc-inv-type-purchase = Pemain membeli barang dari Toko Karakter Baru dengan jumlah mata uang tertentu.
config-desc-inv-type-open = Pemain memasukkan barang inventaris mereka sendiri secara manual.
config-desc-inv-type-static = Pemain diberikan inventaris awal yang telah ditentukan.

## New Character Shop View
config-title-new-char-shop = {"**"}Konfigurasi Server - Toko Karakter Baru{"**"}
config-label-inv-type-selection = {"**"}Tipe Inventaris:{"**"} Pilihan
config-desc-inv-type-selection-shop = Pemain memilih barang secara bebas dari Toko Karakter Baru.
config-label-inv-type-purchase = {"**"}Tipe Inventaris:{"**"} Pembelian
config-desc-inv-type-purchase-shop = Pemain membeli barang dari Toko Karakter Baru dengan jumlah mata uang tertentu.
config-label-inv-type-other = {"**"}Tipe Inventaris:{"**"} { $type }
config-desc-inv-type-not-in-use = Toko Karakter Baru tidak digunakan.
config-msg-define-shop-items = Tentukan barang-barang toko.
config-msg-no-items = Tidak ada barang yang dikonfigurasi.

## Static Kits View
config-title-static-kits = {"**"}Konfigurasi Server - Kit Statis{"**"}
config-desc-create-kit = Buat definisi kit baru.
config-msg-no-kits = Tidak ada kit yang dikonfigurasi.
config-label-kit-more-items = ...dan { $count } barang lagi
config-label-empty-kit = {"*"}Kit Kosong{"*"}

## Edit Static Kit View
config-title-editing-kit = {"**"}Mengedit Kit: { $kitName }{"**"}
config-msg-kit-empty = Kit ini kosong. Gunakan tombol di atas untuk menambahkan mata uang atau barang.
config-label-kit-currency = {"**"}Mata Uang:{"**"} { $display }
config-label-kit-item = {"**"}Barang:{"**"} { $name }

## Currency View
config-title-currency = {"**"}Konfigurasi Server - Mata Uang{"**"}
config-desc-create-currency = Buat mata uang baru.
config-msg-no-currencies = Tidak ada mata uang yang dikonfigurasi.
config-label-currency-display-type = Tipe Tampilan: { $type } | Denominasi: { $count }
config-label-currency-type-double = Desimal
config-label-currency-type-integer = Bilangan Bulat

## Edit Currency View
config-title-manage-currency = {"**"}Kelola Mata Uang: { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Mata Uang dan Denominasi{"**"}__
    - Nama yang diberikan untuk mata uang Anda dianggap sebagai mata uang dasar dan memiliki nilai 1.
    {"```"}Contoh: "gold" dikonfigurasi sebagai mata uang.{"```"}
    - Menambahkan denominasi memerlukan penentuan nama dan nilai relatif terhadap mata uang dasar.
    {"```"}Contoh: Gold diberikan dua denominasi: silver (nilai 0.1), dan copper (nilai 0.01).{"```"}
    - Semua transaksi yang melibatkan mata uang dasar atau denominasinya akan dikonversi secara otomatis.
    {"```"}Contoh: Seorang pemain memiliki 10 gold dan membelanjakan 3 copper. Saldo baru mereka akan otomatis menampilkan
    9 gold, 9 silver, dan 7 copper.{"```"}
    - Mata uang yang ditampilkan sebagai bilangan bulat akan menunjukkan setiap denominasi, sementara mata uang yang ditampilkan sebagai desimal
    hanya akan ditampilkan sebagai mata uang dasar.
    {"```"}Contoh: Pemain di atas dengan tampilan desimal akan ditampilkan sebagai 9.97 gold.{"```"}
config-btn-toggle-display-current = Alihkan Tampilan (Saat Ini: { $type })
config-msg-no-denominations = Tidak ada denominasi yang dikonfigurasi.

## Shops View
config-title-shops = {"**"}Konfigurasi Server - Toko{"**"}
config-desc-add-shop-wizard =
    {"**"}Tambah Toko (Wizard){"**"}
    Buat toko baru yang kosong dari formulir.
config-desc-add-shop-json =
    {"**"}Tambah Toko (JSON){"**"}
    Buat toko baru dengan memberikan definisi JSON lengkap. (Lanjutan)
config-btn-example-json = Contoh JSON
config-desc-example-json =
    {"**"}Contoh JSON{"**"}
    Unduh file JSON contoh yang menunjukkan format yang diharapkan.
config-msg-example-json = Berikut adalah file JSON contoh yang menunjukkan format yang diharapkan.
config-msg-no-shops = Tidak ada toko yang dikonfigurasi.
config-label-shop-type-forum = (Forum)
config-label-shop-channel = Kanal: <#{ $channelId }>

## Shop Channel Type Selection View
config-title-choose-location = {"**"}Tambah Toko - Pilih Tipe Lokasi{"**"}
config-label-text-channel = {"**"}Kanal Teks{"**"}
config-desc-text-channel = Buat toko di kanal teks standar.
config-label-forum-thread = {"**"}Thread Forum{"**"}
config-desc-forum-thread = Buat toko di thread forum (baru atau yang sudah ada).

## Forum Shop Setup View
config-title-forum-setup = {"**"}Tambah Toko - Pengaturan Thread Forum{"**"}
config-label-step1 = {"**"}Langkah 1: Pilih Kanal Forum{"**"}
config-label-step2 = {"**"}Langkah 2: Pilih Opsi Thread{"**"}
config-label-step3 = {"**"}Langkah 3: Pilih Thread yang Ada{"**"}
config-desc-create-new-thread =
    {"**"}Buat Thread Baru{"**"}
    Membuka formulir untuk membuat thread baru dan mengonfigurasi toko.
config-label-selected-thread = {"**"}Thread Terpilih:{"**"} { $threadName }
config-desc-click-to-configure = Klik untuk mengonfigurasi toko di thread ini.

## Manage Shop View
config-title-manage-shop = {"**"}Kelola Toko: { $shopName }{"**"}
config-label-shop-type = {"**"}Tipe:{"**"} { $type }
config-label-shop-type-text = Kanal Teks
config-label-shop-type-forum-thread = Thread Forum
config-label-shopkeeper = {"**"}Penjaga Toko:{"**"} { $name }
config-label-shop-description = {"**"}Deskripsi:{"**"} { $description }
config-label-shop-channel-info = {"**"}Kanal:{"**"} <#{ $channelId }>
config-desc-edit-wizard = Ubah detail dan barang toko melalui Wizard.
config-desc-upload-json = Unggah definisi JSON baru untuk toko ini.
config-desc-download-json = Unduh definisi JSON saat ini.
config-desc-remove-shop = Hapus toko ini secara permanen.

## Edit Shop View
config-title-editing-shop = {"**"}Mengedit Toko: { $shopName }{"**"}
config-label-shop-shopkeeper = Penjaga Toko: {"**"}{ $name }{"**"}

## Stock Limits View
config-title-stock-config = {"**"}Konfigurasi Stok: { $shopName }{"**"}
config-label-current-utc = Waktu UTC Saat Ini: {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Jadwal Restock:{"**"} { $schedule }
config-label-restock-hourly = pada menit :{ $minute }
config-label-restock-daily = pada { $time } UTC
config-label-restock-weekly = pada hari { $day } pukul { $time } UTC
config-label-restock-mode = {"**"}Mode:{"**"} { $mode }
config-label-restock-full = Restock penuh
config-label-restock-incremental = Tambah { $amount } per siklus (hingga maks)
config-label-restock-disabled = {"**"}Jadwal Restock:{"**"} Nonaktif
config-label-item-stock-limits = {"**"}Batas Stok Barang{"**"}
config-msg-no-items-in-shop = Tidak ada barang di toko ini.
config-label-stock-with-available = Maks: { $max } | Tersedia: { $available }
config-label-stock-reserved = | Dipesan: { $reserved }
config-label-stock-not-initialized = Maks: { $max } | Tersedia: (belum diinisialisasi)
config-label-stock-unlimited = Stok: Tidak Terbatas

## Roleplay View
config-title-roleplay = {"**"}Konfigurasi Server - Hadiah Roleplay{"**"}
config-label-rp-status = {"**"}Status:{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Waktu Server:{"**"} `{ $time }`
config-label-rp-enabled = Aktif
config-label-rp-disabled = Nonaktif

config-desc-rp-mode-scheduled = {"```"}Hadiah didistribusikan satu kali, setelah mengirim jumlah pesan layak yang diperlukan dalam periode waktu yang ditetapkan (per jam, harian, atau mingguan).{"```"}
config-desc-rp-mode-accrued = {"```"}Hadiah didistribusikan secara berulang setiap kali sejumlah pesan layak tertentu dikirim.{"```"}

config-label-rp-config-details = {"**"}Detail Konfigurasi:{"**"}
config-label-rp-mode = {"**"}Mode:{"**"} { $mode }
config-label-rp-min-length = {"**"}Panjang Pesan Minimum:{"**"} { $length } karakter
config-label-rp-cooldown = {"**"}Cooldown:{"**"} { $seconds } detik
config-label-rp-frequency-once = {"**"}Frekuensi:{"**"} Sekali per { $period }
config-label-rp-reset-time = {"**"}Waktu Reset:{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Ambang Batas:{"**"} { $count } pesan layak
config-label-rp-frequency-every = {"**"}Frekuensi:{"**"} Setiap { $count } pesan layak

config-label-rp-channels = {"**"}Kanal Roleplay:{"**"}
config-msg-rp-no-channels = Belum dikonfigurasi.
config-label-rp-channels-more = ...dan { $count } lagi.

config-label-rp-rewards = {"**"}Hadiah:{"**"}
config-msg-rp-no-rewards = Belum dikonfigurasi.
config-label-rp-experience = {"**"}Pengalaman:{"**"} { $xp }
config-label-rp-items = {"**"}Barang:{"**"}
config-label-rp-currency = {"**"}Mata Uang:{"**"}

## Language View
config-title-language = {"**"}Konfigurasi Server - Bahasa{"**"}
config-server-language-help =
    Pengaturan ini memungkinkan Anda menentukan bahasa default untuk respons dan pesan {"**"}publik{"**"} ReQuest di server ini. Respons publik meliputi:
    - Postingan Papan Quest dan Papan Pemain
    - Ringkasan Quest dan pesan Kanal Log
    - Restock toko
    - Penggunaan barang oleh pemain

    Pengaturan ini hanya memengaruhi teks statis yang dihasilkan oleh bot, dan tidak menerjemahkan konten dinamis seperti nama barang yang dimasukkan pengguna atau deskripsi quest.

    Respons dan menu pribadi tidak terpengaruh oleh pengaturan ini.
config-label-server-language = {"**"}Bahasa Server:{"**"} { $language }
config-label-server-language-default = {"**"}Bahasa Server:{"**"} Default (tanpa penggantian)
config-select-placeholder-server-language = Pilih bahasa server
config-select-option-default = Default (tanpa penggantian)
config-select-desc-default = Gunakan preferensi masing-masing pengguna atau lokal Discord.

# Quest Roles
config-btn-quest-roles = Quest Roles
config-btn-manage-gm-quest-roles = Manage

config-modal-title-confirm-quest-role-removal = Confirm Role Removal
config-modal-label-remove-quest-role = Remove { $roleName } from { $gmName }?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Select Quest Role Mode
config-select-option-quest-role-disabled = Disabled
config-select-desc-quest-role-disabled = No roles are created or assigned.
config-select-option-quest-role-temporary = Temporary
config-select-desc-quest-role-temporary = GMs can create temporary roles per quest.
config-select-option-quest-role-static = Static
config-select-desc-quest-role-static = GMs pick from pre-assigned server roles.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Assign server role(s) to this GM

## Quest Roles View
config-title-quest-roles = {"**"}Server Configuration - Quest Roles{"**"}
config-label-quest-roles = Quest Roles
config-desc-quest-roles =
    Configure how party roles are handled during quests.

config-label-quest-role-mode-disabled = {"**"}Quest Role Mode:{"**"} Disabled
    No roles are created or assigned during quests.
config-label-quest-role-mode-temporary = {"**"}Quest Role Mode:{"**"} Temporary
    GMs can optionally create a temporary role during quest creation.
    The role is deleted when the quest completes or is cancelled.
config-label-quest-role-mode-static = {"**"}Quest Role Mode:{"**"} Static
    GMs pick from pre-assigned server roles. Roles are assigned to
    party members during quests but are never deleted.

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}Server Configuration - Static Quest Role Assignments{"**"}
config-label-manage-assignments = Manage Role Assignments
config-desc-manage-assignments =
    Assign existing server roles to GMs for use during quests.
    Roles must be lower than ReQuest's highest role in the server hierarchy.
config-msg-no-gm-members = No members with a GM role were found on this server.
config-label-no-roles-assigned = No quest roles assigned

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}Manage Quest Roles — { $gmName }{"**"}
config-error-unmanageable-roles = The following roles cannot be assigned because they are managed by an integration, are the default role, or are above ReQuest's highest role: { $roles }
config-error-quest-role-limit = This GM has reached the maximum of { $limit } assigned quest roles.
