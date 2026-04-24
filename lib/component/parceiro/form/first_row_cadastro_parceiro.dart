import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_radio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/generic/text_form_field/cnpj_field.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_parceiro_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FirstRowCadastroParceiro extends StatelessWidget {
  final CadastroParceiroController controller;

  const FirstRowCadastroParceiro({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode _cnpjFocusNode = FocusNode();
    return Observer(
      builder: (context) {
        return Flex(
          direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
          spacing: 10,
          children: [
            ResponsiveField(
              child: CustomTextFormField(
                prefixIcon: const Icon(Icons.person),
                labelText: "Nome",
                controller: controller.tecDescricao,
                required: true,
              ),
            ),
            SizedBox(
              width: 220,
              child: CustomRadio<bool>(
                title: "Tipo de Pessoa",
                options: [true,false],
                value: controller.pessoaFisica,
                label: (g) => g ? "Física" : "Jurídica",
                onChanged: (value) => controller.setPessoaFisica(value!),
              ),
            ),
            CpfCnpjField(
              controller: controller.tecCpfCnpj,
              pessoaFisica: controller.pessoaFisica,
              focusNode: _cnpjFocusNode,
              onSearchCnpj: () => controller.setDataByCnpj(),
            )
          ],
        );
      }
    );
  }
}
