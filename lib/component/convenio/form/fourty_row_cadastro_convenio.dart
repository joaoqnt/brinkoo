import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/centro_custo/dropdown_centro_custo.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_radio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/empresa/dropdown_empresa.dart';
import 'package:brinquedoteca_flutter/component/generic/text_form_field/cnpj_field.dart';
import 'package:brinquedoteca_flutter/component/generic/text_form_field/codigo.dart';
import 'package:brinquedoteca_flutter/component/natureza/dropdown_natureza.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_empresa_controller.dart';
import 'package:brinquedoteca_flutter/controller/configuracao/cadastro_convenio_controller.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FourtyRowCadastroConvenio extends StatelessWidget {
  final CadastroConvenioController controller;

  const FourtyRowCadastroConvenio({
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
            child: CustomTextFormField(
              labelText: "Pago pelo Conveniado",
              controller: controller.tecPercConvenio,
              keyboardType: TextInputType.number,
              prefixIcon: Icon(Icons.percent),
              onChanged: (p0) => controller.setDataDayConvenio(),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CentavosInputFormatter(moeda: false),
              ],
            )
        ),
        ResponsiveField(
            child: CustomTextFormField(
              labelText: "Desconto da empresa",
              controller: controller.tecPercEmpresa,
              keyboardType: TextInputType.number,
              prefixIcon: Icon(Icons.percent),
              onChanged: (p0) => controller.setDataDayConvenio(),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CentavosInputFormatter(moeda: false),
              ],
            )
        ),
        ResponsiveField(
            child: CustomTextFormField(
              labelText: "Total Desconto",
              controller: controller.tecPercTotal,
              keyboardType: TextInputType.number,
              prefixIcon: Icon(Icons.percent),
              enabled: false,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CentavosInputFormatter(moeda: false),
              ],
            )
        ),
      ]
    );
  }
}
