import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/crianca/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/responsavel/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FourtyRowCadastroResponsavel extends StatelessWidget {
  final CadastroResponsavelController controller;
  final CadastroCriancaController? criancaController;
  final Responsavel? responsavel;

  const FourtyRowCadastroResponsavel({
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
          width: 100,
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
