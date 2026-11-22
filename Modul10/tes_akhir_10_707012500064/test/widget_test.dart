import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:tes_akhir_10_707012500064/main.dart';

void main() {
  testWidgets('Halaman beranda menampilkan formulir aduan', (tester) async {
    await tester.pumpWidget(const AplikasiLaporPju());

    expect(find.text('SILAPJU'), findsOneWidget);
    expect(find.text('Formulir Aduan'), findsOneWidget);
    expect(find.text('Kirim Aduan'), findsOneWidget);
  });
}
