import 'dart:typed_data';
import 'package:brinquedoteca_flutter/component/custom_action_icon.dart';
import 'package:brinquedoteca_flutter/events/image_preview_dialog.dart';
import 'package:brinquedoteca_flutter/view/camera_preview_view.dart';
import 'package:flutter/material.dart';
class FotoAlterComponent extends StatelessWidget {
  final Uint8List? capturedImageBytes;
  final String? imageUrl;
  final double width;
  final double height;
  final Color borderColor;
  final double borderWidth;
  final void Function()? onRemove;
  final void Function(Uint8List)? onEdit;
  final void Function(Uint8List)? onAdd;


  const FotoAlterComponent({
    super.key,
    this.capturedImageBytes,
    this.imageUrl,
    this.width = 160,
    this.height = 160,
    this.borderColor = Colors.blue,
    this.borderWidth = 2.0,
    this.onRemove,
    this.onEdit,
    this.onAdd,
  });

  bool get hasImage => capturedImageBytes != null || imageUrl != null;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: hasImage
              ? () {
            ImagePreviewDialog.show(context,imageBytes: capturedImageBytes,imageUrl: imageUrl);
          }
              : null,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: hasImage ? borderColor : Colors.grey,
                width: borderWidth,
              ),
            ),
            child: _buildImageContent(),
          ),
        ),

        // Botão de adicionar no canto inferior direito
        Positioned(
          bottom: -16,
          right: -16,
          child: FloatingActionButton(
            mini: true,
            backgroundColor: Colors.blue,
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => CameraPreviewWeb(
                  onCapture: (imageBytes) {
                    if (onAdd != null) onAdd!(imageBytes);
                  },
                ),
              );
            },
            tooltip: 'Adicionar foto',
            child: const Icon(Icons.add_a_photo, size: 20),
          ),
        ),

        // Botões de ação editar/remover no canto superior direito
        if (hasImage && (onEdit != null || onRemove != null))
          Positioned(
            top: 4,
            right: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (onEdit != null)
                  CustomActionIcon(
                    icon: Icons.edit,
                    tooltip: 'Alterar foto',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => CameraPreviewWeb(
                          onCapture: (imageBytes) {
                            if (onEdit != null) onEdit!(imageBytes);
                          },
                        ),
                      );
                    },

                  ),
                if (onRemove != null) const SizedBox(height: 8),
                if (onRemove != null)
                  CustomActionIcon(
                    icon: Icons.delete,
                    tooltip: 'Remover foto',
                    onPressed: onRemove!,
                    color: Colors.redAccent,
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildImageContent() {
    if (capturedImageBytes != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.memory(
          capturedImageBytes!,
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
      );
    } else if (imageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image, color: Colors.grey, size: width * 0.25),
          ],
        ),
      );
    }
  }
}
