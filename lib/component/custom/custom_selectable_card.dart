import 'package:brinquedoteca_flutter/style.dart';
import 'package:flutter/material.dart';

class SelectableCard extends StatelessWidget {
  final bool selected;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? subtitle;
  final Widget? trailing;
  final String title;

  const SelectableCard({
    super.key,
    required this.selected,
    required this.title,
    this.onTap,
    this.leading,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {

    final bgColor = selected ? tlLight : rdLight;
    final borderColor = selected ? tlBorder : rdBorder;
    final iconColor = selected ? tl : rd;
    final textColor = selected ? tlDark : rdDark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Row(
          spacing: 10,
          children: [

            if (leading != null) leading!,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitle != null) subtitle!,
                ],
              ),
            ),

            if (trailing != null)
              DefaultTextStyle(
                style: TextStyle(
                  color: iconColor,
                  fontWeight: FontWeight.w800,
                ),
                child: trailing!,
              )
            else
              Text(selected ? "Sim" : "Não",
                  style: TextStyle(
                    color: iconColor,
                    fontWeight: FontWeight.w800,
                  )),
          ],
        ),
      ),
    );
  }
}