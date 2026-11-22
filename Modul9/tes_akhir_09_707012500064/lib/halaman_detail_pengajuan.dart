import 'package:material_ui/material_ui.dart';

import 'models/pengajuan.dart';
import 'widgets/status_chip.dart';

/// Halaman detail pengajuan.
///
/// Dibuka dari tab Riwayat memakai `Navigator.pushNamed()` dengan
/// `arguments: pengajuan`, lalu objeknya dibaca pada tabel `routes` di
/// [AplikasiLayananWarga].
class HalamanDetailPengajuan extends StatelessWidget {
  static const String rute = '/detail-pengajuan';

  final Pengajuan pengajuan;

  const HalamanDetailPengajuan({super.key, required this.pengajuan});

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pengajuan')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        children: [
          _kartuUtama(skema),
          const SizedBox(height: 12),
          _kartu(
            judul: 'Data Pemohon',
            ikon: Icons.person_outline,
            isi: Column(
              children: [
                _barisData('Nama', pengajuan.namaPemohon),
                _barisData('NIK', pengajuan.nik),
                _barisData('Alamat', pengajuan.alamat),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _kartu(
            judul: 'Keperluan',
            ikon: Icons.description_outlined,
            isi: Text(
              pengajuan.keperluan,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _kartu(
            judul: 'Alur Verifikasi',
            ikon: Icons.timeline,
            isi: Column(
              children: [
                _langkahAlur(
                  judul: 'Pengajuan diterima',
                  keterangan:
                      'Formulir masuk ke sistem pada ${pengajuan.tanggalTeks}.',
                  ikon: Icons.mark_email_read_outlined,
                  warna: Colors.green,
                  garisBawah: true,
                ),
                _langkahAlur(
                  judul: 'Verifikasi berkas',
                  keterangan:
                      'Petugas kelurahan memeriksa kelengkapan dokumen Anda.',
                  ikon: Icons.fact_check_outlined,
                  warna: Colors.orange,
                  garisBawah: true,
                ),
                _langkahAlur(
                  judul: 'Surat siap diambil',
                  keterangan:
                      'Estimasi ${pengajuan.layanan.estimasi} sejak berkas '
                      'dinyatakan lengkap.',
                  ikon: Icons.task_alt,
                  warna: Colors.blueGrey,
                  garisBawah: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  size: 18,
                  color: Colors.amber.shade800,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Simpan nomor pengajuan ini. Tunjukkan nomor tersebut '
                    'kepada petugas saat mengambil surat di loket kelurahan.',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.45,
                      color: Colors.amber.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 18),
            label: const Text('Kembali ke Riwayat'),
          ),
        ],
      ),
    );
  }

  Widget _kartuUtama(ColorScheme skema) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3E9F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: skema.primary.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  pengajuan.layanan.ikon,
                  color: skema.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pengajuan.nomor,
                      style: TextStyle(
                        fontSize: 11.5,
                        letterSpacing: 0.4,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      pengajuan.layanan.nama,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              StatusChip(status: pengajuan.status),
              const Spacer(),
              Icon(
                Icons.calendar_today_outlined,
                size: 12,
                color: Colors.grey.shade500,
              ),
              const SizedBox(width: 4),
              Text(
                pengajuan.tanggalTeks,
                style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kartu({
    required String judul,
    required IconData ikon,
    required Widget isi,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3E9F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(ikon, size: 17, color: Colors.blueGrey.shade600),
              const SizedBox(width: 7),
              Text(
                judul,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          isi,
        ],
      ),
    );
  }

  Widget _barisData(String label, String nilai) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 64,
            child: Text(
              label,
              style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600),
            ),
          ),
          Expanded(
            child: Text(
              nilai,
              style: const TextStyle(
                fontSize: 12.5,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _langkahAlur({
    required String judul,
    required String keterangan,
    required IconData ikon,
    required Color warna,
    required bool garisBawah,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: warna.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(ikon, size: 15, color: warna),
            ),
            if (garisBawah)
              Container(
                width: 2,
                height: 30,
                color: const Color(0xFFE3E9F0),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: garisBawah ? 12 : 0, top: 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  keterangan,
                  style: TextStyle(
                    fontSize: 11.5,
                    height: 1.4,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
