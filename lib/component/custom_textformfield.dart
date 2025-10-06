import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final Color? fillColor;
  final bool filled;
  final bool isDense;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextStyle? textStyle;
  final String? errorText;
  final bool? showCursor;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool expands;
  final bool readOnly;
  final String? helperText;
  final TextStyle? helperStyle;
  final Widget? Function(
      BuildContext, {
      required int currentLength,
      required bool isFocused,
      required int? maxLength,
      })? buildCounter;

  /// NOVO ATRIBUTO
  final bool required;
  final List<TextInputFormatter>? inputFormatters;
  final bool enableInteractiveSelection;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final String? restorationId;
  final bool enableSuggestions;
  final String? counterText;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final BoxHeightStyle selectionHeightStyle;
  final BoxWidthStyle selectionWidthStyle;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextCapitalization textCapitalization;

  const CustomTextFormField({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.keyboardType,
    this.obscureText = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.textInputAction,
    this.focusNode,
    this.enabled = true,
    this.contentPadding,
    this.border,
    this.focusedBorder,
    this.errorBorder,
    this.disabledBorder,
    this.fillColor,
    this.filled = false,
    this.isDense = true,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.textStyle,
    this.errorText,
    this.showCursor,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.expands = false,
    this.readOnly = false,
    this.helperText,
    this.helperStyle,
    this.buildCounter,
    this.required = false,
    this.inputFormatters,

    // NOVOS PARÂMETROS
    this.enableInteractiveSelection = true,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.restorationId,
    this.enableSuggestions = true,
    this.counterText,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.strutStyle,
    this.textDirection,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Cores específicas para brinquedoteca
    final theme = Theme.of(context);
    final defaultFillColor = Colors.grey.shade100;
    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.transparent),
    );

    final defaultFocusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: theme.primaryColor, width: 2),
    );

    final defaultErrorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
    );

    final defaultHintStyle = TextStyle(
      color: Colors.grey.shade600,
      fontSize: 16,
    );

    final defaultTextStyle = TextStyle(
      color: Colors.grey.shade800,
      fontSize: 16,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          RichText(
            text: TextSpan(
              text: labelText,
              style: labelStyle ?? TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
              children: [
                if (required)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],

        TextFormField(
          controller: controller,
          initialValue: initialValue,
          keyboardType: keyboardType,
          obscureText: obscureText,
          autofocus: autofocus,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          validator: (value) {
            if (required && (value == null || value.trim().isEmpty)) {
              return 'Este campo é obrigatório';
            }
            if (validator != null) {
              return validator!(value);
            }
            return null;
          },
          onChanged: onChanged,
          onSaved: onSaved,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          textInputAction: textInputAction,
          focusNode: focusNode,
          enabled: enabled,
          showCursor: showCursor,
          textAlign: textAlign,
          textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
          expands: expands,
          readOnly: readOnly,
          style: textStyle ?? defaultTextStyle,
          buildCounter: buildCounter,
          inputFormatters: inputFormatters,

          // NOVAS PROPRIEDADES
          enableInteractiveSelection: enableInteractiveSelection,
          autocorrect: autocorrect,
          smartDashesType: smartDashesType,
          smartQuotesType: smartQuotesType,
          restorationId: restorationId,
          enableSuggestions: enableSuggestions,
          cursorHeight: cursorHeight,
          cursorRadius: cursorRadius,
          cursorColor: cursorColor ?? theme.primaryColor,
          selectionHeightStyle: selectionHeightStyle,
          selectionWidthStyle: selectionWidthStyle,
          strutStyle: strutStyle,
          textDirection: textDirection,
          textCapitalization: textCapitalization,

          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle ?? defaultHintStyle,
            prefixIcon: prefixIcon != null ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: prefixIcon,
            ) : null,
            suffixIcon: suffixIcon != null ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: suffixIcon,
            ) : null,
            isDense: isDense,
            contentPadding: contentPadding ?? const EdgeInsets.all(16),
            fillColor: fillColor ?? (filled ? defaultFillColor : null),
            filled: filled,
            border: border,
            focusedBorder: focusedBorder ?? defaultFocusedBorder,
            errorBorder: errorBorder ?? defaultErrorBorder,
            disabledBorder: disabledBorder ?? defaultBorder,
            errorText: errorText,
            errorStyle: errorStyle ?? TextStyle(
              color: theme.colorScheme.error,
              fontSize: 12,
            ),
            helperText: helperText,
            helperStyle: helperStyle ?? TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
            counterText: counterText,
            prefixIconConstraints: BoxConstraints(minHeight: 24, minWidth: 24),
            suffixIconConstraints: BoxConstraints(minHeight: 24, minWidth: 24),
          ),
        ),
      ],
    );
  }
}
