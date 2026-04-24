import 'package:brinquedoteca_flutter/component/custom/custom_form_action.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/foto/foto_alter_component.dart';
import 'package:brinquedoteca_flutter/component/responsavel/dropdown_responsavel.dart';
import 'package:brinquedoteca_flutter/component/responsavel/form/first_row_cadastro_responsavel.dart';
import 'package:brinquedoteca_flutter/component/responsavel/form/thirty_row_cadastro_responsavel.dart';
import 'package:brinquedoteca_flutter/component/responsavel/form/second_row_cadastro_responsavel.dart';
import 'package:brinquedoteca_flutter/component/responsavel/form/second_row_cadastro_responsavel.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/navigation_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../utils/responsive.dart';
import '../../custom/custom_textformfield.dart';

class FormCadastroResponsavelComponent extends StatelessWidget {
  final CadastroResponsavelController controller;
  final CadastroCriancaController? criancaController;
  final Responsavel? responsavel;
  final Crianca? crianca;

  const FormCadastroResponsavelComponent({
    super.key,
    required this.controller,
    this.responsavel,
    this.criancaController,
    this.crianca,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      bool isDesktop = Responsive.isDesktop(context);
      return Form(
        key: controller.formKeyResponsavel,
        child: Flex(
          direction: isDesktop ? Axis.horizontal : Axis.vertical,
          spacing: 10,
          children: [
            Center(
              child: FotoAlterComponent(
                capturedImageBytes: controller.responsavelImage,
                onAdd: (p0) => controller.addFoto(p0),
                imageUrl: (responsavel?.urlImage) ?? controller.responsavelSelected?.urlImage,
                entity: "Foto do responsável",
              ),
            ),
            SizedBox(height: 10,),
            if(isDesktop)
              Expanded(
                child: Column(
                  spacing: 10,
                  children: [
                    SectionTitle(
                      text: "Dados Pessoais",
                      widget: CustomFormAction(
                        isLoading: controller.isAltering,
                        onClear: () => controller.clearAll(),
                        onSave: () async {
                          if (controller.validate(context) && !controller.isAltering) {
                            if (controller.responsavelSelected == null) {
                              await controller.createResponsavel(context, true);
                            } else {
                              await controller.updateResponsavel(context);
                            }

                            controller.setResponsavel(responsavel: null);
                          }
                        },
                      ),
                    ),
                    FirstRowCadastroResponsavel(
                      controller: controller,
                      criancaController: criancaController,
                      responsavel: responsavel,
                    ),
                    SecondRowCadastroResponsavel(
                      controller: controller,
                      criancaController: criancaController,
                      responsavel: responsavel,
                    ),
                    ThirtyRowCadastroResponsavel(
                      controller: controller,
                      criancaController: criancaController,
                      responsavel: responsavel,
                    ),
                  ],
                ),
              ),
            if(!isDesktop)
              Column(
                spacing: 10,
                children: [
                  if(responsavel?.nome == null)
                    DropdownResponsavel(
                      responsaveis: crianca != null ? crianca!.responsaveis : null,
                      onChanged: (p0) => controller.setResponsavel(responsavel: p0),
                      title: "Selecione um responsável",
                      required: false,
                      responsavel: responsavel,
                      enabled: (responsavel == null || responsavel?.nome == null),
                    ),
                  FirstRowCadastroResponsavel(
                    controller: controller,
                    criancaController: criancaController,
                    responsavel: responsavel,
                  ),
                  SecondRowCadastroResponsavel(
                    controller: controller,
                    criancaController: criancaController,
                    responsavel: responsavel,
                  ),
                  ThirtyRowCadastroResponsavel(
                    controller: controller,
                    criancaController: criancaController,
                    responsavel: responsavel,
                  ),
                ],
              ),
            if (criancaController != null)
              IconButton(
                tooltip: "Remover vínculo com a criança",
                onPressed: () {
                  // criancaController!.removeResponsavel(
                  //     responsavel!, controller
                  // );
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
          ],
        )
      );
    });
  }
}
