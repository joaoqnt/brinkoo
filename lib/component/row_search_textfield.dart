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
              onChanged: onChanged,
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
