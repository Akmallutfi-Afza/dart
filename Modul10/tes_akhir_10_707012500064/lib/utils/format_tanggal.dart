const List<String> namaBulan = [
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

String formatTanggal(DateTime tanggal) {
  return '${tanggal.day} ${namaBulan[tanggal.month - 1]} ${tanggal.year}';
}
