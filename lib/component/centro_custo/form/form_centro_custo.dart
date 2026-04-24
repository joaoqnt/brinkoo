import 'package:brinquedoteca_flutter/component/custom/custom_card_section.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_form_action.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/generic/text_form_field/codigo.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/controller/configuracao/cadastro_centro_custo_controller.dart';
import 'package:flutter/material.dart';

class FormCentroCusto extends StatelessWidget {
  final CadastroCentroCustoController controller;
  const FormCentroCusto({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKeyCenCus,
      child: Column(
        spacing: 20,
        children: [
          CustomCardSection(
            child: Column(
              spacing: 10,
              children: [
                SectionTitle(
                    text: "Dados principais",
                    widget: CustomFormAction(
                      isLoading: controller.isAltering,
                      onClear: () => controller.clearAll(),
                      onSave: () async {
                        if (controller.formKeyCenCus.currentState!.validate() && !controller.isAltering) {
                          if (controller.centroCustoSelected == null) {
                            await controller.createCenCus(context);
                          } else {
                            await controller.updateCenCus(context);
                          }
                          controller.setCenCus(cencus: null);
                        }
                      },
                    )
                ),
                Row(
                  children: [
                    Codigo(tec: controller.tecCodigoCenCus),
                    SizedBox(width: 20),
                    Expanded(
                      child: CustomTextFormField(
                        labelText: "Descrição",
                        controller: controller.tecNomeCenCus,
                        prefixIcon: Icon(Icons.description),
                        required: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
