import 'package:brinquedoteca_flutter/component/forma_pagamento/card_forma_pagamento.dart';
import 'package:brinquedoteca_flutter/component/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/controller/forma_pagamento/forma_pagamento_list_controller.dart';
import 'package:brinquedoteca_flutter/view/cadastros/forma_pagamento/cadastro_forma_pagamento_view.dart';
import 'package:flutter/material.dart';

class FormaPagamentoListView extends StatefulWidget {
  FormaPagamentoListView({super.key});

  @override
  State<FormaPagamentoListView> createState() => _FormaPagamentoListViewState();
}

class _FormaPagamentoListViewState extends State<FormaPagamentoListView> {
  final _controller = FormaPagamentoListController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _controller.getFormasPagamento(),
        builder: (context,snapshot) {
          return snapshot.hasData ? Column(
            spacing: 10,
            children: [
              RowSearchTextfield(
                  tecController: _controller.tecPesquisa,
                  widget: CadastroFormaPagamentoView(),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: _controller.formasPagamento.length,
                      itemBuilder: (context, index) {
                        return CardFormaPagamento(formaPagamento: _controller.formasPagamento[index]);
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
