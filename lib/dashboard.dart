import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  final List<Map<String, String>> items = [
    {'image': 'assets/berita1.jpeg', 'title': 'Pengoplos Beras Berjamur Jadi Premium di Serang Raup Untung Rp 723 Juta', 
    'description': 'Pelaku mendapatkan untung Rp 2.500 sampai Rp 3.000 dari mengoplos beras tidak layak konsumsi dengan beras Bulog.'},
    {'image': 'assets/berita2.jpeg', 'title': 'Gudang Beras Oplosan di Sumenep Digerebek, Dijual dengan Merek Super', 
    'description': 'Polisi menemukan truk bermuatan 10 ton beras oplosan di Sumenep.'},
    {'image': 'assets/berita3.jpg', 'title': 'Oplos Beras dari Bulog Jadi Berkemasan Premium, 2 Orang Ditangkap', 
    'description': 'Polisi menangkap dua orang yang mengoplos beras bersubsidi dari Bulog jadi berkemasan premium agar bisa dijual lebih mahal'},
    {'image': 'assets/berita4.jpg', 'title': 'Mengenal Oplos Beras, Salah Satu Modus Umum Mafia Beras', 'description': 'Gudang PT Food Station Tjipinang Jaya, Jakarta Timur pada Jumat, 3 Februari 2022, Buwas menduga ada beberapa pedagang yang mengemas ulang beras Bulog dan menjualnya di atas batas harga eceran tertinggi.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berita'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            // onTap: () {
            //   // Navigasi berdasarkan item yang dipilih
            //   if (items[index]['title'] == 'Berita') {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const NewsPage()),
            //     );
            //   } else if (items[index]['title'] == 'Informasi') {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const InfoPage()),
            //     );
            //   }
            //   // Tambahkan kondisi lain jika perlu
            // },
            child: Container(
              margin: EdgeInsets.only(bottom: 20.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    items[index]['image']!,
                    height: 80.0,
                    width: 80.0,
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          items[index]['title']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          items[index]['description']!,
                          style: TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}