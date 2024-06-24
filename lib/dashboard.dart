import 'package:flutter/material.dart';
import 'camerapage.dart';
import 'medium_page.dart';
import 'premium_page.dart';
import 'package:riscan/tidak_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selamat Datang di Riscan!'),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 25,
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: Column( //buat kolom untuk scan disini
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              height: 150.0,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 149, 201, 185),
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
              child: ElevatedButton( //tombol pindah ke page scan
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () { //tekan
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CameraPage()), //pindah ke scan
                  );
                },
                child: const Text(
                  "SCAN DISINI",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView( //daftar tombol halaman premium, medium, tidak layak
              padding: const EdgeInsets.all(16.0),
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
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
                  child: ListTile(
                    leading: Image.asset('assets/prem.png', height: 40, width: 40), //gambar premium dan size nya
                    title: const Text('Premium'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PremiumPage()), //pindah ke halaman premium
                      );
                    },
                  ),
                ),
                Container( //box tombol medium
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
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
                  child: ListTile(
                    leading: Image.asset('assets/med.png', height: 40, width: 40), //gambar dan size medium
                    title: const Text('Medium'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MediumPage()), //pindah ke halaman medium
                      );
                    },
                  ),
                ),
                Container( //box kontainer tidak layak
                //digunakan untuk membuat padding atau margin yang simetris secara horizontal dan/atau vertikal.
                  margin: const EdgeInsets.symmetric(vertical: 8.0), 
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
                  child: ListTile( //listtile:bagian dari listview
                    leading: Image.asset('assets/tid.png', height: 40, width: 40),
                    title: const Text('Tidak Layak'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TidakPage()), //pindag ke halaman tidak layak
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
