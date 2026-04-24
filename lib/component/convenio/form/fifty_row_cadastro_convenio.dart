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

class FiftyRowCadastroConvenio extends StatelessWidget {
  final CadastroConvenioController controller;

  const FiftyRowCadastroConvenio({
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
            labelText: "Observação",
            controller: controller.tecObservacao,
            prefixIcon: Icon(Icons.description),
          ),
        ),
      ]
    );
  }
}
