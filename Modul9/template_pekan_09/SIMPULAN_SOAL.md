# Simpulan Tugas Praktikum Pekan 9

**Mata Kuliah:** Dasar Pemrograman Perangkat Bergerak
**Materi:** Navigasi Antar Halaman & Event Handling pada Flutter
**Proyek:** `praktikum_pekan_09` — Aplikasi Kasir Sentra UMKM Kota Bandung

---

## SOAL 1 — Fungsi `prosesLogin()`

**Lokasi kode:** `lib/halaman_login.dart` (TODO 1–4)

**Simpulan:**
Fungsi `prosesLogin()` adalah contoh paling sederhana dari siklus *event handling*: tombol `ElevatedButton` yang ditekan pengguna (*user action*) memicu *event listener* `onPressed`, lalu mengeksekusi *callback* `prosesLogin()`, dan berakhir pada *system reaction* berupa perpindahan layar. Teks dari `TextEditingController` diambil dan dirapikan dengan `trim()`, kemudian diberi nilai cadangan `'Kasir Bandung'` bila kosong, sehingga data yang dikirim ke halaman berikutnya dijamin tidak pernah bernilai kosong. Data nama dikirim secara *forward passing* melalui *constructor injection* ke `HalamanDashboard(namaPengguna: nama)`, yang membuat kesalahan tipe data dapat terdeteksi sejak proses kompilasi (*compile-time type safety*).

> Catatan analisis: komentar TODO 3 menyebut "method navigasi **pengganti** rute", sedangkan kode saat ini memakai `Navigator.push()`. Sesuai teori C.3.c pada modul, alur login sebaiknya memakai `Navigator.pushReplacement()` agar halaman login tidak tertinggal di dalam *navigation stack* dan tidak bisa dibuka kembali dengan tombol back setelah pengguna berhasil masuk.

---

## SOAL 2 — Fungsi `buildProductCard(ItemPenjualan item)`

**Lokasi kode:** `lib/tabs/tab_katalog.dart` (TODO 5–7)

**Simpulan:**
Fungsi ini mengubah data model `ItemPenjualan` menjadi kartu etalase yang interaktif. Karena `Card` dan `Container` pada dasarnya bersifat statis, kartu dibungkus dengan `InkWell` yang menyediakan *callback* `onTap` untuk memanggil `onPilihItem(item)`. Pola ini disebut *callback injection*: widget anak tidak tahu apa yang akan terjadi setelah diketuk, ia hanya meneruskan objek item kepada widget induk (`HalamanDashboard`) yang memiliki logika navigasi. Gambar produk ditampilkan dengan `Image.asset(item.foto, fit: BoxFit.contain)` agar seluruh bagian foto tetap terlihat tanpa terpotong, sementara nama dan harga dirender dari properti objek sehingga satu fungsi yang sama dapat dipakai ulang untuk seluruh item pada `GridView.builder`.

> Catatan: masih terdapat baris `return SizedBox();` setelah `return Card(...)` yang tidak akan pernah dieksekusi (*dead code*) dan sebaiknya dihapus.

---

## SOAL 3 — Fungsi `navigasiKeDetail(ItemPenjualan item)`

**Lokasi kode:** `lib/halaman_dashboard.dart` (TODO 8–9)

**Simpulan:**
`navigasiKeDetail()` menerapkan navigasi hierarkis dengan prinsip LIFO: `Navigator.push()` menumpuk `HalamanDetailItem` di atas dashboard, dan objek `item` disuntikkan lewat *constructor* sehingga halaman detail tidak perlu mencari data sendiri. Nilai balik `Navigator.push()` bertipe `Future<dynamic>`, dan justru *future* inilah yang dikembalikan oleh fungsi ini agar pemanggilnya dapat menunggu hasil transaksi. Layar dashboard tidak dihancurkan, melainkan dibekukan di lapisan bawah tumpukan, sehingga ketika detail ditutup pengguna kembali ke kondisi katalog seperti semula.

---

## SOAL 4 — Fungsi `buildProductBanner(String foto)`

**Lokasi kode:** `lib/halaman_detail_item.dart` (TODO 10–12)

**Simpulan:**
`buildProductBanner()` membangun area gambar utama pada halaman detail. `BoxDecoration` dengan `BorderRadius.circular(12)` memberi sudut membulat dan latar `indigo.shade50` agar foto menyatu dengan tema aplikasi, sedangkan `Image.asset(foto, fit: BoxFit.contain)` menjaga proporsi gambar tetap utuh. Bagian terpenting adalah `errorBuilder`: bila berkas aset gagal dimuat, Flutter tidak melempar layar merah (*red screen of death*), melainkan menampilkan `Icon(Icons.image_outlined)` sebagai fallback. Ini menunjukkan bahwa penanganan kegagalan (*graceful degradation*) merupakan bagian dari perancangan antarmuka yang baik, bukan sekadar tambahan opsional.

---

## SOAL 5 — Fungsi `navigasiKembali()`

**Lokasi kode:** `lib/halaman_detail_item.dart` (TODO 13)

**Simpulan:**
Satu baris `Navigator.pop(context)` sudah cukup untuk melepas rute teratas dari tumpukan memori dan menghancurkannya, sehingga `HalamanDashboard` di bawahnya kembali aktif. Fungsi ini adalah pasangan wajib dari `Navigator.push()` pada SOAL 3: tanpa `pop`, setiap perpindahan layar akan menambah kedalaman tumpukan dan berpotensi menimbulkan *memory leak*. Tombol "Kembali" di sini juga selaras dengan tombol panah bawaan `AppBar` yang otomatis dibuat Flutter (`automaticallyImplyLeading`).

---

## SOAL 6 — Fungsi `prosesPenjualan()`

**Lokasi kode:** `lib/halaman_detail_item.dart` (TODO 14–16)

**Simpulan:**
`prosesPenjualan()` memadukan *event handling* dengan manipulasi state dan pengembalian data. Validasi `widget.item.stok > 0` menjaga agar transaksi tidak pernah menghasilkan stok negatif, lalu `setState()` menurunkan stok satu unit sehingga tampilan jumlah stok langsung diperbarui melalui `build()` ulang. Setelah itu `Navigator.pop(context, 'Terjual 1 unit ...')` menutup halaman sekaligus membawa *payload* berupa bukti transaksi. Perhatikan bahwa tombol penjualan diberi `onPressed: null` ketika stok habis, yang membuat tombol otomatis berstatus *disabled* — bukti bahwa validasi dilakukan di dua lapis: pada tampilan dan pada logika.

---

## SOAL 7 — Fungsi `tangkapHasilTransaksi(ItemPenjualan item)`

**Lokasi kode:** `lib/halaman_dashboard.dart` (TODO 18–20)

**Simpulan:**
Fungsi ini adalah sisi penerima dari mekanisme *backward returning result*. Kata kunci `await` membuat eksekusi berhenti sementara pada `navigasiKeDetail(item)` hingga halaman detail ditutup, karena waktu interaksi pengguna tidak dapat diprediksi sehingga alurnya harus asinkronus. Hasil yang dikembalikan diperiksa dengan `if (hasil != null)` untuk membedakan penjualan yang berhasil dari penutupan halaman lewat tombol back, lalu `riwayatTransaksi.insert(0, hasil.toString())` di dalam `setState()` menaruh transaksi terbaru di urutan paling atas dan langsung memperbarui tab Riwayat.

---

## SOAL 8 — Fungsi `buildRiwayatItem(String dataTransaksi, int noUrut)`

**Lokasi kode:** `lib/tabs/tab_riwayat.dart` (TODO 21–24)

**Simpulan:**
`buildRiwayatItem()` merender satu baris riwayat memakai `Card` dan `ListTile`: `CircleAvatar` berisi `Icon(Icons.check)` sebagai penanda transaksi berhasil, `title` menampilkan deskripsi transaksi, dan `subtitle` menampilkan nomor urut. Nomor urut dihitung sebagai `riwayatTransaksi.length - index` agar transaksi terbaru (yang berada di indeks 0) mendapat nomor paling besar, sesuai urutan kejadian sebenarnya. Ketika daftar masih kosong, `TabRiwayat` menampilkan *empty state* yang informatif, sehingga pengguna tidak melihat layar kosong tanpa penjelasan.

> Catatan: sama seperti SOAL 2, baris `return SizedBox();` di akhir fungsi tidak pernah tercapai dan sebaiknya dihapus.

---

## Simpulan Keseluruhan

Praktikum ini menunjukkan bahwa aplikasi multi-layar pada Flutter dibangun dari dua lapis konsep yang saling melengkapi. Lapis pertama adalah *event handling*: setiap interaksi pengguna melewati empat tahap yang sama, yaitu *user action*, *event listener*, *callback function*, dan *system reaction*, dengan pemilihan jenis tombol Material 3 (Filled, Elevated, Outlined, Text) yang mencerminkan prioritas tindakan. Lapis kedua adalah navigasi: `Navigator.push()` dan `Navigator.pop()` mengelola rute sebagai tumpukan LIFO, sementara `Navigator.pushReplacement()` dipakai ketika riwayat lama memang harus dimusnahkan, seperti pada alur login dan logout.

Pertukaran data antar layar terbukti dapat berjalan dua arah. Data dikirim ke depan melalui *constructor injection* yang aman secara tipe, dan dikembalikan ke belakang melalui `Navigator.pop(context, hasil)` yang ditangkap dengan `await` di sisi pemanggil. Untuk kebutuhan perpindahan antar modul yang setara, `BottomNavigationBar` dengan sinkronisasi `_selectedIndex` menjadi pilihan yang tepat karena tidak menambah kedalaman tumpukan memori dan tidak memerlukan tombol kembali. Kombinasi navigasi horizontal (tab) dan vertikal (push/pop) inilah yang disebut navigasi hibrida, dan pola tersebut yang akhirnya dipakai pada aplikasi kasir Sentra UMKM ini.
