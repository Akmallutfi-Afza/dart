import 'package:flutter/material.dart';

import 'models/item_penjualan.dart';
import 'tabs/tab_katalog.dart';
import 'tabs/tab_riwayat.dart';
import 'tabs/tab_profil.dart';
import 'halaman_detail_item.dart';
import 'halaman_login.dart';

class HalamanDashboard extends StatefulWidget {
  final String namaPengguna;

  HalamanDashboard({required this.namaPengguna});

  @override
  State<HalamanDashboard> createState() {
    return _HalamanDashboardState();
  }
}

class _HalamanDashboardState extends State<HalamanDashboard> {
  int indexNavigasi = 0;
  List<String> riwayatTransaksi = [];

  final List<ItemPenjualan> daftarItem = [
    ItemPenjualan(
      nama: 'Kopi Preanger',
      kategori: 'Minuman',
      harga: 35000,
      stok: 12,
      deskripsi: 'Biji kopi arabika Priangan Bandung.',
      foto: 'assets/images/kopi.png',
    ),
    ItemPenjualan(
      nama: 'Keripik Tempe',
      kategori: 'Makanan',
      harga: 15000,
      stok: 25,
      deskripsi: 'Keripik tempe renyah khas Bandung.',
      foto: 'assets/images/tempe.png',
    ),
    ItemPenjualan(
      nama: 'Kaos Pasupati',
      kategori: 'Pakaian',
      harga: 85000,
      stok: 8,
      deskripsi: 'Kaos bergambar ikon jembatan Pasupati Bandung.',
      foto: 'assets/images/kaos.png',
    ),
    ItemPenjualan(
      nama: 'Sepatu Cibaduyut',
      kategori: 'Kerajinan',
      harga: 220000,
      stok: 5,
      deskripsi: 'Sepatu kulit sentra Cibaduyut Bandung.',
      foto: 'assets/images/sepatu.png',
    ),
    ItemPenjualan(
      nama: 'Tas Rajut Binong',
      kategori: 'Kerajinan',
      harga: 135000,
      stok: 10,
      deskripsi: 'Tas rajut perajin Binong Jati Bandung.',
      foto: 'assets/images/tas.png',
    ),
    ItemPenjualan(
      nama: 'Peuyeum Bandung',
      kategori: 'Makanan',
      harga: 20000,
      stok: 30,
      deskripsi: 'Peuyeum fermentasi singkong manis Bandung.',
      foto: 'assets/images/peuyeum.png',
    ),
    ItemPenjualan(
      nama: 'Jaket Denim Gasibu',
      kategori: 'Pakaian',
      harga: 175000,
      stok: 7,
      deskripsi: 'Jaket denim distro Gasibu Bandung.',
      foto: 'assets/images/jaket.png',
    ),
    ItemPenjualan(
      nama: 'Teh Walini',
      kategori: 'Minuman',
      harga: 28000,
      stok: 18,
      deskripsi: 'Teh seduh Ciwidey Priangan Bandung.',
      foto: 'assets/images/teh.png',
    ),
  ];

  // Simpulan SOAL 3:
  // Navigator.push() menumpuk HalamanDetailItem di atas dashboard sesuai
  // prinsip LIFO, sementara objek item disuntikkan lewat constructor (forward
  // passing) agar halaman detail tidak perlu mencari data sendiri. Dashboard
  // tidak dihancurkan, hanya dibekukan di lapisan bawah tumpukan. Fungsi
  // mengembalikan Future<dynamic> dari push agar pemanggil dapat menunggu
  // hasil transaksi secara asinkronus.
  Future<dynamic> navigasiKeDetail(ItemPenjualan item) {
    // TODO 8: Jalankan navigasi tumpukan dengan Navigator.push
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          // TODO 9: Suntikkan objek item ke constructor HalamanDetailItem
          return HalamanDetailItem(item: item);
        },
      ),
    );
  }

  // Simpulan SOAL 7:
  // Ini sisi penerima backward returning result: await menghentikan eksekusi
  // sampai halaman detail ditutup dan mengirim payload balik. Pengecekan
  // hasil != null membedakan penjualan yang berhasil dari penutupan lewat
  // tombol back, lalu transaksi terbaru disisipkan di indeks 0 di dalam
  // setState() supaya tab Riwayat langsung diperbarui.
  void tangkapHasilTransaksi(ItemPenjualan item) async {
    // TODO 18: Tunggu hasil rute secara asinkronus dengan keyword await
    final hasil = await navigasiKeDetail(item);

    // TODO 19: Periksa apakah hasil tidak bernilai null
    if (hasil != null) {
      // TODO 20: Sisipkan hasil ke indeks 0 riwayatTransaksi di dalam setState
      setState(() {
        riwayatTransaksi.insert(0, hasil.toString());
      });
    }
  }

  void logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HalamanLogin();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> halamanTab = [
      TabKatalog(daftarItem: daftarItem, onPilihItem: tangkapHasilTransaksi),
      TabRiwayat(riwayatTransaksi: riwayatTransaksi),
      TabProfil(
        namaPengguna: widget.namaPengguna,
        jumlahProduk: daftarItem.length,
        totalTransaksi: riwayatTransaksi.length,
        onLogout: logout,
      ),
    ];

    List<String> judulTab = [
      'Katalog Produk UMKM',
      'Riwayat Transaksi',
      'Profil Kasir',
    ];

    return Scaffold(
      appBar: AppBar(title: Text(judulTab[indexNavigasi])),
      body: halamanTab[indexNavigasi],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexNavigasi,
        onTap: (index) {
          setState(() {
            indexNavigasi = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Katalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
