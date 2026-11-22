# SILAYAR — Tes Akhir Praktikum DPPB Pekan 9

Aplikasi mini **Sistem Layanan Warga Kelurahan Sukajadi, Kota Bandung** untuk
digitalisasi pengajuan surat administrasi warga. Dibuat untuk **Tes Akhir**
Praktikum Dasar Pemrograman Perangkat Bergerak Pekan 9.

- **Nama:** Akmallutfi Afza Gusty
- **NIM:** 707012500064
- **Nama proyek:** `tes_akhir_09_707012500064`
- **Framework:** Flutter (Material 3)

## Pemenuhan Ketentuan Tes Akhir

| Ketentuan modul | Implementasi |
| --- | --- |
| Navigasi utama berbasis tab, minimal 3 tab | `BottomNavigationBar` dengan tab **Beranda**, **Riwayat**, dan **Profil** di `lib/halaman_utama.dart` |
| Navigasi ke halaman baru + kirim data lewat constructor | Tombol layanan memanggil `Navigator.push()` menuju `HalamanFormulirPengajuan(layanan: layanan)` |
| Navigasi memakai named route + arguments | Kartu riwayat memanggil `Navigator.pushNamed(context, '/detail-pengajuan', arguments: pengajuan)` |
| Penanganan data balikan (returning data) | Formulir ditutup dengan `Navigator.pop(context, pengajuan)`; halaman induk menangkapnya dengan `await` lalu menyimpannya lewat `setState()` |

## Alur Aplikasi

1. **Beranda** menampilkan sambutan warga, ringkasan jumlah pengajuan, kolom
   pencarian layanan, dan enam jenis layanan administrasi.
2. Warga mengetuk salah satu layanan. Aplikasi membuka **Formulir Pengajuan**
   sambil membawa objek `JenisLayanan` melalui constructor.
3. Formulir memvalidasi nama, NIK (16 digit), alamat, dan keperluan. Setelah
   dikonfirmasi, formulir mengembalikan objek `Pengajuan` ke halaman induk.
4. Halaman induk menyimpan pengajuan ke daftar riwayat, berpindah ke tab
   **Riwayat**, dan menampilkan SnackBar berisi nomor pengajuan.
5. Kartu riwayat dapat diketuk untuk membuka **Detail Pengajuan** (named route)
   yang menampilkan data pemohon, keperluan, dan alur verifikasi.
6. **Profil** menampilkan identitas warga, statistik pengajuan, serta menu
   informasi aplikasi.

## Struktur Berkas

```
lib/
├── main.dart                        # MaterialApp, tema, tabel routes
├── halaman_utama.dart               # Scaffold + BottomNavigationBar + state riwayat
├── halaman_formulir_pengajuan.dart  # Formulir + validasi + pop(data)
├── halaman_detail_pengajuan.dart    # Detail pengajuan (named route)
├── data/data_layanan.dart           # Data statis jenis layanan
├── models/
│   ├── jenis_layanan.dart
│   └── pengajuan.dart               # Nomor otomatis, format tanggal, NIK tersamar
├── tabs/
│   ├── tab_beranda.dart
│   ├── tab_riwayat.dart
│   └── tab_profil.dart
└── widgets/status_chip.dart         # Chip status pengajuan
```

## Menjalankan Aplikasi

```bash
flutter pub get
flutter run -d edge        # atau: flutter run -d chrome
```

Mode offline (tanpa CDN):

```bash
flutter run -d edge --no-web-resources-cdn --no-pub
```

## Pemeriksaan Kode

```bash
flutter analyze   # No issues found!
flutter test      # 3 pengujian lulus
```

Pengujian widget mencakup: tampilan tiga tab, pengiriman data layanan ke
formulir lewat constructor, serta data balikan formulir yang langsung muncul di
tab Riwayat.
