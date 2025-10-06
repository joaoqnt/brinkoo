import 'package:flutter/material.dart';

import '../custom_textformfield.dart';

class TextFieldLogin extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  String labelText;
  bool obscureText;
  Widget prefixIcon;
  Widget? suffixIcon;
  String? Function(String?)? validator;

  TextFieldLogin({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      hintText: labelText,
      labelText: labelText,
      controller: controller,
      obscureText: obscureText,
      prefixIcon: prefixIcon,
      required: true,
      filled: true,
      fillColor: Colors.grey.shade200,
      validator: validator,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
      suffixIcon: suffixIcon,
    );
  }
}
