import 'package:material_ui/material_ui.dart';

import '../models/aduan_pju.dart';
import '../utils/format_tanggal.dart';
import '../widgets/tab_beranda.dart';
import '../widgets/tab_riwayat.dart';

class HalamanLaporPju extends StatefulWidget {
  const HalamanLaporPju({super.key});

  @override
  State<HalamanLaporPju> createState() => _HalamanLaporPjuState();
}

class _HalamanLaporPjuState extends State<HalamanLaporPju> {
  final TextEditingController _alamatController = TextEditingController();
  final List<AduanPju> _daftarAduan = [];

  int _currentIndex = 0;
  int _nomorTerakhir = 0;
  String? _kecamatanDipilih;
  DateTime? _tanggalKejadian;

  static const List<Map<String, dynamic>> _dataKecamatan = [
    {'nama': 'Coblong', 'icon': Icons.apartment, 'warna': Color(0xFF2563EB)},
    {'nama': 'Sukasari', 'icon': Icons.park_outlined, 'warna': Color(0xFF16A34A)},
    {'nama': 'Lengkong', 'icon': Icons.storefront_outlined, 'warna': Color(0xFF9333EA)},
    {'nama': 'Sumur Bandung', 'icon': Icons.location_city, 'warna': Color(0xFF0891B2)},
    {'nama': 'Buahbatu', 'icon': Icons.holiday_village_outlined, 'warna': Color(0xFFEA580C)},
  ];

  @override
  void dispose() {
    _alamatController.dispose();
    super.dispose();
  }

  String _buatNomorAduan() {
    _nomorTerakhir++;
    return 'PJU-BDG-${_nomorTerakhir.toString().padLeft(3, '0')}';
  }

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _bukaPilihanKecamatan() async {
    final pilihan = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.62,
          minChildSize: 0.4,
          maxChildSize: 0.92,
          builder: (context, scrollController) {
            return ListView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              children: [
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D4ED8).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.map_outlined,
                        color: Color(0xFF1D4ED8),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pilih Kecamatan',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Wilayah Kota Bandung',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                ..._dataKecamatan.map((kecamatan) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Material(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(14),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: (kecamatan['warna'] as Color)
                              .withValues(alpha: 0.12),
                          child: Icon(
                            kecamatan['icon'] as IconData,
                            size: 20,
                            color: kecamatan['warna'] as Color,
                          ),
                        ),
                        title: Text(
                          kecamatan['nama'] as String,
                          style: const TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Color(0xFF94A3B8),
                        ),
                        onTap: () {
                          Navigator.pop(context, kecamatan['nama'] as String);
                        },
                      ),
                    ),
                  );
                }),
              ],
            );
          },
        );
      },
    );

    if (pilihan != null) {
      setState(() {
        _kecamatanDipilih = pilihan;
      });
    }
  }

  Future<void> _pilihTanggalKejadian() async {
    final sekarang = DateTime.now();
    final hariIni = DateTime(sekarang.year, sekarang.month, sekarang.day);

    final hasilPilihan = await showDatePicker(
      context: context,
      initialDate: hariIni,
      firstDate: hariIni.subtract(const Duration(days: 30)),
      lastDate: hariIni,
      helpText: 'PILIH TANGGAL KEJADIAN',
      confirmText: 'PILIH',
      cancelText: 'BATAL',
    );

    if (hasilPilihan != null) {
      setState(() {
        _tanggalKejadian = hasilPilihan;
      });
    }
  }

  Widget _barisRingkasan(String label, String nilai) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 3),
          Text(
            nilai,
            style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Future<bool?> _tampilkanKonfirmasi() {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          icon: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.campaign_outlined,
              size: 30,
              color: Color(0xFFD97706),
            ),
          ),
          title: const Text('Konfirmasi Kirim Aduan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Periksa kembali data laporan sebelum diteruskan ke petugas PJU.',
                style: TextStyle(fontSize: 13, height: 1.45),
              ),
              const SizedBox(height: 14),
              _barisRingkasan('Alamat', _alamatController.text.trim()),
              _barisRingkasan('Kecamatan', _kecamatanDipilih ?? '-'),
              _barisRingkasan(
                'Tanggal Kejadian',
                formatTanggal(_tanggalKejadian!),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('PERIKSA KEMBALI'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('KIRIM ADUAN'),
            ),
          ],
        );
      },
    );
  }

  void _tampilkanSnackBarSukses(AduanPju aduan) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.confirmation_number_outlined,
              size: 20,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text('Tiket ${aduan.nomor} berhasil diterbitkan'),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        persist: false,
        action: SnackBarAction(
          label: 'BATALKAN',
          textColor: const Color(0xFFFCD34D),
          onPressed: () {
            setState(() {
              aduan.isAktif = false;
            });
          },
        ),
      ),
    );
  }

  Future<void> _kirimAduan() async {
    FocusScope.of(context).unfocus();

    if (_alamatController.text.trim().isEmpty) {
      _tampilkanPesan('Alamat lokasi wajib diisi');
      return;
    }
    if (_kecamatanDipilih == null) {
      _tampilkanPesan('Pilih kecamatan lokasi lampu padam');
      return;
    }
    if (_tanggalKejadian == null) {
      _tampilkanPesan('Pilih tanggal kejadian lampu padam');
      return;
    }

    final disetujui = await _tampilkanKonfirmasi();
    if (disetujui != true || !mounted) return;

    final aduanBaru = AduanPju(
      nomor: _buatNomorAduan(),
      alamat: _alamatController.text.trim(),
      kecamatan: _kecamatanDipilih!,
      tanggalKejadian: _tanggalKejadian!,
    );

    setState(() {
      _daftarAduan.insert(0, aduanBaru);
      _alamatController.clear();
      _kecamatanDipilih = null;
      _tanggalKejadian = null;
      _currentIndex = 1;
    });

    _tampilkanSnackBarSukses(aduanBaru);
  }

  Future<void> _batalkanAduan(AduanPju aduan) async {
    final disetujui = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(
            Icons.warning_amber_rounded,
            size: 48,
            color: Color(0xFFDC2626),
          ),
          title: const Text('Batalkan Aduan?'),
          content: Text(
            'Aduan ${aduan.nomor} di Kecamatan ${aduan.kecamatan} akan dibatalkan dan tidak diteruskan ke petugas.',
            style: const TextStyle(fontSize: 13.5, height: 1.45),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('TIDAK'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('YA, BATALKAN'),
            ),
          ],
        );
      },
    );

    if (disetujui == true && mounted) {
      setState(() {
        aduan.isAktif = false;
      });
      _tampilkanPesan('Aduan ${aduan.nomor} dibatalkan');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.lightbulb,
              color: Color(0xFFFCD34D),
              size: 20,
            ),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SILAPJU'),
            SizedBox(height: 2),
            Text(
              'Lapor Lampu Jalan Kota Bandung',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Color(0xFFDBEAFE),
              ),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          TabBeranda(
            alamatController: _alamatController,
            kecamatanDipilih: _kecamatanDipilih,
            tanggalKejadian: _tanggalKejadian,
            jumlahAduan: _daftarAduan.length,
            onPilihKecamatan: _bukaPilihanKecamatan,
            onPilihTanggal: _pilihTanggalKejadian,
            onSubmit: _kirimAduan,
          ),
          TabRiwayat(
            daftarAduan: _daftarAduan,
            onBatalkan: _batalkanAduan,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Badge.count(
              count: _daftarAduan.length,
              isLabelVisible: _daftarAduan.isNotEmpty,
              child: const Icon(Icons.history_outlined),
            ),
            selectedIcon: Badge.count(
              count: _daftarAduan.length,
              isLabelVisible: _daftarAduan.isNotEmpty,
              child: const Icon(Icons.history),
            ),
            label: 'Riwayat',
          ),
        ],
      ),
    );
  }
}
