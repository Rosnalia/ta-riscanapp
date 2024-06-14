import 'package:flutter/material.dart';

class TidakPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              'assets/tid.png',  // Ganti dengan path gambar
              height: 20.0,        // Atur tinggi gambar
              fit: BoxFit.cover,   // Mengatur penempatan gambar
            ),
            SizedBox(width: 10),   // Memberikan jarak antara gambar dan teks
            Text(
              'Beras Tidak Layak Konsumsi',
              style: TextStyle(
                color: Color(0xFF1C110A),  // Atur warna teks sesuai kebutuhan
                fontSize: 15.0,       // Atur ukuran teks sesuai kebutuhan
              ),
            ),
          ],
        ),
        centerTitle: false,
        elevation: 0, // Menghilangkan shadow default
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey, // Warna garis bawah
              height: 1.0,
            ),
          ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/tidak1.jpg',  // Ganti dengan path gambar
                height: 200.0,           // Atur tinggi gambar
                fit: BoxFit.cover,       // Mengatur penempatan gambar
              ),
            ),
            SizedBox(height: 20),  // Memberikan jarak antara gambar dan teks
            Text(
              'Beras Tidak Layak Konsumsi',
              style: TextStyle(
                fontSize: 20.0,     // Atur ukuran teks sesuai kebutuhan
                fontWeight: FontWeight.bold,  // Atur ketebalan teks
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Merangkum dari Bobo.grid.id, ini dia ciri-ciri beras yang tidak layak konsumsi.',
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '1. Salah satu ciri beras tidak layak pakai adalah yang mengeluarkan bau apek. Bau apek bisa jadi muncul karena beras sebelumnya disimpan dengan cara yang salah atau bisa jadi beras sudah mulai berjamur.',
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '2. Harus berhati-hati kalau melihat warna beras yang terlalu putih. bisa jadi beras tersebut sudah dicampur dengan pemutih. Banyak pedagang nakal yang memutihkan beras supaya terlihat lebih menarik. Padahal pemutih beras bisa sebabkan banyak penyakit berbahaya. Salah satunya adalah kanker.',
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '3. Beras yang mudah remuk saat dipegang bisa jadi sudah tidak layak konsumsi. Biasanya, beras yang sudah seperti ini sudah rapuh dan hampir busuk. Beras yang rapuh dan busuk lama-kelamaan bisa jadi bubuk-bubuk halus jika diremas',
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Sumber : bobo.grid.id',
              style: TextStyle(
                fontSize: 8.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
