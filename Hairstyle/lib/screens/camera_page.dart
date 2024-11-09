import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';

class CameraPage extends StatefulWidget {
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
      );
      await _cameraController.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Gagal menginisialisasi kamera: $e";
      });
      print("Error initializing camera: $e");
    }
  }

  Future<void> _toggleFlash() async {
    if (_cameraController.value.flashMode == FlashMode.off) {
      await _cameraController.setFlashMode(FlashMode.torch);
      setState(() {
        _isFlashOn = true;
      });
    } else {
      await _cameraController.setFlashMode(FlashMode.off);
      setState(() {
        _isFlashOn = false;
      });
    }
  }

  Future<void> _switchCamera() async {
    setState(() {
      _isRearCamera = !_isRearCamera;
    });
    await _initializeCamera();
  }

  Future<void> _takePicture() async {
    if (!_cameraController.value.isInitialized) return;

    try {
      final image = await _cameraController.takePicture();
      setState(() {
        _capturedImage = image;
      });
    } catch (e) {
      print("Error taking picture: $e");
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
      body: _errorMessage.isNotEmpty
          ? Center(
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            )
          : Stack(
              children: [
                // Membuat CameraPreview memenuhi layar
                if (_isCameraInitialized)
                  Positioned.fill(
                    child: CameraPreview(_cameraController),
                  ),

                // Tombol kembali di pojok kiri atas
                Positioned(
                  top: 20,
                  left: 20,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),

                // Tombol flashlight di kanan atas
                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    icon: Icon(
                      _isFlashOn ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white,
                    ),
                    onPressed: _toggleFlash,
                  ),
                ),

                // Tombol-tombol di bagian bawah
                Positioned(
                  bottom: 30,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Tombol akses folder gambar
                      IconButton(
                        icon: Icon(Icons.photo, color: Colors.white, size: 30),
                        onPressed: () {
                          // Aksi untuk membuka folder gambar
                        },
                      ),
                      // Tombol foto
                      FloatingActionButton(
                        backgroundColor: Colors.blueAccent,
                        onPressed: _takePicture,
                        child: Icon(Icons.camera_alt),
                      ),
                      // Tombol ganti kamera
                      IconButton(
                        icon: Icon(Icons.switch_camera,
                            color: Colors.white, size: 30),
                        onPressed: _switchCamera,
                      ),
                    ],
                  ),
                ),

                // Menampilkan pratinjau gambar jika ada
                if (_capturedImage != null)
                  Positioned(
                    top: 20,
                    left: 100,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: Image.file(File(_capturedImage!.path)),
                          ),
                        );
                      },
                      child: Image.file(
                        File(_capturedImage!.path),
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
