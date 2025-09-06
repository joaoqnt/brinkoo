import 'package:brinquedoteca_flutter/view/cadastros//centro_custo/centro_custo_list_view.dart';
import 'package:brinquedoteca_flutter/view/cadastros/empresa/empresa_list_view.dart';
import 'package:brinquedoteca_flutter/view/cadastros/forma_pagamento/forma_pagamento_list_view.dart';
import 'package:brinquedoteca_flutter/view/cadastros/guardas_volume/guarda_volume_list_view.dart';
import 'package:brinquedoteca_flutter/view/cadastros/natureza/natureza_list_view.dart';
import 'package:brinquedoteca_flutter/view/cadastros/parceiro/parceiro_list_view.dart';
import 'package:flutter/material.dart';

import '../../component/custom_appbar.dart';
import '../../component/drawer/custom_drawer.dart';
import 'atividades/atividades_list_view.dart';

class CadastroView extends StatefulWidget {
  final int initialIndex;
  const CadastroView({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tabs = const [
    Tab(text: 'Atividades'),
    Tab(text: 'Centros de Custo'),
    Tab(text: 'Empresas'),
    Tab(text: 'Formas de Pagamento'),
    Tab(text: 'Guardas Volume'),
    Tab(text: 'Naturezas'),
    Tab(text: 'Parceiros'),
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
                  AtividadesListView(),
                  CentroCustoListView(),
                  EmpresaListView(),
                  FormaPagamentoListView(),
                  GuardaVolumeListView(),
                  NaturezaListView(),
                  ParceiroListView(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
