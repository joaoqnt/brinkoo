import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_radio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_parceiro_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FiftyRowCadastroParceiro extends StatelessWidget {
  final CadastroParceiroController controller;

  const FiftyRowCadastroParceiro({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Flex(
          direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
          spacing: 10,
          children: [
            ResponsiveField(
              width: 200,
              child: CustomRadio<bool>(
                title: "Agência bancária",
                options: [true,false],
                value: controller.agenciaBancaria,
                label: (g) => g ? "Sim" : "Não",
                onChanged: (value) => controller.setAgenciaBancaria(value!),
              ),
            ),
            ResponsiveField(
              width: 200,
              child: CustomRadio<bool>(
                title: "Fornecedor",
                options: [true,false],
                value: controller.fornecedor,
                label: (g) => g ? "Sim" : "Não",
                onChanged: (value) => controller.setFornecedor(value!),
              ),
            ),
            ResponsiveField(
              width: 200,
              child: CustomRadio<bool>(
                title: "Funcionário",
                options: [true,false],
                value: controller.funcionario,
                label: (g) => g ? "Sim" : "Não",
                onChanged: (value) => controller.setFuncionario(value!),
              ),
            ),
            ResponsiveField(
              width: 200,
              child: CustomRadio<bool>(
                title: "Transportador",
                options: [true,false],
                value: controller.transportador,
                label: (g) => g ? "Sim" : "Não",
                onChanged: (value) => controller.setTransportador(value!),
              ),
            ),
          ],
        );
      }
    );
  }
}
