import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/centro_custo/dropdown_centro_custo.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_radio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/forma_pagamento/dropdown_forma_pagamento.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/component/servico_nfse/dropdown_servico_nfse.dart';
import 'package:brinquedoteca_flutter/controller/parametro/parametro_geral_controller.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SecondRowParametroGeral extends StatelessWidget {
  final ParametroGeralController controller;

  const SecondRowParametroGeral({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
      spacing: 10,
      children: [
        ResponsiveField(
          width: 430,
          child: DropdownServicoNfse(
            required: true,
            servicoSelected: controller.servicoNfseSelected,
            onChanged: (p0) => controller.setServicoNfse(p0),
          ),
        ),
        ResponsiveField(
          width: 300,
          child: DropdownFormaPagamento(
            required: true,
            formaPagamento: controller.formaPagamentoSelected,
            onChanged: (p0) => controller.setFormaPagamento(p0),
            label: "Forma Pagamento Padrão",
          ),
        ),
        ResponsiveField(
          width: 280,
          child: DropdownCentroCusto(
            required: true,
            centroCusto: controller.centroCustoCheckinSelected,
            onChanged: (p0) => controller.setCentroCustoCheckin(p0),
            label: "Centro Custo Checkin",
          ),
        ),
        ResponsiveField(
          width: 280,
          child: DropdownCentroCusto(
            required: true,
            centroCusto: controller.centroCustoCheckinSelected,
            onChanged: (p0) => controller.setCentroCustoEvento(p0),
            label: "Centro Custo Evento",
          ),
        ),
      ],
    );
  }
}
