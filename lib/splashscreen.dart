import 'dart:async';
import 'package:flutter/material.dart';
import 'package:riscan/main.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Setelah beberapa detik (misalnya, 3 detik), pindah ke halaman berikutnya
    Timer(Duration(seconds: 3), () {
      // Ganti halaman ke halaman utama aplikasi
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Tampilan splash screen dengan gambar
      body: Container( // Menggunakan Container untuk menambahkan warna latar belakang
      color: Colors.green, // Ganti warna latar belakang di sini
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Image.asset("assets/logo.png", fit:BoxFit.cover),             
            ),
          ),
        ],
      ),)
    );
  }
}
