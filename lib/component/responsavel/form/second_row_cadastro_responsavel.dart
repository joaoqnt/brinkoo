import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/generic/text_form_field/cep_field.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecondRowCadastroResponsavel extends StatelessWidget {
  final CadastroResponsavelController controller;
  final CadastroCriancaController? criancaController;
  final Responsavel? responsavel;

  const SecondRowCadastroResponsavel({
    super.key,
    required this.controller,
    this.criancaController,
    this.responsavel,
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode _cepFocusNode = FocusNode();
    return Flex(
      direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
      spacing: 10,
      children: [
        CepField(
          controller: controller.tecCep,
          focusNode: _cepFocusNode,
          onSearchCep: () => controller.setEnderecoByCep(),
        ),
        ResponsiveField(
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.add_location),
            labelText: "Endereço",
            controller: controller.tecEndereco,
            required: true,
          ),
        ),
        ResponsiveField(
          width: 130,
          child: CustomTextFormField(
              prefixIcon: const Icon(Icons.numbers),
              labelText: "Número",
              controller: controller.tecNumero
          ),
        ),
      ],
    );
  }
}
