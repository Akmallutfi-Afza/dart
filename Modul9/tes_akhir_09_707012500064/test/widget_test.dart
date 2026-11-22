import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:tes_akhir_09_707012500064/main.dart';

/// Layar uji diperbesar agar seluruh isi formulir ikut ter-render.
Future<void> _bukaAplikasi(WidgetTester tester) async {
  tester.view.physicalSize = const Size(430, 1600);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(const AplikasiLayananWarga());
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Beranda menampilkan tiga tab dan daftar layanan', (tester) async {
    await _bukaAplikasi(tester);

    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(
      find.descendant(of: find.byType(AppBar), matching: find.text('Beranda')),
      findsOneWidget,
    );
    expect(find.text('Layanan Administrasi'), findsOneWidget);
    expect(find.text('Surat Pengantar Domisili'), findsOneWidget);
  });

  testWidgets('Formulir menerima data layanan lewat constructor',
      (tester) async {
    await _bukaAplikasi(tester);

    await tester.tap(find.text('Surat Pengantar Domisili'));
    await tester.pumpAndSettle();

    expect(find.text('Formulir Pengajuan'), findsOneWidget);
    expect(find.text('Dokumen yang perlu disiapkan:'), findsOneWidget);
    expect(find.text('Data Pemohon'), findsOneWidget);
  });

  testWidgets('Data balikan formulir masuk ke tab Riwayat', (tester) async {
    await _bukaAplikasi(tester);

    await tester.tap(find.text('Surat Pengantar Domisili'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nama lengkap'),
      'Akmallutfi Afza Gusty',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'NIK'),
      '3273012508040001',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Alamat lengkap'),
      'Jl. Sukajadi No. 21, Bandung',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Keperluan pengajuan'),
      'Syarat pendaftaran sekolah anak',
    );

    await tester.ensureVisible(find.text('Kirim Pengajuan'));
    await tester.tap(find.text('Kirim Pengajuan'));
    await tester.pumpAndSettle();

    expect(find.text('Kirim pengajuan?'), findsOneWidget);

    await tester.tap(find.text('Kirim'));
    await tester.pumpAndSettle();

    // Halaman kembali ke dashboard, berpindah ke tab Riwayat, dan data
    // balikan sudah tersimpan.
    expect(find.text('Riwayat Pengajuan'), findsOneWidget);
    expect(find.textContaining('berhasil dikirim'), findsOneWidget);
    expect(find.text('Menunggu Verifikasi'), findsOneWidget);
    expect(find.text('1 pengajuan'), findsOneWidget);
  });
}
