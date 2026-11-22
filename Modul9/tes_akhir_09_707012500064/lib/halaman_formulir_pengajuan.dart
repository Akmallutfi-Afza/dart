import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import 'models/jenis_layanan.dart';
import 'models/pengajuan.dart';

/// Halaman formulir pengajuan.
///
/// Halaman ini menerima objek [JenisLayanan] dari [HalamanUtama] melalui
/// constructor (forward passing). Setelah formulir valid dan dikonfirmasi,
/// halaman ditutup dengan `Navigator.pop(context, pengajuan)` sehingga objek
/// [Pengajuan] terkirim balik ke halaman induk (returning data).
class HalamanFormulirPengajuan extends StatefulWidget {
  final JenisLayanan layanan;

  const HalamanFormulirPengajuan({super.key, required this.layanan});

  @override
  State<HalamanFormulirPengajuan> createState() =>
      _HalamanFormulirPengajuanState();
}

class _HalamanFormulirPengajuanState extends State<HalamanFormulirPengajuan> {
  final _formKey = GlobalKey<FormState>();
  final _nama = TextEditingController();
  final _nik = TextEditingController();
  final _alamat = TextEditingController();
  final _keperluan = TextEditingController();

  @override
  void dispose() {
    _nama.dispose();
    _nik.dispose();
    _alamat.dispose();
    _keperluan.dispose();
    super.dispose();
  }

  Future<void> _kirimPengajuan() async {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) return;

    final dikonfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Kirim pengajuan?'),
          content: Text(
            'Pengajuan ${widget.layanan.nama} akan dikirim ke petugas '
            'kelurahan untuk diverifikasi.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Periksa Lagi'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Kirim'),
            ),
          ],
        );
      },
    );

    if (!mounted || dikonfirmasi != true) return;

    final sekarang = DateTime.now();
    final pengajuan = Pengajuan(
      nomor: Pengajuan.buatNomor(sekarang),
      layanan: widget.layanan,
      namaPemohon: _nama.text.trim(),
      nik: _nik.text.trim(),
      alamat: _alamat.text.trim(),
      keperluan: _keperluan.text.trim(),
      tanggal: sekarang,
    );

    // Data balikan: objek pengajuan dikirim ke halaman induk.
    Navigator.pop(context, pengajuan);
  }

  String? _validasiTeks(String? nilai, String pesan, {int minimal = 3}) {
    final teks = nilai?.trim() ?? '';
    if (teks.isEmpty) return pesan;
    if (teks.length < minimal) return 'Minimal $minimal karakter.';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Formulir Pengajuan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          children: [
            _kartuLayanan(skema),
            const SizedBox(height: 22),
            const Text(
              'Data Pemohon',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _nama,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Nama lengkap',
                hintText: 'Sesuai KTP',
              ),
              validator: (nilai) =>
                  _validasiTeks(nilai, 'Nama lengkap wajib diisi.'),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _nik,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
              ],
              decoration: const InputDecoration(
                labelText: 'NIK',
                hintText: '16 digit angka',
                counterText: '',
              ),
              maxLength: 16,
              validator: (nilai) {
                final teks = nilai?.trim() ?? '';
                if (teks.isEmpty) return 'NIK wajib diisi.';
                if (teks.length != 16) return 'NIK harus terdiri dari 16 digit.';
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _alamat,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Alamat lengkap',
                hintText: 'Jalan, nomor rumah, RT/RW',
                alignLabelWithHint: true,
              ),
              validator: (nilai) => _validasiTeks(
                nilai,
                'Alamat wajib diisi.',
                minimal: 10,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Detail Keperluan',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _keperluan,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 4,
              maxLength: 250,
              decoration: const InputDecoration(
                labelText: 'Keperluan pengajuan',
                hintText: 'Contoh: syarat pendaftaran sekolah anak',
                alignLabelWithHint: true,
              ),
              validator: (nilai) => _validasiTeks(
                nilai,
                'Keperluan wajib diisi.',
                minimal: 5,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: skema.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, size: 17, color: skema.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Nomor pengajuan dibuat otomatis setelah formulir '
                      'dikirim. Bawa dokumen asli ke loket kelurahan saat '
                      'mengambil surat.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.45,
                        color: Colors.blueGrey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _kirimPengajuan,
              icon: const Icon(Icons.send_outlined, size: 18),
              label: const Text('Kirim Pengajuan'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Batal'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kartuLayanan(ColorScheme skema) {
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
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: skema.primary.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.layanan.ikon,
                  color: skema.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.layanan.nama,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 12,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Estimasi ${widget.layanan.estimasi}',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.layanan.deskripsi,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.45,
              color: Colors.grey.shade700,
            ),
          ),
          const Divider(height: 24),
          Text(
            'Dokumen yang perlu disiapkan:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 6),
          ...widget.layanan.syarat.map(
            (syarat) => Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 14,
                    color: skema.primary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      syarat,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
