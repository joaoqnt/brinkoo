import 'package:brinquedoteca_flutter/component/custom/custom_card_section.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final TabController controller;
  final List<Widget> tabs;
  final ValueChanged<int>? onTap;

  final Color? primaryColor;
  final bool isScrollable;

  final Widget? rightAction;

  const CustomTabBar({
    super.key,
    required this.controller,
    required this.tabs,
    this.onTap,
    this.primaryColor,
    this.isScrollable = true,
    this.rightAction,
  });

  @override
  Widget build(BuildContext context) {
    final color = primaryColor ?? Theme.of(context).primaryColor;

    return CustomCardSection(
      child: Row(
        children: [
          /// 👇 Tabs ocupam o máximo possível
          Expanded(
            child: TabBar(
              controller: controller,

              dividerColor: Colors.transparent,

              labelColor: color,
              unselectedLabelColor: Colors.grey.shade600,

              indicatorColor: color,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,

              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),

              isScrollable: isScrollable,
              tabAlignment: TabAlignment.start,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              labelPadding: const EdgeInsets.symmetric(horizontal: 16),

              tabs: tabs,
              onTap: onTap,
            ),
          ),

          /// 👇 Espaço entre tabs e ação
          if (rightAction != null) ...[
            const SizedBox(width: 8),
            rightAction!,
          ]
        ],
      ),
    );
  }
}