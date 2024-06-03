import 'package:flutter/material.dart';
import 'camerapage.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> items = [
    {
      'image': 'assets/berita1.jpeg',
      'title': 'Pengoplos Beras Berjamur Jadi Premium di Serang Raup Untung Rp 723 Juta',
      'description': 'Pelaku mendapatkan untung Rp 2.500 sampai Rp 3.000 dari mengoplos beras tidak layak konsumsi dengan beras Bulog.'
    },
    {
      'image': 'assets/berita2.jpeg',
      'title': 'Gudang Beras Oplosan di Sumenep Digerebek, Dijual dengan Merek Super',
      'description': 'Polisi menemukan truk bermuatan 10 ton beras oplosan di Sumenep.'
    },
    {
      'image': 'assets/berita3.jpg',
      'title': 'Oplos Beras dari Bulog Jadi Berkemasan Premium, 2 Orang Ditangkap',
      'description': 'Polisi menangkap dua orang yang mengoplos beras bersubsidi dari Bulog jadi berkemasan premium agar bisa dijual lebih mahal'
    },
    {
      'image': 'assets/berita4.jpg',
      'title': 'Mengenal Oplos Beras, Salah Satu Modus Umum Mafia Beras',
      'description': 'Gudang PT Food Station Tjipinang Jaya, Jakarta Timur pada Jumat, 3 Februari 2022, Buwas menduga ada beberapa pedagang yang mengemas ulang beras Bulog dan menjualnya di atas batas harga eceran tertinggi.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Berita'),
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,  // Make the button full width
              height: 150.0,  // Set the height of the button
              decoration: BoxDecoration(
                color: const Color.fromRGBO(248, 179, 102, 1),  // Change the background color of the container
                borderRadius: BorderRadius.circular(10.0),  // Add rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),  // changes position of shadow
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,  // Make the button background transparent
                  shadowColor: Colors.transparent,  // Remove button's own shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  // Navigasi ke halaman CameraPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CameraPage()),
                  );
                },
                child: const Text(
                  "SCAN HERE",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,  // Increase the font size
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.asset('assets/rice1.png', height: 50, width: 50),
                      const Text('Premium'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Image.asset('assets/rice2.png', height: 50, width: 50),
                      const Text('Medium'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Image.asset('assets/rice3.png', height: 50, width: 50),
                      const Text('Tidak Layak'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
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
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                items[index]['description']!,
                                style: const TextStyle(fontSize: 8),
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
          ),
        ],
      ),
    );
  }
}
