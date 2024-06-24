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
      body: Container(
        color: Colors.white,
        child: Center(
          child: SizedBox(
            //kelas di Flutter yang menyediakan informasi mengenai ukuran layar, resolusi, orientasi, dan pengaturan terkait lainnya.
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Image.asset(
              "assets/logoriscan.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
