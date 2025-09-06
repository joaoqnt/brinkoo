import 'package:flutter/material.dart';
import '../../utils/singleton.dart';

class CustomDrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String routeName;

  const CustomDrawerItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSelected = Singleton.instance.pageSelected == label;

    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.blue : null),
      title: Text(
        label,
        style: TextStyle(
          //sfontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.blue : null,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Colors.blue.shade50,
      onTap: () {
        Singleton.instance.pageSelected = label;
        Navigator.of(context).pop(); // Fecha o Drawer
        Navigator.of(context).pushNamed(routeName);
      },
    );
  }
}
