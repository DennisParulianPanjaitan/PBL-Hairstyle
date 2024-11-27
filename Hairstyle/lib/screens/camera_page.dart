import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  String _errorMessage = "";
  bool _isFlashOn = false;
  bool _isRearCamera = true;
  XFile? _capturedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() {
          _errorMessage = "Tidak ada kamera yang tersedia";
        });
        return;
      }

      final camera = _isRearCamera ? cameras.first : cameras.last;

      _cameraController = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController.initialize();

      if (!mounted) return;

      setState(() {
        _isCameraInitialized = true;
      });

      await _cameraController.setFlashMode(FlashMode.off);
    } catch (e) {
      setState(() {
        _errorMessage = "Gagal menginisialisasi kamera: $e";
      });
      print("Error initializing camera: $e");
    }
  }

  Future<void> _takePicture() async {
    if (!_cameraController.value.isInitialized) {
      print("Error: Camera is not initialized");
      return;
    }

    try {
      if (_cameraController.value.isTakingPicture) {
        return;
      }

      final XFile image = await _cameraController.takePicture();

      setState(() {
        _capturedImage = image;
      });

      print("Picture saved to: ${image.path}");

      // Pindah ke halaman preview setelah mengambil gambar
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PreviewPage(imagePath: image.path), // Menyertakan path gambar
        ),
      );
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  Future<void> _toggleFlash() async {
    if (!_cameraController.value.isInitialized) {
      print("Error: Camera is not initialized");
      return;
    }

    try {
      FlashMode newMode;

      if (_cameraController.value.flashMode == FlashMode.off) {
        newMode = FlashMode.torch;
      } else {
        newMode = FlashMode.off;
      }

      await _cameraController.setFlashMode(newMode);

      setState(() {
        _isFlashOn = newMode == FlashMode.torch;
      });
    } catch (e) {
      print("Error toggling flash: $e");
      _errorMessage = "Error toggling flash: $e";
    }
  }

  Future<void> _switchCamera() async {
    if (!_cameraController.value.isInitialized) {
      return;
    }

    try {
      await _cameraController.dispose();

      setState(() {
        _isRearCamera = !_isRearCamera;
        _isCameraInitialized = false;
      });

      await _initializeCamera();
    } catch (e) {
      print("Error switching camera: $e");
      _errorMessage = "Error switching camera: $e";
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _errorMessage.isNotEmpty
          ? Center(
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            )
          : Stack(
              fit: StackFit.expand,
              children: [
                if (_isCameraInitialized)
                  //mirror camera not initialized
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(_isRearCamera
                        ? 0
                        : 3.14159), // Apply mirror effect only for front camera
                    child: CameraPreview(_cameraController),
                  ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_rounded,
                          color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: IconButton(
                      icon: Icon(
                        _isFlashOn ? Icons.flash_on : Icons.flash_off,
                        color: Colors.white,
                      ),
                      onPressed: _toggleFlash,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: IconButton(
                            icon:
                                Icon(Icons.photo_library, color: Colors.white),
                            onPressed: () async {
                              final XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  _capturedImage = image;
                                });
                                // Setelah gambar dipilih, langsung pindah ke PreviewPage
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PreviewPage(imagePath: image.path),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Color(0xFF1B1A55),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 35,
                            ),
                            onPressed: _takePicture,
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                            ),
                            onPressed: _switchCamera,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class PreviewPage extends StatelessWidget {
  final String imagePath;

  const PreviewPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preview Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(File(
                imagePath)), // Menampilkan gambar yang dipilih atau diambil
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman hasil setelah preview
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ResultPage(),
                //   ),
                // );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1B1A55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Go to Result Page",
                style: TextStyle(
                  color: Color.fromARGB(
                      255, 255, 255, 255), // Mengubah warna teks menjadi biru
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
