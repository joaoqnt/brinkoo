import 'package:brinquedoteca_flutter/component/financeiro/card_financeiro.dart';
import 'package:brinquedoteca_flutter/component/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/controller/financeiro/financeiro_list_controller.dart';
import 'package:flutter/material.dart';

class FinanceiroListView extends StatefulWidget {
  String receitaDespesa;
  FinanceiroListView({
    super.key,
    required this.receitaDespesa,
  });

  @override
  State<FinanceiroListView> createState() => _FinanceiroListViewState();
}

class _FinanceiroListViewState extends State<FinanceiroListView> {
  final _controller = FinanceiroListController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _controller.getFinanceiros(widget.receitaDespesa),
          builder: (context,snapshot) {
            return snapshot.hasData ? Column(
              spacing: 10,
              children: [
                RowSearchTextfield(
                  tecController: _controller.tecPesquisa,
                  //widget: CadastroCentroCustoView(),
                ),
                Expanded(
                    child: ListView.builder(
                      itemCount: _controller.financeiros.length,
                      itemBuilder: (context, index) {
                        return CardFinanceiro(financeiro: _controller.financeiros[index]);
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
