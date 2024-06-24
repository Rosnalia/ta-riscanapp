import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite/tflite.dart';
import 'database_helper.dart';

//stateless widget : tidak berubah
//statefull widget : berubah selama apliakasi berjalan
class CameraPage extends StatefulWidget { //Parameter key opsional (nullable)
  const CameraPage({Key? key}) : super(key: key);

  //_CameraPageState mengelola state dan merender UI untuk CameraPage
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _camController; //mengontroll kamera
  // List? _Prediction;
  String? pathDir; //menyimpan directory path dengan tipe data string

  @override
  void initState() {
    super.initState();
    loadModel(); //memuat model dari teachable machine
  }

  Future<String?> loadModel() async {
    String? res = await Tflite.loadModel( //load model menggunakan library tflite
      model: "assets/model.tflite", //memanggil model dari aset
      labels: "assets/label.txt", //memanggil label dari aset
      numThreads: 1, //konfigurasi jumlah threads yang digunakan untuk menjalankan model
      isAsset: true, //meyakinkan sumber daya yg digunakan yaitu dari asset
      useGpuDelegate: false, //tidak menggunakan GPu (Graphics Processing Unit) hanya menggunakan CPU (Central Processing Unit) karena untuk menghemat daya
    );
    return res; //diulang
  }

  Future<void> initCamera() async { //inisialisasi kamera
    var cameras = await availableCameras(); //menunggu kamera ada apa tidak
    _camController = CameraController(cameras[0], ResolutionPreset.high); //mengontrol kamera, resolusi tinggi
    await _camController!.initialize(); //menunggu kamera diinisialisasi
  }

  Future<String> takePicture() async { //ambil gambar kamera
    Directory root = await getTemporaryDirectory(); //mendapatkan directory
    String dir = "${root.path}/BERAS"; //path yg digunakan beras
    await Directory(dir).create(recursive: true); //menunggu directory dibuat
    String filePath = "$dir/${DateTime.now()}.jpg"; //filepath format jpg
    try {
      XFile? img = await _camController!.takePicture(); //ambil gambar kamera
      await img.saveTo(filePath); //gambar disimpan ke path
    } catch (e) {
      log("Error : ${e.toString()}");
    }
    return filePath;
  }

  Future<void> pickImageFromGallery() async { //ambil gambar dari galeri
    final picker = ImagePicker(); //gambar dipilih
    final pickedFile = await picker.pickImage(source: ImageSource.gallery); //menunggu gambar dari galeri dipilih
    if (pickedFile != null) { //jika file dipilih
      pathDir = pickedFile.path; //masuk path
      log("Image picked: $pathDir"); //memanggil file yang dipuilih
      await predictAndSave(pathDir!); //menunggu prediksi dan di save ke path
      ScaffoldMessenger.of(context).showSnackBar( //pop up kecill dibawah 
        const SnackBar(content: Text('Gambar dipilih dan dideteksi!')), //untuk menandakan gambar sudah di pilih dan detesi
      );
    }
  }

  Future<void> predictAndSave(String path) async { //saat prediksi dan disimpan 
    var predictions = await Tflite.runModelOnImage( //model dimuat dibantu dengan tflite
      path: path, //path
      imageMean: 127.5, //rata-rata image 
      imageStd: 127.5, //gambar standar 
      numResults: 2, //hanya dua hasil teratas yang akan diambil dari output model
      threshold: 0.2, //hasil dengan probabilitas atau keyakinan 20% atau lebih tinggi yang akan dipertimbangkan sebagai hasil yang valid
      asynch: true, //proses disinkronkan
    );

    if (predictions != null && predictions.isNotEmpty) { //jika prediksi didapatkan
      var prediction = predictions[0];
      var dbHelper = DatabaseHelper(); // Membuat instance dari DatabaseHelper
      await dbHelper.insertData('Kualitas', { //menunggu dbhelper menambahkan data prediksi ke riwayat
        'nama': prediction['label'], //nama prediksi = label
        'keterangan':
            'Confidence: ${(prediction['confidence'] * 100).toStringAsFixed(2)}%', //kemiripan hasil %
        'imagePath': path,
        'confidence': prediction['confidence']
      });

      showResultDialog(prediction['label'], //menampilkan hasil prediksi
          (prediction['confidence'] * 100).toStringAsFixed(2), path);
    }
  }

  void showResultDialog(String label, String confidence, String imagePath) { //tampilan hasil prediksi
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hasil Scan"),
          content: Column( //kolom
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(File(imagePath)), //gambar hasil prediksi
              const SizedBox(height: 10), //tinggi box
              Text("Label: $label"), //label hasil prediksi
              Text("Confidence: $confidence%"), //kemiripan hasil prediksi
            ],
          ),
          actions: [ //aksi
            TextButton(
              child: const Text("OK"), //button ok
              onPressed: () { //tekan
                Navigator.of(context).pop(); //saat dipress kolom hasil hilang
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _camController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: initCamera(),
        builder: (_, snapshot) => (snapshot.connectionState ==
                ConnectionState.done)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          1 /
                          _camController!.value.aspectRatio,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: CameraPreview(_camController!),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (!_camController!.value.isTakingPicture) {
                            pathDir = await takePicture();
                            log("Picture taken: $pathDir");
                            await predictAndSave(pathDir!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Deteksi berhasil dan disimpan!')),
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 149, 201, 185),
                          ),
                          child: const Center(
                            child: Text(
                              "TAP TO SCAN",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: pickImageFromGallery,
                        icon: const Icon(Icons.photo_library),
                        label: const Text(""),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 149, 201, 185),
                          onPrimary: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          textStyle: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
