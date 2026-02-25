import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/crianca/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/responsavel/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThirtyRowCadastroCrianca extends StatelessWidget {
  final CadastroCriancaController controller;

  const ThirtyRowCadastroCrianca({
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
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.description),
            labelText: "Observações",
            controller: controller.tecObservacaoCrianca,
          ),
        ),
        // ResponsiveField(
        //   child: CustomTextFormField(
        //     prefixIcon: const Icon(Icons.local_pharmacy),
        //     labelText: "Alergias",
        //     controller: controller.tecAlergiaCrianca,
        //   ),
        // ),
        // ResponsiveField(
        //   width: 160,
        //   child: CustomTextFormField(
        //     prefixIcon: const Icon(Icons.bloodtype),
        //     labelText: "Grupo sang.",
        //     controller: controller.tecGrupoSanguineoCrianca,
        //   ),
        // ),
      ],
    );
  }
}
