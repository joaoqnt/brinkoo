import 'package:brinquedoteca_flutter/component/custom/custom_form_action.dart';
import 'package:brinquedoteca_flutter/component/empresa/form/first_row_cadastro_empresa.dart';
import 'package:brinquedoteca_flutter/component/empresa/form/second_row_cadastro_empresa.dart';
import 'package:brinquedoteca_flutter/component/empresa/form/thirty_row_cadastro_empresa.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_empresa_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../custom/custom_textformfield.dart';

class FormCadastroEmpresa extends StatelessWidget {
  final CadastroEmpresaController controller;
  const FormCadastroEmpresa({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {

    return Observer(builder: (context) {
      return Form(
        key: controller.formKeyEmpresa,
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
                    if (controller.formKeyEmpresa.currentState!.validate() && !controller.isAltering) {
                      if (controller.empresaSelected == null) {
                        await controller.createEmpresa(context);
                      } else {
                        await controller.updateEmpresa(context);
                      }

                      controller.setEmpresa(empresa: null);
                    }
                  },
                ),
            ),
            FirstRowCadastroEmpresa(controller: controller),
            SecondRowCadastroEmpresa(controller: controller),
            ThirtyRowCadastroEmpresa(controller: controller),
            // SecondRowCadastroAtividade(controller: controller),
          ],
        ),
      );
    });
  }


}
