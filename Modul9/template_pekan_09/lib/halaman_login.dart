import 'package:flutter/material.dart';

import 'halaman_dashboard.dart';

class HalamanLogin extends StatefulWidget {
  @override
  State<HalamanLogin> createState() {
    return _HalamanLoginState();
  }
}

class _HalamanLoginState extends State<HalamanLogin> {
  final TextEditingController namaController = TextEditingController(
    text: 'Budi',
  );

  // Simpulan SOAL 1:
  // Callback onPressed pada tombol menjalankan fungsi ini sebagai bagian dari
  // siklus event handling (user action -> event listener -> callback ->
  // system reaction). Teks kasir diambil dari controller lalu di-trim, dan
  // diberi nilai default 'Kasir Bandung' bila kosong sehingga data yang
  // dikirim tidak pernah kosong. Pengiriman data memakai forward passing
  // melalui constructor injection (namaPengguna) yang aman secara tipe
  // (compile-time type safety).
  // Catatan: TODO 3 meminta method navigasi pengganti rute, sehingga
  // Navigator.pushReplacement() lebih tepat daripada Navigator.push() agar
  // halaman login tidak tertinggal di navigation stack.
  void prosesLogin() {
    // TODO 1: Ambil teks nama kasir dari controller dan hilangkan spasi

    String nama = namaController.text.trim();

    // TODO 2: Cek kondisi jika nama kosong berikan nilai default 'Kasir Bandung'

    if (nama.isEmpty) {
      nama = 'Kasir Bandung';
    }
    // TODO 3: Tentukan method navigasi pengganti rute pada Navigator

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          // TODO 4: Kirimkan argumen variabel nama ke parameter namaPengguna
          return HalamanDashboard(namaPengguna: nama);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Kasir Toko'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.storefront, size: 80, color: Colors.indigo),
              SizedBox(height: 16),
              Text(
                'Selamat Datang',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                'Sentra UMKM Kota Bandung',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              SizedBox(height: 32),
              TextField(
                controller: namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Kasir / Pengguna',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: prosesLogin,
                icon: Icon(Icons.login),
                label: Text('Masuk ke Dashboard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
