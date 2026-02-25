import 'package:brinquedoteca_flutter/component/atividade/dropdown_atividade.dart';
import 'package:brinquedoteca_flutter/component/atividade/wrap_atividade.dart';
import 'package:brinquedoteca_flutter/component/crianca/form/first_row_cadastro_crianca.dart';
import 'package:brinquedoteca_flutter/component/crianca/form/fourty_row_cadastro_crianca.dart';
import 'package:brinquedoteca_flutter/component/crianca/form/second_row_cadastro_crianca.dart';
import 'package:brinquedoteca_flutter/component/crianca/form/thirty_row_cadastro_crianca.dart';
import 'package:brinquedoteca_flutter/component/foto/foto_alter_component.dart';
import 'package:brinquedoteca_flutter/controller/crianca/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../custom_textformfield.dart';

class FormCadastroCriancaComponent extends StatelessWidget {
  final CadastroCriancaController controller;
  const FormCadastroCriancaComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Observer(
      builder: (context) {
        return Form(
          key: controller.formKeyCrianca,
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 20,
            children: [
              Center(
                child: FotoAlterComponent(
                  onAdd: (p0) => controller.addFoto(p0),
                  capturedImageBytes: controller.criancaImage,
                  imageUrl: controller.criancaSelected?.urlImage,
                ),
              ),
              if(isMobile)
                Column(
                  spacing: 10,
                  children: [
                    SizedBox(height: 1),
                    FirstRowCadastroCrianca(controller: controller),
                    SecondRowCadastroCrianca(controller: controller),
                    ThirtyRowCadastroCrianca(controller: controller),
                    // FourtyRowCadastroCrianca(controller: controller),
                  ],
                ),
              if(!isMobile)
                Expanded(
                    child: Column(
                      spacing: 10,
                      children: [
                        SizedBox(height: 1),
                        FirstRowCadastroCrianca(controller: controller),
                        SecondRowCadastroCrianca(controller: controller),
                        ThirtyRowCadastroCrianca(controller: controller),
                        // FourtyRowCadastroCrianca(controller: controller),
                        WrapAtividade(
                          atividades: controller.atividades,
                          atividadesSelected: controller.atividadesSelected,
                          onSelected: (atividade, selected) => controller.toggleAtividade(atividade),
                        )
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
