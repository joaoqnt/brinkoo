import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class RemoveDialog<T> {
  Future<bool?> show({
    required BuildContext context,
    required T item,
    required String Function(T item) itemName,
    required Future<void> Function(BuildContext context, T item) onDelete,
    required bool Function() isLoading,

    String title = "Confirmar remoção",
    String confirmText = "Remover",
    String cancelText = "Cancelar",
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(
            "Tem certeza que deseja remover ${itemName(item)}?",
          ),
          actions: [
            Observer(
              builder: (_) => TextButton(
                onPressed: isLoading()
                    ? null
                    : () => Navigator.of(context).pop(false),
                child: Text(cancelText),
              ),
            ),
            Observer(
              builder: (_) => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: isLoading()
                    ? null
                    : () async {
                  await onDelete(context, item);
                  Navigator.of(context).pop(true);
                },
                child: isLoading()
                    ? SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : Text(
                  confirmText,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}