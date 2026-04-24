import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/convenio/dropdown_convenio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/checkin/cadastro_checkin_controller.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FirstRowSaida extends StatelessWidget {
  final CadastroCheckinController controller;

  const FirstRowSaida({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Flex(
          direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
          spacing: 10,
          children: [
            ResponsiveField(
              width: 160,
              child: CustomTextFormField(
                prefixIcon: const Icon(Icons.monetization_on),
                labelText: "Valor Bruto",
                controller: controller.tecValorBruto,
                readOnly: true,
              ),
            ),
            ResponsiveField(
              child: DropdownConvenio(
                onChanged: (p0) => controller.setConvenio(convenio: p0),
                convenio: controller.convenioSelected,
                required: false,
                enabled: controller.checkinSelected?.dataSaida == null,
              )
            ),
            FilledButton.icon(
                onPressed: () {
                  if(controller.checkinSelected?.dataSaida != null){
                    return null;
                  } else {
                    controller.setConvenio(convenio: null);
                  }
                },
                label: Text("Remover")
            ),
            ResponsiveField(
              width: 160,
              child: CustomTextFormField(
                prefixIcon: const Icon(Icons.monetization_on),
                labelText: "Desc. Convênio",
                controller: controller.tecDescontoConvenio,
                readOnly: true,
              ),
            ),
            ResponsiveField(
              width: 160,
              child: CustomTextFormField(
                prefixIcon: const Icon(Icons.monetization_on),
                labelText: "Desconto",
                controller: controller.tecDesconto,
                onChanged: (p0) => controller.setValorLiquido(),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CentavosInputFormatter(moeda: true)
                ],
              ),
            ),
            ResponsiveField(
              width: 160,
              child: CustomTextFormField(
                prefixIcon: const Icon(Icons.monetization_on),
                labelText: "Valor Liquido",
                controller: controller.tecValorLiquido,
                readOnly: true,
              ),
            ),
          ]
        );
      }
    );
  }
}
