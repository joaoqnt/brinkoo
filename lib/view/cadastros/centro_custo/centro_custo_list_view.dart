import 'package:brinquedoteca_flutter/component/centro_custo/card_centro_custo.dart';
import 'package:brinquedoteca_flutter/component/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/controller/centro_custo/centro_custo_list_controller.dart';
import 'package:brinquedoteca_flutter/view/cadastros/centro_custo/cadastro_centro_custo_view.dart';
import 'package:flutter/material.dart';

class CentroCustoListView extends StatefulWidget {
  CentroCustoListView({super.key});

  @override
  State<CentroCustoListView> createState() => _CentroCustoListViewState();
}

class _CentroCustoListViewState extends State<CentroCustoListView> {
  final _controller = CentroCustoListController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _controller.getCentros(),
        builder: (context,snapshot) {
          return snapshot.hasData ? Column(
            spacing: 10,
            children: [
              RowSearchTextfield(
                  tecController: _controller.tecPesquisa,
                  widget: CadastroCentroCustoView(),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: _controller.centros.length,
                      itemBuilder: (context, index) {
                        return CardCentroCusto(centroCusto: _controller.centros[index]);
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
