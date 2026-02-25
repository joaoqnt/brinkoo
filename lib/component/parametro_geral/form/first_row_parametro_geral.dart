import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_radio.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/parametro/parametro_geral_controller.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FirstRowParametroGeral extends StatelessWidget {
  final ParametroGeralController controller;

  const FirstRowParametroGeral({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
      spacing: 10,
      children: [
        ResponsiveField(
          width: 200,
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.person),
            labelText: "Tolerância (minutos)",
            controller: controller.tecTolerancia,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            required: true,
          ),
        ),
        ResponsiveField(
          width: 200,
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.person),
            labelText: 'Minutos Mínimo',
            controller: controller.tecMinutosMinimo,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            required: true,
          ),
        ),
      ],
    );
  }
}
