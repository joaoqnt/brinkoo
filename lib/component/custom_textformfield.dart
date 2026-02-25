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

  const CustomTextFormField({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.keyboardType,
    this.obscureText = false,
    this.autofocus = false,
    this.maxLines = null,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      textAlignVertical: textAlignVertical,
      expands: expands,
      readOnly: readOnly,
      style: textStyle,
      buildCounter: buildCounter,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        isDense: isDense,
        contentPadding: contentPadding,
        fillColor: fillColor,
        filled: filled,
        //border: border ?? OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        border: border ?? OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
