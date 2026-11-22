import 'package:flutter/material.dart';

import 'models/item_penjualan.dart';

class HalamanDetailItem extends StatefulWidget {
  final ItemPenjualan item;

  HalamanDetailItem({required this.item});

  @override
  State<HalamanDetailItem> createState() {
    return _HalamanDetailItemState();
  }
}

class _HalamanDetailItemState extends State<HalamanDetailItem> {
  // Simpulan SOAL 4:
  // Banner dibangun dengan BoxDecoration (radius 12 dan latar indigo muda)
  // serta Image.asset dengan BoxFit.contain agar proporsi foto tetap utuh.
  // errorBuilder mencegah red screen ketika aset gagal dimuat dengan
  // menampilkan Icon(Icons.image_outlined) sebagai fallback, yaitu bentuk
  // graceful degradation pada antarmuka.
  Widget buildProductBanner(String foto) {
    return Container(
      height: 180,
      width: double.infinity,
      padding: EdgeInsets.all(12),

      // TODO 10: Terapkan BoxDecoration dengan borderRadius 12
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      // TODO 11: Muat gambar foto dengan fit BoxFit.contain
      child: Image.asset(
        foto,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            // TODO 12: Pasang ikon image_outlined jika aset gambar gagal dimuat
            child: Icon(Icons.image_outlined, size: 64, color: Colors.indigo),
          );
        },
      ),
    );

  }

  // Simpulan SOAL 5:
  // Navigator.pop(context) melepas dan menghancurkan rute teratas sehingga
  // HalamanDashboard di bawahnya kembali aktif. Ini pasangan wajib dari
  // Navigator.push() pada SOAL 3: tanpa pop, tumpukan rute terus bertambah
  // dan berpotensi menimbulkan memory leak.
  void navigasiKembali() {
    // TODO 13: Tutup halaman detail dan kembali ke rute sebelumnya dengan Navigator.pop
    Navigator.pop(context);
  }

  // Simpulan SOAL 6:
  // Validasi stok > 0 mencegah transaksi menghasilkan stok negatif, lalu
  // setState() menurunkan stok satu unit sehingga tampilan langsung
  // diperbarui lewat build() ulang. Navigator.pop(context, payload) menutup
  // halaman sekaligus memulangkan bukti transaksi ke dashboard. Tombol juga
  // diberi onPressed null saat stok habis, jadi validasi berjalan di dua
  // lapis: tampilan dan logika.
  void prosesPenjualan() {
    // TODO 14: Cek kondisi apakah stok item masih lebih besar dari 0
    if (widget.item.stok > 0) {
      setState(() {
        // TODO 15: Kurangi stok sebanyak 1 unit di dalam setState
        widget.item.stok -= 1;
      });
      // TODO 16: Pulangkan data bukti transaksi dengan Navigator.pop
      Navigator.pop(
        context,
        'Terjual 1 unit ${widget.item.nama} (Rp ${widget.item.harga})',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Produk Penjualan')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProductBanner(widget.item.foto),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.nama,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Chip(
                      label: Text(widget.item.kategori),
                      backgroundColor: Colors.indigo.shade50,
                    ),
                    Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Harga Satuan:', style: TextStyle(fontSize: 15)),
                        Text(
                          'Rp ${widget.item.harga}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Stok Tersedia:', style: TextStyle(fontSize: 15)),
                        Text(
                          '${widget.item.stok} unit',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: widget.item.stok > 0
                                ? Colors.black87
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Deskripsi Produk:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.item.deskripsi,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: navigasiKembali,
                    child: Text('Kembali'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.item.stok > 0 ? prosesPenjualan : null,
                    child: Text(
                      widget.item.stok > 0 ? 'Catat Penjualan' : 'Stok Habis',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
