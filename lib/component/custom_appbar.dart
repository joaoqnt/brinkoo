import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool useDrawer;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool showBackButton;
  final Widget? pageBackButton;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.useDrawer = true,
    this.actions,
    this.pageBackButton,
    this.centerTitle = false,
    this.showBackButton = false, // Valor padrão é false
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      automaticallyImplyLeading: useDrawer,
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      )
          : null,
      actions: actions,
    );
  }
}