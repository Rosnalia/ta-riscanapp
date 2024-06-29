import 'dart:io';
import 'package:flutter/material.dart';
import 'package:riscan/database_helper.dart';
// import 'camerapage.dart';

class RiwayatDeteksiPage extends StatefulWidget {
  const RiwayatDeteksiPage({Key? key}) : super(key: key);

  @override
  _RiwayatDeteksiPageState createState() => _RiwayatDeteksiPageState();
}

class _RiwayatDeteksiPageState extends State<RiwayatDeteksiPage> {
  List<Map<String, dynamic>> myData = [];
  bool _isLoading = true; //memuat hasil scan

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() async {
    var dbHelper = DatabaseHelper(); // Membuat instance dari DatabaseHelper
    final data = await dbHelper.getData('Kualitas'); // Menggunakan instance untuk memanggil getData
    setState(() {
      myData = data;
      _isLoading = false;
    });
    debugPrint('Data refreshed: $myData'); //data dimuat ulang
  }

  void deleteItem(int id) async {
    var dbHelper = DatabaseHelper(); // Membuat instance dari DatabaseHelper
    await dbHelper.deleteData('Kualitas', id); // Menggunakan instance untuk memanggil deleteData
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('berhasil dihapus!'),
      backgroundColor: Color.fromARGB(255, 149, 201, 185),
    ));
    _refreshData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold( //struktur dasar untuk layar, termasuk AppBar, Drawer, FloatingActionButton, dan area body.
      //Jika _isLoading bernilai true, maka CircularProgressIndicator akan ditampilkan di tengah layar, menunjukkan bahwa data sedang dimuat.
      body: _isLoading //body yang digunakan untuk menampilkan konten.
      //Jika _isLoading bernilai false dan myData kosong, 
      //maka teks "Riwayat Kosong!" akan ditampilkan di tengah layar, menunjukkan bahwa tidak ada data yang tersedia.
          ? const Center(child: CircularProgressIndicator())
          : myData.isEmpty
              ? const Center(child: Text("Belum ada riwayat"))
              : ListView.builder(
                  itemCount: myData.length, //menentukan jumlah item dalam daftar, diatur sesuai panjang myData
                  itemBuilder: (context, index) => Card( //membangun setiap item dalam daftar.
                    //Mengatur warna latar belakang Card bergantian antara putih dan warna lain berdasarkan indeks item.
                    color: index % 2 == 0 ? Colors.white : Color.fromARGB(255, 149, 201, 185),
                    //setiap Card sebesar 15 piksel di semua sisi.
                    margin: const EdgeInsets.all(15),
                    child: ListTile(
                      leading: myData[index]['imagePath'] != null
                          ? Image.file(File(myData[index]['imagePath']))
                          : null,
                      title: Text(myData[index]['nama'] ?? ''),
                      subtitle: Text(myData[index]['keterangan'] ?? ''),
                      //Menampilkan tombol IconButton dengan ikon delete. 
                      //Saat tombol ditekan, memanggil fungsi deleteItem dengan ID item yang akan dihapus.
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteItem(myData[index]['id']),
                      ),
                    ),
                  ),
                ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (_) => const CameraPage(),
      //     ),
      //   ).then((_) => _refreshData()),
      // ),
    );
  }
}