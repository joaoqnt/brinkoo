import 'package:brinquedoteca_flutter/component/convenio/form/fifty_row_cadastro_convenio.dart';
import 'package:brinquedoteca_flutter/component/convenio/form/first_row_cadastro_convenio.dart';
import 'package:brinquedoteca_flutter/component/convenio/form/fourty_row_cadastro_convenio.dart';
import 'package:brinquedoteca_flutter/component/convenio/form/second_row_cadastro_convenio.dart';
import 'package:brinquedoteca_flutter/component/convenio/form/sixty_row_cadastro_convenio.dart';
import 'package:brinquedoteca_flutter/component/convenio/form/thirty_row_cadastro_convenio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_card_section.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_form_action.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/controller/configuracao/cadastro_convenio_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FormCadastroConvenio extends StatelessWidget {
  final CadastroConvenioController controller;
  const FormCadastroConvenio({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {

    return Observer(builder: (context) {
      return Form(
        key: controller.formKeyConvenio,
        child: Column(
          spacing: 20,
          children: [
            CustomCardSection(
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
                          if (controller.formKeyConvenio.currentState!.validate() && !controller.isAltering) {
                            if (controller.convenioSelected == null) {
                              await controller.createConvenio(context);
                            } else {
                              await controller.updateConvenio(context);
                            }

                            controller.setConvenio(convenio: null);
                          }
                        },
                      ),
                  ),
                  FirstRowCadastroConvenio(controller: controller),
                  SecondRowCadastroConvenio(controller: controller),
                  FiftyRowCadastroConvenio(controller: controller),
                ],
              ),
            ),
            CustomCardSection(
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(
                    text: "Descontos Firmados",
                  ),
                  Row(
                    children: [
                      for (int i = 0; i < controller.convenioDayName.length; i++)
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              controller.setDay(controller.convenioDayName[i]);
                              // controller.daySelected = controller.convenioDay[i];
                            },
                            style: TextButton.styleFrom(
                              foregroundColor:Theme.of(context).primaryColor,
                              backgroundColor: controller.convenioDayName[i] == controller.daySelected
                                  ? Theme.of(context).primaryColor.withOpacity(0.1)
                                  : null,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(controller.convenioDayName[i],
                                style: TextStyle(
                                    fontWeight: controller.convenioDayName[i] == controller.daySelected
                                        ? FontWeight.bold
                                        : null
                                )
                            ),
                          ),
                        ),
                    ],
                  ),
                  FourtyRowCadastroConvenio(controller: controller),
                ],
              ),
            ),
            CustomCardSection(
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(
                    text: "Dados Financeiros",
                  ),
                  ThirtyRowCadastroConvenio(controller: controller),
                ],
              ),
            ),
            CustomCardSection(
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(
                    text: "Dados das Visitas",
                  ),
                  SixtyRowCadastroConvenio(controller: controller),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }


}
