import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/centro_custo/dropdown_centro_custo.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_radio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/forma_pagamento/dropdown_forma_pagamento.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/component/servico_nfse/dropdown_servico_nfse.dart';
import 'package:brinquedoteca_flutter/controller/parametro/parametro_geral_controller.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ThirtyRowParametroGeral extends StatelessWidget {
  final ParametroGeralController controller;

  const ThirtyRowParametroGeral({
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
          width: 250,
          child: CustomTextFormField(
            controller: controller.tecNatOp,
            labelText: "Natureza Operação",
            prefixIcon: const Icon(Icons.money),
          ),
        ),
        ResponsiveField(
          width: 120,
          child: CustomTextFormField(
            controller: controller.tecSerie,
            labelText: "Série",
            prefixIcon: const Icon(Icons.money),
          ),
        ),
        ResponsiveField(
          width: 150,
          child: CustomTextFormField(
            controller: controller.tecCfop,
            labelText: "CFOP",
            prefixIcon: const Icon(Icons.money),
          ),
        ),
      ],
    );
  }
}
