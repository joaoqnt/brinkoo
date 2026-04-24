import 'dart:typed_data';
import 'package:brinquedoteca_flutter/component/custom/custom_action_icon.dart';
import 'package:brinquedoteca_flutter/events/image_preview_dialog.dart';
import 'package:brinquedoteca_flutter/view/camera_preview_view.dart';
import 'package:flutter/material.dart';

class FotoAlterComponent extends StatelessWidget {
  final Uint8List? capturedImageBytes;
  final String? imageUrl;
  final double width;
  final double height;
  final void Function()? onRemove;
  final void Function(Uint8List)? onEdit;
  final void Function(Uint8List)? onAdd;
  final String entity;

  const FotoAlterComponent({
    super.key,
    this.capturedImageBytes,
    this.imageUrl,
    this.width = 120,
    this.height = 120,
    this.onRemove,
    this.onEdit,
    this.onAdd,
    required this.entity,
  });

  bool get hasImage => capturedImageBytes != null || imageUrl != null;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      spacing: 20,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            InkWell(
              onTap: hasImage
                  ? () {
                ImagePreviewDialog.show(
                  context,
                  imageBytes: capturedImageBytes,
                  imageUrl: imageUrl,
                );
              }
                  : null,
              borderRadius: BorderRadius.circular(100),
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: hasImage
                      ? Colors.white
                      : colors.primary.withOpacity(0.05),
                  border: Border.all(
                    color: hasImage
                        ? colors.primary
                        : colors.primary.withOpacity(0.2),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: _buildImageContent(colors),
              ),
            ),

            /// ➕ BOTÃO ADD (mais clean)
            Positioned(
              bottom: -6,
              right: -6,
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => CameraPreviewWeb(
                      onCapture: (imageBytes) {
                        if (onAdd != null) onAdd!(imageBytes);
                      },
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: colors.primary.withOpacity(0.3),
                        blurRadius: 8,
                      )
                    ],
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            /// ✏️ / 🗑️ AÇÕES
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
                        color: colors.primary,
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

                    if (onRemove != null) const SizedBox(height: 6),

                    if (onRemove != null)
                      CustomActionIcon(
                        icon: Icons.delete,
                        tooltip: 'Remover foto',
                        color: colors.error,
                        onPressed: onRemove!,
                      ),
                  ],
                ),
              ),
          ],
        ),
        Text(entity.toUpperCase(),
          style: TextStyle(fontSize: 12,color: Colors.grey)
        )
      ],
    );
  }

  Widget _buildImageContent(ColorScheme colors) {
    if (capturedImageBytes != null) {
      return ClipOval(
        child: Image.memory(
          capturedImageBytes!,
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
      );
    } else if (imageUrl != null) {
      return ClipOval(
        child: Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
      );
    } else {
      return Center(
        child: Icon(
          Icons.image_outlined,
          color: colors.primary.withOpacity(0.4),
          size: width * 0.28,
        ),
      );
    }
  }
}