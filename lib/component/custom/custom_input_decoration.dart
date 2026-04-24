import 'package:flutter/material.dart';
import 'custom_border.dart';

class CustomInputDecoration {
  static InputDecoration build({
    required BuildContext context,
    String? labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool isDense = true,
    bool required = false,
    EdgeInsetsGeometry? contentPadding,
  }) {
    final theme = Theme.of(context);

    return InputDecoration(
      // Lógica do Label com Asterisco
      label: labelText != null
          ? Text.rich(
        TextSpan(
          text: labelText,
          style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
          children: [
            if (required)
              const TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      )
          : null,

      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      isDense: isDense,
      filled: true,
      fillColor: Colors.grey.shade50,

      // Ajuste dinâmico de padding baseado no isDense
      contentPadding: contentPadding ??
          EdgeInsets.symmetric(horizontal: 16, vertical: isDense ? 12 : 16),

      // Bordas padronizadas usando sua CustomBorder
      border: CustomBorder().buildBorder(color: Colors.grey.shade400),
      enabledBorder: CustomBorder().buildBorder(color: Colors.grey.shade400),
      focusedBorder: CustomBorder().buildBorder(color: theme.primaryColor, width: 2),
      errorBorder: CustomBorder().buildBorder(color: Colors.red.shade400),
      focusedErrorBorder: CustomBorder().buildBorder(color: Colors.red.shade400, width: 2),

      // Estilos auxiliares
      hintStyle: TextStyle(color: Colors.grey.shade800, fontSize: 14),
      errorStyle: TextStyle(color: Colors.red.shade400, fontSize: 12),
      labelStyle: TextStyle(color: Colors.grey.shade800),
    );
  }
}