import 'package:material_ui/material_ui.dart';

import '../models/jenis_layanan.dart';
import '../models/pengajuan.dart';

/// Tab pertama: sambutan warga, ringkasan pengajuan, pencarian, dan
/// daftar layanan yang bisa diajukan.
class TabBeranda extends StatefulWidget {
  final String namaWarga;
  final List<JenisLayanan> daftarLayanan;
  final List<Pengajuan> riwayat;
  final ValueChanged<JenisLayanan> onAjukan;

  const TabBeranda({
    super.key,
    required this.namaWarga,
    required this.daftarLayanan,
    required this.riwayat,
    required this.onAjukan,
  });

  @override
  State<TabBeranda> createState() => _TabBerandaState();
}

class _TabBerandaState extends State<TabBeranda> {
  final TextEditingController _pencarian = TextEditingController();
  String _kataKunci = '';

  @override
  void dispose() {
    _pencarian.dispose();
    super.dispose();
  }

  List<JenisLayanan> get _layananTampil {
    final kunci = _kataKunci.trim().toLowerCase();
    if (kunci.isEmpty) return widget.daftarLayanan;

    return widget.daftarLayanan.where((layanan) {
      return layanan.nama.toLowerCase().contains(kunci) ||
          layanan.deskripsi.toLowerCase().contains(kunci);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final layanan = _layananTampil;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        _kartuSambutan(skema),
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                'Layanan Administrasi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${widget.daftarLayanan.length} layanan',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _pencarian,
          onChanged: (nilai) {
            setState(() {
              _kataKunci = nilai;
            });
          },
          decoration: InputDecoration(
            hintText: 'Cari layanan, misal: domisili',
            prefixIcon: const Icon(Icons.search, size: 20),
            suffixIcon: _kataKunci.isEmpty
                ? null
                : IconButton(
                    tooltip: 'Hapus pencarian',
                    onPressed: () {
                      _pencarian.clear();
                      setState(() {
                        _kataKunci = '';
                      });
                    },
                    icon: const Icon(Icons.close, size: 18),
                  ),
          ),
        ),
        const SizedBox(height: 14),
        if (layanan.isEmpty)
          _layananTidakDitemukan()
        else
          ...layanan.map((item) => _kartuLayanan(item, skema)),
      ],
    );
  }

  Widget _kartuSambutan(ColorScheme skema) {
    final total = widget.riwayat.length;
    final diproses = widget.riwayat
        .where((pengajuan) => pengajuan.status == 'Menunggu Verifikasi')
        .length;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0B5D8C), Color(0xFF1591A8)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0B5D8C).withValues(alpha: 0.22),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.account_balance,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat datang,',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.namaWarga,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _kotakStatistik('$total', 'Total pengajuan'),
              const SizedBox(width: 10),
              _kotakStatistik('$diproses', 'Sedang diproses'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.place_outlined,
                size: 13,
                color: Colors.white.withValues(alpha: 0.85),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Kelurahan Sukajadi • Kota Bandung',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kotakStatistik(String nilai, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nilai,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kartuLayanan(JenisLayanan layanan, ColorScheme skema) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE3E9F0)),
      ),
      child: InkWell(
        onTap: () => widget.onAjukan(layanan),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: skema.primary.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(layanan.ikon, color: skema.primary, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      layanan.nama,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      layanan.deskripsi,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.35,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 12,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          layanan.estimasi,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _layananTidakDitemukan() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Icon(Icons.search_off, size: 44, color: Colors.grey.shade400),
          const SizedBox(height: 10),
          Text(
            'Layanan "$_kataKunci" tidak ditemukan.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
