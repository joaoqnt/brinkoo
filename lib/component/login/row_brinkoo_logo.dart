import 'package:flutter/material.dart';

import '../../utils/responsive.dart';

class RowBrinkooLogo extends StatelessWidget {
  double? height;
  RowBrinkooLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          child: Image.asset("assets/logo.jpeg", fit: BoxFit.cover),
        ),
        SizedBox(width: 10),
        Flexible(
          child: Text(
            'Brinkoo',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
