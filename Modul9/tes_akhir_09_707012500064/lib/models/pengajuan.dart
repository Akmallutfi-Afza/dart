import 'jenis_layanan.dart';

/// Data satu pengajuan surat yang dibuat warga.
///
/// Objek ini dikirim ke halaman formulir, lalu dikembalikan lagi ke
/// [HalamanUtama] sebagai data balikan (returning data).
class Pengajuan {
  final String nomor;
  final JenisLayanan layanan;
  final String namaPemohon;
  final String nik;
  final String alamat;
  final String keperluan;
  final DateTime tanggal;
  final String status;

  const Pengajuan({
    required this.nomor,
    required this.layanan,
    required this.namaPemohon,
    required this.nik,
    required this.alamat,
    required this.keperluan,
    required this.tanggal,
    this.status = 'Menunggu Verifikasi',
  });

  static const List<String> _namaBulan = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  /// Contoh hasil: 20 November 2026.
  String get tanggalTeks =>
      '${tanggal.day} ${_namaBulan[tanggal.month - 1]} ${tanggal.year}';

  /// NIK disamarkan agar aman ditampilkan di daftar riwayat.
  String get nikTersamar {
    if (nik.length < 8) return nik;
    return '${nik.substring(0, 4)}••••••••${nik.substring(nik.length - 4)}';
  }

  /// Nomor pengajuan unik, contoh: PJG-20261120-143502.
  static String buatNomor(DateTime waktu) {
    String dua(int angka) => angka.toString().padLeft(2, '0');
    final tanggal =
        '${waktu.year}${dua(waktu.month)}${dua(waktu.day)}';
    final jam = '${dua(waktu.hour)}${dua(waktu.minute)}${dua(waktu.second)}';
    return 'PJG-$tanggal-$jam';
  }
}
