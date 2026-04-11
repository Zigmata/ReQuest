## Player module strings

# --- Cog ---

player-cmd-name = Tukar
player-cmd-desc = Menu Pemain

# --- Buttons ---

# Character management
player-btn-register-character = Daftarkan Karakter Baru
player-btn-activate = Aktifkan
player-btn-active = Aktif

# Player board
player-btn-create-post = Buat Postingan
player-btn-open-starting-shop = Buka Toko Awal
player-btn-select-kit = Pilih Kit
player-btn-input-inventory = Input Inventaris

# Wizard / shop buttons
player-btn-add-to-cart = Tambah ke Keranjang
player-btn-add-to-cart-cost = Tambah ke Keranjang ({ $costString })
player-btn-view-purchase-options = Lihat Opsi Pembelian
player-btn-review-submit = Tinjau & Kirim ({ $count })
player-btn-submit-character = Kirim Karakter
player-btn-keep-shopping = Lanjut Belanja
player-btn-edit-quantity = Ubah Jumlah
player-btn-clear-cart = Kosongkan Keranjang

# Kit buttons
player-btn-confirm-selection = Konfirmasi Pilihan
player-btn-back-to-kits = Kembali ke Kit

# Inventory management
player-btn-spend-currency = Belanjakan Mata Uang
player-btn-print-inventory = Cetak Inventaris

# Container management
player-btn-manage-containers = Kelola Wadah
player-btn-create-new = + Buat Baru
player-btn-consume-destroy = Gunakan/Hancurkan
player-btn-move = Pindahkan
player-btn-move-all = Pindahkan Semua
player-btn-move-some = Pindahkan Sebagian...
player-btn-back-to-overview = ← Kembali ke Ringkasan
player-btn-cancel-move = ← Batal
player-btn-up = ▲ Atas
player-btn-down = ▼ Bawah

# --- Modals ---

# Trade modal
player-modal-title-trade = Berdagang dengan { $targetName }
player-modal-label-trade-name = Nama
player-modal-placeholder-trade-name = Masukkan nama barang yang Anda perdagangkan
player-modal-label-trade-quantity = Jumlah
player-modal-placeholder-trade-quantity = Masukkan jumlah yang Anda perdagangkan

# Character register modal
player-modal-title-register = Daftarkan Karakter Baru
player-modal-label-char-name = Nama
player-modal-placeholder-char-name = Masukkan nama karakter Anda.
player-modal-label-char-note = Catatan
player-modal-placeholder-char-note = Masukkan catatan untuk mengidentifikasi karakter Anda

# Open inventory input modal
player-modal-title-starting-inventory = Input Inventaris Awal
player-modal-label-inventory = Inventaris
player-modal-placeholder-inventory-input =
    Satu per baris dalam format <nama>: <jumlah>, contoh:
    Pedang: 1
    gold: 30

# Spend currency modal
player-modal-title-spend-currency = Belanjakan Mata Uang
player-modal-label-currency-name = Nama Mata Uang
player-modal-placeholder-currency-name = Masukkan nama mata uang yang akan Anda belanjakan
player-modal-label-currency-amount = Jumlah
player-modal-placeholder-currency-amount = Masukkan jumlah yang akan dibelanjakan

# Create player post modal
player-modal-title-create-post = Buat Postingan Papan Pemain
player-modal-label-post-title = Judul
player-modal-placeholder-post-title = Masukkan judul untuk postingan Anda
player-modal-label-post-content = Isi Postingan
player-modal-placeholder-post-content = Masukkan isi postingan Anda

# Edit player post modal
player-modal-title-edit-post = Ubah Postingan Papan Pemain

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = Ubah Jumlah Keranjang
player-modal-label-cart-qty = Jumlah
player-modal-placeholder-cart-qty = Masukkan jumlah baru (0 untuk menghapus)

# Create container modal
player-modal-title-create-container = Buat Wadah Baru
player-modal-label-container-name = Nama Wadah
player-modal-placeholder-container-name = Masukkan nama untuk wadah Anda (contoh: Ransel)

# Rename container modal
player-modal-title-rename-container = Ganti Nama Wadah
player-modal-label-new-container-name = Nama Wadah Baru
player-modal-placeholder-new-container-name = Masukkan nama baru

# Consume from container modal
player-modal-title-consume = Gunakan/Hancurkan Barang
player-modal-label-consume-qty = Jumlah (maks: { $maxQuantity })
player-modal-placeholder-consume-qty = Masukkan jumlah yang akan digunakan/dihancurkan

# Move item quantity modal
player-modal-title-move-item = Pindahkan Barang
player-modal-label-move-qty = Jumlah yang dipindahkan (maks: { $maxQuantity })
player-modal-placeholder-move-qty = Masukkan jumlah yang akan dipindahkan

# --- Selects ---

player-select-placeholder-no-characters = Anda tidak memiliki karakter terdaftar
player-select-placeholder-remove-character = Pilih karakter untuk dihapus
player-select-placeholder-post = Pilih postingan
player-select-placeholder-container-view = Pilih wadah untuk dilihat...
player-select-placeholder-item = Pilih barang...
player-select-placeholder-destination = Pilih tujuan...
player-select-placeholder-container = Pilih wadah...
player-select-option-no-containers = Tidak ada wadah
player-select-option-no-items = Tidak ada barang
player-select-option-no-destinations = Tidak ada tujuan

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}Perintah Pemain - Menu Utama{"**"}
player-menu-btn-characters = Karakter
player-menu-desc-characters = Daftar, lihat, dan aktifkan karakter pemain.
player-menu-btn-inventory = Inventaris
player-menu-desc-inventory = Lihat inventaris karakter aktif Anda dan belanjakan mata uang.
player-menu-btn-player-board = Papan Pemain
player-menu-btn-player-board-disabled = Papan Pemain (Belum Dikonfigurasi)
player-menu-desc-player-board = Buat postingan untuk Papan Pemain

# CharacterBaseView
player-title-characters = {"**"}Perintah Pemain - Karakter{"**"}
player-desc-register-character = Daftarkan karakter baru.
player-msg-no-characters = Anda tidak memiliki karakter yang terdaftar.
player-label-active = (Aktif)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Karakter dalam proses: { $characterName }{"**"}
    Pendaftaran karakter Anda menunggu pengaturan inventaris.
player-btn-resume = Lanjutkan
player-btn-discard = Buang
player-modal-title-discard-character = Buang karakter
player-modal-label-discard-confirm = Buang { $characterName }?

# Confirm character removal
player-modal-title-confirm-char-removal = Konfirmasi Penghapusan Karakter
player-modal-label-confirm-char-delete = Hapus { $characterName }?

# Confirm post removal
player-modal-title-confirm-post-removal = Konfirmasi Penghapusan Postingan
player-modal-label-post-removal-warning = PERINGATAN: Tindakan ini tidak dapat dibatalkan!

# InventoryOverviewView
player-title-inventory = {"**"}Perintah Pemain - Inventaris{"**"}
player-title-char-inventory = {"**"}Inventaris { $characterName }{"**"}
player-msg-no-active-character = Tidak Ada Karakter Aktif: Aktifkan karakter untuk server ini untuk menggunakan menu ini.
player-msg-no-characters-registered = Tidak Ada Karakter: Daftarkan karakter untuk menggunakan menu ini.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } barang
player-label-currency = {"**"}Mata Uang{"**"}
player-msg-inventory-empty = Inventaris kosong.

# Print inventory embed
player-embed-title-inventory = Inventaris { $characterName }

# ContainerItemsView
player-msg-container-empty = Wadah ini kosong.
player-label-selected-item = Terpilih: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Pindahkan "{ $itemName }"{"**"} ({ $available } tersedia)
player-msg-no-other-containers = Tidak ada wadah lain yang tersedia.
player-msg-select-destination = Pilih wadah tujuan:
player-label-destination = Tujuan: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Kelola Wadah{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } barang){ $suffix }
player-label-default-suffix = { " " }(bawaan)
player-msg-no-containers = Tidak ada wadah.
player-label-selected-container = Terpilih: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = Konfirmasi Penghapusan Wadah
player-modal-label-container-has-items = Memiliki { $itemCount } barang. Akan dipindahkan ke Barang Lepas.
player-modal-label-confirm-container-delete = Hapus "{ $containerName }"?

# Container errors
player-error-cannot-rename-loose = Tidak dapat mengganti nama Barang Lepas.
player-error-cannot-delete-loose = Tidak dapat menghapus Barang Lepas.

# PlayerBoardView
player-title-player-board = {"**"}Perintah Pemain - Papan Pemain{"**"}
player-desc-create-post = Buat postingan baru untuk Papan Pemain.
player-msg-no-posts = Anda tidak memiliki postingan saat ini.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Penulis
player-embed-footer-post-id = ID Postingan: { $postId }
player-error-board-channel-not-found = Kanal Papan Pemain tidak ditemukan.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Pengaturan Inventaris untuk { $characterName }{"**"}
player-desc-browse-shop = Jelajahi Toko Awal untuk melengkapi karakter Anda.
player-desc-select-kit = Pilih Kit Awal.
player-desc-input-inventory = Masukkan inventaris awal Anda secara manual.

# StaticKitSelectView
player-title-select-kit = {"**"}Pilih Kit untuk { $characterName }{"**"}
player-msg-no-kits = Tidak ada kit awal yang tersedia.
player-label-and-more-items = ...dan { $count } barang lagi
player-label-empty-kit = {"*"}Kit Kosong{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Konfirmasi Pilihan: { $kitName }{"**"}
player-label-items-heading = {"**"}Barang:{"**"}
player-label-currency-heading = {"**"}Mata Uang:{"**"}
player-msg-kit-empty = Kit ini kosong.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Opsi Pembelian: { $itemName }{"**"}
player-msg-no-cost-options = Barang ini tidak memiliki opsi harga yang tersedia.
player-label-cost-option = {"**"}Opsi { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Toko Awal ({ $inventoryType }){"**"}
player-label-starting-wealth = Kekayaan Awal: { $formattedCurrency }
player-label-in-cart = {"**"}(Di Keranjang: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Tinjau Keranjang{"**"}
player-msg-cart-empty = Keranjang Anda kosong.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Total: { $totalQuantity })
player-label-insufficient-currency = { $currencyName } tidak cukup
player-label-total-cost = {"**"}Total Biaya:{"**"}
player-label-total-cost-free = {"**"}Total Biaya:{"**"} Gratis
player-label-cart-page = Halaman { $current } dari { $total }

# Trade embed
player-embed-title-trade = Laporan Perdagangan
player-embed-desc-trade-sender = Pengirim: { $senderMention } sebagai `{ $senderCharacter }`
player-embed-desc-trade-recipient = Penerima: { $recipientMention } sebagai `{ $recipientCharacter }`
player-embed-field-currency = Mata Uang
player-embed-field-amount = Jumlah
player-embed-field-balance = Saldo { $characterName }
player-embed-field-item = Barang
player-embed-field-quantity = Jumlah
player-embed-footer-transaction-id = ID Transaksi: { $transactionId }

# Trade errors
player-error-trade-no-characters = Pemain yang Anda coba ajak berdagang tidak memiliki karakter!
player-error-trade-no-active = Pemain yang Anda coba ajak berdagang tidak memiliki karakter aktif di server ini!

# Spend currency embed
player-embed-title-spend = Laporan Transaksi Pemain
player-embed-desc-spend-player = Pemain: { $playerMention } sebagai `{ $characterName }`
player-embed-desc-spend-transaction = Transaksi: {"**"}{ $characterName }{"**"} membelanjakan {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Kanal
player-embed-field-receipt = Kuitansi

# Spend currency errors
player-error-amount-not-number = Jumlah harus berupa angka.
player-error-amount-positive = Anda harus membelanjakan jumlah yang positif.
player-error-amount-exceeds-maximum = Jumlah tidak boleh melebihi { $max }.
player-error-no-active-character-server = Anda tidak memiliki karakter aktif di server ini.
player-error-no-currency-config = Konfigurasi mata uang tidak ditemukan untuk server ini.

# Consume item embed
player-embed-title-consume = Laporan Penggunaan Barang
player-embed-desc-consume = Pemain: { $playerMention } sebagai `{ $characterName }`
player-embed-desc-consume-removed = Dihapus: {"**"}{ $quantity }x { $itemName }{"**"} dari {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = Jumlah harus berupa bilangan bulat positif.
player-error-qty-at-least-one = Jumlah harus minimal 1.
player-error-qty-only-have = Anda hanya memiliki { $maxQuantity } barang ini.

# Inventory input errors
player-error-invalid-format = Format tidak valid: "{ $line }". Gunakan <nama>: <jumlah>.
player-error-empty-name = Nama barang tidak boleh kosong pada baris: "{ $line }".
player-error-invalid-quantity = Jumlah tidak valid untuk "{ $name }": "{ $quantity }". Harus berupa bilangan bulat positif.
player-error-input-errors-header = Kesalahan pada input inventaris:
player-msg-no-valid-items = Tidak ada barang yang valid. Menginisialisasi dengan inventaris kosong.

# Validation error view
player-validation-error-title = Kesalahan input
player-validation-btn-retry = Coba lagi

# Cart quantity validation
player-error-enter-valid-number = Silakan masukkan angka positif yang valid.

# Submission embeds (approval queue)
player-embed-title-approval = Persetujuan Inventaris: { $characterName }
player-embed-desc-submitted-by = Diajukan oleh { $userMention }
player-embed-field-items = Barang
player-embed-field-currency-received = Mata Uang
player-embed-footer-submission-id = ID Pengajuan: { $submissionId }
player-label-approval-thread = Persetujuan: { $characterName }
player-embed-title-submission-sent = Pengajuan Inventaris Terkirim
player-embed-desc-submission-sent =
    Pengajuan Anda untuk {"**"}{ $characterName }{"**"} telah dikirim ke tim GM untuk ditinjau!
    Anda akan diberitahu setelah pengajuan ditinjau.
    [Lihat Thread Pengajuan]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = Inventaris Awal Diterapkan
player-embed-desc-starting-inventory = Pemain: { $playerMention } sebagai `{ $characterName }`
player-embed-field-items-received = Barang yang Diterima
player-embed-field-currency-received-label = Mata Uang yang Diterima
player-label-untitled = Tanpa Judul

# ApprovalPostView
player-approval-post-header =
    {"**"}Pengajuan Inventaris: { $characterName }{"**"}
    Diajukan oleh { $userMention }
player-approval-post-items = Item
player-approval-post-currency = Mata Uang
player-approval-resolved = Pengajuan ini telah diselesaikan.
player-approval-btn-approve = Setujui
player-approval-btn-deny = Tolak
player-approval-btn-edit = Ubah
player-approval-error-no-permission = Anda tidak memiliki izin untuk melakukan tindakan ini.
player-approval-error-not-submitter = Hanya pengirim asli yang dapat mengedit pengajuan ini.
player-approval-thread-instructions =
    Thread ini dibuat untuk persetujuan {"**"}{ $characterName }{"**"}.
    Seorang Game Master akan meninjau pengajuan dan menyetujui atau menolaknya.
    Setelah disetujui atau ditolak, thread ini akan dikunci.

    {"**"}Game Master:{"**"} Diskusikan perubahan yang diperlukan
    dengan pemain Anda hingga inventaris dalam keadaan yang dapat
    diterima. Gunakan tombol `Tolak` hanya untuk pengajuan yang
    tidak dapat direkonsiliasi.

    { $playerMention }: Gunakan tombol `Edit` untuk melakukan
    perubahan yang diminta di sini oleh Game Master.
player-approval-approved-by = Pengajuan ini disetujui oleh { $approver }.
player-approval-denied-by = Pengajuan ini ditolak oleh { $denier }.
player-approval-deny-reason = Alasan: { $reason }
player-msg-submission-updated = Pengajuan Anda telah diperbarui.


# Denial modal
player-modal-title-deny-reason = Tolak pengajuan
player-modal-label-deny-reason = Alasan penolakan
player-modal-placeholder-deny-reason = Opsional: jelaskan alasan penolakan
# Approval DM notifications
player-dm-title-approved = Karakter disetujui
player-dm-desc-approved =
    Karakter Anda {"**"}{ $characterName }{"**"} telah disetujui
    oleh { $approver } di {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Karakter ditolak
player-dm-desc-denied =
    Karakter Anda {"**"}{ $characterName }{"**"} telah ditolak
    oleh { $denier } di {"**"}{ $guildName }{"**"}.
