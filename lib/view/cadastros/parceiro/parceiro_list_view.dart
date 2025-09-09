import 'package:brinquedoteca_flutter/component/parceiro/card_parceiro.dart';
import 'package:brinquedoteca_flutter/component/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/controller/parceiro/parceiro_list_controller.dart';
import 'package:brinquedoteca_flutter/view/cadastros/parceiro/cadastro_parceiro_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';


class ParceiroListView extends StatefulWidget {
  ParceiroListView({super.key});

  @override
  State<ParceiroListView> createState() => _ParceiroListViewState();
}

class _ParceiroListViewState extends State<ParceiroListView> {
  final _controller = ParceiroListController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.getParceiros(reset: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _controller.getParceiros();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 10,
        children: [
          RowSearchTextfield(
              tecController: _controller.tecPesquisa,
              widget: CadastroParceiroView(),
          ),
          Expanded(
              child: Observer(
                builder: (context) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: _controller.parceiros.length + (_controller.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < _controller.parceiros.length) {
                        return CardParceiro(parceiro: _controller.parceiros[index]);
                      } else {
                        // Último item -> Loader
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                  );

                }
              )
          )
        ],
      )
    );
  }
}
