import 'dart:typed_data';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String? urlImage;
  final Uint8List? imageBytes;
  final IconData? icon;
  final double radius;
  final VoidCallback? onTap;

  const CustomCircleAvatar({
    Key? key,
    this.urlImage,
    this.imageBytes,
    this.icon,
    this.radius = 30,
    this.onTap,
  }) : super(key: key);

  bool get _hasUrlImage => urlImage != null && urlImage!.isNotEmpty;
  bool get _hasMemoryImage => imageBytes != null;

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;

    if (_hasMemoryImage) {
      imageProvider = MemoryImage(imageBytes!);
    } else if (_hasUrlImage) {
      imageProvider = NetworkImage(urlImage!);
    }

    return InkWell(
      onTap: (_hasUrlImage || _hasMemoryImage) ? onTap : null,
      child: CircleAvatar(
        radius: radius,
        backgroundImage: imageProvider,
        onBackgroundImageError: imageProvider is NetworkImage
            ? (exception, stackTrace) {
          debugPrint("Erro ao carregar imagem: $exception");
        }
            : null,
        child: imageProvider == null
            ? Icon(
          icon ?? Icons.child_care,
          size: radius * 0.6,
        )
            : null,
      ),
    );
  }
}