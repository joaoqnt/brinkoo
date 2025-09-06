import 'package:brinquedoteca_flutter/component/parceiro/card_parceiro.dart';
import 'package:brinquedoteca_flutter/component/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/controller/parceiro/parceiro_list_controller.dart';
import 'package:brinquedoteca_flutter/view/cadastros/parceiro/cadastro_parceiro_view.dart';
import 'package:flutter/material.dart';


class ParceiroListView extends StatefulWidget {
  ParceiroListView({super.key});

  @override
  State<ParceiroListView> createState() => _ParceiroListViewState();
}

class _ParceiroListViewState extends State<ParceiroListView> {
  final _controller = ParceiroListController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _controller.getParceiros(),
        builder: (context,snapshot) {
          return snapshot.hasData ? Column(
            spacing: 10,
            children: [
              RowSearchTextfield(
                  tecController: _controller.tecPesquisa,
                  widget: CadastroParceiroView(),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: _controller.parceiros.length,
                      itemBuilder: (context, index) {
                        return CardParceiro(parceiro: _controller.parceiros[index]);
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
