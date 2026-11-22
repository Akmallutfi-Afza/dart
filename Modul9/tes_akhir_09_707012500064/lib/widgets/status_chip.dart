import 'package:material_ui/material_ui.dart';

class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final MaterialColor warna;
    final IconData ikon;

    if (status == 'Selesai') {
      warna = Colors.green;
      ikon = Icons.check_circle_outline;
    } else if (status == 'Diverifikasi') {
      warna = Colors.blue;
      ikon = Icons.verified_outlined;
    } else {
      warna = Colors.orange;
      ikon = Icons.hourglass_top;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: warna.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(ikon, size: 13, color: warna),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: warna.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
