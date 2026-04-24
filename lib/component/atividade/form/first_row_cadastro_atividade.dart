import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_radio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_atividade_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FirstRowCadastroAtividade extends StatelessWidget {
  final CadastroAtividadeController controller;

  const FirstRowCadastroAtividade({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
      spacing: 10,
      children: [
        SizedBox(
          width: 200,
          child: CustomTextFormField(
            labelText: "Código",
            controller: controller.tecCodigoAtividade,
            prefixIcon: Icon(Icons.confirmation_num),
            readOnly: true,
          ),
        ),
        Expanded(
          child: CustomTextFormField(
            labelText: "Nome",
            controller: controller.tecNomeAtividade,
            prefixIcon: Icon(Icons.description),
            required: true,
          ),
        ),
        Expanded(
          child: CustomTextFormField(
            labelText: "Descrição",
            controller: controller.tecDescricaoAtividade,
            prefixIcon: Icon(Icons.description),
            required: true,
          ),
        ),
      ]
    );
  }
}
