import 'package:brinquedoteca_flutter/component/custom/custom_appbar.dart';
import 'package:brinquedoteca_flutter/controller/navigation_controller.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class NavegationPage extends StatefulWidget {
  const NavegationPage({super.key});

  @override
  State<NavegationPage> createState() => _NavegationPageState();
}

class _NavegationPageState extends State<NavegationPage> {
  final controller = Singleton().navigationController;


  @override
  void initState() {
    super.initState();
    controller.ensurePageLoaded(controller.selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      body: Row(
        children: [

          /// MENU LATERAL
          Container(
            width: 260,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// LOGO
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    "Brinquedoteca",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primary,
                    ),
                  ),
                ),

                /// MENU
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.menuItems.length,
                      itemBuilder: (context, index) {
                        final item = controller.menuItems[index];

                        if (item.isHeader) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(24, 20, 16, 8),
                            child: Text(
                              item.label,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: Colors.grey[800],
                                letterSpacing: 1.2,
                              ),
                            ),
                          );
                        }

                        return Observer(
                          builder: (_) {
                            bool isSelected = controller.selectedIndex == index;

                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              child: ListTile(
                                onTap: () => controller.setIndex(index),
                                selected: isSelected,
                                selectedTileColor: primary.withOpacity(0.15),
                                leading: Icon(
                                  item.icon,
                                  color: isSelected ? primary : Colors.grey[600],
                                ),
                                title: Text(
                                  item.label,
                                  style: TextStyle(
                                    color: isSelected ? primary : Colors.grey[600],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                  ),
                ),
              ],
            ),
          ),

          /// DIVISOR
          Container(width: 1, color: Colors.grey[300]),

          /// ÁREA DE CONTEÚDO
          Expanded(
            child: Observer(
              builder: (_) {
                return IndexedStack(
                  index: controller.selectedIndex,
                  children: List.generate(
                    controller.menuItems.length,
                        (i) => controller.loadedPages[i] ?? const SizedBox(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}