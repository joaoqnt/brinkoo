import 'package:flutter/material.dart';

class CustomFormAction extends StatelessWidget {
  final VoidCallback onClear;
  final Future<void> Function() onSave;
  final bool isLoading;
  final bool useOnClear;

  const CustomFormAction({
    super.key,
    required this.onClear,
    required this.onSave,
    required this.isLoading,
    this.useOnClear = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        if(useOnClear)
          FilledButton.tonal(
            onPressed: isLoading ? null : onClear,
            child: const Text("Limpar dados"),
          ),
        FilledButton(
          onPressed: isLoading ? null : () async => await onSave(),
          child: isLoading
              ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : const Text("Salvar"),
        ),
      ],
    );
  }
}