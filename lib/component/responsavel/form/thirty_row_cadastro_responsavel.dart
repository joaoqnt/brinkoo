import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThirtyRowCadastroResponsavel extends StatelessWidget {
  final CadastroResponsavelController controller;
  final CadastroCriancaController? criancaController;
  final Responsavel? responsavel;

  const ThirtyRowCadastroResponsavel({
    super.key,
    required this.controller,
    this.criancaController,
    this.responsavel,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
      spacing: 10,
      children: [
        ResponsiveField(
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.streetview),
            labelText: "Bairro",
            controller: controller.tecBairro,
            required: true,
          ),
        ),
        ResponsiveField(
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.location_city),
            labelText: "Cidade",
            controller: controller.tecCidade,
            required: true,
          ),
        ),
        ResponsiveField(
          width: 120,
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.map),
            labelText: "UF",
            controller: controller.tecEstado,
            required: true,
          )
        ),
      ],
    );
  }
}
