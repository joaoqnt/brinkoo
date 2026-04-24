import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/checkin/saida/first_row_saida.dart';
import 'package:brinquedoteca_flutter/component/checkin/saida/second_row_saida.dart';
import 'package:brinquedoteca_flutter/component/convenio/dropdown_convenio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_card_section.dart';
import 'package:brinquedoteca_flutter/component/forma_pagamento/card_forma_pagamento.dart';
import 'package:brinquedoteca_flutter/component/forma_pagamento/dropdown_forma_pagamento.dart';
import 'package:brinquedoteca_flutter/component/responsavel/dropdown_responsavel.dart';
import 'package:brinquedoteca_flutter/component/usuario/dropdown_usuario.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/controller/checkin/cadastro_checkin_controller.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SaidaCheckin extends StatelessWidget {
  final CadastroCheckinController controller;
  const SaidaCheckin({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Column(
          spacing: 10,
          children: [
            if (controller.checkinSelected != null) ...[
              CustomCardSection(
                child: Column(
                  spacing: 10,
                  children: [
                    SectionTitle(
                      text: "Responsável pela retirada",
                      subtext: "Selecione o responsável pela retirada",
                    ),
                    DropdownResponsavel(
                      responsaveis: controller.responsaveisPossiveisCheckout,
                      onChanged: (p0) => controller.setResponsavel(p0!, false),
                      responsavel: controller.responsavelSaidaSelected,
                      enabled: controller.checkinSelected?.dataSaida == null,
                      checkin: false,
                    ),
                  ],
                ),
              ),

              CustomCardSection(
                child: Column(
                  spacing: 10,
                  children: [
                    SectionTitle(
                      text: "Atendente da saída",
                      subtext: "Selecione o atendente da saída",
                    ),
                    DropdownUsuario(
                      onChanged: (p0) => controller.setUsuarioSaida(p0!),
                      required: true,
                      enabled: controller.checkinSelected?.dataSaida == null,
                      usuario: controller.usuarioSaida??Singleton().usuario,
                    ),
                  ],
                ),
              ),

              CustomCardSection(
                child: Column(
                  spacing: 10,
                  children: [
                    SectionTitle(
                      text: "Dados do Pagamento",
                      subtext: "Selecione os dados do pagamento",
                    ),
                    FirstRowSaida(controller: controller),
                    SecondRowSaida(controller: controller),
                    for(int i = 0; i < controller.formas.length; i++)
                      CardFormaPagamento(formaPagamento: controller.formas[i],showValue: true,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Restante: ${UtilBrasilFields.obterReal(controller.valorRestante)}")
                      ],
                    )
                    // Row(
                    //   spacing: 10,
                    //   children: [
                    //     Expanded(
                    //       child: DropdownFormaPagamento(
                    //         formaPagamento: controller.formaPagamentoSelected,
                    //         onChanged: (p0) => controller.setFormaPagamento(p0!),
                    //         enabled: controller.checkinSelected?.dataSaida == null,
                    //         required: true,
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: DropdownConvenio(
                    //         enabled: controller.checkinSelected?.dataSaida == null,
                    //         required: false,
                    //         convenio: controller.convenioSelected,
                    //         onChanged: (p0) => controller.setConvenio(convenio: p0),
                    //       ),
                    //     ),
                    //     FilledButton.icon(
                    //       onPressed: () {
                    //         controller.setConvenio(convenio: null);
                    //       },
                    //       label: const Text("Limpar"),
                    //       icon: const Icon(Icons.clear),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
              )
            ],
          ],
        );
      }
    );
  }
}
