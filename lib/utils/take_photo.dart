import 'dart:typed_data';

import 'package:camera/camera.dart';

class TakePhoto{
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];

  Future<Uint8List?> getImage() async{
    _cameras = await availableCameras();

    if (_cameras.isNotEmpty) {
      _cameraController = CameraController(_cameras[0], ResolutionPreset.medium);

      await _cameraController!.initialize();

      final image = await _cameraController!.takePicture();
      return await image.readAsBytes();
    }
    return null;
  }
}