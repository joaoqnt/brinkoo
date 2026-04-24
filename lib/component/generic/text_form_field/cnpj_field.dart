import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CpfCnpjField extends StatelessWidget {
  final TextEditingController controller;
  final bool pessoaFisica;
  final FocusNode? focusNode;
  final Future<void> Function()? onSearchCnpj;
  final double width;

  const CpfCnpjField({
    super.key,
    required this.controller,
    required this.pessoaFisica,
    this.focusNode,
    this.onSearchCnpj,
    this.width = 220,
  });

  bool _isValid() {
    if (pessoaFisica) {
      return UtilBrasilFields.isCPFValido(controller.text);
    } else {
      return UtilBrasilFields.isCNPJValido(controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ResponsiveField(
          width: width,
          child: Focus(
            focusNode: focusNode,
            onKeyEvent: (node, event) {
              if (event is KeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.tab) {
                if (!_isValid()) {
                  CustomSnackBar.error(
                      context, pessoaFisica ? 'CPF inválido' : 'CNPJ inválido');
                } else {
                  if (!pessoaFisica && onSearchCnpj != null) {
                    onSearchCnpj!();
                  }
                }
              }

              return KeyEventResult.ignored;
            },
            child: CustomTextFormField(
              labelText: pessoaFisica ? "CPF" : "CNPJ",
              prefixIcon: const Icon(Icons.document_scanner),
              controller: controller,
              required: true,
              validator: (p0) {
                if (!_isValid()) {
                  return pessoaFisica ? "CPF inválido" : "CNPJ inválido";
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                pessoaFisica
                    ? CpfInputFormatter()
                    : CnpjInputFormatter(),
              ],
            ),
          ),
        ),

        if (!pessoaFisica) ...[
          const SizedBox(width: 8),
          FilledButton(
            onPressed: () {
              if (!_isValid()) {
                CustomSnackBar.error(context, 'CNPJ inválido');
              } else {
                onSearchCnpj?.call();
              }
            },
            child: const Icon(Icons.search),
          )
        ]
      ],
    );
  }
}