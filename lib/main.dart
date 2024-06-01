import 'package:flutter/material.dart';
import 'package:riscan/dashboard.dart';
import 'package:riscan/riwayatpage.dart';
import 'package:riscan/splashscreen.dart';
import 'package:riscan/camerapage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    CameraPage(),
    RiwayatDeteksiPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
        AppBar(
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/logoriscan.png',  // Ganti dengan path gambar Anda
            height: 100.0,       // Atur tinggi gambar
            fit: BoxFit.cover,  // Mengatur penempatan gambar
          ),
        centerTitle: false,
        ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
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