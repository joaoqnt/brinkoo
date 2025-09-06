import 'package:brinquedoteca_flutter/view/parametro/parametros_gerais_view.dart';
import 'package:brinquedoteca_flutter/view/parametro/usuario/cadastro_usuario_view.dart';
import 'package:brinquedoteca_flutter/view/parametro/usuario/usuario_list_view.dart';
import 'package:flutter/material.dart';

import '../../component/custom_appbar.dart';
import '../../component/drawer/custom_drawer.dart';

class ParametroView extends StatefulWidget {
  final int initialIndex;
  const ParametroView({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<ParametroView> createState() => _ParametroViewState();
}

class _ParametroViewState extends State<ParametroView> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tabs = const [
    Tab(text: 'Parâmetros Gerais'),
    Tab(text: 'Usuários e Permissões'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this,initialIndex: widget.initialIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cadastros",
        useDrawer: true,
      ),
      drawer: CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            controller: _tabController,
            tabs: _tabs,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Theme.of(context).primaryColor,
            indicatorWeight: 2,
            labelStyle: const TextStyle(fontSize: 14),
            unselectedLabelStyle: const TextStyle(fontSize: 13),
            isScrollable: true, // opcional, se tiver muitas abas
            padding: const EdgeInsets.symmetric(horizontal: 8),
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TabBarView(
                controller: _tabController,
                children: [
                  ParametrosGeraisView(),
                  UsuarioListView()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
