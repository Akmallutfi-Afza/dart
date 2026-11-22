import 'package:material_ui/material_ui.dart';

import 'screens/halaman_lapor_pju.dart';

void main() {
  runApp(const AplikasiLaporPju());
}

class AplikasiLaporPju extends StatelessWidget {
  const AplikasiLaporPju({super.key});

  static const Color warnaUtama = Color(0xFF1D4ED8);

  @override
  Widget build(BuildContext context) {
    final skema = ColorScheme.fromSeed(seedColor: warnaUtama);

    return MaterialApp(
      title: 'SILAPJU - Lapor Lampu Jalan Kota Bandung',
      debugShowCheckedModeBanner: false,
      locale: const Locale('id'),
      supportedLocales: const [Locale('id'), Locale('en')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: skema,
        scaffoldBackgroundColor: const Color(0xFFF3F6FC),
        appBarTheme: AppBarThemeData(
          backgroundColor: warnaUtama,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Colors.white,
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
            borderSide: const BorderSide(color: Color(0xFFD7E0EF)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD7E0EF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: warnaUtama, width: 1.6),
          ),
          hintStyle: const TextStyle(
            color: Color(0xFF8A94A6),
            fontSize: 13.5,
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
      home: const HalamanLaporPju(),
    );
  }
}
