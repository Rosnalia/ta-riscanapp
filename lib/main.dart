import 'package:flutter/material.dart';
import 'package:riscan/dashboard.dart';
import 'package:riscan/riwayatpage.dart';
import 'package:riscan/splashscreen.dart';
import 'package:riscan/camerapage.dart';
import 'medium_page.dart';
import 'premium_page.dart';
import 'tidak_page.dart';

//running aplikasi
void main() {
  runApp(MyApp());
}

//stateless widget : tidak berubah
//statefull widget : berubah selama apliakasi berjalan
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( //menampilkan material dari google : navigasi, tema, dll
      theme: ThemeData( //tema aplikasi
        primarySwatch: Colors.blue, //warna
      ),
      home: SplashScreen(), // tampilan awal splashscreen
    );
  }
}

//Stateless Widget dapat dikatakan sebagai widget statis yang berarti widget tersebut tidak berubah.
//Stateful Widget merupakan widget yang dinamis. Ini berarti widget ini dapat merubah tampilannya 
//sesuai response dari events yang dipicu baik dari interaksi user maupun adanya variabel atau nilai baru yang didapat.
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState(); 
  //createstate : digunakan untuk membuat dan mengembalikan instance dari kelas state yang terkait dengan widget ini.
}

// int _selectedIndex = 0; --> digunakan untuk menyimpan status atau indeks dari item yang dipilih saat ini dalam 
//sebuah widget yang dapat memiliki beberapa pilihan, seperti BottomNavigationBar, ListView, atau TabBar.
class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [ //list halaman yang dipanggil
    HomePage(),
    CameraPage(),
    RiwayatDeteksiPage(),
    PremiumPage(),
    MediumPage(),
    TidakPage(),
  ];

  //tap salah satu navbar akan muncul UI sesuai navbar yang dipilih
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) { //build : membangun/membuat
    return Scaffold(
      appBar: 
        AppBar(
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/logoriscan.png',  //gambar 
            height: 100.0,       //tinggi gambar
            fit: BoxFit.cover,  //penempatan gambar
          ),
        centerTitle: false, //teks tidak ditengah
        elevation: 0, // Menghilangkan shadow default
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Container( //kotak kontainer
              color: Colors.grey, // Warna garis bawah
              height: 1.0, //tinggi kontainer
            ),
          ),
        ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar( //navbar
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}