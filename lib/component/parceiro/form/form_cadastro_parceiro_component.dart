import 'package:brinquedoteca_flutter/component/custom/custom_card_section.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_form_action.dart';
import 'package:brinquedoteca_flutter/component/foto/foto_alter_component.dart';
import 'package:brinquedoteca_flutter/component/parceiro/form/first_row_cadastro_parceiro.dart';
import 'package:brinquedoteca_flutter/component/parceiro/form/fifty_row_cadastro_parceiro.dart';
import 'package:brinquedoteca_flutter/component/parceiro/form/fourty_row_cadastro_parceiro.dart';
import 'package:brinquedoteca_flutter/component/parceiro/form/second_row_cadastro_parceiro.dart';
import 'package:brinquedoteca_flutter/component/parceiro/form/thirty_row_cadastro_parceiro.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_parceiro_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../utils/responsive.dart';

class FormCadastroParceiroComponent extends StatelessWidget {
  final CadastroParceiroController controller;

  const FormCadastroParceiroComponent({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Form(
      key: controller.formKeyParceiro,
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Coluna da Foto
          FotoAlterComponent(
            onAdd: (p0) => controller.addFoto(p0),
            capturedImageBytes: controller.parceiroImage,
            imageUrl: controller.parceiroSelected?.urlImage,
            entity: "Foto do parceiro",
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
                      if(controller.formKeyParceiro.currentState!.validate() && !controller.isAltering){
                        if(controller.parceiroSelected == null) {
                          await controller.createParceiro(context);
                        } else {
                          await controller.updateParceiro(context);
                        }
                        controller.setParceiro(parceiro: null);
                      }
                    },
                  ),
                ),
                FirstRowCadastroParceiro(controller: controller),
                SecondRowCadastroParceiro(controller: controller),
                ThirtyRowCadastroParceiro(controller: controller),
                FourtyRowCadastroParceiro(controller: controller),
                FiftyRowCadastroParceiro(controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
