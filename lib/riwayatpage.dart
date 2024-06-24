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
  bool _isLoading = true;

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
    debugPrint('Data refreshed: $myData');
  }

  void deleteItem(int id) async {
    var dbHelper = DatabaseHelper(); // Membuat instance dari DatabaseHelper
    await dbHelper.deleteData('Kualitas', id); // Menggunakan instance untuk memanggil deleteData
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted!'),
      backgroundColor: Color.fromARGB(255, 149, 201, 185),
    ));
    _refreshData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : myData.isEmpty
              ? const Center(child: Text("No Data Available!!!"))
              : ListView.builder(
                  itemCount: myData.length,
                  itemBuilder: (context, index) => Card(
                    color: index % 2 == 0 ? Colors.white : Color.fromARGB(255, 149, 201, 185),
                    margin: const EdgeInsets.all(15),
                    child: ListTile(
                      leading: myData[index]['imagePath'] != null
                          ? Image.file(File(myData[index]['imagePath']))
                          : null,
                      title: Text(myData[index]['nama'] ?? ''),
                      subtitle: Text(myData[index]['keterangan'] ?? ''),
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