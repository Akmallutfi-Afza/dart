class AduanPju {
  final String nomor;
  final String alamat;
  final String kecamatan;
  final DateTime tanggalKejadian;
  bool isAktif;

  AduanPju({
    required this.nomor,
    required this.alamat,
    required this.kecamatan,
    required this.tanggalKejadian,
    this.isAktif = true,
  });
}
