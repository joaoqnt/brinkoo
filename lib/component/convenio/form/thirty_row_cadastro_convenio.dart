import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/centro_custo/dropdown_centro_custo.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_radio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/empresa/dropdown_empresa.dart';
import 'package:brinquedoteca_flutter/component/generic/text_form_field/cnpj_field.dart';
import 'package:brinquedoteca_flutter/component/generic/text_form_field/codigo.dart';
import 'package:brinquedoteca_flutter/component/natureza/dropdown_natureza.dart';
import 'package:brinquedoteca_flutter/component/parceiro/dropdown_parceiro.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_empresa_controller.dart';
import 'package:brinquedoteca_flutter/controller/configuracao/cadastro_convenio_controller.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:brinquedoteca_flutter/utils/validator_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ThirtyRowCadastroConvenio extends StatelessWidget {
  final CadastroConvenioController controller;

  const ThirtyRowCadastroConvenio({
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
              child: DropdownCentroCusto(
                required: true,
                centroCusto: controller.centroCustoSelected,
                onChanged: (p0) => controller.setCentroCusto(centrocusto: p0),
              ),
            ),
            ResponsiveField(
              child: DropdownNatureza(
                required: false,
                natureza: controller.naturezaSelected,
                onChanged: (p0) => controller.setNatureza(natureza: p0),
              ),
            ),
            ResponsiveField(
              width: 240,
              child: CustomTextFormField(
                labelText: "Dia Mínimo Vencimento",
                controller: controller.tecMinDiaVencimento,
                keyboardType: TextInputType.number,
                validator: validateDia,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                prefixIcon: Icon(Icons.numbers),
              ),
            ),
            ResponsiveField(
              width: 190,
              child: CustomTextFormField(
                labelText: "Dia Vencimento",
                controller: controller.tecDiaVencimento,
                keyboardType: TextInputType.number,
                validator: validateDia,
                prefixIcon: Icon(Icons.calendar_month),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
          ]
        );
      }
    );
  }
}
