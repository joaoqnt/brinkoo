import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/convenio/dropdown_convenio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/forma_pagamento/dropdown_forma_pagamento.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/checkin/cadastro_checkin_controller.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecondRowSaida extends StatelessWidget {
  final CadastroCheckinController controller;

  const SecondRowSaida({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKeyFormaPgto,
      child: Flex(
        direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
        spacing: 10,
        children: [
          ResponsiveField(
            child: DropdownFormaPagamento(
              onChanged: (p0) => controller.setFormaPagamento(p0!),
              formaPagamento: controller.formaPagamentoSelected,
              required: false,
              enabled: controller.checkinSelected?.dataSaida == null,
            )
          ),
          ResponsiveField(
            width: 180,
            child: CustomTextFormField(
              prefixIcon: const Icon(Icons.monetization_on),
              labelText: "Valor",
              controller: controller.tecValorForma,
              required: true,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CentavosInputFormatter(moeda: true)
              ],
            ),
          ),
          FilledButton(
              onPressed: controller.valorRestante <= 0 ? null : () {
                if(controller.formKeyFormaPgto.currentState!.validate())
                  controller.addFormaPagamento();
              },
              child: Icon(Icons.add)
          )
        ]
      ),
    );
  }
}
