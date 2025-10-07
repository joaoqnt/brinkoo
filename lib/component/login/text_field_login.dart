import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../custom_textformfield.dart';

class TextFieldLogin extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  String labelText;
  bool obscureText;
  Widget prefixIcon;
  Widget? suffixIcon;
  List<TextInputFormatter>? inputFormatters;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  void Function(String)? onChanged;

  TextFieldLogin({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      hintText: hintText,
      labelText: labelText,
      controller: controller,
      obscureText: obscureText,
      prefixIcon: prefixIcon,
      required: true,
      filled: true,
      fillColor: Colors.grey.shade100,
      validator: validator,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: InputBorder.none,
      suffixIcon: suffixIcon,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }
}
