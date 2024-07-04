import 'package:flutter/material.dart';

class PremiumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              'assets/prem.png',  // Ganti dengan path gambar
              height: 20.0,        // Atur tinggi gambar
              fit: BoxFit.cover,   // Mengatur penempatan gambar
            ),
            SizedBox(width: 10),   // Memberikan jarak antara gambar dan teks
            Text(
              'Beras Premium',
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
                'assets/premium1.jpeg',  // Ganti dengan path gambar
                height: 200.0,           // Atur tinggi gambar
                fit: BoxFit.cover,       // Mengatur penempatan gambar
              ),
            ),
            SizedBox(height: 20),  // Memberikan jarak antara gambar dan teks
            Text(
              'Beras Premium',
              style: TextStyle(
                fontSize: 20.0,     // Atur ukuran teks sesuai kebutuhan
                fontWeight: FontWeight.bold,  // Atur ketebalan teks
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Beras Premium merupakan beras mutu terbaik. Saat kita memakan beras medium dan premium sejatinya kita memakan nasi dengan kandungan gizi utama yang sama. Perbedaan utama kedua kelas beras tersebut hanyalah pada kualitas tampilan beras (utuh dan patah), derajat sosoh keberadaan cemaran seperti butir merah, butir kuning, dan benda asing lainnya. Beras dengan persentase beras kepala (butir hampir utuh hingga utuh) >95% dan derajat sosoh 100% kita sebut beras premium, sedangkan beras dengan persentase beras kepala <95% kita sebut beras medium. Untuk lebih jelasnya dapat dilihat pada tabel SNI 6128:2020 berikut.',
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
              'Untuk mengantisipasi beras oplosan dengan harga yang tidak wajar, berikut merupakan rekomendasi merek beras premium, produk-produk ini diurutkan secara mandiri oleh mybest berdasarkan hasil riset pada beberapa website dan review (diperbarui tanggal 14 Januari 2024).',
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 20),  // Memberikan jarak antara teks dan gambar
            Image.asset(
              'assets/beras-prem-list.png',  // Ganti dengan path gambar 
              height: 900.0,    // Atur tinggi gambar
              fit: BoxFit.cover, // Mengatur penempatan gambar
            ),
            SizedBox(height: 50),
            Text(
              'Sumber : mybest.com dan SNI 6128:2020',
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
