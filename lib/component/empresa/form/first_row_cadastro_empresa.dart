import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/generic/text_form_field/cnpj_field.dart';
import 'package:brinquedoteca_flutter/component/generic/text_form_field/codigo.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_empresa_controller.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstRowCadastroEmpresa extends StatelessWidget {
  final CadastroEmpresaController controller;

  const FirstRowCadastroEmpresa({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    FocusNode _cnpjFocusNode = FocusNode();
    return Flex(
      direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
      spacing: 10,
      children: [
        Codigo(tec: controller.tecCodigo),
        ResponsiveField(
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.person),
            labelText: "Nome",
            controller: controller.tecNome,
            required: true,
          ),
        ),
        CpfCnpjField(
          controller: controller.tecCnpj,
          pessoaFisica: false,
          focusNode: _cnpjFocusNode,
          onSearchCnpj: () => controller.setDataByCnpj(),
        )
      ]
    );
  }
}
