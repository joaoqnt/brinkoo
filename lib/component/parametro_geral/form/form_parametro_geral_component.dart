
import 'package:brinquedoteca_flutter/component/parametro_geral/form/first_row_parametro_geral.dart';
import 'package:brinquedoteca_flutter/controller/parametro/parametro_geral_controller.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../custom_textformfield.dart';

class FormParametroGeralComponent extends StatelessWidget {
  final ParametroGeralController controller;
  const FormParametroGeralComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Observer(
        builder: (context) {
          return Form(
            key: controller.formKeyParametro,
            child: Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 20,
              children: [
                if(isMobile)
                  Column(
                    spacing: 10,
                    children: [
                      SizedBox(height: 1),
                      FirstRowParametroGeral(controller: controller),
                      // SecondRowCadastroCrianca(controller: controller),
                      // ThirtyRowCadastroCrianca(controller: controller),
                      // FourtyRowCadastroCrianca(controller: controller),
                    ],
                  ),
                if(!isMobile)
                  Expanded(
                      child: Column(
                        spacing: 10,
                        children: [
                          SizedBox(height: 1),
                          FirstRowParametroGeral(controller: controller),
                          // SecondRowCadastroCrianca(controller: controller),
                          // ThirtyRowCadastroCrianca(controller: controller),
                        ],
                      )
                  ),
              ],
            ),
          );
        }
    );
  }

}
