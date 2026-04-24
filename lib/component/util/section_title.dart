import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final String? subtext;
  final Widget? widget;

  const SectionTitle({
    super.key,
    required this.text,
    this.subtext,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: subtext != null ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        // Indicador lateral colorido
        Container(
          margin: EdgeInsets.only(top: subtext != null ? 4 : 0), // Ajuste de altura se houver subtexto
          width: 4,
          height: subtext != null ? 32 : 16, // Aumenta o traço se houver subtexto
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 12),

        // Textos agrupados
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 15, // Aumentei um ponto para dar hierarquia
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey.shade900,
                  letterSpacing: 0.3,
                ),
              ),
              if (subtext != null) ...[
                const SizedBox(height: 2), // Espaço sutil entre os textos
                Text(
                  subtext!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey, // Tom mais claro para ser "clean"
                  ),
                ),
              ],
            ],
          ),
        ),
        if(widget != null)
          widget!
      ],
    );
  }
}