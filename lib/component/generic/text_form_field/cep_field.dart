import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CepField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Future<void> Function()? onSearchCep;
  final double width;

  const CepField({
    super.key,
    required this.controller,
    this.focusNode,
    this.onSearchCep,
    this.width = 150,
  });

  bool _isValidCep() {
    return controller.text.isNotEmpty &&
        UtilBrasilFields.removeCaracteres(controller.text).length == 8;
  }

  void _handleSearch(BuildContext context) {
    if (_isValidCep()) {
      onSearchCep?.call();
    } else {
      CustomSnackBar.error(context, 'CEP inválido');
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
                _handleSearch(context);
              }
              return KeyEventResult.ignored;
            },
            child: CustomTextFormField(
              labelText: "CEP",
              controller: controller,
              required: true,
              prefixIcon: const Icon(Icons.place),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CepInputFormatter(),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: () => _handleSearch(context),
          child: const Icon(Icons.search),
        ),
      ],
    );
  }
}