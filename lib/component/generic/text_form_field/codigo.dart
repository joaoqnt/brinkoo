import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:flutter/material.dart';

class Codigo extends StatelessWidget {
  final TextEditingController tec;
  const Codigo({super.key,required this.tec});

  @override
  Widget build(BuildContext context) {
    return ResponsiveField(
      width: 120,
      child: CustomTextFormField(
        labelText: "Código",
        controller: tec,
        prefixIcon: Icon(Icons.confirmation_num),
        readOnly: true,
      ),
    );
  }
}
