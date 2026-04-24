import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/cupertino.dart';

class ResponsiveField extends StatelessWidget {
  final Widget child;
  final double? width;
  const ResponsiveField({super.key, required this.child, this.width});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
          ? SizedBox(width: double.infinity, child: child)
          : width != null
        ? SizedBox(width: width,child: child,)
        : Expanded(child: child);
  }
}
