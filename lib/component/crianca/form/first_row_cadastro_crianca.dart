import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_radio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:brinquedoteca_flutter/utils/validator_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FirstRowCadastroCrianca extends StatelessWidget {
  final CadastroCriancaController controller;

  const FirstRowCadastroCrianca({
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
            prefixIcon: const Icon(Icons.person),
            labelText: "Nome da criança",

            controller: controller.tecNomeCrianca,
            required: true,
          ),
        ),
        ResponsiveField(
          width: 200,
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.document_scanner),
            labelText: "CPF",
            controller: controller.tecCpfCrianca,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return null;
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
        Observer(
          builder: (context) {
            return SizedBox(
              width: 170,
              child: CustomRadio<int>(
                title: "Ativo",
                options: [0,1],
                value: controller.radioAtivo,
                label: (g) => g == 0 ? "Sim" : "Não",
                onChanged: (value) => controller.setRadioAtivo(value!),
              ),
            );
          }
        ),
      ],
    );
  }
}
