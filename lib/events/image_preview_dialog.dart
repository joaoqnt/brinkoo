import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImagePreviewDialog extends StatelessWidget {
  final Uint8List? imageBytes;
  final String? imageUrl;
  final String? title;

  const ImagePreviewDialog({
    super.key,
    this.imageBytes,
    this.imageUrl,
    this.title,
  }) : assert(imageBytes != null || imageUrl != null, 'Uma imagem deve ser fornecida.');

  static void show(
      BuildContext context, {
        Uint8List? imageBytes,
        String? imageUrl,
        String? title,
      }) {
    showDialog(
      context: context,
      builder: (_) => ImagePreviewDialog(
        imageBytes: imageBytes,
        imageUrl: imageUrl,
        title: title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.8;

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maxHeight,
          maxWidth: 600,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: InteractiveViewer(
                  child: imageBytes != null
                      ? Image.memory(imageBytes!, fit: BoxFit.contain)
                      : Image.network(imageUrl!, fit: BoxFit.contain),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
