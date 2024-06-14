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
              'Beras Tidak',
              style: TextStyle(
                fontSize: 20.0,     // Atur ukuran teks sesuai kebutuhan
                fontWeight: FontWeight.bold,  // Atur ketebalan teks
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Beras Tidak sering kita jumpai di pasaran. Contoh beras Tidak yang sering kita jumpai diantaranya Beras Cap Kembang dan Beras Tidak SPHP Bulog.',
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Menurut SNI 6128:202 beras Tidak memiliki ciri-ciri seperti tabel berikut:',
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 20),  // Memberikan jarak antara teks dan gambar
            Image.asset(
              'assets/sni.png',  // Ganti dengan path gambar 
              height: 150.0,     // Atur tinggi gambar
              fit: BoxFit.cover, // Mengatur penempatan gambar
            ),
            SizedBox(height: 20),
            Text(
              'Dikutip dari Yogyaonline.co.id, kekuatan beras dengan kualitas Tidak cenderung jauh lebih rapuh dibandingkan dengan beras bekualitas premium. Selain itu, beras Tidak memiliki warna yang lebih semu (buram) dibandingkan dengan beras premium. Secara kasat mata memang tidak terlalu terlihat. Tapi kalau diperhatikan yang Tidak warnanya lebih semu sedangkan beras premium warnanya lebih terang (putih). Biasanya beras Tidak lebih umum memiliki kotoran-kotoran pada berasnya sehingga kamu harus ekstra dalam membersihkannya. Sementara, beras premium lebih bersih dari kotoran yang menempel.',
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Sumber : yogyaonline.co.id dan SNI 6128:2020',
              style: TextStyle(
                fontSize: 8.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Tambahkan konten tambahan sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}
