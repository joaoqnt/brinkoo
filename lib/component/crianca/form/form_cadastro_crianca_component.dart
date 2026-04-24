import 'package:brinquedoteca_flutter/component/atividade/dropdown_atividade.dart';
import 'package:brinquedoteca_flutter/component/atividade/wrap_atividade.dart';
import 'package:brinquedoteca_flutter/component/crianca/form/first_row_cadastro_crianca.dart';
import 'package:brinquedoteca_flutter/component/crianca/form/fourty_row_cadastro_crianca.dart';
import 'package:brinquedoteca_flutter/component/crianca/form/second_row_cadastro_crianca.dart';
import 'package:brinquedoteca_flutter/component/crianca/form/thirty_row_cadastro_crianca.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_form_action.dart';
import 'package:brinquedoteca_flutter/component/foto/foto_alter_component.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../custom/custom_textformfield.dart';

class FormCadastroCriancaComponent extends StatelessWidget {
  final CadastroCriancaController controller;
  const FormCadastroCriancaComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Observer(builder: (context) {
      return Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Coluna da Foto
          SizedBox(
            child: FotoAlterComponent(
              onAdd: (p0) => controller.addFoto(p0),
              capturedImageBytes: controller.criancaImage,
              imageUrl: controller.criancaSelected?.urlImage,
              entity: "Foto da criança",
            ),
          ),

          if (!isMobile) const SizedBox(width: 30), // Espaçamento entre foto e campos

          // Coluna dos Campos
          Expanded(
            flex: 3,
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(
                  text: "Dados Pessoais",
                  widget: CustomFormAction(
                    isLoading: controller.isAltering,
                    onClear: () => controller.clearAll(),
                    onSave: () async {
                      if (controller.validate(context) && !controller.isAltering) {
                        if (controller.criancaSelected == null) {
                          await controller.createCrianca(context);
                        } else {
                          await controller.updateCrianca(context);
                        }

                        // controller.setCrianca(crianca: null);
                      }
                    },
                  ),
                ),
                FirstRowCadastroCrianca(controller: controller),
                SecondRowCadastroCrianca(controller: controller),
                ThirtyRowCadastroCrianca(controller: controller),
              ],
            ),
          ),
        ],
      );
    });
  }


}
