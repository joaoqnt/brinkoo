import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_radio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/generic/text_form_field/codigo.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_atividade_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_guarda_volume_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FirstRowCadastroGuardaVolume extends StatelessWidget {
  final CadastroGuardaVolumeController controller;

  const FirstRowCadastroGuardaVolume({
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
        Expanded(
          child: CustomTextFormField(
            labelText: "Nome",
            controller: controller.tecNome,
            prefixIcon: Icon(Icons.description),
            required: true,
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
      ]
    );
  }
}
