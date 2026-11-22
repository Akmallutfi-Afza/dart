import 'package:material_ui/material_ui.dart';

import 'halaman_detail_pengajuan.dart';
import 'halaman_utama.dart';
import 'models/pengajuan.dart';

void main() {
  runApp(const AplikasiLayananWarga());
}

/// Aplikasi SILAYAR (Sistem Layanan Warga) milik Kelurahan Sukajadi.
///
/// Tes Akhir Praktikum DPPB Pekan 9:
/// - navigasi utama berbasis tab (BottomNavigationBar),
/// - navigasi antar halaman dengan pengiriman data lewat constructor,
/// - pengembalian data dari halaman formulir ke halaman induk.
class AplikasiLayananWarga extends StatelessWidget {
  const AplikasiLayananWarga({super.key});

  static const Color warnaUtama = Color(0xFF0B5D8C);

  @override
  Widget build(BuildContext context) {
    final skema = ColorScheme.fromSeed(seedColor: warnaUtama);

    return MaterialApp(
      title: 'SILAYAR - Layanan Warga Kelurahan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: skema,
        scaffoldBackgroundColor: const Color(0xFFF4F7FA),
        appBarTheme: AppBarThemeData(
          backgroundColor: Colors.white,
          foregroundColor: skema.onSurface,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 2,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: skema.onSurface,
          ),
        ),
        inputDecorationTheme: InputDecorationThemeData(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD8E0E8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD8E0E8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: skema.primary, width: 1.6),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: skema.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: skema.error, width: 1.6),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size(64, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      home: const HalamanUtama(),
      // Halaman detail dibuka dengan Navigator.pushNamed() dan menerima
      // objek Pengajuan melalui `arguments` (argument passing).
      routes: {
        HalamanDetailPengajuan.rute: (context) {
          final argumen = ModalRoute.of(context)!.settings.arguments;
          return HalamanDetailPengajuan(pengajuan: argumen as Pengajuan);
        },
      },
    );
  }
}
