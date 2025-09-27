import 'dart:async';

import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:flutter/material.dart';

class RowSearchTextfield extends StatelessWidget {
  TextEditingController tecController;
  Widget? widget;
  String? hintText;
  void Function(String)? onChanged;

  RowSearchTextfield({
    super.key,
    this.hintText,
    this.onChanged,
    required this.tecController,
    this.widget,
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
              hintText: hintText??"Pesquise pelos atributos",
              suffixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade200,
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();

                _debounce = Timer(const Duration(milliseconds: 500), () {
                  onChanged?.call(value); // chama a função original após 500ms
                });
              },
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
            )
        ),
        if(widget != null)
          FilledButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => widget!),
                );
              },
              icon: Icon(Icons.add),
              label: Text("Cadastrar")
          )
      ],
    );
  }
}
