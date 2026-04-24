import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_radio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/generic/text_form_field/cep_field.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_empresa_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_parceiro_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SecondRowCadastroEmpresa extends StatelessWidget {
  final CadastroEmpresaController controller;

  const SecondRowCadastroEmpresa({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode _cepFocusNode = FocusNode();
    return Observer(
      builder: (context) {
        return Flex(
          direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
          spacing: 10,
          children: [
            ResponsiveField(
              width: 190,
              child: CustomTextFormField(
                labelText: "Telefone",
                controller: controller.tecTelefone,
                prefixIcon: Icon(Icons.phone),
                required: true,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter()
                ],
              ),
            ),
            ResponsiveField(
              child: CustomTextFormField(
                labelText: "E-mail",
                controller: controller.tecEmail,
                prefixIcon: Icon(Icons.mail),
                required: true,
              ),
            ),
            ResponsiveField(
              width: 180,
              child: CustomTextFormField(
                  labelText: "Insc. Estadual",
                  controller: controller.tecInscEst,
                prefixIcon: Icon(Icons.document_scanner),
              ),
            ),
            ResponsiveField(
              width: 160,
              child: CustomTextFormField(
                  labelText: "CNAE",
                  controller: controller.tecCnae,
                prefixIcon: Icon(Icons.document_scanner),
              ),
            ),
            CepField(
              controller: controller.tecCep,
              focusNode: _cepFocusNode,
              onSearchCep: () => controller.setEnderecoByCep(),
            )
          ],
        );
      }
    );
  }
}
