import 'package:brinquedoteca_flutter/component/custom/custom_input_decoration.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_radio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_atividade_controller.dart';
import 'package:brinquedoteca_flutter/model/tmp/icone_atividade.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:brinquedoteca_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SecondRowCadastroAtividade extends StatelessWidget {
  final CadastroAtividadeController controller;

  const SecondRowCadastroAtividade({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
      spacing: 10,
      children: [
        Observer(
          builder: (context) {
            return ResponsiveField(
              width: 200,
              child: DropdownButtonFormField<IconeAtividade>(
                decoration: CustomInputDecoration.build(
                  context: context,
                  required: true,
                  prefixIcon: const Icon(Icons.insert_emoticon),
                  isDense: true,
                  labelText: "Ícone",
                ),
                icon: Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
                validator: (value) => value == null ? "Campo obrigatório" : null,
                value: controller.iconSelected,

                // 1. Mantenha os itens normais (ou ajuste o tamanho aqui se quiser o menu maior)
                items: Utils().getIconesAtividade().map((icone) {
                  return DropdownMenuItem<IconeAtividade>(
                    value: icone,
                    child: Center(
                      child: Image.asset(
                        "assets/${icone.pathImage}",
                        width: 48, // Tamanho dentro do menu
                        height: 48,
                      ),
                    ),
                  );
                }).toList(),

                onChanged: (value) => controller.setIconAtividade(value!),
              ),
            );
          }
        ),
        SizedBox(
          width: 170,
          child: CustomRadio<int>(
            title: "Ativo",
            options: [0,1],
            value: controller.radioAtivo,
            label: (g) => g == 0 ? "Sim" : "Não",
            onChanged: (value) => controller.setRadioAtivo(value!),
          ),
        ),
        SizedBox(
          width: 250,
          child: CustomRadio<int>(
            title: "Padrão ao carregar",
            options: [0,1],
            value: controller.radioPadrao,
            label: (g) => g == 0 ? "Liberado" : "Bloqueado",
            onChanged: (value) => controller.setRadioPadrao(value!),
          ),
        )
      ]
    );
  }
}
