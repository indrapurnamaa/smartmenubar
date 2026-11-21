# Smart Menu Bar

Sembunyikan menu bar saat menonton YouTube fullscreen, tanpa perlu bolak-balik mengubah pengaturan menu bar di macOS.

## Mengapa saya membuat ini?

Saya suka membiarkan menu bar tetap terlihat saat bekerja, membuka VS Code, dan menggunakan aplikasi lain ketika mode fullscreen. Karena itu, saya memilih **Never** pada pengaturan **Automatically hide and show the menu bar** di macOS.

Namun, pengaturan tersebut juga membuat menu bar tetap terlihat saat saya menonton YouTube dalam mode fullscreen. Saya ingin video tampil lebih leluasa tanpa harus membuka System Settings setiap kali ingin menonton, lalu mengubahnya lagi setelah selesai.

Smart Menu Bar dibuat untuk mengatasi kebutuhan tersebut: cukup atur browser sekali, lalu menu bar otomatis tersembunyi saat browser masuk fullscreen, termasuk ketika menonton YouTube. Pengaturan menu bar untuk desktop dan aplikasi lain tetap mengikuti pilihan saya di macOS.

> **Perlu diketahui:** pengaturan ini berlaku untuk semua fullscreen pada browser yang dipilih, bukan hanya YouTube. Skrip ini tidak mendeteksi video atau situs yang sedang dibuka.

## Cara kerjanya

Smart Menu Bar adalah skrip sederhana yang mengubah preferensi menu bar untuk masing-masing browser:

```text
AppleMenuBarVisibleInFullscreen = false
```

Pengaturan global macOS tidak diubah. Anda tetap bisa menggunakan pilihan **Never** agar menu bar terlihat di desktop dan aplikasi lain.

Tidak perlu memasang extension, menjalankan aplikasi tambahan, atau membiarkan Terminal terbuka. Pengaturannya tersimpan setelah sleep, restart, dan shutdown.

## Browser yang didukung

| Browser | Nama dalam perintah |
| --- | --- |
| Google Chrome | `chrome` |
| Safari | `safari` |
| Brave | `brave` |

Sudah dicoba dan berhasil pada perangkat pribadi dengan **macOS 26 Tahoe**. Hasil pada versi macOS atau browser lain bisa berbeda karena preferensi ini bukan API publik yang dijamin Apple.

## Cara menggunakan

### 1. Unduh proyek

Di halaman GitHub repositori ini, pilih **Code → Download ZIP**, lalu ekstrak file yang diunduh.

### 2. Buka Terminal di folder proyek

Buka aplikasi **Terminal** melalui Spotlight (**Command + Space**, lalu ketik `Terminal`).

Ketik `cd` diikuti spasi, seret folder proyek dari Finder ke jendela Terminal, lalu tekan **Enter**. Terminal sekarang berada di folder yang berisi `chrome-menubar.sh`.

> Semua perintah di bawah dijalankan di Terminal, bukan di kolom alamat browser.

### 3. Aktifkan untuk browser pilihan

Jalankan salah satu perintah berikut, sesuai browser yang Anda gunakan. Jika ingin mengaktifkan beberapa browser, jalankan perintahnya satu per satu.

**Google Chrome:**

```sh
zsh chrome-menubar.sh enable chrome
```

**Brave:**

```sh
zsh chrome-menubar.sh enable brave
```

**Safari:**

Safari membutuhkan langkah izin tambahan. Ikuti bagian **Pengaturan khusus Safari** di bawah sebelum menjalankan:

```sh
zsh chrome-menubar.sh enable safari
```

### 4. Tutup dan buka kembali browser

1. Simpan pekerjaan yang sedang dibuka di browser.
2. Keluar sepenuhnya dengan **Command + Q**. Menutup jendela saja belum cukup.
3. Buka kembali browser.
4. Putar video YouTube dan klik tombol fullscreen pada pemutar video.
5. Jauhkan pointer dari tepi atas layar untuk melihat menu bar tersembunyi.

Menu bar dapat muncul sementara ketika pointer diarahkan ke tepi atas. Setelah keluar dari fullscreen, menu bar kembali mengikuti perilaku biasa.

## Pengaturan khusus Safari

macOS melindungi folder preferensi Safari. Jika muncul pesan `Could not write domain`, coba langkah berikut:

1. Tutup Safari dengan **Command + Q**.
2. Buka **System Settings → Privacy & Security → Full Disk Access**.
3. Tambahkan aplikasi **Terminal** jika belum tercantum, lalu aktifkan izinnya.
4. Tutup Terminal sepenuhnya dengan **Command + Q**, lalu buka kembali.
5. Masuk kembali ke folder proyek, kemudian jalankan:

   ```sh
   zsh chrome-menubar.sh enable safari
   ```

6. Jika berhasil, buka Safari dan uji fullscreen YouTube.
7. Setelah selesai, Anda dapat menonaktifkan kembali **Full Disk Access** untuk Terminal. Pengaturan menu bar yang sudah tersimpan tetap berlaku.

Gunakan **Terminal bawaan macOS** untuk langkah ini. Jika menggunakan terminal di dalam VS Code, izin Terminal tidak otomatis berlaku untuk VS Code.

Full Disk Access memberi akses luas ke data yang dilindungi. Izin ini hanya diperlukan saat mengubah preferensi Safari melalui Terminal, termasuk jika nanti ingin mengembalikannya.

## Memeriksa pengaturan

Jalankan perintah sesuai browser:

```sh
zsh chrome-menubar.sh status chrome
zsh chrome-menubar.sh status safari
zsh chrome-menubar.sh status brave
```

Arti hasilnya:

| Hasil | Artinya |
| --- | --- |
| `0` | Preferensi diatur agar menu bar tersembunyi saat fullscreen. |
| `1` | Preferensi diatur agar menu bar tetap terlihat saat fullscreen. |
| Pesan `has no override` | Preferensi tidak ditemukan atau tidak dapat dibaca; browser biasanya mengikuti pengaturan macOS jika tidak ada override. |

## Mengembalikan ke pengaturan macOS

Jalankan perintah sesuai browser yang ingin dikembalikan:

```sh
zsh chrome-menubar.sh restore chrome
zsh chrome-menubar.sh restore safari
zsh chrome-menubar.sh restore brave
```

Kemudian tutup browser dengan **Command + Q** dan buka kembali.

Perintah `restore` menghapus pengaturan khusus menu bar untuk browser tersebut sehingga kembali mengikuti pengaturan macOS. Perintah ini tidak memulihkan nilai khusus yang mungkin sudah Anda pasang sebelum menggunakan skrip; skrip tidak membuat cadangan nilai sebelumnya.

## Pertanyaan umum

**Apakah harus menjalankan skrip setiap kali menonton?**

Tidak. Cukup aktifkan sekali untuk setiap browser.

**Apakah tetap aktif setelah Mac sleep atau shutdown?**

Ya. Pengaturan tersimpan di preferensi browser dan tetap ada setelah sleep, restart, atau shutdown.

**Apakah perlu mengubah pilihan Never di System Settings?**

Tidak. Anda bisa tetap menggunakan **Never**. Skrip hanya mengubah preferensi browser yang dipilih.

**Apakah harus menggunakan sudo?**

Tidak. Jalankan perintah sebagai pengguna biasa. Untuk Safari, gunakan izin Full Disk Access seperti langkah di atas.
