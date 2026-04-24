import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_radio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
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

class ThirtyRowCadastroEmpresa extends StatelessWidget {
  final CadastroEmpresaController controller;

  const ThirtyRowCadastroEmpresa({
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
            labelText: "Endereço",
            controller: controller.tecLogradouro,
            prefixIcon: Icon(Icons.map),
            required: true,
          ),
        ),
        ResponsiveField(
          width: 120,
          child: CustomTextFormField(
            labelText: "Núm.",
            controller: controller.tecNumero,
            required: true,
            prefixIcon: Icon(Icons.confirmation_number),
          ),
        ),
        ResponsiveField(
          child: CustomTextFormField(
            labelText: "Bairro",
            controller: controller.tecBairro,
            required: true,
            prefixIcon: Icon(Icons.house),
          ),
        ),
        ResponsiveField(
          child: CustomTextFormField(
            labelText: "Cidade",
            controller: controller.tecCidade,
            required: true,
            prefixIcon: Icon(Icons.map),
          ),
        ),
        ResponsiveField(
          width: 110,
          child: CustomTextFormField(
            labelText: "UF",
            controller: controller.tecUf,
            required: true,
            prefixIcon: Icon(Icons.map),
          ),
        ),
      ],
    );
  }
}
