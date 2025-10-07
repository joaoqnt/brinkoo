import 'package:flutter/material.dart';

class RowDividerConecte extends StatelessWidget {
  String title;
  RowDividerConecte({super.key, this.title = "Ou conecte com"});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300)),
        SizedBox(width: 10),
        Text(title,style: TextStyle(color: Colors.grey,fontSize: 12)),
        SizedBox(width: 10),
        Expanded(child: Divider(color: Colors.grey.shade300)),
      ],
    );
  }
}
