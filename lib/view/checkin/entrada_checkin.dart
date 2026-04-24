import 'package:brinquedoteca_flutter/component/atividade/wrap_atividade.dart';
import 'package:brinquedoteca_flutter/component/crianca/dropdown_crianca.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_card_section.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/guarda_volume/dropdown_guarda_volume.dart';
import 'package:brinquedoteca_flutter/component/responsavel/dropdown_multiselection_responsavel.dart';
import 'package:brinquedoteca_flutter/component/responsavel/dropdown_responsavel.dart';
import 'package:brinquedoteca_flutter/component/usuario/dropdown_usuario.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/controller/checkin/cadastro_checkin_controller.dart';
import 'package:brinquedoteca_flutter/controller/navigation_controller.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EntradaCheckin extends StatelessWidget {
  final CadastroCheckinController controller;
  const EntradaCheckin({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Column(
          children: [
            Column(
              spacing:10,
              children: [
                CustomCardSection(
                  child: Column(
                    spacing:10,
                    children: [
                      SectionTitle(text: "Buscar criança cadastrada"),
                      Row(
                        spacing: 10,
                        children: [
                          Expanded(
                            child: DropdownCrianca(
                              onChanged: (p0) => controller.setCrianca(p0!),
                              crianca: controller.criancaSelected,
                              enabled: controller.checkinSelected == null,
                            ),
                          ),
                          FilledButton.tonal(
                              onPressed: () {
                                if(controller.criancaSelected != null){
                                  Singleton().cadastroCriancaController.setCrianca(crianca: controller.criancaSelected);
                                  Singleton().cadastroCriancaController.setFromCheckin(true);
                                  Singleton.instance.navigationController.setIndex(NavigationController().indexCadastroCriancaView);
                                }
                              },
                              child: Icon(Icons.edit)
                          ),
                          FilledButton(
                              onPressed: () {
                                Singleton().cadastroCriancaController.setCrianca(crianca: null);
                                Singleton().cadastroCriancaController.setFromCheckin(true);
                                Singleton.instance.navigationController.setIndex(NavigationController().indexCadastroCriancaView);
                              },
                              child: Icon(Icons.add)
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                if (controller.criancaSelected != null) ...[
                  CustomCardSection(
                    child: Column(
                      spacing: 10,
                      children: [
                        SectionTitle(text: "Responsável pela entrada"),
                        DropdownResponsavel(
                          responsaveis: controller.criancaSelected!.responsaveis??[],
                          onChanged: (p0) => controller.setResponsavel(p0!, true),
                          responsavel: controller.responsavelEntradaSelected,
                          enabled: controller.checkinSelected == null,
                        ),
                      ],
                    ),
                  ),

                  CustomCardSection(
                    child: Column(
                      spacing: 10,
                      children: [
                        SectionTitle(
                          text: "Autorização de retirada",
                          subtext: "Quem está autorizado a retirar a criança hoje.",
                        ),
                        DropdownMultiselectionResponsavel(
                          responsaveis: controller.criancaSelected!.responsaveis??[],
                          checkin: false,
                          required: true,
                          enabled: controller.checkinSelected == null,
                          onChanged: (p0) => controller.setResponsaveisPossiveisCheckout(p0!),
                          responsaveisSelected: controller.responsaveisPossiveisCheckout,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: CustomCardSection(
                          child: Column(
                            spacing: 10,
                            children: [
                              SectionTitle(
                                text: "Guarda-volumes",
                                subtext: "Armário dos pertences (opcional).",
                              ),
                              DropdownGuardaVolume(
                                guardaVolume: controller.guardaVolumeSelected,
                                required: false,
                                onChanged: (p0) => controller.setGuardaVolume(p0!),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomCardSection(
                          child: Column(
                            spacing: 10,
                            children: [
                              SectionTitle(
                                text: "Atendente da entrada",
                                // subtext: "Selecione o atendente da entrada",
                              ),
                              DropdownUsuario(
                                onChanged: (p0) => controller.setUsuarioEntrada(p0!),
                                required: true,
                                enabled: controller.checkinSelected == null,
                                usuario: controller.usuarioEntrada??Singleton().usuario,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomCardSection(
                    child: Column(
                      spacing: 10,
                      children: [
                        SectionTitle(
                          text: "Atividades autorizadas hoje",
                          subtext: "Quais oficinas a criança pode participar.",
                        ),
                        ListAtividade(
                          atividades: controller.atividades,
                          atividadesSelected: controller.atividadesSelected,
                          onSelected: (atividade, selected) => controller.toggleAtividade(atividade),
                        ),
                      ],
                    ),
                  ),


                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: CustomTextFormField(
                          controller: controller.tecMinutosDesejados,
                          labelText: "Minutos desejados",
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          suffixIcon: Tooltip(
                            message: "Tempo em que deseja manter a criança no estabelecimento.\n"
                                "Será utilizado para colorir o tempo de permanência "
                                "e alertar o responsável",
                            child: Icon(
                                Icons.info
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ],
        );
      }
    );
  }
}
