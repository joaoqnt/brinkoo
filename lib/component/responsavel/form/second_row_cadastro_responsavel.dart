import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/crianca/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/responsavel/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecondRowCadastroResponsavel extends StatelessWidget {
  final CadastroResponsavelController controller;
  final CadastroCriancaController? criancaController;
  final Responsavel? responsavel;

  const SecondRowCadastroResponsavel({
    super.key,
    required this.controller,
    this.criancaController,
    this.responsavel,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
      spacing: 10,
      children: [
        if (criancaController != null)
          ResponsiveField(
            width: 240,
            child: DropdownSearch<String>(
              items:(filter, loadProps) => criancaController!.tiposRelacionamento,
              popupProps: PopupProps.menu(
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  autofocus: true, // já abre com o teclado ativo
                ),
              ),
              decoratorProps: DropDownDecoratorProps(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_outline),
                  labelText: "Relacionamento",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  isDense: true,
                ),
              ),
              selectedItem: criancaController!.relacionamentoSelected[responsavel],
              onChanged: (value) {
                criancaController!.setRelacionamento(responsavel!, value!);
              },
            ),
          ),
        ResponsiveField(
          width: 180,
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.document_scanner),
            labelText: "Documento",
            controller: controller.tecDocumento,
            required: true,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter()
            ],
          ),
        ),
        ResponsiveField(
          width: 185,
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.phone_android),
            labelText: "Telefone",
            controller: controller.tecTelefone,
            required: true,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TelefoneInputFormatter()
            ],
          ),
        ),
        ResponsiveField(
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.email),
            labelText: "Email",
            controller: controller.tecEmail,
            required: true,
          ),
        ),
      ],
    );
  }
}
