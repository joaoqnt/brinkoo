import 'package:flutter/material.dart';

class CustomRadio<T> extends StatelessWidget {
  final List<T> options;
  final T? value;
  final String Function(T option) label;
  final ValueChanged<T?> onChanged;
  final String? title;
  final bool isDense;

  const CustomRadio({
    Key? key,
    required this.options,
    required this.value,
    required this.label,
    required this.onChanged,
    this.title,
    this.isDense = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: title,
        isDense: isDense,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
      ),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        children: options.map((option) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<T>(
                value: option,
                groupValue: value,
                onChanged: onChanged,
              ),
              Text(label(option)),
            ],
          );
        }).toList(),
      ),
    );
  }
}