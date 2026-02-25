import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/crianca/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/responsavel/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThirtyRowCadastroResponsavel extends StatelessWidget {
  final CadastroResponsavelController controller;
  final CadastroCriancaController? criancaController;
  final Responsavel? responsavel;

  const ThirtyRowCadastroResponsavel({
    super.key,
    required this.controller,
    this.criancaController,
    this.responsavel,
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode _cepFocusNode = FocusNode();
    return Flex(
      direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
      spacing: 10,
      children: [
        ResponsiveField(
          width: 145,
          child: Focus(
            focusNode: _cepFocusNode,
            onKeyEvent: (node, event) {
              if (event is KeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.tab) {

                if (controller.tecCep.text.isNotEmpty &&
                    UtilBrasilFields.removeCaracteres(controller.tecCep.text).length == 8) {
                  controller.setEnderecoByCep();
                } else {
                  CustomSnackBar.error(context, 'Cep inválido');
                }
              }
              return KeyEventResult.ignored;
            },
            child: CustomTextFormField(
              prefixIcon: const Icon(Icons.reduce_capacity),
              labelText: "Cep",
              controller: controller.tecCep,
              required: true,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CepInputFormatter()
              ],
            ),
          ),
        ),
        IconButton.filled(
            onPressed: () async{
              if(controller.tecCep.text.isNotEmpty && UtilBrasilFields.removeCaracteres(controller.tecCep.text).length == 8) {
                controller.setEnderecoByCep();
              } else {
                CustomSnackBar.error(context, 'Cep inválido');
              }
            },
            icon: Icon(Icons.search)
        ),
        ResponsiveField(
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.add_location),
            labelText: "Endereço",
            controller: controller.tecEndereco,
            required: true,
          ),
        ),
        ResponsiveField(
          width: 130,
          child: CustomTextFormField(
              prefixIcon: const Icon(Icons.numbers),
              labelText: "Número",
              controller: controller.tecNumero
          ),
        ),
      ],
    );
  }
}
