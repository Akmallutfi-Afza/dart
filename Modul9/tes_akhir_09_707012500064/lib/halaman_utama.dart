import 'package:material_ui/material_ui.dart';

import 'data/data_layanan.dart';
import 'halaman_detail_pengajuan.dart';
import 'halaman_formulir_pengajuan.dart';
import 'models/jenis_layanan.dart';
import 'models/pengajuan.dart';
import 'tabs/tab_beranda.dart';
import 'tabs/tab_profil.dart';
import 'tabs/tab_riwayat.dart';

/// Halaman induk yang menampung tiga tab sekaligus menjadi pemilik state
/// daftar pengajuan.
///
/// Alur data balikan:
/// 1. [_bukaFormulir] membuka formulir dengan `Navigator.push` sambil
///    mengirim objek [JenisLayanan] lewat constructor.
/// 2. Formulir ditutup dengan `Navigator.pop(context, pengajuan)`.
/// 3. Nilai balikan ditangkap dengan `await`, lalu disimpan ke [_riwayat]
///    melalui `setState()` sehingga tab Riwayat langsung diperbarui.
class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  static const String namaWarga = 'Akmallutfi Afza Gusty';
  static const String nikWarga = '3273012508040001';
  static const String alamatWarga =
      'Jl. Sukajadi No. 21, Kel. Sukajadi, Kota Bandung';

  static const List<String> _judulTab = [
    'Beranda',
    'Riwayat Pengajuan',
    'Profil Warga',
  ];

  int _indexTab = 0;
  final List<Pengajuan> _riwayat = [];

  Future<void> _bukaFormulir(JenisLayanan layanan) async {
    final hasil = await Navigator.push<Pengajuan>(
      context,
      MaterialPageRoute(
        builder: (context) => HalamanFormulirPengajuan(layanan: layanan),
      ),
    );

    if (!mounted || hasil == null) return;

    setState(() {
      _riwayat.insert(0, hasil);
      _indexTab = 1;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Pengajuan ${hasil.nomor} berhasil dikirim.'),
          action: SnackBarAction(
            label: 'Lihat',
            onPressed: () => _bukaDetail(hasil),
          ),
        ),
      );
  }

  void _bukaDetail(Pengajuan pengajuan) {
    Navigator.pushNamed(
      context,
      HalamanDetailPengajuan.rute,
      arguments: pengajuan,
    );
  }

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;

    final halaman = [
      TabBeranda(
        namaWarga: namaWarga,
        daftarLayanan: daftarLayanan,
        riwayat: _riwayat,
        onAjukan: _bukaFormulir,
      ),
      TabRiwayat(riwayat: _riwayat, onBukaDetail: _bukaDetail),
      TabProfil(
        nama: namaWarga,
        nik: nikWarga,
        alamat: alamatWarga,
        totalPengajuan: _riwayat.length,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_judulTab[_indexTab]),
            Text(
              'Kelurahan Sukajadi, Kota Bandung',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
      body: IndexedStack(index: _indexTab, children: halaman),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexTab,
        onTap: (index) {
          setState(() {
            _indexTab = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: skema.primary,
        unselectedItemColor: Colors.grey.shade600,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
