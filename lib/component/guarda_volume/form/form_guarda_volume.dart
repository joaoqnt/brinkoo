import 'package:brinquedoteca_flutter/component/custom/custom_form_action.dart';
import 'package:brinquedoteca_flutter/component/guarda_volume/form/first_row_cadastro_guarda_volume.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_guarda_volume_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../custom/custom_textformfield.dart';

class FormGuardaVolume extends StatelessWidget {
  final CadastroGuardaVolumeController controller;
  const FormGuardaVolume({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {

    return Observer(builder: (context) {
      return Form(
        key: controller.formKeyGuardaVolume,
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
                  if (controller.formKeyGuardaVolume.currentState!.validate() && !controller.isAltering) {
                    if (controller.guardaVolumeSelected == null) {
                      await controller.createGuardaVolume(context);
                    } else {
                      await controller.updateGuardaVolume(context);
                    }
                    controller.setGuardaVolume(guardaVolume: null);
                  }
                },
              ),
            ),
            FirstRowCadastroGuardaVolume(controller: controller),
          ],
        ),
      );
    });
  }


}
