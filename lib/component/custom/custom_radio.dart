import 'package:brinquedoteca_flutter/component/custom/custom_border.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_input_decoration.dart';
import 'package:flutter/material.dart';

class CustomRadio<T> extends StatelessWidget {
  final List<T> options;
  final T? value;
  final String Function(T option) label;
  final ValueChanged<T?> onChanged;
  final String? title;
  final bool isDense;
  final bool required; // Adicionado para seguir o padrão

  const CustomRadio({
    Key? key,
    required this.options,
    required this.value,
    required this.label,
    required this.onChanged,
    this.title,
    this.isDense = true,
    this.required = false, // Padrão falso
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: CustomInputDecoration.build(
        context: context,
        isDense: isDense,
        labelText: title,
        required: required,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8)
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 0,
        children: options.map((option) {
          final isSelected = option == value;
          return InkWell( // Torna o texto clicável também, melhorando a UX
            onTap: () => onChanged(option),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<T>(
                  value: option,
                  groupValue: value,
                  onChanged: onChanged,
                  activeColor: Theme.of(context).primaryColor, // Segue a cor do app
                  visualDensity: VisualDensity.compact, // Deixa o rádio mais elegante
                ),
                Text(
                  label(option),
                  style: TextStyle(
                    color: isSelected ? Colors.black87 : Colors.grey.shade700,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}