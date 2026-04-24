import 'package:flutter/material.dart';

class CustomCardSection extends StatelessWidget {
  final Widget child;
  const CustomCardSection({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: child
      ),
    );
  }
}
