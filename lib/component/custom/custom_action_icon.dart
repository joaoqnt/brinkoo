import 'package:flutter/material.dart';

class CustomActionIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final Color color;

  const CustomActionIcon({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.color = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(),
        elevation: 2,
        child: IconButton(
          icon: Icon(icon, size: 18, color: color),
          onPressed: onPressed,
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.all(8),
          splashRadius: 20,
        ),
      ),
    );
  }
}
