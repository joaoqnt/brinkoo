import 'package:flutter/material.dart';

class CustomBorder{
  OutlineInputBorder buildBorder({Color? color,double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12), // Bordas mais arredondadas (estilo moderno)
      borderSide: BorderSide(
        color: color??Colors.grey.shade300,
        width: width,
      ),
    );
  }
}