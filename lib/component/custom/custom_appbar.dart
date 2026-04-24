import 'package:brinquedoteca_flutter/component/custom/custom_circle_avatar.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget? bottom;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.bottom,
    this.centerTitle = false,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(64.0); // Um pouco mais alta para respiro

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
      ),
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey.shade300, // Cinza bem clarinho
          height: 1.0,
          child: bottom,
        ),
      ),
      actions: actions != null
          ? [
        ...actions!,
        const SizedBox(width: 16),
        CustomCircleAvatar(
          icon: Icons.person,
          urlImage: Singleton.instance.usuario!.urlFoto,
        ),
        const SizedBox(width: 16),
      ] : [
        CustomCircleAvatar(
          icon: Icons.person,
          urlImage: Singleton.instance.usuario!.urlFoto,
        ),
        const SizedBox(width: 16)
      ],
    );
  }
}