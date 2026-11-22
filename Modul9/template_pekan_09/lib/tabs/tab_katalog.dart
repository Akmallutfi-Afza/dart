import 'package:flutter/material.dart';

import '../models/item_penjualan.dart';

class TabKatalog extends StatelessWidget {
  final List<ItemPenjualan> daftarItem;
  final Function(ItemPenjualan) onPilihItem;

  TabKatalog({required this.daftarItem, required this.onPilihItem});

  // Simpulan SOAL 2:
  // Card bersifat statis, sehingga dibungkus InkWell yang menyediakan callback
  // onTap untuk memanggil onPilihItem(item). Widget anak tidak tahu proses
  // selanjutnya; ia hanya meneruskan objek item ke induk (callback injection).
  // Gambar memakai BoxFit.contain agar tidak terpotong, sedangkan nama dan
  // harga dirender dari properti model sehingga satu fungsi ini dapat dipakai
  // ulang oleh GridView.builder untuk seluruh item.
  // Catatan: return SizedBox() di akhir fungsi tidak pernah tercapai.
  Widget buildProductCard(ItemPenjualan item) {
    // TODO 5: Panggil fungsi callback onPilihItem dengan membawa parameter item
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onPilihItem(item);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.indigo.shade50,
                width: double.infinity,
                // TODO 6: Tampilkan gambar produk dari properti item.foto
                child: Image.asset(item.foto, fit: BoxFit.contain),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO 7: Tampilkan teks nama produk dari properti item.nama
                  Text(
                    item.nama,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Rp ${item.harga}',
                    style: TextStyle(color: Colors.green.shade700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemCount: daftarItem.length,
      itemBuilder: (context, index) {
        return buildProductCard(daftarItem[index]);
      },
    );
  }
}
