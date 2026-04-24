
import 'package:brinquedoteca_flutter/component/atividade/form/first_row_cadastro_atividade.dart';
import 'package:brinquedoteca_flutter/component/atividade/form/second_row_cadastro_atividade.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_form_action.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_atividade_controller.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../custom/custom_textformfield.dart';

class FormCadastroAtividade extends StatelessWidget {
  final CadastroAtividadeController controller;
  const FormCadastroAtividade({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {

    return Observer(builder: (context) {
      return Form(
        key: controller.formKeyAtividade,
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
                text: "Dados Principais",
                widget: CustomFormAction(
                  isLoading: controller.isAltering,
                  onClear: () => controller.clearAll(),
                  onSave: () async {
                    if (controller.formKeyAtividade.currentState!.validate() && !controller.isAltering) {
                      if (controller.atividadeSelected == null) {
                        await controller.createAtividade(context);
                      } else {
                        await controller.updateAtividade(context);
                      }

                      controller.setAtividade(atividade: null);
                    }
                  },
                ),
            ),
            FirstRowCadastroAtividade(controller: controller),
            SecondRowCadastroAtividade(controller: controller),
          ],
        ),
      );
    });
  }


}
