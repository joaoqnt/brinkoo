import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_radio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/generic/text_form_field/cnpj_field.dart';
import 'package:brinquedoteca_flutter/component/generic/text_form_field/codigo.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_empresa_controller.dart';
import 'package:brinquedoteca_flutter/controller/configuracao/cadastro_convenio_controller.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FirstRowCadastroConvenio extends StatelessWidget {
  final CadastroConvenioController controller;

  const FirstRowCadastroConvenio({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
      spacing: 10,
      children: [
        Codigo(tec: controller.tecCodigo),
        ResponsiveField(
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.description),
            labelText: "Descrição",
            controller: controller.tecDescricao,
            required: true,
          ),
        ),
        Observer(
            builder: (context) {
              return SizedBox(
                width: 170,
                child: CustomRadio<bool>(
                  title: "Ativo",
                  options: [true,false],
                  value: controller.isAtivo,
                  label: (g) => g  ? "Sim" : "Não",
                  onChanged: (value) => controller.setAtivo(value!),
                ),
              );
            }
        ),
      ]
    );
  }
}
