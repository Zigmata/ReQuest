## Game Master module strings

# GM buttons
gm-btn-create = Buat
gm-btn-edit-details = Ubah Detail
gm-btn-toggle-ready = Alihkan Kesiapan
gm-btn-configure-rewards = Konfigurasi Hadiah
gm-btn-remove-player = Keluarkan Pemain
gm-btn-cancel-quest = Batalkan Quest
gm-btn-manage-party-rewards = Kelola Hadiah Rombongan
gm-btn-manage-individual-rewards = Kelola Hadiah Individu
gm-btn-join = Gabung
gm-btn-leave = Keluar
gm-btn-complete-quest = Selesaikan Quest
gm-btn-review-submission = Tinjau Pengajuan
gm-btn-approve = Setujui
gm-btn-deny = Tolak

# GM modals
gm-modal-title-create-quest = Buat Quest Baru
gm-modal-label-quest-title = Judul Quest
gm-modal-placeholder-quest-title = Judul quest Anda
gm-modal-label-restrictions = Batasan
gm-modal-placeholder-restrictions = Batasan, jika ada, seperti level pemain
gm-modal-label-max-party = Ukuran Rombongan Maksimum
gm-modal-placeholder-max-party = Ukuran maks rombongan untuk quest ini
gm-modal-label-party-role = Peran Rombongan
gm-modal-placeholder-party-role = Buat peran untuk quest ini (Opsional)
gm-modal-label-description = Deskripsi
gm-modal-placeholder-description = Tulis detail quest Anda di sini
gm-modal-title-editing-quest = Mengedit { $questTitle }
gm-modal-label-title = Judul
gm-modal-label-max-party-size = Ukuran Rombongan Maks
gm-modal-title-add-reward = Tambah Hadiah
gm-modal-label-experience = Poin Pengalaman
gm-modal-placeholder-experience = Masukkan angka
gm-modal-label-items = Barang
gm-modal-placeholder-items =
    barang: jumlah
    barang2: jumlah
    dst.
gm-modal-title-add-summary = Tambah Ringkasan Quest
gm-modal-label-summary = Ringkasan
gm-modal-placeholder-summary = Tambahkan ringkasan cerita quest
gm-modal-title-modifying-player = Mengubah { $playerName }
gm-modal-placeholder-xp-add-remove = Masukkan angka positif atau negatif.
gm-modal-label-inventory = Inventaris
gm-modal-placeholder-inventory-modify =
    barang: jumlah
    barang2: jumlah
    dst.
gm-modal-title-review-submission = Tinjau Pengajuan
gm-modal-label-submission-id = ID Pengajuan
gm-modal-placeholder-submission-id = Masukkan ID 8 karakter

# GM errors
gm-error-forbidden-role-name = Nama yang diberikan untuk peran rombongan dilarang.
gm-error-role-already-exists = Peran dengan nama tersebut sudah ada di server ini.
gm-error-no-quest-channel = Kanal belum ditetapkan untuk posting quest. Hubungi admin server untuk mengonfigurasi Kanal Quest.
gm-error-cannot-ping-announce = Tidak dapat menyebut peran pengumuman { $role } di kanal { $channel }. Periksa izin kanal dan peran ReQuest dengan admin server Anda.
gm-error-invalid-item-format = Format barang tidak valid: "{ $item }". Setiap barang harus di baris baru, dengan format "Nama: Jumlah".
gm-error-submission-not-found = Pengajuan tidak ditemukan.
gm-error-already-on-quest = Anda sudah bergabung di quest ini sebagai { $characterName }.
gm-error-no-active-character-long = Anda tidak memiliki karakter aktif di server ini. Gunakan `/player` untuk mendaftar atau mengaktifkan karakter.
gm-error-quest-locked = Gagal bergabung ke quest {"**"}{ $questTitle }{"**"}: Quest dikunci oleh GM.
gm-error-quest-full = Gagal bergabung ke quest {"**"}{ $questTitle }{"**"}: Daftar rombongan quest sudah penuh!
gm-error-not-signed-up = Anda tidak terdaftar di quest ini.
gm-error-quest-channel-not-set = Kanal quest belum diatur!
gm-error-empty-roster = Anda tidak dapat menyelesaikan quest dengan daftar rombongan kosong. Coba batalkan saja.
gm-error-invalid-xp-value = Nilai XP harus berupa bilangan bulat positif!

# GM confirm modals
gm-modal-title-cancel-quest = Batalkan Quest
gm-modal-label-cancel-quest = Ketik KONFIRMASI untuk membatalkan quest.
gm-modal-title-remove-from-quest = Keluarkan karakter dari quest
gm-modal-label-remove-from-quest = Konfirmasi pengeluaran karakter?

# GM DM messages
gm-dm-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} telah dibatalkan oleh GM.
gm-dm-quest-ready = Quest {"**"}{ $questTitle }{"**"} sekarang siap!
gm-dm-quest-unlocked = Quest {"**"}{ $questTitle }{"**"} tidak lagi terkunci.
gm-dm-quest-locked = Quest {"**"}{ $questTitle }{"**"} sekarang dikunci oleh GM.
gm-dm-player-removed = Anda telah dikeluarkan dari quest {"**"}{ $questTitle }{"**"}.
gm-dm-player-removed-waitlist = Anda telah dikeluarkan dari daftar tunggu untuk {"**"}{ $questTitle }{"**"}.
gm-dm-party-promotion = Anda telah ditambahkan ke rombongan untuk {"**"}{ $questTitle }{"**"}, karena ada pemain yang keluar!
gm-dm-roster-locked = Daftar rombongan quest dikunci dan anggota telah diberitahu!
gm-dm-roster-unlocked = Daftar rombongan quest telah dibuka.
gm-dm-rewards-no-characters =
    Admin server Anda telah mengonfigurasi hadiah untuk GM saat mereka menyelesaikan
    quest. Namun, karena Anda tidak memiliki karakter terdaftar, hadiah Anda tidak
    dapat diberikan secara otomatis saat ini.
gm-dm-rewards-no-active-character =
    Admin server Anda telah mengonfigurasi hadiah untuk GM saat mereka menyelesaikan
    quest. Namun, karena Anda tidak memiliki karakter aktif di server ini, hadiah Anda
    tidak dapat diberikan secara otomatis saat ini.
gm-dm-rewards-issued = Berikut ini telah diberikan ke karakter aktif Anda, { $characterName }

# GM select menus
gm-select-placeholder-party-member = Pilih anggota rombongan

# GM embeds
gm-embed-title-mod-report = Laporan Modifikasi Pemain oleh GM
gm-embed-field-experience = Pengalaman
gm-embed-title-quest-complete = Quest Selesai: { $questTitle }
gm-embed-title-quest-completed = QUEST SELESAI: { $questTitle }
gm-embed-field-rewards = Hadiah
gm-embed-field-party = __Rombongan__
gm-embed-field-summary = Ringkasan
gm-embed-title-gm-rewards = Hadiah GM Diberikan
gm-embed-field-items = Barang
gm-msg-player-removed = Pemain dikeluarkan dan daftar rombongan quest diperbarui!

# GM views
gm-title-main-menu = GM - Menu Utama
gm-menu-quests = Quest
gm-menu-desc-quests = Buat, ubah, dan kelola quest.
gm-menu-players = Pemain
gm-menu-desc-players = Kelola inventaris pemain dan ubah karakter.
gm-menu-approvals = Persetujuan Karakter
gm-menu-desc-approvals = Tinjau dan setujui/tolak pengajuan karakter.

gm-title-quest-management = GM - Manajemen Quest
gm-desc-create-quest = Buat quest baru.
gm-msg-no-quests = Tidak ada quest ditemukan.
gm-label-quest-locked = (Terkunci)
gm-title-manage-quest = Kelola Quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Ubah detail quest seperti judul, deskripsi, dan ukuran rombongan.
gm-desc-toggle-ready = Alihkan status kesiapan (Saat ini: {"**"}{ $status }{"**"})
    - Mengunci daftar rombongan quest dan memberi tahu anggota rombongan bahwa quest akan segera dimulai. Jika peran dikonfigurasi, peran akan diberikan kepada anggota rombongan saat dikunci.
    - Membuka daftar rombongan saat diatur ke Terbuka.
gm-label-ready-locked = Terkunci/Siap
gm-label-ready-open = Terbuka
gm-desc-configure-rewards = Konfigurasi hadiah untuk quest yang dipilih.
gm-desc-complete-quest = Selesaikan quest. Memberikan hadiah, jika ada, kepada anggota rombongan.
gm-desc-remove-player = Keluarkan pemain dari daftar rombongan quest dan beri tahu mereka.
gm-desc-cancel-quest = Batalkan quest dan hapus dari papan quest.
gm-title-player-management = GM - Manajemen Pemain
gm-desc-player-management =
    Perintah ini telah dipindahkan ke menu konteks. Klik kanan (desktop) atau tekan lama (seluler) profil pemain untuk opsi menu berikut:

    - {"**"}Modifikasi Pemain{"**"}: Tambah atau hapus barang dan pengalaman dari pemain.
    - {"**"}Lihat Pemain{"**"}: Lihat detail karakter aktif pemain.
gm-title-remove-player = Keluarkan Pemain dari Quest - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Catatan Pengeluaran Pemain{"**"}__

    - Pilih pemain dari dropdown di bawah untuk mengeluarkan mereka dari daftar rombongan quest.
    - Jika ada pemain di daftar tunggu, pemain pertama dalam daftar akan dipromosikan ke rombongan.
    - Hadiah individu untuk pemain yang dikeluarkan akan dihapus dari quest.
    - Jika Anda ingin memberi hadiah kepada pemain atas kontribusi sebelumnya, gunakan menu konteks `Modifikasi Pemain` untuk memberikan hadiah langsung.
gm-label-no-players-in-roster = Tidak ada pemain di daftar rombongan quest
gm-title-character-sheet = Lembar Karakter untuk { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Poin Pengalaman:{"**"}__
gm-label-possessions = __{"**"}Kepemilikan{"**"}__
gm-label-currency-heading = {"**"}Mata Uang{"**"}
gm-msg-inventory-empty = Inventaris kosong.

# GM approvals
gm-title-approvals = GM - Persetujuan Inventaris
gm-desc-review-submission = Masukkan ID Pengajuan untuk meninjau dan menyetujui/menolaknya.
gm-title-reviewing = Meninjau: { $characterName }
gm-label-items = {"**"}Barang:{"**"}
gm-label-currency = {"**"}Mata Uang:{"**"}
gm-embed-title-approved = Pembaruan Inventaris Disetujui
gm-embed-desc-approved = Inventaris untuk {"**"}{ $characterName }{"**"} telah disetujui oleh { $approver }.
gm-embed-title-denied = Pembaruan Inventaris Ditolak
gm-embed-desc-denied = Inventaris untuk {"**"}{ $characterName }{"**"} telah ditolak oleh { $denier }.

gm-modal-label-select-party-role = Peran Rombongan
gm-modal-desc-select-party-role = Pilih peran untuk ditetapkan ke rombongan quest.
gm-select-option-no-role = Tidak ada (Tanpa Peran Rombongan)

gm-error-role-hierarchy = ReQuest tidak dapat mengelola peran "{ $roleName }" (ID: { $roleId }) karena posisinya lebih tinggi dari peran tertinggi ReQuest dalam hierarki server. Hubungi administrator server untuk memindahkan peran tersebut di bawah peran ReQuest, atau tetapkan peran yang lebih tinggi ke ReQuest, lalu coba lagi operasinya.
gm-dm-role-removal-failed =
    ⚠️ Gagal menghapus peran {"**"}{ $roleName }{"**"} dari anggota berikut: { $members }.
    Harap beri tahu administrator server untuk menghapus peran secara manual.

gm-dm-role-not-found =
    ⚠️ Peran quest (ID: { $roleId }) untuk quest {"**"}{ $questTitle }{"**"} tidak lagi ada di server.
    Operasi peran dilewati. Harap beri tahu administrator server jika ini tidak terduga.
