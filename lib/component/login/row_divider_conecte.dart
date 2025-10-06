import 'package:flutter/material.dart';

class RowDividerConecte extends StatelessWidget {
  const RowDividerConecte({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300)),
        SizedBox(width: 20),
        Text("Ou conecte com",style: TextStyle(color: Colors.grey)),
        SizedBox(width: 20),
        Expanded(child: Divider(color: Colors.grey.shade300)),
      ],
    );
  }
}
