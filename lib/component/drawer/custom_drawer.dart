import 'package:brinquedoteca_flutter/component/custom_circle_avatar.dart';
import 'package:brinquedoteca_flutter/events/image_preview_dialog.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
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
                CustomCircleAvatar(
                  urlImage: Singleton.instance.usuario?.urlFoto,
                  radius: 30,
                  onTap: () {
                    ImagePreviewDialog.show(context, imageUrl: Singleton.instance.usuario?.urlFoto);
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  '${Singleton.instance.usuario?.nome}',
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
            routeName: '/parametro_geral',
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
