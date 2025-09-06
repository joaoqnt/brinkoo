import 'package:brinquedoteca_flutter/component/atividade/card_atividade.dart';
import 'package:brinquedoteca_flutter/component/crianca/card_crianca.dart';
import 'package:brinquedoteca_flutter/component/custom_appbar.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/component/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/controller/atividades/atividade_list_controller.dart';
import 'package:brinquedoteca_flutter/view/crianca/cadastro_crianca_view.dart';
import 'package:flutter/material.dart';

import 'cadastro_atividade_view.dart';

class AtividadesListView extends StatefulWidget {
  AtividadesListView({super.key});

  @override
  State<AtividadesListView> createState() => _AtividadesListViewState();
}

class _AtividadesListViewState extends State<AtividadesListView> {
  final _controller = AtividadeListController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _controller.getAtividades(),
        builder: (context,snapshot) {
          return snapshot.hasData ? Column(
            spacing: 10,
            children: [
              RowSearchTextfield(
                  tecController: _controller.tecPesquisa,
                  widget: CadastroAtividadeView(),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: _controller.atividades.length,
                      itemBuilder: (context, index) {
                        return CardAtividade(atividade: _controller.atividades[index]);
                      },
                  )
              )
            ],
          ) : Center(child: CircularProgressIndicator(),);
        }
      ),
    );
  }
}
