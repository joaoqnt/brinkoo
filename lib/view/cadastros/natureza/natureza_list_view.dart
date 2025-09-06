import 'package:brinquedoteca_flutter/component/natureza/card_natureza.dart';
import 'package:brinquedoteca_flutter/component/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/controller/natureza/natureza_list_controller.dart';
import 'package:flutter/material.dart';

import 'cadastro_natureza_view.dart';

class NaturezaListView extends StatefulWidget {
  NaturezaListView({super.key});

  @override
  State<NaturezaListView> createState() => _NaturezaListViewState();
}

class _NaturezaListViewState extends State<NaturezaListView> {
  final _controller = NaturezaListController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _controller.getNaturezas(),
        builder: (context,snapshot) {
          return snapshot.hasData ? Column(
            spacing: 10,
            children: [
              RowSearchTextfield(
                  tecController: _controller.tecPesquisa,
                  widget: CadastroNaturezaView(),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: _controller.naturezas.length,
                      itemBuilder: (context, index) {
                        return CardNatureza(natureza: _controller.naturezas[index]);
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
