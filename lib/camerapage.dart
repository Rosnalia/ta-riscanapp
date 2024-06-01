import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite/tflite.dart';
import 'database_helper.dart';
import 'datatreat.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _camController;
  List? _hasilPred;
  String? pathDir;
  DataTreat dt = DataTreat();

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<String?> loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    );
    return res;
  }

  Future<void> initCamera() async {
    var cameras = await availableCameras();
    _camController = CameraController(cameras[0], ResolutionPreset.high);
    await _camController!.initialize();
  }

  Future<String> takePicture() async {
    Directory root = await getTemporaryDirectory();
    String dir = "${root.path}/BERAS";
    await Directory(dir).create(recursive: true);
    String filePath = "$dir/${DateTime.now()}.jpg";
    try {
      XFile? img = await _camController!.takePicture();
      await img.saveTo(filePath);
    } catch (e) {
      log("Error : ${e.toString()}");
    }
    return filePath;
  }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pathDir = pickedFile.path;
      log("Image picked: $pathDir");
      await predictAndSave(pathDir!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image selected and scanned!')),
      );
    }
  }

  Future<void> predictAndSave(String path) async {
    var predictions = await Tflite.runModelOnImage(
      path: path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 3,
      threshold: 0.2,
      asynch: true,
    );

    if (predictions != null && predictions.isNotEmpty) {
      var prediction = predictions[0];
      await DatabaseHelper.insertData('Kualitas', {
        'nama': prediction['label'],
        'keterangan': 'Confidence: ${(prediction['confidence'] * 100).toStringAsFixed(2)}%',
        'imagePath': path,
        'confidence': prediction['confidence']
      });
    }
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
      appBar: AppBar(
        title: const Text('Camera and Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: pickImageFromGallery,
          ),
        ],
      ),
      body: FutureBuilder(
        future: initCamera(),
        builder: (_, snapshot) => (snapshot.connectionState == ConnectionState.done)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "SCAN SEKARANG",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 1 /
                          _camController!.value.aspectRatio,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: CameraPreview(_camController!),
                    ),
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () async {
                      if (!_camController!.value.isTakingPicture) {
                        pathDir = await takePicture();
                        log("Picture taken: $pathDir");
                        await predictAndSave(pathDir!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Scan complete and saved!')),
                        );
                      }
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(126, 217, 87, 1),
                      ),
                      child: const Center(
                        child: Text(
                          "TAP TO SCAN",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
