import 'dart:async';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:flutter/material.dart';

class RowSearchTextfield extends StatelessWidget {
  final TextEditingController tecController;
  final Widget? widgetToNavigate;
  final Widget? widget;
  final String? hintText;
  final bool filter;
  final void Function(String)? onChanged;
  final VoidCallback? onFilterPressed; // 👈 NOVO

  RowSearchTextfield({
    super.key,
    this.hintText,
    this.onChanged,
    required this.tecController,
    this.widgetToNavigate,
    this.widget,
    this.filter = false,
    this.onFilterPressed, // 👈 NOVO
  });

  @override
  Widget build(BuildContext context) {
    Timer? _debounce;

    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: tecController,
            labelText: "Pesquisar",
            hintText: hintText ?? "Pesquise pelos atributos",
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon:Icon(Icons.highlight_remove),
              onPressed: () {
                tecController.clear();
                if (_debounce?.isActive ?? false) _debounce!.cancel();

                _debounce = Timer(const Duration(milliseconds: 500), () {
                  onChanged?.call('');
                });
              },
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce!.cancel();

              _debounce = Timer(const Duration(milliseconds: 500), () {
                onChanged?.call(value);
              });
            },
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        /// BOTÃO DE FILTRO
        if (filter)
          IconButton.filledTonal(
            tooltip: "Filtros",
            onPressed: onFilterPressed, // 👈 AGORA VEM POR PARÂMETRO
            icon: const Icon(Icons.filter_alt_rounded),
          ),

        /// BOTÃO CADASTRAR
        if (widgetToNavigate != null)
          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => widgetToNavigate!),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text("Cadastrar"),
          ),
        if(widget != null)
          widget!,
      ],
    );
  }
}