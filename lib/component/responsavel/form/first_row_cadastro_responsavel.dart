import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:brinquedoteca_flutter/utils/validator_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstRowCadastroResponsavel extends StatelessWidget {
  final CadastroResponsavelController controller;
  final CadastroCriancaController? criancaController;
  final Responsavel? responsavel;

  const FirstRowCadastroResponsavel({
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
            prefixIcon: const Icon(Icons.person),
            labelText: "Nome",
            controller: controller.tecNome,
            required: true,
          ),
        ),
        ResponsiveField(
          width: 200,
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.document_scanner),
            labelText: "CPF",
            controller: controller.tecDocumento,
            required: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Informe o CPF";
              }

              if (!isValidCPF(UtilBrasilFields.removeCaracteres(value))) {
                return "CPF inválido";
              }

              return null;
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter()
            ],
          ),
        ),
        ResponsiveField(
          width: 200,
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.phone_android),
            labelText: "Telefone",
            controller: controller.tecTelefone,
            required: true,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TelefoneInputFormatter()
            ],
          ),
        ),
        ResponsiveField(
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.email),
            labelText: "Email",
            controller: controller.tecEmail,
            required: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Informe o email";
              }

              if (!isValidEmail(value)) {
                return "Email inválido";
              }

              return null;
            },
          ),
        ),
      ],
    );
  }
}
