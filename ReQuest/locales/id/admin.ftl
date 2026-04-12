## Admin module strings

# Admin cog
admin-embed-title-unauthorized = Server Tidak Diizinkan
admin-embed-desc-unauthorized =
    Terima kasih atas minat Anda terhadap ReQuest! Server Anda tidak ada dalam daftar server uji coba resmi ReQuest.
    Silakan bergabung ke Discord dukungan di bawah ini, dan hubungi tim pengembangan untuk meminta akses uji coba.

    [Discord Pengembangan ReQuest](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Perintah berikut telah disinkronkan ke { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Perintah berikut telah disinkronkan secara global
admin-error-missing-scope = ReQuest tidak memiliki cakupan yang benar di guild target. Tambahkan izin `applications.commands` dan coba lagi.
admin-error-sync-failed = Terjadi kesalahan saat menyinkronkan perintah: { $error }
admin-msg-commands-cleared = Perintah dihapus.

# Admin buttons
admin-btn-shutdown = Matikan
admin-modal-title-confirm-shutdown = Konfirmasi Mematikan
admin-modal-label-shutdown-warning = Peringatan! Ini akan mematikan bot. Ketik KONFIRMASI untuk melanjutkan.
admin-msg-shutting-down = Mematikan!
admin-btn-add-server = Tambah Server Baru
admin-btn-load-cog = Muat Cog
admin-msg-extension-loaded = Ekstensi berhasil dimuat: `{ $module }`
admin-btn-reload-cog = Muat Ulang Cog
admin-msg-extension-reloaded = Ekstensi berhasil dimuat ulang: `{ $module }`
admin-btn-output-guilds = Tampilkan Daftar Guild
admin-msg-connected-guilds = Terhubung ke { $count } guild:

# Admin modals
admin-modal-title-add-server = Tambahkan ID Server ke Daftar Izin
admin-modal-label-server-name = Nama Server
admin-modal-placeholder-server-name = Ketik nama singkat untuk Server Discord
admin-modal-label-server-id = ID Server
admin-modal-placeholder-server-id = Ketik ID Server Discord
admin-modal-title-cog-action = { $action } Cog
admin-modal-label-cog-name = Nama
admin-modal-placeholder-cog-name = Masukkan nama Cog untuk di-{ $action }

# Admin views
admin-title-main-menu = Administrasi - Menu Utama
admin-desc-allowlist = Konfigurasi daftar izin server untuk pembatasan undangan.
admin-desc-cogs = Muat atau muat ulang cog.
admin-desc-guild-list = Menampilkan daftar semua guild tempat bot menjadi anggota.
admin-desc-shutdown = Mematikan bot
admin-title-allowlist = Administrasi - Daftar Izin Server
admin-desc-allowlist-warning =
    Tambahkan ID Server Discord baru ke daftar izin.
    {"**"}PERINGATAN: Tidak ada cara untuk memverifikasi apakah ID server yang diberikan valid tanpa bot menjadi anggota server tersebut. Periksa kembali input Anda!{"**"}
admin-msg-no-servers = Tidak ada server dalam daftar izin.

# Admin confirm modals
admin-modal-title-confirm-server-removal = Konfirmasi Penghapusan Server
admin-modal-label-server-removal = Hapus server dari daftar izin?

# Admin cog view
admin-title-cogs = Administrasi - Cog
admin-desc-load-cog = Muat cog bot berdasarkan nama. File harus bernama `<nama>.py` dan disimpan di ReQuest/cogs/.
admin-desc-reload-cog = Muat ulang cog yang sudah dimuat berdasarkan nama. Pembatasan penamaan dan jalur file yang sama berlaku.
