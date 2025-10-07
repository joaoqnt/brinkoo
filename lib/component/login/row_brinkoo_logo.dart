import 'package:flutter/material.dart';

import '../../utils/responsive.dart';

class RowBrinkooLogo extends StatelessWidget {
  double? height;
  double? fontSize;
  RowBrinkooLogo({
    super.key,
    this.height = 100,
    this.fontSize = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: height,
          child: Image.asset("assets/logo.png", fit: BoxFit.cover),
        ),
        Flexible(
          child: Text(
            'Brinkoo',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800
            ),
          ),
        )
      ],
    );
  }
}
