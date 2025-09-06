import 'package:flutter/material.dart';
import 'custom_drawer_item.dart'; // importe corretamente

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(Icons.person, size: 30, color: Colors.white),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Nome do usuário',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          CustomDrawerItem(
            icon: Icons.home,
            label: 'Painel',
            routeName: '/home',
          ),
          CustomDrawerItem(
            icon: Icons.check_circle,
            label: 'Check-in',
            routeName: '/checkin',
          ),
          CustomDrawerItem(
            icon: Icons.child_care,
            label: 'Criança',
            routeName: '/crianca',
          ),
          CustomDrawerItem(
            icon: Icons.app_registration,
            label: 'Cadastros',
            routeName: '/cadastros',
          ),
          CustomDrawerItem(
            icon: Icons.attach_money,
            label: 'Financeiros',
            routeName: '/financeiros',
          ),
          CustomDrawerItem(
            icon: Icons.settings,
            label: 'Parâmetro',
            routeName: '/parametro',
          ),
          CustomDrawerItem(
            icon: Icons.shopping_bag,
            label: 'Produto',
            routeName: '/produto',
          ),
          CustomDrawerItem(
            icon: Icons.people,
            label: 'Responsável',
            routeName: '/responsavel',
          ),
          CustomDrawerItem(
            icon: Icons.miscellaneous_services,
            label: 'Serviço',
            routeName: '/servico',
          ),
        ],
      ),
    );
  }
}
