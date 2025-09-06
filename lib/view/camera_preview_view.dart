import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class CameraPreviewWeb extends StatefulWidget {
  final void Function(Uint8List imageBytes) onCapture;

  const CameraPreviewWeb({super.key, required this.onCapture});

  @override
  State<CameraPreviewWeb> createState() => _CameraPreviewWebState();
}

class _CameraPreviewWebState extends State<CameraPreviewWeb> {
  late html.VideoElement _videoElement;
  late String _viewType;

  @override
  void initState() {
    super.initState();

    _viewType = 'camera-preview-${DateTime.now().millisecondsSinceEpoch}';

    _videoElement = html.VideoElement()
      ..autoplay = true
      ..muted = true
      ..style.width = '100%'
      ..style.height = '100%'
      ..setAttribute('playsinline', 'true'); // bom para mobile web

    _disposePreviousStreams();

    html.window.navigator.mediaDevices
        ?.getUserMedia({'video': true}).then((stream) {
      _videoElement.srcObject = stream;
      _videoElement.onCanPlay.first.then((_) {
        _videoElement.play();
      });
    });

    // Registrar view com id único para evitar cache/congelamento
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      _viewType,
          (int viewId) => _videoElement,
    );
  }

  void _disposePreviousStreams() {
    if (_videoElement.srcObject != null) {
      var tracks = (_videoElement.srcObject as html.MediaStream).getTracks();
      for (var track in tracks) {
        track.stop();
      }
      _videoElement.srcObject = null;
    }
  }

  @override
  void dispose() {
    _disposePreviousStreams();
    super.dispose();
  }

  Future<void> _capturePhoto() async {
    final canvas = html.CanvasElement(
      width: _videoElement.videoWidth,
      height: _videoElement.videoHeight,
    );
    final contextCanva = canvas.context2D;
    contextCanva.drawImage(_videoElement, 0, 0);

    final blob = await canvas.toBlob('image/jpeg');
    final reader = html.FileReader();
    final completer = Completer<Uint8List>();

    reader.readAsArrayBuffer(blob!);
    reader.onLoadEnd.listen((event) {
      completer.complete(reader.result as Uint8List);
    });

    final imageBytes = await completer.future;
    widget.onCapture(imageBytes);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Tela inteira, appbar opcional
      appBar: AppBar(
        title: const Text('Tirar Foto'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: _capturePhoto,
            tooltip: 'Capturar Foto',
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Cancelar',
          ),
        ],
      ),
      body: HtmlElementView(viewType: _viewType),
      backgroundColor: Colors.black,
    );
  }
}
