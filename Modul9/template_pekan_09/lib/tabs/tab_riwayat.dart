import 'package:flutter/material.dart';

class TabRiwayat extends StatelessWidget {
  final List<String> riwayatTransaksi;

  TabRiwayat({required this.riwayatTransaksi});

  // Simpulan SOAL 8:
  // Satu baris riwayat dirender dengan Card + ListTile: CircleAvatar berisi
  // Icon(Icons.check) sebagai penanda transaksi berhasil, title menampilkan
  // deskripsi transaksi, dan subtitle menampilkan nomor urut. Nomor dihitung
  // sebagai length - index agar transaksi terbaru (indeks 0) mendapat nomor
  // terbesar sesuai urutan kejadian.
  // Catatan: return SizedBox() di akhir fungsi tidak pernah tercapai.
  Widget buildRiwayatItem(String dataTransaksi, int noUrut) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          foregroundColor: Colors.green.shade800,
          // TODO 21: Tampilkan ikon centang check pada CircleAvatar
          child: Icon(Icons.check),
        ),
        // TODO 22: Tampilkan string dataTransaksi pada title ListTile
        title: Text(dataTransaksi),
        // TODO 23: Tampilkan nomor urut noUrut pada subtitle ListTile
        subtitle: Text('Transaksi #$noUrut'),
      ),
    );

    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    if (riwayatTransaksi.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 72,
                color: Colors.grey.shade400,
              ),
              SizedBox(height: 16),
              Text(
                'Belum Ada Riwayat Transaksi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Pilih produk dari tab Katalog untuk mencatat penjualan.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: riwayatTransaksi.length,
      itemBuilder: (context, index) {
        // TODO 24: Kirim nomor urut transaksi ke buildRiwayatItem
        return buildRiwayatItem(
          riwayatTransaksi[index],
          riwayatTransaksi.length - index,
        );
      },
    );
  }
}
