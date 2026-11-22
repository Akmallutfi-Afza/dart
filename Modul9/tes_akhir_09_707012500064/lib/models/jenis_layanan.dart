import 'package:material_ui/material_ui.dart';

/// Model statis untuk satu jenis layanan administrasi kelurahan.
class JenisLayanan {
  final String kode;
  final String nama;
  final String deskripsi;
  final IconData ikon;
  final String estimasi;
  final List<String> syarat;

  const JenisLayanan({
    required this.kode,
    required this.nama,
    required this.deskripsi,
    required this.ikon,
    required this.estimasi,
    required this.syarat,
  });
}
