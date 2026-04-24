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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SecondRowCadastroConvenio extends StatelessWidget {
  final CadastroConvenioController controller;

  const SecondRowCadastroConvenio({
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
                child: DropdownParceiro(
                  onChanged: (p0) => controller.setParceiro(parceiro: p0),
                  required: true,
                  parceiro: controller.parceiroSelected,
                )
            ),
            ResponsiveField(
              child: DropdownEmpresa(
                required: true,
                empresaSelected: controller.empresaSelected,
                onChanged: (p0) => controller.setEmpresa(empresa: p0),

              )
            ),
            ResponsiveField(
              width: 160,
              child: CustomTextFormField(
                labelText: "Expira em",
                controller: controller.tecDataExpiracao,
                keyboardType: TextInputType.number,
                required: true,
                prefixIcon: Icon(Icons.calendar_month),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
              ),
            ),
            ResponsiveField(
              width: 250,
              child: CustomTextFormField(
                labelText: "Quant. crianças liberadas",
                controller: controller.tecMaxVisita,
                keyboardType: TextInputType.number,
                prefixIcon: Icon(Icons.numbers),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            // ResponsiveField(
            //   width: 190,
            //   child: CustomTextFormField(
            //     labelText: "Dia Vencimento",
            //     controller: controller.tecDiaVencimento,
            //     keyboardType: TextInputType.number,
            //     required: true,
            //     prefixIcon: Icon(Icons.calendar_month),
            //     inputFormatters: [
            //       FilteringTextInputFormatter.digitsOnly,
            //     ],
            //   ),
            // ),
            // ResponsiveField(
            //   width: 170,
            //   child: CustomTextFormField(
            //     labelText: "Min. Dia Venc.",
            //     controller: controller.tecMinDiaVencimento,
            //     keyboardType: TextInputType.number,
            //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            //     prefixIcon: Icon(Icons.numbers),
            //   ),
            // ),
          ]
        );
      }
    );
  }
}
