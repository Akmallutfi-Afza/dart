import 'package:material_ui/material_ui.dart';

import '../models/aduan_pju.dart';
import 'kartu_aduan.dart';

class TabRiwayat extends StatelessWidget {
  final List<AduanPju> daftarAduan;
  final ValueChanged<AduanPju> onBatalkan;

  const TabRiwayat({
    super.key,
    required this.daftarAduan,
    required this.onBatalkan,
  });

  Widget _kosong() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: const Color(0xFF1D4ED8).withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.history_toggle_off,
                size: 42,
                color: Color(0xFF1D4ED8),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Belum Ada Aduan',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              'Laporan lampu jalan yang Anda kirim akan muncul di sini beserta nomor tiketnya.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (daftarAduan.isEmpty) {
      return _kosong();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
          child: Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Riwayat Aduan',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Laporan lampu jalan yang tersimpan',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D4ED8).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${daftarAduan.length} laporan',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1D4ED8),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
            itemCount: daftarAduan.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: KartuAduan(
                  aduan: daftarAduan[index],
                  onBatalkan: onBatalkan,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
