import 'package:brinquedoteca_flutter/component/custom/custom_form_action.dart';
import 'package:brinquedoteca_flutter/model/checkin.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:brinquedoteca_flutter/view/checkin/saida_checkin.dart';
import 'package:flutter/material.dart';

class DialogCheckout{
  show(BuildContext context,List<Checkin> checkins, List<Responsavel> responsaveis){
    final controller = Singleton().cadastroCheckinController;
    controller.setCheckins(checkins: checkins,responsaveis: responsaveis);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Form(
                key: controller.formKeyDialog,
                child: Column(
                  spacing: 20,
                  children: [
                    CustomFormAction(
                      onClear: () {
                        controller.setCheckin(checkin: null);
                        controller.setCheckins(checkins: null);
                        Navigator.pop(context);
                      },
                      useOnClear: true,
                      onSave: () async {
                        if(!controller.isLoading && controller.validate(context,checkin: checkins.firstOrNull,useFormKeyDialog: true)) {
                          // controller.checkinsSelected?.forEach((element) async {
                          //   await controller.updateCheckin(context);
                          // },);
                          //   await Singleton().checkinListController.getCheckins(refresh: true);
                          //   await Singleton().inicioController.initAll();
                          // controller.setCheckin(checkin: null);
                          Navigator.pop(context);
                        }
                      },
                      isLoading: controller.isLoading,
                    ),
                    SaidaCheckin(controller: controller),
                  ],
                ),
              ),
            ),
          );
        },
    );
  }
}