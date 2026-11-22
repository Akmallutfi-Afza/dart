import 'package:material_ui/material_ui.dart';

/// Tab ketiga: identitas warga, ringkasan aktivitas, dan informasi aplikasi.
class TabProfil extends StatelessWidget {
  final String nama;
  final String nik;
  final String alamat;
  final int totalPengajuan;

  const TabProfil({
    super.key,
    required this.nama,
    required this.nik,
    required this.alamat,
    required this.totalPengajuan,
  });

  String get _inisial {
    final bagian = nama.trim().split(RegExp(r'\s+'));
    if (bagian.length == 1) return bagian.first.substring(0, 1).toUpperCase();
    return (bagian.first.substring(0, 1) + bagian.last.substring(0, 1))
        .toUpperCase();
  }

  String get _nikTersamar {
    if (nik.length < 8) return nik;
    return '${nik.substring(0, 4)} •••• •••• ${nik.substring(nik.length - 4)}';
  }

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      children: [
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 38,
                backgroundColor: skema.primary.withValues(alpha: 0.12),
                child: Text(
                  _inisial,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: skema.primary,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                nama,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'NIK $_nikTersamar',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 2),
              Text(
                alamat,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.4,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: Color(0xFFE3E9F0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                _statistik('$totalPengajuan', 'Diajukan'),
                _pembatas(),
                _statistik('$totalPengajuan', 'Diproses'),
                _pembatas(),
                _statistik('0', 'Selesai'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Pengaturan & Informasi',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        _menu(
          ikon: Icons.badge_outlined,
          judul: 'Data Kependudukan',
          onTap: () => _tampilkanInfo(
            context,
            'Data Kependudukan',
            'Nama: $nama\nNIK: $nik\nAlamat: $alamat\n\n'
                'Perubahan data kependudukan hanya dapat dilakukan di kantor '
                'kelurahan dengan membawa KTP dan Kartu Keluarga asli.',
          ),
        ),
        _menu(
          ikon: Icons.menu_book_outlined,
          judul: 'Panduan Penggunaan',
          onTap: () => _tampilkanInfo(
            context,
            'Panduan Penggunaan',
            '1. Pilih jenis layanan pada tab Beranda.\n'
                '2. Lengkapi formulir dan kirim pengajuan.\n'
                '3. Pantau status pada tab Riwayat.\n'
                '4. Buka detail pengajuan untuk melihat alur verifikasi.\n\n'
                'Bawa dokumen asli ke loket kelurahan saat mengambil surat.',
          ),
        ),
        _menu(
          ikon: Icons.info_outline,
          judul: 'Tentang Aplikasi',
          onTap: () => showAboutDialog(
            context: context,
            applicationName: 'SILAYAR',
            applicationVersion: '1.0.0',
            applicationIcon: Icon(
              Icons.account_balance,
              size: 36,
              color: skema.primary,
            ),
            children: const [
              Text(
                'Sistem Layanan Warga Kelurahan Sukajadi, Kota Bandung.\n\n'
                'Prototipe aplikasi mandiri untuk digitalisasi layanan '
                'administrasi warga tingkat kelurahan.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: Text(
            'Tes Akhir Praktikum DPPB Pekan 9',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
          ),
        ),
      ],
    );
  }

  Widget _statistik(String nilai, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            nilai,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _pembatas() {
    return Container(width: 1, height: 32, color: const Color(0xFFE3E9F0));
  }

  Widget _menu({
    required IconData ikon,
    required String judul,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE3E9F0)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(ikon, size: 20, color: Colors.blueGrey.shade600),
        title: Text(
          judul,
          style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(
          Icons.chevron_right,
          size: 20,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  void _tampilkanInfo(BuildContext context, String judul, String isi) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(judul),
          content: SingleChildScrollView(child: Text(isi)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}
